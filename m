Return-Path: <linux-fsdevel+bounces-21718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A084908FB5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 18:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 243A51F21C50
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2024 16:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83E619E7D0;
	Fri, 14 Jun 2024 16:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VB20f3hC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FC219D068;
	Fri, 14 Jun 2024 16:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718381342; cv=none; b=Db4qomzak/+95p8h0TK9JuZjJD9cMzLLZuX/qIF/sBoATsvSLH7SWND0/XT4E3jQA9/vSmnLmnkVNzjAYHGz/tLLL1FggCNiOT4UJZrhwu4tXn6kJdG79m6WJU1GCP/tOq/Yym/Khwu04QdjilquZmVa/vjBnGPY3xcEfeHhMdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718381342; c=relaxed/simple;
	bh=7j/faoRXzWh8uYOzQ7IXFB9d5L6kjkr5xK99YDrC7To=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QF/pk05xc1Y9bgz27SK+yD9gSzQfrGjxGuFQQ+8MicztL7WoWuotsD7uryKBgSi3GHH14chE/3dXWPfM+fCs+3jne5TjmTPrOHDyziZQlerYODWsXbmz1Inw+XTXVUiGfyzkFcFEOKaKmELvu9vnPNnD/UOuIA5KhWMCbSFtt0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VB20f3hC; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718381341; x=1749917341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7j/faoRXzWh8uYOzQ7IXFB9d5L6kjkr5xK99YDrC7To=;
  b=VB20f3hCKJcgOMYIFt4PpDglZ4g2NbLrdeQ4Ok27fSkFjrq9Tno+dNx7
   Twzvxth4nNgcUfBNu8J5z4Lp7ekB4PyNkDFKsRISSconfl40Xlm/uIreJ
   rx6n/h+iR5YEiNjVk0SRieRWW4FvGux98+AKqAKNJVpD7LauFaq58kN27
   npclSeVZuSCFUkut7pR1vxX72eq3uJPZkiWcF8zqBmQ0Yl9Z86gojCoLc
   Bkc0gNFF1Fc23EWgODtAwPhXj4brmPnfNRM8mNPnTsy7fSvE4xk+71kBX
   uHcNAqsLFI3Cf/n+NBUJwVz6PprqvauBDrr9XPzHeXIr8+vXVrfXC4pJh
   w==;
X-CSE-ConnectionGUID: rur5bjjARpSF1Z+kfpxQRA==
X-CSE-MsgGUID: aiTmifgOSJSUm6/oEbx1Pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="15399431"
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="15399431"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 09:09:00 -0700
X-CSE-ConnectionGUID: Y2zZfm5BTlukoOmsTXo3aA==
X-CSE-MsgGUID: koUQl62rTAqdHC4GeeJaBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,238,1712646000"; 
   d="scan'208";a="71741096"
Received: from linux-pnp-server-16.sh.intel.com ([10.239.177.152])
  by fmviesa001.fm.intel.com with ESMTP; 14 Jun 2024 09:08:58 -0700
From: Yu Ma <yu.ma@intel.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tim.c.chen@linux.intel.com,
	tim.c.chen@intel.com,
	pan.deng@intel.com,
	tianyou.li@intel.com,
	yu.ma@intel.com
Subject: [PATCH 3/3] fs/file.c: move sanity_check from alloc_fd() to put_unused_fd()
Date: Fri, 14 Jun 2024 12:34:16 -0400
Message-ID: <20240614163416.728752-4-yu.ma@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240614163416.728752-1-yu.ma@intel.com>
References: <20240614163416.728752-1-yu.ma@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

alloc_fd() has a sanity check inside to make sure the FILE object mapping to the
allocated fd is NULL. Move the sanity check from performance critical alloc_fd()
path to non performance critical put_unused_fd() path.

As the initial NULL FILE object condition can be assured by zero initialization
in init_file, we just need to make sure that it is NULL when recycling fd back.
There are 3 functions call __put_unused_fd() to return fd,
file_close_fd_locked(), do_close_on_exec() and put_unused_fd(). For
file_close_fd_locked() and do_close_on_exec(), they have implemented NULL check
already. Adds NULL check to put_unused_fd() to cover all release paths.

Combined with patch 1 and 2 in series, pts/blogbench-1.1.0 read improved by
32%, write improved by 15% on Intel ICX 160 cores configuration with v6.8-rc6.

Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Yu Ma <yu.ma@intel.com>
---
 fs/file.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index a0e94a178c0b..59d62909e2e3 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -548,13 +548,6 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
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
@@ -572,7 +565,7 @@ int get_unused_fd_flags(unsigned flags)
 }
 EXPORT_SYMBOL(get_unused_fd_flags);
 
-static void __put_unused_fd(struct files_struct *files, unsigned int fd)
+static inline void __put_unused_fd(struct files_struct *files, unsigned int fd)
 {
 	struct fdtable *fdt = files_fdtable(files);
 	__clear_open_fd(fd, fdt);
@@ -583,7 +576,12 @@ static void __put_unused_fd(struct files_struct *files, unsigned int fd)
 void put_unused_fd(unsigned int fd)
 {
 	struct files_struct *files = current->files;
+	struct fdtable *fdt = files_fdtable(files);
 	spin_lock(&files->file_lock);
+	if (unlikely(rcu_access_pointer(fdt->fd[fd]))) {
+		printk(KERN_WARNING "put_unused_fd: slot %d not NULL!\n", fd);
+		rcu_assign_pointer(fdt->fd[fd], NULL);
+	}
 	__put_unused_fd(files, fd);
 	spin_unlock(&files->file_lock);
 }
-- 
2.43.0


