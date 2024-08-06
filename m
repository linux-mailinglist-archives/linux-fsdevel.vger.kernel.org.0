Return-Path: <linux-fsdevel+bounces-25099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0298949128
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 15:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14351C20B9C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 13:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4699C1D175E;
	Tue,  6 Aug 2024 13:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="whal1OTA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gjg8Z3oV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="whal1OTA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gjg8Z3oV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844631C2324
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 13:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722950681; cv=none; b=AojBgH00wB9bKaYdwxC33SH5gxFZtxShYr0tgJ4sRPBDkaeEjo1o4XYusIN6wY8pYbjdiRchz70ad9h0oEqjm0as2ISPZQ0hvkj4CXo86ghgbG/bKLhrkVSH3tF+sgpaYkDhnHEwRxCtymPb+UQ/nAUHZS111nMFDKOEqcs0/DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722950681; c=relaxed/simple;
	bh=OAntfKIifAAEAiBhfF3jYfk6H0/LwQ0PwjTEmH3NGh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6itPt3yT3KyKw02DsxbEhk9GSfGYfx8qUwzCImAAze7aB827BEYFvl4tnqzWg7ZIGuFRHhF2c4d5XwNjZEmdac5X6iKkrTZNfBrvUsOTvjsk9x4K6cqBBdvpmWIvGFdWWETQQiv/u2u+gdbi5b2w1x6Rfh2+n8LRp8eVVKPkcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=whal1OTA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gjg8Z3oV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=whal1OTA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gjg8Z3oV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6AD2721C4F;
	Tue,  6 Aug 2024 13:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722950677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=05jXnwlVlHyjUgVebLBbuQB6glngt8hh9VerdiVBf0k=;
	b=whal1OTAJOoSM69VvQfC/jq5Vz6p4/2suH83LmcLqedi/7Lq7WDXb9camR+4sQcLtJDSWA
	7OM0qOsKzVaBiGzOVcJNp6N1jG+kyP8q4vtUMQNcnUJewTrzOw3HwwIDuLu5448rHozXo5
	q35EARxk6HN6Wxf6nDa/W9bsymoRnmk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722950677;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=05jXnwlVlHyjUgVebLBbuQB6glngt8hh9VerdiVBf0k=;
	b=gjg8Z3oVMrM/Q7hU3UkFiwvhRhTEzZV325E6G+1Bd4Gra3KCHjkayN/950v6n0kTFsxAne
	TDwRiSSKJ++cReBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=whal1OTA;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gjg8Z3oV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722950677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=05jXnwlVlHyjUgVebLBbuQB6glngt8hh9VerdiVBf0k=;
	b=whal1OTAJOoSM69VvQfC/jq5Vz6p4/2suH83LmcLqedi/7Lq7WDXb9camR+4sQcLtJDSWA
	7OM0qOsKzVaBiGzOVcJNp6N1jG+kyP8q4vtUMQNcnUJewTrzOw3HwwIDuLu5448rHozXo5
	q35EARxk6HN6Wxf6nDa/W9bsymoRnmk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722950677;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=05jXnwlVlHyjUgVebLBbuQB6glngt8hh9VerdiVBf0k=;
	b=gjg8Z3oVMrM/Q7hU3UkFiwvhRhTEzZV325E6G+1Bd4Gra3KCHjkayN/950v6n0kTFsxAne
	TDwRiSSKJ++cReBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D93813981;
	Tue,  6 Aug 2024 13:24:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id N7xMFhUksma4RgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 06 Aug 2024 13:24:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C4B4DA0762; Tue,  6 Aug 2024 15:24:32 +0200 (CEST)
