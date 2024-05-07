Return-Path: <linux-fsdevel+bounces-18900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2978BE443
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 15:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FCD91C23F42
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 13:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0367160792;
	Tue,  7 May 2024 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0Qt9HF5O";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Cbq9+ujW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LIynchdB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xhkAM7Jb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9303215E1FD;
	Tue,  7 May 2024 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715088536; cv=none; b=PN1MpvS2jB8tmEv9YZ3Tc8zb/y9Ky1U6ccEMfLwefjaxGGy+pVgd23Fj+tU91oxU3TCUk/YIZKqMyQtYNJmcHvMJ4wQxVk8PZKzg6413TcfCvqJBRpFjjTSkMFxv2uP71CoHf7kskughgF07hlZNSDP1DLRrBzngk+CO4Hw0/vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715088536; c=relaxed/simple;
	bh=B4jRPnedjbTg+biEqUUnre9CXwIHW+zDTiCuieMfVWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAnBfoPV9414uxIjBoQI48MRuF6/fMaUf4AR2U1fUXeZmhpFyc8FeRlPjvkRekzbWr9n/rzyIJF0yPu+mnMk9BW6mvrDYftUxgVsc4GQ5X3BEqIElfjDZSeG+YMrCKEhBubpcciQfAg3XSwfKblVrmzWlcWYKZd93H8i4ffBYBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0Qt9HF5O; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Cbq9+ujW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LIynchdB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xhkAM7Jb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A679333F49;
	Tue,  7 May 2024 13:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715088532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VYJbzgiVTNb8w4djcvsGpkVeEx+MzHbClspvU8qpWEk=;
	b=0Qt9HF5O1st4ufx9TLd0e+zazojyZZF2y+oiD9QBCcIHdVW1dV/Sw1OlBgyhMp3M0s4NHg
	x9KusCPY5S0Rb13Sw+M8PwSJipRp6xVpW/0X6vISL3LE3+hDFrpQHrH5b/+HRaXhjK86h3
	n87HIldRzluIzU5Yivc0dOxX6DPsm3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715088532;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VYJbzgiVTNb8w4djcvsGpkVeEx+MzHbClspvU8qpWEk=;
	b=Cbq9+ujWplphkUp3+RUJDS8HDMYypE1cugxOKiX0LBVTgzweSqzsrFMHKuI64F/8z9Zkv+
	KUoe+vHGbqza0YDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LIynchdB;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xhkAM7Jb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715088531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VYJbzgiVTNb8w4djcvsGpkVeEx+MzHbClspvU8qpWEk=;
	b=LIynchdBMDbxmx5idbz7hlfCR+jFLhMOrGYYJrZZSvkQYG8kSCQI11PP/f3UkgaAX6oHmM
	opGJsSCYVJQkUdYjw+gSwR3w4t/UkSGWKxT0mA7UIe7o5kugIHLkD6LEA1c3FPsGiylgxU
	pYtU9z1BTkN3br5ZgBRs/oUwAM3i63Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715088531;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VYJbzgiVTNb8w4djcvsGpkVeEx+MzHbClspvU8qpWEk=;
	b=xhkAM7JbIfP8+p8RaTyHHwZcir0o6JIt2RRIRBp6S6/F1sVrrfpUFUVytZ3KbiFS2awl/3
	nsRqWKaRtfDsGNAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A87F139CB;
	Tue,  7 May 2024 13:28:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mdu3JZMsOmYwKQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 07 May 2024 13:28:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4D55AA4E6D; Tue,  7 May 2024 15:28:51 +0200 (CEST)
Date: Tue, 7 May 2024 15:28:51 +0200
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: Jan Kara <jack@suse.cz>, willy@infradead.org, akpm@linux-foundation.org,
	tj@kernel.org, hcochran@kernelspring.com, axboe@kernel.dk,
	mszeredi@redhat.com, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] mm: correct calculation of wb's bg_thresh in
 cgroup domain
Message-ID: <20240507132851.rck2mc4sywaav67f@quack3>
References: <20240425131724.36778-1-shikemeng@huaweicloud.com>
 <20240425131724.36778-3-shikemeng@huaweicloud.com>
 <20240503093056.6povgn2shvqzpedj@quack3>
 <12bf104e-aeac-67a5-6e5a-bc7bdbfe4d79@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12bf104e-aeac-67a5-6e5a-bc7bdbfe4d79@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A679333F49
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Tue 07-05-24 09:16:39, Kemeng Shi wrote:
> 
> Hi Jan,
> on 5/3/2024 5:30 PM, Jan Kara wrote:
> > On Thu 25-04-24 21:17:22, Kemeng Shi wrote:
> >> The wb_calc_thresh is supposed to calculate wb's share of bg_thresh in
> >> global domain. To calculate wb's share of bg_thresh in cgroup domain,
> >> it's more reasonable to use __wb_calc_thresh in which way we calculate
> >> dirty_thresh in cgroup domain in balance_dirty_pages().
> >>
> >> Consider following domain hierarchy:
> >>                 global domain (> 20G)
> >>                 /                 \
> >>         cgroup domain1(10G)     cgroup domain2(10G)
> >>                 |                 |
> >> bdi            wb1               wb2
> >> Assume wb1 and wb2 has the same bandwidth.
> >> We have global domain bg_thresh > 2G, cgroup domain bg_thresh 1G.
> >> Then we have:
> >> wb's thresh in global domain = 2G * (wb bandwidth) / (system bandwidth)
> >> = 2G * 1/2 = 1G
> >> wb's thresh in cgroup domain = 1G * (wb bandwidth) / (system bandwidth)
> >> = 1G * 1/2 = 0.5G
> >> At last, wb1 and wb2 will be limited at 0.5G, the system will be limited
> >> at 1G which is less than global domain bg_thresh 2G.
> > 
> > This was a bit hard to understand for me so I'd rephrase it as:
> > 
> > wb_calc_thresh() is calculating wb's share of bg_thresh in the global
> > domain. However in case of cgroup writeback this is not the right thing to
> > do. Consider the following domain hierarchy:
> > 
> >                 global domain (> 20G)
> >                 /                 \
> >           cgroup1 (10G)     cgroup2 (10G)
> >                 |                 |
> > bdi            wb1               wb2
> > 
> > and assume wb1 and wb2 have the same bandwidth and the background threshold
> > is set at 10%. The bg_thresh of cgroup1 and cgroup2 is going to be 1G. Now
> > because wb_calc_thresh(mdtc->wb, mdtc->bg_thresh) calculates per-wb
> > threshold in the global domain as (wb bandwidth) / (domain bandwidth) it
> > returns bg_thresh for wb1 as 0.5G although it has nobody to compete against
> > in cgroup1.
> > 
> > Fix the problem by calculating wb's share of bg_thresh in the cgroup
> > domain.
> Thanks for improving the changelog. As this was merged into -mm and
> mm-unstable tree, I'm not sure if a new patch is needed. If there is
> anything I should do, please let me konw. Thanks.

No need to do anything here. Andrew has picked up these updates.

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

