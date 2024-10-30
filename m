Return-Path: <linux-fsdevel+bounces-33284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5319B6BC0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 19:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03253B20D31
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 18:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56041CF5C5;
	Wed, 30 Oct 2024 18:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="c0a6J53k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D60D1CCB4A
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 18:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730311816; cv=none; b=QqXZcGLryV6elV5ptzQ6Fwsoz6Aq2BKZL3ilu/MWL7yff5yIiQzbulS1ExOSs+TB7RycHOjIJjD7hjriUO6u25jZEsxv2ARALlrisKpNMKRdCMrHBbkWbXbTWMw8OOKt4OInBNz33qqtQUt/QQW6u82MQlTgzrHu23+oG1sMo3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730311816; c=relaxed/simple;
	bh=hG8FiFxjxXyHm56h0ScdIRfLd6/tK9OnEVj8jZ9gfhM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=TyIgXedqGB4qaaPaO48IZewsbS12/MJ8NQ7/RIbJJ4B5Qzdwxg13Ntp+NMg4gLZZVP5hfX6USF07dhEa0sWo3H8ZKPCYzwuMUgqIypoWKDk3O3/eGEvaqQRleoKJtmEJtEnuh4ogmRK1p4lEa1zxUEipiC1wNfIStG+D9hQlmqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=c0a6J53k; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20241030181010epoutp02cf78149d930e14689cd0c1f7c84d8be3~DTWyrAkda2034620346epoutp02W
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 18:10:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20241030181010epoutp02cf78149d930e14689cd0c1f7c84d8be3~DTWyrAkda2034620346epoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730311811;
	bh=FoqnIJwb0Z3BnzujRfjpSNb42rOvps9u7WH0JkZKm6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c0a6J53kQrvpkw4H3N36rP6hx2PHTDRbkQbDWb8ahLiNn6psOcWc1KKHK/HDzBgwg
	 BlVlu/Mxx8Zf+52Kk40DP16UMI0u4yI6BHJM71Wc6w32mX2SLqikE7a2a07MyZwm6O
	 kySpznkTwkvUj6TUNFxSkUAT3E8lSJ1hV6qTyG5A=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20241030181010epcas5p4abd6dbdfe08bded4bc46cd5a8c29a441~DTWx4z0jp0638906389epcas5p49;
	Wed, 30 Oct 2024 18:10:10 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4XdwC46dSXz4x9Pq; Wed, 30 Oct
	2024 18:10:08 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	07.ED.08574.08672276; Thu, 31 Oct 2024 03:10:08 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20241030181008epcas5p333603fdbf3afb60947d3fc51138d11bf~DTWwVJnWa1475114751epcas5p3f;
	Wed, 30 Oct 2024 18:10:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241030181008epsmtrp2606d4ffa7080df4891ded85dec9cad92~DTWwP4H8P1079210792epsmtrp2G;
	Wed, 30 Oct 2024 18:10:08 +0000 (GMT)
X-AuditID: b6c32a44-93ffa7000000217e-e9-67227680801c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	AB.78.08229.08672276; Thu, 31 Oct 2024 03:10:08 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241030181005epsmtip267b17ad271ee69c5084ac7f152967aaf~DTWt2IfN90238402384epsmtip2p;
	Wed, 30 Oct 2024 18:10:05 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz
Cc: linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com, vishak.g@samsung.com,
	anuj1072538@gmail.com, Anuj Gupta <anuj20.g@samsung.com>, Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [PATCH v6 04/10] fs, iov_iter: define meta io descriptor
