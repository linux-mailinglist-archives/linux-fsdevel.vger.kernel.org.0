Return-Path: <linux-fsdevel+bounces-23033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F569262D9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 16:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAB751F21F9D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 14:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC24C17B4F6;
	Wed,  3 Jul 2024 14:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vv2DXr1I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BFC17C9E8;
	Wed,  3 Jul 2024 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015638; cv=none; b=cZhuq6Q2+mCL1TxBpKuXUfFiynzO9joFk8Alq8oziBox7SwUkGN+LgCrDLuzJfJ5Q8MFVq1RcNSMyrmHGb8jLGioIuPm3eLx/e7/m4kt/UCmsGZ2xzuzlNfoeaQ1Nw5PsP6ASPLfgQQeb3QKBMGUwIgJy2EZXkOAtS4vgZR+cZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015638; c=relaxed/simple;
	bh=MWZtVxjh3PFjIWGDTRmBv/J1DQS8L9dlFBlCzhsyd10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j6Reh7WbqCQLRnwOa8DvJFJigMVd5ylNB2HTOGY1PzOVbktXdXObO3HIIm2MWf/Mmtvh5HKeeQDNvDlcSVfFAgCC9AtWPpJ+v9rXF0XI9IA0tbHsteGVFB7/r/QGSegJp3zJqkx72TMkJrMBtm9qexsrNM5rJXE1Mp55axrsRCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vv2DXr1I; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720015637; x=1751551637;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MWZtVxjh3PFjIWGDTRmBv/J1DQS8L9dlFBlCzhsyd10=;
  b=Vv2DXr1I3VJY/hBYq3zAzjHcMy1Q1p4/9orh4trqI88lxQtJ5wYFAu/v
   c8sZQGtjsdtroglT8KRCSJ/A/xHHIthC45fwdnWBjGK+FG2VsP385ERj7
   4ey7eQ1herNrNh5Q6ZX5rHB7diQeSI/xcKZur5oaePTGjy0SImgpsunaP
   VOmDmFzXxETOjrSSMReY/ZDNAN2CU/rOO4V2Bam12MnphpcLFuF9qIt76
   tUDATNEptuAs2/2bHcuRxek/3VZI2izMRp5i8I9Y4o9WuPhi0Uq7k50Uw
   /A6xTUPS1yYDPNB/qKcb6AHjOipH2KvRahDUWzyValU7LtP+POV8xMtop
   A==;
X-CSE-ConnectionGUID: vZ76/Iq6RqKhm9hbhc6ibQ==
X-CSE-MsgGUID: +/P0uKcsQeKgH7CZzzu6hA==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="16900702"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="16900702"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 07:07:17 -0700
X-CSE-ConnectionGUID: CfWTawYGR9WQ+E4bqntFRQ==
X-CSE-MsgGUID: 4H/zJIhMSgOQsEe6WsNVOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="46693470"
Received: from linux-pnp-server-16.sh.intel.com ([10.239.177.152])
  by orviesa006.jf.intel.com with ESMTP; 03 Jul 2024 07:07:13 -0700
From: Yu Ma <yu.ma@intel.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	mjguzik@gmail.com,
	edumazet@google.com
Cc: yu.ma@intel.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pan.deng@intel.com,
	tianyou.li@intel.com,
	tim.c.chen@intel.com,
	tim.c.chen@linux.intel.com
Subject: [PATCH v3 1/3] fs/file.c: remove sanity_check and add likely/unlikely in alloc_fd()
Date: Wed,  3 Jul 2024 10:33:09 -0400
Message-ID: <20240703143311.2184454-2-yu.ma@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240703143311.2184454-1-yu.ma@intel.com>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240703143311.2184454-1-yu.ma@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

alloc_fd() has a sanity check inside to make sure the struct file mapping to the
allocated fd is NULL. Remove this sanity check since it can be assured by
exisitng zero initilization and NULL set when recycling fd. Meanwhile, add
likely/unlikely and expand_file() call avoidance to reduce the work under
file_lock.

Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Yu Ma <yu.ma@intel.com>
---
 fs/file.c | 38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index a3b72aa64f11..5178b246e54b 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -515,28 +515,29 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
 	if (fd < files->next_fd)
 		fd = files->next_fd;
 
-	if (fd < fdt->max_fds)
+	if (likely(fd < fdt->max_fds))
 		fd = find_next_fd(fdt, fd);
 
+	error = -EMFILE;
+	if (unlikely(fd >= fdt->max_fds)) {
+		error = expand_files(files, fd);
+		if (error < 0)
+			goto out;
+		/*
+		 * If we needed to expand the fs array we
+		 * might have blocked - try again.
+		 */
+		if (error)
+			goto repeat;
+	}
+
 	/*
 	 * N.B. For clone tasks sharing a files structure, this test
 	 * will limit the total number of files that can be opened.
 	 */
-	error = -EMFILE;
-	if (fd >= end)
-		goto out;
-
-	error = expand_files(files, fd);
-	if (error < 0)
+	if (unlikely(fd >= end))
 		goto out;
 
-	/*
-	 * If we needed to expand the fs array we
-	 * might have blocked - try again.
-	 */
-	if (error)
-		goto repeat;
-
 	if (start <= files->next_fd)
 		files->next_fd = fd + 1;
 
@@ -546,13 +547,6 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
 	else
 		__clear_close_on_exec(fd, fdt);
 	error = fd;
-#if 1
-	/* Sanity check */
-	if (rcu_access_pointer(fdt->fd[fd]) != NULL) {
-		printk(KERN_WARNING "alloc_fd: slot %d not NULL!\n", fd);
-		rcu_assign_pointer(fdt->fd[fd], NULL);
-	}
-#endif
 
 out:
 	spin_unlock(&files->file_lock);
@@ -618,7 +612,7 @@ void fd_install(unsigned int fd, struct file *file)
 		rcu_read_unlock_sched();
 		spin_lock(&files->file_lock);
 		fdt = files_fdtable(files);
-		BUG_ON(fdt->fd[fd] != NULL);
+		WARN_ON(fdt->fd[fd] != NULL);
 		rcu_assign_pointer(fdt->fd[fd], file);
 		spin_unlock(&files->file_lock);
 		return;
-- 
2.43.0


