Return-Path: <linux-fsdevel+bounces-8014-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B3182E32B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 00:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CC2B1C2226D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 23:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F981B7E1;
	Mon, 15 Jan 2024 23:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ieep5Zp+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tAhe4oTA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="afbQTWzk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="izHgT7AR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C481B5BA
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 23:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EACA421DE0;
	Mon, 15 Jan 2024 23:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705360195;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eitl/Ihjf1y93YjBEwoTXoCIr8RPcq50Y9T9031ahsE=;
	b=Ieep5Zp+wRC/KKf3ZrF3o5gCLz3CAImj3Vlhfv3dUFIlXPfuGWzJBKpgAEPpFugSGF76AC
	xRIBjRaJhDo4plaP4n4lcpa261qtPKHHfXRxSfJuB36EslGAlhvNyCdeNj6g0tisuxgvDd
	emkN4RObVH395/9t+yc1XGjHi9gEWlU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705360195;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eitl/Ihjf1y93YjBEwoTXoCIr8RPcq50Y9T9031ahsE=;
	b=tAhe4oTACB3w+E74ZMEoAcU/OnpcArwOqEImoJtJQbXDZs2ve1cWAvgk4iAKrXoZo0vol3
	Ofs2S3byxVhmMwDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705360193;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eitl/Ihjf1y93YjBEwoTXoCIr8RPcq50Y9T9031ahsE=;
	b=afbQTWzkaMIz5Uk5mVGoNPT7/DSuGFX0d9EzS+MuCog0BXED6OBZBMB0y8jBPfWQrAkHqv
	O2s5si8pF1BaIbNmLumxhHDK1IrXHlPJ2vUVwdFLe7Ewh3slJTt9D6FB9mvYuVWk8IKVcX
	etlQWEaipYutx0QO7qQWPLj2xnJVwKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705360193;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eitl/Ihjf1y93YjBEwoTXoCIr8RPcq50Y9T9031ahsE=;
	b=izHgT7ARPTStIxfpe6oSy9BsBYG+NVi1ZhZMFueCv73JKMP9zNPGNBJTWA1aeNJDjT1Ib7
	dL1ZhWfMobTxJqAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C57C132FA;
	Mon, 15 Jan 2024 23:09:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Lyd6JEG7pWWPfwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Mon, 15 Jan 2024 23:09:53 +0000
Date: Tue, 16 Jan 2024 00:09:52 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Cc: ltp@lists.linux.it, mszeredi@redhat.com, brauner@kernel.org,
	Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
	viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
	Richard Palethorpe <rpalethorpe@suse.com>
Subject: Re: [LTP] [PATCH v3 1/4] lib: Add tst_fd iterator
Message-ID: <20240115230952.GA2535088@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240115125351.7266-1-chrubis@suse.cz>
 <20240115125351.7266-2-chrubis@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115125351.7266-2-chrubis@suse.cz>
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=afbQTWzk;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=izHgT7AR
X-Spamd-Result: default: False [0.49 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[pvorel@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 REPLYTO_EQ_FROM(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[42.82%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 0.49
X-Rspamd-Queue-Id: EACA421DE0
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

Hi,

...
> --- /dev/null
> +++ b/lib/tst_fd.c
> @@ -0,0 +1,325 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
...
> +static void open_eventfd(struct tst_fd *fd)
> +{
> +	fd->fd = eventfd(0, 0);
> +
> +	if (fd->fd < 0) {
> +		tst_res(TCONF | TERRNO,
very nit: this could be on single line, without brackets.
> +			"Skipping %s", tst_fd_desc(fd));
> +	}
> +}
> +
> +static void open_signalfd(struct tst_fd *fd)
> +{
> +	sigset_t sfd_mask;
nit: space here saves checkpatch warning.
> +	sigemptyset(&sfd_mask);
> +
> +	fd->fd = signalfd(-1, &sfd_mask, 0);
> +	if (fd->fd < 0) {
> +		tst_res(TCONF | TERRNO,
> +			"Skipping %s", tst_fd_desc(fd));
> +	}
> +}
> +
> +static void open_timerfd(struct tst_fd *fd)
> +{
> +	fd->fd = timerfd_create(CLOCK_REALTIME, 0);
> +	if (fd->fd < 0) {
> +		tst_res(TCONF | TERRNO,
Here as well.
> +			"Skipping %s", tst_fd_desc(fd));
> +	}
> +}
...

Obviously ready to merge, thanks!
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

