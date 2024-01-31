Return-Path: <linux-fsdevel+bounces-9663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04403844276
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 16:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97A7E1F21E28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 15:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2261112F5A1;
	Wed, 31 Jan 2024 14:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aVCI7CG1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7791292E9
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 14:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712956; cv=none; b=HFCmJUx0O+fYBMDya0sbkfvXcfwda20cPQQiU9tsXtVtZmPwOq2v+TBazWPP/9+/sVB749R52+X7PPeq7Z1z4JwlWzpKx+Ls48fXDlxHydWIo53hSDJEiMuJF6eBd0RHdg2kQuMI47QXKnZlA1JdBRTh5uRzmgnhgNJMsUWdZRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712956; c=relaxed/simple;
	bh=67ZR6rJjfFoIuYxBYnYEHKapOQOodrYEnLA47JlmBtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=NxWNFa4WWcOTlXeKRhF+nJBTXodIcbzmr0XAmB1rUjVliA4vj7WRWpMtt6W6NszW2sC6IA2xAYHzvhU91VFSlvyRSPOdAnOhovtE4FuJh4aoTrKGh2VQLkdOsCw9IF1aNmeJgHB4+k3Z30T3HCI7TtYir/FMx0L8P9Cg6mRQsQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=aVCI7CG1; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240131145553epoutp04bd2cc2ac694adda51362edfe652e7b64~vdmNn8Qsj0500405004epoutp04P
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 14:55:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240131145553epoutp04bd2cc2ac694adda51362edfe652e7b64~vdmNn8Qsj0500405004epoutp04P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706712953;
	bh=67ZR6rJjfFoIuYxBYnYEHKapOQOodrYEnLA47JlmBtM=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=aVCI7CG1XgOdS+/aUrWZeY48RrxD0AthYTW8qkv2mvWXu4Y8ELRVn5Uw+INr7qFjl
	 CQ2tsM5x1uXvxoj2mrDeWvTzkct5oHgVNelSdKhKuxLIwG7qunrXVix/RPkXR5RT3l
	 9d1WzJOZcl+rKzEXygKS5hoPPFNaRziICDhN5FSw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240131145552epcas5p2c5728048da88d88cfdbfd1c640974aed~vdmNLNvc_2076120761epcas5p2G;
	Wed, 31 Jan 2024 14:55:52 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4TQ4pv0f43z4x9Pr; Wed, 31 Jan
	2024 14:55:51 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	88.1C.08567.67F5AB56; Wed, 31 Jan 2024 23:55:50 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240131145550epcas5p2153471099be52fc5ca04a5e363b90d6b~vdmLV3Pon0290802908epcas5p2w;
	Wed, 31 Jan 2024 14:55:50 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240131145550epsmtrp15e0fa89e33d45ef82340e61096577931~vdmLVP5Ke1334113341epsmtrp1L;
	Wed, 31 Jan 2024 14:55:50 +0000 (GMT)
X-AuditID: b6c32a44-617fd70000002177-5f-65ba5f76ee08
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BA.9A.07368.67F5AB56; Wed, 31 Jan 2024 23:55:50 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240131145549epsmtip2ef5da46d7d5d8f72af1ec97838df0c0c~vdmJ1yiQ70923609236epsmtip2n;
	Wed, 31 Jan 2024 14:55:48 +0000 (GMT)
