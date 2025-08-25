Return-Path: <linux-fsdevel+bounces-59006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D4FB33E1E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 13:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D168417231D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 11:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C234E2E9EAD;
	Mon, 25 Aug 2025 11:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vM0JmMt8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OOGTAtHz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vM0JmMt8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OOGTAtHz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926772E92C4
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 11:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756121586; cv=none; b=TcD65abxxIRHgpW0OYJBxTiK/2QurLsu1NwlNf7ViuLayG8Ixwh3WVcFds5a3BwU8GKJHJK/fx2pTPuqWLdvuK008ti1iPVwRxZvWKpSjnNo8YUb1F8TBznzyJekEAUU9BGEHvyxXC36Co19WPMwOqcX402yE1RLrU8KqOveDz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756121586; c=relaxed/simple;
	bh=Mp5rkFfMI7w6XlcyJaY/n2AlP/oJ3ya3aaT/ITcmCfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOlH2vpMdQLHDrDf3eVsNF/MIF5nwLt/ee1v/w/C1bp19EUmoj2z+A95hADsqb90zZ70cjntBmkBdS2h08il4b+o5xoHjsqdJy+a1M8KpbJ7Q3PI5kfMCrfqf6d6UzCG9jG6sHyfEqxB1ZzN6NeMH5aZPmM6gDagZHG7jJMfiXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vM0JmMt8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OOGTAtHz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vM0JmMt8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=OOGTAtHz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BF0DE1F79A;
	Mon, 25 Aug 2025 11:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756121582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tomkV9nuT3frr0dWuW+rpHLgqKT+MFjV5H/omKZ8HQI=;
	b=vM0JmMt8wvd1jNqgCn9PlBu1BKoOyBmc8g4JRayRBduJGl7G5bMeIHuWHqcyhxC7VVpw+o
	OWpGDTFEoSWIOkpRGdNq+3RVobpP1dl+yx2gtS3yT/FVxFh/CeG4IzVl10PIoqWscbsWe8
	Pe56YnYXL8LzIs+wmQbuCYduWVXw04A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756121582;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tomkV9nuT3frr0dWuW+rpHLgqKT+MFjV5H/omKZ8HQI=;
	b=OOGTAtHzhWpJM/oD0VYEhQMvX4oTKFcCtFklyDgTAiZ3LpIwMIynTgFLBCUYmk31Bj7H2S
	lagUB7SRl1wN2JAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756121582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tomkV9nuT3frr0dWuW+rpHLgqKT+MFjV5H/omKZ8HQI=;
	b=vM0JmMt8wvd1jNqgCn9PlBu1BKoOyBmc8g4JRayRBduJGl7G5bMeIHuWHqcyhxC7VVpw+o
	OWpGDTFEoSWIOkpRGdNq+3RVobpP1dl+yx2gtS3yT/FVxFh/CeG4IzVl10PIoqWscbsWe8
	Pe56YnYXL8LzIs+wmQbuCYduWVXw04A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756121582;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tomkV9nuT3frr0dWuW+rpHLgqKT+MFjV5H/omKZ8HQI=;
	b=OOGTAtHzhWpJM/oD0VYEhQMvX4oTKFcCtFklyDgTAiZ3LpIwMIynTgFLBCUYmk31Bj7H2S
	lagUB7SRl1wN2JAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF20113867;
	Mon, 25 Aug 2025 11:33:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PY65Ku5JrGjqAwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 25 Aug 2025 11:33:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9FFCCA0A94; Mon, 25 Aug 2025 12:13:53 +0200 (CEST)
Date: Mon, 25 Aug 2025 12:13:53 +0200
From: Jan Kara <jack@suse.cz>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, axboe@kernel.dk
Subject: Re: [External] Re: [PATCH] memcg: Don't wait writeback completion
 when release memcg.
Message-ID: <lvycz43vcro2cwjun4tswjv67tz5sg4tans3hragwils3gvnbh@hxbjk6x6v5zk>
References: <20250820111940.4105766-1-sunjunchao@bytedance.com>
 <20250820111940.4105766-4-sunjunchao@bytedance.com>
 <aKY2-sTc5qQmdea4@slm.duckdns.org>
 <CAHSKhtf--qn3TH3LFMrwqb-Nng2ABwV2gOX0PyAerd7h612X5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHSKhtf--qn3TH3LFMrwqb-Nng2ABwV2gOX0PyAerd7h612X5Q@mail.gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Thu 21-08-25 10:30:30, Julian Sun wrote:
> On Thu, Aug 21, 2025 at 4:58 AM Tejun Heo <tj@kernel.org> wrote:
> >
> > On Wed, Aug 20, 2025 at 07:19:40PM +0800, Julian Sun wrote:
> > > @@ -3912,8 +3921,12 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
> > >       int __maybe_unused i;
> > >
> > >  #ifdef CONFIG_CGROUP_WRITEBACK
> > > -     for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
> > > -             wb_wait_for_completion(&memcg->cgwb_frn[i].done);
> > > +     for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
> > > +             struct wb_completion *done = memcg->cgwb_frn[i].done;
> > > +
> > > +             if (atomic_dec_and_test(&done->cnt))
> > > +                     kfree(done);
> > > +     }
> > >  #endif
> >
> > Can't you just remove done? I don't think it's doing anything after your
> > changes anyway.
> 
> Thanks for your review.
> 
> AFAICT done is also used to track free slots in
> mem_cgroup_track_foreign_dirty_slowpath() and
> mem_cgroup_flush_foreign(), otherwise we have no method to know which
> one is free and might flush more than what MEMCG_CGWB_FRN_CNT allow.
> 
> Am I missing something?

True, but is that mechanism really needed? Given the approximate nature of
foreign flushing, couldn't we just always replace the oldest foreign entry
regardless of whether the writeback is running or not? I didn't give too
deep thought to this but from a quick look this should work just fine...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

