Return-Path: <linux-fsdevel+bounces-35318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6440A9D3A0A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 12:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD0091F26489
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 11:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D6B1A00ED;
	Wed, 20 Nov 2024 11:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qyqkFcoI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ddss9Gul";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qyqkFcoI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ddss9Gul"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6538E19D060;
	Wed, 20 Nov 2024 11:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732103856; cv=none; b=DlMDrdu1B6BMsO6JPd9bu04Ec8z3+GxuwJPsaEoDl9tQy1LRlQ2pJM9C1ikYaksq4GVZmZ/cwre0IvIcUL0q5MuAfg+J/f2VeWzq/B2iUkrl3n/ewpaQadLFjVXVw6yN5ITzLgxF4IXTaRESDm2CXHtvRZiXeKJPuxjHNNziC7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732103856; c=relaxed/simple;
	bh=qKL/jn7qjS4czTVmfysiYAnNefEAEVOI9+h6G0SN/Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FhZ0RvoK+eGxYpBFbwxmQOgv748Q0qLqt0RBq9PLdHKmOMwEO1uKt9OzfohaCPjC7Vv54DD9W6Db2YUTq98z29YvXugalWj16qOtLWSQzLlsi++WYflyaTe/ZsjEnMI2ne+3MOLdgWYCzvB76vJ6Ojsic4Fr7Es/t2ld2HHcwbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qyqkFcoI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ddss9Gul; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qyqkFcoI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ddss9Gul; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 613F91F76E;
	Wed, 20 Nov 2024 11:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732103852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IavqSNCbqUkWJ5eYBw9gwWOmwKh1kgh1iYd5CwKJmz8=;
	b=qyqkFcoI32xIg3C13k1Lny8LPkxmG8CEk1duEJOZIvBXXUzHpoiLocW1IKZgCltQWTkzdD
	i++rtQ4R6X8CKELWPu+PvtzGi2tuHsdkNLEThjpzLF3lLKNSdahAsea6cgAE5NocnftiRo
	plDV9ZGQD2OHi3tC7uMNtcYPA8JFQD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732103852;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IavqSNCbqUkWJ5eYBw9gwWOmwKh1kgh1iYd5CwKJmz8=;
	b=Ddss9GulcQLpQgFQ7Zm0D3ki1/IrEQiCUsv0+UkWVI07Uz/cx46VoKOsra8t9iDLL6f/vx
	06nNUi9PxMYdKaDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qyqkFcoI;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Ddss9Gul
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732103852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IavqSNCbqUkWJ5eYBw9gwWOmwKh1kgh1iYd5CwKJmz8=;
	b=qyqkFcoI32xIg3C13k1Lny8LPkxmG8CEk1duEJOZIvBXXUzHpoiLocW1IKZgCltQWTkzdD
	i++rtQ4R6X8CKELWPu+PvtzGi2tuHsdkNLEThjpzLF3lLKNSdahAsea6cgAE5NocnftiRo
	plDV9ZGQD2OHi3tC7uMNtcYPA8JFQD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732103852;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IavqSNCbqUkWJ5eYBw9gwWOmwKh1kgh1iYd5CwKJmz8=;
	b=Ddss9GulcQLpQgFQ7Zm0D3ki1/IrEQiCUsv0+UkWVI07Uz/cx46VoKOsra8t9iDLL6f/vx
	06nNUi9PxMYdKaDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 45BDA137CF;
	Wed, 20 Nov 2024 11:57:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cR29EKzOPWfmAgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 20 Nov 2024 11:57:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E4D17A08E1; Wed, 20 Nov 2024 12:57:31 +0100 (CET)
Date: Wed, 20 Nov 2024 12:57:31 +0100
From: Jan Kara <jack@suse.cz>
To: Jim Zhao <jimzhao.ai@gmail.com>
Cc: jack@suse.cz, shikemeng@huaweicloud.com, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, willy@infradead.org
Subject: Re: [PATCH v2] mm/page-writeback: Raise wb_thresh to prevent write
 blocking with strictlimit
Message-ID: <20241120115731.gzxozbnb6eazhil7@quack3>
References: <20241119114444.3925495-1-jimzhao.ai@gmail.com>
 <20241119122922.3939538-1-jimzhao.ai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119122922.3939538-1-jimzhao.ai@gmail.com>
X-Rspamd-Queue-Id: 613F91F76E
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

Hello!

