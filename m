Return-Path: <linux-fsdevel+bounces-69304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E84C7685B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67EB04E5296
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CC630E0DC;
	Thu, 20 Nov 2025 22:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgXwjndd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F102ED873
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677987; cv=none; b=f4UA+uzKM6gw1PfMDEfnFYjgdyyOaQJWrsRQ0dwN8F5ODrWiLshhc4zoio/HrEp9Z+uJkmKzqQHd0W/I+V6RtnXnBYHspAMVU2z01qK126veXaJbNe14AFPePteeT86HMzcBa1bJ6sk09wRqBxOdrCmKkyynsrLi1BZIp9d6RUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677987; c=relaxed/simple;
	bh=erNzExMTI4LzhAYnIYUtB7JkQZpxF/cU+fBBFrzL4dU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ng2PR/tTrpgqHlGq90+z+2MJ1/+xGT3/3gJjfPANBw/fE9LCzrx6CvSgYQf4W1JB3kn2R+FBlzwuZliNgq067i3zBmns9gh38WuwDIf5BHBsY24WU0a4r8nY2V2Sr4McM3CIA2cLXzCFV2pOpZo9AT/ONJfkiBXtpj4C4dINzcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rgXwjndd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574E8C4CEF1;
	Thu, 20 Nov 2025 22:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763677986;
	bh=erNzExMTI4LzhAYnIYUtB7JkQZpxF/cU+fBBFrzL4dU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rgXwjnddi1JYqOCRCY/1EFZcFe5LgLwuVYkgi7oXH7nfvfSPbSs1rbLpW1sVqdTPp
	 F1NzDIws0/efGmVLcyaB/m3scfXEZzWxhGSXGyhsDU/aL+w+1nUtK7UI7fXGWnpr4D
	 NhGYEKt5Ia9JewXArnEzvM5xEfmnoaQuIPVZ0J/LOIkZQ5rXPI6d8s3Bo+eGfYqs6h
	 AojNvUjBHVNNjRY7h1sBEHJxoSDt5OVDCMqT6v2Z0HYbk6fCYOoSoxiu0+Xt6NCi9p
	 RibdBKYczL+jJmsVLVv9LxVptENiZUBm4w6cj7QipOqR+CITJN50W8uyk2wYwUS7Ns
	 z2EAmSbbNQuhA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:21 +0100
Subject: [PATCH RFC v2 24/48] bpf: convert bpf_iter_new_fd() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-24-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1648; i=brauner@kernel.org;
 h=from:subject:message-id; bh=erNzExMTI4LzhAYnIYUtB7JkQZpxF/cU+fBBFrzL4dU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3trGL8h+5vr4ltttcbHTFY9+5pr7ukTsbL6zs6Iz
 quCU8RyOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYyMYThr9CpQFWujc9nqU3a
 cIFjl4+IL5/ciRc9vzntbqu1Bl0yr2T4H1kod9n/+0fL7S7tPw1ieCLF81WWaf8+tKvwu8qf89e
 c+QA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/bpf/bpf_iter.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 6ac35430c573..30e737f5b287 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -634,37 +634,25 @@ static int prepare_seq_file(struct file *file, struct bpf_iter_link *link)
 int bpf_iter_new_fd(struct bpf_link *link)
 {
 	struct bpf_iter_link *iter_link;
-	struct file *file;
 	unsigned int flags;
-	int err, fd;
+	int err;
 
 	if (link->ops != &bpf_iter_link_lops)
 		return -EINVAL;
 
 	flags = O_RDONLY | O_CLOEXEC;
-	fd = get_unused_fd_flags(flags);
-	if (fd < 0)
-		return fd;
-
-	file = anon_inode_getfile("bpf_iter", &bpf_iter_fops, NULL, flags);
-	if (IS_ERR(file)) {
-		err = PTR_ERR(file);
-		goto free_fd;
-	}
 
-	iter_link = container_of(link, struct bpf_iter_link, link);
-	err = prepare_seq_file(file, iter_link);
-	if (err)
-		goto free_file;
+	FD_PREPARE(fdf, flags, anon_inode_getfile("bpf_iter", &bpf_iter_fops, NULL, flags)) {
+		if (fd_prepare_failed(fdf))
+			return fd_prepare_error(fdf);
 
-	fd_install(fd, file);
-	return fd;
+		iter_link = container_of(link, struct bpf_iter_link, link);
+		err = prepare_seq_file(fd_prepare_file(fdf), iter_link);
+		if (err)
+			return err;  /* Automatic cleanup handles fput */
 
-free_file:
-	fput(file);
-free_fd:
-	put_unused_fd(fd);
-	return err;
+		return fd_publish(fdf);
+	}
 }
 
 struct bpf_prog *bpf_iter_get_info(struct bpf_iter_meta *meta, bool in_stop)

-- 
2.47.3


