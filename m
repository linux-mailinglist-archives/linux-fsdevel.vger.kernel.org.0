Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453C034052E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 13:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhCRMIq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 08:08:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53875 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229745AbhCRMIT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 08:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616069299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JlDcllrQr7DBrDcUVIaiNqS6XDXXMP0YtmA9o1iIxrY=;
        b=FcBbbxKBfcdcae7kMThWjKP/+KRYFtMf1BqowmxPgqupMjl4lph0T5ymTm10N275LRrG40
        8j9Yq6mWRMvpHYyIK1bvLV2Ypb/kJrAy8EEpqXK4dDsI8e8OaCRz33WWDT0/fXBogFsEDz
        FUHROQKhnIm1ouOyWM7pgFOEN2uYLgM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-LtMXlIIPOV6X0T5SHt7tIw-1; Thu, 18 Mar 2021 08:08:17 -0400
X-MC-Unique: LtMXlIIPOV6X0T5SHt7tIw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC2B9107B7C9;
        Thu, 18 Mar 2021 12:08:14 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 456A31002388;
        Thu, 18 Mar 2021 12:08:04 +0000 (UTC)
Date:   Thu, 18 Mar 2021 08:08:01 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, x86@kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Paris <eparis@redhat.com>, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH 1/2] audit: add support for the openat2 syscall
Message-ID: <20210318120801.GK3141668@madcap2.tricolour.ca>
References: <cover.1616031035.git.rgb@redhat.com>
 <49510cacfb5fbbaa312a4a389f3a6619675007ab.1616031035.git.rgb@redhat.com>
 <20210318104843.uiga6tmmhn5wfhbs@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318104843.uiga6tmmhn5wfhbs@wittgenstein>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-03-18 11:48, Christian Brauner wrote:
> [+Cc Aleksa, the author of openat2()]

Ah!  Thanks for pulling in Aleksa.  I thought I caught everyone...

> and a comment below. :)

Same...

