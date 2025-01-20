Return-Path: <linux-fsdevel+bounces-39748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF98A174BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 23:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F46F168390
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 22:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5779B1EE7BC;
	Mon, 20 Jan 2025 22:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N0VGD85g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3hz21+qu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BdpQ280H";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="imH1oLk6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634A64689
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 22:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737412933; cv=none; b=lFprQHv5V1MTPGZosa3J8VO26JQlCoaZYbgJyteP71ZnOTPMLNXnaKhUNsFbZ7PnoG9XMjtlIqIl6Hxf8kW1bEvbYtsSj3Bq5tl05CJCtqlv4ZDu7InrwquN3NQkfhISS2CdyVOC12yCHZjBrYhIMfpD96D1Wd9rZ004YYbEafk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737412933; c=relaxed/simple;
	bh=yLOARplf0y3PzW5M3l6W/tSxnY57E8+bEDrueONgUV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kyDLKKIuBSX1yeGxzGyUliSky6mEeHDZjXs/M1aPzyxsK/fVkwpR/Tj3n9V3akyNJz1mA1nIXWPVduPJg25bRbyd7c7lDmCmgTTFyQfjfkLh+Ewc+/4kJV6e37RqAQZ3OOTcDPNXdrlju1GjEgptPa4vFahSJuKlOh5Pzv2ZF8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N0VGD85g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3hz21+qu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BdpQ280H; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=imH1oLk6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A1FA121158;
	Mon, 20 Jan 2025 22:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737412922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oYKJuPglaND0aCGEia4dXjUVlLraQdXkAEBvOtlme0Y=;
	b=N0VGD85gkGgJYJtQNQyz4/WR84FielIDHmVkI9NP6NmKvvRMj4VYsyzneD7iOjLLaoPjEX
	iX+qbtMRd/Kk+WsUx+hcRB7U8VqWuj9Fq/gX2BWcgmmCgc1RjgWsuLT9cpXGhmY9N74dVU
	5pRtOWPfqb2Rjom2P+vAnv/hYxKZ9Hk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737412922;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oYKJuPglaND0aCGEia4dXjUVlLraQdXkAEBvOtlme0Y=;
	b=3hz21+quumZ1UFBr3a90Q9soys9ELgyIUEM6FqiMosoDLKzBgA4MkuvKmBZnu/mYBBwWAA
	tybKsghZ6Lr581BQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=BdpQ280H;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=imH1oLk6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737412921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oYKJuPglaND0aCGEia4dXjUVlLraQdXkAEBvOtlme0Y=;
	b=BdpQ280HW04QNax/e8tI3+4ctKBsTEne8h7DC5ZJdSssxiMeXTMH8NFdwf/OUXuruZcN9y
	YTSsBbTDAJwE7pjc54z97TeWGrQ1fQju2INeFhmzvzBuuxk9q7V2oQLF1ukV27CMKKvnuq
	txPEzvilYfRsgY0UDCoA1vrmnq/9zKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737412921;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oYKJuPglaND0aCGEia4dXjUVlLraQdXkAEBvOtlme0Y=;
	b=imH1oLk6AWpk3rvWNR4gEz2lJSgV4RzdwwaptW7baGYl4udCt80p0JkqvIrjUcgUPIycXF
	zuHwlE5f2UOojFCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86CEE139CB;
	Mon, 20 Jan 2025 22:42:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EtCaIDnRjmffcAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 Jan 2025 22:42:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1CCE7A081E; Mon, 20 Jan 2025 23:42:01 +0100 (CET)
Date: Mon, 20 Jan 2025 23:42:01 +0100
From: Jan Kara <jack@suse.cz>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Jan Kara <jack@suse.cz>, lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Improving large folio writeback
 performance
Message-ID: <xuf742w2v2rir6tfumuu5ll2ow3kgzzbhjgvu47vquc3vgrdxf@blrmpfwvre4y>
References: <CAJnrk1a38pv3OgFZRfdTiDMXuPWuBgN8KY47XfOsYHj=N2wxAg@mail.gmail.com>
 <whipjvd65hrc7e5b5qsoj3la556s6dt6ckokn25qmciedmiwqa@rsitf37ibyjw>
 <CAJnrk1aZYpGe+x3=Fz0W30FfXB9RADutDpp+4DeuoBSVHp9XHA@mail.gmail.com>
 <kugnldi6l2rr4m2pcyh3ystyjsnwhcp3jrukqt7ni2ipnw3vpg@l7ieaeq3uosk>
 <CAJnrk1ZJ=mSMM8dP69QZBxLeorQXRjcBjOcVR4skhNcnNiDSAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ZJ=mSMM8dP69QZBxLeorQXRjcBjOcVR4skhNcnNiDSAw@mail.gmail.com>
