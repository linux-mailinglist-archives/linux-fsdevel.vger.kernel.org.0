Return-Path: <linux-fsdevel+bounces-52588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E35DCAE467B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 16:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 700A2189B56D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 14:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A3A248191;
	Mon, 23 Jun 2025 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gz2WrE8Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777D65680
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 14:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688277; cv=none; b=SHeIMUFfoMBZP3u/7OV8MCARiOrRzkQe9nuhMcEsDN+D4gg+3w/NO9axYz6yXnA3tP+TKQrWML9CrH6vmc0P6R+DlIw2OrJBKyX6oZtntsgaPjgybpQ7iOkeJVEgxgOacX/0Zyvgjyd5PoucNrtdhg++3L4CqT2gIyi7D8WaWQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688277; c=relaxed/simple;
	bh=y9FLq6e7Df41x768C3DaE7ioc295ESzZDb/ud7F+0J8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qIvDeZjL+vRZZzvko+kmPypUBd26E1JXISGrbLsf5A2VJ6RZ3KzPtOmGN8qZLOAbPB9+gEY3FaO9VI3rauA+09a2L3l8T9d3TjWoj9cgieWAUAGnrwctgPNmhxk0aE36MfqaTTk5VoDfyWhHC4Q+ULCqD1FX62vaMUf6lcyp/DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gz2WrE8Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750688273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AT6z0J+Z7BRb7a4a/ZOwq8sPn4rNW6on998iWVe3KsU=;
	b=gz2WrE8ZQlyWY9i0qziyrr5pihC8kPY32CtYWuW03wSWbVnrf9H/nPpbgcGbZtDKxCpzcn
	gjNbIJ/Q+lVbuapcf3sZB6v6eOM4Qu3z6OgzfA+hJ08xqBTfRc3g+L52BLzCMdY8cItMfY
	puNCBnZjszVQJqJf60q4av/4cvuGvq0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-PbVCchwdPQq5-fVnyggxgg-1; Mon, 23 Jun 2025 10:17:52 -0400
X-MC-Unique: PbVCchwdPQq5-fVnyggxgg-1
X-Mimecast-MFC-AGG-ID: PbVCchwdPQq5-fVnyggxgg_1750688271
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a503f28b09so2138301f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 07:17:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750688271; x=1751293071;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AT6z0J+Z7BRb7a4a/ZOwq8sPn4rNW6on998iWVe3KsU=;
        b=UbkzhAzpHxrhp2q1nXCsoUXbE4J8BTgap9fMTd00LuuMc9oW2sK8zKpgxT2kDkybQN
         rf1V7QS7gDAL/SVmYBY2qPV7kXOCYXy5d/jItrEFGrIdreZfCPGUcLhbC+1HOB7bFleL
         JsGayujOAj+QoxE3ZxbrtNd8Y6qTPgaWHD319vj6IzklJbSZ8gHr5UeNEDdYGTgmh45A
         X1Gjz2I5Ntr7Sy5uZXvzmLFHiQlMzGVQTz1qWJvLX94+rBCoafHFvMuymtKmBChW9f51
         kTCnBv4EIxi2jh1vx8FPFnPREAWQfvyCB2CzXXW/OKoRJQCPMPuNIitNywqVEhtdTO56
         rX/g==
X-Forwarded-Encrypted: i=1; AJvYcCX9YRZSxBJu4nfPvktc54/3Lb30b26nZP3aUFyIlJUThqtJdJYV3YUuoELNEu75LBmTEMkplLJn7Yv0BkRL@vger.kernel.org
X-Gm-Message-State: AOJu0Yw71mGFsCMKcPPIvqF5/IwkhjtsxaK5AxSXzbwra1pwLci4D2XH
	Di0yp0VaM8wAGtJmsbdkR8bZAQlGYujTy+9PWPlQc+OOqMOdA7pfj23s07CjYdH5kgMtL6w7Yfz
	Y9OOJdo9ndTwZWgFrkPJuXs1b9A7ELobfb92Y6GKu5NvyQzeV1ip611RsrlXYAqYkG+A=
X-Gm-Gg: ASbGncu+WdfyRfTjSOtkz0jP1UZEM76TKWYDfl7noJc7ur+fPf8r70zG440ZTjeeoi2
	z3blgCrLdEA8D+TsxAOcdA4rGo+lsIX3gVG5xnpERd+zHrSqNFq7lqiEQMM7VT0Fi6HQxGNhSb0
	QOwEulE5okLX87SvtTA6fridfbXykZoy6M7n1vn4BvSgMC1x488j3XeRTrtaz1vX8Z69VO2ygIe
	f+79b+oO8PHh6fMdxP3qwfJaoiwHTY5bvjKJIVyJyf9dnTiUwaE2cKqh+ELJCxhWkBOKGj9i0xU
	zPoWr7Fx7YSKFCBGNlyhdDV6o6aqbRcDoAWFGbVXXvTyMxrItL0W2+gucrq+E0T2Xmg31wtGM4G
	CNEVyHI1THiWDBwSwNLib1p56euEUFPS9g4BnJPZLer2eL7F/+A==
X-Received: by 2002:a05:6000:2913:b0:3a4:d685:3de7 with SMTP id ffacd0b85a97d-3a6d2799e03mr8524094f8f.8.1750688271012;
        Mon, 23 Jun 2025 07:17:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVEYbdHympic4C845xjbGIaDAfJ4O6TUpDQzaRepXXtAy+1Ld3k5fQBQt9u4TU2HYvxvW5QQ==
X-Received: by 2002:a05:6000:2913:b0:3a4:d685:3de7 with SMTP id ffacd0b85a97d-3a6d2799e03mr8524018f8f.8.1750688270392;
        Mon, 23 Jun 2025 07:17:50 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159? (p200300d82f4efd008e13e3b590c81159.dip0.t-ipconnect.de. [2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535eac8bb6sm147000545e9.25.2025.06.23.07.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 07:17:49 -0700 (PDT)
Message-ID: <18ef9a51-c029-40a8-b9e4-60c46c83ccef@redhat.com>
Date: Mon, 23 Jun 2025 16:17:46 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mm: update core kernel code to use vm_flags_t
 consistently
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "David S . Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Jarkko Sakkinen <jarkko@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Kees Cook <kees@kernel.org>, Peter Xu <peterx@redhat.com>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache
 <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 Hugh Dickins <hughd@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry.yoo@oracle.com>, Dan Williams <dan.j.williams@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, sparclinux@vger.kernel.org, linux-sgx@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, nvdimm@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org
References: <cover.1750274467.git.lorenzo.stoakes@oracle.com>
 <d1588e7bb96d1ea3fe7b9df2c699d5b4592d901d.1750274467.git.lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <d1588e7bb96d1ea3fe7b9df2c699d5b4592d901d.1750274467.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.06.25 21:42, Lorenzo Stoakes wrote:
> The core kernel code is currently very inconsistent in its use of
> vm_flags_t vs. unsigned long. This prevents us from changing the type of
> vm_flags_t in the future and is simply not correct, so correct this.
> 
> While this results in rather a lot of churn, it is a critical pre-requisite
> for a future planned change to VMA flag type.
> 
> Additionally, update VMA userland tests to account for the changes.
> 
> To make review easier and to break things into smaller parts, driver and
> architecture-specific changes is left for a subsequent commit.
> 
> The code has been adjusted to cascade the changes across all calling code
> as far as is needed.
> 
> We will adjust architecture-specific and driver code in a subsequent patch.
> 
> Overall, this patch does not introduce any functional change.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---

Probably some cases might sneak in in the meantime :)

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


