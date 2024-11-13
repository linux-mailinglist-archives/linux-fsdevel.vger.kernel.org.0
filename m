Return-Path: <linux-fsdevel+bounces-34615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 477279C6C96
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 11:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54189B218EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 10:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491131FB898;
	Wed, 13 Nov 2024 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="U3iCofho";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="J4piauRe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="U3iCofho";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="J4piauRe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA041FB88C;
	Wed, 13 Nov 2024 10:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731492459; cv=none; b=Lonoy3GVgjS9uR5mE04aMJVrc8QlZZvk6a+MdOuuLM1WjYuZqNnM0+/UP4m4wgPVRQ5U0bTqHOieD10+wxRNKfXx9TgPxWhWel5QQGSAQI8REOum2V/mXh0rkU8PfSAvRYO4lO8zpoo36BpcP/OU6oFPEXCAoJrNX/e0FxZ8Gug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731492459; c=relaxed/simple;
	bh=TfEfL5QB3qr3TV5ukBVLmN6qxudBNUSoe7KPQY889jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwSYpdgvzZ2G42MpmRbkenp2OsUwQ7v4BQwSuLCPNRTWpAeIsjh0UXcyE/YdG2xkh3UkenEEvwhjNdkxRGyO7hqSpXck+rvAsSnM73YX8/pculQuQYUFpUhynmIB7BXj2uyYNlAd6fCju7uIbXpKTBqEVxZgb/SRd44KoVVCgQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=U3iCofho; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=J4piauRe; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=U3iCofho; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=J4piauRe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C9B101F37C;
	Wed, 13 Nov 2024 10:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731492455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BUaDYKCeAAV6mV6tt0Zz0KpJFThajAvpLku1YYcIo5o=;
	b=U3iCofhoVSj+GPDiplkLeswb4fN7oOcaTkJSMC4qybsG9dgqT1dMvZcv5RyGnV8HEadv7/
	zOUcRTO9scTbiiD6AOJ3azHYpwY8HJsNKeiQLuEHhU/ZRM/eH5qMXxOYGe/ZmYmdcdt/rp
	4Dmq4wEXqa06QgoQMCYYefCSKtHefLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731492455;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BUaDYKCeAAV6mV6tt0Zz0KpJFThajAvpLku1YYcIo5o=;
	b=J4piauReyh6Q1qZEqD4sgEnO3B0RSOEKf7J555hQpclGrbCjNbeE2Dvzk+n1e/MKpNR7Vt
	1NFCK1KD98g4OLAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731492455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BUaDYKCeAAV6mV6tt0Zz0KpJFThajAvpLku1YYcIo5o=;
	b=U3iCofhoVSj+GPDiplkLeswb4fN7oOcaTkJSMC4qybsG9dgqT1dMvZcv5RyGnV8HEadv7/
	zOUcRTO9scTbiiD6AOJ3azHYpwY8HJsNKeiQLuEHhU/ZRM/eH5qMXxOYGe/ZmYmdcdt/rp
	4Dmq4wEXqa06QgoQMCYYefCSKtHefLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731492455;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BUaDYKCeAAV6mV6tt0Zz0KpJFThajAvpLku1YYcIo5o=;
	b=J4piauReyh6Q1qZEqD4sgEnO3B0RSOEKf7J555hQpclGrbCjNbeE2Dvzk+n1e/MKpNR7Vt
	1NFCK1KD98g4OLAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B322013A6E;
	Wed, 13 Nov 2024 10:07:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lja8K2d6NGeeHgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 13 Nov 2024 10:07:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 643DBA08D0; Wed, 13 Nov 2024 11:07:35 +0100 (CET)
Date: Wed, 13 Nov 2024 11:07:35 +0100
From: Jan Kara <jack@suse.cz>
To: Jim Zhao <jimzhao.ai@gmail.com>
Cc: jack@suse.cz, akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	willy@infradead.org
Subject: Re: [PATCH] mm/page-writeback: Raise wb_thresh to prevent write
 blocking with strictlimit
Message-ID: <20241113100735.4jafa56p4td66z7a@quack3>
References: <20241108220215.s27rziym6mn5nzv4@quack3>
 <20241112084539.702485-1-jimzhao.ai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241112084539.702485-1-jimzhao.ai@gmail.com>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 12-11-24 16:45:39, Jim Zhao wrote:
