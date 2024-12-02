Return-Path: <linux-fsdevel+bounces-36281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 267C99E0C40
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 20:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E959C164782
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 19:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A521DE884;
	Mon,  2 Dec 2024 19:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m1kAwFG5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A671DE3BC
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Dec 2024 19:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733168277; cv=none; b=C6xVj8ZaazlBmASnxszVs8lXp+1xY3aJwsK2ZgiHWdzu5If1StTKuPHISPHNKKU+Fvun4mlv2B+rvfVfNEkuZjO2xv1M1hbmiAswe67yJZbpoWnRyj3M86BGltwj3egvFE9F5QPvwhRvRPw3zw8hzJJbhjbxh2MA+O6sTTGlNbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733168277; c=relaxed/simple;
	bh=urU8l7hS2hjxx98N6RF+l2GQdQildULOhr6xJZO1wSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KQtqZbrNeM0YfMKEO9j74YilZc3D+9zl7Y/+4HkkCPVQX/m6AKgfQPvP984NALU7IsgUITpDN4ddAaEiiyeFM1xJLPW/61QcS+yZScYFEj7AgkMUGTpE4iAb0otSeXOYEAxW/yYWOLrC/Ao6tUXP/EGUwmAZbqjg64e20vZ2SCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m1kAwFG5; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f956b566-e563-429f-93c0-3dd8f72d01e1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733168272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lGt+00bPobNwc0XtOQD6sLOGRVDmsCRpZT3fognjGQ0=;
	b=m1kAwFG5rMpEzMuuILh1U1iDtd+73INbopnF+MSZ+EZkIfsepl/7PKkoUe8G5+3KbFoIW5
	TTre9NEmo0xyb55boXGhsQ6jabXMLrY32DOXGbAViS1Ljorfy7ONvosS/nE0rqoz6Cyyqk
	BavdoEhXfmeuQ/XQ8UMNM5jXwQCgMQc=
Date: Mon, 2 Dec 2024 11:37:47 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: bpf_task_storage improvement question
To: Christian Brauner <brauner@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>,
 linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org
References: <qwinzohs4pwawth5i6g7hfb2376pyfmkurbo2rwvglv77asbkr@mq2goetrtmpu>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <qwinzohs4pwawth5i6g7hfb2376pyfmkurbo2rwvglv77asbkr@mq2goetrtmpu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/2/24 4:38 AM, Christian Brauner wrote:
> Hey,
> 
> I just had to take a quick look at kernel/bpf/bpf_task_storage.c and
> realized that you're doing:
> 
> 
> 	fd = *(int *)key;
> 	pid = pidfd_get_pid(fd, &f_flags);
> 
> 	// something something
> 
> 	task = pid_task(pid, PIDTYPE_PID);
> 
> 	bpf_task_storage_lock();
> 	// something something
> 	bpf_task_storage_unlock();
> 	put_pid(pid);
> 
> That reference count bump on struct pid seems unnecessary and I suspect
> your lookup routines are supposed to be fast. So why don't you just
> open-code this. Something like:
> 
> diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
> index bf7fa15fdcc6..dc36a33c7b6d 100644
> --- a/kernel/bpf/bpf_task_storage.c
> +++ b/kernel/bpf/bpf_task_storage.c
> @@ -92,10 +92,12 @@ static void *bpf_pid_task_storage_lookup_elem(struct bpf_map *map, void *key)
>          struct task_struct *task;
>          unsigned int f_flags;
>          struct pid *pid;
> -       int fd, err;
> 
> -       fd = *(int *)key;
> -       pid = pidfd_get_pid(fd, &f_flags);
> +       CLASS(fd, f)(*(int *)key);
> +       if (fd_empty(f))
> +               return -EBADF;
> +
> +       pid = pidfd_pid(f);
>          if (IS_ERR(pid))
>                  return ERR_CAST(pid);
> 
> @@ -104,19 +106,13 @@ static void *bpf_pid_task_storage_lookup_elem(struct bpf_map *map, void *key)
>           */
>          WARN_ON_ONCE(!rcu_read_lock_held());
>          task = pid_task(pid, PIDTYPE_PID);
> -       if (!task) {
> -               err = -ENOENT;
> -               goto out;
> -       }
> +       if (!task)
> +               return ERR_PTR(-ENOENT);
> 
>          bpf_task_storage_lock();
>          sdata = task_storage_lookup(task, map, true);
>          bpf_task_storage_unlock();
> -       put_pid(pid);
>          return sdata ? sdata->data : NULL;
> -out:
> -       put_pid(pid);
> -       return ERR_PTR(err);
>   }
> 
> which avoids the reference count bumps on @pid.
> It remains pinned by the pidfd anyway.

The "bpf_pid_task_storage_lookup_elem()" is used by the syscall path which may 
be less looked at. The bpf prog uses another function "__bpf_task_storage_get()" 
which directly has a task pointer.

The change makes sense to me. A nice improvement on the syscall path. It will be 
great if you can post a patch for it. Thanks.



