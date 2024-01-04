Return-Path: <linux-fsdevel+bounces-7342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A15823BC0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 06:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5140B2874D1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 05:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD2B18E03;
	Thu,  4 Jan 2024 05:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQKrYHiJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4E215EA6;
	Thu,  4 Jan 2024 05:20:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A793AC433C7;
	Thu,  4 Jan 2024 05:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704345634;
	bh=L7hXBlUDy2kWNN5PKJkyLxeb6dVe99aHeYeX+8fr2TY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hQKrYHiJ/kkm0tu7JUzKAqjnnUeIiU77jEQk1mskptJm2/wRu92z8/UCg+TV3aBaJ
	 ioKOaz7N7FQgghM1bYoeMvVwNnPnOnVcmc6OGK8UVZb8Hhl0IdrL/i6Jqf+V3MvE2A
	 Z3jX1ZA9CN6KDedtJ4VtN2GAijjQXMzD8Y5mqWowrIbga/q9it/oNiDv7Oug+dwEt9
	 /GCOJqEXIyMVeGQEe8nnxJ3InwU6DTQfcY7wiK30ZrOFErC8bNMTmWnsLaE/z+GF9p
	 BdsQVrxOaeUSM1wReoB8SqFJy+DPI1uqE4dUhEaRYBf2bktzf8Sx+VtKQbe5oBTN7E
	 axHRytg3UaUgw==
Date: Wed, 3 Jan 2024 21:20:34 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 05/19] rust: fs: introduce `INode<T>`
Message-ID: <20240104052034.GD3964019@frogsfrogsfrogs>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-6-wedsonaf@gmail.com>
 <87sf3e5v55.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sf3e5v55.fsf@metaspace.dk>

On Wed, Jan 03, 2024 at 01:54:34PM +0100, Andreas Hindborg (Samsung) wrote:
> 
> Wedson Almeida Filho <wedsonaf@gmail.com> writes:
> 
> > +/// The number of an inode.
> > +pub type Ino = u64;
> 
> Would it be possible to use a descriptive name such as `INodeNumber`?

Filesystem programmers are lazy.  Originally the term was "index node
number", which was shortened to "inode number", shortened again to
"inumber", and finally "ino".  The Rust type name might as well mirror
the C type.

(There are probably greyerbeards than I who can quote even more arcane
points of Unix filesystem history.)

> > +    /// Returns the super-block that owns the inode.
> > +    pub fn super_block(&self) -> &SuperBlock<T> {
> > +        // SAFETY: `i_sb` is immutable, and `self` is guaranteed to be valid by the existence of a
> > +        // shared reference (&self) to it.
> > +        unsafe { &*(*self.0.get()).i_sb.cast() }
> > +    }
> 
> I think the safety comment should talk about the pointee rather than the
> pointer? "The pointee of `i_sb` is immutable, and ..."

inode::i_sb (the pointer) shouldn't be reassigned to a different
superblock during the lifetime of the inode; but the superblock object
itself (the pointee) is very much mutable.

--D

> BR Andreas
> 
> 

