Return-Path: <linux-fsdevel+bounces-8619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F44283994B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 20:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1C9C1C25EC1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 19:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3AA823DC;
	Tue, 23 Jan 2024 19:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kUhLAkwG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B028B481DC;
	Tue, 23 Jan 2024 19:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706036984; cv=none; b=LgVGwk6Dn+BVwGnesvCJ/8VX0AJXQQh65qM0el0Q+f+Ne6uNa2Wc0OPE5KMdRk7W5SgYc0TcaISs97M1n/BQDDjZgsWdKXXF3UAHjLv/+cGnGs3PmCSezeNWbKmbRQGGtEPyn9rPJUyFva6RJEgHJxaAgOIoIWpXZVGSUovRs5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706036984; c=relaxed/simple;
	bh=GfcqHqYn6zpa43HZfbBWu94lrhx0W3/9XvbrHFWuZe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKN14gnUHGZZcKqZgw4PHNgeNdHNerLoaH1uszEH7VqcyZ9WPVKKcKQye3PfcqVb1Je/IB/QIZqGnp2nCxt+QFlX6xPspweJIFvlzIdpDZormpKdGA/tzboaucDCrCmtrqpyxQfs4iZIlZ/t1UpveOwpVSsNMWxm+s781OXymjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kUhLAkwG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cL35+wxe3UCEiNgkbHUhPMWYJij5B6ryjcGpNo2q69w=; b=kUhLAkwGdgP3YXsklIW8PJ5ivG
	p+UWPvXW9WYWFxmAjLaI1D3WjmNmm8Vx2p3ZqTmWYe8u5YZaD5L7Ar9sQJlHqGvVdz9lBSAaTIsTR
	8boEQRU+1TS6S3o7d3QyJyMdidys5oCbLZaSw6YhX4dl746vKM/yCvivWZCD+KcpVDfVpPo2r1d9j
	S0X7r/1BJvZS2S66uvhNWBV+JHEXLrbDJE8GATUtVlK53vnyicYVS8zhjDkX84uQKkbfVUwLFJGlg
	xXp5WAOagbXsR+fqpABg8qu+7LueRmyWAXt7d3CxbHlNyosXZu7JTB1KiK3AoGYVuEQkkHTQNeSgO
	u9vjiT8Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rSM9R-000000043nA-26FB;
	Tue, 23 Jan 2024 19:09:37 +0000
Date: Tue, 23 Jan 2024 19:09:37 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kees Cook <keescook@chromium.org>, Gary Guo <gary@garyguo.net>,
	Dave Chinner <dchinner@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Ariel Miculas <amiculas@cisco.com>,
	Paul McKenney <paulmck@kernel.org>
Subject: Re: [LSF/MM TOPIC] Rust
Message-ID: <ZbAO8REoMbxWjozR@casper.infradead.org>
References: <wjtuw2m3ojn7m6gx2ozyqtvlsetzwxv5hdhg2hocal3gyou3ue@34e37oox4d5m>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wjtuw2m3ojn7m6gx2ozyqtvlsetzwxv5hdhg2hocal3gyou3ue@34e37oox4d5m>

On Mon, Jan 22, 2024 at 11:23:51PM -0500, Kent Overstreet wrote:
> There's been ongoing work on safe Rust interfaces to the VFS, as well as
> whole new filesystems in Rust (tarfs, puzzlefs), and talk of adding Rust
> code for existing filesystems (bcachefs, any day now, I swear).

I really want this to happen.  It's taken 50 years, but we finally have
a programming language that can replace C for writing kernels.

> Possible subtopics:
>  - Braces, brackets and arrow signs: does Rust have enough of them, too
>    many, or both?

Um.  Maybe we should limit ourselves to productive discussions
that will affect the MM/filesystems/storage/bpf subsystems?
While it's entertaining to read about Rust-as-it-might-have-been
https://graydon2.dreamwidth.org/307291.html I quickly get lost in trying
to learn the last three decades of language design to understand all
the points being made.

>  - Obeying the borrow checker: C programmers are widely renouned for
>    creative idiosyncrasies in pointer based data structures; structure
>    design; will we be able to fully express our creativity within Rust?
>    Or are there VFS abstractions and lifetime rules that will be
>    difficult to translate?
> 
>  - Perhaps there are annoying VFS rules that in the past required hand
>    tattoos to remember, but we'll now be able to teach the compiler to
>    remember for us?
> 
>    (idmapping comes to mind as one area where we've recently been able
>    to increase safety through effective use of the type system - this is
>    about way more than just use-after-free bugs)
> 
>  - Moving objects around in memory: Rust rather dislikes being told
>    objects can't be moved around (a consequence of algebraic data
>    types), and this has been a source of no small amount of frustration
>    on the Rust side of things. Could we on the C side perhaps find ways
>    to relax their constraints? (object pinning, versus e.g. perhaps
>    making it possible to move a list head around)

Death To List Heads!  They're the perfect data structure for a 1995
era CPU.  They leave 90% of your CPUs performance on the table if you
bought your CPU in the last five years.  If list heads make rust sad,
then that's just one more reason to abolish them.

>  - The use of outside library code: Historically, C code was either
>    written for userspace or the kernel, and not both. But that's not
>    particularly true in Rust land (and getting to be less true even in C
>    land); should we consider some sort of structure or (cough) package
>    management? Is it time to move beyond ye olde cut-and-paste?

Rust has a package manager.  I don't think we need kCargo.  I'm not
deep enough in the weeds on this to make sensible suggestions, but if
a package (eg a crypto suite or compression library) doesn't depend on
anything ridiculous then what's the harm in just pulling it in?

> The Rust-for-Linux people have been great - let's see if we can get them
> to join us in Utah this year, I think they'll have things to teach us.

It's definitely a two-way conversation.  There's too much for any one
person to know, so teaching each other what "we" need "them" to know
is a great thing.  I hear some people are considering pitching sessions
like "What filesystem people get wrong about MM", "The pagecache doesn't
work the way you think it does" and "Why directio and the pagecache are
mortal enemies".  And I'm in favour of those kinds of sessions (as long
as I don't end up leading five sessions again ...).

