Return-Path: <linux-fsdevel+bounces-32511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3889A708D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 19:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95A02B21224
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 17:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1458F1EB9F3;
	Mon, 21 Oct 2024 17:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Wbq7EcN/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2B21E9072
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2024 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729530308; cv=none; b=gtEDfLkTyTV6RCNcifcydQtmn1NqSsAvbqbQtZ3LlGgBqkPaZXDAxyHzNpvw4DlgNOWsDa1dfCy/o7lJ7/HxA+Y+i3+cr7mGNLmq8Prkb0OajnFIOMELdhb9Hcad5MJiB5p8bhCEh1qba2f7pBwjvO28mqkFXxtVJtMYdpfFdbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729530308; c=relaxed/simple;
	bh=5XECQlQwvkXtqIZSghT3bGGBK2UOjwIZA1+g/+BZLFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfFeCn7uEgffT7aGsnHLxkgGtfv4sAvN55HjACOx6rsTck8DnZ3c9aui/CVlUqtspjYtGml9a8mssOqUEMVTptQkd+iQSHy8oE1BuVl+24us8B9WqH9YKran82Ms5dKKJxAmshLy0wyNaGANaeDnnvG+0SnR7lX3Vzokl5buuQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Wbq7EcN/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YLvpQPURvE5e9Rkeb0tGrvNoJUAV35e/MS2gX+cgZcw=; b=Wbq7EcN/ZfGsJ29n3aonQVu/f7
	POThfOce3qRmeAgKKuBLnonOd0mwGle4HTinOnIYbLEExqSf+PijUHcn7KS7PEQyy5ud8bXdTPe/k
	KnF8bOBHfH725KUcID++gs85JgCkvR7B49EO0nMGmSw3PxIfw5ADaACGu1bptClQ4i15Zxyvtm4p4
	P9C4UYiREbUfinihgpeKgufg5wQ1xnXXSOy4XK0/inmbyrq+4vXF5kkPzeRFgTSi8aQu0uvA93CJk
	UFEjR6L477So8t64TUuwON1zOdI6X7i3QxkGZ6Jc1YtvFmtG8JUWJhtmbOho3JrrzeQf80eUXMJVi
	g1FXz67A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t2vq3-00000005yTH-0fQT;
	Mon, 21 Oct 2024 17:05:03 +0000
Date: Mon, 21 Oct 2024 18:05:03 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH] getname_maybe_null() - the third variant of
 pathname copy-in
Message-ID: <20241021170503.GA1350452@ZenIV>
References: <20241015-falter-zuziehen-30594fd1e1c0@brauner>
 <20241016050908.GH4017910@ZenIV>
 <20241016-reingehen-glanz-809bd92bf4ab@brauner>
 <20241016140050.GI4017910@ZenIV>
 <20241016-rennen-zeugnis-4ffec497aae7@brauner>
 <20241017235459.GN4017910@ZenIV>
 <20241018-stadien-einweichen-32632029871a@brauner>
 <20241018165158.GA1172273@ZenIV>
 <20241018193822.GB1172273@ZenIV>
 <20241021-weinreben-loslegen-564010b902a7@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021-weinreben-loslegen-564010b902a7@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Oct 21, 2024 at 02:47:59PM +0200, Christian Brauner wrote:
> On Fri, Oct 18, 2024 at 08:38:22PM +0100, Al Viro wrote:
> > On Fri, Oct 18, 2024 at 05:51:58PM +0100, Al Viro wrote:
> > 
> > > Extra cycles where?  If anything, I'd expect a too-small-to-measure
> > > speedup due to dereference shifted from path_init() to __set_nameidata().
> > > Below is literally all it takes to make filename_lookup() treat NULL
> > > as empty-string name.
> > > 
> > > NOTE: I'm not talking about forcing the pure by-descriptor case through
> > > the dfd+pathname codepath; not without serious profiling.  But treating
> > > AT_FDCWD + NULL by the delta below and passing NULL struct filename to
> > > filename_lookup()?  Where do you expect to have the lost cycles on that?
> > 
> > [snip]
> > 
> > BTW, could you give me a reference to the mail with those objections?
> > I don't see anything in my mailbox, but...
> 
> I had to search for quite a bit myself:
> 
> https://lore.kernel.org/r/CAHk-=wifPKRG2w4mw+YchNtAuk4mMJBde7bG-Z7wt0+ZeQMJ_A@mail.gmail.com

Re get_user() - there's one architecture where this fetch is a clear loss.
Take a look at what um is doing; it's a full page table walk, then
(single-byte) memcpy().  With no caching of page table walk results,
so strncpy_from_user() in case the sucker is _not_ empty will have to
start from scratch (and it's _not_ generic strncpy_from_user() there,
for the same reasons).

BTW, I wonder if we could speed the things up on um by caching the last
page table walk result - and treating that as a TLB.  Might make
back-to-back get_user()/put_user() seriously cheaper there - unsafe_get_user()
could grow a fastpath, possibly making generic strncpy_from_user() cheap
enough to be used.  If that is feasible, the only non-generic variant
would remain on mips, and that's a lot less convincing case than um.
Possibly strnlen_user(), as well - that one has a variant on xtensa,
but that's also not an obvious win compared to generic...

That's a separate story, anyway.

