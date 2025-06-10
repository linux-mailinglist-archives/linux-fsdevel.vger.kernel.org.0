Return-Path: <linux-fsdevel+bounces-51112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D02AD2D59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 07:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3964B188C93C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 05:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130E825E47E;
	Tue, 10 Jun 2025 05:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I+yeTcfJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD394C96;
	Tue, 10 Jun 2025 05:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749533662; cv=none; b=DzqTztxkZomDa4KrBak1nyMHYzaHTq4+J0v8ZAkpPHWUoxL1/9gVJkTwqO0TZF8ubH9ZU2qXSXhzgdGauCFVoWo0iOvqEN2qQh2M5pkyRGH/kpRgXCa1HNT1jstu53gb06SpCO/NXJ3HZ7SX2Uy7Qame7QJUfQ2nXiZbJpl3AUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749533662; c=relaxed/simple;
	bh=3moq36rwz3zNJhBEty7g7ksIMDP8Wkxc/8gfZSpStB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHCESMw+JYg2kODSUu+DAx0wM7/vzUlDGUmXvk9+LIb/zrWrIu2sFdVzsYd5DUmTYAKrmrNqoT7FGXo/xbJ07c5ID/FmWYvY0rgMMVaC0HQo9VbNhr0trEqwrXBN/3X39GROnKa4Bh3XPKccKMh1aKpyX/D1iNwtTDpWgTBE8BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=I+yeTcfJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bbOoognfRsZLvtYC52zli+uVVDEGlVotPrw/o3aP3xM=; b=I+yeTcfJqiLaoaeMpHE+BjScU2
	lCmX8Kbg8Q0LirnbMsNA9XjYh2iRelwW5iysdxa6c9twNLDGlg0ZwJkvlaw3BTONFR0jFUXAnknIr
	eZ92MrMJfoujRZ++fa2a1nCrfnrZ67rFUt8sxIGWMfJT57xMxea91gpc2E34VloE/keEQeq7w0yOt
	2OD4KNvApwfz0JvvhUdxqdh9iU0s87q/1nGTb/ip61/3qSpDEqfmqG8AMad4nsXFVCNTu1e3uLm4w
	xWJIUA0pGQ0K9blU8RfAehg/CUbK2zpNMjxmKEVT5U+Z62u2umBAeRbg6gB6VFg/bLyAwkVn7oleR
	22NGUnsw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOrcq-00000005qmD-3H2i;
	Tue, 10 Jun 2025 05:34:20 +0000
Date: Mon, 9 Jun 2025 22:34:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Cedric Blancher <cedric.blancher@gmail.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: LInux NFSv4.1 client and server- case insensitive filesystems
 supported?
Message-ID: <aEfD3Gd0E8ykYNlL@infradead.org>
References: <CALXu0Ufzm66Ors3aBBrua0-8bvwqo-=RCmiK1yof9mMUxyEmCQ@mail.gmail.com>
 <CALXu0Ufgv7RK7gDOK53MJsD+7x4f0+BYYwo2xNXidigxLDeuMg@mail.gmail.com>
 <44250631-2b70-4ce8-b513-a632e70704ed@oracle.com>
 <aEZ3zza0AsDgjUKq@infradead.org>
 <e5e385fd-d58a-41c7-93d9-95ff727425dd@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5e385fd-d58a-41c7-93d9-95ff727425dd@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jun 09, 2025 at 10:16:24AM -0400, Chuck Lever wrote:
> > Date:   Wed May 21 16:50:46 2008 +1000
> > 
> >     dcache: Add case-insensitive support d_ci_add() routine
> 
> My memory must be quite faulty then. I remember there being significant
> controversy at the Park City LSF around some patches adding support for
> case insensitivity. But so be it -- I must not have paid terribly close
> attention due to lack of oxygen.

Well, that is when the ext4 CI code landed, which added the unicode
normalization, and with that another whole bunch of issues.

> > That being said no one ever intended any of these to be exported over
> > NFS, and I also question the sanity of anyone wanting to use case
> > insensitive file systems over NFS.
> 
> My sense is that case insensitivity for NFS exports is for Windows-based
> clients

I still question the sanity of anyone using a Windows NFS client in
general, but even more so on a case insensitive file system :)


> Does it, for example, make sense for NFSD to query the file system
> on its case sensitivity when it prepares an NFSv3 PATHCONF response?
> Or perhaps only for NFSv4, since NFSv4 pretends to have some recognition
> of internationalized file names?

Linus hates pathconf any anything like it with passion.  Altough we
basically got it now with statx by tacking it onto a fast path
interface instead, which he now obviously also hates.  But yes, nfsd
not beeing able to query lots of attributes, including actual important
ones is largely due to the lack of proper VFS interfaces.


