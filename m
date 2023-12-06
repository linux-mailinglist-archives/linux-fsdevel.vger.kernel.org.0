Return-Path: <linux-fsdevel+bounces-4976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DE8806C3B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 11:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B7AE281A9E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14892E410
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="F90pFI3S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6748ED6F
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 02:12:49 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231206101247epoutp02f94ef22b418f4c2579a5e2b5eeaa1f4f~eNnDzuxZ-2310223102epoutp02r
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 10:12:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231206101247epoutp02f94ef22b418f4c2579a5e2b5eeaa1f4f~eNnDzuxZ-2310223102epoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701857567;
	bh=til+KvRoG+1Iq7dmMib83hgZfmKc66+HX7+qqGC9x84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F90pFI3S3E8AN0HKk4FzmhMPO2pnz6KMJAfes8vFUt5UUpjnvfEw8vqGJ0OjyfVGj
	 Z6dTzZJ3Uijz3LJIkpG94H+vlLwojwa+mqCPclRMn+p+ETok1c7si8akUnYiqV47Ve
	 wnX/jVWQdaZmSz5EWcxv2KJjTL1qodnf3y5Yu308=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20231206101246epcas5p34ee90169766a41f9474ed71bea400f35~eNnC6IJGp0789207892epcas5p3S;
	Wed,  6 Dec 2023 10:12:46 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4SlYB50Nk1z4x9Q5; Wed,  6 Dec
	2023 10:12:45 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9A.22.09672.C1940756; Wed,  6 Dec 2023 19:12:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20231206101244epcas5p38c9d5f1cb01158321f59dbfb4f957470~eNnAdnHs90698906989epcas5p3Z;
	Wed,  6 Dec 2023 10:12:44 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231206101244epsmtrp1c90fe9cdb177c4af9e602b20f796b0ae~eNnAcgHiz1112611126epsmtrp1x;
	Wed,  6 Dec 2023 10:12:44 +0000 (GMT)
X-AuditID: b6c32a4b-60bfd700000025c8-98-6570491c2584
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	46.62.08817.C1940756; Wed,  6 Dec 2023 19:12:44 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231206101240epsmtip26a0b39642efe1b16d765e62dd823455a~eNm8nTf371205412054epsmtip2Q;
	Wed,  6 Dec 2023 10:12:39 +0000 (GMT)
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
	<hare@suse.de>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v18 10/12] dm: Enable copy offload for dm-linear target
