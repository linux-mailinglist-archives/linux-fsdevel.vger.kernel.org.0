Return-Path: <linux-fsdevel+bounces-19788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 151808C9C68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 13:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38E7B1C21EFC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 11:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5DB6E5E8;
	Mon, 20 May 2024 11:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CZ+i3KcB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE0154FAE
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 11:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716205506; cv=none; b=g/pzx+gJQXzIf12/qvU+xHB8Z5JIpGZ3WH+9MC1Cg8L7h3gLqORFzP6xiiz1JiykepCCDgA/DjIJ0iEw16ZoIOLeuT8BYEk/BVnMi7jydKzCYDArB2lRu52hBeJkYghIV943yyxJXA7JCyFPKZn+OPT4OnTxJ06SqUE3KC7aDDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716205506; c=relaxed/simple;
	bh=Ac3WHWfXlPQZczxqpVamDMZW8w7I6olApg/rcA7vauo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=C4p7DDCkTkKC3Y4kLduGm2aq418DvQA/9nYE0DNHvY8tBNuxX+864cRzcL+rzEXjSoPzTNrMpnsj65mi6T856qToxXYaZFqQt2/HJWz82v3gjMrn7ZDBp7ZDqkJGK9KqKX/drp8+2Tub6jeWK+uW5XV8aaIwoRVU/3E5YLVamFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=CZ+i3KcB; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240520114503epoutp0230c0fa730289c7c39e2fd40ba3ca58d5~RL8-rCOmG1030610306epoutp029
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 11:45:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240520114503epoutp0230c0fa730289c7c39e2fd40ba3ca58d5~RL8-rCOmG1030610306epoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716205503;
	bh=eFjYOy/rO8gowEbK0HM6LksYvSQzjlGqTWi9wTV85D4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CZ+i3KcB1WgtOx9XjAhrs9cWVCBOwXEGGC7sQM0NgOA095c//xW695lJOKd7TXbg6
	 MS10uxCnxncl2oMNks5YKnmovLiqqUDu+frJEfMmpfC1jq9NLZl/y9GLqzW9ZXLOg+
	 1rADkCmGXR9s71dNzI+qmQdOdSBa88WazX5Mmne0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240520114502epcas5p314d3ac8847fbfa8f00e6469d2bee365a~RL8_9Pvzi2210822108epcas5p39;
	Mon, 20 May 2024 11:45:02 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4VjbMw3W1Yz4x9Pv; Mon, 20 May
	2024 11:45:00 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	DA.60.19431.CB73B466; Mon, 20 May 2024 20:45:00 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240520102917epcas5p1bda532309b9174bf2702081f6f58daf7~RK62SXh_40443504435epcas5p1G;
	Mon, 20 May 2024 10:29:17 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240520102917epsmtrp2ac75c71748c9cbc2118a64cd866875eb~RK62RQdSo2153521535epsmtrp2y;
	Mon, 20 May 2024 10:29:17 +0000 (GMT)
X-AuditID: b6c32a50-f57ff70000004be7-6c-664b37bccb97
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	88.08.08390.DF52B466; Mon, 20 May 2024 19:29:17 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240520102913epsmtip223ed300d14416990c75ecc6ce4fcc8f9~RK6yqRUzB2247922479epsmtip2r;
	Mon, 20 May 2024 10:29:13 +0000 (GMT)
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
Subject: [PATCH v20 05/12] fs/read_write: Enable copy_file_range for block
 device.
