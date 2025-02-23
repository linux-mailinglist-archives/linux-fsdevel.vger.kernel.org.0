Return-Path: <linux-fsdevel+bounces-42369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BDAA4114C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 20:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 943101712C4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 19:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A895189BAF;
	Sun, 23 Feb 2025 19:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="t/K/WyJf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0353A8F7
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Feb 2025 19:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740339683; cv=none; b=Zxx7aY2wpuV2Uw4BCBWXSUZkAU9aMMPlJy2UC4OuXQfTGqRrE7pva7pwAUfFAuOY8Ml9LVVbyCScDQJ8vwFA1dfI4JqDmjvL78RQoYzr3adHXLeoE08D1vDKIt40Ur9sh63D9AMl54+xhLoPmmkAr92aDo8KbpX+Mj0uPHSZA/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740339683; c=relaxed/simple;
	bh=TV4qfoQgglwTaOZ9vWbc8gynyeB/TZ7WLDBpmEREgw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7cQsnRcRdEjFbQjgaUK+9u/T1Wp6lLE9keXTJtjqRUvJsLyOz2zEU2NwWDb/ahrYT0yO8VfnDBRc+wgJ9b4zziNXLsd27TqILXw+bp6YcJLLSF0celQ5fu7ggrsWiWjZT+vqZqxmC7I45Fn1hEJOyjyoGUHHICL0lSAR2Wlfio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=t/K/WyJf; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ID1OBnk4I9q6p5b08I+FmPh34QFMaD4CF3RsCWwYURc=; b=t/K/WyJfYC4Y25h4REDvDFgC1n
	LnokkaJLMLeWm9uuGfDSC4PoDbdrRG3/rpfjUCS8gdcAhKYJF+G0kCElPYWamJwJfZ7VXh9WCmAEh
	QHyIPV0G6JpKqLWhsl1K3Gd7Xns2IkzwAod81XMAze0YdlEaRrwZ4CJGNjKloYYuQW0Ur9FfQFsOO
	2HaDJ292Y0VBJZZmoJjMJkK2NBOdgA0Xoh5zBTqAukelLbAHxvrwpwcHwyTGAB+6D94qpI06/TRh/
	uYJSrWnRgpSAt6TuukhmHqTohL+x4eMEnjXBbIgH63Vj1IYoxPlsxivh9t3C1oRFguqFRzBO2U+oZ
	7lNH5s3g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmHqn-00000006MIG-3Oqr;
	Sun, 23 Feb 2025 19:41:17 +0000
Date: Sun, 23 Feb 2025 19:41:17 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Bernd Schubert <bernd.schubert@fastmail.fm>,
	Laura Promberger <laura.promberger@cern.ch>,
	Sam Lewis <samclewis@google.com>
Subject: Re: [PATCH] fuse: don't truncate cached, mutated symlink
Message-ID: <20250223194117.GS1977892@ZenIV>
References: <20250220100258.793363-1-mszeredi@redhat.com>
 <20250223002821.GR1977892@ZenIV>
 <CAJfpegv24BN_g3C0uNPZu_gM7GEy_3eSYyFSaeJZ7mLsfcNqJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegv24BN_g3C0uNPZu_gM7GEy_3eSYyFSaeJZ7mLsfcNqJw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Feb 23, 2025 at 08:12:21PM +0100, Miklos Szeredi wrote:
> On Sun, 23 Feb 2025 at 01:28, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Thu, Feb 20, 2025 at 11:02:58AM +0100, Miklos Szeredi wrote:
> >
> > > The solution is to just remove this truncation.  This can cause a
> > > regression in a filesystem that relies on supplying a symlink larger than
> > > the file size, but this is unlikely.  If that happens we'd need to make
> > > this behavior conditional.
> >
> > Note, BTW, that page *contents* must not change at all, so truncation is
> > only safe if we have ->i_size guaranteed to be stable.
> >
> > Core pathwalk really counts upon the string remaining immutable, and that
> > does include the string returned by ->get_link().
> 
> Page contents will not change after initial readlink, but page could
> get invalidated and a fresh page filled with new value for the same
> object.

*nod*

My point is that truncation of something that might be traversed by another
pathwalk is a hard bug - we only get away with doing that in page_get_link()
because it's idempotent.  If ->i_size can change, we are not allowed to
do that.

