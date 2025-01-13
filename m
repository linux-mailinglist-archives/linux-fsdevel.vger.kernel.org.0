Return-Path: <linux-fsdevel+bounces-39038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB3CA0B897
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 14:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1E371645C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 13:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD8122C33C;
	Mon, 13 Jan 2025 13:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfS6uwUE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B70322CF3F;
	Mon, 13 Jan 2025 13:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736776060; cv=none; b=hhzqBTkEywU+dGw/4v+gURn3U3lDyItNgxD7jwZD2rAy25VbljHyS8y4JMQQKuRM6LjqO5NOyyWy+iL1Hzq8+84Ggvgv4UtHLd8Mrl2YMcd9FDYx+BGoVbvdmIwLWcb8+i/SRZhA3OLR9wJm1ZP6PQw11SqDbseobMZtukvmjJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736776060; c=relaxed/simple;
	bh=d6VnacokxFa0NdhC82dN9vc5gzMT70lkfSFY5BX94Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2xP6PV9otav1SgHQ2aTkOJEUq8s8xCux5KPGxSjZe5pVe/xppsjPQOkShqNSv1NPPeMzFAnw0EERfn9FwwYefILA/EFGBdF6sg2nfEInGtTxyUCxm9ajkGCDCKYNZw6zXO2dLmlWVipAB83hWipRcMrKwC03mVsniPJqV8atG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfS6uwUE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E463C4CED6;
	Mon, 13 Jan 2025 13:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736776059;
	bh=d6VnacokxFa0NdhC82dN9vc5gzMT70lkfSFY5BX94Io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BfS6uwUEKi5X3SlriALvSnPkXounsR6SXn3pzaoDzJ91zlkFjWe5mEHgIZkv2ZgqH
	 AIMz1mCK8yRInQjgc/ExjBy6RKj0Y6P6+6V8zYbP9kby4T8BRvZRqtY3n+FRKkfQUx
	 qnA/lAIze6epCAajOEmyQN+acODGYbeLjSmDqo5F/PCPaYvNrmJzTqacvFhyan/r+n
	 jq8lBVGTLLX8XNMb7Rg6SSUSLJKkl91ujOoVfGyKvXqOIiJCsXf31Gs6qvq6U1egS2
	 0xHlOLgElFaY3w7kw4/ZNhCfvJ05YtUFJUrk+o9XLgHSFZ9jrTlcmVZpy7N710EEpm
	 pflaCeACDsryQ==
Date: Mon, 13 Jan 2025 14:47:35 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Charles Han <hanchunchao@inspur.com>
Cc: kees@kernel.org, logang@deltatee.com, mcgrof@kernel.org, 
	yzaikin@google.com, gregkh@linuxfoundation.org, brendan.higgins@linux.dev, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] kernel/sysctl-test: Fix potential null dereference in
 sysctl-test
Message-ID: <a2frlti34dyfiiky3mtcmfz44qtntckrv3i2uzz5pr3aemw2qy@zihefw3poqrf>
References: <20250110100748.63470-1-hanchunchao@inspur.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110100748.63470-1-hanchunchao@inspur.com>

On Fri, Jan 10, 2025 at 06:07:48PM +0800, Charles Han wrote:
> kunit_kzalloc() may return a NULL pointer, dereferencing it without
> NULL check may lead to NULL dereference.
> Add a NULL check for buffer.

Please address the 0-day comments.
> 
> Fixes: 2cb80dbbbaba ("kernel/sysctl-test: Add null pointer test for sysctl.c:proc_dointvec()")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>
> ---
...
>  	unsigned long abs_of_less_than_min = (unsigned long)INT_MAX
>  					     - (INT_MAX + INT_MIN) + 1;
> @@ -354,6 +363,7 @@ static void sysctl_test_api_dointvec_write_single_greater_int_max(
>  	size_t max_len = 32, len = max_len;
>  	loff_t pos = 0;
>  	char *buffer = kunit_kzalloc(test, max_len, GFP_USER);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buffer);
>  	char __user *user_buffer = (char __user *)buffer;
>  	unsigned long greater_than_max = (unsigned long)INT_MAX + 1;
>  
> -- 
> 2.45.2
> 

best
-- 

Joel Granados

