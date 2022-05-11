Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5A6523BEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 19:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345842AbiEKRwm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 13:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345835AbiEKRwl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 13:52:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB1369287;
        Wed, 11 May 2022 10:52:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 29D0621C97;
        Wed, 11 May 2022 17:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652291558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z/S5urEWAvhNHXNJCrstZZi7osmXbDU9L4n3sTIyti4=;
        b=XjCvkfLd4p1kVd/U4cRQl0TwWmL4bKu7g96lmXQVNVz/mH16GCkzhksE+Sv5wLxTVFObOE
        KaaLGVZzw3B9PtPYKNMjK8IlsyB8ND0JJLs+dKXSS7XvYEi1B5ELL9vmiXwqYu7yleNFWY
        oS6u/o/qfgBq4VM2lvdsS5d2VPi1vAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652291558;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z/S5urEWAvhNHXNJCrstZZi7osmXbDU9L4n3sTIyti4=;
        b=dXaapt5Kg47CgP+5ky0IjVnjDn9pcVKgEVs+abHyP07+z/k8ghTX71BXvHYWvS5fIa8xxw
        U2vQtw1DnOmfh2Bw==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E37C92C141;
        Wed, 11 May 2022 17:52:37 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B37B1A062A; Wed, 11 May 2022 19:52:31 +0200 (CEST)
Date:   Wed, 11 May 2022 19:52:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Fanotify API - Tracking File Movement
Message-ID: <20220511175231.d7re3p4tyn55claf@quack3.lan>
References: <YnOmG2DvSpvvOEOQ@google.com>
 <20220505112217.zvzbzhjgmoz7lr6w@quack3.lan>
 <CAOQ4uxhJFEoV0X8uunNaYjdKpsFj6nUtcNFBx8d3oqodDO_iYA@mail.gmail.com>
 <20220505133057.zm5t6vumc4xdcnsg@quack3.lan>
 <YnRhVgu6JKNinarh@google.com>
 <CAOQ4uxi9Jps3BGiSYWWvQdNeb+QPA9kSo_BDRCC2jfPSGWdx_w@mail.gmail.com>
 <20220506100636.k2lm22ztxpyaw373@quack3.lan>
 <CAOQ4uxjEcbjRoObAUfSS3RHVJY7EiW8tJSo1geNtbgQbcTOM+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjEcbjRoObAUfSS3RHVJY7EiW8tJSo1geNtbgQbcTOM+A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 07-05-22 19:03:13, Amir Goldstein wrote:
> > So I've slept on it and agree that allowing FAN_RENAME on a file with the
> > semantics Matthew wants is consistent with the current design and probably
> > the only sensible meaning we can give to it. I also agree that updating
> > permission checks for reporting parent dirs isn't that big of a headache
> > and maintenance burden going further.
> >
> > I'm still somewhat concerned about how the propagation of two parent
> > directories and then formatting into the event is going to work out (i.e.,
> > how many special cases that's going to need) but I'm willing to have a look
> > at the patch. Maybe it won't be as bad as I was afraid :).
> 
> Here is a patch. I don't think it is so bad.(?)
> In fact, I think the code is made a bit more clear when we stop overloading
> ITER_TYPE_INODE as the new_dir in FS_RENAME case.
> But yes, it does add yet another special (moved non-dir vs. moved dir).

Yeah, it looks fine.

> > > > Ah, I really wanted to stay away from watching the super block for all
> > > > FAN_RENAME events. I feel like userspace wearing the pain for such
> > > > cases is suboptimal, as this is something that can effectively be done
> > > > in-kernel.
> >
> > I agree that kernel can do this more efficiently than userspace but the
> > question is how much in terms of code (and thus maintenance overhead) are
> > we willing to spend for this IMO rather specialized feature. The code to
> > build necessary information to pass with the event, dealing with all
> > different types of watches and backends and then formatting it to the event
> > for userspace is complex as hell. Whenever I have to do or review some
> > non-trivial changes to it, my head hurts ;) And the amount of subtle
> > cornercase bugs we were fixing in that code over the years is just a
> > testimony of this. So that's why I'm reluctant to add even small
> > complications to it for something I find relatively specialized use (think
> > for how many userspace programs this feature is going to be useful, I don't
> > think many).
> >
> 
> My 0.02$ - while FAN_RENAME is a snowflake, this is not because
> of our design, this is because rename(2) is a snowflake vfs operation.
> The event information simply reflects the operation complexity and when
> looking at non-Linux filesystem event APIs, the event information for rename
> looks very similar to FAN_RENAME. In some cases (lustre IIRC) the protocol
> was enhanced at some point exactly as we did with FAN_RENAME to
> have all the info in one event vs. having to join two events.

