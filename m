Return-Path: <linux-fsdevel+bounces-23556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 079E692E2C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 10:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A9BD1C22DCD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 08:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FD3154C08;
	Thu, 11 Jul 2024 08:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FOcENf3t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20171152534
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jul 2024 08:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720688015; cv=none; b=AKdHQlyLvAMBD5fymcGjfGZYnjN98N7TdoHkK2RvMG+KhreY9bT3HmJnIprEJedJ4xPPCdYR1N7po0SbHsXEs1PXArgJzfmZHNMbq0YDmBljPG2byNnxBg+EqBaGWL2cYL5nb1uKDnmsoDOl76VrBm+hhkv/7pMtgHckv+qRvcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720688015; c=relaxed/simple;
	bh=xGG5n1lQeDs3+JsfijPpdC3i/+8zt2yDgkuSigJZuzU=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=GXcVnV+cxMCTjYu6Dwroph46d16ZGUH+LRoUa3wvG0nYGpGOad6rAaY9ps/u5+QZk8ungwsoJbw34s6T5vMwN9o/ag/IYo+f9pAKuL3o01eHxAqEC1s9cpN11derJfefZ/JzHwQLdBSMGD30EErKugsq8T/7ZmnjrYeQ78nil0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=FOcENf3t; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240711085325epoutp020490836f345c2d30db2b12ab61ba2bc1~hHJ-J40Fj0741907419epoutp02p
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jul 2024 08:53:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240711085325epoutp020490836f345c2d30db2b12ab61ba2bc1~hHJ-J40Fj0741907419epoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1720688005;
	bh=G+iH+bNNifKzGTzyhpwByRBo4Xe6Ll3424gWu5Icpmg=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=FOcENf3tsRSRbpwVGqPGF7P1HKNZEyNN3FoJeA/tKNvAm42s/m2QggQvI48Zy2TwW
	 cVNtCVFIuo+4pRm+Dactkl3NzNCKI5xGA2QdPNiz46nB0INVKR/gwJ+Jdu81VkOz3D
	 709mrLtsuz3ZEl+QzLQSzReGxjbkODw0p5nuUAzk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTP id
	20240711085324epcas1p48a245672ab6e0607e4f36ac88e0a465b~hHJ_Mxdai2448424484epcas1p46;
	Thu, 11 Jul 2024 08:53:24 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.243]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4WKT5v5w2xz4x9Px; Thu, 11 Jul
	2024 08:53:23 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	65.B7.09910.38D9F866; Thu, 11 Jul 2024 17:53:23 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240711085323epcas1p21fceadec1a5ad178ff88bc14005e8eb1~hHJ9OrPPZ1810118101epcas1p2-;
	Thu, 11 Jul 2024 08:53:23 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240711085323epsmtrp2b32000bced57386e44e13c6aa7e1cf1d~hHJ9N2d7p1185211852epsmtrp2i;
	Thu, 11 Jul 2024 08:53:23 +0000 (GMT)
X-AuditID: b6c32a38-a3fff700000226b6-5e-668f9d8373e0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	92.8A.19057.28D9F866; Thu, 11 Jul 2024 17:53:23 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240711085322epsmtip2c3ee411e640bffc3a33055c836f56e60~hHJ9A4Sy62046820468epsmtip2m;
	Thu, 11 Jul 2024 08:53:22 +0000 (GMT)
From: "Sungjong Seo" <sj1557.seo@samsung.com>
To: "'Dongliang Cui'" <dongliang.cui@unisoc.com>, <linkinjeon@kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <niuzhiguo84@gmail.com>, <hao_hao.wang@unisoc.com>,
	<ke.wang@unisoc.com>, "'Zhiguo Niu'" <zhiguo.niu@unisoc.com>,
	<sj1557.seo@samsung.com>
