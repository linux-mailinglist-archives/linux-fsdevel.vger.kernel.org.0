Return-Path: <linux-fsdevel+bounces-40467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F34FCA23970
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 06:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C9111889CE9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 05:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3335146D6A;
	Fri, 31 Jan 2025 05:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="HAMe/ln+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39AA819;
	Fri, 31 Jan 2025 05:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738302990; cv=none; b=MqWh8K9PllwdbyVeRDISS18HVz/wftV6LrQVUg7OyZaQTWZ7mKAiE90DpNQuop08PlfytbjOHV6r2Ch199iijtu4++mL7JlZ/SqmxZqFiaNBWXkBlp4X5ATrT+/HOKWLMo97Mcsf05nhGic0DHzq5pOu0QOmQS3nRqnl9sjAwS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738302990; c=relaxed/simple;
	bh=r00FRpJjzWBP7EYAZesRXkjGtKa/7vSsn2owKD+Oxn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAYFPACAHXbuEQi1150eTCmlDl1mMdkAaPZbrqlR48UTcKwf0SkY6/cEJkVg0try8XCE+fnkmZh1G9NtwaDOyKjP1HgoIL6Luqmw+uUmexzJDsJN4eTd0fh1YZJwk86WdvOnq85zyVAavsEhV6AN2Q36a4gNL/tUt6VxDzTvAfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=HAMe/ln+; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=I/5Gxht1LmYuOme3EAnZYzqy/1eU0bnMxD4WHKQW5WQ=; b=HAMe/ln+MLWxRzKh5IrSYVOudj
	0VJnOWcOXOMrZZpD08rIF3uoDb7xrH+4gNtoymYFSaUgXmN08aDIvLumO0UDCwQdMEIY9gaL/5/1Z
	h1e5Qolls5dPYVbHeuLPHio/xPAltOOO7MKLJ/HdytgyErkPFhoTnqZE57m2w2PDgZgh2VdL/WNvT
	bf3sW8R03kQtsifsYPIEu7EfOgKKk3KzxXXpoT/ED3npZKFpVZJloNi1smNt/jkNIajhyM9eXWHLo
	4ybcdmiOzJVfAnTgwRUK09geTuU13fPP5PcobFpAiCxNT34YXBvnLruMuwKn7X2mjfO8aYCs7+JI+
	7r+5cvJg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tdk0v-0000000GgzS-3I7f;
	Fri, 31 Jan 2025 05:56:25 +0000
Date: Fri, 31 Jan 2025 05:56:25 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [git pull] d_revalidate pile (v2)
Message-ID: <20250131055625.GV1977892@ZenIV>
References: <Z5fAOpnFoXMgpCWb@lappy>
 <20250127173634.GF1977892@ZenIV>
 <Z5fyAPnvtNPPF5L3@lappy>
 <20250127213456.GH1977892@ZenIV>
 <20250127224059.GI1977892@ZenIV>
 <Z5gWQnUDMyE5sniC@lappy>
 <20250128002659.GJ1977892@ZenIV>
 <20250128003155.GK1977892@ZenIV>
 <20250130043707.GT1977892@ZenIV>
 <CAHk-=wjKkZBM6w+Kc+nufJVdnBzzXwPiNdzWieN3c7dEq9bMaQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjKkZBM6w+Kc+nufJVdnBzzXwPiNdzWieN3c7dEq9bMaQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jan 30, 2025 at 09:24:34AM -0800, Linus Torvalds wrote:
> On Wed, 29 Jan 2025 at 20:37, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > ->d_revalidate() series, along with ->d_iname preliminary work.
> > One trivial conflict in fs/afs/dir.c - afs_do_lookup_one() has lost
> > one argument in mainline and switched another from dentry to qstr
> > in this series.
> 
> Actually, I had a conflict in fs/fuse/dir.c, and it was less trivial.
> 
> The d_revalidate() change means that the stable name passed in might
> come from the path lookup, which means that it isn't NUL-terminated.
> 
> So the code that did
> 
>         args->in_numargs = 1;
>         args->in_args[0].size = name->len + 1;
>         args->in_args[0].value = name->name;
> 
> in fuse_lookup_init() is no longer valid for revalidate, and  instead
> you made it do the NUL termination as the next arg:
> 
>         args->in_numargs = 2;
>         args->in_args[0].size = name->len;
>         args->in_args[0].value = name->name;
>         args->in_args[1].size = 1;
>         args->in_args[1].value = "";
> 
> Fine, no problem. Except it clashes with commit 7ccd86ba3a48 ("fuse:
> make args->in_args[0] to be always the header"), which made in_args[0]
> be that empty case, and moved in_args[0] up to be arg[1].
> 
> So my resolution continues on that, and ends up with three in_args, like this:
> 
>         args->in_numargs = 3;
>         fuse_set_zero_arg0(args);
>         args->in_args[1].size = name->len;
>         args->in_args[1].value = name->name;
>         args->in_args[2].size = 1;
>         args->in_args[2].value = "";

*nod*

My apologies - that did show up in -next (obviously), with the same
resolution you went for, everyone nodded and agreed that it was obviously
the right fix.  Should've mentioned that when updating pull request
message (that wasn't an issue in the first variant, since that had
been prior to fuse merge).  Sorry about missing that...

