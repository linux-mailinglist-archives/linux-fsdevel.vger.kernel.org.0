Return-Path: <linux-fsdevel+bounces-39825-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A374A18E37
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 10:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E59501889498
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 09:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53C520FA9E;
	Wed, 22 Jan 2025 09:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0QH5If6x";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vtGBVGb7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0QH5If6x";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vtGBVGb7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA0D17C220
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 09:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737537771; cv=none; b=HMqQMGIyTkG2b3vfDe7FG3NANY2VaThUEskjMrXf7VDcBcKgqGBrqXCJwCI8DiAPK6/HmYsSMuEOAKhVw8i5igTCC/S+2VtighWPClls7nx4/UZrvytx+QFYpMqKADhw4EiuA7/kwi2L8q0a4jfew9lzoaJoxITskrwwNmv/y6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737537771; c=relaxed/simple;
	bh=yYgyQzdkMXxWkakYv0f7wbDal6nEFNE5qw/Oou0A1xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXyMjosb8YCpw5KY/aTi5ZxV0/ELATUVmxNxnOwTEvieJ/2ysgVHRKRH/rCbWN0gQX/LQxct6FY1pEh1vMnDotmSMkkETNWmQYhAdY+M/nXATAT29SKPSCRtE4OtUo58apj/+MbzgOefPgrrkS65XPkCtKcGRzHiTNCsYoRWrRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0QH5If6x; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vtGBVGb7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0QH5If6x; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vtGBVGb7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C3CE32124D;
	Wed, 22 Jan 2025 09:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737537766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yU8+uGuEP8rUlgMpA7oGK2ff4J2sNYY+AUnJ0O5nvek=;
	b=0QH5If6xdzP6/4yb027KIgEWRMQ2yhbUVlJCJ1XKK/MW+jsMy1rmaka3Wpr/lgFCpT28ND
	d7Q+hj4XOh8SSm0E6w6X3bS6QJhknnQxGEfcFTBZ+Mn6JGypEU5dzWBxcm5ZSPyLK/16r5
	oPNc0zSGaiy+xz72FZSgAEj8tjYZZgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737537766;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yU8+uGuEP8rUlgMpA7oGK2ff4J2sNYY+AUnJ0O5nvek=;
	b=vtGBVGb7ikG8MhhptZ7LPGJLaLUhbC5tzp4lj/iWAA8UvkdwToejU4slXJWKe8JFj6knwt
	UmXD9MQlflfz4AAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737537766; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yU8+uGuEP8rUlgMpA7oGK2ff4J2sNYY+AUnJ0O5nvek=;
	b=0QH5If6xdzP6/4yb027KIgEWRMQ2yhbUVlJCJ1XKK/MW+jsMy1rmaka3Wpr/lgFCpT28ND
	d7Q+hj4XOh8SSm0E6w6X3bS6QJhknnQxGEfcFTBZ+Mn6JGypEU5dzWBxcm5ZSPyLK/16r5
	oPNc0zSGaiy+xz72FZSgAEj8tjYZZgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737537766;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yU8+uGuEP8rUlgMpA7oGK2ff4J2sNYY+AUnJ0O5nvek=;
	b=vtGBVGb7ikG8MhhptZ7LPGJLaLUhbC5tzp4lj/iWAA8UvkdwToejU4slXJWKe8JFj6knwt
	UmXD9MQlflfz4AAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B537E1397D;
	Wed, 22 Jan 2025 09:22:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HGv5K+a4kGcLXAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 22 Jan 2025 09:22:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 582BBA081E; Wed, 22 Jan 2025 10:22:42 +0100 (CET)
Date: Wed, 22 Jan 2025 10:22:42 +0100
From: Jan Kara <jack@suse.cz>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Jan Kara <jack@suse.cz>, lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Improving large folio writeback
 performance
