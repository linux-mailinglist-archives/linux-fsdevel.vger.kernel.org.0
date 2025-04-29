Return-Path: <linux-fsdevel+bounces-47573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B505AA0853
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 12:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 009A03AD93C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 10:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7302BEC3E;
	Tue, 29 Apr 2025 10:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uEPmOZ5H";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MWAXJuoI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uEPmOZ5H";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MWAXJuoI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30A521ABC2
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Apr 2025 10:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745921960; cv=none; b=d5zn4iKuIkE7igqr3I0RRv9QmfyH9/rQZbO1Eu5tbA9ISKkeCZ/3KxDMbE8yg3ruX9N8sUmIHReUrSe+3ZhMS2ZJBLcVlG8qcEizURqFeDs2V2xINmvPkrejfGsZ8aDsdOF6cHu1Ql8BqYx7DWrBZb6c5cJPOcgWcs6kvRPQEZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745921960; c=relaxed/simple;
	bh=4QzkBVmmHsWN4OZnWCSRRaBIew+nm1KtZg3/1hqRiVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bryRfINd1tdmBSMAke0PrW0W0yrIhgdhlF/SAHsQ7kq7/TSxJjGpZtHwS8H9CBZZKzUgwM4QHHnfE8BkmFG/SUiB76mnuht3/GURVyEd+ZDmJfOc8RdlJLxNOFKb8U7QSp9/e63haY6q1xAwNlaDAtT0HxRj5s9xJk+nPzeisfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uEPmOZ5H; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MWAXJuoI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uEPmOZ5H; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MWAXJuoI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 166DC1F391;
	Tue, 29 Apr 2025 10:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745921956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FojJjMlWLIACBAIrNYwWPoVZQRrjQQxZ7P50XQnrvLM=;
	b=uEPmOZ5HSLeDXHB+/QLxg4hkLqdEVZhQm34yN2cqvajNTyMftZUcLfUcOOz0hopKEAFG1E
	J/0I4C7WvMcCVGzQGcgps1eVUpnflFRtembc0UofYWdHrPkMfw5aTRWJT/JIxvdMFV16Yc
	pw5oAtu65gWZSdDGoYjFOtfFTxP51SU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745921956;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FojJjMlWLIACBAIrNYwWPoVZQRrjQQxZ7P50XQnrvLM=;
	b=MWAXJuoI9N+y0T6Vas3sAOy2gxu3Wyd/APynkhGhk8aoCcBmAdgQVRzaCxn8TEzy8sqCB1
	gxmYnnOo8dWgMEDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745921956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FojJjMlWLIACBAIrNYwWPoVZQRrjQQxZ7P50XQnrvLM=;
	b=uEPmOZ5HSLeDXHB+/QLxg4hkLqdEVZhQm34yN2cqvajNTyMftZUcLfUcOOz0hopKEAFG1E
	J/0I4C7WvMcCVGzQGcgps1eVUpnflFRtembc0UofYWdHrPkMfw5aTRWJT/JIxvdMFV16Yc
	pw5oAtu65gWZSdDGoYjFOtfFTxP51SU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745921956;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FojJjMlWLIACBAIrNYwWPoVZQRrjQQxZ7P50XQnrvLM=;
	b=MWAXJuoI9N+y0T6Vas3sAOy2gxu3Wyd/APynkhGhk8aoCcBmAdgQVRzaCxn8TEzy8sqCB1
	gxmYnnOo8dWgMEDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0989313931;
	Tue, 29 Apr 2025 10:19:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EnpPAqSnEGihKwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 29 Apr 2025 10:19:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B2221A0952; Tue, 29 Apr 2025 12:19:15 +0200 (CEST)
Date: Tue, 29 Apr 2025 12:19:15 +0200
From: Jan Kara <jack@suse.cz>
To: Joe Damato <jdamato@fastly.com>
Cc: Carlos Llamas <cmllamas@google.com>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	Alexander Duyck <alexander.h.duyck@intel.com>, open list <linux-kernel@vger.kernel.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, William McVicker <willmcvicker@google.com>
Subject: Re: [PATCH vfs/vfs.fixes v2] eventpoll: Set epoll timeout if it's in
 the future
Message-ID: <zvkvenkysbzves2qzknju5pmaws322r3lugzbstv6kuxcbw23k@mtddhwfxj3ce>
References: <20250416185826.26375-1-jdamato@fastly.com>
 <20250426-haben-redeverbot-0b58878ac722@brauner>
 <ernjemvwu6ro2ca3xlra5t752opxif6pkxpjuegt24komexsr6@47sjqcygzako>
 <aA-xutxtw3jd00Bz@LQ3V64L9R2>
 <aBAB_4gQ6O_haAjp@google.com>
 <aBAEDdvoazY6UGbS@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBAEDdvoazY6UGbS@LQ3V64L9R2>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 28-04-25 15:41:17, Joe Damato wrote:
> On Mon, Apr 28, 2025 at 10:32:31PM +0000, Carlos Llamas wrote:
> > On Mon, Apr 28, 2025 at 09:50:02AM -0700, Joe Damato wrote:
> > > Thank you for spotting that and sorry for the trouble.
> > 
> > This was also flagged by our Android's epoll_pwait2 tests here:
> > https://android.googlesource.com/platform/bionic/+/refs/heads/main/tests/sys_epoll_test.cpp
> > They would all timeout, so the hang reported by Christian fits.
> > 
> > 
> > > Christian / Jan what would be the correct way for me to deal with
> > > this? Would it be to post a v3 (re-submitting the patch in its
> > > entirety) or to post a new patch that fixes the original and lists
> > > the commit sha from vfs.fixes with a Fixes tag ?
> > 
> > The original commit has landed in mainline already, so it needs to be
> > new patch at this point. If if helps, here is the tag:
> > Fixes: 0a65bc27bd64 ("eventpoll: Set epoll timeout if it's in the future")
> > 
> > > diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> > > index 4bc264b854c4..1a5d1147f082 100644
> > > --- a/fs/eventpoll.c
> > > +++ b/fs/eventpoll.c
> > > @@ -2111,7 +2111,9 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
> > > 
> > >                 write_unlock_irq(&ep->lock);
> > > 
> > > -               if (!eavail && ep_schedule_timeout(to))
> > > +               if (!ep_schedule_timeout(to))
> > > +                       timed_out = 1;
> > > +               else if (!eavail)
> > >                         timed_out = !schedule_hrtimeout_range(to, slack,
> > >                                                               HRTIMER_MODE_ABS);
> > >                 __set_current_state(TASK_RUNNING);
> > 
> > I've ran your change through our internal CI and I confirm it fixes the
> > hangs seen on our end. If you send the fix feel free to add:
> > 
> > Tested-by: Carlos Llamas <cmllamas@google.com>
> 
> Thanks, will do.
> 
> I was waiting to hear back from Christian / Jan if they are OK with
> the proposed fix before submitting something, but glad to hear it
> fixes the issue for you. Sorry for the trouble.

Yep, a new patch submission with proper Fixes tag is needed at this point.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