X-Rspamd-Queue-Id: A1FA121158
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 17-01-25 14:45:01, Joanne Koong wrote:
> On Fri, Jan 17, 2025 at 3:53 AM Jan Kara <jack@suse.cz> wrote:
> > On Thu 16-01-25 15:38:54, Joanne Koong wrote:
> > I think tweaking min_pause is a wrong way to do this. I think that is just a
> > symptom. Can you run something like:
> >
> > while true; do
> >         cat /sys/kernel/debug/bdi/<fuse-bdi>/stats
> >         echo "---------"
> >         sleep 1
> > done >bdi-debug.txt
> >
> > while you are writing to the FUSE filesystem and share the output file?
> > That should tell us a bit more about what's happening inside the writeback
> > throttling. Also do you somehow configure min/max_ratio for the FUSE bdi?
> > You can check in /sys/block/<fuse-bdi>/bdi/{min,max}_ratio . I suspect the
> > problem is that the BDI dirty limit does not ramp up properly when we
> > increase dirtied pages in large chunks.
> 
> This is the debug info I see for FUSE large folio writes where bs=1M
> and size=1G:
> 
> 
> BdiWriteback:                0 kB
> BdiReclaimable:              0 kB
> BdiDirtyThresh:            896 kB
> DirtyThresh:            359824 kB
> BackgroundThresh:       179692 kB
> BdiDirtied:            1071104 kB
> BdiWritten:               4096 kB
> BdiWriteBandwidth:           0 kBps
> b_dirty:                     0
> b_io:                        0
> b_more_io:                   0
> b_dirty_time:                0
> bdi_list:                    1
> state:                       1
> ---------
> BdiWriteback:                0 kB
> BdiReclaimable:              0 kB
> BdiDirtyThresh:           3596 kB
> DirtyThresh:            359824 kB
> BackgroundThresh:       179692 kB
> BdiDirtied:            1290240 kB
> BdiWritten:               4992 kB
> BdiWriteBandwidth:           0 kBps
> b_dirty:                     0
> b_io:                        0
> b_more_io:                   0
> b_dirty_time:                0
> bdi_list:                    1
> state:                       1
> ---------
> BdiWriteback:                0 kB
> BdiReclaimable:              0 kB
> BdiDirtyThresh:           3596 kB
> DirtyThresh:            359824 kB
> BackgroundThresh:       179692 kB
> BdiDirtied:            1517568 kB
> BdiWritten:               5824 kB
> BdiWriteBandwidth:       25692 kBps
> b_dirty:                     0
> b_io:                        1
> b_more_io:                   0
> b_dirty_time:                0
> bdi_list:                    1
> state:                       7
> ---------
> BdiWriteback:                0 kB
> BdiReclaimable:              0 kB
> BdiDirtyThresh:           3596 kB
> DirtyThresh:            359824 kB
> BackgroundThresh:       179692 kB
> BdiDirtied:            1747968 kB
> BdiWritten:               6720 kB
> BdiWriteBandwidth:           0 kBps
> b_dirty:                     0
> b_io:                        0
> b_more_io:                   0
> b_dirty_time:                0
> bdi_list:                    1
> state:                       1
> ---------
> BdiWriteback:                0 kB
> BdiReclaimable:              0 kB
> BdiDirtyThresh:            896 kB
> DirtyThresh:            359824 kB
> BackgroundThresh:       179692 kB
> BdiDirtied:            1949696 kB
> BdiWritten:               7552 kB
> BdiWriteBandwidth:           0 kBps
> b_dirty:                     0
> b_io:                        0
> b_more_io:                   0
> b_dirty_time:                0
> bdi_list:                    1
> state:                       1
> ---------
> BdiWriteback:                0 kB
> BdiReclaimable:              0 kB
> BdiDirtyThresh:           3612 kB
> DirtyThresh:            361300 kB
> BackgroundThresh:       180428 kB
> BdiDirtied:            2097152 kB
> BdiWritten:               8128 kB
> BdiWriteBandwidth:           0 kBps
> b_dirty:                     0
> b_io:                        0
> b_more_io:                   0
> b_dirty_time:                0
> bdi_list:                    1
> state:                       1
> ---------
> 
> 
> I didn't do anything to configure/change the FUSE bdi min/max_ratio.
> This is what I see on my system:
> 
> cat /sys/class/bdi/0:52/min_ratio
> 0
> cat /sys/class/bdi/0:52/max_ratio
> 1

