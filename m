Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3407A45EE54
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 13:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377556AbhKZM46 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 07:56:58 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:37544 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhKZMy5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 07:54:57 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1CD4421923;
        Fri, 26 Nov 2021 12:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637931103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e25euTcFjXcEnjJeL5rhhdL+BDQb5ApvRRC+aPdAJRw=;
        b=hCoYmnA6nuV2mGUSWZdF49YoW6tNytYJstJU4nlq+YszBncKxf10/vAOJHnjkcwCHrBu+H
        Y3JjM89Y3oz0vR/8oB3Be4gr3CZuVDkLrtrGMdUjqLGnRoukWCYL2AvkEpUM4F6/3xJbAB
        wujPHo/56y11dlN1di+YDVdvZ4bcpXM=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EBEDBA3B83;
        Fri, 26 Nov 2021 12:51:41 +0000 (UTC)
Date:   Fri, 26 Nov 2021 13:51:38 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        yzaikin@google.com, nixiaoming@huawei.com, ebiederm@xmission.com,
        steve@sk2.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        tytso@mit.edu, viro@zeniv.linux.org.uk, senozhatsky@chromium.org,
        rostedt@goodmis.org, john.ogness@linutronix.de,
        dgilbert@interlog.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, mcgrof@bombadil.infradead.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/8] printk: move printk sysctl to printk/sysctl.c
Message-ID: <YaDYWhq8V8BHZbwm@alley>
References: <20211124231435.1445213-1-mcgrof@kernel.org>
 <20211124231435.1445213-6-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124231435.1445213-6-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 2021-11-24 15:14:32, Luis Chamberlain wrote:
> From: Xiaoming Ni <nixiaoming@huawei.com>
> 
> The kernel/sysctl.c is a kitchen sink where everyone leaves
> their dirty dishes, this makes it very difficult to maintain.
> 
> To help with this maintenance let's start by moving sysctls to
> places where they actually belong. The proc sysctl maintainers
> do not want to know what sysctl knobs you wish to add for your own
> piece of code, we just care about the core logic.
> 
> So move printk sysctl from kernel/sysctl.c to kernel/printk/sysctl.c.
> Use register_sysctl() to register the sysctl interface.
> 
> diff --git a/kernel/printk/Makefile b/kernel/printk/Makefile
> index d118739874c0..f5b388e810b9 100644
> --- a/kernel/printk/Makefile
> +++ b/kernel/printk/Makefile
> @@ -2,5 +2,8 @@
>  obj-y	= printk.o
>  obj-$(CONFIG_PRINTK)	+= printk_safe.o
>  obj-$(CONFIG_A11Y_BRAILLE_CONSOLE)	+= braille.o
> -obj-$(CONFIG_PRINTK)	+= printk_ringbuffer.o
>  obj-$(CONFIG_PRINTK_INDEX)	+= index.o
> +
> +obj-$(CONFIG_PRINTK)                 += printk_support.o
> +printk_support-y	             := printk_ringbuffer.o
> +printk_support-$(CONFIG_SYSCTL)	     += sysctl.o

I have never seen this trick. It looks like a dirty hack ;-)
Anyway, I do not see it described in the documentation. I wonder
if it works only by chance.

IMHO, a cleaner solution would be to add the following
into init/Kconfig:

config BUILD_PRINTK_SYSCTL
	bool
	default (PRINTK && SYSCTL)

and then use:

obj-$(CONFIG_BUILD_PRINTK_SYSCTL)    += sysctl.o


> diff --git a/kernel/printk/sysctl.c b/kernel/printk/sysctl.c
> new file mode 100644
> index 000000000000..653ae04aab7f
> --- /dev/null
> +++ b/kernel/printk/sysctl.c
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * sysctl.c: General linux system control interface
> + */
> +
> +#include <linux/sysctl.h>
> +#include <linux/printk.h>
> +#include <linux/capability.h>
> +#include <linux/ratelimit.h>
> +#include "internal.h"
> +
> +static const int ten_thousand = 10000;

The patch should also remove the variable in kernel/sysctl.c.

Otherwise, it looks like a really nice clean up.

Best Regards,
Petr
