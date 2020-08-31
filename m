Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 010B02580F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 20:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgHaSVw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 14:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729655AbgHaSVu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:21:50 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AD6C061236
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 11:21:50 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t4so2030377iln.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 11:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X3QYc0qUilro/bdxtUXo+KBifJgEgJArvSnQjd2oRO8=;
        b=NZoNODsK62AWX3XXgbhwvgj4xsKlN9RPyEndc3heBWH5oSQ/yEgPaopAIO0pasJJGY
         yeJNE1m+q4C7SdJzMSXi32IxZ5pVi8nfRpfDxwUOS5ZLMJ7CP/rRwt62wt1XKtYJEi5w
         00U3QRrHeVbHgln2joAZuwCq4otiompg1Q6EHjWNwCreW+6wxPJkMVIV8PAmvbErZug0
         8pUgvFzg5hW4fZQKAr7clfdnAa6Cxli4+k3gIiS6WuZVj9z9JF2UaiJ7cPbsyji1wRQM
         fCgsBDhfO2fZa0IooKzzN4Ub4/ywDnMfAEaj4AyAVWv8fiSMuF9kSLuFxGMjged+Jk4t
         WgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X3QYc0qUilro/bdxtUXo+KBifJgEgJArvSnQjd2oRO8=;
        b=gUggoSHyFR5A2tHb4vMqwfi9/PEbYTK+jhJEFSyXC6FfSxStBhiP8GMZcSCapScuYY
         WwTfzN/NC39QZCcbcpQq3V8UCYppU+ROzb6x8e6H/45WWhCbaXtYGWsNc+zWdE4LiciM
         r935jzxQibtmVnyFbshioO1xMFmiyCziQgZrYHDqPtB9l8xxRyWgGDG6BXJm+79XmNUX
         Cdxll0HW4okv8oOt7iuBnAO8c7vWM6Gjq4bFmKTOhSqc0xuGNiQ0iAG9RcGlVVu3uL87
         mZuq5xjWoD/Gbm41rknc5EkZMECUFS1PuPKJzuAYeIEQoHzq0Z9z2DAk1MBglN2HTCbC
         TJ2A==
X-Gm-Message-State: AOAM5339f/KtSbVKQZPJYuV/LmtqdSPiXEZVSnmGf3ppznFsek4m/VaF
        99noSLzmCpwysMOD3tkHH2XzhbjXB0or5j/lHOOUWQ==
X-Google-Smtp-Source: ABdhPJwzKJOJjZ60iNa61GaWBeT9+To763ExbTMXN2HmKulBGL0DIYAj65AkWG0zSOkuEi4Jw1feSDJ/wfLDRHCHlVI=
X-Received: by 2002:a92:c5ac:: with SMTP id r12mr2298152ilt.274.1598898109167;
 Mon, 31 Aug 2020 11:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200827063522.2563293-1-lokeshgidra@google.com>
 <20200827063522.2563293-3-lokeshgidra@google.com> <CAEjxPJ7rsyw=AkRUmnshF5gWygHEN1ahKi5uD9FtYovz0JRKCQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ7rsyw=AkRUmnshF5gWygHEN1ahKi5uD9FtYovz0JRKCQ@mail.gmail.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Mon, 31 Aug 2020 11:21:38 -0700
Message-ID: <CA+EESO7Rc5qKjPQ3Vh9=mJS+b2fJLnEY4_Zr06PWZJ-apC4Vfw@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] Teach SELinux about anonymous inodes
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Daniel Colascione <dancol@dancol.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        David Howells <dhowells@redhat.com>,
        Thomas Cedeno <thomascedeno@google.com>,
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
        SElinux list <selinux@vger.kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Calin Juravle <calin@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Nick Kralevich <nnk@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        kernel-team@android.com, Daniel Colascione <dancol@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 31, 2020 at 11:05 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Aug 27, 2020 at 2:35 AM Lokesh Gidra <lokeshgidra@google.com> wrote:
> >
> > From: Daniel Colascione <dancol@google.com>
> >
> > This change uses the anon_inodes and LSM infrastructure introduced in
> > the previous patch to give SELinux the ability to control
> > anonymous-inode files that are created using the new anon_inode_getfd_secure()
> > function.
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
> > Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> > Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > ---
> >  security/selinux/hooks.c            | 53 +++++++++++++++++++++++++++++
> >  security/selinux/include/classmap.h |  2 ++
> >  2 files changed, 55 insertions(+)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index a340986aa92e..b83f56e5ef40 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2926,6 +2926,58 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
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
> > +       if (unlikely(!selinux_state.initialized))
>
> This should use selinux_initialized(&selinux_state) instead.

Thanks for the review. I'll make the change in the next version.

Kindly have a look at other patches in the series as well.
