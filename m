Return-Path: <linux-fsdevel+bounces-71293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C17E0CBC9AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 07:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1C39301A1A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 06:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2103271E1;
	Mon, 15 Dec 2025 06:07:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DDD306B25;
	Mon, 15 Dec 2025 06:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765778833; cv=none; b=JtPM5oXii1IYfgNrpmajKIdTdp4PuA7zhRldXlktN80MnPPvQZ2+afvbqg1NeEc480SNJw3OnRJE2V08sAJJlyED6pOmaXzViT0M/hvnIT4uaNW1c108T0Ad/g/dharfyjjNQPqRzSeQ1sIWfGtdChdBoE7z4oHsc1Y2FkDP6zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765778833; c=relaxed/simple;
	bh=FYHvfTarUnEsLEMm0tTj9spsvla7d8RVeOgvfpXwUVc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pu1kvnr7p058igfYV+x653mS8GiCaCH2sYJOjiyAt2hPrdFHJZ6vflQa+CiZGmze2Pkjis+Hq5VUPBhZ+Ui0FF3uVIpvnhbGRRkX7nHJ3h6+9lPyRUqZoxm1AYOAxBF+Eb9Axh5zslkEUKsEtxqkARTWBA8vWkpG9WHbHXydqSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 46057a42d97c11f0a38c85956e01ac42-20251215
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:2aee8673-7b9a-48e8-a02e-61890e5ba0a7,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:a9d874c,CLOUDID:e2302d1aa02a200027fdca03db88b56b,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 46057a42d97c11f0a38c85956e01ac42-20251215
X-User: jiangyunshui@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <chenzhang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1768722141; Mon, 15 Dec 2025 14:07:02 +0800
From: chen zhang <chenzhang@kylinos.cn>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenzhang_0901@163.com,
	chen zhang <chenzhang@kylinos.cn>
Subject: [PATCH] chardev: Switch to guard(mutex)
Date: Mon, 15 Dec 2025 14:06:57 +0800
Message-Id: <20251215060657.87947-1-chenzhang@kylinos.cn>
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

Signed-off-by: chen zhang <chenzhang@kylinos.cn>
---
 fs/char_dev.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/char_dev.c b/fs/char_dev.c
index c2ddb998f3c9..ca6037304e19 100644
--- a/fs/char_dev.c
+++ b/fs/char_dev.c
@@ -117,14 +117,15 @@ __register_chrdev_region(unsigned int major, unsigned int baseminor,
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
+			kfree(cd);
+			return ERR_PTR(ret);
 		}
 		major = ret;
 	}
@@ -144,7 +145,8 @@ __register_chrdev_region(unsigned int major, unsigned int baseminor,
 		if (curr->baseminor >= baseminor + minorct)
 			break;
 
-		goto out;
+		kfree(cd);
+		return ERR_PTR(ret);
 	}
 
 	cd->major = major;
@@ -160,12 +162,7 @@ __register_chrdev_region(unsigned int major, unsigned int baseminor,
 		prev->next = cd;
 	}
 
-	mutex_unlock(&chrdevs_lock);
 	return cd;
-out:
-	mutex_unlock(&chrdevs_lock);
-	kfree(cd);
-	return ERR_PTR(ret);
 }
 
 static struct char_device_struct *
-- 
2.25.1


