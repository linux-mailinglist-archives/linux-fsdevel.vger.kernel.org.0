Return-Path: <linux-fsdevel+bounces-3213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAFE7F16EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 16:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 875EC2825E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 15:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3676A1CFB9;
	Mon, 20 Nov 2023 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPebdqSS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5E71CF9C
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Nov 2023 15:13:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C7FC433CA;
	Mon, 20 Nov 2023 15:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700493208;
	bh=0pUwwHeBYZ8VsT0/McY+5CPG4am7JRREoI2bzncL4LM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mPebdqSS152jS3mn2Rj7eP2pZsL8Mv4vjIII9bUCRGMJ5jLimAbx75IttPDGhmMf7
	 aG9W8AXSmAFM03w7UOxBIfrzk6QbWmT4sNHJyYsC1GF0clB26Jk+n06ajZE4Rvw6ms
	 iW5i8L1vQZwE+zT/2Rd/I/DnhsDjxI+QwfYpjmwFfMncxMTE7h3ugnoaNkyr3IOQWF
	 q991A9XCQ74UDFAvRi6tjqJrem43MERjfkcqiJ3sparDryY8AFG43Hr0oKlNy0RUA5
	 m9ums/UqBwEaXYMCYGMN1QvueeaGxCl4oCI08fe/L+VivbrANTeBV8ojzyF7ZB2+Zq
	 ZIe/vatwcBZ7A==
Date: Mon, 20 Nov 2023 16:13:24 +0100
From: Christian Brauner <brauner@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: Rename mapping private members
Message-ID: <20231120-fortbestand-bretter-d13b1cfb5e7e@brauner>
References: <20231117215823.2821906-1-willy@infradead.org>
 <20231117220437.GF36211@frogsfrogsfrogs>
 <ZVfljIc64nEw0ewn@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZVfljIc64nEw0ewn@casper.infradead.org>

On Fri, Nov 17, 2023 at 10:13:32PM +0000, Matthew Wilcox wrote:
> On Fri, Nov 17, 2023 at 02:04:37PM -0800, Darrick J. Wong wrote:
> > On Fri, Nov 17, 2023 at 09:58:23PM +0000, Matthew Wilcox (Oracle) wrote:
> > > It is hard to find where mapping->private_lock, mapping->private_list and
> > > mapping->private_data are used, due to private_XXX being a relatively
> > > common name for variables and structure members in the kernel.  To fit
> > > with other members of struct address_space, rename them all to have an
> > > i_ prefix.  Tested with an allmodconfig build.
> > 
> > /me wonders if the prefix ought to be "as_" for address space instead of
> > inode.  Even though inode begat address_space, they're not the same
> > anymore.
> 
> It'd be the first thing in fs.h to ase an as_ prefix.  Right now, we
> have i_pages, i_mmap_writable, i_mmap, i_mmap_rwsem.  We have a_ops
> (which differs from f_op, i_op, s_op, dq_op, s_qcop in being plural!).
> Everything else doesn't have anything close to a meaningful prefix --
> host, invalidate_lock, gfp_mask, nr_thps, nrpages, writeback_index,
> flags, wb_err.
> 
> So i_ was the most common prefix, but if we wanted to go with a different

I think i_ is fine and really improves grepability. The patch isn't
really all that invasive. I'm willing to take this unless there's
substantial "this will break us all" opposition.

