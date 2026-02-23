Return-Path: <linux-fsdevel+bounces-77969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEimDKFvnGmcGAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 16:17:53 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5D61789F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 16:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A0A0301412F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 15:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258DF27F732;
	Mon, 23 Feb 2026 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="UFWcD0xh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AF927874F
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 15:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771859870; cv=none; b=rmS5d7aRIjq1NJmpVjl2nMEEcdFR7ULSWq8pg2/WNVVbMr3U/OkUrpk9WMUN9fIGEBNSyDvyRHO5Z8+/3cD4RBc4vUjtEffPUZFNng7PKsx2ZaFH/0PqWMeANpmiVfbNqD+UqBEH/xtKfqS+lOTA1Uw7LOB0GxNF9+dnRF/sa3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771859870; c=relaxed/simple;
	bh=S6f4OSeOdwFtTvDmuWzz71idGWXHpg8JIYPYCgQVQZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nWEeK3Nbbw3bRyTJXg+br6BU/hOqzWo+JXdim5okYZ972xdSFg9PsVqKFZKzxoVXpxDZJvEuwz7HWaH9i2c8xJMHD9VaN5fz6ZBHo3+RtZ51Gxaly28ENSqRjsJhH4oGtIma00KZ6SXrXRozVDHEWKqud9oahmClX4R08DX5Ngw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=UFWcD0xh; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: a59a2182-10ca-11f1-b181-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id a59a2182-10ca-11f1-b181-005056abad63;
	Mon, 23 Feb 2026 16:16:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=LZV0p7h9QVGul+r0X+delToi4GAIpdjQCqrCW/EFPa0=;
	b=UFWcD0xhmlurYXNxTQ1VnPgKQRJXg5MP51aPGnoIbDithc2UwF7X4Vg9HnZIzfEzVYlMPWYOQIc9f
	 Jw+z5J4KZOFnU8BgNo3taJg4n1kuI2Pr+F0eApizx/C5EsohLrt1d9L4/JZIvbpqKCpmKiYt+GFPIT
	 74n+I+zWsKMDPYiagosxnlGNowfl7fXTZYSL/HysEzutsTb9zn5b2xrf2tShZtNZk6Qx+3D9W8C0PF
	 1e6TyBqN3VRshNPGMi2xZs+YzHsZwaJQA3v6ZBeCG/uyY21FqFPJe25RyNLtxc7H4CFpUM02KG5LsZ
	 t65/L0TEZaxH4UWJfE0wlmfT9KNAm3w==
X-KPN-MID: 33|6xbVdMBpbX6LwH2HYBsrQ/S9ZruyUKnwQUibKvwI/r7OCqDA4wbX68TB9AWiccj
 OJqyIkFMLSRfueoMyeYtosw==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|vVWvf2zt/0xViE/6bU7JINk92i5Q+ghtq3hQdSCWNH838Jv6O1S3YuQrURSx2pF
 5EvCZxY/g99HZbnWbNVzALg==
Received: from daedalus.home (unknown [91.141.147.178])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id a1ffedf7-10ca-11f1-b8df-005056ab7584;
	Mon, 23 Feb 2026 16:16:37 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: jlayton@kernel.org,
	chuck.lever@oracle.com,
	alex.aring@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	arnd@arndb.de,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: jkoolstra@xs4all.nl
Subject: [PATCH] Add support for empty path in openat and openat2 syscalls
Date: Mon, 23 Feb 2026 16:16:52 +0100
Message-ID: <20260223151652.582048-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[xs4all.nl,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[xs4all.nl:s=xs4all01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-77969-lists,linux-fsdevel=lfdr.de];
	TO_DN_NONE(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,oracle.com,gmail.com,zeniv.linux.org.uk,suse.cz,arndb.de,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[xs4all.nl];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[jkoolstra@xs4all.nl,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[xs4all.nl:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,xs4all.nl:mid,xs4all.nl:dkim,xs4all.nl:email]
X-Rspamd-Queue-Id: 9A5D61789F6
X-Rspamd-Action: no action

To get an operable version of an O_PATH file descriptors, it is possible
to use openat(fd, ".", O_DIRECTORY) for directories, but other files
currently require going through open("/proc/<pid>/fd/<nr>") which
depends on a functioning procfs.

This patch adds the O_EMPTY_PATH flag to openat and openat2. If passed
LOOKUP_EMPTY is set at path resolve time.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/fcntl.c                       | 2 +-
 fs/open.c                        | 6 ++++--
 include/linux/fcntl.h            | 2 +-
 include/uapi/asm-generic/fcntl.h | 4 ++++
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index f93dbca08435..62ab4ad2b6f5 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -1169,7 +1169,7 @@ static int __init fcntl_init(void)
 	 * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
 	 * is defined as O_NONBLOCK on some platforms and not on others.
 	 */
-	BUILD_BUG_ON(20 - 1 /* for O_RDONLY being 0 */ !=
+	BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=
 		HWEIGHT32(
 			(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
 			__FMODE_EXEC));
diff --git a/fs/open.c b/fs/open.c
index 91f1139591ab..32865822ca1c 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1160,7 +1160,7 @@ struct file *kernel_file_open(const struct path *path, int flags,
 EXPORT_SYMBOL_GPL(kernel_file_open);
 
 #define WILL_CREATE(flags)	(flags & (O_CREAT | __O_TMPFILE))
-#define O_PATH_FLAGS		(O_DIRECTORY | O_NOFOLLOW | O_PATH | O_CLOEXEC)
+#define O_PATH_FLAGS		(O_DIRECTORY | O_NOFOLLOW | O_PATH | O_CLOEXEC | O_EMPTY_PATH)
 
 inline struct open_how build_open_how(int flags, umode_t mode)
 {
@@ -1277,6 +1277,8 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 		}
 	}
 
+	if (flags & O_EMPTY_PATH)
+		lookup_flags |= LOOKUP_EMPTY;
 	if (flags & O_DIRECTORY)
 		lookup_flags |= LOOKUP_DIRECTORY;
 	if (!(flags & O_NOFOLLOW))
@@ -1362,7 +1364,7 @@ static int do_sys_openat2(int dfd, const char __user *filename,
 	if (unlikely(err))
 		return err;
 
-	CLASS(filename, name)(filename);
+	CLASS(filename_flags, name)(filename, op.lookup_flags);
 	return FD_ADD(how->flags, do_file_open(dfd, name, &op));
 }
 
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index a332e79b3207..ce742f67bf60 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -10,7 +10,7 @@
 	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | \
 	 O_APPEND | O_NDELAY | O_NONBLOCK | __O_SYNC | O_DSYNC | \
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
-	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
+	 O_NOATIME | O_CLOEXEC | O_PATH | O_EMPTY_PATH | __O_TMPFILE)
 
 /* List of all valid flags for the how->resolve argument: */
 #define VALID_RESOLVE_FLAGS \
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 613475285643..8e4e796ad212 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -88,6 +88,10 @@
 #define __O_TMPFILE	020000000
 #endif
 
+#ifndef O_EMPTY_PATH
+#define O_EMPTY_PATH	0100000000
+#endif
+
 /* a horrid kludge trying to make sure that this will fail on old kernels */
 #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
 
-- 
2.53.0


