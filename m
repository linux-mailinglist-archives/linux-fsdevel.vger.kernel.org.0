Return-Path: <linux-fsdevel+bounces-39603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F11FA160F2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 10:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BD993A6574
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 09:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C00F199230;
	Sun, 19 Jan 2025 09:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="g9A+r+Yw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B077FD
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Jan 2025 09:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737277503; cv=none; b=LdU6ARWnmLPI+G6tfrBzOhQYWDTPwQ07nLZ76CrthD3DrxejRpK9P5n9I5HsvWn9R6osw6um4jB9NxeZNJmFDLWlfdme0BdklNo1pWEsfX6WEnqDIk7NPpFSOnBRMQ5Nj4qNjkVsxL9Q/Ct9Ozti3mQTly+zWAskoCWWiWDbYjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737277503; c=relaxed/simple;
	bh=Y3xlmqJ8rh40wYl7hluAI4J3XxtB6u3Y5hoVzG/HBRI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qhxhrpg7OO6eNx0tm2GB7EWS8N4HHAMgDAoaImx8wJArszwI/BmGB2W9m247x5jw8V9N6uiWzovoUAYsLqWcwXXH9P1rDIyC16hPi8J/Lbg5uNaVEVlHvENzceE7EgjqaZmciQP7pNcaraSG6/RXYzO1Z/kHx0VoGq+YsXT6nQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=g9A+r+Yw; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1737277501; x=1768813501;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yZ65wDVhGjkZ07wLFVLVoKIh5k7PTI8V2u9PFcah/NY=;
  b=g9A+r+YwRfC4bIxiaSQqqYd0Zl2MXUU4J2xnGDz+mN6lqyFbgRvFOc2d
   t4pT9VT8z0n9Gqo8LDJlsWCd17V5WGyTgvdV5NtOnSqAJ/CB9RfMyhz/P
   MpXJqyThKMY1bldVoJ2EQWZugZjDH7AW8JChRyx8Fwnpdl24GmCZJoouk
   0=;
X-IronPort-AV: E=Sophos;i="6.13,216,1732579200"; 
   d="scan'208";a="15432383"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2025 09:05:00 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:2603]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.114:2525] with esmtp (Farcaster)
 id 9bce8b0e-1066-43cb-bb60-58b1de86b0f2; Sun, 19 Jan 2025 09:04:59 +0000 (UTC)
X-Farcaster-Flow-ID: 9bce8b0e-1066-43cb-bb60-58b1de86b0f2
Received: from EX19D002AND002.ant.amazon.com (10.37.240.241) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sun, 19 Jan 2025 09:04:57 +0000
Received: from HND-5CG1082HRX.ant.amazon.com (10.37.244.8) by
 EX19D002AND002.ant.amazon.com (10.37.240.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sun, 19 Jan 2025 09:04:53 +0000
From: Yuichiro Tsuji <yuichtsu@amazon.com>
To: <linux-fsdevel@vger.kernel.org>
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Yuichiro Tsuji <yuichtsu@amazon.com>
Subject: [PATCH v1 vfs 2/2] ioctl: Fix return type of several functions from long to int
Date: Sun, 19 Jan 2025 18:02:49 +0900
Message-ID: <20250119090322.2598-3-yuichtsu@amazon.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250119090322.2598-1-yuichtsu@amazon.com>
References: <20250119090322.2598-1-yuichtsu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB002.ant.amazon.com (10.13.139.188) To
 EX19D002AND002.ant.amazon.com (10.37.240.241)

Fix the return type of several functions from long to int to match its actu
al behavior. These functions only return int values. This change improves
type consistency across the filesystem code and aligns the function signatu
re with its existing implementation and usage.
---
 fs/ioctl.c         | 6 +++---
 include/linux/fs.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 638a36be31c1..502306499dfd 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -41,7 +41,7 @@
  *
  * Returns 0 on success, -errno on error.
  */
-long vfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+int vfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	int error = -ENOTTY;
 
@@ -228,7 +228,7 @@ static int ioctl_fiemap(struct file *filp, struct fiemap __user *ufiemap)
 	return error;
 }
 
-static long ioctl_file_clone(struct file *dst_file, unsigned long srcfd,
+static int ioctl_file_clone(struct file *dst_file, unsigned long srcfd,
 			     u64 off, u64 olen, u64 destoff)
 {
 	CLASS(fd, src_file)(srcfd);
@@ -248,7 +248,7 @@ static long ioctl_file_clone(struct file *dst_file, unsigned long srcfd,
 	return ret;
 }
 
-static long ioctl_file_clone_range(struct file *file,
+static int ioctl_file_clone_range(struct file *file,
 				   struct file_clone_range __user *argp)
 {
 	struct file_clone_range args;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 999ae4790a5a..1094fb0b601c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1992,7 +1992,7 @@ int vfs_fchown(struct file *file, uid_t user, gid_t group);
 int vfs_fchmod(struct file *file, umode_t mode);
 int vfs_utimes(const struct path *path, struct timespec64 *times);
 
-extern long vfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
+int vfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 
 #ifdef CONFIG_COMPAT
 extern long compat_ptr_ioctl(struct file *file, unsigned int cmd,
-- 
2.43.5


