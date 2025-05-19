Return-Path: <linux-fsdevel+bounces-49462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAA7ABCA14
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 23:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0F33AB1C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 21:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C24E21E0AC;
	Mon, 19 May 2025 21:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="GVewrvfp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8210E21A94F
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 21:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747690513; cv=none; b=m58F0T8leqE8iuiHfCY1qn+UADmN7sjSO804m8Mh63NzatbH7Js6fkYVXwu8Ztrfwq/Sir4alxl4qEaZfWeGBdyl0jeYESihn/swD620wCMo7XVbG0IVczhVUgL/gGQdIyUKswcxnEVkMUgDyt+jmv2QOVMKJRqZ0WlSWUhRx6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747690513; c=relaxed/simple;
	bh=UwTtLAdTmM3o5DWUqeAAm+dCZh5TRkRO14eBU6K39jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIBqf1uR4wpSoiVyjrOEEtM9EB+igNt+ZGprANTkz6TQCMczn8w1emxC7qRGFVBme4Sr04otVxYaB+pI31PNnIk2QUFhKkL/Ky3rmwuLfxj//T9hg/hpVghgFAzwcefpcVPD4F835kCDXz3bdnM/OVtcCqATVlfzxJ/aPTc1Etk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=GVewrvfp; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jOGEytbhcMBqWlDaglAMvrwLhgI7utfBDmM3alU+39Q=; b=GVewrvfp/JELgQAp/Wb37FHym7
	qiWCSQCQLgEPrYjq79BQBM37MBZSnQCWPHjL/koWXFpShDOVjsVi21B+i/7IrWtB3BvzzKGkpIs0x
	7iHcNKDOOTjntLFu0h+0F2fB6+qGxNKO86vv8vCVSFECmzX5U/Yo64zLHZg5aw8VMGnrqp4/Ho1Gy
	waatXB+sXVoTItEWzj/9FtlYMylmm9PN3iwALgQWyhffVcZb/MJ35rfWP6dnpWqMsaM3Zqhj29qWW
	C1Rf005MpvZAK5VOV7MEtj4hiL6SYorDPDXyJQzCmbDb+NSXe4wkjQp83AOE7G5UsZ0JJH/gUl2Wf
	xrtfTZ9g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH88a-0000000C3U9-0YqS;
	Mon, 19 May 2025 21:35:08 +0000
Date: Mon, 19 May 2025 22:35:08 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC][CFT][PATCH] Rewrite of propagate_umount() (was Re: [BUG]
 propagate_umount() breakage)
Message-ID: <20250519213508.GA2023217@ZenIV>
References: <20250511232732.GC2023217@ZenIV>
 <87jz6m300v.fsf@email.froward.int.ebiederm.org>
 <20250513035622.GE2023217@ZenIV>
 <20250515114150.GA3221059@ZenIV>
 <20250515114749.GB3221059@ZenIV>
 <20250516052139.GA4080802@ZenIV>
 <CAHk-=wi1r1QFu=mfr75VtsCpx3xw_uy5yMZaCz2Cyxg0fQh4hg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi1r1QFu=mfr75VtsCpx3xw_uy5yMZaCz2Cyxg0fQh4hg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, May 19, 2025 at 11:11:10AM -0700, Linus Torvalds wrote:
> Another thing that is either purely syntactic, or shows that I
> *really* don't understand your patch. Why do you do this odd thing:
> 
>         // reduce the set until it's non-shifting
>         for (m = first_candidate(); m; m = trim_one(m))
>                 ;
> 
> which seems to just walk the candidates list in a very non-obvious
> manner (this is one of those "I had to go back and forth to see what
> first_candidate() did and what lists it used" cases).
> 
> It *seems* to be the same as
> 
>         list_for_each_entry_safe(m, tmp, &candidates, mnt_umounting)
>                 trim_one(m);
> 
> because if I read that code right, 'trim_one()' will just always
> return the next entry in that candidate list.

	list_for_each_entry_safe() is safe wrt removal of the _current_
element.  Suppose the list is <A, B, C, D> and trim_one(A) wants to
take out A, B and D.  What we want is to have it followed by trim_one(C),
but how could *anything* outside of trim_one() get to C?

	list_for_each_entry_safe() would pick B as the next entry
to consider, which will end up with looping in B ever after.

	What trim_one(A) does instead is
* note that A itself needs to be removed
* remove B and D
* remember who currently follows A (the list is down to <A, C>, so C it is)
* remove A
* return C.

	We could have a separate list and have trim_one(m) move m to in
case it still looks like a valid candidate.  Then the loop would turn
into
	while !empty(candidates)
		trim_one(first candidate)
	move the second list over to candidates (or just use it on the
next stage instead of candidates)
What's slightly confusing about that variant is that m might survive
trim_one(m), only to be taken out by subsequent call of trim_one() for
another mount.  So remove_candidate(p) would become "remove p from
candidates or from the set of seen candidates, whichever p currently
belongs to"...

	Another variant would be to steal one more bit from mnt_flags,
set it for all candidates when collecting them, have is_candidate() check
that instead of list_empty(&m->mnt_umounting) and clean it where this
variant removes from the list; trim_one() would immediately return if
bit is not set.  Then we could really do list_for_each_entry_safe(),
with another loop doing list removals afterwards.  Extra work that way,
though, and I still think it's more confusing...
	OTOH, "steal one more bit" would allow to get rid of
->mnt_umounting - we could use ->mnt_list for all these sets.  IIRC,
the reason for ->mnt_umounting was that we used to maintain ->mnt_list
for everything in a namespace, and having to restore it if we decide
that candidate has to stay alive would be painful.  These days we
use rbtree for iterators, so ->mnt_list on those suckers is fair
game...

	Re globals - the other bunch is part of propagate_mnt(), not
propagate_umount()...  IIRC, at some point I got fed up by arseloads
of arguments passed from propagate_umount() down to the helpers and
went "fuck it, we have a hard dependency on global serialization anyway,
might as well make all those arguments global" (and I remember trying
to go with per-namespace locks; stuff of nightmares, that)...

	I'll look into gathering that stuff into a single structure
passed by the callers, but the whole thing (especially on the umount
side) really depends upon not running into another instance working
at the same time.  Trying to cope with duelling umount propagations
from two threads... the data structures would be the least of headache
sources there.

