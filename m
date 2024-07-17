Return-Path: <linux-fsdevel+bounces-23830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B07933E5A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 16:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F2111C20DAC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 14:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70F1181CE7;
	Wed, 17 Jul 2024 14:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kOo5jTEk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF04181BB5;
	Wed, 17 Jul 2024 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721226271; cv=none; b=tejT1pUmqQSWbStRLv/WffV+a7O0v+uSdQm4d7svL0CfPxoQ+v6xZI6uHgMzTdaTzGPgByecFo2LaaZb/5ZyspnuLw8Ymr4c2+HILUVvjzgolV9sUpoKGJVD7UjpdeDSJBxg+AG0jRCuLqe3KVBfkr68GG6V8LkUfBo/QKRMtm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721226271; c=relaxed/simple;
	bh=TR9wDqpaITrEN63de3ORwuMv6UCzobFiwu1pNhvmIH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ejwh6Khl4TCDFnc2T1OJ3VvZaO7rTi9aNuzdUXMxY9F40ddDOYNQUHKicBvKD7iJLqkyhgQOKMOZMONFFcvtTRdNAwerkRKK7lQBuds8ImozhRU2Dera6vT02kcU+okvmI9cP0V2BhDz+4+UlkQ9JxWV8HMnTTfpQJXK7D6njnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kOo5jTEk; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721226270; x=1752762270;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TR9wDqpaITrEN63de3ORwuMv6UCzobFiwu1pNhvmIH8=;
  b=kOo5jTEkDndahHaQuPu/myMUDDITiakP+CQPxXOB8yOE+/3fR0Qb1Wlb
   7Y+bjgdCWnoHdxh75nT9DPvDNM/rOqlrCCWvqd14z3m2cdiqJ4EgebDDK
   jZjXwOW6BV47lWcei/o9WwWWKBpJlI4VGAL3B+ceh49OPlKe+8iSXXrGo
   UFv3WsEx786YyEt9g6oz/ek79pSPVmlWygb16msWXbUFhUG27bYOmu5sg
   7NxtoWHlT10Y5kSCIggmFR30wzxr6EUPk4W10Lxf7gYh1t3MpaIJ7KPQe
   wybwoP2HBjOSDdXIyf6PP1j7M5fmOoCDBQLHZ4PvIqfiUwHFGZDrG18N4
   g==;
X-CSE-ConnectionGUID: LlNYvW49TtOsVPs8Zy0k8A==
X-CSE-MsgGUID: lwl3qL3VSGGP8gkSeNJy6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="29313624"
X-IronPort-AV: E=Sophos;i="6.09,214,1716274800"; 
   d="scan'208";a="29313624"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 07:24:30 -0700
X-CSE-ConnectionGUID: jKjpkE64RcWgbvztYQJWZA==
X-CSE-MsgGUID: Rz9R95s5QwWZRtGtSSAW5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,214,1716274800"; 
   d="scan'208";a="54596639"
Received: from linux-pnp-server-16.sh.intel.com ([10.239.177.152])
  by fmviesa003.fm.intel.com with ESMTP; 17 Jul 2024 07:24:27 -0700
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
Subject: [PATCH v5 3/3] fs/file.c: add fast path in find_next_fd()
Date: Wed, 17 Jul 2024 10:50:18 -0400
Message-ID: <20240717145018.3972922-4-yu.ma@intel.com>
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

Skip 2-levels searching via find_next_zero_bit() when there is free slot in the
word contains next_fd, as:
(1) next_fd indicates the lower bound for the first free fd.
(2) There is fast path inside of find_next_zero_bit() when size<=64 to speed up
searching.
(3) After fdt is expanded (the bitmap size doubled for each time of expansion),
it would never be shrunk. The search size increases but there are few open fds
available here.

This fast path is proposed by Mateusz Guzik <mjguzik@gmail.com>, and agreed by
Jan Kara <jack@suse.cz>, which is more generic and scalable than previous
versions. And on top of patch 1 and 2, it improves pts/blogbench-1.1.0 read by
8% and write by 4% on Intel ICX 160 cores configuration with v6.10-rc7.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Yu Ma <yu.ma@intel.com>
---
 fs/file.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/file.c b/fs/file.c
index 1be2a5bcc7c4..729c07a4fc28 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -491,6 +491,15 @@ static unsigned int find_next_fd(struct fdtable *fdt, unsigned int start)
 	unsigned int maxfd = fdt->max_fds; /* always multiple of BITS_PER_LONG */
 	unsigned int maxbit = maxfd / BITS_PER_LONG;
 	unsigned int bitbit = start / BITS_PER_LONG;
+	unsigned int bit;
+
+	/*
+	 * Try to avoid looking at the second level bitmap
+	 */
+	bit = find_next_zero_bit(&fdt->open_fds[bitbit], BITS_PER_LONG,
+				 start & (BITS_PER_LONG - 1));
+	if (bit < BITS_PER_LONG)
+		return bit + bitbit * BITS_PER_LONG;
 
 	bitbit = find_next_zero_bit(fdt->full_fds_bits, maxbit, bitbit) * BITS_PER_LONG;
 	if (bitbit >= maxfd)
-- 
2.43.0


