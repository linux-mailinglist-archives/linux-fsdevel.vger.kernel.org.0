Return-Path: <linux-fsdevel+bounces-58180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C20B2AAFA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 16:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA1117B5FC5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 14:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538BF233735;
	Mon, 18 Aug 2025 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="g/8Y2lpo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964C924A05B
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755527710; cv=none; b=ClYWB9ZOY7g757TpfhicQkcXxROXQPcthKNNsoUfiG0OAFIg2LiTaiTf5HSDC4/AeuTaKwWpbP5gKylLzkmM1SrFbani5KKa0qujZPkGzShm9mXqY/iF3RPc+xgEYPRzeVh9v+cbIEM678y7n7fxQp/6sUrVM951yF61f36DUB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755527710; c=relaxed/simple;
	bh=otXVTHL+BeB20xbOxHwwF3/CnEk52ra2iOqsDFK0oZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:From:In-Reply-To:
	 Content-Type:References; b=njvosoSx9xRFRVI3exZfhpVTBJKk8qfPaZkBLf3Ahvx/yXIwKDZQbQG58quppINCSnJAYXX0AqjDURNhXi6uyugBULae/q+atxMFvmTbfCH3+LDK/Gl7SF3tPh1YZzjeKKHF49Eg8i+AKMdr5ea2WPpPUDPdq1Nivvg3n/46VJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=g/8Y2lpo; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250818143506euoutp02ddf4db3ebcb7841d80b41c01195cb0ed~c4yXrhSXL0581605816euoutp02Z
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 14:35:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250818143506euoutp02ddf4db3ebcb7841d80b41c01195cb0ed~c4yXrhSXL0581605816euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755527706;
	bh=ieZPe4l8Sl+NzpVwCMHVhCAI7HNLwj+x2OinGuiBzIA=;
	h=Date:Subject:To:CC:From:In-Reply-To:References:From;
	b=g/8Y2lpoTXwKQUIap6/NdRV20IFT9OLTG83AXoJMYdHzX3B0hrm1WELZQ2oj4n2GO
	 sEjEiuQpDYaU08DYrw1/VgAJ/zHuGFJrnKkzPtvwrKaH86QIuwuz7S471w6zoM3efR
	 8ihwkRKC8IemvzcupGoM0eQnGpg0PKVWLtDSCdNs=
Received: from eucas1p2.samsung.com (unknown [182.198.248.175]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250818143506eucas1p120acf5eeaad600f05730a688268dc79f~c4yXWhy1w0945209452eucas1p1J;
	Mon, 18 Aug 2025 14:35:06 +0000 (GMT)
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250818143506eucas1p1d0b69a5a401f01fff45e589e1afe5196~c4yW-MBKO0946009460eucas1p1S;
	Mon, 18 Aug 2025 14:35:06 +0000 (GMT)
Received: from CAMSPWEXC02.scsc.local (unknown [106.1.227.4]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250818143505eusmtip1400e876fb2ca5c15d4c14541a9b4f660~c4yW4Ojir1594715947eusmtip1g;
	Mon, 18 Aug 2025 14:35:05 +0000 (GMT)
Received: from [106.110.32.110] (106.110.32.110) by CAMSPWEXC02.scsc.local
	(106.1.227.4) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.26; Mon, 18 Aug
	2025 15:35:04 +0100
Message-ID: <43bca78e-fa89-4b0e-94f1-de7385818950@samsung.com>
Date: Mon, 18 Aug 2025 16:35:04 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iomap: use largest_zero_folio() in iomap_dio_zero()
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, Christoph
	Hellwig <hch@infradead.org>, Christian Brauner <brauner@kernel.org>,
	<akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>
CC: "Darrick J . Wong" <djwong@kernel.org>, "Pankaj Raghav (Samsung)"
	<kernel@pankajraghav.com>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <mcgrof@kernel.org>,
	<gost.dev@samsung.com>, <linux-xfs@vger.kernel.org>
Content-Language: en-US
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <4b225908-f788-413b-ba07-57a0d6012145@igalia.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CAMSPWEXC01.scsc.local (106.1.227.3) To
	CAMSPWEXC02.scsc.local (106.1.227.4)
X-CMS-MailID: 20250818143506eucas1p1d0b69a5a401f01fff45e589e1afe5196
X-Msg-Generator: CA
X-RootMTR: 20250818141331eucas1p21bf686b508f2b37883a954fd8aed891f
X-EPHeader: CA
cpgsPolicy: EUCPGSC10-065,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250818141331eucas1p21bf686b508f2b37883a954fd8aed891f
References: <20250814142137.45469-1-kernel@pankajraghav.com>
	<20250815-gauner-brokkoli-1855864a9dff@brauner>
	<aKKu7jN6HrcXt3WC@infradead.org>
	<CGME20250818141331eucas1p21bf686b508f2b37883a954fd8aed891f@eucas1p2.samsung.com>
	<4b225908-f788-413b-ba07-57a0d6012145@igalia.com>

On 18/08/2025 16:12, André Almeida wrote:
> Em 18/08/2025 01:41, Christoph Hellwig escreveu:
>> On Fri, Aug 15, 2025 at 04:02:58PM +0200, Christian Brauner wrote:
>>> On Thu, 14 Aug 2025 16:21:37 +0200, Pankaj Raghav (Samsung) wrote:
>>>> iomap_dio_zero() uses a custom allocated memory of zeroes for padding
>>>> zeroes. This was a temporary solution until there was a way to 
>>>> request a
>>>> zero folio that was greater than the PAGE_SIZE.
>>>>
>>>> Use largest_zero_folio() function instead of using the custom allocated
>>>> memory of zeroes. There is no guarantee from largest_zero_folio()
>>>> function that it will always return a PMD sized folio. Adapt the 
>>>> code so
>>>> that it can also work if largest_zero_folio() returns a ZERO_PAGE.
>>>>
>>>> [...]
>>>
>>> Applied to the vfs-6.18.iomap branch of the vfs/vfs.git tree.
>>> Patches in the vfs-6.18.iomap branch should appear in linux-next soon.
>>
>> Hmm, AFAIK largest_zero_folio just showed up in mm.git a few days ago.
>> Wouldn't it be better to queue up this change there?
>>
>>
> 
> Indeed, compiling vfs/vfs.all as of today fails with:
> 
> fs/iomap/direct-io.c:281:36: error: implicit declaration of function 
> ‘largest_zero_folio’; did you mean ‘is_zero_folio’? [-Wimplicit- 
> function-declaration]
> 
> Reverting "iomap: use largest_zero_folio() in iomap_dio_zero()" fixes 
> the compilation.
> 

I also got some reports from Stephen in linux-next. As Christoph 
suggested, maybe we drop the patches from Christian's tree and queue it 
up via Andrew's tree

--
Pankaj


