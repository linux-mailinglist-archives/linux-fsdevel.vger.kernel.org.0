Return-Path: <linux-fsdevel+bounces-1718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA857DDFBF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 11:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 004FF1C20D94
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 10:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816BE10794;
	Wed,  1 Nov 2023 10:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="T9ffKPOE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF9A79E6
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 10:49:55 +0000 (UTC)
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42E7F3
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 03:49:53 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
	by smtp.orange.fr with ESMTPA
	id y8nGq7z314QsMy8nHquUN7; Wed, 01 Nov 2023 11:49:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1698835791;
	bh=2aMI4kaZmSRgyVFOxUmjlKR0UB3Yi5s4GgkvE78ZjEk=;
	h=From:To:Cc:Subject:Date;
	b=T9ffKPOEJxbuViGzfFTHIVaSl3YNHy06fGUxFiCi7i5faO8Gl0+r1nO7E87oWuFhe
	 qM9j9M0OYXNJH6UYiqYK59ZHAxvSX1Ml4JdkAdSZk+SEACj/uRcx626tABaKIioR9s
	 NwOrUp+mXZ3zDlkoQgCkFMGtCoeZt4hz76EcUoS6Nh88geZ1R9CQ4MVnAGnWOlmY9L
	 QSZQ3XO0VCGyF76JzVw4Utsj/FazyT37KvHr1Ic0CzSXC6c3ZjeyOOikUkEl8rNxUA
	 oH75VEzI9pzpR8bH22PFnV6rp/W4feAYqkRH3dvTDmkR4nc5XI899dGkd5vvciOncA
	 l/IMGuRwV/7ow==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 01 Nov 2023 11:49:51 +0100
X-ME-IP: 86.243.2.178
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Hans de Goede <hdegoede@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] vboxsf: Avoid an spurious warning if load_nls_xxx() fails
Date: Wed,  1 Nov 2023 11:49:48 +0100
Message-Id: <d09eaaa4e2e08206c58a1a27ca9b3e81dc168773.1698835730.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an load_nls_xxx() function fails a few lines above, the 'sbi->bdi_id' is
still 0.
So, in the error handling path, we will call ida_simple_remove(..., 0)
which is not allocated yet.

In order to prevent a spurious "ida_free called for id=0 which is not
allocated." message, tweak the error handling path and add a new label.

Fixes: 0fd169576648 ("fs: Add VirtualBox guest shared folder (vboxsf) support")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 fs/vboxsf/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
index 1fb8f4df60cb..9848af78215b 100644
--- a/fs/vboxsf/super.c
+++ b/fs/vboxsf/super.c
@@ -151,7 +151,7 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
 		if (!sbi->nls) {
 			vbg_err("vboxsf: Count not load '%s' nls\n", nls_name);
 			err = -EINVAL;
-			goto fail_free;
+			goto fail_destroy_idr;
 		}
 	}
 
@@ -224,6 +224,7 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
 		ida_simple_remove(&vboxsf_bdi_ida, sbi->bdi_id);
 	if (sbi->nls)
 		unload_nls(sbi->nls);
+fail_destroy_idr:
 	idr_destroy(&sbi->ino_idr);
 	kfree(sbi);
 	return err;
-- 
2.34.1


