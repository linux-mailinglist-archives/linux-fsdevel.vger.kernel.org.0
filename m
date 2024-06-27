Return-Path: <linux-fsdevel+bounces-22631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B658291A89A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 16:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FD90B248E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 14:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365F6195812;
	Thu, 27 Jun 2024 14:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZqurxRux";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DmxQDbCa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="opzsBa/D";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tSRL2AD3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DFD19580D;
	Thu, 27 Jun 2024 14:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719497036; cv=none; b=eKsxi2DXCgb5P0JOflgpTjrzSDcr/nCepXGdxl6+V6pghkKlsDESLtpngNO+Z0s7pT4/rkA550LWaCm6d2iIEi7jRAWSc1Iji3lrCJFd7Xr7VXK7WtQprpsDXOnx1wjt82PNybLOgKOwF1lqb4AtyvDUh8zVEJlONvTlrAz6IAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719497036; c=relaxed/simple;
	bh=ev1QAvan/iAGexvqPDni4mBuoPrSQZfWccKavoN6tEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJeG+9EKyDVSvsQMBgeHJQJyaLUVTJ+/HwIUIN3zBCw5z91LINLrKG7u17NSSlJaPBFeo0Z77St7PRNJFZEHAkzy66dXBA2OWMiQDY1RaRELEJ5nihLelADaW84lykmRAlP7uhqzUeqh5Cij3ud7TdQmXPfRtpATwcuQgbRx6pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZqurxRux; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DmxQDbCa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=opzsBa/D; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tSRL2AD3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E72A721894;
	Thu, 27 Jun 2024 14:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719497029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KvbA4PAazLUAg1OnkD1/0xSOzLB917EBmUzxxIZljXU=;
	b=ZqurxRuxfCKveqBgazMpUmWiJ4uHEo12fPDan0C+/ykFsGXr+N7PtBV0FjoaQBdKI7medJ
	kRUp8HXViPVolNW5HIi412C2qPf0qYQ0ZY0ssLr+HO+tMsSY/d0MlyAG1Spuk3Z1eAl+KP
	Y4BJtBhHip2iNTM7iB6i1TVKK5oUI20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719497029;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KvbA4PAazLUAg1OnkD1/0xSOzLB917EBmUzxxIZljXU=;
	b=DmxQDbCajnj4nn2O7fCdeGTao8pud1sSQhvfhwZ7oZltR5a5i3utWRI2r5E9fIzou+RGJU
	F3KWvm6kh8iXdODA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719497028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KvbA4PAazLUAg1OnkD1/0xSOzLB917EBmUzxxIZljXU=;
	b=opzsBa/DBUBtPf/CH/W/TCAgeZm6x745ReCmSh7I8IBf091NrcC2R8WeRclkOr0pP6Uk2F
	GIrv2P0DB83bVzLrWclbhAffPDidyU1fBoxWDp+h06qJmo/3DlaMdruAHykpDgF/cIGPpo
	NJA17DG47+d+nidVeblu2628hQSaaoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719497028;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KvbA4PAazLUAg1OnkD1/0xSOzLB917EBmUzxxIZljXU=;
	b=tSRL2AD39SoHSFoEcYhQQVLGCs5flg+fpM63mf+H9aqx/6Om8J4IswmSBWJ0Hk0LpISMgH
	hcPkTebqkQwhJzDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE9F5137DF;
	Thu, 27 Jun 2024 14:03:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id x+ZsMkRxfWYgbQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 27 Jun 2024 14:03:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 64CEEA08A2; Thu, 27 Jun 2024 16:03:48 +0200 (CEST)
Date: Thu, 27 Jun 2024 16:03:48 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>, "Ma, Yu" <yu.ma@intel.com>,
	viro@zeniv.linux.org.uk, brauner@kernel.org, edumazet@google.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	pan.deng@intel.com, tianyou.li@intel.com, tim.c.chen@intel.com,
	tim.c.chen@linux.intel.com
