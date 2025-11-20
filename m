Return-Path: <linux-fsdevel+bounces-69300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BADEC76852
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D22604E3AE1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFDE30E83F;
	Thu, 20 Nov 2025 22:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIxowXkS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5C930FF27
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677978; cv=none; b=aKZF9IVRgwPrGnlNl3QH1CrumFiQDi/YQkfBvlfUo6zpnyL7Mqr2TsHyUJ9SlIIYiJ/lcWM/bIEIS0EkYquKbj8afF/KQd0SPvOpSlatN2VA401FU7/6QhDTy4blWuJwsGvvdH/3bjAG+QgsPys3T5Zan5XCJqRIzcE45hogf50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677978; c=relaxed/simple;
	bh=xNwbj8mH0uuPC5zkdtKg5eViAY6Rw26Y5g0n7+o1d08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pRv1V7wyVbBzdnIAmy8WEPFsIAJRuAoAUiLl3zzkwh0OPakrQ27H9UKDuMgyq4xNJRGVmESy9ER2GDpks1IIhFPY34qYYOrj3TJtuiQ4HohC28IkODa4OzGyZPKDhplEkhHNFFAYjE/owsjNgEDDNBfCdKXD7efi00m+IubbCYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIxowXkS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17655C4CEF1;
	Thu, 20 Nov 2025 22:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763677978;
	bh=xNwbj8mH0uuPC5zkdtKg5eViAY6Rw26Y5g0n7+o1d08=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MIxowXkS8cUPSsKcUXiPWMw6gQjpTAg3hiTo3St3dFRZLAuIstWK+dDXdQfQr3ugm
	 buIjgiElBcVZj50FV+g6G3UqCcHuFsc71BfRNMza320IGmscdNSiMnEylM1FKx7X9k
	 gzIa3hfnDrcGHMo/Ck4BXGXVm69GkV4E0rAEjTIu6+jcbyqhYL2cgzwpSqu5yRczP3
	 GYIQwb7Ef2a+fH+KYjim9k1CaQKLGVXkNlYEOf+W2kyun09cDPtKzkUUtDOmL3EMpb
	 cjLoK9/SvIH6Ivif4+gNU9mdw81jV7WnjvHZIVb1/IQBeibhbruuLgHhCY+0TGTsKI
	 ecGyTWEHCZbDA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:17 +0100
Subject: [PATCH RFC v2 20/48] af_unix: convert unix_file_open() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-20-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1186; i=brauner@kernel.org;
 h=from:subject:message-id; bh=xNwbj8mH0uuPC5zkdtKg5eViAY6Rw26Y5g0n7+o1d08=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3v7boFKWGOZ+ovL7WH7H+/ZHs187if7DwP5492OE
 72iGi7f7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI1u+MDHu8s+4sfP5hX/Ta
 SzLdV0y2R7ocefpxao1O92rBWe833N7C8E9p2qO2SVZMvjtztom0p633P+1z5cKz1k2TuKPm/Hy
 zNpcZAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 net/unix/af_unix.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 68c94f49f7b5..e68d8eb558c1 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -3277,9 +3277,6 @@ EXPORT_SYMBOL_GPL(unix_outq_len);
 
 static int unix_open_file(struct sock *sk)
 {
-	struct file *f;
-	int fd;
-
 	if (!ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN))
 		return -EPERM;
 
@@ -3289,18 +3286,12 @@ static int unix_open_file(struct sock *sk)
 	if (!unix_sk(sk)->path.dentry)
 		return -ENOENT;
 
-	fd = get_unused_fd_flags(O_CLOEXEC);
-	if (fd < 0)
-		return fd;
+	FD_PREPARE(fdf, O_CLOEXEC, dentry_open(&unix_sk(sk)->path, O_PATH, current_cred())) {
+		if (fd_prepare_failed(fdf))
+			return fd_prepare_error(fdf);
 
-	f = dentry_open(&unix_sk(sk)->path, O_PATH, current_cred());
-	if (IS_ERR(f)) {
-		put_unused_fd(fd);
-		return PTR_ERR(f);
+		return fd_publish(fdf);
 	}
-
-	fd_install(fd, f);
-	return fd;
 }
 
 static int unix_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)

-- 
2.47.3


