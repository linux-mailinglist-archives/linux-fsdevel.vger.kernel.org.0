Return-Path: <linux-fsdevel+bounces-10453-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9B384B54D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 13:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 949A81C24D82
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 12:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D952134CF0;
	Tue,  6 Feb 2024 12:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xVwxyley";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gmpDayKH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jkYDM+nz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="30hSAi4b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DE2134CEA;
	Tue,  6 Feb 2024 12:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707222541; cv=none; b=e/ZnRvzDP54TNP/YbQDIrQGpXcvZwZXnEGt1dnAnRciWVJXX5vD98CK0+u/GLpx/H5/tbOpCzYmBJ76aChS71es1gCu1n48ljnmhsFaexujh7cYPdubRjhW4gLgcUYvQuOpOW7HU0NcTu7QiW45h2uCvrMBXhHPtaRwXxXFNw0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707222541; c=relaxed/simple;
	bh=VBjZ4iAnpOC5YshUblel7Q7ms9brJlgx8tDTc5vjioo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKwm9CDiAO64Xamfuwa16abTBMGIGSWCYqeDBtLwJTPOXa04wpYmwN0OZDFgiU5qWr/wzViKdzycc6pirnYbL226dMATSZ6ft/ntlHBTRT5cERIQW0DYtOr3tl5YSF3ziCuH5oidL/LFnZfQ6KJM6MWf68kM+RHPJeLBPZFA/7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xVwxyley; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gmpDayKH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jkYDM+nz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=30hSAi4b; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D9E2521FF4;
	Tue,  6 Feb 2024 12:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707222538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=97XujLeKB/pzSnxqeV5jx2ZlV1MqcFgYnkGqFctpKng=;
	b=xVwxyleyVo1Yr5goTDT5pTdCj7Fch+5PsTkM6MeYIoCGtkdZzZHUOBDFEMmK9E718SQmYC
	ptOO0FLXjhbrIMvT6A2W/ZxhKccQ70pkYAummk5hjfiAcM4XSGuTy3X+lEzPqlvPL8uxEU
	0yFvzOlTJyEu/ZspQEffR8G/BXpr0to=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707222538;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=97XujLeKB/pzSnxqeV5jx2ZlV1MqcFgYnkGqFctpKng=;
	b=gmpDayKH/P05ZNAs6pYJ/W7/Ez+gHadWsOIQaGMIdngQwGRR90eDvRSAlqmz4wDXZqB8PQ
	Tl78H5UF8BYj+DCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707222537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=97XujLeKB/pzSnxqeV5jx2ZlV1MqcFgYnkGqFctpKng=;
	b=jkYDM+nzzguoj/27Jwngnu7L5Oa5WG7vQ3ETb8RKiCBza5CiMvw/u3+kpx1QVb734dJwyP
	eQsSbiqHmneO9SNLmY0YjAXzZ69OENzUp7Rwkb1mT5emxyfWekeJH/NV0O8BXVyEDpm6rR
	48gd4WCNV2pQVLxucVhvhHNI45/en6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707222537;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=97XujLeKB/pzSnxqeV5jx2ZlV1MqcFgYnkGqFctpKng=;
	b=30hSAi4bhWv7QWAy6tnPo3DAVBDkUPStsrRiyu3OIJXGRL3FproexVoXpVWKOhF5mOVvfg
	NUzUAWdeOi84vPDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C343D139D8;
	Tue,  6 Feb 2024 12:28:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nMepLwkmwmXnKAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 06 Feb 2024 12:28:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5886AA0809; Tue,  6 Feb 2024 13:28:57 +0100 (CET)
Date: Tue, 6 Feb 2024 13:28:57 +0100
From: Jan Kara <jack@suse.cz>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Jan Kara <jack@suse.cz>, linux-block <linux-block@vger.kernel.org>,
	Linux-Next Mailing List <linux-next@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	linux-fsdevel@vger.kernel.org, lkft-triage@lists.linaro.org,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: next: /dev/root: Can't open blockdev
Message-ID: <20240206122857.svm2ptz2hsvk4sco@quack3>
References: <CA+G9fYttTwsbFuVq10igbSvP5xC6bf_XijM=mpUqrJV=uvUirQ@mail.gmail.com>
 <20240206101529.orwe3ofwwcaghqvz@quack3>
 <CA+G9fYup=QzTAhV2Bh_p8tujUGYNzGYKBHXkcW7jhhG6QFUo_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYup=QzTAhV2Bh_p8tujUGYNzGYKBHXkcW7jhhG6QFUo_g@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.40 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[36.26%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.40

On Tue 06-02-24 15:53:34, Naresh Kamboju wrote:
> On Tue, 6 Feb 2024 at 15:45, Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 06-02-24 14:41:17, Naresh Kamboju wrote:
> > > All qemu's mount rootfs failed on Linux next-20230206 tag due to the following
> > > kernel crash.
> > >
> > > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > >
> > > Crash log:
> > > ---------
> > > <3>[    3.257960] /dev/root: Can't open blockdev
> > > <4>[    3.258940] VFS: Cannot open root device "/dev/sda" or
> > > unknown-block(8,0): error -16
> >
> > Uhuh, -16 is EBUSY so it seems Christian's block device opening changes are
> > suspect? Do you have some sample kconfig available somewhere?
> 
> All build information is in this url,
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2byqguFVp7MYAEjKo6nJGba2FcP/

Thanks! So for record the config has:

CONFIG_BLK_DEV_WRITE_MOUNTED=y

So we are not hitting any weird corner case with blocking writes to mounted
filesystems. It must be something else.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

