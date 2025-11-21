Return-Path: <linux-fsdevel+bounces-69421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E053C7B337
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E228C366E6A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C50352932;
	Fri, 21 Nov 2025 18:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sK8lzHLa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577E9350D51
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748100; cv=none; b=oVFagvvoGt0Nh1F8JYpY+VaVJDs6pmKa36KSEXY9oiUm4kQmonyO62ABudPUf5uF2+DTVd4wbBzKX17zcsjJKNwBkVUPOsu8waEIw2B8okEd/YSAhO0ZRy6Yf3NfUNO/QJfob+YTXLK6wUisOWkHLYM33vAqohzXSzgFBsMaTvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748100; c=relaxed/simple;
	bh=l5n+zJUtOkr5xZKCbQv31foHMjOFUnMsVPFdXxdTkgI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jflx0hg2aqVMonEuqU+rLnx3veaOY0BDt/0yeeMclZIWVBGY0vtxTQH2fkJwGKv7aT/n7cW24yk3c0xifV0hfEtFqj6a7kUA3yaAyZKJRS/3SbnvNV6NUJ80VHlWjwf98QDjOsl5o5sc23J7/y1uIu9jyqLPZi/GLNh6KDdGLfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sK8lzHLa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F9BC4CEF1;
	Fri, 21 Nov 2025 18:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748100;
	bh=l5n+zJUtOkr5xZKCbQv31foHMjOFUnMsVPFdXxdTkgI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sK8lzHLaSHhsM/ZfDFoSLRoIOAe2ZxyftjshS+o2YX9ShZXSiNPY/wvaQplhd+M87
	 g6c8GV/ZSrL9k6J8Q45deaf6p2nr3p/rTv3wjBraXCeu191/nP1NlQygPHZQDKiS8p
	 8E5IVK3Z94hj0XLXUvaX+P1NtwvubtwYzsjKvL4cALvokgupJWn1petj1mkdXJEKdP
	 O1cZL3HXSFUcJ45+RdaA85rxqtQMRk0Nr7zqlxYvPYQUyyrYlR+bKnPf3gesStlfWy
	 W+cPCsoLifa1vRenv8bpp7VncTtGJndODA3zEISKE589lwjuNLXRE/jwhQROvvzDck
	 0n39AuOHv+tBg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:01:02 +0100
Subject: [PATCH RFC v3 23/47] bpf: convert bpf_iter_new_fd() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-23-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1622; i=brauner@kernel.org;
 h=from:subject:message-id; bh=l5n+zJUtOkr5xZKCbQv31foHMjOFUnMsVPFdXxdTkgI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrLigee2URaswZ+jm/vklkk+TNV8YaX58XOl2UEvux
 LHcb4nXOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbiHcHIcK/nEtObNqN/W69P
 yPS9M0k/9XyLpMeXDdLnvs1cFTDzEwcjw9PH2++oxV+SD55h7Hex90aJ49W4xP43RUumL74h2qQ
 sxwoA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/bpf/bpf_iter.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 6ac35430c573..60f9ca339a6b 100644
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
+	FD_PREPARE(fdf, flags, anon_inode_getfile("bpf_iter", &bpf_iter_fops, NULL, flags));
+	err = ACQUIRE_ERR(fd_prepare, &fdf);
 	if (err)
-		goto free_file;
+		return err;
 
-	fd_install(fd, file);
-	return fd;
+	iter_link = container_of(link, struct bpf_iter_link, link);
+	err = prepare_seq_file(fd_prepare_file(fdf), iter_link);
+	if (err)
+		return err; /* Automatic cleanup handles fput */
 
-free_file:
-	fput(file);
-free_fd:
-	put_unused_fd(fd);
-	return err;
+	return fd_publish(fdf);
 }
 
 struct bpf_prog *bpf_iter_get_info(struct bpf_iter_meta *meta, bool in_stop)

-- 
2.47.3


