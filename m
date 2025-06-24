Return-Path: <linux-fsdevel+bounces-52736-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D59AE6102
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 11:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 137F27A6D27
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 09:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0865227BF84;
	Tue, 24 Jun 2025 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Fue5e0m5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qXp/8+am";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Fue5e0m5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qXp/8+am"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E093F25CC50
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750757983; cv=none; b=HznLrqiBsUxeu1lykAS+KK278a+XxW28HwFaUtRoqr8i3k++X0cYQsJZQAIUQn7P+nCp+EUaK8wdhMQtx8ezOty7UgRHLEU+PKL9MqqOwo2RRRS6tEQO6R5r25vnpSzlxJxxnULIawN+Xl0zDdbaU5AmBOx9iDQJGysf8nCKQpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750757983; c=relaxed/simple;
	bh=o+Clf7Yp7wsqPYGo8XH9WsWgb0jpdVFNuO8HDyQc0VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IP8OQ7t1FGYrQ1fQTRDs0L3KKFvIXMPgYCmj9ZXt1Amjwo0xPnLM8CsvB9qRpXwzhKLBwxDqIDWtc/JBEjGuWD7NvWyQTvDE0wAnqSUFyh+RmmO1DNTVRkuHTINQerRySVJv3P0wD0Mmk11G08EgmBSJXCcs4lR7SUd1b5rDygs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Fue5e0m5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qXp/8+am; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Fue5e0m5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qXp/8+am; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1E7AC1F391;
	Tue, 24 Jun 2025 09:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750757980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vnEybcjYtBn0fE9XI6JZYyapdXswcfWlXGaHib2mIHA=;
	b=Fue5e0m5+m0/+388fxa98kSDUSMPlNLoqDL8yVKnD5Wgb9eB8YOPw5Bs5nYgfW7zeZs1K2
	p3BNAkR17g8pfBcknAeGfyBbyXT9DlqUfRFHSwarZCb7LVvP0d3Rs8i5TrtxVz2J/lTXCm
	/KBpj6enYwIgFievpQbRRQqBQTFPvOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750757980;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vnEybcjYtBn0fE9XI6JZYyapdXswcfWlXGaHib2mIHA=;
	b=qXp/8+amFhzVEPUbwo04gDcAug7/wndPdNGjJozEU5SABxlUQGAouljQcP7T2twocDqpTj
	IAGIya5EQuR5QqBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750757980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vnEybcjYtBn0fE9XI6JZYyapdXswcfWlXGaHib2mIHA=;
	b=Fue5e0m5+m0/+388fxa98kSDUSMPlNLoqDL8yVKnD5Wgb9eB8YOPw5Bs5nYgfW7zeZs1K2
	p3BNAkR17g8pfBcknAeGfyBbyXT9DlqUfRFHSwarZCb7LVvP0d3Rs8i5TrtxVz2J/lTXCm
	/KBpj6enYwIgFievpQbRRQqBQTFPvOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750757980;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vnEybcjYtBn0fE9XI6JZYyapdXswcfWlXGaHib2mIHA=;
	b=qXp/8+amFhzVEPUbwo04gDcAug7/wndPdNGjJozEU5SABxlUQGAouljQcP7T2twocDqpTj
	IAGIya5EQuR5QqBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 075A913751;
	Tue, 24 Jun 2025 09:39:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GdLGAVxyWmi6IQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 24 Jun 2025 09:39:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A4A64A0A03; Tue, 24 Jun 2025 11:39:39 +0200 (CEST)
Date: Tue, 24 Jun 2025 11:39:39 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 11/11] selftests/pidfd: decode pidfd file handles
 withou having to specify an fd
Message-ID: <7ekmxqlg7bgwoglnn4ojv4d2ze5micuzjsjopw2tkkgnl6ei43@4jlaaouas7qg>
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
 <20250624-work-pidfs-fhandle-v2-11-d02a04858fe3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624-work-pidfs-fhandle-v2-11-d02a04858fe3@kernel.org>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,suse.cz,gmail.com,ffwll.ch,vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Tue 24-06-25 10:29:14, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  tools/testing/selftests/pidfd/Makefile             |  2 +-
