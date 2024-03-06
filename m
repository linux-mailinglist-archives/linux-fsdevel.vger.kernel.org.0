Return-Path: <linux-fsdevel+bounces-13777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 830AA873DBA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 18:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE155B214BD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 17:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DB413BAF4;
	Wed,  6 Mar 2024 17:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oax/lHL/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DfNYFxl8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oax/lHL/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DfNYFxl8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58775D48F
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 17:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709747356; cv=none; b=uU0M/X5Q+3UJQBAXa4unzA80DdiTRAotggPFRtLfGWZehmte/hPj+UubFhgmFgBDS86GaEJVjyypxO+tivyToaWQ4ahpk14H57yVEQwiKXIzrGcWPvMAxEG71Cki0YmGPNf9V8Sn75SNcQfw/Yl8PmN2RxCI8aXiQWwABNU11ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709747356; c=relaxed/simple;
	bh=ToK2knRGaq75ZPZf+5Z+gs8t+rfuxQXY2RhK8qk8Z0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xf3T7aW7Na36qdjyQk7iygkWHDNogjGJZ90bqV4SrXXblm0VNTDQvN9iLzv90VJFyMYCMC6YIy9B4aH40Bsr2C93SthPbORub4pQkSiBEMEA0jaa/PvHwYopDsQBK3A92sTABqj6S1+x8Gk3Rl6WneUFbkikRgRgZVwFTBLaLO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oax/lHL/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DfNYFxl8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oax/lHL/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DfNYFxl8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A3E5F6BFD9;
	Wed,  6 Mar 2024 17:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709747351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+oXczKlYhHQ/MFSnDcd2diifrqwyuyOM97WAFf7FGrM=;
	b=oax/lHL/wBW3jXtysMMrdGhw9ab4FpTlXdH+KCbwD+O7h9+dUcp6Gpl6WmzwZswk1RHoq3
	uMF3VXCE+kD3jveYOxjqrOL9A8YbdiLxols2I2uxMWmLzy8xjaIvsf8i6a8CPT6Ng8llLK
	181onmNGU/PwyAgKvBjuIcWQH25uAsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709747351;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+oXczKlYhHQ/MFSnDcd2diifrqwyuyOM97WAFf7FGrM=;
	b=DfNYFxl8HmnB7OewaIuvt1MT+T1GiV4lxl1aeIpk4jgzqxKb4vK+Ci+MLzOuRs4bQOcOsj
	HM9rwJVt191iY9CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709747351; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+oXczKlYhHQ/MFSnDcd2diifrqwyuyOM97WAFf7FGrM=;
	b=oax/lHL/wBW3jXtysMMrdGhw9ab4FpTlXdH+KCbwD+O7h9+dUcp6Gpl6WmzwZswk1RHoq3
	uMF3VXCE+kD3jveYOxjqrOL9A8YbdiLxols2I2uxMWmLzy8xjaIvsf8i6a8CPT6Ng8llLK
	181onmNGU/PwyAgKvBjuIcWQH25uAsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709747351;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+oXczKlYhHQ/MFSnDcd2diifrqwyuyOM97WAFf7FGrM=;
	b=DfNYFxl8HmnB7OewaIuvt1MT+T1GiV4lxl1aeIpk4jgzqxKb4vK+Ci+MLzOuRs4bQOcOsj
	HM9rwJVt191iY9CQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9981713A79;
	Wed,  6 Mar 2024 17:49:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 3YJzJZes6GWhGwAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 06 Mar 2024 17:49:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 39419A0803; Wed,  6 Mar 2024 18:49:11 +0100 (CET)
Date: Wed, 6 Mar 2024 18:49:11 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>, Hugh Dickins <hughd@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] tmpfs: don't interrupt fallocate with EINTR
Message-ID: <20240306174911.ixwy2kto33cfjueq@quack3>
References: <ef5c3b-fcd0-db5c-8d4-eeae79e62267@redhat.com>
 <20240305-abgas-tierzucht-1c60219b7839@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240305-abgas-tierzucht-1c60219b7839@brauner>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="oax/lHL/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DfNYFxl8
