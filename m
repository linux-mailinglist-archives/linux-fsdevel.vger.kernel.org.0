Return-Path: <linux-fsdevel+bounces-27207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A18395F7BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 19:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5DB32834D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 17:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD6E191473;
	Mon, 26 Aug 2024 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iH8b29yr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2616C198A0E
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 17:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724692478; cv=none; b=DXx3Ym1NgVXFOjLRqk7trsEhoA/NbIYq8BcfSbwqRnmVXY+LwBTyplxrPTm+vtBrpZeWq0XUTzBn2+KAYbKY9QS7IqglwtvT75peeOr+AqjtrXCgeAZ0dIJ2klxBD/WamZ7T/879li3q7uf2diW73Tj/aFevRQjDJC0VyDHdObs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724692478; c=relaxed/simple;
	bh=xt2LPYyXQ00HT9y64535LFuaSA1NJuGaMN3kkUbOXTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=SvTcMeaZrE5txSb/1lqOfPmQf2Zmj4E7y/y0v1zVLDfO3jt+iKdeVdhek4OvqfCiTam0JLOcJ2577tiTNNDZe16DcJzQFQHMlIBj//pkwNXR4GJwMPJnTw362yTlph6wLwRvXh2L4hrTjdEzm7YSJxRy5dohAWWdBDAwAIGxqdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=iH8b29yr; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240826171434epoutp0498aca9f83a891c58056d9510b30cc5be~vVqrmqjr20751607516epoutp04a
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 17:14:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240826171434epoutp0498aca9f83a891c58056d9510b30cc5be~vVqrmqjr20751607516epoutp04a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724692474;
	bh=8iPZaxnpfFrIc7zaxv8ZaN+SPBoGhDtwQfdoxDKuShI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iH8b29yrbZjHaH35JXRSp1sDkUVuN+m8jfDoWxYmsvFlYohHpAhsxfx6FzRyWc2t/
	 GEoMMKY7w7BA5b64fMb5RtGTgk1WqTi4cEB/kFYqQhZDd2rKhJgvP3e7NW/NV53LIj
	 wJG1saSf3E3XZlaEsh+uUuMRKzvaqWBb6l82X6WM=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240826171432epcas5p4bbeed704b13c2c041148a447d33bf5be~vVqqRDdqX3116731167epcas5p4Q;
	Mon, 26 Aug 2024 17:14:32 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Wsy2v279bz4x9Pp; Mon, 26 Aug
	2024 17:14:31 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	81.B3.09642.6F7BCC66; Tue, 27 Aug 2024 02:14:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240826171430epcas5p3d8e34a266ced7b3ea0df2a11b83292ae~vVqoOYF0n1118211182epcas5p3m;
	Mon, 26 Aug 2024 17:14:30 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240826171430epsmtrp2a8d6ae6dc2221cc5f2dd7ba34e9c1b7e~vVqoLASCB3048030480epsmtrp2m;
	Mon, 26 Aug 2024 17:14:30 +0000 (GMT)
X-AuditID: b6c32a4b-879fa700000025aa-5b-66ccb7f6a7a5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	DF.51.19367.6F7BCC66; Tue, 27 Aug 2024 02:14:30 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240826171426epsmtip243cd9f8a60035672848defe83d52dea1~vVqkKvu2X0834608346epsmtip2P;
	Mon, 26 Aug 2024 17:14:26 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
	brauner@kernel.org, jack@suse.cz, jaegeuk@kernel.org, jlayton@kernel.org,
	chuck.lever@oracle.com, bvanassche@acm.org
Cc: linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com, vishak.g@samsung.com,
	javier.gonz@samsung.com, Kanchan Joshi <joshi.k@samsung.com>, Nitesh Shetty
	<nj.shetty@samsung.com>, Hui Qi <hui81.qi@samsung.com>
