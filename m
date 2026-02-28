Return-Path: <linux-fsdevel+bounces-78824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHscJ+bhomkQ7wQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 13:39:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 422021C2FFC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 13:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3104030383FE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Feb 2026 12:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1ADD43DA44;
	Sat, 28 Feb 2026 12:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mx+suYO4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D8136EA87
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Feb 2026 12:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772282333; cv=none; b=fhswNSJ9y2ssqAI0n19cROHzb9AcMONzFIDzJ9LuqA9vY2uW0WuhWUEg2w1rzC3Mngz8xIZ1I82Ibol96iV3pg835mLCFDjwd4nBZSH2e5K1aTG+xj3p7TUvxzlmwocKDfMUPSi62Mi7MVTA2Z+Q2/uenjPgVTVebgC3Cy40nl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772282333; c=relaxed/simple;
	bh=PEA8vWjT5ovfF14s1Tw4RTm8694oQcfI75jIBt+A4lE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uUFAQrMbznzquWfBXmUV4QaTCInnF2qcv0nJ6dnk11jYGFx7astD1BBJczG3kj8y43rK73NS0GwNSn1550Bk0gb/wWD8WPaTHqF2ApI9+KM2Tb5vbDIjC4RMK8pSd8673aUemne1x29g03zOvfcG37lECCWb19JxeVVjSIqcR/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mx+suYO4; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48378df3469so19515315e9.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Feb 2026 04:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772282330; x=1772887130; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mOaqhQImVlbU+bIaPkzVliN+MSpqLdHsMK4C5p4HbTE=;
        b=Mx+suYO4WAm6Esi84MZAoAmYsEg+faHqpOo9+bFiEOnlJdfwT+vS7ye5q++/MXA6g4
         mTIXqomnM6dz7b4tpK1KbP9UZmW5hzlb/wweLxY7zC8AbdZzTDy3F/KaN2VMw1wXsB66
         IAC4aSt0G9xxuaODA2KLVyEhRLb0dYJmfeWOOZXWzZ3Tj7iGwN4DH5r8OirXx5emK83X
         hFC6Ge2zWg/fc7qE1q3VrENHESF+g8ifwk+SOkHMggXufiEcnyLhtXrm+uV2F1gK9IJW
         /vh/E8zN7TllRgrU9JQ7pdZHtwYv695+yKsE8ye6vRoR2MHRk0HW1MoBXpi7GyXxLEJ7
         t7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772282330; x=1772887130;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mOaqhQImVlbU+bIaPkzVliN+MSpqLdHsMK4C5p4HbTE=;
        b=ZukDpyLxwxJYmzxORayMWhQtz6mfZrF6QJ9RcMnknXbmkLfN+krZMXm5SfXkPYbRRz
         5khL8pB4WltpVIcDkq0WG4FYQFcWeSHO3519SKnlUDOVQEZGcjB2h3r6nFeVydKfvhYw
         ScLLvvKsG6rtWk7/yei5fR6vBs7qORGFZZLdPzw/e3vHAznBv+IgbGbSnQBZ48Z15glt
         l+jyQ9lQqfXEQsK1k8jtd9wn0i+7woQAO+ZcgIeA/2qjvsYmSUMY85inu6I+G6Xh/Ccg
         +u4O5Fm9iAAdUl3s4Gvjz3Q6/brXTdtxC3CjYFiJOr0Utm+CT1okMNhOFB8WG7la09sB
         tq3A==
X-Forwarded-Encrypted: i=1; AJvYcCWk+dTN5OZDe1v7JtADpv7ff7/nVd5pAXNtt1KOUDvMGSiUeuNYg11pU3cfTpWGShXvdHELe7Dod+DndpXk@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Jcsu1HCoV+GooG37i2vONjzUmWjMjR34WKWJBRNXgQtWNVfk
	kzE55SVjNN9LaBNrAT4lEryruk0JA6f3ALcyTSzNinGER44f+1xxIj0ChsoFxldliOSxxRs+89i
	dngcwf+g8+DJBh5/58Q==
X-Received: from wmby19.prod.google.com ([2002:a05:600c:c053:b0:480:690c:88de])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b5b:b0:481:a662:b3f3 with SMTP id 5b1f17b1804b1-483c990c263mr116931775e9.7.1772282329804;
 Sat, 28 Feb 2026 04:38:49 -0800 (PST)
Date: Sat, 28 Feb 2026 12:38:48 +0000
In-Reply-To: <20260227200848.114019-3-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260227200848.114019-1-david@kernel.org> <20260227200848.114019-3-david@kernel.org>
Message-ID: <aaLh2BxSgC9Jl5iS@google.com>
Subject: Re: [PATCH v1 02/16] mm/memory: remove "zap_details" parameter from zap_page_range_single()
From: Alice Ryhl <aliceryhl@google.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
	"linux-mm @ kvack . org" <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Jarkko Sakkinen <jarkko@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, Ian Abbott <abbotti@mev.co.uk>, 
	H Hartley Sweeten <hsweeten@visionengravers.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Dimitri Sivanich <dimitri.sivanich@hpe.com>, Arnd Bergmann <arnd@arndb.de>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Miguel Ojeda <ojeda@kernel.org>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-sgx@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,linux-foundation.org,oracle.com,kernel.org,google.com,suse.com,suse.de,linux.dev,infradead.org,linux.ibm.com,ellerman.id.au,redhat.com,alien8.de,linuxfoundation.org,android.com,mev.co.uk,visionengravers.com,linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,ziepe.ca,hpe.com,arndb.de,iogearbox.net,arm.com,davemloft.net,lists.ozlabs.org,lists.freedesktop.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-78824-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[73];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 422021C2FFC
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 09:08:33PM +0100, David Hildenbrand (Arm) wrote:
> Nobody except memory.c should really set that parameter to non-NULL. So
> let's just drop it and make unmap_mapping_range_vma() use
> zap_page_range_single_batched() instead.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

> diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
> index da21d65ccd20..b8e59e4420f3 100644
> --- a/rust/kernel/mm/virt.rs
> +++ b/rust/kernel/mm/virt.rs
> @@ -124,7 +124,7 @@ pub fn zap_page_range_single(&self, address: usize, size: usize) {
>          // sufficient for this method call. This method has no requirements on the vma flags. The
>          // address range is checked to be within the vma.
>          unsafe {
> -            bindings::zap_page_range_single(self.as_ptr(), address, size, core::ptr::null_mut())
> +            bindings::zap_page_range_single(self.as_ptr(), address, size)
>          };

Please run rustfmt on Rust changes. Here, rustfmt leads to this being
formatted on a single line:

unsafe { bindings::zap_page_range_single(self.as_ptr(), address, size) };

with the above changed:

Acked-by: Alice Ryhl <aliceryhl@google.com> # Rust and Binder

Alice

