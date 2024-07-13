Return-Path: <linux-fsdevel+bounces-23628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F7893032E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2024 04:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 544211C21100
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2024 02:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1DD1862F;
	Sat, 13 Jul 2024 02:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QAI3Fh5R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA0117591;
	Sat, 13 Jul 2024 02:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720836803; cv=none; b=HlMFGVagxDNIw1K2R0GLeMcONdlkl6i3kuuqWu3ZnD46Ruz6kvInXiVt2ABwzj3TZK9fabwj8vaAU3+EiJNcfm6cmHGRG7a/ZYmbcrTlpNySMac42r2vkg6WZazTPFGTHyPTUN/0EucahfgvAm4Eu+lOKHNzrqeMjwJDq43uFEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720836803; c=relaxed/simple;
	bh=vbUi5zKMqImT3C+nksSqGjIBCDKIitAH3vpPg8VR/+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tzaxc6B/haPXc5u8Sc8cqm3cfU1zwHv88bj1MbksRuXGkXdvYEFK/vH8so7QJZy9OFS3d9DqxfEfMU21ZpkDtBRY8KpyNKsIxQ4hDaPp+46PBlaeGEv3Lx5FtCasiSCaAAV1W5qKSbbSu9aPRVKwTpttdkJNRWLX2skTmeYYj64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QAI3Fh5R; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720836801; x=1752372801;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vbUi5zKMqImT3C+nksSqGjIBCDKIitAH3vpPg8VR/+w=;
  b=QAI3Fh5RKOMuFodzxY3Aug6gPo7SZJO3+PMxmqCmc05W//RkQB8qdwgE
   F9+Eg0USu/qOwwknBQvvBwf+XvuFQmJXqiolC/pxIDdIU0EPhxxrT1aD5
   mk9Ar2QZruaHgQxIDgXpFB7MbLjJoPRPqQQkb6pUQiFtxcLmJz0Z1Csat
   QovvD/NlTkVZsFlgVGD8jqIt43UvoVkUPIYoFQM90BW5GZsBs/ZugnMuK
   HFK5974C4SWdAMBvfEPnPSE8xfJc5h2Fjf2iMpiqNy3kZLTq2eXyRjI23
   +e1MDqkSlamM9tYljjvIW8DXxnvPXvaC8nC8J8ipWW1fXpkHuPegppdbd
   Q==;
X-CSE-ConnectionGUID: R1B9IaOfTg6H90wwVMRtPw==
X-CSE-MsgGUID: +qwlZq1ISLuutiEfHo5lQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="12531269"
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="12531269"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 19:13:21 -0700
X-CSE-ConnectionGUID: vADG1FrCSluLzH3d1BXzFA==
X-CSE-MsgGUID: WOQ7wzXJTy6laTIRgMJ1Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,204,1716274800"; 
   d="scan'208";a="53449891"
Received: from linux-pnp-server-16.sh.intel.com ([10.239.177.152])
  by fmviesa005.fm.intel.com with ESMTP; 12 Jul 2024 19:13:19 -0700
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
Subject: [PATCH v4 1/3] fs/file.c: remove sanity_check and add likely/unlikely in alloc_fd()
Date: Fri, 12 Jul 2024 22:39:15 -0400
Message-ID: <20240713023917.3967269-2-yu.ma@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240713023917.3967269-1-yu.ma@intel.com>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240713023917.3967269-1-yu.ma@intel.com>
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
 fs/file.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index a3b72aa64f11..e1b9d6df7941 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -515,7 +515,7 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
 	if (fd < files->next_fd)
 		fd = files->next_fd;
 
-	if (fd < fdt->max_fds)
+	if (likely(fd < fdt->max_fds))
 		fd = find_next_fd(fdt, fd);
 
 	/*
@@ -523,19 +523,21 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
 	 * will limit the total number of files that can be opened.
 	 */
 	error = -EMFILE;
-	if (fd >= end)
+	if (unlikely(fd >= end))
 		goto out;
 
-	error = expand_files(files, fd);
-	if (error < 0)
-		goto out;
+	if (unlikely(fd >= fdt->max_fds)) {
+		error = expand_files(files, fd);
+		if (error < 0)
+			goto out;
 
-	/*
-	 * If we needed to expand the fs array we
-	 * might have blocked - try again.
-	 */
-	if (error)
-		goto repeat;
+		/*
+		 * If we needed to expand the fs array we
+		 * might have blocked - try again.
+		 */
+		if (error)
+			goto repeat;
+	}
 
 	if (start <= files->next_fd)
 		files->next_fd = fd + 1;
@@ -546,13 +548,6 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
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
@@ -618,7 +613,7 @@ void fd_install(unsigned int fd, struct file *file)
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


