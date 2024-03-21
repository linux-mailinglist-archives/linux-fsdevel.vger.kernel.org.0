Return-Path: <linux-fsdevel+bounces-14946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC168881C24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 06:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C36282E1B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 05:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF88F36B01;
	Thu, 21 Mar 2024 05:40:32 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883742E85C
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Mar 2024 05:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710999632; cv=none; b=cKDf68rsVFe1TFrlNyYxpR4z8hq0kQshuLAF9bsmmexrVZVN77ET/fqKM+TdIIaxh58bsfa0zJjipA+tWcUg5xIOJbg59T1MWSZQhzpLmdoJPF25fDNKy790xU7Ikq2+hAOkS0bZ25yrEVDY1UDXcD5K4XZZUMnVoRh+PvOsDD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710999632; c=relaxed/simple;
	bh=UOtGU9bqcepD3f6HblhxMGOQncy71sN+C7ldQsWHJng=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MqgxKn/L//QcISzZkgeP6TDlnr3lcdzaHkmOSxwsmXJtFj/pyOv9csRAeebefpqCeRgWLurGvTQoejITgbGDSNRApQRPMVhR1Vp0D9FPJfVvi+FexWmlF+jcxA7ImH0XzkiBnwcaXzd04cEkXhyVV3lgn+K/Eb0eyzddaqlNGzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4V0Z405m1Lz1h2bC;
	Thu, 21 Mar 2024 13:37:52 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id B521014013B;
	Thu, 21 Mar 2024 13:40:26 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 13:40:25 +0800
Message-ID: <2584271f-a939-4929-970e-daf0ac1ca409@huawei.com>
Date: Thu, 21 Mar 2024 13:40:25 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 11/11] fs: aio: add explicit check for large folio in
 aio_migrate_folio()
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
CC: Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>, Tony Luck
	<tony.luck@intel.com>, Naoya Horiguchi <naoya.horiguchi@nec.com>, Miaohe Lin
	<linmiaohe@huawei.com>, David Hildenbrand <david@redhat.com>, Muchun Song
	<muchun.song@linux.dev>, Benjamin LaHaise <bcrl@kvack.org>,
	<jglisse@redhat.com>, <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>,
	Zi Yan <ziy@nvidia.com>, Jiaqi Yan <jiaqiyan@google.com>, Hugh Dickins
	<hughd@google.com>
References: <20240321032747.87694-1-wangkefeng.wang@huawei.com>
 <20240321032747.87694-12-wangkefeng.wang@huawei.com>
 <Zfuq6thrgFB8Ty_c@casper.infradead.org>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <Zfuq6thrgFB8Ty_c@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/3/21 11:35, Matthew Wilcox wrote:
> On Thu, Mar 21, 2024 at 11:27:47AM +0800, Kefeng Wang wrote:
>> Since large folio copy could spend lots of time and it is involved with
>> a cond_resched(), the aio couldn't support migrate large folio as it takes
>> a spin lock when folio copy, add explicit check for large folio and return
>> err directly.
> 
> This is unnecessary.  aio only allocates order-0 folios (it uses
> find_or_create_page() to do it).

Yes, only order-0 now, I will drop it.

> 
> If you want to take on converting aio to use folios instead of pages,
> that'd be a worthwhile project.

OK, will try, thanks for your review.
> 

