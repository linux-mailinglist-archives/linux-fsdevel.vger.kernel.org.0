Return-Path: <linux-fsdevel+bounces-938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E907A7D3BFF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 18:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25A001C20A0E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Oct 2023 16:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB1C1CFA4;
	Mon, 23 Oct 2023 16:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B277A1CABA
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 16:16:05 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB77D79
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 09:16:03 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 6C0B31FE1D;
	Mon, 23 Oct 2023 16:16:01 +0000 (UTC)
Received: from g78 (unknown [10.163.25.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id BCC792CFD2;
	Mon, 23 Oct 2023 16:16:00 +0000 (UTC)
References: <20231016123320.9865-1-chrubis@suse.cz>
 <20231016123320.9865-5-chrubis@suse.cz>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Cc: mszeredi@redhat.com, brauner@kernel.org, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Subject: Re: [LTP] [PATCH v2 4/4] syscalls: splice07: New splice tst_fd
 iterator test
Date: Mon, 23 Oct 2023 16:59:01 +0100
Organization: Linux Private Site
Reply-To: rpalethorpe@suse.de
In-reply-to: <20231016123320.9865-5-chrubis@suse.cz>
Message-ID: <87o7gpuxfl.fsf@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor denied by domain of rpalethorpe@suse.de) smtp.mailfrom=rpalethorpe@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-2.21 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[rpalethorpe@suse.de];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 DMARC_NA(0.20)[suse.de];
	 R_SPF_SOFTFAIL(0.60)[~all:c];
	 HAS_ORG_HEADER(0.00)[];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 VIOLATED_DIRECT_SPF(3.50)[];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 RCVD_NO_TLS_LAST(0.10)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(0.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -2.21
X-Rspamd-Queue-Id: 6C0B31FE1D

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> We loop over all possible combinations of file descriptors in the test
> and filter out combinations that actually make sense and either block or
> attempt to copy data.
>
> The rest of invalid options produce either EINVAL or EBADF and there
> does not seem to be any clear pattern to the choices of these two.
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  runtest/syscalls                            |  1 +
>  testcases/kernel/syscalls/splice/.gitignore |  1 +
>  testcases/kernel/syscalls/splice/splice07.c | 85 +++++++++++++++++++++
>  3 files changed, 87 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/splice/splice07.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 55396aad8..3af634c11 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1515,6 +1515,7 @@ splice03 splice03
>  splice04 splice04
>  splice05 splice05
>  splice06 splice06
> +splice07 splice07
>  
>  tee01 tee01
>  tee02 tee02
> diff --git a/testcases/kernel/syscalls/splice/.gitignore b/testcases/kernel/syscalls/splice/.gitignore
> index 61e979ad6..88a8dff78 100644
> --- a/testcases/kernel/syscalls/splice/.gitignore
> +++ b/testcases/kernel/syscalls/splice/.gitignore
> @@ -4,3 +4,4 @@
>  /splice04
>  /splice05
>  /splice06
> +/splice07
> diff --git a/testcases/kernel/syscalls/splice/splice07.c b/testcases/kernel/syscalls/splice/splice07.c
> new file mode 100644
> index 000000000..74d3e9c7a
> --- /dev/null
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
> + */
> +#define _GNU_SOURCE
> +
> +#include <sys/socket.h>
> +#include <netinet/in.h>
> +
> +#include "tst_test.h"
> +
> +void check_splice(struct tst_fd *fd_in, struct tst_fd *fd_out)
> +{
> +	int exp_errno = EINVAL;
> +
> +	/* These combinations just hang */

Yup, because there is nothing in the pipe (which you probably realise).

The question is, if we want to test actual splicing, should we fill the
pipe in the lib?

If so should that be an option that we set? TST_FD_FOREACH or
TST_FD_FOREACH2 could take an opts struct for e.g. or even tst_test. I
guess with TST_FD_FOREACH2 there is no need to do add anything now.

> +	if (fd_in->type == TST_FD_PIPE_READ) {
> +		switch (fd_out->type) {
> +		case TST_FD_FILE:
> +		case TST_FD_PIPE_WRITE:
> +		case TST_FD_UNIX_SOCK:
> +		case TST_FD_INET_SOCK:
> +		case TST_FD_MEMFD:
> +			return;
> +		default:
> +		break;
> +		}
> +	}
> +
> +	if (fd_out->type == TST_FD_PIPE_WRITE) {
> +		switch (fd_in->type) {
> +		/* While these combinations succeeed */
> +		case TST_FD_FILE:
> +		case TST_FD_MEMFD:
> +			return;
> +		/* And this complains about socket not being connected */
> +		case TST_FD_INET_SOCK:
> +			return;
> +		default:
> +		break;
> +		}
> +	}
> +
> +	/* These produce EBADF instead of EINVAL */
> +	switch (fd_out->type) {
> +	case TST_FD_DIR:
> +	case TST_FD_DEV_ZERO:
> +	case TST_FD_PROC_MAPS:
> +	case TST_FD_INOTIFY:
> +	case TST_FD_PIPE_READ:
> +		exp_errno = EBADF;
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

This seems like something that could change due to checks changing
order.

This is a bit offtopic, but we maybe need errno sets, which would be
useful for our other discussion on relaxing errno checking.

> +
> +	TST_EXP_FAIL2(splice(fd_in->fd, NULL, fd_out->fd, NULL, 1, 0),
> +		exp_errno, "splice() on %s -> %s",
> +		tst_fd_desc(fd_in), tst_fd_desc(fd_out));
> +}
> +
> +static void verify_splice(void)
> +{
> +	TST_FD_FOREACH(fd_in) {
> +		tst_res(TINFO, "%s -> ...", tst_fd_desc(&fd_in));
> +		TST_FD_FOREACH(fd_out)
> +			check_splice(&fd_in, &fd_out);
> +	}

In general test looks great. It turned out clean and simple.

> +}
> +
> +static struct tst_test test = {
> +	.test_all = verify_splice,
> +};
> -- 
> 2.41.0


-- 
Thank you,
Richard.

