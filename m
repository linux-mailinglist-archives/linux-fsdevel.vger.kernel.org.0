Return-Path: <linux-fsdevel+bounces-22721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F2891B537
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 05:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CBEC1C216BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 03:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9E41CA8A;
	Fri, 28 Jun 2024 03:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qba0I7in"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9197C1BF37;
	Fri, 28 Jun 2024 03:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719543762; cv=none; b=EN1h1fYTq4fLSGCE79jxEm5VepktKDuo2QAWciVFoGFfqVqHfZ5AOTnCyFiXUba4qllcrVXfS8IiY+3zQczrVAjqW6UpCGQjK7EmZESZppIGG2tA57I1R5gGn35EuLHpk6xkp0to6RZ6f3zET13olrqz6TITKbH6fLDvMygQdw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719543762; c=relaxed/simple;
	bh=1NrxczpmN4bxmVpjUaGYnOOj6Lak5FUxVpqQZrkS0MI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iceGAej7+WMIAycgTy900u3UhIdjf+9+grVSw2ZJ8ZocTk2ZchyNl4LENtKWq3XIDdWBi7axuW5BR+BroiQHSCox7Gk6w5Gh3aT/KdgN86jHmCkZnldK16p+rem2StYrBgkl6Tg3I9zifLH973UxzrQ/Be+CP1CyhDLXF1uNTXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qba0I7in; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=LqCEG
	j6lMZuJHj86R+aZ0jn06rkwtuAQt/xBP5lb1fA=; b=qba0I7inz0fYvLov7dUDd
	yztP0vKgvpKYji3U5dbdN7doofy5701f3ETN3z7641rC1fYTsMcPZQ7xZUdod8zs
	HtZ43pTunFsIxUbMjmdqwfVAf02/ycuwMPaGuwUfGlTBb3iyOluugojMaJM8MLvH
	76lxCxmjg3D03iNIJ4r+mY=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mta-g2-3 (Coremail) with SMTP id _____wDnHpiXJ35mN8MXAg--.32613S4;
	Fri, 28 Jun 2024 11:01:45 +0800 (CST)
From: ran xiaokai <ranxiaokai627@163.com>
To: david@redhat.com
Cc: akpm@linux-foundation.org,
	baohua@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	peterx@redhat.com,
	ran.xiaokai@zte.com.cn,
	ranxiaokai627@163.com,
	ryan.roberts@arm.com,
	svetly.todorov@memverge.com,
	vbabka@suse.cz,
	willy@infradead.org,
	ziy@nvidia.com
Subject: Re: [PATCH 2/2] kpageflags: fix wrong KPF_THP on non-pmd-mappable compound pages
Date: Fri, 28 Jun 2024 03:01:43 +0000
Message-Id: <20240628030143.27191-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1fddf73d-577f-4b4c-996a-818dd99eb489@redhat.com>
References: <1fddf73d-577f-4b4c-996a-818dd99eb489@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnHpiXJ35mN8MXAg--.32613S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFyfAw17Xr15ZFWfZw4rAFb_yoWrWrWxpF
	W5KF92yw4DJ3Z0kr1xXw1jyryFgr98WF4jyFy3Kw1xZrs8t3Z7KrW8tw1rA3W7JrWxXF4I
	vayjgF9093Z8ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUN189UUUUU=
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/1tbiqRIMTGVOBJWk6wAAsO

>On 26.06.24 04:49, ran xiaokai wrote:
>> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>> 
>> KPF_COMPOUND_HEAD and KPF_COMPOUND_TAIL are set on "common" compound
>> pages, which means of any order, but KPF_THP should only be set
>> when the folio is a 2M pmd mappable THP. Since commit 19eaf44954df
>
>"should only be set" -- who says that? :)
>
>The documentation only talks about "Contiguous pages which construct 
>transparent hugepages". Sure, when it was added there were only PMD ones.

