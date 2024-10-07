Return-Path: <linux-fsdevel+bounces-31217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 865B3993304
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 18:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59AB41C229D7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 16:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72251DA62C;
	Mon,  7 Oct 2024 16:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="liECcmm1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gkJLSa+J";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="liECcmm1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gkJLSa+J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715EA1D9673;
	Mon,  7 Oct 2024 16:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728318203; cv=none; b=ZvL8LEB6Y8EwYfSGiJgak85JY1Bqi5TL7Ntk08DL8XLwtLMP5ynYvYJOOTK01kNJw2yvr/j0eb5JOz+L4jS23GcKyjBIBbMRyoJcx0TB3q8KgxyYSxVwj2NzCAHylF1XCVHMeMYPvbhV8rHNQwLoLcha+2uP6JRITfRoqykIv6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728318203; c=relaxed/simple;
	bh=vrzdlFeCjprI8T3iVcnGnLDLZN+XRgBxaHxpBktItlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JhqDyNr7TBa8T+fwGv8JnWXC7pbNl2nZk7ywwYUTj6SiXBr6MTWM66PZtNAIzhTSvX4r48bp3fBJjnfRzJoOM/OdQiS3YsLe8vSoBecghM+z2g7H46eBFgPALm4ZaoEIP8OkTW1JFR8gviPDEuPjcUAsZuksWGt3qwPdgLvegc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=liECcmm1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gkJLSa+J; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=liECcmm1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gkJLSa+J; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8D13F21BA7;
	Mon,  7 Oct 2024 16:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728318199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FULVdtLgJ2GY/aWi+tpi8/PNetHdEH/nx3KLO2yF7ng=;
	b=liECcmm1FXfKVrEt5m/8q/OzhLbINpwsz0i3SW1VMdY7p2kVlQjVFmzEUQnZ8lDdU8rloY
	dt7A/iV+Aw1S2Fv7QM3vAdo9LTkMLExa1QYjZDDzE5QmiMkPIpNK8W/vz6Kv6duE6m3/LP
	PWRjnqRjoEE6gGNtfDlDpWNY00tN71Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728318199;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FULVdtLgJ2GY/aWi+tpi8/PNetHdEH/nx3KLO2yF7ng=;
	b=gkJLSa+JrHyUx1s57MHLBjcSz0IyWJlsbF6hGLKhmsC6m0RLDcV2lb8fGdfCxXPHMGtyGp
	pHitEoYjACC+cOBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=liECcmm1;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gkJLSa+J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728318199; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FULVdtLgJ2GY/aWi+tpi8/PNetHdEH/nx3KLO2yF7ng=;
	b=liECcmm1FXfKVrEt5m/8q/OzhLbINpwsz0i3SW1VMdY7p2kVlQjVFmzEUQnZ8lDdU8rloY
	dt7A/iV+Aw1S2Fv7QM3vAdo9LTkMLExa1QYjZDDzE5QmiMkPIpNK8W/vz6Kv6duE6m3/LP
	PWRjnqRjoEE6gGNtfDlDpWNY00tN71Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728318199;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FULVdtLgJ2GY/aWi+tpi8/PNetHdEH/nx3KLO2yF7ng=;
	b=gkJLSa+JrHyUx1s57MHLBjcSz0IyWJlsbF6hGLKhmsC6m0RLDcV2lb8fGdfCxXPHMGtyGp
	pHitEoYjACC+cOBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8056B13786;
	Mon,  7 Oct 2024 16:23:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f/xPH/cKBGdpIgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 07 Oct 2024 16:23:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 374F9A07D0; Mon,  7 Oct 2024 18:23:11 +0200 (CEST)
Date: Mon, 7 Oct 2024 18:23:11 +0200
From: Jan Kara <jack@suse.cz>
To: Tang Yizhou <yizhou.tang@shopee.com>
Cc: Jan Kara <jack@suse.cz>, willy@infradead.org, akpm@linux-foundation.org,
	chandan.babu@oracle.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/page-writeback.c: Rename BANDWIDTH_INTERVAL to
 UPDATE_INTERVAL
Message-ID: <20241007162311.77r5rra2tdhzszek@quack3>
References: <20241002130004.69010-1-yizhou.tang@shopee.com>
 <20241002130004.69010-2-yizhou.tang@shopee.com>
 <20241003130127.45kinxoh77xm5qfb@quack3>
 <CACuPKxmwZgNx242x5HgTUCpu6v6QC3XtFY2ZDOE-mcu=ARK=Ag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACuPKxmwZgNx242x5HgTUCpu6v6QC3XtFY2ZDOE-mcu=ARK=Ag@mail.gmail.com>
X-Rspamd-Queue-Id: 8D13F21BA7
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
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

