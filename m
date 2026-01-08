Return-Path: <linux-fsdevel+bounces-72816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90852D03C82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 16:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66674305E330
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1663A7F71;
	Thu,  8 Jan 2026 10:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L9PphSHv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EkjRTIoK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L9PphSHv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EkjRTIoK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032653A1D05
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jan 2026 10:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767868616; cv=none; b=pncFodRUBM3VYguTzAs9UtTWio/TeodhxkKg20VUXnLAYJwCW/eluMrE4TiwxwoYqIsBShZO4nLfxec9cgqfKJQWmG+DBTZ6lX4TTv1k9inNNXIdoWu8aEKq0U3l4WhgUSX7aJc4HmjVez0w3G/zWsmcq7gUzKfHmVDN796BU7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767868616; c=relaxed/simple;
	bh=KcWwCS3VcWLJt+3EH0EsfM1JUiU9zCLrjaxsjrQEEe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LeQIFs8FC/wxqyA7hx1TAo44JsedHGJ60YadZeuSqhzC72vU156FDA0CQFoYGpgtw1Tx6VAvvMALk5S3Z5S/M8lMTplATEE9mxtc5GQK18SYVbPK9L1HYC4/8wiW4VdW2Ic78z6Dkw+f/QU2Fu3ZRQRoQUSXM2/UHRT4B47ZAks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L9PphSHv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EkjRTIoK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L9PphSHv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EkjRTIoK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4EAFA33CE2;
	Thu,  8 Jan 2026 10:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767868603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y7zhMg4dN+hDANKOVxoNd5LSGROZDwb68O8xAw3Tm4E=;
	b=L9PphSHvE5aR8dH4x2yDWKzbzE7wgHTIPEJc1LruiiFeoKxe0rptToVkFsCWOKf0+iXdEN
	BthFIq3+XrP+9YJvLraGvQZZ0YkbXpq/Wy86oN7Xn6hcghaaGXUsDuvybdBQneXBST1EjH
	KbXkbXiZdrU+WKtZGpBN6oFPEZLh5bo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767868603;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y7zhMg4dN+hDANKOVxoNd5LSGROZDwb68O8xAw3Tm4E=;
	b=EkjRTIoKt0pWVfhd22UD0qU7RDnjIEAUPdxkd5yjon7tdL6zZE2EbkeRZHDxuClMhzgOER
	dfJvWLCKhLKlqSAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=L9PphSHv;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EkjRTIoK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767868603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y7zhMg4dN+hDANKOVxoNd5LSGROZDwb68O8xAw3Tm4E=;
	b=L9PphSHvE5aR8dH4x2yDWKzbzE7wgHTIPEJc1LruiiFeoKxe0rptToVkFsCWOKf0+iXdEN
	BthFIq3+XrP+9YJvLraGvQZZ0YkbXpq/Wy86oN7Xn6hcghaaGXUsDuvybdBQneXBST1EjH
	KbXkbXiZdrU+WKtZGpBN6oFPEZLh5bo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767868603;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y7zhMg4dN+hDANKOVxoNd5LSGROZDwb68O8xAw3Tm4E=;
	b=EkjRTIoKt0pWVfhd22UD0qU7RDnjIEAUPdxkd5yjon7tdL6zZE2EbkeRZHDxuClMhzgOER
	dfJvWLCKhLKlqSAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 353253EA63;
	Thu,  8 Jan 2026 10:36:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Erf3DLuIX2niXgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 08 Jan 2026 10:36:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EB010A0CF3; Thu,  8 Jan 2026 11:36:34 +0100 (CET)
Date: Thu, 8 Jan 2026 11:36:34 +0100
From: Jan Kara <jack@suse.cz>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Jan Kara <jack@suse.cz>, akpm@linux-foundation.org, david@redhat.com, 
	miklos@szeredi.hu, linux-mm@kvack.org, athul.krishna.kr@protonmail.com, 
	j.neuschaefer@gmx.net, carnil@debian.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/1] fs/writeback: skip AS_NO_DATA_INTEGRITY mappings
 in wait_sb_inodes()
