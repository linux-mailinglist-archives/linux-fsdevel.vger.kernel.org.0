Return-Path: <linux-fsdevel+bounces-22178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 485B79134C6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2024 17:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76CC1F21B35
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2024 15:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CA016FF59;
	Sat, 22 Jun 2024 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dUVUWlc2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1902C16F918;
	Sat, 22 Jun 2024 15:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719069792; cv=none; b=CZ8Tb899QuFMPeff+r9MDKnvHeBNdpe/eLa2DZj0mXmCrjhiFq4Ek+tEX+HC6BwEu8HyLZQ1KFETH5bxlCGm2+uwAxXXIvX5AGNZ+ndOk4bCc6CAkjJzIzYZjLD7JlRCbESGPbWuxHXROuJvD6qcLID0AuE8LbLlMSPXJ/HCXIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719069792; c=relaxed/simple;
	bh=090Oenp2xYBj31TJSwOgyDVmmqhieSXMUyvU+EdGtCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hoa4lpvh90aLqU8Kscgoh9j5ls4KeDAi/di1h/mfUOwNkvCbbNOtjk8G5+/48XpStwd0JbIGRv/6s95LyEdzOyAH2L/JCoCWcNzgLtU9D+P6fgGt4Cbv50XatpBLdEjS11cwvNcfD+yebUyGCszXdnUnd/ElVtIsGNajSCiwWAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dUVUWlc2; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719069791; x=1750605791;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=090Oenp2xYBj31TJSwOgyDVmmqhieSXMUyvU+EdGtCE=;
  b=dUVUWlc2RjsV3j7GLBQ0lCTZn19KGO3ECtL1BmAcOMnveCD7w/0KE6ps
   LpXSFh5r3cq0rlKd4RhaSUzIcwqLtO2vGGOoWUrNZk2/+M+s0iGucU1Qb
   /1HnjS8lKiqvS6AdbeaAZxScog6uSXQXdvek2CS/4AgHFGlieS08rwHYv
   KdeNfX1JX3HMn3MCyWZpMTuT28Hn3nj+3usLvgx+4+GOIpVEZuPk8fhZ4
   m2KJeh5QSiVUMQgx04I6m8CZ1m2nFjIOjunhJS5u4JEjU1UIY4Lhn/wHV
   Htyt9DQz6yVNamEiI56ANRtw4BFKMGS/jjLI/3k7Mu4WN7C6Cba6/V3Li
   g==;
X-CSE-ConnectionGUID: A/N53p59RzCm8CVGnv6mnQ==
X-CSE-MsgGUID: 4AZ2bA7WQTm69EqwaaBQcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11111"; a="41495806"
X-IronPort-AV: E=Sophos;i="6.08,258,1712646000"; 
   d="scan'208";a="41495806"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2024 08:23:11 -0700
X-CSE-ConnectionGUID: xDaJIqpyTqCByot2QvZNTA==
X-CSE-MsgGUID: k8vnp9ckQQ+3ZRmCcXKjKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,258,1712646000"; 
   d="scan'208";a="42680518"
Received: from linux-pnp-server-16.sh.intel.com ([10.239.177.152])
  by fmviesa006.fm.intel.com with ESMTP; 22 Jun 2024 08:23:08 -0700
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
Subject: [PATCH v2 1/3] fs/file.c: add fast path in alloc_fd()
Date: Sat, 22 Jun 2024 11:49:02 -0400
Message-ID: <20240622154904.3774273-2-yu.ma@intel.com>
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

There is available fd in the lower 64 bits of open_fds bitmap for most cases
when we look for an available fd slot. Skip 2-levels searching via
find_next_zero_bit() for this common fast path.

Look directly for an open bit in the lower 64 bits of open_fds bitmap when a
free slot is available there, as:
(1) The fd allocation algorithm would always allocate fd from small to large.
Lower bits in open_fds bitmap would be used much more frequently than higher
bits.
(2) After fdt is expanded (the bitmap size doubled for each time of expansion),
it would never be shrunk. The search size increases but there are few open fds
available here.
(3) find_next_zero_bit() itself has a fast path inside to speed up searching
when size<=64.

Besides, "!start" is added to fast path condition to ensure the allocated fd is
greater than start (i.e. >=0), given alloc_fd() is only called in two scenarios:
(1) Allocating a new fd (the most common usage scenario) via
get_unused_fd_flags() to find fd start from bit 0 in fdt (i.e. start==0).
(2) Duplicating a fd (less common usage) via dup_fd() to find a fd start from
old_fd's index in fdt, which is only called by syscall fcntl.

With the fast path added in alloc_fd(), pts/blogbench-1.1.0 read is improved
by 17% and write by 9% on Intel ICX 160 cores configuration with v6.10-rc4.

Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Yu Ma <yu.ma@intel.com>
---
 fs/file.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index a3b72aa64f11..50e900a47107 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -515,28 +515,35 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
 	if (fd < files->next_fd)
 		fd = files->next_fd;
 
-	if (fd < fdt->max_fds)
+	error = -EMFILE;
+	if (likely(fd < fdt->max_fds)) {
+		if (~fdt->open_fds[0] && !start) {
+			fd = find_next_zero_bit(fdt->open_fds, BITS_PER_LONG, fd);
+			goto fastreturn;
+		}
 		fd = find_next_fd(fdt, fd);
+	}
+
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
 
+fastreturn:
 	/*
 	 * N.B. For clone tasks sharing a files structure, this test
 	 * will limit the total number of files that can be opened.
 	 */
-	error = -EMFILE;
-	if (fd >= end)
+	if (unlikely(fd >= end))
 		goto out;
 
-	error = expand_files(files, fd);
-	if (error < 0)
-		goto out;
-
-	/*
-	 * If we needed to expand the fs array we
-	 * might have blocked - try again.
-	 */
-	if (error)
-		goto repeat;
-
 	if (start <= files->next_fd)
 		files->next_fd = fd + 1;
 
-- 
2.43.0


