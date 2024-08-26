Return-Path: <linux-fsdevel+bounces-27204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F5495F7AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 19:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9BFB1C21F79
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 17:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06746198A27;
	Mon, 26 Aug 2024 17:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WFfY1jcw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CD518D64D
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 17:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724692464; cv=none; b=A/f8Tdwyd5USbrXg9ABVyx092ckUWSPO+9ml0AWJyAmDaduMHWt2ZRAbM5sjeE7/1soib9bCzh/8DTachXTVG7sdUEp/iSDt7kz9DdUuGdoeYt6nuK6RZutEpx7V9FGqjQK4bI/MXCTOfZfK6pkBDmzPeKeUCQhZ7NOLcfIMvmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724692464; c=relaxed/simple;
	bh=Qs+0/eghBwmI0+lDjMQ599piAQB0g7zovPudUM+h4To=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=RHuzfAXBA2Wan5WN5Vb1KgP/KcrOQ1pdWL8hCZdHHeGmHKErDyzkmoQh7P0Mt5FMe1kmpHeaNdz/14QegBddPd4xJbLAg8JXeOubyIbhftlSqsQuUv5xL2fLcvCEcSdQRegVIBfmqjYuRQyeJbzfI/k0j/nL3CkEZDWA2DlzfYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=WFfY1jcw; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240826171420epoutp02ba28bdd815a072e1db7d8136edb609d2~vVqe9DcGK2068320683epoutp02n
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 17:14:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240826171420epoutp02ba28bdd815a072e1db7d8136edb609d2~vVqe9DcGK2068320683epoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724692460;
	bh=dvmnXluL763m/k/i9q5rrEgvQ+XYswDEKR5fFJwq0zY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WFfY1jcwoJQ7QQ43GdoomZSnARi7RvDtwJOeywCslMObHyPHu/+S7VeWrF4zzNEKN
	 zB6FNbCioR14iuWC+EXawfBAf97MIuUSdlftEMo2Mc0r6UBrkhMcC6npg3RokJbnsB
	 f5+Rr5WaasQVzwCfYYfMzq9tJuLp2atyTlSPskp0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240826171419epcas5p23cc7ff5eeadbd876a1ae23a70d292612~vVqeOcWQv0605906059epcas5p2q;
	Mon, 26 Aug 2024 17:14:19 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Wsy2f1scRz4x9Pt; Mon, 26 Aug
	2024 17:14:18 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	09.67.19863.AE7BCC66; Tue, 27 Aug 2024 02:14:18 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240826171417epcas5p1c6dbe318c43324116647dae2129b7eb3~vVqcNuU9j0392603926epcas5p1p;
	Mon, 26 Aug 2024 17:14:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240826171417epsmtrp2d498a352e437e2c14cc2c22ecf314eff~vVqcMys6o3048030480epsmtrp2i;
	Mon, 26 Aug 2024 17:14:17 +0000 (GMT)
X-AuditID: b6c32a50-ef5fe70000004d97-80-66ccb7ea69f1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5C.3E.08964.9E7BCC66; Tue, 27 Aug 2024 02:14:17 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240826171413epsmtip2407f4dc023aef06fcca161d1f824ce43~vVqYlY3Pe0834608346epsmtip2O;
	Mon, 26 Aug 2024 17:14:13 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
	brauner@kernel.org, jack@suse.cz, jaegeuk@kernel.org, jlayton@kernel.org,
	chuck.lever@oracle.com, bvanassche@acm.org
Cc: linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com, vishak.g@samsung.com,
	javier.gonz@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH v4 2/5] fcntl: rename rw_hint_* to rw_life_hint_*
