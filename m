Return-Path: <linux-fsdevel+bounces-66682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A42C28A19
	for <lists+linux-fsdevel@lfdr.de>; Sun, 02 Nov 2025 07:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3E064E307B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Nov 2025 06:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0A6260575;
	Sun,  2 Nov 2025 06:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="SP139NaS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40E82566;
	Sun,  2 Nov 2025 06:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762064094; cv=none; b=M5Yv7EHbeSwZQRgHr0w3Nqj+aT4ebQjhd6dv1eONrYFCPuGHk41yibM9qjTDOFPfaX11wLIsnHLzGC7jD9zu8bDUBoaUkaN1ZXOgAvqzckqfiH1W2SkzmYMuMg/SrTbaSk3u2LltPdDSuxeuESIU9Xcziwlw3+PmZK0DjTkxmtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762064094; c=relaxed/simple;
	bh=YXSM2YQ9C3fmfUg9hMzz3r6GrWcyrqSt4GI6duBohBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGmElIqiY5u3AIfio1dSaoub6cMlMPPcBQur/K0y3nQOHXtZD6mgBrfGVfvbUbc3nMFC4K0/1YJad4OaJwgytod0GOI45loXPBJlgklksi98NRCTI7lGF1S+BNYpQOS0OJ/dm61VRFduadwbovi6GEjU26YKyHIrNjL2H70csaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=SP139NaS; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=TBJzu2vu0tgjqlqrzAAeyyr7iAbz2rADLICsDuA9jlg=; b=SP139NaSEP/CV4zc7fdo/HWw19
	LdEcTS+XN4gvDwzYjd6zP8PAat+EMKuNuAqFyvU4RwO0kFp3VbFppSp5PnN+BCmHZXUs7ND3Xbd93
	KcvzcVZ/mKPzDZRRlZ0m4JTHjS37zXTNSVLB3tOwI5YkJJbfUdq0qFqhPRSZo8L5KA/UtIksgO28s
	Va7WqW5cmuvX4/a2rpHlYRCK7PEayKVkszdQFqC/rNCm19fvPDCzzIMfhQYmr1BmMwcWOkvkwe4C6
	WNJozKE1FDToujZqMMN0p/lBFf4rHR4j5um12vz4eatanN6xH/db8O43jLbXjKiSHuZFbipvzyd49
	zpSqzlHA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFRMR-0000000Ds6v-1iYN;
	Sun, 02 Nov 2025 06:14:43 +0000
Date: Sun, 2 Nov 2025 06:14:43 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: touch up predicts in putname()
Message-ID: <20251102061443.GE2441659@ZenIV>
References: <20251029134952.658450-1-mjguzik@gmail.com>
 <20251031201753.GD2441659@ZenIV>
 <20251101060556.GA1235503@ZenIV>
 <CAGudoHHno74hGjwu7rryrS4x2q2W8=SwMwT9Lohjr4mBbAg+LA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHHno74hGjwu7rryrS4x2q2W8=SwMwT9Lohjr4mBbAg+LA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Nov 01, 2025 at 09:19:21AM +0100, Mateusz Guzik wrote:
> On Sat, Nov 1, 2025 at 7:05 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Fri, Oct 31, 2025 at 08:17:53PM +0000, Al Viro wrote:
> >
> > > 0) get rid of audit_reusename() and aname->uptr (I have that series,
> > > massaging it for posting at the moment).  Basically, don't have
> > > getname et.al. called in retry loops - there are few places doing
> > > that, and they are not hard to fix.
> >
> > See #work.filename-uptr; I'll post individual patches tomorrow morning,
> > hopefully along with getname_alien()/take_filename() followups, including
> > the removal of atomic (still not settled on the calling conventions for
> > getname_alien()).
> >
> 
> Ok, in that case I think it will be most expedient if my patch gets
> dropped and you just fold the updated predicts into your patchset
> somewhere. I don't need any credit.

See #work.filename-refcnt.  I'm not entirely happy about the API, if you
see a saner way to do it, I'd really like to hear it.  Stuff in the series:

	* get rid of getname in retry loops.  Only 9 places like that left,
massaged out of existence one by one.  (##1..9)
	* drop audit_reusename() and filename->uptr (#10)
	* get rid of mixing LOOKUP_EMPTY with the rest of the flags -
very few places do that at this point and they are not hard to take
care of (##11..15)
	* take LOOKUP_EMPTY out of LOOKUP_... space entirely - make it
GETNAME_EMPTY and have it passed only to getname_flags() (#16)
	* add GETNAME_NOAUDIT for "don't call audit_getname() there" (#17).
Helpers: getname_alien()/getname_uflags_alien() being wrappers for
that; io-uring switched to those for filename import (in ->prep()).
take_filename(): take a reference to struct filename, leaving NULL
behind, feed it to audit_getname() and return to caller.   Used by
io-uring ->issue() instances that feed an imported filename to
do_{mkdir,mknod...}() - the stuff that does actual work, done in the
thread that will do that work.
	* make filename->refcnt non-atomic; now it can be done (#19,
on top of merge from vfs-common/vfs-6.19.misc to bring your commit
in).

