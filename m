Return-Path: <linux-fsdevel+bounces-28933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E879714E0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 12:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CB9D1C22DA4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 10:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE281B3B2D;
	Mon,  9 Sep 2024 10:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ue9P79P2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OXjmdQI5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xTThav/8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GivMkc87"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA456DF58
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Sep 2024 10:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725876502; cv=none; b=FJg90HqYdWgS1mlY9EqdjN0C3p7dXKQ+f0jFxJ3qQYQ/n3r6fPVdr0Sz22DOjt5fUzTMYVzV38cN4wZeR6ZrsFAEhzW3a5A5ZhvYpbjl1ekbNShRLLUX+mPMuzV8jmPQAMv7Kb3GGD9FYe/bZiMZ90bbf4+o59ZwUcveoL99z9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725876502; c=relaxed/simple;
	bh=yCTArU3ml5f5r9vMXRMafKcJ1dn9ePBTwo6XrjCDZm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQlF2Y06pGz7gPYwzQ3GIBsngbA+kI+cNGF+m4R4KM7ZKcGJSZBVdKxSoes6sAjm4WwTJ71/VjXhHPrG3/1lCBXtTS07GAkkiDEg9zSJCQBCycII6N34Cay2rASb3G2jbiU8oSE+IFfbAB14uMOpjN8NoCGNqobSu92LCIIpo4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ue9P79P2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OXjmdQI5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xTThav/8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GivMkc87; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D410D21BD9;
	Mon,  9 Sep 2024 10:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725876499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O3K+BFd4zjfgpN/ukG9C8+bvJEV4MQC8Anvb5g6Cf/Q=;
	b=ue9P79P2MnenMfRNdbGTUFHMT0YGzWFfQSkpYGm6OIoBgWjgi9Pd2VBBJHouEI7MtuANan
	4dqYyNi3a+bEjQ+gC4P1AvAnOfW9Mwv6Cu/c/NiHVqPU2n8GQoiqKqRbusAv7w1wFuTepN
	ciUh7kAXChR7lJm5HLMc7PMstJFWZKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725876499;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O3K+BFd4zjfgpN/ukG9C8+bvJEV4MQC8Anvb5g6Cf/Q=;
	b=OXjmdQI5bCwFz3AkpXs5/IdqVzL4DCfnZDNYPg7ajB3dODSQwpMISPlSBCvBlCJViXIOLM
	pPorNFZ7EutGHfBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="xTThav/8";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GivMkc87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725876498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O3K+BFd4zjfgpN/ukG9C8+bvJEV4MQC8Anvb5g6Cf/Q=;
	b=xTThav/8aLK6afl+DoIrCMNIcMUChf8wFo1EeTz3RDQud+ezI9ao7zMxQxEv9JL/RZulzi
	Aty0lCuwXD1DCm9334C/t1D6qW4o+YiUxE+bbaxGxsgMZFeXMPMSaiwU0Ap1Bm2I55Paq6
	wygEjBjab1BlYbZC82b+Mu4kZbMADHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725876498;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O3K+BFd4zjfgpN/ukG9C8+bvJEV4MQC8Anvb5g6Cf/Q=;
	b=GivMkc87ceM/pWvA/ZyulCY/c/xXyB89OTtsyF44aNvhnOGUvhJ+/PoqibY8QEZY1Jhq0+
	FZaWiYY8KnzJYpAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4E6E13312;
	Mon,  9 Sep 2024 10:08:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id j18QMBLJ3mZhEQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 09 Sep 2024 10:08:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4C6C2A095F; Mon,  9 Sep 2024 12:08:14 +0200 (CEST)
Date: Mon, 9 Sep 2024 12:08:14 +0200
From: Jan Kara <jack@suse.cz>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org
Subject: Re: [PATCH] vfs: return -EOVERFLOW in generic_remap_checks() when
 overflow check fails
Message-ID: <20240909100814.dvaokmefiaoovpiu@quack3>
References: <20240906033202.1252195-1-sunjunchao2870@gmail.com>
 <20240906102942.egowavntfx6t3z6t@quack3>
 <d6ddc03e3aa86af60b13e9ebb81548b18fe6d74c.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d6ddc03e3aa86af60b13e9ebb81548b18fe6d74c.camel@gmail.com>
X-Rspamd-Queue-Id: D410D21BD9
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 06-09-24 19:12:08, Julian Sun wrote:
> On Fri, 2024-09-06 at 12:29 +0200, Jan Kara wrote:
> 
> Sure, I will include this patch in the patch set for the next version. 
> But I think it maybe deserves a separate patch, rather than being 
> integrated into the original patch?

Yes, probably a separate patch makes sense.

								Honza

> 
> > On Fri 06-09-24 11:32:02, Julian Sun wrote:
> > > Keep it consistent with the handling of the same check within
> > > generic_copy_file_checks().
> > > Also, returning -EOVERFLOW in this case is more appropriate.
> > > 
> > > Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> > 
> > Well, you were already changing this condition here [1] so maybe just
> > update the errno in that patch as well? No need to generate unnecessary
> > patch conflicts...
> > 
> > [1] https://lore.kernel.org/all/20240905121545.ma6zdnswn5s72byb@quack3
> > 
> >                                                                 Honza
> > 
> > > ---
> > >  fs/remap_range.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/remap_range.c b/fs/remap_range.c
> > > index 28246dfc8485..97171f2191aa 100644
> > > --- a/fs/remap_range.c
> > > +++ b/fs/remap_range.c
> > > @@ -46,7 +46,7 @@ static int generic_remap_checks(struct file *file_in, loff_t pos_in,
> > >  
> > >         /* Ensure offsets don't wrap. */
> > >         if (pos_in + count < pos_in || pos_out + count < pos_out)
> > > -               return -EINVAL;
> > > +               return -EOVERFLOW;
> > >  
> > >         size_in = i_size_read(inode_in);
> > >         size_out = i_size_read(inode_out);
> > > -- 
> > > 2.39.2
> > > 
> 
> Thanks,
> -- 
> Julian Sun <sunjunchao2870@gmail.com>
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

