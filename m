Return-Path: <linux-fsdevel+bounces-54244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9BF2AFCBC6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 15:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADDE83A6389
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 13:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4632E2DC32E;
	Tue,  8 Jul 2025 13:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="JRsgXRez"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8008215F6C;
	Tue,  8 Jul 2025 13:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980938; cv=none; b=t3591crjQY2wWVstvToiLGrrEYy+q5F5HJ9Udmhgigs5yhXybRk2p2nY+YvQ5hPZTLa34H067ULHpvsuA8cvyvPQ9voMVu7yIcV8DfKnyLUKHzhdZslsL4v+Se9Oth0y3iiSyW/c5VY2R9s+fkKRwz4MeCZn1R9kPt9H3/n8yX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980938; c=relaxed/simple;
	bh=Et+QSwwJrfokDLvMmKeuMgFeMSBuywiC/GR3rgxX5eY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JUBBJZy5neCmbnjbUMG970MLW13MGJ4w6wmJ0APkYICg/2TRv2iUpLPNRUwISjNsrl4Fh0TRVskv5EwnKSEB1RuYvubnN+4MoZaOQ7VKJzPxycMGbOcWTm1ePDJGZx6uxMF1hdjT4qyfzmMtlq/nxo6/N/WPcVQkzTsi/4RGnMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=JRsgXRez; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bc1x04WFXz9tDq;
	Tue,  8 Jul 2025 15:22:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1751980932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5wp1NxkC5MDj7tCsOv6NJvGRhBxexqsejX9b5t8bGnI=;
	b=JRsgXRezT3rCzZETwYUseY95mRP0oxo8RM7AZGxGq1e5xCG7cHWtzAGozRdQEjbDEzL8W8
	oX2qm0AfuzaFszCNThfoX6TEmIfoy6ofQboDn1KXpEVpEi/Lsc+QxKJNiwL+3ysP+mnG8r
	qdrY18OTlPrJIrUl5t0QJNIYduzBEEvEVZNEJ9A2DCOg4ss67+cQgFfVztPwldJJATDG7q
	rgAw7rdJ1nMv9XjGfFYYYOkKeCYHe1V3dLKfKGZZMWLWJT73IIrinoxGPXGsoiFF11Jki+
	F8p4bVdaK/lH90c/jgoR0bcXIsnWPDgaJR3KqtzMqXmXaOeU8hZbk/DTlPI6GA==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Tue, 08 Jul 2025 23:21:51 +1000
Subject: [PATCH] uapi: export PROCFS_ROOT_INO
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-uapi-procfs-root-ino-v1-1-6ae61e97c79b@cyphar.com>
X-B4-Tracking: v=1; b=H4sIAG4bbWgC/x3MPQqAMAxA4atIZgNV8Pcq4hBs1CxNSVUE8e4Wx
 29474HEJpxgLB4wviSJhoyqLGDZKWyM4rOhdnXjOtfjSVEwmi5rQlM9UIIiVb3zzUADtR5yGo1
 Xuf/tNL/vB29v9fFmAAAA
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3296; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=Et+QSwwJrfokDLvMmKeuMgFeMSBuywiC/GR3rgxX5eY=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWTkStdZT/t0U59d5kJHbGtKNsv9xcIr3d+9YE+OqjMxq
 xaRedPVUcrCIMbFICumyLLNzzN00/zFV5I/rWSDmcPKBDKEgYtTACay7Ssjw1XZD3Pfbl9yc0VM
 2v1Z/hMlAjpfVLPey7pQ2Cvmc/H811pGhg1Lot8wbNZ8sqPIaTkv3y0/FYOP9U3f5uY33Q787rb
 AiB8A
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

The root inode of /proc having a fixed inode number has been part of the
core kernel ABI since its inception, and recently some userspace
programs (mainly container runtimes) have started to explicitly depend
on this behaviour.

The main reason this is useful to userspace is that by checking that a
suspect /proc handle has fstype PROC_SUPER_MAGIC and is PROCFS_ROOT_INO,
they can then use openat2(RESOLVE_{NO_{XDEV,MAGICLINK},BENEATH}) to
ensure that there isn't a bind-mount that replaces some procfs file with
a different one. This kind of attack has lead to security issues in
container runtimes in the past (such as CVE-2019-19921) and libraries
like libpathrs[1] use this feature of procfs to provide safe procfs
handling functions.

There was also some trailing whitespace in the "struct proc_dir_entry"
initialiser, so fix that up as well.

[1]: https://github.com/openSUSE/libpathrs

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 fs/proc/root.c          | 10 +++++-----
 include/linux/proc_ns.h |  1 -
 include/uapi/linux/fs.h | 11 +++++++++++
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/proc/root.c b/fs/proc/root.c
index 06a297a27ba3..ed86ac710384 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -363,12 +363,12 @@ static const struct inode_operations proc_root_inode_operations = {
  * This is the root "inode" in the /proc tree..
  */
 struct proc_dir_entry proc_root = {
-	.low_ino	= PROC_ROOT_INO, 
-	.namelen	= 5, 
-	.mode		= S_IFDIR | S_IRUGO | S_IXUGO, 
-	.nlink		= 2, 
+	.low_ino	= PROCFS_ROOT_INO,
+	.namelen	= 5,
+	.mode		= S_IFDIR | S_IRUGO | S_IXUGO,
+	.nlink		= 2,
 	.refcnt		= REFCOUNT_INIT(1),
-	.proc_iops	= &proc_root_inode_operations, 
+	.proc_iops	= &proc_root_inode_operations,
 	.proc_dir_ops	= &proc_root_operations,
 	.parent		= &proc_root,
 	.subdir		= RB_ROOT,
diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
index 6258455e49a4..4b20375f3783 100644
--- a/include/linux/proc_ns.h
+++ b/include/linux/proc_ns.h
@@ -40,7 +40,6 @@ extern const struct proc_ns_operations timens_for_children_operations;
  * We always define these enumerators
  */
 enum {
-	PROC_ROOT_INO		= 1,
 	PROC_IPC_INIT_INO	= IPC_NS_INIT_INO,
 	PROC_UTS_INIT_INO	= UTS_NS_INIT_INO,
 	PROC_USER_INIT_INO	= USER_NS_INIT_INO,
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 3d7bb6580cfb..0bd678a4a10e 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -60,6 +60,17 @@
 #define RENAME_EXCHANGE		(1 << 1)	/* Exchange source and dest */
 #define RENAME_WHITEOUT		(1 << 2)	/* Whiteout source */
 
+/*
+ * The root inode of procfs is guaranteed to always have the same inode number.
+ * For programs that make heavy use of procfs, verifying that the root is a
+ * real procfs root and using openat2(RESOLVE_{NO_{XDEV,MAGICLINKS},BENEATH})
+ * will allow you to make sure you are never tricked into operating on the
+ * wrong procfs file.
+ */
+enum procfs_ino {
+	PROCFS_ROOT_INO = 1,
+};
+
 struct file_clone_range {
 	__s64 src_fd;
 	__u64 src_offset;

---
base-commit: 40e87bc3b0e06018c908c338b73268ca12e28d89
change-id: 20250708-uapi-procfs-root-ino-a180d59a9a6d

Best regards,
-- 
Aleksa Sarai <cyphar@cyphar.com>


