Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAF23A7187
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jun 2021 23:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbhFNVt2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Jun 2021 17:49:28 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:37436 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhFNVt1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Jun 2021 17:49:27 -0400
Received: by mail-pf1-f177.google.com with SMTP id y15so11634835pfl.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jun 2021 14:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=11qshP+zA6nV1VlKwOngkmrT97wBNjMb27p4nx9dPeQ=;
        b=LUq145VKrQEwE9rgjOGzpPz5r0oSlIPHk/zQwJklsmP/reLr2QhQxs4SzJknhYFcOG
         QTjaJq3N6SKt3n80XeAs0CwuOkqO4TC378gRzRviXjYGeymf9bYuq0R/ohCGLMe6y766
         fzykrtMGa4x7NDcNTbP8sn9RCya+ITsJtGozg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=11qshP+zA6nV1VlKwOngkmrT97wBNjMb27p4nx9dPeQ=;
        b=B+VvyoehWA/pVUXdUzmCJoW17OfFsJD/GgLMhOIfwCm0//SEtLxtpTeoyR+j+x9fWv
         GT5OWAfIc+/7Zdw2iQwWxH78gBC4pzHxe5iGyZkmQSjtMB4WDMSWyqrNSF+Hckj0zNPB
         sQgZF75VEHSG1qQi6dl7R7Xg5aMyAlMkjiB2qK3sdiuMw1TkMkCh5dlt1Lo2pp7aWv+b
         JCTdp54AewYoXY7IdV4Wuaxc5CtdzqI6qqCNOwYa6ePPYQwFtkkx08dHFsAFHJg+dPtJ
         uR8akytTdyAtEYA3Od3MdNEeFPkzDBGoghpzj99QXLAg/RxrUWFydA/pZJS2PB4xc84S
         81Gw==
X-Gm-Message-State: AOAM530uC+e+qewt2P/4dhK5t0NnfoHHi162RtXGpJeyvIhRUUdMWXr8
        CA31F7J9ixFw/aqSObwfBMZnRA==
X-Google-Smtp-Source: ABdhPJzKUWUtsQki9KiY6Yxrv339fbByTu4VTpxk9IVUZhA/8Q0tVs97sv/b2UkmGkORRB8NFg1eiQ==
X-Received: by 2002:a63:e0e:: with SMTP id d14mr18768633pgl.426.1623707184226;
        Mon, 14 Jun 2021 14:46:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id gd3sm380097pjb.39.2021.06.14.14.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 14:46:23 -0700 (PDT)
Date:   Mon, 14 Jun 2021 14:46:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        WeiXiong Liao <gmpy.liaowx@gmail.com>, axboe@kernel.dk,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] pstore/blk: Use the normal block device I/O path
Message-ID: <202106141436.294D1B2@keescook>
References: <20210614200421.2702002-1-keescook@chromium.org>
 <YMe3eoodEyT+r1oI@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMe3eoodEyT+r1oI@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 14, 2021 at 08:09:30PM +0000, Al Viro wrote:
> On Mon, Jun 14, 2021 at 01:04:21PM -0700, Kees Cook wrote:
>   
> >  static ssize_t psblk_generic_blk_write(const char *buf, size_t bytes,
> >  		loff_t pos)
> >  {
> 
> >  	/* Console/Ftrace backend may handle buffer until flush dirty zones */
> >  	if (in_interrupt() || irqs_disabled())
> >  		return -EBUSY;
> 
> > +	return kernel_write(psblk_file, buf, bytes, &pos);
> 
> In which locking environments could that be called?  The checks above
> look like that thing could be called from just about any context;
> could that happen when the caller is holding a page locked?

The contexts are determined by both each of the pstore "front ends":


PSTORE_FLAGS_DMESG:
static struct kmsg_dumper pstore_dumper = {
        .dump = pstore_dump,
...
kmsg_dump_register(&pstore_dumper);


PSTORE_FLAGS_CONSOLE:
static struct console pstore_console = {
        .write  = pstore_console_write,
...
register_console(&pstore_console);


PSTORE_FLAGS_FTRACE:
static struct ftrace_ops pstore_ftrace_ops __read_mostly = {
        .func   = pstore_ftrace_call,
...
register_ftrace_function(&pstore_ftrace_ops);


PSTORE_FLAGS_PMSG:
static const struct file_operations pmsg_fops = {
...
        .write          = write_pmsg,
...
pmsg_major = register_chrdev(0, PMSG_NAME, &pmsg_fops);


and each of the pstore "back ends". (ram, EFI vars, block, etc.)


> IOW, what are those checks really trying to do?

Traditionally, the most restrictive case is kmsg_dump, but that's the
whole point here of the "best effort" mode: if we can't safely make the
call and no panic handler has been registered, we must skip the call.

e.g. the RAM pstore backend has all its buffers preallocated, and it'll
just write directly into them. The handling here has gotten progressive
weirder, as more back ends landed -- i.e. EFI var writing added some
limits to the kind of locking pstore could do, etc.


It may turn out that the checks above aren't needed. I haven't tried it
without, but I suspect it's for the kmsg_dump case.

-Kees

-- 
Kees Cook
