Return-Path: <linux-fsdevel+bounces-8037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 256C282EB4C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 10:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3F47B21DB7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 09:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C542D12B7A;
	Tue, 16 Jan 2024 09:11:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A358612B60;
	Tue, 16 Jan 2024 09:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4720e67c28c74a629f859878749d6007-20240116
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:8f024591-b385-43f6-b9d7-3d5c201cf8a5,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:30
X-CID-INFO: VERSION:1.1.35,REQID:8f024591-b385-43f6-b9d7-3d5c201cf8a5,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:30
X-CID-META: VersionHash:5d391d7,CLOUDID:8e0f4e8e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:240116171145JGHZDUJ7,BulkQuantity:0,Recheck:0,SF:101|17|38|24|100|19
	|42|74|66|102,TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: 4720e67c28c74a629f859878749d6007-20240116
Received: from mail.kylinos.cn [(39.156.73.10)] by mailgw
	(envelope-from <chentao@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1565199830; Tue, 16 Jan 2024 17:11:43 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id C0AD6E000EBA;
	Tue, 16 Jan 2024 17:11:42 +0800 (CST)
X-ns-mid: postfix-65A6484E-552022199
Received: from kernel.. (unknown [172.20.15.234])
	by mail.kylinos.cn (NSMail) with ESMTPA id D80DAE000EB9;
	Tue, 16 Jan 2024 17:11:38 +0800 (CST)
From: Kunwu Chan <chentao@kylinos.cn>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] buffer: Use KMEM_CACHE instead of kmem_cache_create()
Date: Tue, 16 Jan 2024 17:11:37 +0800
Message-Id: <20240116091137.92375-1-chentao@kylinos.cn>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
to simplify the creation of SLAB caches.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 fs/buffer.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index d3bcf601d3e5..9c8156cce9b7 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3121,12 +3121,8 @@ void __init buffer_init(void)
 	unsigned long nrpages;
 	int ret;
=20
-	bh_cachep =3D kmem_cache_create("buffer_head",
-			sizeof(struct buffer_head), 0,
-				(SLAB_RECLAIM_ACCOUNT|SLAB_PANIC|
-				SLAB_MEM_SPREAD),
-				NULL);
-
+	bh_cachep =3D KMEM_CACHE(buffer_head,
+				SLAB_RECLAIM_ACCOUNT|SLAB_PANIC|SLAB_MEM_SPREAD);
 	/*
 	 * Limit the bh occupancy to 10% of ZONE_NORMAL
 	 */
--=20
2.39.2


