Return-Path: <linux-fsdevel+bounces-39758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 279B5A17866
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 08:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7490188C68F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 07:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04CF17A5BE;
	Tue, 21 Jan 2025 07:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LqMu7qEJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A8619D06E
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jan 2025 07:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737443440; cv=none; b=ZV4yzRZnpoZnhkkfdwFYHmscLAj3rFBjKtVTZT2Txk1bmtiyAnWQbuV54Kq3zuYHcBXFt0Ri8ruEeoXL9qdcNtPs+FBTTTl5t9xXk62bsRC3pyUL5UeTk39Vp/f1XEUnUtnUwFRkUhpiXBZoriG96me0BfcnY7fJRUMIi9VLQa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737443440; c=relaxed/simple;
	bh=5s1j4CxvB/puxN4iOg5yPEPpFhOzDEoGmIaj01YvzL8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tb6IpQd/6w3M8KnILclCCEnsG/kQ4zDAiXTGwKuZ83oVXMpw9lKUStRut77WGrlFjfc9pUWlOkhlEqdtcstrLuaVPOomOtxlOSPoe/ubt58USWS9J7WATnKQsuOi9e0DPqW5Uze3USK3zUomFwBolxuHpEO3ZcTNFwPMrShV7n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=LqMu7qEJ; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1737443439; x=1768979439;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wwCSqpPmXH8LJCBo0nkSC9kBq6DLqSP2U+WHFW3Q9vo=;
  b=LqMu7qEJ35q/hSBimuNRkABAnRJphMLplHKlyfsOC2vbr/t0A3B32zau
   u8LaAsf+Jpczsd20DtjcQslbqdhHoe3MMfbBKogLXwQ+XqTOE9wV7Bn/2
   TfxnGMe/z7wdQB1ROiREPIm6s+kiioZEwHRX08+q/UvaCS4WOufXDldpq
   E=;
X-IronPort-AV: E=Sophos;i="6.13,221,1732579200"; 
   d="scan'208";a="370595599"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 07:10:38 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:39370]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.53:2525] with esmtp (Farcaster)
 id 5ec57bd5-bd1a-4393-8730-fdeb188d1334; Tue, 21 Jan 2025 07:10:36 +0000 (UTC)
X-Farcaster-Flow-ID: 5ec57bd5-bd1a-4393-8730-fdeb188d1334
Received: from EX19D002AND002.ant.amazon.com (10.37.240.241) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 21 Jan 2025 07:10:36 +0000
Received: from HND-5CG1082HRX.ant.amazon.com (10.143.93.208) by
 EX19D002AND002.ant.amazon.com (10.37.240.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 21 Jan 2025 07:10:33 +0000
From: Yuichiro Tsuji <yuichtsu@amazon.com>
To: <linux-fsdevel@vger.kernel.org>
CC: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner
	<brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Yuichiro Tsuji <yuichtsu@amazon.com>
Subject: [PATCH v3 vfs 2/2] ioctl: Fix return type of several functions from long to int
Date: Tue, 21 Jan 2025 16:08:23 +0900
Message-ID: <20250121070844.4413-3-yuichtsu@amazon.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250121070844.4413-1-yuichtsu@amazon.com>
References: <20250121070844.4413-1-yuichtsu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA003.ant.amazon.com (10.13.139.42) To
 EX19D002AND002.ant.amazon.com (10.37.240.241)

Fix the return type of several functions from long to int to match its actu
al behavior. These functions only return int values. This change improves
type consistency across the filesystem code and aligns the function signatu
re with its existing implementation and usage.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Yuichiro Tsuji <yuichtsu@amazon.com>
---
 fs/ioctl.c         | 10 +++++-----
 include/linux/fs.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 638a36be31c1..c91fd2b46a77 100644
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
 
@@ -228,8 +228,8 @@ static int ioctl_fiemap(struct file *filp, struct fiemap __user *ufiemap)
 	return error;
 }
 
-static long ioctl_file_clone(struct file *dst_file, unsigned long srcfd,
-			     u64 off, u64 olen, u64 destoff)
+static int ioctl_file_clone(struct file *dst_file, unsigned long srcfd,
+			    u64 off, u64 olen, u64 destoff)
 {
 	CLASS(fd, src_file)(srcfd);
 	loff_t cloned;
@@ -248,8 +248,8 @@ static long ioctl_file_clone(struct file *dst_file, unsigned long srcfd,
 	return ret;
 }
 
-static long ioctl_file_clone_range(struct file *file,
-				   struct file_clone_range __user *argp)
+static int ioctl_file_clone_range(struct file *file,
+				  struct file_clone_range __user *argp)
 {
 	struct file_clone_range args;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index bdd36798ba5f..def100a6c575 100644
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


