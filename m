Return-Path: <linux-fsdevel+bounces-66739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5293BC2B674
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 12:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 618F14F869B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 11:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67023081A8;
	Mon,  3 Nov 2025 11:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSJOLdYs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127AF307ACF;
	Mon,  3 Nov 2025 11:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169245; cv=none; b=phk40vlRabNAsq78QxOa7IKce0jyD6vjaWw5P8z9HoHFzPMx0cOvR7ZoUP75ru0eFZtBZpFLK+x1tmv3+qvQ1CdPvfBSsO3Lsr/UnGVzHBCrhCMqxioyRjOx8LyKjHF54mMHTZBoj2rSJKRjzo3Yi05HQ2KjovQupBbxI8oLE6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169245; c=relaxed/simple;
	bh=mlLhVVRd/xxD3/60oVSWrFdPcpqIel0cuCN6B/lJA2U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cj9vxzhmYuyFoMR4JY5Fm/JH3TE5tagGxFnz4VZ943/swqjHYdfKtXcds1mcVfoboOcAJ0TDIbL9h+phX6koawuU+FzKI2eXyrPMtcWEap/XT7mKMo3WagTNPFmo26aey6DlCC0LdkcsUhVe4uQFf3O3qaByxcNvxI/tX8bYQm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSJOLdYs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4214FC4CEF8;
	Mon,  3 Nov 2025 11:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762169244;
	bh=mlLhVVRd/xxD3/60oVSWrFdPcpqIel0cuCN6B/lJA2U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dSJOLdYsbOtv8x75jqQRz94Oo7UCb7902vSZu0lMMEMCXX/RorZSIkWG8wMed0DWX
	 Ouy8AGG2Fk4WbaOjNzHC2oj3oZgQz3oknW5LY+JpTrie1MhL2dYKPeI8Z/JKT6rbIF
	 Xdn+JLAllNO5yjbH+XulE9RPblj14m06XiM6A7MA3VtBbJYHXSWd58SvLppxpaWaxc
	 SPZ5UeZvxHBPP6kfNsq/eg4oSKVdePHLrKMEM9nYnEEzvLs9V7QIEX9/NqClTOITqR
	 HJQqn+BrCZ8jtneil1XvrBoe6VXIjMjfOLZWm7vksU/vRSN03kt5Vs3y4oZqk2pw9Z
	 He0fs7fz/JbSw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 12:26:54 +0100
Subject: [PATCH 06/16] backing-file: use credential guards for splice write
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-work-creds-guards-simple-v1-6-a3e156839e7f@kernel.org>
References: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
In-Reply-To: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 cgroups@vger.kernel.org, netdev@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=1206; i=brauner@kernel.org;
 h=from:subject:message-id; bh=mlLhVVRd/xxD3/60oVSWrFdPcpqIel0cuCN6B/lJA2U=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyTGzXdZtwz9bEwErmpcLqufXHk27pXpnv09HpmZD0Y
 Y6C+a20jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlMlmT4Z7vMQkfcbFZTvPjK
 Ewmagtc3vf6j5+nFsSeJ/4GEQ3oNDyPDlF/cWhO2zF8gfDJJW6Ut7fjsf/KJewqqFmuk6rpyt3j
 yAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use credential guards for scoped credential override with automatic
restoration on scope exit.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/backing-file.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index 8ebc62f49bad..9c63a3368b66 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -303,7 +303,6 @@ ssize_t backing_file_splice_write(struct pipe_inode_info *pipe,
 				  size_t len, unsigned int flags,
 				  struct backing_file_ctx *ctx)
 {
-	const struct cred *old_cred;
 	ssize_t ret;
 
 	if (WARN_ON_ONCE(!(out->f_mode & FMODE_BACKING)))
@@ -316,11 +315,11 @@ ssize_t backing_file_splice_write(struct pipe_inode_info *pipe,
 	if (ret)
 		return ret;
 
-	old_cred = override_creds(ctx->cred);
-	file_start_write(out);
-	ret = out->f_op->splice_write(pipe, out, &iocb->ki_pos, len, flags);
-	file_end_write(out);
-	revert_creds(old_cred);
+	scoped_with_creds(ctx->cred) {
+		file_start_write(out);
+		ret = out->f_op->splice_write(pipe, out, &iocb->ki_pos, len, flags);
+		file_end_write(out);
+	}
 
 	if (ctx->end_write)
 		ctx->end_write(iocb, ret);

-- 
2.47.3


