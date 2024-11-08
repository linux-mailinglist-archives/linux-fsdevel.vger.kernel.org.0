Return-Path: <linux-fsdevel+bounces-34143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCB79C2F38
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 19:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 178B1280FEE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Nov 2024 18:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA8519F487;
	Sat,  9 Nov 2024 18:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IwxKlBUn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cu3h4u0n";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IwxKlBUn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cu3h4u0n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EABB19ADB0;
	Sat,  9 Nov 2024 18:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731178415; cv=none; b=gaG60d99ekux58ePD8J0MqE3UyO8chE1pWw0PkdF7OlXDwpgTPEjiYoadmhzcXJ8U9zPX+MuRhscXKdKdaNfWZlaW2TVG6uf91d2nQKWPZILv7C/Sp0HK+gkw1YhpLeLKvVjgDW2Hmr1RYtvcRR4JgD6W1cPRqUzTFLJCoDzpDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731178415; c=relaxed/simple;
	bh=h63eq/lTXwjS4BBkrropecGQi6HzYaFEygfbUAuM0Qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIPMLFQxFKaHnVLIfNII87GllpPDPgNyjg0MpqwXKTw/zytk2JyjSMXk6RrLjtuAYJiG1MFQDOFrdSyn7eJYtyUVjxWctun4DEEMxU+YBt/FK8cozQkT7gVnzcuEJspAYdZL85909a5tatWfv42/XBDWUPHK3GC3SHRHLpj+noo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IwxKlBUn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cu3h4u0n; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IwxKlBUn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cu3h4u0n; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 00B2E1F388;
	Sat,  9 Nov 2024 18:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731178411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1CrzPv2zaSwzQWUisXpEjsqCejF07itT1upqPWYCl5Y=;
	b=IwxKlBUntynAt0VjCIuWuAIGpQyiK7PPdFBahQOk1LtjgQZQf/nBPK3l6JQd0KriPzkPxY
	mhsbtGQ45hK7/Ict+XROckUTI4WosacDs4nU/q2OLKwGE5x0/dOH08DngprstYW820+aD2
	TeDYJo8oyH5JM2SRdImQoJGbxqqvPMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731178411;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1CrzPv2zaSwzQWUisXpEjsqCejF07itT1upqPWYCl5Y=;
	b=cu3h4u0nWnE2k7coIl6a1BsZrk76sS2yIA5BVFuOgp4bXhHJvXyeLwY3SXy/wgoNoL67pk
	BREAK6mUb1TAVeAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=IwxKlBUn;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cu3h4u0n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731178411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1CrzPv2zaSwzQWUisXpEjsqCejF07itT1upqPWYCl5Y=;
	b=IwxKlBUntynAt0VjCIuWuAIGpQyiK7PPdFBahQOk1LtjgQZQf/nBPK3l6JQd0KriPzkPxY
	mhsbtGQ45hK7/Ict+XROckUTI4WosacDs4nU/q2OLKwGE5x0/dOH08DngprstYW820+aD2
	TeDYJo8oyH5JM2SRdImQoJGbxqqvPMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731178411;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1CrzPv2zaSwzQWUisXpEjsqCejF07itT1upqPWYCl5Y=;
	b=cu3h4u0nWnE2k7coIl6a1BsZrk76sS2yIA5BVFuOgp4bXhHJvXyeLwY3SXy/wgoNoL67pk
	BREAK6mUb1TAVeAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4083136CC;
	Sat,  9 Nov 2024 18:53:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EYQHN6qvL2dmPQAAD6G6ig
	(envelope-from <jack@suse.cz>); Sat, 09 Nov 2024 18:53:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9C8DCA083F; Fri,  8 Nov 2024 23:02:15 +0100 (CET)
Date: Fri, 8 Nov 2024 23:02:15 +0100
From: Jan Kara <jack@suse.cz>
To: Jim Zhao <jimzhao.ai@gmail.com>
Cc: jack@suse.cz, akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	willy@infradead.org
Subject: Re: [PATCH] mm/page-writeback: Raise wb_thresh to prevent write
 blocking with strictlimit
Message-ID: <20241108220215.s27rziym6mn5nzv4@quack3>
References: <20241107153217.j6kwfgihzhj33dia@quack3>
 <20241108031949.2984319-1-jimzhao.ai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241108031949.2984319-1-jimzhao.ai@gmail.com>
