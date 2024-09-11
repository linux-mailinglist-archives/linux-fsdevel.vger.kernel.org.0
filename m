Return-Path: <linux-fsdevel+bounces-29112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9228597579A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 17:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A3EF28A9F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 15:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C6D1AE86C;
	Wed, 11 Sep 2024 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GAEmF16x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211A01ABEB8
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2024 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726069848; cv=none; b=H4jkZIKDPiEisebPHFcPdy5iIOCYDXhnVr131VDJ3bzE+VlWepVXWsu2J4hE5pWstFFqrBDq5AoV41ShNc7BsJLxQEsT3TMpEtwynFvP0wr4fgaPkI1qwpGIyFnB2Hce090DtNN94Y/7nR6IhLMSRtRCuIDh2ydc0AZclNY31cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726069848; c=relaxed/simple;
	bh=9Oc1sgUVy+/sO/vboDjXOGjR+QgVUOOR2UHjlaRJn6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=F46pYgZKMJQiBXwF0oaXC6cfrMXa0bXOSIXWucxNhExakl29A2mVHJ4hNvkjo2b+hpQgvY+ZF9TXNs+kEysPgfXhVkFBar4IgTL0NCsQ/s3FUFf4aRK4Im48TMnZgF3e0K3yVpXM5wAFGr21U7TcpcRAgWzlwmGE3fUf3Yx4g3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=GAEmF16x; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240911155042epoutp022945eacaa03f1eb562d8b398dedfa519~0O2CDHvDu1729617296epoutp025
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2024 15:50:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240911155042epoutp022945eacaa03f1eb562d8b398dedfa519~0O2CDHvDu1729617296epoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726069842;
	bh=Y748A+ACGXxVtP9PeIAIgM9d3NhEmxDN0RDsrb/j5c4=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=GAEmF16xUoIvpGRG+HP8ovlNfuBgzqaF05BlwWi3sWQGL0saJeGG/auzv8ABlrQx+
	 nUmSb4nIrUCUmj12gucdNHDspwqUSr476xKl6UMYJOBZTrJiyoAJ67a7vEL0RTT8Td
	 EIBmT9j6Jb652OjKfpfqtPgvjBMMSbWCH3Ak8QDQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240911155041epcas5p18825dc12f21aab96cf959521dc5a2c74~0O2AYPXNe0166201662epcas5p1r;
	Wed, 11 Sep 2024 15:50:41 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4X3lQm2vyvz4x9Pp; Wed, 11 Sep
	2024 15:50:40 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B0.92.19863.05CB1E66; Thu, 12 Sep 2024 00:50:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240911155039epcas5p1fae0bda61cf3d7616240b18ba7009936~0O1-I5ATn2212422124epcas5p1G;
	Wed, 11 Sep 2024 15:50:39 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240911155039epsmtrp2fb17711b9e5864d03758445ca4d10c4c~0O1-Hw4Hx2933629336epsmtrp2I;
	Wed, 11 Sep 2024 15:50:39 +0000 (GMT)
X-AuditID: b6c32a50-ef5fe70000004d97-48-66e1bc50d169
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B4.86.08456.F4CB1E66; Thu, 12 Sep 2024 00:50:39 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240911155036epsmtip1ecc3492e4996e9f66e59c7cbd7c278f4~0O175ZUb52806928069epsmtip1d;
	Wed, 11 Sep 2024 15:50:36 +0000 (GMT)
Message-ID: <0982e242-c7fe-1456-815b-2d5b40d17ba9@samsung.com>
Date: Wed, 11 Sep 2024 21:20:30 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v5 3/5] fcntl: add F_{SET/GET}_RW_HINT_EX
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me, martin.petersen@oracle.com,
	James.Bottomley@HansenPartnership.com, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org,
	jlayton@kernel.org, chuck.lever@oracle.com, bvanassche@acm.org
