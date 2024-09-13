Return-Path: <linux-fsdevel+bounces-29301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 039CA977DFD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 12:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 358A42885AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 10:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D66A1D86F7;
	Fri, 13 Sep 2024 10:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p9KPY6aS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oN8wzPEi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="p9KPY6aS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oN8wzPEi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6101D7E59;
	Fri, 13 Sep 2024 10:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726224586; cv=none; b=HIs67v/9PRfbnzB0uJ4AczHTjkC7uZQz/puG3HTwYXxxR8f/DXbNhuQ+G7EoMTNYRsvFR9zUHIyRoygr+oerA8rBQoz9XXjyVgxf/kwA1Kq+E40mpEWh9rPXPBTozEd+52OvzVPKKrRGE/U0S1TQuk5fHnTrh/GpSleL6TMb0Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726224586; c=relaxed/simple;
	bh=ZkHZVLwC5Jq9bc9R8e7GBcPmXfgzUvorRyEFlXYILTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2C2s21EGz1eT578JUukYiEU2J/siz6uGuV1N6dm/zaHWZLK9r2FEherXe6Y+5vpC0Euy0cfwVPfAXzOMvGrokFDAnwSR+77dkhYFBA32fnuE4iRLFs/gMC1n+C9iPnBWBaP3wkd+xjW4kxY++WhEMcEiK3faW91jk6XfJwpxNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=p9KPY6aS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oN8wzPEi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=p9KPY6aS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oN8wzPEi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1A9E21FBCD;
	Fri, 13 Sep 2024 10:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726224583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V5xQxmkk81smqexA5a5HgEMCfAJQT7J/HT9ukF4gDf8=;
	b=p9KPY6aSI6z0IK2ueUPIU9f/rLTr6RPykMQR9H2Qsa1L30+3vqZ1ihNngFMrTfA4mKNjj8
	KgnzKaHHSPGLvTrDWgrWSnd1wm4K5bT2e5KiR16cWGQHykqkKnVehbFGXVSZfo6dNUg1Hy
	KAvTC3xQLtMK8/mue1M3KDXpwpIjhWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726224583;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V5xQxmkk81smqexA5a5HgEMCfAJQT7J/HT9ukF4gDf8=;
	b=oN8wzPEimHTR4soWWSZDCfr7t13ZKjCzeZVCKVHAbQf0fWTqORrsaWhNX7wVWBDdqQZgk9
	Wgg198ov3v6of0CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726224583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V5xQxmkk81smqexA5a5HgEMCfAJQT7J/HT9ukF4gDf8=;
	b=p9KPY6aSI6z0IK2ueUPIU9f/rLTr6RPykMQR9H2Qsa1L30+3vqZ1ihNngFMrTfA4mKNjj8
	KgnzKaHHSPGLvTrDWgrWSnd1wm4K5bT2e5KiR16cWGQHykqkKnVehbFGXVSZfo6dNUg1Hy
	KAvTC3xQLtMK8/mue1M3KDXpwpIjhWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726224583;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V5xQxmkk81smqexA5a5HgEMCfAJQT7J/HT9ukF4gDf8=;
	b=oN8wzPEimHTR4soWWSZDCfr7t13ZKjCzeZVCKVHAbQf0fWTqORrsaWhNX7wVWBDdqQZgk9
	Wgg198ov3v6of0CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09D8013999;
	Fri, 13 Sep 2024 10:49:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pjdkAscY5GbTbAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 13 Sep 2024 10:49:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B6F1FA08EF; Fri, 13 Sep 2024 12:49:38 +0200 (CEST)
Date: Fri, 13 Sep 2024 12:49:38 +0200
From: Jan Kara <jack@suse.cz>
To: Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
	"zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
	steve.kang@unisoc.com
Subject: Re: [RFC PATCHv2 1/1] fs: ext4: Don't use CMA for buffer_head
Message-ID: <20240913104938.onpgr3h6crtbmsmc@quack3>
References: <20240903022902.GP9627@mit.edu>
 <CAGWkznEv+F1A878Nw0=di02DHyKxWCvK0B=93o1xjXK6nUyQ3Q@mail.gmail.com>
 <20240903120840.GD424729@mit.edu>
 <CAGWkznFu1GTB41Vx1_Ews=rNw-Pm-=ACxg=GjVdw46nrpVdO3g@mail.gmail.com>
 <20240904024445.GR9627@mit.edu>
 <CAGWkznFGDJsyMUhn5Y8DPmhba9h4GNkX_CaqEMev4z23xa-s6g@mail.gmail.com>
 <20240912084119.j3oqfikuavymctlm@quack3>
 <CAGWkznG7_=zjKZBO-sj=79F3a3tgZuXqCXbvddDDG2Atv5043g@mail.gmail.com>
 <20240912101608.c6wfkvhbaatiokaw@quack3>
 <CAGWkznGQkoJbUW7hkUK1+i4ww9ihtY2cUTZbC_jqwFq3HDqE4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGWkznGQkoJbUW7hkUK1+i4ww9ihtY2cUTZbC_jqwFq3HDqE4g@mail.gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 13-09-24 09:39:57, Zhaoyang Huang wrote:
