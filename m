Return-Path: <linux-fsdevel+bounces-35415-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0916F9D4B94
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 12:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA7028138B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 11:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429E41D6DB5;
	Thu, 21 Nov 2024 11:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zwfbjgYd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OkZ6CglI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zwfbjgYd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OkZ6CglI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280461CEAB8;
	Thu, 21 Nov 2024 11:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732188148; cv=none; b=o6hVweSwz8Sh6rnifPOoVOoAlOV924ClMWUWSgOBw5gqUrouEyHLWw63R3YJSsUB2mAy6gkQRMmMmv2XrjBQJRQ/NpJIgHpV1u9wM4tRH4SJd5rT71nbDgsXDZgLRSITW/0AN9BvHcrc5a2Wplme9h6Fy3qFBsJuGozrNJxlTtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732188148; c=relaxed/simple;
	bh=PUMa00Ux/Ukqpg2kpDBNw2s7UqmB0bMW7qE0AjwVqMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=quEyeVKoxJAfjYv8o2/gfyvbeNxm/sUfepuUGA4fH3tV1KturPp5sZoI7BGQW4XPqIagVfrR34YDAR5gMIvyLB6ungaVEdhhcIOG66ixUD8lZQ9fH8EXeMSmJ1SPG/fPVknTi2m9KY4mDYADq32U+NZQaEK0zC28B7eUh5kMRvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zwfbjgYd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OkZ6CglI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zwfbjgYd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OkZ6CglI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 337EE1F7F8;
	Thu, 21 Nov 2024 11:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732188144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Co8JGJLovzaeb1AfMJ+YztwQW053Y0U4kyj+8PiKMxM=;
	b=zwfbjgYdAVFSbwkH7ZnuVl428l9dRuDVyNBXONoBTg61avRdEWy/u4P1qb3SCf4V/Pc5U6
	Z6ELuP17V5KpPXf4mKMe6MaOavUdcZd/rw/RIiMfK2nbP7oDUtwkHL9Asg9IS3SK7y06gT
	YCST7guMwoogWeZiFAUzPerQi0kFt70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732188144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Co8JGJLovzaeb1AfMJ+YztwQW053Y0U4kyj+8PiKMxM=;
	b=OkZ6CglI0kgaHO0MK0SfB8AXOPiXoIDcMAx38Tmv/KMlOtq0KNvCPpjwgFX7fmOoc7ukXp
	ZiAu7meypMFzbiCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732188144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Co8JGJLovzaeb1AfMJ+YztwQW053Y0U4kyj+8PiKMxM=;
	b=zwfbjgYdAVFSbwkH7ZnuVl428l9dRuDVyNBXONoBTg61avRdEWy/u4P1qb3SCf4V/Pc5U6
	Z6ELuP17V5KpPXf4mKMe6MaOavUdcZd/rw/RIiMfK2nbP7oDUtwkHL9Asg9IS3SK7y06gT
	YCST7guMwoogWeZiFAUzPerQi0kFt70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732188144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Co8JGJLovzaeb1AfMJ+YztwQW053Y0U4kyj+8PiKMxM=;
	b=OkZ6CglI0kgaHO0MK0SfB8AXOPiXoIDcMAx38Tmv/KMlOtq0KNvCPpjwgFX7fmOoc7ukXp
	ZiAu7meypMFzbiCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1EE5C13927;
	Thu, 21 Nov 2024 11:22:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l/g3B/AXP2cSfwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Nov 2024 11:22:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C4E73A08A2; Thu, 21 Nov 2024 12:22:23 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	brauner@kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-mm@kvack.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 01/19] fs: get rid of __FMODE_NONOTIFY kludge
Date: Thu, 21 Nov 2024 12:22:00 +0100
Message-Id: <20241121112218.8249-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241121112218.8249-1-jack@suse.cz>
References: <20241121112218.8249-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,toxicpanda.com,kernel.org,linux-foundation.org,ZenIV.linux.org.uk,vger.kernel.org,kvack.org,zeniv.linux.org.uk,suse.cz];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,msgid.link:url];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	R_RATELIMIT(0.00)[to_ip_from(RLdu9otajk16idfrkma9mbkf9b)];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Level: 

From: Al Viro <viro@zeniv.linux.org.uk>

