Return-Path: <linux-fsdevel+bounces-16667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C0C8A133B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 13:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFEC31F21498
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 11:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7C1149C4F;
	Thu, 11 Apr 2024 11:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CK63IaK8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B496149C46
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 11:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712835659; cv=none; b=hukh+8sMQHdToKC0UFtVNmeZeqfcaRzjW+6EqC/cpPd8Q0f+U7k1wjpOxf83uAEp3g/qk28rFpCWe2gWA1ryw3HE7fYYFT1L8bFtZXWFg7xzHy08TIJOfKyvlkshgDB/WKmvzRLWe3oCw062Vlou+uanYxzA7UTXUi67aeL6VcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712835659; c=relaxed/simple;
	bh=RTHIh7oCMEfUFywroWS2xBMj4Aot2ydEwhbe3+VnCCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Ww8qwolpdst8+C/5bDYyInHlJGn4rjEXUH9eF1XYuNHzqKHTTJ97Rr5OnOWacAPmwuSFcjG9a61IHMvrhwwSgyGOJ/o7rAlsAaQps3c6jHjFTfILNmF1RyHzAPdFZ48DcKLjJBtuu75l6K+zyhvdr50skaqnYDFK2HWXgn6DOoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=CK63IaK8; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240411114048euoutp024d5231f7dc009579b2e663bafb3f65c8~FNvKRxrga1618016180euoutp02d
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 11:40:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240411114048euoutp024d5231f7dc009579b2e663bafb3f65c8~FNvKRxrga1618016180euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1712835648;
	bh=WyXEhNFJX8cCdY/1UWO0DimgSzaVgdp9nexwZeY60z8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=CK63IaK8L2KIiuqJw/OyeVa5Dob6sPhFp6WdmO5JoTv2UQkw2cOzUVweidXmYydqT
	 DReV/hDL6MFNwl7eu062BukVbiSL7TPWUW9sRV6ZQo7mOMXnEPBsmzDjLvW3jCtMi4
	 pFhY46eGQITwKU8ZGhzPvXj1FZAf1dSbkfVqVr9A=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240411114048eucas1p10a33e25b48904b1931490e0e8284d2d0~FNvKJ6o8s0584505845eucas1p1f;
	Thu, 11 Apr 2024 11:40:48 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 1E.22.09875.04CC7166; Thu, 11
	Apr 2024 12:40:48 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240411114048eucas1p21707a2d0bfb9c5a21f3e8aa76c0d82c1~FNvJ3iOv22178121781eucas1p2P;
	Thu, 11 Apr 2024 11:40:48 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240411114048eusmtrp172d4ea35b1305d947e1edafc4d77f7d3~FNvJ2-IBj2476824768eusmtrp1A;
	Thu, 11 Apr 2024 11:40:48 +0000 (GMT)
X-AuditID: cbfec7f4-131ff70000002693-11-6617cc402ae2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 49.13.08810.04CC7166; Thu, 11
	Apr 2024 12:40:48 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240411114047eusmtip1348ce548c09d291118fe5e8ed6c1b5fa~FNvJfYrM_2299522995eusmtip1O;
	Thu, 11 Apr 2024 11:40:47 +0000 (GMT)
