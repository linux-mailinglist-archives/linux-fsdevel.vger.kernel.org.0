Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 761E2389F59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 09:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhETIAL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 04:00:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229536AbhETIAK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 04:00:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 937626101D;
        Thu, 20 May 2021 07:58:45 +0000 (UTC)
Date:   Thu, 20 May 2021 09:58:42 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Paris <eparis@redhat.com>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>,
        Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH v4 2/3] audit: add support for the openat2 syscall
Message-ID: <20210520075842.vnbwbw6yffkybk6z@wittgenstein>
References: <cover.1621363275.git.rgb@redhat.com>
 <f5f1a4d8699613f8c02ce762807228c841c2e26f.1621363275.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f5f1a4d8699613f8c02ce762807228c841c2e26f.1621363275.git.rgb@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 19, 2021 at 04:00:21PM -0400, Richard Guy Briggs wrote:
> The openat2(2) syscall was added in kernel v5.6 with commit fddb5d430ad9
> ("open: introduce openat2(2) syscall")
> 
> Add the openat2(2) syscall to the audit syscall classifier.
> 
> Link: https://github.com/linux-audit/audit-kernel/issues/67
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Link: https://lore.kernel.org/r/f5f1a4d8699613f8c02ce762807228c841c2e26f.1621363275.git.rgb@redhat.com
> ---
>  arch/alpha/kernel/audit.c           | 2 ++
>  arch/ia64/kernel/audit.c            | 2 ++
>  arch/parisc/kernel/audit.c          | 2 ++
>  arch/parisc/kernel/compat_audit.c   | 2 ++
>  arch/powerpc/kernel/audit.c         | 2 ++
>  arch/powerpc/kernel/compat_audit.c  | 2 ++
>  arch/s390/kernel/audit.c            | 2 ++
>  arch/s390/kernel/compat_audit.c     | 2 ++
>  arch/sparc/kernel/audit.c           | 2 ++
>  arch/sparc/kernel/compat_audit.c    | 2 ++
>  arch/x86/ia32/audit.c               | 2 ++
>  arch/x86/kernel/audit_64.c          | 2 ++
>  include/linux/auditsc_classmacros.h | 1 +
>  kernel/auditsc.c                    | 3 +++
>  lib/audit.c                         | 4 ++++
>  lib/compat_audit.c                  | 4 ++++
>  16 files changed, 36 insertions(+)
> 
> diff --git a/arch/alpha/kernel/audit.c b/arch/alpha/kernel/audit.c
> index 81cbd804e375..3ab04709784a 100644
> --- a/arch/alpha/kernel/audit.c
> +++ b/arch/alpha/kernel/audit.c
> @@ -42,6 +42,8 @@ int audit_classify_syscall(int abi, unsigned syscall)
>  		return AUDITSC_OPENAT;
>  	case __NR_execve:
>  		return AUDITSC_EXECVE;
> +	case __NR_openat2:
> +		return AUDITSC_OPENAT2;
>  	default:
>  		return AUDITSC_NATIVE;
>  	}
> diff --git a/arch/ia64/kernel/audit.c b/arch/ia64/kernel/audit.c
> index dba6a74c9ab3..ec61f20ca61f 100644
> --- a/arch/ia64/kernel/audit.c
> +++ b/arch/ia64/kernel/audit.c
> @@ -43,6 +43,8 @@ int audit_classify_syscall(int abi, unsigned syscall)
>  		return AUDITSC_OPENAT;
>  	case __NR_execve:
>  		return AUDITSC_EXECVE;
> +	case __NR_openat2:
> +		return AUDITSC_OPENAT2;
>  	default:
>  		return AUDITSC_NATIVE;
>  	}
> diff --git a/arch/parisc/kernel/audit.c b/arch/parisc/kernel/audit.c
> index 14244e83db75..f420b5552140 100644
> --- a/arch/parisc/kernel/audit.c
> +++ b/arch/parisc/kernel/audit.c
> @@ -52,6 +52,8 @@ int audit_classify_syscall(int abi, unsigned syscall)
>  		return AUDITSC_OPENAT;
>  	case __NR_execve:
>  		return AUDITSC_EXECVE;
> +	case __NR_openat2:
> +		return AUDITSC_OPENAT2;
>  	default:
>  		return AUDITSC_NATIVE;
>  	}
> diff --git a/arch/parisc/kernel/compat_audit.c b/arch/parisc/kernel/compat_audit.c
> index 1d6347d37d92..3ec490c28656 100644
> --- a/arch/parisc/kernel/compat_audit.c
> +++ b/arch/parisc/kernel/compat_audit.c
> @@ -36,6 +36,8 @@ int parisc32_classify_syscall(unsigned syscall)
>  		return AUDITSC_OPENAT;
>  	case __NR_execve:
>  		return AUDITSC_EXECVE;
> +	case __NR_openat2:
> +		return AUDITSC_OPENAT2;
>  	default:
>  		return AUDITSC_COMPAT;
>  	}
> diff --git a/arch/powerpc/kernel/audit.c b/arch/powerpc/kernel/audit.c
> index 6eb18ef77dff..1bcfca5fdf67 100644
> --- a/arch/powerpc/kernel/audit.c
> +++ b/arch/powerpc/kernel/audit.c
> @@ -54,6 +54,8 @@ int audit_classify_syscall(int abi, unsigned syscall)
>  		return AUDITSC_SOCKETCALL;
>  	case __NR_execve:
>  		return AUDITSC_EXECVE;
> +	case __NR_openat2:
> +		return AUDITSC_OPENAT2;
>  	default:
>  		return AUDITSC_NATIVE;
>  	}
> diff --git a/arch/powerpc/kernel/compat_audit.c b/arch/powerpc/kernel/compat_audit.c
> index b1dc2d1c4bad..251abf79d536 100644
> --- a/arch/powerpc/kernel/compat_audit.c
> +++ b/arch/powerpc/kernel/compat_audit.c
> @@ -39,6 +39,8 @@ int ppc32_classify_syscall(unsigned syscall)
>  		return AUDITSC_SOCKETCALL;
>  	case __NR_execve:
>  		return AUDITSC_EXECVE;
> +	case __NR_openat2:
> +		return AUDITSC_OPENAT2;
>  	default:
>  		return AUDITSC_COMPAT;
>  	}
> diff --git a/arch/s390/kernel/audit.c b/arch/s390/kernel/audit.c
> index 7e331e1831d4..02051a596b87 100644
> --- a/arch/s390/kernel/audit.c
> +++ b/arch/s390/kernel/audit.c
> @@ -54,6 +54,8 @@ int audit_classify_syscall(int abi, unsigned syscall)
>  		return AUDITSC_SOCKETCALL;
>  	case __NR_execve:
>  		return AUDITSC_EXECVE;
> +	case __NR_openat2:
> +		return AUDITSC_OPENAT2;
>  	default:
>  		return AUDITSC_NATIVE;
>  	}
> diff --git a/arch/s390/kernel/compat_audit.c b/arch/s390/kernel/compat_audit.c
> index fc3d1c7ad21c..4b3d463e7d97 100644
> --- a/arch/s390/kernel/compat_audit.c
> +++ b/arch/s390/kernel/compat_audit.c
> @@ -40,6 +40,8 @@ int s390_classify_syscall(unsigned syscall)
>  		return AUDITSC_SOCKETCALL;
>  	case __NR_execve:
>  		return AUDITSC_EXECVE;
> +	case __NR_openat2:
> +		return AUDITSC_OPENAT2;
>  	default:
>  		return AUDITSC_COMPAT;
>  	}
> diff --git a/arch/sparc/kernel/audit.c b/arch/sparc/kernel/audit.c
> index 50fab35bdaba..b092274eca79 100644
> --- a/arch/sparc/kernel/audit.c
> +++ b/arch/sparc/kernel/audit.c
> @@ -55,6 +55,8 @@ int audit_classify_syscall(int abi, unsigned int syscall)
>  		return AUDITSC_SOCKETCALL;
>  	case __NR_execve:
>  		return AUDITSC_EXECVE;
> +	case __NR_openat2:
> +		return AUDITSC_OPENAT2;
>  	default:
>  		return AUDITSC_NATIVE;
>  	}
> diff --git a/arch/sparc/kernel/compat_audit.c b/arch/sparc/kernel/compat_audit.c
> index 1c1b6d075421..2a3f71206fc5 100644
> --- a/arch/sparc/kernel/compat_audit.c
> +++ b/arch/sparc/kernel/compat_audit.c
> @@ -40,6 +40,8 @@ int sparc32_classify_syscall(unsigned int syscall)
>  		return AUDITSC_SOCKETCALL;
>  	case __NR_execve:
>  		return AUDITSC_EXECVE;
> +	case __NR_openat2:
> +		return AUDITSC_OPENAT2;
>  	default:
>  		return AUDITSC_COMPAT;
>  	}
> diff --git a/arch/x86/ia32/audit.c b/arch/x86/ia32/audit.c
> index eedc37a1ee13..efc7d832fefb 100644
> --- a/arch/x86/ia32/audit.c
> +++ b/arch/x86/ia32/audit.c
> @@ -40,6 +40,8 @@ int ia32_classify_syscall(unsigned syscall)
>  	case __NR_execve:
>  	case __NR_execveat:
>  		return AUDITSC_EXECVE;
> +	case __NR_openat2:
> +		return AUDITSC_OPENAT2;
>  	default:
>  		return AUDITSC_COMPAT;
>  	}
> diff --git a/arch/x86/kernel/audit_64.c b/arch/x86/kernel/audit_64.c
> index 2a6cc9c9c881..44c3601cfdc4 100644
> --- a/arch/x86/kernel/audit_64.c
> +++ b/arch/x86/kernel/audit_64.c
> @@ -53,6 +53,8 @@ int audit_classify_syscall(int abi, unsigned syscall)
>  	case __NR_execve:
>  	case __NR_execveat:
>  		return AUDITSC_EXECVE;
> +	case __NR_openat2:
> +		return AUDITSC_OPENAT2;
>  	default:
>  		return AUDITSC_NATIVE;
>  	}
> diff --git a/include/linux/auditsc_classmacros.h b/include/linux/auditsc_classmacros.h
> index 18757d270961..dc8e72536dbd 100644
> --- a/include/linux/auditsc_classmacros.h
> +++ b/include/linux/auditsc_classmacros.h
> @@ -16,6 +16,7 @@ enum auditsc_class_t {
>  	AUDITSC_OPENAT,
>  	AUDITSC_SOCKETCALL,
>  	AUDITSC_EXECVE,
> +	AUDITSC_OPENAT2,
>  
>  	AUDITSC_NVALS /* count */
>  };
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index d775ea16505b..3f59ab209dfd 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -76,6 +76,7 @@
>  #include <linux/fsnotify_backend.h>
>  #include <uapi/linux/limits.h>
>  #include <uapi/linux/netfilter/nf_tables.h>
> +#include <uapi/linux/openat2.h>
>  
>  #include "audit.h"
>  
> @@ -196,6 +197,8 @@ static int audit_match_perm(struct audit_context *ctx, int mask)
>  		return ((mask & AUDIT_PERM_WRITE) && ctx->argv[0] == SYS_BIND);
>  	case AUDITSC_EXECVE:
>  		return mask & AUDIT_PERM_EXEC;
> +	case AUDITSC_OPENAT2:
> +		return mask & ACC_MODE((u32)((struct open_how *)ctx->argv[2])->flags);

That's a lot of dereferncing, casting and masking all at once. Maybe a
small static inline helper would be good for the sake of legibility? Sm
like:

static inline u32 audit_openat2_acc(struct open_how *how, int mask)
{
	u32 flags = how->flags;
	return mask & ACC_MODE(flags);
}

but not sure. Just seems more legible to me.
Otherwise.
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
