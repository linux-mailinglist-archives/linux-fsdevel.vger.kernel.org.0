Return-Path: <linux-fsdevel+bounces-20192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 779298CF6B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 01:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3250428185D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 23:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C36813A3EB;
	Sun, 26 May 2024 23:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="OL4fRYvU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EE613A25D;
	Sun, 26 May 2024 23:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716765407; cv=none; b=UX/pGHLSbtfInorE8ADdHCE67tfX3zDtvvE77GX1ylCOxr2UwlTAlH0IjdjLippISmUNwA0GU55PqpQMkVXS3m+znDHqPUlfeV23TXynw0hGHoe6twy8NL/u+YdKRRoy/WuRieyxXjrelyzgtT4/JAfDcaue8arD3DebeKbtqsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716765407; c=relaxed/simple;
	bh=SvVxcy4zMXIcrzfOIMksqGi6f1D0W3cEUvoQRvmyQ+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqkHtv7F2Q3k6FIcR97sO2svCnC8JZevdwRqLVgrwbXGvh0zvEdqv6bjAAv7Uv6lhDkwjPrpg9XzrQIeSDp3WohKm4K29Ljml4IBEExrP0ZzUoqvm5ecf8vzHUl5wxPTGQ8XlkddPABjfO8rZeO53upQHsl1JHpxgt7Ev2gLAUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=OL4fRYvU; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ot5qxpOdV4cX5rE/iGFXy1muUxNUF/yleqvpYYQ3M8g=; b=OL4fRYvUj2vlYQcic+AubpHxWg
	vQbBoyx7gi852a6z4WdpY7WQiA17tXOh8vsWLI1sCXprThm4GO8KEj6T5tmph1RqoSWBrHESLW4pj
	fX+N/D5cNzaEaqBl6JeDunhrjj/z+gaa3uJhG7WNaUmWXKqAUcYNKHsDMkpPiXpOugp7UmTHVGgP8
	ZcbaRlk6+5fdBohlYB5N4krXhNYXNnVfdXJJWVloOgOYJGTN4WpMiXQtlEvKj/3d9l61mOJn+3RWG
	OdnVw01j6AxKn/FQ3dQNRy7WK/t1ieELjQuEsXPAsIFKXU+sVTqQKGLCM1dLA7BKQYii2bHBhLUcJ
	uWofdJNA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sBN6X-00BDZN-0l;
	Sun, 26 May 2024 23:16:41 +0000
Date: Mon, 27 May 2024 00:16:41 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH][CFT][experimental] net/socket.c: use straight
 fdget/fdput (resend)
Message-ID: <20240526231641.GB2118490@ZenIV>
References: <20240526034506.GZ2118490@ZenIV>
 <CAHk-=wjWFM9iPa8a+0apgvBoLv5PsYeQPViuf-zmkLiCGVQEww@mail.gmail.com>
 <20240526192721.GA2118490@ZenIV>
 <CAHk-=wixYUyQcS9tDNVvnCvEi37puqqpQ=CN+zP=a9Q9Fp5e-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wixYUyQcS9tDNVvnCvEi37puqqpQ=CN+zP=a9Q9Fp5e-Q@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, May 26, 2024 at 03:16:37PM -0700, Linus Torvalds wrote:

> Hopefully in most cases the compiler sees the previous test for
> fd.file, realizes the new test is unnecessary and optimizes it away.

It does.

> Except we most definitely pass around 'struct fd *' in some places (at
> least ovlfs), so I doubt that  will be the case everywhere.

... and those places need care, really.  I've done that review
quite recently.  I don't think you'd been on Cc in related thread...
<checks> nope.

|| Another is overlayfs ovl_real_fdget() and ovl_real_fdget_meta().
|| Those two are arguably too clever for their readers' good.
|| It's still "borrow or clone, and remember which one had it been",
|| but that's mixed with returning errors:
||         err = ovl_read_fdget(file, &fd);
|| may construct and store a junk value in fd if err is non-zero.
|| Not a bug, but only because all callers remember to ignore that
|| value in such case.

Junk value as in e.g. <ERR_PTR(-EIO), FDPUT_FPUT>; it's trivial
to avoid (
		file = ovl_open_realfile(file, &realpath);
		if (IS_ERR(file))
			return ERR_PTR(file);
                real->flags = FDPUT_FPUT;
                real->file = file;
		return 0;
instead of
                real->flags = FDPUT_FPUT;
                real->file = ovl_open_realfile(file, &realpath);

                return PTR_ERR_OR_ZERO(real->file);
we have there right now and similar for <ERR_PTR(-EPERM), 0> pairs),
but note that anything like your switch to struct-wrapped unsigned long
would need similar massage there anyway.

> What would make more sense is if you make the "fd_empty()" test be
> about the _flags_, and then both the fp_empty() test and the test
> inside fdput() would be testing the same things.

Umm...  What encoding would you use?

> Sadly, we'd need another bit in the flags. One option is easy enough -
> we'd just have to make 'struct file' always be 8-byte aligned, which
> it effectively always is.
> 
> Or we'd need to make the rule be that FDPUT_POS_UNLOCK only gets set
> if FDPUT_FPUT is set.

Huh?  That makes no sense - open a file, fork, and there you go;
same file reference in unshared descriptor tables in child and parent.
You definitely don't want to bump refcount on fdget_pos() in either
and you don't want to lose read/write/lseek serialization.

FDPUT_FPUT is *not* a property of file; it's about the original
reference to file not being guaranteed to stay pinned for the lifetime
of struct fd in question...

