Return-Path: <linux-fsdevel+bounces-59203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A6FB36188
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECC58205370
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 13:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824C3223DF6;
	Tue, 26 Aug 2025 13:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7Sem+Jy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A0E1A256B
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 13:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213539; cv=none; b=Ziqc96WiQhmTXIBgmUgwu7RZn2eNmYSNx/89xYtj4zln1jl0htuvUtJymFpoQwdftkZ5Wm9mk8tj+etvBTYFeLmT0TMVMXmg32PjzZe2ATsJvjtR0yM6kDufleQh+6xv6Cy/voZs/WpZCoQt+o2X7UTvwvT1XtaeFPZyBpSXO1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213539; c=relaxed/simple;
	bh=FH1P8Y3Rlx+VsxrV8Fk6g6bj+LlOmbkGsQwEvGMw8wo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S4LHZkRKhCoMZ7rDC0na5RWVH5oxLZm/rAn8a5cnQM4bNSxLfcvltHBrvOmEk9Px7Rm7E9gEMactXM9cnTzZrN9zioEZ3EkXUt/HTHZEGD5ERCIeIf6HpdD0YxyOm6OoIfe3/puo9lTSZhBPjuKV6sTRJnmoyGhkvhQXeT3U7/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X7Sem+Jy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756213536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1BB02iWNVIJ9mg9RLb+t+28O/xwbqNfMBkX4EOOZu44=;
	b=X7Sem+JyVGvBuo2Q4/MSZ6cvJ3Pz93SADA9KsQcyNP8mGw6xkrx+hFNZE4Bs1BPQE+rE6a
	u6TPPs5qHvYpVkeSVqdTYaN81SeCRNJXhB8EcGErUFdoLshqLbeAMDDFdP26ilCpDDl0Ly
	HRy/ptT5EN7MmfYkXDVBogs+7TkeVp8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-OVg5v0JDOpKZKwM4nlx_hQ-1; Tue, 26 Aug 2025 09:05:34 -0400
X-MC-Unique: OVg5v0JDOpKZKwM4nlx_hQ-1
X-Mimecast-MFC-AGG-ID: OVg5v0JDOpKZKwM4nlx_hQ_1756213532
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3c584459d02so1972992f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 06:05:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756213532; x=1756818332;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1BB02iWNVIJ9mg9RLb+t+28O/xwbqNfMBkX4EOOZu44=;
        b=qb7TSd4aJi5OPUUGek0wtKSms6mYoBJ5IwuSWSmVIvsvuiB0EuKYHg6Ta+YT5Gu3gT
         Il8+Ay03KoPKiaW6C6UXnytphZxgVAS/HKtE78V2dr42TNuGH220s9FFAFcOCDXlcWLG
         5Hg2oXFlMn5CDzuJZsXdCl+I2MzVnqtAIsqmJOl+AlQxuwZAI5UBUDnbqoHerHP3k3oY
         0DV1SS6XBc+BM6xWvQKHsO2XjWceMNjagv2VL1hd+NuBgTzD7NwM7263H19Ttg+9Qgp3
         Qk1gBktLN/eXXfU4yERx/kwWIjkB0qe5z0Cw8hjxcpbWAI7xcnxOThcJQge7cbiDyv4k
         dhKw==
X-Forwarded-Encrypted: i=1; AJvYcCUhD7oTKhkkhNNI1T2M2NGC6W+9A/G6lToop/AW4AfsZDTJS1RIOHEvzNvjMYxF7PhDmP9V5Q22VNZzeUEt@vger.kernel.org
X-Gm-Message-State: AOJu0YyjmyC4ZksiDfNmqM75lhq/KW8OgqdmreISxJyokPTYk5+9N1ar
	6SfHVXSlHwjQoiBlPfzl7+9Uapc1ByiDeGwQXk80DC/KxiLWn22mX8YjK0ppsFEzw3ZBf8t+Sz9
	TZDT4PfLMmmMJ1XaenQHHexKVCINmiFhWKhXYaHzr1Tm22J7l+kEzd+6Ihz/6ZiQ1pS8=
X-Gm-Gg: ASbGncvKHMDbNEp7rtya9IXTTViPZzb1m6fdKAgZOyypT0065xOfafZssyjJsweHyHh
	HXq6USD0FNYsXEZ/wNqSeyYc01voO2rIOsXarFPy3Tz28CioK0GI14P+O8F2/4Nte8lEEX0BtHa
	RMXNr9gtfWnMriD6dUsLHXIoXkNSEKdI2ccwSGhQTKRTDQ3dBm3lCpGc5qwYRZAO+yJseFJ0deI
	DlmNlWDveZ91PJz8MhlkSe6CDs7tVB95/Ejttn1/uvkWdj9xrNdN8YrdlhsAYWMUnK5M2UyTDYH
	zVX1BaZfvXN1GFX7wV7yH0/sUCYUgc2QJyYKy0bw+tAbvn7ekw7k0O7ERO2f/ES8rqp4Vvoqvg=
	=
