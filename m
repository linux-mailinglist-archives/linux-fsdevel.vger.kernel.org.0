Return-Path: <linux-fsdevel+bounces-22624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1AB91A6D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 14:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 661BFB26739
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 12:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB79917838D;
	Thu, 27 Jun 2024 12:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="S0y+nBbM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FC2149DE1;
	Thu, 27 Jun 2024 12:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719492441; cv=none; b=QthhATtTnE+dIs4RI6x1Fqza7oXKdwJXrwm2Ffe4qkst42JHtC8C4y+063PqZsFqkQWDQK/BqDmhkgCNH+6rkvPldy6OAKeg6qPAmhpgu8CdFf2T3Fihq53mYWZ+H76N/32iAtdkSdvB0RY7EJ19RHhLgTjFi3swxpWKarGPch4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719492441; c=relaxed/simple;
	bh=9O0e0/pVQKRPZRpTviOM9puWuTW1NUrnLncr2TIKr88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PhAfLpCILBVX7s8PZDvaL1HCVGOzidddAVSMSqyeuvMO8IW/Y0cQ9WAkCUoxL52LdgomgLvMmJR3DX9fkoYy44AiikMoIW9kIXJcNdk2Lo2ByAP+EfjlOGsl7iWmiZ6mOcnxPODJFkJcnxx73JWkdMjJLfc+XDyBuCj49nb9UWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=S0y+nBbM; arc=none smtp.client-ip=45.254.50.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=pIFig
	ibXxiJl8Xxkvx7dP2YimD87atVk5KkBCJ4OxgE=; b=S0y+nBbMS3giy7EKQn5tD
	DJeTJcxZ/hSPb7pJFhAdVnA7BmDMNU0KCilVPycc62EdlxfOQ/kELnWUskfgIK/r
	GZ3lXS/wXYH2R4f34UvDdx7cRaEKAP9Vwb9jpLdvkmqu3cWqTHC++kZbL4BkPAAp
	asSxlvKD1TP/lgBcYYCBb4=
Received: from localhost.localdomain (unknown [193.203.214.57])
	by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wDHr84VX31mAubSAg--.63733S4;
	Thu, 27 Jun 2024 20:46:15 +0800 (CST)
From: ran xiaokai <ranxiaokai627@163.com>
To: ryan.roberts@arm.com
Cc: 21cnbao@gmail.com,
	akpm@linux-foundation.org,
	baolin.wang@linux.alibaba.com,
	david@redhat.com,
	ioworker0@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	peterx@redhat.com,
	ran.xiaokai@zte.com.cn,
	ranxiaokai627@163.com,
	svetly.todorov@memverge.com,
	vbabka@suse.cz,
	yang.yang29@zte.com.cn,
	si.hao@zte.com.cn,
	wangkefeng.wang@huawei.com,
	willy@infradead.org,
	ziy@nvidia.com
Subject: Re: [PATCH 2/2] kpageflags: fix wrong KPF_THP on non-pmd-mappable compound pages
Date: Thu, 27 Jun 2024 12:46:13 +0000
Message-Id: <20240627124613.23377-1-ranxiaokai627@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <4e1a1878-4133-4d78-90fa-1d5bc99d179c@arm.com>
References: <4e1a1878-4133-4d78-90fa-1d5bc99d179c@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHr84VX31mAubSAg--.63733S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF48Wr4kXr15JF4kKrW7urg_yoWrKryUpF
	yrtFyDtF4ktr4Fyr17tw4UtFy8Kr13XFWrWr98Ary8Zwn0qrnrur17G3y09F9rZrn7Ar1j
	vF4jvF93ua4qvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUrxhQUUUUU=
X-CM-SenderInfo: xudq5x5drntxqwsxqiywtou0bp/xtbB0hkLTGWXyo-slAAAsD

