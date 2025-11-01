Return-Path: <linux-fsdevel+bounces-66648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 217A6C27404
	for <lists+linux-fsdevel@lfdr.de>; Sat, 01 Nov 2025 01:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E70A4EAFD0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Nov 2025 00:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F8E3B1AB;
	Sat,  1 Nov 2025 00:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/GT2GTJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838FB9460
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Nov 2025 00:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761955732; cv=none; b=VN6KdZHYLv82auGaZV/l3nAaCg47zvGpYn7sjeD/k6QNwmmEugOaJMzDkyV6hmvtc0BeZFGhRuwJQq4CVpOFXqyb44ejz6o7/l04RjmAiS8FajqH3cqJWB5OqfUmylkW8yinJnHVoBZiMT7gp/5JeVjhrexZdUkEkomTGKf95oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761955732; c=relaxed/simple;
	bh=gMO6yCCzVGtoonPwgki9tGmJDQ++26GAnyf7kETHpJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jotOddAok5DS0/lHwBw/SBFTY8u4dCeIYWPO/pit680JOVIhpt7aHU8b4WKZ+kRYSNmkm/yyP5VG+CM+vAz57lr6IcOY9GFLzTt5Do4rjfDKVj4L7LzNifl6eD1f1gtG3u4DGSSWG2kA3zBHcBzAuuHNzMNOonYFA2bIwlCNVTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/GT2GTJ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b6d53684cfdso597938666b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 17:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761955729; x=1762560529; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqXAJAEFd904kI53cyI6EmfD14ywqnwjSyxvJFGdSTo=;
        b=I/GT2GTJnyFP+sonw2c+7qcr87l0Z1c/Fw1rVpmnONaDoh/5EdI9pmDlDAKOfZZV2f
         N96NHv94e+Rvn6PxBsfgIwDKrlRUpWGEB533sECvANRPgczyIvAckJavIoQsOf0W3sYg
         fmpocS0SqlV83PLyhKaJ5HKyrRMlIu9+1Ct2PdTQElKis32dJtN3VTainI8/FVCqKYt+
         FxMGObFPAI82o7pC2ouDkA5wO659s6YkrSNTMvbG4ilY07/lEvhH0e+ITcQjiSEqOLR2
         J4pruLDD95umSo9J9/zKPmzcrC+BCy4YdoQ1aRJbRywJgVQKMFWfz+in5qSFggVp66AD
         A9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761955729; x=1762560529;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tqXAJAEFd904kI53cyI6EmfD14ywqnwjSyxvJFGdSTo=;
        b=iraZEkb/299G0TVpH7aTnsz+B4WOnsT6q70pbv0BRD43h0thTsPKWC3VHImlfJMcrX
         qMfHFQImEhWDPRu+moDpj2uWVHYYZDkop9KylOroXeVlMrCkAN+Sy5mCE2vE0V4liCbH
         PNVqayDtImnby7whpOtGDAmBJJOXNQSd6j6DSj2JDg+hAPpp+cM1dXh+spSSNwAjA3iC
         9zM5ZxZ094yOUmptZxajdf0O/XXTC+E3lYqgM/Q/omfkFPUJkzxNr5I54HF6wS3DE0eN
         qck5p5E5fUI35XPwJPHaRZWrXqTKtlVYrFt+UlAA+qtujJdw9CMAjdxRIbJLp+1xAOJX
         IZRg==
X-Forwarded-Encrypted: i=1; AJvYcCV2I13by57QzmRAyqMj1v1gpJdNylQhcAm2uvzU5iSLACQC4gp+Ygu+YzW/eVx69qQxvZgkZe/U7YV58fFv@vger.kernel.org
X-Gm-Message-State: AOJu0YyE3Y/KK6yCzVkG48jDLIhkZJdoExsy1d5HFp0onXGfPvxXTwco
	KS693dJ5HtHC8Lyum7T54Nuq82vXgRrTxeDXaUDda5hfcZ+9j1Yad4aX
X-Gm-Gg: ASbGncuF7axWZtuR8Sh9fCpcqn23rXPOBsztEd1NxzNsWyqKcqZGMWztTvIKwYjlTk9
	3qpzoM+oUgJHBL0KwKteHNOsFoHdNKg2x74zD+kswkzOSL8O7GgfzGd9gicpA9HCUx1sv0XBsjW
	+p78veqvdWKzeKis98kkPZc6wH+fDQmdrovj/H6nzwAEbOniHqxnlh+zT480YyqI6WIRl/qnJvw
	G/0kj99da87gNkX0YUMXl2vKVHEpYKyaOPt0cuzEAP/msx7+u2iWQGCo7U01bmqwqKIQmU1lcha
	cpSOegRZecZ/PH+teqx2Ef/zujD865SRVS0EtEfpvobiHKYDKJseHXZFuCyVWDKlX9EewzEu4VX
	mMJ78y05/zZK/Hvi5YaV/1U/WpCBxbB60qknNEadvSnoJegtzYrjKxZicH88pSjNyMJhqAmZGwU
	MmoEMWuFAlJA==
X-Google-Smtp-Source: AGHT+IEwMGMxJ1HbzA7e85hEVqx/WAPxKz46lBfAPL00PToE30wxaTZd53z+QG8i0UJAYghIe/jUag==
X-Received: by 2002:a17:907:608d:b0:b40:b54d:e687 with SMTP id a640c23a62f3a-b70706271c3mr339730266b.47.1761955728728;
        Fri, 31 Oct 2025 17:08:48 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077976075sm308313966b.3.2025.10.31.17.08.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Oct 2025 17:08:48 -0700 (PDT)
