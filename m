Return-Path: <linux-fsdevel+bounces-701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 021467CE79F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 21:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F0A7281D8E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 19:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4349450DD;
	Wed, 18 Oct 2023 19:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u7utzuMp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BEC41A98;
	Wed, 18 Oct 2023 19:21:25 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FB3114;
	Wed, 18 Oct 2023 12:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=61brXupZefx7B2zCFquy0Xv7F9d+8zTo2ZLjjI2qfdE=; b=u7utzuMpZn42rJdGWh4pE5JYf1
	Bmo0FqIMpgvgwEHjU9qQW8ZS+cdLTtwfDjSPNdWmjaSw5saa5S0giF9f0NbzKBEFPPdCMap98Wa/J
	hM6izawdxhri3exlQMOSd166I8k6vSB2UhKhxuiIq39TW7DFcMzJ0ZSHa4G8a608E/9uqPec4/Pb2
	RsPDE0xgOdGfXnNkvDn/WL66o6Lfz/avGBoPlqwfNoHi9l9V/SqiqU0wE0gtOOJ5XItq6cGle8yHX
	DGUomMSBnc40hjDoxoYLNNbxYBBwmqWMrSycm/xK7MoV/yavDcFP0baeVQcwWV27SfbNsE8J4cvqR
	V5BaocRg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qtC6W-002fdh-Kh; Wed, 18 Oct 2023 19:21:16 +0000
Date: Wed, 18 Oct 2023 20:21:16 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 09/19] rust: folio: introduce basic support for folios
Message-ID: <ZTAwLGi4sCup+B1r@casper.infradead.org>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-10-wedsonaf@gmail.com>
 <ZTATIhi9U6ObAnN7@casper.infradead.org>
 <CANeycqoWfWJ5bxuh+UWK99D9jYH0cKKy1=ikHJTpY=fP1ZJMrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANeycqoWfWJ5bxuh+UWK99D9jYH0cKKy1=ikHJTpY=fP1ZJMrg@mail.gmail.com>

On Wed, Oct 18, 2023 at 03:32:36PM -0300, Wedson Almeida Filho wrote:
> On Wed, 18 Oct 2023 at 14:17, Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Wed, Oct 18, 2023 at 09:25:08AM -0300, Wedson Almeida Filho wrote:
> > > +void *rust_helper_kmap(struct page *page)
> > > +{
> > > +     return kmap(page);
> > > +}
> > > +EXPORT_SYMBOL_GPL(rust_helper_kmap);
> > > +
> > > +void rust_helper_kunmap(struct page *page)
> > > +{
> > > +     kunmap(page);
> > > +}
> > > +EXPORT_SYMBOL_GPL(rust_helper_kunmap);
> >
> > I'm not thrilled by exposing kmap()/kunmap() to Rust code.  The vast
> > majority of code really only needs kmap_local_*() / kunmap_local().
> > Can you elaborate on why you need the old kmap() in new Rust code?
> 
> The difficulty we have with kmap_local_*() has to do with the
> requirement that maps and unmaps need to be nested neatly. For
> example:
> 
> let a = folio1.map_local(...);
> let b = folio2.map_local(...);
> // Do something with `a` and `b`.
> drop(a);
> drop(b);
> 
> The code obviously violates the requirements.

Is that the only problem, or are there situations where we might try
to do something like:

a = folio1.map.local()
b = folio2.map.local()
drop(a)
a = folio3.map.local()
drop(b)
b = folio4.map.local()
drop (a)
a = folio5.map.local()
...

> One way to enforce the rule is Rust is to use closures, so the code
> above would be:
> 
> folio1.map_local(..., |a| {
>     folio2.map_local(..., |b| {
>         // Do something with `a` and `b`.
>     })
> })
> 
> It isn't ergonomic the first option, but allows us to satisfy the
> nesting requirement.
> 
> Any chance we can relax that requirement?

It's possible.  Here's an untested patch that _only_ supports
"map a, map b, unmap a, unmap b".  If we need more, well, I guess
we can scan the entire array, both at map & unmap in order to
unmap pages.

diff --git a/mm/highmem.c b/mm/highmem.c
index e19269093a93..778a22ca1796 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -586,7 +586,7 @@ void kunmap_local_indexed(const void *vaddr)
 {
 	unsigned long addr = (unsigned long) vaddr & PAGE_MASK;
 	pte_t *kmap_pte;
-	int idx;
+	int idx, local_idx;
 
 	if (addr < __fix_to_virt(FIX_KMAP_END) ||
 	    addr > __fix_to_virt(FIX_KMAP_BEGIN)) {
@@ -607,15 +607,25 @@ void kunmap_local_indexed(const void *vaddr)
 	}
 
 	preempt_disable();
-	idx = arch_kmap_local_unmap_idx(kmap_local_idx(), addr);
+	local_idx = kmap_local_idx();
+	idx = arch_kmap_local_unmap_idx(local_idx, addr);
+	if (addr != __fix_to_virt(FIX_KMAP_BEGIN + idx) && local_idx > 0) {
+		idx--;
+		local_idx--;
+	}
 	WARN_ON_ONCE(addr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
 
 	kmap_pte = kmap_get_pte(addr, idx);
 	arch_kmap_local_pre_unmap(addr);
 	pte_clear(&init_mm, addr, kmap_pte);
 	arch_kmap_local_post_unmap(addr);
-	current->kmap_ctrl.pteval[kmap_local_idx()] = __pte(0);
-	kmap_local_idx_pop();
+	current->kmap_ctrl.pteval[local_idx] = __pte(0);
+	if (local_idx == kmap_local_idx()) {
+		kmap_local_idx_pop();
+		if (local_idx > 0 &&
+		    pte_none(current->kmap_ctrl.pteval[local_idx - 1]))
+			kmap_local_idx_pop();
+	}
 	preempt_enable();
 	migrate_enable();
 }
@@ -648,7 +658,7 @@ void __kmap_local_sched_out(void)
 			WARN_ON_ONCE(pte_val(pteval) != 0);
 			continue;
 		}
