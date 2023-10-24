Return-Path: <linux-fsdevel+bounces-1005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1C07D4C7B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 11:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1770328194E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 09:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3732F2421C;
	Tue, 24 Oct 2023 09:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="A7Vf/h2I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZK7UCKmm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028C814F9E
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 09:33:25 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB88C1BC7
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 02:33:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4673F1FD87;
	Tue, 24 Oct 2023 09:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698140001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ahilqsyr34aypjt/QhYgtXq9Mqz9d3Qr7GdrM7vyV4k=;
	b=A7Vf/h2IFo4ALjRJ92tHdk2YjxG9xror+tVzcbBgjcjPUcZZN9C2wve9YGHqf5lgcixDtc
	SZbXg53yxtYlUQlK55T4OAP+1KqgvVccgWS5NenPUmsCdTc9gJA35qYJhopOFHQXaaAlbB
	agxPG8pjyWPrHGPS1aGb/UwysKakLvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698140001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ahilqsyr34aypjt/QhYgtXq9Mqz9d3Qr7GdrM7vyV4k=;
	b=ZK7UCKmmHBdSzcKp7QqFlf37S+M85PAzpvhZ5wY66rkwY3UN2CAfButL7jOXiahmL69Y77
	AdHfT0zg0iGE/yDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 361C1134F5;
	Tue, 24 Oct 2023 09:33:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id MPUtDWGPN2V+CAAAMHmgww
	(envelope-from <jack@suse.cz>); Tue, 24 Oct 2023 09:33:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A5632A05BC; Tue, 24 Oct 2023 11:33:20 +0200 (CEST)
Date: Tue, 24 Oct 2023 11:33:20 +0200
From: Jan Kara <jack@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Cc: Richard Palethorpe <rpalethorpe@suse.de>, mszeredi@redhat.com,
	brauner@kernel.org, Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Subject: Re: [LTP] [PATCH v2 4/4] syscalls: splice07: New splice tst_fd
 iterator test
Message-ID: <20231024093320.wsusd5qtveqt64dt@quack3>
References: <20231016123320.9865-1-chrubis@suse.cz>
 <20231016123320.9865-5-chrubis@suse.cz>
 <87o7gpuxfl.fsf@suse.de>
 <ZTd4v-aY2jXkUgr0@yuki>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTd4v-aY2jXkUgr0@yuki>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -9.91
X-Spamd-Result: default: False [-9.91 / 50.00];
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
	 RCPT_COUNT_SEVEN(0.00)[9];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.31)[96.76%]

On Tue 24-10-23 09:56:47, Cyril Hrubis wrote:
> > > +	if (fd_in->type == TST_FD_PIPE_READ) {
> > > +		switch (fd_out->type) {
> > > +		case TST_FD_FILE:
> > > +		case TST_FD_PIPE_WRITE:
> > > +		case TST_FD_UNIX_SOCK:
> > > +		case TST_FD_INET_SOCK:
> > > +		case TST_FD_MEMFD:
> > > +			return;
> > > +		default:
> > > +		break;
> > > +		}
> > > +	}
> > > +
> > > +	if (fd_out->type == TST_FD_PIPE_WRITE) {
> > > +		switch (fd_in->type) {
> > > +		/* While these combinations succeeed */
> > > +		case TST_FD_FILE:
> > > +		case TST_FD_MEMFD:
> > > +			return;
> > > +		/* And this complains about socket not being connected */
> > > +		case TST_FD_INET_SOCK:
> > > +			return;
> > > +		default:
> > > +		break;
> > > +		}
> > > +	}
> > > +
> > > +	/* These produce EBADF instead of EINVAL */
> > > +	switch (fd_out->type) {
> > > +	case TST_FD_DIR:
> > > +	case TST_FD_DEV_ZERO:
> > > +	case TST_FD_PROC_MAPS:
> > > +	case TST_FD_INOTIFY:
> > > +	case TST_FD_PIPE_READ:
> > > +		exp_errno = EBADF;
> > > +	default:
> > > +	break;
> > > +	}
> > > +
> > > +	if (fd_in->type == TST_FD_PIPE_WRITE)
> > > +		exp_errno = EBADF;
> > > +
> > > +	if (fd_in->type == TST_FD_OPEN_TREE || fd_out->type == TST_FD_OPEN_TREE ||
> > > +	    fd_in->type == TST_FD_PATH || fd_out->type == TST_FD_PATH)
> > > +		exp_errno = EBADF;
> > 
> > This seems like something that could change due to checks changing
> > order.
> 
> I was hoping that kernel devs would look at the current state, which is
> documented in these conditions and tell me how shold we set the
> expectations. At least the open_tree() seems to differ from the rest in
> several cases, so maybe needs to be aligned with the rest.

Yeah, so the EINVAL vs EBADF vs EISDIR vs ESPIPE distinction is somewhat
arbitrary and as mentioned it very much depends on the order of checks we
do and that is not very consistent among different operations or over
longer time periods. So it would be good if tests could accept all errors
that make some sense. 

E.g. when we cannot seek (change file position) of the fd, ESPIPE is a
valid error return for any operation involving changing file position.
EISDIR is valid error for any directory fd when doing operation not expected
to work on directories. EINVAL and EBADF are quite generic and should be
accepted anytime fd is not suitable for the operation (generally we try to
return EBADF when the descriptor itself isn't suitable - e.g. O_PATH
descriptor, closed descriptor, ... - and return EINVAL when the open
*object* is not suitable but that is a very rough guideline people don't
always follow). EACCES / EPERM should be accepted error return when we
don't have enough permissions to perform operation on the fd. And so on.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