Date: Mon, 20 May 2024 15:50:18 +0530
Message-Id: <20240520102033.9361-6-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240520102033.9361-1-nj.shetty@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0xTVxzHd+693Ba2uiugO5bBWDeUx4pUaDkQUDfMcgkYWbZsy5aIDb08
	Umi7PkQXpjCsAzZegm7W8RCMDhCKtCBP0xUFZXQwsTAg4DSQuTFRgWEYqa6lsP33+b2+319+
	J4eNu9tILjtNpmaUMnE6j3Qj2noDAvjd4XHJIbm3IdIP9OHoyxIbjhqmikk017sA0JnHKzia
	MX0F0KplCEfGvmmAqmsqCDRu6sBQd80pDNU13MDQuW9zMXTj+UMSnTKPAjRr1WGoZyIInT95
	gUDdPbcINNL5PYmqLs6y0KX+ZxgqzbNiqH0mB6C21SocNc09ItDNCS80ZOt32fsqPXInjh6o
	gXSHbopFD01fIegRi4Zuqc8nacOF4/QDw1lAd41nk3RtUZkLXZg7T9Id2rsu9JPZCYJ+dM1K
	0kXGekAPVl9nJXh8Io1KZcQSRunLyJLkkjRZSjQv7v3EmEShKETAF0SgcJ6vTJzBRPP2xSfw
	301Lt1+I53tYnK6xpxLEKhVv5+4opVyjZnxT5Sp1NI9RSNIVYYpglThDpZGlBMsYdaQgJGSX
	0N54SJr6TdcwqZjmHOm9VM7KBqYXC4ArG1JhcLXMABzsTnUD2DkZWgDc7LwA4L1RI8sZLAP4
	130da2Oi5Oc/gLPQA+Bk+RLpDLQY/HH4HFEA2GySCoI/PWc78p5UAw6/NpQSjgCnDDjM6TVh
	DikP6gNovKldkyUoP9hsnScczKEiYPn4b4TT7jXY0GzCHexKRUJT6+M1a0jpXeFISRHmbNoH
	ny0+Wd/PA/7Zb1xnLlyc7yGdnAnryn8gncMnANSN6YCzsAdqB4pxx9o4FQD1nTudaW94eqBp
	TR+nNsHC1Zl1Lw5sr9zgN+BlffW6/jY4+jSHdMhAiobmk0HOqxQC2PNgAi8BPrr/HaoBqAdc
	RqHKSGGShAoBX8Zk/vduSfKMFrD2DwIT2kFDsy3YDDA2MAPIxnmenBZjbLI7RyI++jmjlCcq
	NemMygyE9guW4twtSXL7R5KpEwVhESFhIpEoLCJUJOC9wpnTVkjcqRSxmpEyjIJRbsxhbFdu
	NuYj4lNT5yMrNscenVvU+ilW4g+8/VFa4+5+js9ojM3itd3rrUNRd49ZGlv43MG+1mBv/kXX
	oluueZVHVre+9+lTi9vvxwOmriY27cU3e6SvdFpYmk3jxbePkVLPLjL2gHD5O2nQvUz4kr/M
	8OFCSlRevodHbtq4JX/5H+HD7vjqN3eo/Fn79ebexCydaWz48PXGusHgg9lbAoShHN93CuWR
	ki+yahVjry/oZ1tVSyrp8o7kybPXlqRtv4BdZzK6/MNXKz/ev52dhTXRk1dzrgwXZ/Xesf56
	2eQzX7OnzG/AxI8uq5JYt82f2LpQmzUZeFpk+/uzF7wPvpwQo1+pmEwOu+/GI1SpYkEgrlSJ
	/wXV832lkAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsWy7bCSvO5fVe80g/c9YhbrTx1jtmia8JfZ
	YvXdfjaL14c/MVpM+/CT2eLJgXZGi99nzzNbbDl2j9FiwaK5LBY3D+xkstizaBKTxcrVR5ks
	Zk9vZrI4+v8tm8WkQ9cYLZ5encVksfeWtsXCtiUsFnv2nmSxuLxrDpvF/GVP2S2WH//HZDGx
	4yqTxY4njYwW237PZ7ZY9/o9i8WJW9IW5/8eZ3WQ8bh8xdvj1CIJj52z7rJ7nL+3kcXj8tlS
	j02rOtk8Ni+p93ixeSajx+6bDWwei/sms3r0Nr9j89jZep/V4+PTWywe7/ddZfPo27KK0ePM
	giPsAcJRXDYpqTmZZalF+nYJXBk9uy+wFdzjrTi8fAp7A+MB7i5GTg4JAROJCedeMnYxcnEI
	CexmlOg9upUFIiEpsezvEWYIW1hi5b/n7BBFzUwS65f0MXUxcnCwCWhLnP7PARIXEdjOLPGx
	uZsJpIFZ4CizxIU1FiC2sECQxLcND8HiLAKqEhuuvgNbwCtgKTHl5gOoZfISqzccAFvGKWAl
	cWDrB0YQWwio5u71D2wTGPkWMDKsYpRMLSjOTc8tNiwwykst1ytOzC0uzUvXS87P3cQIjlYt
	rR2Me1Z90DvEyMTBeIhRgoNZSYR30xbPNCHelMTKqtSi/Pii0pzU4kOM0hwsSuK83173pggJ
	pCeWpGanphakFsFkmTg4pRqYChxP7/f+uftI0t5Nne+Yjsf+/bWlkkF02Xebdg/mJyIs01Pn
	NJ24wXCoZaV05awODn9f41kLmOLdamMerBO0Ot9kO2v+ua0rrupMXLQsirvoSVnC2tmeVyJN
	jJ/52O97YLP9z4l1ta5H7PcXT+2wz2zPNTkkWZU4j7eiVjv+aeOGZT9/s7hl3v21JnA1N9sG
	uaqe2R7yd5hcp82cpFx7asqVSTKJN0627/j5zebNWfUHhU7lyiELrhdZ7z+6Qqv57Aa/rnl/
	k2M8xZM3bi3ZwvHpsbmRsvNMv4uBj7PX/lbTvyBj+WjxD/3gZ/lvf0YWFRvcrxf8p/dx2mcJ
	Oe+YKtZ16kxqQcc+uYiUTfPPV2Ipzkg01GIuKk4EAIU1DcFFAwAA
