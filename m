Return-Path: <linux-fsdevel+bounces-30206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A41E987B3A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 00:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A92C1C22EA4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 22:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8C01B0104;
	Thu, 26 Sep 2024 22:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kORpHkZ8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C4514AD17;
	Thu, 26 Sep 2024 22:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727390864; cv=none; b=Hy8e9UFkIv1+oumBZG0Nm07jBfY3z81m5kT1WgU/PJLWvAbOAaAnl0d2We3EyGWjGg8pXwuU326c6n/wRx8fDPlbtFn4lgScGYRKuLVr8eQ4x1wPf6wrsSzmJBhcldZQvR7LZLboIahsbT1O9tvTLwuWn9V3BKTpQhOT31FMZMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727390864; c=relaxed/simple;
	bh=dr7ELgjvEaJ6VuB9mzRh+8/cUyjY3mocp5rd32TBmWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dd3BDCCJHqeiKGZhuvSuxxxp39VoXIx/uA6OYA5M6oU8N3fyZX6+135ruZ05qWsnkpmyaCdv1vT0kxkQOfDRS1cd5e3304z4NtcWgXyHLFNr0jhcJArZttZ4WjLuhtCh8LO/FigKqyRTw3e7y+UM4HanloCnqHUAHpfQWeZgjhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=kORpHkZ8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qcBcLSP1fjlBBBA9Tv4weRx5CH25aglzEfNgzqEp4pU=; b=kORpHkZ8LqP4ZoRWpzM0AzW7JT
	8b1FZUXpInsEIjC+WYSQIZ1fiBXVj1ibGCILpYyOY4nP1TOnjhITdznULV4KaSToIJL/ett/hredF
	VuvfbYnml3oC7iDfNXfaJmc/QGmYa7SUMMxGI2SA7CVnnmg9fpA9DKJOgz3bW7lPdC3X+1D1Qb6Bf
	kayGDa4NqK+jM9mNNkSAnoc66GEA5v438cIO175ay86J/wGgXiNLZQF1jAR0PvBPil8V5z0ODmeUW
	wmAebKzjvjvPlfL6twxgT6ijhI8TLNVrDeec/EMGmpMuADR6hJ83lQvQSYqZ0YDOTx7bjBblHOxGt
	nhcD6vlA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1stxGn-0000000FnzF-3SWQ;
	Thu, 26 Sep 2024 22:47:33 +0000
Date: Thu, 26 Sep 2024 23:47:33 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] rust: file: add f_pos and set_f_pos
Message-ID: <20240926224733.GQ3550746@ZenIV>
References: <20240926-b4-miscdevice-v1-0-7349c2b2837a@google.com>
 <20240926-b4-miscdevice-v1-2-7349c2b2837a@google.com>
 <20240926220821.GP3550746@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926220821.GP3550746@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Sep 26, 2024 at 11:08:21PM +0100, Al Viro wrote:
> On Thu, Sep 26, 2024 at 02:58:56PM +0000, Alice Ryhl wrote:
> > Add accessors for the file position. Most of the time, you should not
> > use these methods directly, and you should instead use a guard for the
> > file position to prove that you hold the fpos lock. However, under
> > limited circumstances, files are allowed to choose a different locking
> > strategy for their file position. These accessors can be used to handle
> > that case.
> > 
> > For now, these accessors are the only way to access the file position
> > within the llseek and read_iter callbacks.
> 
> You really should not do that within ->read_iter().  If your method
> does that, it has the wrong signature.
> 
> If nothing else, it should be usable for preadv(2), so what file position
> are you talking about?

To elaborate: ->llseek() is the only method that has any business accessing
->f_pos (and that - possibly not forever).  Note, BTW, that most of the
time ->llseek() should be using one of the safe instances from fs/libfs.c
or helpers from the same place; direct ->f_pos access in drivers is
basically for things like
static loff_t cfam_llseek(struct file *file, loff_t offset, int whence)
{
        switch (whence) {
	case SEEK_CUR:
		break;
	case SEEK_SET:
		file->f_pos = offset;
		break;
	default:
		return -EINVAL;
	}

	return offset;
}
which is... really special.  Translation: lseek(fd, n, SEEK_CUR) - return n
and do nothing.  lseek(fd, n, SEEK_SET) - usual semantics.  Anything else
- fail with EINVAL.  The mind-boggling part is SEEK_CUR, but that's
userland ABI of that particular driver; if the authors can be convinced that
we don't need to preserve that wart, it can be replaced with use of
no_seek_end_llseek.  If their very special userland relies upon it...
not much we can do.

Anything else outside of core VFS should not touch the damn thing, unless
they have a very good reason and are willing to explain what makes them
special.

From quick grep through the tree, we seem to have grown a bunch of bogosities
in vfio (including one in samples, presumably responsible for that infestation),
there's a few strange ioctls that reset it to 0 or do other unnatural things
(hell, VFAT has readdir() variant called that way), there are _really_ shitty
cases in HFS, HFS+ and HPFS, where things like unlink() while somebody has the
parent directory open will modify the current position(s), and then there's
whatever ksmbd is playing at.

We really should not expose ->f_pos - that can't be done on the C side (yet),
but let's not spread that idiocy.

