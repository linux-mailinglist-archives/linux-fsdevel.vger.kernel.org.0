Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5661F2ACB85
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 04:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbgKJDMr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 22:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgKJDMr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 22:12:47 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE510C0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Nov 2020 19:12:46 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id cw8so15363456ejb.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Nov 2020 19:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xzmJsWC6dWZQj1XvWO6xJYEz8vIsIxpieR4F7Jap3XY=;
        b=dxZP5LurjoMY+67L6FJnXmxEHoYPw16qhZAeOyWG1ERPn886+jasIPgXr/LCZ57Mps
         Isrxb9tNDyGDxpGtiHj+f3ObDkYNk1lcDzVOMJTkdsVyy69uePT5mT6b2prUhBEMf024
         ZNmPI5b/9pt22TjuKOK87RYl1qeaY7H7dDPx+F1W5i84695rG+cWGjtTREBoaZu3K95S
         /h81TSnDH8J9EozxG6K23XEfvG23QiG3MgIk3K6fv0sLD6LIA7YnvdtHeZPAxNUjFgoo
         yrIRf9S9ue3GKiGjICrWDc7M+Yo0DoY1r1tx6/iSYoWEd/TIccktxDGww6KuTXOg4gR2
         nwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xzmJsWC6dWZQj1XvWO6xJYEz8vIsIxpieR4F7Jap3XY=;
        b=pb2MJd6nINu4S3ZIixo2Odgv1paZ/z9+CzqMTjh6xBKII39JSCynYoSIhNi70UgH87
         T80cY0G/lkzShkN2iCiFD2LzuRxFBmfySbYhzTZDzx+HKmpJKxAOlLBxZNjrLX67+l2O
         noQeEkd9H4h/rdWk/wksrn8FR2CRgPZO///dulXIlw4CmQh1QhfaRRFt5LET3UDLyzUY
         jFlx8z4X8fcjcPrwdnL59GRwTghJ7K0tjrkLhg+OVBW3Gab+c0gihIACYjPj8w6+7Ly2
         kRigsEnvf+9Zs7KzVfimQFM2K9S2sinCRXzrCY7ajtcXQKS0vBM+v9dGc3gUn39wrWwK
         /21g==
X-Gm-Message-State: AOAM531MxXl/u4SzeHhdWpxH3v70fXQC88TK+l/DwmzItzufPgwmAgmC
        0q1XmvvMMfpnUJUu0iy+hRxv8qIxeH5qBBx0bdtJ
X-Google-Smtp-Source: ABdhPJwwIF3MO5LzJ511u4gGvvNF5oo9ZS75tqCLNPpgISHowPuMkNw8MRxvsVJXmkkSV3eBigJKDIMAg0vIkBWE8KU=
X-Received: by 2002:a17:906:c096:: with SMTP id f22mr17581308ejz.488.1604977965148;
 Mon, 09 Nov 2020 19:12:45 -0800 (PST)
MIME-Version: 1.0
References: <20201106155626.3395468-1-lokeshgidra@google.com> <20201106155626.3395468-4-lokeshgidra@google.com>
In-Reply-To: <20201106155626.3395468-4-lokeshgidra@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 9 Nov 2020 22:12:33 -0500
Message-ID: <CAHC9VhRsaE5vhcSMr5nYzrHrM6Pc5-JUErNfntsRrPjKQNALxw@mail.gmail.com>
Subject: Re: [PATCH v12 3/4] selinux: teach SELinux about anonymous inodes
To:     Lokesh Gidra <lokeshgidra@google.com>
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
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        kaleshsingh@google.com, calin@google.com, surenb@google.com,
        nnk@google.com, jeffv@google.com, kernel-team@android.com,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        hch@infradead.org, Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 6, 2020 at 10:56 AM Lokesh Gidra <lokeshgidra@google.com> wrote:
>
> From: Daniel Colascione <dancol@google.com>
>
> This change uses the anon_inodes and LSM infrastructure introduced in
> the previous patches to give SELinux the ability to control
> anonymous-inode files that are created using the new
> anon_inode_getfd_secure() function.
>
> A SELinux policy author detects and controls these anonymous inodes by
> adding a name-based type_transition rule that assigns a new security
> type to anonymous-inode files created in some domain. The name used
> for the name-based transition is the name associated with the
> anonymous inode for file listings --- e.g., "[userfaultfd]" or
> "[perf_event]".
>
> Example:
>
> type uffd_t;
> type_transition sysadm_t sysadm_t : anon_inode uffd_t "[userfaultfd]";
> allow sysadm_t uffd_t:anon_inode { create };
>
> (The next patch in this series is necessary for making userfaultfd
> support this new interface.  The example above is just
> for exposition.)
>
> Signed-off-by: Daniel Colascione <dancol@google.com>
> Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> ---
>  security/selinux/hooks.c            | 53 +++++++++++++++++++++++++++++
>  security/selinux/include/classmap.h |  2 ++
>  2 files changed, 55 insertions(+)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 6b1826fc3658..1c0adcdce7a8 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2927,6 +2927,58 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
>         return 0;
>  }
>
> +static int selinux_inode_init_security_anon(struct inode *inode,
> +                                           const struct qstr *name,
> +                                           const struct inode *context_inode)
> +{
> +       const struct task_security_struct *tsec = selinux_cred(current_cred());
> +       struct common_audit_data ad;
> +       struct inode_security_struct *isec;
> +       int rc;
> +
> +       if (unlikely(!selinux_initialized(&selinux_state)))
> +               return 0;
> +
> +       isec = selinux_inode(inode);
> +
> +       /*
> +        * We only get here once per ephemeral inode.  The inode has
> +        * been initialized via inode_alloc_security but is otherwise
> +        * untouched.
> +        */
> +
> +       if (context_inode) {
> +               struct inode_security_struct *context_isec =
> +                       selinux_inode(context_inode);
> +               isec->sclass = context_isec->sclass;
> +               isec->sid = context_isec->sid;

I suppose this isn't a major concern given the limited usage at the
moment, but I wonder if it would be a good idea to make sure the
context_inode's SELinux label is valid before we assign it to the
anonymous inode?  If it is invalid, what should we do?  Do we attempt
to (re)validate it?  Do we simply fallback to the transition approach?

> +       } else {
> +               isec->sclass = SECCLASS_ANON_INODE;
> +               rc = security_transition_sid(
> +                       &selinux_state, tsec->sid, tsec->sid,
> +                       isec->sclass, name, &isec->sid);
> +               if (rc)
> +                       return rc;
> +       }
> +
> +       isec->initialized = LABEL_INITIALIZED;
> +
> +       /*
> +        * Now that we've initialized security, check whether we're
> +        * allowed to actually create this type of anonymous inode.
> +        */
> +
> +       ad.type = LSM_AUDIT_DATA_INODE;
> +       ad.u.inode = inode;
> +
> +       return avc_has_perm(&selinux_state,
> +                           tsec->sid,
> +                           isec->sid,
> +                           isec->sclass,
> +                           FILE__CREATE,

I believe you want to use ANON_INODE__CREATE here instead of FILE__CREATE, yes?

This brings up another question, and requirement - what testing are
you doing for this patchset?  We require that new SELinux kernel
functionality includes additions to the SELinux test suite to help
verify the functionality.  I'm also *strongly* encouraging that new
contributions come with updates to The SELinux Notebook.  If you are
unsure about what to do for either, let us know and we can help get
you started.

* https://github.com/SELinuxProject/selinux-testsuite
* https://github.com/SELinuxProject/selinux-notebook

> +                           &ad);
> +}
> +
>  static int selinux_inode_create(struct inode *dir, struct dentry *dentry, umode_t mode)
>  {
>         return may_create(dir, dentry, SECCLASS_FILE);
> @@ -6992,6 +7044,7 @@ static struct security_hook_list selinux_hooks[] __lsm_ro_after_init = {
>
>         LSM_HOOK_INIT(inode_free_security, selinux_inode_free_security),
>         LSM_HOOK_INIT(inode_init_security, selinux_inode_init_security),
> +       LSM_HOOK_INIT(inode_init_security_anon, selinux_inode_init_security_anon),
>         LSM_HOOK_INIT(inode_create, selinux_inode_create),
>         LSM_HOOK_INIT(inode_link, selinux_inode_link),
>         LSM_HOOK_INIT(inode_unlink, selinux_inode_unlink),
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index 40cebde62856..ba2e01a6955c 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -249,6 +249,8 @@ struct security_class_mapping secclass_map[] = {
>           {"open", "cpu", "kernel", "tracepoint", "read", "write"} },
>         { "lockdown",
>           { "integrity", "confidentiality", NULL } },
> +       { "anon_inode",
> +         { COMMON_FILE_PERMS, NULL } },
>         { NULL }
>    };
>

-- 
paul moore
www.paul-moore.com
