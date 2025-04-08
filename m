Return-Path: <linux-fsdevel+bounces-45986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59469A80BEE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 15:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BD811BC32CA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 13:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F02227E96;
	Tue,  8 Apr 2025 13:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FQ2AnxcO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7238226548
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Apr 2025 13:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744117921; cv=none; b=evILdJ9XCS/rS6mHLq5n4p6zmonfx8Q5mKxJgDZSmsXqfnDw1eclPNf9K/sO3uaNSgE0XGOMunBPYMilxqPsExzCnNw64qvwNzH1HNFxOO84AlfYPqTacSOEqXSuFeIwu40pnvGyEDrSWrU/p+Se/Iby7O9j1CHOOGaQlasnzUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744117921; c=relaxed/simple;
	bh=y5PBEcHtoKRAjIKMcCw4vFbETq+E/6uta6ffiRCS7Ew=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=dpjmrCYBW2QoKUsynR9sXrVhLDyCoSwilBrdeCUF8KtCN5kIpvdZI5VrZenCMsPH2xbKagNoE+EK4L93siJnNk4eILhjP2b6FS4fG+z7yY6kqIdP6qaPvhggkghb/ABBT6xyF++ffcxrlylGanSbqWWBV6fX45BwFj/zbgg+fY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=FQ2AnxcO; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250408131155epoutp04e06529da5452bf786278628be6941e86~0WgDzXMV31305613056epoutp04G
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Apr 2025 13:11:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250408131155epoutp04e06529da5452bf786278628be6941e86~0WgDzXMV31305613056epoutp04G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1744117915;
	bh=UpfyEqcbyWYNvj+IMLEyTAQFHr3NXL7nlnPV5XPxuFc=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=FQ2AnxcOql+tqzfam9vPPLFZ/XCnFjd2fjgfYgEBxsM1SIhHZdueZWoyYUSxMwr8b
	 4VtsoJ0wUpxsywtOuMhvG5U86ebs+vlwIm3tVWfp8hGgyS8PzJ9rYTa6LrHMEIgYda
	 8BVKwlmKrQmqcikeEKXWk4I7oeTU1BBqr+8WWXmc=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas1p2.samsung.com (KnoxPortal) with ESMTPS id
	20250408131154epcas1p2f53c808216ea8bf2e3efb2bd64a857a3~0WgC8slU-0624206242epcas1p2y;
	Tue,  8 Apr 2025 13:11:54 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.223]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4ZX6165nb9z6B9m4; Tue,  8 Apr
	2025 13:11:54 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
	epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
	03.58.10191.A9025F76; Tue,  8 Apr 2025 22:11:54 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250408131153epcas1p1bb1c8d060037bd37ab623348a210db80~0WgBi8iL51807118071epcas1p1i;
	Tue,  8 Apr 2025 13:11:53 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250408131153epsmtrp26b03680167f30fb304810f06e6523a3b~0WgBiLyDL0774107741epsmtrp2v;
	Tue,  8 Apr 2025 13:11:53 +0000 (GMT)
X-AuditID: b6c32a39-42cce700000027cf-3c-67f5209adbe0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	03.75.08805.99025F76; Tue,  8 Apr 2025 22:11:53 +0900 (KST)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250408131153epsmtip1bdfe66dbabdd2bdba2aa9c6d45b367e5~0WgBS5bma1049710497epsmtip1Q;
	Tue,  8 Apr 2025 13:11:53 +0000 (GMT)
From: "Sungjong Seo" <sj1557.seo@samsung.com>
To: "'Jan Kara'" <jack@suse.cz>, "'Phillip Lougher'"
	<phillip@squashfs.org.uk>
Cc: "'Andreas Gruenbacher'" <agruenba@redhat.com>, "'Namjae Jeon'"
	<linkinjeon@kernel.org>, "'OGAWA Hirofumi'" <hirofumi@mail.parknet.co.jp>,
	"'Carlos Maiolino'" <cem@kernel.org>, "'Darrick J. Wong'"
	<djwong@kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "'Luis	Chamberlain'" <mcgrof@kernel.org>,
	<sjdev.seo@gmail.com>, <sj1557.seo@samsung.com>, <cpgs@samsung.com>