> On Wed, Mar 17, 2021 at 09:47:17PM -0400, Richard Guy Briggs wrote:
> > The openat2(2) syscall was added in kernel v5.6 with commit fddb5d430ad9
> > ("open: introduce openat2(2) syscall")
> > 
> > Add the openat2(2) syscall to the audit syscall classifier.
> > 
> > See the github issue
> > https://github.com/linux-audit/audit-kernel/issues/67
> > 
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  arch/alpha/kernel/audit.c          | 2 ++
> >  arch/ia64/kernel/audit.c           | 2 ++
> >  arch/parisc/kernel/audit.c         | 2 ++
> >  arch/parisc/kernel/compat_audit.c  | 2 ++
> >  arch/powerpc/kernel/audit.c        | 2 ++
> >  arch/powerpc/kernel/compat_audit.c | 2 ++
> >  arch/s390/kernel/audit.c           | 2 ++
> >  arch/s390/kernel/compat_audit.c    | 2 ++
> >  arch/sparc/kernel/audit.c          | 2 ++
> >  arch/sparc/kernel/compat_audit.c   | 2 ++
> >  arch/x86/ia32/audit.c              | 2 ++
> >  arch/x86/kernel/audit_64.c         | 2 ++
> >  kernel/auditsc.c                   | 3 +++
> >  lib/audit.c                        | 4 ++++
> >  lib/compat_audit.c                 | 4 ++++
> >  15 files changed, 35 insertions(+)
> > 
> > diff --git a/arch/alpha/kernel/audit.c b/arch/alpha/kernel/audit.c
> > index 96a9d18ff4c4..06a911b685d1 100644
> > --- a/arch/alpha/kernel/audit.c
> > +++ b/arch/alpha/kernel/audit.c
> > @@ -42,6 +42,8 @@ int audit_classify_syscall(int abi, unsigned syscall)
> >  		return 3;
> >  	case __NR_execve:
> >  		return 5;
> > +	case __NR_openat2:
> > +		return 6;
> >  	default:
> >  		return 0;
> >  	}
> > diff --git a/arch/ia64/kernel/audit.c b/arch/ia64/kernel/audit.c
> > index 5192ca899fe6..5eaa888c8fd3 100644
> > --- a/arch/ia64/kernel/audit.c
> > +++ b/arch/ia64/kernel/audit.c
> > @@ -43,6 +43,8 @@ int audit_classify_syscall(int abi, unsigned syscall)
> >  		return 3;
> >  	case __NR_execve:
> >  		return 5;
> > +	case __NR_openat2:
> > +		return 6;
> >  	default:
> >  		return 0;
> >  	}
> > diff --git a/arch/parisc/kernel/audit.c b/arch/parisc/kernel/audit.c
> > index 9eb47b2225d2..fc721a7727ba 100644
> > --- a/arch/parisc/kernel/audit.c
> > +++ b/arch/parisc/kernel/audit.c
> > @@ -52,6 +52,8 @@ int audit_classify_syscall(int abi, unsigned syscall)
> >  		return 3;
> >  	case __NR_execve:
> >  		return 5;
> > +	case __NR_openat2:
> > +		return 6;
> >  	default:
> >  		return 0;
> >  	}
> > diff --git a/arch/parisc/kernel/compat_audit.c b/arch/parisc/kernel/compat_audit.c
> > index 20c39c9d86a9..fc6d35918c44 100644
> > --- a/arch/parisc/kernel/compat_audit.c
> > +++ b/arch/parisc/kernel/compat_audit.c
> > @@ -35,6 +35,8 @@ int parisc32_classify_syscall(unsigned syscall)
> >  		return 3;
> >  	case __NR_execve:
> >  		return 5;
> > +	case __NR_openat2:
> > +		return 6;
> >  	default:
> >  		return 1;
> >  	}
> > diff --git a/arch/powerpc/kernel/audit.c b/arch/powerpc/kernel/audit.c
> > index a2dddd7f3d09..8f32700b0baa 100644
> > --- a/arch/powerpc/kernel/audit.c
> > +++ b/arch/powerpc/kernel/audit.c
> > @@ -54,6 +54,8 @@ int audit_classify_syscall(int abi, unsigned syscall)
> >  		return 4;
> >  	case __NR_execve:
> >  		return 5;
> > +	case __NR_openat2:
> > +		return 6;
> >  	default:
> >  		return 0;
> >  	}
> > diff --git a/arch/powerpc/kernel/compat_audit.c b/arch/powerpc/kernel/compat_audit.c
> > index 55c6ccda0a85..ebe45534b1c9 100644
> > --- a/arch/powerpc/kernel/compat_audit.c
> > +++ b/arch/powerpc/kernel/compat_audit.c
> > @@ -38,6 +38,8 @@ int ppc32_classify_syscall(unsigned syscall)
> >  		return 4;
> >  	case __NR_execve:
> >  		return 5;
> > +	case __NR_openat2:
> > +		return 6;
> >  	default:
> >  		return 1;
> >  	}
> > diff --git a/arch/s390/kernel/audit.c b/arch/s390/kernel/audit.c
> > index d395c6c9944c..d964cb94cfaf 100644
> > --- a/arch/s390/kernel/audit.c
> > +++ b/arch/s390/kernel/audit.c
> > @@ -54,6 +54,8 @@ int audit_classify_syscall(int abi, unsigned syscall)
> >  		return 4;
> >  	case __NR_execve:
> >  		return 5;
> > +	case __NR_openat2:
> > +		return 6;
> >  	default:
> >  		return 0;
> >  	}
> > diff --git a/arch/s390/kernel/compat_audit.c b/arch/s390/kernel/compat_audit.c
> > index 444fb1f66944..f7b32933ce0e 100644
> > --- a/arch/s390/kernel/compat_audit.c
> > +++ b/arch/s390/kernel/compat_audit.c
> > @@ -39,6 +39,8 @@ int s390_classify_syscall(unsigned syscall)
> >  		return 4;
> >  	case __NR_execve:
> >  		return 5;
> > +	case __NR_openat2:
> > +		return 6;
> >  	default:
> >  		return 1;
> >  	}
> > diff --git a/arch/sparc/kernel/audit.c b/arch/sparc/kernel/audit.c
> > index a6e91bf34d48..b6dcca9c6520 100644
> > --- a/arch/sparc/kernel/audit.c
> > +++ b/arch/sparc/kernel/audit.c
> > @@ -55,6 +55,8 @@ int audit_classify_syscall(int abi, unsigned int syscall)
> >  		return 4;
> >  	case __NR_execve:
> >  		return 5;
> > +	case __NR_openat2:
> > +		return 6;
> >  	default:
> >  		return 0;
> >  	}
> > diff --git a/arch/sparc/kernel/compat_audit.c b/arch/sparc/kernel/compat_audit.c
> > index 10eeb4f15b20..d2652a1083ad 100644
> > --- a/arch/sparc/kernel/compat_audit.c
> > +++ b/arch/sparc/kernel/compat_audit.c
> > @@ -39,6 +39,8 @@ int sparc32_classify_syscall(unsigned int syscall)
> >  		return 4;
> >  	case __NR_execve:
> >  		return 5;
> > +	case __NR_openat2:
> > +		return 6;
> >  	default:
> >  		return 1;
> >  	}
> > diff --git a/arch/x86/ia32/audit.c b/arch/x86/ia32/audit.c
> > index 6efe6cb3768a..57a02ade5503 100644
> > --- a/arch/x86/ia32/audit.c
> > +++ b/arch/x86/ia32/audit.c
> > @@ -39,6 +39,8 @@ int ia32_classify_syscall(unsigned syscall)
> >  	case __NR_execve:
> >  	case __NR_execveat:
> >  		return 5;
> > +	case __NR_openat2:
> > +		return 6;
> >  	default:
> >  		return 1;
> >  	}
> > diff --git a/arch/x86/kernel/audit_64.c b/arch/x86/kernel/audit_64.c
> > index 83d9cad4e68b..39de1e021258 100644
> > --- a/arch/x86/kernel/audit_64.c
> > +++ b/arch/x86/kernel/audit_64.c
> > @@ -53,6 +53,8 @@ int audit_classify_syscall(int abi, unsigned syscall)
> >  	case __NR_execve:
> >  	case __NR_execveat:
> >  		return 5;
> > +	case __NR_openat2:
> > +		return 6;
> >  	default:
> >  		return 0;
> >  	}
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index 8bb9ac84d2fb..f5616e70d129 100644
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
> > @@ -195,6 +196,8 @@ static int audit_match_perm(struct audit_context *ctx, int mask)
> >  		return ((mask & AUDIT_PERM_WRITE) && ctx->argv[0] == SYS_BIND);
> >  	case 5: /* execve */
> >  		return mask & AUDIT_PERM_EXEC;
> > +	case 6: /* openat2 */
> > +		return mask & ACC_MODE((u32)((struct open_how *)ctx->argv[2])->flags);
> 
> That looks a bit dodgy. Maybe sm like the below would be a bit better?

