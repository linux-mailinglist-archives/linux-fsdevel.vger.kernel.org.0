Return-Path: <linux-fsdevel+bounces-73229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 73840D12AD4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 14:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2EB04300A364
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 13:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B3A347BB5;
	Mon, 12 Jan 2026 13:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KfQxrRlk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8cpFpgzW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KfQxrRlk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8cpFpgzW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C08E194A6C
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 13:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768223190; cv=none; b=CfRMiJZU+IlD5pt+qeLy40lff04bci510p+b0Tc70T2pkFKEtMXZ1lyz9mflIIAR7Nu7PKLxByqmNYRhnAoqioqaG7tYh3pfgQKmZZ7DVerHJB6jxtOnQ/3znBuj+ln6oR5yB2Nf0r7+zqy97j1+VAYrrTsgiSKk8q8/dLBctcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768223190; c=relaxed/simple;
	bh=epuMHCuQyIoxOepDGHt+H/u7ItcQ1kvr46bI0q31lfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWuAXuv++UWsbN88G+2idSPIHu/xQjkzmuspr9RA2y9dqzoTZldcnZpGuXW0WHRJpQ4yCZQSCRZ7T2dP58IIR2FFoIDYP86Aqaqta4W2CIHlrUYzhPx5aEa5qk91dn704c4e+pkwl0CMNHD7hcYh99oPA8VdiHnjVMfAYi3hua0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KfQxrRlk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8cpFpgzW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KfQxrRlk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8cpFpgzW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 508C9336AE;
	Mon, 12 Jan 2026 13:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768223187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1O4F1mH7HItPmOqJ627Rc9BGNGj+R0e31g81fuFMM/4=;
	b=KfQxrRlkpaswM4pAu/Suran5vSqEP8Uv5n6UKePya1mXrqas9x7B72WEvUP3HJZ/yaujBD
	K9UcW/PGJ9/0Mdes5qc/0L1K9zOeCHlgSkNvwR1iz6D9JlnKpPrG7I9/TknNtLSw95OmkF
	LqKq2s5iK3+mrXIt1a8U1D4Y94ftszI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768223187;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1O4F1mH7HItPmOqJ627Rc9BGNGj+R0e31g81fuFMM/4=;
	b=8cpFpgzWtTV1uULcC5qhLr5DmVAyZ3iI6B5li9TvXdprn/YaRxcZSDs6Ghltj8llgmSzKi
	9hIDam+YUNmoG+DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768223187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1O4F1mH7HItPmOqJ627Rc9BGNGj+R0e31g81fuFMM/4=;
	b=KfQxrRlkpaswM4pAu/Suran5vSqEP8Uv5n6UKePya1mXrqas9x7B72WEvUP3HJZ/yaujBD
	K9UcW/PGJ9/0Mdes5qc/0L1K9zOeCHlgSkNvwR1iz6D9JlnKpPrG7I9/TknNtLSw95OmkF
	LqKq2s5iK3+mrXIt1a8U1D4Y94ftszI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768223187;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1O4F1mH7HItPmOqJ627Rc9BGNGj+R0e31g81fuFMM/4=;
	b=8cpFpgzWtTV1uULcC5qhLr5DmVAyZ3iI6B5li9TvXdprn/YaRxcZSDs6Ghltj8llgmSzKi
	9hIDam+YUNmoG+DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47FCD3EA63;
	Mon, 12 Jan 2026 13:06:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ncyLEdPxZGmoFAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 12 Jan 2026 13:06:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DF7DFA0A7E; Mon, 12 Jan 2026 14:06:26 +0100 (CET)
Date: Mon, 12 Jan 2026 14:06:26 +0100
From: Jan Kara <jack@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: Bernd Schubert <bernd@bsbernd.com>, Jan Kara <jack@suse.cz>, 
	Joanne Koong <joannelkoong@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"David Hildenbrand (Red Hat)" <david@kernel.org>