X-Rspamd-Queue-Id: 00B2E1F388
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Fri 08-11-24 11:19:49, Jim Zhao wrote:
> > On Wed 23-10-24 18:00:32, Jim Zhao wrote:
> > > With the strictlimit flag, wb_thresh acts as a hard limit in
> > > balance_dirty_pages() and wb_position_ratio(). When device write
> > > operations are inactive, wb_thresh can drop to 0, causing writes to
> > > be blocked. The issue occasionally occurs in fuse fs, particularly
> > > with network backends, the write thread is blocked frequently during
> > > a period. To address it, this patch raises the minimum wb_thresh to a
> > > controllable level, similar to the non-strictlimit case.
> > > 
> > > Signed-off-by: Jim Zhao <jimzhao.ai@gmail.com>
> > 
> > ...
> > 
> > > +	/*
> > > +	 * With strictlimit flag, the wb_thresh is treated as
> > > +	 * a hard limit in balance_dirty_pages() and wb_position_ratio().
> > > +	 * It's possible that wb_thresh is close to zero, not because
> > > +	 * the device is slow, but because it has been inactive.
> > > +	 * To prevent occasional writes from being blocked, we raise wb_thresh.
> > > +	 */
> > > +	if (unlikely(wb->bdi->capabilities & BDI_CAP_STRICTLIMIT)) {
> > > +		unsigned long limit = hard_dirty_limit(dom, dtc->thresh);
> > > +		u64 wb_scale_thresh = 0;
> > > +
> > > +		if (limit > dtc->dirty)
> > > +			wb_scale_thresh = (limit - dtc->dirty) / 100;
> > > +		wb_thresh = max(wb_thresh, min(wb_scale_thresh, wb_max_thresh / 4));
> > > +	}
> > 
> > What you propose makes sense in principle although I'd say this is mostly a
> > userspace setup issue - with strictlimit enabled, you're kind of expected
> > to set min_ratio exactly if you want to avoid these startup issues. But I
> > tend to agree that we can provide a bit of a slack for a bdi without
> > min_ratio configured to ramp up.
> > 
> > But I'd rather pick the logic like:
> > 
> > 	/*
> > 	 * If bdi does not have min_ratio configured and it was inactive,
> > 	 * bump its min_ratio to 0.1% to provide it some room to ramp up.
> > 	 */
> > 	if (!wb_min_ratio && !numerator)
> > 		wb_min_ratio = min(BDI_RATIO_SCALE / 10, wb_max_ratio / 2);
> > 
> > That would seem like a bit more systematic way than the formula you propose
> > above...
> 
> Thanks for the advice.
> Here's the explanation of the formula:
> 1. when writes are small and intermittent，wb_thresh can approach 0, not
> just 0, making the numerator value difficult to verify.

I see, ok.

> 2. The ramp-up margin, whether 0.1% or another value, needs
> consideration.
> I based this on the logic of wb_position_ratio in the non-strictlimit
> scenario: wb_thresh = max(wb_thresh, (limit - dtc->dirty) / 8); It seems
> provides more room and ensures ramping up within a controllable range.

I see, thanks for explanation. So I was thinking how to make the code more
consistent instead of adding another special constant and workaround. What
I'd suggest is:

1) There's already code that's supposed to handle ramping up with
strictlimit in wb_update_dirty_ratelimit():

        /*
         * For strictlimit case, calculations above were based on wb counters
         * and limits (starting from pos_ratio = wb_position_ratio() and up to
         * balanced_dirty_ratelimit = task_ratelimit * write_bw / dirty_rate).
         * Hence, to calculate "step" properly, we have to use wb_dirty as
         * "dirty" and wb_setpoint as "setpoint".
         *
         * We rampup dirty_ratelimit forcibly if wb_dirty is low because
         * it's possible that wb_thresh is close to zero due to inactivity
         * of backing device.
         */
        if (unlikely(wb->bdi->capabilities & BDI_CAP_STRICTLIMIT)) {
                dirty = dtc->wb_dirty;
                if (dtc->wb_dirty < 8)
                        setpoint = dtc->wb_dirty + 1;
                else
                        setpoint = (dtc->wb_thresh + dtc->wb_bg_thresh) / 2;
        }

Now I agree that increasing wb_thresh directly is more understandable and
transparent so I'd just drop this special case.

2) I'd just handle all the bumping of wb_thresh in a single place instead
of having is spread over multiple places. So __wb_calc_thresh() could have
a code like:

        wb_thresh = (thresh * (100 * BDI_RATIO_SCALE - bdi_min_ratio)) / (100 * BDI_RATIO_SCALE)
        wb_thresh *= numerator;
        wb_thresh = div64_ul(wb_thresh, denominator);

        wb_min_max_ratio(dtc->wb, &wb_min_ratio, &wb_max_ratio);

        wb_thresh += (thresh * wb_min_ratio) / (100 * BDI_RATIO_SCALE);
	limit = hard_dirty_limit(dtc_dom(dtc), dtc->thresh);
        /*
         * It's very possible that wb_thresh is close to 0 not because the
         * device is slow, but that it has remained inactive for long time.
         * Honour such devices a reasonable good (hopefully IO efficient)
         * threshold, so that the occasional writes won't be blocked and active
         * writes can rampup the threshold quickly.
         */
	if (limit > dtc->dirty)
		wb_thresh = max(wb_thresh, (limit - dtc->dirty) / 8);
	if (wb_thresh > (thresh * wb_max_ratio) / (100 * BDI_RATIO_SCALE))
		wb_thresh = thresh * wb_max_ratio / (100 * BDI_RATIO_SCALE);

and we can drop the bumping from wb_position)_ratio(). This way have the
wb_thresh bumping in a single logical place. Since we still limit wb_tresh
with max_ratio, untrusted bdis for which max_ratio should be configured
(otherwise they can grow amount of dirty pages upto global treshold anyway)
are still under control.

If we really wanted, we could introduce a different bumping in case of
strictlimit, but at this point I don't think it is warranted so I'd leave
that as an option if someone comes with a situation where this bumping
proves to be too aggressive.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

