Return-Path: <linux-fsdevel+bounces-23035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0439262E2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 16:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA2CD1F22F7B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 14:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7FF1802DF;
	Wed,  3 Jul 2024 14:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OPzep+Ir"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2F617FABD;
	Wed,  3 Jul 2024 14:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015646; cv=none; b=OPHdQnT8fPHoN5aBPHZFqb+EJNCD7Ns68pz7mF/1AdR4AfN001eoJvLPkk6LVgQXESHCOGjBZ9ekrUrtRhX9B8zpnDr34BCv6hgg1xxznpgJMsAkpMnKabLC+isxx+7jKBwN7DVpHfHKG3V30iKMe3OuWfkHmQ0hQlNBeg+5TYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015646; c=relaxed/simple;
	bh=L4N3eNb+hTwnRqOC9zrQnPwJrLZ4wp6PpFdHRrO6tkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CB+TpC+k3yQnLeAg3DZPf1DEFldXoWdNQP/DnRJ5qU/IyHu39fE3iumQwci1kool33PrqVWoYXimQkFbDCOGNyddrLt2ota3xxok7dBQ9VaQa5OW2FUgp7ZwsR/JZ0u9/TqF21g1RZxA0YigPz4GhEkJcL+UmNfQy3ASk2Qu8mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OPzep+Ir; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720015646; x=1751551646;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L4N3eNb+hTwnRqOC9zrQnPwJrLZ4wp6PpFdHRrO6tkU=;
  b=OPzep+Ir+doochKpEDrcqT1JZoPWQDB3bV6reFOaERd7S78yctGt1zv8
   9a+SL6LwtkwptFeBo5SB4OurgncPZ+NmMLBeWb6EEle1BrNqASIxTC6U0
   1haZtdtl0N0qi7gqkP/xCQCOkYKzKKs+WsvTkjbVoKnnezVgl5mFsKIMW
   5W/ZVWG0pF8Xh1pz20/BBZWaKL1pbTm70z4PLjri5kdpWupcaDCg4jWbv
   veD6Q+UrJg+Flz5DCNR/vGRfqk2Al0NDdRk72x0qzlH69fKcxeb8TiFtT
   /ISt+z+7xmS2xUw5ShG41SUjmgLaEmqR11u6wHErZpjevcBrCc6J17vxU
   A==;
X-CSE-ConnectionGUID: sUSNJtu0Q2CXUWw8/6PWfA==
X-CSE-MsgGUID: Kg3WhDsxQ1mf51F+SnBBjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="16900731"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="16900731"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 07:07:25 -0700
X-CSE-ConnectionGUID: mTsZkbyJTsapUGliTg5XdQ==
X-CSE-MsgGUID: h119Mf75TQOy7vvAYg3Iaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="46693515"
Received: from linux-pnp-server-16.sh.intel.com ([10.239.177.152])
  by orviesa006.jf.intel.com with ESMTP; 03 Jul 2024 07:07:22 -0700
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
Subject: [PATCH v3 3/3] fs/file.c: add fast path in find_next_fd()
Date: Wed,  3 Jul 2024 10:33:11 -0400
Message-ID: <20240703143311.2184454-4-yu.ma@intel.com>
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
(3) There is fast path inside of find_next_zero_bit() when size<=64 to speed up
searching.

As suggested by Mateusz Guzik <mjguzik gmail.com> and Jan Kara <jack@suse.cz>,
update the fast path from alloc_fd() to find_next_fd(). With which, on top of
patch 1 and 2, pts/blogbench-1.1.0 read is improved by 13% and write by 7% on
Intel ICX 160 cores configuration with v6.10-rc6.

Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Yu Ma <yu.ma@intel.com>
---
 fs/file.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/file.c b/fs/file.c
index a15317db3119..f25eca311f51 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -488,6 +488,11 @@ struct files_struct init_files = {
 
 static unsigned int find_next_fd(struct fdtable *fdt, unsigned int start)
 {
+	unsigned int bit;
+	bit = find_next_zero_bit(fdt->open_fds, BITS_PER_LONG, start);
+	if (bit < BITS_PER_LONG)
+		return bit;
+
 	unsigned int maxfd = fdt->max_fds; /* always multiple of BITS_PER_LONG */
 	unsigned int maxbit = maxfd / BITS_PER_LONG;
 	unsigned int bitbit = start / BITS_PER_LONG;
-- 
2.43.0


