Return-Path: <linux-fsdevel+bounces-71885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C083FCD7635
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 23:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A1343301C887
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 22:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3627A343206;
	Mon, 22 Dec 2025 22:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8ub/J/p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849CE33E37D;
	Mon, 22 Dec 2025 22:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766444242; cv=none; b=F3ytusoZOtYbcf2SvzFVtKDSraZlpRXGCdu66Tj18dN8M/ZPLcJzVKPHU8p04y2sE80xeI1//d+WZDiSnTJHX6nlavO9uizgNY1o55itxnxX8n/8+3f3oY8pKyb8pob2UtHk5nT6oXfHufK+QmbBs6wxeWA7Rhh5kdM9L2qN9C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766444242; c=relaxed/simple;
	bh=kiFkBV19SEaKSQI5naijfJgcIAR87bXTQeRpdnoIW3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O+nY5HmgKLraZVahjobgy9SJaK1gsVx50LtcEKWrYhmj3/rL+oz/YPDfNB+jPsdHDV211V0IpoaaxJhifkAWj6JN8+vS1Hzdosgw/eTnp2CqDUaR4an/galw32h2qjZKVp1oK9J67fYCTXTnPX0iIx2ut68yTVWhXbKrEHN348Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t8ub/J/p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39A7C19422;
	Mon, 22 Dec 2025 22:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766444242;
	bh=kiFkBV19SEaKSQI5naijfJgcIAR87bXTQeRpdnoIW3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t8ub/J/pxWDsmVEqt8sd1WlfV4pWtlRcBi8/sBuSi0ahLzsk+E05QiRaprTtXJ/mB
	 t2kk16ZoxFQMLgp29Uoyf7yPBD8aL9WrDQJTe22WimcEeWwT/XlDKYpLA3A/IO7w10
	 +yLnaQ8SL4PRSP/PN+gQ0O3UHQuw194BiDppSty56qwLiQJr6dARTlszGG/w4VuJFY
	 I5XSeFy1hgWbS+++/WzTV54JRrnTRPaMER4HZKwS2Qx/Thatoam1jQDvSk7DFs8EZT
	 2W9VGG/HSKZ6nvG9D/0w/+hW5/FJUxhiy23s9/UIxhbej+ukCuoM8u0/IvRgsnaEmp
	 fZB6kO7UeZe2w==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/11] tools headers: Sync UAPI linux/fs.h with kernel sources
Date: Mon, 22 Dec 2025 14:57:09 -0800
Message-ID: <20251222225716.3565649-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
In-Reply-To: <20251222225716.3565649-1-namhyung@kernel.org>
References: <20251222225716.3565649-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up changes from:

  b30ffcdc0c15a88f ("block: introduce BLKREPORTZONESV2 ioctl")
  0d8627cc936de8ea ("blktrace: add definitions for blk_user_trace_setup2")

This should be used to beautify ioctl syscall arguments and it addresses
these tools/perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/perf/trace/beauty/include/uapi/linux/fs.h include/uapi/linux/fs.h

Please see tools/include/README.kernel-copies.

Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/trace/beauty/include/uapi/linux/fs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/include/uapi/linux/fs.h b/tools/perf/trace/beauty/include/uapi/linux/fs.h
index beb4c2d1e41cb1bb..66ca526cf786c761 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/fs.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/fs.h
@@ -298,8 +298,9 @@ struct file_attr {
 #define BLKROTATIONAL _IO(0x12,126)
 #define BLKZEROOUT _IO(0x12,127)
 #define BLKGETDISKSEQ _IOR(0x12,128,__u64)
-/* 130-136 are used by zoned block device ioctls (uapi/linux/blkzoned.h) */
+/* 130-136 and 142 are used by zoned block device ioctls (uapi/linux/blkzoned.h) */
 /* 137-141 are used by blk-crypto ioctls (uapi/linux/blk-crypto.h) */
+#define BLKTRACESETUP2 _IOWR(0x12, 142, struct blk_user_trace_setup2)
 
 #define BMAP_IOCTL 1		/* obsolete - kept for compatibility */
 #define FIBMAP	   _IO(0x00,1)	/* bmap access */
-- 
2.52.0.351.gbe84eed79e-goog


