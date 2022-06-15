Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79B754BEEE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 02:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbiFOAya (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jun 2022 20:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbiFOAy2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jun 2022 20:54:28 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A374C791
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jun 2022 17:54:26 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id p128so11185604iof.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jun 2022 17:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g/o214ka60maiASojlNW0EMmpvUlSswnoTPZvTfc5Kc=;
        b=UFknaUHfF9Hd84TujXyCMqsVqOPqBh60xzYHToPJoyo2UGClkJ9vp5jFhIXGX7w60M
         H4Q8N4SsqWD6nu2l26JvM/Ibl4XCpGc1gMmPzXTGO/JCLZSY1+k1bddGaPKQNiuOTdV/
         YNcZ0IouwvYEIGEO72PYlLHtLnHZNcvIq7reVES7HH12NODrM+Dv0pANnz5Vrnu/Iojs
         fPHPCXrN9dr7fd1l87KrELjKc2RGZQ9Lo8AUNgoZa4zNFs8/wLMckLam+xfFkmtFw9hS
         4UcHJhUF0hqB+qQdbt2NP9SZUwCMOxULsPMeKHOYJmyFSEj9RPC1QqFXsNlj/gJ3xn0K
         w5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g/o214ka60maiASojlNW0EMmpvUlSswnoTPZvTfc5Kc=;
        b=gm3uf8uw/5o0gX2nlbW4+W/tliorH8j+6T3QbZ+N2dvyCQmELd2y//hvY6ywkOBjNF
         /SZqh9CBNe+NCe6FfqM6IYFCeOvbFvV/xVJH/zKBANQJCqcoReviYj49512N6zfGzImp
         2Je5iKOwp+cN0P+cTsXKRGrd3zlrsbcGSfq8jQlXFe7RPpHc7Cugdag+YELwry/b0EAX
         EzUvB6wScd6qJOVO/pBXDOLQ5yqq8pfvpKML7zbpXEd9O7Lr6VKtbSN5kG6O5EF5DAak
         tLMFJtcffzU7k6LbJWmsxwgjsRlOdDt3oYoWS6op7PcgCuM+RHzI/tOuGIeYclqKK3od
         9MbA==
X-Gm-Message-State: AOAM533oH6lCw0tBBdNRPjEvFAj9GMwLi/KfZe4x2ryIN7Xt12/sAn5g
        sM+qFbnhaa4yLQ3Yk59MN61SLO9ta+t7CXbrIT35VA==
X-Google-Smtp-Source: ABdhPJxqJkud1Xxc+ejVu6vGpGTX+vLqjpBLPEk/P4975j41DduO/8+CDXliqc1BzV/wuHr7hFoFg6RZKHTaf3bl+0Q=
X-Received: by 2002:a02:85e8:0:b0:331:c16a:55d3 with SMTP id
 d95-20020a0285e8000000b00331c16a55d3mr4248221jai.167.1655254465201; Tue, 14
 Jun 2022 17:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220601210951.3916598-1-axelrasmussen@google.com>
 <20220601210951.3916598-3-axelrasmussen@google.com> <Yqjc7t+XPtfWUVlw@xz-m1.local>
In-Reply-To: <Yqjc7t+XPtfWUVlw@xz-m1.local>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue, 14 Jun 2022 17:53:49 -0700
Message-ID: <CAJHvVcg+r+mmdODWKH3YpA7VyRs+H-UfaB3W2JOsGj0V=2=yHg@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] userfaultfd: add /dev/userfaultfd for fine grained
 access control
