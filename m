Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C432EC93C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 04:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbhAGD4S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jan 2021 22:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbhAGD4S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jan 2021 22:56:18 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF0DC0612F0
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Jan 2021 19:55:37 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id dk8so6479765edb.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Jan 2021 19:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ArfZUeS2ElfFd5UopeF/y2SL/kE9hAKyfvJ+CrxktOY=;
        b=OMyfG8W1rQr2h6/oLmLv+ytkpXZbK+A0pav47xabiQJCKB96+5iD4rooJBTG+qQ/dh
         9u0Qg6R0IRfRshQlJGwdQAmnkOQT72eqhxk9oErD5oQL9RiqdCZw0n+MVCxfbwfhpC89
         F+ex8TSUqpa8Dpvmsi1K2QGu8ku/ARuy+iOvra/UqtI3y3h4r6a/KWmRLaA8KvukFDeO
         VagKNaCQkNe/8U89AAKBPYds39cnECSVvOYWRjois2iehgx5lxO+if32MDRcWUYvkSmp
         +9n2M7gl9AAiws/+5ahLs1LIg2bCyjCdXy2Chuk7BqbqNQqt301IDVWNA+JrtG37WzRL
         Cwtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ArfZUeS2ElfFd5UopeF/y2SL/kE9hAKyfvJ+CrxktOY=;
        b=umP7eavljP1cgj7qBzioXOtj6eXC34DzfrXmxc0Ycw/TMn3aW2dW7w+i48dYFhZjQW
         k3xt0qOoVhxCWDWiYcwCVefDWDFlyD+N75qAUy5RK2Tqf+afYgioNYUYpDjWJj5boxEz
         af7+5fJPbadjUVMoTyHyny01EUez1+YX7G3Ig0NBFb+JMfXzXSN7l0mQXCntMDioNzQZ
         /aiJXeOcHJSHh36yBt+BlJrSDSPLPqGqCBb9XnGKP/YJTvOqiG3W+sdxPSkvwGNSiZWj
         5PFWzf7hR/Dm5yg4uwDs0dnrMzl+5YJsmRbaxwO5g73Q48jWCAt/yd4JXvZ7/FA8j5Nw
         ZRxQ==
X-Gm-Message-State: AOAM533f+c7c3L9H96MslCZdWl+/N69qQO+SRAIx9mEaeTkjqGaVVTH+
        FKe22C7IwqDWE73F5NnpBGtZyOyLXzCwREwE3pPMWA==
X-Google-Smtp-Source: ABdhPJyORx0sAbAODd8CGeISVo0MbK0W4eoAnMRxbU/9RBvPBR5EHlcWJhHewQFctKMuOIIq9ZOYtptNP4Cvp4t4fuo=
X-Received: by 2002:a05:6402:2cd:: with SMTP id b13mr187485edx.199.1609991736272;
 Wed, 06 Jan 2021 19:55:36 -0800 (PST)
MIME-Version: 1.0
References: <20201112015359.1103333-1-lokeshgidra@google.com>
 <20201112015359.1103333-4-lokeshgidra@google.com> <CAHC9VhS2WNXn2cVAUcAY5AmmBv+=XsthCevofNNuEOU3=jtLrg@mail.gmail.com>
In-Reply-To: <CAHC9VhS2WNXn2cVAUcAY5AmmBv+=XsthCevofNNuEOU3=jtLrg@mail.gmail.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Wed, 6 Jan 2021 19:55:25 -0800
Message-ID: <CA+EESO5wXubeutVOdbp_LamfP5TyG0r7BO-qnWV=wkd9zWqJ4w@mail.gmail.com>
Subject: Re: [PATCH v13 3/4] selinux: teach SELinux about anonymous inodes
To:     Paul Moore <paul@paul-moore.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Eric Paris <eparis@parisplace.org>,
        Daniel Colascione <dancol@dancol.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        David Howells <dhowells@redhat.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Adrian Reber <areber@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Calin Juravle <calin@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>, hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 6, 2021 at 7:03 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Wed, Nov 11, 2020 at 8:54 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
