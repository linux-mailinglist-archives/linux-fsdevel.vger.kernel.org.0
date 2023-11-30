Return-Path: <linux-fsdevel+bounces-4444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C637FF687
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 17:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7456BB20D12
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 16:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D250B5576A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 16:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+WfRvpH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D95482DC;
	Thu, 30 Nov 2023 16:37:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14325C433C7;
	Thu, 30 Nov 2023 16:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701362220;
	bh=SobiidIS+hHcukJvYsXZfDPPGv/R7HPfRW8Q9/zJa4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l+WfRvpHrwFcH8e0Rc5LeToQAMVsKHg8zRjgK/9FHGqJ4qIff68sKeolM7nxWOnW5
	 B6Dc8T2yqvV2BJWfLjbP/YxQVgl7PajeyZimbEJvV1Zxc45BRJk87YWhJtvUPNLYGC
	 FpVKPGPG+eR0Fyd3m81nLS0RonccR2VQJ20OpV96GtE4PZwEHCS8ktccsJftsLX4Pf
	 JDLMSvBi1BW2sTlwj3tglZFYFfrUVP1tkcNhLdVJjcm8u3LjBsw1GJ0/XqGBg/CnGn
	 94+dpy6hgWNyMEV0pw2Bi6/A+6Bwd2ql0Bfn4EG7eMm4CdQuDFpiD4Zyd/+2QGLAy5
	 nWHr2C6yBhFhg==
Date: Thu, 30 Nov 2023 16:36:55 +0000
From: Simon Horman <horms@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, paul@paul-moore.com,
	brauner@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, keescook@chromium.org,
	kernel-team@meta.com, sargun@sargun.me
Subject: Re: [PATCH v11 bpf-next 02/17] bpf: add BPF token delegation mount
 options to BPF FS
Message-ID: <20231130163655.GC32077@kernel.org>
References: <20231127190409.2344550-1-andrii@kernel.org>
 <20231127190409.2344550-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127190409.2344550-3-andrii@kernel.org>

On Mon, Nov 27, 2023 at 11:03:54AM -0800, Andrii Nakryiko wrote:

...

> @@ -764,7 +817,10 @@ static int bpf_get_tree(struct fs_context *fc)
>  
>  static void bpf_free_fc(struct fs_context *fc)
>  {
> -	kfree(fc->fs_private);
> +	struct bpf_mount_opts *opts = fc->s_fs_info;
> +
> +	if (opts)
> +		kfree(opts);
>  }

Hi Andrii,

as it looks like there will be a v12, I have a minor nit to report: There
is no need to check if opts is non-NULL because kfree() is basically a
no-op if it's argument is NULL.

So perhaps this can become (completely untested!):

static void bpf_free_fc(struct fs_context *fc)
{
	kfree(fc->s_fs_info);
}

...

