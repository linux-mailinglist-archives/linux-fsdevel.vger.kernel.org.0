Return-Path: <linux-fsdevel+bounces-29029-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F7F973B14
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 17:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E459928443D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 15:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF41199FD3;
	Tue, 10 Sep 2024 15:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="l7UJGCwD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA386199E9D
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 15:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725981055; cv=none; b=e/dnc0U7iD8SbITJGpSpvpw5u76OsxMvU0ijhjPmtU274Fx0E79uT4yMfWhxr31Y+Wq+7oD0omCYR/pZ9rdOSylk5CKQSqVAMIfFA6KXc8YiZD2jC9mM5PtyiYZ/HWEpChRAOuRtsyPpBeI53vIpzmm6Fs67jHCYlRmiP2hTxaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725981055; c=relaxed/simple;
	bh=ov6xA9K9iXGpqQlTQm6tmG7h9eDDCdtk808oP4zJnxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=YuiIDwZ0K1iKQ0jW18K+1OGF7VtToU1gXb+8H+fY0nn4M3hDIVwpQP4cwv7od+Uaq0kUiv2wDUpt/8kS2/eZiPlumvpUeMLZT4ndaPd2LvTc/pEAKYVAuH+9WkPzUSm6FX1ilhug80f60+G61vLoM+svOG51QoMLqUR3lHv/i6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=l7UJGCwD; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240910151050epoutp022be3fbde1eba134128e04ab1c1ecfb07~z6p8INdDj2304623046epoutp02B
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Sep 2024 15:10:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240910151050epoutp022be3fbde1eba134128e04ab1c1ecfb07~z6p8INdDj2304623046epoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725981051;
	bh=pMYjZwpNA2424mhqR5If5Z9/oTINVKlEa7d3jWpwtNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l7UJGCwDN4SiSuTrx6hJPODsaAQgHZlKK4WJMcPNSTRmfusfcAKXPr+G+Nq5jDkex
	 YSoroUbwMCW4UrBs2VZKpelkX3MIRobVQ8BqDC21P+keybJhHJi+sBHHcRqPREgz93
	 uqIvu/PNMgjlpFWN0mjPbl0SpZssXTzG3F881AWg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240910151050epcas5p179ff3d5c1a23344350ef986991a1f492~z6p7VY4Pn0608306083epcas5p1F;
	Tue, 10 Sep 2024 15:10:50 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4X36bD6pwfz4x9Ps; Tue, 10 Sep
	2024 15:10:48 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4B.86.09640.87160E66; Wed, 11 Sep 2024 00:10:48 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240910151048epcas5p3c610d63022362ec5fcc6fc362ad2fb9f~z6p5sWm3Y0202102021epcas5p3K;
	Tue, 10 Sep 2024 15:10:48 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240910151048epsmtrp1f4f0e75e2c26af28a4bad11e3192301c~z6p5rfzf-1279412794epsmtrp1C;
	Tue, 10 Sep 2024 15:10:48 +0000 (GMT)
X-AuditID: b6c32a49-aabb8700000025a8-69-66e06178b9ab
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	29.DC.08964.87160E66; Wed, 11 Sep 2024 00:10:48 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240910151044epsmtip2969e9e84906072571198d274c61a89e4~z6p19uGJ71712417124epsmtip2t;
	Tue, 10 Sep 2024 15:10:44 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	jaegeuk@kernel.org, jlayton@kernel.org, chuck.lever@oracle.com,
	bvanassche@acm.org
Cc: linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com, vishak.g@samsung.com,
	javier.gonz@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH v5 2/5] fcntl: rename rw_hint_* to rw_lifetime_hint_*
