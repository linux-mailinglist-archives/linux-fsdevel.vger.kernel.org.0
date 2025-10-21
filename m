Return-Path: <linux-fsdevel+bounces-64843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5FFBF59CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 11:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6FFF198132D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 09:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB3E303A21;
	Tue, 21 Oct 2025 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T6oU5js4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9EC2E7F0D
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761040039; cv=none; b=llkt22fIeZlk3th4ARhJ7ps+hilmHLp0KgrJ1FVK0S6vrG8QPwgn9dYbZMFJn7llBX3GOeBWFaSgAjcFIRZvjL1a72xYLgW5M8kL419YjMttIgJJYVs3WASb/b0TsN/Mc+0s2APJ+mTSZsxntCFz3mtpI0C2/NmkCre1Ay9EQBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761040039; c=relaxed/simple;
	bh=b2KvTAnGQKxCK5vbG0Gz3P0Q5QTnn7VRPhHuZr4epbs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jKWgAaUYkJLVAOlUeqk08/UoAkls/4aBn0cIt1EEOf08eqtKxmujxNJNvZ9cDntt5uGCD4DLnwGTbWBWXb/z2AyyBxxaUrWVVMM0CMNEqioEb9/yZAtA7RAqsd027sYm5ezzz2afASXauWs5b3xpBXp1ql4oVp8pFc4rNSvoOMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T6oU5js4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761040037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kdxB4ObaxXDe3ntYne3br3T1Zilh+yVID4oP5ghyroc=;
	b=T6oU5js4C8nqgHR0uGyN39tyHulwjCXfkFxc5rWeOineQyP//mc4lCOj/0iW4Tgxrm5cGT
	pdtRNCquGXoMdpnHqtTIo39pEdvLePWKO+NqIkcq1hdy1Nz1FyWARu1TmCmnuxDlbiAXfC
	xwatb7JdC8PRXcEwEa191QxILbttfFQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-TqixnEtLM_qu64bIMl4bcg-1; Tue, 21 Oct 2025 05:47:15 -0400
X-MC-Unique: TqixnEtLM_qu64bIMl4bcg-1
X-Mimecast-MFC-AGG-ID: TqixnEtLM_qu64bIMl4bcg_1761040034
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-470fd92ad57so109892935e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 02:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761040034; x=1761644834;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kdxB4ObaxXDe3ntYne3br3T1Zilh+yVID4oP5ghyroc=;
        b=qypxR+KpkPUrvH7nF8G8g+xErSbBf5hgpOEEdSLZD7G0jgffXpXH2mgD5Xcgky9RUD
         tLyHrrurtY4jh+6z2OjP3J8BC4gr2GctTagrCnC609gLVTXVp0ly5h5stF22JSQ4m9yy
         pDQdAFSOCyfoS0SwKwy7kEXz6LgJnau1zXGHnauByQ8qLH/k3ICiOyFBQVxrO99VKfTg
         Poq/fZlMVolwH4e6BAEAAPRMmmkjwiymMHzaG8fNyCrgCA/ctYbpoc03rtwOzu0aP3F4
         lvF1JcWMk8a02hyLDUuKaezABia/DDXNejSf/jV9OYeS+IANbiHZaXF7rFWqfctN7Tsd
         mFrA==
X-Forwarded-Encrypted: i=1; AJvYcCUNimIHM0ZHYfWrrXwXa3LOcF0YyV57zyxjW2PAXAkY0RCSmTrNRrhC4pkmrKTM8skDODoYEN6v0sggb6xs@vger.kernel.org
X-Gm-Message-State: AOJu0YxNgK0blSMyelVgmNetayWdjNcuDo8wl4NOJYZ+x126wsfouAw4
	wD0x4HLlBQyZ+wvp8/SiVYQnTt8fsyTkEzJD5H7QiaEbmJM4b2xrbDEmedk18TqJDIuGFDPrNDv
	OzgMqm3AoL3Ml6lIivtiY88tG2yqjIn+ir6odhwJ4ywKR+Sar9hWcxAaPwaq567VSxqY=
