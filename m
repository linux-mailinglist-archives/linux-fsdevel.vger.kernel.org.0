Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6B74165158
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 22:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgBSVGB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 16:06:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:38654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727809AbgBSVGB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 16:06:01 -0500
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6330207FD;
        Wed, 19 Feb 2020 21:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582146361;
        bh=rZ7SQ0o6VNfFZHTJDCbta5DKG6j09ditK/ObGdXt/q0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C8yWnPkbKINJuZlJAl2QRUNDti175Hh+LSN0aYGWStOc91VbH2gzdCcGmAFLif1R+
         9MVXqbcMmNv8hEzKKisZO7IRxeN0Q8mZSqyPoiN9rrsDLqXA1rMqrRpbIgJvU8LEyw
         oq+AlvbWnFXtMpts5Sv6ziYD6N8LHF+2TVGd99Ok=
Date:   Wed, 19 Feb 2020 13:06:00 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] proc: faster open/read/close with "permanent" files
Message-Id: <20200219130600.3cb5cd65fbd696fe43fb7adc@linux-foundation.org>
In-Reply-To: <20200219191127.GA15115@avx2>
References: <20200219191127.GA15115@avx2>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 19 Feb 2020 22:11:27 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:

> Now that "struct proc_ops" exist we can start putting there stuff which
> could not fly with VFS "struct file_operations"...
> 
> Most of fs/proc/inode.c file is dedicated to make open/read/.../close reliable
> in the event of disappearing /proc entries which usually happens if module is
> getting removed. Files like /proc/cpuinfo which never disappear simply do not
> need such protection.
> 
> Save 2 atomic ops, 1 allocation, 1 free per open/read/close sequence for such
> "permanent" files.
> 
> Enable "permanent" flag for
> 
> 	/proc/cpuinfo
> 	/proc/kmsg
> 	/proc/modules
> 	/proc/slabinfo
> 	/proc/stat
> 	/proc/sysvipc/*
> 	/proc/swaps
> 
> More will come once I figure out foolproof way to prevent out module
> authors from marking their stuff "permanent" for performance reasons
> when it is not.
> 
> This should help with scalability: benchmark is "read /proc/cpuinfo R times
> by N threads scattered over the system".
> 
> 	N	R	t, s (before)	t, s (after)
> 	-----------------------------------------------------
> 	64	4096	1.582458	1.530502	-3.2%
> 	256	4096	6.371926	6.125168	-3.9%
> 	1024	4096	25.64888	24.47528	-4.6%

I guess that's significant.

> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -61,6 +61,7 @@ struct proc_dir_entry {
>  	struct rb_node subdir_node;
>  	char *name;
>  	umode_t mode;
> +	u8 flags;

Add a comment describing what this is?

>  	u8 namelen;
>  	char inline_name[];
>  } __randomize_layout;
>
> ...
>
> --- a/include/linux/proc_fs.h
> +++ b/include/linux/proc_fs.h
> @@ -5,6 +5,7 @@
>  #ifndef _LINUX_PROC_FS_H
>  #define _LINUX_PROC_FS_H
>  
> +#include <linux/compiler.h>
>  #include <linux/types.h>
>  #include <linux/fs.h>
>  
> @@ -12,7 +13,21 @@ struct proc_dir_entry;
>  struct seq_file;
>  struct seq_operations;
>  
> +enum {
> +	/*
> +	 * All /proc entries using this ->proc_ops instance are never removed.
> +	 *
> +	 * If in doubt, ignore this flag.
> +	 */
> +#ifdef MODULE
> +	PROC_ENTRY_PERMANENT = 0U,
> +#else
> +	PROC_ENTRY_PERMANENT = 1U << 0,
> +#endif
> +};

That feels quite hacky.  Is it really needed?  Any module which uses
this is simply buggy?

Can we just leave this undefined if MODULE and break the build?

>  struct proc_ops {
> +	unsigned int proc_flags;
>  	int	(*proc_open)(struct inode *, struct file *);
>  	ssize_t	(*proc_read)(struct file *, char __user *, size_t, loff_t *);
>  	ssize_t	(*proc_write)(struct file *, const char __user *, size_t, loff_t *);
> @@ -25,7 +40,7 @@ struct proc_ops {
>  #endif
>  	int	(*proc_mmap)(struct file *, struct vm_area_struct *);
>  	unsigned long (*proc_get_unmapped_area)(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
> -};
> +} __randomize_layout;

Unchangelogged, unrelated?

>  #ifdef CONFIG_PROC_FS
>  