In-Reply-To: <20240705081514.1901580-1-dongliang.cui@unisoc.com>
Subject: RE: [PATCH] exfat: check disk status during buffer write
Date: Thu, 11 Jul 2024 17:53:22 +0900
Message-ID: <459601dad36f$c913a770$5b3af650$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQFvSNYXJxba5FWmGrAfktx9bhOlrwHMkk5tsrngrWA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJJsWRmVeSWpSXmKPExsWy7bCmgW7z3P40g5v/NSxebn7LbDH/8xM2
	i0d77jFZTJy2lNliz96TLBaXd81hs3h94CGzxZZ/R1gtpj49xurA6bFz1l12j02rOtk8+ras
	YvQ43H6W3ePzJrkA1qgGRpvEouSMzLJUhdS85PyUzLx0W6XQEDddCyWFjPziElulaENDIz1D
	A3M9IyMjPVOjWCsjUyWFvMTcVFulCl2oXiWFouQCoNrcymKgATmpelBxveLUvBSHrPxSkC/0
	ihNzi0vz0vWS83OVFMoSc0qBRijpJ3xjzDj3cR1bwTHpiod3jjE2MHaJdTFyckgImEj0X7/P
	3sXIxSEksINRomXPOSjnE6NE+6d7LBDON0aJL6eOscO0NJzfygiR2MsoceLhEyaQhJDAS0aJ
	/u05IDabgK7Ekxs/mUGKRAR6GCUeNG8Cc5gFJjFKNNyYBDaKU8BBYu7VO2C2sICjxLN/l1lA
	bBYBVYkHm2+D2bwClhKth+8yQtiCEidnPgGLMwvIS2x/O4cZ4iQFid2fjrKC2CICVhKLL26E
	qhGRmN3ZBrZYQmAth8S0L2tZIBpcJGYduwLVLCzx6vgWqN+kJD6/28sG0dDNKHH84zuohhmM
	Eks6HCBse4nm1magIg6gDZoS63fpQyzjk3j3tYcVokRQ4vS1bmaQEgkBXomONiGIsIrE9w87
	WWBWXflxlWkCo9IsJK/NQvLaLCQvzEJYtoCRZRWjWGpBcW56arFhgQlylG9iBKdiLYsdjHPf
	ftA7xMjEwXiIUYKDWUmEd/6N7jQh3pTEyqrUovz4otKc1OJDjMnAwJ7ILCWanA/MBnkl8YZm
	ZpYWlkYmhsZmhoaEhU0sDUzMjEwsjC2NzZTEec9cKUsVEkhPLEnNTk0tSC2C2cLEwSnVwBQU
	zrHhyMYnoXaz1/2LbatoOX+RR2DBngiufbz+H+S6on/vXjM1eM3kefciN8yc8zv+WfvicLXl
	CerPt329oxDL0u7CYTzp++llz+bUMG5Q3ZYpGHBi5vljC7N3vqxZFf+3oHsN1xeDdF6ZU+0T
	5auMDn2TSp46yZFlUZ3SQUG9X7+kfUTVWhi7kgy36Yp4/l7J2m+zIaFbS++aUpaO87yVTsvv
	L0gsEXiytsE55bRz1EHfTnWuAvVVsnkpiaypUvPr9OIFeCPfl+0Xuvrhxq8Q2b/zBZVXSe55
	M/Veauix9Qrel7KW72ZbrbZrzhIWwVuGnbvlt8o8j22dpSH3bO+8mbu8NJ9k2x1NKn2z/pcS
	S3FGoqEWc1FxIgB0/vkhfAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphkeLIzCtJLcpLzFFi42LZdlhJXrd5bn+aQU8vs8XLzW+ZLeZ/fsJm
	8WjPPSaLidOWMlvs2XuSxeLyrjlsFq8PPGS22PLvCKvF1KfHWB04PXbOusvusWlVJ5tH35ZV
	jB6H28+ye3zeJBfAGsVlk5Kak1mWWqRvl8CVce7jOraCY9IVD+8cY2xg7BLrYuTkkBAwkWg4
	v5Wxi5GLQ0hgN6NE8+8lrF2MHEAJKYmD+zQhTGGJw4eLIUqeM0qs/byVCaSXTUBX4smNn8wg
	CRGBCYwS55c/AnOYBaYxSjyb95ENomUio8Sy9U3sIC2cAg4Sc6/eAbOFBRwlnv27zAJiswio
	SjzYfBvM5hWwlGg9fJcRwhaUODnzCQvIGcwCehJtG8HCzALyEtvfzmGG+EBBYveno6wgtoiA
	lcTiixtZIGpEJGZ3tjFPYBSehWTSLIRJs5BMmoWkYwEjyypGydSC4tz03GLDAqO81HK94sTc
	4tK8dL3k/NxNjOAI09Lawbhn1Qe9Q4xMHIyHGCU4mJVEeOff6E4T4k1JrKxKLcqPLyrNSS0+
	xCjNwaIkzvvtdW+KkEB6YklqdmpqQWoRTJaJg1OqgenI5lnfa+Z7cpa6Nbilv/4v+ie/oiDx
	TtqVbm9bPqaLaUovJ6x1+/XvD+uarfp3X7z33TJtHW/DN4cvXuwHvlxvSzvL4jidI+6b6dKL
	c6sW74hKFi5s8r2tkPbrDK8xu87RcsOy2tl2e/Q2zdwX9+uL7I/b/Wv6Eu5+5TxkeF8nss5N
	5uKtT3dnzHVbpsX+4YO6vZ73vbjzDOH3Z/cy7c8QUxB+IqGbLP5lU1zY8Q+bHp5ZkHxI4PnL
	nbldAuxz3m/Km+EyxYbll7Xnz4Zy5+m+2TxhQj9VxU4+iTRieya8OqBjN9fBp5YPu/66Zkgy
	fNn2JZ917bWrwZUqt61ZPD/36jWpLqwK/aCj8K1V5okSS3FGoqEWc1FxIgAe++YbHwMAAA==
