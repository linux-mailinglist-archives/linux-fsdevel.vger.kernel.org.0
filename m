Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 773C016975A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2020 12:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgBWLaa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Feb 2020 06:30:30 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50227 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgBWLaa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Feb 2020 06:30:30 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so6210879wmb.0;
        Sun, 23 Feb 2020 03:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6bqMQ6Q8pNpUWevMe3I2fQaUxze6ip4xI8Zg0jCRVFY=;
        b=PzabzD3RJRGWE71FAdfmLXTa3MR80htynajipe846I5/QEDB5Vb9X54dACcFhkLHQt
         NlcBF1lLBm+JSKY+BboOue0ZTC2I7hQiTUORe++WizJBR0qyv+8CsonjVR2VuFiWRpPL
         DX/dMl+d64PCZQUQtw9Qnryo13K70HSRqxDmaKbxQJOgm17jDERQSy9qxFdhhfqjOXZ2
         3Rz9LRVouecAYSjbe4CF8hMDBtzz8EUmGilINrTWW9qN3f4M2JjBZkx4PcvzD0TcV2/g
         R5lDfm0R/F+r9yqDxeGUM359a8wpruJ5tLT16gXMbm/DU8150QZ5QdWOSPWBrr7l6AqY
         6PNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6bqMQ6Q8pNpUWevMe3I2fQaUxze6ip4xI8Zg0jCRVFY=;
        b=c/cUwXI8xjrKAbQFQJO3yXl9c/dIDoLl/qrOfJpPwerk3yG+0TLqKWwL9RnuqndR+W
         DiNJqUE0+26/Z/N9X+vCOIBWsb7uyZkcWTOAABEmUjZiQgFW2LRNYir8Ff8ukVVZzBBF
         vLTyRNCdcRtC0KEF8ifTzE7OVIuxqYuZfwpcVKR8W0aXM9KEQn81BgJm2Cbb7vWicV2Z
         T3eZBmihjJ/QMtHpZHXfPWuNMM9w6SDQvQfVS1VH1ZpiwIQjPeWo9Gy1MT8Hk32xlTMd
         0hFbVoVcNstMNb+4QNoKv1Ayw6vkgu3l0KgSUzRjYNlRYkdFUgII0yPB2NWtN9FDSY9q
         43fw==
X-Gm-Message-State: APjAAAXp3TvpvSNOjeXrqmTUzMQtEse7v3FbVbAXz3iMxGgX81oo8KEZ
        6+bgL28XA/G0d+MvssBtYqNijNs=
X-Google-Smtp-Source: APXvYqxPw0VaSj2Lpsbn4NCOSK4+2vn65MuaG5UcoPoQq4zKGHbihaXwiRo4CEQhaKWgr1UdzAIahw==
X-Received: by 2002:a1c:2786:: with SMTP id n128mr15528583wmn.47.1582457427827;
        Sun, 23 Feb 2020 03:30:27 -0800 (PST)
Received: from avx2 ([46.53.251.128])
        by smtp.gmail.com with ESMTPSA id i2sm12656810wmb.28.2020.02.23.03.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 03:30:26 -0800 (PST)
Date:   Sun, 23 Feb 2020 14:30:24 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] proc: faster open/read/close with "permanent" files
Message-ID: <20200223113024.GA4941@avx2>
References: <20200222201539.GA22576@avx2>
 <7c30fd26941948fa1aedd1e73bdc2ebb8efec477.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7c30fd26941948fa1aedd1e73bdc2ebb8efec477.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 22, 2020 at 12:39:39PM -0800, Joe Perches wrote:
> On Sat, 2020-02-22 at 23:15 +0300, Alexey Dobriyan wrote:
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
> 
> Is this an actual expected use-case?

Yes.

> Is there some additional unnecessary memory consumption
> in the unscaled systems?

No, it's the opposite. Less memory usage for everyone and noticeable
performance improvement for contented case.

> >  static ssize_t proc_reg_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
> >  {
> >  	struct proc_dir_entry *pde = PDE(file_inode(file));
> >  	ssize_t rv = -EIO;
> > -	if (use_pde(pde)) {
> > -		typeof_member(struct proc_ops, proc_read) read;
> >  
> > -		read = pde->proc_ops->proc_read;
> > -		if (read)
> > -			rv = read(file, buf, count, ppos);
> > +	if (pde_is_permanent(pde)) {
> > +		return pde_read(pde, file, buf, count, ppos);
> > +	} else if (use_pde(pde)) {
> > +		rv = pde_read(pde, file, buf, count, ppos);
> >  		unuse_pde(pde);
> 
> Perhaps all the function call duplication could be minimized
> by using code without direct returns like:
> 
> 	rv = pde_read(pde, file, buf, count, pos);
> 	if (!pde_is_permanent(pde))
> 		unuse_pde(pde);
> 
> 	return rv;

Function call non-duplication is false goal.
Surprisingly it makes code bigger:

	$ ./scripts/bloat-o-meter ../vmlinux-000 ../obj/vmlinux
	add/remove: 0/0 grow/shrink: 1/0 up/down: 10/0 (10)
	Function                                     old     new   delta
	proc_reg_read                                108     118     +10

and worse too: "rv" is carried on stack through "unuse_pde" call.
