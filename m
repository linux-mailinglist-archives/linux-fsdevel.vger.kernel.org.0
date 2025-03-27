Return-Path: <linux-fsdevel+bounces-45178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D26A740FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 23:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D8D93AEE04
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 22:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A467B1E835E;
	Thu, 27 Mar 2025 22:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppS7nWzq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF6C1DF75C
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Mar 2025 22:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743114463; cv=none; b=tu5PcoAZrhO3fp2xS45nhHr4ftq8M1cf2hFtWHbA7BYLqREat9+rfHXavjlZYn69X+MGk+SIll4lIE1F5egE2h1lp8pjs+y0A/dQZN5ozGo2UmEWj8nkcM9LqttWwpJNKZ1WrGAjvl+FdfZi6yyijkX9JoXNlpRtn/WaIg4BnRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743114463; c=relaxed/simple;
	bh=FzIjcx9dBnfY4ctyzoIH3XwzJbef24djr7Tb+00ZDJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XagNUN8qACkboEPKyI1HA+/RvT83FLAOTaKNhNEIe/rdZ3B1IZUqeWweVtOaf7TBnyhVG2UIfSn1PJXo4xbDlzABvzvfCfN3/7oS+1YcbV8qwyemHYgR4UFGp02dDtxgViF5anl11Kd6utiGu9mhw3eAj7zLo8Jw17fHNy7NFrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppS7nWzq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4EAC4CEDD;
	Thu, 27 Mar 2025 22:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743114462;
	bh=FzIjcx9dBnfY4ctyzoIH3XwzJbef24djr7Tb+00ZDJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ppS7nWzqshJOtPe5St3wFnGfv9q45JbWKKvTn5/5mr7PaBtQ4goFI/XReyZxQZtOT
	 g8QOonmhqMCFDEhPyran1KmrG60CzHIaZpT9kHt+W3qNOmCgh/WywpMEDn9Fz74v2V
	 /LS7v1BzOgeRJk5BSvpihlI81ZTkK9EObGaiFzfwwir9jEC8o+8Rbwe6yFwkz3gGW2
	 /x56F57URYEaWr9Dd2BeGeOaajlAHU6hQfsPEgRL4CnB0fSSljPULzhU2f7nTKRkOZ
	 cCmrJ02Kc4XRH8Yo37xgsIWiiVV0P53R3LjkWQs9r05lmZQr096HYCr1cWrCVGpoJL
	 C1k8BEDzdVxJA==
Date: Thu, 27 Mar 2025 22:27:40 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: chao@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 0/4] f2fs: Remove uses of writepage
Message-ID: <Z-XQ3NFrfi2-bd3U@google.com>
References: <20250307182151.3397003-1-willy@infradead.org>
 <174172263873.214029.5458881997469861795.git-patchwork-notify@kernel.org>
 <Z9DSym8c9h53Xmr8@casper.infradead.org>
 <Z9Dh4UL7uTm3cQM3@google.com>
 <Z9RR2ubkS9CafUdE@casper.infradead.org>
 <Z9Shx72mSqnQxCh3@google.com>
 <Z-N2hsKd2NJeNiKN@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-N2hsKd2NJeNiKN@casper.infradead.org>

On 03/26, Matthew Wilcox wrote:
> On Fri, Mar 14, 2025 at 09:38:15PM +0000, Jaegeuk Kim wrote:
> > On 03/14, Matthew Wilcox wrote:
> > > Unfortunately, I thnk I have to abandon this effort.  It's only going
> > > to make supporting large folios harder (ie there would then need to be
> > > an equivalently disruptive series adding support for large folios).
> > > 
> > > The fundamental problem is that f2fs has no concept of block size !=
> > > PAGE_SIZE.  So if you create a filesystem on a 4kB PAGE_SIZE kernel,
> > > you can't mount it on a 16kB PAGE_SIZE kernel.  An example:
> > > 
> > > int f2fs_recover_inline_xattr(struct inode *inode, struct page *page)
> > > {
> > >         struct f2fs_inode *ri;
> > >         ipage = f2fs_get_node_page(F2FS_I_SB(inode), inode->i_ino);
> > >         ri = F2FS_INODE(page);
> > > 
> > > so an inode number is an index into the filesystem in PAGE_SIZE units,
> > > not in filesystem block size units.  Fixing this is a major effort, and
> > > I lack the confidence in my abilities to do it without breaking anything.
> > > 
> > > As an outline of what needs to happen, I think that rather than passing
> > > around so many struct page pointers, we should be passing around either
> > > folio + offset, or we should be passing around struct f2fs_inode pointers.
> > > My preference is for the latter.  We can always convert back to the
> > > folio containing the inode if we need to (eg to mark it dirty) and it
> > > adds some typesafety by ensuring that we're passing around pointers that
> > > we believe belong to an inode and not, say, a struct page which happens
> > > to contain a directory entry.
> > > 
> > > This is a monster task, I think.  I'm going to have to disable f2fs
> > > from testing with split page/folio.  This is going to be a big problem
> > > for Android.
> > 
> > I see. fyi; in Android, I'm thinking to run 16KB page kernel with 16KB format
> > natively to keep block_size = PAGE_SIZE. Wasn't large folio to support a set
> > of pages while keeping block_size = PAGE_SIZE?
> 
> Oh, I think I do see a possible argument for continuing this work.
> 
> If we have an f2fs filesystem with a 16kB block size, we can use order-0
> folios with a 16kB PAGE_SIZE kernel, and if we want to mount it on a
> kernel with a 4kB PAGE_SIZE kernel, then we can use order-2 folios to
> do that.
> 
> Is that a useful improvement to f2fs?  It's not really the intent of
> large folios; it's supposed to be used to support arbitrary order folios.
> But we have all the pieces in place such that we could tell the page
> cache min-order = max-order = 2.

It may be helpful in case where someone wants to try 4KB page kernel back,
after Android ships 16KB page/block products. Does it require a big surgery?

