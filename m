Return-Path: <linux-fsdevel+bounces-34634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF549C6F21
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 13:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EAD0B33EEB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 12:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BE9200C9A;
	Wed, 13 Nov 2024 12:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="at2e3wS9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7B61DF250;
	Wed, 13 Nov 2024 12:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731500488; cv=none; b=mSwhfJhy1rAlF9ApjvJFvNTwXpjGT78xVyK2huvBvRT6DBW8ws+hD6OgZ8hwX8/pAzDw3hXb2ZgGf7PyYKabmzhxeNZMjH+rPtLPR8WRNuRshoRswj26ho0glFmUDZ8PE6Yzv/qrsrurKymYQ0d6Gs0qqTQtI5saft9ybqzL+CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731500488; c=relaxed/simple;
	bh=sRahG0jY7C92Pv2ieJzgaq5OEbOR4ygaH0OgwnC/pAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKpe/c4oBw5y9O51IIOQfEa28JE7fbcpal2s5gZLFr5aErHiFdOYnHoDryS1Ub55RK3tF7yQjL97nbFCZASC/GKBSJ3ooOKcrcQj3hmEm/YAr9bgZRg9H/FOIgigquqHIn5sfleMIRz2rd/fnWo4gLwKYdsX+ZlpUZSEhJsjVXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=at2e3wS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2861EC4CEE9;
	Wed, 13 Nov 2024 12:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731500486;
	bh=sRahG0jY7C92Pv2ieJzgaq5OEbOR4ygaH0OgwnC/pAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=at2e3wS9jvEH67INqxjutyD9TMxPrEgQhKRiEDuOI1n1lLzMf/ZSWKDsO/HOLAzbh
	 D8VyKIRQt2rJ7CGeMppcT+v0VzhtZbpkqrzsd1VonDq7DJdY+S9Rop34I19Uk/6Ngb
	 W3ddbl9O6lCdL7kBzRocf32ZgAItPHox5Ah9jYgFuNpJf7T61zfCbUz2wbtEBe5edH
	 YcZYfZ2gVYa5saupUfZaABAVKBmjHQo90vCrFwaKHsqBMJnBjTKQurSjW0fiE4mEY8
	 Jos6gvhEDWdcIxjiuI26QViae/ixvg6jLtP8sxtp8ZGrrWS/MVq00q6uwWHu+Kxvvk
	 OBV0xwCHWVm1Q==
Date: Wed, 13 Nov 2024 13:21:21 +0100
From: Christian Brauner <brauner@kernel.org>
To: Erin Shepherd <erin.shepherd@e43.eu>
Cc: Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, christian@brauner.io, 
	paul@paul-moore.com, bluca@debian.org
Subject: Re: [PATCH 4/4] pidfs: implement fh_to_dentry
Message-ID: <20241113-glorreiche-abfallen-4ab73565bb60@brauner>
References: <20241101135452.19359-1-erin.shepherd@e43.eu>
 <20241101135452.19359-5-erin.shepherd@e43.eu>
 <08d15335925b4fa70467546dd7c08c4e23918220.camel@kernel.org>
 <CAOQ4uxg96V3FBpnn0JvPFvqjK8_R=4gHbJjTPVTxDPzyns52hw@mail.gmail.com>
 <ed210bc9-f257-4cbd-afba-b4019baaf71f@e43.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ed210bc9-f257-4cbd-afba-b4019baaf71f@e43.eu>

On Wed, Nov 13, 2024 at 11:11:47AM +0100, Erin Shepherd wrote:
> On 13/11/2024 09:01, Amir Goldstein wrote:
> 
> > I don't like playing pseudo cryptographic games, we are not
> > crypto experts so we are bound to lose in this game.
> 
> I agree. It would be one thing to obfusficate things in order to prevent
> userspace from relying upon something that's not ABI; it would be another
> to do so with the intent of hiding data. If we wanted to do that, we'd
> need to actually encrypt the PID (with e.g. AES-CTR(key, iv=inode_nr))
> 
> > My thinking is the other way around -
> > - encode FILEID_INO32_GEN with pid_nr + i_generation
> > - pid_nr is obviously not unique across pidns and reusable
> >   but that makes it just like i_ino across filesystems
> > - the resulting file handle is thus usable only in the pidns where
> >   it was encoded - is that a bad thing?
> >
> > Erin,
> >
> > You write that "To ensure file handles are invariant and can move
> > between pid namespaces, we stash a pid from the initial namespace
> > inside the file handle."
> >
> > Why is it a requirement for userspace that pidfs file handles are
> > invariant to pidns?
> 
> I don't think it's a requirement, but I do think its useful - it is nice if

It kind of is though, no? Because you need a reliable way to decode the
pidfs file handle to a struct pid. If one encodes pid numbers as seen
from the encoders pid namespace the decoder has no way of knowing what
pid namespace to resolve it in as the same pid number can obviously be
present in multiple pid namespace. So not encoding the global pid number
would be inherently ambiguous.

> a service inside a pidns can pass you a file handle and you can restore it and
> things are fine (consider also handles stored on the filesystem, as a better
> analog for PID files)
> 
> But I too was uncertain about exposing root namespace PIDs to containers. I
> have no objections to limiting restore of file handles to the same pid ns -
> though I think we should defnitely document that such a limitation may be
> lifted in the future.

The point is really just the provided pid needs to be resolvable in the
pid namespace of the caller. Encoding a global pid number means that
internally we can always resolve it as we know that we always encode
pids in the init pid namespace.

In a second step we can then verify that the struct pid we found based
on the pid number is a member of the pid namespace hierarchy of the
caller. If that is the case then the caller is allowed to get a pidfd
from open_by_handle_at() as they would also be able to get a pidfd via
pidfd_open().

So a container will never be able to a pidfd from a pid number that
resolves to a struct pid that is outside its pid namespace hierarchy.

Let me know if I misunderstood the concerns.

