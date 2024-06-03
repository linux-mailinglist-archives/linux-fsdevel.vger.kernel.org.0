Return-Path: <linux-fsdevel+bounces-20899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2CA8FAA83
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 08:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9448283AE3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 06:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBD313F45D;
	Tue,  4 Jun 2024 06:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="s45Z7N0g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DC613F00B
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 06:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717481289; cv=none; b=kCYMC1t2Qhv1X/WJvC7N8qvfh3H9BwSYL2lkhaIqBBd0N14t4CB5HOcxG7kK34mj+31ay4Gt4BLExWTfUkOX59lgBQpuodY30JYwakq0CImFiotFpq47VWfe2pZ6/sFZZrAsLB+TR5Wp+ErxEnoJACadrjXeuJPufobY1QV83ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717481289; c=relaxed/simple;
	bh=gvH3c0FW48yhnKWny/ep84l1B7/4sRdVkNsiDvcVAnE=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=pztk/r5yxXkf6oJTwPsgdAh+IBptr+t8KPnKDOFItQbMKVv9WMt60A2UcAb4C1SfJlvfKTiVHeL1hlOvXO4FuhFTWx0kMxVr5lBxxyIU1bQ4RRhr1Qff8oKei4Q1MXgcjgElVYoVcwJE3wpeI1ZSriC1t2jb9vmJMfRVbXSl7dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=s45Z7N0g; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240604060800euoutp0189c69449067db6059351c824bd56f005~VuB-9LbQb2518325183euoutp01K
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 06:08:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240604060800euoutp0189c69449067db6059351c824bd56f005~VuB-9LbQb2518325183euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717481280;
	bh=ecaboJMjx0Lduj0jKkhatc0G1F3oFpydwyMrzPU8vkI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=s45Z7N0g/ZRiY2YtE9vr2T63rC5JTqyZ9xb2bgJXCZfCfkwtRO7y+TdBqRgotOeGG
	 wqbZ8kXzvwmAr5CTf2INt9mnRmMvg92+ZKT5EmUO0Z3kJnnXAucggeqafzZzYDWy80
	 WvKIQshwb148JlaEnYeZsgnQS9K5F6ok3+cXgqCY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240604060800eucas1p1aef68ce3eb267c641012e52771407de4~VuB-15l5h2225722257eucas1p1H;
	Tue,  4 Jun 2024 06:08:00 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 5A.AC.09624.04FAE566; Tue,  4
	Jun 2024 07:08:00 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240604060759eucas1p16ab4ee54cca46d6d19fa97af3b40bb07~VuB-dijLP1146711467eucas1p19;
	Tue,  4 Jun 2024 06:07:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240604060759eusmtrp135fcbf5f2f5d052b452483fd11b3c1e3~VuB-dD2uv2259022590eusmtrp1j;
	Tue,  4 Jun 2024 06:07:59 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-ce-665eaf40c88f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 8E.90.09010.F3FAE566; Tue,  4
	Jun 2024 07:07:59 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240604060759eusmtip14af216b4d418c29d87720b55079a7439~VuB-SZE9_2251322513eusmtip11;
	Tue,  4 Jun 2024 06:07:59 +0000 (GMT)
