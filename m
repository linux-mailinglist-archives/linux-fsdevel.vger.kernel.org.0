Return-Path: <linux-fsdevel+bounces-60486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03999B488D5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 11:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57F823C6060
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 09:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4432F3C28;
	Mon,  8 Sep 2025 09:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m0O4w7CB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ysb1Sqo8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m0O4w7CB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ysb1Sqo8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763842F3C2D
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Sep 2025 09:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324476; cv=none; b=WeOloaYRDI/5NwoasrUek4WuzTKOiUmm673y4Jb8m+oyCGmMHQ7qPQ4wexUGhgLqRFTr9iOHfX6eb+7vrl7EMjIsYgzVzzILDyIr+7zdP1HhiZ81X/IaGfeRwNO/oGWNPV44B9xZif+OkXiWhdDYMBTiDPKkrT3Cke9Wy59oEbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324476; c=relaxed/simple;
	bh=uzZwoQ6XS8RfXoweBzzvaTNnVZf93XiF5Ylt1lEIVVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFikb8aOe2rJ4rGs1ZElLH8uRwhCzXDJQLxNtpXCHDOStNJZjNvRBzPwfclCF+edskef9jFtVm5UBLc2oPDvqW+v6fqiu/3E/fgwf50rXSlapXWakzXVMWLJtI30e5C3XMzeNRImeeMbbsnDl4eVIlopaVXbSgs8BORZY9ZJykc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m0O4w7CB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ysb1Sqo8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m0O4w7CB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ysb1Sqo8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 529EC267FA;
	Mon,  8 Sep 2025 09:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757324471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JiNXIY8pPQehwB+uDqWwZtVuz1dH1/0OHIYY7sEX4Mc=;
	b=m0O4w7CBaiJROf0+nZyC3TUOv+Dni3zgVA4KFAO8bNNEH6TztHvquih3o/ioy4WKeoOed/
	cij+vxG326XmOaT9PA39PuyHWhr8+27WYdLMAB6ia6YVGBAxn0usqUP+J8cvSh0LUq3nYo
	FRBTQsM4SbXfOwqWKXA/TmDs0BPPIR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757324471;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JiNXIY8pPQehwB+uDqWwZtVuz1dH1/0OHIYY7sEX4Mc=;
	b=ysb1Sqo8tG37FIOIp7Y9KWQJFHp1DCjCIz+vXO8J80+PYn8+QrXO1f3rjW/Yl9T0OycliN
	6nvRFOm9UEK3e3Dg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=m0O4w7CB;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ysb1Sqo8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757324471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JiNXIY8pPQehwB+uDqWwZtVuz1dH1/0OHIYY7sEX4Mc=;
	b=m0O4w7CBaiJROf0+nZyC3TUOv+Dni3zgVA4KFAO8bNNEH6TztHvquih3o/ioy4WKeoOed/
	cij+vxG326XmOaT9PA39PuyHWhr8+27WYdLMAB6ia6YVGBAxn0usqUP+J8cvSh0LUq3nYo
	FRBTQsM4SbXfOwqWKXA/TmDs0BPPIR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757324471;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JiNXIY8pPQehwB+uDqWwZtVuz1dH1/0OHIYY7sEX4Mc=;
	b=ysb1Sqo8tG37FIOIp7Y9KWQJFHp1DCjCIz+vXO8J80+PYn8+QrXO1f3rjW/Yl9T0OycliN
	6nvRFOm9UEK3e3Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47A2413869;
	Mon,  8 Sep 2025 09:41:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YhR4EbekvmhFbQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 08 Sep 2025 09:41:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0B5B0A0A2D; Mon,  8 Sep 2025 11:41:11 +0200 (CEST)
Date: Mon, 8 Sep 2025 11:41:11 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org, amir73il@gmail.com, chuck.lever@oracle.com, 
	linkinjeon@kernel.org, john@apparmor.net
Subject: Re: [PATCH 05/21] bpf...d_path(): constify path argument
Message-ID: <f6qdt3isdf3q7n5rarqhzn5rqp2znp4kze6ctnr7i4nmcwd5uk@tolexytlh5bi>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
 <20250906091137.95554-5-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906091137.95554-5-viro@zeniv.linux.org.uk>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,suse.cz,linux-foundation.org,gmail.com,oracle.com,apparmor.net];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.org.uk:email,suse.cz:email,suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 529EC267FA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01

On Sat 06-09-25 10:11:21, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/bpf_fs_kfuncs.c                             | 2 +-
>  kernel/trace/bpf_trace.c                       | 2 +-
>  tools/testing/selftests/bpf/bpf_experimental.h | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 1e36a12b88f7..5ace2511fec5 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -79,7 +79,7 @@ __bpf_kfunc void bpf_put_file(struct file *file)
>   * pathname in *buf*, including the NUL termination character. On error, a
>   * negative integer is returned.
>   */
> -__bpf_kfunc int bpf_path_d_path(struct path *path, char *buf, size_t buf__sz)
> +__bpf_kfunc int bpf_path_d_path(const struct path *path, char *buf, size_t buf__sz)
>  {
>  	int len;
>  	char *ret;
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 3ae52978cae6..a8bd6a7351a3 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -900,7 +900,7 @@ const struct bpf_func_proto bpf_send_signal_thread_proto = {
>  	.arg1_type	= ARG_ANYTHING,
>  };
>  
> -BPF_CALL_3(bpf_d_path, struct path *, path, char *, buf, u32, sz)
> +BPF_CALL_3(bpf_d_path, const struct path *, path, char *, buf, u32, sz)
>  {
>  	struct path copy;
>  	long len;
> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
> index da7e230f2781..c15797660cdf 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -219,7 +219,7 @@ extern void bpf_put_file(struct file *file) __ksym;
>   *	including the NULL termination character, stored in the supplied
>   *	buffer. On error, a negative integer is returned.
>   */
> -extern int bpf_path_d_path(struct path *path, char *buf, size_t buf__sz) __ksym;
> +extern int bpf_path_d_path(const struct path *path, char *buf, size_t buf__sz) __ksym;
>  
>  /* This macro must be used to mark the exception callback corresponding to the
>   * main program. For example:
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

