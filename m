Return-Path: <linux-fsdevel+bounces-33885-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB75B9C029C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 11:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B8751F216CF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 10:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCA91EF0B7;
	Thu,  7 Nov 2024 10:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gw5BR0QY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EN8wG4xV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Gw5BR0QY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EN8wG4xV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBB61EE013;
	Thu,  7 Nov 2024 10:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730976084; cv=none; b=gKysDL+KI7nY4rbc0hIO16m0cbV2yqZCFZBIF+dD7vcx92RKLI7+FwRhPYyaSzjSuwiTueTP0WVqmMHTyVl9AfnEvgEHs+at1yw5qlltataBGZs29hncnsqkful9+e+aHxyR8QSJgkmiHEMZ+d/rwoAw8zai5EWkx14DqeOU9ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730976084; c=relaxed/simple;
	bh=AsVkfe5Chsmh6onjrcoBInU9o9BRtSV25rfkSVW7YTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZbX3rBUGeNQa4Q1Nxe+36CJyTdLCUw2vCs12B9/2Kex5JZgATzzXjy1wTEYTHqNXJVSfKJPWaQSfmHuI6BNWc7yM153NFWI0mXGOsRw4FxMJRvloTMlpMQ6P50OkaDm8ryOP4PnSB7juq+fH08yPIB3106XBmP5Y9keWEXh8OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gw5BR0QY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EN8wG4xV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Gw5BR0QY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EN8wG4xV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3663B1FF83;
	Thu,  7 Nov 2024 10:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730976081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KN1HJ3pdDGlNL2Ga+abDI/XhyPCloSZdGhb/Xe0Xrv0=;
	b=Gw5BR0QYe9EW5/pn1SRTd3balD1AVZR41NCgpRhXmzOgQf6yl3JgnZ+ufR9WlisypZQRAS
	3CRpgXHBnkU7bS/n4qIckSXsGlV7snTYSWy4jP49em7YF+OV9tNtQx2vBfo+ZAzoD2YEbp
	+oNPOYgmvx+CzMrXjq0kiXDPIv+PqYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730976081;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KN1HJ3pdDGlNL2Ga+abDI/XhyPCloSZdGhb/Xe0Xrv0=;
	b=EN8wG4xVJh7TRuBekLlTqYNP97AjFZUBq8FxghPFV9bhlDRsmDUXYblkyxM1okorTysf63
	KA5ZNadTllGkk7Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730976081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KN1HJ3pdDGlNL2Ga+abDI/XhyPCloSZdGhb/Xe0Xrv0=;
	b=Gw5BR0QYe9EW5/pn1SRTd3balD1AVZR41NCgpRhXmzOgQf6yl3JgnZ+ufR9WlisypZQRAS
	3CRpgXHBnkU7bS/n4qIckSXsGlV7snTYSWy4jP49em7YF+OV9tNtQx2vBfo+ZAzoD2YEbp
	+oNPOYgmvx+CzMrXjq0kiXDPIv+PqYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730976081;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KN1HJ3pdDGlNL2Ga+abDI/XhyPCloSZdGhb/Xe0Xrv0=;
	b=EN8wG4xVJh7TRuBekLlTqYNP97AjFZUBq8FxghPFV9bhlDRsmDUXYblkyxM1okorTysf63
	KA5ZNadTllGkk7Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2969F1394A;
	Thu,  7 Nov 2024 10:41:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HucWClGZLGdqDgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 07 Nov 2024 10:41:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D2527A0AF4; Thu,  7 Nov 2024 11:41:20 +0100 (CET)
Date: Thu, 7 Nov 2024 11:41:20 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Song Liu <songliubraving@meta.com>, Jeff Layton <jlayton@kernel.org>,
	Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Kernel Team <kernel-team@meta.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	"repnop@google.com" <repnop@google.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [RFC bpf-next fanotify 2/5] samples/fanotify: Add a sample
 fanotify fastpath handler
Message-ID: <20241107104120.64er6wj3n7gcibld@quack3>
References: <20241029231244.2834368-1-song@kernel.org>
 <20241029231244.2834368-3-song@kernel.org>
 <5b8318018dd316f618eea059f610579a205c05db.camel@kernel.org>
 <D21DC5F6-A63A-4D94-A73D-408F640FD075@fb.com>
 <22c12708ceadcdc3f1a5c9cc9f6a540797463311.camel@kernel.org>
 <2602F1B5-6B73-4F8F-ADF5-E6DE9EAD4744@fb.com>
 <CAOQ4uxjyN-Sr4mV8EjhAJ9rvx4k4sSRSEFLF08RnT1ijvm2Y-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjyN-Sr4mV8EjhAJ9rvx4k4sSRSEFLF08RnT1ijvm2Y-g@mail.gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[meta.com,kernel.org,vger.kernel.org,gmail.com,iogearbox.net,linux.dev,zeniv.linux.org.uk,suse.cz,google.com,toxicpanda.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 06-11-24 20:40:50, Amir Goldstein wrote:
> On Thu, Oct 31, 2024 at 2:52 AM Song Liu <songliubraving@meta.com> wrote:
> > > Alternately, maybe there is some way to designate that an entire
> > > vfsmount is a child of a watched (or ignored) directory?
> > >
> > >> @Christian, I would like to know your thoughts on this (walking up the
> > >> directory tree in fanotify fastpath handler). It can be expensive for
> > >> very very deep subtree.
> > >>
> > >
> > > I'm not Christian, but I'll make the case for it. It's basically a
> > > bunch of pointer chasing. That's probably not "cheap", but if you can
> > > do it under RCU it might not be too awful. It might still suck with
> > > really deep paths, but this is a sample module. It's not expected that
> > > everyone will want to use it anyway.
> >
> > Thanks for the suggestion! I will try to do it under RCU.
> >
> 
> That's the cost of doing a subtree filter.
> Not sure how it could be avoided?

Yes. For a real solution (not this example), we'd probably have to limit
the parent walk to say 16 steps and if we can reach neither root nor our
dir in that number of steps, we'll just chicken out and pass the event to
userspace to deal with it. This way the kernel filter will deal with most
cases anyway and we won't risk livelocking or too big performance overhead
of the filter.

For this example, I think using fs/dcache.c:is_subdir() will be OK for
demonstration purposes.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

