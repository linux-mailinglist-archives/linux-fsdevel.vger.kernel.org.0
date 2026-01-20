Return-Path: <linux-fsdevel+bounces-74671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4INwJgymb2lDEgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 16:58:04 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFE046E44
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 16:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B3FB8783E56
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 14:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7036942EEC9;
	Tue, 20 Jan 2026 14:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fzTmFh6U";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0uyNt8Te";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fzTmFh6U";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0uyNt8Te"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB55359F9F
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 14:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768919742; cv=none; b=dZ0PFxoofeJayocpCgKXOD2WmQlCqdr3L7nNpVjbiMh43Eem1rW1RDNTdRj12PZz5XML9hQ6zYLtk5lOV/lGYr40IAku0Gl73IbsnUSkotZFHrswZifRaLP9IifuWFj2GEt05z8vK6NJvzMcirTpdv5BtUHczEt7eY/d5WvffAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768919742; c=relaxed/simple;
	bh=vPSCa9zKkDF4Ki+sDaiGCzizc0zVUYasXylacrHHjHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9ViBDzu90Pj1+5R5Vjre8juaVgKWeFFCargCm8qQGkoVG+hHCrsmo4ZZXGbAptYeuAytQULqDUQZeBGN4GJwLixi70PtSSRr+zzI+sx/8QECra3CPEHj9SR2yRcxROR53EGcORNjU7qUxGR7DUbcTL2C8JPpgztGBcWEBg6e1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fzTmFh6U; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0uyNt8Te; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fzTmFh6U; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0uyNt8Te; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6708A5BCCD;
	Tue, 20 Jan 2026 14:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768919738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dr07aLXDVCjM7i/UybL6ay/mRo+PckVKNWM0IK2ZlRk=;
	b=fzTmFh6UPmm1R2MPTU/2h5WoDP5GcRIbztOJ37Wf0G2Ho7SS5T6lRdqZkFyQmcxULesV4C
	dytHCyddQBpjDhgRwUhhD4N0WRbT2zJlEhSN5tgbUbt/wVfejG1RjB1bvc0duo7t/o8JBO
	pJwPb8f1ZVR9gajrVhGnvBk46JEwxlk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768919738;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dr07aLXDVCjM7i/UybL6ay/mRo+PckVKNWM0IK2ZlRk=;
	b=0uyNt8Tewmtk1dT9/EczhE/wUA5iTwOeidApiLlYykzMTfAVxyEXD2CR4kG8tH62pZ5353
	iL/Jig2ZSyQATfAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768919738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dr07aLXDVCjM7i/UybL6ay/mRo+PckVKNWM0IK2ZlRk=;
	b=fzTmFh6UPmm1R2MPTU/2h5WoDP5GcRIbztOJ37Wf0G2Ho7SS5T6lRdqZkFyQmcxULesV4C
	dytHCyddQBpjDhgRwUhhD4N0WRbT2zJlEhSN5tgbUbt/wVfejG1RjB1bvc0duo7t/o8JBO
	pJwPb8f1ZVR9gajrVhGnvBk46JEwxlk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768919738;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dr07aLXDVCjM7i/UybL6ay/mRo+PckVKNWM0IK2ZlRk=;
	b=0uyNt8Tewmtk1dT9/EczhE/wUA5iTwOeidApiLlYykzMTfAVxyEXD2CR4kG8tH62pZ5353
	iL/Jig2ZSyQATfAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEEF13EA63;
	Tue, 20 Jan 2026 14:35:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 79qaLrmSb2mcZgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 20 Jan 2026 14:35:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 68DD6A09DA; Tue, 20 Jan 2026 15:35:33 +0100 (CET)
Date: Tue, 20 Jan 2026 15:35:33 +0100
From: Jan Kara <jack@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: Bernd Schubert <bernd@bsbernd.com>, Jan Kara <jack@suse.cz>, 
	Joanne Koong <joannelkoong@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"David Hildenbrand (Red Hat)" <david@kernel.org>
