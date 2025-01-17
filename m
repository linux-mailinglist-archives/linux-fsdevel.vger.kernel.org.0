Return-Path: <linux-fsdevel+bounces-39486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FBBA14ED1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 12:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6DDB162C51
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 11:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3948A1FE464;
	Fri, 17 Jan 2025 11:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NJcCHxZP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gDPG0Z9T";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NJcCHxZP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gDPG0Z9T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70351FC7F4
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2025 11:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737114796; cv=none; b=LyJSDjfz228df0AYY+cWM/cH9JQPYPbfkPo4qcQQj+q8thyQ/LhCKUJ3IOrP0G5vL4ivs0NjMpu4X2uLfPoYbovvfZcGXlGdXmiWKEmwPvIuJERZCcwVafCyDy15m6Zqe5k55f4jaSr8LdNGFQYsV6YcyQSjP3ajiHvsrMNCK+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737114796; c=relaxed/simple;
	bh=aiZ8+Kv8Y/LE4IrkVrc1yHGq1AP/cMlQsqhnX/+U5ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjVUK2szFQlk3wXAC7Mb8ABk4yTzsUtVXD2jemu2ALrNomlVWNPNmh2/VXg+1VnCVoQVRwOffoNY1YiI0hIoSNZh3X2GdIVZOvRhKXG5vyfZmOs/lWeoDEvM9bxGlFl0evwxl/BPJM4S87pqAAFDxGOtJjtd0taaTHKlUJ2WQGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NJcCHxZP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gDPG0Z9T; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NJcCHxZP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gDPG0Z9T; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ACF211F387;
	Fri, 17 Jan 2025 11:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737114792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xJIXcHFlhkpdaXnNFrtSkSwJL1S21AwiTjXtrXyOnvI=;
	b=NJcCHxZPZ6+7RbFR4Zeawf29Ru6YuKBKC7IpbiRKRIX7SpY0db3HR+3Qhyt8k8dzE9Qjzb
	oM/aFtmsARQ1iI5l9+uSjQ0MgCwdHhwpB5dw6NfntY+A9ApRUC1pWLWcgkomkKgbP60pTo
	/6RArHt8EiFNUEUFT4xpwczB8g6lUwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737114792;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xJIXcHFlhkpdaXnNFrtSkSwJL1S21AwiTjXtrXyOnvI=;
	b=gDPG0Z9THR5+zXITIQwNntze3+8VPiCbdz4NgQC38FqLorkFqgvWQ6PbeYzRmHN8opmCfe
	PKr9DOD2D7jtszBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=NJcCHxZP;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gDPG0Z9T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737114792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xJIXcHFlhkpdaXnNFrtSkSwJL1S21AwiTjXtrXyOnvI=;
	b=NJcCHxZPZ6+7RbFR4Zeawf29Ru6YuKBKC7IpbiRKRIX7SpY0db3HR+3Qhyt8k8dzE9Qjzb
	oM/aFtmsARQ1iI5l9+uSjQ0MgCwdHhwpB5dw6NfntY+A9ApRUC1pWLWcgkomkKgbP60pTo
	/6RArHt8EiFNUEUFT4xpwczB8g6lUwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737114792;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xJIXcHFlhkpdaXnNFrtSkSwJL1S21AwiTjXtrXyOnvI=;
	b=gDPG0Z9THR5+zXITIQwNntze3+8VPiCbdz4NgQC38FqLorkFqgvWQ6PbeYzRmHN8opmCfe
	PKr9DOD2D7jtszBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A011A139CB;
	Fri, 17 Jan 2025 11:53:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Xy0KJ6hEimd+cAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 17 Jan 2025 11:53:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6181EA08E0; Fri, 17 Jan 2025 12:53:12 +0100 (CET)
Date: Fri, 17 Jan 2025 12:53:12 +0100
From: Jan Kara <jack@suse.cz>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Jan Kara <jack@suse.cz>, lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Improving large folio writeback
 performance
Message-ID: <kugnldi6l2rr4m2pcyh3ystyjsnwhcp3jrukqt7ni2ipnw3vpg@l7ieaeq3uosk>
References: <CAJnrk1a38pv3OgFZRfdTiDMXuPWuBgN8KY47XfOsYHj=N2wxAg@mail.gmail.com>
 <whipjvd65hrc7e5b5qsoj3la556s6dt6ckokn25qmciedmiwqa@rsitf37ibyjw>
 <CAJnrk1aZYpGe+x3=Fz0W30FfXB9RADutDpp+4DeuoBSVHp9XHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1aZYpGe+x3=Fz0W30FfXB9RADutDpp+4DeuoBSVHp9XHA@mail.gmail.com>