Message-ID: <tglgxjxcs3wpm4msgxlvzk3hebzcguhuu752hs3eefku6wj4zv@2ixuho7rxbah>
References: <CAJnrk1a38pv3OgFZRfdTiDMXuPWuBgN8KY47XfOsYHj=N2wxAg@mail.gmail.com>
 <whipjvd65hrc7e5b5qsoj3la556s6dt6ckokn25qmciedmiwqa@rsitf37ibyjw>
 <CAJnrk1aZYpGe+x3=Fz0W30FfXB9RADutDpp+4DeuoBSVHp9XHA@mail.gmail.com>
 <kugnldi6l2rr4m2pcyh3ystyjsnwhcp3jrukqt7ni2ipnw3vpg@l7ieaeq3uosk>
 <CAJnrk1ZJ=mSMM8dP69QZBxLeorQXRjcBjOcVR4skhNcnNiDSAw@mail.gmail.com>
 <xuf742w2v2rir6tfumuu5ll2ow3kgzzbhjgvu47vquc3vgrdxf@blrmpfwvre4y>
 <CAJnrk1Z21NU0GCjj+GzsudyT1LAKx3TNqHt2oO22u1MZAZ4Lug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1Z21NU0GCjj+GzsudyT1LAKx3TNqHt2oO22u1MZAZ4Lug@mail.gmail.com>
