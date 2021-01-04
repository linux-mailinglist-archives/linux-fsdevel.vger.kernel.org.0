Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6882E9F43
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 22:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbhADVD3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 16:03:29 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:38816 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbhADVD2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 16:03:28 -0500
X-Greylist: delayed 1415 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Jan 2021 16:03:28 EST
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kwWYB-006sAQ-KF; Mon, 04 Jan 2021 20:33:59 +0000
Date:   Mon, 4 Jan 2021 20:33:59 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, Kyle Anderson <kylea@netflix.com>,
        Manas Alekar <malekar@netflix.com>
Subject: Re: [PATCH] fs: Validate flags and capabilities before looking up
 path in ksys_umount
Message-ID: <20210104203359.GO3579531@ZenIV.linux.org.uk>
References: <20201223102604.2078-1-sargun@sargun.me>
 <20210104195127.GN3579531@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104195127.GN3579531@ZenIV.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 04, 2021 at 07:51:27PM +0000, Al Viro wrote:
> On Wed, Dec 23, 2020 at 02:26:04AM -0800, Sargun Dhillon wrote:
> > ksys_umount was refactored to into split into another function
> > (path_umount) to enable sharing code. This changed the order that flags and
> > permissions are validated in, and made it so that user_path_at was called
> > before validating flags and capabilities.
> > 
> > Unfortunately, libfuse2[1] and libmount[2] rely on the old flag validation
> > behaviour to determine whether or not the kernel supports UMOUNT_NOFOLLOW.
> > The other path that this validation is being checked on is
> > init_umount->path_umount->can_umount. That's all internal to the kernel.
> > 
> > [1]: https://github.com/libfuse/libfuse/blob/9bfbeb576c5901b62a171d35510f0d1a922020b7/util/fusermount.c#L403
> > [2]: https://github.com/karelzak/util-linux/blob/7ed579523b556b1270f28dbdb7ee07dee310f157/libmount/src/context_umount.c#L813
> 
> Sorry, I don't like that solution.  If nothing else, it turns path_umount() into
> a landmine for the future.  Yes, we have a regression, yes, we need to do something
> about it, but that's not a good way to do that.
> 
> FWIW, I would rather separate the check of flags validity from can_umount()
> and lift _that_ into ksys_umount(), with "path_umount() relies upon the
> flags being minimally sane" comment slapped at path_umount() definition.
> The rest of can_umount() really shouldn't be taken out of there.

I mean something like the following; unlike your variant, may_mount() is left
where it is.

commit a0a6df9afcaf439a6b4c88a3b522e3d05fdef46f
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Mon Jan 4 15:25:34 2021 -0500

    umount(2): move the flag validity checks first
    
    Unfortunately, there's userland code that used to rely upon these
    checks being done before anything else to check for UMOUNT_NOFOLLOW
    support.  That broke in 41525f56e256 ("fs: refactor ksys_umount").
    Separate those from the rest of checks and move them to ksys_umount();
    unlike everything else in there, this can be sanely done there.
    
    Reported-by: Sargun Dhillon <sargun@sargun.me>
    Fixes: 41525f56e256 ("fs: refactor ksys_umount")
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/fs/namespace.c b/fs/namespace.c
index d2db7dfe232b..9d33909d0f9e 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1713,8 +1713,6 @@ static int can_umount(const struct path *path, int flags)
 {
 	struct mount *mnt = real_mount(path->mnt);
 
-	if (flags & ~(MNT_FORCE | MNT_DETACH | MNT_EXPIRE | UMOUNT_NOFOLLOW))
-		return -EINVAL;
 	if (!may_mount())
 		return -EPERM;
 	if (path->dentry != path->mnt->mnt_root)
@@ -1728,6 +1726,7 @@ static int can_umount(const struct path *path, int flags)
 	return 0;
 }
 
+// caller is responsible for flags being sane
 int path_umount(struct path *path, int flags)
 {
 	struct mount *mnt = real_mount(path->mnt);
@@ -1749,6 +1748,10 @@ static int ksys_umount(char __user *name, int flags)
 	struct path path;
 	int ret;
 
+	// basic validity checks done first
+	if (flags & ~(MNT_FORCE | MNT_DETACH | MNT_EXPIRE | UMOUNT_NOFOLLOW))
+		return -EINVAL;
+
 	if (!(flags & UMOUNT_NOFOLLOW))
 		lookup_flags |= LOOKUP_FOLLOW;
 	ret = user_path_at(AT_FDCWD, name, lookup_flags, &path);
