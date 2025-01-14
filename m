Return-Path: <linux-fsdevel+bounces-39160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE17A10C25
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 17:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4CE61888D16
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 16:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B874B1C2DB2;
	Tue, 14 Jan 2025 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E8VLNTt/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C0D1ACE12
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 16:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736871744; cv=none; b=QF0gwHBVlpK1DRe526A6wQAWgZbqZREpbJ6A09KJdQCRfMeqSHl8QXXO1hXPWMzt1/i7ldTJ7TnF210t4p/gCtgRz+2K8RT1O9QOHT6IW9Txd+VbbTnz0Xer5IM93yLvTdurtSpMMT976cUiBJd/zAlK6EjWIVwQ7A9+oIrpnhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736871744; c=relaxed/simple;
	bh=4ao/NUGmaxaKVVgcyi/MaeA+sr+ghIi9JGqMpkQRUp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ILehHWhbvnEpjTVGsNGrf1eqd/iV/YKeq8/uwu9LljA0Eyisbn5hz6Ycw8F0Fss740r/VXEyqZkDiDJU2xWtm3R794t2aH3Qmwv0TpnG8pKNeLiO7R0U9vnIF74xydkFY+q2i/88i8npVA43TfAhk0GnGtZxnE1Wkq6W+FUYgL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E8VLNTt/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736871741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Gy0Ldt+ZI7Y3XWp3OlPzHMQgs1yINwkH9YDhGI10yLM=;
	b=E8VLNTt/xM4Ct+YHV1CgQdQ5PhtMwJ8MSW9OzFBWp0YKQ/wtle9K+r4SG/j/8zGoH6AdNj
	a60WRm1dbL0YZmowiVOP4gYYWQlj+v0f7j5hBSvp5fxfhqrNcomBxQWt+THgStaiO/jHrd
	OrOHDoByubYvRhTKf13Uwi3FRaZIL/Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-8ck-olCBNsyoQZ2hJPw5UQ-1; Tue, 14 Jan 2025 11:22:20 -0500
X-MC-Unique: 8ck-olCBNsyoQZ2hJPw5UQ-1
X-Mimecast-MFC-AGG-ID: 8ck-olCBNsyoQZ2hJPw5UQ
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43628594d34so31899655e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 08:22:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736871739; x=1737476539;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gy0Ldt+ZI7Y3XWp3OlPzHMQgs1yINwkH9YDhGI10yLM=;
        b=vh9s3xsQgCQm1to4/wSyL77T2eXVKqmoe3L1rA3d1s6zPve8uPyogaVdzcYylwddad
         4jCGtakBUFlqizslP9T5I5+ZBzE1+6IcJGarYVKJtFyLqXo7SQpVE+w8YFQtcuVwkzVm
         +X4STglmSpR1dgw+rlwVbL7yo8Jk6jziKvK80BnlH1U8E3arVyxfVaU0Q0fqpRqFJdYp
         EuUCi9ezsZhLjjOS6RtlYj969fqFdntVp/qKui3OFCtrS8j3I1CJZaAA542ObrEkAPmi
         FB2RZanweuJ1IJoUH71JvUyN56YLP7n+LPwNDrB9Xrc4XsDhEX0aF+QunFTQm0AnOXKk
         SsZw==
X-Forwarded-Encrypted: i=1; AJvYcCX06fe0yZclv4kl6xVMKzGsERJD6qeVa459r1YnfuCStmlwbsiNlcjB1H8v8vlXexmxCZpNKqXge8igkLXV@vger.kernel.org
X-Gm-Message-State: AOJu0YyVVEiCKrbSmLrbbA7jc0QJKCTEY/kBq56fS575MCb06/v/JE9B
	x3iGn0jeJ/zB0LXuioAeYnzbmz/ENl6d2PcTIN2Dcq6qmJ+TMCmInXkTG7mjYf6URnTbDlrbP0B
	sN/qJt+jWlDo1vOhknIc36/hGKTPR1CjxMW1zcruVOKAoxwndUhDamG9Kn6eL/3A=
X-Gm-Gg: ASbGncs14JDgExZMriGP0fbPwYMVPWTlgfhTtKRK4Gp9u0zzbPgu353ELowpgS2JUK/
	yRWT5eBi5k1V6H81+M3uB0LwUWJjLOxuI+aWiZ8V98Ww96KSsE2ykIMycIVQ0PD5S6KghXGmTbm
	mVIBeId4w0bCmyWPZegNKL+7poStgWhtKLEROeTKmGsfzk+J/0JINVifc/sduY3Jow/FYTkasgw
	m6VniwT+mBPKNkeZjsFy9IQ5H8w73P0lldNNmTxiMBOBPTGvjn0LPp9SBfcxMpoENVgCxQ4R+FP
	UUkU/1AlUgxzh30JsNyWHULBWFJFaKenQ+l7eyTp858WmbbkS7E/Ul0PCGswGEwxxy/HpsQ7ncu
	Nz1TcpsWc
