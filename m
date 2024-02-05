Return-Path: <linux-fsdevel+bounces-10256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0338497B4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 11:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D16DF1C2261F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 10:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E538171B6;
	Mon,  5 Feb 2024 10:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="k7Nz4t8G";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mbAO5ZIJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="akVjiA3B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w3Zpgcdh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8CF168DC
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Feb 2024 10:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707128655; cv=none; b=ECNCDLkfBZ54A4EvykAT0pm4Ru8OQ19Ac8JIJdCc5AMpwWI0uE00rOaqyEyhcEHzGuVCR5CG5UgFWKJSzkQrV40SfJdVorgq6qhkZGRMawShclUm9RanFC997sfcZFQ9ViSEYIdnoNy60nhtLHhfGfir3Mjd6RM8ufi1JuOh4Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707128655; c=relaxed/simple;
	bh=ONOY+lIlgzm7y1QPF62q+X9QGNmgQCC+7pyfW7JRz44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1acjg9rnzv6QqlD3GheYKowuAcsyR+tIJYZlw29Wv5bcQKUBjwVAXRtWy49NW0rMfhyuE93Zw/cGy0nLATTBjaWPRnT032M/nI04wXPuUzBGY2RCeWPwMcbzfxm+KhPrAIF8yDjmzZB90cO5HMXF+ppVDrLhYjs2iAtPSG6dnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=k7Nz4t8G; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mbAO5ZIJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=akVjiA3B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w3Zpgcdh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B07E81F8B3;
	Mon,  5 Feb 2024 10:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707128651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jn7duIoEWwtGS5G4is0r/wK8YqNDeJfLh0SlttlLpng=;
	b=k7Nz4t8G/J/lnPuupdkgOZpRFcIHTFBSs902yXeC/Jr3MveGJ9wsjdaIOOk965boZa9q3V
	m+7sYTbtb5T4XS5uiu4HiWtOfxakaxjXoTIT4dptAcFO8HX1cPBKqzCR4Vcc9B/VbMBZZA
	ZTE0PuQHktw174RL2tz4pRi7aIBC+SQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707128651;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jn7duIoEWwtGS5G4is0r/wK8YqNDeJfLh0SlttlLpng=;
	b=mbAO5ZIJWRt4L/k4zziS62ltFAPtw1ATK2xtv1sL90v1QCCljYwsjbKHe43yC5VVA8MbLI
	yj1I5JEf9rMxWUAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707128649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jn7duIoEWwtGS5G4is0r/wK8YqNDeJfLh0SlttlLpng=;
	b=akVjiA3BS6wclzQDFl9tMur8wVkUAX0ShQKYVdi70RUCD9wvhvr23wY3VjkLMWtZbDaLhl
	O/xoJ0ZZgML3G5XdLL8akSxi3Aei1Spe7QWpYrV3E8cgj7Y0aJKU7/TOnfBmS6VAB1+MWo
	Rwh8opfLjdhvXRR8pmeH+o44ocafezI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707128649;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jn7duIoEWwtGS5G4is0r/wK8YqNDeJfLh0SlttlLpng=;
	b=w3ZpgcdhWz0SE6Pd3RhJ5UaHSF3SLGllM4YBjlnjhfQ+qJGtTPIMe+8PRD3aFMca90SVVL
	FZCEOt7FD3Qn8bDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5742132DD;
	Mon,  5 Feb 2024 10:24:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4r1hKEm3wGVXLQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 05 Feb 2024 10:24:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5DC23A0809; Mon,  5 Feb 2024 11:24:09 +0100 (CET)
Date: Mon, 5 Feb 2024 11:24:09 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] remap_range: merge do_clone_file_range() into
 vfs_clone_file_range()
Message-ID: <20240205102409.4jppi3gp23e542gi@quack3>
References: <20240202102258.1582671-1-amir73il@gmail.com>
 <20240202114405.xvgo5zbrhhlskwqk@quack3>
 <CAOQ4uxgQqL_5fTSVpTB=HScyJOkx8Gz6YOr7ZeiV9Wm0Rt3hVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgQqL_5fTSVpTB=HScyJOkx8Gz6YOr7ZeiV9Wm0Rt3hVw@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.39
X-Spamd-Result: default: False [-2.39 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.59)[92.39%]
X-Spam-Flag: NO

On Fri 02-02-24 14:08:07, Amir Goldstein wrote:
> On Fri, Feb 2, 2024 at 1:44 PM Jan Kara <jack@suse.cz> wrote:
> > > +     /* Try to use clone_file_range to clone up within the same fs */
> > > +     cloned = vfs_clone_file_range(old_file, 0, new_file, 0, len, 0);
> > > +     if (cloned == len)
> > > +             goto out_fput;
> > > +
> > > +     /* Couldn't clone, so now we try to copy the data */
> > >       error = rw_verify_area(READ, old_file, &old_pos, len);
> > >       if (!error)
> > >               error = rw_verify_area(WRITE, new_file, &new_pos, len);
> > >       if (error)
> > >               goto out_fput;
> >
> > Do we need to keep these rw_verify_area() checks here when
> > vfs_clone_file_range() already did remap_verify_area()?
> 
> Yes, because in the common case of no clone support (e.g. ext4),
> the permission hooks in vfs_clone_file_range() will not be called.
> 
> There is a corner case where fs supports clone, but for some reason
> rejects this specific clone request, although there is no apparent
> reason to reject a clone request for the entire file range.
> 
> In that case, permission hooks will be called twice - no big deal -
> that is exactly like a fallback in userspace cp --reflink=auto that
> will end up calling permission hooks twice in this corner case.

I see. Thanks for explanation!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

