Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50F438F60C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 01:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbhEXXFu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 May 2021 19:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhEXXFt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 May 2021 19:05:49 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF1AC06138E
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 May 2021 16:04:20 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id lz27so44241062ejb.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 May 2021 16:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uHnwU/8zVxK9/bfw4gLk9ClQH8SbH6WwTZFdoRwbAtE=;
        b=QQB024vhpmn4hq25e6Gkh0zhdrnh3KHdtxH6hg6RDKH7CnpR3mYJd6drz35kPPn+vq
         h6264Me+UgyGvlpwu30FVPeTMz+AEc12Q0M+XUT2JohzSMatCOapVMLXEXEiejzFf7ti
         ktfb2nZNhIlo275VOb2O2BOnbc3ySbclEou9yYwi6+PYR4gUlNFMkKIpexQj+R7biYK9
         xXDP+mzIofYbIEFKZVe3ZXLMSxK2QP8MWFHo5cfoJS3ZJay5Rqyq5UdBp1+zLKULS08J
         lwUq6hGqLZp80Ar+2xFbnq6NvtyQI7K0uQTTZPi/naCAAye6mC44N7eH6EQPj41saYzr
         cNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uHnwU/8zVxK9/bfw4gLk9ClQH8SbH6WwTZFdoRwbAtE=;
        b=nDxLG5QD+g14wHcNISxGgjF33gJSPooFQ1zHJgBOZzfPW86meAEdZEnhTXqiTrUBF2
         LHuw8K9rAo5nECM3/g45FHfz8P72CjgO482Iy21qSVSGVrqe1Sm7+67EwRzpBVXTVnf6
         RFOubVi936xk59rBlQ+FzR4u1xd+e8/1ve6kGj2vgubXAdmZo9zkaV1KGkJL+xUjestq
         tq8sEN7Fk08Pr/tVlQMCSB5Uv7L+PP9ufP7Ko1A0FRDCZgfa1eyRj75Lhs2nCnC91Cva
         itaN7p+WHJNtqb59j1sPUeeBo0tRidOwq7SnOlpKA4VPwm+TQEKY9WJZwy0zd4nV+TCL
         A1HA==
X-Gm-Message-State: AOAM5322AA3oOO6sao/08rjrb/SiBWmjFxs+7u1Qp0KarAoCOC52J2ML
        Yooc/yCeZRuG+JltpN8tLplZi3PO9rpBYn5lHO2zatopIA==
X-Google-Smtp-Source: ABdhPJzHdwSaxqdMgKRFDcoSWE+vBddUp/NzMoTBPda3nQNAVt0QAUQEdTUit8AXk9QB29Wy0DPtdDjKh5nmDnbZhoc=
X-Received: by 2002:a17:907:10d8:: with SMTP id rv24mr25356059ejb.542.1621897458726;
 Mon, 24 May 2021 16:04:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1621363275.git.rgb@redhat.com> <f5f1a4d8699613f8c02ce762807228c841c2e26f.1621363275.git.rgb@redhat.com>
 <20210520075842.vnbwbw6yffkybk6z@wittgenstein>
In-Reply-To: <20210520075842.vnbwbw6yffkybk6z@wittgenstein>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 24 May 2021 19:04:07 -0400
Message-ID: <CAHC9VhTyAFou=_Xu7ZSZSY+19Yii=hQ1NW1LPisk49Ot9wg7rg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] audit: add support for the openat2 syscall
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
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

On Thu, May 20, 2021 at 3:58 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> On Wed, May 19, 2021 at 04:00:21PM -0400, Richard Guy Briggs wrote:
> > The openat2(2) syscall was added in kernel v5.6 with commit fddb5d430ad9
> > ("open: introduce openat2(2) syscall")
> >
> > Add the openat2(2) syscall to the audit syscall classifier.
> >
> > Link: https://github.com/linux-audit/audit-kernel/issues/67
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > Link: https://lore.kernel.org/r/f5f1a4d8699613f8c02ce762807228c841c2e26f.1621363275.git.rgb@redhat.com
> > ---
> >  arch/alpha/kernel/audit.c           | 2 ++
> >  arch/ia64/kernel/audit.c            | 2 ++
> >  arch/parisc/kernel/audit.c          | 2 ++
> >  arch/parisc/kernel/compat_audit.c   | 2 ++
> >  arch/powerpc/kernel/audit.c         | 2 ++
> >  arch/powerpc/kernel/compat_audit.c  | 2 ++
> >  arch/s390/kernel/audit.c            | 2 ++
> >  arch/s390/kernel/compat_audit.c     | 2 ++
> >  arch/sparc/kernel/audit.c           | 2 ++
> >  arch/sparc/kernel/compat_audit.c    | 2 ++
> >  arch/x86/ia32/audit.c               | 2 ++
> >  arch/x86/kernel/audit_64.c          | 2 ++
> >  include/linux/auditsc_classmacros.h | 1 +
> >  kernel/auditsc.c                    | 3 +++
> >  lib/audit.c                         | 4 ++++
> >  lib/compat_audit.c                  | 4 ++++
> >  16 files changed, 36 insertions(+)

...

> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index d775ea16505b..3f59ab209dfd 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -76,6 +76,7 @@
> >  #include <linux/fsnotify_backend.h>
> >  #include <uapi/linux/limits.h>
> >  #include <uapi/linux/netfilter/nf_tables.h>
> > +#include <uapi/linux/openat2.h>
> >
> >  #include "audit.h"
> >
> > @@ -196,6 +197,8 @@ static int audit_match_perm(struct audit_context *ctx, int mask)
> >               return ((mask & AUDIT_PERM_WRITE) && ctx->argv[0] == SYS_BIND);
> >       case AUDITSC_EXECVE:
> >               return mask & AUDIT_PERM_EXEC;
> > +     case AUDITSC_OPENAT2:
> > +             return mask & ACC_MODE((u32)((struct open_how *)ctx->argv[2])->flags);
>
> That's a lot of dereferncing, casting and masking all at once. Maybe a
> small static inline helper would be good for the sake of legibility? Sm
> like:
>
> static inline u32 audit_openat2_acc(struct open_how *how, int mask)
> {
>         u32 flags = how->flags;
>         return mask & ACC_MODE(flags);
> }
>
> but not sure. Just seems more legible to me.
> Otherwise.

I'm on the fence about this.  I understand Christian's concern, but I
have a bit of hatred towards single caller functions like this.  Since
this function isn't really high-touch, and I don't expect that to
change in the near future, let's leave the casting mess as-is.

-- 
paul moore
www.paul-moore.com
