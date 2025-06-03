Return-Path: <linux-fsdevel+bounces-50519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE27ACCEB8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 23:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABEFD163AC1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 21:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399112248A6;
	Tue,  3 Jun 2025 21:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MZib4A3W";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VbktXhK5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MZib4A3W";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VbktXhK5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD69D224247
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 21:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748985209; cv=none; b=nmTvshgD3PvMqStw9C308sUlCfjE9DakjpTTXPWOBiSLW6tLNU8DN7y/UB9apeLU4G1RwrSAJYT3CZYgWEr2r3YMQ5U523b+uCogfPmQYwQkxoSSeXCdp0kCIUrTUrFnWKzTj5bYAAtrfKbQWs9r11Y8NZKJky0PnIZos+tjDZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748985209; c=relaxed/simple;
	bh=56CnIO38JA9FR6C8fkfLYnjVHQy114Hq381qdfserSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMHvw6Kk7PgdT9nsH6axjpCqYskZDV7+lXS4t60vTW7cj6RVKxsHGWmczVHOqk3EiWOfkZdmtEiWQjMOVQEO14HZks7M/paI3h6nvk4CzyW2qEtGdK36r9J3DUTv/6BoFrx+hUjb81Z9be8ATr6nUda6Qroev7ZOxdN3dQ2v8WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MZib4A3W; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VbktXhK5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MZib4A3W; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VbktXhK5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B67531F443;
	Tue,  3 Jun 2025 21:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748985205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nMp5F2i64TgnwrxwOwToMGnKAHG72K+/VQOBRSB9EGs=;
	b=MZib4A3WP4o/O56JpIBAdlFZ4Bq7le3ftDXE0PSpWTZsKWYED18U9CNNGY8y7P5S6CForx
	4J2rPtFUR30wU2LunJgVr6nZJYoQ7vdI0AsZs+wnieCYRS4P11OGAXwNyhGHDZsP7Lpci2
	3YjzPub65b9JhZuu996QCsyC6TzopBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748985205;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nMp5F2i64TgnwrxwOwToMGnKAHG72K+/VQOBRSB9EGs=;
	b=VbktXhK5SK/ViiRkLAanmMa4DDS8Fzlkt0rgQKf+GJ3y8T4crILU354KWyqtsGWg0VPCX9
	4EGT1zw8aO3TZDAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MZib4A3W;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VbktXhK5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748985205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nMp5F2i64TgnwrxwOwToMGnKAHG72K+/VQOBRSB9EGs=;
	b=MZib4A3WP4o/O56JpIBAdlFZ4Bq7le3ftDXE0PSpWTZsKWYED18U9CNNGY8y7P5S6CForx
	4J2rPtFUR30wU2LunJgVr6nZJYoQ7vdI0AsZs+wnieCYRS4P11OGAXwNyhGHDZsP7Lpci2
	3YjzPub65b9JhZuu996QCsyC6TzopBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748985205;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nMp5F2i64TgnwrxwOwToMGnKAHG72K+/VQOBRSB9EGs=;
	b=VbktXhK5SK/ViiRkLAanmMa4DDS8Fzlkt0rgQKf+GJ3y8T4crILU354KWyqtsGWg0VPCX9
	4EGT1zw8aO3TZDAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EC3F13A1D;
	Tue,  3 Jun 2025 21:13:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qgB/JnVlP2hIHwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Jun 2025 21:13:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 456DAA08DD; Tue,  3 Jun 2025 23:13:25 +0200 (CEST)
Date: Tue, 3 Jun 2025 23:13:25 +0200
From: Jan Kara <jack@suse.cz>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Jan Kara <jack@suse.cz>, Song Liu <song@kernel.org>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Christian Brauner <brauner@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Amir Goldstein <amir73il@gmail.com>, repnop@google.com, 
	Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: Introduce path iterator
