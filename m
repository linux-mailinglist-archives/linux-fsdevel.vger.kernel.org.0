Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFA816AE2D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2020 18:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgBXRz0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Feb 2020 12:55:26 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51320 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbgBXRzZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:55:25 -0500
Received: by mail-wm1-f66.google.com with SMTP id t23so237310wmi.1;
        Mon, 24 Feb 2020 09:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=98hkSdEFZYYm7ue/qKLU11DJOrIsjwH9kzLWsOMOGoQ=;
        b=Vwkro33JPZEjGumCkuOvUlXTzL/fDauJkqYW8YDyhgcyZDvc9+xMMcMOp48V0SqDew
         NtZUkEKblDHV8EvfvK5BMWroYkI+HmgUETvMBfgEvKXitmgQ7Q17y7t3jbtzZVMUfsVV
         2q+nx/5gFgfqeKXnYe26ES5rnCgKJ0zRS9NoP/lHphqkoWgjMOMf8N8/5ou/BHKyduSO
         EXsoKJqN/LfLHO2l/qdzEDlohe3shxKYZ6B+aPP0xIOdEclw/+Y1DRRXEi7oX0dgIBAH
         zB3Xaxk8XQnRDP6nozRFtcBs+u9kZ/tEPdwEyTkYXbNnNHclyKJVgsX5VOyr8TkORgHs
         RPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=98hkSdEFZYYm7ue/qKLU11DJOrIsjwH9kzLWsOMOGoQ=;
        b=Y5IiOE4LLchXd85N0or0eR7qizY9Ym6foC5grB+tFOQ5WppPvQgXc1yNtbflfsRadZ
         8NXGvPkvqy4eMit0maJ6+lgWZZSiXVQd9T+mf19h5Y2SumtPsohInEhGlQgPLmCGcO5a
         jw6P5DAjekgxppebKpG+TlKQ5FFWELq+9M88Ce0T51n2oBVLwrE8WbxEoCPThOEI9tnF
         JN7MGb3BZVUr/a8CJqChDVxkiL3guoroTusAkOcDKFGPQLMUTxNpDQhRRlDzs2rznX3Z
         8lN1g+hjO3Urj7LxPc3MYAWBo2qDgciFQLTMly5wIZXSXWxIOd4saZXApX1bfjmuTC1H
         C1sQ==
X-Gm-Message-State: APjAAAXac9hzKJnSdhvaMShT4w2xern07MGB6Ziru916d8jiDEHV6Dy+
        LtPlDOb7oLDN1PsSeIZpea6amc8=
X-Google-Smtp-Source: APXvYqxm0NJVyiy1qW3kAmbakTqJFJUOQ0dfkTq8hktodIEO2WpsI8z91rO0JnAJZ5HXpylenvl3GA==
X-Received: by 2002:a1c:990b:: with SMTP id b11mr211208wme.15.1582566923445;
        Mon, 24 Feb 2020 09:55:23 -0800 (PST)
Received: from avx2 ([46.53.250.94])
        by smtp.gmail.com with ESMTPSA id s8sm20772193wrt.57.2020.02.24.09.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 09:55:22 -0800 (PST)
Date:   Mon, 24 Feb 2020 20:55:20 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] proc: faster open/read/close with "permanent" files
Message-ID: <20200224175520.GA3401@avx2>
References: <20200222201539.GA22576@avx2>
 <7c30fd26941948fa1aedd1e73bdc2ebb8efec477.camel@perches.com>
 <20200223113024.GA4941@avx2>
 <dc93d5299169a33e00fc35a4c5f29ea72764bce0.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dc93d5299169a33e00fc35a4c5f29ea72764bce0.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Feb 23, 2020 at 06:48:38PM -0800, Joe Perches wrote:
> On Sun, 2020-02-23 at 14:30 +0300, Alexey Dobriyan wrote:
> > On Sat, Feb 22, 2020 at 12:39:39PM -0800, Joe Perches wrote:
> > > On Sat, 2020-02-22 at 23:15 +0300, Alexey Dobriyan wrote:
> > > > Now that "struct proc_ops" exist we can start putting there stuff which
> > > > could not fly with VFS "struct file_operations"...
> > > > 
> > > > Most of fs/proc/inode.c file is dedicated to make open/read/.../close reliable
> > > > in the event of disappearing /proc entries which usually happens if module is
> > > > getting removed. Files like /proc/cpuinfo which never disappear simply do not
> > > > need such protection.
> > > > 
> > > > Save 2 atomic ops, 1 allocation, 1 free per open/read/close sequence for such
> > > > "permanent" files.
> > > > 
> > > > Enable "permanent" flag for
> > > > 
> > > > 	/proc/cpuinfo
> > > > 	/proc/kmsg
> > > > 	/proc/modules
> > > > 	/proc/slabinfo
> > > > 	/proc/stat
> > > > 	/proc/sysvipc/*
> > > > 	/proc/swaps
> > > > 
> > > > More will come once I figure out foolproof way to prevent out module
> > > > authors from marking their stuff "permanent" for performance reasons
> > > > when it is not.
> > > > 
> > > > This should help with scalability: benchmark is "read /proc/cpuinfo R times
> > > > by N threads scattered over the system".
> > > 
> > > Is this an actual expected use-case?
> > 
> > Yes.
> > 
> > > Is there some additional unnecessary memory consumption
> > > in the unscaled systems?
> > 
> > No, it's the opposite. Less memory usage for everyone and noticeable
> > performance improvement for contented case.
> > 
> > > >  static ssize_t proc_reg_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
> > > >  {
> > > >  	struct proc_dir_entry *pde = PDE(file_inode(file));
> > > >  	ssize_t rv = -EIO;
> > > > -	if (use_pde(pde)) {
> > > > -		typeof_member(struct proc_ops, proc_read) read;
> > > >  
> > > > -		read = pde->proc_ops->proc_read;
> > > > -		if (read)
> > > > -			rv = read(file, buf, count, ppos);
> > > > +	if (pde_is_permanent(pde)) {
> > > > +		return pde_read(pde, file, buf, count, ppos);
> > > > +	} else if (use_pde(pde)) {
> > > > +		rv = pde_read(pde, file, buf, count, ppos);
> > > >  		unuse_pde(pde);
> > > 
> > > Perhaps all the function call duplication could be minimized
> > > by using code without direct returns like:
> > > 
> > > 	rv = pde_read(pde, file, buf, count, pos);
> > > 	if (!pde_is_permanent(pde))
> > > 		unuse_pde(pde);
> > > 
> > > 	return rv;
> > 
> > Function call non-duplication is false goal.
> 
> Depends, copy/paste errors are common and object code
> size generally increases.
> 
> > Surprisingly it makes code bigger:
> 
> Not so far as I can tell.  Are you sure?
> 
> > 	$ ./scripts/bloat-o-meter ../vmlinux-000 ../obj/vmlinux
> > 	add/remove: 0/0 grow/shrink: 1/0 up/down: 10/0 (10)
> > 	Function                                     old     new   delta
> > 	proc_reg_read                                108     118     +10
> > 
> > and worse too: "rv" is carried on stack through "unuse_pde" call.
> 
> With gcc 9.2.1 x86-64 defconfig:
> 
> Changing just proc_reg_read to:
> 
> static ssize_t proc_reg_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
> {
> 	struct proc_dir_entry *pde = PDE(file_inode(file));
> 	ssize_t rv;
> 
> 	rv = pde_read(pde, file, buf, count, ppos);
> 	if (use_pde(pde))
> 		unuse_pde(pde);

What?

Please make non-racy patch before doing anything.

> 
> 	return rv;
> }
