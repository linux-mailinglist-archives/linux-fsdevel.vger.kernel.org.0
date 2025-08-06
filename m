Return-Path: <linux-fsdevel+bounces-56861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3D8B1CB3E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 19:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E663BA640
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 17:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783242BD03D;
	Wed,  6 Aug 2025 17:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="ShbUj0+j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F73329CB58;
	Wed,  6 Aug 2025 17:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754502305; cv=none; b=KGnjX9DOCAPcZpM3ixwDe4UJ3H1Wr5fRILBd7fEI2bQXMoi8fUYTUXVcdhjvZJnUtsLDlgrtOysEHqw+UrVD/QXc50oMKhlhIdTVPJTs8/tK0LYPu5+S99m2gT1MvLrm2nvYTYC8MxGDOv/wr2efleiMtWyhUoDxiH1fBTeW0RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754502305; c=relaxed/simple;
	bh=8DPMg3YdXXlcxIrWJ1hq+5y1fTKw/qmcyDBJf8cL2Fg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LHDMAqxNpw+OuuLm6YKOw98XAdu1U6UyAWLmjwHM6YydaFevHSOx8bfNuTLVhyxk0XJ8uqYNntjTxkxJEWzMkBjzpBO7YTy1dKSuDvPFP6I8xjCA4HK9t54kezlNCp3GFB81+RCYqqpaqk75GIpMoX1RW7eFsF0bTI8Fr1Yv9k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=ShbUj0+j; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bxyNr5QmZz9tHN;
	Wed,  6 Aug 2025 19:45:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754502300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VlFKUKsClHvae08VDfYFxp2k8jZdmsu6fCRZQ1cGOHc=;
	b=ShbUj0+j0vj4MOBNbPQoIw9uYb1+LCmMqURHP19joNM7jC4L9O6cbwL7kwrxhbCC7vvrWj
	/3CgsVrjo5s8ScgApEEteErIFI60QchTTO6RXfnapuyrRDaT9E7z0tBN4o6aghR7e9kVmv
	V6XmaaUpOlwcC2V6HtY7CH3uD8fPeeruAtH2ump/kDPmbkvWreWKo1ySzU7VK/sH175Wad
	AquVmjtNa70ZDTF0s2qq7jHk2q9prITz877QKSjZUP9BpN7IelHjr00ZOy2dMoT8BMGuQ4
	0Fv2WsAPd97Sh1uSmo1IkufzCOcpakdrR61ts1Re28O0FfayZodXt3jIv1Mn8A==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Thu, 07 Aug 2025 03:44:36 +1000
Subject: [PATCH v2 02/11] mount_setattr.2: move mount_attr struct to
 mount_attr.2type
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-new-mount-api-v2-2-558a27b8068c@cyphar.com>
References: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com>
In-Reply-To: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Askar Safin <safinaskar@zohomail.com>, 
 "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
 linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3031; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=8DPMg3YdXXlcxIrWJ1hq+5y1fTKw/qmcyDBJf8cL2Fg=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRMntLWzJyTMk3I40f737q2GwInzlopZCpu/5OdJHtLc
 lF19sGsjlIWBjEuBlkxRZZtfp6hm+YvvpL8aSUbzBxWJpAhDFycAjARKSFGhsk/PlbKm8/Ntzu/
 bO03c8Vly43aLkc5sBi82pPUpV/Upc3wi2lL8n//7zteTNt34ESmbZd5Wbx9XvTP1v7p9zd+ncC
 zmhMA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

As with open_how(2type), it makes sense to move this to a separate man
page.  In addition, future man pages added in this patchset will want to
reference mount_attr(2type).

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 man/man2/mount_setattr.2      | 17 ++++---------
 man/man2type/mount_attr.2type | 58 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 12 deletions(-)

diff --git a/man/man2/mount_setattr.2 b/man/man2/mount_setattr.2
index c96f0657f046..d44fafc93a20 100644
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
index 000000000000..b7a3ace6b3b9
--- /dev/null
+++ b/man/man2type/mount_attr.2type
@@ -0,0 +1,58 @@
+
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
+.BR "    __u64 attr_set;" "     /* Mount properties to set */"
+.BR "    __u64 attr_clr;" "     /* Mount properties to clear */"
+.BR "    __u64 propagation;" "  /* Mount propagation type */"
+.BR "    __u64 userns_fd;" "    /* User namespace file descriptor */"
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
+This fields specifies which
+.BI MOUNT_ATTR_ *
+attribute flags to clear.
+.TP
+.I .propagation
+This field specifies what mount propagation will be applied.
+The valid values of this field are the same propagation types described in
+.BR mount_namespaces (7).
+.TP
+.I .userns_fd
+This fields specifies a file descriptor that indicates which user namespace to
+use as a reference for ID-mapped mounts with
+.BR MOUNT_ATTR_IDMAP .
+.SH VERSIONS
+Extra fields may be appended to the structure,
+with a zero value in a new field resulting in
+the kernel behaving as though that extension field was not present.
+Therefore, a user
+.I must
+zero-fill this structure on initialization.
+.SH STANDARDS
+Linux.
+.SH SEE ALSO
+.BR mount_setattr (2)

-- 
2.50.1


