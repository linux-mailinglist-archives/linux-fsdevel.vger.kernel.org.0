Return-Path: <linux-fsdevel+bounces-40712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B8EA26F93
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 11:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DDFA1885077
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 10:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34A920B1E0;
	Tue,  4 Feb 2025 10:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F/xJp6SL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="m9NoxGYd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F/xJp6SL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="m9NoxGYd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C9120AF69
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 10:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738666298; cv=none; b=cw4JHkb2BOa1+ZJ/IK0sKc2vpxbLGAh8JbRRe8MZROhU9XNR+FvuNZXlbvcNLJTjdMS4b7dcHz9/QuX0ZVcrzVrHkWprDejlRHkphy+cd7a6f+VIhHKmDtuuKMTukSAqjYRsVgN8ReLDAX4o40q8YVEc/o6ZajLse9n6mlvp4PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738666298; c=relaxed/simple;
	bh=HJR/sbLwekjmFUNqqIMVtCe+qXSxh5w7BpcXe6fRLFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awlN3RjrXYBWR/pWzNkc4kqFgLdCk4AWpRfmrFjop1ArkGYHF8TU9RmCOnCyETopj7eUEkxqdSnlHcJ8S/e8b8cIOYq5791uUu53jqEQ+39BlE83atzjFSO+LUD2goe04pI3zX495hX8v9/HiXZdsqyPECVb+8R5igRv6HnVBFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F/xJp6SL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=m9NoxGYd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=F/xJp6SL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=m9NoxGYd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9AC8D1F387;
	Tue,  4 Feb 2025 10:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738666294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bJbsvQr2WeVJ+c+4x96qbpV3fVNBXtHHVF2mU+pdzUc=;
	b=F/xJp6SLc3m7LL+BJPfCuNFSwD9AAWUkkiMrwM//GRatr2tEQfU5zjQyhqA8njbPAYa4Ke
	jOuxQ5e9GmiYfvgdvx2HbF++3ALm7K6LVImS8ZScNY3OPeo5x4hTXqXP4eSj7mvKeIqacg
	5F+SC+p2u3q+jyJUQrafqJFAulCFbsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738666294;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bJbsvQr2WeVJ+c+4x96qbpV3fVNBXtHHVF2mU+pdzUc=;
	b=m9NoxGYdATOHbeL6J98ZhV+l8SuXFXIt+nlqZZ5myRjXU8z4RXBzZm9olVK2cbc1lg5hll
	1qotO8adJu/CLhCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="F/xJp6SL";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=m9NoxGYd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738666294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bJbsvQr2WeVJ+c+4x96qbpV3fVNBXtHHVF2mU+pdzUc=;
	b=F/xJp6SLc3m7LL+BJPfCuNFSwD9AAWUkkiMrwM//GRatr2tEQfU5zjQyhqA8njbPAYa4Ke
	jOuxQ5e9GmiYfvgdvx2HbF++3ALm7K6LVImS8ZScNY3OPeo5x4hTXqXP4eSj7mvKeIqacg
	5F+SC+p2u3q+jyJUQrafqJFAulCFbsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738666294;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bJbsvQr2WeVJ+c+4x96qbpV3fVNBXtHHVF2mU+pdzUc=;
	b=m9NoxGYdATOHbeL6J98ZhV+l8SuXFXIt+nlqZZ5myRjXU8z4RXBzZm9olVK2cbc1lg5hll
	1qotO8adJu/CLhCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 888FE13795;
	Tue,  4 Feb 2025 10:51:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +EtOITbxoWcXHgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 04 Feb 2025 10:51:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C8E9DA082D; Tue,  4 Feb 2025 11:51:29 +0100 (CET)
Date: Tue, 4 Feb 2025 11:51:29 +0100
From: Jan Kara <jack@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, 
	lsf-pc@lists.linux-foundation.org, Shakeel Butt <shakeel.butt@linux.dev>, 
	David Hildenbrand <david@redhat.com>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Zi Yan <ziy@nvidia.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Jingbo Xu <jefflexu@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Removing writeback temp pages in FUSE
Message-ID: <aeszroqwtyj2drpxkoc3o6x6y56rltirgpbimg2qmgsr6jkzii@ntdx7xrpplhk>
References: <CAJnrk1ZCgff6ZWmqKzBXFq5uAEbms46OexA1axWS5v-PCZFqJg@mail.gmail.com>
 <43474a67d1af7ec03e2fade9e83c7702b74fe66b.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43474a67d1af7ec03e2fade9e83c7702b74fe66b.camel@kernel.org>
