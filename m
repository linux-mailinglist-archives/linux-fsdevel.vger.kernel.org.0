Return-Path: <linux-fsdevel+bounces-41581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C576A32695
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 14:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4A1A188AD14
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2025 13:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D12720E018;
	Wed, 12 Feb 2025 13:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SoMnpL3+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169BA209F4B
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2025 13:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739365681; cv=none; b=iMh/GYlKO+P6uSO/9EN+zW2FHsm6unE1Z2x/LHjZK9E6LQo1TRbmjjU/Ynjj/4eMvuoLXxTYn/iEuCTbm7PfdeUS4xnNmVb0H0imu/J1MO6GA8OnTnCrvpymDIAz3cb1zJ62EDNAX09E/K+3jfLg9euNMQNBiYDqOyWIskVocMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739365681; c=relaxed/simple;
	bh=Xlz7lh5nb4tKA4hMucrgKfSq16jZXHPDVgIo0xXrdQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=KC6cXAXQXFbscvtMG7JV0zXrVZAQKcki4Jgh7YSWIXveb5mFgO8ZOrv/6Bz5MBcFMsvr6iDZCorP2JnzO77g7EjCSvbLtLHNEHuyLsXhZ3uC3NGxBh6Exn/1Jup9KP821l8MnOPwgelwTwsGy4LFdGUsdDE0JcHslHtdLS0okJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=SoMnpL3+; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250212130755epoutp0345f2f3e13ca3d52faa60d2d5a160654b~jd93Qio411971119711epoutp03I
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2025 13:07:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250212130755epoutp0345f2f3e13ca3d52faa60d2d5a160654b~jd93Qio411971119711epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739365675;
	bh=kgwjPTJeDp+dDmaPIcMkbT3oy9GS8B0AWN3rKWEtzaU=;
	h=From:To:Cc:Subject:Date:References:From;
	b=SoMnpL3+6bg3oMwbL4zKoUbMAou3/ZhXpjcDDgf7J0ogv5MQbTUDSEtgizznw0ego
	 qWMOCQdE9XYTn04ah9/wY6gtIqz8DChCmKQDQPMcMidN66yPnM0w8HXm7xChAcqftq
	 70pCzpdaTflKcZVefqR2EENLpekHDrUxydQAuTt8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250212130755epcas5p21568f3e10b8b94889e5a0ddc5bb5a821~jd92tgxN11394313943epcas5p2S;
	Wed, 12 Feb 2025 13:07:55 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4YtJWs3nLwz4x9Pw; Wed, 12 Feb
	2025 13:07:53 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3C.04.19710.92D9CA76; Wed, 12 Feb 2025 22:07:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250212104507epcas5p18722b26bd022151979418508eae99065~jcBLs-P-T1039910399epcas5p1M;
	Wed, 12 Feb 2025 10:45:07 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250212104507epsmtrp1dc77ed69ffc94892e6b9022d7f864de7~jcBLsLQUl0677306773epsmtrp1s;
	Wed, 12 Feb 2025 10:45:07 +0000 (GMT)
X-AuditID: b6c32a44-363dc70000004cfe-53-67ac9d296b0e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	19.36.18949.3BB7CA76; Wed, 12 Feb 2025 19:45:07 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250212104505epsmtip2112d1f4ce9e93a19b821fd17dd30191f~jcBJjOjo41728317283epsmtip2X;
	Wed, 12 Feb 2025 10:45:05 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: david@fromorbit.com, mcgrof@kernel.org, jack@suse.cz, hch@lst.de
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	anuj20.g@samsung.com, axboe@kernel.dk, clm@meta.com, willy@infradead.org,
	gost.dev@samsung.com, vishak.g@samsung.com, amir73il@gmail.com,
	brauner@kernel.org, Kundan Kumar <kundan.kumar@samsung.com>
