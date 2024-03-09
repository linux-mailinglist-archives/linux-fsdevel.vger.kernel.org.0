Return-Path: <linux-fsdevel+bounces-14060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D606877278
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 18:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C087F1F21AD4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 17:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D22C22F00;
	Sat,  9 Mar 2024 17:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="J9j4FkA+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D5E1CD1D
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Mar 2024 17:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710005834; cv=none; b=U/k5APLJwwXIT0juTq6tW6fmHEdARLaynOdg2juWVP40jl725J00/czGP62kbQYcJQasY7KMU5WdW4070dDaBRB4X3sHsRwYUbSTpirXF0ytaMqEsT/2/J+K6ybL7UwHekdmQ9LHeeSom2GDBXA7CjlVN4yBxrQWOwJmPHAs6aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710005834; c=relaxed/simple;
	bh=4a+v8Ej7xkuKfJCRl6OGe7hcXG6VG/+ojuMEE+Ljnp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tFg3kUEUjRgYQgWYTqtiu/LyMjydT0wYErnpIDXrPSEWwbj4Zg2CP7pZWxY2q30qqmxfzVqgSqhuejtAj6l0rnJHu6tMspnJUceY8EQ/fzlIWS4Myg72PS4x+O0FyKMJY6JfCtXJVvSSxuwWx1Li7avqu7Gqo3pxXBuNv8+uWHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=J9j4FkA+; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-236.bstnma.fios.verizon.net [173.48.82.236])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 429Hb1pZ028720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 9 Mar 2024 12:37:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1710005822; bh=9elOI6GpyTpZ/7j17WgRMfYrS+bnbPgrkKxtq7ZzIqc=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=J9j4FkA+DjpgTNOuaFGXn0QUdx//DjZ9byAUaDGuyK03nN0rBNjBk4Xd7eK59Bob6
	 VpRkZwAnhQx9dUqao0wWq5F5CGYQycPWbm5HVIcP8KNTd5MhsROt3LsVejkfE49iEx
	 l+TqSk3NHFDpxoW17mnepiMiJX16WRTo/ihzQ0kNxdQxnxaCruDuZdBwDm12/G4v5k
	 eG3MjlDlNzmU3LhaLR+dfNhXyvG0VA9qarfmZLKrVqL7lXOjYV+xjq+cf3aRDQNQme
	 adpSPzrMl7BPZ5Py4pk40+nMLkhCd2EWr6YWNLNfo0snLbretNrhdEJo3buFmCJ4Ml
	 bNoL+a6Yo1CVQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id F220D15C027D; Sat,  9 Mar 2024 12:37:00 -0500 (EST)
Date: Sat, 9 Mar 2024 12:37:00 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Phillip Susi <phill@thesusis.net>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: Uneccesary flushes waking up suspended disks
Message-ID: <20240309173700.GB143836@mit.edu>
References: <877cieqhaw.fsf@vps.thesusis.net>
 <20240307153756.GB26301@mit.edu>
 <87jzmcwijz.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzmcwijz.fsf@vps.thesusis.net>

On Fri, Mar 08, 2024 at 03:54:40PM -0500, Phillip Susi wrote:
> "Theodore Ts'o" <tytso@mit.edu> writes:
> 
> > Another fix would be making sure that the kernel isues the file system
> > syncs, and waits for them to be completed, *before* we freeze the
> > disk.  That way, if there are any dirty pages, they can be flushed to
> > stable store so that if the battery runs down while the laptop is
> > suspended, the user won't see data loss.
> 
> That's exactly how it works now.  The kernel syncs the fs before
> suspending, but during that sync, even though there were no dirty pages
> and so nothing has been written to the disk and it has been runtime
> suspended, the fs issues a flush, which wakes the disk up, only to be
> put right back to sleep so the system can transition to S3.

In an earlier message from you upthread, you had stated "Since the
disk is suspended however, there is nothing in the cache to flush, so
this is wasteful."  So that sounded like the flush was happening at
the wrong time, after the disk has already been suspended?

Am I missing something?

Thanks,

					- Ted

