Return-Path: <linux-fsdevel+bounces-32372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D309A4713
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 21:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AC2B1F24A9A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 19:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4150B204F68;
	Fri, 18 Oct 2024 19:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="oPw+rupG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7058F73477
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Oct 2024 19:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729280307; cv=none; b=Jtkrdcs7DPAuZYUEy7g9692TEMQj+nF7oBb9G/Nlh+2YV9fhSr1i8N2KLEspcW8Hoz945cz9S8YArQ8RWJrjrLJ/HYHS52Rve77lXqo7kJRDQtnTfr7+C/JQSarCtY6bCY3JHRagAOA/HXOADhpBswm6KVI6TWjju5q82b2Otxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729280307; c=relaxed/simple;
	bh=eKxNJ1wPfUbBugVEUtqitdk3Is2B3/6nYnQitqxLYE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMdxZ8N56LOc2V3KTgPovooNeWnnhNCVdB7PWm96DacExAh5DcGs2r5nuCt9UbXm3vW5QvUizipPCFOeFyQ0A/Vbz+cc3iIt/QGzY7XnVaiznDw4k1OsKP8Qfg09ix/HAiq3U3CmAyf3D3+52EeZK2da7LLxEGIFugcglTEtwjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=oPw+rupG; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OBWcFJcHuODtIa2N6z1xi1+9eR+X9y0Fd5kvBcycBAU=; b=oPw+rupGM0caBObCb3Y5hInTeA
	SrBhHmjAusBaMqMaQlBufWGKFIdZJIBePRWZOxXU94Gg4pZwW14WrqfV4GsKwqHe5SakZjgFHYQZc
	JUBUayXZccQiWoVXhW9JOCdjS9SrvbzskASGODwBimsHuheDqFzQS8A+FFk0AT8aQii9Xi4ldvaYA
	Vhy+3Bk0UL7LSdUQxletEO4lvhlIdp92CFjgzqxCwFBFjvE+LGGvDm7y7gPoRv2QKvXFEOee6636x
	4iTvxygETI+LwsRkLS65rA9OXKiUqiPl/ZJ7RuxLJI5Frweq+YWByy7DiwpFr9RV4ZJsLCpkYgmjl
	Jjyx5aCQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t1snm-000000059jo-1eqy;
	Fri, 18 Oct 2024 19:38:22 +0000
Date: Fri, 18 Oct 2024 20:38:22 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH] getname_maybe_null() - the third variant of
 pathname copy-in
Message-ID: <20241018193822.GB1172273@ZenIV>
References: <20241009040316.GY4017910@ZenIV>
 <20241015-falter-zuziehen-30594fd1e1c0@brauner>
 <20241016050908.GH4017910@ZenIV>
 <20241016-reingehen-glanz-809bd92bf4ab@brauner>
 <20241016140050.GI4017910@ZenIV>
 <20241016-rennen-zeugnis-4ffec497aae7@brauner>
 <20241017235459.GN4017910@ZenIV>
 <20241018-stadien-einweichen-32632029871a@brauner>
 <20241018165158.GA1172273@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018165158.GA1172273@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Oct 18, 2024 at 05:51:58PM +0100, Al Viro wrote:

> Extra cycles where?  If anything, I'd expect a too-small-to-measure
> speedup due to dereference shifted from path_init() to __set_nameidata().
> Below is literally all it takes to make filename_lookup() treat NULL
> as empty-string name.
> 
> NOTE: I'm not talking about forcing the pure by-descriptor case through
> the dfd+pathname codepath; not without serious profiling.  But treating
> AT_FDCWD + NULL by the delta below and passing NULL struct filename to
> filename_lookup()?  Where do you expect to have the lost cycles on that?

[snip]

BTW, could you give me a reference to the mail with those objections?
I don't see anything in my mailbox, but...

Or was that in one of those AT_EMPTY_PATH_NOCHECK (IIRC?) threads?

Anyway, what I'm suggesting is

1) teach filename_lookup() to handle NULL struct filename * argument, treating
it as "".  Trivial and does not impose any overhead on the normal cases.

2) have statx try to recognize AT_EMPTY_PATH, "" and AT_EMPTY_PATH, NULL.
If we have that and dfd is *NOT* AT_FDCWD, we have a nice descriptor-based
case and can deal with it.
If the name is not empty, we have to go for dfd+filename path.  Also obvious.
Where we get trouble is AT_FDCWD, NULL case.  But with (1) we can simply
route that to the same dfd+filename path, just passing it NULL for filename.

That handles the currently broken case, with very little disruption to
anything else.

What's more, the logics for "is it NULL or empty with AT_EMPTY_PATH" no
longer needs to care about dfd.  We can encapsulate it nicely into
a function that takes userland pointer + flags and does the following:

	if no AT_EMPTY_PATH in flags
		return getname(pointer)
	if pointer == NULL		     (same as vfs_empty_path())
		return NULL
	peek at the first byte, if it's '\0' (same as vfs_empty_path())
		return NULL
	name = getname_flags(pointer, LOOKUP_EMPTY)
	if IS_ERR(name)
		return name
	if unlikely(name is empty)
		putname(name)
		return NULL
	return name

Then statx() (or anyone who wants similar AT_EMPTY_PATH + NULL semantics)
can do this:
	name = getname_maybe_null(user_pointer, flags)
	if (!name && dfd >= 0) // or dfd != AT_FDCWD, perhaps
		do_something_by_fd(dfd, ...)
	else
		do_something_by_name(dfd, name, ...)
without the bitrot-prone boilerplate.

