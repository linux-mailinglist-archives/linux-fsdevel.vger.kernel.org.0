Return-Path: <linux-fsdevel+bounces-931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F417D394B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 16:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 394DA1C20A0C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 14:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F701B29F;
	Mon, 23 Oct 2023 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RQgR5MdW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3E6134DF;
	Mon, 23 Oct 2023 14:28:46 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561A9DD;
	Mon, 23 Oct 2023 07:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eJ9wptQOy3DXDZN8YbGeVcfaYB+0Ek+ymB3Thh5UoEU=; b=RQgR5MdWu7alC+E8XMn/GCeCtl
	oqT+IVASajqYJp/YWUEoMbj3gr9x2OELGrz07E8RGC3vHSOY5+MXU5RBG1ztPRHRliZKrjmk+769O
	rgNvcDcPHamAdKTLnCd93aV3h2eSUS4w+EVcfuw2xDs8vBWCDWtOhZ+Df0wve4/7IrJungvP/DqSl
	jAHZeyordi6IYUIZknSeYFb+tyOIvPdUF5L5BLBTiQrH5KHQqCvpuNxJFFQ/NPPjapQ6/lbXj+Zob
	qc8rtsTSsAO95oYo7vn0aC9Vk+Pq65ADTb3XD+nzGqIHOB52r15OR2t9c2xU+lMYgV+yejNFXH5Ap
	I3E7JVFg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1quvv3-00EH5J-PT; Mon, 23 Oct 2023 14:28:37 +0000
Date: Mon, 23 Oct 2023 15:28:37 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 09/19] rust: folio: introduce basic support for folios
Message-ID: <ZTaDFe/s2wvyI9u2@casper.infradead.org>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-10-wedsonaf@gmail.com>
 <ZTATIhi9U6ObAnN7@casper.infradead.org>
 <CANeycqoWfWJ5bxuh+UWK99D9jYH0cKKy1=ikHJTpY=fP1ZJMrg@mail.gmail.com>
 <ZTAwLGi4sCup+B1r@casper.infradead.org>
 <CANeycqrp_s20pCO_OJXHpqN5tZ_Uq5icTupWiVeLf69JOFj4cA@mail.gmail.com>
 <ZTH9+sF+NPyRjyRN@casper.infradead.org>
 <87h6mhfwbm.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6mhfwbm.fsf@metaspace.dk>

On Mon, Oct 23, 2023 at 12:48:33PM +0200, Andreas Hindborg (Samsung) wrote:
> The build system and Rust compiler can inline and optimize across
> function calls and languages when LTO is enabled. Some patches are
> needed to make it work though.

That's fine, but something like folio_put() is performance-critical.

Relying on the linker to figure out that it _should_ inline through

+void rust_helper_folio_put(struct folio *folio)
+{
+	folio_put(folio);
+}
+EXPORT_SYMBOL_GPL(rust_helper_folio_put);

seems like a very bad idea to me.  For reference, folio_put() is
defined as:

static inline void folio_put(struct folio *folio)
{
        if (folio_put_testzero(folio))
                __folio_put(folio);
}

which turns into (once you work your way through all the gunk that hasn't
been cleaned up yet)

	if (atomic_dec_and_test(&folio->_refcount))
		__folio_put(folio)

ie it's a single dec-and-test insn followed by a conditional function
call.  Yes, there's some expensive debug you can turn on in there, but
it's an incredibly frequent call, and we shouldn't be relying on linker
magic to optimise it all away.

Of course, I don't want to lose the ability to turn on the debug code,
so folio.put() can't be as simple as the call to atomic_dec_and_test(),
but I hope you see my point.

Wedson wrote in a later email,
> Having said that, while it's possible to do what you suggested above,
> we try to avoid it so that maintainers can continue to have a single
> place they need to change if they ever decide to change things. A
> simple example from above is order(), if you decide to implement it
> differently (I don't know, if you change the flag, you decide to have
> an explicit field, whatever), then you'd have to change the C _and_
> the Rust versions. Worse yet, there's a chance that forgetting to
> update the Rust version wouldn't break the build, which would make it
> harder to catch mismatched versions.

I understand that concern!  Indeed, I did change the implementation
of folio_order() recently.  I'm happy to commit to keeping the Rust
implementation updated as I modify the C implementation of folios,
but I appreciate that other maintainers may not be willing to make such
a commitment.

I'm all the way up to Chapter 5: References in the Blandy book now!
I expect to understand the patches you're sending any week now ;-)