X-Rspamd-Queue-Id: ACF211F387
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 16-01-25 15:38:54, Joanne Koong wrote:
> On Thu, Jan 16, 2025 at 3:01 AM Jan Kara <jack@suse.cz> wrote:
> > On Tue 14-01-25 16:50:53, Joanne Koong wrote:
> > > I would like to propose a discussion topic about improving large folio
> > > writeback performance. As more filesystems adopt large folios, it
> > > becomes increasingly important that writeback is made to be as
> > > performant as possible. There are two areas I'd like to discuss:
> > >
> > > == Granularity of dirty pages writeback ==
> > > Currently, the granularity of writeback is at the folio level. If one
> > > byte in a folio is dirty, the entire folio will be written back. This
> > > becomes unscalable for larger folios and significantly degrades
> > > performance, especially for workloads that employ random writes.
> > >
> > > One idea is to track dirty pages at a smaller granularity using a
> > > 64-bit bitmap stored inside the folio struct where each bit tracks a
> > > smaller chunk of pages (eg for 2 MB folios, each bit would track 32k
> > > pages), and only write back dirty chunks rather than the entire folio.
> >
> > Yes, this is known problem and as Dave pointed out, currently it is upto
> > the lower layer to handle finer grained dirtiness handling. You can take
> > inspiration in the iomap layer that already does this, or you can convert
> > your filesystem to use iomap (preferred way).
> >
> > > == Balancing dirty pages ==
> > > It was observed that the dirty page balancing logic used in
> > > balance_dirty_pages() fails to scale for large folios [1]. For
> > > example, fuse saw around a 125% drop in throughput for writes when
> > > using large folios vs small folios on 1MB block sizes, which was
> > > attributed to scheduled io waits in the dirty page balancing logic. In
> > > generic_perform_write(), dirty pages are balanced after every write to
> > > the page cache by the filesystem. With large folios, each write
> > > dirties a larger number of pages which can grossly exceed the
> > > ratelimit, whereas with small folios each write is one page and so
> > > pages are balanced more incrementally and adheres more closely to the
> > > ratelimit. In order to accomodate large folios, likely the logic in
> > > balancing dirty pages needs to be reworked.
> >
> > I think there are several separate issues here. One is that
> > folio_account_dirtied() will consider the whole folio as needing writeback
> > which is not necessarily the case (as e.g. iomap will writeback only dirty
> > blocks in it). This was OKish when pages were 4k and you were using 1k
> > blocks (which was uncommon configuration anyway, usually you had 4k block
> > size), it starts to hurt a lot with 2M folios so we might need to find a
> > way how to propagate the information about really dirty bits into writeback
> > accounting.
> 
> Agreed. The only workable solution I see is to have some sort of api
> similar to filemap_dirty_folio() that takes in the number of pages
> dirtied as an arg, but maybe there's a better solution.

Yes, something like that I suppose.

> > Another problem *may* be that fast increments to dirtied pages (as we dirty
> > 512 pages at once instead of 16 we did in the past) cause over-reaction in
> > the dirtiness balancing logic and we throttle the task too much. The
> > heuristics there try to find the right amount of time to block a task so
> > that dirtying speed matches the writeback speed and it's plausible that
> > the large increments make this logic oscilate between two extremes leading
> > to suboptimal throughput. Also, since this was observed with FUSE, I belive
> > a significant factor is that FUSE enables "strictlimit" feature of the BDI
> > which makes dirty throttling more aggressive (generally the amount of
> > allowed dirty pages is lower). Anyway, these are mostly speculations from
> > my end. This needs more data to decide what exactly (if anything) needs
> > tweaking in the dirty throttling logic.
> 
> I tested this experimentally and you're right, on FUSE this is
> impacted a lot by the "strictlimit". I didn't see any bottlenecks when
> strictlimit wasn't enabled on FUSE. AFAICT, the strictlimit affects
> the dirty throttle control freerun flag (which gets used to determine
> whether throttling can be skipped) in the balance_dirty_pages() logic.
> For FUSE, we can't turn off strictlimit for unprivileged servers, but
> maybe we can make the throttling check more permissive by upping the
> value of the min_pause calculation in wb_min_pause() for writes that
> support large folios? As of right now, the current logic makes writing
> large folios unfeasible in FUSE (estimates show around a 75% drop in
> throughput).

I think tweaking min_pause is a wrong way to do this. I think that is just a
symptom. Can you run something like:

while true; do
	cat /sys/kernel/debug/bdi/<fuse-bdi>/stats
	echo "---------"
	sleep 1
done >bdi-debug.txt

while you are writing to the FUSE filesystem and share the output file?
That should tell us a bit more about what's happening inside the writeback
throttling. Also do you somehow configure min/max_ratio for the FUSE bdi?
You can check in /sys/block/<fuse-bdi>/bdi/{min,max}_ratio . I suspect the
problem is that the BDI dirty limit does not ramp up properly when we
increase dirtied pages in large chunks.

Actually, there's a patch queued in mm tree that improves the ramping up of
bdi dirty limit for strictlimit bdis [1]. It would be nice if you could
test whether it changes something in the behavior you observe. Thanks!

								Honza

[1] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patche
s/mm-page-writeback-consolidate-wb_thresh-bumping-logic-into-__wb_calc_thresh.pa
tch

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

