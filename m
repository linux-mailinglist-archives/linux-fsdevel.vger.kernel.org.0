Return-Path: <linux-fsdevel+bounces-748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F437CF82F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 14:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76A2BB216D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 12:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19301DFFD;
	Thu, 19 Oct 2023 12:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cOITCODN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19381DFF4
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 12:05:25 +0000 (UTC)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE7C195
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 05:04:56 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20231019120425epoutp01b7a9f27bf7ac94ecb412a4a3e773e112~PgK0uTmSH2660526605epoutp01u
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 12:04:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20231019120425epoutp01b7a9f27bf7ac94ecb412a4a3e773e112~PgK0uTmSH2660526605epoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697717065;
	bh=W6Cvqjs8GJhwgBfxrn3JFatd+tYHBlqUZSV4Q7H1XFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cOITCODNXXuYwgLQ6hyqZYYLH3GJY/7fPZzF/sdr6RHAL+atAmR8035wbBK7PTHfO
	 EXsUuQMhgjAF3ITxKiEVZVxl0OgT/b5Yh/Y06YT90ChXO3+AMzQUIb1Owrmbh/4Fgw
	 G7zSuNMG68blBewu27/NB+JxxA5XIdOp93yC8R1A=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20231019120425epcas5p39a9a0961718caa950f5d37351b93c490~PgK0GSnQG1178011780epcas5p3O;
	Thu, 19 Oct 2023 12:04:25 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4SB5x3443yz4x9Pp; Thu, 19 Oct
	2023 12:04:23 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F7.DB.19369.74B11356; Thu, 19 Oct 2023 21:04:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20231019110954epcas5p132f1188382b57c5e6cd071e52100b60f~PfbOf8T-e2531825318epcas5p1C;
	Thu, 19 Oct 2023 11:09:54 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231019110954epsmtrp2dead90b55f80f656007a5524af4403c2~PfbOfE_Un1629616296epsmtrp2u;
	Thu, 19 Oct 2023 11:09:54 +0000 (GMT)
X-AuditID: b6c32a50-c99ff70000004ba9-22-65311b4779c4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	08.88.08817.28E01356; Thu, 19 Oct 2023 20:09:54 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231019110951epsmtip1cdd2d4cc218dfbcf4982a24ae7888de3~PfbLbvW240548505485epsmtip1H;
	Thu, 19 Oct 2023 11:09:51 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	dm-devel@lists.linux.dev, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
	Brauner <brauner@kernel.org>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	nitheshshetty@gmail.com, anuj1072538@gmail.com, gost.dev@samsung.com,
	mcgrof@kernel.org, Nitesh Shetty <nj.shetty@samsung.com>, Hannes Reinecke
	<hare@suse.de>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v17 10/12] dm: Enable copy offload for dm-linear target
