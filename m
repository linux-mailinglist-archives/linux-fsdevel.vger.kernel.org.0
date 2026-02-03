Return-Path: <linux-fsdevel+bounces-76116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id LxPSMQdKgWkPFgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 02:06:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10233D3384
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 02:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C0DB30160EB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 01:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3311D88B4;
	Tue,  3 Feb 2026 01:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkDCsU6/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01D0E55C;
	Tue,  3 Feb 2026 01:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770080764; cv=none; b=rdAqf+VmLM7VKN/TjQxKBymvcMPf7G+frGrZhm/AIRrdOU3ZM91SORxXfKSua7zfkxfwqhJKSuX4bUUAO1kh12XkBliUG1vLeS8k8kbFsT0hAAm/OvAYqGF1bJavqJcr0Shj/463VxukwGCO1RW96BSVZJv8ZZpnLYwlChOM8Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770080764; c=relaxed/simple;
	bh=azEkiGxiA3Hw2+tfcndTv3hv9emD35wXOEgTKhj5v88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=luD/NN8E7a+4J1iq9fN0Gm+v2ygvJ8DjZAfpZKk8I9bpa18y/Ft/nbORR/lP5alUQnTBilyxbSRu+f6IwcXlxvmY3u5xZlB7pOuEbA3XsY80yOKlhhgx5cQ89v1v0RIu8GKt7XYmIefvrLMdaDP509ilN5RWjKhxO+kt4+LHgNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkDCsU6/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A559C116C6;
	Tue,  3 Feb 2026 01:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770080764;
	bh=azEkiGxiA3Hw2+tfcndTv3hv9emD35wXOEgTKhj5v88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EkDCsU6/YPYJFZ1iaExHI4hbskDbrtiyHvFCcdPJ5aTo5ctujsVFkMrFTjbGFVLto
	 Z6Fu014LXwc49j+8GS56Y1/WDLmRKQNBoyKusXsmNDvqQRtR5klWbXmr93EREDKmLW
	 ZvdetYt/9Jgo5vpT9HcQKz32PF3mH1yxm17xp0wGCEhk6WzbsaZpX08AdiJ6Y46yZ1
	 B83Q4NDoZji7HJ8ow4gZ8bnAC9gV8B8GerBjumPtF92hKCcoWqUnKNG7sBsS9A4gQg
	 2CndLEJwqCayDeDrxUC1jokKeL+HTtTdsbDpMr/syKsrLLHFgRuT7cN5SE3PnsA51w
	 O7rRAHLf/DXoQ==
Date: Mon, 2 Feb 2026 18:05:58 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: david.laight.linux@gmail.com, Christian Brauner <brauner@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Miklos Szeredi <miklos@szeredi.hu>, Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Kees Cook <kees@kernel.org>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Theodore Ts'o <tytso@mit.edu>, Brian Masney <bmasney@redhat.com>
Subject: Re: [PATCH next] fuse: Fix 'min: signedness error' in fuse_wr_pages()
Message-ID: <20260203010558.GA1648836@ax162>
References: <20260113192243.73983-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113192243.73983-1-david.laight.linux@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76116-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 10233D3384
X-Rspamd-Action: no action

On Tue, Jan 13, 2026 at 07:22:43PM +0000, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> On 32bit systems 'pos' is s64 and everything else is 32bit so the
> first argument to min() is signed - generating a warning.
> On 64bit systems 'len' is 64bit unsigned forcing everything to unsigned.
> 
> Fix by reworking the exprssion to completely avoid 64bit maths on 32bit.
> Use DIV_ROUND_UP() instead of open-coding something equivalent.
> 
> Note that the 32bit 'len' cannot overflow because the syscall interface
> limits read/write (etc) to (INT_MAX - PAGE_SIZE) bytes (even on 64bit).
> 
> Fixes: 0f5bb0cfb0b4 ("fs: use min() or umin() instead of min_t()")

Christian, you took 0f5bb0cfb0b4 in vfs-7.0.misc, could you please apply
this fix? Building this file for 32-bit has been broken for the majority
of the -next cycle (I applied an earlier fix David provided and forgot
to chase it until now).

> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
>  fs/fuse/file.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 2595b6b4922b..ff823b0545ed 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1323,8 +1323,8 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
>  static inline unsigned int fuse_wr_pages(loff_t pos, size_t len,
>  				     unsigned int max_pages)
>  {
> -	return min(((pos + len - 1) >> PAGE_SHIFT) - (pos >> PAGE_SHIFT) + 1,
> -		   max_pages);
> +	len += pos % PAGE_SIZE;
> +	return min(DIV_ROUND_UP(len, PAGE_SIZE), max_pages);
>  }
>  
>  static ssize_t fuse_perform_write(struct kiocb *iocb, struct iov_iter *ii)
> -- 
> 2.39.5
> 