All it takes to get rid of the __FMODE_NONOTIFY kludge is switching
fanotify from anon_inode_getfd() to anon_inode_getfile_fmode() and adding
a dentry_open_nonotify() helper to be used by fanotify on the other path.
That's it - no more weird shit in OPEN_FMODE(), etc.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Link: https://lore.kernel.org/linux-fsdevel/20241113043003.GH3387508@ZenIV/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/d1231137e7b661a382459e79a764259509a4115d.1731684329.git.josef@toxicpanda.com
---
 fs/fcntl.c                         |  4 ++--
 fs/notify/fanotify/fanotify_user.c | 25 ++++++++++++++++---------
 fs/open.c                          | 23 +++++++++++++++++++----
 include/linux/fs.h                 |  6 +++---
 include/uapi/asm-generic/fcntl.h   |  1 -
 5 files changed, 40 insertions(+), 19 deletions(-)

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
index 8e2d43fc6f7c..83ee591744e9 100644
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
@@ -259,12 +258,11 @@ static int create_fd(struct fsnotify_group *group, const struct path *path,
 		return client_fd;
 
 	/*
-	 * we need a new file handle for the userspace program so it can read even if it was
-	 * originally opened O_WRONLY.
+	 * We provide an fd for the userspace program, so it could access the
+	 * file without generating fanotify events itself.
 	 */
-	new_file = dentry_open(path,
-			       group->fanotify_data.f_flags | __FMODE_NONOTIFY,
-			       current_cred());
+	new_file = dentry_open_nonotify(path, group->fanotify_data.f_flags,
+					current_cred());
 	if (IS_ERR(new_file)) {
 		put_unused_fd(client_fd);
 		client_fd = PTR_ERR(new_file);
@@ -1415,6 +1413,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	unsigned int fid_mode = flags & FANOTIFY_FID_BITS;
 	unsigned int class = flags & FANOTIFY_CLASS_BITS;
 	unsigned int internal_flags = 0;
+	struct file *file;
 
 	pr_debug("%s: flags=%x event_f_flags=%x\n",
 		 __func__, flags, event_f_flags);
@@ -1483,7 +1482,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	    (!(fid_mode & FAN_REPORT_NAME) || !(fid_mode & FAN_REPORT_FID)))
 		return -EINVAL;
 
-	f_flags = O_RDWR | __FMODE_NONOTIFY;
+	f_flags = O_RDWR;
 	if (flags & FAN_CLOEXEC)
 		f_flags |= O_CLOEXEC;
 	if (flags & FAN_NONBLOCK)
@@ -1561,10 +1560,18 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 			goto out_destroy_group;
 	}
 
-	fd = anon_inode_getfd("[fanotify]", &fanotify_fops, group, f_flags);
+	fd = get_unused_fd_flags(f_flags);
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
index 6c4950f19cfb..480c3798da2a 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1122,6 +1122,23 @@ struct file *dentry_open(const struct path *path, int flags,
 }
 EXPORT_SYMBOL(dentry_open);
 
+struct file *dentry_open_nonotify(const struct path *path, int flags,
+				  const struct cred *cred)
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
@@ -1219,7 +1236,7 @@ inline struct open_how build_open_how(int flags, umode_t mode)
 inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 {
 	u64 flags = how->flags;
-	u64 strip = __FMODE_NONOTIFY | O_CLOEXEC;
+	u64 strip = O_CLOEXEC;
 	int lookup_flags = 0;
 	int acc_mode = ACC_MODE(flags);
 
@@ -1227,9 +1244,7 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 			 "struct open_flags doesn't yet handle flags > 32 bits");
 
 	/*
-	 * Strip flags that either shouldn't be set by userspace like
-	 * FMODE_NONOTIFY or that aren't relevant in determining struct
-	 * open_flags like O_CLOEXEC.
+	 * Strip flags that aren't relevant in determining struct open_flags.
 	 */
 	flags &= ~strip;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3559446279c1..24598d707578 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2728,6 +2728,8 @@ static inline struct file *file_open_root_mnt(struct vfsmount *mnt,
 }
 struct file *dentry_open(const struct path *path, int flags,
 			 const struct cred *creds);
+struct file *dentry_open_nonotify(const struct path *path, int flags,
+				  const struct cred *cred);
 struct file *dentry_create(const struct path *path, int flags, umode_t mode,
 			   const struct cred *cred);
 struct path *backing_file_user_path(struct file *f);
@@ -3625,11 +3627,9 @@ struct ctl_table;
 int __init list_bdev_fs_names(char *buf, size_t size);
 
 #define __FMODE_EXEC		((__force int) FMODE_EXEC)
-#define __FMODE_NONOTIFY	((__force int) FMODE_NONOTIFY)
 
 #define ACC_MODE(x) ("\004\002\006\006"[(x)&O_ACCMODE])
-#define OPEN_FMODE(flag) ((__force fmode_t)(((flag + 1) & O_ACCMODE) | \
-					    (flag & __FMODE_NONOTIFY)))
+#define OPEN_FMODE(flag) ((__force fmode_t)((flag + 1) & O_ACCMODE))
 
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
-- 
2.35.3


