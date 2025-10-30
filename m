Return-Path: <linux-fsdevel+bounces-66492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42803C2116E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 17:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 621383BA3B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 16:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF5A3655E0;
	Thu, 30 Oct 2025 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CDvt75El"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3303B1DB15F
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 16:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761840310; cv=none; b=oKQeKZM49XGsghDEB14fmAEwOfisMoyBbcRsTH27faGdYg9ig0WHbmntzVk48Bc5lJq8iajFY9hvjkni7BCjuRqjLuGnMdJe9WlBSVoCNZJUhlXBFPUPeGZ9P27SsiKX8wenaHDZTL/SI1rzO9A4j8vskLznY0wPlLK/vRaxNhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761840310; c=relaxed/simple;
	bh=c9b8XC/fH65U9UHUGq3SmXgvpJYhZ/Lo5B2qlcSERQ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uxMbpZZaaqA1thAVxH2D2CSYq8xw/QOcZWn951gr318A6lmpJHhVHcw5v7WbdojSXo5UpenSvtxcYkxJBHjtSQNtWqtbGXDwe6ZzdrWgrstEL5A8VQzOBTGUtdqzAWgi0GaGYuSL/sMTHrqyvlhLdWXN4AqD9NMbL5Euiiu3xoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CDvt75El; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3f7b5c27d41so852118f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 09:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761840306; x=1762445106; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c9b8XC/fH65U9UHUGq3SmXgvpJYhZ/Lo5B2qlcSERQ0=;
        b=CDvt75ElY3hdyLEZnu5e1h6J5sMfYbfZLViMq0FtvdBo6f3AztmUt90lVbhofK72EK
         b745wROqFofANCzBlhNHxm2KN+pTzU7kvyPTuPbvqLi1LG6nKhZqILpjkBgZPRq3kQuZ
         eyaOBe6qbuD9b0wvX7pcUmBDcYD2CI22Sy3ewlxtzOTvkRQlq2xVjXPpNff1VPHu7hCt
         ohJUvsZxnM6hRmARijIiA/iL77tvS5Cr/S5iPd0vUw9HVrbfAcdYfOiY0/wb2ZB398fe
         i0MBwZqx3tS3Cn0LlwnHMPfjgclAImjU3fkpRYKslFfi8jX2Sc0EZmrHnTIGFrth8N0S
         fUZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761840307; x=1762445107;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c9b8XC/fH65U9UHUGq3SmXgvpJYhZ/Lo5B2qlcSERQ0=;
        b=Yg8aGUNT2fKYiz45imOYSOIa0g4+vibqcxD8fybvc9Hf5gKXwphRujLHO8v5nDOoKR
         mBCtiJzUzVjr4dFpBOBBhBbFHGTl+xel39I6KT641ubww+odHEqd5lyq4fRKZxNJ4VJ8
         MkUZkIHQRSm/q8+cYMX7XzvftrEMRZxbiSwP7T/f6C4GGsLCNkE93UHU26Ba17hLvwdd
         UM7a9NeRkJ+vL8TMQIzPpwAcq6wGYAVekxp5/irkH0l3nV1snop3iVH3eUMm0JB0Ml+U
         +nWmzARMvbyUCaLY88lryk3CJnRqfs6bHRmnsNwKlakWnaV6yjcpDBV3sfp1OFyI++4o
         8AFw==
X-Forwarded-Encrypted: i=1; AJvYcCX82RHFicm8LDHBlSKpsDGNh7Ui3/kdRTdp9q/ElkFF615dLIhafYG66rYW48eOy9o8s3+cNKk8w4IG+AwD@vger.kernel.org
X-Gm-Message-State: AOJu0YzoeDu4/IeRAGkR5WD4bw4157+p5LBdfsWfeDzeBuF5ZelD5CNI
	esdd7YU+pRlpGh1eu2SWwBKyhMskU/FTlooxSPmgbqYV6GVycKAzM9aKj9q3B04xk2hWcvBXpxD
	rl0rR974L/l9AKA==
X-Google-Smtp-Source: AGHT+IHjMaURNuY5ADspjcwjcl/WRoZFYO9bioemMflpQGaxNDVvaG4JDdR/nXAPdbz/Yfz+Utvfc7Y4KaunSA==
X-Received: from wmbz6.prod.google.com ([2002:a05:600c:c086:b0:471:6089:1622])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2408:b0:429:8b8a:c32b with SMTP id ffacd0b85a97d-429b4c83176mr3266075f8f.22.1761840306279;
 Thu, 30 Oct 2025 09:05:06 -0700 (PDT)
