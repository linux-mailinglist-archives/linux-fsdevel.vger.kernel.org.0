Return-Path: <linux-fsdevel+bounces-24176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C9A93ACE6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 09:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20E42B21791
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2024 07:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E9D61FD4;
	Wed, 24 Jul 2024 07:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mOx8n5Xi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A574C84
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jul 2024 07:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721804599; cv=none; b=Fuu9fvLaSsCWS/aRBeQFO0irRZgPX89T+H6kXc6NcP3tdWNwhldUjKFnLLbK0PO/KDKQNd+J0gL2XeRdvvZZUs7f/U7Wths2O3IyLcnmwtfvhfZphvA6UnaFIYvVxdxyA0NrCw/BTWIb3sUbyL06nQ49ri0kGEzD1pb5UHpoLuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721804599; c=relaxed/simple;
	bh=Hj209A7eRQJgJxq3hWOX/xGIK42kabAlIa1lGJ/kI0c=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=EiS2iQotaMkP5KTBahLXvM6fee0gCH4rpYogTWpgTbsQTWuvHBLhZQvr/7Adm605qPy/c/V42wQhd1zmcCCXZg5A79Zwq818Ko4E5ZKhs9V3ub1vjGYEnT4yyIxbFD60MQFSYsPJFHhq6myTaSs4YsTGF3DSJfgQbaShEDZor2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=mOx8n5Xi; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240724070308epoutp04b0575269d097cba3ce7be1742a9e33d6~lFCaHfhdH2993629936epoutp04D
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jul 2024 07:03:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240724070308epoutp04b0575269d097cba3ce7be1742a9e33d6~lFCaHfhdH2993629936epoutp04D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1721804588;
	bh=3a9qh6TR51uNp+W9iz5lZhu3x4cY5+clZCiTLup+j3s=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=mOx8n5XiGlhdq+NqZQFft8XBmEpHOegJbCEsyP5gZiT2afdKDF4LtPC+8H1JwUvWT
	 2ADfsZjwBSvbWavrapGYRhtxFAFbg34E35Fs1lTTxG4a/ZISpP9mQcgWQtw4fiH2xV
	 iOauWpgIK0lB6JLE1ulU7vDbnSiim8pSI6xStK9w=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240724070307epcas1p14ac77e3652d645df7ba3aa35dbacdf06~lFCZovWsz1537715377epcas1p1o;
	Wed, 24 Jul 2024 07:03:07 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.223]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4WTQ2g2prFz4x9QH; Wed, 24 Jul
	2024 07:03:07 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	30.9E.08992.B27A0A66; Wed, 24 Jul 2024 16:03:07 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240724070307epcas1p2a7dea311f215b5ca2cbfae4676d99e01~lFCY_cCAN0784807848epcas1p2E;
	Wed, 24 Jul 2024 07:03:07 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240724070307epsmtrp2963f167a3581266bcff7a09ea12a4b17~lFCY9r-Pd0749007490epsmtrp2s;
	Wed, 24 Jul 2024 07:03:07 +0000 (GMT)
X-AuditID: b6c32a33-96dfa70000002320-f6-66a0a72b1952
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2B.46.08456.A27A0A66; Wed, 24 Jul 2024 16:03:06 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240724070306epsmtip1991d52a298003d906955935760b14b0a~lFCYwHY6c1045610456epsmtip1i;
	Wed, 24 Jul 2024 07:03:06 +0000 (GMT)
From: "Sungjong Seo" <sj1557.seo@samsung.com>
To: "'Dongliang Cui'" <dongliang.cui@unisoc.com>, <linkinjeon@kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <niuzhiguo84@gmail.com>, <hao_hao.wang@unisoc.com>,
	<ke.wang@unisoc.com>, <cuidongliang390@gmail.com>, "'Zhiguo Niu'"
	<zhiguo.niu@unisoc.com>, <sj1557.seo@samsung.com>
