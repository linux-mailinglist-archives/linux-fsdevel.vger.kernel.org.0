Return-Path: <linux-fsdevel+bounces-7433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CDA824BB9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 00:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C62B41C22A0F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 23:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA262D7A2;
	Thu,  4 Jan 2024 23:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tDZeDFsr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2UD+lNiA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tDZeDFsr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2UD+lNiA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9171C2D791
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jan 2024 23:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 939A71F83C;
	Thu,  4 Jan 2024 23:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704409870;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s/j7CRB+Ktnqa0ZviY1seTtrTLtEWjREUKwTyg4hLD0=;
	b=tDZeDFsrw1EHyuAM55X6vrPIRZ0Z2muXtCzXN5ZfImL476agkdEtrhjbXRF9MlLoPZit8C
	7yA5/2hj6VGu86DVrAAWsJr1OQVgeW53DOS/kFNBEPbTyqcrjxOeXkS1jPaPzEMufUzjrz
	psVJqYAmwSW0MEkRDPIn6PKnf5i/A4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704409870;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s/j7CRB+Ktnqa0ZviY1seTtrTLtEWjREUKwTyg4hLD0=;
	b=2UD+lNiAfjnqyNHl8Vkbk0oQxMSjpOYi2q3GdskOaAG/zWvKYrI6c7irEbH5N0eTcP0HEq
	/CHgxaBJQG5uGYBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704409870;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s/j7CRB+Ktnqa0ZviY1seTtrTLtEWjREUKwTyg4hLD0=;
	b=tDZeDFsrw1EHyuAM55X6vrPIRZ0Z2muXtCzXN5ZfImL476agkdEtrhjbXRF9MlLoPZit8C
	7yA5/2hj6VGu86DVrAAWsJr1OQVgeW53DOS/kFNBEPbTyqcrjxOeXkS1jPaPzEMufUzjrz
	psVJqYAmwSW0MEkRDPIn6PKnf5i/A4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704409870;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s/j7CRB+Ktnqa0ZviY1seTtrTLtEWjREUKwTyg4hLD0=;
	b=2UD+lNiAfjnqyNHl8Vkbk0oQxMSjpOYi2q3GdskOaAG/zWvKYrI6c7irEbH5N0eTcP0HEq
	/CHgxaBJQG5uGYBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 635EB13722;
	Thu,  4 Jan 2024 23:11:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A+ggFw47l2X4PAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Thu, 04 Jan 2024 23:11:10 +0000
Date: Fri, 5 Jan 2024 00:11:09 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Cc: ltp@lists.linux.it, mszeredi@redhat.com, brauner@kernel.org,
	Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
	viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: Re: [LTP] [PATCH v2 4/4] syscalls: splice07: New splice tst_fd
 iterator test
Message-ID: <20240104231109.GB1447350@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20231016123320.9865-1-chrubis@suse.cz>
 <20231016123320.9865-5-chrubis@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016123320.9865-5-chrubis@suse.cz>
X-Spam-Level: *
X-Spam-Level: 
X-Spam-Score: 0.28
X-Rspamd-Queue-Id: 939A71F83C
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tDZeDFsr;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2UD+lNiA
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spamd-Result: default: False [0.28 / 50.00];
	 HAS_REPLYTO(0.30)[pvorel@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.01)[45.62%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 REPLYTO_EQ_FROM(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 URIBL_BLOCKED(0.00)[suse.cz:email,suse.cz:dkim];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]

Hi Cyril,

...
> +++ b/testcases/kernel/syscalls/splice/splice07.c
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/*
> + * Copyright (C) 2023 Cyril Hrubis <chrubis@suse.cz>
> + */
> +
> +/*\
> + * [Description]
> + *
nit: missing a description.
> + */
> +#define _GNU_SOURCE
> +
> +#include <sys/socket.h>
> +#include <netinet/in.h>
> +
> +#include "tst_test.h"
> +
> +void check_splice(struct tst_fd *fd_in, struct tst_fd *fd_out)
nit: missing static

> +	/* These produce EBADF instead of EINVAL */
> +	switch (fd_out->type) {
> +	case TST_FD_DIR:
> +	case TST_FD_DEV_ZERO:
> +	case TST_FD_PROC_MAPS:
> +	case TST_FD_INOTIFY:
> +	case TST_FD_PIPE_READ:
> +		exp_errno = EBADF;
I tested it just on kernel 6.6. I wonder if this behaves the same on older
kernels.

> +	default:
> +	break;
> +	}
> +
> +	if (fd_in->type == TST_FD_PIPE_WRITE)
> +		exp_errno = EBADF;
> +
> +	if (fd_in->type == TST_FD_OPEN_TREE || fd_out->type == TST_FD_OPEN_TREE ||
> +	    fd_in->type == TST_FD_PATH || fd_out->type == TST_FD_PATH)
> +		exp_errno = EBADF;
I suppose you'll send another version, which will make use of TST_EXP_FAIL.
https://lore.kernel.org/ltp/20240103115700.14585-1-chrubis@suse.cz/

BTW I also wonder if TST_EXP_FAIL() could simplify some of fanotify tests
(some of them got quite complex over time).

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

