Return-Path: <linux-fsdevel+bounces-17897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640AD8B3882
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 15:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 880DA1C2113B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 13:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4E71482FC;
	Fri, 26 Apr 2024 13:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="E1ffhLcT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [178.154.239.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEC01474DF;
	Fri, 26 Apr 2024 13:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714138460; cv=none; b=JFmJGS1X3RpuekiRAx2G8RbkCgux0FDtrj6IvPFJMaCbPysaUJWuPQfrrI8KfiUd7LT/EBnPm3+18oe3SkG3OVVdQzb+WZ6sg+Pl+gAyjL9UPPCUxrJjMIu2PrPbjOjQIT5wf81Pw2kor2jCl4Xa8ndEEgr6PjzjS6G011kDlYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714138460; c=relaxed/simple;
	bh=nZvMQTmrqARtQUnPBPFu3Ve70ZduHAcyHC7S7TaKEbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hD73tobEN7x1tqxwO1qxxdQOEYZBn5D9W4AxeUQ1/+ystI1+c+Yxy++oSsrItp7caxFbLcIv9noIfPjD9KYliVcQiB+agQFbWDerVwIJYukfg0uqOAb39EbIOsCyzTGP3eu/fUOJ4Y39dbnr6i2goWvUmJl3ib07ljbtFg4OuDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=E1ffhLcT; arc=none smtp.client-ip=178.154.239.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0d:230c:0:640:f8e:0])
	by forward103a.mail.yandex.net (Yandex) with ESMTPS id C1737608F6;
	Fri, 26 Apr 2024 16:34:09 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 2YN3P0DXnmI0-8WRp0rPj;
	Fri, 26 Apr 2024 16:34:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1714138448; bh=PQrL87zyCxcvBgqIk2OLIv3fLCdiMHul6W+w6klXk6Y=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=E1ffhLcTFWZrSX+Ma2El3B2AWKqbH5vZPawrmS98o5BQmb8lkocxXMsnagi5Mkgr0
	 sXG3eaGmMdZoFcoxN3TCjo5He3ZY5gjtCR1W578ltnAQ02pEWmZggxfCAiYw19nKk3
	 fn837K0d7/WZjPIwT1Nhns2R4i4KIkw09rQWIRng=
Authentication-Results: mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Stas Sergeev <stsp2@yandex.ru>
To: linux-kernel@vger.kernel.org
Cc: Stas Sergeev <stsp2@yandex.ru>,
	Stefan Metzmacher <metze@samba.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andy Lutomirski <luto@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	David Laight <David.Laight@ACULAB.COM>,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v5 3/3] openat2: add OA2_CRED_INHERIT flag
Date: Fri, 26 Apr 2024 16:33:10 +0300
Message-ID: <20240426133310.1159976-4-stsp2@yandex.ru>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426133310.1159976-1-stsp2@yandex.ru>
References: <20240426133310.1159976-1-stsp2@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This flag performs the open operation with the fs credentials
(fsuid, fsgid, group_info) that were in effect when dir_fd was opened.
dir_fd must be opened with O_CRED_ALLOW flag for this to work.
This allows the process to pre-open some directories and then
change eUID (and all other UIDs/GIDs) to a less-privileged user,
retaining the ability to open/create files within these directories.

Design goal:
The idea is to provide a very light-weight sandboxing, where the
process, without the use of any heavy-weight techniques like chroot
within namespaces, can restrict the access to the set of pre-opened
directories.
This patch is just a first step to such sandboxing. If things go
well, in the future the same extension can be added to more syscalls.
These should include at least unlinkat(), renameat2() and the
not-yet-upstreamed setxattrat().

Security considerations:
- Only the bare minimal set of credentials is overridden:
  fsuid, fsgid and group_info. The rest, for example capabilities,
  are not overridden to avoid unneeded security risks.
- To avoid sandboxing escape, this patch makes sure the restricted
  lookup modes are used. Namely, RESOLVE_BENEATH or RESOLVE_IN_ROOT.
- Magic /proc symlinks are discarded, as suggested by
  Andy Lutomirski <luto@kernel.org>
- O_CRED_ALLOW fds cannot be passed via unix socket and are always
  closed on exec() to prevent "unsuspecting userspace" from not being
  able to fully drop privs.

Use cases:
Virtual machines that deal with untrusted code, can use that
instead of a more heavy-weighted approaches.
Currently the approach is being tested on a dosemu2 VM.

Signed-off-by: Stas Sergeev <stsp2@yandex.ru>

CC: Stefan Metzmacher <metze@samba.org>
CC: Eric Biederman <ebiederm@xmission.com>
CC: Alexander Viro <viro@zeniv.linux.org.uk>
CC: Andy Lutomirski <luto@kernel.org>
CC: Christian Brauner <brauner@kernel.org>
CC: Jan Kara <jack@suse.cz>
CC: Jeff Layton <jlayton@kernel.org>
CC: Chuck Lever <chuck.lever@oracle.com>
CC: Alexander Aring <alex.aring@gmail.com>
CC: linux-fsdevel@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Christian Göttsche <cgzones@googlemail.com>
---
 fs/fcntl.c                   |  2 ++
 fs/namei.c                   | 56 ++++++++++++++++++++++++++++++++++--
 fs/open.c                    | 10 ++++++-
 include/linux/fcntl.h        |  2 ++
 include/uapi/linux/openat2.h |  2 ++
 5 files changed, 69 insertions(+), 3 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 78c96b1293c2..283c2e65fc2c 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -1043,6 +1043,8 @@ static int __init fcntl_init(void)
 		HWEIGHT32(
 			(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
 			__FMODE_EXEC | __FMODE_NONOTIFY));
