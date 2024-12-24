Return-Path: <linux-fsdevel+bounces-38109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EB19FC23C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 21:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83C3E1883B6D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 20:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B0E212B3C;
	Tue, 24 Dec 2024 20:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bjNYxM7y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF34142E76
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Dec 2024 20:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735071899; cv=none; b=DDgGQCNeS7CC7iL+LxYaAtbgzEKlzYs7opiPvQmnCLD+SkZ3cnCqk/QeFRFinZ++y+AtwsBnKxszIxjY4It7+y8l/2bqdXsmJ1bo+vo0sP6xjTez0q2IAFweugoXxQgOo/ZflrPWavcMVjPL9Jv9CNrOUYkDLQCSGXWtw5uGLhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735071899; c=relaxed/simple;
	bh=Xr3jMqjmEh/AA8533OkGCLvih3wNmmeyeSbJoksCDGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORrxKXfkqcTXlrmMbdA7fzhKgAp56yJHhb+i07wcJaGeFAIaTEO431Jlxf/nF2gTXAp6j0h7c+x3KX+EfmKJa3KrfNyU4D+oJjGNZ1wXVMfuccj8hyiX0BV3ba8G2nQMrPsCZ5zJsAI5LTZeZ8WOYZLcTTlttJFNWs9Y9v8KRwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bjNYxM7y; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8G73kpC85fCPsH5dvSjBij/D5p4bKHNBHi6VMskEWAo=; b=bjNYxM7y/3WrDlSdAR/3TZCCW4
	7dqSz0kCe+MOpCkbMvI3dKDadABj+gRPDzO2T9fGR4J5Bzjn5qPC0e2VPiv6Np4ugUDMjah4YFFTp
	RZ4/Jicld5LGkHZRlPF2dkc54ZCE9s45f+0oFfdBMJYY2B1jZP60dm+S9TN5UAmP5T3APc8rK9OVp
	c2x8anZ0rwJPKviaUnwNev+ffzt8eunXyyNkJyBhU/8tx2SWlee+4pnBlSl7lFNJ6WOVrMcYHgUzZ
	SBfPJ9ktzAM1uBduWqvwFVcGBDb9eIw0x9TzJHFMF3Kp919hV1sQT/eDE4q5w7aAiIYdgJcuit9hm
	WdyibLOQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tQBSY-0000000Bnk4-22qu;
	Tue, 24 Dec 2024 20:24:54 +0000
Date: Tue, 24 Dec 2024 20:24:54 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH][RFC] make take_dentry_name_snapshot() lockless
Message-ID: <20241224202454.GT1977892@ZenIV>
References: <20241209211708.GA3387508@ZenIV>
 <20241209222854.GB3387508@ZenIV>
 <CAHk-=wjrtchauo9CO1ebkiES0X1VaZinjnHmcXQGBcZNHzyyBA@mail.gmail.com>
 <CAHk-=wj_rCVrTiRMyD8UKkRdUpeGiheyrZcf28H6OADRkLPFkw@mail.gmail.com>
 <20241209231237.GC3387508@ZenIV>
 <20241210024523.GD3387508@ZenIV>
 <20241223042540.GG1977892@ZenIV>
 <41e481e9-6e7f-4ce0-8b2d-c12491cce2dc@kernel.dk>
 <20241224191854.GS1977892@ZenIV>
 <CAHk-=wi6-XuqHrQ6ndE5jUR_rLnXZS2ZnhjbqjXTqxUthK_SBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi6-XuqHrQ6ndE5jUR_rLnXZS2ZnhjbqjXTqxUthK_SBA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Dec 24, 2024 at 11:44:55AM -0800, Linus Torvalds wrote:
> On Tue, 24 Dec 2024 at 11:18, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >                 if (f)
> >                         seq_file_path(m, f, " \t\n\\<");
> >                 else
> >                         seq_puts(m, "<none>");
> 
> Maybe seq_file_path() could do the "<none>" thing itself.
> 
> Right now it looks like d_path() just oopses with a NULL pointer
> dereference if you pass it a NULL path. Our printk() routines -
> including '%pd' - tend to do "(null)" for this case (and also handle
> ERR_PTR() cases) thanks to the 'check_pointer()' logic.

	Umm...  What about the escape character set?  If we have
seq_file_path() produce "<none>" for a NULL file reference, we'd
need to make sure that file called "<none>" won't get mixed with
that...

	OTOH, there will be leading / in all cases except for
pipes/sockets/anon files/anything that has ->d_dname() and
it looks like the output of all instances has either '/' or
':' in it...  Feels brittle, though.

	Anyway, I'm not at all sure that those <none> lines are
actually useful for anything - we get something like
UserFiles:    512
followed by 512 lines of form index:name or index:<none>, with
indices going from 0 to 511.

	We are dumping an io_uring private descriptor table - all
of it in one call of ->show().  And each line is prepended with
the slot number, so it's not obvious that dumping empty slots
makes sense.

