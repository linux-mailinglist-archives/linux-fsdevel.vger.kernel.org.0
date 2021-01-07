Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D182EC8D1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 04:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbhAGDEf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jan 2021 22:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbhAGDEe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jan 2021 22:04:34 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8AAC0612F1
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Jan 2021 19:03:54 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id x16so7798783ejj.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Jan 2021 19:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6kwvfWjFnH4Pc0zsg+cAo49RaImmwcqEmlwY0Dyffcs=;
        b=M11mc+jiW0OYQkc9/dR28NTijrEoOw94j/VOx8Dg07F4MK1+HH6XznVqn9brS7Tmwn
         VZm/q6ON2mOW031Dx5roB5u0XEecDdQ2Alw/urDCe2ZqbsJoKEAJb/XOsX2cjhJpn+tj
         6Cvc74oeTvrjgZ0SBGJvMJOShhHnp01lTaSKxIqJpaSXGUMp2xFnBIBh4ZBvL9VOlQFc
         AL5v3K9JuY4NKBbhAko+8UuCxMJHDBldsqPzgGwiJfGWhVmHo5EvIvvosgAvJtBJz2Rz
         g8RoSYbnLb5SG2lykH7nZ+qGq6TexpA5lxLk+RXeQMoSbpNbYGkh1dufOfQRPUy1NpQ2
         zitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6kwvfWjFnH4Pc0zsg+cAo49RaImmwcqEmlwY0Dyffcs=;
        b=T4gJgpRnlbsQMaSyacLxEaBZ4fFiZXBqTqxnKS8t97FdF53/mXZP6Wh6Zr6BHoP9y5
         ykN9PndARtQZyV03e+4d2HnaKmfbNT3SP22OVlOs5YHM9Qi9R4ABZgRasZrab8pnBLhZ
         FZwh6jpXIM0f715NwCdmXlOvNdWlptHmJ3GaRKwKFHFVwRkmL/w7T/3tlZz9KIO8ovcG
         NW+eif/TWBIs65iVXK/gBxnCvGtOAjfUZ3VmaWnKyppO8dgvsMHUIWZJtiYIzGCk9pV0
         JcCJDNKohFLzWS0guGw1+SawnFoB3IeeWOECfNNs5arjwmbohxW4X5YbiT4H+pAweVQ/
         MmIQ==
X-Gm-Message-State: AOAM5326Zh+GqLtT3APNX012BQDxxcsvQjL+RFZPR65Q4NppK//OfB0e
        KscaBoTGCgrAfSEU4Fqn/Jq78LfbfM0EpENnUrrl
X-Google-Smtp-Source: ABdhPJxIp98KdT+UjIT3+fzknjc5WNT9ayzrPwNK/r34lZvPzfuCHqHbVQNUYHSOPAYOY3LHLdNuze3frO0LGlwZTbk=
X-Received: by 2002:a17:906:aec6:: with SMTP id me6mr4825292ejb.542.1609988632573;
 Wed, 06 Jan 2021 19:03:52 -0800 (PST)
MIME-Version: 1.0
References: <20201112015359.1103333-1-lokeshgidra@google.com> <20201112015359.1103333-4-lokeshgidra@google.com>
In-Reply-To: <20201112015359.1103333-4-lokeshgidra@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 6 Jan 2021 22:03:41 -0500
Message-ID: <CAHC9VhS2WNXn2cVAUcAY5AmmBv+=XsthCevofNNuEOU3=jtLrg@mail.gmail.com>
Subject: Re: [PATCH v13 3/4] selinux: teach SELinux about anonymous inodes
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
        jeffv@google.com, kernel-team@android.com, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>, hch@infradead.org,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 11, 2020 at 8:54 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
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
>  security/selinux/hooks.c            | 56 +++++++++++++++++++++++++++++
>  security/selinux/include/classmap.h |  2 ++
>  2 files changed, 58 insertions(+)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 6b1826fc3658..d092aa512868 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2927,6 +2927,61 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
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
> +               if (context_isec->initialized != LABEL_INITIALIZED)
> +                       return -EACCES;
> +
> +               isec->sclass = context_isec->sclass;

Taking the object class directly from the context_inode is
interesting, and I suspect problematic.  In the case below where no
context_inode is supplied the object class is set to
SECCLASS_ANON_INODE, which is correct, but when a context_inode is
supplied there is no guarantee that the object class will be set to
SECCLASS_ANON_INODE.  This could both pose a problem for policy
writers (how do you distinguish the anon inode from other normal file
inodes in this case?) as well as an outright fault later in this
function when we try to check the ANON_INODE__CREATE on an object
other than a SECCLASS_ANON_INODE object.

It works in the userfaultfd case because the context_inode is
originally created with this function so the object class is correctly
set to SECCLASS_ANON_INODE, but can we always guarantee that to be the
case?  Do we ever need or want to support using a context_inode that
is not SECCLASS_ANON_INODE?

> +               isec->sid = context_isec->sid;
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
> +                           ANON_INODE__CREATE,
> +                           &ad);
> +}

-- 
paul moore
www.paul-moore.com
