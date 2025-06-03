Return-Path: <linux-fsdevel+bounces-50438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECBCACC37C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 11:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30FDE1893529
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 09:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924B52882C2;
	Tue,  3 Jun 2025 09:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vfJ11Vcv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EdrsGWdo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vfJ11Vcv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EdrsGWdo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF33287506
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 09:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748943991; cv=none; b=SBHYsc5yKdoe83S+1POZTGMPf45m1ypImvo0hIIHRpc4QLFEa3rCEmOYCnahxIwcM/1Kbw/znGlXiOpYmcAHrJLQbfK999VNrzHY+skFKrEkyaDM8bJrR+T0sP5YRi8WqCiJ2f+V+HST9tvcn2uJlGakfwEQLu57xoBtgLjVxTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748943991; c=relaxed/simple;
	bh=hfsUb86ujRf+ShwgSQXb0UcIkrqAV6maD581wcZj0Kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h76I3smKQA/W2DGioUMVCYf679D/zNYFOBnz7gVgct9mi1oQoFJuud3fJvkbBxhquYbqz/X8NlLCUdj8TCYEEPwveRxs2BUyV/AvCMFb1fAF5hlS/RX+l3vzN8JTdFjB6vEUH3rpgCaVCGs/LvnRjzHV3zffGiaGoQMR+aBPwzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vfJ11Vcv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EdrsGWdo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vfJ11Vcv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EdrsGWdo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1EDFB218D6;
	Tue,  3 Jun 2025 09:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748943987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8NMcdzlNx3C6x3AzJjjDWk/TvaFCiwWRANaj0JTW0wM=;
	b=vfJ11Vcv4ehGI9fGHmeQenIn7s/QuwmG2yb2o4Sjf1fhmsRCpK56gijJAXVkMFvuXOJO1z
	VElS5BnGg1y4zY9xJc/2do+HLGeAUHo/Xb2nmcV4Q2zmLyee0VxwrwFfWuPGsifmvat9df
	dhSrMRSGTCgJ3M2N9e+czGkjGxKkPkQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748943987;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8NMcdzlNx3C6x3AzJjjDWk/TvaFCiwWRANaj0JTW0wM=;
	b=EdrsGWdopIPNC6+RaFzOoUEo/h5ZH3QBqFl4D2Mzt7HQQB3/zqWUnXl6ZWjVZigbTCd40i
	ojRVNZN9fJ91UiBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vfJ11Vcv;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EdrsGWdo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748943987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8NMcdzlNx3C6x3AzJjjDWk/TvaFCiwWRANaj0JTW0wM=;
	b=vfJ11Vcv4ehGI9fGHmeQenIn7s/QuwmG2yb2o4Sjf1fhmsRCpK56gijJAXVkMFvuXOJO1z
	VElS5BnGg1y4zY9xJc/2do+HLGeAUHo/Xb2nmcV4Q2zmLyee0VxwrwFfWuPGsifmvat9df
	dhSrMRSGTCgJ3M2N9e+czGkjGxKkPkQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748943987;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8NMcdzlNx3C6x3AzJjjDWk/TvaFCiwWRANaj0JTW0wM=;
	b=EdrsGWdopIPNC6+RaFzOoUEo/h5ZH3QBqFl4D2Mzt7HQQB3/zqWUnXl6ZWjVZigbTCd40i
	ojRVNZN9fJ91UiBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1223F13A92;
	Tue,  3 Jun 2025 09:46:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wxdnBHPEPmiqQgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Jun 2025 09:46:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BCC67A08DD; Tue,  3 Jun 2025 11:46:22 +0200 (CEST)
Date: Tue, 3 Jun 2025 11:46:22 +0200
From: Jan Kara <jack@suse.cz>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Song Liu <song@kernel.org>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, 
	bpf <bpf@vger.kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Christian Brauner <brauner@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Amir Goldstein <amir73il@gmail.com>, repnop@google.com, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: [PATCH bpf-next 3/4] bpf: Introduce path iterator
Message-ID: <vumjuw5ha6jtxtadsr5vwjtuneeqfg3vpydciczsn75qdg2ekv@464a4dxtxx27>
References: <20250528222623.1373000-1-song@kernel.org>
 <20250528222623.1373000-4-song@kernel.org>
 <20250528223724.GE2023217@ZenIV>
 <yti2dilasy7b3tu6iin5pugkn6oevdswrwoy6gorudb7x2cqhh@nqb3gcyxg4by>
 <CAPhsuW4tg+bXU41fhAaS0n74d_a_KCFGvy_vkQOj7v4VLie2wg@mail.gmail.com>
 <CAADnVQ+UGsvfAM8-E8Ft3neFkz4+TjE=rPbP1sw1m5_4H9BPNg@mail.gmail.com>
 <CAPhsuW78L8WUkKz8iJ1whrZ2gLJR+7Kh59eFrSXvrxP0DwMGig@mail.gmail.com>
 <20250530.oh5pahH9Nui9@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250530.oh5pahH9Nui9@digikod.net>
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,suse.cz,zeniv.linux.org.uk,vger.kernel.org,meta.com,iogearbox.net,linux.dev,google.com,toxicpanda.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 1EDFB218D6
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -2.51

On Fri 30-05-25 16:20:39, Mickaël Salaün wrote:
> On Thu, May 29, 2025 at 10:05:59AM -0700, Song Liu wrote:
> > On Thu, May 29, 2025 at 9:57 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > [...]
> > > >
> > > > How about we describe this as:
> > > >
> > > > Introduce a path iterator, which safely (no crash) walks a struct path.
> > > > Without malicious parallel modifications, the walk is guaranteed to
> > > > terminate. The sequence of dentries maybe surprising in presence
> > > > of parallel directory or mount tree modifications and the iteration may
> > > > not ever finish in face of parallel malicious directory tree manipulations.
> > >
> > > Hold on. If it's really the case then is the landlock susceptible
> > > to this type of attack already ?
> > > landlock may infinitely loop in the kernel ?
> > 
> > I think this only happens if the attacker can modify the mount or
> > directory tree as fast as the walk, which is probably impossible
> > in reality.
> 
> Yes, so this is not an infinite loop but an infinite race between the
> kernel and a very fast malicious user space process with an infinite
> number of available nested writable directories, that would also require
> a filesystem (and a kernel) supporting infinite pathname length.

Well, you definitely don't need infinite pathname length. Example:

Have a dir hierarchy like:

  A
 / \
B   C
|
D

Start iterating from A/B/D, you climb up to A/B. In parallel atacker does:

mv A/B/ A/C/; mkdir A/B

Now by following parent you get to A/C. In parallel attaker does:

mv A/C/ A/B/; mkdir A/C

And now you are essentially where you've started so this can repeat
forever.

As others wrote this particular timing might be hard enough to hit for it
to not be a practical attack but I would not bet much on somebody not being
able to invent some variant that works, in particular with BPF iterator.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

