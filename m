Return-Path: <linux-fsdevel+bounces-65057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A889EBFA44E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 08:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADB545846EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 06:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1DE2EF665;
	Wed, 22 Oct 2025 06:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="fEux8RY7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C9E2EE60B;
	Wed, 22 Oct 2025 06:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761115178; cv=none; b=oj/3N5F/ZxH7WctOOLDydWfll4679ye0p3QAcTRzcpI+5J1NO4kukE4KQ5RXUY7I5/n8bIzOoWqFLzIpK39CWAb43mNpatDeNOZEpSxwVRZfHtRNwTUTK9Lm7ABhLJePMODoQjVJzCrMkdbsOSe/40xmNfJaB2kd4/7jUWkeLGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761115178; c=relaxed/simple;
	bh=2XDerOMWHsYth7c9RPiqiOMv9Pf6Ok5nLiwCvpim1Io=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=shW6ndNzWkn67lZ9wWNsTQMCjKxibDMYopHAFyDxRlP4TJKxWHwfdnkt+S7UM00pU9f+dii1zUd9k+MGLS8x0Y4b9fFiM6HUzXCP05GMPbd+slwYTM7Qjn1inL7+qEo09fuNO9g88bMWAJut12GM0NZjclJm43ajQb7iFebnZf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=fEux8RY7; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=9YszbItFa8+6g0CApeKe+tj/OKRQ7kdza/2EO8OVt+k=;
	b=fEux8RY7JKOtPA/+t8JeDlCiLLgkFsovxTzM67kKnEdmP/wob1n3bYU478R/SJGfbOzsmmjqN
	T0Uv28VcXq3y4Oql5YG1S8wtyy9lGKg4k1rh6o3jJG8NS+pkPB5F/E11kHVet3z3pjxYmUAcNJZ
	c1+wpfATD92Jsum/pf4f8EE=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4crzyz20FrzKm6d;
	Wed, 22 Oct 2025 14:39:07 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id A829A1800CF;
	Wed, 22 Oct 2025 14:39:31 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 22 Oct 2025 14:39:28 +0800
Received: from [10.173.125.37] (10.173.125.37) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 22 Oct 2025 14:39:26 +0800
Subject: Re: [PATCH v2 2/3] mm/memory-failure: improve large block size folio
 handling.
To: Zi Yan <ziy@nvidia.com>
CC: <david@redhat.com>, <kernel@pankajraghav.com>,
	<syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>, <akpm@linux-foundation.org>,
	<mcgrof@kernel.org>, <nao.horiguchi@gmail.com>, Lorenzo Stoakes
	<lorenzo.stoakes@oracle.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
	<baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, "Matthew Wilcox
 (Oracle)" <willy@infradead.org>, Wei Yang <richard.weiyang@gmail.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, Yang Shi <shy828301@gmail.com>, <jane.chu@oracle.com>
References: <20251016033452.125479-1-ziy@nvidia.com>
 <20251016033452.125479-3-ziy@nvidia.com>
 <CAHbLzkoOZm0PXxE9qwtF4gKR=cpRXrSrJ9V9Pm2DJexs985q4g@mail.gmail.com>
 <5EE26793-2CD4-4776-B13C-AA5984D53C04@nvidia.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <4238c5ed-f8ee-724e-606b-54bc1259fdd7@huawei.com>