Date: Thu, 19 Oct 2023 16:31:38 +0530
Message-Id: <20231019110147.31672-11-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20231019110147.31672-1-nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTZxTOe+/tpTA7LkXDuzI2UkIIMqDdKHtBkE0N3o39wGjcQia1gbtC
	gLZry1CYAQRkIF9zGKHyUTrCVwk4vkYZzK6oSBkjzg8GypymZEwQFSawEexais5/z3lynnOe
	c04OG+dWOvHYyTI1o5RJUvmkC9E37O8XuN9TyAiqSr1Qp/kKjp48XSeQfqacRPPDSwBZjIUA
	aXW1BJoyGjA0qDuDoVb9ZQydMd0CaPamBkND0wGo4VQjgQaHRgl0faCGRPVNs07o9GQ/iZpH
	nmHot4pZgPotuQD1rdfjqGP+EYGuTnuiiY0R1nuQNmhmnOiJ378j6Ovj6XRXWxFJdzdm03Pd
	1YD+YSqHpL8t+4ZFl+YtkvST2WmCfvTjTZIu62kDdPdYFr3c9QbdZXmIxbrGpUQkMZJERunN
	yBLkickyaSQ/5qB4r1gUKhAGCsPQu3xvmSSNieTv+yg2MDo51bYIvvcXktR0GxUrUan4wbsj
	lPJ0NeOdJFepI/mMIjFVEaIIUknSVOkyaZCMUYcLBYK3RbbEoylJxjkjpuhgHau6XQlygJEo
	Bs5sSIXAqSIdXgxc2FxqEMCKxzOkI1gCcPmXSSdHsAJg842NFxKL9Y8tyRCAs6W3tyQFGLxb
	+DOrGLDZJBUAx6xsO7+dKsDhxTsLwB7g1D8YzGu5Cuyl3Kn9MH+mhGXHBOUL7zdaN3kOtQuO
	fV+L2QtBKhiW33Wz0842+sJpu1l7ihscrbZsOsKpN2Fe7/lNR5DSO8P7q4PAYXUfPLVkZTmw
	O3ww0uPkwDy4vDhEOnAGbK1sIR3ifAA1k5otcRQsMJfjdhM45Q87B4IdtBc8a+7AHI1fhaXr
	FszBc2B/3XPsA9s7tVv1X4O3VnO3MA2rSoc3MZcqA/DG0NEK4K15aR7NS/No/u+sBXgb4DEK
	VZqUSRAphIEyJuPFnRPkaV1g8z12xvYD/YWNIBPA2MAEIBvnb+f40gKGy0mUHM9klHKxMj2V
	UZmAyLbwr3HejgS57b9karEwJEwQEhoaGhL2TqiQ78GZL6hN5FJSiZpJYRgFo3yuw9jOvBzs
	EHciO0P/qSE7qy7G75iXci36r5gDqmHyUkmtVdvk+2vhiHvv5x2cPZJtH8rCORlGLjvwpIvJ
	z2fxMTfF5P9Wy0ZmvO4OIaZETbvChZl8M+ve3uiEj+PjelbMTWZxU6f24EbvqvuVBUNVciN7
	1NX4yQms9eHc8eoaGefSWT1Hu5r1tLnKZ/ya8eI5a+SXnz3R/3To/J+GcsOBQt7lgC6xV11W
	t8+Jf3cfznnfkxvh6tI3phtjxRj8pP7THq7SyoYMt3H52gcP/s5vcdu2wlmr6Y4Slew5Eufc
	fu31IknEEdXAyCtZ55KfxS98pWPMuYdPRjVme3iT9+oLfdsbanZE9LXwCVWSRLgTV6ok/wFO
	aP8OpwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02RfUzMcRzH9/39fvfr123Hr8N8i3VzZiiuwvSdh8rD5rsR1kyeJqe+q6au
	3PXkOUJzyZ0Uitx1JVwoVxJOOycP5w7zEMryeEdzKnkeq7hi89/78369Pw/bh6PFNsaPS1Sk
	EaVCniRlhUz9Nan/xB2DQkjwseOTUfXtGzTq/vqLQVVtGha5r30CyGnJBUhvKGVQi+UihcyG
	AgqdqrpOoQLrY4BczSUUutIaiMp2VzDIfMXGoIeXjrJIV+nyQnlPGlh04mYvhZ5qXQA1OLcD
	VP9LR6Oz7i4G3Wodge713BREQHyxpM0L33t+jsEP76Rjk3EPi2srtuH22mKAL7dks7h83wEB
	zs/pZHG3q5XBXY3NLN5XZwS41r4Jfzb5Y5Ozg1o8eIVwRhxJSswgyqCwNcIES7uFSj0ryDr8
	rBBkAwujBt4c5KdAZ99LWg2EnJi/DGDjrg/0APCFlT1Nf/UQeKr3nddAKIeCTXoHqwYcx/KB
	0N7HefyhvIaGnT2HKE9B87k0tL93U57uIfw8uLNtr8CjGX4MfF3RBzxaxE+H9gullGcQ5IOg
	5oWPx/b+Y9fkGfoXi/lp8KX+jddA3Afaip39V9O8BOacP0JrAV/yHyr5D+kBZQS+JFWVHJ+s
	CkmdpCCZMpU8WZWuiJfFpiSbQP+3AwIagNn4UWYFFAesAHK0dKhoDA4mYlGcfMNGokyJUaYn
	EZUVjOAY6XDRN3d+nJiPl6eRdYSkEuU/SnHeftlUZLtk+s93b0ur1iR+jsoaVV5Aolt5q8qY
	FT7BbLz9KO2OYsPJtK2hwqIM0e4ZY4OQTSeRTiq7/wrPMo97Ejl7ap1T+jUsAZ0ZPWyR/uqe
	WTsKHQn+HcvIhY5nhnUv3JqluTXRgvrMmJj5Mx8Ri7ZoyYL98dmxd+sekHRhUsaXExmXJr6d
	6z3tWFyjpDtvTrgsczDwWXjGb1RMuV17TlcZJLE54I+Pc8aGH+ydLRObPqkXzq+eF+WInLky
	5EdgxOn1VdpITWiUw652vmp57bvZFNUi1o3ftXzkWlRzpHPLMk1ORH5h86qDYZzcUF2YlxLb
	uzr/fe74va7gD12hxU3fsVTKqBLkIQG0UiX/DageFnZcAwAA
X-CMS-MailID: 20231019110954epcas5p132f1188382b57c5e6cd071e52100b60f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231019110954epcas5p132f1188382b57c5e6cd071e52100b60f
References: <20231019110147.31672-1-nj.shetty@samsung.com>
	<CGME20231019110954epcas5p132f1188382b57c5e6cd071e52100b60f@epcas5p1.samsung.com>

Setting copy_offload_supported flag to enable offload.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 drivers/md/dm-linear.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index f4448d520ee9..1d1ee30bbefb 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -62,6 +62,7 @@ static int linear_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	ti->num_discard_bios = 1;
 	ti->num_secure_erase_bios = 1;
 	ti->num_write_zeroes_bios = 1;
+	ti->copy_offload_supported = 1;
 	ti->private = lc;
 	return 0;
 
-- 
2.35.1.500.gb896f729e2


