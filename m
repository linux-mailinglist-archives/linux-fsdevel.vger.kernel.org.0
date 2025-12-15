Return-Path: <linux-fsdevel+bounces-71306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0F2CBD7AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 12:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED35830469B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 11:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24E4330338;
	Mon, 15 Dec 2025 11:15:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CD433032F;
	Mon, 15 Dec 2025 11:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765797318; cv=none; b=YZuItaskxmnSFYMHf00HR/ktsEPVXW2CL4Hbc5pQvtV5D2iUA099ohZ4zwCak0z5/oFszPZPiCiD+3fSUvofflS2HCifIdvSUhhQlfsstYsJymgLT1WcTRxVUlTbMVWpXz+gIqSkl+ClM5FTzBtKbQ0D90PjLjyRGHlGIo3OgJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765797318; c=relaxed/simple;
	bh=PXlAp725fYrDg3F+cW7h+nuedrV4NqKP33ZJQSI6jGM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GjSU6zNIEfEZwqE1idIDFaibt1ELOXjR962uPSADXL5RGSRyB9oIM5KgLjJd9eiet0CbWoqUCm2Z5hTuIudxFAmU8G0XstS+EhDGLLn1NriN4THqBYSxC1SuSq9lhQtE3uMVn+CBxl7MAO6I0EpoG+DMWpjDmPnZTIEutNfvpkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4e5edb18d9a711f0a38c85956e01ac42-20251215
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:3e0eaed8-e63c-44d5-9aae-16fd66b48968,IP:0,UR
	L:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:547e6ca5d6628fb648bacd1f3005be6c,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|898,TC:nil,Content:0|15|50,EDM:5
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4e5edb18d9a711f0a38c85956e01ac42-20251215
X-User: jiangyunshui@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <chenzhang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2032657404; Mon, 15 Dec 2025 19:15:04 +0800
From: chen zhang <chenzhang@kylinos.cn>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenzhang_0901@163.com,
	chen zhang <chenzhang@kylinos.cn>
Subject: [PATCH v2] chardev: Switch to guard(mutex) and __free(kfree)
Date: Mon, 15 Dec 2025 19:15:00 +0800
Message-Id: <20251215111500.159243-1-chenzhang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of using the 'goto label; mutex_unlock()' pattern use
'guard(mutex)' which will release the mutex when it goes out of scope.
Use the __free(kfree) cleanup to replace instances of manually
calling kfree(). Also make some code path simplifications that this
allows.

Signed-off-by: chen zhang <chenzhang@kylinos.cn>
---
 fs/char_dev.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index c2ddb998f3c9..74d4bdfaa9ae 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -10,6 +10,7 @@
 #include <linux/kdev_t.h>
 #include <linux/slab.h>
 #include <linux/string.h>
+#include <linux/cleanup.h>
 
 #include <linux/major.h>
 #include <linux/errno.h>
@@ -97,7 +98,8 @@ static struct char_device_struct *
 __register_chrdev_region(unsigned int major, unsigned int baseminor,
 			   int minorct, const char *name)
 {
-	struct char_device_struct *cd, *curr, *prev = NULL;
+	struct char_device_struct *cd __free(kfree) = NULL;
+	struct char_device_struct *curr, *prev = NULL;
 	int ret;
 	int i;
 
@@ -117,14 +119,14 @@ __register_chrdev_region(unsigned int major, unsigned int baseminor,
 	if (cd == NULL)
 		return ERR_PTR(-ENOMEM);
 
-	mutex_lock(&chrdevs_lock);
+	guard(mutex)(&chrdevs_lock);
 
 	if (major == 0) {
 		ret = find_dynamic_major();
 		if (ret < 0) {
 			pr_err("CHRDEV \"%s\" dynamic allocation region is full\n",
 			       name);
-			goto out;
+			return ERR_PTR(ret);
 		}
 		major = ret;
 	}
@@ -144,7 +146,7 @@ __register_chrdev_region(unsigned int major, unsigned int baseminor,
 		if (curr->baseminor >= baseminor + minorct)
 			break;
 
-		goto out;
+		return ERR_PTR(ret);
 	}
 
 	cd->major = major;
@@ -160,12 +162,7 @@ __register_chrdev_region(unsigned int major, unsigned int baseminor,
 		prev->next = cd;
 	}
 
-	mutex_unlock(&chrdevs_lock);
-	return cd;
-out:
-	mutex_unlock(&chrdevs_lock);
-	kfree(cd);
-	return ERR_PTR(ret);
+	return_ptr(cd);
 }
 
 static struct char_device_struct *
-- 
2.25.1