Cc: linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com, vishak.g@samsung.com,
	javier.gonz@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <e6792bd5-1bd0-4a28-b0c9-7e49f74505f2@kernel.dk>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf1CTdRzHe55ne/ZAjXscI74uT9ZTeQrxY7TBFxPSy+jp6Addlld33hjj
	ETj2q/1IsYgdhoLWQELAAUK4E2R3gMMDErgIME7I1gkU7mJhjEiRLDgJVLRtDxb/vT6f+7y/
	78+P+xKYoJgnIrI1RkavUagoPJDTMbAtPDK15/r+mNulQdA+WYLDuYEFBFb8tYLBh5OzKLzW
	9zUKz9kvobC68jAKPa1WDJ4vIeD0L4s8uHK2mQfL+n9CYK8rAl5teBX29F7mwLqzMzx4/Ocu
	HDYOPUBhx706DLbM3eZA5+oQFzqtNbydT9KjYym0032eQ1eUDeP06BUT7Wguxul2Wz7dXb+I
	0t3XzDj994yLQ1suNCP09/WDPHrRsZl2eObRVP4HOTuyGEUGoxczGqU2I1uTmUilvCN/WS6L
	i5FEShJgPCXWKNRMIrX79dTI5GyVd2ZK/JFCZfKmUhUGAxWdtEOvNRkZcZbWYEykGF2GSifV
	RRkUaoNJkxmlYYzbJTExsTJvYVpO1nDTQ1zXhx08bvFwzcgkegwJIAApBafvu7wcSAjIHgTM
	dw1z2WABAUMlHRw2WEJAUcs3vEeS7spRzMcCshcBw1MfsjyPgOqLSh/zySTgGTP7LTjkc2Bk
	xIWw+Q3g8ikPx8chZDq4O17jzweTieCr1Sb/+xgZClyeOn9LQtKOghq3zR9gZDkKlqv6vc4E
	gZPbwI9fmnyCAK+4fPbMmjgMdM7XYL56QDYGgMqWzzG2693g5Im7axwMbg5dWJtGBBb/7MVZ
	zgFTv01xWP4EdLVbuCy/BMz3J7g+X8zr23oxmvUKAl/c86C+NCD5oOiIgK1+GrjLZtaUoeB6
	lW2NaeAqH8PZhd5CQJvrJl6KiK3r9mJdN7913TjW/53rEU4zImJ0BnUmo5TpJJEa5sB/F1dq
	1Q7E/yfCU7sQe9tqVD+CEkg/AgiMEvJLktz7BfwMRe4hRq+V600qxtCPyLwXOoGJQpRa76fS
	GOUSaUKMNC4uTprwQpyECuXPFdZmCMhMhZHJYRgdo3+kQ4kAkRl9bHMe82vgLipTyEP0dfse
	Fx1685yDyv6hzBmsdoa84qKn1K3L422nbLMD8pDPhNzJiGdihW+PLxU1hIHoiAPpxyY3WYjc
	o2/M1tROvLc3qENMlgbeIBqL8n+fuCXffuOK2bhvZG/FGWffp9yTJqmw7ak7l6JePKzcmNs5
	mlZwuiHfsefb14KVuTL+YHpHU2TC0bD4QZsucWl5i3vl/eefdVUv3LnaslxVvWEiuXVp42rC
	1vYjeQ6Lu8ITbTtoseelRb81W/CPjNqVJp0qsMebuwofbErZsvUJwwxM7ny3gW5tWpZOO+qn
	9bHffdyJ11cm50cFpeTWFnY7whf3FP9B7eRRHEOWQhKO6Q2KfwHlKQmenAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUyMcRz3e56n557abh5X+HGGnSmudUT4GfIym6cyic3rRk/u6U2Xdtd5
	yR+uuY1OhJrydLpeL12TuUqnK0tJ68UytawjxFEcQheaXejK1n+f7/fz9v3jS+Gi98RcKi4x
	mVMmsgkS0ou42ySZHxBe1x+9XNvvh8r7MkjkaPoO0LWvozj60zeAod6GexgqK2/GUG72WQzZ
	b/M4upNBobcvhgVo1GgSoKuNPQDV2/zR08JtqK6+lUAG4zsBuvDMQqLSljEM3f1twFGFY4hA
	na4WD9TJ6wWbZjFd3WFM58s7BHPtahvJdD1WM2ZTGslUFp9hrPnDGGPt1ZDMt3c2grlUZQJM
	R/5DATNsns+Y7Z+xncIDXuvlXELccU65LDjSK7bt5h8yqQE/eeGS3UMD+jAd8KQgHQSt2V24
	DnhRItoKoDa1ZZKYDc/2/BJMYG9YNjYgmBA5ACx1utwiIR0M7d0aNyboxbC93QYm9jNg63U7
	MY5n0lGw7lWqW+NNb4AFrpvuUPxfgc1uwMZDfehyDPI16WB8wOksDDq0Q5N1nwBsNn0gdYCi
	SHopfJKpHnd7/kvKGiiaTFoNddU6MIEXwJrPevwyEPFTDuGnFPJTLPwUSz4gTGAOl6RSxChU
	gUkrErkTMhWrUKkTY2RHjinMwP0KUqkF1Jm+yhoBRoFGAClc4iPMCH4ZLRLK2VMpnPLYYaU6
	gVM1AjFFSGYLfzguykV0DJvMHeW4JE75n8Uoz7kaLOVbT3MaCozvPhhlyDzRUZ3+gxRrrzhD
	nzulR9ZlT9NW3joIAhb5p7zev3ZM4xxa6P0zFxSZVZY98SCk1mNktJSvn/dBs2aVj+J0uBzV
	/vxitMuNyLLjBnjouDXk11FwcYuzur4y9rKPyXdFtYiN1Of4L0nfGk3pg6Voe0V/STkrI6ue
	7oq+0mQKWeJbGxa2qkBc6EBxzMjvQzWDm3r4kSxKErnx+xM/1lgyvXB3w7nkwgc5fml5nobM
	rAcz1BFrgnwDHj3e55GWd3j1XmPm5uKyVwHWkFy+TTY66Eqt2FPQq88eJKs+vuHvi8+EnX5k
	KYn5+CnKFXpPfH5lhE1CqGLZQCmuVLF/Acg4jlZ5AwAA
X-CMS-MailID: 20240911155039epcas5p1fae0bda61cf3d7616240b18ba7009936
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240910151052epcas5p48b20962753b1e3171daf98f050d0b5af
References: <20240910150200.6589-1-joshi.k@samsung.com>
	<CGME20240910151052epcas5p48b20962753b1e3171daf98f050d0b5af@epcas5p4.samsung.com>
	<20240910150200.6589-4-joshi.k@samsung.com>
	<e6792bd5-1bd0-4a28-b0c9-7e49f74505f2@kernel.dk>

On 9/11/2024 12:18 AM, Jens Axboe wrote:
> On 9/10/24 9:01 AM, Kanchan Joshi wrote:
>> +static inline bool rw_placement_hint_valid(u64 val)
>> +{
>> +	if (val <= MAX_PLACEMENT_HINT_VAL)
>> +		return true;
>> +
>> +	return false;
>> +}
> Nit, why not just:
> 
> static inline bool rw_placement_hint_valid(u64 val)
> {
> 	return val <= MAX_PLACEMENT_HINT_VAL;
> }
> 

Right, concise.
I can fold in both the changes in next respin.

