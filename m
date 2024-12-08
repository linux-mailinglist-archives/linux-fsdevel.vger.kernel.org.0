Return-Path: <linux-fsdevel+bounces-36710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 889939E8733
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2024 19:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49F34281A83
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Dec 2024 18:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542EA189BA8;
	Sun,  8 Dec 2024 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYv6BBKa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35774690
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Dec 2024 18:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733681241; cv=none; b=Z1zRQAp6JnYRC0JPpDkwVGQsjZQ+BDfI7g4nhqDvZcNn2P2FT5zGNXOBt25wxSc0FqgftPOAqo5mTWI1Vo/9T8qiT4vhB1jq8mySmJ08cOSkf/dN/DiGqth8a+pnx9TU/zzNWH8jX9ADvku1RPyryiiyCt1mvHJrUs1ExPtKsQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733681241; c=relaxed/simple;
	bh=V1CgRxZBwZNmgx/smRVKpeWE8D3gg3C9nUGKjmxcNbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RizPwBkAOjZMzwfNyIb3FDVpqD5gDkEydQhGIoGUYfaqFAI4+KUGjqZrVja+f4D46+NVxJQJnGxdvnLV/L27uOYiEA1S9A96mpxoGVOo1utkvsMNMMjHGGw+lIFQhrphiCkt2+FQWAPOhfD9Tkg1dCOfib6O10tVdkYdu4UfQ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYv6BBKa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C22C4CED2;
	Sun,  8 Dec 2024 18:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733681241;
	bh=V1CgRxZBwZNmgx/smRVKpeWE8D3gg3C9nUGKjmxcNbs=;
	h=From:To:Cc:Subject:Date:From;
	b=rYv6BBKaH8rQQISPGJyHqEY3TM7oQacWoayqrCvN73CBBVwQqFvm7t9HPfkdyRTQk
	 YV55Xd31dSEaCrbysI0tsegPLc7IqNnmG5E/WFcza2YIHCwtGM2GwUz+AJdNXOTfRA
	 SJhIznPhW5J97G2dBo9iPfHboFjAgJb8XlYZp03QLr+pOEwCs8D6YTtxQu85chSBUR
	 yVumqI5LwXtXaV1Q8Zq7L3AZHsNyaUQF7eLtloTxm0W3n5hYXCnp23FYIlKvt0Axnt
	 HNA1zD7xO/Yu6jgH+G5/Mq5Y13kju9woumW/oA82bfZxq1Wfv3QRtxCfoVWRf+omvB
	 fMgCUy22zkpJA==
From: cel@kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: <linux-fsdevel@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] fstests: disable generic duperemove tests for NFS and others
Date: Sun,  8 Dec 2024 13:07:18 -0500
Message-ID: <20241208180718.930987-1-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On NFS mounts, at least, generic/559, 560, and 561 run for a very
long time, and usually fail.

The above tests already gate on whether duperemove is installed on
the test system, but when fstests is installed as part of an
automated workflow designed to handle many filesystem types,
duperemove is installed by default.

duperemove(8) states:

  Deduplication is currently only supported by the btrfs and xfs
  filesystem.

Ensure that the generic dedupe tests are run on only filesystems
where duperemove is known to work.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 tests/generic/559 | 1 +
 tests/generic/560 | 1 +
 tests/generic/561 | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tests/generic/559 b/tests/generic/559
index 28cf2e1a32c2..cf80be92142d 100755
--- a/tests/generic/559
+++ b/tests/generic/559
@@ -13,6 +13,7 @@ _begin_fstest auto stress dedupe
 . ./common/filter
 . ./common/reflink
 
+_supported_fs btrfs xfs
 _require_scratch_duperemove
 
 fssize=$((2 * 1024 * 1024 * 1024))
diff --git a/tests/generic/560 b/tests/generic/560
index 067d3ec0049e..a94b512efda1 100755
--- a/tests/generic/560
+++ b/tests/generic/560
@@ -15,6 +15,7 @@ _begin_fstest auto stress dedupe
 . ./common/filter
 . ./common/reflink
 
+_supported_fs btrfs xfs
 _require_scratch_duperemove
 
 _scratch_mkfs > $seqres.full 2>&1
diff --git a/tests/generic/561 b/tests/generic/561
index afe727ac56cb..da5f111c5b23 100755
--- a/tests/generic/561
+++ b/tests/generic/561
@@ -28,6 +28,7 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
+_supported_fs btrfs xfs
 _require_scratch_duperemove
 
 _scratch_mkfs > $seqres.full 2>&1
-- 
2.47.0


