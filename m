Return-Path: <linux-fsdevel+bounces-19378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E8F8C424C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 15:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C5B61F21390
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 13:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F6015532F;
	Mon, 13 May 2024 13:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gCM+EfKK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mdyZ2uNi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gCM+EfKK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mdyZ2uNi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9380C154429;
	Mon, 13 May 2024 13:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607701; cv=none; b=Zoca9JhV8Zp/sAl1PD+I3yjFx5vnWKnLd45CjTO7c3vmTxwoV8D3zpxdqNPhbrRuGwPMwckzOCZSacdTrChbzbAfxiQG/qaJ2QojChKHsKdb7GBhIVD9IJh+1E5U6GoDkOhv90SQ7P9j5ShpsD/feh23K36prwzgBFXc4JsQq/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607701; c=relaxed/simple;
	bh=1vwhNLWQzWOw14LAEZi7EsnlB5e8SqSlplib0RuK460=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTzYvKtbDitg79oEKxgTPT+uoWZRmw3oWhwZZUnL95gj3fl12u+u7/oJzduCRcBR14RAtXi9oBXwx5ccSaeTE6ulOMQ1JVEKEHpZG5RUa0aeAQ+AJB4Dnj/wP5E0uL3QnB9bnH+rYe/KRdWUsnBC18m/F7BflByjuyN2tovrVbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gCM+EfKK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mdyZ2uNi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gCM+EfKK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mdyZ2uNi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 740D55C0E0;
	Mon, 13 May 2024 13:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715607697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tsajR3jWLhoXAo1Db8WJHsrCg5uk4EqrkI1RB3AkQjQ=;
	b=gCM+EfKK1yd1U9Cibs0FoEYv8srOq28jiH6hSJ+QuuxUWBv9xgN13a6UByPu8WW8TLQjwU
	sxhU7iki+aUAOqbjOomb+RMN2+gqNPdy6pzSGaboLushNkZXD9IPjVCVaC1IhIpd3KuAA4
	Jxn73PG5O5eXCf3O6mwDQGtRCMQN+mg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715607697;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tsajR3jWLhoXAo1Db8WJHsrCg5uk4EqrkI1RB3AkQjQ=;
	b=mdyZ2uNizmupVu8YQ6oQcqJdPVFtl1TN7WgfM4J7HlLXOvR47fENoOylA20z6vyY6hmNmQ
	82XyVNcmcopduFCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gCM+EfKK;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mdyZ2uNi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715607697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tsajR3jWLhoXAo1Db8WJHsrCg5uk4EqrkI1RB3AkQjQ=;
	b=gCM+EfKK1yd1U9Cibs0FoEYv8srOq28jiH6hSJ+QuuxUWBv9xgN13a6UByPu8WW8TLQjwU
	sxhU7iki+aUAOqbjOomb+RMN2+gqNPdy6pzSGaboLushNkZXD9IPjVCVaC1IhIpd3KuAA4
	Jxn73PG5O5eXCf3O6mwDQGtRCMQN+mg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715607697;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tsajR3jWLhoXAo1Db8WJHsrCg5uk4EqrkI1RB3AkQjQ=;
	b=mdyZ2uNizmupVu8YQ6oQcqJdPVFtl1TN7WgfM4J7HlLXOvR47fENoOylA20z6vyY6hmNmQ
	82XyVNcmcopduFCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44F0E13A69;
	Mon, 13 May 2024 13:41:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iJXPEJEYQmabDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 13 May 2024 13:41:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2ACB1A089F; Sun, 12 May 2024 10:05:11 +0200 (CEST)
Date: Sun, 12 May 2024 10:05:11 +0200
From: Jan Kara <jack@suse.cz>
To: Justin Stitt <justinstitt@google.com>
Cc: Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] fs: remove accidental overflow during wraparound check
Message-ID: <20240512080511.yotlypw35qowwjoh@quack3>
References: <20240507-b4-sio-vfs_fallocate-v1-1-322f84b97ad5@google.com>
 <20240509155356.w274h4blmcykxej6@quack3>
 <CAFhGd8opxHhTdZhDg_hq7XWQFxJ34nLDxTd-nBBgye9BLohnqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhGd8opxHhTdZhDg_hq7XWQFxJ34nLDxTd-nBBgye9BLohnqw@mail.gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DATE_IN_PAST(1.00)[29];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 740D55C0E0
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.01

On Thu 09-05-24 15:10:07, Justin Stitt wrote:
> On Thu, May 9, 2024 at 8:53 AM Jan Kara <jack@suse.cz> wrote:
> > > @@ -319,8 +320,12 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
> > >       if (!S_ISREG(inode->i_mode) && !S_ISBLK(inode->i_mode))
> > >               return -ENODEV;
> > >
> > > -     /* Check for wrap through zero too */
> > > -     if (((offset + len) > inode->i_sb->s_maxbytes) || ((offset + len) < 0))
> > > +     /* Check for wraparound */
> > > +     if (check_add_overflow(offset, len, &sum))
> > > +             return -EFBIG;
> > > +
> > > +     /* Now, check bounds */
> > > +     if (sum > inode->i_sb->s_maxbytes || sum < 0)
> > >               return -EFBIG;
> >
> > But why do you check for sum < 0? We know from previous checks offset >= 0
> > && len > 0 so unless we overflow, sum is guaranteed to be > 0.
> 
> Fair enough. I suppose with the overflow check in place we can no
> longer have a sum less than zero there. If nothing else, it tells
> readers of this code what the domain of (offset+len) is. I don't mind
> sending a new version, though.

Well, for normal readers offset+len is always a positive number. That's
what you expect. If you see a check for offset+len < 0, you start wondering
what are you missing... only to find you miss nothing and the check is
pointless. So yes, please send a version without the pointless check.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

