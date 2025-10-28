Return-Path: <linux-fsdevel+bounces-65952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6778DC16BB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 21:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90C621C22D72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 20:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A953502A1;
	Tue, 28 Oct 2025 20:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0ADMY+N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE5370814;
	Tue, 28 Oct 2025 20:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761682076; cv=none; b=MreTTeIfLk/WSrRRfa4aVilfNZVQQs0fa0gpho6+xlboYJ6LNZFe9dyW8Fsm7F/8YWkqBg290wHWyjq6z+3R65UiGXzYimggFp/DFJEPTEeKhftIbWZh3wYX6OCVukMGRHR7yF3Fz6ODv8mTV0D5BDAKd3ZbA+EZyU/W63MjhhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761682076; c=relaxed/simple;
	bh=lqhcGj8AvOs5ztyB9VxiBJaNBn39P9EjaFW2eYVQxlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJkJEtzxq+R2EHF2P5UJXkg0Yp2pZBp8blHv+ahyKRiJestyPhfGgOGxViuiHC4iyoUGp+2RnVdvwlF4VivEUKbNZNsVeNZKpsX3CZ4hdwbDFPnslHXcgeyE15/UY6hXNswHQFWTDViIZ0NltqZJUXwhdlIQJfSSi70voSNLhrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0ADMY+N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED442C4CEE7;
	Tue, 28 Oct 2025 20:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761682076;
	bh=lqhcGj8AvOs5ztyB9VxiBJaNBn39P9EjaFW2eYVQxlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H0ADMY+NtLDcGkjx+pJRYYTdyo7ne4j7NrFRzVnMLqWvtYAfIOitYnbolEvC3cT3B
	 78XwjyJRUL+fwPcfS4UTj9jN7NaC2fH0Y4vsEtimfWgY9QfpYGAp1uSmJOl/0IGG5g
	 7MvPrXz0+1TTviGh/9MmQlBOAzrLwk8KxtdcfnI0Jp7fgkwq1fw+YQdhZIdlxQ43oV
	 jctJQ5trvuTDmJgPz9Jdai6smQHtEw6gUhO3OwGFUnNYt3QRASdbadfKtu4vu9nlWW
	 eXCBAhEBsyQONBuv78Dz54/rLraHfo8P83tCnnmZchlrMSL+YprrV9TF9z64e8odfT
	 XFV++yKc6kpfA==
Date: Tue, 28 Oct 2025 13:07:55 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brajesh Patil <brajeshpatil11@gmail.com>
Cc: miklos@szeredi.hu, stefanha@redhat.com, vgoyal@redhat.com,
	eperezma@redhat.com, virtualization@lists.linux.dev,
	virtio-fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com,
	khalid@kernel.org
Subject: Re: [PATCH] fuse: virtio_fs: add checks for FUSE protocol compliance
Message-ID: <20251028200755.GJ6174@frogsfrogsfrogs>
References: <20251028200311.40372-1-brajeshpatil11@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028200311.40372-1-brajeshpatil11@gmail.com>

On Wed, Oct 29, 2025 at 01:33:11AM +0530, Brajesh Patil wrote:
> Add validation in virtio-fs to ensure the server follows the FUSE
> protocol for response headers, addressing the existing TODO for
> verifying protocol compliance.
> 
> Add checks for fuse_out_header to verify:
>  - oh->unique matches req->in.h.unique
>  - FUSE_INT_REQ_BIT is not set
>  - error codes are valid
>  - oh->len does not exceed the expected size
> 
> Signed-off-by: Brajesh Patil <brajeshpatil11@gmail.com>
> ---
>  fs/fuse/virtio_fs.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 6bc7c97b017d..52e8338bf436 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -764,14 +764,34 @@ static void virtio_fs_request_complete(struct fuse_req *req,
>  {
>  	struct fuse_args *args;
>  	struct fuse_args_pages *ap;
> -	unsigned int len, i, thislen;
> +	struct fuse_out_header *oh;
> +	unsigned int len, i, thislen, expected_len = 0;
>  	struct folio *folio;
>  
> -	/*
> -	 * TODO verify that server properly follows FUSE protocol
> -	 * (oh.uniq, oh.len)
> -	 */
> +	oh = &req->out.h;
> +
> +	if (oh->unique == 0)
> +		pr_warn_once("notify through fuse-virtio-fs not supported");
> +
> +	if ((oh->unique & ~FUSE_INT_REQ_BIT) != req->in.h.unique)
> +		pr_warn_ratelimited("virtio-fs: unique mismatch, expected: %llu got %llu\n",
> +				    req->in.h.unique, oh->unique & ~FUSE_INT_REQ_BIT);

Er... shouldn't these be rejecting the response somehow?  Instead of
warning that something's amiss but continuing with known bad data?

--D

> +
> +	WARN_ON_ONCE(oh->unique & FUSE_INT_REQ_BIT);
> +
> +	if (oh->error <= -ERESTARTSYS || oh->error > 0)
> +		pr_warn_ratelimited("virtio-fs: invalid error code from server: %d\n",
> +				    oh->error);
> +
>  	args = req->args;
> +
> +	for (i = 0; i < args->out_numargs; i++)
> +		expected_len += args->out_args[i].size;
> +
> +	if (oh->len > sizeof(*oh) + expected_len)
> +		pr_warn("FUSE reply too long! got=%u expected<=%u\n",
> +			oh->len, (unsigned int)(sizeof(*oh) + expected_len));
> +
>  	copy_args_from_argbuf(args, req);
>  
>  	if (args->out_pages && args->page_zeroing) {
> -- 
> 2.43.0
> 
> 

