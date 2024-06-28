Return-Path: <linux-fsdevel+bounces-22757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF2391BB31
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 11:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37B48B20B2A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 09:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE1414F9F2;
	Fri, 28 Jun 2024 09:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zzb7Wx1k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lEHmVekb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zzb7Wx1k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lEHmVekb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067BB143886;
	Fri, 28 Jun 2024 09:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565961; cv=none; b=eEnNyX0u3Y5Q7gbiKw3vGHbFusEwlh70k9ojEH0OEBZyPZj7Vd6eIR0lkUj1Pr5kg4WZfOeWeG7EVNWhG/g04qKTupITHmmpjIo79DXmUn/ep9RDqpOC+nEDhznK+TthmtyNDeDbPbTxfs21wiSQwydxnZm4271pjragHQwcIek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565961; c=relaxed/simple;
	bh=ICDZYOmrwau3qLv0xvQ1droKz1J2J6HDOC4KJEAOLxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMy5snE6vN5t/ECvX0fOla0JVq1s3NPZqL4b2TFRuxGICmAsYtvI4hjY/oNAHNmYPaXFmiX21KWtn86c4p5veezgxOhiZJG0CkvrTLUZ1+AY14tsnS+QuZU0N///5KL0C1YQaTSJBscgJdsMon3vF5URhPZDlshDyvHgnTEud/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zzb7Wx1k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lEHmVekb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zzb7Wx1k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lEHmVekb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 18B171F399;
	Fri, 28 Jun 2024 09:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719565958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jaDh5ipqF28thvRSG3GWD+pXBue70l9oTbRsKNkiPgE=;
	b=zzb7Wx1kOBNkmcrvHQQTaYqVoAY6jt30QUYgrv4D6ggc/9idtOAI1IKvWM/1mX0iDzj+cL
	DabGraGTbvKgBi/PuFGEmkm1OTlyBjZsT2D22xLZlzFmTFu0ODxiYQx9dL5ub3JGB8P2/K
	DXLUpbK+85Z9JvlJy5tUfbl6DYywcEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719565958;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jaDh5ipqF28thvRSG3GWD+pXBue70l9oTbRsKNkiPgE=;
	b=lEHmVekbEb+j7TYoM4Gscqd7JG8L9OHB+aWZOxC/JMspbZVvpW6s3VdaPPl9cVqmxUCtpe
	CGPeZXC1FDbxyPDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719565958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jaDh5ipqF28thvRSG3GWD+pXBue70l9oTbRsKNkiPgE=;
	b=zzb7Wx1kOBNkmcrvHQQTaYqVoAY6jt30QUYgrv4D6ggc/9idtOAI1IKvWM/1mX0iDzj+cL
	DabGraGTbvKgBi/PuFGEmkm1OTlyBjZsT2D22xLZlzFmTFu0ODxiYQx9dL5ub3JGB8P2/K
	DXLUpbK+85Z9JvlJy5tUfbl6DYywcEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719565958;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jaDh5ipqF28thvRSG3GWD+pXBue70l9oTbRsKNkiPgE=;
	b=lEHmVekbEb+j7TYoM4Gscqd7JG8L9OHB+aWZOxC/JMspbZVvpW6s3VdaPPl9cVqmxUCtpe
	CGPeZXC1FDbxyPDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0047C13A9A;
	Fri, 28 Jun 2024 09:12:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WCcKAIZ+fmanLwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 28 Jun 2024 09:12:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A1DFBA0893; Fri, 28 Jun 2024 11:12:37 +0200 (CEST)
Date: Fri, 28 Jun 2024 11:12:37 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: "Ma, Yu" <yu.ma@intel.com>, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, viro@zeniv.linux.org.uk,
	edumazet@google.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, pan.deng@intel.com,
	tianyou.li@intel.com, tim.c.chen@intel.com,
	tim.c.chen@linux.intel.com
Subject: Re: [PATCH v2 1/3] fs/file.c: add fast path in alloc_fd()
Message-ID: <20240628091237.o5slz77tpwb5kdwj@quack3>
References: <20240622154904.3774273-1-yu.ma@intel.com>
 <20240622154904.3774273-2-yu.ma@intel.com>
 <20240625115257.piu47hzjyw5qnsa6@quack3>
 <20240625125309.y2gs4j5jr35kc4z5@quack3>
 <87a1279c-c5df-4f3b-936d-c9b8ed58f46e@intel.com>
 <20240626115427.d3x7g3bf6hdemlnq@quack3>
 <CAGudoHEkw=cRG1xFHU02YjkM2+MMS2vkY_moZ2QUjAToEzbR3g@mail.gmail.com>
 <20240627-laufschuhe-hergibt-8158b7b6b206@brauner>
 <32ac6edc-62b4-405d-974f-afe1e718114d@intel.com>
 <CAGudoHE5ROsy_hZB9uZjcjko0+=DbsUtBkmX9D1K1RG1GWrNbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHE5ROsy_hZB9uZjcjko0+=DbsUtBkmX9D1K1RG1GWrNbg@mail.gmail.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,intel.com:email]

On Thu 27-06-24 21:59:12, Mateusz Guzik wrote:
> On Thu, Jun 27, 2024 at 8:27 PM Ma, Yu <yu.ma@intel.com> wrote:
> > 2. For fast path implementation, the essential and simple point is to
> > directly return an available bit if there is free bit in [0-63]. I'd
> > emphasize that it does not only improve low number of open fds (even it
> > is the majority case on system as Honza agreed), but also improve the
> > cases that lots of fds open/close frequently with short task (as per the
> > algorithm, lower bits will be prioritized to allocate after being
> > recycled). Not only blogbench, a synthetic benchmark, but also the
> > realistic scenario as claimed in f3f86e33dc3d("vfs: Fix pathological
> > performance case for __alloc_fd()"), which literally introduced this
> > 2-levels bitmap searching algorithm to vfs as we see now.
> 
> I don't understand how using next_fd instead is supposed to be inferior.
> 
> Maybe I should clarify that by API contract the kernel must return the
> lowest free fd it can find. To that end it maintains the next_fd field
> as a hint to hopefully avoid some of the search work.
> 
> In the stock kernel the first thing done in alloc_fd is setting it as
> a starting point:
>         fdt = files_fdtable(files);
>         fd = start;
>         if (fd < files->next_fd)
>                 fd = files->next_fd;
> 
> that is all the calls which come here with 0 start their search from
> next_fd position.

Yup.

> Suppose you implemented the patch as suggested by me and next_fd fits
> the range of 0-63. Then you get the benefit of lower level bitmap
> check just like in the patch you submitted, but without having to
> first branch on whether you happen to be in that range.
> 
> Suppose next_fd is somewhere higher up, say 80. With your general
> approach the optimization wont be done whatsoever or it will be
> attempted at the 0-63 range when it is an invariant it finds no free
> fds.
> 
> With what I'm suggesting the general idea of taking a peek at the
> lower level bitmap can be applied across the entire fd space. Some
> manual mucking will be needed to make sure this never pulls more than
> one cacheline, easiest way out I see would be to align next_fd to
> BITS_PER_LONG for the bitmap search purposes.

Well, all you need to do is to call:

	bit = find_next_zero_bit(fdt->open_fds[start / BITS_PER_LONG],
				 BITS_PER_LONG, start & (BITS_PER_LONG-1));
	if (bit < BITS_PER_LONG)
		return bit + (start & ~(BITS_PER_LONG - 1));


in find_next_fd(). Not sure if this is what you meant by aligning next_fd
to BITS_PER_LONG...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