Date: Wed,  6 Dec 2023 15:32:42 +0530
Message-Id: <20231206100253.13100-11-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231206100253.13100-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xTZxjOd87pBRb0rDL5wAWwcUuEgC203YcBNzc3jmOLZGKWjGzQweHa
	m70okywyuQyZgFDRgRKkK3KRyCiIlNugXrgsCuGi0gWmox1lDBDUqWGOtbRz/nve932ePN/z
	fnnZOKeA5cNOlalppUws4TLdibar2wOCXt+roHlzReGoaegGjpYfrxLo4lQxE81fXQHI0vst
	QOd1lQSa7DViqEtXiqH6i9cxVGq6DZB1ogJD3eZAVJ2nJ1BX9yCBxjrOMVHVBSsLfXennYlq
	+//B0N2TVoBK8icw1G75BqC21SocXZpfItCAeQsaft7PeMebMlZMsajh6WaCGrupoQwNx5lU
	i/4oZWspB1TnZBaT+qFIy6AKsxeZ1LLVTFBLPRNMqqi1AVAtP2dSDw2+lMGygEVv/Cw9PIUW
	J9JKf1qWIE9MlSVHcKP2x70XJxTx+EH8MPQW118mltIR3D0fRQd9kCqxb4Prf0gs0dhb0WKV
	irtjV7hSrlHT/ilylTqCSysSJQqBIlgllqo0suRgGa3eyefxQoR2Ynx6yuT0FFBMMTJqTvVg
	WcBGFAA3NiQF0DxyASsA7mwO2Qlg56M1wlmsAFhoaXYVfwE4O5b3QlJ/pRw4B90A1twyulgP
	ARybsbEKAJvNJLfDEa3GIfAkG3FobOY7ODj5DIPZdQPAMdhERsKnl/9mOTBBvgHrsrIwB/Yg
	w2DfUKvLzQ+Wjz5Z57jZ+9pZHe7kvAoHyy3rHNzOyb58FncYQLLJDV6qa2U4xXugrbWD5cSb
	4B/9rS7sA+eK81w4AY6W38KcWA1nuvpc+G2YO1SMO8Lg9jBNHTucXhtg4aoFc7Qh6QHz8zhO
	9lY4XWp1uXrB+9/rXZiCLabf15/JIU8A2Fuz/yTwq3gpQcVLCSr+NzsP8AbgTStU0mRaJVSE
	yujDLz42QS41gPWjCIhqB7/dexBsAhgbmABk41xPD8mwnOZ4JIq/OkIr5XFKjYRWmYDQvuIS
	3Oe1BLn9qmTqOL4gjCcQiUSCsFARn+vlMZ9bmcghk8VqOp2mFbTyPx3GdvPJwnJqZYvWB59X
	nQ1IKwVx0qVTbtWfMFK1aeEZezMXr23OHh0v2z0TklFyQphkno4/x4/6YtIQ+UTgk13tdyy+
	egP7vlZz+GnswrOZKZk0Q3DTa3jtXuOHvxDalbaD0bFDQv+dP9nWcg6afA9tfk5ONA0Mvs8f
	PiYJ7Pi0+871kvF9oddsoq7mNK+g3AM13TfMSSMHdO+Oz3Se1tO/9jze90i98eP5K8d1vrpd
	R3lpXzOq9YE9yXM12iGTNDKpvzL/rmCLIfzNnIzMM2XbPLsKte7TsVtnf+xUe0+E/Nm3wHpl
	MabodmZj/XIMmK/TrxnntKZtxiO5Ft4ZU8puXlnMeO2XpCeXUKWI+QG4UiX+F+4VIRudBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsWy7bCSvK6MZ0Gqwbu/fBbrTx1jtvj49TeL
	xeq7/WwWrw9/YrR4cqCd0WLBorksFjcP7GSy2LNoEpPFytVHmSwmHbrGaPH06iwmi723tC0W
	ti1hsdiz9ySLxeVdc9gs5i97ym7RfX0Hm8Xy4/+YLG5MeMpoMbHjKpPFjieNjBbbfs9ntlj3
	+j2LxYlb0hbn/x5ndZD02DnrLrvH+XsbWTwuny312LSqk81j85J6jxebZzJ67L7ZwOaxuG8y
	q0dv8zs2j49Pb7F4vN93lc2jb8sqRo/Np6s9Pm+S89j05C1TAH8Ul01Kak5mWWqRvl0CV8bN
	e3cZC+6yViydso+pgfEFSxcjJ4eEgInEyu0zGbsYuTiEBHYzSpy9fZwJIiEu0XztBzuELSyx
	8t9zdoiij4wS0/uuAxVxcLAJaEpcmFwKEhcR2MEs8XNtMxOIwyzQzixx+tVrsEnCAu4SP7b+
	AZvEIqAqsaKhASzOK2ApcfDUFqgz5CVmXvoOVsMJFJ/8fBEziC0kYCGxr3E6C0S9oMTJmU/A
	bGag+uats5knMArMQpKahSS1gJFpFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcJxr
	ae1g3LPqg94hRiYOxkOMEhzMSiK8OefzU4V4UxIrq1KL8uOLSnNSiw8xSnOwKInzfnvdmyIk
	kJ5YkpqdmlqQWgSTZeLglGpgkrzp4N/ssnTl1ZksvfcP5OkeODfPYqvm6ux7sYvzlkw4Lba6
	vMXc85oy7/PCiBNvl1wtdjy2/MsvTg0Rqw8XyjL8dsquUtZVWqSUPfu72l6uNfFVed/vG896
	veWbWEjCIqXebWkt9gEmyy+fndMh6n3nwYn96lWdqse0vFmLJ6pscZ7U9CSLiW2ujonw7mkH
	pudufF63+2XbVLeyUP+PM8Lfp24Tc9y5kHl9nL8R29wQ/WmXLq+T7v4vwzY7PO1Qd+Gt3tWr
	lDbYBz3iWnkkfXLty0OCNdxzpr0sySqUn881/eDPj4UJ5Ur69r7XdZVYozM+/Kq3UvugobRs
	/fJf+eENNh8XfI3RimXh61ozRYmlOCPRUIu5qDgRABxSzHRiAwAA
X-CMS-MailID: 20231206101244epcas5p38c9d5f1cb01158321f59dbfb4f957470
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231206101244epcas5p38c9d5f1cb01158321f59dbfb4f957470
References: <20231206100253.13100-1-joshi.k@samsung.com>
	<CGME20231206101244epcas5p38c9d5f1cb01158321f59dbfb4f957470@epcas5p3.samsung.com>

From: Nitesh Shetty <nj.shetty@samsung.com>

Setting copy_offload_supported flag to enable offload.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 drivers/md/dm-linear.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 2d3e186ca87e..cfec2fac28e1 100644
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


