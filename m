Return-Path: <linux-fsdevel+bounces-59206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D28B362C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA9BE2A27D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 13:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2896B30AAC2;
	Tue, 26 Aug 2025 13:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KL1w+yp/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C2B30146A
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 13:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214006; cv=none; b=MNCAB7mwTG87XL++L5LQkNxC34ZKmZBCjbpqcmhAJxcvai0Hpa/+J2DQ8OZcHuFo0C5QXuWJhS/UpWPQyrXS7jMvP4cdmxDUCI8SM9wMo4nHjdCYMelz0asqOqdqK+fegRW03Twir9QFnwHQFw44RDeZpIoy71pKNNX38BLoYjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214006; c=relaxed/simple;
	bh=yt7PX86YZMaO/zrX2cd6zBWZMNRsvMh2Y0BhzLi5e4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oRJnsiPQEfXbu/HfkPyjyiEn2N4smmgj28JxyFK3yoY9ijzpZNe9Rspywruiv22dy52EybMnGbUFjFJfsWdB0N/PqiBeCVBHWD6n276PfowN9hWsgtJ6qZ3ZOcRAV+C9Qx610PKG1FvRX2g10qX7A+09hc8iDJccuSxune9X508=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KL1w+yp/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756214003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ssn/jpuXTRjbOLCPQ6KT3z7CgPD8X2cfIkgpAEmxoSg=;
	b=KL1w+yp/nXfT/CAUCPaiGVxaRUwX7zebkDA58NK1DTqcNQkMotwVHy5gvOxz/ZC5/S6zE1
	J0YfOscDhH+aFirH8AN+JTD09WFAaieVt+qTOhZD1n1R0SCpDuhy2wiEzX9PLxE0cZTA6M
	6P0SrmdP9PZBuA6Wf9saGZlfIRw666w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-SRmekMh7MlOHO4cI-L9pgA-1; Tue, 26 Aug 2025 09:13:22 -0400
X-MC-Unique: SRmekMh7MlOHO4cI-L9pgA-1
X-Mimecast-MFC-AGG-ID: SRmekMh7MlOHO4cI-L9pgA_1756214001
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b0071c1so29712855e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 06:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756214001; x=1756818801;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ssn/jpuXTRjbOLCPQ6KT3z7CgPD8X2cfIkgpAEmxoSg=;
        b=LewXh5Bxq39INGqaz15AN4mxRQUYsUWdZ4ysXOQbV8CUsR4MvrKSr2y+1G2ZxEK4vA
         vcuoKa0XVAmHylL80lZfWiezBuohcLBlnbSPpMJ8qfh8vlYdWmBQwO7jubm28SFAk0zs
         C1K4yq6FJA8kGb/xwe6bfHdYH9e9n+bbXGuo5Dt3Xi2SJ7RgR5h197AY6BzOxaCDfQ+P
         LMB/LhgravJiusSX0uZdrsfg3OGIfY1F5I/wdPm50USHeU9NDEL13DCpZoANhR4paQ/3
         UUBbJpF219OOaiQydtH+NGApis4TqTo3v9iocPdCMGHHqDpDfBffXym0HyEbgk1uxues
         3i/g==
X-Forwarded-Encrypted: i=1; AJvYcCVZPbTKjuOf0JEVMDZ3HTfsjenM9WmqGHxSLKHTAlin9LHdFOulg+1kJ1ME8qwofo2PyunLJaqS3Juw85Hq@vger.kernel.org
X-Gm-Message-State: AOJu0YyXGmxpYpxYtykH39UVxEa1Iozs5RbiAsWi6eoNmWaAE2wevcO4
	rbmiJDnKpdUt9NugNHHkauYKUC5EdTBNllGuhtj3nwT/5rGeR9XelrR1itRC19aKMSi5nyoVrWm
	2nl+eucMNGLFfzo29XMAcgiG2qUjIhcvQi2KBNxZiVwjSHAwT4IJ9/Dk1dA5V+VhDwxI=
X-Gm-Gg: ASbGncuV0IWCic6h/tb6oX/r6K+FSmtGnvyIqERFbf02OVFAPuUWB6fki9Wheu1R15i
	bBwcQ5WPtH28qhJA/+KByP0liDlbkvcBR1HTp5SeYHcCsVJREX8QbXD9GU6jLtLmyVZx0hNeOvT
	SDID2k1rcMKDYfdq7+KV87YOlWCGRDK6iMfwM0xcen3pt4ptunB8HZI7nbOWwdaWY00/QIhlyTx
	yLYq4frYNSXZ2nEKhQvEGvH62C+H5YUksvG4jF2w5mmZOmRgDaDZFNWj9KpeJjFE3jWzG5pR4xd
	/d+WspdbEv8C2G0pqErgMR7/2UUwHN6rRrWKj0wjbgznvoCinGP3IZ6pAQPkZ+uRtJzB+5OcPA=
	=
X-Received: by 2002:a05:600c:3551:b0:459:d6a6:77c with SMTP id 5b1f17b1804b1-45b604654ebmr67817395e9.33.1756214000753;
        Tue, 26 Aug 2025 06:13:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFU6LjwpcLiO4vOafOaD+LEz6b5Fo3ncGFRjR+/4dbvpwKsZckynZJGDmTGTRv6UW0AZNnoA==
X-Received: by 2002:a05:600c:3551:b0:459:d6a6:77c with SMTP id 5b1f17b1804b1-45b604654ebmr67816665e9.33.1756214000202;
        Tue, 26 Aug 2025 06:13:20 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b57498d8bsm152684985e9.25.2025.08.26.06.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 06:13:19 -0700 (PDT)
Message-ID: <3a072cda-2eb3-41bc-858d-3fcafd7ce05a@redhat.com>
Date: Tue, 26 Aug 2025 15:13:17 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] mm: convert remaining users to mm_flags_*()
 accessors
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
 <cc67a56f9a8746a8ec7d9791853dc892c1c33e0b.1755012943.git.lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <cc67a56f9a8746a8ec7d9791853dc892c1c33e0b.1755012943.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.08.25 17:44, Lorenzo Stoakes wrote:
> As part of the effort to move to mm->flags becoming a bitmap field, convert
> existing users to making use of the mm_flags_*() accessors which will, when
> the conversion is complete, be the only means of accessing mm_struct flags.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


