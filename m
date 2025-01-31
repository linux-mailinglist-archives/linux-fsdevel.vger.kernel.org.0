Return-Path: <linux-fsdevel+bounces-40518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BC4A24432
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 21:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47E233A329A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 20:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC711F3D3B;
	Fri, 31 Jan 2025 20:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="aapcnkq/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A31625760
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 20:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738356076; cv=none; b=m3Vi5iz1mOu5oYcBRetJ0nLaiVNE7U63MoeEp28DK3kqtRPm3Zzkaq3390HZV/eiEwIB5AU+EAvZGwc/ejN2ozN2ZygRrRV+8L4kt6I29gqjV1yngAe+nI9Yhl2B9GM0BL4IHlZkkd1kHnu8JGRFmIZRPwLSIxTDMJBLv2UUhD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738356076; c=relaxed/simple;
	bh=k3xhfvKrf2Pr5tDaLENix581N1tdmWKU5tPRSQYGlHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/djzT3FijKxR/z3lLp8g9JsigXxlb9D2pIkwz0AXntZeXt+8OzhUzZMJL17BwqkjQSobLsbgHWJlkOelcljazPm4s+5CezhhdpR+/erHe4ae6SviN7QXeyPr1H/yZwoHZS4zn/W3ESBfh6aB+VMU3lY4H3zNWIeDd5fYy1/ys8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=aapcnkq/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wyeY0zl3q3i15QAC1d8ZJ/K8m1LYUmdoE0QeI/z3MGY=; b=aapcnkq/3FfcP81l7ShcYg555j
	SxSk9qWc9FWSkAfIN+sYpCO5lcPG2T9tlslFdaKKnRCfHEN81/sLeGsz68aTMLdeu80EdnGdEUJQd
	EM1ZEBHsCjmVp53Q+mKb7aDIIqqD9fWrpiVEYHe6EbaHAkDxcsunlBEy67nFnkpQeL9OHr3k4af7n
	SPf7MgMPadyTof6JGPK9szoM1FuQw7cx+Wc2xyk561K5sg1x4aetCZtPxTGM/Jd4xyH45ngXihZVh
	FzNJ/cG8t7LI4B6VoGhsIvipi/3EUhhRxDVvjSeDKGlag/W5O0A5YsbEcScxX1cPjbNY/dJMVh0dD
	Zaw6rWOQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tdxp9-0000000HD92-0eMU;
	Fri, 31 Jan 2025 20:41:11 +0000
Date: Fri, 31 Jan 2025 20:41:11 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH][RFC] add a string-to-qstr constructor
Message-ID: <20250131204111.GY1977892@ZenIV>
References: <20250131083201.GX1977892@ZenIV>
 <CAHk-=wg0FbExNA0nHe=VcJy1j=uNY-YvkzQcTCCOEALwPuWzBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg0FbExNA0nHe=VcJy1j=uNY-YvkzQcTCCOEALwPuWzBw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jan 31, 2025 at 11:29:05AM -0800, Linus Torvalds wrote:
> On Fri, 31 Jan 2025 at 00:32, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > This commit lifts definition(s) of QSTR() into linux/dcache.h,
> > converts it to compound literal (all bcachefs users are fine
> > with that) and converts assorted open-coded instances to using
> > that.
> 
> Looks fine to me. I do wonder if the cast to 'struct qstr' should be
> part of QSTR_INIT, so that you can use that the same way when you
> already know the length.
> 
> We have code like this in fs/overlayfs/namei.c:
> 
>         *name = (struct qstr) QSTR_INIT(n, s - n);
> 
> in bcachefs has
> 
>         return (struct qstr) QSTR_INIT(d.v->d_name, bch2_dirent_name_bytes(d));
> 
> So both of them would seem to want to have that cast as part of the
> QSTR_INIT() thing.
> 
> Or maybe we could just make QSTR() itself more powerful, and do
> something like this:
> 
>     #define QSTR_INIT(n, l, ...) { { { .len = l } }, .name = n }
>     #define QSTR(a, ...) (struct qstr) QSTR_INIT(a , ## __VA_ARGS__, strlen(a))
> 
> which allows you to write either "QSTR(str)" or "QSTR(str, len)", and
> defaults to using 'strlen()' when no length is given.
> 
> Because if we have heper macros, let's make them _helpful_.
>
> Side note: you missed a few places in the core VFS code that could
> also use this new cleanup:
> 
>         struct qstr this = QSTR_INIT("pts", 3);
>         ...
>         child = d_hash_and_lookup(parent, &this);
> 
> can now be just
> 
>         child = d_hash_and_lookup(parent, &QSTR("pts"));
> 
> but sadly a few more are static initializers and can't use 'strlen()'.

There's also this in fs/fuse/inode.c
                const struct qstr name = QSTR_INIT(".", 1);
and
        struct qstr null_name = QSTR_INIT(NULL_FILE_NAME,
						  sizeof(NULL_FILE_NAME)-1);
in selinuxfs - I wasn't trying to get them all, just the infrastructure
and enough examples to demonstrate the usefulness.  Once the definition
is merged, those could be switched at leisure.

