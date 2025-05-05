Return-Path: <linux-fsdevel+bounces-48048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91569AA9129
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 12:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F156816AEDE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 10:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87BA1C1AB4;
	Mon,  5 May 2025 10:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v/cRW/Pz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vd9D7VuE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pleN2Uah";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tmLFl7MU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EC92BAF8
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 May 2025 10:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746441042; cv=none; b=K7wK6jNWu+vX7RyMyGp7m87CrTmZwsJ1xvSed6ql6GxMwyfmyIR+7YNR3r34ImeKxp1PFVZZ9zYn8YYfQI/x/R9yKbgjy5sbtlaQR3eiIApMcFp3zmSyKE35o4TqJ8Wnb3AlZuOcgmRYqmryqfot1xu+QrQNTXLXDRbN5/bZlHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746441042; c=relaxed/simple;
	bh=ct62KMfLxIMi8zKKGRA1TL3a8bH4QhRTXMBnPfC4En0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odV+6EKSSkFFUhQMcqdbVFVjoL8gPQvotOUHnPLTnhAOP+qa8JAgSayGoLNAKCfVZSreWPgqQptCdoyuAey+w7xRchzWyLe3UksD+XWkkyKZipY3LhmQLEoT42aMeMUD8l+nY1iY7tvTRVCljplc6/0JsvjTAfIGBhoCvIkIi6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v/cRW/Pz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vd9D7VuE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pleN2Uah; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tmLFl7MU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DCF4D216E7;
	Mon,  5 May 2025 10:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746441039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Tcwj14g30hkYsi6niOV2gAdBchyaDqHDd0TogTWuaM=;
	b=v/cRW/Pzqbl1M4+mkziznOrzIIKi2ngqS797S6hr+miUrEnf6R2lISJv0R1CtGD6g2RyGw
	mMYM+7eBeGiUkwHv05Wvy39SWiLV2Er50Yoe6l8By/Y3al+yA46Pj49Ao62ee3AVGB7Gp3
	yrKXx0/D5e3Gqnv3iIXSw2a8YqtNnWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746441039;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Tcwj14g30hkYsi6niOV2gAdBchyaDqHDd0TogTWuaM=;
	b=vd9D7VuEBSyldtRZ37n/+/bUPYzwnFqjBSq6bL0Eh4GvpiKn+qlaslGIahQzZjHTOBV+rf
	b/4aQzW/KgDWKdBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746441038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Tcwj14g30hkYsi6niOV2gAdBchyaDqHDd0TogTWuaM=;
	b=pleN2UahRxzAymDtuZIZ4OfgZ+nHzK++f/D9qtFcQ1uJZ8ThBvuGLf+zjbsDV8nQlqiHfQ
	lDMdSoTIJ1gu8VgB9yp1s7G07Lq0h14xHZ3A4vx8idYwj4zQ1ImFEeg7yaG8fIHjbjb4XA
	zMbmhOQxTs0THMfQ6BIfgU7/MTWnVbM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746441038;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Tcwj14g30hkYsi6niOV2gAdBchyaDqHDd0TogTWuaM=;
	b=tmLFl7MUirAtiOJtQmiztp36ZGYdCgX5ebK4p5IIydJwJ76NvdNO0MnSH5gil5p49+aAe8
	ZstIhgXkcYLpPZCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D227513883;
	Mon,  5 May 2025 10:30:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WNNIM06TGGiKfgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 05 May 2025 10:30:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8F655A0670; Mon,  5 May 2025 12:30:38 +0200 (CEST)
Date: Mon, 5 May 2025 12:30:38 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFF] realpathat system call
Message-ID: <xq5cgpnzgcrglzvtcn23qfykekvkgpfuochcjbroyi6ya22yic@sigdivujq3dp>
References: <CAGudoHFULfaG4h-46GG2cJG9BDCKX0YoPEpQCpgefpaSBYk4hw@mail.gmail.com>
 <idlhgryyp4336ybkmtjdxotb5agos3h44vkp2p7cg6dvc2uefg@no4dm6c6vyzd>
 <CAGudoHE6kBTWa9Pqs5Dnc4JF4Oijc--eg+aXCkmcgm0o13Gt4Q@mail.gmail.com>
 <CAGudoHHHVG7sX+ukMNc8feRkE+YrWknmCWjQ95W1xkYkSycwrQ@mail.gmail.com>
 <CAGudoHGAdTVVv-K7tOgLyPE2K=qG4VaZU=qrAaieqcO_sNn6+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHGAdTVVv-K7tOgLyPE2K=qG4VaZU=qrAaieqcO_sNn6+A@mail.gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 02-05-25 20:28:13, Mateusz Guzik wrote:
> On Fri, May 2, 2025 at 8:01 PM Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > On Fri, May 2, 2025 at 7:35 PM Mateusz Guzik <mjguzik@gmail.com> wrote:
> > >
> > > On Fri, May 2, 2025 at 2:34 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > On Wed 30-04-25 22:50:23, Mateusz Guzik wrote:
> > > > > Before I explain why the system call and how, I'm noting a significant
> > > > > limitation upfront: in my proposal the system call is allowed to fail
> > > > > with EAGAIN. It's not inherent, but I think it's the sane thing to do.
> > > > > Why I think that's sensible and why it does not defeat the point is
> > > > > explained later.
> > > > >
> > > > > Why the system call: realpath(3) is issued a lot for example by gcc
> > > > > (mostly for header files). libc implements it as a series of
> > > > > readlinks(!) and it unsurprisingly looks atrocious:
> > > > > [pid 1096382] readlink("/usr", 0x7fffbac84f90, 1023) = -1 EINVAL
> > > > > (Invalid argument)
> > > > > [pid 1096382] readlink("/usr/local", 0x7fffbac84f90, 1023) = -1 EINVAL
> > > > > (Invalid argument)
> > > > > [pid 1096382] readlink("/usr/local/include", 0x7fffbac84f90, 1023) =
> > > > > -1 EINVAL (Invalid argument)
> > > > > [pid 1096382] readlink("/usr/local/include/bits", 0x7fffbac84f90,
> > > > > 1023) = -1 ENOENT (No such file or directory)
> > > > > [pid 1096382] readlink("/usr", 0x7fffbac84f90, 1023) = -1 EINVAL
> > > > > (Invalid argument)
> > > > > [pid 1096382] readlink("/usr/include", 0x7fffbac84f90, 1023) = -1
> > > > > EINVAL (Invalid argument)
> > > > > [pid 1096382] readlink("/usr/include/x86_64-linux-gnu",
> > > > > 0x7fffbac84f90, 1023) = -1 EINVAL (Invalid argument)
> > > > > [pid 1096382] readlink("/usr/include/x86_64-linux-gnu/bits",
> > > > > 0x7fffbac84f90, 1023) = -1 EINVAL (Invalid argument)
> > > > > [pid 1096382] readlink("/usr/include/x86_64-linux-gnu/bits/types",
> > > > > 0x7fffbac84f90, 1023) = -1 EINVAL (Invalid argument)
> > > > > [pid 1096382] readlink("/usr/include/x86_64-linux-gnu/bits/types/FILE.h",
> > > > > 0x7fffbac84f90, 1023) = -1 EINVAL (Invalid argument)
> > > > >
> > > > > and so on. This converts one path lookup to N (by path component). Not
> > > > > only that's terrible single-threaded, you may also notice all these
> > > > > lookups bounce lockref-containing cachelines for every path component
> > > > > in face of gccs running at the same time (and highly parallel
> > > > > compilations are not rare, are they).
> > > > >
> > > > > One way to approach this is to construct the new path on the fly. The
> > > > > problem with that is that it would require some rototoiling and more
> > > > > importantly is highly error prone (notably due to symlinks). This is
> > > > > the bit I'm trying to avoid.
> > > > >
> > > > > A very pleasant way out is to instead walk the path forward, then
> > > > > backward on the found dentry et voila -- all the complexity is handled
> > > > > for you. There is however a catch: no forward progress guarantee.
> > > >
> > > > So AFAIU what you describe here is doing a path lookup and then calling
> > > > d_path() on the result - actually prepend_path() as I'm glancing in your
> > > > POC code.
> > > >
> > >
> > > Ye that's the gist.
> > >
> > > > > rename seqlock is needed to guarantee correctness, otherwise if
> > > > > someone renamed a dir as you were resolving the path forward, by the
> > > > > time you walk it backwards you may get a path which would not be
> > > > > accessible to you -- a result which is not possible with userspace
> > > > > realpath.
> > > >
> > > > In presence of filesystem mutations paths are always unreliable, aren't
> > > > they? I mean even with userspace realpath() implementation the moment the
> > > > function call is returning the path the filesystem can be modified so that
> > > > the path stops being valid. With kernel it is the same. So I don't see any
> > > > strong reason to bother with handling parallel filesystem modifications.
> > > > But maybe I'm missing some practically important case...
> > > >
> > >
> > > The concern is not that the result is stale, but that it was not
> > > legitimately obtainable at any point by the caller doing the current
> > > realpath walk.
> > >
> > > Consider the following tree:
> > > /foo/file
> > > /bar
> > >
> > > where foo is 755, bar is 700 and both are owned by root, while the
> > > user issuing realpath has some other uid
> > >
> > > if root renames /foo/file to /bar/file while racing against realpath
> > > /foo/file, there is a time window where the user will find the dentry
> > > and by the time they d_path the result is /bar/file. but they never
> > > would get /bar/file with the current implementation.
> > >
> >
> > That said, if this is considered fine, the entire thing turns a
> > trivial patch for sure.
> >
> 
> To elaborate,  the result is not obtainable in two ways, one of which
> has a security angle to it.
> 
> Let's grab the tree again:
> /foo/file
> /bar
> 
> except both foo and bar are 755
> 
> with userspace realpath the following results are possible when racing
> against rename /foo/file /bar/file:
> - success, the path is returned as /foo/file
> - ENOENT
> 
> with kernel realpath not checking for rename ENOENT is off the table,
> instead you get:
> - success, the path is returned as /bar/file
> 
> Suppose that's fine and maybe even considered an improvement.
> 
> Now consider a case where bar is 700 and the user issuing realpath
> can't traverse on it.
> 
> The user would *not* get the path even if they realpath /bar/file as
> they don't have perms. You could argue the user does not have the
> rights to know where the file after said rename.

Indeed. In particular if the directory hierarchy is deeper, the user could
learn about things he is never supposed to see. Thanks for explanation.

> So I stand by the need to check rename seq.
> 
> However, I wonder if it would be tolerable to redo the lookup with the
> *new* path and check if we got the same dentry at the end. If so, we
> know the path was obtainable by traversal.

I agree that if following path lookup will succeed, it should be safe to
give out the path. But there's one more corner case - suppose you look up

/foo/file

while racing with rename /bar/file /foo/file. With userspace implementation
you're always going to get /foo/file as rename is atomic wrt other dir
operations. With the kernel implementation, you may call prepend_path() on
already deleted dentry with obvious results...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