Date: Tue, 10 Sep 2024 20:31:57 +0530
Message-Id: <20240910150200.6589-3-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240910150200.6589-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TbUxbVRzGc+4t7WVSvCsTDjVseB1LQF7aCeWgsC3ayTXsA8liTPZBuKOX
	Qlra2ttuQCRDkCowB2IGo7yIuPE6N3lnQxJlq4gOQTYZMN4FmYOlUAKGDIYtZbpvv/M/z3P+
	5zkvBC5a4YuJZI2B1WsYNcXfw2u/5R8QlMpMJ0pWCyWocaKAjxZv2QAqXt7A0fbEAoZGf7iB
	ofpGC4bKSrIxNHfdjKOmAgL9Ob4qQBs1DQJk2X7MR0U9wwB1j72Ghqqj0ffdfTz0Vc28AOXf
	7+Sj2t6nGLq2aOWhga1eFzRgLhcc86Tv3ouhByabeHRx0S98+m6/kW5uyOXTLZfP0V1Vqxjd
	NZrJp1fmx3j0hdYGQN+pui2gV5v3081zj7FY4SlVZBLLKFi9L6tJ0CqSNcooKuZk3NtxYTKJ
	NEgagcIpXw2TwkZR8hOxQe8kq+2ZKd8zjNpoL8UyHEeFHInUa40G1jdJyxmiKFanUOtCdcEc
	k8IZNcpgDWt4QyqRHA6zC+NVSev5Vlxn2pu6NNgNMsGSMA+4EpAMhTMPanh5YA8hIrsArNn4
	FXcObABey2oHzsE6gNtN9eCZZfiPqV1VN4CtAw8EjgkRuQpgbtZbeYAg+KQ/HPzS6NDsIysx
	+NOgZWclnCzC4Mr0t3yHwYM8DhcXnuAO5pF+cOq7xp26kAyH6yPnBc5uB2Dp0D877EoiuFB7
	FXNq9sK+0jmeg3G7JrutbGdHkMx3hRUdm3ynWQ7LyocwJ3vAR72tu4uK4d8Fpl1WwenZaZ6T
	P4KdLRdcnHwUZm6OuDjS4PY012+GOHu5w8+fzGGOMiSF8DOTyKl+BU4Wze86veDMpcu7TMNR
	a6uL87DyAVzbvIEVggPm5yKYn4tg/r9bFcAbgDer41KULBemk2rYs//dbII2pRnsvP2AdzvB
	xPRycA/ACNADIIFT+4QFRyYTRUIFk5bO6rVxeqOa5XpAmP2Mv8DFLyVo7Z9HY4iThkZIQmUy
	WWjE6zIp5SVczKlQiEglY2BVLKtj9c98GOEqzsRUlVjCTP7X5vq2p7YrTR5z+005Xvc/MJX6
	HYJ6t8YraRGBFbk5A1nBzeFpqowtny5Z3FV5fGKfe5r/il+gMrptTXxT5Jls5Sy1jDlx69OM
	xJplIr3D09ta0GGZfdlN1iaMSU4fzpoypM7aKifbQ3j4nfXAk8d9sjuSvL5ZSZWE/V5+StNy
	ps5U0uXqc9v9EPUos9H//ItTbLW0YankdGSrUdbGnjt4Qlz6XpFtSz6e+3NK4ObHigrlbwuF
	n4wDeLpvW+6G8j588+yamBiJj33/4Y/31EOs1dZefdAil/uMHT08lTFV91DFjcZ6C/sv1jfV
	Hetzf5Uq7o/+a+2FkEsUj0tipAG4nmP+Be3mHYqEBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra0hTYQCG/b5zPDsuhqdpedLQNTLsZklRHyEWgXWofnQPup/0aJaba3Pd
	qJSsSdpcGZnOSovK3MLcskzULluilma10lymlsoslS0NU3Oa04L+PfA88P54SUxYhPuSMdJ4
	Ti5lY8UEH39kFgfMP8q2Ri1MtXsi/WcNgbrMvQBlOAYxNPrZBlHjsxKI8vUVEGVfSYKo/b4W
	QwYNidqa+nho8I6OhypGewiUbqoHqNw6F727uRqVlVfjKOdOBw+lNjwmUF7lCEQFXXYc1Tkr
	3VGd9ipvxVTG8n4tU9dswJmM9JcEY6lVMkbdOYJ5cCuBKc3tg0xpYyLB/Oiw4kxakQ4wNbkv
	eEyf0Z8xtvfA9YLt/NBILjbmMCdfELaXv78/1Y7JVJOPdr8pB4mgW5ACPEiaWkzXf2jBUgCf
	FFKlgG64/RZMCB86qX6AN8FedP6IjTcR/QB0R+VTmAJIkqBm028uKV2NN1UA6bsZ61wNRl2F
	dN65YswlvKhwusv2e5xxKpBuKdQTLhZQS+n+j+f/DgTQWe9+jbMHhWhb3j3oYuFY49Dkuk/0
	k+nqrHbcxdhYn/QwG7sAKO1/SvufygVQB6ZxMoUkWqIIkYVIuSPBClaiUEqjgyPiJEYwfuyc
	2Y9Bsc4RbAKQBCZAk5jYW6AJa44SCiLZY8c5edweuTKWU5iAH4mLfQQ+nepIIRXNxnMHOU7G
	yf9ZSHr4JsLruphiLvzJrCVKa1bmvmai6ROZFK4O3XLJTor2nfb6umF3uuXkW1KFV3Z/GU7I
	P1R/zSFPmxnkfxH0atb0nM/JvLkyecTk1zYvTbHMd8/mbwMZM7hpjT7uRaraGreHyVb4fJnB
	4l2SvzyCtULzT/nSRZcvhK72DPogCjLHHfzYuXZ4uv7TrnVemeqN3juPlzhPBW02idU2uG1I
	pyUWlIXXiCWxFaZW/vdvTqkscJto04Z7hcZU1c7rT8/49kWcMDj9p1iqRC9f2T23vp7kyKqS
	qg2li7Y4YU4o6Ta4Y+hsbWdUd5tbS3bTiPiax40dB0Q9hasWFpgzVYGCBlZXphfjiv1syBxM
	rmD/AE2dcMxHAwAA