Subject: [RFC 0/3] Parallelizing filesystem writeback
Date: Wed, 12 Feb 2025 16:06:31 +0530
Message-Id: <20250212103634.448437-1-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAJsWRmVeSWpSXmKPExsWy7bCmuq7m3DXpBqenSlpcWLea0aJpwl9m
	i9V3+9ksXh/+xGix5ZK9xZZj9xgtbh7YyWSxcvVRJovZ05uZLLZ++cpqsWfvSRaLXX92sFvc
	mPCU0eL8rDnsFr9/zGFz4Pc4tUjCY+esu+wem1doeVw+W+qxaVUnm8fumw1sHucuVnj0bVnF
	6HFmwRF2j8+b5AK4orJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22V
	XHwCdN0yc4BeUFIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBToFSfmFpfmpevl
	pZZYGRoYGJkCFSZkZ2zb+JO14IJYRUfLDfYGxq+CXYycHBICJhIzru9g7WLk4hAS2M0osW7x
	JzYI5xOjxOf7D1ggnG+MEt0fjjLDtCxdcoQdIrGXUeLT8jaols+MEu9/dQA5HBxsAroSP5pC
	QRpEBFwkDi3vA9vBLNDJJPF+6w42kISwgKnEo4XLmUBsFgFViV2fdjOC2LwCdhJvWo+yQGyT
	l5h56Ts7RFxQ4uTMJ2BxZqB489bZzCBDJQSWckhcubefDaLBRWLS44dQzcISr45vYYewpSRe
	9rdB2dkShxo3MEHYJRI7jzRAxe0lWk/1M4M8wCygKbF+lz5EWFZi6ql1TBB7+SR6fz+BauWV
	2DEPxlaTmPNuKtRaGYmFl2ZAxT0kpj+5zApiCwnEStzfN4d5AqP8LCTvzELyziyEzQsYmVcx
	SqYWFOempyabFhjmpZbDYzY5P3cTIzgpa7nsYLwx/5/eIUYmDsZDjBIczEoivBLT1qQL8aYk
	VlalFuXHF5XmpBYfYjQFhvFEZinR5HxgXsgriTc0sTQwMTMzM7E0NjNUEudt3tmSLiSQnliS
	mp2aWpBaBNPHxMEp1cDk7fL+wMW1M6XvqtVt+pv2aL7k0xm/9X2+nw9ZNl3Eha38+BXBwvhb
	lUePzX2xXzShRuzchKTIW7fz7KS8mh6bi2580z/TgcWDo39PceLUzokvPtxiKT0ctpmXZydn
	5uJJeVcilbUZvuZq9b0JeLFiC8uXzuajFpXa76QWzDggIp3T6J7u1yKwMFDR+jCnvprX0T3R
	XUs5Z73Ve37wn5hC1wIRjyNWc2uuzdONLdxwUkf27C4OY+87kkmTeBU4xAJNtEOtnDa/mnDM
	lZXX9oOw0KrbqmVZD+pMnrHp/HwdoCUTpT31itzSiWd+SX1OLj94ynrZXJV9f7NK07csfxJ9
	jFHiBmuhm2HQfLES7j4lluKMREMt5qLiRADyNp2WUwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsWy7bCSvO7m6jXpBvN3KltcWLea0aJpwl9m
	i9V3+9ksXh/+xGix5ZK9xZZj9xgtbh7YyWSxcvVRJovZ05uZLLZ++cpqsWfvSRaLXX92sFvc
	mPCU0eL8rDnsFr9/zGFz4Pc4tUjCY+esu+wem1doeVw+W+qxaVUnm8fumw1sHucuVnj0bVnF
	6HFmwRF2j8+b5AK4orhsUlJzMstSi/TtErgytm38yVpwQayio+UGewPjV8EuRk4OCQETiaVL
	jrB3MXJxCAnsZpT4vO4qE0RCRmL33Z2sELawxMp/z6GKPjJKrPi4CMjh4GAT0JX40RQKUiMi
	4CVxcdMHsBpmgelMElO2nGcHSQgLmEo8WrgcbCiLgKrErk+7GUFsXgE7iTetR1kgFshLzLz0
	nR0iLihxcuYTsDgzULx562zmCYx8s5CkZiFJLWBkWsUomVpQnJueW2xYYJSXWq5XnJhbXJqX
	rpecn7uJERwfWlo7GPes+qB3iJGJg/EQowQHs5IIr8nCFelCvCmJlVWpRfnxRaU5qcWHGKU5
	WJTEeb+97k0REkhPLEnNTk0tSC2CyTJxcEo1MKlxz231Eju2gVuPQ6Ln+0HeB5//Xi515J7k
	e/56DN/znRmSifeKfL03lj2S3fn5gFP+jx8OTwU1tdiv/Km1Lp8vOG1hTS3XgjqR9nv/JdJs
	1Rc+PmxfnxuTXuU6+aDZRs61px0OP9XZprNyaZpOp+DD12cyslcduLJgql1c5+lVsttZquJU
	IxMcilt7NPStcn8yRhqK1d/a63V8ntqxw91rj0mLGl7YtP/dIQ/nJ687tRYyPDCxdPIQE4w6
	Iv0555ekt+QTvawTgassb6usO6sl+drdyZUtIO7jspsqEzZenhCl8Vi2lN1qj/fEPxrnnKYH
	RN67mCeRmZOwrMxtUeNJ6aC/S3YFB6xSW3XXX4mlOCPRUIu5qDgRAHsiSkH+AgAA
