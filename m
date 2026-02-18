Return-Path: <linux-fsdevel+bounces-77596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GmQLfr4lWlMXgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 18:38:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C371585CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 18:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A9D4300D979
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 17:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8816F3451DA;
	Wed, 18 Feb 2026 17:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="chjdh5XH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8FLJRHIA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LpDGGDTw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zBV5uAub"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA792FFDF7
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 17:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771436273; cv=none; b=RFlbXfbefwN8jkYgPk9YCvNW8DE7bkMBh8boomWk0Ro/VLEUzMvx0RBkdXqhv9GGo3vpjA5jpUfBfdhF4rny3/eZRx6EGLDTpewXoH96FXAPjyPTRkeINqF5AGDLTRezbcFBMbfLNBUhV5C/vP1hIR9ERRR1mRsqf+qgphFJF8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771436273; c=relaxed/simple;
	bh=76Ff56fbPG+YupOH2t4752VyNFaSp8jKGjIYeYZAAsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQBgdBlaK8I9lOf0WEHg8eQ84aiJXZHyA/jC3lYTBmVpJV1QMAvCnDrZnfWk+FmMaZboGkvX6zRiwe0HAva3ovOg/jn0jfv85xOd/i1OmInlpZ+GHVfAYhiOOYtXmJt6HqO+X/c3weGV7N+hnSbRCZ0xIbe4PE3ky0AiPx/8q4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=chjdh5XH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8FLJRHIA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LpDGGDTw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zBV5uAub; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DAF533E6D4;
	Wed, 18 Feb 2026 17:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771436270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KiZMR2ATXrpcVfWnnpGxqgw91jILZgAAnYQZEzfr0rU=;
	b=chjdh5XHQ+spZBLzRoayZvH6v3WCn9Eh7IwU1q7gx5e2Ktw0hr9RCIvNZDkdRD01Tg12z1
	z5ACcsrgXLSZnOVdiEYiwoY1NaUMAUuG2CUTxuC42+WFxXtadrNkb0w1PAbJnfKbvsYnju
	lU115Yrm+Syi3d5vKeOjFJXTsemsKhc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771436270;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KiZMR2ATXrpcVfWnnpGxqgw91jILZgAAnYQZEzfr0rU=;
	b=8FLJRHIAucgH0EEOwmbJ+dxSNSPw1CIvtLVWU9j+/afBiV/Duq/SRGWidsB582/a9fZkgB
	6UjbSABipwpw34Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771436269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KiZMR2ATXrpcVfWnnpGxqgw91jILZgAAnYQZEzfr0rU=;
	b=LpDGGDTwuOY9t6+AZxVmD5Mj+fPPuD/AFbECH5A9xW/tCjPbDDtnhWeQNBdHdL0CbuaPWY
	pteqfXfNJ7rXCIdglDBGZk/jba07QkBygebUoZcq/6ZogWMi3xTV81a+ypv+eWv5713m+y
	McJNc/rPVvvMDN3L6Db8XfKf4WFrd5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771436269;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KiZMR2ATXrpcVfWnnpGxqgw91jILZgAAnYQZEzfr0rU=;
	b=zBV5uAubWbzcySDYHmKue/ElL13lBzL4CztINAngAwBuduN9S4FoRYJqsydV74Njz4a+Yd
	md66EnPx1s8caKBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2F3F3EA65;
	Wed, 18 Feb 2026 17:37:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pL+RL+34lWnXaAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 18 Feb 2026 17:37:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6AE5FA08CF; Wed, 18 Feb 2026 18:37:45 +0100 (CET)
Date: Wed, 18 Feb 2026 18:37:45 +0100
From: Jan Kara <jack@suse.cz>
To: Andres Freund <andres@anarazel.de>
Cc: Jan Kara <jack@suse.cz>, Pankaj Raghav <pankaj.raghav@linux.dev>, 
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-xfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, lsf-pc@lists.linux-foundation.org, djwong@kernel.org, 
	john.g.garry@oracle.com, willy@infradead.org, hch@lst.de, ritesh.list@gmail.com, 
	Luis Chamberlain <mcgrof@kernel.org>, dchinner@redhat.com, Javier Gonzalez <javier.gonz@samsung.com>, 
	gost.dev@samsung.com, tytso@mit.edu, p.raghav@samsung.com, vi.shah@samsung.com
