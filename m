Return-Path: <linux-fsdevel+bounces-8164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DEF8308B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 15:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 307172866E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jan 2024 14:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DDB21371;
	Wed, 17 Jan 2024 14:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iWphZ0dG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0/jB+92E";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hZG3jWS8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NYVOO9XB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F0921358
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jan 2024 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705503007; cv=none; b=hMZHXTB4kbtzm7Br+yegkBVT3iaN2vprRhzYyiKSbMutddsg3K+DqL0hgbpOvpLQ0pm1P2UUrzGGbvzQfYfwbeYW/fLq1TyeK9DRAd+nOe3SpFPFauKa4vaEFLHll2FWdABpmI/G/cSVLhrERnaFrLYNcBzRpl1kD2gTznhe69o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705503007; c=relaxed/simple;
	bh=Du4KCjQtN3gTbcq2w3UfzSscnuq2eXhwcBQKOpE4EiM=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Spam-Level:X-Spam-Score:
	 X-Spamd-Result:X-Spam-Flag; b=rlODgJTt/WVp1A7oyAgp5UtayuYeY2b+JBMQhaEP1jxf01U4w9e9yf8ijqKh72cXTljIm8UtxpH1fVSwLDEj5v3ksUFtjBLyuimCKNiU91P0ORPmS01d+Ju+TgrxHlKjNnZ7kR8HSdIm1+SpRw8Ur3AzFN7n/TAW0bMuf+PLAbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iWphZ0dG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0/jB+92E; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hZG3jWS8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NYVOO9XB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E43051FC9E;
	Wed, 17 Jan 2024 14:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705502998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rwL2GEmiFW8hx8tyR1j7E18Lj0t9asL8FE1gISe8pzM=;
	b=iWphZ0dGzxUv835CKS/yDAsBxRihUpIep5D0ta3haXzAEsZefYaDJ5iWYhX1j1hmQVem5o
	C+Kjx69w1nxGENQ/o8kK8Ilw3rSixcOz/JLGqGHXfpah2sMyKuTxUA0AnPeb8A1J8mXpfm
	2sQkeam+aGqyHXYY6OA5PjPU0NZeUZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705502998;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rwL2GEmiFW8hx8tyR1j7E18Lj0t9asL8FE1gISe8pzM=;
	b=0/jB+92ElM09Pk4X5DkXcqOGjUOLln76uNKHrbB/NXSElKIIk643eXoEOt/gbzvp/vtAny
	GfSGlSjFTMHxK/BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705502997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rwL2GEmiFW8hx8tyR1j7E18Lj0t9asL8FE1gISe8pzM=;
	b=hZG3jWS84EKBF1/znhhtuwjr6/1jr2NTTG5EbDKOQB7ZKTRlpNigZsbhozjnelU1Za6FhA
	0GnCtox/xF7y6MaOPdb2Nc2PgEnvV4grhYQamkcvElw83brheXLGoEoylSMR6O2eo455/k
	r/VroBUf3csfCNOOi6Y+tqSCBEk7vDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705502997;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rwL2GEmiFW8hx8tyR1j7E18Lj0t9asL8FE1gISe8pzM=;
	b=NYVOO9XBYVMJgymzPShPD31CNTvufudoCsu0K8+SYJNEEgg/wGVXRtmunMPLTmH0j4CB8S
	cHSJ7pv9urxM1+AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D903C13800;
	Wed, 17 Jan 2024 14:49:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3zP6NBXpp2U6DAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 17 Jan 2024 14:49:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9EE2BA0803; Wed, 17 Jan 2024 15:49:53 +0100 (CET)
Date: Wed, 17 Jan 2024 15:49:53 +0100
From: Jan Kara <jack@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Cc: ltp@lists.linux.it, Matthew Wilcox <willy@infradead.org>,
	amir73il@gmail.com, mszeredi@redhat.com, brauner@kernel.org,
	viro@zeniv.linux.org.uk, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Richard Palethorpe <rpalethorpe@suse.com>
