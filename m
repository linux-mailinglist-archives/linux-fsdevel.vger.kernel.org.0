Return-Path: <linux-fsdevel+bounces-42801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A34A48E42
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 03:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E1701891581
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 02:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD2E28DD0;
	Fri, 28 Feb 2025 02:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iNFU55a7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5965B125B2
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2025 02:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740708013; cv=none; b=JYXp0juHjzLh7HB/USo6uTtW1sOw9s0XK5WshuQa5Pu7Ghz6kEpu8lJoF7di8T0J1kYJiNtOuzInGNoJLuktIkBOUuhsAB6adodcY8lLFDMfsYYYIovBbrEaCz23+qPGgFP3d/VyhucU3Ng4VgYrn+M2sX0GnyCJCGZqSPglGBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740708013; c=relaxed/simple;
	bh=5THlPvVH4GcoKHXhVcUh2F7BUVk1jm7kya3C5rkouNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QnZCGs3EmQsBMFiBfHEYlzzDo9o1KQmEetmj6X59w05AoQGGuglLYzD0GR4CLSODqU8MkUCcumAUW0yoqatpPksIf/JVA7C/0u1cEMgb+W7cKVLON55csv62UA5vMF1O8s6D3Mc+avs9Rr1pjzUfQQamnhD4kY7lt8+7g7GjQhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iNFU55a7; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740708010; x=1772244010;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5THlPvVH4GcoKHXhVcUh2F7BUVk1jm7kya3C5rkouNM=;
  b=iNFU55a75t4Lqlwj8jEfnQLT491z7lDX3ddDz3BFXZKG83RJ7h0daTnQ
   b05JifwKcLSwQ70bO+3kbyMRbnd8kbkNbAj5X0AOXp+JagICVrPra+T6r
   14xlfT346drhE8uFPci0cgVxqGA6Q8zXiknmwcqAXqhFFh/rEe73MFHVJ
   lZJCwclcp1gyA8ekVDziEtr8fA6ZjE5aAOBHBoGt4ngRP7hrY3YhzFoD9
   BGuoN44mS/RfbSZRhB8K4G+B+bBGGyRDsSwHpfM1TfmpKqoOjF+2CNa1F
   wNG7yBj0k52WcFxuGEdxQ5UCcdvBsMqz2Jst6BdwdIhMNkza+x5ovfoZX
   Q==;
X-CSE-ConnectionGUID: qiFnGyiKQfG+QldZ3Yobbg==
X-CSE-MsgGUID: wmfYJoz7Qzq5/28Xt6edYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41654404"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="41654404"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 18:00:09 -0800
X-CSE-ConnectionGUID: kLssblpjS4KxV7zyFQ5RfA==
X-CSE-MsgGUID: gugUVw3WS/u3hzDl22oMGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117728471"
Received: from linux-pnp-server-17.sh.intel.com ([10.239.166.49])
  by orviesa007.jf.intel.com with ESMTP; 27 Feb 2025 18:00:06 -0800
From: Pan Deng <pan.deng@intel.com>
To: brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org
Cc: tianyou.li@intel.com,
	tim.c.chen@linux.intel.com,
	lipeng.zhu@intel.com,
	pan.deng@intel.com
Subject: [PATCH] fs: place f_ref to 3rd cache line in struct file to resolve false sharing
Date: Fri, 28 Feb 2025 10:00:59 +0800
Message-ID: <20250228020059.3023375-1-pan.deng@intel.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running syscall pread in a high core count system, f_ref contends
with the reading of f_mode, f_op, f_mapping, f_inode, f_flags in the
same cache line.

This change places f_ref to the 3rd cache line where fields are not
updated as frequently as the 1st cache line, and the contention is
grealy reduced according to tests. In addition, the size of file
object is kept in 3 cache lines.

This change has been tested with rocksdb benchmark readwhilewriting case
in 1 socket 64 physical core 128 logical core baremetal machine, with
build config CONFIG_RANDSTRUCT_NONE=y
Command:
./db_bench --benchmarks="readwhilewriting" --threads $cnt --duration 60
The throughput(ops/s) is improved up to ~21%.
=====
thread		baseline	compare
16		 100%		 +1.3%
32		 100%		 +2.2%
64		 100%		 +7.2%
128		 100%		 +20.9%

It was also tested with UnixBench: syscall, fsbuffer, fstime,
fsdisk cases that has been used for file struct layout tuning, no
regression was observed.

Signed-off-by: Pan Deng <pan.deng@intel.com>
Reviewed-by: Tianyou Li <tianyou.li@intel.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Tested-by: Lipeng Zhu <lipeng.zhu@intel.com>
---
 include/linux/fs.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2c3b2f8a621f..63b402cc9219 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1067,7 +1067,6 @@ static inline int ra_has_index(struct file_ra_state *ra, pgoff_t index)
 
 /**
  * struct file - Represents a file
- * @f_ref: reference count
  * @f_lock: Protects f_ep, f_flags. Must not be taken from IRQ context.
  * @f_mode: FMODE_* flags often used in hotpaths
  * @f_op: file operations
@@ -1090,9 +1089,9 @@ static inline int ra_has_index(struct file_ra_state *ra, pgoff_t index)
  * @f_llist: work queue entrypoint
  * @f_ra: file's readahead state
  * @f_freeptr: Pointer used by SLAB_TYPESAFE_BY_RCU file cache (don't touch.)
+ * @f_ref: reference count
  */
 struct file {
-	file_ref_t			f_ref;
 	spinlock_t			f_lock;
 	fmode_t				f_mode;
 	const struct file_operations	*f_op;
@@ -1102,6 +1101,7 @@ struct file {
 	unsigned int			f_flags;
 	unsigned int			f_iocb_flags;
 	const struct cred		*f_cred;
+	u8				padding[8];
 	/* --- cacheline 1 boundary (64 bytes) --- */
 	struct path			f_path;
 	union {
@@ -1127,6 +1127,7 @@ struct file {
 		struct file_ra_state	f_ra;
 		freeptr_t		f_freeptr;
 	};
+	file_ref_t			f_ref;
 	/* --- cacheline 3 boundary (192 bytes) --- */
 } __randomize_layout
   __attribute__((aligned(4)));	/* lest something weird decides that 2 is OK */
-- 
2.43.5