On Tue 19-11-24 20:29:22, Jim Zhao wrote:
> Thanks, Jan, I just sent patch v2, could you please review it ?

Yes, the patch looks good to me.

> 
> And I found the debug info in the bdi stats. 
> The BdiDirtyThresh value may be greater than DirtyThresh, and after
> applying this patch, the value of BdiDirtyThresh could become even
> larger.
> 
> without patch:
> ---
> root@ubuntu:/sys/kernel/debug/bdi/8:0# cat stats
> BdiWriteback:                0 kB
> BdiReclaimable:             96 kB
> BdiDirtyThresh:        1346824 kB

But this is odd. The machine appears to have around 3GB of memory, doesn't
it? I suspect this is caused by multiple cgroup-writeback contexts
contributing to BdiDirtyThresh - in fact I think the math in
bdi_collect_stats() is wrong as it is adding wb_thresh() calculated based
on global dirty_thresh for each cgwb whereas it should be adding
wb_thresh() calculated based on per-memcg dirty_thresh... You can have a
look at /sys/kernel/debug/bdi/8:0/wb_stats file which should have correct
limits as far as I'm reading the code.

								Honza

> DirtyThresh:            673412 kB
> BackgroundThresh:       336292 kB
> BdiDirtied:              19872 kB
> BdiWritten:              19776 kB
> BdiWriteBandwidth:           0 kBps
> b_dirty:                     0
> b_io:                        0
> b_more_io:                   0
> b_dirty_time:                0
> bdi_list:                    1
> state:                       1
> 
> with patch:
> ---
> root@ubuntu:/sys/kernel/debug/bdi/8:0# cat stats
> BdiWriteback:               96 kB
> BdiReclaimable:            192 kB
> BdiDirtyThresh:        3090736 kB
> DirtyThresh:            650716 kB
> BackgroundThresh:       324960 kB
> BdiDirtied:             472512 kB
> BdiWritten:             470592 kB
> BdiWriteBandwidth:      106268 kBps
> b_dirty:                     2
> b_io:                        0
> b_more_io:                   0
> b_dirty_time:                0
> bdi_list:                    1
> state:                       1
> 
> 
> @kemeng, is this a normal behavior or an issue ?
> 
> Thanks,
> Jim Zhao
> 
> 
> > With the strictlimit flag, wb_thresh acts as a hard limit in
> > balance_dirty_pages() and wb_position_ratio().  When device write
> > operations are inactive, wb_thresh can drop to 0, causing writes to be
> > blocked.  The issue occasionally occurs in fuse fs, particularly with
> > network backends, the write thread is blocked frequently during a period.
> > To address it, this patch raises the minimum wb_thresh to a controllable
> > level, similar to the non-strictlimit case.
> >
> > Signed-off-by: Jim Zhao <jimzhao.ai@gmail.com>
> > ---
> > Changes in v2:
> > 1. Consolidate all wb_thresh bumping logic in __wb_calc_thresh for consistency;
> > 2. Replace the limit variable with thresh for calculating the bump value,
> > as __wb_calc_thresh is also used to calculate the background threshold;
> > 3. Add domain_dirty_avail in wb_calc_thresh to get dtc->dirty.
> > ---
> >  mm/page-writeback.c | 48 ++++++++++++++++++++++-----------------------
> >  1 file changed, 23 insertions(+), 25 deletions(-)
> >
> > diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> > index e5a9eb795f99..8b13bcb42de3 100644
> > --- a/mm/page-writeback.c
> > +++ b/mm/page-writeback.c
> > @@ -917,7 +917,9 @@ static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc,
> >                                     unsigned long thresh)
> >  {
> >       struct wb_domain *dom = dtc_dom(dtc);
> > +     struct bdi_writeback *wb = dtc->wb;
> >       u64 wb_thresh;
> > +     u64 wb_max_thresh;
> >       unsigned long numerator, denominator;
> >       unsigned long wb_min_ratio, wb_max_ratio;
> >
> > @@ -931,11 +933,27 @@ static unsigned long __wb_calc_thresh(struct dirty_throttle_control *dtc,
> >       wb_thresh *= numerator;
> >       wb_thresh = div64_ul(wb_thresh, denominator);
> >
> > -     wb_min_max_ratio(dtc->wb, &wb_min_ratio, &wb_max_ratio);
> > +     wb_min_max_ratio(wb, &wb_min_ratio, &wb_max_ratio);
> >
> >       wb_thresh += (thresh * wb_min_ratio) / (100 * BDI_RATIO_SCALE);
> > -     if (wb_thresh > (thresh * wb_max_ratio) / (100 * BDI_RATIO_SCALE))
> > -             wb_thresh = thresh * wb_max_ratio / (100 * BDI_RATIO_SCALE);
> > +
> > +     /*
> > +      * It's very possible that wb_thresh is close to 0 not because the
> > +      * device is slow, but that it has remained inactive for long time.
> > +      * Honour such devices a reasonable good (hopefully IO efficient)
> > +      * threshold, so that the occasional writes won't be blocked and active
> > +      * writes can rampup the threshold quickly.
> > +      */
> > +     if (thresh > dtc->dirty) {
> > +             if (unlikely(wb->bdi->capabilities & BDI_CAP_STRICTLIMIT))
> > +                     wb_thresh = max(wb_thresh, (thresh - dtc->dirty) / 100);
> > +             else
> > +                     wb_thresh = max(wb_thresh, (thresh - dtc->dirty) / 8);
> > +     }
> > +
> > +     wb_max_thresh = thresh * wb_max_ratio / (100 * BDI_RATIO_SCALE);
> > +     if (wb_thresh > wb_max_thresh)
> > +             wb_thresh = wb_max_thresh;
> >
> >       return wb_thresh;
> >  }
> > @@ -944,6 +962,7 @@ unsigned long wb_calc_thresh(struct bdi_writeback *wb, unsigned long thresh)
> >  {
> >       struct dirty_throttle_control gdtc = { GDTC_INIT(wb) };
> >
> > +     domain_dirty_avail(&gdtc, true);
> >       return __wb_calc_thresh(&gdtc, thresh);
> >  }
> >
> > @@ -1120,12 +1139,6 @@ static void wb_position_ratio(struct dirty_throttle_control *dtc)
> >       if (unlikely(wb->bdi->capabilities & BDI_CAP_STRICTLIMIT)) {
> >               long long wb_pos_ratio;
> >
> > -             if (dtc->wb_dirty < 8) {
> > -                     dtc->pos_ratio = min_t(long long, pos_ratio * 2,
> > -                                        2 << RATELIMIT_CALC_SHIFT);
> > -                     return;
> > -             }
> > -
> >               if (dtc->wb_dirty >= wb_thresh)
> >                       return;
> >
> > @@ -1196,14 +1209,6 @@ static void wb_position_ratio(struct dirty_throttle_control *dtc)
> >        */
> >       if (unlikely(wb_thresh > dtc->thresh))
> >               wb_thresh = dtc->thresh;
> > -     /*
> > -      * It's very possible that wb_thresh is close to 0 not because the
> > -      * device is slow, but that it has remained inactive for long time.
> > -      * Honour such devices a reasonable good (hopefully IO efficient)
> > -      * threshold, so that the occasional writes won't be blocked and active
> > -      * writes can rampup the threshold quickly.
> > -      */
> > -     wb_thresh = max(wb_thresh, (limit - dtc->dirty) / 8);
> >       /*
> >        * scale global setpoint to wb's:
> >        *      wb_setpoint = setpoint * wb_thresh / thresh
> > @@ -1459,17 +1464,10 @@ static void wb_update_dirty_ratelimit(struct dirty_throttle_control *dtc,
> >        * balanced_dirty_ratelimit = task_ratelimit * write_bw / dirty_rate).
> >        * Hence, to calculate "step" properly, we have to use wb_dirty as
> >        * "dirty" and wb_setpoint as "setpoint".
> > -      *
> > -      * We rampup dirty_ratelimit forcibly if wb_dirty is low because
> > -      * it's possible that wb_thresh is close to zero due to inactivity
> > -      * of backing device.
> >        */
> >       if (unlikely(wb->bdi->capabilities & BDI_CAP_STRICTLIMIT)) {
> >               dirty = dtc->wb_dirty;
> > -             if (dtc->wb_dirty < 8)
> > -                     setpoint = dtc->wb_dirty + 1;
> > -             else
> > -                     setpoint = (dtc->wb_thresh + dtc->wb_bg_thresh) / 2;
> > +             setpoint = (dtc->wb_thresh + dtc->wb_bg_thresh) / 2;
> >       }
> >
> >       if (dirty < setpoint) {
> > --
> > 2.20.1
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

