Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E3431B910
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 13:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhBOMWF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 07:22:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:54208 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230337AbhBOMVx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 07:21:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5AE60B03A;
        Mon, 15 Feb 2021 12:21:11 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 4363275b;
        Mon, 15 Feb 2021 12:22:13 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jeff Layton <jlayton@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] fs: Add flag to file_system_type to indicate
 content is generated
References: <20210212044405.4120619-1-drinkcat@chromium.org>
        <20210212124354.1.I7084a6235fbcc522b674a6b1db64e4aff8170485@changeid>
        <YCYybUg4d3+Oij4N@kroah.com>
        <CAOQ4uxhovoZ4S3WhXwgYDeOeomBxfQ1BdzSyGdqoVX6boDOkeA@mail.gmail.com>
        <YCY+tjPgcDmgmVD1@kroah.com> <871rdljxtx.fsf@suse.de>
        <YCZyBZ1iT+MUXLu1@kroah.com> <87sg61ihkj.fsf@suse.de>
        <CAOQ4uxi-VuBmE8Ej_B3xmBnn1nmp9qpiA-BkNpPcrE0PCRp1UA@mail.gmail.com>
        <87h7mdvcmd.fsf@suse.de>
Date:   Mon, 15 Feb 2021 12:22:13 +0000
In-Reply-To: <87h7mdvcmd.fsf@suse.de> (Luis Henriques's message of "Mon, 15
        Feb 2021 10:39:22 +0000")
Message-ID: <87eehhldvu.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Luis Henriques <lhenriques@suse.de> writes:

> Amir Goldstein <amir73il@gmail.com> writes:
>
>> On Fri, Feb 12, 2021 at 2:40 PM Luis Henriques <lhenriques@suse.de> wrote:
> ...
>>> Sure, I just wanted to point out that *maybe* there are other options than
>>> simply reverting that commit :-)
>>>
>>> Something like the patch below (completely untested!) should revert to the
>>> old behaviour in filesystems that don't implement the CFR syscall.
>>>
>>> Cheers,
>>> --
>>> Luis
>>>
>>> diff --git a/fs/read_write.c b/fs/read_write.c
>>> index 75f764b43418..bf5dccc43cc9 100644
>>> --- a/fs/read_write.c
>>> +++ b/fs/read_write.c
>>> @@ -1406,8 +1406,11 @@ static ssize_t do_copy_file_range(struct file *file_in, loff_t pos_in,
>>>                                                        file_out, pos_out,
>>>                                                        len, flags);
>>>
>>> -       return generic_copy_file_range(file_in, pos_in, file_out, pos_out, len,
>>> -                                      flags);
>>> +       if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
>>> +               return -EXDEV;
>>> +       else
>>> +               generic_copy_file_range(file_in, pos_in, file_out, pos_out, len,
>>> +                                       flags);
>>>  }
>>>
>>
>> Which kernel is this patch based on?
>
> It was v5.11-rc7.
>
>> At this point, I am with Dave and Darrick on not falling back to
>> generic_copy_file_range() at all.
>>
>> We do not have proof of any workload that benefits from it and the
>> above patch does not protect from a wierd use case of trying to copy a file
>> from sysfs to sysfs.
>>
>
> Ok, cool.  I can post a new patch doing just that.  I guess that function
> do_copy_file_range() can be dropped in that case.
>
>> I am indecisive about what should be done with generic_copy_file_range()
>> called as fallback from within filesystems.
>>
>> I think the wise choice is to not do the fallback in any case, but this is up
>> to the specific filesystem maintainers to decide.
>
> I see what you mean.  You're suggesting to have userspace handle all the
> -EOPNOTSUPP and -EXDEV errors.  Would you rather have a patch that also
> removes all the calls to generic_copy_file_range() function?  And that
> function can also be deleted too, of course.

Here's a first stab at this patch.  Hopefully I didn't forgot anything
here.  Let me know if you prefer the more conservative approach, i.e. not
touching any of the filesystems and let them use generic_copy_file_range.

Once everyone agrees on the final solution, I can follow-up with the
manpages update.

Cheers,
-- 
Luis

From e1b37e80b12601d56f792bd19377d3e5208188ef Mon Sep 17 00:00:00 2001
From: Luis Henriques <lhenriques@suse.de>
Date: Fri, 12 Feb 2021 18:03:23 +0000
Subject: [PATCH] vfs: prevent copy_file_range to copy across devices

