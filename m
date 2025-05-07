Return-Path: <linux-fsdevel+bounces-48338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 972C4AADBD8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 11:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 987B4983C1C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 09:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA9720D50B;
	Wed,  7 May 2025 09:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFclae51"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D948C204598;
	Wed,  7 May 2025 09:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746611341; cv=none; b=TpiBAnWCzBohRSGyv7+ifhWECya3ouQUvP/uRwj8pd8TEnoyO9VghAHZU5sJTLjHdn+ZTbyVnY11uNkvVBSIJA4m6YHBhsiZkJkDYEQd2d4SBlqEAPVfbqghkzcTSOgxwL3SI3xrcvZe8hwrqo5iSZefvUq5vLuGLW/ZKimsEQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746611341; c=relaxed/simple;
	bh=YmXb1IMXEepuEXY1v/CCA3dq2ySe0XpN7f3YZ8Yss+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DENZ0/MZC8W78sPTG6WOEsILQGEaTB7ov4rMRWjHT0Eo1nhg3Ykotyt5r/DAks+cRrYmMFrdCthLFCTL5V2zsUvneMVglJxDhpClwie6jzC3gDpFrcHwjuAEFiUjmfyDcizdYE7Nm4XY/iHEOFurR6UL6ICzdK2X/h509T+l+6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFclae51; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5f62d3ed994so6356464a12.2;
        Wed, 07 May 2025 02:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746611338; x=1747216138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GjQrORBe8uJy043H7EM7pumSsieyU41q9yu6GM4/Qx8=;
        b=WFclae51DsxRRCg4dHTqjYp1Jh1KVOmKzs+upCWFlQBojWg97VSq21zYkET2YA0hf9
         6iWtyTk2w2Fj6bTGCsSUNxc6sEk8Kqbv1Dh5Na4k0lhQ6/KS8ojTs/CT9wefBjqoL9oB
         cQfGBEIk5tt+rzeH3Fij4Dlj9UZO+KG0fg9RgMfRKQ/YcN1o8qIgFB2qMUV4ulYSYCD7
         zPct4+vWApr5S1KCavoRntarOdriStldD3MhFrNxXmEAeAOUKaBr9c0dsq338E4FpC9F
         sxkPoDmyGISVYIaJYRyQrpuumaG2nngqu2hgtbEf0jV771WL78aNEuqVeL+HNTpo9LM6
         128A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746611338; x=1747216138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjQrORBe8uJy043H7EM7pumSsieyU41q9yu6GM4/Qx8=;
        b=nLaKHiE2M8rPt8q26wLeWytPCyUCKAcP/+Bib0S+poQ+iKfoKLv5cFZkB9Rdkkw4+w
         CvpF34Ovr2doZVZDBoBxfRsAZOE6UsJk6bkqkHLdrbh5Nx8QD/KoYq2orEzAwi40o+3S
         rRk3ePNudklkGcwurV6l0wDzcZ3BEGVq526L3AUljbp5qx3wMKRcPNIDiwILAw6YBuht
         gjwgQ9R7tKE7zlcdt4sJ8m/dJLtzZFXzKPt4iwpLc168Lxs2FWvbA3mtWrKic6J1L38U
         90aIxo5Jx0H5mvTvGqTTMna5uIo2VQM191HwLVbP/B7t0opeFIHEbJRiFgWxFyV9D8YK
         zClQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWoUl6adwm62Z/GlOJExq5GhBKO0VhWi//IM9X+qkzsqDChFUbbf0KtmfHC6zf65IisHWhPoq/twHLMz8N@vger.kernel.org, AJvYcCVh7fr48mAI1IojSsyf3EFxF8lGChOnaCSKpzC91Yp0+PHSjpRreE3ZtcXT6kEUUhauFM2d3sbJwdK22P/h@vger.kernel.org
X-Gm-Message-State: AOJu0YwhMoCsFkd5O7q9Bv4JNzQtOmov5rmczSoNp4HqY8AM71z3+Ha7
	5/UFsygLL8R7lWJ1S7wn/QslCUddn9qURZzBwlK1vVcs1bnhZgw=
X-Gm-Gg: ASbGncvjp0VquFRU+LkNP2+pKfAobHUfeYCydLjzpQovW0IYkjGTGnlEdXQLi8RdKTg
	Fs30HB1h54zsHKSXMPABN2Kk8UJz0rPjpPKcaFlTsa4HQgeEdCw7+5wr2TbAxLC9NCR/ByAMb85
	FvF1vSvgAMoAobW5oh6Owa3bi0OlvD74McldqGfKAIi8pMwQH6Ib4q3dFJ+eZQBVHkVexXucVfc
	L/NbD2ClBek0xCi/UCjY+opPRpJeHa0RoQXkQ3IXWM0exM8bFOs2FSAoHWoJ8IKPHCPigLl0tVr
	K0vrPxHHWK7rKk09DOnTwEny9nJq
X-Google-Smtp-Source: AGHT+IFNQiuzv2ccreFN6wf270m0d+4UhXZh+bTbh4mLS/dbn5WcnhMVb30zvLQEk8fOB7lFhTL5Hg==
X-Received: by 2002:a05:6402:34c6:b0:5f8:5672:69cb with SMTP id 4fb4d7f45d1cf-5fbe9d8a6ecmr2278196a12.5.1746611337757;
        Wed, 07 May 2025 02:48:57 -0700 (PDT)
