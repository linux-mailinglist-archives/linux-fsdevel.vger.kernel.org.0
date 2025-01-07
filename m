Return-Path: <linux-fsdevel+bounces-38556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B76BAA03BD8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 11:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0224163F94
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 10:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364031E0E16;
	Tue,  7 Jan 2025 10:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bjeHVxgd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="N1n5DiVX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bjeHVxgd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="N1n5DiVX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B4F1547D2
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jan 2025 10:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736244501; cv=none; b=RrUcQBlLKzSTWDg6JoecBAF9H5spTG6w7wqybaToqR/hFRe/wxA/X0YTGKb7pJB56tEOcDl2FByjSXtvB0Kig0Jb1NzWajtrxjzJqKGK+OJXByJZ2TpzYdAVrNvSEaIsChEheZMKaidTtS4u2h7PtQad37qSH0RRaGkmS4YgFzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736244501; c=relaxed/simple;
	bh=syQ0UcB0WElaq0BBcrLtEHxdQcHj7yNus0G4Km6uNCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y//X4OPXEV9a5Ev+2Lc+2mo0gGyDINMGKq87pH8vOGhy2f/VwWKkevKi0lfLicJgVxjialf/IYmgfRE/ImwgAfP49lpFMbVffLYOPBiZoJKzmGozXv/9a5opptWVL+RAYCCT0cXQLPrvjxJesGqby2y5LH0ZwQ8ZrtYb06vHKpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bjeHVxgd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=N1n5DiVX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bjeHVxgd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=N1n5DiVX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5FD7421106;
	Tue,  7 Jan 2025 10:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736244494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5pTKHH7AwBByQVPLNvCYyaEpc2MIKxRmp803bVr2DnA=;
	b=bjeHVxgdOakFgQFP5LjOBLHrBl7AO6GyzeY1r4L1Y7BWSs5df6+Jc4r8dEwxQM28QSjXIY
	Sa/Cmm91z+2GALtev+XHH/5KXokZXIFDGfOT1sk+/b35Ma4NBvhJaPeAwJeNAHfTxiO5Ib
	PdTcFr8sOj/BYtXFIJ/czSA071qH33c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736244494;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5pTKHH7AwBByQVPLNvCYyaEpc2MIKxRmp803bVr2DnA=;
	b=N1n5DiVX1rUpsOkSRxzwvUmWxuVYgYFljZtnECxiCLprrsQEhyMExIDqrXqsIEpQQIM16J
	prLGZiJ/V3MX7DBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bjeHVxgd;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=N1n5DiVX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736244494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5pTKHH7AwBByQVPLNvCYyaEpc2MIKxRmp803bVr2DnA=;
	b=bjeHVxgdOakFgQFP5LjOBLHrBl7AO6GyzeY1r4L1Y7BWSs5df6+Jc4r8dEwxQM28QSjXIY
	Sa/Cmm91z+2GALtev+XHH/5KXokZXIFDGfOT1sk+/b35Ma4NBvhJaPeAwJeNAHfTxiO5Ib
	PdTcFr8sOj/BYtXFIJ/czSA071qH33c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736244494;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5pTKHH7AwBByQVPLNvCYyaEpc2MIKxRmp803bVr2DnA=;
	b=N1n5DiVX1rUpsOkSRxzwvUmWxuVYgYFljZtnECxiCLprrsQEhyMExIDqrXqsIEpQQIM16J
	prLGZiJ/V3MX7DBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52A4413A6A;
	Tue,  7 Jan 2025 10:08:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7Z4tFA79fGfXXgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 07 Jan 2025 10:08:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DE343A091E; Tue,  7 Jan 2025 11:08:13 +0100 (CET)
Date: Tue, 7 Jan 2025 11:08:13 +0100
From: Jan Kara <jack@suse.cz>
To: Cedric Blancher <cedric.blancher@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] sysv: Remove the filesystem
Message-ID: <dl55ihsxe45c7bv2g7w7hlqugs3wdwebfpuanzcxe4qsvm5uzt@dzafyykaaeyj>
References: <20250106162401.21156-1-jack@suse.cz>
 <b4a292ba5a33cc5d265a46824057fe001ed2ced6.camel@kernel.org>
 <20250106233112.GI6156@frogsfrogsfrogs>
 <CALXu0UcWsAcDMZqAP=wM5mb9o0-T+sPyFxLcWpHZNbDWguLKEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALXu0UcWsAcDMZqAP=wM5mb9o0-T+sPyFxLcWpHZNbDWguLKEA@mail.gmail.com>
X-Rspamd-Queue-Id: 5FD7421106
X-Spam-Level: 
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Tue 07-01-25 08:17:00, Cedric Blancher wrote:
> I disagree with the removal.
> 
> This is still being used, but people running Debian will notice such
> bugs only with the next stable release. Imagine their nasty xmas
> present when SYSVFS support is gone for no reason.

Hum, do you *know* any user of sysv filesystem driver? Because the kernel
should be spewing warnings for sleeping in atomic context left and right when
you use that driver for 20 years and nobody complained.

> Better add a test to CI

That's easier said than done. AFAIK we don't have tools to create the
filesystem or verify its integrity. And perhaps most importantly I don't
know of anyone wishing to invest their time into keeping this filesystem
alive. Are you volunteering to become a SYSV maintainer?

								Honza


> On Tue, 7 Jan 2025 at 00:31, Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Mon, Jan 06, 2025 at 02:52:11PM -0500, Jeff Layton wrote:
> > > On Mon, 2025-01-06 at 17:24 +0100, Jan Kara wrote:
> > > > Since 2002 (change "Replace BKL for chain locking with sysvfs-private
> > > > rwlock") the sysv filesystem was doing IO under a rwlock in its
> > > > get_block() function (yes, a non-sleepable lock hold over a function
> > > > used to read inode metadata for all reads and writes).  Nobody noticed
> > > > until syzbot in 2023 [1]. This shows nobody is using the filesystem.
> > > > Just drop it.
> > > >
> > > > [1] https://lore.kernel.org/all/0000000000000ccf9a05ee84f5b0@google.com/
> > > >
> > > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > > ---
> > > >  What do people think about this? Or should we perhaps go through a (short)
> > > >  deprecation period where we warn about removal?
> > > >
> > >
> > > FWIW, it was orphaned in 2023:
> > >
> > >     commit a8cd2990b694ed2c0ef0e8fc80686c664b4ebbe5
> > >     Author: Christoph Hellwig <hch@lst.de>
> > >     Date:   Thu Feb 16 07:29:22 2023 +0100
> > >
> > >         orphan sysvfs
> > >
> > >         This code has been stale for years and I have no way to test it.
> > >
> > >
> > > Given how long this was broken with no one noticing, and since it's not
> > > being adequately tested, I vote we remove it.
> >
> > I concur, if someone really wants this we can always add it back (after
> > making them deal with the bugs):
> >
> > Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> >
> > --D
> >
> > >
> > > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > >
> >
> 
> 
> -- 
> Cedric Blancher <cedric.blancher@gmail.com>
> [https://plus.google.com/u/0/+CedricBlancher/]
> Institute Pasteur
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

