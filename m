Return-Path: <linux-fsdevel+bounces-45979-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F21A8043E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 14:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBECD7A8CEA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 12:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78A326AA8F;
	Tue,  8 Apr 2025 12:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nqButSfg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0PMLuMo0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nqButSfg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0PMLuMo0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2DC2690EC
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Apr 2025 12:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744113901; cv=none; b=KwZbIX5VH2wWfH49N2zB5aw1uZHQqlwaQe59pHujc427GKJFSZtZQo6J9Yt2lm0wVijBaZ/F3khi4Ta33LwKDAOkcEFOMkf/u8W7pizmCk+IfyEBN1fGqDB61l1esKrCW6mBU/9s2ewRUiU6LQF7o9NlZ+o3I5r0cONlyEoembw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744113901; c=relaxed/simple;
	bh=Tnobg0PIummJt3dHeOxpkdDmh0yA7puuUHX8uslkzt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrbmjwPsNdUXDDX0oT1k/DBiVbkuXsUouaWph5nCJD3hV2zpz/tYIOyu0CrztDUfLcGA5rmGEtuArucs3Au1bnDkYAQcBalbHKtoFjlKTJlNcVCu+5/1uQd1hO7uXwwAoZlR47iVEXts7PN0DG9nSrbX2vgTJZU8/Y3b7zltV8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nqButSfg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0PMLuMo0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nqButSfg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0PMLuMo0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E4DE321185;
	Tue,  8 Apr 2025 12:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744113896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3nmX2QzAOhysdioEeWUc+9P14ljzQl1odFx/3u4yCxo=;
	b=nqButSfgwadwmDVb9dHugKAqWeny2mlZxb2PdnD3dfozkaJ0PluM8It0eeTN7QslDlfHZV
	UPk5zp14O4l3EZLvOvkYb304TCCqLeU/K+zv2rdoWeLtYoE/NHHDK8CNX8Hge89icxfbq4
	dRhf4PLC2xPpV0Jp+VYlFhdOjkJfkg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744113896;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3nmX2QzAOhysdioEeWUc+9P14ljzQl1odFx/3u4yCxo=;
	b=0PMLuMo0JZj44gLMD9TOYHx5fwZoPbOJ3NZBrZBNgpuHjipRqKL5nuEWBOYIXJNGnUuNG4
	ppGwarzNoNmlAyAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744113896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3nmX2QzAOhysdioEeWUc+9P14ljzQl1odFx/3u4yCxo=;
	b=nqButSfgwadwmDVb9dHugKAqWeny2mlZxb2PdnD3dfozkaJ0PluM8It0eeTN7QslDlfHZV
	UPk5zp14O4l3EZLvOvkYb304TCCqLeU/K+zv2rdoWeLtYoE/NHHDK8CNX8Hge89icxfbq4
	dRhf4PLC2xPpV0Jp+VYlFhdOjkJfkg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744113896;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3nmX2QzAOhysdioEeWUc+9P14ljzQl1odFx/3u4yCxo=;
	b=0PMLuMo0JZj44gLMD9TOYHx5fwZoPbOJ3NZBrZBNgpuHjipRqKL5nuEWBOYIXJNGnUuNG4
	ppGwarzNoNmlAyAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C7E7613A1E;
	Tue,  8 Apr 2025 12:04:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ML+EMOgQ9Wc0FwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 08 Apr 2025 12:04:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 75092A0968; Tue,  8 Apr 2025 14:04:48 +0200 (CEST)
Date: Tue, 8 Apr 2025 14:04:48 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	mkoutny@suse.cz
Subject: Re: d_path() results in presence of detached mounts
Message-ID: <7tqv43wtdldjtlbizfhzjmwuoo6fo2xg537jpoxamkvjmckhbv@wiprprojwih2>
References: <rxytpo37ld46vclkts457zvwi6qkgwzlh3loavn3lddqxe2cvk@k7lifplt7ay6>
 <20250408-ungebeten-auskommen-5a2aaab8e23d@brauner>
 <20250408-nachverfolgen-deftig-19199bfc1801@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408-nachverfolgen-deftig-19199bfc1801@brauner>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Tue 08-04-25 13:39:28, Christian Brauner wrote:
> On Tue, Apr 08, 2025 at 10:55:07AM +0200, Christian Brauner wrote:
> > On Mon, Apr 07, 2025 at 06:00:07PM +0200, Jan Kara wrote:
> > > Hello!
> > > 
> > > Recently I've got a question from a user about the following:
> > > 
> > > # unshare --mount swapon /dev/sda3
> > > # cat /proc/swaps
> > > Filename                                Type            Size            Used            Priority
> > > /sda3                                   partition       2098152         0               -2
> > > 
> > > Now everything works as expected here AFAICS. When namespace gets created
> > > /dev mount is cloned into it. When swapon exits, the namespace is
> > > destroyed and /dev mount clone is detached (no parent, namespace NULL).
> 
> That's not the issue you're seeing here though
> 
> > > Hence when d_path() crawls the path it stops at the mountpoint root and
> > > exits. There's not much we can do about this but when discussing the
> > > situation internally, Michal proposed that d_path() could append something
> > > like "(detached)" to the path string - similarly to "(deleted)". That could
> > > somewhat reduce the confusion about such paths? What do people think about
> > > this?
> > 
> > You can get into this situation in plenty of other ways. For example by
> > using detached mount via open_tree(OPEN_TREE_CLONE) as layers in
> > overlayfs. Or simply:
> > 
> >         int fd;
> >         char dpath[PATH_MAX];
> > 
> >         fd = open_tree(-EBADF, "/var/lib/fwupd", OPEN_TREE_CLONE);
> >         dup2(fd, 500);
> >         close(fd);
> >         readlink("/proc/self/fd/500", dpath, sizeof(dpath));
> >         printf("dpath = %s\n", dpath);
> > 
> > Showing "(detached)" will be ambiguous just like "(deleted)" is. If that
> > doesn't matter and it's clearly documented then it's probably fine. But
> > note that this will also affect /proc/<pid>/fd/ as can be seen from the
> > above example.
> 
> The other downside is that it will still be quite opaque because the
> user will have to be aware of the concept of a detached mount. So it's
> mostly useful for administrators tbh.

Thanks for the insights!

> In general, I think it needs to be made clear to userspace that paths
> shown in such tables are open()-able in the best case and decorative or
> even misleading in the worst case.

Yes, I know this and I was just wondering if we can at least somehow
visibly indicate the path shown is likely unusable. If you think it would
do more harm than good, I'm fine with that answer, I just thought I'll
ask...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

