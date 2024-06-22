Return-Path: <linux-fsdevel+bounces-22177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8679134C5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2024 17:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 892C8B219F0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2024 15:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08C516F90F;
	Sat, 22 Jun 2024 15:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jAyq/f6B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FCFB660;
	Sat, 22 Jun 2024 15:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719069790; cv=none; b=gxjHmeBPTDpLeAPMxC88woZMQpwVnIgFuLHNVLrcfhDh1SJzehDz24gA3WZwjMJRdZL0/8YZmVyVsTPmD3lcB5arrNZS/tzmVMAmvYKz9YHUzK1nISQSJFrxcbnyIFXERXS+hLR/M8WtkqEgf64qW9lOscKUes1DWfdIV1hPyIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719069790; c=relaxed/simple;
	bh=cOyjd06LqP//etzyIxkKXb6JWqQd2d0ROQMKn+9dM9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LB5ogh8wnAcQRE2Nfe9U4XAXXau/TyuPyozHmfKyEq529p0cV1GeSriu9nhrdheyat99CmGU4Z3/5wrsgUg+deR7iDZXdWh47HRyOC0woW5UNspSg3+y3ihiBaUT9VxSQSdT01+s1RmDIrjgITtGTdfCrrVMGPEKHbWQ2J5E60g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jAyq/f6B; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719069788; x=1750605788;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cOyjd06LqP//etzyIxkKXb6JWqQd2d0ROQMKn+9dM9s=;
  b=jAyq/f6BZ5saNF5+ZnOyeXBDPE2zFvWKg7XlzYpuun8R/Sx8E6weWbQh
   vrQj8A57d3dkNwwf7khLhvmi4cFUI8i/8NxqyjPFtTcotuMYFzLMiUmw+
   o8uyf+yAtUD/KXH5zQkNiJtDr7B5Mv5coeu+NhEojPM8DsWlCpeGUqvsF
   mQhAQ/GpfyQTsemqiQ/+rI1ZnkBdd72bdsvuOy0FDRV/1ahz6N44WR/kn
   KvhCg8xwuy60pA17N/4zY2sk8akc720k+JiMbYZdtaV1zjOJ9aJcj4Fnn
   /MyIwADbJgjKjRC2bPexyImrRLeD0et+m/kIwQDQiJDjwRL2btaPzHM1d
   A==;
X-CSE-ConnectionGUID: kbc9S1sITAuO/hIc2k+7UQ==
X-CSE-MsgGUID: SU6Uzgz3TEKiekGYGmg0WQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11111"; a="41495801"
X-IronPort-AV: E=Sophos;i="6.08,258,1712646000"; 
   d="scan'208";a="41495801"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2024 08:23:07 -0700
X-CSE-ConnectionGUID: ivm1FCwuRF6RMuyonR6RHA==
X-CSE-MsgGUID: +aeW7iaITTG5brKzHP1fEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,258,1712646000"; 
   d="scan'208";a="42680514"
Received: from linux-pnp-server-16.sh.intel.com ([10.239.177.152])
  by fmviesa006.fm.intel.com with ESMTP; 22 Jun 2024 08:23:04 -0700
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
Subject: [PATCH v2 0/3] fs/file.c: optimize the critical section of file_lock in
Date: Sat, 22 Jun 2024 11:49:01 -0400
Message-ID: <20240622154904.3774273-1-yu.ma@intel.com>
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

pts/blogbench-1.1.0 is a benchmark designed to replicate the
load of a real-world busy file server by multiple threads of
random reads, writes, and rewrites. When running default configuration
with multiple parallel threads, hot spin lock contention is observed
from alloc_fd(), file_closed_fd() and put_unused_fd() around file_lock.

These 3 patches are created to reduce the critical section of file_lock
in alloc_fd() and close_fd(). As a result, pts/blogbench-1.1.0 has been
improved by 32% for read and 17% for write with over 30% kernel cycles
reduced on ICX 160 cores configuration with v6.10-rc4.

v1 -> v2:
1. Rebased the patch set to latest v6.10-rc4 and updated the performance
results.
2. Updated patch 1 to resolve the bug identified by Mateusz Guzik with rlimit
check and ensure allocated fd is greater than start.
3. Updated patch 3 to remove sanity_check directly per the alignment with
maintainer

Yu Ma (3):
  fs/file.c: add fast path in alloc_fd()
  fs/file.c: conditionally clear full_fds
  fs/file.c: remove sanity_check from alloc_fd()

 fs/file.c | 46 ++++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)


base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
-- 
2.43.0


