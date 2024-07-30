Return-Path: <linux-fsdevel+bounces-24557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F216F940745
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CCEDB22DD3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 05:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EACD16A925;
	Tue, 30 Jul 2024 05:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSzSa+nO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71D419883B;
	Tue, 30 Jul 2024 05:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316510; cv=none; b=F2RDiEZtY+vcLqsky3b/Ac2LhLPwLBgiQ1Hgo+uizxXP8I/X+lo/KLdpnzK+Pl8i2uv/kgCzavG9hwJf7m+mRvYdu4fCneijvh16g/Md4KGvjycGXqevlP2DZGGP6FqZbrN6iLBc2S3aw+SyM6QKjTZN1Ox4NvjD4sgh/Cu6rG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316510; c=relaxed/simple;
	bh=B0KoN/5o23anS0E9iABmCsTA3ff9c7CHjUY+K3+pq3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CnGi7VvvYg9kx2ydEgt8H7b3tQ+wO96Y/zr9bwwssdgcz1anJMK+gWu4aQW/J7R7O29kMbG42RX+ORj1M2p5bpvAUye24jFsHjrIzcwtV1ZdiicqVEFdfdoMulrC53EDFe3Y5WpFHPSGq9fEg/bWYAK5frj2pY3of7icPPYusyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSzSa+nO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D3BC4AF0E;
	Tue, 30 Jul 2024 05:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722316510;
	bh=B0KoN/5o23anS0E9iABmCsTA3ff9c7CHjUY+K3+pq3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SSzSa+nOzlsrOycHKBQn6/UT/VXWhQlk3O5elIL6ccYXrUmn9RpJl39js+e1DjqMs
	 7NTTa9ALOTeb00dA1a9zmv/Dv0vQGg5iFczonqGtygzpbP+fRTUjbV1/opngVpuxr/
	 e73LYvJ5a/ZzZc4yFAkTdfQFFzB8Y51BH6dLA8Kg17OiLfPzlbUHRC4A5BxQPCY5R8
	 yVQjcdWA+KTX345wgkMa4/3h6H1bhi/FVkHxGJakWSwV+sVfo6PESSQNwPETzZ6tdg
	 rP4DcNu/JpyjVVSpYd13YJlKKpT+1gRzeSzIATZ/BhnVkzznNOU4wtb4UYwx5cmExw
	 wyOEAuHv47PGg==
From: viro@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: amir73il@gmail.com,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 25/39] convert do_preadv()/do_pwritev()
Date: Tue, 30 Jul 2024 01:16:11 -0400
Message-Id: <20240730051625.14349-25-viro@kernel.org>
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

fdput() can be transposed with add_{r,w}char() and inc_sysc{r,w}();
it's the same story as with do_readv()/do_writev(), only with
fdput() instead of fdput_pos().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/read_write.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 789ea6ecf147..486ed16ab633 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1020,18 +1020,16 @@ static inline loff_t pos_from_hilo(unsigned long high, unsigned long low)
 static ssize_t do_preadv(unsigned long fd, const struct iovec __user *vec,
 			 unsigned long vlen, loff_t pos, rwf_t flags)
 {
-	struct fd f;
 	ssize_t ret = -EBADF;
 
 	if (pos < 0)
 		return -EINVAL;
 
-	f = fdget(fd);
-	if (fd_file(f)) {
+	CLASS(fd, f)(fd);
+	if (!fd_empty(f)) {
 		ret = -ESPIPE;
 		if (fd_file(f)->f_mode & FMODE_PREAD)
 			ret = vfs_readv(fd_file(f), vec, vlen, &pos, flags);
-		fdput(f);
 	}
 
 	if (ret > 0)
@@ -1043,18 +1041,16 @@ static ssize_t do_preadv(unsigned long fd, const struct iovec __user *vec,
 static ssize_t do_pwritev(unsigned long fd, const struct iovec __user *vec,
 			  unsigned long vlen, loff_t pos, rwf_t flags)
 {
-	struct fd f;
 	ssize_t ret = -EBADF;
 
 	if (pos < 0)
 		return -EINVAL;
 
-	f = fdget(fd);
-	if (fd_file(f)) {
+	CLASS(fd, f)(fd);
+	if (!fd_empty(f)) {
 		ret = -ESPIPE;
 		if (fd_file(f)->f_mode & FMODE_PWRITE)
 			ret = vfs_writev(fd_file(f), vec, vlen, &pos, flags);
-		fdput(f);
 	}
 
 	if (ret > 0)
-- 
2.39.2