X-CMS-MailID: 20240520102917epcas5p1bda532309b9174bf2702081f6f58daf7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240520102917epcas5p1bda532309b9174bf2702081f6f58daf7
References: <20240520102033.9361-1-nj.shetty@samsung.com>
	<CGME20240520102917epcas5p1bda532309b9174bf2702081f6f58daf7@epcas5p1.samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

From: Anuj Gupta <anuj20.g@samsung.com>

This is a prep patch. Allow copy_file_range to work for block devices.
Relaxing generic_copy_file_checks allows us to reuse the existing infra,
instead of adding a new user interface for block copy offload.
Change generic_copy_file_checks to use ->f_mapping->host for both inode_in
and inode_out. Allow block device in generic_file_rw_checks.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 fs/read_write.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index ef6339391351..31645ca5ed58 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1413,8 +1413,8 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 				    struct file *file_out, loff_t pos_out,
 				    size_t *req_count, unsigned int flags)
 {
-	struct inode *inode_in = file_inode(file_in);
-	struct inode *inode_out = file_inode(file_out);
+	struct inode *inode_in = file_in->f_mapping->host;
+	struct inode *inode_out = file_out->f_mapping->host;
 	uint64_t count = *req_count;
 	loff_t size_in;
 	int ret;
@@ -1726,7 +1726,9 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
 	/* Don't copy dirs, pipes, sockets... */
 	if (S_ISDIR(inode_in->i_mode) || S_ISDIR(inode_out->i_mode))
 		return -EISDIR;
-	if (!S_ISREG(inode_in->i_mode) || !S_ISREG(inode_out->i_mode))
+	if (!S_ISREG(inode_in->i_mode) && !S_ISBLK(inode_in->i_mode))
+		return -EINVAL;
+	if ((inode_in->i_mode & S_IFMT) != (inode_out->i_mode & S_IFMT))
 		return -EINVAL;
 
 	if (!(file_in->f_mode & FMODE_READ) ||
-- 
2.17.1