> > On Fri 08-11-24 11:19:49, Jim Zhao wrote:
> > > > On Wed 23-10-24 18:00:32, Jim Zhao wrote:
> > > > > With the strictlimit flag, wb_thresh acts as a hard limit in
> > > > > balance_dirty_pages() and wb_position_ratio(). When device write
> > > > > operations are inactive, wb_thresh can drop to 0, causing writes to
> > > > > be blocked. The issue occasionally occurs in fuse fs, particularly
> > > > > with network backends, the write thread is blocked frequently during
> > > > > a period. To address it, this patch raises the minimum wb_thresh to a
> > > > > controllable level, similar to the non-strictlimit case.
> > > > >
> > > > > Signed-off-by: Jim Zhao <jimzhao.ai@gmail.com>
> > > >
> > > > ...
> > > >
> > > > > +       /*
> > > > > +        * With strictlimit flag, the wb_thresh is treated as
> > > > > +        * a hard limit in balance_dirty_pages() and wb_position_ratio().
> > > > > +        * It's possible that wb_thresh is close to zero, not because
> > > > > +        * the device is slow, but because it has been inactive.
> > > > > +        * To prevent occasional writes from being blocked, we raise wb_thresh.
> > > > > +        */
> > > > > +       if (unlikely(wb->bdi->capabilities & BDI_CAP_STRICTLIMIT)) {
> > > > > +               unsigned long limit = hard_dirty_limit(dom, dtc->thresh);
> > > > > +               u64 wb_scale_thresh = 0;
> > > > > +
> > > > > +               if (limit > dtc->dirty)
> > > > > +                       wb_scale_thresh = (limit - dtc->dirty) / 100;
> > > > > +               wb_thresh = max(wb_thresh, min(wb_scale_thresh, wb_max_thresh / 4));
> > > > > +       }
> > > >
> > > > What you propose makes sense in principle although I'd say this is mostly a
> > > > userspace setup issue - with strictlimit enabled, you're kind of expected
> > > > to set min_ratio exactly if you want to avoid these startup issues. But I
> > > > tend to agree that we can provide a bit of a slack for a bdi without
> > > > min_ratio configured to ramp up.
> > > >
> > > > But I'd rather pick the logic like:
> > > >
> > > >   /*
> > > >    * If bdi does not have min_ratio configured and it was inactive,
> > > >    * bump its min_ratio to 0.1% to provide it some room to ramp up.
> > > >    */
> > > >   if (!wb_min_ratio && !numerator)
> > > >           wb_min_ratio = min(BDI_RATIO_SCALE / 10, wb_max_ratio / 2);
> > > >
> > > > That would seem like a bit more systematic way than the formula you propose
> > > > above...
> > >
> > > Thanks for the advice.
> > > Here's the explanation of the formula:
> > > 1. when writes are small and intermittent，wb_thresh can approach 0, not
> > > just 0, making the numerator value difficult to verify.
> >
> > I see, ok.
> >
> > > 2. The ramp-up margin, whether 0.1% or another value, needs
> > > consideration.
> > > I based this on the logic of wb_position_ratio in the non-strictlimit
> > > scenario: wb_thresh = max(wb_thresh, (limit - dtc->dirty) / 8); It seems
> > > provides more room and ensures ramping up within a controllable range.
> >
> > I see, thanks for explanation. So I was thinking how to make the code more
> > consistent instead of adding another special constant and workaround. What
> > I'd suggest is:
> >
> > 1) There's already code that's supposed to handle ramping up with
> > strictlimit in wb_update_dirty_ratelimit():
> >
> >         /*
> >          * For strictlimit case, calculations above were based on wb counters
> >          * and limits (starting from pos_ratio = wb_position_ratio() and up to
> >          * balanced_dirty_ratelimit = task_ratelimit * write_bw / dirty_rate).
> >          * Hence, to calculate "step" properly, we have to use wb_dirty as
> >          * "dirty" and wb_setpoint as "setpoint".
> >          *
> >          * We rampup dirty_ratelimit forcibly if wb_dirty is low because
> >          * it's possible that wb_thresh is close to zero due to inactivity
> >          * of backing device.
> >          */
> >         if (unlikely(wb->bdi->capabilities & BDI_CAP_STRICTLIMIT)) {
> >                 dirty = dtc->wb_dirty;
> >                 if (dtc->wb_dirty < 8)
> >                         setpoint = dtc->wb_dirty + 1;
> >                 else
> >                         setpoint = (dtc->wb_thresh + dtc->wb_bg_thresh) / 2;
> >         }
> >
> > Now I agree that increasing wb_thresh directly is more understandable and
> > transparent so I'd just drop this special case.
> 
> yes, I agree.
> 
> > 2) I'd just handle all the bumping of wb_thresh in a single place instead
> > of having is spread over multiple places. So __wb_calc_thresh() could have
> > a code like:
> >
> >         wb_thresh = (thresh * (100 * BDI_RATIO_SCALE - bdi_min_ratio)) / (100 * BDI_RATIO_SCALE)
> >         wb_thresh *= numerator;
> >         wb_thresh = div64_ul(wb_thresh, denominator);
> >
> >         wb_min_max_ratio(dtc->wb, &wb_min_ratio, &wb_max_ratio);
> >
> >         wb_thresh += (thresh * wb_min_ratio) / (100 * BDI_RATIO_SCALE);
> >       limit = hard_dirty_limit(dtc_dom(dtc), dtc->thresh);
> >         /*
> >          * It's very possible that wb_thresh is close to 0 not because the
> >          * device is slow, but that it has remained inactive for long time.
> >          * Honour such devices a reasonable good (hopefully IO efficient)
> >          * threshold, so that the occasional writes won't be blocked and active
> >          * writes can rampup the threshold quickly.
> >          */
> >       if (limit > dtc->dirty)
> >               wb_thresh = max(wb_thresh, (limit - dtc->dirty) / 8);
> >       if (wb_thresh > (thresh * wb_max_ratio) / (100 * BDI_RATIO_SCALE))
> >               wb_thresh = thresh * wb_max_ratio / (100 * BDI_RATIO_SCALE);
> >
> > and we can drop the bumping from wb_position)_ratio(). This way have the
> > wb_thresh bumping in a single logical place. Since we still limit wb_tresh
> > with max_ratio, untrusted bdis for which max_ratio should be configured
> > (otherwise they can grow amount of dirty pages upto global treshold anyway)
> > are still under control.
> >
> > If we really wanted, we could introduce a different bumping in case of
> > strictlimit, but at this point I don't think it is warranted so I'd leave
> > that as an option if someone comes with a situation where this bumping
> > proves to be too aggressive.
> 
> Thank you, this is very helpful. And I have 2 concerns:
> 
> 1.
> In the current non-strictlimit logic, wb_thresh is only bumped within
> wb_position_ratio() for calculating pos_ratio, and this bump isn’t
> restricted by max_ratio.  I’m unsure if moving this adjustment to
> __wb_calc_thresh() would effect existing behavior.  Would it be possible
> to keep the current logic for non-strictlimit case?

