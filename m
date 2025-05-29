Return-Path: <linux-fsdevel+bounces-50055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C80F2AC7D2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 13:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EC5E18987DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 11:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AD129188B;
	Thu, 29 May 2025 11:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ts6YCJmj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436DC28ECC1
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 11:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748518421; cv=none; b=YJWRrE8+hNFYxph0Ug0bRiIkh5Jtqdp9TBA4NbTqV4XvCSd/ovwyqPrj1IvoIXQYROpgSVVEJ/5pEm3fnCnstV8nARwMtEiWyuCeizK6+RYGmess5fWa3VVilMH1wZ4rPWNQ3pO2AvSf1zpu1YcHsPaevxpaLcKM7jMFX4suBB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748518421; c=relaxed/simple;
	bh=DEBsNWeSDlOavpo2lUgTrg95DkHmdk/dGCBKPtzRFHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=bkTWIhcOV2scTVrGhBkTIRNGED+BE8k4CsYqi2HTUmVS0wgcLhj/eqFRk5HRRoMGNTD037KaVniPNinXAFFZh+W3uMG6/qeomsNVVBUXxrDXRJwDfOu6CqP7eE2Yc6eHuHuPac96cQERhf2fP8qGdyXo26A2L/3NIVhcx2G0YCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Ts6YCJmj; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250529113338epoutp0434d39c209aaa72415351b9ad295f237a~D-Dzb__4c2607626076epoutp04E
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 11:33:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250529113338epoutp0434d39c209aaa72415351b9ad295f237a~D-Dzb__4c2607626076epoutp04E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748518418;
	bh=y+nkfIOt+3+fBahE/FTnqxhgbR0oamTFyjGP5NPPufo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ts6YCJmjPWjasO0VospUwjxr823S5DCJ0B/nK1nXpt8i+nYK1U+qsXOEVM8hd67Um
	 QXLl5bxMflnDcLN74eUL4Y08XqYwiHBv4b06ElIqDdCid297crZaqYHpnyzzyqIY2y
	 JrasquQ9L2o2lS0EhaqXd6xZI9j62DzNfez58xys=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250529113337epcas5p3f024c11a53bffeb67f7425b656519dc7~D-DyuRv7L3109531095epcas5p3L;
	Thu, 29 May 2025 11:33:37 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.174]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4b7PQ808lcz3hhT7; Thu, 29 May
	2025 11:33:36 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250529113232epcas5p4e6f3b2f03d3a5f8fcaace3ddd03298d0~D-C11dWKS0832408324epcas5p4m;
	Thu, 29 May 2025 11:32:32 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250529113232epsmtrp2605620ed3bb7cb2547eb5f0a4dc89991~D-C10gkfG3187631876epsmtrp2N;
	Thu, 29 May 2025 11:32:32 +0000 (GMT)
X-AuditID: b6c32a52-41dfa70000004c16-e4-683845d00f0d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	95.82.19478.0D548386; Thu, 29 May 2025 20:32:32 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250529113228epsmtip2fac518f078939caf5955dd6c606fa5b7~D-Cx_RSE_2424224242epsmtip2v;
	Thu, 29 May 2025 11:32:28 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, akpm@linux-foundation.org,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com, david@fromorbit.com,
	amir73il@gmail.com, axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com,
	djwong@kernel.org, dave@stgolabs.net, p.raghav@samsung.com,
	da.gomez@samsung.com
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, Kundan Kumar <kundan.kumar@samsung.com>, Anuj Gupta
	<anuj20.g@samsung.com>
Subject: [PATCH 04/13] writeback: affine inode to a writeback ctx within a
 bdi
