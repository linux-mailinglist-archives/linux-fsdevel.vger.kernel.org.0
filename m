Return-Path: <linux-fsdevel+bounces-34008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B0B9C1C74
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 12:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A80171C22D0E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 11:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9770C1E32B3;
	Fri,  8 Nov 2024 11:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fdBO+zl3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BDC7462
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 11:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731066788; cv=none; b=irSuaY6Z5Gi6u2B/kQzDkLi74CKk8k6QQdFyfYocNhO5s/j0IobIErDoRregVVwgcMsTxGH+WFYzNYemzPuQjBvTU8Q+DVashiaAiQKY5da7aazYtWehwPgv01KVqQqOTMzpnifL1kryy3e0Fd7hvHoO9hdnOvD2xEfiExYFwFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731066788; c=relaxed/simple;
	bh=r/pQUYly2pJ8YnsK+CjQvBNrq/hkety11wAubJ3FFPI=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=gbKXT+ka4/REmHrqZ39K4cI9n8v/TW4p5CvxA0R3edoprezaPWwEQzZDNnI76GTLRDizi7p5IVlBnKqRY0SynoOLPpDHjbYXxyKLTQymN8DNCGWHt+pmbJW3J1TYEMBP3KOQTjCjaevNdnGkw5SGKiFqUctvzJeTnVE6xncOdGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=fdBO+zl3; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241108115302epoutp014250d65211e7770a416eeb48b7ca00e5~F-BErpAhB1825118251epoutp01f
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 11:53:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241108115302epoutp014250d65211e7770a416eeb48b7ca00e5~F-BErpAhB1825118251epoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1731066782;
	bh=FFtehOWDtACb8yWdEUGCVrYyxM9Rsxqi/jQIKzsK3G8=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=fdBO+zl3C8hSWTvcdrPyhforcAVW/3PiehwbENPSrmQFZNouX2GtsmuWi6zg+e/eH
	 dmFl4wDG3G72Gw35J0MbsjbhsnTjKxJ1ZHI5zgOAnNQ7xa6OiemGqnR5HEsNCDkoDn
	 qI9Y0LjbUZV3TtQ4fDKN4e42qRuUVV2uQU11DEKs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241108115302epcas1p1df378e492d4151abea2a814cf4bfa43b~F-BEbGUGY0973109731epcas1p19;
	Fri,  8 Nov 2024 11:53:02 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4XlHPp189Rz4x9Pp; Fri,  8 Nov
	2024 11:53:02 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20241108113923epcas1p3b9e16ceb73b67a96411221feee72b37b~F_1JztnoI0579405794epcas1p3s;
	Fri,  8 Nov 2024 11:39:23 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241108113923epsmtrp1d8949cbe9ee6350c2c16e4a43edf821b~F_1JzItB82889028890epsmtrp1O;
	Fri,  8 Nov 2024 11:39:23 +0000 (GMT)
X-AuditID: b6c32a52-9d9c2700000049f9-a3-672df86bdc7c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	BB.EC.18937.B68FD276; Fri,  8 Nov 2024 20:39:23 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20241108113923epsmtip2e6ee948b2aec8459a7639b52dec9ebd1~F_1JpI8H52635526355epsmtip2C;
	Fri,  8 Nov 2024 11:39:23 +0000 (GMT)
From: "Sungjong Seo" <sj1557.seo@samsung.com>
To: <Yuezhang.Mo@sony.com>, <linkinjeon@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>, <Wataru.Aoyama@sony.com>,
	<cpgs@samsung.com>, <sj1557.seo@samsung.com>
