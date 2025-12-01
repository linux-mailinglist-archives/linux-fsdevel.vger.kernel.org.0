Return-Path: <linux-fsdevel+bounces-70334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E28BC97389
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 13:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 50BC33438B9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 12:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A309330C616;
	Mon,  1 Dec 2025 12:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kf+H2TDs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NZMwJMDT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gWsAifbt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Qu2Bz2in"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB83E30C613
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 12:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764591645; cv=none; b=RCWjXwYnXq1rg0dD48OiEXxFKeRyNgfzrkiIps2CUPz84kX7zjWpFgUEUkmXeFcWwdchc8WoA3YwknbMJ8OUpQmYxuRTR1Gpw3PD9Z7/D73XqUPfwFBF89G1ftxuadY1CbTyGjQsW8RFnLHZwvS/8EU/H3bgivz4OCebqb86Y2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764591645; c=relaxed/simple;
	bh=ksL4tfKu69Qba/rx/+9FuEO4EgwovIqzqRyBEQrKN04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GX+E9vyBsHokLscwGPthJIF+Tpe/jG4/2Yjh44xZRCQ8PNVbIW70leoAJjzpITCXqd081IeP6K2Gqmh6t0NbpdeVq4I/7wQUTZUGXNVlwiiHGoideqbOZKlQfAV07Y76lwfwyerzY8l96NTa/MD0ENXYwv7EATlRM8q22vSPzyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kf+H2TDs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NZMwJMDT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gWsAifbt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Qu2Bz2in; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 341425BDB1;
	Mon,  1 Dec 2025 12:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764591635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TuQYhYAH8ukuYELFqC8jeyQHZIE9q4z/01xlCbA+gq4=;
	b=kf+H2TDsR3X0QkpzRcRtsi9S28iLNIFcidwVnnUW7+cJB79chfBXzjGk/IVwAhjmsRUnzV
	SS3uGc9M/zDCzk2kSMxTc5dNLGs+KShFe7PPNYeUF0CMTd6dxb7amJubByLPz1Hgn/Ks93
	DDAk/GEU7mpZny34OCaL2RHtjeAyWQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764591635;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TuQYhYAH8ukuYELFqC8jeyQHZIE9q4z/01xlCbA+gq4=;
	b=NZMwJMDTh2mCRKYxZviLN9cfW09mdHArWDPel/dI8ocRXG5lrsNdvYOdCSFpuidpWcsGVU
	EtDLxcsuqYJ5ClCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gWsAifbt;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Qu2Bz2in
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764591634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TuQYhYAH8ukuYELFqC8jeyQHZIE9q4z/01xlCbA+gq4=;
	b=gWsAifbtn9x0yYk9q98PGJbHsWlAH3bGcIBUn89uYMpAojrGoGOeqndHY0RlGyZXu6tzKt
	z690WdIsrP6wTIJQMQHWLxjdDq149sczayWFkutV8XlPfJ+VvhF0fDKHIA8UoVHrqemEv2
	ClkYTXXTnHopqB5/OwnN59pBtj9iXY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764591634;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TuQYhYAH8ukuYELFqC8jeyQHZIE9q4z/01xlCbA+gq4=;
	b=Qu2Bz2inrtS6FCO5okU89CX9pI1zx8ehc7cwt/XUYU0FBhlQHwTgzRHXqx5p5MZkpq9+w7
	6RsrABxzI7QmcZBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 232393EA63;
	Mon,  1 Dec 2025 12:20:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id W2+OCBKILWnedQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 01 Dec 2025 12:20:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 189E8A09A3; Mon,  1 Dec 2025 13:20:29 +0100 (CET)