Subject: [PATCH v4 5/5] nvme: enable FDP support
Date: Mon, 26 Aug 2024 22:36:06 +0530
Message-Id: <20240826170606.255718-6-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240826170606.255718-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ta0xTZxjHcy6cHgydB9DwShZgNW4CQlug5a0T0Uj0IEQxyxbih9UODheB
	tvS06pzbCGxMBORihFmGEAWcVVbucqtTroGhEBDlIgwYpAF0ol1gCBtrKTq//Z7n/f/f53ne
	C4k5vCScyVi5mlHJZfE8YhNe1+ru7rV0pydKYHyMwVtjWQScb32FwLyFZQyujRlROHyvAYU3
	b7WjsKGsnAML8lNQOK3XYrAyi4R/PDVx4HKZjgPb154TMLflMQINI56w/9oh2GzowmFR2QwH
	pj+pJ+CNzn9RWLdShMFf5l/gsFf7E2efEz3wKITuHa/E6bzcboIeeKChq3RpBF1d8i3dVGxC
	6abhJIJ+OTOC0xdrdAjdU9zGoU1VLmF2x+P2xDCySEblxsgjFJGx8ugAXsgn0gNSkVgg9BJK
	oD/PTS5LYAJ4QaFhXgdj480z89xOyeI15lSYjGV5/L17VAqNmnGLUbDqAB6jjIxX+im9WVkC
	q5FHe8sZ9W6hQOAjMgtPxMXUau8RyruiM0OLGXgSctPzAmJLAsoPzOpT0QvIJtKBakJAxWgt
	xxq8QkDW7SHsbTBbch97Y3ky2EZYFxoQ8FtNH24NTAgw9iyaVSRJUO6g75LGkt9CpaCgsvz1
	ugOjRlDQNPszYhE5UgKQvMJadsWpHaCtQGdjYS4lAdlp11BrNVdwpX+JY2FbajdYW3jBsWrs
	QdeVadzCmFmTUluw3iqg0m1BQUfFhjkINGc/3GBHMNdZw7GyMzD9aSCsHAcmpiZwK58D9dUX
	bawcCJJWh2wsfWLmYfSNfGut90DmyjRqSQOKC86nOljVH4Dx3JkNpxOY/LFkg2mgL+vYON9M
	BEzWZuHZiKv2nRG074yg/b9aMYLpkG2Mkk2IZliR0lfOnH57sxGKhCpk/e17hNQjUxML3i0I
	SiItCCAx3hauy0BXlAM3UvblWUalkKo08QzbgojMZ5yDOW+NUJg/j1wtFfpJBH5isdhP4isW
	8py4898XRjpQ0TI1E8cwSkb1xoeSts5J6GdTpdXpHn9nf9zkiiVutTPwlzprugqyxPnjnGeD
	k6k7jRnnJzM8V45q/FcLjY/0oz5BY4sD+xxPYqeKYurmsJHQz/Vh5Dfh+4/xt5Uasqs7bRr/
	Gv19+PKh5JD2qKsZm6OMXlUfipolhYlnDpb2Jhy5/1Hp3jt9uszrVXI7Q+BJ4z/LxGhrovM5
	+wf81l2b1ca00IfhXPf0uz6G/V2vG3cdWT1+2D7vrDS4JPN5/7PgxeuNzTmVrFNvrO/t1aLi
	VP4Pvm02hhxy+xeD/uj7sxV1Hdtd3Ce/K38qNZ3+WhJ4QB/sm/rrV1eHmMs7Anb2hed7j0Yk
	dq98ivUdPnYCS55rn13r5uFsjEzogalY2X/d+SZVhAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra1BMYRjHveeczjk14thuh9jG5lZRGZle5PaFM2gGYwxhONpTYVs7u20u
	MZaIrYhQOqEk2+w2SvebdthKUyJdVVNoSUiKmmSiZdsx07f/8/x+8/w/PCQqeITNIg9Jwzi5
	lJWIcBussELksmSkqC7IWx3pAjO74nDYV/EDwITBXyg0dfUisP1JCQK1mVUILNE8JGByYiQC
	P2TzKMyJI+H7ziEC/tLoCFhl6sdhvKEVwPIOD9iYthE+Lq/BYIqmh4Axr4txmFE9jsDCsRQU
	ZvUNYLCev02sc2Kamjcz9W9yMCYhvhZnml4omVydGmfy0s8wZalDCFPWrsKZ7z0dGHMlXweY
	utRKghnKFW6dGmDjJ+Ykh8I5udeaAzYhBfwTXKZffrxtJBZTAa1HNLAmacqHft1SiUcDG1JA
	FQH6y9Bn3AKc6MjWUcKS7WjteC9hkb4DOtY4ZhUNSBKn3OhX15XmvT11HaHPdedj5gGlPiJ0
	V3I+YpbsKG/63JjCfAij5tOVyTorc7alVtBX1WmIpcCFTmr8OVFmTa2kTYMDE1nwz9HWZRAW
	fwZdk/QBM2f0nx9ZkIxeBRQ/CfGTUCpAdMCBkylCg0MDZUs9FWyoQikN9gw8GpoLJp7qvr0Y
	aLL/eBoAQgIDoElUZG8rbKoJEtiK2RMnOfnR/XKlhFMYgDOJiZxsXSVqsYAKZsO4Ixwn4+T/
	KUJaz1IhmwhfVW/enYbBm9tciuJfFe7lTqwNUOm9ZwbEjZgCo84Xl9dnVNQuqjwlHXUEbf4B
	rs7PYwybnt092GiV+O596Ybutn33SvasV2oHe5rFFzV2hgcRM+f6R7ndLeGJy8KpCeFnhY6O
	T+W3+FFj71PrlO7O1B3oMSj0ejGlPqQivGXevtjADpOofe6Gt1m/d5Wd9n057WXpDW5OsXg4
	3eGSEx8Tt2xbn1db+s6s+abhhIhVaasXdvRPuW/EPhl4YwP7+ULr28zDnSnO2/OlM/LUvux0
	/ezarwPSa116h+GgM9XfFCO7F/hIcqBR4zd7WN+S+3NxOi7acjvcge3O7lyglZEiTBHCLnVH
	5Qr2L7cQEX5DAwAA