X-Spam-Level: 
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
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Tue 21-01-25 16:29:57, Joanne Koong wrote:
> On Mon, Jan 20, 2025 at 2:42 PM Jan Kara <jack@suse.cz> wrote:
> > On Fri 17-01-25 14:45:01, Joanne Koong wrote:
> > > On Fri, Jan 17, 2025 at 3:53 AM Jan Kara <jack@suse.cz> wrote:
> > > > On Thu 16-01-25 15:38:54, Joanne Koong wrote:
> > > > I think tweaking min_pause is a wrong way to do this. I think that is just a
> > > > symptom. Can you run something like:
> > > >
> > > > while true; do
> > > >         cat /sys/kernel/debug/bdi/<fuse-bdi>/stats
> > > >         echo "---------"
> > > >         sleep 1
> > > > done >bdi-debug.txt
> > > >
> > > > while you are writing to the FUSE filesystem and share the output file?
> > > > That should tell us a bit more about what's happening inside the writeback
> > > > throttling. Also do you somehow configure min/max_ratio for the FUSE bdi?
> > > > You can check in /sys/block/<fuse-bdi>/bdi/{min,max}_ratio . I suspect the
> > > > problem is that the BDI dirty limit does not ramp up properly when we
> > > > increase dirtied pages in large chunks.
> > >
> > > This is the debug info I see for FUSE large folio writes where bs=1M
> > > and size=1G:
> > >
> > >
> > > BdiWriteback:                0 kB
> > > BdiReclaimable:              0 kB
> > > BdiDirtyThresh:            896 kB
> > > DirtyThresh:            359824 kB
> > > BackgroundThresh:       179692 kB
> > > BdiDirtied:            1071104 kB
> > > BdiWritten:               4096 kB
> > > BdiWriteBandwidth:           0 kBps
> > > b_dirty:                     0
> > > b_io:                        0
> > > b_more_io:                   0
> > > b_dirty_time:                0
> > > bdi_list:                    1
> > > state:                       1
> > > ---------
> > > BdiWriteback:                0 kB
> > > BdiReclaimable:              0 kB
> > > BdiDirtyThresh:           3596 kB
> > > DirtyThresh:            359824 kB
> > > BackgroundThresh:       179692 kB
> > > BdiDirtied:            1290240 kB
> > > BdiWritten:               4992 kB
> > > BdiWriteBandwidth:           0 kBps
> > > b_dirty:                     0
> > > b_io:                        0
> > > b_more_io:                   0
> > > b_dirty_time:                0
> > > bdi_list:                    1
> > > state:                       1
> > > ---------
> > > BdiWriteback:                0 kB
> > > BdiReclaimable:              0 kB
> > > BdiDirtyThresh:           3596 kB
> > > DirtyThresh:            359824 kB
> > > BackgroundThresh:       179692 kB
> > > BdiDirtied:            1517568 kB
> > > BdiWritten:               5824 kB
> > > BdiWriteBandwidth:       25692 kBps
> > > b_dirty:                     0
> > > b_io:                        1
> > > b_more_io:                   0
> > > b_dirty_time:                0
> > > bdi_list:                    1
> > > state:                       7
> > > ---------
> > > BdiWriteback:                0 kB
> > > BdiReclaimable:              0 kB
> > > BdiDirtyThresh:           3596 kB
> > > DirtyThresh:            359824 kB
> > > BackgroundThresh:       179692 kB
> > > BdiDirtied:            1747968 kB
> > > BdiWritten:               6720 kB
> > > BdiWriteBandwidth:           0 kBps
> > > b_dirty:                     0
> > > b_io:                        0
> > > b_more_io:                   0
> > > b_dirty_time:                0
> > > bdi_list:                    1
> > > state:                       1
> > > ---------
> > > BdiWriteback:                0 kB
> > > BdiReclaimable:              0 kB
> > > BdiDirtyThresh:            896 kB
> > > DirtyThresh:            359824 kB
> > > BackgroundThresh:       179692 kB
> > > BdiDirtied:            1949696 kB
> > > BdiWritten:               7552 kB
> > > BdiWriteBandwidth:           0 kBps
> > > b_dirty:                     0
> > > b_io:                        0
> > > b_more_io:                   0
> > > b_dirty_time:                0
> > > bdi_list:                    1
> > > state:                       1
> > > ---------
> > > BdiWriteback:                0 kB
> > > BdiReclaimable:              0 kB
> > > BdiDirtyThresh:           3612 kB
> > > DirtyThresh:            361300 kB
> > > BackgroundThresh:       180428 kB
> > > BdiDirtied:            2097152 kB
> > > BdiWritten:               8128 kB
> > > BdiWriteBandwidth:           0 kBps
> > > b_dirty:                     0
> > > b_io:                        0
> > > b_more_io:                   0
> > > b_dirty_time:                0
> > > bdi_list:                    1
> > > state:                       1
> > > ---------
> > >
> > >
> > > I didn't do anything to configure/change the FUSE bdi min/max_ratio.
> > > This is what I see on my system:
> > >
> > > cat /sys/class/bdi/0:52/min_ratio
> > > 0
> > > cat /sys/class/bdi/0:52/max_ratio
> > > 1
> >
> > OK, we can see that BdiDirtyThresh stabilized more or less at 3.6MB.
> > Checking the code, this shows we are hitting __wb_calc_thresh() logic:
> >
> >         if (unlikely(wb->bdi->capabilities & BDI_CAP_STRICTLIMIT)) {
> >                 unsigned long limit = hard_dirty_limit(dom, dtc->thresh);
> >                 u64 wb_scale_thresh = 0;
> >
> >                 if (limit > dtc->dirty)
> >                         wb_scale_thresh = (limit - dtc->dirty) / 100;
> >                 wb_thresh = max(wb_thresh, min(wb_scale_thresh, wb_max_thresh /
> >         }
> >
> > so BdiDirtyThresh is set to DirtyThresh/100. This also shows bdi never
> > generates enough throughput to ramp up it's share from this initial value.
> >
> > > > Actually, there's a patch queued in mm tree that improves the ramping up of
> > > > bdi dirty limit for strictlimit bdis [1]. It would be nice if you could
> > > > test whether it changes something in the behavior you observe. Thanks!
> > > >
> > > >                                                                 Honza
> > > >
> > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patche
> > > > s/mm-page-writeback-consolidate-wb_thresh-bumping-logic-into-__wb_calc_thresh.pa
> > > > tch
> > >
> > > I still see the same results (~230 MiB/s throughput using fio) with
> > > this patch applied, unfortunately. Here's the debug info I see with
> > > this patch (same test scenario as above on FUSE large folio writes
> > > where bs=1M and size=1G):
> > >
> > > BdiWriteback:                0 kB
> > > BdiReclaimable:           2048 kB
> > > BdiDirtyThresh:           3588 kB
> > > DirtyThresh:            359132 kB
> > > BackgroundThresh:       179348 kB
> > > BdiDirtied:              51200 kB
> > > BdiWritten:                128 kB
> > > BdiWriteBandwidth:      102400 kBps
> > > b_dirty:                     1
> > > b_io:                        0
> > > b_more_io:                   0
> > > b_dirty_time:                0
> > > bdi_list:                    1
> > > state:                       5
> > > ---------
> > > BdiWriteback:                0 kB
> > > BdiReclaimable:              0 kB
> > > BdiDirtyThresh:           3588 kB
> > > DirtyThresh:            359144 kB
> > > BackgroundThresh:       179352 kB
> > > BdiDirtied:             331776 kB
> > > BdiWritten:               1216 kB
> > > BdiWriteBandwidth:           0 kBps
> > > b_dirty:                     0
> > > b_io:                        0
> > > b_more_io:                   0
> > > b_dirty_time:                0
> > > bdi_list:                    1
> > > state:                       1
> > > ---------
> > > BdiWriteback:                0 kB
> > > BdiReclaimable:              0 kB
> > > BdiDirtyThresh:           3588 kB
> > > DirtyThresh:            359144 kB
> > > BackgroundThresh:       179352 kB
> > > BdiDirtied:             562176 kB
> > > BdiWritten:               2176 kB
> > > BdiWriteBandwidth:           0 kBps
> > > b_dirty:                     0
> > > b_io:                        0
> > > b_more_io:                   0
> > > b_dirty_time:                0
> > > bdi_list:                    1
> > > state:                       1
> > > ---------
> > > BdiWriteback:                0 kB
> > > BdiReclaimable:              0 kB
> > > BdiDirtyThresh:           3588 kB
> > > DirtyThresh:            359144 kB
> > > BackgroundThresh:       179352 kB
> > > BdiDirtied:             792576 kB
> > > BdiWritten:               3072 kB
> > > BdiWriteBandwidth:           0 kBps
> > > b_dirty:                     0
> > > b_io:                        0
> > > b_more_io:                   0
> > > b_dirty_time:                0
> > > bdi_list:                    1
> > > state:                       1
> > > ---------
> > > BdiWriteback:               64 kB
> > > BdiReclaimable:              0 kB
> > > BdiDirtyThresh:           3588 kB
> > > DirtyThresh:            359144 kB
> > > BackgroundThresh:       179352 kB
> > > BdiDirtied:            1026048 kB
> > > BdiWritten:               3904 kB
> > > BdiWriteBandwidth:           0 kBps
> > > b_dirty:                     0
> > > b_io:                        0
> > > b_more_io:                   0
> > > b_dirty_time:                0
> > > bdi_list:                    1
> > > state:                       1
> > > ---------
> >
> > Yeah, here the situation is really the same. As an experiment can you
> > experiment with setting min_ratio for the FUSE bdi to 1, 2, 3, ..., 10 (I
> > don't expect you should need to go past 10) and figure out when there's
> > enough slack space for the writeback bandwidth to ramp up to a full speed?
> > Thanks!
> >
> >                                                                 Honza
> 
> When locally testing this, I'm seeing that the max_ratio affects the
> bandwidth more so than min_ratio (eg the different min_ratios have
> roughly the same bandwidth per max_ratio). I'm also seeing somewhat
> high variance across runs which makes it hard to gauge what's
> accurate, but on average this is what I'm seeing:
> 
> max_ratio=1 --- bandwidth= ~230 MiB/s
> max_ratio=2 --- bandwidth= ~420 MiB/s
> max_ratio=3 --- bandwidth= ~550 MiB/s
> max_ratio=4 --- bandwidth= ~653 MiB/s
> max_ratio=5 --- bandwidth= ~700 MiB/s
> max_ratio=6 --- bandwidth= ~810 MiB/s
> max_ratio=7 --- bandwidth= ~1040 MiB/s (and then a lot of times, 561
> MiB/s on subsequent runs)

Ah, sorry. I actually misinterpretted your reply from previous email that:

> > > cat /sys/class/bdi/0:52/max_ratio
> > > 1

This means the amount of dirty pages for the fuse filesystem is indeed
hard-capped at 1% of dirty limit which happens to be ~3MB on your machine.
Checking where this is coming from I can see that fuse_bdi_init() does
this by:

	bdi_set_max_ratio(sb->s_bdi, 1);

So FUSE restricts itself and with only 3MB dirty limit and 2MB dirtying
granularity it is not surprising that dirty throttling doesn't work well.

I'd say there needs to be some better heuristic within FUSE that balances
maximum folio size and maximum dirty limit setting for the filesystem to a
sensible compromise (so that there's space for at least say 10 dirty
max-sized folios within the dirty limit).

But I guess this is just a shorter-term workaround. Long-term, finer
grained dirtiness tracking within FUSE (and writeback counters tracking in
MM) is going to be a more effective solution.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

