Return-Path: <linux-fsdevel+bounces-38106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8237A9FC1A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 20:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05D32165B90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 19:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A6E180A80;
	Tue, 24 Dec 2024 19:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="S0OWFedk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9798218AE2
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Dec 2024 19:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735067940; cv=none; b=BQ6DfPVQBSIIddn9RZMK1vJlmwR/AyrtuwQBE7xANLuUHsp8vxPkgT8qM9HehZJQZY4I2BLmXVKsX/Nxnp2UXUyItwyJsAzCSNKawjY6aKxHg7HxvTNN+T4s5+GeH0JHlPhtkY8vruEF2iuADJxDNvKIwp8WldnhGnyL1LVtFho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735067940; c=relaxed/simple;
	bh=cO//RWMFYVGRDMjPv17bJUku3ijxTJDnQ2IbM21dsLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvjMt2aKfVzow32x2RSkgknU3j9pG1MehuqfKaCIMnbIhxOvszN3Nh/psr81CUWlZUMNkbYtstDNGBKcFu+1HFN/SYCHokxDjqPJqlgOtKrxUy6Wx7dVn3S8QHXvvMhHsYI2yUsceYijlBQFiMVFRlSKpmULQ5KfepAQxXI0fIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=S0OWFedk; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oHhlraYMex1BbGVVTdqeTTIKAKIpJL7DdL1qPujaoj0=; b=S0OWFedkrbOONKYmW1SEx3cDSs
	BWazhxklJ99QG/wIMMEpbo0+nLIDE45g28uZZwh2V0qq5XHeYFngnpxl5S+sK+sLIlVjE4IdrPuNq
	nv4+kuGR0HEd3hL/mnYoirGyph48o5iM2+B1WN0QuoLBaRBGgKBJfERNmaFQAYW02ZUeTPJ7biKG/
	WRNUm/6XIi1xMV2bbLynGim4eJNRswCOtvbA3fzRdLKYJhsOh9b0w9TnuM0lQpSgJCRFYi6sSldRW
	VyPbkg1KahjbrucTMn0yhpm8hsKNe/+kopoNbC1J2JHmDcsY9yCUtX91FjXRUKVBtJnII5qEF2g37
	v90v1o0A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tQAQh-0000000Bmka-03v7;
	Tue, 24 Dec 2024 19:18:55 +0000
Date: Tue, 24 Dec 2024 19:18:54 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jann Horn <jannh@google.com>
Subject: Re: [PATCH][RFC] make take_dentry_name_snapshot() lockless
Message-ID: <20241224191854.GS1977892@ZenIV>
References: <20241209035251.GV3387508@ZenIV>
 <CAHk-=wh4=95ainkHyi5n3nFCToNWhLcfQtziSp3jSFSQGzQUAw@mail.gmail.com>
 <20241209211708.GA3387508@ZenIV>
 <20241209222854.GB3387508@ZenIV>
 <CAHk-=wjrtchauo9CO1ebkiES0X1VaZinjnHmcXQGBcZNHzyyBA@mail.gmail.com>
 <CAHk-=wj_rCVrTiRMyD8UKkRdUpeGiheyrZcf28H6OADRkLPFkw@mail.gmail.com>
 <20241209231237.GC3387508@ZenIV>
 <20241210024523.GD3387508@ZenIV>
 <20241223042540.GG1977892@ZenIV>
 <41e481e9-6e7f-4ce0-8b2d-c12491cce2dc@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41e481e9-6e7f-4ce0-8b2d-c12491cce2dc@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Dec 23, 2024 at 02:31:38PM -0700, Jens Axboe wrote:

> > And that's a user-visible ABI.  What the hell?
> > 
> > NOTE: file here is may be anything whatsoever.  It may be a pipe,
> > an arbitrary file in tmpfs, a socket, etc.
> > 
> > How hard an ABI it is?  If it's really used by random userland code
> > (admin tools, etc.), we have a problem.  If that thing is cast in
> > stone, we'll have to emulate the current behaviour of that code,
> > no matter what.  I really hope it can be replaced with something
> > saner, though.
> > 
> > Incidentally, call your file "<none>"; is the current behaviour
> > the right thing to do?
> > 
> > What behaviour _is_ actually wanted?  Jens, Jann?
> 
> It's not really API, it's just for debugging purposes.

Famous last words...  Let's hope that change won't bring some deployed
userland tool screaming about breakage; it's been there for almost 5 years...

> Ideal behavior -
> show the file name, if possible, if not it can be anything like "anon
> inode" or whatever.
> 
> IOW, we can change this however we want.

All right, how about
		seq_printf(m, "%5u: ", i);
		if (f)
			seq_file_path(m, f, " \t\n\\<");
		else
			seq_puts(m, "<none>");
		seq_puts(m, "\n");
in io_uring_show_fdinfo(), instead of your
                if (f)
			seq_printf(m, "%5u: %s\n", i, file_dentry(f)->d_iname);
		else   
			seq_printf(m, "%5u: <none>\n", i);
Can you live with that?  Said that, I'm not sure that <none> case is worth printing -
you are dumping the entire table, in order of increasing index, so it's not as if
those lines carried any useful information...  If we do not care about those, it
becomes
		if (f) {
			seq_printf(m, "%5u: ", i);
			seq_file_path(m, f, " \t\n\\");
			seq_puts(m, "\n");
		}
- we only need to escape '<' in names to avoid output clashing with <none>...

