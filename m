Return-Path: <linux-fsdevel+bounces-58222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07944B2B505
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 01:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A2E3188C20F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 23:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26AC2253A1;
	Mon, 18 Aug 2025 23:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ool6jtOu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t82DzWUO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ool6jtOu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t82DzWUO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C2D1A8F97
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 23:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755560821; cv=none; b=YNBCnVT1bLVvFwNb0Kr0By/Ch6oFMvDUShFjZl0S4928BT334Hm9pBlfLZbtvo9XNal/tvg+SEyBK8f8HCy5r4yc9R9tTq2q/zKRwmYxuxYkSHPkijNx08ElTQEEicAO1Lx+oY1hYg6KzXFhUal6yKZWVgZWB8XYk3TczYPlkRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755560821; c=relaxed/simple;
	bh=EUIaYawZIEI778Q0jpb2ysU3mSttgdtYb2SKSDL2mic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b9xGTDG1JUe6yVfkVWKXHKC5wWNczpThN/cqnWVfa7pxLYDH16aibuZMO0weFJ1n+yzkMDmgXMeRix35ou+gbKgFIp6mfDe976QVgFbMyTFa+cBATp714wXhCllvg5uhSLJj1j+HWHchqXQsS+JepIhcrcwdiw4r4yHoMChQmfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ool6jtOu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=t82DzWUO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ool6jtOu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=t82DzWUO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 18E0021200;
	Mon, 18 Aug 2025 23:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755560817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kKPdfAGF6R26ubinwcGOkXEjKG7rKKI1AkRQ36bglwk=;
	b=ool6jtOuF303p0ePZTwpsLaYfYRSVY1qgmJDdOGIfAT3+gFK55u2PfkfnCqH/5/IgKZ1lv
	1m7O5bCgcLbRaZ47Tf0+lU7nFDw8G4+RE4KnutoABLZd0U0qlu1LzMjr9HJClwrnLesdi8
	XVnAD2eG4xXXpBUroFzbEVJ45wzfGjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755560817;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kKPdfAGF6R26ubinwcGOkXEjKG7rKKI1AkRQ36bglwk=;
	b=t82DzWUOX0JXT3objeIK1E7fC+Po0ICEomOqeCajU7flwO4rXxTtb6bvxGJxY5ocI4WxOS
	2klxP5zGZSyNvqCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ool6jtOu;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=t82DzWUO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755560817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kKPdfAGF6R26ubinwcGOkXEjKG7rKKI1AkRQ36bglwk=;
	b=ool6jtOuF303p0ePZTwpsLaYfYRSVY1qgmJDdOGIfAT3+gFK55u2PfkfnCqH/5/IgKZ1lv
	1m7O5bCgcLbRaZ47Tf0+lU7nFDw8G4+RE4KnutoABLZd0U0qlu1LzMjr9HJClwrnLesdi8
	XVnAD2eG4xXXpBUroFzbEVJ45wzfGjQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755560817;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kKPdfAGF6R26ubinwcGOkXEjKG7rKKI1AkRQ36bglwk=;
	b=t82DzWUOX0JXT3objeIK1E7fC+Po0ICEomOqeCajU7flwO4rXxTtb6bvxGJxY5ocI4WxOS
	2klxP5zGZSyNvqCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3DCA413686;
	Mon, 18 Aug 2025 23:46:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9bNGOG67o2isMQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 18 Aug 2025 23:46:54 +0000
Date: Tue, 19 Aug 2025 09:46:48 +1000
From: David Disseldorp <ddiss@suse.de>
To: Nicolas Schier <nsc@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-next@vger.kernel.org
Subject: Re: [PATCH v2 0/7] gen_init_cpio: add copy_file_range / reflink
 support
Message-ID: <20250819094648.186b037c.ddiss@suse.de>
In-Reply-To: <aKNzl1Oo2zzPYGQP@levanger>
References: <20250814054818.7266-1-ddiss@suse.de>
	<aKNzl1Oo2zzPYGQP@levanger>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 18E0021200
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.51

On Mon, 18 Aug 2025 20:40:23 +0200, Nicolas Schier wrote:

> On Thu, Aug 14, 2025 at 03:17:58PM +1000, David Disseldorp wrote:
> > This patchset adds copy_file_range() support to gen_init_cpio. When
> > combined with data segment alignment, large-file archiving performance
> > is improved on Btrfs and XFS due to reflinks (see 7/7 benchmarks).
> > 
> > cpio data segment alignment is provided by "bending" the newc spec
> > to zero-pad the filename field. GNU cpio and Linux initramfs extractors
> > handle this fine as long as PATH_MAX isn't exceeded.
> > 
> > Changes since v1 RFC
> > - add alignment patches 6-7
> > - slightly rework commit and error messages
> > - rename l->len to avoid 1/i confusion
> > 
> > David Disseldorp (7):
> >       gen_init_cpio: write to fd instead of stdout stream
> >       gen_init_cpio: support -o <output_path> parameter
> >       gen_init_cpio: attempt copy_file_range for file data
> >       gen_init_cpio: avoid duplicate strlen calls
> >       gen_initramfs.sh: use gen_init_cpio -o parameter
> >       docs: initramfs: file data alignment via name padding
> >       gen_init_cpio: add -a <data_align> as reflink optimization
> > 
> >  .../driver-api/early-userspace/buffer-format.rst   |   5 +
> >  usr/gen_init_cpio.c                                | 234 ++++++++++++++-------
> >  usr/gen_initramfs.sh                               |   7 +-
> >  3 files changed, 166 insertions(+), 80 deletions(-)
> > 
> >   
> 
> Thanks for the series!  I have found only a minor nick pick and some few
> bike-shedding things.
> 
> Reviewed-by: Nicolas Schier <nsc@kernel.org>

Thanks a lot for the review, Nicolas!
I'll post a v3 with your suggestions addressed, as I have one further
initramfs_test.c patch to padded filename test coverage.

Cheers, David

