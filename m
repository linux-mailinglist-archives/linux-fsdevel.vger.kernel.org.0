Return-Path: <linux-fsdevel+bounces-4972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF6C806C34
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 11:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06231F210CF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8A82DF68
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cd1wParl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0249DD50
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 02:11:53 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231206101152epoutp047e897eaa51bb8506d318553132f942ac~eNmP_7LSa1402414024epoutp04Y
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 10:11:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231206101152epoutp047e897eaa51bb8506d318553132f942ac~eNmP_7LSa1402414024epoutp04Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701857512;
	bh=AOfFIjYI2wLqNYIL53RS+cLCGUBaMkDlBy8uIvV9EEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cd1wParlIHUxsUbfkdHucKN5S4B108SkOdn2UE2QFoT5CT9a09J5xJIjTgbgMYLNr
	 GB9uAp0SLhK6JPqS7QZJLg/pb3xUUY2nBJoUOm/6KxXmJT5Sa3lfEHj4R+WXWGWJoI
	 0X04DP+lwYEmhwwR1JG2g98PfxOo6mJC0L7NNfjE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20231206101151epcas5p13faeb3c54d5e6e95672f50b1041fd65d~eNmPQdroJ1468514685epcas5p1B;
	Wed,  6 Dec 2023 10:11:51 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4SlY915zhlz4x9Pv; Wed,  6 Dec
	2023 10:11:49 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	80.D6.10009.5E840756; Wed,  6 Dec 2023 19:11:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20231206101149epcas5p429e2a328af02819c71fa48ad01308a89~eNmNLRqTM2528425284epcas5p40;
	Wed,  6 Dec 2023 10:11:49 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231206101149epsmtrp14047bbe569c539379849c452b0a67208~eNmNKMzPF1112611126epsmtrp1H;
	Wed,  6 Dec 2023 10:11:49 +0000 (GMT)
X-AuditID: b6c32a4a-261fd70000002719-67-657048e52afe
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	89.52.08817.5E840756; Wed,  6 Dec 2023 19:11:49 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231206101141epsmtip2611ca7ae3531b6917df9b8dbc3213075~eNmF_pEh-1181011810epsmtip2G;
	Wed,  6 Dec 2023 10:11:41 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
	<mpatocka@redhat.com>, dm-devel@lists.linux.dev, Keith Busch
	<kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	nitheshshetty@gmail.com, anuj1072538@gmail.com, gost.dev@samsung.com,
	mcgrof@kernel.org, Nitesh Shetty <nj.shetty@samsung.com>, Hannes Reinecke
	<hare@suse.de>, Anuj Gupta <anuj20.g@samsung.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v18 06/12] fs, block: copy_file_range for def_blk_ops for
 direct block device
