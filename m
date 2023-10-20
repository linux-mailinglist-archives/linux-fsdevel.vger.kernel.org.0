Return-Path: <linux-fsdevel+bounces-806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0887D074C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 06:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2330B1C20F42
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 04:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B6F539A;
	Fri, 20 Oct 2023 04:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MvH/RZcM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5124320FB;
	Fri, 20 Oct 2023 04:11:50 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A54FA;
	Thu, 19 Oct 2023 21:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0TRfYcY4FztgXN27eg6Q00CIuzPsmunhjJWurKwX5G8=; b=MvH/RZcMmLdb7Q69xTuPczSnac
	3BU2DYEurlpQCzCZygRCaTxsHBcsrRQAPdtGu5BpkttRXz4h9wsG53XZWYhplEC1jIIy370YfWCSW
	GhXnIfCIdZGmHupz8Q7r+lbP5+Dv3rgCAvcl4TVoKZPu3ki1EKWoJTW4sAmtVmGCOJQ1x+d0Db7FS
	2wWIM3AXejW6NLBmBtcNbWi0BGIvyPuh+TUvSJpOIHYZTGNcetJjgUED79ZDnvU7fRkrSA1yY5fes
	ajxydxygvgT8fFZzsnhccKkgveDrSd1IfFr2XONqxWAUg4FIKkTUt04ketkiL5XmKRCeWRKd5R1LH
	Pcjl7Bew==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qtgrK-00B1CM-Pv; Fri, 20 Oct 2023 04:11:38 +0000
Date: Fri, 20 Oct 2023 05:11:38 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 09/19] rust: folio: introduce basic support for folios
Message-ID: <ZTH9+sF+NPyRjyRN@casper.infradead.org>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-10-wedsonaf@gmail.com>
 <ZTATIhi9U6ObAnN7@casper.infradead.org>
 <CANeycqoWfWJ5bxuh+UWK99D9jYH0cKKy1=ikHJTpY=fP1ZJMrg@mail.gmail.com>
 <ZTAwLGi4sCup+B1r@casper.infradead.org>
 <CANeycqrp_s20pCO_OJXHpqN5tZ_Uq5icTupWiVeLf69JOFj4cA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANeycqrp_s20pCO_OJXHpqN5tZ_Uq5icTupWiVeLf69JOFj4cA@mail.gmail.com>

On Thu, Oct 19, 2023 at 10:25:39AM -0300, Wedson Almeida Filho wrote:
> On Wed, 18 Oct 2023 at 16:21, Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Wed, Oct 18, 2023 at 03:32:36PM -0300, Wedson Almeida Filho wrote:
> > > On Wed, 18 Oct 2023 at 14:17, Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Wed, Oct 18, 2023 at 09:25:08AM -0300, Wedson Almeida Filho wrote:
> > > > > +void *rust_helper_kmap(struct page *page)
> > > > > +{
> > > > > +     return kmap(page);
> > > > > +}
> > > > > +EXPORT_SYMBOL_GPL(rust_helper_kmap);
> > > > > +
> > > > > +void rust_helper_kunmap(struct page *page)
> > > > > +{
> > > > > +     kunmap(page);
> > > > > +}
> > > > > +EXPORT_SYMBOL_GPL(rust_helper_kunmap);
> > > >
> > > > I'm not thrilled by exposing kmap()/kunmap() to Rust code.  The vast
> > > > majority of code really only needs kmap_local_*() / kunmap_local().
> > > > Can you elaborate on why you need the old kmap() in new Rust code?
> > >
> > > The difficulty we have with kmap_local_*() has to do with the
> > > requirement that maps and unmaps need to be nested neatly. For
> > > example:
> > >
> > > let a = folio1.map_local(...);
> > > let b = folio2.map_local(...);
> > > // Do something with `a` and `b`.
> > > drop(a);
> > > drop(b);
> > >
> > > The code obviously violates the requirements.
> >
> > Is that the only problem, or are there situations where we might try
> > to do something like:
> >
> > a = folio1.map.local()
> > b = folio2.map.local()
> > drop(a)
> > a = folio3.map.local()
> > drop(b)
> > b = folio4.map.local()
> > drop (a)
> > a = folio5.map.local()
> > ...
> 
> This is also a problem. We don't control the order in which users are
> going to unmap.

OK.  I have something in the works, but it's not quite ready yet.

> If you don't want to scan the whole array, we could have a solution
> where we add an indirection between the available indices and the
> stack of allocations; this way C could continue to work as is and Rust
> would have a slightly different API that returns both the mapped
> address and an index (which would be used to unmap).
> 
> It's simple to remember the index in Rust and it wouldn't have to be
> exposed to end users, they'd still just do:
> 
> let a = folio1.map_local(...);
> 
> And when `a` is dropped, it would call unmap and pass the index back.
> (It's also safe in the sense that users would not be able to
> accidentally pass the wrong index.)
> 
> But if scanning the whole array is acceptable performance-wise, it's
> definitely a simpler solution.

Interesting idea.  There are some other possibilities too ... let's see.

