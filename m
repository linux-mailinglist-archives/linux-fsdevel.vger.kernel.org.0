Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D443516584D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 08:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgBTHNF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 02:13:05 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35135 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbgBTHNF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 02:13:05 -0500
Received: by mail-wm1-f65.google.com with SMTP id b17so821939wmb.0;
        Wed, 19 Feb 2020 23:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LuLRB0u6LFeZT0zz7S0KLItdb3h9B9LHeKzaA+xlLl4=;
        b=VJ2E3Ck0HxAKFJb/f98BRyx6TcvSrX9cwOn823sTbKvE0GaRYST7Q/uO9Z5o3OiW2u
         uEZmroJKXSe60CTELjJD1gn0Uw6PQgQZucjVGXpozlJRe1MNPnQlrrpW0zGfNmf8BBTz
         1ijyPnacJI7lf/qnHMBdZPlE/siW9GHXzbK9idcncXz28EO+fNgOqYXgQUIxGT/Af1z8
         v02odj5iB0AHYxwbVOjoHiK9D184z5Dw9q8hBZQqgHw3up/nNLRYCC+9gaUzkmew64u4
         TKjMmsgxI1qah8xBM+VBSpKu4ixdrtX+sJJsicXsKo8nxladk39qeMqk1aI40gc4JFDt
         pKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LuLRB0u6LFeZT0zz7S0KLItdb3h9B9LHeKzaA+xlLl4=;
        b=mTjXx2spYainNdk6R9I9uZu1e3USPhDFF9kUmzaMaz6HWXTPRRuX0AXBAzHRmIuYo+
         jG4s00sIelN3voxK7YtTphqq6nNiaNPLThAA4JG4Cue7Hf/KO8arZPK+gS5sa8LhWWp0
         Sv/c+yKd2fxfqsDXAG7pmELdwtL1tj+OmrKBsvI+D78h9RXAVwD3TSMh7BXMo4tizY+F
         eEPp129O+SzGMjTpd80VjMNI+ne/vXmFmp+/CqdhWmV13mnL2VH1OwYRZRymvT+FeErW
         iQKoVLpkp2mfozb6v1ZerjOn9AZ+8Uez9yEI+GGfsNR/JQhPDfOrQrlfP3rvZNSPcrIY
         WT+A==
X-Gm-Message-State: APjAAAUFD/YVd18q4yO5DDgi9NeVgcoB6rxDRgcgT6HdBtTl8qOPcyg+
        rNBVw4qNTT/R+3Um2bCsGxc1J7E=
X-Google-Smtp-Source: APXvYqzbH1S0yZWti5zzw/ngfwtODbeK1Fjd48qTM4U4kVKC6R+/mMZNtC/AbAKSpTFmy/H1XvFw0A==
X-Received: by 2002:a7b:c8c5:: with SMTP id f5mr2518130wml.44.1582182783589;
        Wed, 19 Feb 2020 23:13:03 -0800 (PST)
Received: from avx2 ([46.53.248.148])
        by smtp.gmail.com with ESMTPSA id r1sm3061979wrx.11.2020.02.19.23.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 23:13:02 -0800 (PST)
Date:   Thu, 20 Feb 2020 10:13:00 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] proc: faster open/read/close with "permanent" files
Message-ID: <20200220071300.GA2188@avx2>
References: <20200219191127.GA15115@avx2>
 <20200219130600.3cb5cd65fbd696fe43fb7adc@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200219130600.3cb5cd65fbd696fe43fb7adc@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 19, 2020 at 01:06:00PM -0800, Andrew Morton wrote:
> On Wed, 19 Feb 2020 22:11:27 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > Now that "struct proc_ops" exist we can start putting there stuff which
> > could not fly with VFS "struct file_operations"...
> > 
> > Most of fs/proc/inode.c file is dedicated to make open/read/.../close reliable
> > in the event of disappearing /proc entries which usually happens if module is
> > getting removed. Files like /proc/cpuinfo which never disappear simply do not
> > need such protection.
> > 
> > Save 2 atomic ops, 1 allocation, 1 free per open/read/close sequence for such
> > "permanent" files.
> > 
> > Enable "permanent" flag for
> > 
> > 	/proc/cpuinfo
> > 	/proc/kmsg
> > 	/proc/modules
> > 	/proc/slabinfo
> > 	/proc/stat
> > 	/proc/sysvipc/*
> > 	/proc/swaps
> > 
> > More will come once I figure out foolproof way to prevent out module
> > authors from marking their stuff "permanent" for performance reasons
> > when it is not.
> > 
> > This should help with scalability: benchmark is "read /proc/cpuinfo R times
> > by N threads scattered over the system".
> > 
> > 	N	R	t, s (before)	t, s (after)
> > 	-----------------------------------------------------
> > 	64	4096	1.582458	1.530502	-3.2%
> > 	256	4096	6.371926	6.125168	-3.9%
> > 	1024	4096	25.64888	24.47528	-4.6%
> 
> I guess that's significant.
> 
> > --- a/fs/proc/internal.h
> > +++ b/fs/proc/internal.h
> > @@ -61,6 +61,7 @@ struct proc_dir_entry {
> >  	struct rb_node subdir_node;
> >  	char *name;
> >  	umode_t mode;
> > +	u8 flags;
> 
> Add a comment describing what this is?
> 
> >  	u8 namelen;
> >  	char inline_name[];
> >  } __randomize_layout;
> >
> > ...
> >
> > @@ -12,7 +13,21 @@ struct proc_dir_entry;
> >  struct seq_file;
> >  struct seq_operations;
> >  
> > +enum {
> > +	/*
> > +	 * All /proc entries using this ->proc_ops instance are never removed.
> > +	 *
> > +	 * If in doubt, ignore this flag.
> > +	 */
> > +#ifdef MODULE
> > +	PROC_ENTRY_PERMANENT = 0U,
> > +#else
> > +	PROC_ENTRY_PERMANENT = 1U << 0,
> > +#endif
> > +};
> 
> That feels quite hacky.  Is it really needed?  Any module which uses
> this is simply buggy?

Without "#ifdef MODULE" -- yes, buggy.
> 
> Can we just leave this undefined if MODULE and break the build?

It is for the case when module is built-in, so module removal won't
happen.

This flag requires discipline. It says that all code working for proc
entry will never be unloaded and /proc entry itself will stay as well.

> >  struct proc_ops {
> > +	unsigned int proc_flags;
> >  	int	(*proc_open)(struct inode *, struct file *);
> >  	ssize_t	(*proc_read)(struct file *, char __user *, size_t, loff_t *);
> >  	ssize_t	(*proc_write)(struct file *, const char __user *, size_t, loff_t *);
> > @@ -25,7 +40,7 @@ struct proc_ops {
> >  #endif
> >  	int	(*proc_mmap)(struct file *, struct vm_area_struct *);
> >  	unsigned long (*proc_get_unmapped_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
> > -};
> > +} __randomize_layout;
> 
> Unchangelogged, unrelated?

No! Randomization kicks in if all members are pointers to functions,
so once a integer is added it is not randomised anymore.

Or so I've heard...

I'll resend with more comments.