Date: Mon, 26 Aug 2024 22:36:03 +0530
Message-Id: <20240826170606.255718-3-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240826170606.255718-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTVxjfubfcFmPNHS9PukzwRk2AgXSWejCUjUHmTWBJo4uZ4gKFXgqh
	tLWPbSK6GpxxRWBW8IFusNkVLZFnN1AsMBgqhMVN2HiMlwxkg2F5SnAIa2nd/O/3/b7f933n
	951zOLjXnwSPk67QMmqFRE4RG1jftwYGhUzWdaaGzS6zUflgAYGmWucAujCzjKO1wQkM9TXf
	wtCN8jYMXbmYg6GxymIcVRdw0B8D82y0bLawUdvaNIGMLb8BZOsPRg+/2Yvu2NpZqMQ8zka5
	PfUEKru3iqGKKTsLPSi+yn7bl+7qjqMfDFWz6AvGDoLu+klH11g+J+ha06d0Q+k8Rjf06Ql6
	dryfRedbLYDuLP2RTc/XbBFvPJQRmcZIpIw6gFGkKKXpCpmIitufGJMYLgzjh/Aj0G4qQCHJ
	ZERUbLw45N10ucMpFfCRRK5zUGKJRkPtjIpUK3VaJiBNqdGKKEYllasEqlCNJFOjU8hCFYx2
	Dz8s7M1whzApI+3W7R/YqifkJ/3TvYQedHMNwJMDSQGsHjYAA9jA8SLvANjzuJFwBXMArpqL
	2K7gKYALPSXEi5LFbquHK2ED8Jepk27VPID9dT2ODIdDkIHw5/M6J+9D5mCw+uaz9b44acTg
	7MhNwinyJqNhlUno7Moit8NnV+0sJ+aSEdCWOwdc0/zh5YdLbCf2JPfAtRk726V5FbZfHlvX
	4w5NzndXcGd/SK5x4JmKAbarOBaW5i+6j+0NJ+9Z3TwPzj+xufkMODI6wnLhbFhfm+/hwm9B
	/UrvuhncYaby9k7XrE0w758xzElDkgvPnPZyqbfCIeO4u3IzfHTJ5MY0LD9dhLn2kwdgR1Mf
	9gXwL37JQvFLFor/n1YKcAvgMSpNpoxJCVfxQxTMx/9dbYoyswasP/kgcT0or3oe2gIwDmgB
	kINTPtwtXe2pXlyp5GgWo1YmqnVyRtMCwh1LPofzfFOUjj+j0CbyBRFhAqFQKIjYJeRTm7lT
	n30p9SJlEi2TwTAqRv2iDuN48vSYXMYrPDylMMe3W2WvNG6ffGwkRoriizS6OCJhcLluOqUh
	q/BEY83Zi6bRCqqk71DZwWOvLVpOZX9rP9UafbdAKho+jgX/fTDuHDI0rRzdZr5vN+iphHGZ
	PXLh99QDMW8kd3oXHnkeawod35R1LMOn6YMb7w+1Lw1HJe3Ajjwa8c00iBPLmnFT7u5Kv/OX
	KhfwkNS9QkFOi35maIywl5yNtgXHnFw5vk8b3xzrJ1r1r772dWDUh9GtMR1iUf5fvPeWTEkT
	PX0r9Xn04Mx9j63i2oEVv962X0drVlXWA9etydy70yf2b/TP+mrCHvE6siQbdyWkU9zD7zxN
	mNRWZV+7bqZYmjQJPwhXayT/Akz0UW97BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsWy7bCSvO7L7WfSDN7s1rBYfbefzeL14U+M
	FtM+/GS2+H/3OZPFzQM7mSxWrj7KZDF7ejOTxZP1s5gtNvZzWDy+85nd4ueyVewWR/+/ZbOY
	dOgao8XeW9oWlxa5W+zZe5LFYv6yp+wW3dd3sFksP/6PyWLd6/csFudnzWF3EPW4fMXb4/y9
	jSwe0yadYvO4fLbUY9OqTjaPzUvqPXYv+MzksftmA5vHx6e3WDz6tqxi9Diz4Ai7x+dNcgE8
	UVw2Kak5mWWpRfp2CVwZO3cdZC94J1Bx6+0NtgbGK7xdjJwcEgImEl+vbGEFsYUEdjNKbHpa
	DREXl2i+9oMdwhaWWPnvOTtEzUdGiedf+bsYOTjYBDQlLkwu7WLk4hARmMwk0fRwCwuIwyww
	h0lieed2ZpAiYQFHiQ1LzEB6WQRUJX7Nec8CYvMKWErs7f7ECDFfXmLmpe9g8zkFrCT+f3gP
	tctSYuWZ5ewQ9YISJ2c+AetlBqpv3jqbeQKjwCwkqVlIUgsYmVYxSqYWFOem5xYbFhjmpZbr
	FSfmFpfmpesl5+duYgRHppbmDsbtqz7oHWJk4mA8xCjBwawkwit3+WSaEG9KYmVValF+fFFp
	TmrxIUZpDhYlcV7xF70pQgLpiSWp2ampBalFMFkmDk6pBqaI361bzdYefGvotaUs0pcxS1Zz
	X6zrROkJOuGZtVszXeapXojrEYj2upp1teTdynKVzLKYa3o/lrAcedEWaHdJ/HLAJ59nXCmz
	xTYZP3345lLWgsVzXp8Snez4WvDx72/vtjTfEJPT+bdoZ+rjhwwrg/fM85hv90L0cs2NT34K
	pfq8em++RTv+vs8Z7H45UtnC6cPnXi+2dqfP2iekMu0X2/dfzUxq2CvvMCVLeT1HtNXVlze4
	AiSyF4i6/NucvXyB5Ro5Y5EZ0tOVXL0X+rlG2h6eF2djdiDoRmLDvqrKdfucV6bu9FW7fKp6
	+dPqHpGia0t+W374HKJ1w2ndooVXRc/fPpe9/E+seVRvpLsSS3FGoqEWc1FxIgAB0w2bOwMA
	AA==
