Return-Path: <linux-fsdevel+bounces-76396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOR+HHh8hGlU3AMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 12:18:16 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 515FDF1C6C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 12:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C1821300B5BC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 11:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263821C2324;
	Thu,  5 Feb 2026 11:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bJOkg6D/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5603314A4
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Feb 2026 11:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770290288; cv=none; b=AsAIwGbTQ/juxJFnlrXtDsMD4uTfoXw6YbMBHJ3eXi3Lo5FY9X2YeDn4h6WGwTxXqdx6oJs9yroFm6l34M9ymVo42Pffx0DgnopiUHvvHlsJpmP7rCJ/GUHr7nbAG9GpCrZSNQL6tiCJQWwL1120LHpLOM698cZPRLu6aKk3RAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770290288; c=relaxed/simple;
	bh=AE7Z1z/ctiKTAKwDjyTVIDBTQBvWkP7O4TR3WdUg5dU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c2NarQ4rS8aeK2ZgLeS4DOKV2YuS4VkhTl7KowBoycJ8SEyufs3R+Y57GNR/J/qs0XbwruX8x4IVYiqSniKlSljMoWIXUBoZcFfNLBZ65FKYq0e+JYpKr7x5R65ICMt56m7DTMxck72PJidVKRkQDMGkB4AaBkhSnAGeUp3kvn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bJOkg6D/; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47d4029340aso10420805e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Feb 2026 03:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770290287; x=1770895087; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z01yRtpRz+f8+vWuZfwZd3Dwpe3AoEMaMACYc8SLy3w=;
        b=bJOkg6D/xGb1ioO5QYwxjWChTiPiq0uWg+b/KpTmp2pM0RgaVwRSeR/bN346N5gs54
         EM2L8vBEwL0f/ZrkWMNgxWoLQpahn0yjnbuuPVqJWrVZXqMzq07BA84K5pXHkNz8esvU
         aMjfY7c7XBMQjMUlk5+ikMpoRqdHVlFlWL9kczIfvKuHE1KotzvUG1QPYad5JpZaWkWD
         kh0qbL6MDEHA2wTFsj2cSdQWe4MYtlP2kN/5srirtJaags0xaxz8KB9SMxJ6MmcMgwiS
         Td6/rjJ9qZHl3tsYU/6Qq9WdELwn9pPd7Vs7vnF94b61ubW0Llc8CDLYS0aKfmKedJfQ
         +jFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770290287; x=1770895087;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z01yRtpRz+f8+vWuZfwZd3Dwpe3AoEMaMACYc8SLy3w=;
        b=AzXoZNY4A03tuiNRY76ErRL9tF3HiCMyZ0oigcwjhovMC8M+dcFBhB/mfxIlH9OQxD
         C3mmGKOlfV3UnjpIxXT0zJGo5y1VgyEJycUkLtzbQo3SiBf2pS9ptfeZFWvD4O+m/VyA
         XeR4eWRW7KqSH61feEE/b+5cOGkPoiz13q8vrlowjKkt8W9ZaPsMS228qANEcGb/WmKa
         8YuonRgswdqhgfEXm2cIWbxyOzfA1Z8GiW1uPdY0jfzLuMMekKKmGHN7jtuzzmdVyXxB
         wVt4XMLjQyBvJfHgUiv3XVqtUsM8i6fgRWWPFD/7o5/BBOhUGR9dbBVJIm8UFWd+9Byx
         c8xw==
X-Forwarded-Encrypted: i=1; AJvYcCUhOXGBCodGd/44SMUYwHMsnjxBpCqqODyfiDvDjuZih5oXuwRAzet5uUMy/jqDKGUsUy9slxK1YMgVg+Y+@vger.kernel.org
X-Gm-Message-State: AOJu0YyhKEHUs5Nt9t2q6QomLW80nZmAgTif3jjtH/wfAdqSJTOdT5GE
	mwY4jy0kz2/CALPoodqggX4QmssEKbt3bM7xBNNkSL4zbqmnxiG/sf3O7JzufCnBtnjljvhCtCi
	D2ql+1wWjXViLQjj5oQ==
