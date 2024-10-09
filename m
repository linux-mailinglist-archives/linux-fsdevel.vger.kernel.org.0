Return-Path: <linux-fsdevel+bounces-31452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83407996ED8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 16:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13B8C1F21CFF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 14:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1B51A00C9;
	Wed,  9 Oct 2024 14:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZJ9TgKjH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hia5RO0D";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZJ9TgKjH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hia5RO0D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFF3199E8C;
	Wed,  9 Oct 2024 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485722; cv=none; b=ldx+gEv+NXh2M/BPF2pTxts7lV+3rw7NfSA1oakN1fN4WrBI3pe/c3P4Ugv02LElgw3PFDKnJ6EE3RiXSMOl1aQUZvaK1NGmtRYfBMbJNilnPFd4uWEsPy3Sn7OCvMx5YwIDa6zMM/baZ0ZtPxlIat0ayLSB5g3FIjJGDvFnpdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485722; c=relaxed/simple;
	bh=dQ74uOIsA6iqlSUG/Js/0gIXFRGTJTUkhLtj9S0GdLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfO/W/E8Pmzt0lKwetFxmQ7wGHJ0/jxH7nMdDclUNeA9ryxpUpor+x1wxsTlGNxp0n++WIRSXabetDqjcDWSF0bSEUmymAzo0hXXEnkuCdVFOguAt5PKzYz5smEIflusVjrpCkIMgJWRRcqX4ULBk2cI62TPgN93sUh1uWvx4kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZJ9TgKjH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hia5RO0D; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZJ9TgKjH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hia5RO0D; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9B1301F823;
	Wed,  9 Oct 2024 14:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728485705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/wNkRSgMEBFmbf3VBe2Yls7JA2XVD8KU/URoZo9DSqE=;
	b=ZJ9TgKjHM7JqnTBECZAfgcL0bjvHDafo05LkhOksLlWRhcbIpIki6YFrbrKj7khr7D4u5i
	WeM+zSc36J1SgIboZhIg0gVnIREH98Vg1Lz2pPkzH+3SmlnIxXUONhM3fYVRa2Efx9ZeSa
	Fi45gsSyW4qDOpgC10wJi8qJW602Jk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728485705;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/wNkRSgMEBFmbf3VBe2Yls7JA2XVD8KU/URoZo9DSqE=;
	b=Hia5RO0DVW4Qh4AQhap8Plw4J6y9Ni7a+eXgNFw/PRZOzQiOpYe6vHMIE4Spudyg+Rlm4z
	IyAaj8V1+GOub4AQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZJ9TgKjH;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Hia5RO0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728485705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/wNkRSgMEBFmbf3VBe2Yls7JA2XVD8KU/URoZo9DSqE=;
	b=ZJ9TgKjHM7JqnTBECZAfgcL0bjvHDafo05LkhOksLlWRhcbIpIki6YFrbrKj7khr7D4u5i
	WeM+zSc36J1SgIboZhIg0gVnIREH98Vg1Lz2pPkzH+3SmlnIxXUONhM3fYVRa2Efx9ZeSa
	Fi45gsSyW4qDOpgC10wJi8qJW602Jk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728485705;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/wNkRSgMEBFmbf3VBe2Yls7JA2XVD8KU/URoZo9DSqE=;
	b=Hia5RO0DVW4Qh4AQhap8Plw4J6y9Ni7a+eXgNFw/PRZOzQiOpYe6vHMIE4Spudyg+Rlm4z
	IyAaj8V1+GOub4AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8EBA5136BA;
	Wed,  9 Oct 2024 14:55:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lzPtIkmZBmcKTQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 09 Oct 2024 14:55:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4A76AA0896; Wed,  9 Oct 2024 16:55:05 +0200 (CEST)
Date: Wed, 9 Oct 2024 16:55:05 +0200
From: Jan Kara <jack@suse.cz>
To: Tang Yizhou <yizhou.tang@shopee.com>
Cc: Jan Kara <jack@suse.cz>, willy@infradead.org, akpm@linux-foundation.org,
	chandan.babu@oracle.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/page-writeback.c: Rename BANDWIDTH_INTERVAL to
 UPDATE_INTERVAL
Message-ID: <20241009145505.5ol3mushw6uqjefc@quack3>
References: <20241002130004.69010-1-yizhou.tang@shopee.com>
 <20241002130004.69010-2-yizhou.tang@shopee.com>
 <20241003130127.45kinxoh77xm5qfb@quack3>
 <CACuPKxmwZgNx242x5HgTUCpu6v6QC3XtFY2ZDOE-mcu=ARK=Ag@mail.gmail.com>
 <20241007162311.77r5rra2tdhzszek@quack3>
 <CACuPKx=-wmNOHbHFEqYEwnw6X7uzaZ+JU7pHqG+FCsAgKjePnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACuPKx=-wmNOHbHFEqYEwnw6X7uzaZ+JU7pHqG+FCsAgKjePnQ@mail.gmail.com>
