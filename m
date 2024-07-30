Return-Path: <linux-fsdevel+bounces-24565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D291194076C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B2CC1F237E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 05:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E852319F475;
	Tue, 30 Jul 2024 05:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrCsEGKa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C1219EEC7;
	Tue, 30 Jul 2024 05:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316518; cv=none; b=IxSLtmj/uORNYVy+uTIDCnmhAfapBtVZD5aJHnjOrX6XV+QIgy+1dmHBrTzS2i/MAy282hBzRHoeODyMoH0rs6fWAlu/2lo5xwV9eAnr+iXM6ZIwxbaZdyLKYXPDi7B+Ar714BBlCAY/oB4l0Mtmk4lg5Qw3jUwCkE3W4R5kaaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316518; c=relaxed/simple;
	bh=+eUS9gA/DsbbdUuJN3oT06KLearuA02IQdEsykzkjkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dLeiRkTO16la+aFUybBGsVLu4yv4dF3NPCE6Kqy5Jgw/cyO1AsuRwy3Q1zuIcimKl4DOxmqr6rScLuDTU7hsOhOfIJhCn0i6IOnC+MlKQiUJF0eXEX+YT3jJ5usz+u1uhc1SpWyVmpL9h1N/a0wjlmOGM/7A9VdnuPLqUSHmvuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrCsEGKa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F53C32782;
	Tue, 30 Jul 2024 05:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722316517;
	bh=+eUS9gA/DsbbdUuJN3oT06KLearuA02IQdEsykzkjkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BrCsEGKaHsSas8cdcu/Y8to9QXIwkeXsxr6N3fEQa1zzWoSGUK9FPv0BsooKUq8fH
	 gUawH0qdIST+Os/yNpQnqscnx8pY4oVmFz3Zs4qgLXZqzutuKgvPVzHtbj56SPh1Zh
	 S40SSiwYV46WzfR0E1Ab8PXH+hAz4dyc5ZRdk1nnLhs7Wzmq8mjhzfWlTp7cqX6YPp
	 BkPEVB4wFZFHxjx753vWufewa/mXcbdszn2hVXQxSozoppQVMooFq2/GPhCXBidcg7
	 wN/NVijwphK4J14DPYSOdJuy0iGkHVv2aWsZDk1Blm01vszjsaWNBhIpDGnppT1FoX
	 P7chtfNCYFzJw==
From: viro@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: amir73il@gmail.com,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 33/39] convert do_select()
Date: Tue, 30 Jul 2024 01:16:19 -0400
Message-Id: <20240730051625.14349-33-viro@kernel.org>
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

take the logics from fdget() to fdput() into an inlined helper - with existing
wait_key_set() subsumed into that.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/select.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 97e1009dde00..039f81c6f817 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -465,15 +465,22 @@ static int max_select_fd(unsigned long n, fd_set_bits *fds)
 			 EPOLLNVAL)
 #define POLLEX_SET (EPOLLPRI | EPOLLNVAL)
 
-static inline void wait_key_set(poll_table *wait, unsigned long in,
+static inline __poll_t select_poll_one(int fd, poll_table *wait, unsigned long in,
 				unsigned long out, unsigned long bit,
 				__poll_t ll_flag)
 {
+	CLASS(fd, f)(fd);
+
+	if (fd_empty(f))
+		return EPOLLNVAL;
+
 	wait->_key = POLLEX_SET | ll_flag;
 	if (in & bit)
 		wait->_key |= POLLIN_SET;
 	if (out & bit)
 		wait->_key |= POLLOUT_SET;
+
+	return vfs_poll(fd_file(f), wait);
 }
 
 static noinline_for_stack int do_select(int n, fd_set_bits *fds, struct timespec64 *end_time)
@@ -525,20 +532,12 @@ static noinline_for_stack int do_select(int n, fd_set_bits *fds, struct timespec
 			}
 
 			for (j = 0; j < BITS_PER_LONG; ++j, ++i, bit <<= 1) {
-				struct fd f;
 				if (i >= n)
 					break;
 				if (!(bit & all_bits))
 					continue;
-				mask = EPOLLNVAL;
-				f = fdget(i);
-				if (fd_file(f)) {
-					wait_key_set(wait, in, out, bit,
-						     busy_flag);
-					mask = vfs_poll(fd_file(f), wait);
-
-					fdput(f);
-				}
+				mask = select_poll_one(i, wait, in, out, bit,
+						       busy_flag);
 				if ((mask & POLLIN_SET) && (in & bit)) {
 					res_in |= bit;
 					retval++;
-- 
2.39.2