X-Received: from wmbjt17.prod.google.com ([2002:a05:600c:5691:b0:482:dff5:2424])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c1a:b0:477:a246:8398 with SMTP id 5b1f17b1804b1-4830e93ea4emr80378215e9.2.1770290286698;
 Thu, 05 Feb 2026 03:18:06 -0800 (PST)
Date: Thu, 5 Feb 2026 11:18:03 +0000
In-Reply-To: <2f908340-a983-42c7-bb59-2d6f3a80c834@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260205-binder-tristate-v1-0-dfc947c35d35@google.com>
 <20260205-binder-tristate-v1-3-dfc947c35d35@google.com> <d3dca137-2e4c-4a1a-bdec-63cc2477bfda@kernel.org>
 <aYR5J0ip2MdD3nMP@google.com> <2f908340-a983-42c7-bb59-2d6f3a80c834@kernel.org>
Message-ID: <aYR8a09XUh74tg8l@google.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76396-lists,linux-fsdevel=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,e142025:email]
X-Rspamd-Queue-Id: 515FDF1C6C
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 12:12:23PM +0100, David Hildenbrand (arm) wrote:
> On 2/5/26 12:04, Alice Ryhl wrote:
> > On Thu, Feb 05, 2026 at 11:59:47AM +0100, David Hildenbrand (arm) wrote:
> > > On 2/5/26 11:51, Alice Ryhl wrote:
> > > > diff --git a/mm/list_lru.c b/mm/list_lru.c
> > > > index ec48b5dadf519a5296ac14cda035c067f9e448f8..bf95d73c9815548a19db6345f856cee9baad22e3 100644
> > > > --- a/mm/list_lru.c
> > > > +++ b/mm/list_lru.c
> > > > @@ -179,6 +179,7 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item, int nid,
> > > >    	unlock_list_lru(l, false);
> > > >    	return false;
> > > >    }
> > > > +EXPORT_SYMBOL_GPL(list_lru_add);
> > > >    bool list_lru_add_obj(struct list_lru *lru, struct list_head *item)
> > > >    {
> > > > @@ -216,6 +217,7 @@ bool list_lru_del(struct list_lru *lru, struct list_head *item, int nid,
> > > >    	unlock_list_lru(l, false);
> > > >    	return false;
> > > >    }
> > > > +EXPORT_SYMBOL_GPL(list_lru_del);
> > > >    bool list_lru_del_obj(struct list_lru *lru, struct list_head *item)
> > > >    {
> > > > diff --git a/mm/memory.c b/mm/memory.c
> > > > index da360a6eb8a48e29293430d0c577fb4b6ec58099..64083ace239a2caf58e1645dd5d91a41d61492c4 100644
> > > > --- a/mm/memory.c
> > > > +++ b/mm/memory.c
> > > > @@ -2168,6 +2168,7 @@ void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
> > > >    	zap_page_range_single_batched(&tlb, vma, address, size, details);
> > > >    	tlb_finish_mmu(&tlb);
> > > >    }
> > > > +EXPORT_SYMBOL(zap_page_range_single);
> > > 
> > > Why not EXPORT_SYMBOL_GPL?
> > 
> > I just tried to match other symbols in the same file.
> 
> We were probably a bit too sloppy with some of these in the past. But:
> 
> davhil01@e142025:~/git/linux$ grep -c "EXPORT_SYMBOL(" mm/memory.c
> 12
> davhil01@e142025:~/git/linux$ grep -c "EXPORT_SYMBOL_GPL(" mm/memory.c
> 10
> 
> So just go with EXPORT_SYMBOL_GPL unless there is a good reason why not.

Sounds good, I'll do that in the next version.

Alice