Subject: Re: [PATCH v3 3/4] syscalls: accept: Add tst_fd test
Message-ID: <20240117144953.thfogyhkbmeyi3wa@quack3>
References: <20240115125351.7266-1-chrubis@suse.cz>
 <20240115125351.7266-4-chrubis@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115125351.7266-4-chrubis@suse.cz>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[lists.linux.it,infradead.org,gmail.com,redhat.com,kernel.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org,suse.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Mon 15-01-24 13:53:50, Cyril Hrubis wrote:
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

Makes sense to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  runtest/syscalls                            |  1 +
>  testcases/kernel/syscalls/accept/.gitignore |  1 +
>  testcases/kernel/syscalls/accept/accept01.c |  8 ---
>  testcases/kernel/syscalls/accept/accept03.c | 60 +++++++++++++++++++++
>  4 files changed, 62 insertions(+), 8 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/accept/accept03.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 8216d86b0..5472c954b 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -3,6 +3,7 @@ abort01 abort01
>  
>  accept01 accept01
>  accept02 accept02
> +accept03 accept03
>  
>  accept4_01 accept4_01
>  
> diff --git a/testcases/kernel/syscalls/accept/.gitignore b/testcases/kernel/syscalls/accept/.gitignore
> index 5b1462699..f81d4bec9 100644
> --- a/testcases/kernel/syscalls/accept/.gitignore
> +++ b/testcases/kernel/syscalls/accept/.gitignore
> @@ -1,2 +1,3 @@
>  /accept01
>  /accept02
> +/accept03
> diff --git a/testcases/kernel/syscalls/accept/accept01.c b/testcases/kernel/syscalls/accept/accept01.c
> index 85af0f8af..e5db1dfec 100644
> --- a/testcases/kernel/syscalls/accept/accept01.c
> +++ b/testcases/kernel/syscalls/accept/accept01.c
> @@ -26,7 +26,6 @@
>  struct sockaddr_in sin0, sin1, fsin1;
>  
>  int invalid_socketfd = 400; /* anything that is not an open file */
> -int devnull_fd;
>  int socket_fd;
>  int udp_fd;
>  
> @@ -45,10 +44,6 @@ static struct test_case {
>  		(struct sockaddr *)&fsin1, sizeof(fsin1), EBADF,
>  		"bad file descriptor"
>  	},
> -	{
> -		PF_INET, SOCK_STREAM, 0, &devnull_fd, (struct sockaddr *)&fsin1,
> -		sizeof(fsin1), ENOTSOCK, "fd is not socket"
> -	},
>  	{
>  		PF_INET, SOCK_STREAM, 0, &socket_fd, (struct sockaddr *)3,
>  		sizeof(fsin1), EINVAL, "invalid socket buffer"
> @@ -73,8 +68,6 @@ static void test_setup(void)
>  	sin0.sin_port = 0;
>  	sin0.sin_addr.s_addr = INADDR_ANY;
>  
> -	devnull_fd = SAFE_OPEN("/dev/null", O_WRONLY);
> -
>  	socket_fd = SAFE_SOCKET(PF_INET, SOCK_STREAM, 0);
>  	SAFE_BIND(socket_fd, (struct sockaddr *)&sin0, sizeof(sin0));
>  
> @@ -88,7 +81,6 @@ static void test_setup(void)
>  
>  static void test_cleanup(void)
>  {
> -	SAFE_CLOSE(devnull_fd);
>  	SAFE_CLOSE(socket_fd);
>  	SAFE_CLOSE(udp_fd);
>  }
> diff --git a/testcases/kernel/syscalls/accept/accept03.c b/testcases/kernel/syscalls/accept/accept03.c
> new file mode 100644
> index 000000000..b85ec0d9b
> --- /dev/null
> +++ b/testcases/kernel/syscalls/accept/accept03.c
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +/*
> + * Copyright (C) 2023-2024 Cyril Hrubis <chrubis@suse.cz>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Verify that accept() returns ENOTSOCK or EBADF for non-socket file
> + * descriptors. The EBADF is returned in the case that the file descriptor has
> + * not a file associated with it, which is for example in the case of O_PATH
> + * opened file.
> + */
> +
> +#include <sys/socket.h>
> +#include <netinet/in.h>
> +
> +#include "tst_test.h"
> +
> +void check_accept(struct tst_fd *fd)
> +{
> +	struct sockaddr_in addr = {
> +		.sin_family = AF_INET,
> +		.sin_port = 0,
> +		.sin_addr = {.s_addr = INADDR_ANY},
> +	};
> +
> +	socklen_t size = sizeof(addr);
> +
> +	int exp_errno = ENOTSOCK;
> +
> +	switch (fd->type) {
> +	case TST_FD_UNIX_SOCK:
> +	case TST_FD_INET_SOCK:
> +		return;
> +	/*
> +	 * With these two we fail even before we get to the do_accept() because
> +	 * the fd does not have a struct file associated.
> +	 */
> +	case TST_FD_OPEN_TREE:
> +	case TST_FD_PATH:
> +		exp_errno = EBADF;
> +	default:
> +		break;
> +	}
> +
> +	TST_EXP_FAIL2(accept(fd->fd, (void*)&addr, &size),
> +		exp_errno, "accept() on %s", tst_fd_desc(fd));
> +}
> +
> +static void verify_accept(void)
> +{
> +	TST_FD_FOREACH(fd)
> +		check_accept(&fd);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = verify_accept,
> +};
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