OK, we can see that BdiDirtyThresh stabilized more or less at 3.6MB.
Checking the code, this shows we are hitting __wb_calc_thresh() logic:

        if (unlikely(wb->bdi->capabilities & BDI_CAP_STRICTLIMIT)) {
                unsigned long limit = hard_dirty_limit(dom, dtc->thresh);
                u64 wb_scale_thresh = 0;

                if (limit > dtc->dirty)
                        wb_scale_thresh = (limit - dtc->dirty) / 100;
                wb_thresh = max(wb_thresh, min(wb_scale_thresh, wb_max_thresh /
        }

so BdiDirtyThresh is set to DirtyThresh/100. This also shows bdi never
generates enough throughput to ramp up it's share from this initial value.

> > Actually, there's a patch queued in mm tree that improves the ramping up of
> > bdi dirty limit for strictlimit bdis [1]. It would be nice if you could
> > test whether it changes something in the behavior you observe. Thanks!
> >
> >                                                                 Honza
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patche
> > s/mm-page-writeback-consolidate-wb_thresh-bumping-logic-into-__wb_calc_thresh.pa
> > tch
> 
> I still see the same results (~230 MiB/s throughput using fio) with
> this patch applied, unfortunately. Here's the debug info I see with
> this patch (same test scenario as above on FUSE large folio writes
> where bs=1M and size=1G):
> 
> BdiWriteback:                0 kB
> BdiReclaimable:           2048 kB
> BdiDirtyThresh:           3588 kB
> DirtyThresh:            359132 kB
> BackgroundThresh:       179348 kB
> BdiDirtied:              51200 kB
> BdiWritten:                128 kB
> BdiWriteBandwidth:      102400 kBps
> b_dirty:                     1
> b_io:                        0
> b_more_io:                   0
> b_dirty_time:                0
> bdi_list:                    1
> state:                       5
> ---------
> BdiWriteback:                0 kB
> BdiReclaimable:              0 kB
> BdiDirtyThresh:           3588 kB
> DirtyThresh:            359144 kB
> BackgroundThresh:       179352 kB
> BdiDirtied:             331776 kB
> BdiWritten:               1216 kB
> BdiWriteBandwidth:           0 kBps
> b_dirty:                     0
> b_io:                        0
> b_more_io:                   0
> b_dirty_time:                0
> bdi_list:                    1
> state:                       1
> ---------
> BdiWriteback:                0 kB
> BdiReclaimable:              0 kB
> BdiDirtyThresh:           3588 kB
> DirtyThresh:            359144 kB
> BackgroundThresh:       179352 kB
> BdiDirtied:             562176 kB
> BdiWritten:               2176 kB
> BdiWriteBandwidth:           0 kBps
> b_dirty:                     0
> b_io:                        0
> b_more_io:                   0
> b_dirty_time:                0
> bdi_list:                    1
> state:                       1
> ---------
> BdiWriteback:                0 kB
> BdiReclaimable:              0 kB
> BdiDirtyThresh:           3588 kB
> DirtyThresh:            359144 kB
> BackgroundThresh:       179352 kB
> BdiDirtied:             792576 kB
> BdiWritten:               3072 kB
> BdiWriteBandwidth:           0 kBps
> b_dirty:                     0
> b_io:                        0
> b_more_io:                   0
> b_dirty_time:                0
> bdi_list:                    1
> state:                       1
> ---------
> BdiWriteback:               64 kB
> BdiReclaimable:              0 kB
> BdiDirtyThresh:           3588 kB
> DirtyThresh:            359144 kB
> BackgroundThresh:       179352 kB
> BdiDirtied:            1026048 kB
> BdiWritten:               3904 kB
> BdiWriteBandwidth:           0 kBps
> b_dirty:                     0
> b_io:                        0
> b_more_io:                   0
> b_dirty_time:                0
> bdi_list:                    1
> state:                       1
> ---------

Yeah, here the situation is really the same. As an experiment can you
experiment with setting min_ratio for the FUSE bdi to 1, 2, 3, ..., 10 (I
don't expect you should need to go past 10) and figure out when there's
enough slack space for the writeback bandwidth to ramp up to a full speed?
Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