Subject: Re: [LSF/MM/BPF TOPIC] Buffered atomic writes
Message-ID: <umq2nlgxqp4xbrp23zjiajwd6ombed4dfwbajuh35xd4vphyee@26g2y6a4rdnu>
References: <d0c4d95b-8064-4a7e-996d-7ad40eb4976b@linux.dev>
 <aY8n97G_hXzA5MMn@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <7cf3f249-453d-423a-91d1-dfb45c474b78@linux.dev>
 <zzvybbfy6bcxnkt4cfzruhdyy6jsvnuvtjkebdeqwkm6nfpgij@dlps7ucza22s>
 <wkczfczlmstoywbmgfrxzm6ko4frjsu65kvpwquzu7obrjcd3f@6gs5nsfivc6v>
 <2planlrvjqicgpparsdhxipfdoawtzq3tedql72hoff4pdet6t@btxbx6cpoyc6>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2planlrvjqicgpparsdhxipfdoawtzq3tedql72hoff4pdet6t@btxbx6cpoyc6>
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77596-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[suse.cz,linux.dev,linux.ibm.com,vger.kernel.org,kvack.org,lists.linux-foundation.org,kernel.org,oracle.com,infradead.org,lst.de,gmail.com,redhat.com,samsung.com,mit.edu];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 10C371585CC
X-Rspamd-Action: no action

On Tue 17-02-26 11:13:07, Andres Freund wrote:
> > > P1: pwritev(fd, [blocks 1-10], RWF_ATOMIC) start & completes
> > > Kernel: starts writeback but doesn't complete it
> > > P1: pwrite(fd, [any block in 1-10]), non-atomically
> > > Kernel: completes writeback
> > >
> > > The former is not at all an issue for postgres' use case, the pages in
> > > our buffer pool that are undergoing IO are locked, preventing additional
> > > IO (be it reads or writes) to those blocks.
> > >
> > > The latter would be a problem, since userspace wouldn't even know that
> > > here is still "atomic writeback" going on, afaict the only way we could
> > > avoid it would be to issue an f[data]sync(), which likely would be
> > > prohibitively expensive.
> >
> > It somewhat depends on what outcome you expect in terms of crash safety :)
> > Unless we are careful, the RWF_ATOMIC write in your latter example can end
> > up writing some bits of the data from the second write because the second
> > write may be copying data to the pages as we issue DMA from them to the
> > device.
> 
> Hm. It's somewhat painful to not know when we can write in what mode again -
> with DIO that's not an issue. I guess we could use
> sync_file_range(SYNC_FILE_RANGE_WAIT_BEFORE) if we really needed to know?
> Although the semantics of the SFR flags aren't particularly clear, so maybe
> not?

If you used RWF_WRITETHROUGH for your writes (so you are sure IO has
already started) then sync_file_range(SYNC_FILE_RANGE_WAIT_BEFORE) would
indeed be a safe way of waiting for that IO to complete (or just wait for
the write(2) syscall itself to complete if we make RWF_WRITETHROUGH wait
for IO completion as Dave suggests - but I guess writes may happen from
multiple threads so that may be not very convenient and sync_file_range(2)
might be actually easier).

> > I expect this isn't really acceptable because if you crash before
> > the second write fully makes it to the disk, you will have inconsistent
> > data.
> 
> The scenarios that I can think that would lead us to doing something like
> this, are when we are overwriting data without regard for the prior contents,
> e.g:
> 
> An already partially filled page is filled with more rows, we write that page
> out, then all the rows are deleted, and we re-fill the page with new content
> from scratch. Write it out again.  With our existing logic we treat the second
> write differently, because the entire contents of the page will be in the
> journal, as there is no prior content that we care about.
> 
> A second scenario in which we might not use RWF_ATOMIC, if we carry today's
> logic forward, is if a newly created relation is bulk loaded in the same
> transaction that created the relation. If a crash were to happen while that
> bulk load is ongoing, we don't care about the contents of the file(s), as it
> will never be visible to anyone after crash recovery.  In this case we won't
> have prio RWF_ATOMIC writes - but we could have the opposite, i.e. an
> RWF_ATOMIC write while there already is non-RWF_ATOMIC dirty data in the page
> cache. Would that be an issue?

No, this should be fine. But as I'm thinking about it what seems the most
natural is that RWF_WRITETHROUGH writes will wait on any pages under
writeback in the target range before proceeding with the write. That will
give user proper serialization with other RWF_WRITETHROUGH writes to the
overlapping range as well as writeback from previous normal writes. So the
only case that needs handling - either by userspace or kernel forcing
stable writes - would be RWF_WRITETHROUGH write followed by a normal write.

> It's possible we should just always use RWF_ATOMIC, even in the cases where
> it's not needed from our side, to avoid potential performance penalties and
> "undefined behaviour".  I guess that will really depend on the performance
> penalty that RWF_ATOMIC will carry and whether multiple-atomicity-mode will
> eventually be supported (as doing small writes during bulk loading is quite
> expensive).

Sure, that's a possibility as well. I guess it requires some
experimentation and benchmarking to pick a proper tradeoff.

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