X-CMS-MailID: 20240826171417epcas5p1c6dbe318c43324116647dae2129b7eb3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240826171417epcas5p1c6dbe318c43324116647dae2129b7eb3
References: <20240826170606.255718-1-joshi.k@samsung.com>
	<CGME20240826171417epcas5p1c6dbe318c43324116647dae2129b7eb3@epcas5p1.samsung.com>

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
index 300e5d9ad913..46cf08f67278 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -269,7 +269,7 @@ static int f_getowner_uids(struct file *filp, unsigned long arg)
 }
 #endif
 
-static bool rw_hint_valid(u64 hint)
+static bool rw_life_hint_valid(u64 hint)
 {
 	BUILD_BUG_ON(WRITE_LIFE_NOT_SET != RWH_WRITE_LIFE_NOT_SET);
 	BUILD_BUG_ON(WRITE_LIFE_NONE != RWH_WRITE_LIFE_NONE);
@@ -291,7 +291,7 @@ static bool rw_hint_valid(u64 hint)
 	}
 }
 
-static long fcntl_get_rw_hint(struct file *file, unsigned int cmd,
+static long fcntl_get_rw_life_hint(struct file *file, unsigned int cmd,
 			      unsigned long arg)
 {
 	struct inode *inode = file_inode(file);
@@ -303,7 +303,7 @@ static long fcntl_get_rw_hint(struct file *file, unsigned int cmd,
 	return 0;
 }
 
-static long fcntl_set_rw_hint(struct file *file, unsigned int cmd,
+static long fcntl_set_rw_life_hint(struct file *file, unsigned int cmd,
 			      unsigned long arg)
 {
 	struct inode *inode = file_inode(file);
@@ -312,7 +312,7 @@ static long fcntl_set_rw_hint(struct file *file, unsigned int cmd,
 
 	if (copy_from_user(&hint, argp, sizeof(hint)))
 		return -EFAULT;
-	if (!rw_hint_valid(hint))
+	if (!rw_life_hint_valid(hint))
 		return -EINVAL;
 
 	WRITE_ONCE(inode->i_write_hint, hint);
@@ -449,10 +449,10 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 		err = memfd_fcntl(filp, cmd, argi);
 		break;
 	case F_GET_RW_HINT:
-		err = fcntl_get_rw_hint(filp, cmd, arg);
+		err = fcntl_get_rw_life_hint(filp, cmd, arg);
 		break;
 	case F_SET_RW_HINT:
-		err = fcntl_set_rw_hint(filp, cmd, arg);
+		err = fcntl_set_rw_life_hint(filp, cmd, arg);
 		break;
 	default:
 		break;
-- 
2.25.1


