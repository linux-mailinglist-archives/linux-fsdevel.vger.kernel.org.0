Return-Path: <linux-fsdevel+bounces-71275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4AACBC43A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 03:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9241A300A87C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 02:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEA0315D3D;
	Mon, 15 Dec 2025 02:44:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C6713AD05;
	Mon, 15 Dec 2025 02:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765766674; cv=none; b=mYmtlc8Llnrt6DgJPEGSUL0wB50jEZLHnxnF3x8ZyBytJlwcb5vt9cBLdLTZHsZ3lnUOulDsyWiAbbsKFUR/uIOC/3vvz/ngB8y+3Hu/2Nc1n3dbQ8yQOvCEXMS3RIH6kb0gGf4V68yrHG2CC4ZuP0sDQzY0irEI94fkOsEP49A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765766674; c=relaxed/simple;
	bh=Wat+8SzSu/r2ncS4XhIRmLGp10EsJegALBFR6IW+GS0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fRV2YhSGQcbicGrwlUW04nAkpHHYJamk5w29PMcjZghzqFh+5taN6I/TT6JxLu+LP2KxS+FVh+sdq8VIEX47tlnvCgbhnAXryj1A6jt/OJZ60dwp5xYof5P4PfVlrX8b8g+5MKKj7EDJLbsZtfrEpgD4VCrQu4mFVW0Am3+YfGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f623c590d95f11f0a38c85956e01ac42-20251215
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:b8802c2d-f7c1-420e-96d7-3f15e3d42127,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:5e6481ef8b84c54c2b6d34138743eae1,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f623c590d95f11f0a38c85956e01ac42-20251215
X-User: jiangyunshui@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <chenzhang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1824232543; Mon, 15 Dec 2025 10:44:22 +0800
From: chen zhang <chenzhang@kylinos.cn>
To: miklos@szeredi.hu,
	mszeredi@redhat.com,
	joannelkoong@gmail.com,
	josef@toxicpanda.com
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	chenzhang_0901@163.com,
	chen zhang <chenzhang@kylinos.cn>
Subject: [PATCH] fuse: use sysfs_emit() instead of sprintf()
Date: Mon, 15 Dec 2025 10:44:16 +0800
Message-Id: <20251215024416.40841-1-chenzhang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Follow the advice in Documentation/filesystems/sysfs.rst:
show() should only use sysfs_emit() or sysfs_emit_at() when formatting
the value to be returned to user space.

Signed-off-by: chen zhang <chenzhang@kylinos.cn>
---
 fs/fuse/cuse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index 28c96961e85d..0c8e7259f489 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -581,7 +581,7 @@ static ssize_t cuse_class_waiting_show(struct device *dev,
 {
 	struct cuse_conn *cc = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%d\n", atomic_read(&cc->fc.num_waiting));
+	return sysfs_emit(buf, "%d\n", atomic_read(&cc->fc.num_waiting));
 }
 static DEVICE_ATTR(waiting, 0400, cuse_class_waiting_show, NULL);
 
-- 
2.25.1