Date: Thu, 30 Oct 2025 16:05:05 +0000
In-Reply-To: <e25867b6-ffc0-4c7c-9635-9b3f47b186ca@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924151101.2225820-4-patrick.roy@campus.lmu.de>
 <20250924152214.7292-1-roypat@amazon.co.uk> <20250924152214.7292-3-roypat@amazon.co.uk>
 <e25867b6-ffc0-4c7c-9635-9b3f47b186ca@intel.com>
X-Mailer: aerc 0.21.0
Message-ID: <DDVS9ITBCE2Z.RSTLCU79EX8G@google.com>
Subject: Re: [PATCH v7 06/12] KVM: guest_memfd: add module param for disabling
 TLB flushing
From: Brendan Jackman <jackmanb@google.com>
To: Dave Hansen <dave.hansen@intel.com>, "Roy, Patrick" <roypat@amazon.co.uk>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>, 
	"maz@kernel.org" <maz@kernel.org>, "oliver.upton@linux.dev" <oliver.upton@linux.dev>, 
	"joey.gouly@arm.com" <joey.gouly@arm.com>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, 
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	"will@kernel.org" <will@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "luto@kernel.org" <luto@kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "willy@infradead.org" <willy@infradead.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "david@redhat.com" <david@redhat.com>, 
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, 
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "vbabka@suse.cz" <vbabka@suse.cz>, 
	"rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com" <surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>, 
	"song@kernel.org" <song@kernel.org>, "jolsa@kernel.org" <jolsa@kernel.org>, "ast@kernel.org" <ast@kernel.org>, 
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "andrii@kernel.org" <andrii@kernel.org>, 
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "eddyz87@gmail.com" <eddyz87@gmail.com>, 
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"sdf@fomichev.me" <sdf@fomichev.me>, "haoluo@google.com" <haoluo@google.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "peterx@redhat.com" <peterx@redhat.com>, 
	"jannh@google.com" <jannh@google.com>, "pfalcato@suse.de" <pfalcato@suse.de>, 
	"shuah@kernel.org" <shuah@kernel.org>, "seanjc@google.com" <seanjc@google.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Cali, Marco" <xmarcalx@amazon.co.uk>, 
	"Kalyazin, Nikita" <kalyazin@amazon.co.uk>, "Thomson, Jack" <jackabt@amazon.co.uk>, 
	"derekmn@amazon.co.uk" <derekmn@amazon.co.uk>, "tabba@google.com" <tabba@google.com>, 
	"ackerleytng@google.com" <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu Sep 25, 2025 at 6:27 PM UTC, Dave Hansen wrote:
> On 9/24/25 08:22, Roy, Patrick wrote:
>> Add an option to not perform TLB flushes after direct map manipulations.
>
> I'd really prefer this be left out for now. It's a massive can of worms.
> Let's agree on something that works and has well-defined behavior before
> we go breaking it on purpose.

As David pointed out in the MM Alignment Session yesterday, I might be
able to help here. In [0] I've proposed a way to break up the direct map
by ASI's "sensitivity" concept, which is weaker than the "totally absent
from the direct map" being proposed here, but it has kinda similar
implementation challenges.

Basically it introduces a thing called a "freetype" that extends the
idea of migratetype. Like the existing idea of migratetype, it's used to
physically group pages when allocating, and you can index free pages by
it, i.e. each freetype gets its own freelist. But it can also encode
other information than mobility (and the other stuff that's encoded in
migratetype...).

Could it make sense to use that logic to just have entire pageblocks
that are absent from the direct map? Then when allocating memory for the
guest_memfd we get it from one of those pageblocks. Then we only have to
flush the TLB if there's no memory left in pageblocks of this freetype
(so the allocator has to flip another pageblock over to the "no direct
map" freetype, after removing it from the direct map).

I haven't yet investigated this properly, I'll start doing that now.
But I thought I'd immediately drop this note in case anyone can
immediately see a reason why this doesn't work.

[0] https://lore.kernel.org/all/20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com/T/#t

BTW, I think if the skip-flush flag is the only thing blocking this
patchset, it would be great to merge it without it. Even if that means
it's no use for Firecracker usecases that doesn't mean the underlying
feature isn't valuable for _someone_. Then we can figure out how to make
it work for Firecracker afterwards, one way or another.

(Just to be transparent: my nefarious ulterior motive is that it would
give me an angle to start merging code that will eventually support ASI.
But, I'm serious that there are probably users who would like this
feature even if it's slow!)