In-Reply-To: <20240723105412.3615926-1-dongliang.cui@unisoc.com>
Subject: RE: [PATCH v2] exfat: check disk status during buffer write
Date: Wed, 24 Jul 2024 16:03:06 +0900
Message-ID: <1625601dadd97$88eca020$9ac5e060$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQGzaQBfv4s+oykJFwGd5ZaoFrNFNAItpdPUskLqrBA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDJsWRmVeSWpSXmKPExsWy7bCmga728gVpBkvWCFlM/HGF1eLl5rfM
	FvM/P2GzeLTnHpPFxGlLmS327D3JYnF51xw2i9cHHjJbbPl3hNVi6tNjrA5cHjtn3WX32LSq
	k82jb8sqRo/D7WfZPT5vkgtgjWpgtEksSs7ILEtVSM1Lzk/JzEu3VQoNcdO1UFLIyC8usVWK
	NjQ00jM0MNczMjLSMzWKtTIyVVLIS8xNtVWq0IXqVVIoSi4Aqs2tLAYakJOqBxXXK07NS3HI
	yi8FeUWvODG3uDQvXS85P1dJoSwxpxRohJJ+wjfGjKsfDQueiFe8uNrJ3MDYJNzFyMkhIWAi
	sePjRpYuRi4OIYEdjBJd788wQjifGCUmNG1nhnC+MUp09+5mgWk5/+kvK0RiL6PEk99drCAJ
	IYGXjBItd/xBbDYBXYknN36CdYsI9DBKPGjeBOYwC6xnlPj3dQE7SBWngIPEi9+X2LoYOTiE
	BVwk/n00BwmzCKhKnNw6hRnE5hWwkrh/9RgbhC0ocXLmE7ArmAXkJba/ncMMcZGCxO5PR8GO
	EAGqnz75ITtEjYjE7M42sL0SAms5JNa3bWKEaHCRWHh6HiuELSzx6vgWdghbSuLzu71sEA3d
	jBLHP76D+nkGo8SSDgcI216iubUZ7GhmAU2J9bv0IZbxSbz72gM1U1Di9LVuZpASCQFeiY42
	IYiwisT3DztZYFZd+XGVaQKj0iwkr81C8tosJC/MQli2gJFlFaNYakFxbnpqsmGBIXKEb2IE
	J2Qt4x2Ml+f/0zvEyMTBeIhRgoNZSYT3yau5aUK8KYmVValF+fFFpTmpxYcYk4GBPZFZSjQ5
	H5gT8kriDc3MLC0sjUwMjc0MDQkLm1gamJgZmVgYWxqbKYnznrlSliokkJ5YkpqdmlqQWgSz
	hYmDU6qByTWkV9qO98aDN4lpc5O89x1ZlaX+sdEn0CDnqfm0/6oG03Zfbv2+dUcqm8LsGepX
	5ynyhDYV6X6wvnvtuem+73un99f/+yj8lNPg/AK5guCNZ6c4VSX0Pdn8K0S243Hw9/tW7jfk
	33zdsCg8b7fGUU91praImx3Vmo+WaE9+p+HAfWjai4Wi7fu3R/86fHCrQ83Wt5IX58Ql7F7Z
	YvOEd3n4tXcNX0M53J+vnPz31AKx+wfcU8/sY5v/8JpdQvX/mpN6Z9pWCDYU6gTxs//a9vbS
	3BmPJkh3hDz3eNN7ubHmgorkE95HOcbLsm781n31yniDgd7m78ElAV/mXt1ye7LE8bpje7kT
	RI9eKr84aWurEktxRqKhFnNRcSIA26EG6H8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZdlhJTldr+YI0gzunzSwm/rjCavFy81tm
	i/mfn7BZPNpzj8li4rSlzBZ79p5ksbi8aw6bxesDD5kttvw7wmox9ekxVgcuj52z7rJ7bFrV
	yebRt2UVo8fh9rPsHp83yQWwRnHZpKTmZJalFunbJXBlXP1oWPBEvOLF1U7mBsYm4S5GTg4J
	AROJ85/+soLYQgK7GSV+LFfqYuQAiktJHNynCWEKSxw+XNzFyAVU8ZxRYtOVJewg5WwCuhJP
	bvxkBkmICExglDi//BEzSIJZYCujxLxZnBAdExkl7rx4BZbgFHCQePH7EhvIVGEBF4l/H81B
	wiwCqhInt04BK+EVsJK4f/UYG4QtKHFy5hMWkHJmAT2Jto2MEOPlJba/ncMMcb6CxO5PR8HO
	FwFqnT75ITtEjYjE7M425gmMwrOQTJqFMGkWkkmzkHQsYGRZxSiZWlCcm55bbFhglJdarlec
	mFtcmpeul5yfu4kRHGNaWjsY96z6oHeIkYmD8RCjBAezkgjvk1dz04R4UxIrq1KL8uOLSnNS
	iw8xSnOwKInzfnvdmyIkkJ5YkpqdmlqQWgSTZeLglGpgurRyTaK6qAz3X8v0fVWcgg/tDJgE
	uErnvpxsG1+eZHTuc/L8ujZf2YJZ57gmTYraY9bndHrhrILpkuUKitvfbVvS4OjOKPO3rqgo
	nKvskVZeu90u3cKD7lMOntmqefmOhybzaV3/aI9nD6X/6N0r3K3zxn/lYSuZaQbZU06bucVb
	ztCSvFH56epil6dCR/deiRDfNqf9p+HlKdXr9C+9TGU8Xa/4UXulyPHmV8W5B18qZ0ldmdRb
	3HjzpBKXTR7vrB9xRxYHBjZMv5EZHaP/Wf/ucvdwln+xHVxXGz2V3m5dZHTo7unZJ6wuVUy1
	a5zQEtORnLzVJMXgy+uFTdMXdIWLaFc9tlR/FNw4g6VViaU4I9FQi7moOBEAqt3phyADAAA=
