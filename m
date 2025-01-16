Return-Path: <linux-fsdevel+bounces-39396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BF7A13882
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 12:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81B143A7E2B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 11:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55021D9A7F;
	Thu, 16 Jan 2025 11:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nDOnGevl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BIE73Bvr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VklNlpvB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O3p73550"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A63A19ABD1
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2025 11:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737025285; cv=none; b=kSzY/9000idKs2i7XhrbwmnHKQIsY4q8olzpE5bz76SVzOmQjk0Bi+NvwdEvSSS6+dgkEPOFjdZwt/hao+ON82SGbSi4yPn+Z+VBwtYdwpyMGZrVrkdJDeUIzKqwMNvGuFpgFgeXbyvqWqNbltnIXclXX60teuvlvNh5RD7vtQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737025285; c=relaxed/simple;
	bh=/SwV/TtqYsdz6D2cQXhdmXS9xv5v7CaIyZ9JceAKJ9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=afkubhyAfDNaa0/WKTXRoPzEa5xHA89S5qosregswn8mYgM9c1poKsGs/giaUQ6JVwsy9r8Hm1t4o9xLcvaduhluaLCyThulNPOtHdBuD/6+DsDMjqZQ60hYcbuxj2H3O3VNuws9q0o0XchPpEdcM4ZIflsOW0gL6Z64Vngsy3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nDOnGevl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BIE73Bvr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VklNlpvB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O3p73550; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2A5F31F796;
	Thu, 16 Jan 2025 11:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737025281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KnGXZdJlEms5ULoeuyyEbZ4E4cbzhyWII1nI4VNWv50=;
	b=nDOnGevl+Jl26iDGz+x6aky12KznuuOnQIcL3UAmVz/a6L7B/yD99lD5LUMdE7HSo2Pbi7
	Lq2GXQpinnvdqYsf71b6Sd4JJNTEOKi7wHmN4D97u9xNMTOQiM9JAfwD82FpVfQ/1LYEA4
	g7A92aB+154tYJR0PXBKVOTrFF8KLq0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737025281;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KnGXZdJlEms5ULoeuyyEbZ4E4cbzhyWII1nI4VNWv50=;
	b=BIE73BvrWIM3cJnrtW7zOVCKJDweaPpETD3xbrDwpYhPjIkq3oTJCOS+eRvd4eNarBHMx/
	U+zSPnP03eVjBkDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737025280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KnGXZdJlEms5ULoeuyyEbZ4E4cbzhyWII1nI4VNWv50=;
	b=VklNlpvB6j0DrgBZDkCK6xT62d8aYq5SQDqZ8pjjPgIYKVT/diQtDLhrsg4G2boYKpDh5O
	zbuBVAJvTKSA9ZNsSJQeja7SbEAIAgOhZHF0NlDuKnt9GkjuHtFyhwy1Sun0puK0njZY9N
	3l8Y+yniGun7CrxeAwl5LbUni+txvGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737025280;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KnGXZdJlEms5ULoeuyyEbZ4E4cbzhyWII1nI4VNWv50=;
	b=O3p735506mg+aqjoNal9r8qqicEulPnI+xWFB8OH0YcnfYY7csQvgijK3ppI5ET8+Xtq0p
	K8/nQpxfUca719Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20BBD13A57;
	Thu, 16 Jan 2025 11:01:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KJL5BwDniGfAKgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 16 Jan 2025 11:01:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CAB6EA08E0; Thu, 16 Jan 2025 12:01:15 +0100 (CET)
Date: Thu, 16 Jan 2025 12:01:15 +0100
From: Jan Kara <jack@suse.cz>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Improving large folio writeback
 performance
Message-ID: <whipjvd65hrc7e5b5qsoj3la556s6dt6ckokn25qmciedmiwqa@rsitf37ibyjw>
References: <CAJnrk1a38pv3OgFZRfdTiDMXuPWuBgN8KY47XfOsYHj=N2wxAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1a38pv3OgFZRfdTiDMXuPWuBgN8KY47XfOsYHj=N2wxAg@mail.gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
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
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO


Hello!

On Tue 14-01-25 16:50:53, Joanne Koong wrote:
> I would like to propose a discussion topic about improving large folio
> writeback performance. As more filesystems adopt large folios, it
> becomes increasingly important that writeback is made to be as
> performant as possible. There are two areas I'd like to discuss:
> 
> == Granularity of dirty pages writeback ==
> Currently, the granularity of writeback is at the folio level. If one
> byte in a folio is dirty, the entire folio will be written back. This
> becomes unscalable for larger folios and significantly degrades
> performance, especially for workloads that employ random writes.
> 
> One idea is to track dirty pages at a smaller granularity using a
> 64-bit bitmap stored inside the folio struct where each bit tracks a
> smaller chunk of pages (eg for 2 MB folios, each bit would track 32k
> pages), and only write back dirty chunks rather than the entire folio.

Yes, this is known problem and as Dave pointed out, currently it is upto
the lower layer to handle finer grained dirtiness handling. You can take
inspiration in the iomap layer that already does this, or you can convert
your filesystem to use iomap (preferred way).

> == Balancing dirty pages ==
> It was observed that the dirty page balancing logic used in
> balance_dirty_pages() fails to scale for large folios [1]. For
> example, fuse saw around a 125% drop in throughput for writes when
> using large folios vs small folios on 1MB block sizes, which was
> attributed to scheduled io waits in the dirty page balancing logic. In
> generic_perform_write(), dirty pages are balanced after every write to
> the page cache by the filesystem. With large folios, each write
> dirties a larger number of pages which can grossly exceed the
> ratelimit, whereas with small folios each write is one page and so
> pages are balanced more incrementally and adheres more closely to the
> ratelimit. In order to accomodate large folios, likely the logic in
> balancing dirty pages needs to be reworked.

I think there are several separate issues here. One is that
folio_account_dirtied() will consider the whole folio as needing writeback
which is not necessarily the case (as e.g. iomap will writeback only dirty
blocks in it). This was OKish when pages were 4k and you were using 1k
blocks (which was uncommon configuration anyway, usually you had 4k block
size), it starts to hurt a lot with 2M folios so we might need to find a
way how to propagate the information about really dirty bits into writeback
accounting.

Another problem *may* be that fast increments to dirtied pages (as we dirty
512 pages at once instead of 16 we did in the past) cause over-reaction in
the dirtiness balancing logic and we throttle the task too much. The
heuristics there try to find the right amount of time to block a task so
that dirtying speed matches the writeback speed and it's plausible that
the large increments make this logic oscilate between two extremes leading
to suboptimal throughput. Also, since this was observed with FUSE, I belive
a significant factor is that FUSE enables "strictlimit" feature of the BDI
which makes dirty throttling more aggressive (generally the amount of
allowed dirty pages is lower). Anyway, these are mostly speculations from
my end. This needs more data to decide what exactly (if anything) needs
tweaking in the dirty throttling logic.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

