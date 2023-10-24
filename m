Return-Path: <linux-fsdevel+bounces-984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 130967D4918
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 09:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CA89B20F74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 07:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4A714F88;
	Tue, 24 Oct 2023 07:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kHcHsGMK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AUJVJ/Nt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F5513FED
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 07:56:19 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FAFF9
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 00:56:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 57B1B21B79;
	Tue, 24 Oct 2023 07:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698134175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ar1OnnUr2FhvbGPoXqbLyR03nliEnCcQms0fks4oEVw=;
	b=kHcHsGMKkL8BSJyqwZewanYZ8/lC5mTm+kY8FfuXWlwQx6HDvdyvkkgT9REBG9IToM7BsZ
	X1uk3HmgOFZN76Uuz+69+qZ9LLM4h0L07fLvbNQmIDXJBKNAJ5zZin0o8P/cenmxKz47KZ
	NJX8enVeH1p/vcROgTreQXxIU9XVzjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698134175;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ar1OnnUr2FhvbGPoXqbLyR03nliEnCcQms0fks4oEVw=;
	b=AUJVJ/Ntvpv90bPUxoKp/ecczrrB6GDEaQ66lH1wZEFR6Hy1525yKFiPhLnI1DfrWqVPLU
	xw3R3Byupu6OjCAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4239E134F5;
	Tue, 24 Oct 2023 07:56:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id QtTRDp94N2VNUgAAMHmgww
	(envelope-from <chrubis@suse.cz>); Tue, 24 Oct 2023 07:56:15 +0000
Date: Tue, 24 Oct 2023 09:56:47 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Cc: mszeredi@redhat.com, brauner@kernel.org, Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Subject: Re: [LTP] [PATCH v2 4/4] syscalls: splice07: New splice tst_fd
 iterator test
Message-ID: <ZTd4v-aY2jXkUgr0@yuki>
References: <20231016123320.9865-1-chrubis@suse.cz>
 <20231016123320.9865-5-chrubis@suse.cz>
 <87o7gpuxfl.fsf@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7gpuxfl.fsf@suse.de>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -7.69
X-Spamd-Result: default: False [-7.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.09)[64.49%]

Hi!
> Yup, because there is nothing in the pipe (which you probably realise).
> 
> The question is, if we want to test actual splicing, should we fill the
> pipe in the lib?
>
> If so should that be an option that we set? TST_FD_FOREACH or
> TST_FD_FOREACH2 could take an opts struct for e.g. or even tst_test. I
> guess with TST_FD_FOREACH2 there is no need to do add anything now.

That would be much more complex. For splicing from a TCP socket I would
have to set up a TCP server, connect the socket there and feed the data
from a sever...

So maybe later on. I would like to avoid adding more complexity to the
patchset at this point and focus on testing errors for now.

> > +	if (fd_in->type == TST_FD_PIPE_READ) {
> > +		switch (fd_out->type) {
> > +		case TST_FD_FILE:
> > +		case TST_FD_PIPE_WRITE:
> > +		case TST_FD_UNIX_SOCK:
> > +		case TST_FD_INET_SOCK:
> > +		case TST_FD_MEMFD:
> > +			return;
> > +		default:
> > +		break;
> > +		}
> > +	}
> > +
> > +	if (fd_out->type == TST_FD_PIPE_WRITE) {
> > +		switch (fd_in->type) {
> > +		/* While these combinations succeeed */
> > +		case TST_FD_FILE:
> > +		case TST_FD_MEMFD:
> > +			return;
> > +		/* And this complains about socket not being connected */
> > +		case TST_FD_INET_SOCK:
> > +			return;
> > +		default:
> > +		break;
> > +		}
> > +	}
> > +
> > +	/* These produce EBADF instead of EINVAL */
> > +	switch (fd_out->type) {
> > +	case TST_FD_DIR:
> > +	case TST_FD_DEV_ZERO:
> > +	case TST_FD_PROC_MAPS:
> > +	case TST_FD_INOTIFY:
> > +	case TST_FD_PIPE_READ:
> > +		exp_errno = EBADF;
> > +	default:
> > +	break;
> > +	}
> > +
> > +	if (fd_in->type == TST_FD_PIPE_WRITE)
> > +		exp_errno = EBADF;
> > +
> > +	if (fd_in->type == TST_FD_OPEN_TREE || fd_out->type == TST_FD_OPEN_TREE ||
> > +	    fd_in->type == TST_FD_PATH || fd_out->type == TST_FD_PATH)
> > +		exp_errno = EBADF;
> 
> This seems like something that could change due to checks changing
> order.

I was hoping that kernel devs would look at the current state, which is
documented in these conditions and tell me how shold we set the
expectations. At least the open_tree() seems to differ from the rest in
several cases, so maybe needs to be aligned with the rest.

> This is a bit offtopic, but we maybe need errno sets, which would be
> useful for our other discussion on relaxing errno checking.

Indeed that is something we have to do either way.

-- 
Cyril Hrubis
chrubis@suse.cz