X-CMS-MailID: 20240724070307epcas1p2a7dea311f215b5ca2cbfae4676d99e01
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-ArchiveUser: EV
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240723105423epcas1p4d4ee53975fbc4644e969b5c9b7514c9b
References: <CGME20240723105423epcas1p4d4ee53975fbc4644e969b5c9b7514c9b@epcas1p4.samsung.com>
	<20240723105412.3615926-1-dongliang.cui@unisoc.com>

> We found that when writing a large file through buffer write, if the
> disk is inaccessible, exFAT does not return an error normally, which
> leads to the writing process not stopping properly.
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
> The root cause of this issue is that during buffer write process,
> exFAT does not need to access the disk to look up directory entries
> or the FAT table (whereas FAT would do) every time data is written.
> Instead, exFAT simply marks the buffer as dirty and returns,
> delegating the writeback operation to the writeback process.
> 
> If the disk cannot be accessed at this time, the error will only be
> returned to the writeback process, and the original process will not
> receive the error, so it cannot be returned to the user side.
> 
> When the disk cannot be accessed normally, an error should be returned
> to stop the writing process.
> 
> Signed-off-by: Dongliang Cui <dongliang.cui@unisoc.com>
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
> Changes in v2:
>  - Refer to the block_device_ejected in ext4 for determining the
>    device status.
>  - Change the disk_check process to exfat_get_block to cover all
>    buffer write scenarios.
> ---
> ---
>  fs/exfat/inode.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
> index dd894e558c91..463cebb19852 100644
> --- a/fs/exfat/inode.c
> +++ b/fs/exfat/inode.c
> @@ -8,6 +8,7 @@
>  #include <linux/mpage.h>
>  #include <linux/bio.h>
>  #include <linux/blkdev.h>
> +#include <linux/backing-dev-defs.h>
>  #include <linux/time.h>
>  #include <linux/writeback.h>
>  #include <linux/uio.h>
> @@ -275,6 +276,13 @@ static int exfat_map_new_buffer(struct
> exfat_inode_info *ei,
>  	return 0;
>  }
> 
> +static int exfat_block_device_ejected(struct super_block *sb)
> +{
> +	struct backing_dev_info *bdi = sb->s_bdi;
> +
> +	return bdi->dev == NULL;
> +}
Have you tested with this again?

> +
>  static int exfat_get_block(struct inode *inode, sector_t iblock,
>  		struct buffer_head *bh_result, int create)
>  {
> @@ -290,6 +298,9 @@ static int exfat_get_block(struct inode *inode,
> sector_t iblock,
>  	sector_t valid_blks;
>  	loff_t pos;
> 
> +	if (exfat_block_device_ejected(sb))
This looks better than the modified location in the last patch.
However, the caller of this function may not be interested in exfat
error handling, so here we should call exfat_fs_error_ratelimit()
with an appropriate error message.

> +		return -ENODEV;
> +
>  	mutex_lock(&sbi->s_lock);
>  	last_block = EXFAT_B_TO_BLK_ROUND_UP(i_size_read(inode), sb);
>  	if (iblock >= last_block && !create)
> --
> 2.25.1



