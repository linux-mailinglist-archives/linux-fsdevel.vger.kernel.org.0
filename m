Return-Path: <linux-fsdevel+bounces-21679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4474F907DEE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 23:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5B14B23BE2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 21:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5317913FD66;
	Thu, 13 Jun 2024 21:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EMg5zEp0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E20A13541B;
	Thu, 13 Jun 2024 21:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718313277; cv=none; b=nAWDc/JpKo3O0iQpmo3f/JVeyQno3RUUPtoMYEDxuJ752qQCa+hRnZ2P/kW132a2KCrEnJ/Jt/DbN8/NzQMsmZWFYhQlmMhlKoGoucQFps/04TmyFCjwNbLvpNNOzD6+xbhz0gspQTrGALkIspPP2RUMZpJlzXJBScphlNnAVLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718313277; c=relaxed/simple;
	bh=4a2+5zIfwargPvYAlTmLGH6pFw0rZamk0P9b4EVRVsM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=J5qK+BHpvk/gEtqryvsEniQeH2DMXzjDGqdVN3KRwcRNo+449/wjJrKHs7bSXbV8AlwCfNkHdu0XY0+pXSrsO0Cfizrv5Ibd2OkYjaHmfara94UAz+BYb7WE4fncOem3BmVTsmiDMXKUmF2Rb8GFoMbjd+FLDypwH0yMjmzWB6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EMg5zEp0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E20C2BBFC;
	Thu, 13 Jun 2024 21:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718313277;
	bh=4a2+5zIfwargPvYAlTmLGH6pFw0rZamk0P9b4EVRVsM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EMg5zEp0mO+NhF6jvPGvPYkQn8Gd0u2aw4kR2cAYBNOQj5bRnNWwQM9CehUe95cZs
	 6Ig1y6VAXMhH/JYy3dPHM1EG0vGdCUoJaJs1tYAbb6NeSB3p4cP0PLop0SsGaGcGr6
	 fg74mWAVBAHGreHe41TJIWG8GiGZhlI1Nb5wr4hM=
Date: Thu, 13 Jun 2024 14:14:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: torvalds@linux-foundation.org, ebiederm@xmission.com,
 alexei.starovoitov@gmail.com, rostedt@goodmis.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 audit@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 05/10] mm/util: Fix possible race condition in
 kstrdup()
Message-Id: <20240613141435.fad09579c934dbb79a3086cc@linux-foundation.org>
In-Reply-To: <20240613023044.45873-6-laoar.shao@gmail.com>
References: <20240613023044.45873-1-laoar.shao@gmail.com>
	<20240613023044.45873-6-laoar.shao@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 10:30:39 +0800 Yafang Shao <laoar.shao@gmail.com> wrote:

> In kstrdup(), it is critical to ensure that the dest string is always
> NUL-terminated. However, potential race condidtion can occur between a
> writer and a reader.
> 
> Consider the following scenario involving task->comm:
> 
>     reader                    writer
> 
>   len = strlen(s) + 1;
>                              strlcpy(tsk->comm, buf, sizeof(tsk->comm));
>   memcpy(buf, s, len);
> 
> In this case, there is a race condition between the reader and the
> writer. The reader calculate the length of the string `s` based on the
> old value of task->comm. However, during the memcpy(), the string `s`
> might be updated by the writer to a new value of task->comm.
> 
> If the new task->comm is larger than the old one, the `buf` might not be
> NUL-terminated. This can lead to undefined behavior and potential
> security vulnerabilities.
> 
> Let's fix it by explicitly adding a NUL-terminator.

The concept sounds a little strange.  If some code takes a copy of a
string while some other code is altering it, yes, the result will be a
mess.  This is why get_task_comm() exists, and why it uses locking.

I get that "your copy is a mess" is less serious than "your string
isn't null-terminated" but still.  Whichever outcome we get, the
calling code is buggy and should be fixed.

Are there any other problematic scenarios we're defending against here?

>
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -60,8 +60,10 @@ char *kstrdup(const char *s, gfp_t gfp)
>  
>  	len = strlen(s) + 1;
>  	buf = kmalloc_track_caller(len, gfp);
> -	if (buf)
> +	if (buf) {
>  		memcpy(buf, s, len);
> +		buf[len - 1] = '\0';
> +	}
>  	return buf;
>  }

Now I'll start receiving patches to remove this again.  Let's have a
code comment please.

And kstrdup() is now looking awfully similar to kstrndup().  Perhaps
there's a way to reduce duplication?

