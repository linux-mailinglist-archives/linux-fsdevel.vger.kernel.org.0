Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61EA63648B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 19:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbhDSRCz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 13:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhDSRCy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 13:02:54 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF67EC06174A
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Apr 2021 10:02:24 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lYXHt-006bH2-0E; Mon, 19 Apr 2021 17:02:17 +0000
Date:   Mon, 19 Apr 2021 17:02:16 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: fsnotify path hooks
Message-ID: <YH23mMawq2nZeBhk@zeniv-ca.linux.org.uk>
References: <CAOQ4uxirud-+ot0kZ=8qaicvjEM5w1scAeoLP_-HzQx+LwihHw@mail.gmail.com>
 <20210331125412.GI30749@quack2.suse.cz>
 <CAOQ4uxjOyuvpJ7Tv3cGmv+ek7+z9BJBF4sK_-OLxwePUrHERUg@mail.gmail.com>
 <CAOQ4uxhWE9JGOZ_jN9_RT5EkACdNWXOryRsm6Wg_zkaDNDSjsA@mail.gmail.com>
 <20210401102947.GA29690@quack2.suse.cz>
 <CAOQ4uxjHFkRVTY5iyTSpb0R5R6j-j=8+Htpu2hgMAz9MTci-HQ@mail.gmail.com>
 <CAOQ4uxjS56hjaXeTUdce2gJT3tTFb2Zs1_PiUJZzXF9i-SPGkw@mail.gmail.com>
 <20210408125258.GB3271@quack2.suse.cz>
 <CAOQ4uxhrvKkK3RZRoGTojpyiyVmQpLWknYiKs8iN=Uq+mhOvsg@mail.gmail.com>
 <CAOQ4uxi3c2xg9eiL41xv51JoGKn0E2KZuK07na0uSNCxU54OMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi3c2xg9eiL41xv51JoGKn0E2KZuK07na0uSNCxU54OMQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 19, 2021 at 07:41:51PM +0300, Amir Goldstein wrote:

> Would you be willing to make an exception for notify_change()
> and pass mnt arg to the helper? and if so, which of the following
> is the lesser evil in your opinion:
> 
> 1. Optional mnt arg
> --------------------------
> int notify_change(struct vfsmount *mnt,
>                  struct user_namespace *mnt_userns,
>                  struct dentry *dentry, struct iattr *attr,
>                  struct inode **delegated_inode)
> 
> @mnt is non-NULL from syscalls and nfsd and NULL from other callers.
> 
> 2. path instead of dentry
> --------------------------------
> int notify_change(struct user_namespace *mnt_userns,
>                  struct path *path, struct iattr *attr,
>                  struct inode **delegated_inode)
> 
> This is symmetric with vfs_getattr().
> syscalls and nfsd use the actual path.
> overlayfs, ecryptfs, cachefiles compose a path from the private mount
> (Christian posted patches to make ecryptfs, cachefiles mount private).
> 
> 3. Mandatory mnt arg
> -----------------------------
> Like #1, but use some private mount instead of NULL, similar to the
> mnt_userns arg.
> 
> Any of the above acceptable?
> 
> Pushed option #1 (along with rest of the work) to:
> https://github.com/amir73il/linux/commits/fsnotify_path_hooks
> 
> It's only sanity tested.

	Out of that bunch only #2 is more or less tolerable.
HOWEVER, if we go that way, mnt_user_ns crap must go, and
I really want to see details on all callers - which mount are
you going to use in each case.

	The thing that is not going to be acceptable is
a combination of mount from one filesystem and dentry from
another.  In particular, file_remove_privs() is going to be
interesting.

	Note, BTW, that ftruncate() and file_remove_privs()
are different in that respect - the latter hits d_real()
(by way of file_dentry()), the former does not.  Which one
is correct and if both are, why are their needs different?
