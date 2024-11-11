Return-Path: <linux-fsdevel+bounces-34217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A43C9C3D67
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 12:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A6731F2206F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 11:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2825C15B13B;
	Mon, 11 Nov 2024 11:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PTlqdmpw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692C3139578
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 11:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731324907; cv=none; b=YlyPrNytVJYCaTI7kBto13Wsgjh+UftDWY6lB6O3lVRxG9YKe5/aLOT7Gzb9xNs+P0lQS5tefuAlxRQMR+Nzi3kSQVK9bcPe+9A/TxlBg6Kc4QQ4qj3RxNsEiSYMuqKzVW8kyhPbOqjAoaacln++BNZTaIvrXYZax3EGKs+8AkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731324907; c=relaxed/simple;
	bh=uKt/67hNTMAAYUJ9QOFvpfk+St1XCyEIESBi9KjNfso=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=l6eEn7RdRHC1GhmB48RU8VXpN083i0GOUDAbqcE/xPF1z1PQMupXm0u3uvUHluY6/v7cs7WY/M9lLZcXJyead0hTEnJNRqTvxEkLa3ksk0bwUET6HuEs9P6OriNNifcW5oIaXDOlcJSRChYntvzHB9YdNmeonrO2JHeLcQd9X10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=PTlqdmpw; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20241111113502epoutp02aa4cca5f4e5fe77256ba59f43e967d09~G5tNovNC41599415994epoutp02K
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 11:35:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20241111113502epoutp02aa4cca5f4e5fe77256ba59f43e967d09~G5tNovNC41599415994epoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1731324902;
	bh=EMGVwugpA69gYJLgTMTzPKuroXJ3DjpiP/iQYD+nqMM=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=PTlqdmpw8PFjDWilvJdSSmJ511mMHWI2ewZFFq2rmc3TbZKhfD3U3UqhDMb5Gyt8c
	 VKi4yqC0C14gmy3JwIwc7cFrdaV/eT20M1GrwW9C16SBjchXvul+fgPUXcyCbC65Nj
	 xu6go3CPz3k5kqsZU0Fg6iJMfsQwJzBXygKB6SiU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20241111113502epcas1p3b9df1262a7bcb391318ccc5496c49a31~G5tNS3yQU1239312393epcas1p3d;
	Mon, 11 Nov 2024 11:35:02 +0000 (GMT)
