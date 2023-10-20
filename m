Return-Path: <linux-fsdevel+bounces-841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A537D1272
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 17:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F4682825D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 15:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7FC1DA5D;
	Fri, 20 Oct 2023 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hjxGYQzb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF121C2B0;
	Fri, 20 Oct 2023 15:17:50 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB56AD52;
	Fri, 20 Oct 2023 08:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qaWDknVeqQdf6FKBYtlbZGqJStqsiLloU1mTfUyJ3c4=; b=hjxGYQzbvNZn2qDQQilcUXrVLz
	P4bFRtxZ8enO2uWJs9FRy2t58m8Mx9A3ETtnIcQCNYuIHHRh8RehwUDtoXzMritulfYnGv6W/In0c
	BGWiEM+UBlvDA4Yp69QSGbr0mA7FOvQQjsZcbwz4fY1MfOnL5nReOrhulOUtomh2e0JVbI9rSYM0m
	EG6WMGvDrGQVJwnctTojVXAatT+2ikndBCrFMNtSQdTcCAVJeOqz1IKTNZchcdM7zgwZKvnYq+K5O
	ZO5XDK1WdTwpeOWc8jp4TLn2kND3oghuAMGizfI/Uhtw+lZykVE3hnPkOpRpZlhP1sU6pLuGpn1Vn
	NCwAnDbw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qtrFw-00DoPa-Gx; Fri, 20 Oct 2023 15:17:44 +0000
Date: Fri, 20 Oct 2023 16:17:44 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 09/19] rust: folio: introduce basic support for folios
Message-ID: <ZTKaGFN/tp3QjGaD@casper.infradead.org>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-10-wedsonaf@gmail.com>
 <ZTATIhi9U6ObAnN7@casper.infradead.org>
 <CANeycqoWfWJ5bxuh+UWK99D9jYH0cKKy1=ikHJTpY=fP1ZJMrg@mail.gmail.com>
 <ZTAwLGi4sCup+B1r@casper.infradead.org>
 <CANeycqrp_s20pCO_OJXHpqN5tZ_Uq5icTupWiVeLf69JOFj4cA@mail.gmail.com>
 <ZTH9+sF+NPyRjyRN@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTH9+sF+NPyRjyRN@casper.infradead.org>

On Fri, Oct 20, 2023 at 05:11:38AM +0100, Matthew Wilcox wrote:
> > Sure, it's safe to map a folio in general, but Rust has stricter rules
> > about aliasing and mutability that are part of how memory safety is
> > achieved. In particular, it requires that we never have mutable and
> > immutable pointers to the same memory at once (modulo interior
> > mutability).
> > 
> > So we need to avoid something like:
> > 
> > let a = folio.map(); // `a` is a shared pointer to the contents of the folio.
> > 
> > // While we have a shared (and therefore immutable) pointer, we're
> > changing the contents of the folio.
> > sb.sread(sector_number, sector_count, folio);
> > 
> > This violates Rust rules. `UniqueFolio` helps us address this for our
> > use case; if we try the above with a UniqueFolio, the compiler will
> > error out saying that  `a` has a shared reference to the folio, so we
> > can't call `sread` on it (because sread requires a mutable, and
> > therefore not shareable, reference to the folio).
> 
> This is going to be quite the impedance mismatch.  Still, I imagine
> you're used to dealing with those by now and have a toolbox of ideas.
> 
> We don't have that rule for the pagecache as it is.  We do have rules that
> prevent data corruption!  For example, if the folio is !uptodate then you
> must have the lock to write to the folio in order to bring it uptodate
> (so we have a single writer rule in that regard).  But once the folio is
> uptodate, all bets are off in terms of who can be writing to it / reading
> it at the same time.  And that's going to have to continue to be true;
> multiple processes can have the same page mmaped writable and write to
> it at the same time.  There's no possible synchronisation between them.
> 
> But I think your concern is really more limited.  You're concerned
> with filesystem metadata obeying Rust's rules.  And for a read-write
> filesystem, you're going to have to have ... something ... which gets a
> folio from the page cache, and establishes that this is the only thread
> which can modify that folio (maybe it's an interior node of a Btree,
> maybe it's a free space bitmap, ...).  We could probably use the folio
> lock bit for that purpose,  For the read-only filesystems, you only need
> be concerned about freshly-allocated folios, but you need something more
> when it comes to doing an ext2 clone.
> 
> There's general concern about the overuse of the folio lock bit, but
> this is a reasonable use -- preventing two threads from modifying the
> same folio at the same time.

Sorry, I didn't quite finish this thought; that'll teach me to write
complicated emails last thing at night.

The page cache has no single-writer vs multiple-reader exclusion on folios
found in the page cache.  We expect filesystems to implement whatever
exclusion they need at a higher level.  For example, ext2 has no higher
level lock on its block allocator.  Once the buffer is uptodate (ie has
been read from storage), it uses atomic bit operations in order to track
which blocks are freed.  It does use a spinlock to control access to
"how many blocks are currently free".

I'm not suggesting ext2 is an optimal strategy.  I know XFS and btrfs
use rwsems, although I'm not familiar enough with either to describe
exactly how it works.