X-Received: by 2002:a05:600c:808:b0:436:488f:4f3 with SMTP id 5b1f17b1804b1-436e26a1b3dmr248887985e9.17.1736871738769;
        Tue, 14 Jan 2025 08:22:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzrt+oh+BDgDr0mTUmNNAkoVBPx3QMSnwQIay9ds7g9OeGpsrnfeAbT16Qe0MdXZET33lN3g==
X-Received: by 2002:a05:600c:808:b0:436:488f:4f3 with SMTP id 5b1f17b1804b1-436e26a1b3dmr248887545e9.17.1736871738414;
        Tue, 14 Jan 2025 08:22:18 -0800 (PST)
Received: from ?IPV6:2003:cb:c738:3100:8133:26cf:7877:94aa? (p200300cbc7383100813326cf787794aa.dip0.t-ipconnect.de. [2003:cb:c738:3100:8133:26cf:7877:94aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9e6249csm178599775e9.38.2025.01.14.08.22.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 08:22:17 -0800 (PST)
Message-ID: <fb1b7d1d-33da-4de1-b863-61ea8421c7fa@redhat.com>
Date: Tue, 14 Jan 2025 17:22:15 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 15/26] huge_memory: Add vmf_insert_folio_pud()
To: Alistair Popple <apopple@nvidia.com>, akpm@linux-foundation.org,
 dan.j.williams@intel.com, linux-mm@kvack.org
Cc: alison.schofield@intel.com, lina@asahilina.net, zhang.lyra@gmail.com,
 gerald.schaefer@linux.ibm.com, vishal.l.verma@intel.com,
 dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com,
 jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com, will@kernel.org,
 mpe@ellerman.id.au, npiggin@gmail.com, dave.hansen@linux.intel.com,
 ira.weiny@intel.com, willy@infradead.org, djwong@kernel.org, tytso@mit.edu,
 linmiaohe@huawei.com, peterx@redhat.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, jhubbard@nvidia.com,
 hch@lst.de, david@fromorbit.com, chenhuacai@kernel.org, kernel@xen0n.name,
 loongarch@lists.linux.dev
References: <cover.11189864684e31260d1408779fac9db80122047b.1736488799.git-series.apopple@nvidia.com>
 <60fcfaa3df47885b1df9b064ecb3d4e366fc07e7.1736488799.git-series.apopple@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <60fcfaa3df47885b1df9b064ecb3d4e366fc07e7.1736488799.git-series.apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.01.25 07:00, Alistair Popple wrote:
> Currently DAX folio/page reference counts are managed differently to
> normal pages. To allow these to be managed the same as normal pages
> introduce vmf_insert_folio_pud. This will map the entire PUD-sized folio
> and take references as it would for a normally mapped page.
> 
> This is distinct from the current mechanism, vmf_insert_pfn_pud, which
> simply inserts a special devmap PUD entry into the page table without
> holding a reference to the page for the mapping.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>

[...]

> +/**
> + * vmf_insert_folio_pud - insert a pud size folio mapped by a pud entry
> + * @vmf: Structure describing the fault
> + * @folio: folio to insert
> + * @write: whether it's a write fault
> + *
> + * Return: vm_fault_t value.
> + */
> +vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio, bool write)
> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +	unsigned long addr = vmf->address & PUD_MASK;
> +	pud_t *pud = vmf->pud;
> +	struct mm_struct *mm = vma->vm_mm;
> +	spinlock_t *ptl;
> +
> +	if (addr < vma->vm_start || addr >= vma->vm_end)
> +		return VM_FAULT_SIGBUS;
> +
> +	if (WARN_ON_ONCE(folio_order(folio) != PUD_ORDER))
> +		return VM_FAULT_SIGBUS;
> +
> +	ptl = pud_lock(mm, pud);
> +	if (pud_none(*vmf->pud)) {
> +		folio_get(folio);
> +		folio_add_file_rmap_pud(folio, &folio->page, vma);
> +		add_mm_counter(mm, mm_counter_file(folio), HPAGE_PUD_NR);
> +	}
> +	insert_pfn_pud(vma, addr, vmf->pud, pfn_to_pfn_t(folio_pfn(folio)), write);

This looks scary at first (inserting something when not taking a 
reference), but insert_pfn_pud() seems to handle that. A comment here 
would have been nice.

It's weird, though, that if there is already something else, that we 
only WARN but don't actually return an error. So ...

> +	spin_unlock(ptl);
> +
> +	return VM_FAULT_NOPAGE;

I assume always returning VM_FAULT_NOPAGE, even when something went 
wrong, is the right thing to do?

Apart from that LGTM.


-- 
Cheers,

David / dhildenb


