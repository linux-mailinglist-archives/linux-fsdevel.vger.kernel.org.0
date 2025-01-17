Return-Path: <linux-fsdevel+bounces-39506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46361A155B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 18:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B21BD188D446
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 17:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC81E1A01B0;
	Fri, 17 Jan 2025 17:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUC2Txjt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5C9166F29;
	Fri, 17 Jan 2025 17:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737134857; cv=none; b=XTpwydEjsDHLy+YzCjecCMi4dMi4Yn+DwScgx0TNjThJmKqEczy0KHn3YPRc+0t5FSZ7XYpWwq929KziKlcl2xoJbSmS2bTSm7Gxw0M7ECaILP8pFFFTS7N8T3GI0wOy5D+jOJKw8wLf8rfYEx5erQRE0XHrtOnJQkAPopg5pQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737134857; c=relaxed/simple;
	bh=gGQs0jdBLONWMw8yIZeO8xwHMCIGE7muTiY0X8OYcaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMshL4FtZniLAyX+XSd2/4CJpdpDT1VrW0RszEPLLNWLBay9hcMIjuI2dkzOKRTA6ZY6zDu8scawoPD0VGkW98V63IjEJ/ux9gpv/24OKXUUJGX6Dp0Qq8/1/XJUM/nhZuypTuWRjzsy+mKedBiqSlapyXnb2pWZxs7Edc+RDFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUC2Txjt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A49C4CEDD;
	Fri, 17 Jan 2025 17:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737134856;
	bh=gGQs0jdBLONWMw8yIZeO8xwHMCIGE7muTiY0X8OYcaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KUC2TxjtsoQGHVGfTV57qJ+h5WstypSORN5Nt+XM5y176z5UuquRhiXJuuTwwEIZo
	 7lnKui4AOmQd89VrdbT9B7fFmx4YsTN51BC955JXawN0WOlDrhU90XM51Z8JBz7JQc
	 88CN5vfEGGgQYSkoxwYYL5cfjW5nQL55y3F+oSt3//Zi3srqCgG/32ijNVH4UBarvK
	 GwldhRkLANHQ6uKTWQprkAExxp63lTqqrJ9FuWYR0vIi7Hxr0dyuTlgRPnoXIATNPk
	 0+ZZHfuB1gdxH6hMFDYzGIongXeGTr2qjTK3hREbQLgrCjFSvqm6+SQHbjxlpTjPK3
	 xdEQ5amq8yMTw==
Date: Fri, 17 Jan 2025 09:27:36 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH] fstests: workaround for gcc-15
Message-ID: <20250117172736.GG1611770@frogsfrogsfrogs>
References: <20250117043709.2941857-1-zlang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117043709.2941857-1-zlang@kernel.org>

On Fri, Jan 17, 2025 at 12:37:09PM +0800, Zorro Lang wrote:
> GCC-15 does a big change, it changes the default language version for
> C compilation from -std=gnu17 to -std=gnu23. That cause lots of "old
> style" C codes hit build errors. On the other word, current xfstests
> can't be used with GCC-15. So -std=gnu17 can help that.
> 
> Signed-off-by: Zorro Lang <zlang@kernel.org>
> ---
> 
> Hi,
> 
> I send this patch just for talking about this issue. The upcoming gcc-15
> does lots of changes, a big change is using C23 by default:
> 
>   https://gcc.gnu.org/gcc-15/porting_to.html
> 
> xfstests has many old style C codes, they hard to be built with gcc-15.
> So we have to either add -std=$old_version (likes this patch), or port
> the code to C23.
> 
> This patch is just a workaround (and a reminder for someone might hit
> this issue with gcc-15 too). If you have any good suggestions or experience
> (for this kind of issue) to share, feel free to reply.

-std=gnu11 to match the kernel and xfsprogs?

--D

> Thanks,
> Zorro
> 
>  include/builddefs.in | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/builddefs.in b/include/builddefs.in
> index 5b5864278..ef124bb87 100644
> --- a/include/builddefs.in
> +++ b/include/builddefs.in
> @@ -75,7 +75,7 @@ HAVE_RLIMIT_NOFILE = @have_rlimit_nofile@
>  NEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE = @need_internal_xfs_ioc_exchange_range@
>  HAVE_FICLONE = @have_ficlone@
>  
> -GCCFLAGS = -funsigned-char -fno-strict-aliasing -Wall
> +GCCFLAGS = -funsigned-char -fno-strict-aliasing -std=gnu17 -Wall
>  SANITIZER_CFLAGS += @autovar_init_cflags@
>  
>  ifeq ($(PKG_PLATFORM),linux)
> -- 
> 2.47.1
> 
> 

