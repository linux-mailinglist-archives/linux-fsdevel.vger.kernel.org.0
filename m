Return-Path: <linux-fsdevel+bounces-66730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71039C2B434
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 12:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29DE13AB3E4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 11:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC1430170F;
	Mon,  3 Nov 2025 11:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="S/u/hx6d";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YQm9FIh2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="S/u/hx6d";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YQm9FIh2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D122F261D
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 11:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762168456; cv=none; b=FD6Upyqj23bgUPGzrS1wmExsfJ8PFPipAdxcELB4UovMtNTplI0xzvuCdThDhg1aczja1U2Y7PhNhDOe5pHWzkfoBzmM/rK5Ne8L9Q3agzunyRuMbjsuJjNjIznxB0wDaTf1mlGhQVD+5/ZL41p6HuVIszaslFhygLOJ/B7/bCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762168456; c=relaxed/simple;
	bh=JMlP5F8/TM9H4KCJbRqrlBkd9WC1GKKCixt0cRIB71g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5Mmvpr0e/hGxpqwc51PD3tIH/rmIBgW8QrBS3FqJj0v1Y62pVAI/PbmZXfJA0/lsHg28qplJR4l3gto9AdDn1X1o0YSHfBhPBx7p403um7SLWT2W8BAoEJKoxV075wf8FsJGWsAg6I+PKMyFod2eHCttTL8u+O2dmUHBPPIvHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=S/u/hx6d; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YQm9FIh2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=S/u/hx6d; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YQm9FIh2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7CE8521DA3;
	Mon,  3 Nov 2025 11:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762168447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kAOKcOngnHrYc/dXomxDPPqmKlLzC5SKPL9i00W6DQg=;
	b=S/u/hx6duGowi/23qtCyS/p4qw46C7LKnrcI2Asj/Ybis80WciRhjeBfqE5buAOyHkGf5M
	Ror43ZfDUEQOfCccPTgPP6D+GLwQkWEYBUn/AIgNG1E4LHUN/DwSY945+yrYyhd6icDWyj
	8kwCRA/J/vop+AloumXfIGJJRbGp7jk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762168447;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kAOKcOngnHrYc/dXomxDPPqmKlLzC5SKPL9i00W6DQg=;
	b=YQm9FIh21ynenPWiUKhSroYW38hcq/8Q6zhL/dSLMXC/g9YLE5ZRE+8RLbs1vgxj9pSvnO
	gDgbHEOXJdqm+aBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762168447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kAOKcOngnHrYc/dXomxDPPqmKlLzC5SKPL9i00W6DQg=;
	b=S/u/hx6duGowi/23qtCyS/p4qw46C7LKnrcI2Asj/Ybis80WciRhjeBfqE5buAOyHkGf5M
	Ror43ZfDUEQOfCccPTgPP6D+GLwQkWEYBUn/AIgNG1E4LHUN/DwSY945+yrYyhd6icDWyj
	8kwCRA/J/vop+AloumXfIGJJRbGp7jk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762168447;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kAOKcOngnHrYc/dXomxDPPqmKlLzC5SKPL9i00W6DQg=;
	b=YQm9FIh21ynenPWiUKhSroYW38hcq/8Q6zhL/dSLMXC/g9YLE5ZRE+8RLbs1vgxj9pSvnO
	gDgbHEOXJdqm+aBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6692F139A9;
	Mon,  3 Nov 2025 11:14:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S0MGGX+OCGm8FAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 03 Nov 2025 11:14:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CDE22A2812; Mon,  3 Nov 2025 12:14:06 +0100 (CET)
Date: Mon, 3 Nov 2025 12:14:06 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Dave Chinner <david@fromorbit.com>, 
	Carlos Maiolino <cem@kernel.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: fall back from direct to buffered I/O when stable writes are
 required
Message-ID: <kpk2od2fuqofdoneqse2l3gvn7wbqx3y4vckmnvl6gc2jcaw4m@hsxqmxshckpj>
References: <20251029071537.1127397-1-hch@lst.de>
 <aQNJ4iQ8vOiBQEW2@dread.disaster.area>
 <20251030143324.GA31550@lst.de>
 <aQPyVtkvTg4W1nyz@dread.disaster.area>
 <20251031130050.GA15719@lst.de>
 <aQTcb-0VtWLx6ghD@kbusch-mbp>
 <20251031164701.GA27481@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031164701.GA27481@lst.de>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Fri 31-10-25 17:47:01, Christoph Hellwig wrote:
> On Fri, Oct 31, 2025 at 09:57:35AM -0600, Keith Busch wrote:
> > Not sure of any official statement to that effect, but storage in
> > general always says the behavior of modifying data concurrently with
> > in-flight operations on that data produces non-deterministic results.
> 
> Yes, it's pretty clear that the result in non-deterministic in what you
> get.  But that result still does not result in corruption, because
> there is a clear boundary ( either the sector size, or for NVMe
> optionally even a larger bodunary) that designates the atomicy boundary.

Well, is that boundary really guaranteed? I mean if you modify the buffer
under IO couldn't it happen that the DMA sees part of the sector new and
part of the sector old? I agree the window is small but I think the real
guarantee is architecture dependent and likely cacheline granularity or
something like that.

> > An
> > application with such behavior sounds like a bug to me as I can't
> > imagine anyone purposefully choosing to persist data with a random
> > outcome. If PI is enabled, I think they'd rather get a deterministic
> > guard check error so they know they did something with undefined
> > behavior.
> 
> As long as your clearly define your transaction boundaries that
> non-atomicy is not a problem per se.
> 
> > It's like having reads and writes to overlapping LBA and/or memory
> > ranges concurrently outstanding. There's no guaranteed result there
> > either; specs just say it's the host's responsibilty to not do that.
> 
> There is no guaranteed result as in an enforced ordering.  But there
> is a pretty clear model that you get either the old or new at a
> well defined boundary.
> 
> > The kernel doesn't stop an application from trying that on raw block
> > direct-io, but I'd say that's an application bug.
> 
> If it corrupts other applications data as in the RAID case it's
> pretty clearly not an application bug.  It's also pretty clear that
> at least some applications (qemu and other VMs) have been doings this
> for 20+ years.

Well, I'm mostly of the opinion that modifying IO buffers in flight is an
application bug (as much as most current storage stacks tolerate it) but on
the other hand returning IO errors later or even corrupting RAID5 on resync
is, in my opinion, not a sane error handling on the kernel side either so I
think we need to do better.

I also think the performance cost of the unconditional bounce buffering is
so heavy that it's just a polite way of pushing the app to do proper IO
buffer synchronization itself (assuming it cares about IO performance but
given it bothered with direct IO it presumably does). 

So the question is how to get out of this mess with the least disruption
possible which IMO also means providing easy way for well-behaved apps to
avoid the overhead.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