Date: Wed,  6 Dec 2023 15:32:38 +0530
Message-Id: <20231206100253.13100-7-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231206100253.13100-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf1CTdRzu+76v2zCWbwOPr+sHMEODDtgWG18UqDu13iuvSKs7oZrvsbdB
	G9vaD81+EKQCWvw+L5jyI0AtJAgGArIJQoBQAsGhAuEBskAoSIS4JKWNzfK/5/P9PM899zzf
	+3BwXhabz4lXGxidmlYJWOuJ823+WwNtlJYR/n3GH1V1d+Do9tIKgb7Iuoejc6OZLDTbtgDQ
	ZEsqQMUlBQQaamnEkKUkB0PfnWvHUE7rVYBsgyYMWYefQ9+klBHIYu0i0MCFUyxUdMbGRl9e
	a2Chs533MXQ9ywZQdtoghhomkwE6v1KEo8rZeQJdHn4C9d7rXPcin2o0jbKp3hvVBDVwxUjV
	lB9jUeayz6lpcz6gmoaSWFRpRu46Kv3wHIu6bRsmqPmLgywqo7YcUOafPqHu1DxN1Uz+gUVt
	iFaGxzG0nNH5MOpYjTxerYgQvLpXtkMmkQpFgaIwFCrwUdMJTIRg5+6owJfiVfZKBD4HaJXR
	/hRF6/WC4MhwncZoYHziNHpDhIDRylXaEG2Qnk7QG9WKIDVj2CYSCsUSO3G/Mu5E9i+YdmbD
	RxOtA3gSmHc/Dtw4kAyBtSbbuuNgPYdHNgGY8lsT4RwWAFy4aHFt/gKw8u4S+4GkLs/Kdi6s
	ACb3VGDO4Q6A1Uea7QOHwyL9YV+u0SHwJCtw2FgtcnBwshCH5olOzLHwIGVwdXUCd2CC9IO1
	q8uEA3NJBK/MNRNON2+Y37+85uxGhsHcqRLcyXkcduVPrnFwO+dw3UncYQDJejdY3lXlEu+E
	fc0dmBN7wJnOWlcEPryVmeLCsbA/v8fFMcCblksu/AI82p2JO8Lg9jBVF4KdXo/B9JXJtYyQ
	5MK0FJ6T7Qtv5Dh6dGAvOJ5X5sIUnM8vcPXzFYDT31eys4C36aEIpocimP53KwZ4OdjEaPUJ
	CkYv0YrVzMH/fjZWk1AD1k4j4JUGMD72Z1ArwDigFUAOLvDkqno1DI8rpw99zOg0Mp1Rxehb
	gcTecTbO3xirsd+W2iAThYQJQ6RSaUjY81KRwIs7e7RAziMVtIFRMoyW0T3QYRw3fhJWtN1/
	KS3GN6eTM0ZbEy1vmJ6t2pLD8p3K2CTcU6kkxJHbgtzfrS+b4DZ5FtIJKlm0R30/VTJWGtb2
	T9ojQk/3LYtVZtmJ7mVr3Y91qQt9978NZe6+6f7UgbmDqUXk67vxr6//sPlUu7/8mmKEV2Ns
	U1amh/56cl7djgqpIaVkxA/xn9nlfnof8U6A+GVpxYpO3Le93k/U5XVV5F382mdwbLjIMrK8
	lLeYnOitvTSbXNo9xZh10++VLz5ZHzmzeqwjr+X9/s3my6P7RwvfCh435CXSn34IDv188+zv
	og/woF1bib2SWzGn3x40Rdn24JkNw6mPKsKj96lKeqQbxdNHdsQICH0cLQrAdXr6X6DehwWj
	BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsWy7bCSvO5Tj4JUg92XuC3WnzrGbPHx628W
	i6YJf5ktVt/tZ7N4ffgTo8WTA+2MFgsWzWWxuHlgJ5PFnkWTmCxWrj7KZDHp0DVGi6dXZzFZ
	7L2lbbGwbQmLxZ69J1ksLu+aw2Yxf9lTdovu6zvYLJYf/8dkcWPCU0aLiR1XmSx2PGlktNj2
	ez6zxbrX71ksTtyStjj/9zirg5THzll32T3O39vI4nH5bKnHplWdbB6bl9R7vNg8k9Fj980G
	No/FfZNZPXqb37F5fHx6i8Xj/b6rbB59W1Yxemw+Xe3xeZOcx6Ynb5kC+KO4bFJSczLLUov0
	7RK4MqZOvMhU8Iq/4tGhy8wNjO95uhg5OSQETCS2ztjL3sXIxSEksJtRon3CIjaIhLhE87Uf
	7BC2sMTKf8+hij4ySvzc2cHYxcjBwSagKXFhcilIXERgB7PEz7XNTCANzAJrmCW2zOUFsYUF
	YiVO9r1mBbFZBFQltvz/zgJi8wpYSJx9t58FYoG8xMxL38GWcQpYSkx+vogZxBYCqtnXOB2q
	XlDi5MwnLBDz5SWat85mnsAoMAtJahaS1AJGplWMkqkFxbnpucWGBUZ5qeV6xYm5xaV56XrJ
	+bmbGMHxrqW1g3HPqg96hxiZOBgPMUpwMCuJ8Oacz08V4k1JrKxKLcqPLyrNSS0+xCjNwaIk
	zvvtdW+KkEB6YklqdmpqQWoRTJaJg1OqgclTvuZhtd+36MK4Yx08wR//CWft7HOoLxMyuXZ0
	n63VJG2hzbLm6hPiVIsSKmx/cM3omPOFiSE29HqO3/KIecJskSu7X1jyCTQ65vT1nXhxeUZZ
	6OaDO9TcYlvyy5Ztaz6YtvtbkMuq/T3Mtt9e2DfYLtaUNFu6RXHP7oDUORscJ8xev4XLOfzI
	Kcdw97z4hrxvD7O3CIXMr+lM9Hfclaj05I5Qy7YPAkV2v1YyLn17JVo6tiLndspbtitdjg8e
	9LzTsy26GbN3q9Klme+t405e9VrpNut4FlOE9iuxmWJpjVsZXoacWKEifLu83WPR72TL0PB5
	y5PzJ53837N63b/Fb660NpuxzDp8tc9cV4mlOCPRUIu5qDgRAAqih8RmAwAA
X-CMS-MailID: 20231206101149epcas5p429e2a328af02819c71fa48ad01308a89
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231206101149epcas5p429e2a328af02819c71fa48ad01308a89
References: <20231206100253.13100-1-joshi.k@samsung.com>
	<CGME20231206101149epcas5p429e2a328af02819c71fa48ad01308a89@epcas5p4.samsung.com>

From: Nitesh Shetty <nj.shetty@samsung.com>

For direct block device opened with O_DIRECT, use copy_file_range to
issue device copy offload, or use generic_copy_file_range in case
device copy offload capability is absent or the device files are not open
with O_DIRECT.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 block/fops.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index 0bdad1e8d514..08b652788e55 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -747,6 +747,30 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return ret;
 }
 
+static ssize_t blkdev_copy_file_range(struct file *file_in, loff_t pos_in,
+				      struct file *file_out, loff_t pos_out,
+				      size_t len, unsigned int flags)
+{
+	struct block_device *in_bdev = I_BDEV(bdev_file_inode(file_in));
+	struct block_device *out_bdev = I_BDEV(bdev_file_inode(file_out));
+	ssize_t copied = 0;
+
+	if ((in_bdev == out_bdev) && bdev_max_copy_sectors(in_bdev) &&
+	    (file_in->f_iocb_flags & IOCB_DIRECT) &&
+	    (file_out->f_iocb_flags & IOCB_DIRECT)) {
+		copied = blkdev_copy_offload(in_bdev, pos_in, pos_out, len,
+					     NULL, NULL, GFP_KERNEL);
+		if (copied < 0)
+			copied = 0;
+	} else {
+		copied = generic_copy_file_range(file_in, pos_in + copied,
+						 file_out, pos_out + copied,
+						 len - copied, flags);
+	}
+
+	return copied;
+}
+
 #define	BLKDEV_FALLOC_FL_SUPPORTED					\
 		(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |		\
 		 FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE)
@@ -851,6 +875,7 @@ const struct file_operations def_blk_fops = {
 	.splice_read	= filemap_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= blkdev_fallocate,
+	.copy_file_range = blkdev_copy_file_range,
 };
 
 static __init int blkdev_init(void)
-- 
2.35.1.500.gb896f729e2