Received: from epcpadp1new (unknown [182.195.40.141]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Xn6sd6z47z4x9Pq; Mon, 11 Nov
	2024 11:35:01 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241111110758epcas1p2966806075b6b677dcef063cf7bf25148~G5VlG2u_Z2500625006epcas1p24;
	Mon, 11 Nov 2024 11:07:58 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241111110758epsmtrp2a72f862566d960035b42c061b11cc183~G5VlGPlZE0337003370epsmtrp2y;
	Mon, 11 Nov 2024 11:07:58 +0000 (GMT)
X-AuditID: b6c32a52-979ff700000049f9-43-6731e58e6aa2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	22.C4.18937.E85E1376; Mon, 11 Nov 2024 20:07:58 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20241111110758epsmtip2681d1699a46e776ed6a0669edc3b0254~G5Vk7dLIK0163201632epsmtip2G;
	Mon, 11 Nov 2024 11:07:58 +0000 (GMT)
From: "Sungjong Seo" <sj1557.seo@samsung.com>
To: <Yuezhang.Mo@sony.com>, <linkinjeon@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>, <Wataru.Aoyama@sony.com>,
	<sj1557.seo@samsung.com>, <cpgs@samsung.com>
In-Reply-To: <PUZPR04MB6316E3576F9431D57C9D7B3681582@PUZPR04MB6316.apcprd04.prod.outlook.com>
Subject: RE: [PATCH v2 0/6] exfat: reduce FAT chain traversal
Date: Mon, 11 Nov 2024 20:07:57 +0900
Message-ID: <1891546521.01731324901938.JavaMail.epsvc@epcpadp1new>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHUpRLFe7kluUUOIFOWdoNxaDEVxwLIg/IysqjFUHA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsWy7bCSvG7fU8N0g/8tghYvD2laTJy2lNli
	z96TLBZb/h1htfj4YDejxfU3D1kd2Dw2repk8+jbsorRo33CTmaPz5vkAliiuGxSUnMyy1KL
	9O0SuDL+zFrEUrCeo+LX9IXsDYwX2LoYOTkkBEwkvk5dy9zFyMUhJLCdUeLP+XYghwMoISVx
	cJ8mhCkscfhwMUTJc0aJOcs2M4H0sgnoSjy58ZMZxBYRMJX4cvkE2ExmgUKJc/fvsUM0rGOU
	eHxoCTtIglMgVmL7r49gtrCArUTjohawZhYBVYnLH/vAmnkFLCUufPgDZQtKnJz5hAViqLbE
	05tPoWx5ie1v5zBDPKAgsfvTUVaII6wkPr95ywhRIyIxu7ONeQKj8Cwko2YhGTULyahZSFoW
	MLKsYhRNLSjOTc9NLjDUK07MLS7NS9dLzs/dxAiOF62gHYzL1v/VO8TIxMF4iFGCg1lJhFfD
	Xz9diDclsbIqtSg/vqg0J7X4EKM0B4uSOK9yTmeKkEB6YklqdmpqQWoRTJaJg1OqgWmpc8zr
	jbODzPQlJ1wRrBDYElxR4PP8ZevMQzO1fjwzCdf6FsSXrztRgCnPIcO5qcRd4YPoc5VrUucm
	lbe+fvxryftYfbYyTR+Zk15rP7c2te4Q8Gv3sn4750DaQybtv89KFhxTmpFxc7/IrpOT5v4X
	49BruZ4ykU1+QlZV/3TX6YcilPbXqPPO3Popa5bwItNnD/64WU6+zMy26O3bOgannY66q7L2
	77jX7mUsMkOXPyjxCftUofopURp6gX+jdimx80VmOh3k5tNb4L4+yUsmJ7Dx6DvHY2u7q6Jf
	zD71cmVi3c1Zes+DQzkSJW41ty3oWWDM+sNlScatN5uVH+86ZO/+rqVafbbelJ377iuxFGck
	GmoxFxUnAgD9pab3BgMAAA==
X-CMS-MailID: 20241111110758epcas1p2966806075b6b677dcef063cf7bf25148
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
X-ArchiveUser: EV
X-Hop-Count: 3
X-CMS-RootMailID: 20241111064411epcas1p3d6b8405d13bc56afe910b94e4faf38e7
References: <CGME20241111064411epcas1p3d6b8405d13bc56afe910b94e4faf38e7@epcas1p3.samsung.com>
	<PUZPR04MB6316E3576F9431D57C9D7B3681582@PUZPR04MB6316.apcprd04.prod.outlook.com>

> This patch set is designed to reduce FAT traversal, it includes the
> patch to implement this feature as well as the patches to optimize and
> clean up the code to facilitate the implementation of this feature.
> 
> Changes for v2:
>   - [6/6] add inline descriptions for 'dir' and 'entry' in
>     'struct exfat_dir_entry' and 'struct exfat_inode_info'.

This patch-set looks nice. Thank you!
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>

> Yuezhang Mo (6):
>   exfat: remove unnecessary read entry in __exfat_rename()
>   exfat: add exfat_get_dentry_set_by_inode() helper
>   exfat: move exfat_chain_set() out of __exfat_resolve_path()
>   exfat: remove argument 'p_dir' from exfat_add_entry()
>   exfat: code cleanup for exfat_readdir()
>   exfat: reduce FAT chain traversal
> 
>  fs/exfat/dir.c      |  38 ++++-------
>  fs/exfat/exfat_fs.h |   6 ++
>  fs/exfat/inode.c    |   2 +-
>  fs/exfat/namei.c    | 155 +++++++++++++++++++-------------------------
>  4 files changed, 86 insertions(+), 115 deletions(-)
> 
> --
> 2.43.0




