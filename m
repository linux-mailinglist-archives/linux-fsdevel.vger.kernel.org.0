Return-Path: <linux-fsdevel+bounces-24564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE413940767
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68E53283739
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 05:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B9719EEBF;
	Tue, 30 Jul 2024 05:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFBvDFOH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD8819E833;
	Tue, 30 Jul 2024 05:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316517; cv=none; b=A+qLWDZSpTvuWEciDesAZYuCqHd8WHfdOzd5jxFWEL3/ywzEiC/HTEbrrCyVnuHlnE9FLEpkdmYHqA8yw53C/Sr27uWQdM3oZMHbDk9cS2niMoJSj9CxmW2mPtCUx7WXbOcYaxsQXsDN06ksuCn6ycD20WFWvNmi75nfX5eD/Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316517; c=relaxed/simple;
	bh=xeDLFzUS1+B+uAh15XjSY5PKhu6A4AinBVe4VaaGqS0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aKFZqdOencEfXzh12yrGT/O0Rwagmnxaq02fYvUjLmC+gW92dPVaBlL3VOPBKaJ3OQMHYgwDvTgl7M+nzwrsv/YoK8EhitOfjp1R6yMzJEvpb5ljdkMeU3pHu28LFWmw8gmrHFby2nEdyUNBogqj/tnCtHSqvKO0Oxar+m2Cr08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFBvDFOH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F136C4AF0F;
	Tue, 30 Jul 2024 05:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722316516;
	bh=xeDLFzUS1+B+uAh15XjSY5PKhu6A4AinBVe4VaaGqS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tFBvDFOHiGzYfXaU3RHpawLJoWktIe3M19l7hbzYc1b5fsIh+gT1SroCgyDRM0HgF
	 pr8ug85KvNs6QG5KJV+D39yMRQyAogVhMjLCMxVkKjEw2v+m5G7AvRN7YRCsq+Sfav
	 ZGP2oHq41BlZimC/dBPRl89mfifxzKahGHhZFJ3+UlnpLt8iO7STjVTEFSCEx/QyTw
	 Snb5M+xC9Gm65XGYQH80QVGgtiYJ0rAlfWrzBIfIk6CVG0XRNIrHOCeCCE0HXT1Uu+
	 I04IJLs0a/mukWKc34Upl1+l3C7Ldw162ruK8++jeZuyqmhEppUUzQzJ082wA9Oj2c
	 eDps3dA7skCvA==
From: viro@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: amir73il@gmail.com,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 32/39] convert vfs_dedupe_file_range().
Date: Tue, 30 Jul 2024 01:16:18 -0400
Message-Id: <20240730051625.14349-32-viro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240730051625.14349-1-viro@kernel.org>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

fdput() is followed by checking fatal_signal_pending() (and aborting
the loop in such case).  fdput() is transposable with that check.
Yes, it'll probably end up with slightly fatter code (call after the
check has returned false + call on the almost never taken out-of-line path
instead of one call before the check), but it's not worth bothering with
explicit extra scope there (or dragging the check into the loop condition,
for that matter).

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/remap_range.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/remap_range.c b/fs/remap_range.c
index 017d0d1ea6c9..26afbbbfb10c 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -536,7 +536,7 @@ int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
 	}
 
 	for (i = 0, info = same->info; i < count; i++, info++) {
-		struct fd dst_fd = fdget(info->dest_fd);
+		CLASS(fd, dst_fd)(info->dest_fd);
 
 		if (fd_empty(dst_fd)) {
 			info->status = -EBADF;
@@ -545,7 +545,7 @@ int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
 
 		if (info->reserved) {
 			info->status = -EINVAL;
-			goto next_fdput;
+			goto next_loop;
 		}
 
 		deduped = vfs_dedupe_file_range_one(file, off, fd_file(dst_fd),
@@ -558,8 +558,6 @@ int vfs_dedupe_file_range(struct file *file, struct file_dedupe_range *same)
 		else
 			info->bytes_deduped = len;
 
-next_fdput:
-		fdput(dst_fd);
 next_loop:
 		if (fatal_signal_pending(current))
 			break;
-- 
2.39.2


