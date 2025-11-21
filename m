Return-Path: <linux-fsdevel+bounces-69437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313B8C7B307
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4B1A3A42B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5093538AA;
	Fri, 21 Nov 2025 18:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9adge8t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C20352929
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748134; cv=none; b=CxS2yeg7MuUIjT1LpsSMz4AvVLdL5eNEbGkkjwRtA3WerSMwg6SSXQ/zER/8+IXQhBx6JUv87nISjZG8IJoz41JdRndX3f57FBK+5zgET3ivkad3081mlQfJ6eiBiwxPcYhlZl84plrMI3/QIzpRRZr7rLZUgubJf05ZoMg9QAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748134; c=relaxed/simple;
	bh=TuMDIkp9GEcCNq6J0wW+W6iR+65A9/Aoj+ubmQ41eb8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gqbV4PR756jMVt56zpG2hrNwZXmTlUJAej9UbA8zUjAjaH9R4paEIFu4N/PpHi/C710UspVHLfgcKsv+YXswLzGBQyiC/H9mNhJsCpJ8JkkR/ttlUeXyJz/slDyr9F/t2VpgCSBhQA7bgx9c46XL/wTx42XEiUOMflk0ddDnUv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9adge8t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24046C116D0;
	Fri, 21 Nov 2025 18:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748133;
	bh=TuMDIkp9GEcCNq6J0wW+W6iR+65A9/Aoj+ubmQ41eb8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=h9adge8t7p56iYxLNm/3iffC0mpZYMJ/Qk9RSXhcseVnjunABrGBRqP/OHrXuoTaW
	 tu1/wcCWZ2mIPmTFFJAFlDmCRHNgAbPerkVuLWEFtQUEzPzgoaFLqonocnzzor1Ry1
	 0Mtub7Dc54K1KrzEF0lyYme33lKeQLE6vnWiREOpFMx52t+FVAfrRAS1OvwxPEoQna
	 ugpacERLMMRMCBTzxDt62QrixweHk/0ANoNoMiXH1pZlBK4eoce94M+rs67k84ju4V
	 rntpd7JVMpuSjCqVm8x5dZYn+Tk8oNqsjHtETIlsVM91IznxvNqgVp45tzGUQHXDdr
	 XzXQWN+Ca5tyA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:01:18 +0100
Subject: [PATCH RFC v3 39/47] hv: convert mshv_ioctl_create_partition() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-39-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1323; i=brauner@kernel.org;
 h=from:subject:message-id; bh=TuMDIkp9GEcCNq6J0wW+W6iR+65A9/Aoj+ubmQ41eb8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrLjIWb/107pOoRenite5LtKp2NvF/NCCs2Trz1fRX
 pK1v+I3dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykUJWR4Z6qruBE+3xzWXXJ
 V3VVotfudfWufvqm9NhtrWefD9z0k2L4K33v5oWblheN1rS5Lk4JaGln5XDJEUlz7FtW2WdcM1+
 LGQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/hv/mshv_root_main.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index e3b2bd417c46..575c23560bb2 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1938,30 +1938,16 @@ mshv_ioctl_create_partition(void __user *user_arg, struct device *module_dev)
 		goto delete_partition;
 
 	ret = mshv_init_async_handler(partition);
-	if (ret)
-		goto remove_partition;
-
-	fd = get_unused_fd_flags(O_CLOEXEC);
-	if (fd < 0) {
-		ret = fd;
-		goto remove_partition;
-	}
-
-	file = anon_inode_getfile("mshv_partition", &mshv_partition_fops,
-				  partition, O_RDWR);
-	if (IS_ERR(file)) {
-		ret = PTR_ERR(file);
-		goto put_fd;
+	if (!ret) {
+		FD_PREPARE(fdf, O_CLOEXEC,
+			   anon_inode_getfile("mshv_partition",
+					      &mshv_partition_fops, partition, O_RDWR));
+		ret = ACQUIRE_ERR(fd_prepare, &fdf);
+		if (!ret)
+			return fd_publish(fdf);
 	}
-
-	fd_install(fd, file);
-
-	return fd;
-
-put_fd:
-	put_unused_fd(fd);
-remove_partition:
 	remove_partition(partition);
+
 delete_partition:
 	hv_call_delete_partition(partition->pt_id);
 cleanup_irq_srcu:

-- 
2.47.3


