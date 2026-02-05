Return-Path: <linux-fsdevel+bounces-76394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKZbCDl5hGlU3AMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76394-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 12:04:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CB482F1A02
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 12:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAE91301D4CE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 11:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8353AA1AB;
	Thu,  5 Feb 2026 11:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="03S1SqJo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CDB3A9621
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 11:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770289452; cv=none; b=EMvGEqnQsSM0iP3PthBVs7i3Se6YWF/4YqKk0PFfJ0fgl7OtwE/dsQ+KmA3nIrjVbz+QEN833G4BS651mbddr0iPksHvjFr1OZ3EgP4DN1n4XELOcPAfTWEtOFYDaxKdldVjZ7EMtPEKNIyOLoq/vQnTXiq1qkJl5vGp682P9hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770289452; c=relaxed/simple;
	bh=IgZWvTB7RDsJ+EoqXU2SxH1H5wVJn5fVr0cKgKEL31g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WJWuyry7onkNlX++Y3BI0GtIuNIDj/DkrxDUVjcEoSTtb2Qul5O4wuz4Jf1y1vp88U969gytY7jkOHdEdgChT3wkv5OJwRfnq7vrPlYqd05CsYkCKB5BHOyPfAIpqJyTeGYp+ZgmLgmJKaMVfJXHGwUMMbchcayGJ+XX+LAf2fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=03S1SqJo; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-482d8e6e13aso7434595e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 03:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770289450; x=1770894250; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=89hL5xRbrc/VbCzks41N6CYINZBf+zOJ4ZeQZ8mSub0=;
        b=03S1SqJoRO6NpsMwupIDV/bSUuJ7Is91IzNqLFRp9z1m19IP99BZ4wK+bg17PAaMcq
         Vt2LPzz2A2pmbkJFSppLE+pJPkizZm99mQQXzEbScLjRGysKnpIr7lmiQKcGH/GDYQWf
         2cRXv44VRXyoe5dXtpv916ykrbcHw0XebCmr6Ng+XhA7xmOOULd2SoiDJXnYYZKdIalj
         imP6aSjRGRrWd+LF3hi33lNvheRApXUI0c0cxX06fDwXMLHQuUTBkuq0S58/mrpvNax3
         uvVPm0u25AwgZv3QrMeoAKv/qdIMQL3oqGFg96jFsv/vbcld+qrPZKGtO5PtX3HG2wga
         BehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770289450; x=1770894250;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=89hL5xRbrc/VbCzks41N6CYINZBf+zOJ4ZeQZ8mSub0=;
        b=X83RB+Y9WbbOnVOoW4jBR1o3x4Y3YvDZfYd7U2bc67eo3cNafzkEGnTvZr0d/02MxT
         bb7MG/CAeVtL8io++i3GFZWoqZEhvRTFxjNef4mcSupKxsCTllm5eayazeSiwn4vjiWB
         XUzb049TBDOu1Pmgm0Aj050U2TWcT4W/HBW9GvvLkXm7EzBl2U/1fULBsfrCXuegUND1
         j0/v42qpCTX//M2s9w22xf3Wna6BpCypXYqrrwv2ylcQ/G5XE37pJWmxmA1F4DeqWTEv
         F9P5hj2CLKAjuIS3Kl8Gt3eK1z8HnzFEYzIERMA7WWxKMaxCJa3isSf/QPtl8FeDU4gC
         CsnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtT6PB33eo+Pk02WOFURM2kxaPfAnOeqQSUVGelfz6Z5v//DltIZEYE1zYBH9q0eUR2avWch46VYgp21fg@vger.kernel.org
X-Gm-Message-State: AOJu0YyVrfwUonZQlh6lwTLhT3NJpR5W5TQpduUFLqz6TQgxlmstdBqo
	R9FQrPMSMRltpqNYxKp8K+SOg2/MHcigu/FRRaenuBw4ykj2UPcwl4ecUDB2stliO336WNPNht6
	zNSkGXJ8NH6e146n6+w==