X-CMS-MailID: 20240826171430epcas5p3d8e34a266ced7b3ea0df2a11b83292ae
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240826171430epcas5p3d8e34a266ced7b3ea0df2a11b83292ae
References: <20240826170606.255718-1-joshi.k@samsung.com>
	<CGME20240826171430epcas5p3d8e34a266ced7b3ea0df2a11b83292ae@epcas5p3.samsung.com>

Flexible Data Placement (FDP), as ratified in TP 4146a, allows the host
to control the placement of logical blocks so as to reduce the SSD WAF.

Userspace can send the data placement information using the write hints.
Fetch the placement-identifiers if the device supports FDP.

The incoming placement hint is mapped to a placement-identifier, which
in turn is set in the DSPEC field of the write command.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Hui Qi <hui81.qi@samsung.com>
---
 drivers/nvme/host/core.c | 81 ++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  4 ++
 include/linux/nvme.h     | 19 ++++++++++
 3 files changed, 104 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 33fa01c599ad..f93abd7fb163 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -43,6 +43,20 @@ struct nvme_ns_info {
 	bool is_removed;
 };
 
+struct nvme_fdp_ruh_status_desc {
+	u16 pid;
+	u16 ruhid;
+	u32 earutr;
+	u64 ruamw;
+	u8  rsvd16[16];
+};
+
+struct nvme_fdp_ruh_status {
+	u8  rsvd0[14];
+	__le16 nruhsd;
+	struct nvme_fdp_ruh_status_desc ruhsd[];
+};
+
 unsigned int admin_timeout = 60;
 module_param(admin_timeout, uint, 0644);
 MODULE_PARM_DESC(admin_timeout, "timeout in seconds for admin commands");
