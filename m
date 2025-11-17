Return-Path: <linux-fsdevel+bounces-68669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 076C6C63496
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EDD5F34F3A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA989329C6D;
	Mon, 17 Nov 2025 09:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoxQKbAl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140A6329C6A;
	Mon, 17 Nov 2025 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372073; cv=none; b=aE+7+WBHr9m8bACtEQILcXu/nfbRrL+pJdk/3ZCAPGH6jicJg64TvozpK/IgvqBfrGLGaBrYoILrpe135PLnfBmOCOCrOF11fbH6GEZGV0cgamooU6Ph/NIcauba02gs0oK52KpcNA9BncWAJx0M2k9egiDF+TefuSJfJUDRMB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372073; c=relaxed/simple;
	bh=w/Dmgc1d7gWmCfiWXXUSgzh+qcUGL45MEBGfQrYUryY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T0eNyodz8Hq+wcTFIO+uMAzSgkxUuslNXRq7fG5QAKUQU7TuMYJSUVBntGFJQ8kiVo5aoYeVdi+SanWXQ38RDC4w0qieOk8oZkMifpMB4BAV+xEXQ98xPB6hhyRFImYyONjWnjAbgAJzvgiqaaadlVzEOY5WNxvp2i5NcnqGGdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoxQKbAl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E03CC4CEFB;
	Mon, 17 Nov 2025 09:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372071;
	bh=w/Dmgc1d7gWmCfiWXXUSgzh+qcUGL45MEBGfQrYUryY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UoxQKbAldmBmW5ifBHR4oSz4VYVzx1vP8PEIM1eF5FWp1BHPhEOK8aZHds7b7QNsn
	 uaq6ZT0A1rRtxrrJgESzzD171Zu27u96UbAEeC+v2/z7poHauLNgGJPaEvHvIZ6F4q
	 UNO/wQc3Zhli65PuOMo72EUJVb77tzIbsVrY5DG5+OdeGpkyV7/mc73b3F1tcoJOCQ
	 PlbnaUzUA1yl0F7y0b3lqbkcYpjB6i716XgXcwwHuU1p5MRVM6X6KIRRk1bWJaVSUn
	 x7L1zygbNgcQuEU1aslA2Io+SpiddOsBuZOcRqOfh4XDUJu+ednDd9mJ6NARCo0YYn
	 WzapUGygNGeOQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:33:57 +0100
Subject: [PATCH v4 26/42] ovl: port ovl_dir_llseek() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-v4-26-b31603935724@kernel.org>
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=994; i=brauner@kernel.org;
 h=from:subject:message-id; bh=w/Dmgc1d7gWmCfiWXXUSgzh+qcUGL45MEBGfQrYUryY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvf6mfrYrcaH3fTnWrLgppw5ObZHacYrZyuXBYq5Si
 ysxuY/DOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZilcbIMEvpiPY3+5t7Gf1X
 fpv/VD9u+83o/LvdFaejLgtX/59ek8rwk3HH1RMHjinfs/lxhP3N2vVL3XdcDPZ0XTrt8oI1Ror
 BslwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/readdir.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index f24a044d1b61..3af6a8bb6fe5 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -955,14 +955,8 @@ static loff_t ovl_dir_llseek(struct file *file, loff_t offset, int origin)
 static struct file *ovl_dir_open_realfile(const struct file *file,
 					  const struct path *realpath)
 {
-	struct file *res;
-	const struct cred *old_cred;
-
-	old_cred = ovl_override_creds(file_inode(file)->i_sb);
-	res = ovl_path_open(realpath, O_RDONLY | (file->f_flags & O_LARGEFILE));
-	ovl_revert_creds(old_cred);
-
-	return res;
+	with_ovl_creds(file_inode(file)->i_sb)
+		return ovl_path_open(realpath, O_RDONLY | (file->f_flags & O_LARGEFILE));
 }
 
 /*

-- 
2.47.3