On Sun 06-10-24 20:41:11, Tang Yizhou wrote:
> On Thu, Oct 3, 2024 at 9:01 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 02-10-24 21:00:02, Tang Yizhou wrote:
> > > From: Tang Yizhou <yizhou.tang@shopee.com>
> > >
> > > The name of the BANDWIDTH_INTERVAL macro is misleading, as it is not
> > > only used in the bandwidth update functions wb_update_bandwidth() and
> > > __wb_update_bandwidth(), but also in the dirty limit update function
> > > domain_update_dirty_limit().
> > >
> > > Rename BANDWIDTH_INTERVAL to UPDATE_INTERVAL to make things clear.
> > >
> > > This patche doesn't introduce any behavioral changes.
> > >
> > > Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
> >
> > Umm, I agree BANDWIDTH_INTERVAL may be confusing but UPDATE_INTERVAL does
> > not seem much better to be honest. I actually have hard time coming up with
> > a more descriptive name so what if we settled on updating the comment only
> > instead of renaming to something not much better?
> >
> >                                                                 Honza
> 
> Thank you for your review. I agree that UPDATE_INTERVAL is not a good
> name. How about
> renaming it to BW_DIRTYLIMIT_INTERVAL?

Maybe WB_STAT_INTERVAL? Because it is interval in which we maintain
statistics about writeback behavior.

								Honza

> > > ---
> > >  mm/page-writeback.c | 16 ++++++++--------
> > >  1 file changed, 8 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> > > index fcd4c1439cb9..a848e7f0719d 100644
> > > --- a/mm/page-writeback.c
> > > +++ b/mm/page-writeback.c
> > > @@ -54,9 +54,9 @@
> > >  #define DIRTY_POLL_THRESH    (128 >> (PAGE_SHIFT - 10))
> > >
> > >  /*
> > > - * Estimate write bandwidth at 200ms intervals.
> > > + * Estimate write bandwidth or update dirty limit at 200ms intervals.
> > >   */
> > > -#define BANDWIDTH_INTERVAL   max(HZ/5, 1)
> > > +#define UPDATE_INTERVAL              max(HZ/5, 1)
> > >
> > >  #define RATELIMIT_CALC_SHIFT 10
> > >
> > > @@ -1331,11 +1331,11 @@ static void domain_update_dirty_limit(struct dirty_throttle_control *dtc,
> > >       /*
> > >        * check locklessly first to optimize away locking for the most time
> > >        */
> > > -     if (time_before(now, dom->dirty_limit_tstamp + BANDWIDTH_INTERVAL))
> > > +     if (time_before(now, dom->dirty_limit_tstamp + UPDATE_INTERVAL))
> > >               return;
> > >
> > >       spin_lock(&dom->lock);
> > > -     if (time_after_eq(now, dom->dirty_limit_tstamp + BANDWIDTH_INTERVAL)) {
> > > +     if (time_after_eq(now, dom->dirty_limit_tstamp + UPDATE_INTERVAL)) {
> > >               update_dirty_limit(dtc);
> > >               dom->dirty_limit_tstamp = now;
> > >       }
> > > @@ -1928,7 +1928,7 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
> > >               wb->dirty_exceeded = gdtc->dirty_exceeded ||
> > >                                    (mdtc && mdtc->dirty_exceeded);
> > >               if (time_is_before_jiffies(READ_ONCE(wb->bw_time_stamp) +
> > > -                                        BANDWIDTH_INTERVAL))
> > > +                                        UPDATE_INTERVAL))
> > >                       __wb_update_bandwidth(gdtc, mdtc, true);
> > >
> > >               /* throttle according to the chosen dtc */
> > > @@ -2705,7 +2705,7 @@ int do_writepages(struct address_space *mapping, struct writeback_control *wbc)
> > >        * writeback bandwidth is updated once in a while.
> > >        */
> > >       if (time_is_before_jiffies(READ_ONCE(wb->bw_time_stamp) +
> > > -                                BANDWIDTH_INTERVAL))
> > > +                                UPDATE_INTERVAL))
> > >               wb_update_bandwidth(wb);
> > >       return ret;
> > >  }
> > > @@ -3057,14 +3057,14 @@ static void wb_inode_writeback_end(struct bdi_writeback *wb)
> > >       atomic_dec(&wb->writeback_inodes);
> > >       /*
> > >        * Make sure estimate of writeback throughput gets updated after
> > > -      * writeback completed. We delay the update by BANDWIDTH_INTERVAL
> > > +      * writeback completed. We delay the update by UPDATE_INTERVAL
> > >        * (which is the interval other bandwidth updates use for batching) so
> > >        * that if multiple inodes end writeback at a similar time, they get
> > >        * batched into one bandwidth update.
> > >        */
> > >       spin_lock_irqsave(&wb->work_lock, flags);
> > >       if (test_bit(WB_registered, &wb->state))
> > > -             queue_delayed_work(bdi_wq, &wb->bw_dwork, BANDWIDTH_INTERVAL);
> > > +             queue_delayed_work(bdi_wq, &wb->bw_dwork, UPDATE_INTERVAL);
> > >       spin_unlock_irqrestore(&wb->work_lock, flags);
> > >  }
> > >
> > > --
> > > 2.25.1
> > >
> > >
> > --
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

