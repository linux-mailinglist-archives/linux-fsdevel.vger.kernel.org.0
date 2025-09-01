Return-Path: <linux-fsdevel+bounces-59858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E46D2B3E683
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 16:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7C74188365A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 14:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A33340D86;
	Mon,  1 Sep 2025 14:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="erFv24g9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB0C33472C
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 14:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756735260; cv=none; b=degyDflMt5wMoY9Mg0RKpC7wPoLl7EX9EP1gR/6TzX+hXXiYwrCNST+vMz4ushFQLxQTIGAOryeIgGC8G0HDFtAk8bcfsDNWZllla+lFxWx5ypnaK//U7HhSY9YCk+h4TKDlcvabAVfISohymdhM+kwhvmU8j9i9Ojy267VIEUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756735260; c=relaxed/simple;
	bh=A0rIjcIgYC8dyuUFStHv+vQbOBSmgcbpTN3EDpWY4Jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MC4orV3xh46eNxcOtNKouIuOeEhFxmqpWbBpbFyG5V3HCY9SUmnQCnMMIKfvL2MvyxiqZ5Vkai+5cszJFC4Gv/Ck9f3Ot4zuEvW2gUAOJKM+tWPsUqOMf1sNTM5D3ob9HwdPbDgvX9dWZcOBxzxA/4v4I69g73Q2f76zf3EnFxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=erFv24g9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756735258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lx0LFME7B3AUa2/+kLMyCPk/GuDX6f91CgTqDnBJCDI=;
	b=erFv24g9Vv7P9jpa2Y7g0I9YspaAcYdnoAIpktwfzMahhMrZunvO8qZzX/+UWLFoB6GbQc
	w17htXkdOYGAHsmQPaDbwWuBcjHOVIStN2oh49bNXsQfH828K6DYlr4yoYhtddnjiD8UKu
	2RFkc4Bh+t9m3D9OTd53S4a/13vaSkg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-SCxGil2qO1aLbljwcbg5sg-1; Mon, 01 Sep 2025 10:00:57 -0400
X-MC-Unique: SCxGil2qO1aLbljwcbg5sg-1
X-Mimecast-MFC-AGG-ID: SCxGil2qO1aLbljwcbg5sg_1756735256
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b7c4c738cso16378215e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Sep 2025 07:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756735256; x=1757340056;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lx0LFME7B3AUa2/+kLMyCPk/GuDX6f91CgTqDnBJCDI=;
        b=T7BJirTF9ZWXswBezM5zwA78C4HZk9vTePNhK4EEecz1tA+ntojLE/T2gSXWRskVwA
         0sduHliVxrHWXo6JbwT012aO1YbnHDJdtNagnRXPtuyoTb1v32847AILPEcJ5nf2sLqk
         7G38HpeHxNTCOj1Zyt4pT1xYaT3aKj7EGzwe7lYjHrYIMgYVCC7psw0u7/s8Avv0uIKz
         4lDQdTeH3AjZ48s07QLef5toYtc9V7P1MS/73wr16NCG+gidNCtuOsPbTTb9gbvi/F5P
         QTKrNTGPbwJ09YzLITnSu1ygx1GPk1rFpVUPgWGosgPcLtaa8VRCF/6U4XzRJ1tdxyf+
         os2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGe43Zxeikrh9uMvJmMINNggXSaQ8V1VJ+hqpCP4bdP+SKJM4i8LYZ/ZlrYT0xcDwVtDTKIyQoNBG/QWdY@vger.kernel.org
X-Gm-Message-State: AOJu0YwjMgmwNB73bXAhTiENK+wtZV0cvG97Nto0hDd2e/rCsfe5Sg6P
	XbCHEnDkhm5KfpTlNPkezdDqPEyHTwJ3VytezoqFt5OFbVVGMN6WHh9FV1j+cUo219OFTr01wVB
	sFbzfw5Z45qFNwPGm108f04FhRnjpzxRX/+SRELdcUnqMUCgzgB6h2Fl4ZBGFmjWsqLA=
