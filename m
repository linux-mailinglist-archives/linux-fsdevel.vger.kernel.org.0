Return-Path: <linux-fsdevel+bounces-34593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845899C680F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 05:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45149286106
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 04:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AAB4C98;
	Wed, 13 Nov 2024 04:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XKMv5wom"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47C841C6C;
	Wed, 13 Nov 2024 04:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731472212; cv=none; b=FL3zDahBbpKOEem+1DCLF+6A4vGCXvyb3D+8sanOsnDF9ghX+BZ9MhKRjH817Ezhnd7rVSo3wHnT1gMYzlRPmjKn+xOcX72H05a8E8Z6NsTGyb8vwS3UEQWGt/tt4Jrf7PNfQjMOln7P8Sx5kiMEPBj8FZhMn6yCxeIkqEBhGK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731472212; c=relaxed/simple;
	bh=MH5F3vlP88L7EiH6Bh1MjZF1ITbNu9Nq09eIINwcVlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZvXbDgk6Kb80Lugz56Ptq9Tj4VnwmU9BFKDY7C6dj0S+HSEZvZbAN1Qtxjqg0Hsymf/xnoT13HzwVyL+DAq1Z+wo5HJZEtcMCdMJXWzGeFTAyL7w/WlRadJtoDCDuFIdJ1SYiyyRs8OpquPSoOyjx+jSqQl5mHETYFBba3YhmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=XKMv5wom; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wZh1lNxuuSr30YjUMdsOV4XTgEJagRrgTnzmNehpilo=; b=XKMv5womPW9nnryoMkpEGH/E0+
	rxxM9TGFfKtRN19ZwerG5ECpVtqj1D3/a5YMf5g8FBAHkS17vvpRhNVAsjYRtPGgwgUtG0FBcE7Pg
	w7HhUBBdaxTzQlWhdAOCwsJfXIKSfSNelx5WZVeaybOEzdxcFmJK+RNsNWDYNI5CnOKHkDx7NK6lv
	uOAkF7wVrCAO3+MSVBW6jjU7RAp3cxm6ut+uAxvPAPoZffve0MuF66okL3a/mWuJeqVY1brwlbR+A
	XFC+yZfvbRk0AL884vqXjTh3XY3/wuOwelgq3mhSIp8sEFT+VOPHnrEutmtnmg4Rf24zeX1UH+WYN
	FKxc42Bw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tB511-0000000EMIh-0wwD;
	Wed, 13 Nov 2024 04:30:03 +0000
Date: Wed, 13 Nov 2024 04:30:03 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
	kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	brauner@kernel.org, linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v7 05/18] fsnotify: introduce pre-content permission
 events
Message-ID: <20241113043003.GH3387508@ZenIV>
References: <cover.1731433903.git.josef@toxicpanda.com>
 <141e2cc2dfac8b2f49c1c8d219dd7c20925b2cef.1731433903.git.josef@toxicpanda.com>
 <CAHk-=wjkBEch_Z9EMbup2bHtbtt7aoj-o5V6Nara+VxeUtckGw@mail.gmail.com>
 <CAOQ4uxiiFsu-cG89i_PA+kqUp8ycmewhuD9xJBgpuBy5AahG5Q@mail.gmail.com>
 <CAHk-=wijFZtUxsunOVN5G+FMBJ+8A-+p5TOURv2h=rbtO44egw@mail.gmail.com>
 <20241113001251.GF3387508@ZenIV>
 <CAHk-=wg02AubUBZ5DxLra7b5w2+hxawdipPqEHemg=Lf8b1TDA@mail.gmail.com>
 <CAHk-=wgVzOQDNASK8tU3JoZHUgp7BMTmuo2Njmqh4NvEMYTrCw@mail.gmail.com>
 <20241113011954.GG3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113011954.GG3387508@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Nov 13, 2024 at 01:19:54AM +0000, Al Viro wrote:
