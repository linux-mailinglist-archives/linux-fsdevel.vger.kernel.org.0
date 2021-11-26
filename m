Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33E545EBEB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 11:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbhKZKyB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 05:54:01 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:33320 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376824AbhKZKwB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:52:01 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 672512191E;
        Fri, 26 Nov 2021 10:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637923727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z4wlzPXcHY1E4jnsxIlOVyE4bXQ2QOsHbiS5pKe8Jrg=;
        b=cYhFEEY32kdRfruql7qB2OOrS2FuoDklEOM0w0eV1ukDmK1Jf3qiEUQjrZsuLFljg8RgR2
        mslbGlMji8p7NPqa/LEHaecjc2iTYmLUxOqZQMSGcyuStdBF23ZOZaCDUZ1R7SUd4Fk7eI
        Lye9iW1ZJ/X+9f0lBzP3/1ExedN5fWI=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5000FA3B81;
        Fri, 26 Nov 2021 10:48:47 +0000 (UTC)
Date:   Fri, 26 Nov 2021 11:48:46 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH v2 2/4] mm/vmalloc: add support for __GFP_NOFAIL
Message-ID: <YaC7jij1hHtdOJdE@dhcp22.suse.cz>
References: <20211122153233.9924-1-mhocko@kernel.org>
 <20211122153233.9924-3-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122153233.9924-3-mhocko@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 22-11-21 16:32:31, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> Dave Chinner has mentioned that some of the xfs code would benefit from
> kvmalloc support for __GFP_NOFAIL because they have allocations that
> cannot fail and they do not fit into a single page.
> 
> The large part of the vmalloc implementation already complies with the
> given gfp flags so there is no work for those to be done. The area
> and page table allocations are an exception to that. Implement a retry
> loop for those.
> 
> Add a short sleep before retrying. 1 jiffy is a completely random
> timeout. Ideally the retry would wait for an explicit event - e.g.
> a change to the vmalloc space change if the failure was caused by
> the space fragmentation or depletion. But there are multiple different
> reasons to retry and this could become much more complex. Keep the retry
> simple for now and just sleep to prevent from hogging CPUs.
> 
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Are there still any concerns around this patch or the approach in
general?
-- 
Michal Hocko
SUSE Labs
