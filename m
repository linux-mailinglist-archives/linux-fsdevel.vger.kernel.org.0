Return-Path: <linux-fsdevel+bounces-71303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56828CBD4E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 11:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D5863017CB8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 10:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D002A314B91;
	Mon, 15 Dec 2025 10:02:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5014029ACC5;
	Mon, 15 Dec 2025 10:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765792952; cv=none; b=f0KN9BjLm2BKb9+p2YHPcFi8OeUN1MsJa3HcY4MXmXt+LeyoHkTBGVU15s6zlcD8vAb/l6jHfoeTn6WjxdZMOJG5UKhNK+z33lD6+LRhQjGDIMQCS/v8ytMvvF3kam+r4fJkizn2vA4C8obRYHLWgfwcFN9sONVlY0dY0hFaDbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765792952; c=relaxed/simple;
	bh=GyeIkxR1+30Py3QYSp0HmOcopTRz4jeq8pA2AK1hE0U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eqxQW+LN9T5s4Yb/CVHmPVyDMH6WYcObcZTdSKx9PKUo/w8ld4O10zCOMs5GRyFvGt1XELf/T1zpbpzjkLSOp3kiUigXKNB6JKDotUXKbPSUXrqcdeLQRsRIdT7XxixNakWeJJfScjLzLefF5Nmp7Acx0TG6Q7U7TQWrxI3nQPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 23fa53d4d99d11f0a38c85956e01ac42-20251215
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:fd9a8df2-f284-44c2-a57f-92218c27e60d,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:a9d874c,CLOUDID:7adbf85120823665fc4c7ba17ce066e1,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 23fa53d4d99d11f0a38c85956e01ac42-20251215
X-User: jiangyunshui@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <chenzhang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1710653524; Mon, 15 Dec 2025 18:02:18 +0800
From: chen zhang <chenzhang@kylinos.cn>
To: miklos@szeredi.hu,
	mszeredi@redhat.com,
	joannelkoong@gmail.com,
	josef@toxicpanda.com,
	gmaglione@redhat.com,
	vgoyal@redhat.com
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	chenzhang_0901@163.com,
	chen zhang <chenzhang@kylinos.cn>
Subject: [PATCH] virtio_fs: use sysfs_emit_at() instead of snprintf()
Date: Mon, 15 Dec 2025 18:02:14 +0800
Message-Id: <20251215100214.144568-1-chenzhang@kylinos.cn>
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
 fs/fuse/virtio_fs.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index b2f6486fe1d5..7466e5d6baa2 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -234,7 +234,6 @@ static ssize_t cpu_list_show(struct kobject *kobj,
 	struct virtio_fs *fs = container_of(kobj->parent->parent, struct virtio_fs, kobj);
 	struct virtio_fs_vq *fsvq = virtio_fs_kobj_to_vq(fs, kobj);
 	unsigned int cpu, qid;
-	const size_t size = PAGE_SIZE - 1;
 	bool first = true;
 	int ret = 0, pos = 0;
 
@@ -244,18 +243,20 @@ static ssize_t cpu_list_show(struct kobject *kobj,
 	qid = fsvq->vq->index;
 	for (cpu = 0; cpu < nr_cpu_ids; cpu++) {
 		if (qid < VQ_REQUEST || (fs->mq_map[cpu] == qid)) {
-			if (first)
-				ret = snprintf(buf + pos, size - pos, "%u", cpu);
-			else
-				ret = snprintf(buf + pos, size - pos, ", %u", cpu);
-
-			if (ret >= size - pos)
-				break;
-			first = false;
+			if (first) {
+				ret = sysfs_emit_at(buf, pos, "%u", cpu);
+				first = false;
+			} else
+				ret = sysfs_emit_at(buf, pos, ", %u", cpu);
+
+			if (ret < 0)
+				return  -EINVAL;
 			pos += ret;
 		}
 	}
-	ret = snprintf(buf + pos, size + 1 - pos, "\n");
+	ret = sysfs_emit_at(buf, pos, "\n");
+	if (ret < 0)
+		return -EINVAL;
 	return pos + ret;
 }
 
-- 
2.25.1


