Return-Path: <linux-fsdevel+bounces-22839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AC291D686
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 05:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96F7028178D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 03:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB953C2D6;
	Mon,  1 Jul 2024 03:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="s0iE896n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385AF1A269
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jul 2024 03:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719804046; cv=none; b=CNroBeWRaJNIHDqbIlipH8RWQUK0IdmMVvLjHR7L8imFVN9ZSWEiwaCxM1SMfYHsobHuMXQmAMSTeEVjpx7OS2EnbfnmWu2uyVWfGSXD7Gxz3EreSj6YWiWSxqp/N4P4NTtgefZwiAJpi6ZIfuQDr0bpevRZbismSKOjWlGG9SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719804046; c=relaxed/simple;
	bh=hhzcxn3o15FWD44sYfGUZc2UF7od1cqh57GfN5AtSFA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=MRwoCIwC35EOBnLq+F6pg7SZY/ca3GwOQL0yVSpPNWjoDiWCXyyMKC2apOM3wYfTNKAsMnIwzNGnni6dodiTQMUmRQWXfdtGjE0lIWXALy4dfCAkFj/04Q3f+O3pJRjXd8qVdxaj9i2IR/laypMFsEwyI/UfOf7W/gSoGe0VPww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=s0iE896n; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240701032034epoutp04d6d32e309597f07cea8fd6f8fe31348f~d_KhrZpyC0904109041epoutp04C
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jul 2024 03:20:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240701032034epoutp04d6d32e309597f07cea8fd6f8fe31348f~d_KhrZpyC0904109041epoutp04C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1719804035;
	bh=Vxi5sHDAhuEww9/KaAgxP+Heg1gv8NQiMaWH3RP8kMw=;
	h=From:To:Cc:Subject:Date:References:From;
	b=s0iE896nzlaNiUFCTAUYWGmEnSyS6dpEaQxz5PhdZCdRq9LNm3sGpgkWeIVA60bze
	 2aHCGgDtzSSk/YO5EjU/vLjLYuRD7b0UQmQy+k6L1cUuR0kzQNlo/2lO35+Bo8ZmJh
	 5erPfjy2YodH/bRmRHzhBf1N87Hqv+XrnFM/R6f4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20240701032034epcas2p42c86a901d27fb9e440da844f582f6e6e~d_KhXmG790424904249epcas2p41;
	Mon,  1 Jul 2024 03:20:34 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.38.182]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4WCBBT06yLz4x9Pp; Mon,  1 Jul
	2024 03:20:33 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	8B.BD.09485.08022866; Mon,  1 Jul 2024 12:20:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
	20240701025614epcas2p16db7bb7616cf8be284034ae7fb35275d~d91RXTW7k2321823218epcas2p1V;
	Mon,  1 Jul 2024 02:56:14 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240701025614epsmtrp1e17dcd3db1f9c38daf23cfe27e550a39~d91RWmoBA0897608976epsmtrp1L;
	Mon,  1 Jul 2024 02:56:14 +0000 (GMT)
