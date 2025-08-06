Return-Path: <linux-fsdevel+bounces-56860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E879BB1CB3C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 19:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29BDD7A6EFB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 17:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228D329E0EA;
	Wed,  6 Aug 2025 17:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="hDNFYPJw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981E02BCF4F;
	Wed,  6 Aug 2025 17:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754502305; cv=none; b=HwI//g1r5c3N6wwVbFoAprQRBOCpaA7TWn1gSsPLa+wIG4ugHBLHmC+9yyWPUn4tonS+kk79P29eGk18GKtW0vjCxY2nP2g10C5lGUH6/E5VTDtTeAs9OAe2DpsyPd4eA12ylyioJ0L+ZP4wBgaJryGQZYtzHEHwpE+FW5n2Vhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754502305; c=relaxed/simple;
	bh=13kudgbKXbJx4krYwEelfDLkJuG6/PIQ2nEiAbfcm3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nBqHvW6zZQeMoy9x2iQQNxxkXU4Uvwt1hPbyupkPuYghM4I+PLAlXgFmqOjZTwZcSAPgc+4INld2sw6Lz0HafcwgEEHSDMDe1Rvv+gmNiIXaJOYetJVUG+yIeHYdSN7raw1WwpkuSHaTEi5ockKzQ8NxLqT+AE/paZJcMajoTJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=hDNFYPJw; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bxyNk5dp5z9tGx;
	Wed,  6 Aug 2025 19:44:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754502294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zBmcpHxiLObUdOrrVuAKzBG2uoCjEctpjRwfJ7cGgFw=;
	b=hDNFYPJwluKDqZKsRVVNaREcdnJb3G9aaNBq2Ulfue3pZ5bIObEndJLg+wu5CQky/5aGj4
	1QlAGneSv92u6dHyklEPKbdNVpCFcP/EHDb6uV0jqJtR5dYe2AY58tizkqOWLcjhuIGsbm
	sBRaLs3E8vV+nrJYCWhgmNBa5Dnaa5EwJUv3ij/85okYWABKNEmeo9EPG49qNCr33dHixb
	/1fBFHk6WiJIUcw3RF/rIggVdOPDdlqs1IFH3RPyQnO1xXvfoupn2o2JZqMrrq/tmt9HcM
	6iafaPtNbhq4V6rIwCfEYyamsCwr+C81brbD+HlTGJ4b1IYOFS083fD+0lIoQA==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Thu, 07 Aug 2025 03:44:35 +1000
Subject: [PATCH v2 01/11] mount_setattr.2: document glibc >= 2.36 syscall
 wrappers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-new-mount-api-v2-1-558a27b8068c@cyphar.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2998; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=13kudgbKXbJx4krYwEelfDLkJuG6/PIQ2nEiAbfcm3w=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRMntKm9bV7YXR+tJ5u8ENz4fsHtNg406Mmrq1/miak/
 2DCcYHkjlIWBjEuBlkxRZZtfp6hm+YvvpL8aSUbzBxWJpAhDFycAjCRh4EM/7MyztX/q2GZ2JCw
 bfvvyrLPi6dLHqr+keS5gi+I63s312OG/1X6F6PWOjB+ZmNM3MHLyWzy+v+bqEVvGyyWGteGL01
 fzw8A
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

Glibc 2.36 added syscall wrappers for the entire family of fd-based
mount syscalls, including mount_setattr(2).  Thus it's no longer
necessary to instruct users to do raw syscall(2) operations.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 man/man2/mount_setattr.2 | 45 +++++++--------------------------------------
 1 file changed, 7 insertions(+), 38 deletions(-)

diff --git a/man/man2/mount_setattr.2 b/man/man2/mount_setattr.2
index 60d9cf9de8aa..c96f0657f046 100644
--- a/man/man2/mount_setattr.2
+++ b/man/man2/mount_setattr.2
@@ -10,21 +10,12 @@ .SH LIBRARY
 .RI ( libc ,\~ \-lc )
 .SH SYNOPSIS
 .nf
-.BR "#include <linux/fcntl.h>" " /* Definition of " AT_* " constants */"
-.BR "#include <linux/mount.h>" " /* Definition of " MOUNT_ATTR_* " constants */"
-.BR "#include <sys/syscall.h>" " /* Definition of " SYS_* " constants */"
-.B #include <unistd.h>
+.BR "#include <fcntl.h>" "       /* Definition of " AT_* " constants */"
+.B #include <sys/mount.h>
 .P
-.BI "int syscall(SYS_mount_setattr, int " dirfd ", const char *" path ,
-.BI "            unsigned int " flags ", struct mount_attr *" attr \
-", size_t " size );
+.BI "int mount_setattr(int " dirfd ", const char *" path ", unsigned int " flags ","
+.BI "                  struct mount_attr *" attr ", size_t " size );"
 .fi
-.P
-.IR Note :
-glibc provides no wrapper for
-.BR mount_setattr (),
-necessitating the use of
-.BR syscall (2).
 .SH DESCRIPTION
 The
 .BR mount_setattr ()
@@ -586,6 +577,7 @@ .SH HISTORY
 .\" commit 7d6beb71da3cc033649d641e1e608713b8220290
 .\" commit 2a1867219c7b27f928e2545782b86daaf9ad50bd
 .\" commit 9caccd41541a6f7d6279928d9f971f6642c361af
+glibc 2.36.
 .SH NOTES
 .SS ID-mapped mounts
 Creating an ID-mapped mount makes it possible to
@@ -914,37 +906,14 @@ .SH EXAMPLES
 #include <err.h>
 #include <fcntl.h>
 #include <getopt.h>
-#include <linux/mount.h>
-#include <linux/types.h>
+#include <sys/mount.h>
+#include <sys/types.h>
 #include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/syscall.h>
 #include <unistd.h>
 \&
-static inline int
-mount_setattr(int dirfd, const char *path, unsigned int flags,
-              struct mount_attr *attr, size_t size)
-{
-    return syscall(SYS_mount_setattr, dirfd, path, flags,
-                   attr, size);
-}
-\&
-static inline int
-open_tree(int dirfd, const char *filename, unsigned int flags)
-{
-    return syscall(SYS_open_tree, dirfd, filename, flags);
-}
-\&
-static inline int
-move_mount(int from_dirfd, const char *from_path,
-           int to_dirfd, const char *to_path, unsigned int flags)
-{
-    return syscall(SYS_move_mount, from_dirfd, from_path,
-                   to_dirfd, to_path, flags);
-}
-\&
 static const struct option longopts[] = {
     {"map\-mount",       required_argument,  NULL,  \[aq]a\[aq]},
     {"recursive",       no_argument,        NULL,  \[aq]b\[aq]},

-- 
2.50.1


