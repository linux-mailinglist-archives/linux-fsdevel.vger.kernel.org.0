Return-Path: <linux-fsdevel+bounces-19789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DA18C9C6F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 13:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEA931F23B94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 11:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F486EB75;
	Mon, 20 May 2024 11:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nV3cn/Hr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD5E6EB7E
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 11:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716205511; cv=none; b=i7FSwFv/5XqmmKhxuCNB0cOBpcsgAVr4DU3MDVkxNPq2MFnK8MO5htMgEKI+uOanMlGNVw5WN455BfFYO8LVRfpb8LwyS7q6cT6L683tS8T7uJtNy2Cy2t5tkInI/Dm86lkECa5ww2L88MvRyZyan2cROn+06Yy9+4QyCiLrER0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716205511; c=relaxed/simple;
	bh=e665OnEyWefogk0vb4VFDyJsEhhglmgHT8IJCAx1QrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=AKc3Lbow4KSvcA6anGEmX1ZM8PR8xz/CeaM4J1Hr3WRiriwEMWKMwuQTM00QmjKDLbNZnpmg4KaLwrnrePOsn+/l3lVcoybBm5DEax5MAWaPMIea7u8Ei0/hAdQ39g2lMQdh0ouXLjsOXWHaTl2xNOK7Q2pcqH66ck6nQSMw45E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=nV3cn/Hr; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240520114507epoutp03da8555847f3125d906a32139255d78e4~RL9EC9RGr1512115121epoutp03g
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 11:45:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240520114507epoutp03da8555847f3125d906a32139255d78e4~RL9EC9RGr1512115121epoutp03g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716205507;
	bh=/5WrYlM6k89NsKl1z4Z8uUwH+ZTcI7GeL+q1n6MWvbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nV3cn/HrIJ9I28gSoSLooLCP96sKlzwp3oQUuSxAUMkW3pUZbQiY3K53BzdnJw0qS
	 /53m/nQf/aAhBuC9Cn0FI5AeiKIJynqjphP/MppiyBqSa1soBCVMmeNdu8lOrQyGOr
	 RJ8ctPUyLjUJLFJnHyu1rv3yJzh6O8cfAy+odbsI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240520114507epcas5p1770da6e88bb8e69b58441ec32768b20f~RL9DbPS8Z0060100601epcas5p1H;
	Mon, 20 May 2024 11:45:07 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4VjbN12cCRz4x9Pv; Mon, 20 May
	2024 11:45:05 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	96.1D.09666.1C73B466; Mon, 20 May 2024 20:45:05 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240520102929epcas5p2f4456f6fa0005d90769615eb2c2bf273~RK7BClKh10987709877epcas5p2U;
	Mon, 20 May 2024 10:29:29 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240520102929epsmtrp2668c16e2b9ae57c2df89353a51211e4a~RK7BBRsWd2153521535epsmtrp2_;
	Mon, 20 May 2024 10:29:29 +0000 (GMT)
X-AuditID: b6c32a49-f53fa700000025c2-e8-664b37c1a522
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2B.ED.09238.8062B466; Mon, 20 May 2024 19:29:28 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240520102925epsmtip265107529beb8c915e4bcd516677cf197~RK69azK9t2204722047epsmtip2F;
	Mon, 20 May 2024 10:29:25 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
	<mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
	Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: martin.petersen@oracle.com, bvanassche@acm.org, david@fromorbit.com,
	hare@suse.de, damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
	joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com, Nitesh
	Shetty <nj.shetty@samsung.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v20 06/12] fs, block: copy_file_range for def_blk_ops for
 direct block device