X-Received: by 2002:a5d:5d0a:0:b0:3c7:6348:4086 with SMTP id ffacd0b85a97d-3c763484467mr7275261f8f.1.1756213531702;
        Tue, 26 Aug 2025 06:05:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IED6aZTaK2lqB/sF3ARmnAdAwZO8b9lpHwjPZdqb85yBXUF5jouz9AriJp/YIpO7DcxRXsArw==
X-Received: by 2002:a5d:5d0a:0:b0:3c7:6348:4086 with SMTP id ffacd0b85a97d-3c763484467mr7275175f8f.1.1756213531071;
        Tue, 26 Aug 2025 06:05:31 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c7117d5b10sm16090666f8f.47.2025.08.26.06.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 06:05:30 -0700 (PDT)
Message-ID: <f77fd9af-5824-4f5d-ba97-54d70bbd1935@redhat.com>
Date: Tue, 26 Aug 2025 15:05:27 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] mm: correct sign-extension issue in MMF_* flag
 masks
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S . Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 David Rientjes <rientjes@google.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Matthew Wilcox <willy@infradead.org>,
 Mateusz Guzik <mjguzik@gmail.com>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
 <f92194bee8c92a04fd4c9b2c14c7e65229639300.1755012943.git.lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <f92194bee8c92a04fd4c9b2c14c7e65229639300.1755012943.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.08.25 17:44, Lorenzo Stoakes wrote:
> There is an issue with the mask declarations in linux/mm_types.h, which
> naively do (1 << bit) operations. Unfortunately this results in the 1 being
> defaulted as a signed (32-bit) integer.
> 
> When the compiler expands the MMF_INIT_MASK bitmask it comes up with:
> 
> (((1 << 2) - 1) | (((1 << 9) - 1) << 2) | (1 << 24) | (1 << 28) | (1 << 30)
> | (1 << 31))
> 
> Which overflows the signed integer to -788,527,105. Implicitly casting this
> to an unsigned integer results in sign-expansion, and thus this value
> becomes 0xffffffffd10007ff, rather than the intended 0xd10007ff.
> 
> While we're limited to a maximum of 32 bits in mm->flags, this isn't an
> issue as the remaining bits being masked will always be zero.
> 
> However, now we are moving towards having more bits in this flag, this
> becomes an issue.
> 
> Simply resolve this by using the _BITUL() helper to cast the shifted value
> to an unsigned long.

Hmm, I thought BIT() should be used and would just fine?

include/linux/bits.h includes <vdso/bits.h> where we have

#define BIT(nr)			(UL(1) << (nr))

In contrast, _BITUL is a uapi thingy from include/uapi/linux/const.h ...
as it seems.

$ git grep "_BITUL" -- include/linux/
include/linux/mm_types.h:#define MMF_DUMPABLE_MASK (_BITUL(MMF_DUMPABLE_BITS) - 1)
include/linux/mm_types.h:       ((_BITUL(MMF_DUMP_FILTER_BITS) - 1) << MMF_DUMP_FILTER_SHIFT)
include/linux/mm_types.h:       (_BITUL(MMF_DUMP_ANON_PRIVATE) | _BITUL(MMF_DUMP_ANON_SHARED) | \
include/linux/mm_types.h:        _BITUL(MMF_DUMP_HUGETLB_PRIVATE) | MMF_DUMP_MASK_DEFAULT_ELF)
include/linux/mm_types.h:# define MMF_DUMP_MASK_DEFAULT_ELF     _BITUL(MMF_DUMP_ELF_HEADERS)
include/linux/mm_types.h:#define MMF_DISABLE_THP_MASK   (_BITUL(MMF_DISABLE_THP_COMPLETELY) | \
include/linux/mm_types.h:                                _BITUL(MMF_DISABLE_THP_EXCEPT_ADVISED))
include/linux/mm_types.h:#define MMF_HAS_MDWE_MASK      _BITUL(MMF_HAS_MDWE)
include/linux/mm_types.h:#define MMF_VM_MERGE_ANY_MASK  _BITUL(MMF_VM_MERGE_ANY)
include/linux/mm_types.h:#define MMF_TOPDOWN_MASK       _BITUL(MMF_TOPDOWN)

Oh, hey, it's only your changes :P

We should better just be using BIT().

-- 
Cheers

David / dhildenb