Ah, ok, fair enough, since original flags use a u32 and this was picked
as u64 for alignment.  It was just occurring to me last night that I
might have the dubious honour of being the first usage of 0%llo format
specifier in the kernel...  ;-)

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 47fb48f42c93..531e882a5096 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -159,6 +159,7 @@ static const struct audit_nfcfgop_tab audit_nfcfgs[] = {
> 
>  static int audit_match_perm(struct audit_context *ctx, int mask)
>  {
> +       struct open_how *openat2;
>         unsigned n;
>         if (unlikely(!ctx))
>                 return 0;
> @@ -195,6 +196,12 @@ static int audit_match_perm(struct audit_context *ctx, int mask)
>                 return ((mask & AUDIT_PERM_WRITE) && ctx->argv[0] == SYS_BIND);
>         case 5: /* execve */
>                 return mask & AUDIT_PERM_EXEC;
> +       case 6: /* openat2 */
> +               openat2 = ctx->argv[2];
> +               if (upper_32_bits(openat2->flags))
> +                       pr_warn("Some sensible warning about unknown flags");
> +
> +               return mask & ACC_MODE(lower_32_bits(openat2->flags));
>         default:
>                 return 0;
>         }
> 
> (Ideally we'd probably notice at build-time that we've got flags
> exceeding 32bits. Could probably easily been done by exposing an all
> flags macro somewhere and then we can place a BUILD_BUG_ON() or sm into
> such places.)
> 
> Christian

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