@@ -656,6 +670,7 @@ static void nvme_free_ns_head(struct kref *ref)
 	ida_free(&head->subsys->ns_ida, head->instance);
 	cleanup_srcu_struct(&head->srcu);
 	nvme_put_subsystem(head->subsys);
+	kfree(head->plids);
 	kfree(head);
 }
 
@@ -958,6 +973,17 @@ static bool nvme_valid_atomic_write(struct request *req)
 	return true;
 }
 
+static inline void nvme_assign_placement_id(struct nvme_ns *ns,
+					struct request *req,
+					struct nvme_command *cmd)
+{
+	u8 h = umin(ns->head->nr_plids - 1,
+				WRITE_PLACEMENT_HINT(req->write_hint));
+
+	cmd->rw.control |= cpu_to_le16(NVME_RW_DTYPE_DPLCMT);
+	cmd->rw.dsmgmt |= cpu_to_le32(ns->head->plids[h] << 16);
+}
+
 static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 		struct request *req, struct nvme_command *cmnd,
 		enum nvme_opcode op)
@@ -1077,6 +1103,8 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 		break;
 	case REQ_OP_WRITE:
 		ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_write);
+		if (!ret && ns->head->nr_plids)
+			nvme_assign_placement_id(ns, req, cmd);
 		break;
 	case REQ_OP_ZONE_APPEND:
 		ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_zone_append);
@@ -2113,6 +2141,52 @@ static int nvme_update_ns_info_generic(struct nvme_ns *ns,
 	return ret;
 }
 
+static int nvme_fetch_fdp_plids(struct nvme_ns *ns, u32 nsid)
+{
+	struct nvme_command c = {};
+	struct nvme_fdp_ruh_status *ruhs;
+	struct nvme_fdp_ruh_status_desc *ruhsd;
+	int size, ret, i;
+
+refetch_plids:
+	size = struct_size(ruhs, ruhsd, ns->head->nr_plids);
+	ruhs = kzalloc(size, GFP_KERNEL);
+	if (!ruhs)
+		return -ENOMEM;
+
+	c.imr.opcode = nvme_cmd_io_mgmt_recv;
+	c.imr.nsid = cpu_to_le32(nsid);
+	c.imr.mo = 0x1;
+	c.imr.numd =  cpu_to_le32((size >> 2) - 1);
+
+	ret = nvme_submit_sync_cmd(ns->queue, &c, ruhs, size);
+	if (ret)
+		goto out;
+
+	if (!ns->head->nr_plids) {
+		ns->head->nr_plids = le16_to_cpu(ruhs->nruhsd);
+		ns->head->nr_plids =
+			min_t(u16, ns->head->nr_plids, NVME_MAX_PLIDS);
+
+		if (!ns->head->nr_plids)
+			goto out;
+
+		kfree(ruhs);
+		goto refetch_plids;
+	}
+	ns->head->plids = kzalloc(ns->head->nr_plids * sizeof(u16), GFP_KERNEL);
+	if (!ns->head->plids)
+		return -ENOMEM;
+
+	for (i = 0; i < ns->head->nr_plids; i++) {
+		ruhsd = &ruhs->ruhsd[i];
+		ns->head->plids[i] = le16_to_cpu(ruhsd->pid);
+	}
+out:
+	kfree(ruhs);
+	return ret;
+}
+
 static int nvme_update_ns_info_block(struct nvme_ns *ns,
 		struct nvme_ns_info *info)
 {
@@ -2204,6 +2278,13 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 		if (ret && !nvme_first_scan(ns->disk))
 			goto out;
 	}
