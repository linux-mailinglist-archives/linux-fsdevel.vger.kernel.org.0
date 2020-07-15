Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F67220270
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 04:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbgGOChR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 22:37:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726609AbgGOChR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 22:37:17 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DA7720663;
        Wed, 15 Jul 2020 02:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594780636;
        bh=gNCU6NtVT1fH7sZMvndJL+pfZVolBkI/L9zrcc75WLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZW7bvzZismjfYNcynEiJI4uFYpzcES7AiqZrIEknc1E5AE5GIGxUqEpg5yb+eb60K
         4z6ODym+QN9zL9m2e9h+i2hXxFIpKSNtzshWLEr+yJV5/dbQxq4mi/t1s+48jbgTwE
         QkLMnFZNQrNY9V2HZEKQ6QO1YqGQAplVdI+EF7Pw=
Date:   Tue, 14 Jul 2020 19:37:14 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] fs/direct-io: avoid data race on ->s_dio_done_wq
Message-ID: <20200715023714.GA38091@sol.localdomain>
References: <20200713033330.205104-1-ebiggers@kernel.org>
 <20200715013008.GD2005@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715013008.GD2005@dread.disaster.area>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 15, 2020 at 11:30:08AM +1000, Dave Chinner wrote:
> On Sun, Jul 12, 2020 at 08:33:30PM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Fix the preliminary checks for ->s_dio_done_wq to use READ_ONCE(), since
> > it's a data race, and technically the behavior is undefined without
> > READ_ONCE().  Also, on one CPU architecture (Alpha), the data read
> > dependency barrier included in READ_ONCE() is needed to guarantee that
> > the pointed-to struct is seen as fully initialized.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > ---
> >  fs/direct-io.c       | 8 +++-----
> >  fs/internal.h        | 9 ++++++++-
> >  fs/iomap/direct-io.c | 3 +--
> >  3 files changed, 12 insertions(+), 8 deletions(-)
> > 
> > diff --git a/fs/direct-io.c b/fs/direct-io.c
> > index 6d5370eac2a8..26221ae24156 100644
> > --- a/fs/direct-io.c
> > +++ b/fs/direct-io.c
> > @@ -590,7 +590,7 @@ static inline int dio_bio_reap(struct dio *dio, struct dio_submit *sdio)
> >   * filesystems that don't need it and also allows us to create the workqueue
> >   * late enough so the we can include s_id in the name of the workqueue.
> >   */
> > -int sb_init_dio_done_wq(struct super_block *sb)
> > +int __sb_init_dio_done_wq(struct super_block *sb)
> >  {
> >  	struct workqueue_struct *old;
> >  	struct workqueue_struct *wq = alloc_workqueue("dio/%s",
> > @@ -615,9 +615,7 @@ static int dio_set_defer_completion(struct dio *dio)
> >  	if (dio->defer_completion)
> >  		return 0;
> >  	dio->defer_completion = true;
> > -	if (!sb->s_dio_done_wq)
> > -		return sb_init_dio_done_wq(sb);
> > -	return 0;
> > +	return sb_init_dio_done_wq(sb);
> >  }
> >  
> >  /*
> > @@ -1250,7 +1248,7 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
> >  		retval = 0;
> >  		if (iocb->ki_flags & IOCB_DSYNC)
> >  			retval = dio_set_defer_completion(dio);
> > -		else if (!dio->inode->i_sb->s_dio_done_wq) {
> > +		else {
> >  			/*
> >  			 * In case of AIO write racing with buffered read we
> >  			 * need to defer completion. We can't decide this now,
> > diff --git a/fs/internal.h b/fs/internal.h
> > index 9b863a7bd708..6736c9eee978 100644
> > --- a/fs/internal.h
> > +++ b/fs/internal.h
> > @@ -178,7 +178,14 @@ extern void mnt_pin_kill(struct mount *m);
> >  extern const struct dentry_operations ns_dentry_operations;
> >  
> >  /* direct-io.c: */
> > -int sb_init_dio_done_wq(struct super_block *sb);
> > +int __sb_init_dio_done_wq(struct super_block *sb);
> > +static inline int sb_init_dio_done_wq(struct super_block *sb)
> > +{
> > +	/* pairs with cmpxchg() in __sb_init_dio_done_wq() */
> > +	if (likely(READ_ONCE(sb->s_dio_done_wq)))
> > +		return 0;
> > +	return __sb_init_dio_done_wq(sb);
> > +}
> 
> Ummm, why don't you just add this check in sb_init_dio_done_wq(). I
> don't see any need for adding another level of function call
> abstraction in the source code?

This keeps the fast path doing no function calls and one fewer branch, as it was
before.  People care a lot about minimizing direct I/O overhead, so it seems
desirable to keep this simple optimization.  Would you rather it be removed?

> 
> Also, you need to explain the reason for the READ_ONCE() existing
> rather than just saying "it pairs with <some other operation>".
> Knowing what operation it pairs with doesn't explain why the pairing
> is necessary in the first place, and that leads to nobody reading
> the code being able to understand what this is protecting against.
> 

How about this?

	/*
	 * Nothing to do if ->s_dio_done_wq is already set.  But since another
	 * process may set it concurrently, we need to use READ_ONCE() rather
	 * than a plain read to avoid a data race (undefined behavior) and to
	 * ensure we observe the pointed-to struct to be fully initialized.
	 */
	if (likely(READ_ONCE(sb->s_dio_done_wq)))
		return 0;
