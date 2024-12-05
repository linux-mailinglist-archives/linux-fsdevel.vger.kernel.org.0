Return-Path: <linux-fsdevel+bounces-36546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A60199E59B2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 16:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79593169539
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 15:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE43721C9F2;
	Thu,  5 Dec 2024 15:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R2y1XW7U";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9sU+3iTP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R2y1XW7U";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9sU+3iTP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597C33A268;
	Thu,  5 Dec 2024 15:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733412590; cv=none; b=TZHTWV+qRwB9Ev64IYihr9UDueq4bMArKEbYn/N/86XhAi9si0bncLVNKS9maGSmILnqs3Ja2j/Zt5JAZbNd69A4GrIeYHyykzFw7UKJaZeUyzPWItD5OpaWWp0o8tSL3iytAnee9ReJIJ67pAusA+SZDcao4+tPesdZVSXwgkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733412590; c=relaxed/simple;
	bh=Ri1vtdqrd1HmJUq5VcLDSp53Hksz+SDfwNnxXBNa+Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cspmcuULf1dmXSrF0JS2fII0NUQyKNuxwY8RpmfFW/03hiHnntO1XF6kIcMPVVIjElj3l8Sn2CS1M3PLmg8egYWJW5ZNTsxZxYpHgsGLavt4yNG3v99qQZHk6iOirTsxCSfm6T3H638dqq7HrnCJxNSaJkVYr1Knz6dlHBLH6x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R2y1XW7U; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9sU+3iTP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R2y1XW7U; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9sU+3iTP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5F7B5211D2;
	Thu,  5 Dec 2024 15:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733412586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hqVGQidTbQ04kHsCAl2xPOfO6GwktGINxvjsWD7obiQ=;
	b=R2y1XW7UAzPHhWSM1yqPX5wB4MedPnS7yqOp4rEk4efBVgi3gxDzTt6RbFbTGfE4Dm/Ubv
	SLYrx3uAOO+w19IPh2e4+FQC/AvDVW9FmyjVZqpps7/S4RgW2ZxDY9BCFvlaizOlESn+2V
	U+yP9A8UrTJQzxtP00bvk7Tc7+ImGaw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733412586;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hqVGQidTbQ04kHsCAl2xPOfO6GwktGINxvjsWD7obiQ=;
	b=9sU+3iTPkVTHjHtL1Lp4a95mQ3Jquzx7pT10se231vTPJ6piLNDRT6kNVsWsquIdw2ZbeS
	y88QZi/usx1EV2BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733412586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hqVGQidTbQ04kHsCAl2xPOfO6GwktGINxvjsWD7obiQ=;
	b=R2y1XW7UAzPHhWSM1yqPX5wB4MedPnS7yqOp4rEk4efBVgi3gxDzTt6RbFbTGfE4Dm/Ubv
	SLYrx3uAOO+w19IPh2e4+FQC/AvDVW9FmyjVZqpps7/S4RgW2ZxDY9BCFvlaizOlESn+2V
	U+yP9A8UrTJQzxtP00bvk7Tc7+ImGaw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733412586;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hqVGQidTbQ04kHsCAl2xPOfO6GwktGINxvjsWD7obiQ=;
	b=9sU+3iTPkVTHjHtL1Lp4a95mQ3Jquzx7pT10se231vTPJ6piLNDRT6kNVsWsquIdw2ZbeS
	y88QZi/usx1EV2BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F198138A5;
	Thu,  5 Dec 2024 15:29:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jEtJE+rGUWd+bQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Dec 2024 15:29:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A760AA08CF; Thu,  5 Dec 2024 16:29:37 +0100 (CET)
Date: Thu, 5 Dec 2024 16:29:37 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>, paulmck@kernel.org, brauner@kernel.org,
	viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org, edumazet@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fs: elide the smp_rmb fence in fd_install()
Message-ID: <20241205152937.v2uf65wcmnkutiqz@quack3>
References: <CAGudoHG6zYMfFmhizJDPAw=CF8QY8dzbvg0cSEW4XVcvTYhELw@mail.gmail.com>
 <20241205120332.1578562-1-mjguzik@gmail.com>
 <20241205144645.bv2q6nqua66sql3j@quack3>
 <CAGudoHGtOX+XPM5Z5eWd-feCvNZQ+nv0u6iY9zqGVMhPunLXqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHGtOX+XPM5Z5eWd-feCvNZQ+nv0u6iY9zqGVMhPunLXqA@mail.gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 05-12-24 16:01:07, Mateusz Guzik wrote:
> On Thu, Dec 5, 2024 at 3:46 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 05-12-24 13:03:32, Mateusz Guzik wrote:
> > > See the added commentary for reasoning.
> > >
> > > ->resize_in_progress handling is moved inside of expand_fdtable() for
> > > clarity.
> > >
> > > Whacks an actual fence on arm64.
> > >
> > > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> >
> > Hum, I don't think this works. What could happen now is:
> >
> > CPU1                                    CPU2
> > expand_fdtable()                        fd_install()
> >   files->resize_in_progress = true;
> >   ...
> >   if (atomic_read(&files->count) > 1)
> >     synchronize_rcu();
> >   ...
> >   rcu_assign_pointer(files->fdt, new_fdt);
> >   if (cur_fdt != &files->fdtab)
> >           call_rcu(&cur_fdt->rcu, free_fdtable_rcu);
> >
> >                                         rcu_read_lock_sched()
> >
> >                                         fdt = rcu_dereference_sched(files->fdt);
> >                                         /* Fetched old FD table - without
> >                                          * smp_rmb() the read was reordered */
> >   rcu_assign_pointer(files->fdt, new_fdt);
> >   /*
> >    * Publish everything before we unset ->resize_in_progress, see above
> >    * for an explanation.
> >    */
> >   smp_wmb();
> > out:
> >   files->resize_in_progress = false;
> >                                         if (unlikely(files->resize_in_progress)) {
> >                                           - false
> >                                         rcu_assign_pointer(fdt->fd[fd], file);
> >                                           - store in the old table - boom.
> >
> 
> I don't believe this ordering is possible because of both
> synchronize_rcu and the fence before updating resize_in_progress.
> 
> Any CPU which could try racing like that had to come in after the
> synchronize_rcu() call, meaning one of the 3 possibilities:
> - the flag is true and the fd table is old
> - the flag is true and the fd table is new
> - the flag is false and the fd table is new

I agree here.

> Suppose the CPU reordered loads of the flag and the fd table. There is
> no ordering in which it can see both the old table and the unset flag.

But I disagree here. If the reads are reordered, then the fd table read can
happen during the "flag is true and the fd table is old" state and the flag
read can happen later in "flag is false and the fd table is new" state.
Just as I outlined above...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

