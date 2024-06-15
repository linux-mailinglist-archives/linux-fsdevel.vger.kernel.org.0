Return-Path: <linux-fsdevel+bounces-21747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F9D909617
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 07:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E4791F22E87
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 05:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF711094E;
	Sat, 15 Jun 2024 05:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDNSflcp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811014400;
	Sat, 15 Jun 2024 05:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718428092; cv=none; b=DnKEZBFH6pq4fEWTnZO8bdbtER5/3Hxkpc4vgaxoISzy98wvggnZDOlFoct68zjeY4SV8+gCMRjP+l5FX4FusFZ9+sHqEH5Dk3qBuNsv+zPxZAkai+zK+OhHfRgbTc03gCnWOdh+TMjHv9n6afuYciaHXFDIzbXiYmcJSnAKIpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718428092; c=relaxed/simple;
	bh=4CHdbMYVbdognB1/jW4tT/scq2Xp8Kos8RrmdHBYAGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8DOX2SENLedDDsGMhMDvVdWd3KZwxBgxIo8y8VfR0JNZlpM09IA71vLJUXnwbe+T5zsesqm9bwhcxZBrS788QZkWNegD3n9eMcEPy4yY+ucIQBGyKazGwW59aka8CogJtJbP1sWKHI52SJQOtc4a64megs01HO1M6qUbzajSYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDNSflcp; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e72224c395so26874811fa.3;
        Fri, 14 Jun 2024 22:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718428089; x=1719032889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qMK42kBNAfn/goA4zNg7M+q4KdNhr3DCK7lRsbRs6oA=;
        b=dDNSflcpkDjrUIxMu+p3pqP5slvFn4UvlETiyQxPauAnvhFuC39OV/n8npXkcHLs4S
         21iJEWxNZ+VJLar93vSXhAdvAg0x22flpshX99YTpVvTcm3ipbTKkTDqPrikudRzUE/x
         0/AK4oak1X367bnJPT5+xL2++PIiFOAcqpF4iRhBTNlYFSsIJnmyfsx1GymLlblqUZi5
         xHxm6sQtR0+3MV0wXhQnbHTcPGIUezck5+XXoanQvrCHTddCoXLzkYIoOY8zfjEbgGmD
         aklaOACadBerz5X7yakUUawqRom5Gveey4nfqiqGEWJbvJoF0Xk0wiXQUis4rZV1Oz92
         MRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718428089; x=1719032889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMK42kBNAfn/goA4zNg7M+q4KdNhr3DCK7lRsbRs6oA=;
        b=Qz61NlLLp1XnOMe54U0L3L7wjC5tV/WlxbilCsqRlLoMcu2gvp+PCl+27Ex1xm+YF7
         3SPTczkzROp4PrB4XBI9i68yuc5FsR9r1pHjgKHKBaBtIfeJQ6F8u4XOV8E1njWEmn3o
         Y5bFMDIweS4PH5vf6C0GzrMY2L0Qqhtp/SBFyX/p7k+hznWvb0Ornam/E0bo6B6PMPbV
         XzZqDYs+osPo2OntilFPP9J5UOJcV7qUG5z+aCQ0uwSMFxVaFZOCBKVClmCMhAdFHQwS
         5BNCngnkHIcCp0OS/n4wyhQ1wKDplH3RsWYi/5P2ssm74cqxrYddFqjZ6oGyBTylBgOA
         U+cw==
X-Forwarded-Encrypted: i=1; AJvYcCUZRKa0mAXHna+LCqwYAhaQs4bRprykzgB8uQdq95fVsWbNAAFwzbJNc8jy7wkgnD4MuXxhMXTijFMWqRjPPDonyv+8f69adFmqgLdWXbYwEeMe2HKirrTgD19zykZSqLqf1CAZiI7eGwNCow==
X-Gm-Message-State: AOJu0YyuIbLBs0sI2IHJyZPfgjoDUEBR3D95gbbqYa8Kwi1PgE8TBYEg
	owyXOEMLPOJ806NHqkekQWckfoQrq3LPsx066sA2dZi7jmGZn2lGxSU6mA==
X-Google-Smtp-Source: AGHT+IF3uR3AIbzNPYPMKlkUKamVCSnkf5R+ELu5AwTrxcdYut8UITRtzJap2kc2uM8GX8wfae+kGw==
X-Received: by 2002:a2e:8606:0:b0:2ec:22c0:66e6 with SMTP id 38308e7fff4ca-2ec22c0683emr1463661fa.7.1718428087270;
        Fri, 14 Jun 2024 22:08:07 -0700 (PDT)