-		if (WARN_ON_ONCE(pte_none(pteval)))
+		if (pte_none(pteval))
 			continue;
 
 		/*
@@ -685,7 +695,7 @@ void __kmap_local_sched_in(void)
 			WARN_ON_ONCE(pte_val(pteval) != 0);
 			continue;
 		}
-		if (WARN_ON_ONCE(pte_none(pteval)))
+		if (pte_none(pteval))
 			continue;
 
 		/* See comment in __kmap_local_sched_out() */

> > > +void rust_helper_folio_set_error(struct folio *folio)
> > > +{
> > > +     folio_set_error(folio);
> > > +}
> > > +EXPORT_SYMBOL_GPL(rust_helper_folio_set_error);
> >
> > I'm trying to get rid of the error flag.  Can you share the situations
> > in which you've needed the error flag?  Or is it just copying existing
> > practices?
> 
> I'm just mimicking C code. Happy to remove it.

Great, thanks!

> > > +    /// Returns the byte position of this folio in its file.
> > > +    pub fn pos(&self) -> i64 {
> > > +        // SAFETY: The folio is valid because the shared reference implies a non-zero refcount.
> > > +        unsafe { bindings::folio_pos(self.0.get()) }
> > > +    }
> >
> > I think it's a mistake to make file positions an i64.  I estimate 64
> > bits will not be enough by 2035-2040.  We should probably have a numeric
> > type which is i64 on 32-bit and isize on other CPUs (I also project
> > 64-bit pointers will be insufficient by 2035-2040 and so we will have
> > 128-bit pointers around the same time, so we're not going to need i128
> > file offsets with i64 pointers).
> 
> I'm also just mimicking C here -- we just don't have a type that has
> the properties you describe. I'm happy to switch once we have it, in
> fact, Miguel has plans that I believe align well with what you want.
> I'm not sure if he has already contacted you about it yet though.

No, I haven't heard about plans for an off_t equivalent.  Perhaps you
could just do what the crates.io libc does?

https://docs.rs/libc/0.2.149/libc/type.off_t.html
pub type off_t = i64;

and then there's only one place to change to be i128 when the time comes.

> > > +/// A [`Folio`] that has a single reference to it.
> > > +pub struct UniqueFolio(pub(crate) ARef<Folio>);
> >
> > How do we know it only has a single reference?  Do you mean "has at
> > least one reference"?  Or am I confusing Rust's notion of a reference
> > with Linux's notion of a reference?
> 
> Instances of `UniqueFolio` are only produced by calls to
> `folio_alloc`. They encode the fact that it's safe for us to map the
> folio and know that there aren't any concurrent threads/CPUs doing the
> same to the same folio.

Mmm ... it's always safe to map a folio, even if other people have a
reference to it.  And Linux can make temporary spurious references to
folios appear, although those should be noticed by the other party and
released again before they access the contents of the folio.  So from
the point of view of being memory-safe, you can ignore them, but you
might see the refcount of the folio as >1, even if you just got the
folio back from the allocator.

> > > +impl UniqueFolio {
> > > +    /// Maps the contents of a folio page into a slice.
> > > +    pub fn map_page(&self, page_index: usize) -> Result<MapGuard<'_>> {
> > > +        if page_index >= self.0.size() / bindings::PAGE_SIZE {
> > > +            return Err(EDOM);
> > > +        }
> > > +
> > > +        // SAFETY: We just checked that the index is within bounds of the folio.
> > > +        let page = unsafe { bindings::folio_page(self.0 .0.get(), page_index) };
> > > +
> > > +        // SAFETY: `page` is valid because it was returned by `folio_page` above.
> > > +        let ptr = unsafe { bindings::kmap(page) };
> >
> > Surely this can be:
> >
> >            let ptr = unsafe { bindings::kmap_local_folio(folio, page_index * PAGE_SIZE) };
> 
> The problem is the unmap path that can happen at arbitrary order in
> Rust, see my comment above.
> 
> >
> > > +        // SAFETY: We just mapped `ptr`, so it's valid for read.
> > > +        let data = unsafe { core::slice::from_raw_parts(ptr.cast::<u8>(), bindings::PAGE_SIZE) };
> >
> > Can we hide away the "if this isn't a HIGHMEM system, this maps to the
> > end of the folio, but if it is, it only maps to the end of the page"
> > problem here?
> 
> Do you have ideas on how this might look like? (Don't worry about
> Rust, just express it in some pseudo-C and we'll see if you can
> express it in Rust.)

On systems without HIGHMEM, kmap() is a no-op.  So we could do something
like this:

	let data = unsafe { core::slice::from_raw_parts(ptr.cast::<u8>(),
		if (folio_test_highmem(folio))
			bindings::PAGE_SIZE
		else
			folio_size(folio) - page_idx * PAGE_SIZE) }

... modulo whatever the correct syntax is in Rust.

Something I forgot to mention was that I found it more useful to express
"map this chunk of a folio" in bytes rather than pages.  You might find
the same, in which case it's just folio.map(offset: usize) instead of
folio.map_page(page_index: usize)


