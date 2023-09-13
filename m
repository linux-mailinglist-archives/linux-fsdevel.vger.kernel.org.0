Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60D2879E70F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 13:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240484AbjIMLoM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 07:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbjIMLoM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:44:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E774710E6;
        Wed, 13 Sep 2023 04:44:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 681091F390;
        Wed, 13 Sep 2023 11:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694605446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vz3yiosx/rzMDjScdtkZUeynlz8sR2dqQb6E8Dch4WU=;
        b=zm2SOQUrTuBFh9LcDDHHMoNwE7Ia840mThylMohDv9Gci9kxr+h/5W03KtujSJ07x9xnSb
        0OsFPVIOPPEJmCH4bpGJ55wEm/DQeiAiE2AA9fYgHKJ4N1FC4ih0bOkt5CGOGv6VkqD9j5
        u4Iq1d2qYszn9ih/QUFYsdEamU2t+6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694605446;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vz3yiosx/rzMDjScdtkZUeynlz8sR2dqQb6E8Dch4WU=;
        b=HlxSW2PX6ZPcMDSNEmHtBJyM3r1rcWTRaTvbBDcGpg+v5rad5VkGV+eAbSsqYD/Vm3Wztv
        /ZRAuNcr+4kk/7Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4321213582;
        Wed, 13 Sep 2023 11:44:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kvR3EIagAWVnDgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 13 Sep 2023 11:44:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B9B1BA07C2; Wed, 13 Sep 2023 13:44:05 +0200 (CEST)
Date:   Wed, 13 Sep 2023 13:44:05 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Chunhai Guo <guochunhai@vivo.com>, viro@zeniv.linux.org.uk,
        chao@kernel.org, jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs-writeback: writeback_sb_inodes: Do not increase
 'total_wrote' when nothing is written
Message-ID: <20230913114405.b4gajruhpkemj2bk@quack3>
References: <20230912142043.283495-1-guochunhai@vivo.com>
 <20230913-spionieren-goldschatz-3d15c1ce2743@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913-spionieren-goldschatz-3d15c1ce2743@brauner>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 13-09-23 10:42:21, Christian Brauner wrote:
> [+Cc Jan]

Thanks!

> On Tue, Sep 12, 2023 at 08:20:43AM -0600, Chunhai Guo wrote:
> > I am encountering a deadlock issue as shown below. There is a commit
> > 344150999b7f ("f2fs: fix to avoid potential deadlock") can fix this issue.
> > However, from log analysis, it appears that this is more likely a fake
> > progress issue similar to commit 68f4c6eba70d ("fs-writeback:
> > writeback_sb_inodes: Recalculate 'wrote' according skipped pages"). In each
> > writeback iteration, nothing is written, while writeback_sb_inodes()
> > increases 'total_wrote' each time, causing an infinite loop. This patch
> > fixes this issue by not increasing 'total_wrote' when nothing is written.
> > 
> >     wb_writeback        fsync (inode-Y)
> > blk_start_plug(&plug)
> > for (;;) {
> >   iter i-1: some reqs with page-X added into plug->mq_list // f2fs node page-X with PG_writeback
> >                         filemap_fdatawrite
> >                           __filemap_fdatawrite_range // write inode-Y with sync_mode WB_SYNC_ALL
> >                            do_writepages
> >                             f2fs_write_data_pages
> >                              __f2fs_write_data_pages // wb_sync_req[DATA]++ for WB_SYNC_ALL
> >                               f2fs_write_cache_pages
> >                                f2fs_write_single_data_page
> >                                 f2fs_do_write_data_page
> >                                  f2fs_outplace_write_data
> >                                   f2fs_update_data_blkaddr
> >                                    f2fs_wait_on_page_writeback
> >                                      wait_on_page_writeback // wait for f2fs node page-X
> >   iter i:
> >     progress = __writeback_inodes_wb(wb, work)
> >     . writeback_sb_inodes
> >     .   __writeback_single_inode // write inode-Y with sync_mode WB_SYNC_NONE
> >     .   . do_writepages
> >     .   .   f2fs_write_data_pages
> >     .   .   .  __f2fs_write_data_pages // skip writepages due to (wb_sync_req[DATA]>0)
> >     .   .   .   wbc->pages_skipped += get_dirty_pages(inode) // wbc->pages_skipped = 1
> >     .   if (!(inode->i_state & I_DIRTY_ALL)) // i_state = I_SYNC | I_SYNC_QUEUED
> >     .    total_wrote++;  // total_wrote = 1
> >     .   requeue_inode // requeue inode-Y to wb->b_dirty queue due to non-zero pages_skipped
> >     if (progress) // progress = 1
> >       continue;
> >   iter i+1:
> >       queue_io
> >       // similar process with iter i, infinite for-loop !
> > }
> > blk_finish_plug(&plug)   // flush plug won't be called
> > 
> > Signed-off-by: Chunhai Guo <guochunhai@vivo.com>

Thanks for the patch but did you test this patch fixed your deadlock?
Because the patch seems like a noop to me. Look:

> > diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> > index 969ce991b0b0..54cdee906be9 100644
> > --- a/fs/fs-writeback.c
> > +++ b/fs/fs-writeback.c
> > @@ -1820,6 +1820,7 @@ static long writeback_sb_inodes(struct super_block *sb,
> >  		struct inode *inode = wb_inode(wb->b_io.prev);
> >  		struct bdi_writeback *tmp_wb;
> >  		long wrote;
> > +		bool is_dirty_before;
> >  
> >  		if (inode->i_sb != sb) {
> >  			if (work->sb) {
> > @@ -1881,6 +1882,7 @@ static long writeback_sb_inodes(struct super_block *sb,
> >  			continue;
> >  		}
> >  		inode->i_state |= I_SYNC;
> > +		is_dirty_before = inode->i_state & I_DIRTY_ALL;

is_dirty_before is going to be set if there's anything dirty - inode, page,
timestamp. So it can be unset only if there are no dirty pages, in which
case there are no pages that can be skipped during page writeback, which means
that requeue_inode() will go and remove inode from b_io/b_dirty lists and
it will not participate in writeback anymore.

So I don't see how this patch can be helping anything... Please correct me
if I'm missing anything.

								Honza


> >  		wbc_attach_and_unlock_inode(&wbc, inode);
> >  
> >  		write_chunk = writeback_chunk_size(wb, work);
> > @@ -1918,7 +1920,7 @@ static long writeback_sb_inodes(struct super_block *sb,
> >  		 */
> >  		tmp_wb = inode_to_wb_and_lock_list(inode);
> >  		spin_lock(&inode->i_lock);
> > -		if (!(inode->i_state & I_DIRTY_ALL))
> > +		if (!(inode->i_state & I_DIRTY_ALL) && is_dirty_before)
> >  			total_wrote++;
> >  		requeue_inode(inode, tmp_wb, &wbc);
> >  		inode_sync_complete(inode);
> > -- 
> > 2.25.1
> > 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
