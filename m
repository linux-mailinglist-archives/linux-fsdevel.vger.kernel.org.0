Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8513A24DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jun 2021 08:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhFJG7U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Jun 2021 02:59:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35033 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229705AbhFJG7U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Jun 2021 02:59:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623308244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2xI9DhwUbPIwsok2RGKHqBDnQZkdygy7sVBmHeixOo0=;
        b=XS1NRVgI78bKMY/9v0VhbLBo7dESzPx++vlg71gFCbTk0MBKbxuJNjELARKlxqCBOHo9MT
        5LDgYs004y/1OojEeIiDrea03uG0YjVO2RKm4wZaujs1E9qDo0CcNA3+qFjTb/9KcFCVUI
        V2fFDzD//WLjjyGsLOlCjHlg6Wh5X8E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-K_zC0YpLOs6gHmmqGjcAbg-1; Thu, 10 Jun 2021 02:57:20 -0400
X-MC-Unique: K_zC0YpLOs6gHmmqGjcAbg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE5DD100C662;
        Thu, 10 Jun 2021 06:57:18 +0000 (UTC)
Received: from T590 (ovpn-13-145.pek2.redhat.com [10.72.13.145])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BE5760937;
        Thu, 10 Jun 2021 06:57:07 +0000 (UTC)
Date:   Thu, 10 Jun 2021 14:57:03 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, cgroups@vger.kernel.org,
        Jan Kara <jack@suse.com>
Subject: Re: [PATCH v9 3/8] writeback, cgroup: increment isw_nr_in_flight
 before grabbing an inode
Message-ID: <YMG3v13caUW5BX8n@T590>
References: <20210608230225.2078447-1-guro@fb.com>
 <20210608230225.2078447-4-guro@fb.com>
 <YMA2XEnJrHyVLWrD@T590>
 <YMFa+guFw7OFjf3X@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMFa+guFw7OFjf3X@carbon.dhcp.thefacebook.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 09, 2021 at 05:21:14PM -0700, Roman Gushchin wrote:
> On Wed, Jun 09, 2021 at 11:32:44AM +0800, Ming Lei wrote:
> > On Tue, Jun 08, 2021 at 04:02:20PM -0700, Roman Gushchin wrote:
> > > isw_nr_in_flight is used do determine whether the inode switch queue
> > > should be flushed from the umount path. Currently it's increased
> > > after grabbing an inode and even scheduling the switch work. It means
> > > the umount path can be walked past cleanup_offline_cgwb() with active
> > > inode references, which can result in a "Busy inodes after unmount."
> > > message and use-after-free issues (with inode->i_sb which gets freed).
> > > 
> > > Fix it by incrementing isw_nr_in_flight before doing anything with
> > > the inode and decrementing in the case when switching wasn't scheduled.
> > > 
> > > The problem hasn't yet been seen in the real life and was discovered
> > > by Jan Kara by looking into the code.
> > > 
> > > Suggested-by: Jan Kara <jack@suse.com>
> > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > Reviewed-by: Jan Kara <jack@suse.cz>
> > > ---
> > >  fs/fs-writeback.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > > index b6fc13a4962d..4413e005c28c 100644
> > > --- a/fs/fs-writeback.c
> > > +++ b/fs/fs-writeback.c
> > > @@ -505,6 +505,8 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
> > >  	if (!isw)
> > >  		return;
> > >  
> > > +	atomic_inc(&isw_nr_in_flight);
> > 
> > smp_mb() may be required for ordering the WRITE in 'atomic_inc(&isw_nr_in_flight)'
> > and the following READ on 'inode->i_sb->s_flags & SB_ACTIVE'. Otherwise,
> > cgroup_writeback_umount() may observe zero of 'isw_nr_in_flight' because of
> > re-order of the two OPs, then miss the flush_workqueue().
> > 
> > Also this barrier should serve as pair of the one added in cgroup_writeback_umount(),
> > so maybe this patch should be merged with 2/8.
> 
> Hi Ming!
> 
> Good point, I agree. How about a patch below?
> 
> Thanks!
> 
> --
> 
> From 282861286074c47907759d80c01419f0d0630dae Mon Sep 17 00:00:00 2001
> From: Roman Gushchin <guro@fb.com>
> Date: Wed, 9 Jun 2021 14:14:26 -0700
> Subject: [PATCH] cgroup, writeback: add smp_mb() to inode_prepare_wbs_switch()
> 
> Add a memory barrier between incrementing isw_nr_in_flight
> and checking the sb's SB_ACTIVE flag and grabbing an inode in
> inode_prepare_wbs_switch(). It's required to prevent grabbing
> an inode before incrementing isw_nr_in_flight, otherwise
> 0 can be obtained as isw_nr_in_flight in cgroup_writeback_umount()
> and isw_wq will not be flushed, potentially leading to a memory
> corruption.
> 
> Added smp_mb() will work in pair with smp_mb() in
> cgroup_writeback_umount().
> 
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  fs/fs-writeback.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 545fce68e919..6332b86ca4ed 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -513,6 +513,14 @@ static void inode_switch_wbs_work_fn(struct work_struct *work)
>  static bool inode_prepare_wbs_switch(struct inode *inode,
>  				     struct bdi_writeback *new_wb)
>  {
> +	/*
> +	 * Paired with smp_mb() in cgroup_writeback_umount().
> +	 * isw_nr_in_flight must be increased before checking SB_ACTIVE and
> +	 * grabbing an inode, otherwise isw_nr_in_flight can be observed as 0
> +	 * in cgroup_writeback_umount() and the isw_wq will be not flushed.
> +	 */
> +	smp_mb();
> +
>  	/* while holding I_WB_SWITCH, no one else can update the association */
>  	spin_lock(&inode->i_lock);
>  	if (!(inode->i_sb->s_flags & SB_ACTIVE) ||

Looks fine, you may have to merge this one with 2/8 & 3/8, so the memory
barrier use can be correct & intact for avoiding the race between switching
cgwb and generic_shutdown_super().


Thanks,
Ming

