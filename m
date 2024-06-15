Return-Path: <linux-fsdevel+bounces-21746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70151909601
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 06:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1284283674
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 04:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EE1F507;
	Sat, 15 Jun 2024 04:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1sGke49"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB3D8F70;
	Sat, 15 Jun 2024 04:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718426519; cv=none; b=K4i7e6nPbPmjGsRTGm/ITimdtmt28eSaLVepOpRYtH/FUS2FCsLq12bZao5IPS+N11gM2XKFZasJmXpgrlSEXl6ppvi00mGmcNV2bqHRtYNzQbdt70pz7ToCPP/ou2e4zxfsT2h8PPm+ICBMJKDT9xl2K52Te0QiJNfOO+ISkco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718426519; c=relaxed/simple;
	bh=UsW5f2mRaDwai/bK6ucBq8wXkpvVGTtyzCqYbvt2ku4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gE069Vk3UytyOGED6KJlBND+GQdikrBUWeWcYMVohIMQbCMALZlrEb5lJ+64As4Hrhuiz7nudOGo8yhJWNiM7qMfs7PQc9BPzYCU8DOZIpN//8id9yaIiH1Nc6NaT7bhagi2zFibOHMBiGXCMjgy+ZaRweA66ul6ChH+4IRqYaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1sGke49; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4217d808034so26962465e9.3;
        Fri, 14 Jun 2024 21:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718426516; x=1719031316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K2qrQhaKuq5qmeUje0aTpEyuTysZEWpi+WcIcMw+cck=;
        b=J1sGke49rQ6zn69ORFrg/m2HNWcYXR1ID1FqfJ2e1r8c9oWdZ0Yre8Y0mQv/AxbxRT
         sWxjjoChzUdohkfbdwMZKmu8xNXT7x6ejiVeamr/gfCaGsQ2IhQbLZ3YzNyTLEJCtpgY
         u30/09I5icX0wRtHo3x0pJEFmhOmtviYGUKFBTyV364xBnVcxtEClLYH3FB/tmqiAjyX
         6lDa/4Ts5XRlClOLZMerUW/95w1g6Ytw9RUubtj4G6MYXH/VJQNG72QOC2pS8Gp43egM
         lYx/l9jjWYtxPDS0zE25w/S1CGGitd+8ySeErwrgnvHH+DhLbxpENTuEtUhuuAYpd6he
         aj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718426516; x=1719031316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2qrQhaKuq5qmeUje0aTpEyuTysZEWpi+WcIcMw+cck=;
        b=ftw7pudM57ovEA80HuYrRAw5zQMkpyWjRCZt8fdr32g3h2FaTZrDqCkSVuhW8j7L0G
         UbsRZ6JcxHCHPOJI550565h65qeSLW+3vFE36yMqMXTAjiM+CHq8wxaIgDvvKqQMC0TK
         WJsRakqM9z9O4Xy7RnetEdOdJMBY5ptHKyJmgj7HA3TNNGd5aGZbD47LOa5Vfc7KEL66
         lfDJDldz5nnbe2ygWIvF0QsjIkDhesbMbm9hIfhtP55wujAEE/REbg9sI5daBsBijUT7
         QImsPgU/ahyfFe2uBd3ifAodrVHBS2t7qrbHyjk8qstfWjQIDVtu0K1N9I2Sp79Lq9F5
         BG+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW58Mg0xHgTkCATimI92ViDlubHiuQefGPUfGCiXEmYpTezu+9j2BlN8al3SLOATHu6w9eXZ/ZwmBUU4sD2W58nSWNHdRYHMBqy6/oAdb9Magj36ZYwu+4AxsCI5Ioul2CKs+rOYXN8tIH4hw==
X-Gm-Message-State: AOJu0Yx+6BV0NvvBoqfUmXOv7BRV9B+Ips7dA5PY2uaPCGh9VtpizADn
	pB0kUeJhb+X2lFG7wYLfKwrhfqobvaUxCaeJFwv9IADbkTOWPbM4
X-Google-Smtp-Source: AGHT+IHgajnB5XGD80al+ghVpMqGo0+Es5Vn6cIaMGlf7eeJLe2pwopKZwZdpZfQyrTDpFQuCOnUfw==
X-Received: by 2002:a05:600c:4ca9:b0:422:52c3:7fe0 with SMTP id 5b1f17b1804b1-4230482c1e9mr41320185e9.22.1718426515401;
        Fri, 14 Jun 2024 21:41:55 -0700 (PDT)
