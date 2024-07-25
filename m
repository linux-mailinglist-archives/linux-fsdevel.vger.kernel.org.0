Return-Path: <linux-fsdevel+bounces-24240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DD193C3BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 16:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 450E91C21006
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 14:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA79819CD0B;
	Thu, 25 Jul 2024 14:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NTT59Pjd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ji8CL2AE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="THQcBCEx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XzXUTah8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F80A19B3D7;
	Thu, 25 Jul 2024 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721916506; cv=none; b=Wc00lgcgk2UdmfaC+M6AViMJ584b3Ug6vb9sDSp/PUkGkvOwVKHq3IWynv0GRO6bbXn+yQ6pecpQKDtj0Z8/Qfrfu6LsukzDfjnRel73tN97da25bd3UB5hEBLzPwo9wHz9+ZdF6LT7uUZAf/7BinxN7EGFAnlJ48eaUVyVxtns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721916506; c=relaxed/simple;
	bh=7ZymtsaU2hUseLDSUph0VLd1JbABq1jT63J6bQYrsj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMTReyLk7fAA+yYgGpNlscgfl7BdppVxO2cC09ZD4HgphVO1RTsHdif2PkyHu9AAqSBL3gfvfXOyIkQ/J8utrfi9BVgPyMZlP4S37QPeFdZRXoE3LstcP4F9WnRjmTeYt4cVsUp9KEd7y1MWWAIpdJMWaRFrYRxP7oOmE+OSpdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NTT59Pjd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ji8CL2AE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=THQcBCEx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XzXUTah8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 89A241F45A;
	Thu, 25 Jul 2024 14:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721916502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=caOm/uxS2opXn02vZjb14EARqvFtBFXQYGYYAAi6TfU=;
	b=NTT59Pjd2aG2JZ1FwEAqDsj9joB3aQKjncebjD66Wb3Xt+eQdUoPPQmOP4eV4P2jLg72Sf
	axh/eQah8OMNNolhDdIEcZuj83nxt0jnOMEQRpZ8wywi9KAf3/wEAz4LpU9kDiN1rfaAwo
	m20AFgYDAtlNT6NNiTPU+rMneRyTCsY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721916502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=caOm/uxS2opXn02vZjb14EARqvFtBFXQYGYYAAi6TfU=;
	b=Ji8CL2AE9oLO280RcM2TskMEkxKDf9Q1ksT3hVIhGaEbiuneJjjA4VVWJ2s0d4zrrVA0cc
	lC6thLbZ9TqfetCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721916501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=caOm/uxS2opXn02vZjb14EARqvFtBFXQYGYYAAi6TfU=;
	b=THQcBCExcuvhyE2GtBGUU65zFU+EaPRm/CdRCjV2v2TuCDgLk+k9I1Jj1iTTWOLkKa3qRb
	UMna64jhX436NrbcdoOYQvKDb99ojzYa24xBVHjWuGSknybB7e1xbFHfDT6mWh5Wgn3S0c
	9A6vKzpWjCQPUEn3JZm2fw4aTLz7TZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721916501;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=caOm/uxS2opXn02vZjb14EARqvFtBFXQYGYYAAi6TfU=;
	b=XzXUTah8ueHAu0wQnsuMWRWONZykdlgmzSk9X9Yxbd08rDAOMGuDO/boM3g1ijZVJtp4To
	A/K71S8DVHXVTNAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 745351368A;
	Thu, 25 Jul 2024 14:08:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C7FhHFVcomZZEAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 25 Jul 2024 14:08:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3B312A0996; Thu, 25 Jul 2024 16:08:21 +0200 (CEST)
Date: Thu, 25 Jul 2024 16:08:21 +0200
From: Jan Kara <jack@suse.cz>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-serial <linux-serial@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] tty: tty_io: fix race between tty_fops and
 hung_up_tty_fops
Message-ID: <20240725140821.kfzzn6uh52acwcbm@quack3>
References: <a11e31ab-6ffc-453f-ba6a-b7f6e512c55e@I-love.SAKURA.ne.jp>
 <20240722-gehminuten-fichtenwald-9dd5a7e45bc5@brauner>
 <20240722161041.t6vizbeuxy5kj4kz@quack3>
 <2024072238-reversing-despise-b555@gregkh>
 <e6e7cb33-f359-43bd-959e-039e82c6915a@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6e7cb33-f359-43bd-959e-039e82c6915a@I-love.SAKURA.ne.jp>
X-Spamd-Result: default: False [-3.60 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.60

On Tue 23-07-24 07:20:34, Tetsuo Handa wrote:
> On 2024/07/23 1:24, Greg Kroah-Hartman wrote:
> > On Mon, Jul 22, 2024 at 06:10:41PM +0200, Jan Kara wrote:
> >> On Mon 22-07-24 16:41:22, Christian Brauner wrote:
> >>> On Fri, Jul 19, 2024 at 10:37:47PM GMT, Tetsuo Handa wrote:
> >>>> syzbot is reporting data race between __tty_hangup() and __fput(), and
> >>>> Dmitry Vyukov mentioned that this race has possibility of NULL pointer
> >>>> dereference, for tty_fops implements e.g. splice_read callback whereas
> >>>> hung_up_tty_fops does not.
> >>>>
> >>>>   CPU0                                  CPU1
> >>>>   ----                                  ----
> >>>>   do_splice_read() {
> >>>>                                         __tty_hangup() {
> >>>>     // f_op->splice_read was copy_splice_read
> >>>>     if (unlikely(!in->f_op->splice_read))
> >>>>       return warn_unsupported(in, "read");
> >>>>                                           filp->f_op = &hung_up_tty_fops;
> >>>>     // f_op->splice_read is now NULL
> >>>>     return in->f_op->splice_read(in, ppos, pipe, len, flags);
> >>>>                                         }
> >>>>   }
> >>>>
> >>>> Fix possibility of NULL pointer dereference by implementing missing
> >>>> callbacks, and suppress KCSAN messages by adding __data_racy qualifier
> >>>> to "struct file"->f_op .
> >>>
> >>> This f_op replacing without synchronization seems really iffy imho.
> >>
> >> Yeah, when I saw this I was also going "ouch". I was just waiting whether a
> >> tty maintainer will comment ;)
> > 
> > I really didn't want to :)
> > 
> >> Anyway this replacement of ops in file /
> >> inode has proven problematic in almost every single case where it was used
> >> leading to subtle issues.
> > 
> > Yeah, let's not do this.
> 
> https://lkml.kernel.org/r/18a58415-4aa9-4cba-97d2-b70384407313@I-love.SAKURA.ne.jp was a patch
> that does not replace f_op, and
> https://lkml.kernel.org/r/CAHk-=wgSOa_g+bxjNi+HQpC=6sHK2yKeoW-xOhb0-FVGMTDWjg@mail.gmail.com
> was a comment from Linus.

OK, thanks for references. After doing some light audit of tty, I didn't
find a way how switching f_op could break the system. Still it is giving
me some creeps because usually there's some god-forgotten place somewhere
that caches some decision based on f_op content and when f_op change,
things go out of sync with strange results. And the splice operations
enabled by tty are complex enough to hide some potential problems.

In fact I'm not sure why tty switches f_op at all. The reliable check for
tty being hung up seems to be fetching ldisc pointer under a ldisc_lock and
most operations do this and handle it appropriately -> no need for special
f_op for hung up state for them. .ioctl notably might need some love but
overall it doesn't seem too hard to completely avoid changing f_op for tty.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

