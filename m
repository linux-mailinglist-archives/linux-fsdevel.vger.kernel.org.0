Return-Path: <linux-fsdevel+bounces-71886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 859DBCD7659
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 23:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A71D3070CA9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 22:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC9E3451AA;
	Mon, 22 Dec 2025 22:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4bpIDcc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D278A33F8B1;
	Mon, 22 Dec 2025 22:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766444242; cv=none; b=A13xpMospYVQqcvRAo8LZl03X8yTqJxr50Er0w47aVNNzfUUzzXW2B1uEV0ZHB2PtAq37WgtTUAkIjiBcJW0YM4S1I9AZdweyGgAKIhKZcKnfUQPq8Hx4RbYmWRd6Mur6x5IfXxgVicdj0EISyGBBS5ufOAVc+0BVDg4YuLi/aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766444242; c=relaxed/simple;
	bh=FwSiAEyJtEd/q6VDaW2QXF9zQP4+P1BGW+1/bjUTDNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QUtVi9nKPJRtvJuCaYMNc73kvN0y67EA7O8arhVhxMQdQHg2Lz0MFLgJe63vSlN3VLkV9a+mzJrLFJGOO7NW3ki941PsWSvYjKAcbFLLdLaKc66w1T5jtw451pH8h/PwAcYcE0qDsMKvZcd0A/rVvm3jkb3QpLZpKdfk8GUig1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4bpIDcc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCD8C4CEF1;
	Mon, 22 Dec 2025 22:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766444242;
	bh=FwSiAEyJtEd/q6VDaW2QXF9zQP4+P1BGW+1/bjUTDNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p4bpIDcck9GVvj07Ffwc7HFbkL4Vpth/ofPjUTMClXu0a0OgtuYfHiyFh1M8Po1KN
	 3Qw9uwMXawAuW2CV2fT0ZrgBRLmQ1IYpspQ01nT61LUbQcAyTzYNxpkBHF9GhCtD7z
	 YdbTvBhVzWuNn+6urFfgfRZTRyDFaajOZjXxB163VOa40T3YkM3V9up1npAEN4Oa7n
	 eIOZQMht/tFOnnimDPJ5PdSN0LgnM6O1ZRlV6CLHr8Ne1tEHh2+LhKFn6sEO8oBjOD
	 wzBJSrKc0oGgtigoSZMwUCsNq1N5PwrW6kJsQP19H3ZvIFazwUPOryckbm06Oz//xC
	 +SYShAaQQrvrg==
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
Subject: [PATCH 05/11] tools headers: Sync UAPI linux/mount.h with kernel sources
Date: Mon, 22 Dec 2025 14:57:10 -0800
Message-ID: <20251222225716.3565649-5-namhyung@kernel.org>
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

  78f0e33cd6c939a5 ("fs/namespace: correctly handle errors returned by grab_requested_mnt_ns")

This should be used to beautify mount syscall arguments and it addresses
these tools/perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/perf/trace/beauty/include/uapi/linux/mount.h include/uapi/linux/mount.h

Please see tools/include/README.kernel-copies.

Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/trace/beauty/include/uapi/linux/mount.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/include/uapi/linux/mount.h b/tools/perf/trace/beauty/include/uapi/linux/mount.h
index 7fa67c2031a5db52..5d3f8c9e3a6256b4 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/mount.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/mount.h
@@ -197,7 +197,7 @@ struct statmount {
  */
 struct mnt_id_req {
 	__u32 size;
-	__u32 spare;
+	__u32 mnt_ns_fd;
 	__u64 mnt_id;
 	__u64 param;
 	__u64 mnt_ns_id;
-- 
2.52.0.351.gbe84eed79e-goog


