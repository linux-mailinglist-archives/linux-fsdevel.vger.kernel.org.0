Return-Path: <linux-fsdevel+bounces-51119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A106BAD2F6E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 10:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A8BA1893F3C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 08:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E66280036;
	Tue, 10 Jun 2025 08:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gJ4/O1u7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5uc1NKUo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gJ4/O1u7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5uc1NKUo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE07121B9FF
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 08:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749542571; cv=none; b=VKePp8vg91drddVrLI2IsMOYdSAEB/I7ZW6IYePvK4VkuQtooneWpzwcuD9wz3PBHXBxWroJeiTE33F7S+QwwhOP3A8F/jjl7TtMDS+j8pi0FaN/SWr6r9fdcB6OALzmq89sQcD2ifC3KIqNp8Vs/xDROnyfGrUg8676VLHGDfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749542571; c=relaxed/simple;
	bh=rOXychcPq/CNnpkEI3k0q1KTfTevbC7m+s2fmhLNbGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OiXOEG2lxE40+wmqR2B44yGcwQiCJqKkDef7BGbx7yxsJef41lRuihsUi46KtscOigxurJ+x/qzHk3AqZrjABxeVXG7hyaiWbHIRaP9MmKHuuiABTdwIb7nwcHYUMf/6wDu/02W5utlbK3wzS6e7FwrZSt0Q+2XJhm0+KFEAFGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gJ4/O1u7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5uc1NKUo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gJ4/O1u7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5uc1NKUo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 142A71F38F;
	Tue, 10 Jun 2025 08:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749542567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o6YgtNsqJ6iSWpN+TUORrgg0GAgVl234AaHqoSyV6NE=;
	b=gJ4/O1u7mkTgjX2UqNEEcK9mfChCsjY0rEdy0QTPYPYhHaCvhUMH+8NpQNsfaR5bq3rsF7
	nsTDHWfz2K+GQILgkoj3kKzvGT45D+ye8U4/qOAgpJxWeR4bh28Lj/zP0TO4bUEYygfICg
	X0RAs448dtL9pxBzN5nbkWPVMxSuhf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749542567;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o6YgtNsqJ6iSWpN+TUORrgg0GAgVl234AaHqoSyV6NE=;
	b=5uc1NKUoUybLuXP0rDY9SSwR5idRbOtrCzVuefqb4/Il0OyffvJruVMDStMCqF0zjRFv2m
	2eaWczgn4Ta8p3AQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="gJ4/O1u7";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5uc1NKUo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749542567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o6YgtNsqJ6iSWpN+TUORrgg0GAgVl234AaHqoSyV6NE=;
	b=gJ4/O1u7mkTgjX2UqNEEcK9mfChCsjY0rEdy0QTPYPYhHaCvhUMH+8NpQNsfaR5bq3rsF7
	nsTDHWfz2K+GQILgkoj3kKzvGT45D+ye8U4/qOAgpJxWeR4bh28Lj/zP0TO4bUEYygfICg
	X0RAs448dtL9pxBzN5nbkWPVMxSuhf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749542567;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o6YgtNsqJ6iSWpN+TUORrgg0GAgVl234AaHqoSyV6NE=;
	b=5uc1NKUoUybLuXP0rDY9SSwR5idRbOtrCzVuefqb4/Il0OyffvJruVMDStMCqF0zjRFv2m
	2eaWczgn4Ta8p3AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0823A139E2;
	Tue, 10 Jun 2025 08:02:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8Y20AafmR2haDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 10 Jun 2025 08:02:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AFCEFA099E; Tue, 10 Jun 2025 10:02:42 +0200 (CEST)
Date: Tue, 10 Jun 2025 10:02:42 +0200
From: Jan Kara <jack@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Xianying Wang <wangxianying546@gmail.com>, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] WARNING in bdev_getblk
Message-ID: <vwsalkqqm3gaxy5olc7nuolwrv62igdvi6s3hlp2sj2euizlzk@xdkfk6s3br22>
References: <CAOU40uAjmLO9f0LOGqPdVd5wpiFK6QaT+UwiNvRoBXhVnKcDbw@mail.gmail.com>
 <x3govm5j2nweio5k3r4imvg6cyg3onadln4tvj7bh4gmleuzqn@zmnbnjfqawfo>
 <aEdIsaZIcR_co42X@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEdIsaZIcR_co42X@casper.infradead.org>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,zeniv.linux.org.uk,kernel.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 142A71F38F
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.01

On Mon 09-06-25 21:48:49, Matthew Wilcox wrote:
> On Mon, Jun 09, 2025 at 03:54:01PM +0200, Jan Kara wrote:
> > Hi!
> > 
> > On Mon 09-06-25 16:39:15, Xianying Wang wrote:
> > > I encountered a kernel WARNING in the function bdev_getblk() when
> > > fuzzing the Linux 6.12 kernel using Syzkaller. The crash occurs during
> > > a block buffer allocation path, where __alloc_pages_noprof() fails
> > > under memory pressure, and triggers a WARNING due to an internal
> > > allocation failure.
> > 
> > Ah, this is a warning about GFP_NOFAIL allocation from direct reclaim:
> 
> It's the same discussion we had at LSFMM.  It seems like we have a lot
> of "modified syzkaller" people trying this kind of thing.

Well, yes, it's from modified syzkaller and I'm not going to run the
reproducer but in this case it's clear just from the stacktrace what the
problem is and it looks like a valid (although relatively minor) issue.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

