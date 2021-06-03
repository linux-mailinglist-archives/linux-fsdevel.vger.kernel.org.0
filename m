Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDFF6399E82
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 12:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhFCKMn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 06:12:43 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:42618 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCKMn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 06:12:43 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 045A21FD56;
        Thu,  3 Jun 2021 10:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622715058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dl1cSFiS5eKqztKERplBtFE3q8X+b7XPT0PQ/DFNCvM=;
        b=tPuCzD1fQp7yP6anCTvYzIYNpUk9tc3LVokNr+FsYzOzm74PZesjrtCYB8WUDID5WbX6lb
        Eh1+21542gh0yxrTadXYt2VbTT5S0myebYY0wbrvIkodTZMSVCFALWL/WxzoUsO2luaJ1a
        3l4cCvlm8BgUKgQd4xaj4JkkJG2sVJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622715058;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dl1cSFiS5eKqztKERplBtFE3q8X+b7XPT0PQ/DFNCvM=;
        b=rGD56/LecjA4ecN9EDCJM0AZenCGGzEQBAm2KixEVmJVBebVq3OzFJkGR0UI7gz9tau0ce
        aetK6i7QWZCzUJCw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id E934CA3B85;
        Thu,  3 Jun 2021 10:10:57 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C765C1F2C98; Thu,  3 Jun 2021 12:10:57 +0200 (CEST)
Date:   Thu, 3 Jun 2021 12:10:57 +0200
From:   Jan Kara <jack@suse.cz>
To:     Roman Gushchin <guro@fb.com>
Cc:     Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH v6 4/5] writeback, cgroup: support switching multiple
 inodes at once
Message-ID: <20210603101057.GH23647@quack2.suse.cz>
References: <20210603005517.1403689-1-guro@fb.com>
 <20210603005517.1403689-5-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603005517.1403689-5-guro@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 02-06-21 17:55:16, Roman Gushchin wrote:
> Currently only a single inode can be switched to another writeback
> structure at once. That means to switch an inode a separate
> inode_switch_wbs_context structure must be allocated, and a separate
> rcu callback and work must be scheduled.
> 
> It's fine for the existing ad-hoc switching, which is not happening
> that often, but sub-optimal for massive switching required in order to
> release a writeback structure. To prepare for it, let's add a support
> for switching multiple inodes at once.
> 
> Instead of containing a single inode pointer, inode_switch_wbs_context
> will contain a NULL-terminated array of inode
> pointers. inode_do_switch_wbs() will be called for each inode.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Two small comments below:

> @@ -473,10 +473,14 @@ static void inode_switch_wbs_work_fn(struct work_struct *work)
>  {
>  	struct inode_switch_wbs_context *isw =
>  		container_of(to_rcu_work(work), struct inode_switch_wbs_context, work);
> +	struct inode **inodep;
> +
> +	for (inodep = &isw->inodes[0]; *inodep; inodep++) {
                      ^^^^ why not just isw->inodes?

> +		inode_do_switch_wbs(*inodep, isw->new_wb);
> +		iput(*inodep);
> +	}

I was kind of hoping that we would save the repeated locking of
bdi->wb_switch_rwsem, old_wb->list_lock, and new_wb->list_lock for multiple
inodes. Maybe we can have 'old_wb' as part of isw as well and assert that
all inodes are still attached to the old_wb at this point to make this a
bit simpler. Or we can fetch old_wb from the first inode and then just
lock & assert using that one.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
