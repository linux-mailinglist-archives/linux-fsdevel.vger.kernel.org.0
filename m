Return-Path: <linux-fsdevel+bounces-68655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 59655C633FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2927D4EE182
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3534932AAA0;
	Mon, 17 Nov 2025 09:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Awo1ZiUk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF26329394;
	Mon, 17 Nov 2025 09:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372048; cv=none; b=PD4bnrPoh+jUz69162/MwsPRsLrgbcAp15ME61nyTr5UX0Iqu8rSuakgTllp5iniEGRVeICC2yZs1bkPGSU2wI8PJFe/vEb1HkuXleoyQF1vM0V5urE6DNFq5lCR8qbVVyfyCmDeQyjhQ/clGgLWr9lPw5Lni/geFCVBHwuwxlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372048; c=relaxed/simple;
	bh=r0Cw6AGppPOUVDBRoId5Hra+D8yd9v14F+NYYV9raRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=izvQFu2VVgA+H4PWjceg/QWwsKxOSWrEk3aqlNlHwHLlAlE+Oj0q4fYKpNQcpEUGpndkrzEneSpbVF0zI1V7+R1fydY2Z5cIDdeFG+vCslmHCbueYMNPEg1uIzA99Dnz/s2i9v03CGxyGIMTyfbcSpcIH+euOwoFLOT8Wbp+jTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Awo1ZiUk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1923BC116B1;
	Mon, 17 Nov 2025 09:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372046;
	bh=r0Cw6AGppPOUVDBRoId5Hra+D8yd9v14F+NYYV9raRw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Awo1ZiUkRUj824m1jzyHtJSWU41TKrFJCoE8tiQ/b2K5I8/yWDTrQl6VTG7jWyJVk
	 dLDorbQHyxgZKP51KbdUTU2zvDN8PVR8orertY39t66r+VlYBWW77IkZlDBpnUhjXv
	 sw94df33hzT9LfZxMPzfYTL9LGSupLOEE4QObumfyJQPkxUEmV96fhxjLwjpIze7Qk
	 CkIOlvoenFF3HBpaz7k+vJCB+UoA3MD4gAl9Vu27sJHvt4PAD/j+kkFWHpHMfhLINj
	 B5vFO9rmPjMhyH4xGUfYK3Eiw8/y7mrxh5DuEUdcH0Vapn5LdAj/bFDhKHKpH/C86v
	 LgeCdLM6dHb1A==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:33:43 +0100
Subject: [PATCH v4 12/42] ovl: port ovl_flush() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-v4-12-b31603935724@kernel.org>
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1004; i=brauner@kernel.org;
 h=from:subject:message-id; bh=r0Cw6AGppPOUVDBRoId5Hra+D8yd9v14F+NYYV9raRw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvf7KKF18UY0zvONBXsmhf2ck9z+J4VoibFXncFwqf
 4qK4E77jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImkPGX4Z9kmkbr0ToR8yB9B
 bssjC6bozgkVstDTlNKL5eC4dbpOmuGvxP589nqOcNeMP34H0usX3e5qrPj8i7U+g9kgV28xUzE
 XAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/file.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index f562f908f48a..e375c7306051 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -620,7 +620,6 @@ static loff_t ovl_remap_file_range(struct file *file_in, loff_t pos_in,
 static int ovl_flush(struct file *file, fl_owner_t id)
 {
 	struct file *realfile;
-	const struct cred *old_cred;
 	int err = 0;
 
 	realfile = ovl_real_file(file);
@@ -628,9 +627,8 @@ static int ovl_flush(struct file *file, fl_owner_t id)
 		return PTR_ERR(realfile);
 
 	if (realfile->f_op->flush) {
-		old_cred = ovl_override_creds(file_inode(file)->i_sb);
+		with_ovl_creds(file_inode(file)->i_sb)
 			err = realfile->f_op->flush(realfile, id);
-		ovl_revert_creds(old_cred);
 	}
 
 	return err;

-- 
2.47.3