To:     Peter Xu <peterx@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Charan Teja Reddy <charante@codeaurora.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        zhangyi <yi.zhang@huawei.com>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 14, 2022 at 12:09 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Jun 01, 2022 at 02:09:47PM -0700, Axel Rasmussen wrote:
> > Historically, it has been shown that intercepting kernel faults with
> > userfaultfd (thereby forcing the kernel to wait for an arbitrary amount
> > of time) can be exploited, or at least can make some kinds of exploits
> > easier. So, in 37cd0575b8 "userfaultfd: add UFFD_USER_MODE_ONLY" we
> > changed things so, in order for kernel faults to be handled by
> > userfaultfd, either the process needs CAP_SYS_PTRACE, or this sysctl
> > must be configured so that any unprivileged user can do it.
> >
> > In a typical implementation of a hypervisor with live migration (take
> > QEMU/KVM as one such example), we do indeed need to be able to handle
> > kernel faults. But, both options above are less than ideal:
> >
> > - Toggling the sysctl increases attack surface by allowing any
> >   unprivileged user to do it.
> >
> > - Granting the live migration process CAP_SYS_PTRACE gives it this
> >   ability, but *also* the ability to "observe and control the
> >   execution of another process [...], and examine and change [its]
> >   memory and registers" (from ptrace(2)). This isn't something we need
> >   or want to be able to do, so granting this permission violates the
> >   "principle of least privilege".
> >
> > This is all a long winded way to say: we want a more fine-grained way to
> > grant access to userfaultfd, without granting other additional
> > permissions at the same time.
> >
> > To achieve this, add a /dev/userfaultfd misc device. This device
> > provides an alternative to the userfaultfd(2) syscall for the creation
> > of new userfaultfds. The idea is, any userfaultfds created this way will
> > be able to handle kernel faults, without the caller having any special
> > capabilities. Access to this mechanism is instead restricted using e.g.
> > standard filesystem permissions.
> >
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > ---
> >  fs/userfaultfd.c                 | 76 ++++++++++++++++++++++++++------
> >  include/uapi/linux/userfaultfd.h |  4 ++
> >  2 files changed, 66 insertions(+), 14 deletions(-)
> >
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index e943370107d0..8b92c1398169 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -30,6 +30,7 @@
> >  #include <linux/security.h>
> >  #include <linux/hugetlb.h>
> >  #include <linux/swapops.h>
> > +#include <linux/miscdevice.h>
> >
> >  int sysctl_unprivileged_userfaultfd __read_mostly;
> >
> > @@ -413,13 +414,8 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
> >
> >       if (ctx->features & UFFD_FEATURE_SIGBUS)
> >               goto out;
> > -     if ((vmf->flags & FAULT_FLAG_USER) == 0 &&
> > -         ctx->flags & UFFD_USER_MODE_ONLY) {
> > -             printk_once(KERN_WARNING "uffd: Set unprivileged_userfaultfd "
> > -                     "sysctl knob to 1 if kernel faults must be handled "
> > -                     "without obtaining CAP_SYS_PTRACE capability\n");
> > +     if (!(vmf->flags & FAULT_FLAG_USER) && (ctx->flags & UFFD_USER_MODE_ONLY))
> >               goto out;
> > -     }
> >
> >       /*
> >        * If it's already released don't get it. This avoids to loop
> > @@ -2052,19 +2048,33 @@ static void init_once_userfaultfd_ctx(void *mem)
> >       seqcount_spinlock_init(&ctx->refile_seq, &ctx->fault_pending_wqh.lock);
> >  }
> >
> > -SYSCALL_DEFINE1(userfaultfd, int, flags)
> > +static inline bool userfaultfd_allowed(bool is_syscall, int flags)
> > +{
> > +     bool kernel_faults = !(flags & UFFD_USER_MODE_ONLY);
> > +     bool allow_unprivileged = sysctl_unprivileged_userfaultfd;
> > +
> > +     /* userfaultfd(2) access is controlled by sysctl + capability. */
> > +     if (is_syscall && kernel_faults) {
> > +             if (!allow_unprivileged && !capable(CAP_SYS_PTRACE))
> > +                     return false;
> > +     }
> > +
> > +     /*
> > +      * For /dev/userfaultfd, access is to be controlled using e.g.
> > +      * permissions on the device node. We assume this is correctly
> > +      * configured by userspace, so we simply allow access here.
> > +      */
> > +
> > +     return true;
> > +}
>
> This helper reads a bit weird because potentially it constantly returns
> "true" for !syscall use case but it's very not obvious..
>
> Would it be cleaner to not pass in the bool at all?  Something like (I also
> un-nested some of the condition checks, hopefully it'll be easier to read):
>
> bool userfaultfd_syscall_allowed(int flags)
> {
>         /* Userspace-only page faults are always allowed */
>         if (flags & UFFD_USER_MODE_ONLY)
>                 return true;
>
>         /*
>          * The user is requesting kernel fault capabilities. Privileged
>          * users are always allowed even for kernel fault traps.
>          */
>         if (capable(CAP_SYS_PTRACE))
>                 return true;
>
>         /* Whether we allow unprivileged users for kernel faults? */
>         return sysctl_unprivileged_userfaultfd;
> }
>
> Then below...
>
> > +
> > +static int new_userfaultfd(bool is_syscall, int flags)
> >  {
> >       struct userfaultfd_ctx *ctx;
> >       int fd;
> >
> > -     if (!sysctl_unprivileged_userfaultfd &&
> > -         (flags & UFFD_USER_MODE_ONLY) == 0 &&
> > -         !capable(CAP_SYS_PTRACE)) {
> > -             printk_once(KERN_WARNING "uffd: Set unprivileged_userfaultfd "
> > -                     "sysctl knob to 1 if kernel faults must be handled "
> > -                     "without obtaining CAP_SYS_PTRACE capability\n");
> > +     if (!userfaultfd_allowed(is_syscall, flags))
> >               return -EPERM;
> > -     }
>
> .. we could write it as:
>
>         if (is_syscall && !userfaultfd_syscall_allowed(flags))
>                 return -EPERM;
>
> What do you think?
>
> >
> >       BUG_ON(!current->mm);
> >
> > @@ -2083,6 +2093,10 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
> >       refcount_set(&ctx->refcount, 1);
> >       ctx->flags = flags;
> >       ctx->features = 0;
> > +     /*
> > +      * If UFFD_USER_MODE_ONLY is not set, then userfaultfd_allowed() above
> > +      * decided that kernel faults were allowed and should be handled.
> > +      */
>
> Hmm.. why this needs to be added above "released=false"? Did you want to
> add this (perhaps) above "flags" instead?
>
> IMHO when people reading the flags it'll be clear already on how it was
> handled, the thing is the comment probably hide deep anyway so I'd consider
> omitting it.
>
> The rest looks good to me, thanks.

Thanks for reviewing, Peter! Most of these comments look good to me,
I'll include them in a v4 after I get back to the office in about a
week.

>
> >       ctx->released = false;
> >       atomic_set(&ctx->mmap_changing, 0);
> >       ctx->mm = current->mm;
> > @@ -2098,8 +2112,42 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
> >       return fd;
> >  }
> >
> > +SYSCALL_DEFINE1(userfaultfd, int, flags)
> > +{
> > +     return new_userfaultfd(true, flags);
> > +}
> > +
> > +static int userfaultfd_dev_open(struct inode *inode, struct file *file)
> > +{
> > +     return 0;
> > +}
> > +
> > +static long userfaultfd_dev_ioctl(struct file *file, unsigned int cmd, unsigned long flags)
> > +{
> > +     if (cmd != USERFAULTFD_IOC_NEW)
> > +             return -EINVAL;
> > +
> > +     return new_userfaultfd(false, flags);
> > +}
> > +
> > +static const struct file_operations userfaultfd_dev_fops = {
> > +     .open = userfaultfd_dev_open,
> > +     .unlocked_ioctl = userfaultfd_dev_ioctl,
> > +     .compat_ioctl = userfaultfd_dev_ioctl,
> > +     .owner = THIS_MODULE,
> > +     .llseek = noop_llseek,
> > +};
> > +
> > +static struct miscdevice userfaultfd_misc = {
> > +     .minor = MISC_DYNAMIC_MINOR,
> > +     .name = "userfaultfd",
> > +     .fops = &userfaultfd_dev_fops
> > +};
> > +
> >  static int __init userfaultfd_init(void)
> >  {
> > +     WARN_ON(misc_register(&userfaultfd_misc));
> > +
> >       userfaultfd_ctx_cachep = kmem_cache_create("userfaultfd_ctx_cache",
> >                                               sizeof(struct userfaultfd_ctx),
> >                                               0,
> > diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
> > index 7d32b1e797fb..005e5e306266 100644
> > --- a/include/uapi/linux/userfaultfd.h
> > +++ b/include/uapi/linux/userfaultfd.h
> > @@ -12,6 +12,10 @@
> >
> >  #include <linux/types.h>
> >
> > +/* ioctls for /dev/userfaultfd */
> > +#define USERFAULTFD_IOC 0xAA
> > +#define USERFAULTFD_IOC_NEW _IO(USERFAULTFD_IOC, 0x00)
> > +
> >  /*
> >   * If the UFFDIO_API is upgraded someday, the UFFDIO_UNREGISTER and
> >   * UFFDIO_WAKE ioctls should be defined as _IOW and not as _IOR.  In
> > --
> > 2.36.1.255.ge46751e96f-goog
> >
>
> --
> Peter Xu
>
