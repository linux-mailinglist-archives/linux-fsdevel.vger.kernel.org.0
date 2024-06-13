Return-Path: <linux-fsdevel+bounces-21611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 959C490671B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 10:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19A3FB2560A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 08:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E231411F6;
	Thu, 13 Jun 2024 08:37:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C0384A2E;
	Thu, 13 Jun 2024 08:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267840; cv=none; b=lC0UP8LpPQgBntA2hhocOrIfgSFlR0VcvoEZxOcDm4JoFHz/WCNMTemDbfFf2L1JqjBNLsICupxcSMJsNTHInAWZpYg7DlDQw4WroAXat8eR1XjmAfxn/TuhUy94MetEMx7gyuREUP5EjcjnG53x7BY36ffR1I+MBCmPISJvuK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267840; c=relaxed/simple;
	bh=h5wDivARpTb9Bsym4NLG7piXQK127/7v0HULHzaLt3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LS8Yf+5plieGU9BK1skcwZRBRI+i5aBGlDHhpqlNPJ5t0VT5GIzmj8UN2UQtsUYGAILzLd3julg9mqeQUDEHLtfzMcwfXLxDnqkp3l7xW9PjIpIwSu+8vjAjaAQ4U3f8fAes0q8xHm2ZbtRbGu3UikeKdt6T8KJMs3+xgS8jo2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FA1C4AF1D;
	Thu, 13 Jun 2024 08:37:17 +0000 (UTC)
Date: Thu, 13 Jun 2024 09:37:15 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: torvalds@linux-foundation.org, ebiederm@xmission.com,
	alexei.starovoitov@gmail.com, rostedt@goodmis.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	bpf@vger.kernel.org, netdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 06/10] mm/kmemleak: Replace strncpy() with
 __get_task_comm()
Message-ID: <Zmqvu-1eUpdZ39PD@arm.com>
References: <20240613023044.45873-1-laoar.shao@gmail.com>
 <20240613023044.45873-7-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613023044.45873-7-laoar.shao@gmail.com>

On Thu, Jun 13, 2024 at 10:30:40AM +0800, Yafang Shao wrote:
> Using __get_task_comm() to read the task comm ensures that the name is
> always NUL-terminated, regardless of the source string. This approach also
> facilitates future extensions to the task comm.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  mm/kmemleak.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index d5b6fba44fc9..ef29aaab88a0 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -663,13 +663,7 @@ static struct kmemleak_object *__alloc_object(gfp_t gfp)
>  		strncpy(object->comm, "softirq", sizeof(object->comm));
>  	} else {
>  		object->pid = current->pid;
> -		/*
> -		 * There is a small chance of a race with set_task_comm(),
> -		 * however using get_task_comm() here may cause locking
> -		 * dependency issues with current->alloc_lock. In the worst
> -		 * case, the command line is not correct.
> -		 */
> -		strncpy(object->comm, current->comm, sizeof(object->comm));
> +		__get_task_comm(object->comm, sizeof(object->comm), current);
>  	}

You deleted the comment stating why it does not use get_task_comm()
without explaining why it would be safe now. I don't recall the details
but most likely lockdep warned of some potential deadlocks with this
function being called with the task_lock held.

So, you either show why this is safe or just use strscpy() directly here
(not sure we'd need strscpy_pad(); I think strscpy() would do, we just
need the NUL-termination).

-- 
Catalin

