Return-Path: <linux-fsdevel+bounces-31437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B62A996905
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 13:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E081283706
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 11:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D6B1922DC;
	Wed,  9 Oct 2024 11:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RK9iEOvk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E67318FDAF
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Oct 2024 11:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728474179; cv=none; b=uszuGQMKT8oIlNU8xv5YNHXlozRQ/YkIp7wHg9zM+Ui7eAOJkGJy14gMzraZpig+Cdb6y/Ptxp2b3/2ANFhoHKiT67dzn6AmUSL2e/DPn4IHx/zQApFjJlu4OYTeCbJHKAXXgV3K0eJjZdiRBnsMT8YQK5KVB5f619FkbnrDyOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728474179; c=relaxed/simple;
	bh=Fd4qfGvcLUZTuHOy8raJdMX7vC2jgNcVLAkVYM6zRTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=fXFUXNSRDJWEjB/z6NDzK+glwoz2HzM7VvnxGMw1e2hh9ron+ZDLD1cedTQiw/I/u0iJhom5V29TVbS2mLA3mcIY1X9+xPFQk4wjvEdssA71WhTQ4U5nV4Taw9A02OXgr0o8UbmzcXAVy4IClRKuTQOzG/Az+Uy5bNo6oRv4858=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=RK9iEOvk; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241009114254euoutp0132fbd26af7da08b56460e99342d667ac~8xhqddRRD1669116691euoutp01L
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Oct 2024 11:42:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241009114254euoutp0132fbd26af7da08b56460e99342d667ac~8xhqddRRD1669116691euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1728474174;
	bh=jguo1hZb9YRK3ghzgfsaiktNLvc5Da5Czj4m8/g7MX4=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=RK9iEOvktHGsehfpVTB6qzuq1dCJPa+gHny4AYGrDtQeaIsXR4Jypo8J6RWEp/jQe
	 nzfUwGPRw2E9jGc14zb7pwbRY146w6sKteHDI63V2FndFC8J5+7NIGS9rGcR4vFEVS
	 /AHAByj0F6TMBpr/YSOY1UVLlvsGavW+o4YYYkS0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20241009114254eucas1p2a2fdb2e8b97c75d5d4526317c7a00a56~8xhqSJAwi2753827538eucas1p2O;
	Wed,  9 Oct 2024 11:42:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 44.A0.09624.E3C66076; Wed,  9
	Oct 2024 12:42:54 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20241009114254eucas1p2c174307fe53b3d5563795cc8eb92b91d~8xhp83vcA2208822088eucas1p2z;
	Wed,  9 Oct 2024 11:42:54 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241009114254eusmtrp1acb0a4ad05aeafa9a081b1f75bccd9ab~8xhp8X2yi0783807838eusmtrp1F;
	Wed,  9 Oct 2024 11:42:54 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-a0-67066c3e6cf5
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id D1.12.14621.D3C66076; Wed,  9
	Oct 2024 12:42:53 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241009114253eusmtip1a41a1bd1ba7a439a5962d4a0b509cba8~8xhpgSO8G1726017260eusmtip1v;
	Wed,  9 Oct 2024 11:42:53 +0000 (GMT)
Message-ID: <d45b18b5-6d84-425d-8e73-599a616d012a@samsung.com>
Date: Wed, 9 Oct 2024 13:42:52 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/11] make __set_open_fd() set cloexec state as well
To: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc: torvalds@linux-foundation.org, brauner@kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20241007174358.396114-10-viro@zeniv.linux.org.uk>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42LZduznOV27HLZ0gxOzxS1eH/7EaLFn70kW
	i0d9b9ktzv89zurA4rFpVSebx4kZv1k8Pm+S89j05C1TAEsUl01Kak5mWWqRvl0CV8bUg/+Z
	C1qFK/6u3s7awNjP38XIySEhYCLxavUL9i5GLg4hgRWMEt37prNCOF8YJf42H2WDcD4zSjT3
	3GGFaWnY95gRIrGcUeLV9d1QVR8ZJd6/WcoEUsUrYCcx7dpaFhCbRUBFYsO6RkaIuKDEyZlP
	wOKiAvIS92/NAFrOwSEs4CPxZQvYAhEBF4nbjXuZQWxmAVOJE2072SFscYlbT+aDjWcTMJTo
	etvFBtLKKWAvcWyXD0SJvMT2t3OYQc6REDjAIfHl/B4miKNdJFbfuQn1gLDEq+Nb2CFsGYnT
	k3tYIBraGSUW/L7PBOFMYJRoeH6LEaLKWuLOuV9g25gFNCXW79KHCDtKTPq+F+x+CQE+iRtv
	BSGO4JOYtG06M0SYV6KjTQiiWk1i1vF1cGsPXrjEPIFRaRZSoMxC8uUsJO/MQti7gJFlFaN4
	amlxbnpqsWFearlecWJucWleul5yfu4mRmBqOf3v+KcdjHNffdQ7xMjEwXiIUYKDWUmEV3ch
	a7oQb0piZVVqUX58UWlOavEhRmkOFiVxXtUU+VQhgfTEktTs1NSC1CKYLBMHp1QDU07chakr
	zkWv1W5uj3/45+LRndOf7+o/fsCZvyZ8namnqlxCbcyV6ZXePj8b3cxF7x7gqWDh37hhvj/D
	i9+17RFFmjPY9q3yv7xAOW6d11KV5BPXw9/9WHH/mM2pCIGSmQd3T9j/weTKzr/iC1h/m9dP
	XckmkMbitOIt89S0mw9DTx9Z9LF63pkvz+Yp9aRqNLa01QY7/rO6xXrrs9Y+yzTO83U9f3I/
	82bo+27eu3v5wu3f1x364BphwNHQkXH277/ox5YTqh3FQzUaPVKnrn62+FRh3sk1Prs3pPNw
	upaZWUZrqH5xy0ueuDGmfhNTgZXAasafSr2GfnfPcX+Y38Uyy0gsxSo23ozhSt6mOCWW4oxE
	Qy3mouJEAIrtR2CcAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVy+t/xu7q2OWzpBgebbCxeH/7EaLFn70kW
	i0d9b9ktzv89zurA4rFpVSebx4kZv1k8Pm+S89j05C1TAEuUnk1RfmlJqkJGfnGJrVK0oYWR
	nqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2CXsbUg/+ZC1qFK/6u3s7awNjP38XIySEh
	YCLRsO8xI4gtJLCUUaLpTC1EXEbi5LQGVghbWOLPtS62LkYuoJr3jBI/bp9iAknwCthJTLu2
	lgXEZhFQkdiwrpERIi4ocXLmE7C4qIC8xP1bM9i7GDk4hAV8JL5sAZspIuAicbtxLzOIzSxg
	KnGibSc7xPypjBIrV15lg0iIS9x6Mh9sF5uAoUTXW5AjODg4Bewlju3ygSgxk+ja2sUIYctL
	bH87h3kCo9AsJFfMQjJpFpKWWUhaFjCyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiMpG3H
	fm7ewTjv1Ue9Q4xMHIyHGCU4mJVEeHUXsqYL8aYkVlalFuXHF5XmpBYfYjQFBsVEZinR5Hxg
	LOeVxBuaGZgamphZGphamhkrifO6XT6fJiSQnliSmp2aWpBaBNPHxMEp1cBUd6C6Jvfnioc7
	FX7lC+9xjlDceuKP4o9IHsEn8Y8Kk7l5I47+fzzz16tNSeujdxquuVXp+tPXbU5EiW9SjAN/
	wfIEJWn5aM7YyiCht6uNpBdcloxmkoiPnv3fYPZvifywus64yPvhz9aK2k95yc285fYDud7/
	jEKn2XkmHu9Y5HvTkrnhvhuvVMoke5ZLfx9auvos6Tb1+JHcol/G9y7LzNH93FNzj0t6J7Jt
	rhWdUs2duav44RqVo7tF3nSwWc51+Fa3qeZz9uz7x1XmsGzq6ivdxCLO05u3fMrqlX1Gu4Jm
	3Nsb9spf6sJ/K/eC+zLCNzgnPdi0akcYRzpvYaLMKfVLRS87jyfIzz5tOFGJpTgj0VCLuag4
	EQBEq+phLQMAAA==
