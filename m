Return-Path: <linux-fsdevel+bounces-53500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F1CAEF93E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 14:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0D21C04D81
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 12:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31270274FCB;
	Tue,  1 Jul 2025 12:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y/9X8GnL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dRFMJVjF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y/9X8GnL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dRFMJVjF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929B2274B4A
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jul 2025 12:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751374320; cv=none; b=uAVwOIfIicbhB1oQiQ/pO3bw7WonKjtZG2tyJI9m19H5w2lEr4C5qT0GTcSZZBjZFkEjEPhVrAatM+gXvltiwRH0VAhIgp+MZ0aC8P8pRkk218hTQ/LeYgcvsvSE4zEFWTTDud2qJW1+sVH87x8uo+HOVjhwKShVfg193qBj1NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751374320; c=relaxed/simple;
	bh=80jibo9YFU9Xh9ajvLwdjd8CZM7fqnjDNbr4s/LZXeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f696XvTzuIWZqT06LtzdDClb+qfnfKPNNxxeksXpM5cAZZUqrUhZwMMw52cjR1RWzLWhPXD0KuIR05GUFNA5y2flnCUbQhIvcRY0janb4yDA+oohQ3x6YGkUEUSmrSfihnlkT2KhP1Nho5xFy7u47bYNuI7ds7hXDNQ3Pzmj9ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y/9X8GnL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dRFMJVjF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y/9X8GnL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dRFMJVjF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9E138210F9;
	Tue,  1 Jul 2025 12:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751374316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TRq0octuxf2aaKKW3YUWVaP4X18zIUGJ/muDzG99C4E=;
	b=Y/9X8GnLA3U+Ar6ub3L7M3nTC1LXsD+5EW0KZDlGlaiHJ5gNFTz9ICGf7JPdatJV+af6lQ
	0idbEEoq9CKqX+xkJ2c5aPAXaKxF6QcwvnoscLjmp6W5epRcW9zI/EXDFSZ80wiRCKTxoI
	8MbegElc26gDUEFBgz6SF1BagawLoH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751374316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TRq0octuxf2aaKKW3YUWVaP4X18zIUGJ/muDzG99C4E=;
	b=dRFMJVjFmeey2zXn8cHYGfKbjtupEF1VIVRyk0KM31JxE0bbjDghmf9XA/oTzENsE9xMT0
	Z3DRpegG4I6tpBAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Y/9X8GnL";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dRFMJVjF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751374316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TRq0octuxf2aaKKW3YUWVaP4X18zIUGJ/muDzG99C4E=;
	b=Y/9X8GnLA3U+Ar6ub3L7M3nTC1LXsD+5EW0KZDlGlaiHJ5gNFTz9ICGf7JPdatJV+af6lQ
	0idbEEoq9CKqX+xkJ2c5aPAXaKxF6QcwvnoscLjmp6W5epRcW9zI/EXDFSZ80wiRCKTxoI
	8MbegElc26gDUEFBgz6SF1BagawLoH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751374316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TRq0octuxf2aaKKW3YUWVaP4X18zIUGJ/muDzG99C4E=;
	b=dRFMJVjFmeey2zXn8cHYGfKbjtupEF1VIVRyk0KM31JxE0bbjDghmf9XA/oTzENsE9xMT0
	Z3DRpegG4I6tpBAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6529313890;
	Tue,  1 Jul 2025 12:51:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Fju6GOzZY2hHcAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 01 Jul 2025 12:51:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CAFA7A0A23; Tue,  1 Jul 2025 14:51:51 +0200 (CEST)
Date: Tue, 1 Jul 2025 14:51:51 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, 
	Arnd Bergmann <arnd@arndb.de>, Casey Schaufler <casey@schaufler-ca.com>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Paul Moore <paul@paul-moore.com>, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	selinux@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v6 4/6] fs: make vfs_fileattr_[get|set] return -EOPNOSUPP
Message-ID: <ozxxm5fglq5kuoiteqr34wghaqhxgue4kshz2jnnk7oopmhxk6@a2lo6weivsyz>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
 <20250630-xattrat-syscall-v6-4-c4e3bc35227b@kernel.org>
 <CAOQ4uxgbeMEqx7FtBc3KnrCjOHHRniSjBPLzk7_S9SjYKcY_ag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgbeMEqx7FtBc3KnrCjOHHRniSjBPLzk7_S9SjYKcY_ag@mail.gmail.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 9E138210F9
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.01

On Tue 01-07-25 08:05:45, Amir Goldstein wrote:
> On Mon, Jun 30, 2025 at 6:20 PM Andrey Albershteyn <aalbersh@redhat.com> wrote:
> >
> > Future patches will add new syscalls which use these functions. As
> > this interface won't be used for ioctls only, the EOPNOSUPP is more
> > appropriate return code.
> >
> > This patch converts return code from ENOIOCTLCMD to EOPNOSUPP for
> > vfs_fileattr_get and vfs_fileattr_set. To save old behavior translate
> > EOPNOSUPP back for current users - overlayfs, encryptfs and fs/ioctl.c.
> >
> > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
...
> > --- a/fs/overlayfs/inode.c
> > +++ b/fs/overlayfs/inode.c
> > @@ -721,7 +721,7 @@ int ovl_real_fileattr_get(const struct path *realpath, struct fileattr *fa)
> >                 return err;
> >
> >         err = vfs_fileattr_get(realpath->dentry, fa);
> > -       if (err == -ENOIOCTLCMD)
> > +       if (err == -EOPNOTSUPP)
> >                 err = -ENOTTY;
> >         return err;
> >  }
> 
> That's the wrong way, because it hides the desired -EOPNOTSUPP
> return code from ovl_fileattr_get().
> 
> The conversion to -ENOTTY was done for
> 5b0a414d06c3 ("ovl: fix filattr copy-up failure"),
> so please do this instead:
> 
> --- a/fs/overlayfs/inode.c
> +++ b/fs/overlayfs/inode.c
> @@ -722,7 +722,7 @@ int ovl_real_fileattr_get(const struct path
> *realpath, struct fileattr *fa)
> 
>         err = vfs_fileattr_get(realpath->dentry, fa);
>         if (err == -ENOIOCTLCMD)
> -               err = -ENOTTY;
> +               err = -EOPNOTSUPP;

Is this really needed? AFAICS nobody returns ENOIOCTLCMD after this
patch...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

