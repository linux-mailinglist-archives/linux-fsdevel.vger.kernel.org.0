Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59B74C386E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 23:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbiBXWIU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 17:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235227AbiBXWIU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:08:20 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857731BA920
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Feb 2022 14:07:48 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id e11so2900213ils.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Feb 2022 14:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y9LemQ7UibOKv7TygsAJ1fNv/umOOO5ENly/vIRlt/k=;
        b=qI7/MYEtXIjkXk/BlL6OEtG1iBeaBndACQNElTTZ4D5/YVxj7hBSQepyKPaVO++1j1
         tAiRpdpSnZV5chVbxRSwWT9d7iyt75Ckq2r3bFuWxa58q6rQCu0jBgRQjaAyI3FRErwO
         4g2mo9CBiAScNu8MOryoQkyac3JJ8fs58MzPgAO25LCrstR6w4tK3duf/wXUQb2HOQMK
         Bn0m8l8hskFMNnqxWzQ848XQ1Zy3ZXEFmXVhjtnvxxyelXxsYZPDzBC5sTxvB/HWKsmf
         CX6wzvaxBz0pa5ORMJaR3HtfqE4ZICEP53zsEK4EFPh4mGXDsQzQfaNC71Lkf/QltSOA
         BhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y9LemQ7UibOKv7TygsAJ1fNv/umOOO5ENly/vIRlt/k=;
        b=5HaBsVOqG1p3E4phHwex4Pu59QCqItobTZI3kx05c3KEd19Zvlm8GfpGbc9enqljp4
         AVcx7vUaF+cd5OwTMan4hRVAju5t6HNbWwx7gNKPuTPxJeOLG0iAWBLyEf04dVuDP4Mb
         xLDlcROFS+bNpC1KAzioOZqAppuIfDV47cXKeVO0Or+tBP7V7dXA9XrIOIm/ubNmIZ9C
         G9TN1OIfC/2tZYFDDRAPGUj3NAqvnR2pq0UPbS9jBwEMxqIx6IKOdk2PX/Soh5Y5uG7y
         mzAo4tIfYVz7+NJluny8GnZQgyaNSikSdNBNbSyoX3Ret4twDTGPOf9PS7MGNIQRzYNk
         RfTw==
X-Gm-Message-State: AOAM530/jf3QQplM/40xNGNncxcmNThT3SATq5Ve5GFfAuBM2I5G4Erq
        jYgXgUtKmsWWxkgKWJVRnR5cFeKzmPMLlbqQLc5ZeA==
X-Google-Smtp-Source: ABdhPJw/OUuE/4M4UCVUuipkXoZFfcmS2v6/NEodYV8mnLmpm4XNWqpIbhHzUrSrS2ufX/mhmMw/EP2b+/MRm9SNGlo=
X-Received: by 2002:a05:6e02:1584:b0:2b9:7a3d:8937 with SMTP id
 m4-20020a056e02158400b002b97a3d8937mr3987461ilu.192.1645740467186; Thu, 24
 Feb 2022 14:07:47 -0800 (PST)
MIME-Version: 1.0
References: <20220224181953.1030665-1-axelrasmussen@google.com> <fd265bb6-d9be-c8a3-50a9-4e3bf048c0ef@schaufler-ca.com>
In-Reply-To: <fd265bb6-d9be-c8a3-50a9-4e3bf048c0ef@schaufler-ca.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 24 Feb 2022 14:07:11 -0800
Message-ID: <CAJHvVcgbCL7+4bBZ_5biLKfjmz_DKNBV8H6NxcLcFrw9Fbu7mw@mail.gmail.com>
Subject: Re: [PATCH] userfaultfd, capability: introduce CAP_USERFAULTFD
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Serge Hallyn <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>
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

On Thu, Feb 24, 2022 at 11:13 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 2/24/2022 10:19 AM, Axel Rasmussen wrote:
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
> >    unprivileged user to do it.
> >
> > - Granting the live migration process CAP_SYS_PTRACE gives it this
> >    ability, but *also* the ability to "observe and control the
> >    execution of another process [...], and examine and change [its]
> >    memory and registers" (from ptrace(2)). This isn't something we need
> >    or want to be able to do, so granting this permission violates the
> >    "principle of least privilege".
> >
> > This is all a long winded way to say: we want a more fine-grained way to
> > grant access to userfaultfd, without granting other additional
> > permissions at the same time.
> >
> > So, add CAP_USERFAULTFD, for this specific case.
>
> TL;DR - No. We don't add new capabilities for a single use.
>
> You have a program that is already using a reasonably restrictive
> capability (compared to CAP_SYS_ADMIN, for example) and which I
> assume you have implemented appropriately for the level of privilege
> used. If you can demonstrate that this CAP_USERFAULTD has applicability
> beyond your specific implementation (and the name would imply otherwise)
> it could be worth considering, but as it is, no.

Thanks for taking the time to look at this Casey!

I'm not exactly clear, would you want more evidence of userspace use
cases besides just mine? Besides Google's VM implementation: Peter and
Andrea expressed interest in this to me a while back for use with
QEMU/KVM-based VMs [*], and I suspect Android folks would also use
this if it were merged (+Suren and Lokesh to CC).

Or, do you just mean that userfaultfd is too narrow a feature to
warrant a capability? When writing this I was encouraged by CAP_BPF
and CAP_CHECKPOINT_RESTORE, they seemed to me to be somewhat similar
in terms of scope (specific to a single kernel feature).



