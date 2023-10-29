Return-Path: <linux-fsdevel+bounces-1507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DC87DAE37
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Oct 2023 21:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E11C9B20E3B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Oct 2023 20:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F366612E51;
	Sun, 29 Oct 2023 20:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B1fPnGb1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71FF3FED;
	Sun, 29 Oct 2023 20:32:05 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00B4BD;
	Sun, 29 Oct 2023 13:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jZsNeLgG9aNq/nQBR2OAHUt2uM+tRZYRfWQG3TV8SQ0=; b=B1fPnGb1zrseB1YnkCL8DkGj5O
	reDt0YDpJN7u1Xw3WUzZdCdloPfRV0oO3LrVH9ZarZqHnVt6LuFpVt8NwQBai8hi6Hu8MJUmTOSn0
	jYWX6BzZBBZnvxh7HrAO/mLhcxvzPdtX7vYBXOZYAGxlcQdkKOA4f3VU8z9P2m4mzMJroU63ehsCZ
	QHYHDSvNiI4tCwQs0wc9pv4MEVSMzaoMxBGcHIQsEpvKeTmT4Z/NPW4vb7uWaT69BTSXIlhFPED2j
	KKI7dds2stG8yayOG5EQsP0TtakNfE6awDQWNuUzgrnQObgx292j+DbGLZHkiJClHN12wpGVZchcI
	PrRSr7aQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qxCRx-00HYSp-Hq; Sun, 29 Oct 2023 20:31:58 +0000
Date: Sun, 29 Oct 2023 20:31:57 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 00/19] Rust abstractions for VFS
Message-ID: <ZT7BPUAxsHQ/H/Hm@casper.infradead.org>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018122518.128049-1-wedsonaf@gmail.com>

On Wed, Oct 18, 2023 at 09:24:59AM -0300, Wedson Almeida Filho wrote:
> Rust file system modules can be declared with the `module_fs` macro and are
> required to implement the following functions (which are part of the
> `FileSystem` trait):
> 
> impl FileSystem for MyFS {
>     fn super_params(sb: &NewSuperBlock<Self>) -> Result<SuperParams<Self::Data>>;
>     fn init_root(sb: &SuperBlock<Self>) -> Result<ARef<INode<Self>>>;
>     fn read_dir(inode: &INode<Self>, emitter: &mut DirEmitter) -> Result;
>     fn lookup(parent: &INode<Self>, name: &[u8]) -> Result<ARef<INode<Self>>>;
>     fn read_folio(inode: &INode<Self>, folio: LockedFolio<'_>) -> Result;
> }

Does it make sense to describe filesystem methods like this?  As I
understand (eg) how inodes are laid out, we typically malloc a

foofs_inode {
	x; y; z;
	struct inode vfs_inode;
};

and then the first line of many functions that take an inode is:

	struct ext2_inode_info *ei = EXT2_I(dir);

That feels like unnecessary boilerplate, and might lead to questions like
"What if I'm passed an inode that isn't an ext2 inode".  Do we want to
always pass in the foofs_inode instead of the inode?

Also, I see you're passing an inode to read_dir.  Why did you decide to
do that?  There's information in the struct file that's either necessary
or useful to have in the filesystem.  Maybe not in toy filesystems, but eg
network filesystems need user credentials to do readdir, which are stored
in struct file.  Block filesystems store readahead data in struct file.

