Return-Path: <linux-fsdevel+bounces-62186-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A71CFB87A77
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 04:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 520CA3B9DAD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 02:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B932580FB;
	Fri, 19 Sep 2025 02:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="zSTJe/nc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720D0258ED6;
	Fri, 19 Sep 2025 02:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758247213; cv=none; b=VPtek00abHZHsuXRDIk0puyCo4oBa2fSv5r5Cg+tYc0Cy3bwlZ0UBEZu3Y7ybTvAsr3KOexms5GbLJ60KUawy3of8PxCrh/UxsoXKFel0Laognla36RCddrsf3Hgl0Xe4hwF/ZUI3bNlnXOpS8Jams2aWg+zmNXvkCH7Z9P7lLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758247213; c=relaxed/simple;
	bh=0foHFKsVISgRDKCD5chs3frnytAecaOPF/iJXka2vNU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DnzGpduVOux6CJGxI4TIM2Jl1/MwYbV5DHE6od5pVH+zUpLwNk4mkgJ72Eh5rv3/YAG1WxkNDK7pwImhsaX30G6W0uS6RMOjGgRa1sNFFmHRLDOJymBF9BgeCW18J8vId3tdeIvPiQQy2ePAWGSML8KaPiJSjoce5mnZGoDzqwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=zSTJe/nc; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4cSbLH41qHz9sjJ;
	Fri, 19 Sep 2025 04:00:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1758247207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l26kFBE6hyGWioTfsXgOOyNO21cgB9nDi07HYHTYlmQ=;
	b=zSTJe/ncq8LYrMKyPYbol2AecKZyGDmj1P9mMpvlj39CkgSBwlPNTXBNSCI1MLEPKXQYsV
	WuXSCJ2v9D9uCqYnOyM/Ie0yfeMartCn7l0Rqt43Z27wRBs9jgH3OgDdgNNI7WiTx5YE/7
	Gg7HoDCYa4V9evkPQbyGVO7w7AX4F6nZCKDNZi2ysFvRafujUD/DJCxDlhm4i4KF6B9wPD
	dUiNz1X3SMWxM8jSdbdJLERyFeD/hwCKZtTfP8LiImBtiFvhSal4hr48dAn2RO2uRXNg0G
	5vdo/vNtOGh3aePykE5d08f7J7ahSG+czF6kwfonJYd1klXtiXBkmmLbfG9UOA==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Fri, 19 Sep 2025 11:59:42 +1000
Subject: [PATCH v4 01/10] man/man2/mount_setattr.2: move mount_attr struct
 to mount_attr(2type)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-new-mount-api-v4-1-1261201ab562@cyphar.com>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
In-Reply-To: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Askar Safin <safinaskar@zohomail.com>, 
 "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
 linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3215; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=0foHFKsVISgRDKCD5chs3frnytAecaOPF/iJXka2vNU=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWSc2Smadrrj9RVfG5YHnxtesH7Qkp0712L6kquVgn1NG
 cfM3Lbs7ZjIwiDGxWAppsiyzc8zdNP8xVeSP61kg5nDygQyRFqkgYGBgYGFgS83Ma/USMdIz1Tb
 UM/QUMdIx4iBi1MApjpanJHhy/uLd2b/v/Wsz557UovzifVrDf1+7Jhuo+zHyPAltXjKUobfLKs
 tTz/UmLrjrIYxz/vkgrQrh003nllQp/p+Z9K3+SZWnAA=
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

As with open_how(2type), it makes sense to move this to a separate man
page.  In addition, future man pages added in this patchset will want to
reference mount_attr(2type).

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 man/man2/mount_setattr.2      | 17 ++++--------
 man/man2type/mount_attr.2type | 61 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 12 deletions(-)

diff --git a/man/man2/mount_setattr.2 b/man/man2/mount_setattr.2
index 586633f48e894bf8f2823aa7755c96adcddea6a6..4b55f6d2e09d00d9bc4b3a085f310b1b459f34e8 100644
--- a/man/man2/mount_setattr.2
+++ b/man/man2/mount_setattr.2
@@ -114,18 +114,11 @@ .SH DESCRIPTION
 .I attr
 argument of
 .BR mount_setattr ()
-is a structure of the following form:
-.P
-.in +4n
-.EX
-struct mount_attr {
-    __u64 attr_set;     /* Mount properties to set */
-    __u64 attr_clr;     /* Mount properties to clear */
-    __u64 propagation;  /* Mount propagation type */
-    __u64 userns_fd;    /* User namespace file descriptor */
-};
-.EE
-.in
+is a pointer to a
+.I mount_attr
+structure,
+described in
+.BR mount_attr (2type).
 .P
 The
 .I attr_set
diff --git a/man/man2type/mount_attr.2type b/man/man2type/mount_attr.2type
new file mode 100644
index 0000000000000000000000000000000000000000..f5c4f48be46ec1e6c0d3a211b6724a1e95311a41
--- /dev/null
+++ b/man/man2type/mount_attr.2type
@@ -0,0 +1,61 @@
+.\" Copyright, the authors of the Linux man-pages project
+.\"
+.\" SPDX-License-Identifier: Linux-man-pages-copyleft
+.\"
+.TH mount_attr 2type (date) "Linux man-pages (unreleased)"
+.SH NAME
+mount_attr \- what mount properties to set and clear
+.SH LIBRARY
+Linux kernel headers
+.SH SYNOPSIS
+.EX
+.B #include <sys/mount.h>
+.P
+.B struct mount_attr {
+.BR "    u64 attr_set;" "     /* Mount properties to set */"
+.BR "    u64 attr_clr;" "     /* Mount properties to clear */"
+.BR "    u64 propagation;" "  /* Mount propagation type */"
+.BR "    u64 userns_fd;" "    /* User namespace file descriptor */"
+    /* ... */
+.B };
+.EE
+.SH DESCRIPTION
+Specifies which mount properties should be changed with
+.BR mount_setattr (2).
+.P
+The fields are as follows:
+.TP
+.I .attr_set
+This field specifies which
+.BI MOUNT_ATTR_ *
+attribute flags to set.
+.TP
+.I .attr_clr
+This field specifies which
+.BI MOUNT_ATTR_ *
+attribute flags to clear.
+.TP
+.I .propagation
+This field specifies what mount propagation will be applied.
+The valid values of this field are the same propagation types described in
+.BR mount_namespaces (7).
+.TP
+.I .userns_fd
+This field specifies a file descriptor that indicates which user namespace to
+use as a reference for ID-mapped mounts with
+.BR MOUNT_ATTR_IDMAP .
+.SH STANDARDS
+Linux.
+.SH HISTORY
+Linux 5.12.
+.\" commit 2a1867219c7b27f928e2545782b86daaf9ad50bd
+glibc 2.36.
+.P
+Extra fields may be appended to the structure,
+with a zero value in a new field resulting in
+the kernel behaving as though that extension field was not present.
+Therefore, a user
+.I must
+zero-fill this structure on initialization.
+.SH SEE ALSO
+.BR mount_setattr (2)

-- 
2.51.0


