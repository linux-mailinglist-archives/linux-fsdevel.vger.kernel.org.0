Return-Path: <linux-fsdevel+bounces-30379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E27D398A6DE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 16:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EB06B22662
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 14:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF7F19049B;
	Mon, 30 Sep 2024 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oQOIubJv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eU2U7l7j";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZXKypRn9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qgTRa9DM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD412CA5;
	Mon, 30 Sep 2024 14:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727705908; cv=none; b=gjdt1hDHwLsAlriNSwyvpWvzd2qIFfz6vfk4f4TKXDX84De0WGHZ4Q8bhu4cJO/EYX0sfU6FRTZS0OaLPz7ID8O9A6UPzsh8FrmjgGhkg78NeBWjwV3zINHGY00e0xN5zIpgBKs69qMNyBHPrXeuYXoNOciEz77IV7TLxl1ZwNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727705908; c=relaxed/simple;
	bh=1sxA7K02Jj/JRaDvAujnM2cgpl168z8rMPMnUZjbcYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iEf+eLcVqk5S90l9pW2cnyadEsuHVZpGf9tPgUQcl6ciGvdSFB8IFGLhcgM55tQrYxG5Uh5MH2U8JNouvKmFJsyrSEFa7jX7q4e9WeuYenUVp4C5dTiBldoG2w5u3XXnMWGLNRXwOjXhhijTMF0XSSNuXUuB+L0BdeozSP/JSf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oQOIubJv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eU2U7l7j; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZXKypRn9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qgTRa9DM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E5DC21FBAC;
	Mon, 30 Sep 2024 14:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727705904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HGAGZwu1KK8fBCYpuB/ipxUhHna1zSwnUUhkngNYVcE=;
	b=oQOIubJvVB5fGbM720M+yr59VBiD+XA/tPA7+aVDk3K5REPI2w06nhIgH2Jx8hDvsv9g2M
	trn1mJI9msnmjnL44gtFladFfJn2bbs5tGg4pwI6ILa8bYkCYzl1UUPLiM92QAbqjhvqEk
	D6LfyUhGqnqxoxtuRjXuZz0MUz33yEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727705904;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HGAGZwu1KK8fBCYpuB/ipxUhHna1zSwnUUhkngNYVcE=;
	b=eU2U7l7jQsgvjGuTl2SO1P2Bliz3IEM8M9wnaQ9n/ps4U0aWdM85QW6sqQTuOHDKF661qU
	qqgWuChD3ZDlqYDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZXKypRn9;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qgTRa9DM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727705903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HGAGZwu1KK8fBCYpuB/ipxUhHna1zSwnUUhkngNYVcE=;
	b=ZXKypRn9B9Jm+kMno1hmhGnlyDsq+5Z0mqO44ElQtXIqqjqwGXiRCNtxUYjdgBCPGZrO0K
	PrzPy823p0rIReUUrnKG1aEaBJVsWBVOhu1ZmJ7YZOlgpUrQUaB+a9FbLvooVbtxePmPy1
	+cl9UwCn365KDomRSzFVRy7cdHZHhxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727705903;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HGAGZwu1KK8fBCYpuB/ipxUhHna1zSwnUUhkngNYVcE=;
	b=qgTRa9DMJA/CgCPS/5P5mehbVINY8eB9oZNUrefPsKzLGf8TF1fm0a18Rx5p6q9qHtZrs3
	qG/20Cq0kR3DhJCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA96A13A8B;
	Mon, 30 Sep 2024 14:18:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lcdZNS+z+mZ0DgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 30 Sep 2024 14:18:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9398AA0845; Mon, 30 Sep 2024 16:18:19 +0200 (CEST)
Date: Mon, 30 Sep 2024 16:18:19 +0200
From: Jan Kara <jack@suse.cz>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
	LKML <linux-kernel@vger.kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] erofs: add file-backed mount support
Message-ID: <20240930141819.tabcwa3nk5v2mkwu@quack3>
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
 <CAMuHMdVqa2Mjqtqv0q=uuhBY1EfTaa+X6WkG7E2tEnKXJbTkNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdVqa2Mjqtqv0q=uuhBY1EfTaa+X6WkG7E2tEnKXJbTkNg@mail.gmail.com>
X-Rspamd-Queue-Id: E5DC21FBAC
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
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi!

