Return-Path: <linux-fsdevel+bounces-16103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 328DE8983BA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 11:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D943E285C61
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 09:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF66774407;
	Thu,  4 Apr 2024 09:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hi94dDcK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VkRVOHT4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DEF73533;
	Thu,  4 Apr 2024 09:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712221678; cv=none; b=E88T7reG94jVGsl7NK8bD/DTH/wi9zTN561cvgNOvV+WRSMhzL3NUpZcPrzG8AcYt/bg6DNdpPi3v75Lao58ye0eYL56cc6EFUes+78Tpj9F2QkvaDg3BLVNsZZdNWOV8I2Hb4P+YPMtQJoGZPQyajiXegCeWBGyazriUgOqIxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712221678; c=relaxed/simple;
	bh=0uxoQRaHoHG7chj6MWdAHKa820ZHfiIxdM2f5qnK8GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tSkz09hGnEmhudZirWyMQU3Kgt7pW+ovUaEhxgZHA4WfORhCtpaoxWSs/e1TlxJm96i9vMDmST4NUIcFibcLd58Y+v3+K/0Cm1ssN5WFYaJ+I4dZHWV8fngD1DxxfXauIJbBcC+4cJp2OxoQTaNj+yHxyAzotbzEURrBYKEqOUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hi94dDcK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VkRVOHT4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2947E379D1;
	Thu,  4 Apr 2024 09:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712221674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/fyMt9mi2QeseeA79i7XQ5O3GA4jt9iGQ8W/i5gg2EM=;
	b=hi94dDcK+h6tGAZlnkEpRkayNJyik5D1DB64qJBX/33XmvKoNiopZn0tTwPha4ZF+hu+uI
	rLRcFKKUihWQTBnUa9Uy9OC7PdmEdks6ukgg9Q/PrfYhhr3HZ2sMbx2PURYsSqeZj6oRYc
	P1F442CqNJKqalruSYD54kf73oHdt54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712221674;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/fyMt9mi2QeseeA79i7XQ5O3GA4jt9iGQ8W/i5gg2EM=;
	b=VkRVOHT4tDv91fGgYX/LQ85y2rs2YsRBCXmUriVwKaLwCyl4q1vDBWWJg3Fx+JQwjJ4O3y
	ZFdhAhwO9xHLzGCg==
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 196E9139E8;
	Thu,  4 Apr 2024 09:07:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id gxXxBeptDmZRHQAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 04 Apr 2024 09:07:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B688DA0816; Thu,  4 Apr 2024 11:07:53 +0200 (CEST)
Date: Thu, 4 Apr 2024 11:07:53 +0200
From: Jan Kara <jack@suse.cz>
To: Brian Foster <bfoster@redhat.com>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>, akpm@linux-foundation.org,
	willy@infradead.org, jack@suse.cz, tj@kernel.org, dsterba@suse.com,
	mjguzik@gmail.com, dhowells@redhat.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] writeback: support retrieving per group debug
 writeback stats of bdi
Message-ID: <20240404090753.q3iugmqeeqig64db@quack3>
References: <20240327155751.3536-1-shikemeng@huaweicloud.com>
 <20240327155751.3536-4-shikemeng@huaweicloud.com>
 <Zga937dR5UgtSVaz@bfoster>
 <e3816f9c-0f29-a0e4-8ad8-a6acf82a06ad@huaweicloud.com>
 <Zg1wGvTeQxjqjYUG@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zg1wGvTeQxjqjYUG@bfoster>
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[huaweicloud.com,linux-foundation.org,infradead.org,suse.cz,kernel.org,suse.com,gmail.com,redhat.com,vger.kernel.org,kvack.org];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO

On Wed 03-04-24 11:04:58, Brian Foster wrote:
> On Wed, Apr 03, 2024 at 04:49:42PM +0800, Kemeng Shi wrote:
> > on 3/29/2024 9:10 PM, Brian Foster wrote:
> > > On Wed, Mar 27, 2024 at 11:57:48PM +0800, Kemeng Shi wrote:
> > >> +		collect_wb_stats(&stats, wb);
> > >> +
> > > 
> > > Also, similar question as before on whether you'd want to check
> > > WB_registered or something here..
> > Still prefer to keep full debug info and user could filter out on
> > demand.
> 
> Ok. I was more wondering if that was needed for correctness. If not,
> then that seems fair enough to me.
> 
> > >> +		if (mem_cgroup_wb_domain(wb) == NULL) {
> > >> +			wb_stats_show(m, wb, &stats);
> > >> +			continue;
> > >> +		}
> > > 
> > > Can you explain what this logic is about? Is the cgwb_calc_thresh()
> > > thing not needed in this case? A comment might help for those less
> > > familiar with the implementation details.
> > If mem_cgroup_wb_domain(wb) is NULL, then it's bdi->wb, otherwise,
> > it's wb in cgroup. For bdi->wb, there is no need to do wb_tryget
> > and cgwb_calc_thresh. Will add some comment in next version.
> > > 
> > > BTW, I'm also wondering if something like the following is correct
> > > and/or roughly equivalent:
> > > 	
> > > 	list_for_each_*(wb, ...) {
> > > 		struct wb_stats stats = ...;
> > > 
> > > 		if (!wb_tryget(wb))
> > > 			continue;
> > > 
> > > 		collect_wb_stats(&stats, wb);
> > > 
> > > 		/*
> > > 		 * Extra wb_thresh magic. Drop rcu lock because ... . We
> > > 		 * can do so here because we have a ref.
> > > 		 */
> > > 		if (mem_cgroup_wb_domain(wb)) {
> > > 			rcu_read_unlock();
> > > 			stats.wb_thresh = min(stats.wb_thresh, cgwb_calc_thresh(wb));
> > > 			rcu_read_lock();
> > > 		}
> > > 
> > > 		wb_stats_show(m, wb, &stats)
> > > 		wb_put(wb);
> > > 	}
> > It's correct as wb_tryget to bdi->wb has no harm. I have considered
> > to do it in this way, I change my mind to do it in new way for
> > two reason:
> > 1. Put code handling wb in cgroup more tight which could be easier
> > to maintain.
> > 2. Rmove extra wb_tryget/wb_put for wb in bdi.
> > Would this make sense to you?
> 
> Ok, well assuming it is correct the above logic is a bit more simple and
> readable to me. I think you'd just need to fill in the comment around
> the wb_thresh thing rather than i.e. having to explain we don't need to
> ref bdi->wb even though it doesn't seem to matter.
> 
> I kind of feel the same on the wb_stats file thing below just because it
> seems more consistent and available if wb_stats eventually grows more
> wb-specific data.
> 
> That said, this is subjective and not hugely important so I don't insist
> on either point. Maybe wait a bit and see if Jan or Tejun or somebody
> has any thoughts..? If nobody else expresses explicit preference then
> I'm good with it either way.

No strong opinion from me really.

> > >> +static void cgwb_debug_register(struct backing_dev_info *bdi)
> > >> +{
> > >> +	debugfs_create_file("wb_stats", 0444, bdi->debug_dir, bdi,
> > >> +			    &cgwb_debug_stats_fops);
> > >> +}
> > >> +
> > >>  static void bdi_collect_stats(struct backing_dev_info *bdi,
> > >>  			      struct wb_stats *stats)
> > >>  {
> > >> @@ -117,6 +202,8 @@ static void bdi_collect_stats(struct backing_dev_info *bdi,
> > >>  {
> > >>  	collect_wb_stats(stats, &bdi->wb);
> > >>  }
> > >> +
> > >> +static inline void cgwb_debug_register(struct backing_dev_info *bdi) { }
> > > 
> > > Could we just create the wb_stats file regardless of whether cgwb is
> > > enabled? Obviously theres only one wb in the !CGWB case and it's
> > > somewhat duplicative with the bdi stats file, but that seems harmless if
> > > the same code can be reused..? Maybe there's also a small argument for
> > > dropping the state info from the bdi stats file and moving it to
> > > wb_stats.In backing-dev.c, there are a lot "#ifdef CGWB .. #else .. #endif" to
> > avoid unneed extra cost when CGWB is not enabled.
> > I think it's better to avoid extra cost from wb_stats when CGWB is not
> > enabled. For now, we only save cpu cost to create and destroy wb_stats
> > and save memory cost to record debugfs file, we could save more in
> > future when wb_stats records more debug info.

Well, there's the other side that you don't have to think whether the
kernel has CGWB enabled or not when asking a customer to gather the
writeback debug info - you can always ask for wb_stats. Also if you move
the wb->state to wb_stats only it will become inaccessible with CGWB
disabled. So I agree with Brian that it is better to provide wb_stats also
with CGWB disabled (and we can just implement wb_stats for !CGWB case with
the same function as bdi_stats).

That being said all production kernels I have seen do have CGWB enabled so
I don't care that much about this...

> > Move state info from bdi stats to wb_stats make senses to me. The only
> > concern would be compatibility problem. I will add a new patch to this
> > to make this more noticeable and easier to revert.

Yeah, I don't think we care much about debugfs compatibility but I think
removing state from bdi_stats is not worth the inconsistency between
wb_stats and bdi_stats in the !CGWB case.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