X-CMS-MailID: 20240711085323epcas1p21fceadec1a5ad178ff88bc14005e8eb1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-ArchiveUser: EV
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240705081528epcas1p32c38cfb39dae65109bbfbd405a9852b2
References: <CGME20240705081528epcas1p32c38cfb39dae65109bbfbd405a9852b2@epcas1p3.samsung.com>
	<20240705081514.1901580-1-dongliang.cui@unisoc.com>

> We found that when writing a large file through buffer write,
> if the disk is inaccessible, exFAT does not return an error
> normally, which leads to the writing process not stopping properly.
> 
> To easily reproduce this issue, you can follow the steps below:
> 
> 1. format a device to exFAT and then mount (with a full disk erase)
> 2. dd if=/dev/zero of=/exfat_mount/test.img bs=1M count=8192
> 3. eject the device
> 
> You may find that the dd process does not stop immediately and may
> continue for a long time.
> 
> We compared it with the FAT, where FAT would prompt an EIO error and
> immediately stop the dd operation.
> 
> The root cause of this issue is that when the exfat_inode contains the
> ALLOC_NO_FAT_CHAIN flag, exFAT does not need to access the disk to
> look up directory entries or the FAT table (whereas FAT would do)
> every time data is written. Instead, exFAT simply marks the buffer as
> dirty and returns, delegating the writeback operation to the writeback
> process.
> 
> If the disk cannot be accessed at this time, the error will only be
> returned to the writeback process, and the original process will not
> receive the error, so it cannot be returned to the user side.
> 
> Therefore, we think that when writing files with ALLOC_NO_FAT_CHAIN,
> it is necessary to continuously check the status of the disk.
> 
> When the disk cannot be accessed normally, an error should be returned
> to stop the writing process.
> 
> Signed-off-by: Dongliang Cui <dongliang.cui@unisoc.com>
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>  fs/exfat/exfat_fs.h | 5 +++++
>  fs/exfat/inode.c    | 5 +++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
> index ecc5db952deb..c5f5a7a8b672 100644
> --- a/fs/exfat/exfat_fs.h
> +++ b/fs/exfat/exfat_fs.h
> @@ -411,6 +411,11 @@ static inline unsigned int
> exfat_sector_to_cluster(struct exfat_sb_info *sbi,
>  		EXFAT_RESERVED_CLUSTERS;
>  }
> 
> +static inline bool exfat_check_disk_error(struct block_device *bdev)
> +{
> +	return blk_queue_dying(bdev_get_queue(bdev));
Why don't you check it like ext4?

static int block_device_ejected(struct super_block *sb)
{
       struct inode *bd_inode = sb->s_bdev->bd_inode;
       struct backing_dev_info *bdi = inode_to_bdi(bd_inode);

       return bdi->dev == NULL;
}
> +}
> +
>  static inline bool is_valid_cluster(struct exfat_sb_info *sbi,
>  		unsigned int clus)
>  {
> diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
> index dd894e558c91..efd02c1c83a6 100644
> --- a/fs/exfat/inode.c
> +++ b/fs/exfat/inode.c
> @@ -147,6 +147,11 @@ static int exfat_map_cluster(struct inode *inode,
> unsigned int clu_offset,
>  	*clu = last_clu = ei->start_clu;
> 
>  	if (ei->flags == ALLOC_NO_FAT_CHAIN) {
> +		if (exfat_check_disk_error(sb->s_bdev)) {
> +			exfat_fs_error(sb, "device inaccessiable!\n");
> +			return -EIO;
This patch looks useful when using removable storage devices.
BTW, in case of "ei->flags != ALLOC_NO_FAT_CHAIN", There could be
the same problem if it can be found from lru_cache. So, it would be nice
to check disk_error regardless ei->flags. Also, Calling exfat_fs_error()
seems unnecessary. Instead, let's return -ENODEV instead of -EIO.
I believe that these errors will be handled on exfat_get_block()

Thanks.
> +		}
> +
>  		if (clu_offset > 0 && *clu != EXFAT_EOF_CLUSTER) {
>  			last_clu += clu_offset - 1;
> 
> --
> 2.25.1



