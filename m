Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65ECC2ADE32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 19:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgKJSYl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 13:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgKJSYk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:24:40 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE8FC0613D1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2020 10:24:40 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id s10so15303048ioe.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Nov 2020 10:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IOH6J0YBVkmN1dduOdBptrakAtOt/X1RoVotGiwpplM=;
        b=nAZHLD1wNP2fywJokk4jgbvk40kb3W2SbHy4upVPJeYV6HVMkSU/HRg/PRVlU06Whz
         TALsPG/RgWYNQaPhVD/mknthvlJLWXZmM8xFta7xjpCmDH2a5I4fbv+eznlGUH4TrYDH
         4vIj+/LT4oB+UrNBVuEtAl03K1E0htqAnJ8MU0AOxxhID/b+BUSNS8Eod2sMZbSkOx8a
         TelU7TsRBNw9xR2Pz5v6NRRb9E/LZNTFQDmmUamW1ySUZl59u6suJxcyMlRAQOkG4KO0
         3m7K9iKSKI4mvTy+R8emuvMO2KhsIlRIZWbqL9Zf8l4tyclS6Oibaqo8kL9gt1C6hE5R
         shUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IOH6J0YBVkmN1dduOdBptrakAtOt/X1RoVotGiwpplM=;
        b=BKwJTnro4gG8lFMs4XwRzRutdxvTXXagXTyfGPbuSwlsll+TEG59qq7cXe+exL3Pwj
         xPetYnigR9ZOF7pIlPYtGbu5sCgmT8j3ztLa9IdA9aFH+XHhqUyiFCmvxSLWWh6TSUhG
         dpqb9qgJQnMY20xvLW+mjBLjpZVIqjIzT3jyx2bwa6qUakSiE/9XPe80SPEP+F3CHcxW
         RyvZ5+rQ2n6LT/amnUx1qfznJ0rwtb8sSSQKovz4Qiz73s8yMvLNdZ/fTwwyNIHLDlPE
         SadIEggiKub0OSIF2iIapOLNLO3JNklE8oh6Gzpw1U+nDtxY2EVqh0k8HUZa9YWJHZVj
         KVCQ==
X-Gm-Message-State: AOAM531oqEzn4vmIB2hNGjW6LvsueNweO/sxHhTF4KrDvi2u9bgCcYaZ
        qB1llEFYWwSu/DVHYDobbDXZf8IvsvK4iGh3rWQjxw==
X-Google-Smtp-Source: ABdhPJzYF7f15PCApiJG/Ryo7Fp4i0qaDqB/n4P56vFp3U6LWxeDHbRvZ+rktmtpVpMpeygK6GoiZGFWsmugurZHzY4=
X-Received: by 2002:a6b:3fd4:: with SMTP id m203mr15357830ioa.25.1605032679312;
 Tue, 10 Nov 2020 10:24:39 -0800 (PST)
MIME-Version: 1.0
References: <20201106155626.3395468-1-lokeshgidra@google.com>
 <20201106155626.3395468-4-lokeshgidra@google.com> <CAHC9VhRsaE5vhcSMr5nYzrHrM6Pc5-JUErNfntsRrPjKQNALxw@mail.gmail.com>
In-Reply-To: <CAHC9VhRsaE5vhcSMr5nYzrHrM6Pc5-JUErNfntsRrPjKQNALxw@mail.gmail.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Tue, 10 Nov 2020 10:24:28 -0800
Message-ID: <CA+EESO7LuRM_MH9z=BhLbWJrxMvnepq-NSTu_UJsPXxc0QkEag@mail.gmail.com>
Subject: Re: [PATCH v12 3/4] selinux: teach SELinux about anonymous inodes
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
        "Cc: Android Kernel" <kernel-team@android.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>, hch@infradead.org,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks a lot Paul for the reviewing this patch.

On Mon, Nov 9, 2020 at 7:12 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Fri, Nov 6, 2020 at 10:56 AM Lokesh Gidra <lokeshgidra@google.com> wrote:
> >
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
> >  security/selinux/hooks.c            | 53 +++++++++++++++++++++++++++++
> >  security/selinux/include/classmap.h |  2 ++
> >  2 files changed, 55 insertions(+)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 6b1826fc3658..1c0adcdce7a8 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2927,6 +2927,58 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
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
> > +               isec->sclass = context_isec->sclass;
> > +               isec->sid = context_isec->sid;
>
> I suppose this isn't a major concern given the limited usage at the
> moment, but I wonder if it would be a good idea to make sure the
> context_inode's SELinux label is valid before we assign it to the
> anonymous inode?  If it is invalid, what should we do?  Do we attempt
> to (re)validate it?  Do we simply fallback to the transition approach?
>
Frankly, I'm not too familiar with SELinux. Originally this patch
series was developed by Daniel, in consultation with Stephen Smalley.
In my (probably naive) opinion we should fallback to transition
approach. But I'd request you to tell me if this needs to be addressed
now, and if so then what's the right approach.

If the decision is to address this now, then what's the best way to
check the SELinux label validity?

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
> > +                           FILE__CREATE,
>
> I believe you want to use ANON_INODE__CREATE here instead of FILE__CREATE, yes?

ANON_INODE__CREATE definitely seems more appropriate. I'll change it
in the next revision.
>
> This brings up another question, and requirement - what testing are
> you doing for this patchset?  We require that new SELinux kernel
> functionality includes additions to the SELinux test suite to help
> verify the functionality.  I'm also *strongly* encouraging that new
> contributions come with updates to The SELinux Notebook.  If you are
> unsure about what to do for either, let us know and we can help get
> you started.
>
> * https://github.com/SELinuxProject/selinux-testsuite
> * https://github.com/SELinuxProject/selinux-notebook
>
I'd definitely need help with both of these. Kindly guide how to proceed.

> > +                           &ad);
> > +}
> > +
> >  static int selinux_inode_create(struct inode *dir, struct dentry *dentry, umode_t mode)
> >  {
> >         return may_create(dir, dentry, SECCLASS_FILE);
> > @@ -6992,6 +7044,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
> >
> >         LSM_HOOK_INIT(inode_free_security, selinux_inode_free_security),
> >         LSM_HOOK_INIT(inode_init_security, selinux_inode_init_security),
> > +       LSM_HOOK_INIT(inode_init_security_anon, selinux_inode_init_security_anon),
> >         LSM_HOOK_INIT(inode_create, selinux_inode_create),
> >         LSM_HOOK_INIT(inode_link, selinux_inode_link),
> >         LSM_HOOK_INIT(inode_unlink, selinux_inode_unlink),
> > diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> > index 40cebde62856..ba2e01a6955c 100644
> > --- a/security/selinux/include/classmap.h
> > +++ b/security/selinux/include/classmap.h
> > @@ -249,6 +249,8 @@ struct security_class_mapping secclass_map[] = {
> >           {"open", "cpu", "kernel", "tracepoint", "read", "write"} },
> >         { "lockdown",
> >           { "integrity", "confidentiality", NULL } },
> > +       { "anon_inode",
> > +         { COMMON_FILE_PERMS, NULL } },
> >         { NULL }
> >    };
> >
>
> --
> paul moore
> www.paul-moore.com
