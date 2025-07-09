Return-Path: <linux-fsdevel+bounces-54344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E00AFE4C7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 12:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EB9B1887500
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 10:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E92288C81;
	Wed,  9 Jul 2025 09:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="iMW6PKHA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1830424B26;
	Wed,  9 Jul 2025 09:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055158; cv=none; b=gsIxtMA9oNxoHryeb/2AeP9WHK9py2TcW5sDGhX7WL8DnJcnjzsksJQU4f/25ICigOnMf6YZXIm14pAhXv+LuHCG3nUiRC3m6ucHESweZyw7OPvaVUDAFgW1xZHVJMPJwCcISFIXZ8+XqwXLpYGEtyreJQDtSkLu1LF2Km0lbj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055158; c=relaxed/simple;
	bh=V3I5hLDpVu9hQyAkfXoHs+QWYvl3bUpi55121rBny4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YC7M1VQRBnSnsYFnZ+xmEFOEjAxNy6OMXIhAlNCaCazqlHeTullCxw59W/4NkJCWND0cYKLTwKvBgIj+gy1AQZpUz524omaYQmBJTJlSXcg/tF3vTBLhZkBTTgFEkVF9d4rPlGhZGpTfPJrG2cUk6TZX3LK+wXQWztvt0M7abIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=iMW6PKHA; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bcYNJ6s2Wz9sSf;
	Wed,  9 Jul 2025 11:59:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1752055153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MaNm/Rqy67eO1HZemeROtIk1IORMMZeTew+oRtrvGkQ=;
	b=iMW6PKHALmPyYY17kX+7z/UasELzVAlOwMHkXhfmMfYQ/HGql/rTF8RnQV/PY/RKU2dbTv
	Q1wW0tPyR4pJpPZukYuAdQh7+xBhk+xD18a/CmM7ZQf1WuimGQjMXFOVqCLMCIptjtbVat
	NM9TO+Vu4oJiQDPY6wTAbYUO3uWnNXxqlsxu6CY5Mi7Wm3KcYBnb5jjtoU4s5bojivYl6d
	au6Jm0/uFu4tf9hZPt5U/AyAyhzkpH/XE0Fq7fEGRjMd/NnirMwGNMKOAUNX/b/3sBuWaV
	Dyytuh906m1aINvPOuiJvUzah44GbnrgicnGClNOIJaF4X4YJfRO/swAnCxFbQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
Message-ID: <3ed1e744-5536-4b47-a5ab-66cd300ded67@pankajraghav.com>
Date: Wed, 9 Jul 2025 11:59:00 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/5] add static PMD zero page support
To: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michal Hocko <mhocko@suse.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Thomas Gleixner <tglx@linutronix.de>,
 Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>,
 linux-kernel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org,
 x86@kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
 gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
 <20250707153844.d868f7cfe16830cce66f3929@linux-foundation.org>
Content-Language: en-US
From: Pankaj Raghav <kernel@pankajraghav.com>
In-Reply-To: <20250707153844.d868f7cfe16830cce66f3929@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4bcYNJ6s2Wz9sSf

Hi Andrew,

>> We already have huge_zero_folio that is allocated on demand, and it will be
>> deallocated by the shrinker if there are no users of it left.
>>
>> At moment, huge_zero_folio infrastructure refcount is tied to the process
>> lifetime that created it. This might not work for bio layer as the completions
>> can be async and the process that created the huge_zero_folio might no
>> longer be alive.
> 
> Can we change that?  Alter the refcounting model so that dropping the
> final reference at interrupt time works as expected?
> 

That is an interesting point. I did not try it. At the moment, we always drop the reference in
__mmput().

Going back to the discussion before this work started, one of the main thing that people wanted was
to use some sort of a **drop in replacement** for ZERO_PAGE that can be bigger than PAGE_SIZE[1].

And, during the RFCs of these patches, one of the feedback I got from David was in big server
systems, 2M (in the case of 4k page size) should not be a problem and we don't need any unnecessary
refcounting for them.

Also when I had a chat with David, he also wants to make changes to the existing mm_huge_zero_folio
infrastructure to get rid of shrinker if possible. So we decided that it is better to have opt-in
static allocation and keep the existing dynamic allocation path.

So that is why I went with this approach of having a static PMD allocation.

I hope this clarifies the motivation a bit.

Let me know if you have more questions.

> And if we were to do this, what sort of benefit might it produce?
> 
>> Add a config option STATIC_PMD_ZERO_PAGE that will always allocate
>> the huge_zero_folio via memblock, and it will never be freed.
[1] https://lore.kernel.org/linux-xfs/20231027051847.GA7885@lst.de/

