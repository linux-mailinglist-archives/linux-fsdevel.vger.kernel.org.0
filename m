Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B537F37AEAB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 20:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbhEKSvh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 May 2021 14:51:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50156 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231329AbhEKSvg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 May 2021 14:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620759029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3sGuDkwY1rpAMVCQJVmhxPq9zjMod4hGpJJ6eXBTmJw=;
        b=hQY2U/sdJZgnKD/aZ40Y1bjPAwj3Rg8Nl6veQT+vSESgSs2BmfCHcMtOHEJnP1AvIIr8gg
        i+zcc7YB6+lRqSAMqlHsW0ss/P+FSpK6CtIOnNZCccGkxSgTuDDWfeZVuQPp2snugIFc/P
        5sAyNf173JzEocFSfwUqXRWiLpTrWzQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-wJc_w8FvMFOfP0IN4Jn3vw-1; Tue, 11 May 2021 14:50:26 -0400
X-MC-Unique: wJc_w8FvMFOfP0IN4Jn3vw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BF5B8015DB;
        Tue, 11 May 2021 18:50:24 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.3.128.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 525D42C14A;
        Tue, 11 May 2021 18:50:13 +0000 (UTC)
Date:   Tue, 11 May 2021 14:50:11 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
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
Subject: Re: [PATCH v3 1/3] audit: replace magic audit syscall class numbers
 with macros
Message-ID: <20210511185011.GP3141668@madcap2.tricolour.ca>
References: <cover.1619811762.git.rgb@redhat.com>
 <bda073f2a8b11000ef40cf8b965305409ee88f44.1619811762.git.rgb@redhat.com>
 <CAHC9VhShi4u26h5OsahveQDNxO_uZ+KgzGOYEp5W7w6foA-uKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhShi4u26h5OsahveQDNxO_uZ+KgzGOYEp5W7w6foA-uKg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-05-10 21:23, Paul Moore wrote:
> On Fri, Apr 30, 2021 at 4:36 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> >
> > Replace audit syscall class magic numbers with macros.
> >
> > This required putting the macros into new header file
> > include/linux/auditscm.h since the syscall macros were included for both 64
> > bit and 32 bit in any compat code, causing redefinition warnings.
> 
> The ifndef/define didn't protect against redeclaration?  Huh.  Maybe
> I'm not thinking about this correctly, or the arch specific code is
> doing something wonky ...

I had a chat with Arnd about it in IRC upstream and started digging
deeper and it got quite messy.  As seen from the cover letter, audit.h
pulled in a chain of things which weren't entirely unreasonable given it
was compiling compat support in with native support by default.  I
suppose I could have defined _ASM_X86_UNISTD_64_H to prevent it from
being added, but that would be ugly on a generated file, have caused a
failure elsewhere and would need to be done for each compat file.  I
thought of defining CONFIG_X86_32 in arch/x86/ia32/audit.c but that
would cause other problems.  This was the cleanest solution.  Otherwise
I leave them as magic numbers like in V1.

> Regardless, assuming that it is necessary, I would prefer if we called
> it auditsc.h instead of auditscm.h; the latter makes me think of
> sockets and not syscalls.
> 
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  MAINTAINERS                        |  1 +
> >  arch/alpha/kernel/audit.c          |  8 ++++----
> >  arch/ia64/kernel/audit.c           |  8 ++++----
> >  arch/parisc/kernel/audit.c         |  8 ++++----
> >  arch/parisc/kernel/compat_audit.c  |  9 +++++----
> >  arch/powerpc/kernel/audit.c        | 10 +++++-----
> >  arch/powerpc/kernel/compat_audit.c | 11 ++++++-----
> >  arch/s390/kernel/audit.c           | 10 +++++-----
> >  arch/s390/kernel/compat_audit.c    | 11 ++++++-----
> >  arch/sparc/kernel/audit.c          | 10 +++++-----
> >  arch/sparc/kernel/compat_audit.c   | 11 ++++++-----
> >  arch/x86/ia32/audit.c              | 11 ++++++-----
> >  arch/x86/kernel/audit_64.c         |  8 ++++----
> >  include/linux/audit.h              |  1 +
> >  include/linux/auditscm.h           | 23 +++++++++++++++++++++++
> >  kernel/auditsc.c                   | 12 ++++++------
> >  lib/audit.c                        | 10 +++++-----
> >  lib/compat_audit.c                 | 11 ++++++-----
> >  18 files changed, 102 insertions(+), 71 deletions(-)
> >  create mode 100644 include/linux/auditscm.h
> 
> ...
> 
> > diff --git a/include/linux/auditscm.h b/include/linux/auditscm.h
> > new file mode 100644
> > index 000000000000..1c4f0ead5931
> > --- /dev/null
> > +++ b/include/linux/auditscm.h
> > @@ -0,0 +1,23 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/* auditscm.h -- Auditing support syscall macros
> > + *
> > + * Copyright 2021 Red Hat Inc., Durham, North Carolina.
> > + * All Rights Reserved.
> > + *
> > + * Author: Richard Guy Briggs <rgb@redhat.com>
> > + */
> > +#ifndef _LINUX_AUDITSCM_H_
> > +#define _LINUX_AUDITSCM_H_
> > +
> > +enum auditsc_class_t {
> > +       AUDITSC_NATIVE = 0,
> > +       AUDITSC_COMPAT,
> > +       AUDITSC_OPEN,
> > +       AUDITSC_OPENAT,
> > +       AUDITSC_SOCKETCALL,
> > +       AUDITSC_EXECVE,
> > +
> > +       AUDITSC_NVALS /* count */
> > +};
> > +
> > +#endif
> 
> -- 
> paul moore
> www.paul-moore.com
> 

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

