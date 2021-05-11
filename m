Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C43379BFF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 03:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhEKBZO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 21:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbhEKBZN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 21:25:13 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61C0C06175F
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 May 2021 18:24:06 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id m12so27309073eja.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 May 2021 18:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=syt/rTNKKQ17UGCB3Uu0pF3Y4fSaa3SrmtO2mz6CWnE=;
        b=wnnDBP50YuTDmWGzNOFnPcs4wQToxwsCwGRBEFgx7dTWtco22s8x+zEZSiwuwWfbpM
         cWdw31wnr1boOC7AEos2jrrH4bGAuhpsYL+GtY+HbrHfNNFIkCQ2XoXiTKi6ysk/a0LM
         KwLh5IIRlLP0O+kiTEPwwX6SP6ff2YJqRmgF9axUO6GoHRWhDwBuHrmuAHL/1AQB00za
         Z5ya4HUeA76Q7yyS/rcQO9PZfeIpKFiUmrvL2D2pFYuw1ACepDvAm2QaZ/4I+ELpE5vp
         C6rfPiox76AXXt/Rb/GJows7NCWjIsCS6N3qaxUYY1LJERzpfb4IjwoLyxWMlP5agPFI
         AE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=syt/rTNKKQ17UGCB3Uu0pF3Y4fSaa3SrmtO2mz6CWnE=;
        b=WEAM48tnEJaNaO86d32YGLm+K4XTM3kbPFEcalf7ovJeD+wj/C01DSJluwb2wBQxxl
         XP8jrLuJxlPeN9Jo+CJzA7OWxECyWkIUR4QGh+SeEjC7XHxyvThXlFYYnyoT3ZaVyRfr
         aoyD1CN8NpUGeyhS0BqVHlqICc3T8not6AdN6eDdvyu3MUFXgEW2XIrvN/olYEAtgxxr
         2tMKbkVw5cdKAVQMraKFgaMZ5eBWP4gSfAfLnFKXF9kQwO2xFRDSkd1jSjDae8ku9/u1
         VBjC9wBblKtazAxkYhkluIflGLJ6NkWH3915nXIj4qjx4B+DfafBhll/kDuhkyMAVVW/
         paUA==
X-Gm-Message-State: AOAM530fWhpytD7N0z5/ja2Po2iAk04750AAKtHeZNLalJGeV8dtN7DG
        bxtF07Gt+0HrIisTqfcw7qfBkccmlWKrzlWQWbhf
X-Google-Smtp-Source: ABdhPJyW4MiZ3N1+ZHg7+YNdb0vgiQkf7+SPMSk21X8mfUycEAtJWf5nTYhrqBDtALuDjNQQeKXN/Vj76oxO0MuWUxs=
X-Received: by 2002:a17:907:10d8:: with SMTP id rv24mr28569992ejb.542.1620696245333;
 Mon, 10 May 2021 18:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1619811762.git.rgb@redhat.com> <bda073f2a8b11000ef40cf8b965305409ee88f44.1619811762.git.rgb@redhat.com>
In-Reply-To: <bda073f2a8b11000ef40cf8b965305409ee88f44.1619811762.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 10 May 2021 21:23:54 -0400
Message-ID: <CAHC9VhShi4u26h5OsahveQDNxO_uZ+KgzGOYEp5W7w6foA-uKg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] audit: replace magic audit syscall class numbers
 with macros
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Paris <eparis@redhat.com>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>,
        Arnd Bergmann <arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 30, 2021 at 4:36 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Replace audit syscall class magic numbers with macros.
>
> This required putting the macros into new header file
> include/linux/auditscm.h since the syscall macros were included for both 64
> bit and 32 bit in any compat code, causing redefinition warnings.

The ifndef/define didn't protect against redeclaration?  Huh.  Maybe
I'm not thinking about this correctly, or the arch specific code is
doing something wonky ...

Regardless, assuming that it is necessary, I would prefer if we called
it auditsc.h instead of auditscm.h; the latter makes me think of
sockets and not syscalls.

> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  MAINTAINERS                        |  1 +
>  arch/alpha/kernel/audit.c          |  8 ++++----
>  arch/ia64/kernel/audit.c           |  8 ++++----
>  arch/parisc/kernel/audit.c         |  8 ++++----
>  arch/parisc/kernel/compat_audit.c  |  9 +++++----
>  arch/powerpc/kernel/audit.c        | 10 +++++-----
>  arch/powerpc/kernel/compat_audit.c | 11 ++++++-----
>  arch/s390/kernel/audit.c           | 10 +++++-----
>  arch/s390/kernel/compat_audit.c    | 11 ++++++-----
>  arch/sparc/kernel/audit.c          | 10 +++++-----
>  arch/sparc/kernel/compat_audit.c   | 11 ++++++-----
>  arch/x86/ia32/audit.c              | 11 ++++++-----
>  arch/x86/kernel/audit_64.c         |  8 ++++----
>  include/linux/audit.h              |  1 +
>  include/linux/auditscm.h           | 23 +++++++++++++++++++++++
>  kernel/auditsc.c                   | 12 ++++++------
>  lib/audit.c                        | 10 +++++-----
>  lib/compat_audit.c                 | 11 ++++++-----
>  18 files changed, 102 insertions(+), 71 deletions(-)
>  create mode 100644 include/linux/auditscm.h

...

> diff --git a/include/linux/auditscm.h b/include/linux/auditscm.h
> new file mode 100644
> index 000000000000..1c4f0ead5931
> --- /dev/null
> +++ b/include/linux/auditscm.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/* auditscm.h -- Auditing support syscall macros
> + *
> + * Copyright 2021 Red Hat Inc., Durham, North Carolina.
> + * All Rights Reserved.
> + *
> + * Author: Richard Guy Briggs <rgb@redhat.com>
> + */
> +#ifndef _LINUX_AUDITSCM_H_
> +#define _LINUX_AUDITSCM_H_
> +
> +enum auditsc_class_t {
> +       AUDITSC_NATIVE = 0,
> +       AUDITSC_COMPAT,
> +       AUDITSC_OPEN,
> +       AUDITSC_OPENAT,
> +       AUDITSC_SOCKETCALL,
> +       AUDITSC_EXECVE,
> +
> +       AUDITSC_NVALS /* count */
> +};
> +
> +#endif

-- 
paul moore
www.paul-moore.com