X-Rspamd-Queue-Id: 9B1301F823
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email,suse.cz:dkim];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 08-10-24 22:14:16, Tang Yizhou wrote:
> On Tue, Oct 8, 2024 at 12:23 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Sun 06-10-24 20:41:11, Tang Yizhou wrote:
> > > On Thu, Oct 3, 2024 at 9:01 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > On Wed 02-10-24 21:00:02, Tang Yizhou wrote:
> > > > > From: Tang Yizhou <yizhou.tang@shopee.com>
> > > > >
> > > > > The name of the BANDWIDTH_INTERVAL macro is misleading, as it is not
> > > > > only used in the bandwidth update functions wb_update_bandwidth() and
> > > > > __wb_update_bandwidth(), but also in the dirty limit update function
> > > > > domain_update_dirty_limit().
> > > > >
> > > > > Rename BANDWIDTH_INTERVAL to UPDATE_INTERVAL to make things clear.
> > > > >
> > > > > This patche doesn't introduce any behavioral changes.
> > > > >
> > > > > Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
> > > >
> > > > Umm, I agree BANDWIDTH_INTERVAL may be confusing but UPDATE_INTERVAL does
> > > > not seem much better to be honest. I actually have hard time coming up with
> > > > a more descriptive name so what if we settled on updating the comment only
> > > > instead of renaming to something not much better?
> > > >
> > > >                                                                 Honza
> > >
> > > Thank you for your review. I agree that UPDATE_INTERVAL is not a good
> > > name. How about
> > > renaming it to BW_DIRTYLIMIT_INTERVAL?
> >
> > Maybe WB_STAT_INTERVAL? Because it is interval in which we maintain
> > statistics about writeback behavior.
> >
> 
> I don't think this is a good name, as it suggests a relation to enum
> wb_stat_item, but bandwidth and dirty limit are not in wb_stat_item.

OK, so how about keeping BANDWIDTH_INTERVAL as is and adding
DIRTY_LIMIT_INTERVAL with the same value? There's nothing which would
strictly tie them to the same value.

								Honza

> > > > > ---
> > > > >  mm/page-writeback.c | 16 ++++++++--------
> > > > >  1 file changed, 8 insertions(+), 8 deletions(-)
> > > > >
> > > > > diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> > > > > index fcd4c1439cb9..a848e7f0719d 100644
> > > > > --- a/mm/page-writeback.c
> > > > > +++ b/mm/page-writeback.c
> > > > > @@ -54,9 +54,9 @@
> > > > >  #define DIRTY_POLL_THRESH    (128 >> (PAGE_SHIFT - 10))
> > > > >
> > > > >  /*
> > > > > - * Estimate write bandwidth at 200ms intervals.
> > > > > + * Estimate write bandwidth or update dirty limit at 200ms intervals.
> > > > >   */
> > > > > -#define BANDWIDTH_INTERVAL   max(HZ/5, 1)
> > > > > +#define UPDATE_INTERVAL              max(HZ/5, 1)
> > > > >
> > > > >  #define RATELIMIT_CALC_SHIFT 10
> > > > >
> > > > > @@ -1331,11 +1331,11 @@ static void domain_update_dirty_limit(struct dirty_throttle_control *dtc,
> > > > >       /*
> > > > >        * check locklessly first to optimize away locking for the most time
> > > > >        */
> > > > > -     if (time_before(now, dom->dirty_limit_tstamp + BANDWIDTH_INTERVAL))
> > > > > +     if (time_before(now, dom->dirty_limit_tstamp + UPDATE_INTERVAL))
> > > > >               return;
> > > > >
> > > > >       spin_lock(&dom->lock);
> > > > > -     if (time_after_eq(now, dom->dirty_limit_tstamp + BANDWIDTH_INTERVAL)) {
> > > > > +     if (time_after_eq(now, dom->dirty_limit_tstamp + UPDATE_INTERVAL)) {
> > > > >               update_dirty_limit(dtc);
> > > > >               dom->dirty_limit_tstamp = now;
> > > > >       }
> > > > > @@ -1928,7 +1928,7 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
> > > > >               wb->dirty_exceeded = gdtc->dirty_exceeded ||
> > > > >                                    (mdtc && mdtc->dirty_exceeded);
> > > > >               if (time_is_before_jiffies(READ_ONCE(wb->bw_time_stamp) +
> > > > > -                                        BANDWIDTH_INTERVAL))
> > > > > +                                        UPDATE_INTERVAL))
> > > > >                       __wb_update_bandwidth(gdtc, mdtc, true);
> > > > >
> > > > >               /* throttle according to the chosen dtc */
> > > > > @@ -2705,7 +2705,7 @@ int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
> > > > >        * writeback bandwidth is updated once in a while.
> > > > >        */
> > > > >       if (time_is_before_jiffies(READ_ONCE(wb->bw_time_stamp) +
> > > > > -                                BANDWIDTH_INTERVAL))
> > > > > +                                UPDATE_INTERVAL))
> > > > >               wb_update_bandwidth(wb);
> > > > >       return ret;
> > > > >  }
> > > > > @@ -3057,14 +3057,14 @@ static void wb_inode_writeback_end(struct bdi_writeback *wb)
> > > > >       atomic_dec(&wb->writeback_inodes);
> > > > >       /*
> > > > >        * Make sure estimate of writeback throughput gets updated after
> > > > > -      * writeback completed. We delay the update by BANDWIDTH_INTERVAL
> > > > > +      * writeback completed. We delay the update by UPDATE_INTERVAL
> > > > >        * (which is the interval other bandwidth updates use for batching) so
> > > > >        * that if multiple inodes end writeback at a similar time, they get
> > > > >        * batched into one bandwidth update.
> > > > >        */
> > > > >       spin_lock_irqsave(&wb->work_lock, flags);
> > > > >       if (test_bit(WB_registered, &wb->state))
> > > > > -             queue_delayed_work(bdi_wq, &wb->bw_dwork, BANDWIDTH_INTERVAL);
> > > > > +             queue_delayed_work(bdi_wq, &wb->bw_dwork, UPDATE_INTERVAL);
> > > > >       spin_unlock_irqrestore(&wb->work_lock, flags);
> > > > >  }
> > > > >
> > > > > --
> > > > > 2.25.1
> > > > >
> > > > >
> > > > --
> > > > Jan Kara <jack@suse.com>
> > > > SUSE Labs, CR
> > --
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

