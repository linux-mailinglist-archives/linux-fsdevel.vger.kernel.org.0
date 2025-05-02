Return-Path: <linux-fsdevel+bounces-47912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E05AA722D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 14:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 410DC98118F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 12:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B302B2522A7;
	Fri,  2 May 2025 12:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="glUojonQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hmbaG9yz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="glUojonQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hmbaG9yz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852B0252284
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 May 2025 12:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746189306; cv=none; b=UCGilmSX8Agw2PAoM/xxRNY4j4895ELvOnZw1QrjSk7JefSneg7nW21NPy/vIw2OUq9ZYhUYw+db9DbfQ7NhqrPZtjjr1Wu0ve2pbwtLaAXuiHIJI/QEncZ6tovJ+McMljJFlTJeXREoeYS25rmwGoxuB3+1U69c3n89/z+8raY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746189306; c=relaxed/simple;
	bh=9toq2mWM33oieAxJ23AVg7MVhndjEuWk6KVteNPfBQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3LIUwYTsAcc5VeqN5Z5ocz3CuBln45SYaIbusoc/UHosgof7Ksex+2rTnWO/wSFx3Xz9O2i3UniFG2Eph/POLLN4eCXldc0bfdfq1Gt9sFL13HZzwMrF3JMCI2c0ykOWzgHJDyNxqxQaL6RP5wa0ON0ByOBJQui9lKtOfatetg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=glUojonQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hmbaG9yz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=glUojonQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hmbaG9yz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0D22A219F2;
	Fri,  2 May 2025 12:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746189297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w17CW48Q24WrWib2SSf4Vlpk3F7XhAZYx1Bh6viL9x4=;
	b=glUojonQGHwg18Ss5KhUmR8f6UG9EmFCzSuiZxairIcsjOXnzeASd+j9C4ktxVSSlYf3JG
	YL31RwUTtXRd5CbmKf9vyJMSfHMsu+U+mFHGUwumUqr5Xi5tB7RNjW0DH4BqH0fmgY+cDk
	Ja3GHFPQ3huIGcTXUP678ilPJUugjRE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746189297;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w17CW48Q24WrWib2SSf4Vlpk3F7XhAZYx1Bh6viL9x4=;
	b=hmbaG9yzPqskD1Py0VRLW7ef6fMxeGcXHXSDK5TITpcsWms4y/gZKMdIkRHmxoMoxMKN7r
	30s92c+ZP3e7qaDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746189297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w17CW48Q24WrWib2SSf4Vlpk3F7XhAZYx1Bh6viL9x4=;
	b=glUojonQGHwg18Ss5KhUmR8f6UG9EmFCzSuiZxairIcsjOXnzeASd+j9C4ktxVSSlYf3JG
	YL31RwUTtXRd5CbmKf9vyJMSfHMsu+U+mFHGUwumUqr5Xi5tB7RNjW0DH4BqH0fmgY+cDk
	Ja3GHFPQ3huIGcTXUP678ilPJUugjRE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746189297;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w17CW48Q24WrWib2SSf4Vlpk3F7XhAZYx1Bh6viL9x4=;
	b=hmbaG9yzPqskD1Py0VRLW7ef6fMxeGcXHXSDK5TITpcsWms4y/gZKMdIkRHmxoMoxMKN7r
	30s92c+ZP3e7qaDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE83213687;
	Fri,  2 May 2025 12:34:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gRHeOfC7FGhaDAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 02 May 2025 12:34:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9961FA0921; Fri,  2 May 2025 14:34:56 +0200 (CEST)
Date: Fri, 2 May 2025 14:34:56 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFF] realpathat system call
Message-ID: <idlhgryyp4336ybkmtjdxotb5agos3h44vkp2p7cg6dvc2uefg@no4dm6c6vyzd>
References: <CAGudoHFULfaG4h-46GG2cJG9BDCKX0YoPEpQCpgefpaSBYk4hw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHFULfaG4h-46GG2cJG9BDCKX0YoPEpQCpgefpaSBYk4hw@mail.gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Wed 30-04-25 22:50:23, Mateusz Guzik wrote:
> Before I explain why the system call and how, I'm noting a significant
> limitation upfront: in my proposal the system call is allowed to fail
> with EAGAIN. It's not inherent, but I think it's the sane thing to do.
> Why I think that's sensible and why it does not defeat the point is
> explained later.
> 
> Why the system call: realpath(3) is issued a lot for example by gcc
> (mostly for header files). libc implements it as a series of
> readlinks(!) and it unsurprisingly looks atrocious:
> [pid 1096382] readlink("/usr", 0x7fffbac84f90, 1023) = -1 EINVAL
> (Invalid argument)
> [pid 1096382] readlink("/usr/local", 0x7fffbac84f90, 1023) = -1 EINVAL
> (Invalid argument)
> [pid 1096382] readlink("/usr/local/include", 0x7fffbac84f90, 1023) =
> -1 EINVAL (Invalid argument)
> [pid 1096382] readlink("/usr/local/include/bits", 0x7fffbac84f90,
> 1023) = -1 ENOENT (No such file or directory)
> [pid 1096382] readlink("/usr", 0x7fffbac84f90, 1023) = -1 EINVAL
> (Invalid argument)
> [pid 1096382] readlink("/usr/include", 0x7fffbac84f90, 1023) = -1
> EINVAL (Invalid argument)
> [pid 1096382] readlink("/usr/include/x86_64-linux-gnu",
> 0x7fffbac84f90, 1023) = -1 EINVAL (Invalid argument)
> [pid 1096382] readlink("/usr/include/x86_64-linux-gnu/bits",
> 0x7fffbac84f90, 1023) = -1 EINVAL (Invalid argument)
> [pid 1096382] readlink("/usr/include/x86_64-linux-gnu/bits/types",
> 0x7fffbac84f90, 1023) = -1 EINVAL (Invalid argument)
> [pid 1096382] readlink("/usr/include/x86_64-linux-gnu/bits/types/FILE.h",
> 0x7fffbac84f90, 1023) = -1 EINVAL (Invalid argument)
> 
> and so on. This converts one path lookup to N (by path component). Not
> only that's terrible single-threaded, you may also notice all these
> lookups bounce lockref-containing cachelines for every path component
> in face of gccs running at the same time (and highly parallel
> compilations are not rare, are they).
> 
> One way to approach this is to construct the new path on the fly. The
> problem with that is that it would require some rototoiling and more
> importantly is highly error prone (notably due to symlinks). This is
> the bit I'm trying to avoid.
> 
> A very pleasant way out is to instead walk the path forward, then
> backward on the found dentry et voila -- all the complexity is handled
> for you. There is however a catch: no forward progress guarantee.

So AFAIU what you describe here is doing a path lookup and then calling
d_path() on the result - actually prepend_path() as I'm glancing in your
POC code.

> rename seqlock is needed to guarantee correctness, otherwise if
> someone renamed a dir as you were resolving the path forward, by the
> time you walk it backwards you may get a path which would not be
> accessible to you -- a result which is not possible with userspace
> realpath.

In presence of filesystem mutations paths are always unreliable, aren't
they? I mean even with userspace realpath() implementation the moment the
function call is returning the path the filesystem can be modified so that
the path stops being valid. With kernel it is the same. So I don't see any
strong reason to bother with handling parallel filesystem modifications.
But maybe I'm missing some practically important case...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