[*] Although, we talked about fine grained permissions in general, not
necessarily a capability based approach. An alternative we talked
about was to add a userfaultfd device node like /dev/userfaultfd. The
idea being, access to it could be controlled using normal filesystem
permissions (chmod/chown), and userfaultfds created that way (as
opposed to the userfaultfd() syscall) would be able to intercept
kernel faults, regardless of CAP_SYS_PTRACE. My gut feeling was that
this was significantly more complicated than the patch I'm proposing
here.

>
> >
> > Setup a helper which accepts either CAP_USERFAULTFD, or for backward
> > compatibility reasons (existing userspaces may depend on the old way of
> > doing things), CAP_SYS_PTRACE.
> >
> > One special case is UFFD_FEATURE_EVENT_FORK: this is left requiring only
> > CAP_SYS_PTRACE, since it is specifically about manipulating the memory
> > of another (child) process, it sems like a better fit the way it is. To
> > my knowledge, this isn't a feature required by typical live migration
> > implementations, so this doesn't obviate the above.
> >
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > ---
> >   fs/userfaultfd.c                    | 6 +++---
> >   include/linux/capability.h          | 5 +++++
> >   include/uapi/linux/capability.h     | 7 ++++++-
> >   security/selinux/include/classmap.h | 4 ++--
> >   4 files changed, 16 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index e26b10132d47..1ec0d9b49a70 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -411,7 +411,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
> >           ctx->flags & UFFD_USER_MODE_ONLY) {
> >               printk_once(KERN_WARNING "uffd: Set unprivileged_userfaultfd "
> >                       "sysctl knob to 1 if kernel faults must be handled "
> > -                     "without obtaining CAP_SYS_PTRACE capability\n");
> > +                     "without obtaining CAP_USERFAULTFD capability\n");
> >               goto out;
> >       }
> >
> > @@ -2068,10 +2068,10 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
> >
> >       if (!sysctl_unprivileged_userfaultfd &&
> >           (flags & UFFD_USER_MODE_ONLY) == 0 &&
> > -         !capable(CAP_SYS_PTRACE)) {
> > +         !userfaultfd_capable()) {
> >               printk_once(KERN_WARNING "uffd: Set unprivileged_userfaultfd "
> >                       "sysctl knob to 1 if kernel faults must be handled "
> > -                     "without obtaining CAP_SYS_PTRACE capability\n");
> > +                     "without obtaining CAP_USERFAULTFD capability\n");
> >               return -EPERM;
> >       }
> >
> > diff --git a/include/linux/capability.h b/include/linux/capability.h
> > index 65efb74c3585..f1e7b3506432 100644
> > --- a/include/linux/capability.h
> > +++ b/include/linux/capability.h
> > @@ -270,6 +270,11 @@ static inline bool checkpoint_restore_ns_capable(struct user_namespace *ns)
> >               ns_capable(ns, CAP_SYS_ADMIN);
> >   }
> >
> > +static inline bool userfaultfd_capable(void)
> > +{
> > +     return capable(CAP_USERFAULTFD) || capable(CAP_SYS_PTRACE);
> > +}
> > +
> >   /* audit system wants to get cap info from files as well */
> >   int get_vfs_caps_from_disk(struct user_namespace *mnt_userns,
> >                          const struct dentry *dentry,
> > diff --git a/include/uapi/linux/capability.h b/include/uapi/linux/capability.h
> > index 463d1ba2232a..83a5d8601508 100644
> > --- a/include/uapi/linux/capability.h
> > +++ b/include/uapi/linux/capability.h
> > @@ -231,6 +231,7 @@ struct vfs_ns_cap_data {
> >   #define CAP_SYS_CHROOT       18
> >
> >   /* Allow ptrace() of any process */
> > +/* Allow everything under CAP_USERFAULTFD for backward compatibility */
> >
> >   #define CAP_SYS_PTRACE       19
> >
> > @@ -417,7 +418,11 @@ struct vfs_ns_cap_data {
> >
> >   #define CAP_CHECKPOINT_RESTORE      40
> >
> > -#define CAP_LAST_CAP         CAP_CHECKPOINT_RESTORE
> > +/* Allow intercepting kernel faults with userfaultfd */
> > +
> > +#define CAP_USERFAULTFD              41
> > +
> > +#define CAP_LAST_CAP         CAP_USERFAULTFD
> >
> >   #define cap_valid(x) ((x) >= 0 && (x) <= CAP_LAST_CAP)
> >
> > diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> > index 35aac62a662e..98e37b220159 100644
> > --- a/security/selinux/include/classmap.h
> > +++ b/security/selinux/include/classmap.h
> > @@ -28,9 +28,9 @@
> >
> >   #define COMMON_CAP2_PERMS  "mac_override", "mac_admin", "syslog", \
> >               "wake_alarm", "block_suspend", "audit_read", "perfmon", "bpf", \
> > -             "checkpoint_restore"
> > +             "checkpoint_restore", "userfaultfd"
> >
> > -#if CAP_LAST_CAP > CAP_CHECKPOINT_RESTORE
> > +#if CAP_LAST_CAP > CAP_USERFAULTFD
> >   #error New capability defined, please update COMMON_CAP2_PERMS.
> >   #endif
> >
