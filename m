Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6378B434D0D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 16:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhJTOIr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 10:08:47 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48846 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbhJTOIq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 10:08:46 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C58131FD39;
        Wed, 20 Oct 2021 14:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634738790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8LBh2cfuvkiBjRN5KYfkv+nWpJ1+urNfv8ByT8ZENOk=;
        b=etRnN9aZU6UoO1QQkQcCtZVMEXIxpjIWVQA8cmBYgMbRQJyZdi4aHS8P2LG/DsbRbpdl50
        fF9jrEFYAiFzj2Z6bHrjRObK3nl7B4SxT2M/G/iYCgFIkEAfVMnbitLuT5oa3FijPawRy5
        NY1bYjW/xrTYQQ4m2obifWqR8g7irzE=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 71486A3BA1;
        Wed, 20 Oct 2021 14:06:30 +0000 (UTC)
Date:   Wed, 20 Oct 2021 16:06:29 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Dave Chinner <david@fromorbit.com>, Neil Brown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [RFC 2/3] mm/vmalloc: add support for __GFP_NOFAIL
Message-ID: <YXAiZdvk8CGvZCIM@dhcp22.suse.cz>
References: <20211018114712.9802-1-mhocko@kernel.org>
 <20211018114712.9802-3-mhocko@kernel.org>
 <20211019110649.GA1933@pc638.lan>
 <YW6xZ7vi/7NVzRH5@dhcp22.suse.cz>
 <20211019194658.GA1787@pc638.lan>
 <YW/SYl/ZKp7W60mg@dhcp22.suse.cz>
 <CA+KHdyUopXQVTp2=X-7DYYFNiuTrh25opiUOd1CXED1UXY2Fhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+KHdyUopXQVTp2=X-7DYYFNiuTrh25opiUOd1CXED1UXY2Fhg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 20-10-21 15:54:23, Uladzislau Rezki wrote:
> > > >
> > > I think adding kind of schedule() will not make things worse and in corner
> > > cases could prevent a power drain by CPU. It is important for mobile devices.
> >
> > I suspect you mean schedule_timeout here? Or cond_resched? I went with a
> > later for now, I do not have a good idea for how to long to sleep here.
> > I am more than happy to change to to a sleep though.
> >
> cond_resched() reschedules only if TIF_NEED_RESCHED is raised what is not good
> here. Because in our case we know that we definitely would like to
> take a breath. Therefore
> invoking the schedule() is more suitable here. It will give a CPU time
> to another waiting
> process(if exists) in any case putting the "current" one to the tail.

Yes, but there is no explicit event to wait for currently.

> As for adding a delay. I am not sure about for how long to delay or i
> would say i do not
> see a good explanation why for example we delay for 10 milliseconds or so.

As I've said I am OK with either of the two. Do you or anybody have any
preference? Without any explicit event to wake up for neither of the two
is more than just an optimistic retry.
-- 
Michal Hocko
SUSE Labs
