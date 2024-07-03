Return-Path: <linux-fsdevel+bounces-23008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A506592568B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 11:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E1222889BF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 09:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A87E13D2B5;
	Wed,  3 Jul 2024 09:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hiJmdn5/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9C113C8EE;
	Wed,  3 Jul 2024 09:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719998490; cv=none; b=qAWlS6NbMak+iKcJ1lXlQu8vMCfez10vexgz9gzE3FvmKN2/41w8JByWMH65GrCS7n66vjx2snA0X2oDdrHYePXp5uWnuhkv0uTqHKGginD1AYTpbaTxr/L79Ijce116Rhcf0FXNtomATZqG7d13zZ3bAo8JFWczZV4X0sAjZp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719998490; c=relaxed/simple;
	bh=LuBxYBzCQ3t5eskA78KO4HNCqbdC06CI70/S0+JsLj4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fcxiYRFDkbql+kB1QWnJvjATyxD+ddqA5uLQ3lOic46YMBNeFZ7vuizRLt0auvQAIuzZ3e+V8lLVIF2Qmsduuetsu/9s3ee0sqTH7s7motweSdgHFBiFDWewjzNS1uSqmlvK9ogcjKYOfCeIpklmvqnsWvKp3BaUGOjM4A6UiL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hiJmdn5/; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=BTnss
	Ax2cxCnOWayOPuWiQqj81ayGW11i7bWdYf4BJo=; b=hiJmdn5/r1tETI0cFNGMu
	KP4M134fRLE3XF8DtHruRuzVy/vGGHGU9+fl/hNk9lCGVZc+0cb7s2kmVfYxOD5C
	e93prtr44x+v7DiHu7iO1yBtl8dMg6t6007MYg9ffXBDU8QHfCH4yHMSczAL7kXf
	9gf2Zm1KBJdOCAUvdDiBqo=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mta-g0-0 (Coremail) with SMTP id _____wD3P3TXF4Vmr+vYBQ--.20081S4;
	Wed, 03 Jul 2024 17:20:25 +0800 (CST)
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
Date: Wed,  3 Jul 2024 09:20:23 +0000
Message-Id: <20240703092023.76749-1-ranxiaokai627@163.com>
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
X-CM-TRANSID:_____wD3P3TXF4Vmr+vYBQ--.20081S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFyfAw17Xr15ZrWrXF48tFb_yoW5Cw15pF
	WYkFyqyr4DG3sYyr1Ivw1qyry8Gr98ZayUta43Cr17uF9xJF92qrW0y3s8A3W3Ar4rZ3ZF
	vFWUWF4qv3W5ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUN189UUUUU=
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/1tbiqRIMTGVOBJWk7QABsJ

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
>
>
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
>
>2) Anon THP are disabled as default. If some custom tool cannot deal
>    with that "extension" we did with smaller THP, it shall be updated if
>    it really has to special-case PMD-mapped THP, before enabled by the
>    admin.
>
>
>I think this interface does exactly what we want, as it is right now. 
>Unless there is *good* reason, we should keep it like that.
>
>So I suggest
>
>a) Extend the documentation to just state "THP of any size and any 
>mapping granularity" or sth like that.
>
>b) Maybe using folio_test_large_rmappable() instead of "(k & (1 <<
>    PG_lru)) || is_anon", so even isolated-from-LRU THPs are indicated
>    properly.

Hi, David,

The "is_anon" check was introduced to also include page vector cache
pages, but now large folios are added to lru list directly, bypassed
the pagevec cache. So the is_anon check seems unnecessary here.
As now pagecache also supports large folios, the is_anon check seems
unsufficient here.

Can i say that for userspace memory,
folio_test_large_rmappable() == folio_test_large()?
if that is true, except the "if ((k & (1 << PG_lru)) || is_anon)"
check, we can also remove the folio_test_large() check,
like this:

else if (folio_test_large_rmappable(folio)) {
        u |= 1 << KPF_THP;
    else if (is_huge_zero_folio(folio)) {
        u |= 1 << KPF_ZERO_PAGE;
        u |= 1 << KPF_THP;
    }
} else if (is_zero_pfn(page_to_pfn(page)))

This will also include the isolated folios.

>c) Whoever is interested in getting the folio size, use this flag along
>    with a scan for the KPF_COMPOUND_HEAD.
>
>
>I'll note that, scanning documentation, PAGE_IS_HUGE currently only 
>applies to PMD *mapped* THP. It doesn't consider PTE-mapped THP at all 
>(including PMD-ones). Likely, documentation should be updated to state 
>"PMD-mapped THP or any hugetlb page".
>
>> Also kpageflags is not only for userspace memory but for all valid pfn
>> pages,including slab pages or drivers used pages, so the PG_lru and
>> is_anon check are unnecessary here.
>
>I'm completely confused about that statements. We do have KPF_OFFLINE, 
>KPF_PGTABLE, KPF_SLAB, ... I'm missing something important.


