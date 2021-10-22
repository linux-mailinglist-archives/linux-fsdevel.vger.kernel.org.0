Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC3A437390
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 10:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbhJVIVB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 04:21:01 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48952 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbhJVIVA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 04:21:00 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5BE1D1FD58;
        Fri, 22 Oct 2021 08:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634890722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=udzLvenaNJ3s/w3myOyFSHoI8PZDzLqGtGnzU72grpQ=;
        b=tZfVS+GsxB4ztBI/PkTVtzq3zqzVa5Ey0BVI3ujAZ+X0/kU0WMm2JFoQ/dI1UFErKreYzj
        WLhUzybUFXpwzm8xQ1URT+ic7zij5GZvX9+r0TkHTyRNRBc3/vjyF5pfQEJrTUNxJpiAKB
        SmEwUou+18lgMrN++sJUBE+oi8MDJVg=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2A969A3B84;
        Fri, 22 Oct 2021 08:18:42 +0000 (UTC)
Date:   Fri, 22 Oct 2021 10:18:41 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     NeilBrown <neilb@suse.de>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dave Chinner <david@fromorbit.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [RFC 2/3] mm/vmalloc: add support for __GFP_NOFAIL
Message-ID: <YXJz4QVsNk4kUZvH@dhcp22.suse.cz>
References: <CA+KHdyUopXQVTp2=X-7DYYFNiuTrh25opiUOd1CXED1UXY2Fhg@mail.gmail.com>
 <YXAiZdvk8CGvZCIM@dhcp22.suse.cz>
 <CA+KHdyUyObf2m51uFpVd_tVCmQyn_mjMO0hYP+L0AmRs0PWKow@mail.gmail.com>
 <YXAtYGLv/k+j6etV@dhcp22.suse.cz>
 <CA+KHdyVdrfLPNJESEYzxfF+bksFpKGCd8vH=NqdwfPOLV9ZO8Q@mail.gmail.com>
 <20211020192430.GA1861@pc638.lan>
 <163481121586.17149.4002493290882319236@noble.neil.brown.name>
 <YXFAkFx8PCCJC0Iy@dhcp22.suse.cz>
 <20211021104038.GA1932@pc638.lan>
 <163485654850.17149.3604437537345538737@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163485654850.17149.3604437537345538737@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 22-10-21 09:49:08, Neil Brown wrote:
[...]
> However now that I've thought about some more, I'd much prefer we
> introduce something like
>     memalloc_retry_wait();
> 
> and use that everywhere that a memory allocation is retried.
> I'm not convinced that we need to wait at all - at least, not when
> __GFP_DIRECT_RECLAIM is used, as in that case alloc_page will either
>   - succeed
>   - make some progress a reclaiming or
>   - sleep

There
are two that we have to do explicitly vmap_pages_range one is due to
implicit GFP_KERNEL allocations for page tables. Those would likely be a
good fit for something you suggest above. Then we have __get_vm_area_node
retry loop which can be either due to vmalloc space reservation failure
or an implicit GFP_KERNEL allocation by kasan. The first one is not
really related to the memory availability so it doesn't sound like a
good fit.

-- 
Michal Hocko
SUSE Labs
