Return-Path: <linux-fsdevel+bounces-23828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A638933E55
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 16:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B8821C21130
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 14:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D221181B89;
	Wed, 17 Jul 2024 14:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lcwyX8yH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD17181321;
	Wed, 17 Jul 2024 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721226263; cv=none; b=GPbxUC/2bAHBc+jeZtYAuVAXtE9s9KzqYdKUNlgbk52fMb0NN7RF5ETpEVP9ZVvetnuzFqn3QL4QA3bL5y39vjyynG4SxyTPFbrIZxeCnEptX8Tv+9YbplmiQCKWIZ0/ff5NYXbIdhzHD4ZeeWeh6sLnKXgLIA8uaUXidIfwjx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721226263; c=relaxed/simple;
	bh=pmAaCzlr4Dp3556CZXW+f9AsCzhySHEDTX55XwcA8WA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G5SxG6Y8wHQmEEmDCGGdhMRvRS9n9m58AleMTU0qqVSNLhvN84hsscR3mOPIus0xs1ao1oAA40xOCe+sCQvWMUVwtyvPtpexgsONmQJxjJkPUzpGIPkCG5xN2G59ABcm69mo+zRtHNVr93wDBjpjn1GN6zQK2D6KzVD8CEZoHjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lcwyX8yH; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721226263; x=1752762263;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pmAaCzlr4Dp3556CZXW+f9AsCzhySHEDTX55XwcA8WA=;
  b=lcwyX8yHYyBHza+Wf7pd7zsGbnEO/xgM3QHem1UZdVsVb8yYKdrBlEbZ
   au8ib8R7quuDcx8dYqOy0RPbVXXUGLPTVW7n2wfyEASaxo8c14O/+9x+O
   wBXbGjUl9m3/9Gl5uOJhmhfSnqPqjPj2MDWTlZCvhPMoAsx4ctkGb48FW
   sDB24D+575RpdsHY2zaeGQevv5kHgxjswFNchQXGqxUJaiaR6CHTCPGWf
   5x9BJukec19MYf1OYuHEZmA9czgNdHQIaoYEm4vd0rvpkajKiNq44X/RQ
   ty0isSAZzl5m7ID/g3RikQISC92F/IFxQNa/7EdChV02p1vLzjF3Kmf/3
   A==;
X-CSE-ConnectionGUID: qhgaxGdVTwSSuPlkKaap4A==
X-CSE-MsgGUID: ebyScBP1TtylTpOpZK1pcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="29313604"
X-IronPort-AV: E=Sophos;i="6.09,214,1716274800"; 
   d="scan'208";a="29313604"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 07:24:23 -0700
X-CSE-ConnectionGUID: T/G66mvKSTKEnbd8vTSiPA==
X-CSE-MsgGUID: YDigqb2cSfOzAtRdYCQMSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,214,1716274800"; 
   d="scan'208";a="54596624"
Received: from linux-pnp-server-16.sh.intel.com ([10.239.177.152])
  by fmviesa003.fm.intel.com with ESMTP; 17 Jul 2024 07:24:20 -0700
From: Yu Ma <yu.ma@intel.com>
To: brauner@kernel.org,
	jack@suse.cz,
	mjguzik@gmail.com,
	edumazet@google.com
Cc: yu.ma@intel.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pan.deng@intel.com,
	tianyou.li@intel.com,
	tim.c.chen@intel.com,
	tim.c.chen@linux.intel.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH v5 1/3] fs/file.c: remove sanity_check and add likely/unlikely in alloc_fd()
Date: Wed, 17 Jul 2024 10:50:16 -0400
Message-ID: <20240717145018.3972922-2-yu.ma@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717145018.3972922-1-yu.ma@intel.com>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240717145018.3972922-1-yu.ma@intel.com>
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

Reviewed-by: Jan Kara <jack@suse.cz>
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