Message-ID: <b552a153-1a7a-522d-de6e-df2648a4a78b@samsung.com>
Date: Wed, 31 Jan 2024 20:25:48 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v9 06/19] block, fs: Restore the per-bio/request data
 lifetime fields
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, "Martin K . Petersen"
	<martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Christoph
	Hellwig <hch@lst.de>, Daejun Park <daejun7.park@samsung.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240130214911.1863909-7-bvanassche@acm.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMJsWRmVeSWpSXmKPExsWy7bCmlm5Z/K5Ug4vfbSxW3+1ns3h9+BOj
	xbQPP5ktVj0It1i5+iiTxd5b2hZ79p5ksei+voPNYvnxf0wW5/8eZ3Xg8rh8xdvj8tlSj02r
	Otk8dt9sYPP4+PQWi0ffllWMHp83yXlsevKWKYAjKtsmIzUxJbVIITUvOT8lMy/dVsk7ON45
	3tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB+hAJYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmt
	UmpBSk6BSYFecWJucWleul5eaomVoYGBkSlQYUJ2xuyeqewFd5gqrqzoYG5gXM7UxcjJISFg
	IrH/1nzmLkYuDiGB3YwSc7fOY4dwPjFKXHjfCJX5xijx5tVEuJYfjV2sEIm9jBLHNnyDct4y
	Skz+e4kRpIpXwE6ic/4DoA4ODhYBVYk5G/QgwoISJ2c+YQGxRQWSJH5dnQNWLiwQLXF4zj2w
	OLOAuMStJ/PBlokIxEm0znrFCDKfWWAGk8S619fYQWayCWhKXJhcCmJyClhJfDlcCNEqL7H9
	7RywoyUE1nJI7Jv/lg3iaBeJX0fvsELYwhKvjm9hh7ClJF72t0HZyRKXZp6DerJE4vGeg1C2
	vUTrqX5mkF3MQGvX79KH2MUn0fv7CdiHEgK8Eh1tQhDVihL3Jj2F2iQu8XDGElaIEg+J6RMz
	4KH2+txJpgmMCrOQAmUWkudnIflmFsLiBYwsqxglUwuKc9NTk00LDPNSy+HRnZyfu4kRnHq1
	XHYw3pj/T+8QIxMH4yFGCQ5mJRHelXI7U4V4UxIrq1KL8uOLSnNSiw8xmgIjZyKzlGhyPjD5
	55XEG5pYGpiYmZmZWBqbGSqJ875unZsiJJCeWJKanZpakFoE08fEwSnVwHQwzjyllHFl3nvl
	c+Ym74QUc8Ljtv7Y18ebKbR807Gthn//8r7+uK6ge+m7jZGtvpt67VNtXhQwTVrs8I3XaN7H
	Q8eWmf7OEXSSjfRNXfyx8DvvWduHzRNsVmenTeGc8W/Jfwv2gHTnCVumbf/Hee7HvmM3ZJYW
	am47eMzk2FYRj52TmldzRx673v9yTffNlLYJz9r8DCcybTd4PY2b+eDle8b/+VMqb3xkMf/8
	dHWj6omLU9kP/Vjz0DjTJMT04YfdyrsW+dVf6uCZz8KjaJ4scnq27Nej9/+siSy+aCu7cc3n
	rOufNjSqnYq7z3n7VrOYRs28WK3rxV8ClDccXpQTKPFtgenJaTz6ChtqF/SwKrEUZyQaajEX
	FScCAHSTN89GBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWy7bCSvG5Z/K5UgzXHlSxW3+1ns3h9+BOj
	xbQPP5ktVj0It1i5+iiTxd5b2hZ79p5ksei+voPNYvnxf0wW5/8eZ3Xg8rh8xdvj8tlSj02r
	Otk8dt9sYPP4+PQWi0ffllWMHp83yXlsevKWKYAjissmJTUnsyy1SN8ugStjds9U9oI7TBVX
	VnQwNzAuZ+pi5OSQEDCR+NHYxdrFyMUhJLCbUeLO6wZGiIS4RPO1H+wQtrDEyn/P2SGKXjNK
	/No6iw0kwStgJ9E5/wHQJA4OFgFViTkb9CDCghInZz5hAbFFBZIk9txvBFsmLBAtcXjOPbA4
	M9D8W0/mg8VFBOIkDu+/ATafWWAWk8Tz8w/ZIJbtZZR49f8FG8gCNgFNiQuTS0FMTgEriS+H
	CyHmmEl0be1ihLDlJba/ncM8gVFoFpIzZiFZNwtJyywkLQsYWVYxSqYWFOem5yYbFhjmpZbr
	FSfmFpfmpesl5+duYgRHmpbGDsZ78//pHWJk4mA8xCjBwawkwrtSbmeqEG9KYmVValF+fFFp
	TmrxIUZpDhYlcV7DGbNThATSE0tSs1NTC1KLYLJMHJxSDUzb1GSCL0h9PHLn4K7YJ+wVHT7P
	d77uLuQNSQqM+nTikvGcI26NanJaOV7CRS+Sy00zflYVHE3U1e1aJmI3MS3ueNDEuarWGUca
	3PJ3qL2+MqvvFVfmO7Y/KXWLHb3eePXPZe88J+mX9nNLoXLh5yUl843s+z1YG+uiu3LL2JbO
	XKD5U8Tn7adf4TLcub5ZrZrZs6O8E92WGqh7MwVLT1lhpNW6kiFgw0kr7ba0CD0fx5qeJuaw
	3ffETzVnL1vvvUru46w7NjabF/1bMsVd+++OdXO3eIQJq7qmndaXjl5vnL/C7cbKuYEuZ7IP
	vTkxO/ZVZte+H+0X3nM+1DliZbbXv+2U3gyx83M7d53uUGIpzkg01GIuKk4EAETxdtwjAwAA
X-CMS-MailID: 20240131145550epcas5p2153471099be52fc5ca04a5e363b90d6b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240130215017epcas5p4df29da1bff15618e23de372310417b53
References: <20240130214911.1863909-1-bvanassche@acm.org>
	<CGME20240130215017epcas5p4df29da1bff15618e23de372310417b53@epcas5p4.samsung.com>
	<20240130214911.1863909-7-bvanassche@acm.org>

On 1/31/2024 3:18 AM, Bart Van Assche wrote:
> Restore support for passing data lifetime information from filesystems to
> block drivers. This patch reverts commit b179c98f7697 ("block: Remove
> request.write_hint") and commit c75e707fe1aa ("block: remove the
> per-bio/request write hint")

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

