Return-Path: <linux-fsdevel+bounces-65340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B76C027BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 18:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60D7C3AF6E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 16:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2263385A3;
	Thu, 23 Oct 2025 16:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoHfb8Iy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2284219301;
	Thu, 23 Oct 2025 16:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761237854; cv=none; b=f5teLi6lu404zRSIwY3rtfCaVxsJHRIkeeU4VTe7RpcJYDTvmVW0i5PHRRxNrr4s0DRfYKVFoIBGRR/qcuEFHQD0xMxWZUg0pcAey+N3cwqgYPGFt9H0WXAsr1q90tpKcTOor+/B2k6iEjdGNZx/CafLlSLlSK5ljmren62G7lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761237854; c=relaxed/simple;
	bh=VAA7Q/g6kiApuugIPJYAaj5pCfbgfWp8NdIwEsu+uaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsO7AG5fdkksJUIkxLfq8SyfLqezS3BqjIzgwbHIDyt3NBdyRUvHz/sW1SqxRg6PL0krkqLKKPIfNEP9oHCoNLHpXNNidamEw46sKTUXCr//ATNWYqhKf2RMdlld01ocPmyDnuUUq+ormbqamS0Dt5NK25T/nbJGhjfruJ7kYv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoHfb8Iy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46772C113D0;
	Thu, 23 Oct 2025 16:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761237853;
	bh=VAA7Q/g6kiApuugIPJYAaj5pCfbgfWp8NdIwEsu+uaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aoHfb8IyYpT4CfDQc8jGo4dGFhs53JKMrKjm7oqwhDG6bS1SykGmrPrMdEU7OCz0Y
	 MA+dHpw9Ed/UHr7a+7GzB+6IHPeXTMEdpwE7CIMbvrxfLcCP5Uqq0F6qaZ1TOq0Gbf
	 NV7D5gMErcdX2YwFk6OUrO9HdRauJKBzBR4o1VjEzzuHOwyVnPyfaGe2OFpPaI03V9
	 4BurTkGPtw0IQ/1Yc4usB0brkZSg3fUMEbJ9En28jEwtQ8MXz9ctXctuZgeY2Fl+vE
	 h081BquAaSahc3OxAlTKK8cc2cbZmP4QwZdKkM/AuPy68fJDl5RvPOwWxpSp5BqK2h
	 +ZPA1FFzWL0Pw==
Date: Thu, 23 Oct 2025 18:44:08 +0200
From: Nathan Chancellor <nathan@kernel.org>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, David Sterba <dsterba@suse.com>,
	Nicolas Schier <nsc@kernel.org>
Subject: Re: [PATCH] fs/pipe: stop duplicating union pipe_index declaration
Message-ID: <20251023164408.GB2090923@ax162>
References: <20251023082142.2104456-1-linux@rasmusvillemoes.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023082142.2104456-1-linux@rasmusvillemoes.dk>

On Thu, Oct 23, 2025 at 10:21:42AM +0200, Rasmus Villemoes wrote:
> Now that we build with -fms-extensions, union pipe_index can be
> included as an anonymous member in struct pipe_inode_info, avoiding
> the duplication.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
> Do we want to do this as well? At the very least it would give some
> more test coverage if this could be in -next for most of a cycle.

Yeah, this would also be a good conversion example so we could include
it in kbuild-next with the appropriate Acks. We probably do not want to
take too many other conversions in the initial pull. If people really
want to use this in other places for 6.19, we should probably do a
shared branch for these changes that maintainers could pull into their
own trees.

> Context for new people:
> 
> https://lore.kernel.org/lkml/CAHk-=wjeZwww6Zswn6F_iZTpUihTSNKYppLqj36iQDDhfntuEw@mail.gmail.com/
> https://lore.kernel.org/linux-kbuild/20251020142228.1819871-1-linux@rasmusvillemoes.dk/
> 
>  include/linux/pipe_fs_i.h | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
> index 9d42d473d201..80539972e569 100644
> --- a/include/linux/pipe_fs_i.h
> +++ b/include/linux/pipe_fs_i.h
> @@ -44,12 +44,6 @@ typedef unsigned int pipe_index_t;
>  typedef unsigned short pipe_index_t;
>  #endif
>  
> -/*
> - * We have to declare this outside 'struct pipe_inode_info',
> - * but then we can't use 'union pipe_index' for an anonymous
> - * union, so we end up having to duplicate this declaration
> - * below. Annoying.
> - */
>  union pipe_index {
>  	unsigned long head_tail;
>  	struct {
> @@ -87,14 +81,7 @@ struct pipe_inode_info {
>  	struct mutex mutex;
>  	wait_queue_head_t rd_wait, wr_wait;
>  
> -	/* This has to match the 'union pipe_index' above */
> -	union {
> -		unsigned long head_tail;
> -		struct {
> -			pipe_index_t head;
> -			pipe_index_t tail;
> -		};
> -	};
> +	union pipe_index;
>  
>  	unsigned int max_usage;
>  	unsigned int ring_size;
> 
> base-commit: 778740ee2d00e5c04d0c8ffd9c3beea89b1ec554
> -- 
> 2.51.0
> 