Received: from f (cst-prg-88-61.cust.vodafone.cz. [46.135.88.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f6320c16sm84407835e9.38.2024.06.14.22.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 22:08:06 -0700 (PDT)
Date: Sat, 15 Jun 2024 07:07:56 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Yu Ma <yu.ma@intel.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, tim.c.chen@linux.intel.com, 
	tim.c.chen@intel.com, pan.deng@intel.com, tianyou.li@intel.com
Subject: Re: [PATCH 3/3] fs/file.c: move sanity_check from alloc_fd() to
 put_unused_fd()
Message-ID: <lzotoc5jwq4o4oij26tnzm5n2sqwqgw6ve2yr3vb4rz2mg4cee@iysfvyt77gkx>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240614163416.728752-4-yu.ma@intel.com>
 <fejwlhtbqifb5kvcmilqjqbojf3shfzoiwexc3ucmhhtgyfboy@dm4ddkwmpm5i>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fejwlhtbqifb5kvcmilqjqbojf3shfzoiwexc3ucmhhtgyfboy@dm4ddkwmpm5i>

On Sat, Jun 15, 2024 at 06:41:45AM +0200, Mateusz Guzik wrote:
> On Fri, Jun 14, 2024 at 12:34:16PM -0400, Yu Ma wrote:
> > alloc_fd() has a sanity check inside to make sure the FILE object mapping to the
> 
> Total nitpick: FILE is the libc thing, I would refer to it as 'struct
> file'. See below for the actual point.
> 
> > Combined with patch 1 and 2 in series, pts/blogbench-1.1.0 read improved by
> > 32%, write improved by 15% on Intel ICX 160 cores configuration with v6.8-rc6.
> > 
> > Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> > Signed-off-by: Yu Ma <yu.ma@intel.com>
> > ---
> >  fs/file.c | 14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)
> > 
> > diff --git a/fs/file.c b/fs/file.c
> > index a0e94a178c0b..59d62909e2e3 100644
> > --- a/fs/file.c
> > +++ b/fs/file.c
> > @@ -548,13 +548,6 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
> >  	else
> >  		__clear_close_on_exec(fd, fdt);
> >  	error = fd;
> > -#if 1
> > -	/* Sanity check */
> > -	if (rcu_access_pointer(fdt->fd[fd]) != NULL) {
> > -		printk(KERN_WARNING "alloc_fd: slot %d not NULL!\n", fd);
> > -		rcu_assign_pointer(fdt->fd[fd], NULL);
> > -	}
> > -#endif
> >  
> 
> I was going to ask when was the last time anyone seen this fire and
> suggest getting rid of it if enough time(tm) passed. Turns out it does
> show up sometimes, latest result I found is 2017 vintage:
> https://groups.google.com/g/syzkaller-bugs/c/jfQ7upCDf9s/m/RQjhDrZ7AQAJ
> 
> So you are moving this to another locked area, but one which does not
> execute in the benchmark?
> 
> Patch 2/3 states 28% read and 14% write increase, this commit message
> claims it goes up to 32% and 15% respectively -- pretty big. I presume
> this has to do with bouncing a line containing the fd.
> 
> I would argue moving this check elsewhere is about as good as removing
> it altogether, but that's for the vfs overlords to decide.
> 
> All that aside, looking at disasm of alloc_fd it is pretty clear there
> is time to save, for example:
> 
> 	if (unlikely(nr >= fdt->max_fds)) {
> 		if (fd >= end) {
> 			error = -EMFILE;
> 			goto out;
> 		}
> 		error = expand_files(fd, fd);
> 		if (error < 0)
> 			goto out;
> 		if (error)
> 			goto repeat;
> 	}
> 

Now that I wrote it I noticed the fd < end check has to be performed
regardless of max_fds -- someone could have changed rlimit to a lower
value after using a higher fd. But the main point stands: the call to
expand_files and associated error handling don't have to be there.

> This elides 2 branches and a func call in the common case. Completely
> untested, maybe has some brainfarts, feel free to take without credit
> and further massage the routine.
> 
> Moreover my disasm shows that even looking for a bit results in
> a func call(!) to _find_next_zero_bit -- someone(tm) should probably
> massage it into another inline.
> 
> After the above massaging is done and if it turns out the check has to
> stay, you can plausibly damage-control it with prefetch -- issue it
> immediately after finding the fd number, before any other work.
> 
> All that said, by the above I'm confident there is still *some*
> performance left on the table despite the lock.
> 
> >  out:
> >  	spin_unlock(&files->file_lock);
> > @@ -572,7 +565,7 @@ int get_unused_fd_flags(unsigned flags)
> >  }
> >  EXPORT_SYMBOL(get_unused_fd_flags);
> >  
> > -static void __put_unused_fd(struct files_struct *files, unsigned int fd)
> > +static inline void __put_unused_fd(struct files_struct *files, unsigned int fd)
> >  {
> >  	struct fdtable *fdt = files_fdtable(files);
> >  	__clear_open_fd(fd, fdt);
> > @@ -583,7 +576,12 @@ static void __put_unused_fd(struct files_struct *files, unsigned int fd)
> >  void put_unused_fd(unsigned int fd)
> >  {
> >  	struct files_struct *files = current->files;
> > +	struct fdtable *fdt = files_fdtable(files);
> >  	spin_lock(&files->file_lock);
> > +	if (unlikely(rcu_access_pointer(fdt->fd[fd]))) {
> > +		printk(KERN_WARNING "put_unused_fd: slot %d not NULL!\n", fd);
> > +		rcu_assign_pointer(fdt->fd[fd], NULL);
> > +	}
> >  	__put_unused_fd(files, fd);
> >  	spin_unlock(&files->file_lock);
> >  }

