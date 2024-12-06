Return-Path: <linux-fsdevel+bounces-36599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9710E9E63C1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 02:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 531DE285750
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 01:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F3A14A099;
	Fri,  6 Dec 2024 01:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="JXsdLF5S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D953917A5BD
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 01:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733450018; cv=none; b=I/e1pxfYvmwJIYXnE1wa9PMClADyYXOuol/t4HcYr/ZGwMmdMUHj/xciBVdHeGq/drGkGhssw7isbriXqJtLhyitfGuvA5GlUn2BuR5AfbMdD84lU7bkEQx4B34uPcymUxpcwQKTh2geOecPlvnD8IoiX50WeUONuHZ0EOjscF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733450018; c=relaxed/simple;
	bh=oSucAwfLbsC0ZrBCRDPimPdNR0z47lozSlk2cE3qr84=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nJblpmfj0WMnIAkVc/lU+ShDifv2ndjf8LFyRWHgJ9VrYA/aypXzbZG/pdtR8zt4gxc4AQch1KEupaZ1Vt4IzNp+N5Wzb6F0mzpyRkOyOHSRGZicou2E4Fn7VTz3/EkS+s8nKN0Y6nJPJ5BoXA+K0lGcX0fZXKvUFNflFVgPs+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=JXsdLF5S; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4B605ewj013917
	for <linux-fsdevel@vger.kernel.org>; Thu, 5 Dec 2024 17:53:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=zlAb0pn1DAyajDFVPLOKoAhYRE5EXTu7nKt9gAZEWPg=; b=JXsdLF5SM5mK
	nkAguF4E9ngzY2b6bVDyQv5PIYAYIwM4Jt2tU/BPsCZz5OKM4CFNc7vB9qFllRcj
	ZSVHryvVwjTYzVXPGfhGTM7w38LwXAHcuOgGOFUEP9lyIuul+5TRC8yA9KGyqCF5
	rmX5WJEYi7a2tsKCTx0EXLHo1uoFzGbTonUv9T2BXP+YcQfziggKJa4h9CYGWRFv
	XXzyvtaxN3TH6ZlCpMWubAR6YtgpDN4v20KaGdPK/4SnReoIOIoJhaVi9YLCTDhl
	Pl7sgcli9DAEYyWh9NHItfVUqXbwVjaa7j+q4UsidV6odQrP+z7KHjCQdpZjf7N9
	q1FVzkGdwg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 43bmrwh5m2-16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2024 17:53:35 -0800 (PST)
Received: from twshared9216.15.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 6 Dec 2024 01:53:25 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 6C47E15B2115E; Thu,  5 Dec 2024 17:53:09 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <io-uring@vger.kernel.org>
CC: <sagi@grimberg.me>, <asml.silence@gmail.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv11 10/10] nvme: use fdp streams if write stream is provided
Date: Thu, 5 Dec 2024 17:53:08 -0800
Message-ID: <20241206015308.3342386-11-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241206015308.3342386-1-kbusch@meta.com>
References: <20241206015308.3342386-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: MwAhNKsomq-CjyeBD_A3eGI5tQY6QKaD
X-Proofpoint-ORIG-GUID: MwAhNKsomq-CjyeBD_A3eGI5tQY6QKaD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

From: Keith Busch <kbusch@kernel.org>

Maps a user requested write stream to an FDP placement ID if possible.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 32 +++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 410a77de92f88..c6f48403fc51c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -997,6 +997,18 @@ static inline blk_status_t nvme_setup_rw(struct nvme=
_ns *ns,
 	if (req->cmd_flags & REQ_RAHEAD)
 		dsmgmt |=3D NVME_RW_DSM_FREQ_PREFETCH;
=20
+	if (op =3D=3D nvme_cmd_write && ns->head->nr_plids) {
+		u16 write_stream =3D req->bio->bi_write_stream;
+
+		if (WARN_ON_ONCE(write_stream > ns->head->nr_plids))
+			return BLK_STS_INVAL;
+
+		if (write_stream) {
+			dsmgmt |=3D ns->head->plids[write_stream - 1] << 16;
+			control |=3D NVME_RW_DTYPE_DPLCMT;
+		}
+	}
+
 	if (req->cmd_flags & REQ_ATOMIC && !nvme_valid_atomic_write(req))
 		return BLK_STS_INVAL;
=20
@@ -2197,11 +2209,12 @@ static int nvme_check_fdp(struct nvme_ns *ns, str=
uct nvme_ns_info *info,
=20
 static int nvme_query_fdp_info(struct nvme_ns *ns, struct nvme_ns_info *=
info)
 {
+	struct nvme_fdp_ruh_status_desc *ruhsd;
 	struct nvme_ns_head *head =3D ns->head;
 	struct nvme_fdp_ruh_status *ruhs;
 	struct nvme_command c =3D {};
 	u32 fdp, fdp_idx;
-	int size, ret;
+	int size, ret, i;
=20
 	ret =3D nvme_get_features(ns->ctrl, NVME_FEAT_FDP, info->endgid, NULL, =
0,
 				&fdp);
@@ -2235,6 +2248,19 @@ static int nvme_query_fdp_info(struct nvme_ns *ns,=
 struct nvme_ns_info *info)
 	if (!head->nr_plids)
 		goto free;
=20
+	head->nr_plids =3D min(head->nr_plids, NVME_MAX_PLIDS);
+	head->plids =3D kcalloc(head->nr_plids, sizeof(head->plids),
+			      GFP_KERNEL);
+	if (!head->plids) {
+		ret =3D -ENOMEM;
+		goto free;
+	}
+
+	for (i =3D 0; i < head->nr_plids; i++) {
+		ruhsd =3D &ruhs->ruhsd[i];
+		head->plids[i] =3D le16_to_cpu(ruhsd->pid);
+	}
+
 	kfree(ruhs);
 	return 0;
=20
@@ -2289,6 +2315,10 @@ static int nvme_update_ns_info_block(struct nvme_n=
s *ns,
 				"FDP failure status:0x%x\n", ret);
 		if (ret < 0)
 			goto out;
+	} else {
+		ns->head->nr_plids =3D 0;
+		kfree(ns->head->plids);
+		ns->head->plids =3D NULL;
 	}
=20
 	blk_mq_freeze_queue(ns->disk->queue);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 5c8bdaa2c8824..4c12d35b3e39e 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -495,6 +495,7 @@ struct nvme_ns_head {
 	struct gendisk		*disk;
=20
 	u16			nr_plids;
+	u16			*plids;
 #ifdef CONFIG_NVME_MULTIPATH
 	struct bio_list		requeue_list;
 	spinlock_t		requeue_lock;
--=20
2.43.5


