Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3FA1D7FD6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 19:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgERRQG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 13:16:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45064 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgERRQF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 13:16:05 -0400
Received: by mail-pf1-f194.google.com with SMTP id z26so5119893pfk.12;
        Mon, 18 May 2020 10:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oSxgBphvkiJdu6V2dtQBN/0DGb4vzo835la/M2fjiy8=;
        b=tshHZE1aMxmYZm7w2jyAWilxOJJw9JNrvWFgvWCZuK/RNkyhAFGlLRhN/h3dB0Eate
         Rvn7ARQ9ZYFGrYlKdpyMhgxkuT3JpExfGWfBbdoELtGquSWlhyzMylRJkOcui4VxiapH
         hhWAnzvLHSVg/bISyS3eKKD8MuxXr89oTY8xqfcX5KJmhgjkU4Xp5foNHYIhzCm+6RSU
         5mdHgINu+MXzkG6VioYMeZgtoCZF+svkfQ/bK9fzbSmYvOTWfY/sM4akI1dCc2TGdi1r
         O+GukjhC20FpCES+bTYARBgUIBbUQoFdCKJOFBYZ0SEIDf5pSe2ji/KtUfBOIoOH9MYA
         sBqQ==
X-Gm-Message-State: AOAM532gaQ/tQYwm9EaaAj6bns8mnIT1dc1qDFZAJfqErbF9RmSuc8jv
        OD6lcmUlnjHnYpwFVvU1JzU=
X-Google-Smtp-Source: ABdhPJyAshFHOjZ/KBTljVH5Y/wZaJfQQJBDG8ktwGBNfOC7BLDqNWjToZdGNvIsJHsELXZqITgg1g==
X-Received: by 2002:a65:62d6:: with SMTP id m22mr16290471pgv.314.1589822164760;
        Mon, 18 May 2020 10:16:04 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id h7sm3412336pgn.60.2020.05.18.10.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 10:16:03 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id DE896404B0; Mon, 18 May 2020 17:16:02 +0000 (UTC)
Date:   Mon, 18 May 2020 17:16:02 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     keescook@chromium.org, yzaikin@google.com, adobriyan@gmail.com,
        patrick.bellasi@arm.com, mingo@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, gregkh@linuxfoundation.org,
        Jisheng.Zhang@synaptics.com, bigeasy@linutronix.de,
        pmladek@suse.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        wangle6@huawei.com, alex.huangjianhui@huawei.com
Subject: Re: [PATCH v3 0/4] cleaning up the sysctls table (hung_task watchdog)
Message-ID: <20200518171602.GK11244@42.do-not-panic.com>
References: <1589774397-42485-1-git-send-email-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589774397-42485-1-git-send-email-nixiaoming@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 18, 2020 at 11:59:53AM +0800, Xiaoming Ni wrote:
> Kernel/sysctl.c contains more than 190 interface files, and there are a 
> large number of config macro controls. When modifying the sysctl 
> interface directly in kernel/sysctl.c, conflicts are very easy to occur.
> E.g: https://lkml.org/lkml/2020/5/10/413.

FWIW un the future please avoid using lkmk.org and instead use
https://lkml.kernel.org/r/<MESSAGE-ID> for references.

> Use register_sysctl() to register the sysctl interface to avoid
> merge conflicts when different features modify sysctl.c at the same time.
> 
> So consider cleaning up the sysctls table, details are in:
> 	https://kernelnewbies.org/KernelProjects/proc
> 	https://lkml.org/lkml/2020/5/13/990
> 
> The current patch set extracts register_sysctl_init and some sysctl_vals
> variables, and clears the interface of hung_task and watchdog in sysctl.c.
> 
> The current patch set is based on commit b9bbe6ed63b2b9 ("Linux 5.7-rc6"),
> which conflicts with the latest branch of linux-next:
> 	9b4caf6941fc41d ("kernel / hung_task.c: introduce sysctl to print
> all traces when a hung task is detected")
> 
> Should I modify to make patch based on the "linux-next" branch to avoid
> conflicts, or other branches?

If you can do that, that would be appreciated. I have a sysctl fs cleanup
stuff, so I can take your patches, and put my work ont op of yours and
then send this to Andrew once done.

  Luis