X-Spamd-Result: default: False [-2.27 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 R_MIXED_CHARSET(0.54)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A3E5F6BFD9
X-Spam-Level: 
X-Spam-Score: -2.27
X-Spam-Flag: NO

Hello,

On Tue 05-03-24 09:42:27, Christian Brauner wrote:
> On Mon, Mar 04, 2024 at 07:43:39PM +0100, Mikulas Patocka wrote:
> > I have a program that sets up a periodic timer with 10ms interval. When
> > the program attempts to call fallocate on tmpfs, it goes into an infinite
> > loop. fallocate takes longer than 10ms, so it gets interrupted by a
> > signal and it returns EINTR. On EINTR, the fallocate call is restarted,
> > going into the same loop again.
> > 
> > fallocate(19, FALLOC_FL_KEEP_SIZE, 0, 206057565) = -1 EINTR (Přerušené volání systému)
> > --- SIGALRM {si_signo=SIGALRM, si_code=SI_TIMER, si_timerid=0, si_overrun=0, si_int=0, si_ptr=NULL} ---
> > sigreturn({mask=[]})                    = -1 EINTR (Přerušené volání systému)
> > fallocate(19, FALLOC_FL_KEEP_SIZE, 0, 206057565) = -1 EINTR (Přerušené volání systému)
> > --- SIGALRM {si_signo=SIGALRM, si_code=SI_TIMER, si_timerid=0, si_overrun=0, si_int=0, si_ptr=NULL} ---
> > sigreturn({mask=[]})                    = -1 EINTR (Přerušené volání systému)
> > fallocate(19, FALLOC_FL_KEEP_SIZE, 0, 206057565) = -1 EINTR (Přerušené volání systému)
> > --- SIGALRM {si_signo=SIGALRM, si_code=SI_TIMER, si_timerid=0, si_overrun=0, si_int=0, si_ptr=NULL} ---
> > sigreturn({mask=[]})                    = -1 EINTR (Přerušené volání systému)
> > fallocate(19, FALLOC_FL_KEEP_SIZE, 0, 206057565) = -1 EINTR (Přerušené volání systému)
> > --- SIGALRM {si_signo=SIGALRM, si_code=SI_TIMER, si_timerid=0, si_overrun=0, si_int=0, si_ptr=NULL} ---
> > sigreturn({mask=[]})                    = -1 EINTR (Přerušené volání systému)
> > 
> > Should there be fatal_signal_pending instead of signal_pending in the
> > shmem_fallocate loop?
> > 
> > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > 
> > ---
> >  mm/shmem.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Index: linux-2.6/mm/shmem.c
> > ===================================================================
> > --- linux-2.6.orig/mm/shmem.c	2024-01-18 19:18:31.000000000 +0100
> > +++ linux-2.6/mm/shmem.c	2024-03-04 19:05:25.000000000 +0100
> > @@ -3143,7 +3143,7 @@ static long shmem_fallocate(struct file
> >  		 * Good, the fallocate(2) manpage permits EINTR: we may have
> >  		 * been interrupted because we are using up too much memory.
> >  		 */
> > -		if (signal_pending(current))
> > +		if (fatal_signal_pending(current))
> 
> I think that's likely wrong and probably would cause regressions as
> there may be users relying on this?

I understand your concern about userspace regressions but is the EINTR
behavior that useful? Sure, something can be relying on terminating
fallocate(2) with any signal but since tmpfs is the only filesystem having
this behavior, it is fair to say there are even higher chances some
application will be surprised by this behavior when used on tmpfs as
Mikulas was? So I wouldn't be that opposed to this change. *But* tmpfs has
a comment explaining the signal_pending() check:

                /*
                 * Good, the fallocate(2) manpage permits EINTR: we may have
                 * been interrupted because we are using up too much memory.
                 */

Now I'd expect the signal to be fatal in this case but we definitely need
to make sure this is the case if we want to consider changing the test.
Hugh?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