Date: Thu, 29 May 2025 16:44:55 +0530
Message-Id: <20250529111504.89912-5-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250529111504.89912-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsWy7bCSvO4FV4sMg56b4hbb1u1mt5izfg2b
	xYV1qxktWnf+Z7FomvCX2WL13X42i9eHPzFanJ56lsliyyV7i/eXtzFZrL65htFiy7F7jBaX
	n/BZ7J7+j9Xi5oGdTBYrVx9lspg9vZnJ4sn6WcwWW798ZbW4tMjdYs/ekywW99b8Z7W4cOA0
	q8WNCU8ZLZ7t3shs8XlpC7vFwVMd7Baf5gINOf/3OKvF7x9z2BzkPE4tkvDYOesuu8fmFVoe
	l8+Wemxa1cnmsenTJHaPEzN+s3i82DyT0WP3gs9MHrtvNrB5nLtY4fF+31U2j74tqxg9ps6u
	9ziz4Ai7x4ppF5kChKK4bFJSczLLUov07RK4Mvrf7mIp2M5dMeXuCfYGxuucXYycHBICJhI7
	zzezdTFycQgJbGeUaHq1jAkiISOx++5OVghbWGLlv+fsEEUfGSUeNWwFSnBwsAnoSvxoCgWJ
	iwjcZJY4d/YMWAOzwD9Gid2vdEBsYQE/iW8t51hAbBYBVYkn19ewg9i8ArYSWx9+YYdYIC8x
	89J3MJtTwE5i0ZKvjCC2EFDN0ptrWSDqBSVOznzCAjFfXqJ562zmCYwCs5CkZiFJLWBkWsUo
	mlpQnJuem1xgqFecmFtcmpeul5yfu4kRnBS0gnYwLlv/V+8QIxMH4yFGCQ5mJRHeJnuzDCHe
	lMTKqtSi/Pii0pzU4kOM0hwsSuK8yjmdKUIC6YklqdmpqQWpRTBZJg5OqQYmxpfaGhdVIziz
	TKao3eiztPVfdav36KOd9b6V83kzPh6OWi784W2iYkLX9XnCVw1YLUNqPrXU7nRhnx5s43/u
	w/s9d2vP+srpP2qW8N//K1Zn9dVFTE0cQo5+qZWOV6rqHJdJyzc2BCacVJ7ynf/4/4BTv9bf
	Xi91+HvHpZ7b0rU6bjtnrWm+5fB0t+q+Od31M+T7tQIl9uzaX7hKVs3DXXtB1gb+t02xoVNK
	669F8dWEHT5oeuRToNYFL8XJAmsESlNDik8cbtJhX/z1RaVsxrv8pXZnuo8/0f82J85j89Lw
	aXMFUu/dL+59co9fRfCcfOs1p1xm+bU8bxfqVaW+X5i/s1OvfBnf7MPfzv5XYinOSDTUYi4q
	TgQA1ASJpnkDAAA=
X-CMS-MailID: 20250529113232epcas5p4e6f3b2f03d3a5f8fcaace3ddd03298d0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250529113232epcas5p4e6f3b2f03d3a5f8fcaace3ddd03298d0
References: <20250529111504.89912-1-kundan.kumar@samsung.com>
	<CGME20250529113232epcas5p4e6f3b2f03d3a5f8fcaace3ddd03298d0@epcas5p4.samsung.com>

Affine inode to a writeback context. This helps in minimizing the
filesytem fragmentation due to inode being processed by different
threads.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/fs-writeback.c           | 3 ++-
 include/linux/backing-dev.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 0959fff46235..9529e16c9b66 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -265,7 +265,8 @@ void __inode_attach_wb(struct inode *inode, struct folio *folio)
 {
 	struct backing_dev_info *bdi = inode_to_bdi(inode);
 	struct bdi_writeback *wb = NULL;
-	struct bdi_writeback_ctx *bdi_writeback_ctx = bdi->wb_ctx_arr[0];
+	struct bdi_writeback_ctx *bdi_writeback_ctx =
+						fetch_bdi_writeback_ctx(inode);
 
 	if (inode_cgwb_enabled(inode)) {
 		struct cgroup_subsys_state *memcg_css;
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index fbccb483e59c..30a812fbd488 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -157,7 +157,7 @@ fetch_bdi_writeback_ctx(struct inode *inode)
 {
 	struct backing_dev_info *bdi = inode_to_bdi(inode);
 
-	return bdi->wb_ctx_arr[0];
+	return bdi->wb_ctx_arr[inode->i_ino % bdi->nr_wb_ctx];
 }
 
 #ifdef CONFIG_CGROUP_WRITEBACK
-- 
2.25.1