Hi, David,
I am working on tools/testing/selftests/mm/split_huge_page_test to support
splitint THP to more orders, not only order-0, and the testcases failed.
It seems the testcodes rely on KPF_THP to indicate only 2M THP.

>> ("mm: thp: support allocation of anonymous multi-size THP"),
>> multiple orders of folios can be allocated and mapped to userspace,
>> so the folio_test_large() check is not sufficient here,
>> replace it with folio_test_pmd_mappable() to fix this.
>> 
>
>A couple of points:
>
>1) If I am not daydreaming, ever since we supported non-PMD THP in the
>    pagecache (much longer than anon mTHP), we already indicate KPF_THP
>    for them here. So this is not anon specific? Or am I getting the
>    PG_lru check all wrong?

Thanks for the clarification.

>2) Anon THP are disabled as default. If some custom tool cannot deal
>    with that "extension" we did with smaller THP, it shall be updated if
>    it really has to special-case PMD-mapped THP, before enabled by the
>    admin.

ok, it seems that it is the testcodes which should be updated.

>
>I think this interface does exactly what we want, as it is right now. 
>Unless there is *good* reason, we should keep it like that.
>
>So I suggest
>
>a) Extend the documentation to just state "THP of any size and any 
>mapping granularity" or sth like that.

yes, it is neccessay to update the documentation to make it more clear.
Since the definition of KPF_THP has been expanded since it was firstly introduced.

>b) Maybe using folio_test_large_rmappable() instead of "(k & (1 <<
>    PG_lru)) || is_anon", so even isolated-from-LRU THPs are indicated
>    properly.

i will investigate on this.

>c) Whoever is interested in getting the folio size, use this flag along
>    with a scan for the KPF_COMPOUND_HEAD.

yes, we can use the combination of KPF_COMPOUND_HEAD and KPF_COMPOUND_TAIL
to figure out the compound order.

>
>I'll note that, scanning documentation, PAGE_IS_HUGE currently only 
>applies to PMD *mapped* THP. It doesn't consider PTE-mapped THP at all 
>(including PMD-ones). Likely, documentation should be updated to state 
>"PMD-mapped THP or any hugetlb page".

i will also investigate on this.

>> Also kpageflags is not only for userspace memory but for all valid pfn
>> pages,including slab pages or drivers used pages, so the PG_lru and
>> is_anon check are unnecessary here.
>
>I'm completely confused about that statements. We do have KPF_OFFLINE, 
>KPF_PGTABLE, KPF_SLAB, ... I'm missing something important.

My statement is wrong, please ignore this.

>> 
>> Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>> ---
>>   fs/proc/page.c | 14 ++++----------
>>   1 file changed, 4 insertions(+), 10 deletions(-)
>> 
>> diff --git a/fs/proc/page.c b/fs/proc/page.c
>> index 2fb64bdb64eb..3e7b70449c2f 100644
>> --- a/fs/proc/page.c
>> +++ b/fs/proc/page.c
>> @@ -146,19 +146,13 @@ u64 stable_page_flags(const struct page *page)
>>   		u |= kpf_copy_bit(k, KPF_COMPOUND_HEAD, PG_head);
>>   	else
>>   		u |= 1 << KPF_COMPOUND_TAIL;
>> +
>>   	if (folio_test_hugetlb(folio))
>>   		u |= 1 << KPF_HUGE;
>> -	/*
>> -	 * We need to check PageLRU/PageAnon
>> -	 * to make sure a given page is a thp, not a non-huge compound page.
>> -	 */
>> -	else if (folio_test_large(folio)) {
>> -		if ((k & (1 << PG_lru)) || is_anon)
>> -			u |= 1 << KPF_THP;
>> -		else if (is_huge_zero_folio(folio)) {
>> +	else if (folio_test_pmd_mappable(folio)) {
>
>folio_test_pmd_mappable() would not be future safe. It includes anything 
> >= PMD_ORDER as well.
>
>
>-- 
>Cheers,
>
>David / dhildenb