Date: Mon, 1 Dec 2025 13:20:29 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 0/13] fsnotify: Rework inode tracking
Message-ID: <p3qiohdacumtxe5jqwsxcevf4a3cdnsxvoiw6sfwu7qtem7k7t@wkwomodle5p7>
References: <20251127170509.30139-1-jack@suse.cz>
 <CAOQ4uxgOKH5_Nqu8wWCjPQ1Y0_40p76YrvLtOP-yOsYkHTDNNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgOKH5_Nqu8wWCjPQ1Y0_40p76YrvLtOP-yOsYkHTDNNw@mail.gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email,suse.com:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 341425BDB1
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Fri 28-11-25 12:08:12, Amir Goldstein wrote:
> On Thu, Nov 27, 2025 at 6:30 PM Jan Kara <jack@suse.cz> wrote:
> >
> > Hello!
> >
> > This patch set reworks how fsnotify subsystem tracks inodes.
> 
> I like the vision, but I think we need to break the problem into smaller
> pieces and solve them one at a time.
> 
> The first and foremost problem is the nasty races like [1] and more
> that are possible in upstream and stable kernels.
> 
> [1] https://lore.kernel.org/linux-unionfs/20250915101510.7994-1-acsjakub@amazon.de/
> 
> I think it is a worthy objective to be able to solve the race in stable
> kernels, so I am suggesting a more conservative approach...

So far nobody was able to hit these races in practice (even syzbot ;)) so I've
let my creativity go wild but perhaps you're right and we could make the
patch set so that the initial part of it is not very intrusive and deals with
the races. I did the patches the way they are because I was most interested
to see how the rhashtable idea works out and what we can simplify when
using it. Fixing the races was just a nice side effect :).

> > So far we have
> > held inode references from notification marks (connectors of list of
> > notification marks to be more precise). This has three issues:
> >
> > 1) Placing a notification mark pins inode in memory. Since inodes are
> > relatively big objects, users could pin significant amount of kernel memory
> > by this. This then requires administrators to configure suitable limits on
> > maximum amount of notification marks each user can place which is cumbersome.
> >
> > 2) During filesystem unmount we have walk a list of all inodes for the
> > superblock to drop these inode references. This is either slow (when we do
> > it before evicting all other inodes) or opens nasty races (when fsnotify()
> > can run after dcache for the superblock has been evicted).
> >
> 
> This can be solved by putting the inode connector on a list.
> AFAICT, the hash table code (which is ~90% of this pathset) is not needed to
> solve the race vs. inode walk problem.

Correct, the race-handling part could be made less intrusive by using a list.

> > 3) Since sb global inode list is a noticeable contention point we are trying
> > to transition its users to something else so that we can eventually get rid
> > of it.
> >
> > In this patch set, fsnotify subsystem tracks notification marks attached to
> > inodes in a specialrhashtable indexed by inode identifier. This way we can stop
> > holding inode references and instead disconnect notification marks from the
> > inode on inode eviction (and reconnect them when inode gets loaded into memory
> > again). Credit for the original idea of this tracking actually goes to Dave
> > Chinner.
> >
> > The patches are so far incomplete - I still need to implement proper handling
> > for filesystems where inode number isn't enough to identify the inode. isofs
> > is provided as a sample how such support will look like for these filesystems.
> 
> If you accept the POV that the hash table is an optimization to solve the
> pinned inodes situation, then when adding hash table code, I think it is
> safer to have opt-in sb flag to participate in "independent inode marks"
> and test the code first without having to implement all special filesystems
> fsnotify operations.
> 
> Heck, if only for memory optimization and not for the end goal of getting
> rid of global sb inode list, then there may be no reason at all for optimizing
> those special filesystems for recursive inotify memory usage - a problem
> that existed forever.

I'll consider this. So far I think it is beneficial for the lifetime rules
on all filesystems to be the same and it also allows us to get rid of the
inode pinning code which has its complexity. As I went through the
filesystems there aren't that many that need special treatment (like 19)
and for each of them the adaptation is fairly simple so it isn't that huge
task.

> > Also we need to decide what to do with evictable notification marks. With the
> > patches as is they are now never evicted. This makes sense because the main
> > reason behind evictable marks was to avoid pinning the inode. On the other
> > hand this *might* surprise some userspace - definitely it breaks couple of LTP
> > tests we have for evictable marks.
> 
> Those tests were never super reliable, because as in real workloads,
> users can't usually know, short of unmount, if inode was really evicted.
> 
> What we can do going forward is use this currently inval flag combo
> #define FAN_MARK_EVICTABLE_INODE \
>            (FAN_MARK_EVICTABLE | FAN_MARK_MOUNT)
> 
> to opt-in for not pinning the inode without loosing the mark
> as an explicit test for a kernel that supports this improvement,
> rather than users doing recursive inotify without knowing the consequences.

OK, I agree that if we have marks that no longer pin the inode, then adding a
way for userspace to discover this capability is sensible. But let's solve
that API question after we have the functionality merged.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

