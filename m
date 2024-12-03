Return-Path: <linux-fsdevel+bounces-36368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D569C9E2894
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 18:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AE85B831C6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 16:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4FF1F8AE6;
	Tue,  3 Dec 2024 16:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yFRTUmL8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="V3E5Ks4X";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yFRTUmL8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="V3E5Ks4X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DB62BD1D
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Dec 2024 16:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733244128; cv=none; b=gRAzEIH12YKM1XGCUCCpOGFcgWGaby2PoGMyMTRvfV8epleXv88pjS9DXGOPsz9CaGWvFX4So+JBDWXzjH4TaXKFexaW3v/ZylksL9OazR6LMkA/zl+1/d7XW+yQjlX8G+EdQKRI27ZGltfSxV8W9lrjVv2X0n4AH+NT555QMGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733244128; c=relaxed/simple;
	bh=VKhqfWbw7lZY62m8nZ/HZPzAt0pTHMbldEq13Oco5qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7CoXEUcGlDEBJDs5YZu/33xXY5Zc+KbdSlHHpdXii0UaYsDgdzSXfKYA2gOpsQB7ZuU1ZZ03QrsozDs5WkNgfibml6vrFuBm6K+20wJTxVjdeHwg5u20s9yu4km/B7xqSEAmNZvc5NNLg8F7wEDeyqE0J89DG0+whWR9NOS8zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yFRTUmL8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=V3E5Ks4X; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yFRTUmL8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=V3E5Ks4X; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1530C21119;
	Tue,  3 Dec 2024 16:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733244125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iEieebZ3Li6BEjcsDNktj7Z+m2y3mxtuPYupMnb1MhA=;
	b=yFRTUmL8VZsFeoLch2XkUqAOMfoA42F7nz5tSlDImO6NvtzgBAkRPO9zHBxPx9wdDlzC4n
	pA3Xpgiv83Zn/DpdaHyWbKLK65+UUWvYqA0u4b5G6ZVmaHh8YfWokrelbVB5E9L94z0NFJ
	VSdyuGBT58xcvjD9px3sGLhpb1pObNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733244125;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iEieebZ3Li6BEjcsDNktj7Z+m2y3mxtuPYupMnb1MhA=;
	b=V3E5Ks4XvZwYwDiBpSxtPLkLnALVNWmwdhkMbNeZzbLJjbLhDUJug1TVswEmm8jCxSIa92
	1GtmpP7HHhEN/wAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yFRTUmL8;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=V3E5Ks4X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733244125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iEieebZ3Li6BEjcsDNktj7Z+m2y3mxtuPYupMnb1MhA=;
	b=yFRTUmL8VZsFeoLch2XkUqAOMfoA42F7nz5tSlDImO6NvtzgBAkRPO9zHBxPx9wdDlzC4n
	pA3Xpgiv83Zn/DpdaHyWbKLK65+UUWvYqA0u4b5G6ZVmaHh8YfWokrelbVB5E9L94z0NFJ
	VSdyuGBT58xcvjD9px3sGLhpb1pObNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733244125;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iEieebZ3Li6BEjcsDNktj7Z+m2y3mxtuPYupMnb1MhA=;
	b=V3E5Ks4XvZwYwDiBpSxtPLkLnALVNWmwdhkMbNeZzbLJjbLhDUJug1TVswEmm8jCxSIa92
	1GtmpP7HHhEN/wAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0652E139C2;
	Tue,  3 Dec 2024 16:42:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A5BEAd00T2cRYAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Dec 2024 16:42:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9B736A08FB; Tue,  3 Dec 2024 17:42:04 +0100 (CET)
Date: Tue, 3 Dec 2024 17:42:04 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Karel Zak <kzak@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>,
	linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Lennart Poettering <lennart@poettering.net>,
	Ian Kent <raven@themaw.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC PATCH] fanotify: notify on mount attach and detach
Message-ID: <20241203164204.nfscpnxbfwvfpmts@quack3>
References: <20241128144002.42121-1-mszeredi@redhat.com>
 <dqeiphslkdqyxevprnv7rb6l5baj32euh3v3drdq4db56cpgu3@oalgjntkdgol>
 <CAOQ4uxh0QevMgHur1MOOL2uXjivGEneyW2UfD+QOWj1Ozz5B1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxh0QevMgHur1MOOL2uXjivGEneyW2UfD+QOWj1Ozz5B1g@mail.gmail.com>
X-Rspamd-Queue-Id: 1530C21119
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
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 03-12-24 14:03:24, Amir Goldstein wrote:
> On Tue, Dec 3, 2024 at 12:40 PM Karel Zak <kzak@redhat.com> wrote:
> > Thank you for working on this.
> >
> > On Thu, Nov 28, 2024 at 03:39:59PM GMT, Miklos Szeredi wrote:
> > > To monitor an entire mount namespace with this new interface, watches need
> > > to be added to all existing mounts.  This can be done by performing
> > > listmount()/statmount() recursively at startup and when a new mount is
> > > added.
> >
> > It seems that maintaining a complete tree of nodes on large systems
> > with thousands of mountpoints is quite costly for userspace. It also
> > appears to be fragile, as any missed new node (due to a race or other
> > reason) would result in the loss of the ability to monitor that part
> > of the hierarchy. Let's imagine that there are new mount nodes added
> > between the listmount() and fanotify_mark() calls. These nodes
> > will be invisible.
> 
> That should not happen if the monitor does:
> 1. set fanotify_mark() on parent mount to get notified on new child mounts
> 2. listmount() on parent mount to list existing children mounts

Right, that works in principle. But it will have all those headaches as
trying to do recursive subtree watching with inotify directory watches
(mounts can also be moved, added, removed, etc. while we are trying to
capture them). It is possible to do but properly handling all the possible
races was challenging to say the least. That's why I have my doubts whether
this is really the interface we want to offer to userspace...

> > It would be beneficial to have a "recursive" flag that would allow for
> > opening only one mount node and receiving notifications for the entire
> > hierarchy. (I have no knowledge about fanotify, so it is possible that
> > this may not be feasible due to the internal design of fanotify.)
> 
> This can be challenging, but if it is acceptable to hold the namespace
> mutex while setting all the marks (?) then maybe.

So for mounts, given the relative rarity of mount / umount events and depth
of a mount tree (compared to the situation with ordinary inodes and
standard fanotify events), I think it might be even acceptable to walk up
the mount tree and notify everybody along that path.

> What should be possible is to set a mark on the mount namespace
> to get all the mount attach/detach events in the mount namespace
> and let userspace filter out the events that are not relevant to the
> subtree of interest.

Or this.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