Date: Tue, 6 Aug 2024 15:24:32 +0200
From: Jan Kara <jack@suse.cz>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Jan Kara <jack@suse.cz>, viro@zeniv.linux.org.uk, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH] fs: Add a new flag RWF_IOWAIT for preadv2(2)
Message-ID: <20240806132432.jtdlv5trklgxwez4@quack3>
References: <20240804080251.21239-1-laoar.shao@gmail.com>
 <20240805134034.mf3ljesorgupe6e7@quack3>
 <CALOAHbCor0VoCNLACydSytV7sB8NK-TU2tkfJAej+sAvVsVDwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbCor0VoCNLACydSytV7sB8NK-TU2tkfJAej+sAvVsVDwA@mail.gmail.com>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 6AD2721C4F
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,zeniv.linux.org.uk,kernel.org,vger.kernel.org,fromorbit.com,gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Tue 06-08-24 19:54:58, Yafang Shao wrote:
> On Mon, Aug 5, 2024 at 9:40 PM Jan Kara <jack@suse.cz> wrote:
> > On Sun 04-08-24 16:02:51, Yafang Shao wrote:
> > > Background
> > > ==========
> > >
> > > Our big data workloads are deployed on XFS-based disks, and we frequently
> > > encounter hung tasks caused by xfs_ilock. These hung tasks arise because
> > > different applications may access the same files concurrently. For example,
> > > while a datanode task is writing to a file, a filebeat[0] task might be
> > > reading the same file concurrently. If the task writing to the file takes a
> > > long time, the task reading the file will hang due to contention on the XFS
> > > inode lock.
> > >
> > > This inode lock contention between writing and reading files only occurs on
> > > XFS, but not on other file systems such as EXT4. Dave provided a clear
> > > explanation for why this occurs only on XFS[1]:
> > >
> > >   : I/O is intended to be atomic to ordinary files and pipes and FIFOs.
> > >   : Atomic means that all the bytes from a single operation that started
> > >   : out together end up together, without interleaving from other I/O
> > >   : operations. [2]
> > >   : XFS is the only linux filesystem that provides this behaviour.
> > >
> > > As we have been running big data on XFS for years, we don't want to switch
> > > to other file systems like EXT4. Therefore, we plan to resolve these issues
> > > within XFS.
> > >
> > > Proposal
> > > ========
> > >
> > > One solution we're currently exploring is leveraging the preadv2(2)
> > > syscall. By using the RWF_NOWAIT flag, preadv2(2) can avoid the XFS inode
> > > lock hung task. This can be illustrated as follows:
> > >
> > >   retry:
> > >       if (preadv2(fd, iovec, cnt, offset, RWF_NOWAIT) < 0) {
> > >           sleep(n)
> > >           goto retry;
> > >       }
> > >
> > > Since the tasks reading the same files are not critical tasks, a delay in
> > > reading is acceptable. However, RWF_NOWAIT not only enables IOCB_NOWAIT but
> > > also enables IOCB_NOIO. Therefore, if the file is not in the page cache, it
> > > will loop indefinitely until someone else reads it from disk, which is not
> > > acceptable.
> > >
> > > So we're planning to introduce a new flag, IOCB_IOWAIT, to preadv2(2). This
> > > flag will allow reading from the disk if the file is not in the page cache
> > > but will not allow waiting for the lock if it is held by others. With this
> > > new flag, we can resolve our issues effectively.
> > >
> > > Link: https://lore.kernel.org/linux-xfs/20190325001044.GA23020@dastard/ [0]
> > > Link: https://github.com/elastic/beats/tree/master/filebeat [1]
> > > Link: https://pubs.opengroup.org/onlinepubs/009695399/functions/read.html [2]
> > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > Cc: Dave Chinner <david@fromorbit.com>
> >
> > Thanks for the detailed explanation! I understand your problem but I have to
> > say I find this flag like a hack to workaround particular XFS behavior and
> > the guarantees the new RWF_IOWAIT flag should provide are not very clear to
> > me.
> 
> Its guarantee is clear:
> 
>   : I/O is intended to be atomic to ordinary files and pipes and FIFOs.
>   : Atomic means that all the bytes from a single operation that started
>   : out together end up together, without interleaving from other I/O
>   : operations.

Oh, I understand why XFS does locking this way and I'm well aware this is
a requirement in POSIX. However, as you have experienced, it has a
significant performance cost for certain workloads (at least with simple
locking protocol we have now) and history shows users rather want the extra
performance at the cost of being a bit more careful in userspace. So I
don't see any filesystem switching to XFS behavior until we have a
performant range locking primitive.

> What this flag does is avoid waiting for this type of lock if it
> exists. Maybe we should consider a more descriptive name like
> RWF_NOATOMICWAIT, RWF_NOFSLOCK, or RWF_NOPOSIXWAIT? Naming is always
> challenging.

Aha, OK. So you want the flag to mean "I don't care about POSIX read-write
exclusion". I'm still not convinced the flag is a great idea but
RWF_NOWRITEEXCLUSION could perhaps better describe the intent of the flag.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

