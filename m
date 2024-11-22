Return-Path: <linux-fsdevel+bounces-35569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 811FE9D5E6F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 12:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 335CE1F22B81
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 11:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F9C1DE2A4;
	Fri, 22 Nov 2024 11:54:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8191779BD;
	Fri, 22 Nov 2024 11:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732276487; cv=none; b=r75mhI/7vdzZkTlezPwtRGDfagMMIrkJTJ/cJMboAdpD102tBjTre63lJFz/nXo+mZUhEqOE1PHnB3t88fhFUAz0szy8b1DxLN6PVZp6Ouz4OCkZpdONOu1Cz4vPu3R5tEuVo20Pp9E26kdFxTxDeoYowv1cjxyqmmltXE0jZb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732276487; c=relaxed/simple;
	bh=cIZ/m6h0Qlf0xisGQXrtvorYEXPPbp8A55cAfF1RhJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XWXOqVVKJKVNDaJNCY7/sV280PFcRi54/Z/gFZGGg7ErdHMVgUCtBc/DVE7TseQxPHK4fxUIKzj75pEckE7ycx8/Fpy2SUm1JP1KWMv4ENnbUVX46eebSH7Dsn7TN6ehkTCbzo1chOZw7oXk4vL2t2VBbr4bq3LL2fZyU5nh70Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 8c41c9b0a8c811efa216b1d71e6e1362-20241122
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:4265bc8a-81c5-4cb0-bb10-d69d2a0573a4,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:82c5f88,CLOUDID:a8d355a933fd5e17785e4c1f0f4941f5,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:5,IP:nil,URL:0,
	File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:N
	O,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8c41c9b0a8c811efa216b1d71e6e1362-20241122
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangheng@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1996190283; Fri, 22 Nov 2024 19:54:37 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 0890EE0080FF;
	Fri, 22 Nov 2024 19:54:37 +0800 (CST)
X-ns-mid: postfix-674070FC-7993913
Received: from kylin-pc.. (unknown [172.25.130.133])
	by mail.kylinos.cn (NSMail) with ESMTPA id 7E8DCE0080FF;
	Fri, 22 Nov 2024 19:54:27 +0800 (CST)
From: zhangheng <zhangheng@kylinos.cn>
To: willy@infradead.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangheng <zhangheng@kylinos.cn>
Subject: [PATCH] idr-test: ida_simple_get/remove are deprecated, so switch to ida_alloc/free.
Date: Fri, 22 Nov 2024 19:54:25 +0800
Message-ID: <20241122115425.3820230-1-zhangheng@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: zhangheng <zhangheng@kylinos.cn>
---
 tools/testing/radix-tree/idr-test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/radix-tree/idr-test.c b/tools/testing/radix-tr=
ee/idr-test.c
index 84b8c3c92c79..7fb04a830a21 100644
--- a/tools/testing/radix-tree/idr-test.c
+++ b/tools/testing/radix-tree/idr-test.c
@@ -505,12 +505,12 @@ void ida_simple_get_remove_test(void)
 	unsigned long i;
=20
 	for (i =3D 0; i < 10000; i++) {
-		assert(ida_simple_get(&ida, 0, 20000, GFP_KERNEL) =3D=3D i);
+		assert(ida_alloc_range(&ida, 0, 19999, GFP_KERNEL) =3D=3D i);
 	}
-	assert(ida_simple_get(&ida, 5, 30, GFP_KERNEL) < 0);
+	assert(ida_alloc_range(&ida, 5, 29, GFP_KERNEL) < 0);
=20
 	for (i =3D 0; i < 10000; i++) {
-		ida_simple_remove(&ida, i);
+		ida_free(&ida, i);
 	}
 	assert(ida_is_empty(&ida));
=20
--=20
2.45.2