X-Received: from wmjt15.prod.google.com ([2002:a7b:c3cf:0:b0:479:2d82:5535])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:35d5:b0:47e:e8c2:905f with SMTP id 5b1f17b1804b1-4830e926302mr90738135e9.8.1770289449847;
 Thu, 05 Feb 2026 03:04:09 -0800 (PST)
Date: Thu, 5 Feb 2026 11:04:07 +0000
In-Reply-To: <d3dca137-2e4c-4a1a-bdec-63cc2477bfda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260205-binder-tristate-v1-0-dfc947c35d35@google.com>
 <20260205-binder-tristate-v1-3-dfc947c35d35@google.com> <d3dca137-2e4c-4a1a-bdec-63cc2477bfda@kernel.org>
Message-ID: <aYR5J0ip2MdD3nMP@google.com>
Subject: Re: [PATCH 3/5] mm: export zap_page_range_single and list_lru_add/del
From: Alice Ryhl <aliceryhl@google.com>
To: "David Hildenbrand (arm)" <david@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Carlos Llamas <cmllamas@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Dave Chinner <david@fromorbit.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76394-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,google.com,zeniv.linux.org.uk,kernel.org,suse.cz,paul-moore.com,namei.org,hallyn.com,linux-foundation.org,fromorbit.com,bytedance.com,linux.dev,oracle.com,suse.com,gmail.com,garyguo.net,protonmail.com,umich.edu,android.com,vger.kernel.org,kvack.org];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CB482F1A02
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 11:59:47AM +0100, David Hildenbrand (arm) wrote:
> On 2/5/26 11:51, Alice Ryhl wrote:
> > These are the functions needed by Binder's shrinker.
> > 
> > Binder uses zap_page_range_single in the shrinker path to remove an
> > unused page from the mmap'd region. Note that pages are only removed
> > from the mmap'd region lazily when shrinker asks for it.
> > 
> > Binder uses list_lru_add/del to keep track of the shrinker lru list, and
> > it can't use _obj because the list head is not stored inline in the page
> > actually being lru freed, so page_to_nid(virt_to_page(item)) on the list
> > head computes the nid of the wrong page.
> > 
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > ---
> >   mm/list_lru.c | 2 ++
> >   mm/memory.c   | 1 +
> >   2 files changed, 3 insertions(+)
> > 
> > diff --git a/mm/list_lru.c b/mm/list_lru.c
> > index ec48b5dadf519a5296ac14cda035c067f9e448f8..bf95d73c9815548a19db6345f856cee9baad22e3 100644
> > --- a/mm/list_lru.c
> > +++ b/mm/list_lru.c
> > @@ -179,6 +179,7 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item, int nid,
> >   	unlock_list_lru(l, false);
> >   	return false;
> >   }
> > +EXPORT_SYMBOL_GPL(list_lru_add);
> >   bool list_lru_add_obj(struct list_lru *lru, struct list_head *item)
> >   {
> > @@ -216,6 +217,7 @@ bool list_lru_del(struct list_lru *lru, struct list_head *item, int nid,
> >   	unlock_list_lru(l, false);
> >   	return false;
> >   }
> > +EXPORT_SYMBOL_GPL(list_lru_del);
> >   bool list_lru_del_obj(struct list_lru *lru, struct list_head *item)
> >   {
> > diff --git a/mm/memory.c b/mm/memory.c
> > index da360a6eb8a48e29293430d0c577fb4b6ec58099..64083ace239a2caf58e1645dd5d91a41d61492c4 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -2168,6 +2168,7 @@ void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
> >   	zap_page_range_single_batched(&tlb, vma, address, size, details);
> >   	tlb_finish_mmu(&tlb);
> >   }
> > +EXPORT_SYMBOL(zap_page_range_single);
> 
> Why not EXPORT_SYMBOL_GPL?

I just tried to match other symbols in the same file.

Alice

