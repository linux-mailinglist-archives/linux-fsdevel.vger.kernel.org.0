Return-Path: <linux-fsdevel+bounces-1719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8107DDFC3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 11:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEDB7B21095
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 10:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0CF10968;
	Wed,  1 Nov 2023 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="E8ypWe7Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21902107BC
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 10:50:01 +0000 (UTC)
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B6611A
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 03:50:00 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id y8nGq7z314QsMy8nNquUNu; Wed, 01 Nov 2023 11:49:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1698835798;
	bh=ZFoT46jhWC+OotEkeda4BBrZIJT+3NpRAKetJm3pBjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E8ypWe7QgSH/1hVNdu7NjKwR6dgkPxmlT6wOrOuy+qIK8qWSkzW/in+i1zDWc9/eu
	 sdH7yEEQTPrkmlVN7ZjOA4DONg64WFIS8EFuXXmM732OOb6S3MHo9fxxmQVnca+eR9
	 aX/AIA9S2BaUtXguHsf4hqAn9ArijpRLukoYpS0OnvyAsBQYAY5O32aU/nGU6DOQWD
	 N/5B1xKkyjd/ToWslTf2CcI+xF9JiwgGjz5mIMYBzAa5Ux18Tg6J9O70Z3aZCfKWci
	 IqtBFU07TJKh4AZ9mmpruRlQFtzx+TLpIEw8fbIe1g+XHoT07GN88kC+36ocS9iRBz
	 VHbrGWbtQfNIQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 01 Nov 2023 11:49:58 +0100
X-ME-IP: 86.243.2.178
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] vboxsf: Remove usage of the deprecated ida_simple_xx() API
Date: Wed,  1 Nov 2023 11:49:49 +0100
Message-Id: <b3c057c86b73f0309a6362031d21f4d7ebb60587.1698835730.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <d09eaaa4e2e08206c58a1a27ca9b3e81dc168773.1698835730.git.christophe.jaillet@wanadoo.fr>
References: <d09eaaa4e2e08206c58a1a27ca9b3e81dc168773.1698835730.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

This is less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 fs/vboxsf/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
index 9848af78215b..0f67f2d8b651 100644
--- a/fs/vboxsf/super.c
+++ b/fs/vboxsf/super.c
@@ -155,7 +155,7 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
 		}
 	}
 
-	sbi->bdi_id = ida_simple_get(&vboxsf_bdi_ida, 0, 0, GFP_KERNEL);
+	sbi->bdi_id = ida_alloc(&vboxsf_bdi_ida, GFP_KERNEL);
 	if (sbi->bdi_id < 0) {
 		err = sbi->bdi_id;
 		goto fail_free;
@@ -221,7 +221,7 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
 	vboxsf_unmap_folder(sbi->root);
 fail_free:
 	if (sbi->bdi_id >= 0)
-		ida_simple_remove(&vboxsf_bdi_ida, sbi->bdi_id);
+		ida_free(&vboxsf_bdi_ida, sbi->bdi_id);
 	if (sbi->nls)
 		unload_nls(sbi->nls);
 fail_destroy_idr:
@@ -269,7 +269,7 @@ static void vboxsf_put_super(struct super_block *sb)
 
 	vboxsf_unmap_folder(sbi->root);
 	if (sbi->bdi_id >= 0)
-		ida_simple_remove(&vboxsf_bdi_ida, sbi->bdi_id);
+		ida_free(&vboxsf_bdi_ida, sbi->bdi_id);
 	if (sbi->nls)
 		unload_nls(sbi->nls);
 
-- 
2.34.1


