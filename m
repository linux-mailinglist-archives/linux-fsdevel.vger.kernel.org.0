Return-Path: <linux-fsdevel+bounces-63838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F984BCF2CA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 11:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7358C189F119
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 09:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E85823C51C;
	Sat, 11 Oct 2025 09:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="dXgfOpNZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81E81DE3DB;
	Sat, 11 Oct 2025 09:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760173691; cv=none; b=kr7kRLERRcZqUGp9x/fJ2vSyQY0eteofQ2dBnhIKRzy0Bed0Qzev+aAXn3cvR4k5U7Xjt9CAnKijhEgTAG9dhG3vwb0gUxagh1Oda+EKVYorCpbeXIBdE5ODqhex5vlbOhVmGHSilPbNQf8mqWgxm3Zvgfj/1t2QjCfspfGtQG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760173691; c=relaxed/simple;
	bh=aPPzq32Tdl7574xxOnMxr+16UrNQqbxR3o7mGU6OOik=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=o+RTiTiKWIXb7cYOE21iLlzSJHmq1oZcepaq2kZAo5xy4nxVw1cUlEJmQshlgVwICTf87vnrzUo4lYT6EHicWejpNq472D5Wfx3lE4nF3xn8dTfA+4ZlbM4eFunuhIoWJmBbN8bJQUdizGXZWdtCcxGhLSn0BerV0O27opcdNmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=dXgfOpNZ; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=9jpEyMrd3vnSjR1xZsepMLlxr22S8g5uYtrOEpK8mUw=;
	b=dXgfOpNZIKxIEYfectR6rgBEK/xShe6Oqk8o0P9ZQhY5AT4FV2gWS2vwPs9xIQ2R0nKmQujlq
	K37Ww7EE9AcBEwU3Zx88CXnZ3DF9I1rXF/TpyIUnnHLFBNCZGYt6sdM2rxVEybQdNTCZcYDlANo
	bKX7s35pF2/5G1Pvgglyi80=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4ckHmq1wxHzpTKL;
	Sat, 11 Oct 2025 17:07:07 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id EEA0C1401F4;
	Sat, 11 Oct 2025 17:07:54 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 11 Oct 2025 17:07:40 +0800
Received: from [10.173.125.37] (10.173.125.37) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 11 Oct 2025 17:07:38 +0800
Subject: Re: [PATCH 2/2] mm/memory-failure: improve large block size folio
 handling.
To: Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>
CC: <akpm@linux-foundation.org>, <mcgrof@kernel.org>,
	<nao.horiguchi@gmail.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett"
	<Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, Ryan Roberts
	<ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
	<baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <david@redhat.com>, <jane.chu@oracle.com>,
	<kernel@pankajraghav.com>,
	<syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>
References: <20251010173906.3128789-1-ziy@nvidia.com>
 <20251010173906.3128789-3-ziy@nvidia.com>
 <934db898-5244-50b9-7ef7-b42f1e40ddca@huawei.com>
 <aOnkUxWPODofUnRy@casper.infradead.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <35d00740-0aa4-1d6d-87b8-ee973bcff792@huawei.com>
Date: Sat, 11 Oct 2025 17:07:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aOnkUxWPODofUnRy@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2025/10/11 13:00, Matthew Wilcox wrote:
> On Sat, Oct 11, 2025 at 12:12:12PM +0800, Miaohe Lin wrote:
>>>  		folio_set_has_hwpoisoned(folio);
>>> -		if (try_to_split_thp_page(p, false) < 0) {
>>> +		/*
>>> +		 * If the folio cannot be split to order-0, kill the process,
>>> +		 * but split the folio anyway to minimize the amount of unusable
>>> +		 * pages.
>>> +		 */
>>> +		if (try_to_split_thp_page(p, new_order, false) || new_order) {
>>> +			/* get folio again in case the original one is split */
>>> +			folio = page_folio(p);
>>
>> If original folio A is split and the after-split new folio is B (A != B), will the
>> refcnt of folio A held above be missing? I.e. get_hwpoison_page() held the extra refcnt
>> of folio A, but we put the refcnt of folio B below. Is this a problem or am I miss
>> something?
> 
> That's how split works.

I read the code and see how split works. Thanks for point this out.

> 
> Zi Yan, the kernel-doc for folio_split() could use some attention.

That would be really helpful.

Thanks.
.

> First, it's not kernel-doc; the comment opens with /* instead of /**.
> Second, it says:
> 
>  * After split, folio is left locked for caller.
> 
> which isn't actually true, right?  The folio which contains
> @split_at will be locked.  Also, it will contain the additional
> reference which was taken on @folio by the caller.
> 
> .
> 