> On Thu, Sep 12, 2024 at 6:16 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 12-09-24 17:10:44, Zhaoyang Huang wrote:
> > > On Thu, Sep 12, 2024 at 4:41 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > On Wed 04-09-24 14:56:29, Zhaoyang Huang wrote:
> > > > > On Wed, Sep 4, 2024 at 10:44 AM Theodore Ts'o <tytso@mit.edu> wrote:
> > > > > > On Wed, Sep 04, 2024 at 08:49:10AM +0800, Zhaoyang Huang wrote:
> > > > > > > >
> > > > > > > > After all, using GFP_MOVEABLE memory seems to mean that the buffer
> > > > > > > > cache might get thrashed a lot by having a lot of cached disk buffers
> > > > > > > > getting ejected from memory to try to make room for some contiguous
> > > > > > > > frame buffer memory, which means extra I/O overhead.  So what's the
> > > > > > > > upside of using GFP_MOVEABLE for the buffer cache?
> > > > > > >
> > > > > > > To my understanding, NO. using GFP_MOVEABLE memory doesn't introduce
> > > > > > > extra IO as they just be migrated to free pages instead of ejected
> > > > > > > directly when they are the target memory area. In terms of reclaiming,
> > > > > > > all migrate types of page blocks possess the same position.
> > > > > >
> > > > > > Where is that being done?  I don't see any evidence of this kind of
> > > > > > migration in fs/buffer.c.
> > > > > The journaled pages which carry jh->bh are treated as file pages
> > > > > during isolation of a range of PFNs in the callstack below[1]. The bh
> > > > > will be migrated via each aops's migrate_folio and performs what you
> > > > > described below such as copy the content and reattach the bh to a new
> > > > > page. In terms of the journal enabled ext4 partition, the inode is a
> > > > > blockdev inode which applies buffer_migrate_folio_norefs as its
> > > > > migrate_folio[2].
> > > > >
> > > > > [1]
> > > > > cma_alloc/alloc_contig_range
> > > > >     __alloc_contig_migrate_range
> > > > >         migrate_pages
> > > > >             migrate_folio_move
> > > > >                 move_to_new_folio
> > > > >
> > > > > mapping->aops->migrate_folio(buffer_migrate_folio_norefs->__buffer_migrate_folio)
> > > > >
> > > > > [2]
> > > > > static int __buffer_migrate_folio(struct address_space *mapping,
> > > > >                 struct folio *dst, struct folio *src, enum migrate_mode mode,
> > > > >                 bool check_refs)
> > > > > {
> > > > > ...
> > > > >         if (check_refs) {
> > > > >                 bool busy;
> > > > >                 bool invalidated = false;
> > > > >
> > > > > recheck_buffers:
> > > > >                 busy = false;
> > > > >                 spin_lock(&mapping->i_private_lock);
> > > > >                 bh = head;
> > > > >                 do {
> > > > >                         if (atomic_read(&bh->b_count)) {
> > > > >           //My case failed here as bh is referred by a journal head.
> > > > >                                 busy = true;
> > > > >                                 break;
> > > > >                         }
> > > > >                         bh = bh->b_this_page;
> > > > >                 } while (bh != head);
> > > >
> > > > Correct. Currently pages with journal heads attached cannot be migrated
> > > > mostly out of pure caution that the generic code isn't sure what's
> > > > happening with them. As I wrote in [1] we could make pages with jhs on
> > > > checkpoint list only migratable as for them the buffer lock is enough to
> > > > stop anybody from touching the bh data. Bhs which are part of a running /
> > > > committing transaction are not realistically migratable but then these
> > > > states are more shortlived so it shouldn't be a big problem.
> > > By observing from our test case, the jh remains there for a long time
> > > when journal->j_free is bigger than j_max_transaction_buffers which
> > > failed cma_alloc. So you think this is rare or abnormal?
> > >
> > > [6] j_free & j_max_transaction_buffers
> > > crash_arm64_v8.0.4++> struct
> > > journal_t.j_free,j_max_transaction_buffers 0xffffff80e70f3000 -x
> > >   j_free = 0x3f1,
> > >   j_max_transaction_buffers = 0x100,
> >
> > So jh can stay attached to the bh for a very long time (basically only
> > memory pressure will evict it) and this is what blocks migration. But what
> > I meant is that in fact, most of the time we can migrate bh with jh
> > attached just fine. There are only relatively short moments (max 5s) where
> > a buffer (jh) is part of a running or committing transaction and then we
> > cannot really migrate.
> Please correct me if I am wrong. According to __buffer_migrate_folio,
> the bh can not be migrated as long as it has jh attached which could
> remain until the next cp transaction is launched. In my case, the
> jbd2' log space is big enough( j_free = 0x3f1 >
> j_max_transaction_buffers = 0x100) to escape the launch.

Currently yes. My proposal was to make bh migratable even with jh attached
(which obviously needs some tweaks to __buffer_migrate_folio()).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

