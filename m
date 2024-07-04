Return-Path: <linux-fsdevel+bounces-23169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACF9927EC0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 23:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8B661F23538
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 21:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1E52BB06;
	Thu,  4 Jul 2024 21:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v2wp3z4T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UolzhRCh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Re4H/W5B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qAohF2d6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9AA6A039;
	Thu,  4 Jul 2024 21:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720130111; cv=none; b=crag1X2zea558MaZlxb64P8wO3g+Ccog0JBMQuTPpHK4NCbWmv+eh1MhPrfJPDgQB2izN2jmuuKlSbJoOHaYcsP5F1syIzCKCTGjC+LoyJOPAkOWQkTqXQwdfkUC2uG09poPHCy6PFU5KYkIEoQdGpAJXlfK3wQR8RIF6zYV7dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720130111; c=relaxed/simple;
	bh=T+sBqmJGXgajisCj2//LrLA9ZJPffXqOqWIuJbpQP64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gb7q3KuwI2yEhnjh3Iru3ZHu5Nvtik697TMox9e+ezQzXhDHscwSsq3uYwxE8ucIHcLGYR+qZtEafloTdl2Gj4vRRWg6V+STDFDKIsTPh/McaRSFm3u1i+9WPb/kicQ3WxCQ5Uqdh1F8h5gY9vDd2QvMTB2M9iu3B7MERjNawqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v2wp3z4T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UolzhRCh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Re4H/W5B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qAohF2d6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F108C1F80F;
	Thu,  4 Jul 2024 21:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720130108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GfiX9Zp/QKnsaMyxxdXkgz0ONmAbGLZLMo2D9g/3los=;
	b=v2wp3z4TaiWgoJ3lJdZtjRHeS4wxyh7dkWNJQwYTsySUEo5oqY7IUhuVx9iHkQrfl7ITl1
	YJIb4py74XY24Azs+BQ9ic4x1SJgPNGcTeebdXcJJ0+UgG09VTSRm5E72BT4y3QxlvIvhK
	hkK5dHiosgDMMfG+6geogOVgbL62n6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720130108;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GfiX9Zp/QKnsaMyxxdXkgz0ONmAbGLZLMo2D9g/3los=;
	b=UolzhRChId9QVzkkW2L+Iv0K5xOVrqbrTJsx/QFyqwE1IuzikHhhURX35rVkI5+f7YDvBl
	OuC3LBo/5ct4NLBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720130107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GfiX9Zp/QKnsaMyxxdXkgz0ONmAbGLZLMo2D9g/3los=;
	b=Re4H/W5B//TP004dE7MUjFMkiG1lnyxSv0SV/A+x+tJG80mPAxmOmE56qA5ze4Ii4gpEqc
	DtBvzCkCXt7jnACYM28w2TXmFYDddvdj4Kh0yHTYdDgwiezeYhaA+8Q1kPSoHI/k5CzCvi
	d1F4PH5L8coBa2dWeaGWm7zTGb6KPuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720130107;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GfiX9Zp/QKnsaMyxxdXkgz0ONmAbGLZLMo2D9g/3los=;
	b=qAohF2d6Hz034S5wwpLNY/oCZc0f64E/XhO09I/xh1MncxyLdCTZYZrzyTXBNYG40hAEjS
	gINzaYZLL6WaVoAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E08881369F;
	Thu,  4 Jul 2024 21:55:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aCaINjsah2afIAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 04 Jul 2024 21:55:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8BAA0A08C9; Thu,  4 Jul 2024 23:55:07 +0200 (CEST)
Date: Thu, 4 Jul 2024 23:55:07 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Yu Ma <yu.ma@intel.com>, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, edumazet@google.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, pan.deng@intel.com,
	tianyou.li@intel.com, tim.c.chen@intel.com,
	tim.c.chen@linux.intel.com
Subject: Re: [PATCH v3 3/3] fs/file.c: add fast path in find_next_fd()
Message-ID: <20240704215507.mr6st2d423lvkepu@quack3>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240703143311.2184454-1-yu.ma@intel.com>
 <20240703143311.2184454-4-yu.ma@intel.com>
 <CAGudoHH_P4LGaVN1N4j8FNTH_eDm3SDL7azMc25+HY2_XgjvJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHH_P4LGaVN1N4j8FNTH_eDm3SDL7azMc25+HY2_XgjvJQ@mail.gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Thu 04-07-24 19:44:10, Mateusz Guzik wrote:
> On Wed, Jul 3, 2024 at 4:07 PM Yu Ma <yu.ma@intel.com> wrote:
> >
> > There is available fd in the lower 64 bits of open_fds bitmap for most cases
> > when we look for an available fd slot. Skip 2-levels searching via
> > find_next_zero_bit() for this common fast path.
> >
> > Look directly for an open bit in the lower 64 bits of open_fds bitmap when a
> > free slot is available there, as:
> > (1) The fd allocation algorithm would always allocate fd from small to large.
> > Lower bits in open_fds bitmap would be used much more frequently than higher
> > bits.
> > (2) After fdt is expanded (the bitmap size doubled for each time of expansion),
> > it would never be shrunk. The search size increases but there are few open fds
> > available here.
> > (3) There is fast path inside of find_next_zero_bit() when size<=64 to speed up
> > searching.
> >
> > As suggested by Mateusz Guzik <mjguzik gmail.com> and Jan Kara <jack@suse.cz>,
> > update the fast path from alloc_fd() to find_next_fd(). With which, on top of
> > patch 1 and 2, pts/blogbench-1.1.0 read is improved by 13% and write by 7% on
> > Intel ICX 160 cores configuration with v6.10-rc6.
> >
> > Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> > Signed-off-by: Yu Ma <yu.ma@intel.com>
> > ---
> >  fs/file.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/fs/file.c b/fs/file.c
> > index a15317db3119..f25eca311f51 100644
> > --- a/fs/file.c
> > +++ b/fs/file.c
> > @@ -488,6 +488,11 @@ struct files_struct init_files = {
> >
> >  static unsigned int find_next_fd(struct fdtable *fdt, unsigned int start)
> >  {
> > +       unsigned int bit;
> > +       bit = find_next_zero_bit(fdt->open_fds, BITS_PER_LONG, start);
> > +       if (bit < BITS_PER_LONG)
> > +               return bit;
> > +
> >         unsigned int maxfd = fdt->max_fds; /* always multiple of BITS_PER_LONG */
> >         unsigned int maxbit = maxfd / BITS_PER_LONG;
> >         unsigned int bitbit = start / BITS_PER_LONG;
> > --
> > 2.43.0
> >
> 
> I had something like this in mind:
> diff --git a/fs/file.c b/fs/file.c
> index a3b72aa64f11..4d3307e39db7 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -489,6 +489,16 @@ static unsigned int find_next_fd(struct fdtable
> *fdt, unsigned int start)
>         unsigned int maxfd = fdt->max_fds; /* always multiple of
> BITS_PER_LONG */
>         unsigned int maxbit = maxfd / BITS_PER_LONG;
>         unsigned int bitbit = start / BITS_PER_LONG;
> +       unsigned int bit;
> +
> +       /*
> +        * Try to avoid looking at the second level map.
> +        */
> +       bit = find_next_zero_bit(&fdt->open_fds[bitbit], BITS_PER_LONG,
> +                               start & (BITS_PER_LONG - 1));
> +       if (bit < BITS_PER_LONG) {
> +               return bit + bitbit * BITS_PER_LONG;
> +       }

Drat, you're right. I missed that Ma did not add the proper offset to
open_fds. *This* is what I meant :)

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

