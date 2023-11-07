Return-Path: <linux-fsdevel+bounces-2326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB337E4B96
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 23:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAC2AB210BD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 22:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EB62A8C4;
	Tue,  7 Nov 2023 22:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hntptVlG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0291C2F859;
	Tue,  7 Nov 2023 22:18:13 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E5599;
	Tue,  7 Nov 2023 14:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DTT5lzbKGZqy0lWVmsfN05x9UU5Qeehz1tYRPwYDIGo=; b=hntptVlG3/jEmDW7kzZmTNMvzW
	z7P8vzjPmCqbYJSY1MJVupXyVM4ey2OWa6b06yys+B3he60kg6pfFRaLgTxEhMh0RaPA84LYyBg5A
	pOtvTryiYWYBk8YFjAr9kM2itvYwsaJXffoAq06O3cdBiajQRBHBq81pB4bj+Q+F5/POEGcFc/cCH
	sz73sKNRthRLyTbOChotcqmoe7Ispr7XzU4EVEYKaHRn2QCIaKA+pErg8qblvxRIZ6c3Ud8ZYAsKJ
	APxHwKbIpi+jVXsY/U/MzIeN1jKivgptYE6CxkUh/rVE15lYNNJEM+TH5dUEW5R3r+9aMBfkQWPaw
	B6ZG7dcw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r0UOb-00Erdc-QE; Tue, 07 Nov 2023 22:18:05 +0000
Date: Tue, 7 Nov 2023 22:18:05 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 10/19] rust: fs: introduce `FileSystem::read_folio`
Message-ID: <ZUq3nZgedcA5CF0V@casper.infradead.org>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-11-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018122518.128049-11-wedsonaf@gmail.com>

On Wed, Oct 18, 2023 at 09:25:09AM -0300, Wedson Almeida Filho wrote:
> @@ -36,6 +39,9 @@ pub trait FileSystem {
>  
>      /// Returns the inode corresponding to the directory entry with the given name.
>      fn lookup(parent: &INode<Self>, name: &[u8]) -> Result<ARef<INode<Self>>>;
> +
> +    /// Reads the contents of the inode into the given folio.
> +    fn read_folio(inode: &INode<Self>, folio: LockedFolio<'_>) -> Result;
>  }
>  

This really shouldn't be a per-filesystem operation.  We have operations
split up into mapping_ops, inode_ops and file_ops for a reason.  In this
case, read_folio() can have a very different implementation for, eg,
symlinks, directories and files.  So we want to have different aops
for each of symlinks, directories and files.  We should maintain that
separation for filesystems written in Rust too.  Unless there's a good
reason to change it, and then we should change it in C too.