> On Tue, Nov 12, 2024 at 04:38:42PM -0800, Linus Torvalds wrote:
> > Looking at that locking code in fadvise() just for the f_mode use does
> > make me think this would be a really good cleanup.
> > 
> > I note that our fcntl code seems buggy as-is, because while it does
> > use f_lock for assignments (good), it clearly does *not* use them for
> > reading.
> > 
> > So it looks like you can actually read inconsistent values.
> > 
> > I get the feeling that f_flags would want WRITE_ONCE/READ_ONCE in
> > _addition_ to the f_lock use it has.
> 
> AFAICS, fasync logics is the fishy part - the rest should be sane.
> 
> > The f_mode thing with fadvise() smells like the same bug. Just because
> > the modifications are serialized wrt each other doesn't mean that
> > readers are then automatically ok.
> 
> Reads are also under ->f_lock in there, AFAICS...
> 
> Another thing in the vicinity is ->f_mode modifications after the calls
> of anon_inode_getfile() in several callers - probably ought to switch
> those to anon_inode_getfile_fmode().  That had been discussed back in
> April when the function got merged, but "convert to using it" followup
> series hadn't materialized...

While we are at it, there's is a couple of kludges I really hate -
mixing __FMODE_NONOTIFY and __FMODE_EXEC with O_... flags.

E.g. for __FMODE_NONOTIFY all it takes is switching fanotify from
anon_inode_getfd() to anon_inode_getfile_fmode() and adding
a dentry_open_nonotify() to be used by fanotify on the other path.
That's it - no more weird shit in OPEN_FMODE(), etc.

For __FMODE_EXEC it might get trickier (nfs is the main consumer),
but I seriously suspect that something like "have path_openat()
check op->acc_mode & MAY_EXEC and set FMODE_EXEC in ->f_mode
right after struct file allocation" would make a good starting
point; yes, it would affect uselib(2), but... I've no idea whether
it wouldn't be the right thing to do; would be hard to test.

Anyway, untested __FMODE_NONOTIFY side of it:

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 22dd9dcce7ec..ebd1c82bfb6b 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -1161,10 +1161,10 @@ static int __init fcntl_init(void)
 	 * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
 	 * is defined as O_NONBLOCK on some platforms and not on others.
 	 */