I agree that rename is a special operation and that reflects to some extent
in fsnotify as well.


> But... (there is always a but when it comes to UAPI),
> When looking at my patch, one cannot help wondering -
> what about FAN_CREATE/FAN_DELETE/FAN_MOVE?
> If those can report child fid, why should they be treated differently
> than FAN_RENAME w.r.t marking the child inode?
> 
> For example, when watching a non-dir for FAN_CREATE, it could
> be VERY helpful to get the dirfid+name of where the inode was
> hard linked. In fact, if an application is watching FAN_RENAME to track
> the movement of a non-dir file and does not watch hardlink+unlink, then
> the file could escape under the application's nose.

I agree that being able to track FAN_CREATE (or FAN_DELETE for that matter
if you'd like to maintain in which dirs a file is visible) for a file like
this would be useful in a similar way as what we now enable for rename.

> We should definitely not extend the UAPI to a non-dir file before we provide
> an answer to this question. For that reason I also sent v2 of Fix patch to
> deny setting all dirent events on non-dir with FAN_REPORT_TARGET_FID.

Agreed.

> From d25f3ce8da49ce1a3b0a0621f0bf7b1d6ba2dad6 Mon Sep 17 00:00:00 2001
> From: Amir Goldstein <amir73il@gmail.com>
> Date: Sat, 7 May 2022 10:04:08 +0300
> Subject: [PATCH] fsnotify: send FS_RENAME to groups watching the moved inode
> 
> Send FS_RENAME to groups watching the moved inode itself if the
> moved inode is a non-dir to allow tracking the movement of a watched
> inode.
> 
> Sending FS_RENAME to a moved watched directory would be confusing
> and FAN_MOVE_SELF provided enough information to track the movements
> of a watched directory.
> 
> At the moment, no backend allows watching FS_RENAME on a non-dir inode.
> When backends (i.e. fanotify) will allow watching FS_RENAME on a non-dir
> inode, old/new dir+name should be reported only if the group proves to
> have read permission on old/new dir.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/notify/fanotify/fanotify.c    |  4 +-
>  fs/notify/fsnotify.c             | 72 ++++++++++++++++++++------------
>  include/linux/fsnotify.h         | 19 +++++----
>  include/linux/fsnotify_backend.h |  6 ++-
>  4 files changed, 63 insertions(+), 38 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 985e995d2a39..fc498fc090da 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -780,9 +780,9 @@ static struct fanotify_event *fanotify_alloc_event(
>  			report_old = report_new =
>  				match_mask & (1U << FSNOTIFY_ITER_TYPE_SB);
>  			report_old |=
> -				match_mask & (1U << FSNOTIFY_ITER_TYPE_INODE);
> +				match_mask & (1U << FSNOTIFY_ITER_TYPE_OLD_DIR);
>  			report_new |=
> -				match_mask & (1U << FSNOTIFY_ITER_TYPE_INODE2);
> +				match_mask & (1U << FSNOTIFY_ITER_TYPE_NEW_DIR);
>  
>  			if (!report_old) {
>  				/* Do not report old parent+name */
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 6eee19d15e8c..ce1ae725ec8c 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -277,19 +277,19 @@ static int fsnotify_handle_event(struct fsnotify_group *group, __u32 mask,
>  	    WARN_ON_ONCE(fsnotify_iter_vfsmount_mark(iter_info)))
>  		return 0;
>  
> -	/*
> -	 * For FS_RENAME, 'dir' is old dir and 'data' is new dentry.
> -	 * The only ->handle_inode_event() backend that supports FS_RENAME is
> -	 * dnotify, where it means file was renamed within same parent.
> -	 */
>  	if (mask & FS_RENAME) {
> -		struct dentry *moved = fsnotify_data_dentry(data, data_type);
> +		inode_mark = fsnotify_iter_old_dir_mark(iter_info);
> +		parent_mark = fsnotify_iter_new_dir_mark(iter_info);

AFAIU you use parent_mark here as a temporary variable. Maybe it would be
less confusing to just declare new 'new_dir_mark' variable to use for
comparison here? Also we would not have to change the "if (parent_mark)"
condition below.
  
> -		if (dir != moved->d_parent->d_inode)
> +		/*
> +		 * The only ->handle_inode_event() backend that supports
> +		 * FS_RENAME is dnotify, where DN_RENAME means that file
> +		 * was renamed within the same parent.
> +		 */
> +		if (WARN_ON_ONCE(!inode_mark) ||
> +		    inode_mark != parent_mark)
>  			return 0;
> -	}
> -
> -	if (parent_mark) {
> +	} else if (parent_mark) {
>  		/*
>  		 * parent_mark indicates that the parent inode is watching
>  		 * children and interested in this event, which is an event

...

> @@ -491,19 +491,31 @@ int fsnotify(__u32 mask, const void *data, int data_type, struct inode *dir,
>  	if (!inode) {
>  		/* Dirent event - report on TYPE_INODE to dir */
>  		inode = dir;
> -		/* For FS_RENAME, inode is old_dir and inode2 is new_dir */
> -		if (mask & FS_RENAME) {
> -			moved = fsnotify_data_dentry(data, data_type);
> -			inode2 = moved->d_parent->d_inode;
> -			inode2_type = FSNOTIFY_ITER_TYPE_INODE2;
> -		}
> +	} else if (mask & FS_RENAME) {
> +		/* For FS_RENAME, dir1 is old_dir and dir2 is new_dir */
> +		moved = fsnotify_data_dentry(data, data_type);
> +		dir1 = moved->d_parent->d_inode;
> +		dir2 = dir;
> +		if (dir1->i_fsnotify_marks || dir2->i_fsnotify_marks)
> +			dir1_type = FSNOTIFY_ITER_TYPE_OLD_DIR;
> +		/*
> +		 * Send FS_RENAME to groups watching the moved inode itself
> +		 * only if the moved inode is a non-dir.
> +		 * Sending FS_RENAME to a moved watched directory would be
> +		 * confusing and FS_MOVE_SELF provided enough information to
> +		 * track the movements of a watched directory.
> +		 */
> +		if (mask & FS_ISDIR)
> +			inode = NULL;

So I agree that sending FS_RENAME to a directory when the directory itself
moves is confusing. But then it makes me wonder whether it would not be
more logical if we extended FS_MOVE_SELF rather than FS_RENAME. Currently
FS_MOVE_SELF is an inode event but we could expand it to provide new parent
directory to priviledged listeners (and even old directory if we wanted).
But I guess the concern is that we'd have to introduce a group flag for
this to make sure things are backward compatible, whereas with FAN_RENAME
we could mostly get away without a feature flag?

> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index bb8467cd11ae..75f1048443a5 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -28,18 +28,19 @@
>   */
>  static inline int fsnotify_name(__u32 mask, const void *data, int data_type,
>  				struct inode *dir, const struct qstr *name,
> -				u32 cookie)
> +				struct inode *inode, u32 cookie)

So you add 'inode' argument to fsnotify_name() but never actually use it?
The only place where inode would be non-NULL is changed to use fsnotify()
directly...

Also I'm not sure why you pass the inode for rename event now when the same
inode is passed as 'dentry' in data? I feel like I'm missing something
here.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