Nicolas Boichat reported an issue when trying to use the copy_file_range
syscall on a tracefs file.  It failed silently because the file content is
generated on-the-fly (reporting a size of zero) and copy_file_range needs
to know in advance how much data is present.

This commit effectively reverts 5dae222a5ff0 ("vfs: allow copy_file_range to
copy across devices").  Now the copy is done only if the filesystems for source
and destination files are the same and they implement this syscall.

Fixes: 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices")
Cc: Nicolas Boichat <drinkcat@chromium.org>
Signed-off-by: Luis Henriques <lhenriques@suse.de>
---
 fs/ceph/file.c     | 21 +++------------
 fs/cifs/cifsfs.c   |  3 ---
 fs/fuse/file.c     | 21 +++------------
 fs/nfs/nfs4file.c  | 20 +++-----------
 fs/read_write.c    | 65 ++++++++--------------------------------------
 include/linux/fs.h |  3 ---
 6 files changed, 20 insertions(+), 113 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 209535d5b8d3..639bd7bfaea9 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -2261,9 +2261,9 @@ static ssize_t ceph_do_objects_copy(struct ceph_inode_info *src_ci, u64 *src_off
 	return bytes;
 }
 
-static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
-				      struct file *dst_file, loff_t dst_off,
-				      size_t len, unsigned int flags)
+static ssize_t ceph_copy_file_range(struct file *src_file, loff_t src_off,
+				    struct file *dst_file, loff_t dst_off,
+				    size_t len, unsigned int flags)
 {
 	struct inode *src_inode = file_inode(src_file);
 	struct inode *dst_inode = file_inode(dst_file);
@@ -2456,21 +2456,6 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	return ret;
 }
 
-static ssize_t ceph_copy_file_range(struct file *src_file, loff_t src_off,
-				    struct file *dst_file, loff_t dst_off,
-				    size_t len, unsigned int flags)
-{
-	ssize_t ret;
-
-	ret = __ceph_copy_file_range(src_file, src_off, dst_file, dst_off,
-				     len, flags);
-
-	if (ret == -EOPNOTSUPP || ret == -EXDEV)
-		ret = generic_copy_file_range(src_file, src_off, dst_file,
-					      dst_off, len, flags);
-	return ret;
-}
-
 const struct file_operations ceph_file_fops = {
 	.open = ceph_open,
 	.release = ceph_release,
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index e46da536ed33..8b869cc67443 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1229,9 +1229,6 @@ static ssize_t cifs_copy_file_range(struct file *src_file, loff_t off,
 					len, flags);
 	free_xid(xid);
 
-	if (rc == -EOPNOTSUPP || rc == -EXDEV)
-		rc = generic_copy_file_range(src_file, off, dst_file,
-					     destoff, len, flags);
 	return rc;
 }
 
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 8cccecb55fb8..0dd703278e49 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3330,9 +3330,9 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 	return err;
 }
 
-static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
-				      struct file *file_out, loff_t pos_out,
-				      size_t len, unsigned int flags)
+static ssize_t fuse_copy_file_range(struct file *file_in, loff_t pos_in,
+				    struct file *file_out, loff_t pos_out,
+				    size_t len, unsigned int flags)
 {
 	struct fuse_file *ff_in = file_in->private_data;
 	struct fuse_file *ff_out = file_out->private_data;
@@ -3439,21 +3439,6 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 	return err;
 }
 
-static ssize_t fuse_copy_file_range(struct file *src_file, loff_t src_off,
-				    struct file *dst_file, loff_t dst_off,
-				    size_t len, unsigned int flags)
-{
-	ssize_t ret;
-
-	ret = __fuse_copy_file_range(src_file, src_off, dst_file, dst_off,
-				     len, flags);
-
-	if (ret == -EOPNOTSUPP || ret == -EXDEV)
-		ret = generic_copy_file_range(src_file, src_off, dst_file,
-					      dst_off, len, flags);
-	return ret;
-}
-
 static const struct file_operations fuse_file_operations = {
 	.llseek		= fuse_file_llseek,
 	.read_iter	= fuse_file_read_iter,
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 57b3821d975a..60998209e310 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -133,9 +133,9 @@ nfs4_file_flush(struct file *file, fl_owner_t id)
 }
 
 #ifdef CONFIG_NFS_V4_2
-static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
-				      struct file *file_out, loff_t pos_out,
-				      size_t count, unsigned int flags)
+static ssize_t nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
+				    struct file *file_out, loff_t pos_out,
+				    size_t count, unsigned int flags)
 {
 	struct nfs42_copy_notify_res *cn_resp = NULL;
 	struct nl4_server *nss = NULL;
@@ -189,20 +189,6 @@ static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
 	return ret;
 }
 