In-Reply-To: <PUZPR04MB63164B1F3E8FFEA10105095881542@PUZPR04MB6316.apcprd04.prod.outlook.com>
Subject: RE: [PATCH v1 0/6] exfat: reduce FAT chain traversal
Date: Fri, 8 Nov 2024 20:39:22 +0900
Message-ID: <1891546521.01731066782150.JavaMail.epsvc@epcpadp2new>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQI4nbmMyEWmFyUqCNhwOix127NT8gHN0m7iseP0ynA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsWy7bCSvG72D910g83f+C1eHtK0mDhtKbPF
	nr0nWSy2/DvCavHxwW5Gi+tvHrI6sHlsWtXJ5tG3ZRWjR/uEncwenzfJBbBEcdmkpOZklqUW
	6dslcGW8XHiZrWAiV8WR5beYGhg7OLoYOTkkBEwkNq/8wgxiCwlsZ5To2ZPdxcgBFJeSOLhP
	E8IUljh8uLiLkQuo4jmjxN2fW1lAytkEdCWe3PgJ1ioiYCrx5fIJNhCbWaBQom3JLGaIhnWM
	Eq8X/WcDGcQpECsx7VEgSI2wgK3E1W+NYL0sAioS9+5PBbN5BSwl7v/5wgphC0qcnPmEBWKm
	tsTTm0+hbHmJ7W/nMEOcryCx+9NRVogbrCR+NXYxQ9SISMzubGOewCg8C8moWUhGzUIyahaS
	lgWMLKsYRVMLinPTc5MLDPWKE3OLS/PS9ZLzczcxgmNFK2gH47L1f/UOMTJxMB5ilOBgVhLh
	9Y/SThfiTUmsrEotyo8vKs1JLT7EKM3BoiTOq5zTmSIkkJ5YkpqdmlqQWgSTZeLglGpgMuY5
	cJnZi4n1z9Or2/ISBVr1ffXs8s91d35yeTUrZNaSh28+yVX81N6+/VyGH8ueD1r1Um7Woevj
	W1a03VJduqjG+p7gnc5Hm/fZdy6Jm7nwwiGxF6ltlYdXdPSo+DaFL3n9+com+XtuE1s3cHoa
	PV3VuVB8xWaNvUY/7/6Tlsyw/CpnWjhLvfPFZoVpE3OMGQLmHfkm/Nhk9bng/OJVM24LtnzV
	2+51f+9mvdnr/iZnrX5S9GTp1aOnDXzKsm9v3x+YxvDw78bivUs/ZLDnHF3fqBw/Uc5q7jQB
	8xAVXVN7YdkXAj3tWcwKZpk/rI5sNfSYvGle0Xs+nt/zbvxwnJLmesTzNMvjiWGSR165PlNi
	Kc5INNRiLipOBACMiPXxBAMAAA==
X-CMS-MailID: 20241108113923epcas1p3b9e16ceb73b67a96411221feee72b37b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
X-ArchiveUser: EV
X-Hop-Count: 3
X-CMS-RootMailID: 20241030061222epcas1p27c3d41fae0ee2e8db3a5fa56fcadecb2
References: <CGME20241030061222epcas1p27c3d41fae0ee2e8db3a5fa56fcadecb2@epcas1p2.samsung.com>
	<PUZPR04MB63164B1F3E8FFEA10105095881542@PUZPR04MB6316.apcprd04.prod.outlook.com>

Hi, Yuezhang,
> This patch set is designed to reduce FAT traversal, it includes the
> patch to implement this feature as well as the patches to optimize and
> clean up the code to facilitate the implementation of this feature.
> 
> Yuezhang Mo (6):
>   exfat: remove unnecessary read entry in __exfat_rename()
>   exfat: add exfat_get_dentry_set_by_inode() helper
>   exfat: move exfat_chain_set() out of __exfat_resolve_path()
>   exfat: remove argument 'p_dir' from exfat_add_entry()
>   exfat: code cleanup for exfat_readdir()
>   exfat: reduce FAT chain traversal

You are awesome! Looks good!
It seems like a lot of inefficient code has been cleaned up overall.

BTW, only one thing about the patch 'reduce FAT chain traversal',
there may be confusion as the concepts of 'dir' and 'entry' within
'struct exfat_dir_entry' have changed from what we previously understood.

To clarify the changed concept, how about leaving an inline description
for each of 'dir' and 'entry' in 'struct exfat_dir_entry'?

> 
>  fs/exfat/dir.c      |  38 ++++-------
>  fs/exfat/exfat_fs.h |   2 +
>  fs/exfat/inode.c    |   2 +-
>  fs/exfat/namei.c    | 155 +++++++++++++++++++-------------------------
>  4 files changed, 82 insertions(+), 115 deletions(-)
> 
> --
> 2.43.0