Message-ID: <fhwhqvzs6rmn5zbazbbtcdr73tokykwy63lrorv4q5azbdg4hz@czkgoperhk4x>
References: <20251215030043.1431306-1-joannelkoong@gmail.com>
 <20251215030043.1431306-2-joannelkoong@gmail.com>
 <ypyumqgv5p7dnxmq34q33keb6kzqnp66r33gtbm4pglgdmhma6@3oleltql2qgp>
 <CAJnrk1aYpcDpm8MpN5Emb8qNOn34-qEiARLH0RudySKFtEZVpA@mail.gmail.com>
 <ucnvcqbmxsiszobzzkjrgekle2nabf3w5omnfbitmotgujas4e@4f5ct4ot4mup>
 <CAJnrk1b-77uK2JuQaHz8KUCBnZfnQZ6M_nQQqFNWLvPDDdy4+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1b-77uK2JuQaHz8KUCBnZfnQZ6M_nQQqFNWLvPDDdy4+Q@mail.gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.net,protonmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,linux-foundation.org,redhat.com,szeredi.hu,kvack.org,protonmail.com,gmx.net,debian.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 4EAFA33CE2
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Wed 07-01-26 15:20:48, Joanne Koong wrote:
> On Wed, Jan 7, 2026 at 2:12 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 06-01-26 15:30:05, Joanne Koong wrote:
> > > On Tue, Jan 6, 2026 at 1:34 AM Jan Kara <jack@suse.cz> wrote:
> > > > [Thanks to Andrew for CCing me on patch commit]
> > >
> > > Sorry, I didn't mean to exclude you. I hadn't realized the
> > > fs-writeback.c file had maintainers/reviewers listed for it. I'll make
> > > sure to cc you next time.
> >
> > No problem, I don't think it's formally spelled out anywhere. It's just
> > that for changes in fs/*.c people tend to CC VFS maintainers / reviewers.
> >
> > Thanks for the historical perspective, it does put some more peace into my
> > mind that things were considered :)
> >
> > > For the fsync() and truncate() examples you mentioned, I don't think
> > > it's an issue that these now wait for the server to finish the I/O and
> > > hang if the server doesn't. I think it's actually more correct
> > > behavior than what we had with temp pages, eg imo these actually ought
> > > to wait for the writeback to have been completed by the server. If the
> > > server is malicious / buggy and fsync/truncate hangs, I think that's
> > > fine given that fsync/truncate is initiated by the user on a specific
> > > file descriptor (as opposed to the generic sync()) (and imo it should
> > > hang if it can't actually be executed correctly because the server is
> > > malfunctioning).
> >
> > Here, I have a comment. The hang in truncate is not as innocent as you
> > might think. It will happen in truncate_inode_pages() and as such it will
> > also end up hanging inode reclaim. Thus kswapd (or other arbitrary process
> > entering direct reclaim) may hang in inode reclaim waiting for
> > truncate_inode_pages() to finish. And at that point you are between a rock
> > and a hard place - truncate_inode_pages() cannot fail because the inode is
> > at the point of no return. You cannot just detach the folio under writeback
> > from the mapping because if the writeback ever completes, the IO end
> > handlers will get seriously confused - at least in the generic case, maybe
> > specifically for FUSE there would be some solution possible - like a
> > special handler in fuse_evict_inode() walking all the pages under writeback
> > and tearing them down in a clean way (properly synchronizing with IO
> > completion) before truncate_inode_pages() is called.
> 
> Hmm... I looked into this path a bit when I was investigating a
> deadlock that was unrelated to this. The ->evict_inode() callback gets
> invoked only if the ref count on an inode has dropped to zero. In
> fuse, in the .release() callback (fuse_release()), if writeback
> caching is enabled, write_inode_now() is called on the inode with
> sync=1 (WB_SYNC_ALL). This does synchronous writeback and returns (and
> drops the inode ref) only after all the dirty pages have been written
> out. When ->evict_inode() -> fuse_evict_inode() is called, I don't
> think there can be any lingering dirty pages to write out in
> trunate_inode_pages().

Right, that addresses my concern. Inode reclaim on FUSE shouldn't be able
to see dirty / writeback pages. Thanks for explanation!

							Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

