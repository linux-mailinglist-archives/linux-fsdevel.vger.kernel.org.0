Return-Path: <linux-fsdevel+bounces-16333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D971A89B554
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 03:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FD071F21439
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 01:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37E917C2;
	Mon,  8 Apr 2024 01:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="DvemyNyA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39ED15A8
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Apr 2024 01:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712540391; cv=none; b=SlpEyBPoEmJM18RN4qxCGwmWohWeMY8K/IDlDhdxLeAozd7jX5yX68KJ7iR9uKNYZ6SNPZFu/CgACon2jHhnc8WmOeePly8LSHUGAjkGm5I3WN+m3w2eaPwIBr7WCRwaG9ed64424Rs2jVNDAbwJPuyUECTDDiwBQrLmMNJ/K5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712540391; c=relaxed/simple;
	bh=zJKJK5l/b2eY/YHFUNvSK0zGx+9rl7WxZ+zIbHlaaak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHooLtUwZlo1pT00eAu3FSvcV0DZbkGks1vdH/6raI75AZwbosPIpxWIObKn+eOzk6j+Xc6Auyu7I5eJ1NZWzrEBc5W44JKG/1QdmbcmXR/bTdLjzGadtwmYJzio517ysiJnXC4NsFvhZLuVBsUv+8+GYSjUvkTqIfxgl8RYTTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=DvemyNyA; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-118-221.bstnma.fios.verizon.net [173.48.118.221])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4381dTjd031031
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 7 Apr 2024 21:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1712540370; bh=F/NXeh60kH/CKsYkDgUE+27ivtJL3MzJ1EyU4gatORM=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=DvemyNyAvfIzjgTdQ2q28WjB/CRO14UxSz0kpETLZD7J64fI8CvAu7t3OflWnWV+q
	 UsJ2kTH8iAkdhw6zUhXfqO6sTKb2BvaV8AW33yKDAuA5f28QhfolXElbY1+gC/qiWX
	 88Z68ekKqkZStRrTeW5Vd3CtEhAuPiNADKYe1pYpE9hquXews558z2ATs4eoi8EYkT
	 NAAovo1Fo/2wRHnAVGUET+fQFOanBoQ/hiRolfLu50Iyt0gOa2isXyPP13QgsEuQmf
	 DYx3nEM1nZAC9t+QOpT3FqH92jCU8bZqn0yGon9HcWu+W0VqteFMCdM6fmk1pDF1Kt
	 7YsXxpRjw8+Vg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id E333E15C00DE; Sun,  7 Apr 2024 21:39:28 -0400 (EDT)
Date: Sun, 7 Apr 2024 21:39:28 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: HAN Yuwei <hrx@bupt.moe>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Questions about Unicode Normalization Form
Message-ID: <20240408013928.GG13376@mit.edu>
References: <AD5CD726D505B53F+46f1c811-ae13-4811-8b56-62d88dd1674a@bupt.moe>
 <ccfe804c63cbc975b567aa79fb37002d50196215.camel@HansenPartnership.com>
 <D445FB6AD28AA2B6+fe6a70b0-56bf-4283-ab4d-8c12fb5d377f@bupt.moe>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D445FB6AD28AA2B6+fe6a70b0-56bf-4283-ab4d-8c12fb5d377f@bupt.moe>

On Sat, Apr 06, 2024 at 11:15:36PM +0800, HAN Yuwei wrote:
> 
> Sorry, I am not very familiar with Unicode nor kernel. Correct me if wrong.
> 
> As to what I have read, kernel seems like using NFD when processing all
> UTF-8 related string.
> If fs is using these helper function, then I can be sure kernel is applying
> NFD to every UTF-8 filenames.
> But I can't find any references to these helper function on Github mirror,
> how are they used by fs code?

For the most part, the kernel's file stysem code doesn't do anything
special for Unicode.  The exception is that the ext4 and f2fs file
systems can have an optional feature which is mostly only used by
Android systems to support case insensitive lookups.  This is called
the "casefold" feature, which is not enabled by default by most
desktop or server systems.

The casefold feature was developed because Android has a requirement
to support case-insensitive lookups, and it had to support Unicode
character sets (for example, XFS has support for case insensitive
lookups back from the Irix days, but it only supports ASCII), and the
alternative to adding support in the kernel for case fodling was this
terrible out-of-tree kernel module which use a file system wrapping
that was deadlock-prone (which is why the case-folding wrapfs would
never be accepted upstream; it was a trash fire).  Anyway, I got tired
of being asked to debug file system deadlocks which was not the VFS's
fault, but was rather caused by this terrible wrapfs kludge used by
Android, so I instigated proper case-folding support (ala Windows and
MacOS) for the file system types commonly used by Android, namely ext4
and f2fs.

So *if* you are using ext4 or f2fs, *and* the file system is specially
created with the file system feature flag "casefold", *and* the
directory has the casefold flag set, *then* the file system will
support case-preserving, case-insensitive lookups.  As a side effect
of using utf8_strcasecmp, it will also do string comparisons where
even if you have not normalized the file banes, so that the filename
contained some Unicode character, such as (for example) the NFC form
of the Anstrom Sign character (00C5), and you try to look it up using
the NFD form of the character (0041 030A), the lookup will succeed,
because we use utf8_strcasecmp().   However, this is *only* if case
folding is enabled, and in general, it isn't.

Aside from this exception (which as I said, is in general only enabled
for Android, because most other use cases such as for Desktop, Server,
etc. don't really care about MacOS / Windows style case insensitive
filename lookups), the Linux VFS in general treats UTF-8 characters as
null-terminated byte streams.  So the kernel doesn't validate to make
sure that a file name is composed of valid UTF-8 code points (e.g., so
we don't prohibit the use of Klingon characters which are not
recognized by the Unicode consortium), nor does the kernel do any kind
of Unicode normalization.  So for example, if casefolding is not
enabled, 0041 030A and 00C5 will be considered different, and kernel
will not force the NFC form (00C5) to the NFD form (0041 030A) or vice
versa.

Now, because the kernel tries very hard to be blissfully ignorant
about the nightmare which is I18N, it is up to the userspace Unicode
libraries to normalize strings before passing them to the kernel ---
either as data in text files, or as file names.  I am very glad that I
don't worry about whether the standard normalization form used by the
various GNOME, KDE, Unicode, etc., userspace libraries is NFD, NFC,
NFKD, or NFKC.  That's someone else's problem, and if you don't have
casefolding enabled, we will do the filename comparisons using the
strcmp() function.

Fundamentally, unicode and normalization is a userspace problem, not a
kernel problem, except when we don't have a choice (such as for casse
insensitive lookups).  And there we solve just the smallest part of
the problem, and make it userspace's problem for everything else.

Cheers,

					- Ted

