Return-Path: <linux-fsdevel+bounces-68368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4914EC5A2BD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF7E44EC556
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB01D32693B;
	Thu, 13 Nov 2025 21:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiY2UTlq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521712C3245;
	Thu, 13 Nov 2025 21:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069552; cv=none; b=EkuQvgjQxgLoPqi+ng/TG5J9EiG8T7eYo2CWfa5cVNh53s2otAhXZv2DcamBGwWc0gAZVe4Ct//l54Lb1KTua/vqbw32Fu0EhHpd1zLpGPYutGJAn4MiUwZt3N8N0uD9jAFVd7USrau8uycN0Ujd//9JZ/V9F13+x3AqYPhlbTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069552; c=relaxed/simple;
	bh=r0Cw6AGppPOUVDBRoId5Hra+D8yd9v14F+NYYV9raRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JERlHaBqMh6BRzsFTixTR0PauWhbiRWbLktFHEaGiOV0tkyT3paT2XxlVdO5kMddXgPAkD0ao4cMMRFjITgqVdD0TonlpXEp/XoApemzTEaXMmqvl+QsQmauJyf8d2dP78EOBrF2YxOmI+lkuv9Nb3RgiS/3SSDGiMeZgxbeuJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IiY2UTlq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77690C4CEFB;
	Thu, 13 Nov 2025 21:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763069551;
	bh=r0Cw6AGppPOUVDBRoId5Hra+D8yd9v14F+NYYV9raRw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IiY2UTlqFONNEz9Fflzlc5QCi9sswpDEJLNasB+GLUiy0y0f9pzrQB4Cnzg0/ZAvQ
	 wOYgimEfxISdN+d1GIW3UZO14fS+0gh159U5xkipFwI6XdkRn8WTyQJYwjm/ucQp+2
	 /P+eq+0ynI8zzxMtkuJzcyGFtvlYFueWVfaVOa1y97CpVLCNQtmiaC43ljsW/U0M+f
	 DRU9PUSpHQ84YihLZG/9IY4cv5bjY21Zwtxl4oOJ0Y/tD5lWXRsFWqJ9AkYBXL3ddo
	 THQYPuiTj35JVWu9gcQKZ0di8FNhsWZrEFb3+DQUOLo/vzIYjMw1rTCmonFYdDgru7
	 UEePH6SmNYXvw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 22:31:55 +0100
Subject: [PATCH v3 12/42] ovl: port ovl_flush() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v3-12-b35ec983efc1@kernel.org>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1004; i=brauner@kernel.org;
 h=from:subject:message-id; bh=r0Cw6AGppPOUVDBRoId5Hra+D8yd9v14F+NYYV9raRw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSK+YVVy8jrvr8dnKjHdaXv+4qC24cmr9nPb8oUdFT/V
 8D1ab+md5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykbicjw/3cZw/EJHyPFqZm
 eDMYC+SdlWiL+G7AtPZh7qM01/7XTgw/GaeJGqntf1Ckt/p5muhtk8imACvXvbWnrNxPm/0KO9L
 HAQA=
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