Subject: Re: __folio_end_writeback() lockdep issue
Message-ID: <wu7mu22kgr7pmzrneq6rkivhwvpbximyrkouciktl7wf5w7wur@rsyqyczopba2>
References: <9b845a47-9aee-43dd-99bc-1a82bea00442@bsbernd.com>
 <b7b72183-f9e1-4e58-b40f-45a267cc6831@bsbernd.com>
 <aWJ-pHIY8Y8sjLeC@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWJ-pHIY8Y8sjLeC@casper.infradead.org>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[bsbernd.com,suse.cz,gmail.com,szeredi.hu,ddn.com,vger.kernel.org,linux-foundation.org,kvack.org,kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Sat 10-01-26 16:30:28, Matthew Wilcox wrote:
> On Sat, Jan 10, 2026 at 04:31:28PM +0100, Bernd Schubert wrote:
> > [  872.499480]  Possible interrupt unsafe locking scenario:
> > [  872.499480] 
> > [  872.500326]        CPU0                    CPU1
> > [  872.500906]        ----                    ----
> > [  872.501464]   lock(&p->sequence);
> > [  872.501923]                                local_irq_disable();
> > [  872.502615]                                lock(&xa->xa_lock#4);
> > [  872.503327]                                lock(&p->sequence);
> > [  872.504116]   <Interrupt>
> > [  872.504513]     lock(&xa->xa_lock#4);
> > 
> > 
> > Which is introduced by commit 2841808f35ee for all file systems. 
> > The should be rather generic - I shouldn't be the only one seeing
> > it?
> 
> Oh wow, 2841808f35ee has a very confusing commit message.  It implies
> that _no_ filesystem uses BDI_CAP_WRITEBACK_ACCT, but what it really
> means is that no filesystem now _clears_ BDI_CAP_WRITEBACK_ACCT, so
> all filesystems do use this code path and therefore the flag can be
> removed.  And that matches the code change.
> 
> So you should be able to reproduce this problem with commit 494d2f508883
> as well?
> 
> That tells me that this is something fuse-specific.  Other filesystems
> aren't seeing this.  Wonder why ...
> 
> __wb_writeout_add() or its predecessor __wb_writeout_inc() have been in
> that spot since 2015 or earlier.  
> 
> The sequence lock itself is taken inside fprop_new_period() called from
> writeout_period() which has been there since 2012, so that's not it.
> 
> Looking at fprop_new_period() is more interesting.  Commit a91befde3503
> removed an earlier call to local_irq_save().  It was then replaced with
> preempt_disable() in 9458e0a78c45 but maybe removing it was just
> erroneous?
> 
> Anyway, that was 2022, so it doesn't answer "why is this only showing up
> now and only for fuse?"  But maybe replacing the preempt-disable with
> irq-disable in fprop_new_period() is the right solution, regardless.

So I don't have a great explanation why it is showing up only now and only
for FUSE. It seems the fprop code is unsafe wrt interrupts because
fprop_new_period() grabs

        write_seqcount_begin(&p->sequence);

and if IO completion interrupt on this CPU comes while p->sequence is odd,
the call to

	read_seqcount_begin(&p->sequence);

in __folio_end_writeback() -> __wb_writeout_add() -> wb_domain_writeout_add()
-> __fprop_add_percpu_max() -> fprop_fraction_percpu() will loop
indefinitely. *However* this isn't in fact possible because
fprop_new_period() is only called from a timer code and thus in softirq
context and thus IO completion softirq cannot really preempt it.

But for the same reason I don't think what lockdep complains about is
really possible because xa_lock gets only used from IO completion softirq as
well. Or can we really acquire it from some hard irq context? Based on
lockdep report at least lockdep things IO completion runs in hardirq
context but then I don't see why we're not seeing complaints like this all
the time and even deadlocks I've described above. I guess I'll have to do
some experimentation to refresh how these things behave these days...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