X-Gm-Gg: ASbGncuglZWuurHuIlBYi5166Gxh4dy12j1LaLoyEv7xYvfDq+UMR2+NjXZWC07EZGZ
	stBtY5n0lSCpZt6RE8Cpe3B8ovheB8F2PSIZ512bdAg7ANYMuCKGEmkpwcvd7LLfKCEHSeAyG0M
	HRUTxrngDoTMgUJn66WuUW+aVR+mqdp93xYZCQwVNe7cWA9HJ516KpYfh8L2g70un+GbzW7VwTa
	i4d97KXcc+gFLIZzGIJ2IVp7BWqx4B1rCunrll6U9H2CY3WnyXo6iz+9XVIwI4FDEdmVNI8hcpV
	z4vYmjf+1Mq0hm3PVnaHw5y3I3f8AXXvSnxq08piPIwyVLgc7HMZqP7uFaVIxv6s32DDOhqFGGb
	e93QzxI4tls3nmz8ss28Yha48jHGyUu64OoISvB90g1TkmsCKUxKk
X-Received: by 2002:a05:600c:19ca:b0:45b:8b76:c734 with SMTP id 5b1f17b1804b1-45b8b76c9aemr51288835e9.17.1756735255053;
        Mon, 01 Sep 2025 07:00:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKtDnpo7zdRn5kM2ivYNaIbBCzDVyMQFOSKKHTd6+Sf3l6DZcgbqTIv+QNYIMEkOQcJ2hrog==
X-Received: by 2002:a05:600c:19ca:b0:45b:8b76:c734 with SMTP id 5b1f17b1804b1-45b8b76c9aemr51287845e9.17.1756735254313;
        Mon, 01 Sep 2025 07:00:54 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0c6fe5sm239195655e9.5.2025.09.01.07.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 07:00:53 -0700 (PDT)
Message-ID: <5ff7c9bc-1722-4d8a-ad2e-8d567216a4e4@redhat.com>
Date: Mon, 1 Sep 2025 16:00:50 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/12] mm: constify various inline test functions for
 improved const-correctness
To: Max Kellermann <max.kellermann@ionos.com>, akpm@linux-foundation.org,
 axelrasmussen@google.com, yuanchu@google.com, willy@infradead.org,
 hughd@google.com, mhocko@suse.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 vbabka@suse.cz, rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com,
 linux@armlinux.org.uk, James.Bottomley@HansenPartnership.com, deller@gmx.de,
 agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 davem@davemloft.net, andreas@gaisler.com, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, x86@kernel.org, hpa@zytor.com, chris@zankel.net,
 jcmvbkbc@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, weixugc@google.com, baolin.wang@linux.alibaba.com,
 rientjes@google.com, shakeel.butt@linux.dev, thuth@redhat.com,
 broonie@kernel.org, osalvador@suse.de, jfalempe@redhat.com,
 mpe@ellerman.id.au, nysal@linux.ibm.com,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
 <20250901123028.3383461-11-max.kellermann@ionos.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250901123028.3383461-11-max.kellermann@ionos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.09.25 14:30, Max Kellermann wrote:
> We select certain test functions from mm_inline.h which either invoke
> each other, functions that are already const-ified, or no further
> functions.
> 
> It is therefore relatively trivial to const-ify them, which
> provides a basis for further const-ification further up the call
> stack.
> 
> One exception is the function folio_migrate_refs() which does write to
> the "new" folio pointer; there, only the "old" folio pointer is being
> constified; only its "flags" field is read, but nothing written.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---

Also some getters hiding (and functions that actually implement logic -- 
folio_migrate_refs())

[...]

>   
> -static inline int folio_lru_gen(struct folio *folio)
> +static inline int folio_lru_gen(const struct folio *folio)

*const ?

-- 
Cheers

David / dhildenb