>  tools/testing/selftests/pidfd/pidfd.h              |  4 ++
>  .../selftests/pidfd/pidfd_file_handle_test.c       | 60 ++++++++++++++++++++++
>  3 files changed, 65 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
> index 03a6eede9c9e..764a8f9ecefa 100644
> --- a/tools/testing/selftests/pidfd/Makefile
> +++ b/tools/testing/selftests/pidfd/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -CFLAGS += -g $(KHDR_INCLUDES) -pthread -Wall
> +CFLAGS += -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES) -pthread -Wall
>  
>  TEST_GEN_PROGS := pidfd_test pidfd_fdinfo_test pidfd_open_test \
>  	pidfd_poll_test pidfd_wait pidfd_getfd_test pidfd_setns_test \
> diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
> index 5dfeb1bdf399..b427a2636402 100644
> --- a/tools/testing/selftests/pidfd/pidfd.h
> +++ b/tools/testing/selftests/pidfd/pidfd.h
> @@ -19,6 +19,10 @@
>  #include "../kselftest.h"
>  #include "../clone3/clone3_selftests.h"
>  
> +#ifndef FD_INVALID
> +#define FD_INVALID -10009 /* Invalid file descriptor. */
> +#endif
> +
>  #ifndef P_PIDFD
>  #define P_PIDFD 3
>  #endif
> diff --git a/tools/testing/selftests/pidfd/pidfd_file_handle_test.c b/tools/testing/selftests/pidfd/pidfd_file_handle_test.c
> index 439b9c6c0457..ff1bf51bca5e 100644
> --- a/tools/testing/selftests/pidfd/pidfd_file_handle_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_file_handle_test.c
> @@ -500,4 +500,64 @@ TEST_F(file_handle, valid_name_to_handle_at_flags)
>  	ASSERT_EQ(close(pidfd), 0);
>  }
>  
> +/*
> + * That we decode a file handle without having to pass a pidfd.
> + */
> +TEST_F(file_handle, decode_purely_based_on_file_handle)
> +{
> +	int mnt_id;
> +	struct file_handle *fh;
> +	int pidfd = -EBADF;
> +	struct stat st1, st2;
> +
> +	fh = malloc(sizeof(struct file_handle) + MAX_HANDLE_SZ);
> +	ASSERT_NE(fh, NULL);
> +	memset(fh, 0, sizeof(struct file_handle) + MAX_HANDLE_SZ);
> +	fh->handle_bytes = MAX_HANDLE_SZ;
> +
> +	ASSERT_EQ(name_to_handle_at(self->child_pidfd1, "", fh, &mnt_id, AT_EMPTY_PATH), 0);
> +
> +	ASSERT_EQ(fstat(self->child_pidfd1, &st1), 0);
> +
> +	pidfd = open_by_handle_at(FD_INVALID, fh, 0);
> +	ASSERT_GE(pidfd, 0);
> +
> +	ASSERT_EQ(fstat(pidfd, &st2), 0);
> +	ASSERT_TRUE(st1.st_dev == st2.st_dev && st1.st_ino == st2.st_ino);
> +
> +	ASSERT_EQ(close(pidfd), 0);
> +
> +	pidfd = open_by_handle_at(FD_INVALID, fh, O_CLOEXEC);
> +	ASSERT_GE(pidfd, 0);
> +
> +	ASSERT_EQ(fstat(pidfd, &st2), 0);
> +	ASSERT_TRUE(st1.st_dev == st2.st_dev && st1.st_ino == st2.st_ino);
> +
> +	ASSERT_EQ(close(pidfd), 0);
> +
> +	pidfd = open_by_handle_at(FD_INVALID, fh, O_NONBLOCK);
> +	ASSERT_GE(pidfd, 0);
> +
> +	ASSERT_EQ(fstat(pidfd, &st2), 0);
> +	ASSERT_TRUE(st1.st_dev == st2.st_dev && st1.st_ino == st2.st_ino);
> +
> +	ASSERT_EQ(close(pidfd), 0);
> +
> +	pidfd = open_by_handle_at(self->pidfd, fh, 0);
> +	ASSERT_GE(pidfd, 0);
> +
> +	ASSERT_EQ(fstat(pidfd, &st2), 0);
> +	ASSERT_TRUE(st1.st_dev == st2.st_dev && st1.st_ino == st2.st_ino);
> +
> +	ASSERT_EQ(close(pidfd), 0);
> +
> +	pidfd = open_by_handle_at(-EBADF, fh, 0);
> +	ASSERT_LT(pidfd, 0);
> +
> +	pidfd = open_by_handle_at(AT_FDCWD, fh, 0);
> +	ASSERT_LT(pidfd, 0);
> +
> +	free(fh);
> +}
> +
>  TEST_HARNESS_MAIN
> 
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

