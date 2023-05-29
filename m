Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EB9714D33
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 May 2023 17:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjE2PiC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 May 2023 11:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjE2PiB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 May 2023 11:38:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F59DF3;
        Mon, 29 May 2023 08:37:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A8E621F8B5;
        Mon, 29 May 2023 15:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685374674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VfC2IdpO+7uEiBHhtf+jBby1eH6FWQ5ChsH/O7pLur0=;
        b=gSf0t+vZ0B4myh9SviD61zCj1EH1uc1YlVGhNUgb/MCZXxzHgA8J3XifwVyza2KRq20hWr
        pZGc6AXCETQnP8jb+U91N20w7vIA7f5VobiHfL+/HbuvYR4sGOy/Qvb7o1ZnPBWqac7LBg
        kZfgvCRZqV9R20JgWvdDd1kIZir+lK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685374674;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VfC2IdpO+7uEiBHhtf+jBby1eH6FWQ5ChsH/O7pLur0=;
        b=2+2tMQkyipmhcoqtqPAlHCSakWLZKRrkGMRW/G1J4HZuo+ZsFqLS2sYv/igpPh23T0GX71
        4QMmBZeR6OW2F3DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 87AAC13A36;
        Mon, 29 May 2023 15:37:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BKs+INLGdGQrSAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 29 May 2023 15:37:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0BA32A06F2; Mon, 29 May 2023 14:41:31 +0200 (CEST)
Date:   Mon, 29 May 2023 14:41:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Al Viro <viro@ZenIV.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>, Ted Tso <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4/6] fs: Establish locking order for unrelated directories
Message-ID: <20230529124131.gbb3fmhrspl332i6@quack3>
References: <20230525100654.15069-1-jack@suse.cz>
 <20230525101624.15814-4-jack@suse.cz>
 <20230526-polarstern-herrichten-32fc46c63bfc@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526-polarstern-herrichten-32fc46c63bfc@brauner>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 26-05-23 11:45:15, Christian Brauner wrote:
> On Thu, May 25, 2023 at 12:16:10PM +0200, Jan Kara wrote:
> > Currently the locking order of inode locks for directories that are not
> > in ancestor relationship is not defined because all operations that
> > needed to lock two directories like this were serialized by
> > sb->s_vfs_rename_mutex. However some filesystems need to lock two
> > subdirectories for RENAME_EXCHANGE operations and for this we need the
> > locking order established even for two tree-unrelated directories.
> > Provide a helper function lock_two_inodes() that establishes lock
> > ordering for any two inodes and use it in lock_two_directories().
> > 
> > CC: stable@vger.kernel.org
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/inode.c    | 34 ++++++++++++++++++++++++++++++++++
> >  fs/internal.h |  2 ++
> >  fs/namei.c    |  4 ++--
> >  3 files changed, 38 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/inode.c b/fs/inode.c
> > index 577799b7855f..2015fa50d34a 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -1103,6 +1103,40 @@ void discard_new_inode(struct inode *inode)
> >  }
> >  EXPORT_SYMBOL(discard_new_inode);
> >  
> > +/**
> > + * lock_two_inodes - lock two inodes (may be regular files but also dirs)
> > + *
> > + * Lock any non-NULL argument. The caller must make sure that if he is passing
> > + * in two directories, one is not ancestor of the other.  Zero, one or two
> > + * objects may be locked by this function.
> > + *
> > + * @inode1: first inode to lock
> > + * @inode2: second inode to lock
> > + * @subclass1: inode lock subclass for the first lock obtained
> > + * @subclass2: inode lock subclass for the second lock obtained
> > + */
> > +void lock_two_inodes(struct inode *inode1, struct inode *inode2,
> > +		     unsigned subclass1, unsigned subclass2)
> > +{
> > +	if (!inode1 || !inode2)
> > +		goto lock;
> 
> Before this change in
> 
> lock_two_nondirectories(struct inode *inode1, struct inode *inode2)
> 
> the swap() would cause the non-NULL inode to always be locked with
> I_MUTEX_NONDIR2. Now it can be either I_MUTEX_NORMAL or I_MUTEX_NONDIR2.
> Is that change intentional?

Kind of. I don't think we really care so I didn't bother to complicate the
code for this. If you think keeping the lockdep class consistent is worth
it, I can modify the patch...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