Message-ID: <528e184b-9cb1-40a7-b757-db11a852dd59@samsung.com>
Date: Thu, 11 Apr 2024 13:40:47 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] timerfd: convert to ->read_iter()
To: Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <1a1c00fb-c83f-44e7-bc6a-cfe52d780c35@kernel.dk>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42LZduzneV2HM+JpBnumKFisvtvPZvH68CdG
	iz17T7JYXN41h83i/N/jrA6sHpfPlnpsWtXJ5vF5k5zHpidvmQJYorhsUlJzMstSi/TtErgy
	Th3sYC+YyVlxqus2YwPjDPYuRk4OCQETiZvfDzN2MXJxCAmsYJSYdPQhC4TzBch5vowJwvnM
	KLFwziFmmJaWs0+hEssZJY5snscEkhAS+MgosWC9PIjNK2AnMeHzK7AdLAKqEpt+zmaFiAtK
	nJz5hAXEFhWQl7h/C+IOYQEriW3PHoDViAjYSyy/tZcRxGYW8Jd4cr2ZBcIWl7j1ZD7YLjYB
	Q4mut11sIDangK3Exvkw9fIS29/OgTp0D4fEn/N8ELaLxJYjB1ggbGGJV8e3QP0vI3F6cg/Y
	yxIC7UD3/77PBOFMYJRoeH6LEaLKWuLOuV9A2ziANmhKrN+lDxF2lNjVPo8dJCwhwCdx460g
	xA18EpO2TWeGCPNKdLQJQVSrScw6vg5u7cELl5gnMCrNQgqVWUi+nIXkm1kIexcwsqxiFE8t
	Lc5NTy02ykst1ytOzC0uzUvXS87P3cQITDGn/x3/soNx+auPeocYmTgYDzFKcDArifBKa4mm
	CfGmJFZWpRblxxeV5qQWH2KU5mBREudVTZFPFRJITyxJzU5NLUgtgskycXBKNTA5WU11fJij
	aT9hUuvv4+5fbW5wljyzr8s/2XytfPnOuC7HDL2fX2WnxsmWLwjXks+MCd4lc+S1lfrr5zGu
	8pL1046XF07OyhfQY9DOkw/vePqGZ66v7F3TdTN+rNi6WXSS16TsGau47xVPn57w16uhvfja
	4uvx648wHPukLPPVvqNj2tPumJuHzvztkitQ/7VKYI3Ilv8Ke97yccdo7dWb0/q1cIf50Q98
	XDfaJ9+UnNVq1mT+XuR66N2DehfW/mo/nfjrR+D9pD9s2wPef5vyMV3FenubTqcpFzeLztcF
	d34yeqT6vVmhZdxgtvf603ksO3lvvclzjO3rTbque9b7qKxZX3V70tdOh8MuJ58osRRnJBpq
	MRcVJwIA+5P10KADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsVy+t/xu7oOZ8TTDJZM47FYfbefzeL14U+M
	Fnv2nmSxuLxrDpvF+b/HWR1YPS6fLfXYtKqTzePzJjmPTU/eMgWwROnZFOWXlqQqZOQXl9gq
	RRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlnDrYwV4wk7PiVNdtxgbGGexd
	jJwcEgImEi1nnzJ1MXJxCAksZZSYNfcvM0RCRuLktAZWCFtY4s+1LjaIoveMEucenwfr5hWw
	k5jw+RWYzSKgKrHp52xWiLigxMmZT1hAbFEBeYn7tyC2CQtYSWx79gCsRkTAXmL5rb2MIDaz
	gK/Ep3etrBALJjFKXLm7lA0iIS5x68l8JhCbTcBQouttF1icU8BWYuN8mGYzia6tXVC2vMT2
	t3OYJzAKzUJyxywko2YhaZmFpGUBI8sqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwLjaduzn
	5h2M81591DvEyMTBeIhRgoNZSYRXWks0TYg3JbGyKrUoP76oNCe1+BCjKTAwJjJLiSbnAyM7
	ryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQimj4mDU6qBKfeu5KXsHmbBed89
	C5asLsziP1fAKLwp6EB99rWLeWqOd/N9bhRGCT25Zi9r5JRn+9K1IfXbR9ef7r6RqiWvUzId
	z7g8XHtJYsmlMre/p9dZbVWsmVouyvt/ir0W67tPCqpJU95vr4pYM3/y78qLBVMsHi/M3Tf5
	fMK/So6L121+ZLxuOnZKxG0yi5X+hI/bhEJWfvrhe86qs3LXzOkrLUziK/bfq2Hc84VZZuOX
	Jdfa2m+1L1Df+HnRv9/v39ycq/DlWcw7GZaoYuHdsmJlVypauKtuPxV4FVZ70V+XybZovqVF
	kHziPIV137UnHTr8w0kjd1eda15ep++m5kmGJVZS99oei+99aXHk44HUnUosxRmJhlrMRcWJ
	ADyMfWI0AwAA
X-CMS-MailID: 20240411114048eucas1p21707a2d0bfb9c5a21f3e8aa76c0d82c1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240411114048eucas1p21707a2d0bfb9c5a21f3e8aa76c0d82c1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240411114048eucas1p21707a2d0bfb9c5a21f3e8aa76c0d82c1
References: <20240409152438.77960-1-axboe@kernel.dk>
	<20240409152438.77960-3-axboe@kernel.dk>
	<1a1c00fb-c83f-44e7-bc6a-cfe52d780c35@kernel.dk>
	<CGME20240411114048eucas1p21707a2d0bfb9c5a21f3e8aa76c0d82c1@eucas1p2.samsung.com>

Hi,

On 11.04.2024 00:27, Jens Axboe wrote:
> On 4/9/24 9:22 AM, Jens Axboe wrote:
>> @@ -312,8 +313,8 @@ static ssize_t timerfd_read(struct file *file, char __user *buf, size_t count,
>>   		ctx->ticks = 0;
>>   	}
>>   	spin_unlock_irq(&ctx->wqh.lock);
>> -	if (ticks)
>> -		res = put_user(ticks, (u64 __user *) buf) ? -EFAULT: sizeof(ticks);
>> +	if (ticks && !copy_to_iter_full(&ticks, sizeof(ticks), to))
>> +		res = -EFAULT;
>>   	return res;
>>   }
> Dumb thinko here, as that should be:
>
> if (ticks) {
> 	res = copy_to_iter(&ticks, sizeof(ticks), to);
> 	if (!res)
> 		res = -EFAULT;
> }
>
> I've updated my branch, just a heads-up. Odd how it passing testing,
> guess I got stack lucky...

The old version got its way into today's linux-next and bisecting the 
boot issues directed me here. There is nothing more to report, but I can 
confirm that the above change indeed fixes the problems observed on 
next-20240411.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

I hope that tomorrow's linux-next will have the correct version of this 
patch.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