X-Rspamd-Queue-Id: 9AC8D1F387
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_ENVRCPT(0.00)[fastmail.fm,gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.linux-foundation.org,linux.dev,redhat.com,fastmail.fm,nvidia.com,szeredi.hu,linux.alibaba.com,vger.kernel.org,meta.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 28-01-25 14:59:37, Jeff Layton via Lsf-pc wrote:
> On Mon, 2025-01-27 at 13:44 -0800, Joanne Koong wrote:
> > Recently, there was a long discussion upstream [1] on a patchset that
> > removes temp pages when handling writeback in FUSE. Temp pages are the
> > main bottleneck for write performance in FUSE and local benchmarks
> > showed approximately a 20% and 45% improvement in throughput for 4K
> > and 1M block size writes respectively when temp pages were removed.
> > More information on how FUSE uses temp pages can be found here [2].
> > 
> > In the discussion, there were concerns from mm regarding the
> > possibility of untrusted malicious or buggy fuse servers never
> > completing writeback, which would impede migration for those pages.
> > 
> > It would be great to continue this discussion at LSF/MM and align on a
> > solution that removes FUSE temp pages altogether while satisfying mm’s
> > expectations for page migration. These are the most promising options
> > so far:
> > 
> > a) Kill untrusted fuse servers that do not reply to writeback requests
> > by a certain amount of time (where that time can be configurable
> > through a sysctl) as a safeguard for system resources
> > 
> > b) Use unmovable pages for untrusted fuse servers
> > 
> > If there are no acceptable solutions, it might also be worth
> > considering whether there could be mm options that could sufficiently
> > mitigate this problem. One potential idea is co-locating FUSE folio
> > allocations to the same page block so that the worst-case
> > malicious/buggy server scenario only hampers migration of one page
> > block.
> > 
> > If there is no way to remove temp pages altogether, then it would be
> > useful to discuss:
> > a) how skipping temp pages should be gated:
> >     i) unprivileged servers default to always using temp pages while
> > privileged servers skip temp pages
> >     ii) splice defaults to using temp pages and writeback for non-temp
> > pages get canceled if migration is initiated
> >     iii) skip temp pages if a sufficient enough request timeout is set
> > 
> 
> We might also consider coupling the above measures with a new limit on
> the number of unprivileged FUSE mounts a user is allowed to have. IIUC,
> a single unprivileged FUSE mount is only allowed a certain amount of
> dirty pages, but there is no real cap on the number of mounts that an
> unprivileged user can spawn.
> 
> A tunable hard cap on the number mounts allowed per uid would be a
> reasonable thing to consider. Most users won't need more than 32 or 64
> or so.

Yes, this might be interesting for general system management but I don't
think this is a definitive answer for the issue here. IMO it would be too
cumbersome to tune this (sometimes even small probability of migration
failure or similar issues is going to bite at times).

> > b) how to support large FUSE folios for writeback. Currently FUSE uses
> > an rb tree to track writeback state of temp pages but with large
> > folios, this gets unsustainable if concurrent writebacks happen on the
> > same page indices but are part of different sized folios, eg the
> > following scenario
> >       i)  writeback on a large folio is issued
> >      ii) the folio is copied to a tmp folio and writeback is cleared,
> > we add this writeback request to the rb tree
> >      iii) the folio in the pagecache is evicted
> >      iv) another write occurs on a larger range that encompasses the
> > range in the writeback in i) or on a subset of it
> > It seems likely that we will need to align on another data structure
> > instead of the rb tree to sufficiently handle this.
> > 
> > 
> > Thanks,
> > Joanne
> > 
> > [1] https://lore.kernel.org/linux-fsdevel/20241122232359.429647-5-joannelkoong@gmail.com/
> > [2] https://lore.kernel.org/linux-fsdevel/20241122232359.429647-1-joannelkoong@gmail.com/
> 
> 
> Miklos' has a good point about reads being a problem too. In fact, it
> might be simpler to start by dealing with reads.
> 
> While limiting what we can do with FUSE is all well and good, I wonder
> too if we might be able to allow pages to be migrated while reads or
> writeback is going on.

Yes, this sounds as an intriguing idea. Generally when we hand physical
addresses to the HW, we cannot touch the pages. But with FUSE we are giving
them to userspace and there's MMU there anyway. So at least from the first
look it should be possible to actually safely migrate these pages although
they have been handed to userspace server for IO.

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