You are correct that current bumping is not affected by max_ratio and that
is actually a bug. wb_thresh should never exceed what is corresponding to
the configured max_ratio. Furthermore in practical configurations I don't
think the max_ratio limiting will actually make a big difference because
bumping should happen when wb_thresh is really low. So for consistency I
would apply it also to the non-strictlimit case.

> 2. Regarding the formula:
> wb_thresh = max(wb_thresh, (limit - dtc->dirty) / 8);
> 
> Consider a case: 
> With 100 fuse devices(with high max_ratio) experiencing high writeback
> delays, the pages being written back are accounted in NR_WRITEBACK_TEMP,
> not dtc->dirty.  As a result, the bumped wb_thresh may remain high. While
> individual devices are under control, the total could exceed
> expectations.

I agree but this is a potential problem with any kind of bumping based on
'limit - dtc->dirty'. It is just a matter of how many fuse devices you have
and how exactly you have max_ratio configured.

> Although lowering the max_ratio can avoid this issue, how about reducing
> the bumped wb_thresh?
> 
> The formula in my patch:
> wb_scale_thresh = (limit - dtc->dirty) / 100;
> The intention is to use the default fuse max_ratio(1%) as the multiplier.

So basically you propose to use the "/ 8" factor for the normal case and "/
100" factor for the strictlimit case. My position is that I would not
complicate the logic unless somebody comes with a real world setup where
the simpler logic is causing real problems. But if you feel strongly about
this, I'm fine with that option.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

