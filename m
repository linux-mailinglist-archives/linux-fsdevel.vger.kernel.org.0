Return-Path: <linux-fsdevel+bounces-55406-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 837ACB09DD4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 10:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E2751C422D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 08:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177712253A1;
	Fri, 18 Jul 2025 08:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+o1biBD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1CB221299
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 08:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752827092; cv=none; b=G/OZC5Ha8oUOZKhemIYcZ908AlYiBWZ6m42Ne2S4LVwbIhNg+DDfnB34L+f/hPZczVNIYmWqRp09xTlpVqLIJz2tSP3X2U1b75/OOJ2FH6atgMhb2mlPJtqaOc0fBsl9Vt/QCoNky/TdSiV6FLTRwj4TKMbxdXVmIrY6zOIM2Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752827092; c=relaxed/simple;
	bh=sVQsolnnCJuLILt02MiOxWZxcfz5JnT2hyv24xtRbaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LuUOlDoZAPxMW7+k+1lpfdW6SyxiEzDVBy+gfppKv5v8rTwCamzwLkllVhv+4IVzapTnDhT/Gs7J3/CWNaU5UElV0wCAuntEmxva86OH6MTprofepr1ZG+lN+5SpIAirZqcppRpXQY6zu17Vbil/pW3HwvUgyz8Cu+AXXXWAlFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+o1biBD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4E5C4CEEB;
	Fri, 18 Jul 2025 08:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752827092;
	bh=sVQsolnnCJuLILt02MiOxWZxcfz5JnT2hyv24xtRbaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L+o1biBDfezAVsjv5Ax50hkmfOMI6dsz92jbE/n7AfkYgBnmtUmmBUzZNbkVK6+DI
	 NGnLhVsN5iovok+eLRIZtub9GGm5pdXuUbckq2wVWgGpdYN1xU/0eI61jfN1QAU1G0
	 1nEk9eWeN+6on7YeqJSFw5JpGVgiLiWxrojYAwRHT8UTSxBakexYgKoBlDZtBu3A5S
	 Tyqg16itvo7B7fp6mkWxSbJ4IuGoYohbgR4r2UDn3FyodkpkqdD/CkkngRXWRKxt1g
	 FfqKIISI181GutgCWCHemPpYrogtoxtEJs4odJFoUY5j6TrdCwfv18jkxiiH99FAA2
	 pswT8OsMHNnvQ==
Date: Fri, 18 Jul 2025 10:24:47 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.com>, 
	Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC DRAFT DOESNOTBUILD] inode: free up more space
Message-ID: <20250718-funkkontakt-gehrock-c78ddcf4e009@brauner>
References: <20250715-work-inode-fscrypt-v1-1-aa3ef6f44b6b@kernel.org>
 <20250716112149.GA29673@lst.de>
 <20250716-unwahr-dumpf-835be7215e4c@brauner>
 <q4uhf6gprnmhbinn7z6bxpjmdgjod5o7utij7hmn6hcvagmyzj@v5nhnkgrwfm5>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <q4uhf6gprnmhbinn7z6bxpjmdgjod5o7utij7hmn6hcvagmyzj@v5nhnkgrwfm5>

On Thu, Jul 17, 2025 at 02:57:02PM +0200, Jan Kara wrote:
> On Wed 16-07-25 14:19:57, Christian Brauner wrote:
> > On Wed, Jul 16, 2025 at 01:21:49PM +0200, Christoph Hellwig wrote:
> > > On Tue, Jul 15, 2025 at 04:35:24PM +0200, Christian Brauner wrote:
> > > > Unless there are severe performance penalties for the extra pointer
> > > > dereferences getting our hands on 16 bytes is a good reason to at least
> > > > consider doing this.
> > > > 
> > > > I've drafted one way of doing this using ext4 as my victim^wexample. I'd
> > > > like to hear some early feedback whether this is something we would want
> > > > to pursue.
> > > 
> > > I like getting rid of the fields.  But adding all these indirect calls
> > > is a bit nasty.
> > > 
> > > Given that all these fields should be in the file system specific inode
> > > that also embeddeds the vfs struct inode, what about just putting the
> > > relative offset into struct inode_operations.
> > > 
> > > e.g. something like
> > > 
> > > 	struct inode_operations {
> > > 		...
> > > 		ptrdiff_t		i_crypto_offset;
> > > 	}
> > > 
> > > struct inode_operations foofs_iops {
> > > 	...
> > > 
> > > 	.i_crypto_offset = offsetoff(struct foofs_inode), vfs_inode) -
> > > 		offsetoff(struct foofs_inode, crypt_info);
> > > }
> > > 
> > > static inline struct fscrypt_inode_info CRYPT_I(struct inode *inode)
> > > {
> > > 	return ((void *)inode) - inode->i_op->i_cryto_offset;
> > > }
> > 
> > Sheesh, ugly in a different way imho. I could live with it. I'll let
> > @Jan be the tie-breaker.
> 
> Heh, I feel biased because about 10 years ago I proposed something like
> this and it got shot down as being too ugly to be worth the memory. But
> times are changing :). I think hooks to return pointer are cleaner but this

We can't just keep accumulating more and more stuff in our core
structures. The bpf people are breathing down our neck to put more
things in struct inode and I'm sure the next thingamabob is already in
the works and we need a way to push such stuff out of core struct inode.

It is simply not sustainable so I'd rather bite the bullet and have it
look ugly rather than waste more and more memory or argue that we can't
do something because it bloats a core structure for the sake of code
purity. And it's not that bad tbh. We have uglier hacks (stealing
pointer bits for struct fd comes to mind) for the sake of performance. I
don't see why significant memory savings for most other kernel consumers
of this struct should not be worth it.

> is clearly going to be faster. I think since this would be fully
> encapsulated in the few inline helpers the offset solution is (still) OK.

