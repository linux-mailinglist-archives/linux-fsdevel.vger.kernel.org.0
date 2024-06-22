Return-Path: <linux-fsdevel+bounces-22180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C09719134CA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2024 17:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 008AA1C225D6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2024 15:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9674C171E6C;
	Sat, 22 Jun 2024 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EUHnRP7j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACDF16F903;
	Sat, 22 Jun 2024 15:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719069800; cv=none; b=FNSxG1Xks6kaIY7F/B3m/auGK1e4XFhBhHFmH1ZEtk6hn5lWWFgreqKk0rA9KmNGp4C7Xf6tVH3QyEaPKb0hfk5TjwfHeJxSHlKuYLE5CVcW9CvuT5V/oncifhhxY1+A9MWSWX36rhnyfbYr46XTuG/4MVoUi1taXxtczidy0/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719069800; c=relaxed/simple;
	bh=+3EtXD3anw5T5SPSXo7iEqIIBqdxGY53eBDTDUvUN6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RKdr+fP8WDVisMiHQPTIGww7yew8HyZOt6OMb60QaixAiq5sHdClG3yHfZWPL1OUdLsxH1wz6pvOMdzN48ifJ4suOgt9kx2ERyG1qH9dJumZ57Mx32JpW73h4lfBtgNi1AnS+X0Kg4y20ti9RBOCNSbWbcS8Lz9fMi4OOCpg7tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EUHnRP7j; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719069798; x=1750605798;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+3EtXD3anw5T5SPSXo7iEqIIBqdxGY53eBDTDUvUN6A=;
  b=EUHnRP7jGDm2Tx80mmXBHZye71Pzbr/AcqP1ih2PL52ljheDemfie3Rt
   Qdu5XM5xphoi6LyFQTdeqlczig3r9kr4J3Xl07DLJ8OzK/bOoF0v4GlfZ
   rBdSLwDCOhdpp05J9R7t+sPYg9wM3G6phCx9dkPKPzz1nSmT7w6o7bUsb
   ohzbfC297heVAW8VsR8Im9bI5ELY6HwIfS2vRVIVv3alZSoeBCuIHJYlS
   2hgxvTcXVinLFwOvSO2XcvlHWS4mUAgTfJhoXAscSSIV8ip5KThe78TML
   iq8H3fw7+Y4CGkdM8wZqD+6spf8AtNsjmJ2xxUHpsHh85S97ZdI8B5uf4
   g==;
X-CSE-ConnectionGUID: ZDPF5iUMR7mpEXujn3mikw==
X-CSE-MsgGUID: YDs3RqLuSLOHRSfF7u7Kxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11111"; a="41495819"
X-IronPort-AV: E=Sophos;i="6.08,258,1712646000"; 
   d="scan'208";a="41495819"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2024 08:23:18 -0700
X-CSE-ConnectionGUID: LAVAn+nqTZC3/Mh2iI7B5A==
X-CSE-MsgGUID: CofonECtRpuZaK2eOtuHsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,258,1712646000"; 
   d="scan'208";a="42680526"
Received: from linux-pnp-server-16.sh.intel.com ([10.239.177.152])
  by fmviesa006.fm.intel.com with ESMTP; 22 Jun 2024 08:23:15 -0700
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
Subject: [PATCH v2 3/3] fs/file.c: remove sanity_check from alloc_fd()
Date: Sat, 22 Jun 2024 11:49:04 -0400
Message-ID: <20240622154904.3774273-4-yu.ma@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240622154904.3774273-1-yu.ma@intel.com>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240622154904.3774273-1-yu.ma@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

alloc_fd() has a sanity check inside to make sure the struct file mapping to the
allocated fd is NULL. Remove this sanity check since it can be assured by
exisitng zero initilization and NULL set when recycling fd.

Combined with patch 1 and 2 in series, pts/blogbench-1.1.0 read improved by
32%, write improved by 17% on Intel ICX 160 cores configuration with v6.10-rc4.

Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Yu Ma <yu.ma@intel.com>
---
 fs/file.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index b4d25f6d4c19..1153b0b7ba3d 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -555,13 +555,6 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
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
-- 
2.43.0


