Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665C42EF843
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 20:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbhAHTg0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 14:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728864AbhAHTgZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 14:36:25 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FC3C061381;
        Fri,  8 Jan 2021 11:35:45 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id m12so25599400lfo.7;
        Fri, 08 Jan 2021 11:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3WxPunzObO7VBBO08P095znmCTwpPws3qFKujB/DeTY=;
        b=QH3kOVU7aUnQVLBDSE8jtmzLrRomllVB694UQ/nV/I42Dq+Crwrb7qazkPROG4ni+K
         CG0cvfn/5pVGUA/naferSia8hrt82nhsgR72saQ3sWVNzskbIHrJh5haTHdONdbmjS7B
         XqdOVWM+o6gzD1B8gRxrrUaFO7eauxky4rQE4U5VaM4dVo0DS8X1BhAszVGrxpbAPYjd
         EfmY549yM6uKr+LQKOG+q4OYu8tLB2YsbDv0NoxeE9FytJOrRSVmzKWiB2GU3FFP6GAY
         erG4XYFOd9Tqd+WjDuYQpZQjVplkMF7T+L/IcCPi/+ZZbEb+o2tO+CHh2lgfPNnpftUd
         EDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3WxPunzObO7VBBO08P095znmCTwpPws3qFKujB/DeTY=;
        b=KQGM/kSEAVd0yxJkzgvB/ql5VMfhXY9ES7N97wOQSFgTtlNxFEB9earixeMnysF7XU
         eTqpYf3RIfgb/ha5ffBjMmvoeuoCMhHddA7ajcuhJbv8qW9mZ+HclTUZ2C3qoYHzoRe3
         YuGNxx8O3gf1gjlc8MkDhSuOZz6zmL10VnMQA3gwAme5/WijnCI+WP/5Iv4+uUoQqi20
         oUhmkzrKDNNqtueb6o29knQniHyXHwWMGZi58QuGo99NcsDH4ujfB2WE/vWJDqSqCar8
         dldJGHIVuBWl4iC/acWv2T4m56l91KCacNp5xxYDFDoYHj11mb4hle/ugCXWl3SnMDQv
         L0PA==
X-Gm-Message-State: AOAM530j2g4muQEJXiIWa6jPHQF4Ah4cR5eyXFrPiNLBtoYUTvgZsL9X
        nst2NYYisY4u+RJtVweqvsf0DtF8zGnm04uU0pQ=
X-Google-Smtp-Source: ABdhPJzxD5CloN42QduDGf0YSiNOZ34DQjuAmMuXasAf2DGf5AZYqpLTLcFTkfGXtKpUES/9E+ntTXJrXzs1KjxjxjY=
X-Received: by 2002:ac2:548b:: with SMTP id t11mr2380189lfk.181.1610134543697;
 Fri, 08 Jan 2021 11:35:43 -0800 (PST)
MIME-Version: 1.0
References: <20201112015359.1103333-1-lokeshgidra@google.com>
 <20201112015359.1103333-4-lokeshgidra@google.com> <CAHC9VhS2WNXn2cVAUcAY5AmmBv+=XsthCevofNNuEOU3=jtLrg@mail.gmail.com>
In-Reply-To: <CAHC9VhS2WNXn2cVAUcAY5AmmBv+=XsthCevofNNuEOU3=jtLrg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 8 Jan 2021 14:35:32 -0500
Message-ID: <CAEjxPJ6TA_nXrUJ6CjhG-j0_oAj9WU1vRn5pGvjDqQ2Bk9VVag@mail.gmail.com>
Subject: Re: [PATCH v13 3/4] selinux: teach SELinux about anonymous inodes
To:     Paul Moore <paul@paul-moore.com>
Cc:     Lokesh Gidra <lokeshgidra@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
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
        Aaron Goidel <acgoide@tycho.nsa.gov>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Reber <areber@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>, kaleshsingh@google.com,
        Calin Juravle <calin@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        kernel-team@android.com, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 6, 2021 at 10:03 PM Paul Moore <paul@paul-moore.com> wrote:
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
> It works in the userfaultfd case because the context_inode is
> originally created with this function so the object class is correctly
> set to SECCLASS_ANON_INODE, but can we always guarantee that to be the
> case?  Do we ever need or want to support using a context_inode that
> is not SECCLASS_ANON_INODE?

Sorry, I haven't been following this.  IIRC, the original reason for
passing a context_inode was to support the /dev/kvm or similar use
cases where the driver is creating anonymous inodes to represent
specific objects/interfaces derived from the device node and we want
to be able to control subsequent ioctl operations on those anonymous
inodes in the same manner as for the device node.  For example, ioctl
operations on /dev/kvm can end up returning file descriptors for
anonymous inodes representing a specific VM or VCPU or similar.  If we
propagate the security class and SID from the /dev/kvm inode (the
context inode) to the new anonymous inode, we can write a single
policy rule over all ioctl operations related to /dev/kvm.  That's
also why we used the FILE__CREATE permission here originally; that was
also intentional.  All the file-related classes including anon_inode
inherit a common set of file permissions including create and thus we
often use the FILE__<permission> in common code when checking
permission against any potentially derived class.