+	BUILD_BUG_ON(HWEIGHT32(VALID_OPENAT2_FLAGS) !=
+			HWEIGHT32(VALID_OPEN_FLAGS) + 1);
 
 	fasync_cache = kmem_cache_create("fasync_cache",
 					 sizeof(struct fasync_struct), 0,
diff --git a/fs/namei.c b/fs/namei.c
index dd50345f7260..aa5dcf57851b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3776,6 +3776,43 @@ static int do_o_path(struct nameidata *nd, unsigned flags, struct file *file)
 	return error;
 }
 
+static const struct cred *openat2_init_creds(int dfd)
+{
+	struct cred *cred;
+	struct fd f;
+
+	if (dfd == AT_FDCWD)
+		return ERR_PTR(-EINVAL);
+
+	f = fdget_raw(dfd);
+	if (!f.file)
+		return ERR_PTR(-EBADF);
+
+	cred = ERR_PTR(-EPERM);
+	if (!(f.file->f_flags & O_CRED_ALLOW))
+		goto done;
+
+	cred = prepare_creds();
+	if (!cred) {
+		cred = ERR_PTR(-ENOMEM);
+		goto done;
+	}
+
+	cred->fsuid = f.file->f_cred->fsuid;
+	cred->fsgid = f.file->f_cred->fsgid;
+	cred->group_info = get_group_info(f.file->f_cred->group_info);
+
+done:
+	fdput(f);
+	return cred;
+}
+
+static void openat2_done_creds(const struct cred *cred)
+{
+	put_group_info(cred->group_info);
+	put_cred(cred);
+}
+
 static struct file *path_openat(struct nameidata *nd,
 			const struct open_flags *op, unsigned flags)
 {
@@ -3793,18 +3830,33 @@ static struct file *path_openat(struct nameidata *nd,
 			error = do_o_path(nd, flags, file);
 	} else {
 		const char *s;
+		const struct cred *old_cred = NULL, *cred = NULL;
 
-		file = alloc_empty_file(open_flags, current_cred());
-		if (IS_ERR(file))
+		if (open_flags & OA2_CRED_INHERIT) {
+			cred = openat2_init_creds(nd->dfd);
+			if (IS_ERR(cred))
+				return ERR_CAST(cred);
+		}
+		file = alloc_empty_file(open_flags, cred ?: current_cred());
+		if (IS_ERR(file)) {
+			if (cred)
+				openat2_done_creds(cred);
 			return file;
+		}
 
 		s = path_init(nd, flags);
+		if (cred)
+			old_cred = override_creds(cred);
 		while (!(error = link_path_walk(s, nd)) &&
 		       (s = open_last_lookups(nd, file, op)) != NULL)
 			;
 		if (!error)
 			error = do_open(nd, file, op);
+		if (old_cred)
+			revert_creds(old_cred);
 		terminate_walk(nd);
+		if (cred)
+			openat2_done_creds(cred);
 	}
 	if (likely(!error)) {
 		if (likely(file->f_mode & FMODE_OPENED))
diff --git a/fs/open.c b/fs/open.c
index ee8460c83c77..dd4fab536135 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1225,7 +1225,7 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 	 * values before calling build_open_flags(), but openat2(2) checks all
 	 * of its arguments.
 	 */
-	if (flags & ~VALID_OPEN_FLAGS)
+	if (flags & ~VALID_OPENAT2_FLAGS)
 		return -EINVAL;
 	if (how->resolve & ~VALID_RESOLVE_FLAGS)
 		return -EINVAL;
@@ -1326,6 +1326,14 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 		lookup_flags |= LOOKUP_CACHED;
 	}
 
+	if (flags & OA2_CRED_INHERIT) {
+		/* Inherit creds only with scoped look-up modes. */
+		if (!(lookup_flags & LOOKUP_IS_SCOPED))
+			return -EPERM;
+		/* Reject /proc "magic" links if inheriting creds. */
+		lookup_flags |= LOOKUP_NO_MAGICLINKS;
+	}
+
 	op->lookup_flags = lookup_flags;
 	return 0;
 }
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index e074ee9c1e36..33b9c7ad056b 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -12,6 +12,8 @@
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
 	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | O_CRED_ALLOW)
 
+#define VALID_OPENAT2_FLAGS (VALID_OPEN_FLAGS | OA2_CRED_INHERIT)
+
 /* List of all valid flags for the how->resolve argument: */
 #define VALID_RESOLVE_FLAGS \
 	(RESOLVE_NO_XDEV | RESOLVE_NO_MAGICLINKS | RESOLVE_NO_SYMLINKS | \
diff --git a/include/uapi/linux/openat2.h b/include/uapi/linux/openat2.h
index a5feb7604948..f803558ad62f 100644
--- a/include/uapi/linux/openat2.h
+++ b/include/uapi/linux/openat2.h
@@ -40,4 +40,6 @@ struct open_how {
 					return -EAGAIN if that's not
 					possible. */
 
+#define OA2_CRED_INHERIT		(1UL << 28)
+
 #endif /* _UAPI_LINUX_OPENAT2_H */
-- 
2.44.0