X-CMS-MailID: 20240910151048epcas5p3c610d63022362ec5fcc6fc362ad2fb9f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240910151048epcas5p3c610d63022362ec5fcc6fc362ad2fb9f
References: <20240910150200.6589-1-joshi.k@samsung.com>
	<CGME20240910151048epcas5p3c610d63022362ec5fcc6fc362ad2fb9f@epcas5p3.samsung.com>

F_GET/SET_RW_HINT fcntl handlers query/set write life hints.
Rename the handlers/helpers to be explicit that write life hints are
being handled.

This is in preparation to introduce a new interface that supports more
than one type of write hint.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 fs/fcntl.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 300e5d9ad913..9df35e7ff754 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -269,7 +269,7 @@ static int f_getowner_uids(struct file *filp, unsigned long arg)
 }
 #endif
 
-static bool rw_hint_valid(u64 hint)
+static bool rw_lifetime_hint_valid(u64 hint)
 {
 	BUILD_BUG_ON(WRITE_LIFE_NOT_SET != RWH_WRITE_LIFE_NOT_SET);
 	BUILD_BUG_ON(WRITE_LIFE_NONE != RWH_WRITE_LIFE_NONE);
@@ -291,7 +291,7 @@ static bool rw_hint_valid(u64 hint)
 	}
 }
 
-static long fcntl_get_rw_hint(struct file *file, unsigned int cmd,
+static long fcntl_get_rw_lifetime_hint(struct file *file, unsigned int cmd,
 			      unsigned long arg)
 {
 	struct inode *inode = file_inode(file);
@@ -303,7 +303,7 @@ static long fcntl_get_rw_hint(struct file *file, unsigned int cmd,
 	return 0;
 }
 
-static long fcntl_set_rw_hint(struct file *file, unsigned int cmd,
+static long fcntl_set_rw_lifetime_hint(struct file *file, unsigned int cmd,
 			      unsigned long arg)
 {
 	struct inode *inode = file_inode(file);
@@ -312,7 +312,7 @@ static long fcntl_set_rw_hint(struct file *file, unsigned int cmd,
 
 	if (copy_from_user(&hint, argp, sizeof(hint)))
 		return -EFAULT;
-	if (!rw_hint_valid(hint))
+	if (!rw_lifetime_hint_valid(hint))
 		return -EINVAL;
 
 	WRITE_ONCE(inode->i_write_hint, hint);
@@ -449,10 +449,10 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 		err = memfd_fcntl(filp, cmd, argi);
 		break;
 	case F_GET_RW_HINT:
-		err = fcntl_get_rw_hint(filp, cmd, arg);
+		err = fcntl_get_rw_lifetime_hint(filp, cmd, arg);
 		break;
 	case F_SET_RW_HINT:
-		err = fcntl_set_rw_hint(filp, cmd, arg);
+		err = fcntl_set_rw_lifetime_hint(filp, cmd, arg);
 		break;
 	default:
 		break;
-- 
2.25.1


