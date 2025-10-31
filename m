Return-Path: <linux-fsdevel+bounces-66592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CE5C25604
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 14:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 885644E8AF5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 13:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E21E34B42C;
	Fri, 31 Oct 2025 13:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="SivK9mM1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6342534A3AC
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 13:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761919105; cv=none; b=utCevXU0Tj4br0c4YVWk7LvlCyufI6eHoz5POXLfcEk0Ar/NsfflZpg0Z+R5J1gJe0GLZ9Xad61Gw2ZvK7Gq5Ojlsit/aXYI48ztn1SvBz+qvnqOlFtQbrwu/d+Q/ycW7Dl0JGLiyZIler2DZDhCplqBK58mqq2Bc0W6WXWOA9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761919105; c=relaxed/simple;
	bh=jxbdgfaupleKnoKUaQ3/ywyBHovB8OcivEL0GTAj8QI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YV9DTkP8h/Wh7gvAd3BC7OLdVBBMybLsH9EVqygfHmZYRxwGNROZzf51bLZHEAUk/OPAy20SZ41H2RuBwF5O+wrAku27xRwYvYQUC0aeFb94e8S4c0lgR47UgXdg3KZbXuYVkCsl/nddjbh+kjgaJnR7RTxwJLn2Q21P1lWDPkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=SivK9mM1; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4e89de04d62so18699461cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 06:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1761919102; x=1762523902; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4S0mka8jGiqhtu5Z/8KUXJ1hNRdqooEO/ICp8xqPw1s=;
        b=SivK9mM1FM9aNj+j1zkz+BM1pi1rpZkSdkhIUdr67YJ2Ozdnr+O3y0hpFrRrRHcbLe
         Ma0Fdd+gg5q9eltKVFatQlAywtABlQ41n1S65E2v9D9XCs/X2bHcLTxL8TMOoVJMcb1t
         XJzy6I469rm8tw8e1PtMiJ1o8C6KNn4CLd+WYrRu8Vvz0Vk0fHGF9FW3wereh2PibfdI
         mzzgqE6OU1Tg7jXc93L8cZ4plRP/f0TTU81rNo8by7pdjLjwk5BRh3PcDgCZCpPZ58jS
         u0WAieaGjjMNsnKuLBEPdR16YnXwtrrHaPMEuuVVkJ0S9WLBkwk6BZPKgSVlWZxDupSW
         kYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761919102; x=1762523902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4S0mka8jGiqhtu5Z/8KUXJ1hNRdqooEO/ICp8xqPw1s=;
        b=V3P+cRBh/eW3VT9wzDecDGuo8w0cwvTLKOxZxum7AzFz7PnFbebEcBfJ7vbBlFxOxx
         vA+9FmPiRmAEGhvjquOcECNVGmNKW91XKvWo6kPvzdRNPpNXZnOyYOUn3oYrgIDvs8bm
         GW0QipJBUmv5iR8oX41n5VNSUb5SMctMTKcLnGBDInoVApQqqDEpvhgKGfO3pgKoDQXb
         Kjxj3Oo6PtVG5yBLUNoNbyUwPezjLD9LASq7TX6GtV5Vhhrjsn+vTZlV9hPyJiKINP6k
         V1B1F9vUmY5Q/0+Q9pn6Axye8t5IKeHf6WTw0GOZwj/P+yNOxKBeVtzZu3mrMTz0zbbG
         iq/g==
X-Forwarded-Encrypted: i=1; AJvYcCUVq6JzUynCcETRp04YhLK1gMWf1dr2tKYwrYPH65n6UlJQLMYoMho6XGgUNf04TXzPk6i8rtFczSvkDC+f@vger.kernel.org
X-Gm-Message-State: AOJu0YyJV0jc/UBzaOI1KO2xrUqrWlkLxySjpR5hFb3VBm4hk5+BgH5B
	//+30NAFztf/1j/lvBAiKl/nsJRZUQlo15l8kV8V09/wGunSBvPEEALqmAlZdNqTQ+Y=
