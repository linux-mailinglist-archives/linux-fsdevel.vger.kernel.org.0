Return-Path: <linux-fsdevel+bounces-676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2D97CE444
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 19:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 915DD281C95
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 17:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6323D982;
	Wed, 18 Oct 2023 17:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HccU353B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E72199CE;
	Wed, 18 Oct 2023 17:17:55 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E21E1FED;
	Wed, 18 Oct 2023 10:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=l1O9IUhCgD84U9jHaGppKeFo9ECoVkPjzmvdZdQQzJk=; b=HccU353BUxHHSbnR7sb5bzqEw8
	rmW7iejYuUAEXoq37BG3mnDEh8jIHgtKtaNF2FNq9UuSFYVKxniHb+I9V3cqxUfzyyzLy4K/OjBgM
	cZ3qtZqqS6E9AStsHsC+CtnXwVdpehk09ySa1ohCrQiLtWdzb9CBWFoegwbOKklOkseIoKnzjP+jT
	1jTuJYzg1uoxkWYRGaQdD2uewLVa/8NfLd30OAd1k/O4WOtUyNfG1rIxNvh3xv8319vmYkF7wAVmk
	hf6eVvv+Ql2h4vX856xsNbavJgRRlB8xBTYJIwgZuOCxw94aAbfA15lnLJ6hM4Jmx+9wptVakQqj4
	tI0cR6RQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qtAAc-0027Zt-8y; Wed, 18 Oct 2023 17:17:22 +0000
Date: Wed, 18 Oct 2023 18:17:22 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 09/19] rust: folio: introduce basic support for folios
Message-ID: <ZTATIhi9U6ObAnN7@casper.infradead.org>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-10-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018122518.128049-10-wedsonaf@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 18, 2023 at 09:25:08AM -0300, Wedson Almeida Filho wrote:
> +void *rust_helper_kmap(struct page *page)
> +{
> +	return kmap(page);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_kmap);
> +
> +void rust_helper_kunmap(struct page *page)
> +{
> +	kunmap(page);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_kunmap);

I'm not thrilled by exposing kmap()/kunmap() to Rust code.  The vast
majority of code really only needs kmap_local_*() / kunmap_local().
Can you elaborate on why you need the old kmap() in new Rust code?

> +void rust_helper_folio_set_error(struct folio *folio)
> +{
> +	folio_set_error(folio);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_folio_set_error);

I'm trying to get rid of the error flag.  Can you share the situations
in which you've needed the error flag?  Or is it just copying existing
practices?

> +    /// Returns the byte position of this folio in its file.
> +    pub fn pos(&self) -> i64 {
> +        // SAFETY: The folio is valid because the shared reference implies a non-zero refcount.
> +        unsafe { bindings::folio_pos(self.0.get()) }
> +    }

I think it's a mistake to make file positions an i64.  I estimate 64
bits will not be enough by 2035-2040.  We should probably have a numeric
type which is i64 on 32-bit and isize on other CPUs (I also project
64-bit pointers will be insufficient by 2035-2040 and so we will have
128-bit pointers around the same time, so we're not going to need i128
file offsets with i64 pointers).

> +/// A [`Folio`] that has a single reference to it.
> +pub struct UniqueFolio(pub(crate) ARef<Folio>);

How do we know it only has a single reference?  Do you mean "has at
least one reference"?  Or am I confusing Rust's notion of a reference
with Linux's notion of a reference?

> +impl UniqueFolio {
> +    /// Maps the contents of a folio page into a slice.
> +    pub fn map_page(&self, page_index: usize) -> Result<MapGuard<'_>> {
> +        if page_index >= self.0.size() / bindings::PAGE_SIZE {
> +            return Err(EDOM);
> +        }
> +
> +        // SAFETY: We just checked that the index is within bounds of the folio.
> +        let page = unsafe { bindings::folio_page(self.0 .0.get(), page_index) };
> +
> +        // SAFETY: `page` is valid because it was returned by `folio_page` above.
> +        let ptr = unsafe { bindings::kmap(page) };

Surely this can be:

	   let ptr = unsafe { bindings::kmap_local_folio(folio, page_index * PAGE_SIZE) };

> +        // SAFETY: We just mapped `ptr`, so it's valid for read.
> +        let data = unsafe { core::slice::from_raw_parts(ptr.cast::<u8>(), bindings::PAGE_SIZE) };

Can we hide away the "if this isn't a HIGHMEM system, this maps to the
end of the folio, but if it is, it only maps to the end of the page"
problem here?