Message-ID: <fcl5ay76nlftwcqetzxduwlkesmmoyofctnpca5otqecee3bf4@w6hv3lxcwscq>
References: <20250528222623.1373000-1-song@kernel.org>
 <20250528222623.1373000-4-song@kernel.org>
 <20250528223724.GE2023217@ZenIV>
 <yti2dilasy7b3tu6iin5pugkn6oevdswrwoy6gorudb7x2cqhh@nqb3gcyxg4by>
 <CAPhsuW4tg+bXU41fhAaS0n74d_a_KCFGvy_vkQOj7v4VLie2wg@mail.gmail.com>
 <CAADnVQ+UGsvfAM8-E8Ft3neFkz4+TjE=rPbP1sw1m5_4H9BPNg@mail.gmail.com>
 <CAPhsuW78L8WUkKz8iJ1whrZ2gLJR+7Kh59eFrSXvrxP0DwMGig@mail.gmail.com>
 <20250530.oh5pahH9Nui9@digikod.net>
 <vumjuw5ha6jtxtadsr5vwjtuneeqfg3vpydciczsn75qdg2ekv@464a4dxtxx27>
 <20250603.be1ahteePh8z@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250603.be1ahteePh8z@digikod.net>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	FREEMAIL_CC(0.00)[suse.cz,kernel.org,gmail.com,zeniv.linux.org.uk,vger.kernel.org,meta.com,iogearbox.net,linux.dev,google.com,toxicpanda.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B67531F443
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -2.51

On Tue 03-06-25 14:49:09, Mickaël Salaün wrote:
> On Tue, Jun 03, 2025 at 11:46:22AM +0200, Jan Kara wrote:
> > On Fri 30-05-25 16:20:39, Mickaël Salaün wrote:
> > > On Thu, May 29, 2025 at 10:05:59AM -0700, Song Liu wrote:
> > > > On Thu, May 29, 2025 at 9:57 AM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > [...]
> > > > > >
> > > > > > How about we describe this as:
> > > > > >
> > > > > > Introduce a path iterator, which safely (no crash) walks a struct path.
> > > > > > Without malicious parallel modifications, the walk is guaranteed to
> > > > > > terminate. The sequence of dentries maybe surprising in presence
> > > > > > of parallel directory or mount tree modifications and the iteration may
> > > > > > not ever finish in face of parallel malicious directory tree manipulations.
> > > > >
> > > > > Hold on. If it's really the case then is the landlock susceptible
> > > > > to this type of attack already ?
> > > > > landlock may infinitely loop in the kernel ?
> > > > 
> > > > I think this only happens if the attacker can modify the mount or
> > > > directory tree as fast as the walk, which is probably impossible
> > > > in reality.
> > > 
> > > Yes, so this is not an infinite loop but an infinite race between the
> > > kernel and a very fast malicious user space process with an infinite
> > > number of available nested writable directories, that would also require
> > > a filesystem (and a kernel) supporting infinite pathname length.
> > 
> > Well, you definitely don't need infinite pathname length. Example:
> > 
> > Have a dir hierarchy like:
> > 
> >   A
> >  / \
> > B   C
> > |
> > D
> > 
> > Start iterating from A/B/D, you climb up to A/B. In parallel atacker does:
> > 
> > mv A/B/ A/C/; mkdir A/B
> > 
> > Now by following parent you get to A/C. In parallel attaker does:
> > 
> > mv A/C/ A/B/; mkdir A/C
> > 
> > And now you are essentially where you've started so this can repeat
> > forever.
> 
> Yes, this is the scenario I had in mind talking about "infinite race"
> (instead of infinite loop).  For this to work it will require the
> filesystem to support an infinite number of nested directories, but I'm
> not sure which FS could be eligible.

Well, most filesystems don't limit depth of a directory hierarchy in any
particular way. The depth is limited only by available disk space.

> Anyway, what would would be the threat model for this infinite race?

These kinds of problems can usually lead to DoS. That's not too serious
problem as local users with write fs access can cause smaller or larger
troubles to the system anyway but it can be rather unpleasant e.g. for
container hosting systems if you can force e.g. container management tools
to spend attacker-controlled time in the kernel just because Landlock or
the eBPF "security solution" ends up crawling path in attacker controlled
part of filesystem.

> > As others wrote this particular timing might be hard enough to hit for it
> > to not be a practical attack but I would not bet much on somebody not being
> > able to invent some variant that works, in particular with BPF iterator.
> 
> There might exist corner cases that could be an issue but would the
> impact be different than with other kinds of path walk?

Well, a standard path lookup is limited by the length of the path (and
symlink recursion limit). Things like common parent lookup during rename
acquire locks to block parallel directory tree modifications so similar
attacks are impossible there. It is only the "walk from some dentry to the
root without holding any locks" pattern that has these kind of unbounded
looping issues.

> What could we do to avoid or limit such issue?

That's a tough question. You can hold rename_lock which blocks all
directory renames. This obviously makes the walk-to-the-root safe against
any "rename" attacks but it is a system wide lock with all the obvious
scalability implications. So I don't think that's really feasible. You
could also limit the number of steps in your pathwalk and return error if
it gets exceeded. I believe that would be a more practical solution.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