X-CMS-MailID: 20250212104507epcas5p18722b26bd022151979418508eae99065
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250212104507epcas5p18722b26bd022151979418508eae99065
References: <CGME20250212104507epcas5p18722b26bd022151979418508eae99065@epcas5p1.samsung.com>

This RFC is an attempt to share a POC for our LSFMM'25[0] proposal.
We initially prepared it based on the percpu writeback context design.
But based on feedback received initially, we moved towards a more
FS-geometry aware design. The patches are still clumsy, and there is
softlockup issue while running fstests as well(mentioned below).
Yet, we would like to gather feedback which will help in ironing
out the infra.

Kernel tree:
https://github.com/SamsungDS/linux/tree/priv/pw/rfc

Design
==========================
- A new "wb_ctx" structure is introduced that represents a writeback
  context/thread.
  A new "wb_ctx_list" field is introduced in bdi_writeback that describes
  a wb_ctx array, which gets initialized during wb_init.

- Writeback handling is modified to use "wb_ctx_list[0]" writeback
  context, so it continues to remain single threaded.

- In xfs, during AG initialization, we try to assign a different writeback
  context to each AG from the wb_ctx_list.

- During writeback, a "get_wb_ctx" handler is introduced in
  super_operations to fetch the writeback context from the inode, which
  gets used for writeback handling. Currently this handler is implemented
  only by xfs, so writeback handling is parallelized (per AG) for xfs
  only. It can be easily extended to other filesystems.

Discussion
==========================
- Design for API that would be used for deciding the number of writeback
  contexts by FS (suggested by Dave).

TBDs
==========================
- Need to explore cgroup related writeback handling.

- Add a list_lock field in struct wb_ctx for protecting pctx_b_* lists.
  Currently there is a "bdi_writeback->list_lock" for protecting per
  writeback context list.

- Ability to create writeback contexts dynamically. Currently, NR_WB_CTX
  number of writeback contexts are present in bdi_writeback and get
  initialized during wb_init.

Testing
==========================
- Encountered a softlockup issue while running fstests (test generic/051).
  Investigating the same.

[0] https://lore.kernel.org/all/20250129102627.161448-1-kundan.kumar@samsung.com/


Kundan Kumar (3):
  writeback: add parallel writeback infrastructure
  fs: modify writeback infra to work with wb_ctx
  xfs: use the parallel writeback infra per AG

 fs/fs-writeback.c                | 507 ++++++++++++++++++++-----------
 fs/xfs/libxfs/xfs_ag.c           |  16 +
 fs/xfs/libxfs/xfs_ag.h           |   1 +
 fs/xfs/xfs_super.c               |  20 ++
 include/linux/backing-dev-defs.h |  67 +++-
 include/linux/backing-dev.h      |  34 ++-
 include/linux/fs.h               |   1 +
 mm/backing-dev.c                 |  68 +++--
 mm/page-writeback.c              |  82 ++---
 9 files changed, 551 insertions(+), 245 deletions(-)


base-commit: 57d357a7663c4025c68ae07974b679d84e2d5d1a
-- 
2.25.1


