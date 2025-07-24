Return-Path: <linux-fsdevel+bounces-55920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2212B1014A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 09:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60923A9575
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 07:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394C5226CF0;
	Thu, 24 Jul 2025 07:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWXWPmcK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855482AF1D;
	Thu, 24 Jul 2025 07:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753340803; cv=none; b=UyiPMvjwqPmR+e+q21O6MpA1Xx+aatNHY91giJJw/FGX4+kB7aJoAdlLVYapszadXjbdeGQwKfG2o7X5FMp5gwd+3QCu1I3BJz8sGrQESUUx4L4CUMmYx5XUp69iqoAd04aeONgo8BYPWeEpEkTl0IX1pGOkbtjgKPIrQyGgOI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753340803; c=relaxed/simple;
	bh=sej0X/um4Puq/WT7bts08CgrzXQnU4yySgZNzrUUUDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVsyjlqoI8eTPqo/mc4imlcJS7pGK+u3Qoll3Si5jCA4RMYE0p7A6fNujBwfRZ1RNSzi7QMjbwTaSyyvLyeDJkh3CL+InJ676lZtFtyZ7q18AiHDi2JxIZ1eHv81Id+K1D2wpaTyLcQU4Ks61eZwcyfTjJQHjlKit5Fz+YkYkC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWXWPmcK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A78BEC4CEED;
	Thu, 24 Jul 2025 07:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753340801;
	bh=sej0X/um4Puq/WT7bts08CgrzXQnU4yySgZNzrUUUDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QWXWPmcKv+XyHJFQ/3Jd/Q9cpFVbmd9t89Q00C12XeUC+pXJ4/8PntaU/MJAXbR6Z
	 PVWf2sGRdCDLEsq0l8pKRxJOlRwbbAlXWRNi031SK7Yh1cPX4VDRm14E0w04LcRO5G
	 Fw4kBbW9TFfiRx4Q6AqT/CHat/IfmEqsueWnGV+GJT5cihxwjpFfvwdE4nKJD2T0/S
	 0ezFEfrAr6rOM1QEjDD1j1LlhM+7C9dS2MTpmkYw2Dj7eG79j8u1kpkv4MwZ7cZoJo
	 AhL60YGEFNx9EWzas0DbYRYOQzoRiotqzXzk5An1sNX/+YR3ne/wnkn86X1iWL7aMN
	 Q+Ws4mSXin1fg==
Date: Thu, 24 Jul 2025 09:06:36 +0200
From: Christian Brauner <brauner@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/4] pidns: move is-ancestor logic to helper
Message-ID: <20250724-lakai-zombie-2676e99b9a7a@brauner>
References: <20250723-procfs-pidns-api-v2-0-621e7edd8e40@cyphar.com>
 <20250723-procfs-pidns-api-v2-1-621e7edd8e40@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250723-procfs-pidns-api-v2-1-621e7edd8e40@cyphar.com>

On Wed, Jul 23, 2025 at 09:18:51AM +1000, Aleksa Sarai wrote:
> This check will be needed in later patches, and there's no point
> open-coding it each time.
> 
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
>  include/linux/pid_namespace.h |  9 +++++++++
>  kernel/pid_namespace.c        | 23 +++++++++++++++--------
>  2 files changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
> index 7c67a5811199..17fdc059f8da 100644
> --- a/include/linux/pid_namespace.h
> +++ b/include/linux/pid_namespace.h
> @@ -84,6 +84,9 @@ extern void zap_pid_ns_processes(struct pid_namespace *pid_ns);
>  extern int reboot_pid_ns(struct pid_namespace *pid_ns, int cmd);
>  extern void put_pid_ns(struct pid_namespace *ns);
>  
> +extern bool pidns_is_ancestor(struct pid_namespace *child,
> +			      struct pid_namespace *ancestor);
> +
>  #else /* !CONFIG_PID_NS */
>  #include <linux/err.h>
>  
> @@ -118,6 +121,12 @@ static inline int reboot_pid_ns(struct pid_namespace *pid_ns, int cmd)
>  {
>  	return 0;
>  }
> +
> +static inline bool pidns_is_ancestor(struct pid_namespace *child,
> +				     struct pid_namespace *ancestor)
> +{
> +	return false;
> +}
>  #endif /* CONFIG_PID_NS */
>  
>  extern struct pid_namespace *task_active_pid_ns(struct task_struct *tsk);
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index 7098ed44e717..c2783c5fa90b 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -390,11 +390,24 @@ static void pidns_put(struct ns_common *ns)
>  	put_pid_ns(to_pid_ns(ns));
>  }
>  
> +bool pidns_is_ancestor(struct pid_namespace *child,
> +		       struct pid_namespace *ancestor)
> +{
> +	struct pid_namespace *ns;
> +
> +	if (child->level < ancestor->level)
> +		return false;
> +	for (ns = child; ns->level > ancestor->level; ns = ns->parent)
> +		;
> +	return ns == ancestor;
> +}
> +EXPORT_SYMBOL_GPL(pidns_is_ancestor);

Why do you need to export this? Afaict, this is only used from procfs
and iirc procfs cannot be a module. This could also be a static inline
completely in the header? Otherwise this looks good.