-	BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=
+	BUILD_BUG_ON(20 - 1 /* for O_RDONLY being 0 */ !=
 		HWEIGHT32(
 			(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
-			__FMODE_EXEC | __FMODE_NONOTIFY));
+			__FMODE_EXEC));
 
 	fasync_cache = kmem_cache_create("fasync_cache",
 					 sizeof(struct fasync_struct), 0,
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 9644bc72e457..43fbf29ef03a 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -101,8 +101,7 @@ static void __init fanotify_sysctls_init(void)
  *
  * Internal and external open flags are stored together in field f_flags of
  * struct file. Only external open flags shall be allowed in event_f_flags.
- * Internal flags like FMODE_NONOTIFY, FMODE_EXEC, FMODE_NOCMTIME shall be
- * excluded.
+ * Internal flags like FMODE_EXEC shall be excluded.
  */
 #define	FANOTIFY_INIT_ALL_EVENT_F_BITS				( \
 		O_ACCMODE	| O_APPEND	| O_NONBLOCK	| \
@@ -262,8 +261,8 @@ static int create_fd(struct fsnotify_group *group, const struct path *path,
 	 * we need a new file handle for the userspace program so it can read even if it was
 	 * originally opened O_WRONLY.
 	 */
-	new_file = dentry_open(path,
-			       group->fanotify_data.f_flags | __FMODE_NONOTIFY,
+	new_file = dentry_open_nonotify(path,
+			       group->fanotify_data.f_flags,
 			       current_cred());
 	if (IS_ERR(new_file)) {
 		/*
@@ -1404,6 +1403,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	unsigned int fid_mode = flags & FANOTIFY_FID_BITS;
 	unsigned int class = flags & FANOTIFY_CLASS_BITS;
 	unsigned int internal_flags = 0;
+	struct file *file;
 
 	pr_debug("%s: flags=%x event_f_flags=%x\n",
 		 __func__, flags, event_f_flags);
@@ -1472,7 +1472,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	    (!(fid_mode & FAN_REPORT_NAME) || !(fid_mode & FAN_REPORT_FID)))
 		return -EINVAL;
 
-	f_flags = O_RDWR | __FMODE_NONOTIFY;
+	f_flags = O_RDWR;
 	if (flags & FAN_CLOEXEC)
 		f_flags |= O_CLOEXEC;
 	if (flags & FAN_NONBLOCK)
@@ -1550,10 +1550,18 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 			goto out_destroy_group;
 	}
 
-	fd = anon_inode_getfd("[fanotify]", &fanotify_fops, group, f_flags);
+	fd = get_unused_fd_flags(flags);
 	if (fd < 0)
 		goto out_destroy_group;
 
+	file = anon_inode_getfile_fmode("[fanotify]", &fanotify_fops, group,
+					f_flags, FMODE_NONOTIFY);
+	if (IS_ERR(file)) {
+		fd = PTR_ERR(file);
+		put_unused_fd(fd);
+		goto out_destroy_group;
+	}
+	fd_install(fd, file);
 	return fd;
 
 out_destroy_group:
diff --git a/fs/open.c b/fs/open.c
index acaeb3e25c88..04cb581528ff 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1118,6 +1118,23 @@ struct file *dentry_open(const struct path *path, int flags,
 }
 EXPORT_SYMBOL(dentry_open);
 
+struct file *dentry_open_nonotify(const struct path *path, int flags,
+			 const struct cred *cred)
+{
+	struct file *f = alloc_empty_file(flags, cred);
+	if (!IS_ERR(f)) {
+		int error;
+
+		f->f_mode |= FMODE_NONOTIFY;
+		error = vfs_open(path, f);
+		if (error) {
+			fput(f);
+			f = ERR_PTR(error);
+		}
+	}
+	return f;
+}
+
 /**
  * dentry_create - Create and open a file
  * @path: path to create
@@ -1215,7 +1232,7 @@ inline struct open_how build_open_how(int flags, umode_t mode)
 inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 {
 	u64 flags = how->flags;
-	u64 strip = __FMODE_NONOTIFY | O_CLOEXEC;
+	u64 strip = O_CLOEXEC;
 	int lookup_flags = 0;
 	int acc_mode = ACC_MODE(flags);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e3c603d01337..18888d601550 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2731,6 +2731,8 @@ struct file *dentry_open(const struct path *path, int flags,
 struct file *dentry_create(const struct path *path, int flags, umode_t mode,
 			   const struct cred *cred);
 struct path *backing_file_user_path(struct file *f);
+struct file *dentry_open_nonotify(const struct path *path, int flags,
+			 const struct cred *creds);
 
 /*
  * When mmapping a file on a stackable filesystem (e.g., overlayfs), the file
@@ -3620,11 +3622,9 @@ struct ctl_table;
 int __init list_bdev_fs_names(char *buf, size_t size);
 
 #define __FMODE_EXEC		((__force int) FMODE_EXEC)
-#define __FMODE_NONOTIFY	((__force int) FMODE_NONOTIFY)
 
 #define ACC_MODE(x) ("\004\002\006\006"[(x)&O_ACCMODE])
-#define OPEN_FMODE(flag) ((__force fmode_t)(((flag + 1) & O_ACCMODE) | \
-					    (flag & __FMODE_NONOTIFY)))
+#define OPEN_FMODE(flag) ((__force fmode_t)(((flag + 1) & O_ACCMODE)))
 
 static inline bool is_sxid(umode_t mode)
 {
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 80f37a0d40d7..613475285643 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -6,7 +6,6 @@
 
 /*
  * FMODE_EXEC is 0x20
- * FMODE_NONOTIFY is 0x4000000
  * These cannot be used by userspace O_* until internal and external open
  * flags are split.
  * -Eric Paris