Subject: Re: [PATCH v2 1/3] fs/file.c: add fast path in alloc_fd()
Message-ID: <20240627140348.ju2kynqenxporsns@quack3>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240622154904.3774273-1-yu.ma@intel.com>
 <20240622154904.3774273-2-yu.ma@intel.com>
 <20240625115257.piu47hzjyw5qnsa6@quack3>
 <20240625125309.y2gs4j5jr35kc4z5@quack3>
 <87a1279c-c5df-4f3b-936d-c9b8ed58f46e@intel.com>
 <20240626115427.d3x7g3bf6hdemlnq@quack3>
 <CAGudoHEkw=cRG1xFHU02YjkM2+MMS2vkY_moZ2QUjAToEzbR3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHEkw=cRG1xFHU02YjkM2+MMS2vkY_moZ2QUjAToEzbR3g@mail.gmail.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]

On Wed 26-06-24 21:13:07, Mateusz Guzik wrote:
> On Wed, Jun 26, 2024 at 1:54 PM Jan Kara <jack@suse.cz> wrote:
> > So maybe I'm wrong but I think the biggest benefit of your code compared to
> > plain find_next_fd() is exactly in that we don't have to load full_fds_bits
> > into cache. So I'm afraid that using full_fds_bits in the condition would
> > destroy your performance gains. Thinking about this with a fresh head how
> > about putting implementing your optimization like:
> >
> > --- a/fs/file.c
> > +++ b/fs/file.c
> > @@ -490,6 +490,20 @@ static unsigned int find_next_fd(struct fdtable *fdt, unsigned int start)
> >         unsigned int maxbit = maxfd / BITS_PER_LONG;
> >         unsigned int bitbit = start / BITS_PER_LONG;
> >
> > +       /*
> > +        * Optimistically search the first long of the open_fds bitmap. It
> > +        * saves us from loading full_fds_bits into cache in the common case
> > +        * and because BITS_PER_LONG > start >= files->next_fd, we have quite
> > +        * a good chance there's a bit free in there.
> > +        */
> > +       if (start < BITS_PER_LONG) {
> > +               unsigned int bit;
> > +
> > +               bit = find_next_zero_bit(fdt->open_fds, BITS_PER_LONG, start);
> > +               if (bit < BITS_PER_LONG)
> > +                       return bit;
> > +       }
> > +
> >         bitbit = find_next_zero_bit(fdt->full_fds_bits, maxbit, bitbit) * BITS_PER_LONG;
> >         if (bitbit >= maxfd)
> >                 return maxfd;
> >
> > Plus your optimizations with likely / unlikely. This way the code flow in
> > alloc_fd() stays more readable, we avoid loading the first open_fds long
> > into cache if it is full, and we should get all the performance benefits?
> >
> 
> Huh.
> 
> So when I read the patch previously I assumed this is testing the bit
> word for the map containing next_fd (whatever it is), avoiding looking
> at the higher level bitmap and inlining the op (instead of calling the
> fully fledged func for bit scans).
> 
> I did not mentally register this is in fact only checking for the
> beginning of the range of the entire thing. So apologies from my end
> as based on my feedback some work was done and I'm going to ask to
> further redo it.

Well, just confirming the fact that the way the code was written was
somewhat confusing ;)

> blogbench spawns 100 or so workers, say total fd count hovers just
> above 100. say this lines up with about half of more cases in practice
> for that benchmark.
> 
> Even so, that's a benchmark-specific optimization. A busy web server
> can have literally tens of thousands of fds open (and this is a pretty
> mundane case), making the 0-63 range not particularly interesting.

I agree this optimization helps only processes with low number of open fds.
On the other hand that is usually the  majority of the processes on the
system so the optimization makes sense to me. That being said your idea of
searching the word with next_fd makes sense as well...

> That aside I think the patchset is in the wrong order -- first patch
> tries to not look at the higher level bitmap, while second reduces
> stores made there. This makes it quite unclear how much is it worth to
> reduce looking there if atomics are conditional.
> 
> So here is what I propose in terms of the patches:
> 1. NULL check removal, sprinkling of likely/unlikely and expand_files
> call avoidance; no measurements done vs stock kernel for some effort
> saving, just denote in the commit message there is less work under the
> lock and treat it as baseline
> 2. conditional higher level bitmap clear as submitted; benchmarked against 1
> 3. open_fds check within the range containing fd, avoiding higher
> level bitmap if a free slot is found. this should not result in any
> func calls if successful; benchmarked against the above

Yeah, I guess this ordering is the most obvious -> the least obvious so it
makes sense to me.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