X-Gm-Gg: ASbGncthp9AgTzl74MIqOFlfaHC3pjGo7JioUUiF61HlR8k/Ucv8gFDiKgkn76M/dgN
	XUzcGtHkVQ85vqe4tj4bsZWEFzGObzM013eqMMIJCDJJdHz7ZGwcbM3KyvE69EpLie9XmVk8wG8
	gPz7TFF4V86Q8RrBOEFTNvs0PJDZzFu8I0RzVUwJA/hCHLJNDdSwzqOtfKtkM1aUQuUQU1M24DS
	x39dx1oVscGMwULnVSgh0NCWKNbBJ34EZ1FdrhWQHpk+0X0hRprn7D8TWfTl9kHyutjAF7qz8a4
	S9x/gbbIUMICGJc0fd5zMu46SZH269Puhwa6os/ex3RCn9hYIuGhnDoHk3FFe5Tx6l7pyD7nqH2
	l0Vs/WcF6rEN2L3iCcXntXbTxzgCxjHxrDP3G6pF+NVXwd/Tw71c08UbzBFGB+FUB1XhnJvdihC
	89HP2WsjzjensL92Nh2cd0Cp+acqc=
X-Received: by 2002:a05:600c:354a:b0:46e:59bd:f7d3 with SMTP id 5b1f17b1804b1-47117903f24mr109166425e9.20.1761040034392;
        Tue, 21 Oct 2025 02:47:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQrCWI5MRc3hct8M6FiDVhKuOrq9aVGTkJL4l+BBrXUp5JiUTebsACgmFnwi5Fpp4jK76vLw==
X-Received: by 2002:a05:600c:354a:b0:46e:59bd:f7d3 with SMTP id 5b1f17b1804b1-47117903f24mr109166135e9.20.1761040033964;
        Tue, 21 Oct 2025 02:47:13 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496c2c9dasm13207305e9.4.2025.10.21.02.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 02:47:13 -0700 (PDT)
Message-ID: <37ceab54-c4b2-449e-aa46-ffaefe525737@redhat.com>
Date: Tue, 21 Oct 2025 11:47:11 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm/truncate: Unmap large folio on split failure
From: David Hildenbrand <david@redhat.com>
To: Kiryl Shutsemau <kirill@shutemov.name>,
 Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>,
 Matthew Wilcox <willy@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Darrick J. Wong" <djwong@kernel.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kiryl Shutsemau <kas@kernel.org>
References: <20251021063509.1101728-1-kirill@shutemov.name>
 <20251021063509.1101728-2-kirill@shutemov.name>
 <a013f044-1dc6-4c2c-9d9a-99f223157c69@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <a013f044-1dc6-4c2c-9d9a-99f223157c69@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.10.25 11:44, David Hildenbrand wrote:
> On 21.10.25 08:35, Kiryl Shutsemau wrote:
>> From: Kiryl Shutsemau <kas@kernel.org>
>>
>> Accesses within VMA, but beyond i_size rounded up to PAGE_SIZE are
>> supposed to generate SIGBUS.
>>
>> This behavior might not be respected on truncation.
>>
>> During truncation, the kernel splits a large folio in order to reclaim
>> memory. As a side effect, it unmaps the folio and destroys PMD mappings
>> of the folio. The folio will be refaulted as PTEs and SIGBUS semantics
>> are preserved.
>>
>> However, if the split fails, PMD mappings are preserved and the user
>> will not receive SIGBUS on any accesses within the PMD.
>>
>> Unmap the folio on split failure. It will lead to refault as PTEs and
>> preserve SIGBUS semantics.
> 
> Was the discussion on the old patch set already done? I can spot that
> you send this series 20min after asking Christoph

^ Dave

Also, please send a proper patch series including cover letter that 
describes the changes since the last RFC.

-- 
Cheers

David / dhildenb


