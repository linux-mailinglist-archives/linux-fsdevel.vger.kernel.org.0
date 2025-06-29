Return-Path: <linux-fsdevel+bounces-53230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 927DFAECB96
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Jun 2025 09:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B128D17656B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Jun 2025 07:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BAC1EDA1E;
	Sun, 29 Jun 2025 07:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oe3xpJaW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F752BAF9;
	Sun, 29 Jun 2025 07:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751182824; cv=none; b=VKddyw7XIdqAldd9gXv+ksL1x0Xtd8TOrWPyaR7yYcxAKqUd9zfswz1A9ADtgf1hfa7oXFtc4qgsST0ejhwj9qHg1k9bsTN1CvK8GdkBsOe3hM73HjzI6LlPILodcj25rnLJDfobeRpJ7NDHNarMJjgDcmh+s104yuunlvfq8RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751182824; c=relaxed/simple;
	bh=0pkDIgKgJcoIUak+Q1ldoChrgf3t0SaaqA9PQnbbfxc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U2Ll1o8P6pVSyMp1TjyNfHQzAwWG/W42TGAlTXE1LevkRqF7hI+uYMyXry7uH+0FTZBcS1O61Uz6Y76TIhsxksIJxE6OmLlOKPEsEsYoH3hHEB4S/GCcfUz4krCI2PH+CzJsMPDcVVfN43NkoFyL6S63lISOqm8DzCx2XcRft98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oe3xpJaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD6BC4CEEB;
	Sun, 29 Jun 2025 07:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751182824;
	bh=0pkDIgKgJcoIUak+Q1ldoChrgf3t0SaaqA9PQnbbfxc=;
	h=From:To:Cc:Subject:Date:From;
	b=Oe3xpJaWpxtOyptwR4HtiXngqEQK1RBeOE5fAHBhhTnC0ISfLwP73JpchWZwf0Bhm
	 Nezfi/blHNfNkscVLx5pxkAu4YfgaI7RyEM9FV4kJzHjIFMbZeIxZdedNCXz7yTLrK
	 eNtsHCECT5Lgn+HVg7sNbcR+7ppZr5YTtNV18hsJFcncjcUmYof8TKe6A3Z0VnHVwb
	 91R1YpKZlvDAKD0+V5++wstSAj1A2kYANfblm4KfxgmSQbka0gGRwZKF5G5RkP0mCH
	 ZuPUE5tbQn2cISPxyjrjsWucy/WzQ3PM5CS2SGGdAIZWc8AN2On86eT8zlaoPj/hw0
	 BZTHRd//F4D5g==
From: Sasha Levin <sashal@kernel.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	akpm@linux-foundation.org,
	dada1@cosmosbay.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] fs: Prevent file descriptor table allocations exceeding INT_MAX
Date: Sun, 29 Jun 2025 03:40:21 -0400
Message-Id: <20250629074021.1038845-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When sysctl_nr_open is set to a very high value (for example, 1073741816
as set by systemd), processes attempting to use file descriptors near
the limit can trigger massive memory allocation attempts that exceed
INT_MAX, resulting in a WARNING in mm/slub.c:

  WARNING: CPU: 0 PID: 44 at mm/slub.c:5027 __kvmalloc_node_noprof+0x21a/0x288

This happens because kvmalloc_array() and kvmalloc() check if the
requested size exceeds INT_MAX and emit a warning when the allocation is
not flagged with __GFP_NOWARN.

Specifically, when nr_open is set to 1073741816 (0x3ffffff8) and a
process calls dup2(oldfd, 1073741880), the kernel attempts to allocate:
- File descriptor array: 1073741880 * 8 bytes = 8,589,935,040 bytes
- Multiple bitmaps: ~400MB
- Total allocation size: > 8GB (exceeding INT_MAX = 2,147,483,647)

Reproducer:
1. Set /proc/sys/fs/nr_open to 1073741816:
   # echo 1073741816 > /proc/sys/fs/nr_open

2. Run a program that uses a high file descriptor:
   #include <unistd.h>
   #include <sys/resource.h>

   int main() {
       struct rlimit rlim = {1073741824, 1073741824};
       setrlimit(RLIMIT_NOFILE, &rlim);
       dup2(2, 1073741880);  // Triggers the warning
       return 0;
   }

3. Observe WARNING in dmesg at mm/slub.c:5027

systemd commit a8b627a introduced automatic bumping of fs.nr_open to the
maximum possible value. The rationale was that systems with memory
control groups (memcg) no longer need separate file descriptor limits
since memory is properly accounted. However, this change overlooked
that:

1. The kernel's allocation functions still enforce INT_MAX as a maximum
   size regardless of memcg accounting
2. Programs and tests that legitimately test file descriptor limits can
   inadvertently trigger massive allocations
3. The resulting allocations (>8GB) are impractical and will always fail

systemd's algorithm starts with INT_MAX and keeps halving the value
until the kernel accepts it. On most systems, this results in nr_open
being set to 1073741816 (0x3ffffff8), which is just under 1GB of file
descriptors.

While processes rarely use file descriptors near this limit in normal
operation, certain selftests (like
tools/testing/selftests/core/unshare_test.c) and programs that test file
descriptor limits can trigger this issue.

Fix this by adding a check in alloc_fdtable() to ensure the requested
allocation size does not exceed INT_MAX. This causes the operation to
fail with -EMFILE instead of triggering a kernel warning and avoids the
impractical >8GB memory allocation request.

Fixes: 9cfe015aa424 ("get rid of NR_OPEN and introduce a sysctl_nr_open")
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/file.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/file.c b/fs/file.c
index b6db031545e65..6d2275c3be9c6 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -197,6 +197,21 @@ static struct fdtable *alloc_fdtable(unsigned int slots_wanted)
 			return ERR_PTR(-EMFILE);
 	}
 
+	/*
+	 * Check if the allocation size would exceed INT_MAX. kvmalloc_array()
+	 * and kvmalloc() will warn if the allocation size is greater than
+	 * INT_MAX, as filp_cachep objects are not __GFP_NOWARN.
+	 *
+	 * This can happen when sysctl_nr_open is set to a very high value and
+	 * a process tries to use a file descriptor near that limit. For example,
+	 * if sysctl_nr_open is set to 1073741816 (0x3ffffff8) - which is what
+	 * systemd typically sets it to - then trying to use a file descriptor
+	 * close to that value will require allocating a file descriptor table
+	 * that exceeds 8GB in size.
+	 */
+	if (unlikely(nr > INT_MAX / sizeof(struct file *)))
+		return ERR_PTR(-EMFILE);
+
 	fdt = kmalloc(sizeof(struct fdtable), GFP_KERNEL_ACCOUNT);
 	if (!fdt)
 		goto out;
-- 
2.39.5