>On 27/06/2024 10:16, Barry Song wrote:
>> On Thu, Jun 27, 2024 at 8:39?PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>
>>> On 27/06/2024 05:10, Barry Song wrote:
>>>> On Thu, Jun 27, 2024 at 2:40?AM Zi Yan <ziy@nvidia.com> wrote:
>>>>>
>>>>> On Wed Jun 26, 2024 at 7:07 AM EDT, Ryan Roberts wrote:
>>>>>> On 26/06/2024 04:06, Zi Yan wrote:
>>>>>>> On Tue Jun 25, 2024 at 10:49 PM EDT, ran xiaokai wrote:
>>>>>>>> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
>>>>>>>>
>>>>>>>> KPF_COMPOUND_HEAD and KPF_COMPOUND_TAIL are set on "common" compound
>>>>>>>> pages, which means of any order, but KPF_THP should only be set
>>>>>>>> when the folio is a 2M pmd mappable THP.
>>>>>>
>>>>>> Why should KPF_THP only be set on 2M THP? What problem does it cause as it is
>>>>>> currently configured?
>>>>>>
>>>>>> I would argue that mTHP is still THP so should still have the flag. And since
>>>>>> these smaller mTHP sizes are disabled by default, only mTHP-aware user space
>>>>>> will be enabling them, so I'll naively state that it should not cause compat
>>>>>> issues as is.
>>>>>>
>>>>>> Also, the script at tools/mm/thpmaps relies on KPF_THP being set for all mTHP
>>>>>> sizes to function correctly. So that would need to be reworked if making this
>>>>>> change.
>>>>>
>>>>> + more folks working on mTHP
>>>>>
>>>>> I agree that mTHP is still THP, but we might want different
>>>>> stats/counters for it, since people might want to keep the old THP counters
>>>>> consistent. See recent commits on adding mTHP counters:
>>>>> ec33687c6749 ("mm: add per-order mTHP anon_fault_alloc and anon_fault_fallback
>>>>> counters"), 1f97fd042f38 ("mm: shmem: add mTHP counters for anonymous shmem")
>>>>>
>>>>> and changes to make THP counter to only count PMD THP:
>>>>> 835c3a25aa37 ("mm: huge_memory: add the missing folio_test_pmd_mappable() for
>>>>> THP split statistics")
>>>>>
>>>>> In this case, I wonder if we want a new KPF_MTHP bit for mTHP and some
>>>>> adjustment on tools/mm/thpmaps.
>>>>
>>>> It seems we have to do this though I think keeping KPF_THP and adding a
>>>> separate bit like KPF_PMD_MAPPED makes more sense. but those tools
>>>> relying on KPF_THP need to realize this and check the new bit , which is
>>>> not done now.
>>>> whether the mTHP's name is mTHP or THP will make no difference for
>>>> this case:-)
>>>
>>> I don't quite follow your logic for that last part; If there are 2 separate
>>> bits; KPF_THP and KPF_MTHP, and KPF_THP is only set for PMD-sized THP, that
>>> would be a safe/compatible approach, right? Where as your suggestion requires
>>> changes to existing tools to work.
>> 
>> Right, my point is that mTHP and THP are both types of THP. The only difference
>> is whether they are PMD-mapped or PTE-mapped. Adding a bit to describe how
>> the page is mapped would more accurately reflect reality. However, this change
>> would disrupt tools that assume KPF_THP always means PMD-mapped THP.
>> Therefore, we would still need separate bits for THP and mTHP in this case.
>
>I think perhaps PTE- vs PMD-mapped is a separate issue. The issue at hand is
>whether PKF_THP implies a fixed size (and alignment). If compat is an issue,
>then PKF_THP must continue to imply PMD-size. If compat is not an issue, then
>size can be determined by iterating over the entries.
>
>Having a mechanism to determine the level at which a block is mapped would
>potentially be a useful feature, but seems orthogonal to me.
>
>> 
>> I saw Willy complain about mTHP being called "mTHP," but in this case, calling
>> it "mTHP" or just "THP" doesn't change anything if old tools continue to assume
>> that KPF_THP means PMD-mapped THP.
>
>I think Willy was just ribbing me because he preferred calling it "anonymous
>large folios". That's how I took it anyway.
>
>> 
>>>
>>> Thinking about this a bit more, I wonder if PKF_MTHP is the right name for a new
>>> flag; We don't currently expose the term "mTHP" to user space. I can't think of
>>> a better name though.
>> 
>> Yes.  If "compatibility" is a requirement, we cannot disregard it.
>> 
>>> I'd still like to understand what is actually broken that this change is fixing.
>>> Is the concern that a user could see KPF_THP and advance forward by
>>> "/sys/kernel/mm/transparent_hugepage/hpage_pmd_size / getpagesize()" entries?
>>>
>> 
>> Maybe we need an example which is thinking that KPF_THP is PMD-mapped.
>
>Yes, that would help.

For now it is the testcase in tools/testing/selftests/mm/split_huge_page_test,
if we try to split THP to other orders other than 0, the testcase will break.

Maybe we can use KPF_COMPOUND_HEAD and KPF_COMPOUND_TAIL to figure out
the compound page's start/end and the order. But these two flags are not
for userspace memory only.