X-Gm-Gg: ASbGncskUWhtZdH/CHr0/R4n4kcTGyKM5BgttvtjM6U6qzERtE5Hkm8rH/z40fCcgds
	u09vxqaeedw+aILOFOaePvE7suDav6XSEnwzoIRdYtoeeMv+IkL8KFg3ip4rzxWdJzyLiAbo05/
	fq2QEgqJ8o+1TaQFZRJdMCtBdnRbMKoL6QHgl2k3Ju+ZGbsgJJ5LCDPJE0kD7EdU5p0pvny4aoX
	NvQsIypptqbA6JLw3BCVot6Ri8Gj78ejGHDImmzSdO1Yc9RfnVlEWdd83ka0mFGaSNY7orGAiYi
	1kPevH7dIhVvo2gHGjnzYHp4TGfrgFzcrVCdLYYk5pIVwOL6SSl4qrvykVaRwDq5C95cgLA1qDX
	a+UzL8k49aMOpZuFrH2gTTsFs786KVPr+mhdzE36Vbl47H+sRYTxAQVD2YbQvkpfZF0G6VNLUcY
	29NMfHWnAXS/yOYlwpyFoNGQRlsRSiT2qByYfrwPDyNbNMqrhkPExJQaQB2iLaISt5JPz0HQ==
X-Google-Smtp-Source: AGHT+IFUTwsA2dbbxdluP2M6MQtg1EQ3qn+mIRsc6BUtZCrQZJJLWzhdFTNRyqmV7Af8J/4OoxxHWg==
X-Received: by 2002:a05:622a:1985:b0:4e8:a3ed:4c50 with SMTP id d75a77b69052e-4ed30dd6d5bmr40807401cf.24.1761919102031;
        Fri, 31 Oct 2025 06:58:22 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-880362d7baasm11755356d6.33.2025.10.31.06.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 06:58:21 -0700 (PDT)
Date: Fri, 31 Oct 2025 09:58:18 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@redhat.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Peter Xu <peterx@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Kees Cook <kees@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Jann Horn <jannh@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	David Rientjes <rientjes@google.com>,
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/4] mm: declare VMA flags by bit
Message-ID: <aQTAejgLn8_Er8RF@gourry-fedora-PF4VCD3F>
References: <cover.1761757731.git.lorenzo.stoakes@oracle.com>
 <a94b3842778068c408758686fbb5adcb91bdbc3c.1761757731.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a94b3842778068c408758686fbb5adcb91bdbc3c.1761757731.git.lorenzo.stoakes@oracle.com>

On Wed, Oct 29, 2025 at 05:49:35PM +0000, Lorenzo Stoakes wrote:
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index db16ed91c269..c113a3eb5cbd 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1182,10 +1182,10 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
>  		[ilog2(VM_PKEY_BIT0)]	= "",
>  		[ilog2(VM_PKEY_BIT1)]	= "",
>  		[ilog2(VM_PKEY_BIT2)]	= "",
> -#if VM_PKEY_BIT3
> +#if CONFIG_ARCH_PKEY_BITS > 3
>  		[ilog2(VM_PKEY_BIT3)]	= "",
>  #endif
> -#if VM_PKEY_BIT4
> +#if CONFIG_ARCH_PKEY_BITS > 4
>  		[ilog2(VM_PKEY_BIT4)]	= "",
>  #endif
>  #endif /* CONFIG_ARCH_HAS_PKEYS */


I realize this causes some annoying churn, but is it possible/reasonable
to break the no-op ifdefsphagetti fixes into a separate diff?

it makes it easier to see this change:

> -# define VM_PKEY_BIT0  VM_HIGH_ARCH_0
> +#define VM_PKEY_BIT0 VMA_BIT(VMA_PKEY_BIT0_BIT)

~Gregory