Date: Mon, 20 May 2024 15:50:19 +0530
Message-Id: <20240520102033.9361-7-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240520102033.9361-1-nj.shetty@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VTa1ATVxT27oZNgEZXou2VguDaygjDIwp4QwFRnHYRZ0ot/VFtJ+6Q5SGQ
	pEkQ25mOQQVbNCLIwyY80lTlEQcqAQoqjwaBilIYMDhgeXQGUEsllFqwZdQCCe2/7/vO+c45
	99w5PNzlJeHKS5KqWIWUSaEIJ05D+3Zv3x93RccHlGWvRTXdnTg6eeEFjowjOQSabp8DqHD2
	bxxNtJ0BaLGnF0d1naMA6Q0lHDTU1oShW4Y8DFUaOzCkKzqFoY5XTwmUZx4EaNKixVDzsA/6
	NusyB91qvsNBAzeKCVR2dZKLyrteYij3KwuGGicyAGpYLMNR9bSVg34afhP1vuhyiHCjB+5H
	090GSDdpR7h07+h1Dj3Qk0bXVn1N0KbLJ+jHpm8AfXNITdDfnb/oQGtOzRB0U+aYA/3H5DCH
	trZYCPp8XRWg7+lvc2MEh5JDE1lGwio8WWmcTJIkTQijoj8UR4qDggOEvkIR2kV5SplUNoza
	dyDG992klKUNUZ7HmJS0JSmGUSop//BQhSxNxXomypSqMIqVS1LkgXI/JZOqTJMm+ElZVYgw
	IGBH0FLikeTEh6ZxB/lz8ri+os9BDX7lZwNHHiQDYeuQBssGTjwX8iaA5boCO5kDcGiqgbCR
	eQC1RY3EqmVBv2ppBrC54SzXRjIxOFg8gGcDHo8gfeDdV7xlfQNpxOFZUy5nmeCkCYcZ7W3Y
	cikBKYYd9VfBMuaQb0Nd37OVFnxSBMcWzFxbOw9o/L4NX8aOZAhsq58Fy4UgWeMIe07qcFvS
	Pniue8Y+nwD+1lVnN7vCP2ea7Xo6rMyvIGzm00sPeqAFtsBumNmdszI2Tm6HNTf8bbI7LOiu
	XhkUJ9dCzeIEZtP5sLF0FW+F12r09vqb4OBChh3TcOSH+/YdaQCcrSgGF8Bm7f8t9ABUgU2s
	XJmawCqD5EIpm/7fx8XJUmvByiF4RzWCkfFZPzPAeMAMIA+nNvBr66LiXfgS5vMvWIVMrEhL
	YZVmELS0wVzcdWOcbOmSpCqxMFAUEBgcHBwo2hkspN7gT2eWSFzIBEbFJrOsnFWs+jCeo6sa
	0136R5PoFRQOuGeUhX3b7hxY51Ry+Hb7Xe5bUu/Twwcp8bZzzS2DRfOt+PpI1xPHiAdNzua2
	NQzT2TLlrr40FRjy3kGYWfp0yNmtNKml0nrUas7r13LnrbWWEWFV4bghyqvB55Nn4dU6Z49P
	1a1Gw+MCQavgSkT95N7dXk8Ytz3Ov1CqR/uffPl+fno5ZTniYazweb5HeP3K+EzkRo/cwxGC
	xtC/Io6OEdr9e48Lr92Dhi1qrohoycr/2V22tXP09d/nPrJoumNjM3YeKvCx9mz+OL00bfyd
	zILXCqxVa/zFZpF6bcOA5IPFHXGmLE5qf0fsw5z18i0h1vj+R67Cz9YNUhxlIiP0xhVK5l9E
	6d4ekQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsWy7bCSvC6HmneawZrz5hbrTx1jtmia8JfZ
	YvXdfjaL14c/MVpM+/CT2eLJgXZGi99nzzNbbDl2j9FiwaK5LBY3D+xkstizaBKTxcrVR5ks
	Zk9vZrI4+v8tm8WkQ9cYLZ5encVksfeWtsXCtiUsFnv2nmSxuLxrDpvF/GVP2S2WH//HZDGx
	4yqTxY4njYwW237PZ7ZY9/o9i8WJW9IW5/8eZ3WQ8bh8xdvj1CIJj52z7rJ7nL+3kcXj8tlS
	j02rOtk8Ni+p93ixeSajx+6bDWwei/sms3r0Nr9j89jZep/V4+PTWywe7/ddZfPo27KK0ePM
	giPsAcJRXDYpqTmZZalF+nYJXBm3Nz9gLfghULFgxQXWBsaHvF2MnBwSAiYS3xf0MnUxcnEI
	CexmlPh9YhMrREJSYtnfI8wQtrDEyn/P2SGKmpkkVj0/CuRwcLAJaEuc/s8BEhcR2M4s8bG5
	mwmkgVngKLPEhTUWILawQKxEz79WsEEsAqoSsy98YQOxeQUsJe5/P8QOsUBeYvWGA2A1nAJW
	Ege2fmAEsYWAau5e/8A2gZFvASPDKkbJ1ILi3PTcZMMCw7zUcr3ixNzi0rx0veT83E2M4GjV
	0tjBeG/+P71DjEwcjIcYJTiYlUR4N23xTBPiTUmsrEotyo8vKs1JLT7EKM3BoiTOazhjdoqQ
	QHpiSWp2ampBahFMlomDU6qBKSotOnXuR/VM58hf25ILLxm5WxavPLVTc2mSdC975OM9UYmV
	Rdf89l48HlNgvNOw2m+LUtPHs9+1ju81+aG4v3b577Qfqw+1aHhdbnzdcKBy5ocMhoi5m39c
	eqCcOLF2ytTrD8xrNWvnyAtuXZrVPbU69VFrXWVoiM/8eyGbFz4TXLkoakG2nXZY4v7ma09U
	xdby9J70DAo21a9NDl7xOeHvU8G5fP7fa2buMZ8dO+v3d1fpPq9AydCOKN+PRnvXaMVf2nVk
	Z0tbqcvKty+6sp+H2HsoaedHxZ9zmbjr+3GpNBWWE+ftTZZebsvaZ2WbKLrb7Nibt4dmsTCG
	Xi4UjG5c8vnYg0T5ecKfn4mfVGIpzkg01GIuKk4EANH/NelFAwAA
X-CMS-MailID: 20240520102929epcas5p2f4456f6fa0005d90769615eb2c2bf273
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240520102929epcas5p2f4456f6fa0005d90769615eb2c2bf273
References: <20240520102033.9361-1-nj.shetty@samsung.com>
	<CGME20240520102929epcas5p2f4456f6fa0005d90769615eb2c2bf273@epcas5p2.samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

For direct block device opened with O_DIRECT, use blkdev_copy_offload to
issue device copy offload, or use splice_copy_file_range in case
device copy offload capability is absent or the device files are not open
with O_DIRECT.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 block/fops.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index 376265935714..5a4bba4f43aa 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -17,6 +17,7 @@
 #include <linux/fs.h>
 #include <linux/iomap.h>
 #include <linux/module.h>
+#include <linux/splice.h>
 #include "blk.h"
 
 static inline struct inode *bdev_file_inode(struct file *file)
@@ -754,6 +755,30 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
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
+		copied = splice_copy_file_range(file_in, pos_in + copied,
+						 file_out, pos_out + copied,
+						 len - copied);
+	}
+
+	return copied;
+}
+
 #define	BLKDEV_FALLOC_FL_SUPPORTED					\
 		(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |		\
 		 FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE)
@@ -859,6 +884,7 @@ const struct file_operations def_blk_fops = {
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= blkdev_fallocate,
 	.fop_flags	= FOP_BUFFER_RASYNC,
+	.copy_file_range = blkdev_copy_file_range,
 };
 
 static __init int blkdev_init(void)
-- 
2.17.1


