Return-Path: <linux-fsdevel+bounces-54493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 401CEB002E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 15:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E07D1BC58DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 13:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA56285412;
	Thu, 10 Jul 2025 13:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fkKybojH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377411DC9A3;
	Thu, 10 Jul 2025 13:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752152963; cv=none; b=TdMMJ9IaFIMIviO1N7AWr6GVCWQLygdeFNVxxYrzBxi9J1zkkKK2FuAxLdcK2EDwy6/XKUueuJy4aE/cSAgIgkEbhvUwxi0kj/ktrGUDdwYstS+86UOcycqR6OdU9cEqevsn7S1JLSNXOZ96CBr7z9QOhjLueAfDgjBthZXtKX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752152963; c=relaxed/simple;
	bh=aVJI3YGqiyP4dgHE0xW7hMbGBdmM1uJRcRjZGkNUOco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OB60JwQDRp8opgWYj1ugv9T5cJ7NEdmZMnn3YaM8eroVXBfx+1+lFp4pXS3VqhujoWiR4khj8/9NGa0ho6YvwXXkuURjuTm4n5eHo7vB6dlLEjaLv4bKMx7Sv9gRop7oQqmwj7RfLEpTV+NUNnZ1Uj+YvnWZEa7MvDDJ6kNZo4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fkKybojH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6742AC4CEE3;
	Thu, 10 Jul 2025 13:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752152962;
	bh=aVJI3YGqiyP4dgHE0xW7hMbGBdmM1uJRcRjZGkNUOco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fkKybojHJPRa5y3uHhmoR9eXKXBDf+N/z0/WnpoGb47ABPkdj2QoKkt6EPM7/0u7+
	 MWv/onIO98v1tbty8kXEekD4qQBeHv/ZaZzWzemcwdY+szSwe7TYVIbU1sRuWtBWl6
	 b1ZLCK1af8fIqGG0c/z3oWma31mcYHCMFeS3RUbU=
Date: Thu, 10 Jul 2025 15:09:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Heyne, Maximilian" <mheyne@amazon.de>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Oleg Nesterov <oleg@redhat.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	"Sauerwein, David" <dssauerw@amazon.de>,
	Sasha Levin <sashal@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [RESEND PATCH 5.10] fs/proc: do_task_stat: use
 __for_each_thread()
Message-ID: <2025071044-bunt-sister-9d9e@gregkh>
References: <20250710-dyne-quaff-a6577749@mheyne-amazon>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-dyne-quaff-a6577749@mheyne-amazon>

On Thu, Jul 10, 2025 at 12:35:43PM +0000, Heyne, Maximilian wrote:
> From: Oleg Nesterov <oleg@redhat.com>
> 
> [ Upstream commit 7904e53ed5a20fc678c01d5d1b07ec486425bb6a ]
> 
> do/while_each_thread should be avoided when possible.
> 
> Link: https://lkml.kernel.org/r/20230909164501.GA11581@redhat.com
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Stable-dep-of: 7601df8031fd ("fs/proc: do_task_stat: use sig->stats_lock to gather the threads/children stats")
> Cc: stable@vger.kernel.org
> [mheyne: adjusted context]
> Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
> ---
> 
> Compile-tested only.
> We're seeing soft lock-ups with 5.10.237 because of the backport of
> commit 4fe85bdaabd6 ("fs/proc: do_task_stat: use sig->stats_lock to
> gather the threads/children stats").

And this fixes it?

How?

> 
> ---
>  fs/proc/array.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/proc/array.c b/fs/proc/array.c
> index 8fba6d39e776..77b94c04e4af 100644
> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c
> @@ -512,18 +512,18 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
>  		cgtime = sig->cgtime;
>  
>  		if (whole) {
> -			struct task_struct *t = task;
> +			struct task_struct *t;
>  
>  			min_flt = sig->min_flt;
>  			maj_flt = sig->maj_flt;
>  			gtime = sig->gtime;
>  
>  			rcu_read_lock();
> -			do {
> +			__for_each_thread(sig, t) {
>  				min_flt += t->min_flt;
>  				maj_flt += t->maj_flt;
>  				gtime += task_gtime(t);
> -			} while_each_thread(task, t);
> +			}

Ideally, the code generated here should be identical as before, so why
is this change needed?

confused,

greg k-h