In-Reply-To: <ormbk7uxe7v4givkz6ylo46aacfbrcy5zbasmti5tsqcirgijs@ulgt66vb2wbg>
Subject: RE: Recent changes mean sb_min_blocksize() can now fail
Date: Tue, 8 Apr 2025 22:11:53 +0900
Message-ID: <dd0001dba887$cbe78280$63b68780$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJRCaHaogomL6hlNxnS1IqQdP5a5wHHr4YsAptGYzWyi+DQkA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnl+LIzCtJLcpLzFFi42LZdljTQHeWwtd0g3lzNS22rdvNbrHv0lRG
	i5eHNC0uP+GzmD53A4vF7OnNTBYTpy1lttiz9ySLxeVdc9gsbkx4ymhxtGczm8WWf0dYLV58
	2MDmwOuxc9Zddo9NqzrZPO6/TfR4v+8qm0ffllWMHlO+Pmf2OLPgCLvH501yARxRDYw2iUXJ
	GZllqQqpecn5KZl56bZKoSFuuhZKChn5xSW2StGGhkZ6hgbmekZGRnqmRrFWRqZKCnmJuam2
	ShW6UL1KCkXJBUC1uZXFQANyUvWg4nrFqXkpDln5pSBf6hUn5haX5qXrJefnKimUJeaUAo1Q
	0k/4xpjx7NFm5oLv7BW/Hj5ka2Ccx9bFyMkhIWAicXzZa+YuRi4OIYEdjBK7TmxgB0kICXxi
	lLjSnwWR+MYocXfuRVaYjj3XHrJCJPYySkx7tQnKecko8evkPrC5bAK6Ek9u/GQGsUUEAiQ6
	Oz+xgBQxC0xllni9bh7YDk4BP4n5Pw6CjRUWcJBYuuIjWJxFQEVi8vXvYIN4BSwlHm15xQJh
	C0qcnPkEzGYWkJfY/nYOM8RJChK7Px1lhVjmJLHo2GJmiBoRidmdbWDPSQjc4JA4dfM50FAO
	IMdF4uUfF4heYYlXx7ewQ9hSEp/f7WWDqO9mlDj+8R0LRGIGo8SSDgcI216iubUZbA6zgKbE
	+l36ELv4JN597YEGEa9Ew8bfUDMFJU5f62aGWMsr0dEmBBFWkfj+YSfLBEblWUg+m4Xks1lI
	PpiFsGwBI8sqRrHUguLc9NRiwwJT5AjfxAhO41qWOxinv/2gd4iRiYPxEKMEB7OSCO/biV/S
	hXhTEiurUovy44tKc1KLDzEmA8N6IrOUaHI+MJPklcQbmplZWlgamRgamxkaEhY2sTQwMTMy
	sTC2NDZTEufd8/FpupBAemJJanZqakFqEcwWJg5OqQYmc0urT2oyD952xGSenvFFq2C/TizP
	z1vPw+Nq805zBktMefI4vMJw/rXfQjaaCS9vr+DjVu1+3HbWcs8p61ZG+4wz73olo0xKOO7p
	HDrS9UopWshTNHryrbvi7X6rnnX4a19dmKwzVybs5/P85coVL+d3rw/ad8hQqLR0eraG+3TX
	/kta4X+OORdWiXHHW91uC/9w1Zav9lCo+eLqkoeyV806tbT1zjA8txJfE8L+4ZTCa03ZjsMv
	0k3WfJRZLOVRqVjL0aArqPlU8NnlmFdfPnwI+O3MwpWmftxF+V1z0F293EVch7taXITPzTOZ
	fUypabnixGSNTGUvZR5Ju+0vzrAFKTB3z2999myenBJLcUaioRZzUXEiADkpFEmaBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsWy7bCSnO5Mha/pBg/f81tsW7eb3WLfpamM
	Fi8PaVpcfsJnMX3uBhaL2dObmSwmTlvKbLFn70kWi8u75rBZ3JjwlNHiaM9mNost/46wWrz4
	sIHNgddj56y77B6bVnWyedx/m+jxft9VNo++LasYPaZ8fc7scWbBEXaPz5vkAjiiuGxSUnMy
	y1KL9O0SuDKePdrMXPCdveLXw4dsDYzz2LoYOTkkBEwk9lx7yApiCwnsZpSYddCli5EDKC4l
	cXCfJoQpLHH4cHEXIxdQxXNGicmHZzKDlLMJ6Eo8ufETzBYRCJBYuewaO0gRs8B8ZokTEzqY
	IWZeY5Q4sTYGxOYU8JOY/+Mg2C5hAQeJpSs+soPYLAIqEpOvfwe7h1fAUuLRllcsELagxMmZ
	T8BsZgE9ifXr5zBC2PIS29/OYYa4X0Fi96ejrBBHOEksOraYGaJGRGJ2ZxvzBEbhWUhGzUIy
	ahaSUbOQtCxgZFnFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREcn1paOxj3rPqgd4iR
	iYPxEKMEB7OSCO/biV/ShXhTEiurUovy44tKc1KLDzFKc7AoifN+e92bIiSQnliSmp2aWpBa
	BJNl4uCUamAKmbviu8wCthwLE27zmVfqNj1hmWaeIJgvktqgIHlNu/krf3ypIG/GVn3RjxPY
	/l5cE7ix6bp3tZlLpguTcYiW7ZQHsxvDDf/ET7328HR4xLw53l4/o+P2Bx1TOzMn4cKLKoYL
	6y64sO5kWz6hXrulsELEkNUjXnOSz82bk1Z1mpatZWG1nWCXGS4Yp/ugi/GYx+mZGptmCplM
	4Us26/7ffUNYc5rVmcMHE85/4/dwfvk+yegQ1x4z++r3clErWZ6uqdvEFTsvfbnG/+Cjk7Pv
	91pciDtk/Gq7AWegkNThKu4VC78Ku83ZcKhHbv26acfavT6v3bS/UCRTp+vR1aenH3XMvJfd
	7nW88VeoipUSS3FGoqEWc1FxIgD8sJNRPgMAAA==