Subject: Re: __folio_end_writeback() lockdep issue
Message-ID: <4sn6k56c7g3jwvzze4imc4pilmomekvcelo7zo2awjqxsifaqe@djs5p2l55q64>
References: <9b845a47-9aee-43dd-99bc-1a82bea00442@bsbernd.com>
 <b7b72183-f9e1-4e58-b40f-45a267cc6831@bsbernd.com>
 <aWJ-pHIY8Y8sjLeC@casper.infradead.org>
 <wu7mu22kgr7pmzrneq6rkivhwvpbximyrkouciktl7wf5w7wur@rsyqyczopba2>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wu7mu22kgr7pmzrneq6rkivhwvpbximyrkouciktl7wf5w7wur@rsyqyczopba2>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74671-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,suse.com:email,suse.cz:dkim];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[bsbernd.com,suse.cz,gmail.com,szeredi.hu,ddn.com,vger.kernel.org,linux-foundation.org,kvack.org,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3FFE046E44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon 12-01-26 14:06:26, Jan Kara wrote:
> On Sat 10-01-26 16:30:28, Matthew Wilcox wrote:
> > On Sat, Jan 10, 2026 at 04:31:28PM +0100, Bernd Schubert wrote:
> > > [  872.499480]  Possible interrupt unsafe locking scenario:
> > > [  872.499480] 
> > > [  872.500326]        CPU0                    CPU1
> > > [  872.500906]        ----                    ----
> > > [  872.501464]   lock(&p->sequence);
> > > [  872.501923]                                local_irq_disable();
> > > [  872.502615]                                lock(&xa->xa_lock#4);
> > > [  872.503327]                                lock(&p->sequence);
> > > [  872.504116]   <Interrupt>
> > > [  872.504513]     lock(&xa->xa_lock#4);
> > > 
> > > 
> > > Which is introduced by commit 2841808f35ee for all file systems. 
> > > The should be rather generic - I shouldn't be the only one seeing
> > > it?
> > 
> > Oh wow, 2841808f35ee has a very confusing commit message.  It implies
> > that _no_ filesystem uses BDI_CAP_WRITEBACK_ACCT, but what it really
> > means is that no filesystem now _clears_ BDI_CAP_WRITEBACK_ACCT, so
> > all filesystems do use this code path and therefore the flag can be
> > removed.  And that matches the code change.
> > 
> > So you should be able to reproduce this problem with commit 494d2f508883
> > as well?
> > 
> > That tells me that this is something fuse-specific.  Other filesystems
> > aren't seeing this.  Wonder why ...
> > 
> > __wb_writeout_add() or its predecessor __wb_writeout_inc() have been in
> > that spot since 2015 or earlier.  
> > 
> > The sequence lock itself is taken inside fprop_new_period() called from
> > writeout_period() which has been there since 2012, so that's not it.
> > 
> > Looking at fprop_new_period() is more interesting.  Commit a91befde3503
> > removed an earlier call to local_irq_save().  It was then replaced with
> > preempt_disable() in 9458e0a78c45 but maybe removing it was just
> > erroneous?
> > 
> > Anyway, that was 2022, so it doesn't answer "why is this only showing up
> > now and only for fuse?"  But maybe replacing the preempt-disable with
> > irq-disable in fprop_new_period() is the right solution, regardless.
> 
> So I don't have a great explanation why it is showing up only now and only
> for FUSE. It seems the fprop code is unsafe wrt interrupts because
> fprop_new_period() grabs
> 
>         write_seqcount_begin(&p->sequence);
> 
> and if IO completion interrupt on this CPU comes while p->sequence is odd,
> the call to
> 
> 	read_seqcount_begin(&p->sequence);
> 
> in __folio_end_writeback() -> __wb_writeout_add() -> wb_domain_writeout_add()
> -> __fprop_add_percpu_max() -> fprop_fraction_percpu() will loop
> indefinitely. *However* this isn't in fact possible because
> fprop_new_period() is only called from a timer code and thus in softirq
> context and thus IO completion softirq cannot really preempt it.
> 
> But for the same reason I don't think what lockdep complains about is
> really possible because xa_lock gets only used from IO completion softirq as
> well. Or can we really acquire it from some hard irq context? Based on
> lockdep report at least lockdep things IO completion runs in hardirq
> context but then I don't see why we're not seeing complaints like this all
> the time and even deadlocks I've described above. I guess I'll have to do
> some experimentation to refresh how these things behave these days...

So I've got to experiment with this some more. It appears that my
recollection of block layer IO completion code is about decade old and
these days bio completion routines (and thus __folio_end_writeback()) are
getting called in hardirq context in most cases (verified this with ftrace).
Hence the flexible proportions code is indeed prone to deadlocks with
hardirqs. I'm just wondering why aren't we seeing much more lockdep reports
about this and possibly also real deadlocks... Anyway, I'll send a patch to
make fprop_new_period() irq safe.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