Date: Sat, 1 Nov 2025 00:08:47 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Zi Yan <ziy@nvidia.com>
Cc: akpm@linux-foundation.org, Wei Yang <richard.weiyang@gmail.com>,
	linmiaohe@huawei.com, david@redhat.com, jane.chu@oracle.com,
	kernel@pankajraghav.com, mcgrof@kernel.org, nao.horiguchi@gmail.com,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Yang Shi <shy828301@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 3/3] mm/huge_memory: fix kernel-doc comments for
 folio_split() and related.
Message-ID: <20251101000847.3ht26lmiug6aznsh@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251031162001.670503-1-ziy@nvidia.com>
 <20251031162001.670503-4-ziy@nvidia.com>
 <20251031233610.ftpqyeosb4cedwtp@master>
 <BE7AC5F3-9E64-4923-861D-C2C4E0CB91EB@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BE7AC5F3-9E64-4923-861D-C2C4E0CB91EB@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Fri, Oct 31, 2025 at 07:52:28PM -0400, Zi Yan wrote:
>On 31 Oct 2025, at 19:36, Wei Yang wrote:
>
>> On Fri, Oct 31, 2025 at 12:20:01PM -0400, Zi Yan wrote:
>> [...]
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 0e24bb7e90d0..ad2fc52651a6 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -3567,8 +3567,9 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
>>> 		ClearPageCompound(&folio->page);
>>> }
>>>
>>> -/*
>>> - * It splits an unmapped @folio to lower order smaller folios in two ways.
>>> +/**
>>> + * __split_unmapped_folio() - splits an unmapped @folio to lower order folios in
>>> + * two ways: uniform split or non-uniform split.
>>>  * @folio: the to-be-split folio
>>>  * @new_order: the smallest order of the after split folios (since buddy
>>>  *             allocator like split generates folios with orders from @folio's
>>> @@ -3589,22 +3590,22 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
>>>  *    uniform_split is false.
>>>  *
>>>  * The high level flow for these two methods are:
>>> - * 1. uniform split: a single __split_folio_to_order() is called to split the
>>> - *    @folio into @new_order, then we traverse all the resulting folios one by
>>> - *    one in PFN ascending order and perform stats, unfreeze, adding to list,
>>> - *    and file mapping index operations.
>>> - * 2. non-uniform split: in general, folio_order - @new_order calls to
>>> - *    __split_folio_to_order() are made in a for loop to split the @folio
>>> - *    to one lower order at a time. The resulting small folios are processed
>>> - *    like what is done during the traversal in 1, except the one containing
>>> - *    @page, which is split in next for loop.
>>> + * 1. uniform split: @xas is split with no expectation of failure and a single
>>> + *    __split_folio_to_order() is called to split the @folio into @new_order
>>> + *    along with stats update.
>>> + * 2. non-uniform split: folio_order - @new_order calls to
>>> + *    __split_folio_to_order() are expected to be made in a for loop to split
>>> + *    the @folio to one lower order at a time. The folio containing @page is
>>
>> Hope it is not annoying.
>>
>> The parameter's name is @split_at, maybe we misuse it?
>>
>> s/containing @page/containing @split_at/
>>
>>> + *    split in each iteration. @xas is split into half in each iteration and
>>> + *    can fail. A failed @xas split leaves split folios as is without merging
>>> + *    them back.
>>>  *
>>>  * After splitting, the caller's folio reference will be transferred to the
>>>  * folio containing @page. The caller needs to unlock and/or free after-split
>>
>> The same above.
>>
>> And probably there is another one in above this comment(not shown here).
>
>Hi Andrew,
>
>Do you mind applying this fixup to address Wei's concerns?
>
>Thanks.
>
>From e1894a4e7ac95bdfe333cf5bee567f0ff90ddf5d Mon Sep 17 00:00:00 2001
>From: Zi Yan <ziy@nvidia.com>
>Date: Fri, 31 Oct 2025 19:50:55 -0400
>Subject: [PATCH] mm/huge_memory: kernel-doc fixup
>
>Signed-off-by: Zi Yan <ziy@nvidia.com>
>---
> mm/huge_memory.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)
>
>diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>index ad2fc52651a6..a30fee2001b5 100644
>--- a/mm/huge_memory.c
>+++ b/mm/huge_memory.c
>@@ -3586,7 +3586,7 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
>  *    uniform_split is true.
>  * 2. buddy allocator like (non-uniform) split: the given @folio is split into
>  *    half and one of the half (containing the given page) is split into half
>- *    until the given @page's order becomes @new_order. This is done when
>+ *    until the given @folio's order becomes @new_order. This is done when
>  *    uniform_split is false.
>  *
>  * The high level flow for these two methods are:
>@@ -3595,14 +3595,14 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
>  *    along with stats update.
>  * 2. non-uniform split: folio_order - @new_order calls to
>  *    __split_folio_to_order() are expected to be made in a for loop to split
>- *    the @folio to one lower order at a time. The folio containing @page is
>- *    split in each iteration. @xas is split into half in each iteration and
>+ *    the @folio to one lower order at a time. The folio containing @split_at
>+ *    is split in each iteration. @xas is split into half in each iteration and
>  *    can fail. A failed @xas split leaves split folios as is without merging
>  *    them back.
>  *
>  * After splitting, the caller's folio reference will be transferred to the
>- * folio containing @page. The caller needs to unlock and/or free after-split
>- * folios if necessary.
>+ * folio containing @split_at. The caller needs to unlock and/or free
>+ * after-split folios if necessary.
>  *
>  * Return: 0 - successful, <0 - failed (if -ENOMEM is returned, @folio might be
>  * split but not to @new_order, the caller needs to check)
>-- 
>2.51.0
>
>

Thanks.

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

>
>
>--
>Best Regards,
>Yan, Zi

-- 
Wei Yang
Help you, Help me

