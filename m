Return-Path: <linux-fsdevel+bounces-65692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A27C7C0CFC8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 11:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 561D44F2B69
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 10:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402CB2F6918;
	Mon, 27 Oct 2025 10:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L4TYKvEE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268F08462
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 10:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761561545; cv=none; b=u3YHoDGcIUdiX4B9WSqmVVKyuZKbvEze7uDwrKqvf+6z7G2fYDPmiPj4RBEM7T2MBTkym+QFaRFCplBaIWQayI3AqxdSu7/sm0oIDktDo4Gt9ba2898jMZp6oIn/Z7ZRFfxV80AJ8gUMbJ5gXieuDSO0KLazkA8KHHJf+R3gO44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761561545; c=relaxed/simple;
	bh=Km0cY0JQnllVh3tM4GfoPJxMZjf5O3Xp+Jlec73U1Lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UvJ398IoaUYElJOI8bmNOdsOeOuwnMRvipU/bdGSmSCjZdEPREjr+VtDF/Lx+qa2YcScbL0bsBVjFtGFzKiqt/eUJdCbp5DN+TxRCvobE4AUoF2wTbOME7yVdDOU9Vb59MvY+DvhamFMwWg5qnlvPvq2sBiFG6vc547cUaT3KG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L4TYKvEE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761561543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Oel4G3cPEuo2MmKUJIoS9kEtL79BAE03caQp/0wRCy0=;
	b=L4TYKvEESW7VoykmJWc+6IwiCxjyUZbTXd6qHtfqEnOj3Ma8I5k+Edy0olMi8h/6n0z6Hb
	zoO0OxJaFStfX4kpDytSpn9NOxw8T3yLY/c6ze5vte9f5oRVBfA3Wbs/z5eizbSo4UPG9a
	vV8OAZTV/iuI3iHQ8gUH5mspyxqf1go=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-pXjb6csaPPuyK_K_yqCUrA-1; Mon, 27 Oct 2025 06:38:42 -0400
X-MC-Unique: pXjb6csaPPuyK_K_yqCUrA-1
X-Mimecast-MFC-AGG-ID: pXjb6csaPPuyK_K_yqCUrA_1761561520
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-471168953bdso42089695e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 03:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761561520; x=1762166320;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oel4G3cPEuo2MmKUJIoS9kEtL79BAE03caQp/0wRCy0=;
        b=DDMBMXq3AZ8g3VX99+jcgSe+pPYfQA2l/9xa8IbYdi5oqANJTdu169loycpbgU2deM
         lQ/NCYICf0+8RrJi4tihe/91d5V66/7j04bL9MOUmsX+J3ozDGybzdUpH0aQhTIvmrt4
         dFD57+LELIP6LWD+yY8YU2UN8VWjTMON2GU/3JPVrq1/qPNvxO5OKq6M7KpNzM7uzgZ1
         aDwW0NATGfNU/R7YUsMGMHo/w5yzTCSNxguR6WN5HHiH37FDzCHKonpiX2zP5IAFFX7f
         j/Qzi068xhwPzqpQn3TX8CMzMR9bCkKB6pmOYB7dYt+Ehm2XwFEOfVL4GQO/ZaIpkzTC
         jSeg==
X-Forwarded-Encrypted: i=1; AJvYcCVUl8DPEk1yHXaQbJEZfweydZWhf1C7y9fDARcSNGbu/mdB2uqNGG+Sb1NElvPKVK3qT5MDgyE7t5fcGiFr@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8/Qrfh2UjyyCCIjJ7PV6n7ebMTpEssPAEM7qm7qEqFuRRZs3i
	r9Ckz20pscfS6P0L3+bcMxjkiObaVm/vdYZCR+0hMNJk+i4Tz+OBmontCHweTnzRTrFbzD9sfL1
	KdzG+y105j511daMIhE3n5tk+7qd6wb051aJfw3XF+Nod6t/IoEtsGRwiqjV8rEa59xM=
X-Gm-Gg: ASbGncvq5cBsjb7g/0NsjIMFbSxaXlH9uLkCiLnRJc73Q7za1Dc6tASCJ/15wuDqk91
	e1RkrRvw9BDvWMXhkmAd65qyljoj1XIV0ah4LMLKSpnBVL3Vyp+eab3ubJqVYI91NDwfuAaeLnS
	40/sC+4mC2mAWuUdbW9OmBQIyBh8GWLt+Cl+8lUdEyWqRjMTv9iUCZqxYaBcm4dhj5MD0Fwydez
	WT/QFUvUeyqoWdPk7TEcmQXgDyydtSvZOytda9uvTQKuXMlTsL3VqInZ1sv7wrWvOB+qz+lVXAu
	tH6vGINV/qmusVBgF6TiuiwzNwP5iKsDl+A9jDZ25aobtVp6exdDzCeQ2RrIIPjw73o+dIrbY7U
	dNfdDmH2y1RvCH8jmvNK/zikL3zhYJJhO+NfcEY7bwVRHv6hlDsYEr6+dukZhQFvZFfHBn1Uafq
	MGJSoP2X2fMk6W2VI92it0Jp2LJ/0=
X-Received: by 2002:a05:600c:4451:b0:476:8ce0:a737 with SMTP id 5b1f17b1804b1-4768ce0a95dmr50410095e9.14.1761561520278;
        Mon, 27 Oct 2025 03:38:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEn2q3gNAE8tdvOtiWdSqoFcYYI2LbctFUWA3TJur1mAMDCjIxd6GkkJ6jfNxpspik62KNYg==
X-Received: by 2002:a05:600c:4451:b0:476:8ce0:a737 with SMTP id 5b1f17b1804b1-4768ce0a95dmr50409835e9.14.1761561519853;
        Mon, 27 Oct 2025 03:38:39 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169? (p200300d82f3f4b00ee138c225cc5d169.dip0.t-ipconnect.de. [2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd4e30f5sm130097035e9.17.2025.10.27.03.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 03:38:39 -0700 (PDT)
Message-ID: <c519f6f8-37ca-4016-b8f3-aef9b9bda9c7@redhat.com>
Date: Mon, 27 Oct 2025 11:38:37 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/2] mm/truncate: Unmap large folio on split failure
To: Hugh Dickins <hughd@google.com>, Kiryl Shutsemau <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kiryl Shutsemau <kas@kernel.org>
References: <20251023093251.54146-1-kirill@shutemov.name>
 <20251023093251.54146-3-kirill@shutemov.name>
 <9c7ae4c5-cc63-f11f-c5b0-5d539df153e1@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <9c7ae4c5-cc63-f11f-c5b0-5d539df153e1@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> 
> And a final nit: I'd delete that WARN_ON(folio_mapped(folio)) myself,
> all it could ever achieve is perhaps a very rare syzbot report which
> nobody would want to spend time on.

I think that's the crucial part: what are we supposed to do if both 
splitting and unmapping fails? Silently violate SIGBUS semantics like we 
did before this patch?

So far our understanding was that for file pages, unmapping should not 
fail, but I am not 100% sure if that's really the case.

-- 
Cheers

David / dhildenb