X-CMS-MailID: 20250408131153epcas1p1bb1c8d060037bd37ab623348a210db80
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
X-ArchiveUser: EV
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250408104502epcas1p1bd964ac9143218dace05538507ef8c6b
References: <86290c9b-ba40-4ebd-96c1-d3a258abe9d4@squashfs.org.uk>
	<CGME20250408104502epcas1p1bd964ac9143218dace05538507ef8c6b@epcas1p1.samsung.com>
	<ormbk7uxe7v4givkz6ylo46aacfbrcy5zbasmti5tsqcirgijs@ulgt66vb2wbg>

Hi, All

> Hi!
> 
> On Tue 08-04-25 06:33:53, Phillip Lougher wrote:
> > A recent (post 6.14) change to the kernel means sb_min_blocksize() can
> now fail,
> > and any filesystem which doesn't check the result may behave
> unexpectedly as a
> > result.  This change has recently affected Squashfs, and checking the
> kernel code,
> > a number of other filesystems including isofs, gfs2, exfat, fat and xfs
> do not
> > check the result.  This is a courtesy email to warn others of this
> change.
> >
> > The following emails give the relevant details.
> >
> > https://lore.kernel.org/all/2a13ea1c-08df-4807-83d4-
> 241831b7a2ec@squashfs.org.uk/
> > https://lore.kernel.org/all/129d4f39-6922-44e9-8b1c-
> 6455ee564dda@squashfs.org.uk/
> 
> Indeed. Thanks for the heads up!
> 
> 								Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

exfat-fs calls it to set it to the minimum value of 512, but it's not
particularly problematic if it fails.

Thank you
B.R.
Sungjong Seo


