Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC2B462508
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 23:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbhK2Wep (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 17:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbhK2WeJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:34:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FB6C21A270;
        Mon, 29 Nov 2021 12:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0YDfapNgCmOTH6GZNUQRejfSO4l0EFD3rYz0ioF3mfU=; b=bvW+kevoC2ztwjYU2acXSwjahi
        kGTKR/8Sl5ECSwNmsZEM5TQx+KDIxb0rnrJHMNExJpkdRbP/W4KB+HTR7sEFew5NuNkHe3NArNxqY
        nlXzugVmX6s6s//WkNc/9G2N5mtYwWkPX9s8f92K8a9RnWjxegh9ME+GS144d615Ub/89KmqlZw5i
        H3fdU9nQVQbwi7f9vpxJMFk56GbjbjxSx00UkW7KBJzWiRnuLuhDRGIULxiTfVaAWKdiO6By7VlTW
        COXj8AJKQgHYJcZ2GZETNqIhKVOOvldk4IYzuk6w5I2GxCy/+/831TfGmkqhj4Ri4rx4XfN2Tmm14
        bci/UywQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrnZh-002Ulu-IJ; Mon, 29 Nov 2021 20:48:33 +0000
Date:   Mon, 29 Nov 2021 12:48:33 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        yzaikin@google.com, nixiaoming@huawei.com, ebiederm@xmission.com,
        steve@sk2.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        tytso@mit.edu, viro@zeniv.linux.org.uk, senozhatsky@chromium.org,
        rostedt@goodmis.org, john.ogness@linutronix.de,
        dgilbert@interlog.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/8] printk: move printk sysctl to printk/sysctl.c
Message-ID: <YaU8oTPBiWTP/4Ll@bombadil.infradead.org>
References: <20211124231435.1445213-1-mcgrof@kernel.org>
 <20211124231435.1445213-6-mcgrof@kernel.org>
 <YaDYWhq8V8BHZbwm@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaDYWhq8V8BHZbwm@alley>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 26, 2021 at 01:51:38PM +0100, Petr Mladek wrote:
> On Wed 2021-11-24 15:14:32, Luis Chamberlain wrote:
> > From: Xiaoming Ni <nixiaoming@huawei.com>
> > 
> > The kernel/sysctl.c is a kitchen sink where everyone leaves
> > their dirty dishes, this makes it very difficult to maintain.
> > 
> > To help with this maintenance let's start by moving sysctls to
> > places where they actually belong. The proc sysctl maintainers
> > do not want to know what sysctl knobs you wish to add for your own
> > piece of code, we just care about the core logic.
> > 
> > So move printk sysctl from kernel/sysctl.c to kernel/printk/sysctl.c.
> > Use register_sysctl() to register the sysctl interface.
> > 
> > diff --git a/kernel/printk/Makefile b/kernel/printk/Makefile
> > index d118739874c0..f5b388e810b9 100644
> > --- a/kernel/printk/Makefile
> > +++ b/kernel/printk/Makefile
> > @@ -2,5 +2,8 @@
> >  obj-y	= printk.o
> >  obj-$(CONFIG_PRINTK)	+= printk_safe.o
> >  obj-$(CONFIG_A11Y_BRAILLE_CONSOLE)	+= braille.o
> > -obj-$(CONFIG_PRINTK)	+= printk_ringbuffer.o
> >  obj-$(CONFIG_PRINTK_INDEX)	+= index.o
> > +
> > +obj-$(CONFIG_PRINTK)                 += printk_support.o
> > +printk_support-y	             := printk_ringbuffer.o
> > +printk_support-$(CONFIG_SYSCTL)	     += sysctl.o
> 
> I have never seen this trick. It looks like a dirty hack ;-)

It has been used in mac80211 for over a decade now :) See
net/mac80211/Makefile

> Anyway, I do not see it described in the documentation. I wonder
> if it works only by chance.
> 
> IMHO, a cleaner solution would be to add the following
> into init/Kconfig:
> 
> config BUILD_PRINTK_SYSCTL
> 	bool
> 	default (PRINTK && SYSCTL)
> 
> and then use:
> 
> obj-$(CONFIG_BUILD_PRINTK_SYSCTL)    += sysctl.o

I suppose it is a matter of taste, either way works with me,
but I think less kconfig logic is better here.

> > diff --git a/kernel/printk/sysctl.c b/kernel/printk/sysctl.c
> > new file mode 100644
> > index 000000000000..653ae04aab7f
> > --- /dev/null
> > +++ b/kernel/printk/sysctl.c
> > @@ -0,0 +1,85 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * sysctl.c: General linux system control interface
> > + */
> > +
> > +#include <linux/sysctl.h>
> > +#include <linux/printk.h>
> > +#include <linux/capability.h>
> > +#include <linux/ratelimit.h>
> > +#include "internal.h"
> > +
> > +static const int ten_thousand = 10000;
> 
> The patch should also remove the variable in kernel/sysctl.c.
> 
> Otherwise, it looks like a really nice clean up.

Ah yes that variable is now unused there. Thanks

  Luis
