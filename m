Return-Path: <linux-fsdevel+bounces-39755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A92A176BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 05:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 872343A555A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 04:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E4E1925A3;
	Tue, 21 Jan 2025 04:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KIaB8+h5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEF845979
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2025 04:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737435561; cv=none; b=ekWM5nArXqU0iyRwmo3U9Y/rMrPqkaJXwNdR7yqt/xYNPnVKUYYYnJK/QunnJ6T4KGxRsFYgiLiyWQ7FaaYE0JG3k2EmsIBihicP50wHR9HqDlAnaRMB95gS8OZGzbg494qy0wKfWfjZ77CMA4E1GVZofLh04gxDKAewtAwV+2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737435561; c=relaxed/simple;
	bh=JI37iwm8le2Ive0jJ1TWUv3uq7YTIGy13MvmyUVdcd0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z7pTfaB0u5QSXJqy3JM0HJNPc/cGWgdQ8Bet1emPCWxn4SqGI8rd2pmGWUkeQpgAHiNzMn37YWFZWgCQGKDKs/BYUDhzz5uVc5uKU3ud0yRVNSweGH+qiQ82y0b0iJe4DL0PkfwqxWOUS10O7BNxGpxXFQL5YaCz6ElHdccFP6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=KIaB8+h5; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1737435560; x=1768971560;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jbKZ02zieANME3CZwoXlf/EvC4nIZqKLeMUB4ONs6fI=;
  b=KIaB8+h5iCj7G6j/XSxJde9NKWNJIXDzq5fpf/YBRT20OwE3OxO8zxIK
   Cy6djdhv1u82r84D8lk5YwG2bDfAtLRUVw7N2g423QCCLw4Khio/CWuvm
   pFN4eOcfj9iVmi824nRLgJLXIkuNua2ot2XTsfBDPZWA841w1Qde3zPMD
   0=;
X-IronPort-AV: E=Sophos;i="6.13,221,1732579200"; 
   d="scan'208";a="690650189"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 04:59:15 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:37619]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.209:2525] with esmtp (Farcaster)
 id b6f148a6-efcc-40c0-ba9b-894ddb365a57; Tue, 21 Jan 2025 04:59:14 +0000 (UTC)
X-Farcaster-Flow-ID: b6f148a6-efcc-40c0-ba9b-894ddb365a57
Received: from EX19D002AND002.ant.amazon.com (10.37.240.241) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 21 Jan 2025 04:59:13 +0000
Received: from HND-5CG1082HRX.ant.amazon.com (10.143.93.208) by
 EX19D002AND002.ant.amazon.com (10.37.240.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 21 Jan 2025 04:59:10 +0000
From: Yuichiro Tsuji <yuichtsu@amazon.com>
To: <linux-fsdevel@vger.kernel.org>
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Yuichiro Tsuji <yuichtsu@amazon.com>
Subject: [PATCH v2 vfs 2/2] ioctl: Fix return type of several functions from long to int
Date: Tue, 21 Jan 2025 13:57:08 +0900
Message-ID: <20250121045730.3747-3-yuichtsu@amazon.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250121045730.3747-1-yuichtsu@amazon.com>
References: <20250121045730.3747-1-yuichtsu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D002AND002.ant.amazon.com (10.37.240.241)

Fix the return type of several functions from long to int to match its actu
al behavior. These functions only return int values. This change improves
type consistency across the filesystem code and aligns the function signatu
re with its existing implementation and usage.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Yuichiro Tsuji <yuichtsu@amazon.com>
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