On Tue 24-09-24 11:21:59, Geert Uytterhoeven wrote:
> On Fri, Aug 30, 2024 at 5:29 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> > It actually has been around for years: For containers and other sandbox
> > use cases, there will be thousands (and even more) of authenticated
> > (sub)images running on the same host, unlike OS images.
> >
> > Of course, all scenarios can use the same EROFS on-disk format, but
> > bdev-backed mounts just work well for OS images since golden data is
> > dumped into real block devices.  However, it's somewhat hard for
> > container runtimes to manage and isolate so many unnecessary virtual
> > block devices safely and efficiently [1]: they just look like a burden
> > to orchestrators and file-backed mounts are preferred indeed.  There
> > were already enough attempts such as Incremental FS, the original
> > ComposeFS and PuzzleFS acting in the same way for immutable fses.  As
> > for current EROFS users, ComposeFS, containerd and Android APEXs will
> > be directly benefited from it.
> >
> > On the other hand, previous experimental feature "erofs over fscache"
> > was once also intended to provide a similar solution (inspired by
> > Incremental FS discussion [2]), but the following facts show file-backed
> > mounts will be a better approach:
> >  - Fscache infrastructure has recently been moved into new Netfslib
> >    which is an unexpected dependency to EROFS really, although it
> >    originally claims "it could be used for caching other things such as
> >    ISO9660 filesystems too." [3]
> >
> >  - It takes an unexpectedly long time to upstream Fscache/Cachefiles
> >    enhancements.  For example, the failover feature took more than
> >    one year, and the deamonless feature is still far behind now;
> >
> >  - Ongoing HSM "fanotify pre-content hooks" [4] together with this will
> >    perfectly supersede "erofs over fscache" in a simpler way since
> >    developers (mainly containerd folks) could leverage their existing
> >    caching mechanism entirely in userspace instead of strictly following
> >    the predefined in-kernel caching tree hierarchy.
> >
> > After "fanotify pre-content hooks" lands upstream to provide the same
> > functionality, "erofs over fscache" will be removed then (as an EROFS
> > internal improvement and EROFS will not have to bother with on-demand
> > fetching and/or caching improvements anymore.)
> >
> > [1] https://github.com/containers/storage/pull/2039
> > [2] https://lore.kernel.org/r/CAOQ4uxjbVxnubaPjVaGYiSwoGDTdpWbB=w_AeM6YM=zVixsUfQ@mail.gmail.com
> > [3] https://docs.kernel.org/filesystems/caching/fscache.html
> > [4] https://lore.kernel.org/r/cover.1723670362.git.josef@toxicpanda.com
> >
> > Closes: https://github.com/containers/composefs/issues/144
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Thanks for your patch, which is now commit fb176750266a3d7f
> ("erofs: add file-backed mount support").
> 
> > ---
> > v2:
> >  - should use kill_anon_super();
> >  - add O_LARGEFILE to support large files.
> >
> >  fs/erofs/Kconfig    | 17 ++++++++++
> >  fs/erofs/data.c     | 35 ++++++++++++---------
> >  fs/erofs/inode.c    |  5 ++-
> >  fs/erofs/internal.h | 11 +++++--
> >  fs/erofs/super.c    | 76 +++++++++++++++++++++++++++++----------------
> >  5 files changed, 100 insertions(+), 44 deletions(-)
> >
> > diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
> > index 7dcdce660cac..1428d0530e1c 100644
> > --- a/fs/erofs/Kconfig
> > +++ b/fs/erofs/Kconfig
> > @@ -74,6 +74,23 @@ config EROFS_FS_SECURITY
> >
> >           If you are not using a security module, say N.
> >
> > +config EROFS_FS_BACKED_BY_FILE
> > +       bool "File-backed EROFS filesystem support"
> > +       depends on EROFS_FS
> > +       default y
> 
> I am a bit reluctant to have this default to y, without an ack from
> the VFS maintainers.

Well, we generally let filesystems do whatever they decide to do unless it
is a affecting stability / security / maintainability of the whole system.
In this case I don't see anything that would be substantially different
than if we go through a loop device. So although the feature looks somewhat
unusual I don't see a reason to nack it or otherwise interfere with
whatever the fs maintainer wants to do. Are you concerned about a
particular problem?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

