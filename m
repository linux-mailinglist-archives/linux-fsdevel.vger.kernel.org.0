Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172C72EF84D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 20:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbhAHTkV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 14:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728823AbhAHTkU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 14:40:20 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C8BC061381;
        Fri,  8 Jan 2021 11:39:39 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id h205so25644560lfd.5;
        Fri, 08 Jan 2021 11:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lRRuQiPCIIeRicvu+E7yQv5jDQB4era/dfVIHrx38PY=;
        b=DDK07p/ZKmZovcAoUiUjhPZ9+WCGC807tO2pvPWlhUi9UtECGHDga2OUiQLvFRW6m1
         CL7YpLNNsh3TSClAeQ/dcSMdqb7lPU03rY1tDf2yHm+w0ax3yV318Yy5oPz3DyHPicTI
         vmAGuZP3ws04WKr1+0mzPdwnygTMRJx0+iB6AAiBfXZc15OrNwotlxr94ltS3El5Ph1R
         5WYgAdo103laqbvVr/QRVJacC46ys3XZ59rB6XDiSWFlvy8CFIN7IpE4eHnbipMfAj4j
         9YLrGXSg4oVXIGeWUrPWGEnZJXsHYmpMQZxKHYjAY2W5nH/ttP52YDraR9DHsNuOMRyg
         ykbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lRRuQiPCIIeRicvu+E7yQv5jDQB4era/dfVIHrx38PY=;
        b=ZhIR0Oh2KDcSKN9sjDRGrFvTbTp4ISpFG6cm3D6DrokHQGTFwcgWQYvjKEZfAUniXx
         /u4nibnr3VpSpvoLnhyqdSqLLFOdZjclucc+2KoQV4ybfWo/iFbCzx/+Cz9mSZiAJuoO
         EuE0ewc8hd8McxWvVWjBNRE9DEDrf/oRZ5NUb2YQaTjhkzYI6OwaFV6riUObBEPrPVnk
         HAEI+hHNtwZsEBxznB3MKArbhyrfifmut7utUTjHeIxCPV2uNmN+Raeusm8cYtJaVJFW
         w0aWMqHIkK9c6TK1QeZZbs4uhC75oHuxaourNGOI8rKev4pSu5f7skpjB0h7oN9n9uvN
         HNCA==
X-Gm-Message-State: AOAM530B0inqi06mPJ2jRMoLfcntEE14efkpToEPpE8BVFwncKu9yhQ2
        pXj80omPGaDfey3wUKqbIekOsd+C1OGTdt83t8I=
X-Google-Smtp-Source: ABdhPJzp+tchs1WxNnpCyQKdVwlmdW4339VLO6VpJKuxPGqACDJSvoyrCRLpOfnZNEuPynu3i6RydgSvS62GOLzl5A8=
X-Received: by 2002:a2e:b949:: with SMTP id 9mr2033333ljs.376.1610134778285;
 Fri, 08 Jan 2021 11:39:38 -0800 (PST)
MIME-Version: 1.0
References: <20210108053259.726613-1-lokeshgidra@google.com> <20210108053259.726613-4-lokeshgidra@google.com>
In-Reply-To: <20210108053259.726613-4-lokeshgidra@google.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 8 Jan 2021 14:39:26 -0500
Message-ID: <CAEjxPJ5Z8X02J-qvETuhDSHqgnORYiG=dmsTPGYfYtyusdRz1A@mail.gmail.com>
Subject: Re: [PATCH v14 3/4] selinux: teach SELinux about anonymous inodes
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
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
        SElinux list <selinux@vger.kernel.org>, kaleshsingh@google.com,
        Calin Juravle <calin@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        kernel-team@android.com, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 8, 2021 at 12:33 AM Lokesh Gidra <lokeshgidra@google.com> wrote:
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
>  security/selinux/hooks.c            | 59 +++++++++++++++++++++++++++++
>  security/selinux/include/classmap.h |  2 +
>  2 files changed, 61 insertions(+)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 644b17ec9e63..8b4e155b2930 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2934,6 +2933,63 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
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
> +       isec->initialized = LABEL_INITIALIZED;
> +       isec->sclass = SECCLASS_ANON_INODE;
> +
> +       if (context_inode) {
> +               struct inode_security_struct *context_isec =
> +                       selinux_inode(context_inode);
> +               if (context_isec->initialized != LABEL_INITIALIZED)
> +                       return -EACCES;
> +               if (context_isec->sclass != SECCLASS_ANON_INODE) {
> +                       pr_err("SELinux:  initializing anonymous inode with non-anonymous inode");
> +                       return -EACCES;
> +               }

This would preclude using this facility for anonymous inodes created
by kvm and other use cases.
Don't do this.

> +
> +               isec->sid = context_isec->sid;
> +       } else {
> +               rc = security_transition_sid(
> +                       &selinux_state, tsec->sid, tsec->sid,
> +                       isec->sclass, name, &isec->sid);
> +               if (rc)
> +                       return rc;
> +       }
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
> +                           ANON_INODE__CREATE,

FILE__CREATE is perfectly appropriate here, not that it makes any difference.
