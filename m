Return-Path: <linux-fsdevel+bounces-76409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJDbGgmHhGl43QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 13:03:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FEDF22CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 13:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 519F1307EC48
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 11:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5BC3BFE40;
	Thu,  5 Feb 2026 11:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q9h9Uaqq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DB53B8D7A
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 11:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770292683; cv=none; b=bMC1d8uCNNJVW8aTSjrOaTctLrtmrGC5IoqQzbFgjWDjCf5MZzrsxBkCjWVimIqiXUcvY8EEH+Zlq9XeVxrQYGZ//d80MBWFGeWTvRLS8U0lsy8y/lt01mpquAtU62h+m7ytlOA+KK5X1aLZTiaGm+N+5l+M+BJeJv49KPHTxzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770292683; c=relaxed/simple;
	bh=owOn4NfEXJPahvyCs1+dVhCw3SUugjqxSNjuCWJTwrI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jEsKD2mk42az06NJwR9SFI9xtK504vU2xkhG5yOLknj5BbT3i9VnqpTudU76CHc5HGFECdV0TDVeX2NmiAWVjnkxl28D99SkLmZMtpq3YuTJSQEAhCGhlXcBrj8IvquWb7ax6zgjEy58NkbUhUnluUjVDfkPNkLTWbwP36UC4Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q9h9Uaqq; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-4325b182e3cso610187f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 03:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770292681; x=1770897481; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=30L32YMTRfZh1EnIU9CFZai9EgpumK+W4TFcDn64HBM=;
        b=Q9h9UaqqViZ6pUFabLcnl3jyvzexxzM6mDpU2uCUMFx6LIVO8Ng5lGo7VzVrJ9JSMh
         dRslR85St5+NQ1MuYZcmSjLU7pL0Y3PTmsL5O80GhHJZMaO4ETD6z3U2ibcOJmjnYIKO
         dCjU1yFWFlhrWbgM27K7NP/ggw/W2jQzFSprXShIYfJXCRVRWusRnCXjbrjr5CyjxrFX
         ooWYlDj3ZwuSfPBExNmhUwx48xU3pZ3+znL29+WmFLBuoiWOEVkscCZRrb529yQ8dv4e
         49MQ56vxOsMKCVC0wGDEkDtTakXyYQ6dhUFGiktXrH+UMq1rZBpkc6+F6yEwKbZluQYz
         +ioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770292681; x=1770897481;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=30L32YMTRfZh1EnIU9CFZai9EgpumK+W4TFcDn64HBM=;
        b=lktxcrTJEfCO2mVixw9kOnL/dESY/Nuk3o/ckru4zFsMKNZuhNqL8f2DF5R/YuhWRL
         vTLhEpTRAtgRZ6AJVSLa2+/d8ZK8Xa7wq/QAthn/7VJOq25cHledhF4VAZRIdtf6aiHF
         ARV5XTqc7c2w23LqFzvMeUveSu2xhkaNSucSBL6TD6UVZ7lHfyoonCP76y3yROpMICxy
         PUUk49yXzLiR+Qfvnyb1PBj7xbuDVmW5tGhqtd4If33G+5Nmjg4mULqPt3sWvGYe8k7M
         kvqSTiClreUHie/SK5EfZQ0b7SsEdWTnJphdmti7VV2pwKtSRzXqNJgx+bqRPSnMWt4J
         Ki4A==
X-Forwarded-Encrypted: i=1; AJvYcCXx3oaCj9CZF4yPrwrU8qm0ohA40BSHY46ZAzinV12bbHpZar/ai8AQqGlRpp7j8ow8Tvn+iPZQAFsXNcJw@vger.kernel.org
X-Gm-Message-State: AOJu0YwSlDJZICLSdUruCWdeqQHa19YPhdWmOOIdg0BizX62ZqTEzEWD
	jlp0L11BLlBAFQkXGH0OTuLmvFggJp55c74jGTRCWlrfZMaK0ItaVR7+O7VotN/9cymSKUFV1G1
	5ZMSED3a3ZEQ1cyj7lQ==
X-Received: from wrqm13.prod.google.com ([2002:a5d:4a0d:0:b0:436:e5d:8f4])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:64c3:0:b0:436:d10:a6b0 with SMTP id ffacd0b85a97d-43617e422f7mr9490372f8f.20.1770292681357;
 Thu, 05 Feb 2026 03:58:01 -0800 (PST)
Date: Thu, 5 Feb 2026 11:58:00 +0000
In-Reply-To: <21d90844-1cb1-46ab-a2bb-62f2478b7dfb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260205-binder-tristate-v1-0-dfc947c35d35@google.com>
 <20260205-binder-tristate-v1-3-dfc947c35d35@google.com> <02801464-f4cb-4e38-8269-f8b9cf0a5965@lucifer.local>
 <21d90844-1cb1-46ab-a2bb-62f2478b7dfb@kernel.org>
Message-ID: <aYSFyH-1kkW92M2N@google.com>
Subject: Re: [PATCH 3/5] mm: export zap_page_range_single and list_lru_add/del
From: Alice Ryhl <aliceryhl@google.com>
To: "David Hildenbrand (arm)" <david@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Dave Chinner <david@fromorbit.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-mm@kvack.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76409-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linuxfoundation.org,google.com,zeniv.linux.org.uk,kernel.org,suse.cz,paul-moore.com,namei.org,hallyn.com,linux-foundation.org,fromorbit.com,bytedance.com,linux.dev,suse.com,gmail.com,garyguo.net,protonmail.com,umich.edu,android.com,vger.kernel.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D1FEDF22CD
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 12:43:03PM +0100, David Hildenbrand (arm) wrote:
> On 2/5/26 12:29, Lorenzo Stoakes wrote:
> > On Thu, Feb 05, 2026 at 10:51:28AM +0000, Alice Ryhl wrote:
> > >   bool list_lru_del_obj(struct list_lru *lru, struct list_head *item)
> > >   {
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index da360a6eb8a48e29293430d0c577fb4b6ec58099..64083ace239a2caf58e1645dd5d91a41d61492c4 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -2168,6 +2168,7 @@ void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
> > >   	zap_page_range_single_batched(&tlb, vma, address, size, details);
> > >   	tlb_finish_mmu(&tlb);
> > >   }
> > > +EXPORT_SYMBOL(zap_page_range_single);
> > 
> > Sorry but I don't want this exported at all.
> > 
> > This is an internal implementation detail which allows fine-grained control of
> > behaviour via struct zap_details (which binder doesn't use, of course :)
> 
> I don't expect anybody to set zap_details, but yeah, it could be abused.
> It could be abused right now from anywhere else in the kernel
> where we don't build as a module :)
> 
> Apparently we export a similar function in rust where we just removed the last parameter.

To clarify, said Rust function gets inlined into Rust Binder, so Rust
Binder calls the zap_page_range_single() symbol directly.

Alice