X-CMS-MailID: 20241009114254eucas1p2c174307fe53b3d5563795cc8eb92b91d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20241009114254eucas1p2c174307fe53b3d5563795cc8eb92b91d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241009114254eucas1p2c174307fe53b3d5563795cc8eb92b91d
References: <20241007173912.GR4017910@ZenIV>
	<20241007174358.396114-1-viro@zeniv.linux.org.uk>
	<20241007174358.396114-10-viro@zeniv.linux.org.uk>
	<CGME20241009114254eucas1p2c174307fe53b3d5563795cc8eb92b91d@eucas1p2.samsung.com>

On 07.10.2024 19:43, Al Viro wrote:
> ->close_on_exec[] state is maintained only for opened descriptors;
> as the result, anything that marks a descriptor opened has to
> set its cloexec state explicitly.
>
> As the result, all calls of __set_open_fd() are followed by
> __set_close_on_exec(); might as well fold it into __set_open_fd()
> so that cloexec state is defined as soon as the descriptor is
> marked opened.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

This patch landed in today's linux-next as commit 218a562f273b ("make 
__set_open_fd() set cloexec state as well"). In my tests I found that it 
breaks booting of many of my test systems (arm 32bit, arm 64bit and 
riscv64). It's hard to describe what exactly is broken, but none of the 
affected boards reached the login shell. All crashed somewhere in the 
userspace during systemd startup. This can be easily reproduced even 
with qemu.

> ---
>   fs/file.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/fs/file.c b/fs/file.c
> index d8fccd4796a9..b63294ed85ec 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -248,12 +248,13 @@ static inline void __set_close_on_exec(unsigned int fd, struct fdtable *fdt,
>   	}
>   }
>   
> -static inline void __set_open_fd(unsigned int fd, struct fdtable *fdt)
> +static inline void __set_open_fd(unsigned int fd, struct fdtable *fdt, bool set)
>   {
>   	__set_bit(fd, fdt->open_fds);
>   	fd /= BITS_PER_LONG;
>   	if (!~fdt->open_fds[fd])
>   		__set_bit(fd, fdt->full_fds_bits);
> +	__set_close_on_exec(fd, fdt, set);
>   }
>   
>   static inline void __clear_open_fd(unsigned int fd, struct fdtable *fdt)
> @@ -517,8 +518,7 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
>   	if (start <= files->next_fd)
>   		files->next_fd = fd + 1;
>   
> -	__set_open_fd(fd, fdt);
> -	__set_close_on_exec(fd, fdt, flags & O_CLOEXEC);
> +	__set_open_fd(fd, fdt, flags & O_CLOEXEC);
>   	error = fd;
>   
>   out:
> @@ -1186,8 +1186,7 @@ __releases(&files->file_lock)
>   		goto Ebusy;
>   	get_file(file);
>   	rcu_assign_pointer(fdt->fd[fd], file);
> -	__set_open_fd(fd, fdt);
> -	__set_close_on_exec(fd, fdt, flags & O_CLOEXEC);
> +	__set_open_fd(fd, fdt, flags & O_CLOEXEC);
>   	spin_unlock(&files->file_lock);
>   
>   	if (tofree)

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


