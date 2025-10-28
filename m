Return-Path: <linux-fsdevel+bounces-65885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22261C139A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 09:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 745721AA5672
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 08:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0567C2D9ECB;
	Tue, 28 Oct 2025 08:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVVK8yJB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E1C2D978C;
	Tue, 28 Oct 2025 08:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761641184; cv=none; b=dO6UP0ldbWUhXdG14pmYmzl2mgK8dsTETfMuxRNNK3UUKOZnDJOPnSbC8633LnFvydIpJ8K54Qr+gHjsYVRiCG+Ziq1XWM3DpNt8Q1+WGHRIHTAeEpHRCiMRYiDI14XQSQVuwN1QFu18zcKJy4cTfM43oaVje+IBwc/MTJ6YPdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761641184; c=relaxed/simple;
	bh=5bvn5pDHWFfYoNTwh3Tkn+1Oem0Xb9reqUBXveK/Isw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qdvolf+VAlBR4vG/z9sa+TirQapdpToX+2SzzOOX08+OmkcpvRQM68KjvCDsSiTcjACQjKoSEKF2K83gpU9FtCXxLhDMZIicrWMO74s1C154wxKC8H3PZwonYNR2TAtcVSI6HgJ4h56OrDChsZIYuzJFtR9nLVVCAERnVIaiOYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVVK8yJB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6392DC4CEE7;
	Tue, 28 Oct 2025 08:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761641183;
	bh=5bvn5pDHWFfYoNTwh3Tkn+1Oem0Xb9reqUBXveK/Isw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lVVK8yJBAk5tACBhO5qZTavS4Uu+uKeSsytmdXGlq15nzndR4bO5IGbmw1WhAyxlI
	 VTpTzjFfPtWgTY1fxyqskyRCqwnQTtH724Ml0aGQQIuPDHBLFRNWnEyt3EkKnAYFz+
	 s81YwaLZd8TOY/d7c9b7fcc3TWNDfEmGe1xCbAlmnoY027HUI8jGTzXQIw5s2361UR
	 h0CgJhz7Yx5uvQfRsFCR5A+yQ71Z5pd700EuCStFBmTfGisCFYM4akJVEnBPbezBLK
	 CzgMphXmoCf2A0AS4PcZ036TR+pIdK04kciyMj47rBTpHvPJq5bKwc1Ixh5gYHcBpe
	 G3kuJJC0dtRxA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 28 Oct 2025 09:45:50 +0100
Subject: [PATCH 05/22] pidfd: add a new supported_mask field
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-work-coredump-signal-v1-5-ca449b7b7aa0@kernel.org>
References: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org>
In-Reply-To: <20251028-work-coredump-signal-v1-0-ca449b7b7aa0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>, Amir Goldstein <amir73il@gmail.com>, 
 Aleksa Sarai <cyphar@cyphar.com>, 
 Yu Watanabe <watanabe.yu+github@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Jann Horn <jannh@google.com>, Luca Boccassi <luca.boccassi@gmail.com>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, 
 Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=3362; i=brauner@kernel.org;
 h=from:subject:message-id; bh=5bvn5pDHWFfYoNTwh3Tkn+1Oem0Xb9reqUBXveK/Isw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQyNB1c2vvWVWDb1UilqctLtXQnJrl3vX6ynE210nFmX
 Fa13P7ejlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkofmT4H7Qp/86MSz+lJAIF
 wvL+v5p12SdrmrSWGrvh1s23F6Zn8jH8r5Xjy6iqb3yZx2p+Uv2a9m3hkJRy73C99ZENM4x7I4q
 5AQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Some of the future fields in struct pidfd_info can be optional. If the
kernel has nothing to emit in that field, then it doesn't set the flag
in the reply. This presents a problem: There is currently no way to know
what mask flags the kernel supports since one can't always count on them
being in the reply.

Add a new PIDFD_INFO_SUPPORTED_MASK flag and field that the kernel can
set in the reply. Userspace can use this to determine if the fields it
requires from the kernel are supported. This also gives us a way to
deprecate fields in the future, if that should become necessary.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c                 | 17 ++++++++++++++++-
 include/uapi/linux/pidfd.h |  3 +++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 7e4d90cc74ff..204ebd32791a 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -293,6 +293,14 @@ static __u32 pidfs_coredump_mask(unsigned long mm_flags)
 	return 0;
 }
 
+/* This must be updated whenever a new flag is added */
+#define PIDFD_INFO_SUPPORTED (PIDFD_INFO_PID | \
+			      PIDFD_INFO_CREDS | \
+			      PIDFD_INFO_CGROUPID | \
+			      PIDFD_INFO_EXIT | \
+			      PIDFD_INFO_COREDUMP | \
+			      PIDFD_INFO_SUPPORTED_MASK)
+
 static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct pidfd_info __user *uinfo = (struct pidfd_info __user *)arg;
@@ -306,7 +314,7 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 	const struct cred *c;
 	__u64 mask;
 
-	BUILD_BUG_ON(sizeof(struct pidfd_info) != PIDFD_INFO_SIZE_VER1);
+	BUILD_BUG_ON(sizeof(struct pidfd_info) != PIDFD_INFO_SIZE_VER2);
 
 	if (!uinfo)
 		return -EINVAL;
@@ -412,6 +420,13 @@ static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 		return -ESRCH;
 
 copy_out:
+	if (mask & PIDFD_INFO_SUPPORTED_MASK) {
+		kinfo.mask |= PIDFD_INFO_SUPPORTED_MASK;
+		kinfo.supported_mask = PIDFD_INFO_SUPPORTED;
+	}
+
+	/* Are there bits in the return mask not present in PIDFD_INFO_SUPPORTED? */
+	WARN_ON_ONCE(~PIDFD_INFO_SUPPORTED & kinfo.mask);
 	/*
 	 * If userspace and the kernel have the same struct size it can just
 	 * be copied. If userspace provides an older struct, only the bits that
diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
index 6ccbabd9a68d..e05caa0e00fe 100644
--- a/include/uapi/linux/pidfd.h
+++ b/include/uapi/linux/pidfd.h
@@ -26,9 +26,11 @@
 #define PIDFD_INFO_CGROUPID		(1UL << 2) /* Always returned if available, even if not requested */
 #define PIDFD_INFO_EXIT			(1UL << 3) /* Only returned if requested. */
 #define PIDFD_INFO_COREDUMP		(1UL << 4) /* Only returned if requested. */
+#define PIDFD_INFO_SUPPORTED_MASK	(1UL << 5) /* Want/got supported mask flags */
 
 #define PIDFD_INFO_SIZE_VER0		64 /* sizeof first published struct */
 #define PIDFD_INFO_SIZE_VER1		72 /* sizeof second published struct */
+#define PIDFD_INFO_SIZE_VER2		80 /* sizeof third published struct */
 
 /*
  * Values for @coredump_mask in pidfd_info.
@@ -94,6 +96,7 @@ struct pidfd_info {
 	__s32 exit_code;
 	__u32 coredump_mask;
 	__u32 __spare1;
+	__u64 supported_mask;	/* Mask flags that this kernel supports */
 };
 
 #define PIDFS_IOCTL_MAGIC 0xFF

-- 
2.47.3


