Return-Path: <linux-fsdevel+bounces-14744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3C887EBCF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 16:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63D002821AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Mar 2024 15:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C734F1EB;
	Mon, 18 Mar 2024 15:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOsRy1yB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F30B28DD6;
	Mon, 18 Mar 2024 15:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710774798; cv=none; b=T/bfmKI/oeN2RW7qsUUayqGLOZh3Y33qgY0bsz6V1N8uVN4QgIi7IbkSP46Wk1n8l7CscrkcZ5MUn+fpEuDu8Z9LNMx4Yc9oMqanZwzgLKgeYw9SBDUMcplnMuUR6LxV0hlz0ydMfCwGAU8fjmunHfDye2Q235Nq5+fb2jp07kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710774798; c=relaxed/simple;
	bh=rRATV2N31zsveTfJyPsq00vyGMeq8C5j6TUwN5zJ6z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7vF1zChKKQVtqoz/pvtPSHEA5hTTRn9A2DavSwtIYQG9LVj991hwO5u16OdM0oIePWhi9gnkFjAwsUAOnpwnFYwiNI1EuOT1xM1m4ruZA8knxR4bU4PzaltDk29avBdpil1ajsrM7CPJz4bNlIy01y+LJT9a9HG/mCMPqp0lKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOsRy1yB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA78EC433F1;
	Mon, 18 Mar 2024 15:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710774797;
	bh=rRATV2N31zsveTfJyPsq00vyGMeq8C5j6TUwN5zJ6z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NOsRy1yBcOq3Fm7ENrmIQ7hAgJHxb8m+6wRR5+xFvOIHaS/k4gkRl0F0imCxU4zd7
	 PNXwlEKtNXvBEWP2poskYdCRye3YuwQ3cgrmLou3HpPGWKMUK75ALPzGKMXF893PiJ
	 SBpWXZaNjkmn1KiXMnM91etp+I0Dv0qM8x75bR/086aMj5SrxJtoR4Dm84EvASX2pq
	 yzgMcpAuyIkapckZcmgbvsUJeE2hITHNajlJo77i/AH/Jvn2pgJvpN3NfbwNtUETFw
	 bU0v1tMswFdLqqayxnZU19RcaXm147LHVoWZBEgCivqvlfdiXai6nFHQL322jXyvJm
	 cB0W/OTocpbYg==
Date: Mon, 18 Mar 2024 16:13:12 +0100
From: Christian Brauner <brauner@kernel.org>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: amir73il@gmail.com, hu1.chen@intel.com, miklos@szeredi.hu, 
	malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com, 
	lizhen.you@intel.com, linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC v3 1/5] cleanup: Fix discarded const warning when defining
 lock guard
Message-ID: <20240318-flocken-nagetiere-1e027955d06e@brauner>
References: <20240216051640.197378-1-vinicius.gomes@intel.com>
 <20240216051640.197378-2-vinicius.gomes@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240216051640.197378-2-vinicius.gomes@intel.com>

On Thu, Feb 15, 2024 at 09:16:36PM -0800, Vinicius Costa Gomes wrote:
> Fix the following warning when defining a cleanup guard for a "const"
> pointer type:
> 
> ./include/linux/cleanup.h:211:18: warning: return discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
>   211 |         return _T->lock;                                                \
>       |                ~~^~~~~~
> ./include/linux/cleanup.h:233:1: note: in expansion of macro ‘__DEFINE_UNLOCK_GUARD’
>   233 | __DEFINE_UNLOCK_GUARD(_name, _type, _unlock, __VA_ARGS__)               \
>       | ^~~~~~~~~~~~~~~~~~~~~
> ./include/linux/cred.h:193:1: note: in expansion of macro ‘DEFINE_LOCK_GUARD_1’
>   193 | DEFINE_LOCK_GUARD_1(cred, const struct cred, _T->lock = override_creds_light(_T->lock),
>       | ^~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>  include/linux/cleanup.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
> index c2d09bc4f976..085482ef46c8 100644
> --- a/include/linux/cleanup.h
> +++ b/include/linux/cleanup.h
> @@ -208,7 +208,7 @@ static inline void class_##_name##_destructor(class_##_name##_t *_T)	\
>  									\
>  static inline void *class_##_name##_lock_ptr(class_##_name##_t *_T)	\
>  {									\
> -	return _T->lock;						\
> +	return (void *)_T->lock;					\
>  }

I think both of these patches are a bit ugly as we burden the generic
cleanup code with casting to void which could cause actual issues.

Casting from const to non-const is rather specific to the cred code so I
would rather like to put the burden on the cred code instead of the
generic code if possible.