Received: from p183 ([46.53.254.183])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fa77755abcsm9154658a12.4.2025.05.07.02.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 02:48:56 -0700 (PDT)
Date: Wed, 7 May 2025 12:48:55 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: brauner@kernel.org, Mateusz Guzik <mjguzik@gmail.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: allow to mark /proc files permanent outside of
 fs/proc/
Message-ID: <3740e9db-3c15-42f5-a199-0a5d66f68c4f@p183>
References: <c58291cd-0775-4c90-8443-ba71897b5cbb@p183>
 <20250409143546.b3fecd04485b104657b8af25@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250409143546.b3fecd04485b104657b8af25@linux-foundation.org>

On Wed, Apr 09, 2025 at 02:35:46PM -0700, Andrew Morton wrote:
> On Wed, 9 Apr 2025 22:20:13 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > >From 06e2ff406942fef65b9c397a7f44478dd4b61451 Mon Sep 17 00:00:00 2001
> > From: Alexey Dobriyan <adobriyan@gmail.com>
> > Date: Sat, 5 Apr 2025 14:50:10 +0300
> > Subject: [PATCH 1/1] proc: allow to mark /proc files permanent outside of
> >  fs/proc/
> > 
> > From: Mateusz Guzik <mjguzik@gmail.com>
> > 
> > Add proc_make_permanent() function to mark PDE as permanent to speed up
> > open/read/close (one alloc/free and lock/unlock less).
> 
> When proposing a speedup it is preferable to provide some benchmarking
> results to help others understand the magnitude of that speedup.
> 
> > ...
> >
> > index 58b9067b2391..81dcd0ddadb6 100644
> > --- a/fs/filesystems.c
> > +++ b/fs/filesystems.c
> > @@ -252,7 +252,9 @@ static int filesystems_proc_show(struct seq_file *m, void *v)
> >  
> >  static int __init proc_filesystems_init(void)
> >  {
> > -	proc_create_single("filesystems", 0, NULL, filesystems_proc_show);
> > +	struct proc_dir_entry *pde =
> > +		proc_create_single("filesystems", 0, NULL, filesystems_proc_show);
> 
> To avoid the 80-column nasties, this is more pleasing:

It is inferior style, see below. BTW, how the kernel is still on 80 columns?

> 	struct proc_dir_entry *pde;
> 
> 	pde = proc_create_single("filesystems", 0, NULL, filesystems_proc_show);
> 
> 
> > +	proc_make_permanent(pde);
> >  	return 0;
> >  }
> >  module_init(proc_filesystems_init);
> > diff --git a/fs/proc/generic.c b/fs/proc/generic.c
> > index a3e22803cddf..0342600c0172 100644
> > --- a/fs/proc/generic.c
> > +++ b/fs/proc/generic.c
> > @@ -826,3 +826,15 @@ ssize_t proc_simple_write(struct file *f, const char __user *ubuf, size_t size,
> >  	kfree(buf);
> >  	return ret == 0 ? size : ret;
> >  }
> > +
> > +/*
> > + * Not exported to modules:
> > + * modules' /proc files aren't permanent because modules aren't permanent.
> > + */
> > +void impl_proc_make_permanent(struct proc_dir_entry *pde);
> 
> This declaration is unneeded, isn't it?

It is necessary, but I need to make a comment, yes.

> > +void impl_proc_make_permanent(struct proc_dir_entry *pde)
> > +{
> > +	if (pde) {
> > +		pde_make_permanent(pde);
> > +	}
> 
> Please let's be running checkpatch more often?

No! I'd rather change kernel coding style.

> > --- a/fs/proc/internal.h
> > +++ b/fs/proc/internal.h
> > @@ -80,8 +80,11 @@ static inline bool pde_is_permanent(const struct proc_dir_entry *pde)
> >  	return pde->flags & PROC_ENTRY_PERMANENT;
> >  }
> >  
> > +/* This is for builtin code, not even for modules which are compiled in. */
> >  static inline void pde_make_permanent(struct proc_dir_entry *pde)
> >  {
> > +	/* Ensure magic flag does something. */
> > +	static_assert(PROC_ENTRY_PERMANENT != 0);
> 
> Looks odd.  What is this doing?  The comment does a poor job of
> explaining this!
> 
> >  	pde->flags |= PROC_ENTRY_PERMANENT;
> >  }
> >  
> > diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
> > index ea62201c74c4..2d59f29b49eb 100644
> > --- a/include/linux/proc_fs.h
> > +++ b/include/linux/proc_fs.h
> > @@ -247,4 +247,14 @@ static inline struct pid_namespace *proc_pid_ns(struct super_block *sb)
> >  
> >  bool proc_ns_file(const struct file *file);
> >  
> > +static inline void proc_make_permanent(struct proc_dir_entry *pde)
> > +{
> > +	/* Don't give matches to modules. */
> 
> This comment is also mysterious (to me).  Please expand upon it.
> 
> > +#if defined CONFIG_PROC_FS && !defined MODULE
> > +	/* This mess is created by defining "struct proc_dir_entry" elsewhere. */
> 
> Also mysterious.
> 
> > +	void impl_proc_make_permanent(struct proc_dir_entry *pde);
> 
> Forward-declaring a function within a function in this manner is quite
> unusual.  Let's be conventional, please.
> 
> > +	impl_proc_make_permanent(pde);
> > +#endif
> > +}

This patch tries to create semi-exported interface which does nothing
if module built as module is using it it but does something it built-in or
module built-in does. This is why all complications and prorotypes.

But let me change coding style first.