Received: from f (cst-prg-88-61.cust.vodafone.cz. [46.135.88.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f6320c21sm86927655e9.34.2024.06.14.21.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 21:41:54 -0700 (PDT)
Date: Sat, 15 Jun 2024 06:41:45 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Yu Ma <yu.ma@intel.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, tim.c.chen@linux.intel.com, 
	tim.c.chen@intel.com, pan.deng@intel.com, tianyou.li@intel.com
Subject: Re: [PATCH 3/3] fs/file.c: move sanity_check from alloc_fd() to
 put_unused_fd()
Message-ID: <fejwlhtbqifb5kvcmilqjqbojf3shfzoiwexc3ucmhhtgyfboy@dm4ddkwmpm5i>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240614163416.728752-4-yu.ma@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240614163416.728752-4-yu.ma@intel.com>

On Fri, Jun 14, 2024 at 12:34:16PM -0400, Yu Ma wrote:
> alloc_fd() has a sanity check inside to make sure the FILE object mapping to the

Total nitpick: FILE is the libc thing, I would refer to it as 'struct
file'. See below for the actual point.

> Combined with patch 1 and 2 in series, pts/blogbench-1.1.0 read improved by
> 32%, write improved by 15% on Intel ICX 160 cores configuration with v6.8-rc6.
> 
> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> Signed-off-by: Yu Ma <yu.ma@intel.com>
> ---
>  fs/file.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index a0e94a178c0b..59d62909e2e3 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -548,13 +548,6 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
>  	else
>  		__clear_close_on_exec(fd, fdt);
>  	error = fd;
> -#if 1
> -	/* Sanity check */
> -	if (rcu_access_pointer(fdt->fd[fd]) != NULL) {
> -		printk(KERN_WARNING "alloc_fd: slot %d not NULL!\n", fd);
> -		rcu_assign_pointer(fdt->fd[fd], NULL);
> -	}
> -#endif
>  

I was going to ask when was the last time anyone seen this fire and
suggest getting rid of it if enough time(tm) passed. Turns out it does
show up sometimes, latest result I found is 2017 vintage:
https://groups.google.com/g/syzkaller-bugs/c/jfQ7upCDf9s/m/RQjhDrZ7AQAJ

So you are moving this to another locked area, but one which does not
execute in the benchmark?

Patch 2/3 states 28% read and 14% write increase, this commit message
claims it goes up to 32% and 15% respectively -- pretty big. I presume
this has to do with bouncing a line containing the fd.

I would argue moving this check elsewhere is about as good as removing
it altogether, but that's for the vfs overlords to decide.

All that aside, looking at disasm of alloc_fd it is pretty clear there
is time to save, for example:

	if (unlikely(nr >= fdt->max_fds)) {
		if (fd >= end) {
			error = -EMFILE;
			goto out;
		}
		error = expand_files(fd, fd);
		if (error < 0)
			goto out;
		if (error)
			goto repeat;
	}

This elides 2 branches and a func call in the common case. Completely
untested, maybe has some brainfarts, feel free to take without credit
and further massage the routine.

Moreover my disasm shows that even looking for a bit results in
a func call(!) to _find_next_zero_bit -- someone(tm) should probably
massage it into another inline.

After the above massaging is done and if it turns out the check has to
stay, you can plausibly damage-control it with prefetch -- issue it
immediately after finding the fd number, before any other work.

All that said, by the above I'm confident there is still *some*
performance left on the table despite the lock.

>  out:
>  	spin_unlock(&files->file_lock);
> @@ -572,7 +565,7 @@ int get_unused_fd_flags(unsigned flags)
>  }
>  EXPORT_SYMBOL(get_unused_fd_flags);
>  
> -static void __put_unused_fd(struct files_struct *files, unsigned int fd)
> +static inline void __put_unused_fd(struct files_struct *files, unsigned int fd)
>  {
>  	struct fdtable *fdt = files_fdtable(files);
>  	__clear_open_fd(fd, fdt);
> @@ -583,7 +576,12 @@ static void __put_unused_fd(struct files_struct *files, unsigned int fd)
>  void put_unused_fd(unsigned int fd)
>  {
>  	struct files_struct *files = current->files;
> +	struct fdtable *fdt = files_fdtable(files);
>  	spin_lock(&files->file_lock);
> +	if (unlikely(rcu_access_pointer(fdt->fd[fd]))) {
> +		printk(KERN_WARNING "put_unused_fd: slot %d not NULL!\n", fd);
> +		rcu_assign_pointer(fdt->fd[fd], NULL);
> +	}
>  	__put_unused_fd(files, fd);
>  	spin_unlock(&files->file_lock);
>  }