Date: Wed, 22 Oct 2025 14:39:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5EE26793-2CD4-4776-B13C-AA5984D53C04@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2025/10/21 3:46, Zi Yan wrote:
> On 17 Oct 2025, at 15:11, Yang Shi wrote:
> 
>> On Wed, Oct 15, 2025 at 8:38 PM Zi Yan <ziy@nvidia.com> wrote:
>>>
>>> Large block size (LBS) folios cannot be split to order-0 folios but
>>> min_order_for_folio(). Current split fails directly, but that is not
>>> optimal. Split the folio to min_order_for_folio(), so that, after split,
>>> only the folio containing the poisoned page becomes unusable instead.
>>>
>>> For soft offline, do not split the large folio if it cannot be split to
>>> order-0. Since the folio is still accessible from userspace and premature
>>> split might lead to potential performance loss.
>>>
>>> Suggested-by: Jane Chu <jane.chu@oracle.com>
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
>>> ---
>>>  mm/memory-failure.c | 25 +++++++++++++++++++++----
>>>  1 file changed, 21 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>> index f698df156bf8..443df9581c24 100644
>>> --- a/mm/memory-failure.c
>>> +++ b/mm/memory-failure.c
>>> @@ -1656,12 +1656,13 @@ static int identify_page_state(unsigned long pfn, struct page *p,
>>>   * there is still more to do, hence the page refcount we took earlier
>>>   * is still needed.
>>>   */
>>> -static int try_to_split_thp_page(struct page *page, bool release)
>>> +static int try_to_split_thp_page(struct page *page, unsigned int new_order,
>>> +               bool release)
>>>  {
>>>         int ret;
>>>
>>>         lock_page(page);
>>> -       ret = split_huge_page(page);
>>> +       ret = split_huge_page_to_list_to_order(page, NULL, new_order);
>>>         unlock_page(page);
>>>
>>>         if (ret && release)
>>> @@ -2280,6 +2281,7 @@ int memory_failure(unsigned long pfn, int flags)
>>>         folio_unlock(folio);
>>>
>>>         if (folio_test_large(folio)) {
>>> +               int new_order = min_order_for_split(folio);
>>>                 /*
>>>                  * The flag must be set after the refcount is bumped
>>>                  * otherwise it may race with THP split.
>>> @@ -2294,7 +2296,14 @@ int memory_failure(unsigned long pfn, int flags)
>>>                  * page is a valid handlable page.
>>>                  */
>>>                 folio_set_has_hwpoisoned(folio);
>>> -               if (try_to_split_thp_page(p, false) < 0) {
>>> +               /*
>>> +                * If the folio cannot be split to order-0, kill the process,
>>> +                * but split the folio anyway to minimize the amount of unusable
>>> +                * pages.
>>> +                */
>>> +               if (try_to_split_thp_page(p, new_order, false) || new_order) {
>>
>> folio split will clear PG_has_hwpoisoned flag. It is ok for splitting
>> to order-0 folios because the PG_hwpoisoned flag is set on the
>> poisoned page. But if you split the folio to some smaller order large
>> folios, it seems you need to keep PG_has_hwpoisoned flag on the
>> poisoned folio.
> 
> OK, this means all pages in a folio with folio_test_has_hwpoisoned() should be
> checked to be able to set after-split folio's flag properly. Current folio
> split code does not do that. I am thinking about whether that causes any
> issue. Probably not, because:
> 
> 1. before Patch 1 is applied, large after-split folios are already causing
> a warning in memory_failure(). That kinda masks this issue.
> 2. after Patch 1 is applied, no large after-split folios will appear,
> since the split will fail.
> 
> @Miaohe and @Jane, please let me know if my above reasoning makes sense or not.
> 
> To make this patch right, folio's has_hwpoisoned flag needs to be preserved
> like what Yang described above. My current plan is to move
> folio_clear_has_hwpoisoned(folio) into __split_folio_to_order() and
> scan every page in the folio if the folio's has_hwpoisoned is set.
> There will be redundant scans in non uniform split case, since a has_hwpoisoned
> folio can be split multiple times (leading to multiple page scans), unless
> the scan result is stored.
> 
> @Miaohe and @Jane, is it possible to have multiple HW poisoned pages in
> a folio? Is the memory failure process like 1) page access causing MCE,
> 2) memory_failure() is used to handle it and split the large folio containing
> it? Or multiple MCEs can be received and multiple pages in a folio are marked
> then a split would happen?
memory_failure() is called with mf_mutex held. So I think even if multiple pages
in a folio trigger multiple MCEs at the same time, only one page will have HWPoison
flag set when splitting folio. If folio is successfully split, things look fine.
But if it fails to split folio due to e.g. extra refcnt held by others, the following
pages will see that there are already multiple pages in a folio are marked as HWPoison.
This is the scenario I can think of at the moment.

Thanks.
.