+	if (ns->ctrl->ctratt & NVME_CTRL_ATTR_FDPS) {
+		ret = nvme_fetch_fdp_plids(ns, info->nsid);
+		if (ret)
+			dev_warn(ns->ctrl->device,
+				"FDP failure status:0x%x\n", ret);
+	}
+
 
 	ret = 0;
 out:
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ae5314d32943..7516823ff8dd 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -450,6 +450,8 @@ struct nvme_ns_ids {
 	u8	csi;
 };
 
+#define NVME_MAX_PLIDS   (MAX_PLACEMENT_HINT_VAL  + 1)
+
 /*
  * Anchor structure for namespaces.  There is one for each namespace in a
  * NVMe subsystem that any of our controllers can see, and the namespace
@@ -471,6 +473,8 @@ struct nvme_ns_head {
 	struct kref		ref;
 	bool			shared;
 	bool			passthru_err_log_enabled;
+	u16			nr_plids;
+	u16			*plids;
 	struct nvme_effects_log *effects;
 	u64			nuse;
 	unsigned		ns_id;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 7b2ae2e43544..12d8db13b66e 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -275,6 +275,7 @@ enum nvme_ctrl_attr {
 	NVME_CTRL_ATTR_HID_128_BIT	= (1 << 0),
 	NVME_CTRL_ATTR_TBKAS		= (1 << 6),
 	NVME_CTRL_ATTR_ELBAS		= (1 << 15),
+	NVME_CTRL_ATTR_FDPS		= (1 << 19),
 };
 
 struct nvme_id_ctrl {
@@ -843,6 +844,7 @@ enum nvme_opcode {
 	nvme_cmd_resv_register	= 0x0d,
 	nvme_cmd_resv_report	= 0x0e,
 	nvme_cmd_resv_acquire	= 0x11,
+	nvme_cmd_io_mgmt_recv	= 0x12,
 	nvme_cmd_resv_release	= 0x15,
 	nvme_cmd_zone_mgmt_send	= 0x79,
 	nvme_cmd_zone_mgmt_recv	= 0x7a,
@@ -864,6 +866,7 @@ enum nvme_opcode {
 		nvme_opcode_name(nvme_cmd_resv_register),	\
 		nvme_opcode_name(nvme_cmd_resv_report),		\
 		nvme_opcode_name(nvme_cmd_resv_acquire),	\
+		nvme_opcode_name(nvme_cmd_io_mgmt_recv),	\
 		nvme_opcode_name(nvme_cmd_resv_release),	\
 		nvme_opcode_name(nvme_cmd_zone_mgmt_send),	\
 		nvme_opcode_name(nvme_cmd_zone_mgmt_recv),	\
@@ -1015,6 +1018,7 @@ enum {
 	NVME_RW_PRINFO_PRCHK_GUARD	= 1 << 12,
 	NVME_RW_PRINFO_PRACT		= 1 << 13,
 	NVME_RW_DTYPE_STREAMS		= 1 << 4,
+	NVME_RW_DTYPE_DPLCMT		= 2 << 4,
 	NVME_WZ_DEAC			= 1 << 9,
 };
 
@@ -1102,6 +1106,20 @@ struct nvme_zone_mgmt_recv_cmd {
 	__le32			cdw14[2];
 };
 
+struct nvme_io_mgmt_recv_cmd {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__le64			rsvd2[2];
+	union nvme_data_ptr	dptr;
+	__u8			mo;
+	__u8			rsvd11;
+	__u16			mos;
+	__le32			numd;
+	__le32			cdw12[4];
+};
+
 enum {
 	NVME_ZRA_ZONE_REPORT		= 0,
 	NVME_ZRASF_ZONE_REPORT_ALL	= 0,
@@ -1822,6 +1840,7 @@ struct nvme_command {
 		struct nvmf_auth_receive_command auth_receive;
 		struct nvme_dbbuf dbbuf;
 		struct nvme_directive_cmd directive;
+		struct nvme_io_mgmt_recv_cmd imr;
 	};
 };
 
-- 
2.25.1