> > From: Daniel Colascione <dancol@google.com>
> >
> > This change uses the anon_inodes and LSM infrastructure introduced in
> > the previous patches to give SELinux the ability to control
> > anonymous-inode files that are created using the new
> > anon_inode_getfd_secure() function.
> >
> > A SELinux policy author detects and controls these anonymous inodes by
> > adding a name-based type_transition rule that assigns a new security
> > type to anonymous-inode files created in some domain. The name used
> > for the name-based transition is the name associated with the
> > anonymous inode for file listings --- e.g., "[userfaultfd]" or
> > "[perf_event]".
> >
> > Example:
> >
> > type uffd_t;
> > type_transition sysadm_t sysadm_t : anon_inode uffd_t "[userfaultfd]";
> > allow sysadm_t uffd_t:anon_inode { create };
> >
> > (The next patch in this series is necessary for making userfaultfd
> > support this new interface.  The example above is just
> > for exposition.)
> >
> > Signed-off-by: Daniel Colascione <dancol@google.com>
> > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > ---
> >  security/selinux/hooks.c            | 56 +++++++++++++++++++++++++++++
> >  security/selinux/include/classmap.h |  2 ++
> >  2 files changed, 58 insertions(+)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 6b1826fc3658..d092aa512868 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2927,6 +2927,61 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
> >         return 0;
> >  }
> >
> > +static int selinux_inode_init_security_anon(struct inode *inode,
> > +                                           const struct qstr *name,
> > +                                           const struct inode *context_inode)
> > +{
> > +       const struct task_security_struct *tsec = selinux_cred(current_cred());
> > +       struct common_audit_data ad;
> > +       struct inode_security_struct *isec;
> > +       int rc;
> > +
> > +       if (unlikely(!selinux_initialized(&selinux_state)))
> > +               return 0;
> > +
> > +       isec = selinux_inode(inode);
> > +
> > +       /*
> > +        * We only get here once per ephemeral inode.  The inode has
> > +        * been initialized via inode_alloc_security but is otherwise
> > +        * untouched.
> > +        */
> > +
> > +       if (context_inode) {
> > +               struct inode_security_struct *context_isec =
> > +                       selinux_inode(context_inode);
> > +               if (context_isec->initialized != LABEL_INITIALIZED)
> > +                       return -EACCES;
> > +
> > +               isec->sclass = context_isec->sclass;
>
> Taking the object class directly from the context_inode is
> interesting, and I suspect problematic.  In the case below where no
> context_inode is supplied the object class is set to
> SECCLASS_ANON_INODE, which is correct, but when a context_inode is
> supplied there is no guarantee that the object class will be set to
> SECCLASS_ANON_INODE.  This could both pose a problem for policy
> writers (how do you distinguish the anon inode from other normal file
> inodes in this case?) as well as an outright fault later in this
> function when we try to check the ANON_INODE__CREATE on an object
> other than a SECCLASS_ANON_INODE object.
>
Thanks for catching this. I'll initialize 'sclass' unconditionally to
SECCLASS_ANON_INODE in the next version. Also, do you think I should
add a check that context_inode's sclass must be SECCLASS_ANON_INODE to
confirm that we never receive a regular inode as context_inode?

> It works in the userfaultfd case because the context_inode is
> originally created with this function so the object class is correctly
> set to SECCLASS_ANON_INODE, but can we always guarantee that to be the
> case?  Do we ever need or want to support using a context_inode that
> is not SECCLASS_ANON_INODE?
>

I don't think there is any requirement of supporting context_inode
which isn't anon-inode. And even if there is, as you described
earlier, for ANON_INODE__CREATE to work the sclass has to be
SECCLASS_ANON_INODE. I'll appreciate comments on this from others,
particularly Daniel and Stephen who originally discussed and
implemented this patch.


> > +               isec->sid = context_isec->sid;
> > +       } else {
> > +               isec->sclass = SECCLASS_ANON_INODE;
> > +               rc = security_transition_sid(
> > +                       &selinux_state, tsec->sid, tsec->sid,
> > +                       isec->sclass, name, &isec->sid);
> > +               if (rc)
> > +                       return rc;
> > +       }
> > +
> > +       isec->initialized = LABEL_INITIALIZED;
> > +
> > +       /*
> > +        * Now that we've initialized security, check whether we're
> > +        * allowed to actually create this type of anonymous inode.
> > +        */
> > +
> > +       ad.type = LSM_AUDIT_DATA_INODE;
> > +       ad.u.inode = inode;
> > +
> > +       return avc_has_perm(&selinux_state,
> > +                           tsec->sid,
> > +                           isec->sid,
> > +                           isec->sclass,
> > +                           ANON_INODE__CREATE,
> > +                           &ad);
> > +}
>
> --
> paul moore
> www.paul-moore.com