X-AuditID: b6c32a46-f3bff7000000250d-10-6682208046a5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4B.DA.19057.ECA12866; Mon,  1 Jul 2024 11:56:14 +0900 (KST)
Received: from dpss81-OptiPlex-9020.. (unknown [109.105.118.81]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240701025613epsmtip26de489e87992bded0c23cc01ab4ac7fa~d91Qbqr0P1543115431epsmtip2p;
	Mon,  1 Jul 2024 02:56:13 +0000 (GMT)
From: Hui Qi <hui81.qi@samsung.com>
To: jlayton@kernel.org, chuck.lever@oracle.com, alex.aring@gmail.com
Cc: linux-fsdevel@vger.kernel.org, bvanassche@acm.org, joshi.k@samsung.com,
	j.xia@samsung.com, Hui Qi <hui81.qi@samsung.com>
Subject: [PATCH] Fixes: ec16b147a55bfa14e858 ("fs: Fix rw_hint validation")
Date: Mon,  1 Jul 2024 11:21:10 +0800
Message-Id: <20240701032110.3601345-1-hui81.qi@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmmW6DQlOaweeNlhaHGswtpn34yWzx
	/+5zJou5ry+xWOxctpbd4uOe1UwWP5etYrc4+v8tm8WevSdZLM5O+MDqwOVx+Yq3x85Zd9k9
	Nq3qZPP4+PQWi0ffllWMHp83yQWwRWXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpa
	mCsp5CXmptoqufgE6Lpl5gAdpqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCnQ
	K07MLS7NS9fLSy2xMjQwMDIFKkzIzjja/5a9YDVvxbXl3ewNjK+4uhg5OSQETCR2TljA0sXI
	xSEksINRonl7IzOE84lRovvJHXYI5xujxMZnX1lhWj6+uMkEkdjLKLF793eolq+MEjOvbmYH
	qWITUJa48WYjM4gtIuAisfPcdMYuRg4OZoE6iQUfWEDCwgLeEpMOn2YDsVkEVCVenJvOBGLz
	ClhL3N+5lh1imbzE/oNnmSHighInZz4B62UGijdvnQ22V0LgI7vE2onrGCEaXCQO3T0Edamw
	xKvjW6AGSUm87G+Dsosl2j/8ZgW5R0KgRqL5eglE2Fpi2/p1TBBnakqs36UPEZaVmHpqHRPE
	Wj6JjsN/oabwSnw+vgPKVpI4vmETM4QtIXHg2x4WiOkeEr8aeEHCQgKxEls2NbNOYJSfheSZ
	WUiemYWweAEj8ypGsdSC4tz01GKjAiN4nCbn525iBCdNLbcdjFPeftA7xMjEwXiIUYKDWUmE
	N/BXfZoQb0piZVVqUX58UWlOavEhRlNg8E5klhJNzgem7bySeEMTSwMTMzNjM2NzIzMlcd57
	rXNThATSE0tSs1NTC1KLYPqYODilGpjEmb/2q/XubZzRk3syIbnCfNXZQFtJqx1TuJzL03Vm
	vJAr8jqhz8Sk0i32WTPlcp9hfNGm/w/uT/qfekNye//LXx58e2tjj02NvVHgfTPgnGQlz8nZ
	VUyXM6XM1n146rrSo6ik+ZRf1+epm2YZ9i3/7bDLP+H1k/cv2Rf82vYziN/554m5YhNerpiT
	I3h7EpPRnA/Pph9uzd/Mcif5rXyzzGblx0p/vgqwFK3hWvi0/Njn1vnBDb6uixW1bI/PfbKW
	XWK92D/FD/euRawPe9/7adp7+Ro/weaGs0f1bscePL7Icw3fzxftx0PaeKZ9eJG+59H0D535
	ryO2ng+Tlkv8uXZx4ssLsZI2k50/PmNepsRSnJFoqMVcVJwIAOFqzzgjBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsWy7bCSvO45qaY0g62/eC0ONZhbTPvwk9ni
	/93nTBZzX19isdi5bC27xcc9q5ksfi5bxW5x9P9bNos9e0+yWJyd8IHVgcvj8hVvj52z7rJ7
	bFrVyebx8ektFo++LasYPT5vkgtgi+KySUnNySxLLdK3S+DKONr/lr1gNW/FteXd7A2Mr7i6
	GDk5JARMJD6+uMnUxcjFISSwm1Gisx3E4QBKSEh8+hIEUSMscb/lCCuILSTwmVGi/4sZiM0m
	oCxx481GZhBbRMBD4s7h2cwgc5gFWhgl9r/6ygKSEBbwlph0+DQbiM0ioCrx4tx0JhCbV8Ba
	4v7OtewQC+Ql9h88ywwRF5Q4OfMJWC8zULx562zmCYx8s5CkZiFJLWBkWsUomVpQnJueW2xY
	YJSXWq5XnJhbXJqXrpecn7uJERzIWlo7GPes+qB3iJGJg/EQowQHs5IIb+Cv+jQh3pTEyqrU
	ovz4otKc1OJDjNIcLErivN9e96YICaQnlqRmp6YWpBbBZJk4OKUamLrm7DGNEJy38kzzykWn
	4iJFmvYd+XTgmeLUjv1n9hvsTVtxTE019vOhuNML09YlTOOc3Wx2/2/WNtfw5yU/mvap3T/Y
	PMPSf9ZHy5f3Px7qvHOws9lptzp7fDnXpSfFsxk/LUuT4732++L/LlaeVxesv+futkh5tqCG
	vSByap/rll2Xu8QjxRS+t7HaHNjlfzSU2SNO7cAOl+XCf5kZZmQ7KVwp7Zg7uyf1QGn3/6rl
	e38rzhesm3Zn9t+6jZMWtMkwtnzWudgsIPLf62GYwKJsoaupLKtjrl8Q3tagrrVi4/U5RcvL
	g/YUycS7/7u0MHJN9o0fkuItj6JO3an5Zu3y2aIlUv5P2emiyN1G6T+UWIozEg21mIuKEwEx
	fJ8y0wIAAA==
X-CMS-MailID: 20240701025614epcas2p16db7bb7616cf8be284034ae7fb35275d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240701025614epcas2p16db7bb7616cf8be284034ae7fb35275d
References: <CGME20240701025614epcas2p16db7bb7616cf8be284034ae7fb35275d@epcas2p1.samsung.com>

The high 32 bits is filled with arbitrary value. If hint is set
WRITE_LIFE_SHORT (2) by fcntl, the value is 0xf6d1374000000002,
which causes rw_hint_valid always returns false. i_write_hint of inode and
bi_write_hint of bio are both enum rw_hint. The value would be truncated
only if the element value exceeds 2^32.

Signed-off-by: Hui Qi <hui81.qi@samsung.com>
---
 fs/fcntl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 300e5d9ad913..bab45c5586c6 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -269,7 +269,7 @@ static int f_getowner_uids(struct file *filp, unsigned long arg)
 }
 #endif
 
-static bool rw_hint_valid(u64 hint)
+static bool rw_hint_valid(enum rw_hint hint)
 {
 	BUILD_BUG_ON(WRITE_LIFE_NOT_SET != RWH_WRITE_LIFE_NOT_SET);
 	BUILD_BUG_ON(WRITE_LIFE_NONE != RWH_WRITE_LIFE_NONE);
@@ -295,8 +295,8 @@ static long fcntl_get_rw_hint(struct file *file, unsigned int cmd,
 			      unsigned long arg)
 {
 	struct inode *inode = file_inode(file);
-	u64 __user *argp = (u64 __user *)arg;
-	u64 hint = READ_ONCE(inode->i_write_hint);
+	enum rw_hint __user *argp = (enum rw_hint __user *)arg;
+	enum rw_hint hint = READ_ONCE(inode->i_write_hint);
 
 	if (copy_to_user(argp, &hint, sizeof(*argp)))
 		return -EFAULT;
@@ -307,8 +307,8 @@ static long fcntl_set_rw_hint(struct file *file, unsigned int cmd,
 			      unsigned long arg)
 {
 	struct inode *inode = file_inode(file);
-	u64 __user *argp = (u64 __user *)arg;
-	u64 hint;
+	enum rw_hint __user *argp = (enum rw_hint __user *)arg;
+	enum rw_hint hint;
 
 	if (copy_from_user(&hint, argp, sizeof(hint)))
 		return -EFAULT;
-- 
2.34.1