-static ssize_t nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
-				    struct file *file_out, loff_t pos_out,
-				    size_t count, unsigned int flags)
-{
-	ssize_t ret;
-
-	ret = __nfs4_copy_file_range(file_in, pos_in, file_out, pos_out, count,
-				     flags);
-	if (ret == -EOPNOTSUPP || ret == -EXDEV)
-		ret = generic_copy_file_range(file_in, pos_in, file_out,
-					      pos_out, count, flags);
-	return ret;
-}
-
 static loff_t nfs4_file_llseek(struct file *filep, loff_t offset, int whence)
 {
 	loff_t ret;
diff --git a/fs/read_write.c b/fs/read_write.c
index 75f764b43418..87bf9efd7f71 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1358,58 +1358,6 @@ COMPAT_SYSCALL_DEFINE4(sendfile64, int, out_fd, int, in_fd,
 }
 #endif
 
-/**
- * generic_copy_file_range - copy data between two files
- * @file_in:	file structure to read from
- * @pos_in:	file offset to read from
- * @file_out:	file structure to write data to
- * @pos_out:	file offset to write data to
- * @len:	amount of data to copy
- * @flags:	copy flags
- *
- * This is a generic filesystem helper to copy data from one file to another.
- * It has no constraints on the source or destination file owners - the files
- * can belong to different superblocks and different filesystem types. Short
- * copies are allowed.
- *
- * This should be called from the @file_out filesystem, as per the
- * ->copy_file_range() method.
- *
- * Returns the number of bytes copied or a negative error indicating the
- * failure.
- */
-
-ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
-				struct file *file_out, loff_t pos_out,
-				size_t len, unsigned int flags)
-{
-	return do_splice_direct(file_in, &pos_in, file_out, &pos_out,
-				len > MAX_RW_COUNT ? MAX_RW_COUNT : len, 0);
-}
-EXPORT_SYMBOL(generic_copy_file_range);
-
-static ssize_t do_copy_file_range(struct file *file_in, loff_t pos_in,
-				  struct file *file_out, loff_t pos_out,
-				  size_t len, unsigned int flags)
-{
-	/*
-	 * Although we now allow filesystems to handle cross sb copy, passing
-	 * a file of the wrong filesystem type to filesystem driver can result
-	 * in an attempt to dereference the wrong type of ->private_data, so
-	 * avoid doing that until we really have a good reason.  NFS defines
-	 * several different file_system_type structures, but they all end up
-	 * using the same ->copy_file_range() function pointer.
-	 */
-	if (file_out->f_op->copy_file_range &&
-	    file_out->f_op->copy_file_range == file_in->f_op->copy_file_range)
-		return file_out->f_op->copy_file_range(file_in, pos_in,
-						       file_out, pos_out,
-						       len, flags);
-
-	return generic_copy_file_range(file_in, pos_in, file_out, pos_out, len,
-				       flags);
-}
-
 /*
  * Performs necessary checks before doing a file copy
  *
@@ -1474,6 +1422,14 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 {
 	ssize_t ret;
 
+	/*
+	 * Allow the copy only if the filesystems for file_in and file_out are
+	 * the same, and copy_file_range is implemented.
+	 */
+	if (!file_out->f_op->copy_file_range ||
+	    (file_out->f_op->copy_file_range != file_in->f_op->copy_file_range))
+		return -EXDEV;
+
 	if (flags != 0)
 		return -EINVAL;
 
@@ -1513,8 +1469,9 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 		}
 	}
 
-	ret = do_copy_file_range(file_in, pos_in, file_out, pos_out, len,
-				flags);
+	ret = file_out->f_op->copy_file_range(file_in, pos_in,
+					      file_out, pos_out,
+					      len, flags);
 	WARN_ON_ONCE(ret == -EOPNOTSUPP);
 done:
 	if (ret > 0) {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fd47deea7c17..3aaf627be409 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1910,9 +1910,6 @@ extern ssize_t vfs_read(struct file *, char __user *, size_t, loff_t *);
 extern ssize_t vfs_write(struct file *, const char __user *, size_t, loff_t *);
 extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file *,
 				   loff_t, size_t, unsigned int);
-extern ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
-				       struct file *file_out, loff_t pos_out,
-				       size_t len, unsigned int flags);
 extern int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 					 struct file *file_out, loff_t pos_out,
 					 loff_t *count,