Received: from localhost (106.210.248.71) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 4 Jun 2024 07:07:59 +0100
Date: Mon, 3 Jun 2024 14:53:32 +0200
From: Joel Granados <j.granados@samsung.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
CC: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] kernel/sysctl-test: add MODULE_DESCRIPTION()
Message-ID: <20240603125332.3zsv255k3zhyy6x5@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240529-md-kernel-sysctl-test-v1-1-32597f712634@quicinc.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42LZduznOV2H9XFpBhs+81mc6c612HpL2mLP
	3pMsFpd3zWGzuDHhKaNF45a7rA5sHrMbLrJ4bFrVyeYxcU+dx+dNcgEsUVw2Kak5mWWpRfp2
	CVwZFz+2MhY0sFe8WPudpYHxBWsXIyeHhICJxKLO88wgtpDACkaJlqUJXYxcQPYXRokFd6cz
	QjifGSVa/zWww3T0HfzIDpFYzijxelc7C1zV/c1fmCBmbWaUWHqlBsRmEVCRePizhwXEZhPQ
	kTj/5g7YPhEgu/XpFjaQZmaQ+nM/9rGBJIQFHCXu7J4HVsQr4CDRvbmfDcIWlDg58wnYIGag
	5gW7PwHFOYBsaYnl/zhAwpwC3hIzP+5nhLhUSeLgxfcsEHatxNpjZ8CulhA4wyFx6+t8aAC4
	SKzavQiqSFji1fEtUG/KSJye3MMC0TCZUWL/vw9Q3asZJZY1fmWCqLKWaLnyhB3kCgmgq/cf
	toYw+SRuvBWEuJNPYtK26cwQYV6JjjYhiEY1idX33rBMYFSeheSzWUg+m4Xw2QJG5lWM4qml
	xbnpqcWGeanlesWJucWleel6yfm5mxiBKeX0v+OfdjDOffVR7xAjEwfjIUYJDmYlEd6+uug0
	Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4ryqKfKpQgLpiSWp2ampBalFMFkmDk6pBiaD3+VvXksl
	Xbr0TF8/z5g1gS2v1cDvc8nXzf9No+TuVq98FPuysm2DQsuhfSnvL2+fqbrLwzA4bfd5p93a
	Z0+0Zfi6GHw22De/+8ux+QEZ+37ZdE/i8bmcfkdGy53TZ+XybUotVSrdybKvHoeaPDxp/VF0
	v1OX7CSDucLLpLZsm7i2bZGPfq7XoYjc8uyvb0OvhHl83d5XuPQOg2uMyHeuLLWMyyLH5d8V
	qt52q5U+0+48zf3Bn4vrf6nr6Ot3M99IvV4qNG13pgVzxEPGJO1l61i2TuNaslppteImKeVV
	OVJ3N20s6j90YsHhtetOW2QwPPywJDZDw2Bm+cFj8x6JLn3YV7P/9fRyY9a0l/1KLMUZiYZa
	zEXFiQBRCa6MmAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsVy+t/xu7r26+PSDB5fN7I4051rsfWWtMWe
	vSdZLC7vmsNmcWPCU0aLxi13WR3YPGY3XGTx2LSqk81j4p46j8+b5AJYovRsivJLS1IVMvKL
	S2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstSi/TtEvQyLn5sZSxoYK94sfY7SwPj
	C9YuRk4OCQETib6DH9m7GLk4hASWMkpcPXGeESIhI7Hxy1WoImGJP9e62CCKPjJK7Hs5gRnC
	2cwoceD/HCaQKhYBFYmHP3tYQGw2AR2J82/uMIPYIkB269MtYN3MIA3nfuxjA0kICzhK3Nk9
	D6yIV8BBontzP9SKeYwS3yctYoNICEqcnPkEbCoz0KQFuz8BxTmAbGmJ5f84QMKcAt4SMz/u
	hzpbSeLgxfcsEHatxKv7uxknMArPQjJpFpJJsxAmLWBkXsUoklpanJueW2ykV5yYW1yal66X
	nJ+7iREYXduO/dyyg3Hlq496hxiZOBgPMUpwMCuJ8PbVRacJ8aYkVlalFuXHF5XmpBYfYjQF
	hsVEZinR5HxgfOeVxBuaGZgamphZGphamhkrifN6FnQkCgmkJ5akZqemFqQWwfQxcXBKNTDt
	EX78qJO/46Xko66//FG2qSom73Nlj9YUn394SvRD3rWK/U3zeMP2bE08teSRzyK59aITovsc
	mBWVfi+bI3nc3O1vS+qDsIwLG6c5XG/U/7z2urSOR89ezaoJOuwmz17F9M83/PPlyAODho7X
	P1/P1N5v0Vgl9Ojg47pivllh2XkXnwf733ae1bXM+NIZ7o3/U0PYr3G4pugXKYTNVTiYFe45
	Yf8RTtO6s5fb5NqzHJpOyLNFrnsTbTdF41Shxq6VE1ctKVG/aCN+d7XX43At+4rIsObsA/Zp
	zBoe0j4XlV1Yd8eJJje7LJ1ms/P50sWsW/0bk4VF1lluiTDTOf4sktWlWLa0ddmZ0zdeqSix
	FGckGmoxFxUnAgAI5dORNwMAAA==
X-CMS-MailID: 20240604060759eucas1p16ab4ee54cca46d6d19fa97af3b40bb07
X-Msg-Generator: CA
X-RootMTR: 20240529212552eucas1p1810ee5a1c17fb966eada0b0562338c23
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240529212552eucas1p1810ee5a1c17fb966eada0b0562338c23
References: <CGME20240529212552eucas1p1810ee5a1c17fb966eada0b0562338c23@eucas1p1.samsung.com>
	<20240529-md-kernel-sysctl-test-v1-1-32597f712634@quicinc.com>

On Wed, May 29, 2024 at 02:25:41PM -0700, Jeff Johnson wrote:
> Fix the 'make W=1' warning:
> WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/sysctl-test.o
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  kernel/sysctl-test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
> index 6ef887c19c48..92f94ea28957 100644
> --- a/kernel/sysctl-test.c
> +++ b/kernel/sysctl-test.c
> @@ -388,4 +388,5 @@ static struct kunit_suite sysctl_test_suite = {
>  
>  kunit_test_suites(&sysctl_test_suite);
>  
> +MODULE_DESCRIPTION("KUnit test of proc sysctl");

thx
Reviewed-by: Joel Granados <j.granados@samsung.com>

>  MODULE_LICENSE("GPL v2");
> 
> ---
> base-commit: 4a4be1ad3a6efea16c56615f31117590fd881358
> change-id: 20240529-md-kernel-sysctl-test-2bbad793ac62
> 


-- 

Joel Granados