> > > > > +/// A [`Folio`] that has a single reference to it.
> > > > > +pub struct UniqueFolio(pub(crate) ARef<Folio>);
> > > >
> > > > How do we know it only has a single reference?  Do you mean "has at
> > > > least one reference"?  Or am I confusing Rust's notion of a reference
> > > > with Linux's notion of a reference?
> > >
> > > Instances of `UniqueFolio` are only produced by calls to
> > > `folio_alloc`. They encode the fact that it's safe for us to map the
> > > folio and know that there aren't any concurrent threads/CPUs doing the
> > > same to the same folio.
> >
> > Mmm ... it's always safe to map a folio, even if other people have a
> > reference to it.  And Linux can make temporary spurious references to
> > folios appear, although those should be noticed by the other party and
> > released again before they access the contents of the folio.  So from
> > the point of view of being memory-safe, you can ignore them, but you
> > might see the refcount of the folio as >1, even if you just got the
> > folio back from the allocator.
> 
> Sure, it's safe to map a folio in general, but Rust has stricter rules
> about aliasing and mutability that are part of how memory safety is
> achieved. In particular, it requires that we never have mutable and
> immutable pointers to the same memory at once (modulo interior
> mutability).
> 
> So we need to avoid something like:
> 
> let a = folio.map(); // `a` is a shared pointer to the contents of the folio.
> 
> // While we have a shared (and therefore immutable) pointer, we're
> changing the contents of the folio.
> sb.sread(sector_number, sector_count, folio);
> 
> This violates Rust rules. `UniqueFolio` helps us address this for our
> use case; if we try the above with a UniqueFolio, the compiler will
> error out saying that  `a` has a shared reference to the folio, so we
> can't call `sread` on it (because sread requires a mutable, and
> therefore not shareable, reference to the folio).

This is going to be quite the impedance mismatch.  Still, I imagine
you're used to dealing with those by now and have a toolbox of ideas.

We don't have that rule for the pagecache as it is.  We do have rules that
prevent data corruption!  For example, if the folio is !uptodate then you
must have the lock to write to the folio in order to bring it uptodate
(so we have a single writer rule in that regard).  But once the folio is
uptodate, all bets are off in terms of who can be writing to it / reading
it at the same time.  And that's going to have to continue to be true;
multiple processes can have the same page mmaped writable and write to
it at the same time.  There's no possible synchronisation between them.

But I think your concern is really more limited.  You're concerned
with filesystem metadata obeying Rust's rules.  And for a read-write
filesystem, you're going to have to have ... something ... which gets a
folio from the page cache, and establishes that this is the only thread
which can modify that folio (maybe it's an interior node of a Btree,
maybe it's a free space bitmap, ...).  We could probably use the folio
lock bit for that purpose,  For the read-only filesystems, you only need
be concerned about freshly-allocated folios, but you need something more
when it comes to doing an ext2 clone.

There's general concern about the overuse of the folio lock bit, but
this is a reasonable use -- preventing two threads from modifying the
same folio at the same time.

(I have simplified all this; both iomap and buffer heads support folios
which are partially uptodate, but conceptually this is accurate)

> > On systems without HIGHMEM, kmap() is a no-op.  So we could do something
> > like this:
> >
> >         let data = unsafe { core::slice::from_raw_parts(ptr.cast::<u8>(),
> >                 if (folio_test_highmem(folio))
> >                         bindings::PAGE_SIZE
> >                 else
> >                         folio_size(folio) - page_idx * PAGE_SIZE) }
> >
> > ... modulo whatever the correct syntax is in Rust.
> 
> We can certainly do that. But since there's the possibility that the
> array will be capped at PAGE_SIZE in the HIGHMEM case, callers would
> still need a loop to traverse the whole folio, right?
> 
> let mut offset = 0;
> while offset < folio.size() {
>     let a = folio.map(offset);
>     // Do something with a.
>     offset += a.len();
> }
> 
> I guess the advantage is that we'd have a single iteration in systems
> without HIGHMEM.

Right.  You can see something similar to that in memcpy_from_folio() in
highmem.h.

> > Something I forgot to mention was that I found it more useful to express
> > "map this chunk of a folio" in bytes rather than pages.  You might find
> > the same, in which case it's just folio.map(offset: usize) instead of
> > folio.map_page(page_index: usize)
> 
> Oh, thanks for the feedback. I'll switch to bytes then for v2.
> (Already did in the example above.)

Great!  Something else I think would be a good idea is open-coding some
of the trivial accessors.  eg instead of doing:

+size_t rust_helper_folio_size(struct folio *folio)
+{
+	return folio_size(folio);
+}
+EXPORT_SYMBOL_GPL(rust_helper_folio_size);
[...]
+    pub fn size(&self) -> usize {
+        // SAFETY: The folio is valid because the shared reference implies a non-zero refcount.
+        unsafe { bindings::folio_size(self.0.get()) }
+    }

add:

impl Folio {
...
    pub fn order(&self) -> u8 {
	if (self.flags & (1 << PG_head))
	    self._flags_1 & 0xff
	else
	    0
    }

    pub fn size(&self) -> usize {
	bindings::PAGE_SIZE << self.order()
    }
}

... or have I misunderstood what is possible here?  My hope is that the
compiler gets to "see through" the abstraction, which surely can't be
done when there's a function call.