Date: Wed, 30 Oct 2024 23:31:06 +0530
Message-Id: <20241030180112.4635-5-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241030180112.4635-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLJsWRmVeSWpSXmKPExsWy7bCmhm5DmVK6wbmF+hYfv/5msWia8JfZ
	Ys6qbYwWq+/2s1m8PvyJ0eLmgZ1MFitXH2WyeNd6jsVi9vRmJouj/9+yWUw6dI3RYu8tbYs9
	e0+yWMxf9pTdovv6DjaL5cf/MVmc/3uc1eL8rDnsDkIeO2fdZfe4fLbUY9OqTjaPzUvqPXbf
	bGDz+Pj0FotH35ZVjB5nFhxh9/i8Sc5j05O3TAFcUdk2GamJKalFCql5yfkpmXnptkrewfHO
	8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUA/KSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0ts
	lVILUnIKTAr0ihNzi0vz0vXyUkusDA0MjEyBChOyM3YeWMdacIm34tWa30wNjNO5uxg5OCQE
	TCQeN5R1MXJyCAnsZpR4cs60i5ELyP7EKHF+yy9WCOcbo8T37/9YQapAGmZ8esAGkdjLKPH6
	xwxmCOczo8TyVVvZQMayCWhKXJhcCtIgIrCUUWLl9WiQGmaB5UwS79ZPYQSpERZwlPh0Xh+k
	hkVAVaLn32EWEJtXwFzi/sPZTBDL5CVmXvrODmJzClhIfNhxE6pGUOLkzCdgNjNQTfPW2WA3
	SAg84JBYuvgfC0Szi0Tv1BmMELawxKvjW9ghbCmJz+/2skHY2RIPHj2Aqq+R2LG5D+pLe4mG
	PzdYQe5kBvpl/S59iF18Er2/nzBBQo5XoqNNCKJaUeLepKdQneISD2csYYUo8ZCYu7kSEjrd
	jBIfTi5nn8AoPwvJB7OQfDALYdkCRuZVjJKpBcW56anJpgWGeanl8FhNzs/dxAhO11ouOxhv
	zP+nd4iRiYPxEKMEB7OSCK9lkGK6EG9KYmVValF+fFFpTmrxIUZTYBBPZJYSTc4HZoy8knhD
	E0sDEzMzMxNLYzNDJXHe161zU4QE0hNLUrNTUwtSi2D6mDg4pRqY7nrN3LRfcdqU9K/rF2wW
	KV59YkvJ9I8tDmySvJEzlWpYFhdzHz394tGfxboz1k2dbS1y9MdjB9svasWaTTdP9ntPlQuv
	5FzVdNW33r5PbbfLv6COA57Su05tlr3iUxzL/vkO+91zDG/PL64XE1N8eufzAtX3EnzHviVb
	VFzfPEnk9/878ZdvVtyu3JTT/r1mga21VcXVb3791w84Lwllq/lhenuXfs/yG1Pv3pn05rn9
	vjmepR3+gS+c9fieGUVe0zi6ddmakpk3+BSqz+tXGs46dbXsvtJHPZnfyXdnuP02eLw0h7XI
	KZVh2cvvL9W39W3U3LVLaGu//+7SV3svq2zb41Bu5vhbUmrSArtfiq5KLMUZiYZazEXFiQBf
	/ecGYAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMIsWRmVeSWpSXmKPExsWy7bCSvG5DmVK6wfvtghYfv/5msWia8JfZ
	Ys6qbYwWq+/2s1m8PvyJ0eLmgZ1MFitXH2WyeNd6jsVi9vRmJouj/9+yWUw6dI3RYu8tbYs9
	e0+yWMxf9pTdovv6DjaL5cf/MVmc/3uc1eL8rDnsDkIeO2fdZfe4fLbUY9OqTjaPzUvqPXbf
	bGDz+Pj0FotH35ZVjB5nFhxh9/i8Sc5j05O3TAFcUVw2Kak5mWWpRfp2CVwZOw+sYy24xFvx
	as1vpgbG6dxdjJwcEgImEjM+PWDrYuTiEBLYzSix4MM7NoiEuETztR/sELawxMp/z8FsIYGP
	jBIPPnl1MXJwsAloSlyYXArSKyKwnlHi7N4JLCAOs8BGJokpG88xghQJCzhKfDqvD9LLIqAq
	0fPvMAuIzStgLnH/4WwmiPnyEjMvfQebzylgIfFhx00WiF3mEtcXnmGHqBeUODnzCVicGai+
	eets5gmMArOQpGYhSS1gZFrFKJlaUJybnltsWGCYl1quV5yYW1yal66XnJ+7iREcb1qaOxi3
	r/qgd4iRiYPxEKMEB7OSCK9lkGK6EG9KYmVValF+fFFpTmrxIUZpDhYlcV7xF70pQgLpiSWp
	2ampBalFMFkmDk6pBqajO/kY6lWvq+zc2Vbtwsg8J9qxOKeCc/WbpGkPHPXvtPR/qr8UJm6b
	ui/ZzmsrE8/HVaWS2xY8+y7SOr3orYpm6I7nrxd2P9C8yq5nsFtfciqnzanpjzbITWOq3Ldn
	3uG8MvNpn6OPMlkzJBS9eS50ielPp5Sp39Sv9//NmRYVHZ+fLbrcdTH380y5aJMXZjv2Hlrt
	spRBMW3upimc2gHcxf613YuFrv20Ppv0s+ysyZ42g01+d/ZfupXePbe/JGH9rn2v2WMN7MJ2
	JU9aV+YqoitxxnPqeavLNX8lO48y/M1lW3VnTvNW5sz0+SIRz+1nrnL69PfHlb/bXi1UrH3/
	ZJd/jPKhh9wbJa5du/NOiaU4I9FQi7moOBEAYQnKiyYDAAA=
X-CMS-MailID: 20241030181008epcas5p333603fdbf3afb60947d3fc51138d11bf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241030181008epcas5p333603fdbf3afb60947d3fc51138d11bf
References: <20241030180112.4635-1-joshi.k@samsung.com>
	<CGME20241030181008epcas5p333603fdbf3afb60947d3fc51138d11bf@epcas5p3.samsung.com>

From: Anuj Gupta <anuj20.g@samsung.com>

Add flags to describe checks for integrity meta buffer. Also, introduce
a  new 'uio_meta' structure that upper layer can use to pass the
meta/integrity information.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 include/linux/uio.h     | 9 +++++++++
 include/uapi/linux/fs.h | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 853f9de5aa05..8ada84e85447 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -82,6 +82,15 @@ struct iov_iter {
 	};
 };
 
+typedef __u16 uio_meta_flags_t;
+
+struct uio_meta {
+	uio_meta_flags_t	flags;
+	u16			app_tag;
+	u64			seed;
+	struct iov_iter		iter;
+};
+
 static inline const struct iovec *iter_iov(const struct iov_iter *iter)
 {
 	if (iter->iter_type == ITER_UBUF)
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 753971770733..9070ef19f0a3 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -40,6 +40,15 @@
 #define BLOCK_SIZE_BITS 10
 #define BLOCK_SIZE (1<<BLOCK_SIZE_BITS)
 
+/* flags for integrity meta */
+#define IO_INTEGRITY_CHK_GUARD		(1U << 0) /* enforce guard check */
+#define IO_INTEGRITY_CHK_REFTAG		(1U << 1) /* enforce ref check */
+#define IO_INTEGRITY_CHK_APPTAG		(1U << 2) /* enforce app check */
+
+#define IO_INTEGRITY_VALID_FLAGS (IO_INTEGRITY_CHK_GUARD | \
+				  IO_INTEGRITY_CHK_REFTAG | \
+				  IO_INTEGRITY_CHK_APPTAG)
+
 #define SEEK_SET	0	/* seek relative to beginning of file */
 #define SEEK_CUR	1	/* seek relative to current file position */
 #define SEEK_END	2	/* seek relative to end of file */
-- 
2.25.1


