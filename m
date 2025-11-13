Return-Path: <linux-fsdevel+bounces-68365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CAEC5A299
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F3E24ECD84
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2482C326927;
	Thu, 13 Nov 2025 21:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quIeVFpL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE08326925;
	Thu, 13 Nov 2025 21:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069546; cv=none; b=AJZSJa63qEiA0XxFiLlnnYQT4fl9FYg0jqudCcWDPthNZQpGGp0Cf53gpXYN64qzCpSSRVNnCOgAkUrpVX6WU7s888LqZrSv0IahXo3G/4I2CutwQgwYznQdORnW5kcpxxfNwVnvLznAMHmz+bEMeIjIl89q0pMMT7o75+QP71A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069546; c=relaxed/simple;
	bh=3594gwA3mJkkf4GzIrd+4mJpgDHreMVCWU6cv7ipCbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g0jCU6jEIGR9OUUBwlx98VK36X5us9qFHfJE9/5Ne2VYFVtZNMOXfyVCFxBGiFM/kBWOrnPT2b7C2Y3R0y9SMpTAkuNWDStbZU5XvUlKDlpSYCbISwfboM9G1RvcR+B/t2eA7CMZpoNtZZvp1Du66C/824KEBQvON+trlA/KZNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=quIeVFpL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08AD2C4CEF8;
	Thu, 13 Nov 2025 21:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763069546;
	bh=3594gwA3mJkkf4GzIrd+4mJpgDHreMVCWU6cv7ipCbk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=quIeVFpLf+4i0KYmHgQhzHUb+Hxae40zb99J/rH/VBZSq95yRDRv4NRxKGgJRG3uE
	 6vggTOEuidXkq/A46Dl53SPGcWC4MMy3774iJup8Ucxc9Ii95AKg+VsHFTqg5+4LVM
	 jXzeT7qNhXqHOmAr/AO2Tq8LPnWMscFiXV5gcesBKmiTtcLkHEcCHzJ0DkIjVW96k9
	 dNP8B6iu+gEEpuTD1B0gvVRawvhj97Zgmdplv6ZRNZG1kv2eyV3XOStbL2i+6yRaL2
	 jE3qiiMocqGqupn6VtrQAUbgu++Xz7K22eac4HZFBFEXvhQHuLzfc3pCMmHwy5EiUL
	 uL3qLapg50EXA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 22:31:52 +0100
Subject: [PATCH v3 09/42] ovl: port ovl_fsync() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v3-9-b35ec983efc1@kernel.org>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1191; i=brauner@kernel.org;
 h=from:subject:message-id; bh=3594gwA3mJkkf4GzIrd+4mJpgDHreMVCWU6cv7ipCbk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSK+YWdsXxpYGCgphKadfv62rPf505m/jDnyNZnCz3Oa
 4pce+o7paOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAie+YyMnxz1N4ZKlLTP9P8
 Tv2SRenzas5t9fQ9tKU6oTxB54ijiiTDP6WgdJWAQ9z3rr98FnX35PsJOfdCf07Kux7LtPzsc7n
 yq1wA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/file.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index e713f27d70aa..6c5aa74f63ec 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -446,7 +446,6 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	enum ovl_path_type type;
 	struct path upperpath;
 	struct file *upperfile;
-	const struct cred *old_cred;
 	int ret;
 
 	ret = ovl_sync_status(OVL_FS(file_inode(file)->i_sb));
@@ -463,11 +462,8 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	if (IS_ERR(upperfile))
 		return PTR_ERR(upperfile);
 
-	old_cred = ovl_override_creds(file_inode(file)->i_sb);
-	ret = vfs_fsync_range(upperfile, start, end, datasync);
-	ovl_revert_creds(old_cred);
-
-	return ret;
+	with_ovl_creds(file_inode(file)->i_sb)
+		return vfs_fsync_range(upperfile, start, end, datasync);
 }
 
 static int ovl_mmap(struct file *file, struct vm_area_struct *vma)

-- 
2.47.3


