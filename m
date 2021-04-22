Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2496E36815F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Apr 2021 15:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236363AbhDVNVz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Apr 2021 09:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235830AbhDVNVz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Apr 2021 09:21:55 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE55C06174A;
        Thu, 22 Apr 2021 06:21:20 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y4so31924184lfl.10;
        Thu, 22 Apr 2021 06:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PHTEUlxqgA8l0F2eLJhm0lUslDtS68hTg+QYS24mt1A=;
        b=W7OhzBe3tGUvNLBkODmWurcIqydRnEopd0uCZ7QbiU0h8VJODUAOgr/3XEF92VflWL
         TXceQfgaNdpDg1UZRmbzPTG/0L4PlAQgTVuPAwopTgPlwj5U+BeXZQoSRaUL5ma+2bCC
         vsH3TBHRwlPoNzyhQfT99Nn97tBv4CiuPKbmQNBy03lBXBKQm8jTqQmuGDxl9wzOuHOu
         CHODrbcVzlu+LM35gAf1pN09cFuWMk9cdrJwBiAi/STbb+w6F2eLveY8XqqJLod9m8QX
         LhegfL4CHs7Cqsan2vBBPlw32MMwx6zv5p5LSqjAhg3Ni6jqTuu1XKMo0Mw/2vgyoUtF
         q6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PHTEUlxqgA8l0F2eLJhm0lUslDtS68hTg+QYS24mt1A=;
        b=b5D21r/VO6XvpFHwVDDGnwP++n2sr6T8y4GVR57JINanzuQlTwM3mLW6s9Y/935ePK
         bhVKgvNMwEbPUkHzMrG45DJSqEd4VU02kDkWB829SWsFzSsJs2afzTffp+8/XPB9Xvv1
         KSruMrAfk13Rz/XWcheZDgA7rNjOTgwj63LQmlZFnuFfm4yEWVpeDO66Lw6A+JzJpCWb
         LrF8YZa+cR/vsyFpIMrH+qYBbZFtIP3OQsdkSTrVU16x18QCcPJHCXHkJhfLdYERx5Ma
         pam1YN5bg3eMRqTGE2blo6EUeZpm0zSlYLIzou78khtQtkzJMHhR03nQKT1HtgmcJSsX
         T+yA==
X-Gm-Message-State: AOAM532KFlXa64Trvt/Rz/vzImEFax8NFOsJ3jyVbpsh7TuTrb2k0qX5
        /1kP6j8G1LxIEE4X3azrACop1AsccWQ2lxBHSRz54KAaOBY=
X-Google-Smtp-Source: ABdhPJzchxlr8SAqDCJEYfgZJ8QXE6CDSC4eSAy8LD85f/vmqWZ1RAbHO7YYaqobzfkUvRLmAMfCh19ckF2iWAe3l5w=
X-Received: by 2002:ac2:43c5:: with SMTP id u5mr2441430lfl.40.1619097678746;
 Thu, 22 Apr 2021 06:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210421171446.785507-1-omosnace@redhat.com> <20210421171446.785507-3-omosnace@redhat.com>
In-Reply-To: <20210421171446.785507-3-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 22 Apr 2021 09:21:07 -0400
Message-ID: <CAEjxPJ5ksqrafO8uaf3jR=cjU5JnyQYmn_57skp=WXz7-RcbVQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] selinux: add capability to map anon inode types
 to separate classes
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lokesh Gidra <lokeshgidra@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 21, 2021 at 1:14 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Unfortunately, the approach chosen in commit 29cd6591ab6f ("selinux:
> teach SELinux about anonymous inodes") to use a single class for all
> anon inodes and let the policy distinguish between them using named
> transitions turned out to have a rather unfortunate drawback.
>
> For example, suppose we have two types of anon inodes, "A" and "B", and
> we want to allow a set of domains (represented by an attribute "attr_x")
> certain set of permissions on anon inodes of type "A" that were created
> by the same domain, but at the same time disallow this set to access
> anon inodes of type "B" entirely. Since all inodes share the same class
> and we want to distinguish both the inode types and the domains that
> created them, we have no choice than to create separate types for the
> cartesian product of (domains that belong to attr_x) x ("A", "B") and
> add all the necessary allow and transition rules for each domain
> individually.
>
> This makes it very impractical to write sane policies for anon inodes in
> the future, as more anon inode types are added. Therefore, this patch
> implements an alternative approach that assigns a separate class to each
> type of anon inode. This allows the example above to be implemented
> without any transition rules and with just a single allow rule:
>
> allow attr_x self:A { ... };
>
> In order to not break possible existing users of the already merged
> original approach, this patch also adds a new policy capability
> "extended_anon_inode_class" that needs to be set by the policy to enable
> the new behavior.
>
> I decided to keep the named transition mechanism in the new variant,
> since there might eventually be some extra information in the anon inode
> name that could be used in transitions.
>
> One minor annoyance is that the kernel still expects the policy to
> provide both classes (anon_inode and userfaultfd) regardless of the
> capability setting and if one of them is not defined in the policy, the
> kernel will print a warning when loading the policy. However, it doesn't
> seem worth to work around that in the kernel, as the policy can provide
> just the definition of the unused class(es) (and permissions) to avoid
> this warning. Keeping the legacy anon_inode class with some fallback
> rules may also be desirable to keep the policy compatible with kernels
> that only support anon_inode.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

NAK.  We do not want to introduce a new security class for every user
of anon inodes - that isn't what security classes are for.
For things like kvm device inodes, those should ultimately use the
inherited context from the related inode (the /dev/kvm inode itself).
That was the original intent of supporting the related inode.

> ---
>  security/selinux/hooks.c                   | 27 +++++++++++++++++++++-
>  security/selinux/include/classmap.h        |  2 ++
>  security/selinux/include/policycap.h       |  1 +
>  security/selinux/include/policycap_names.h |  3 ++-
>  security/selinux/include/security.h        |  7 ++++++
>  5 files changed, 38 insertions(+), 2 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index dc57ba21d8ff..20a8d7d17936 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3079,7 +3079,32 @@ static int selinux_inode_init_security_anon(struct inode *inode,
>                 isec->sclass = context_isec->sclass;
>                 isec->sid = context_isec->sid;
>         } else {
> -               isec->sclass = SECCLASS_ANON_INODE;
> +               /*
> +                * If the check below fails:
> +                *  1. Add the corresponding security class to
> +                *     security/selinux/include/classmap.h
> +                *  2. Map the new LSM_ANON_INODE_* value to the class in
> +                *     the switch statement below.
> +                *  3. Update the RHS of the comparison in the BUILD_BUG_ON().
> +                *  4. CC selinux@vger.kernel.org and
> +                *     linux-security-module@vger.kernel.org when submitting
> +                *     the patch or in case of any questions.
> +                */
> +               BUILD_BUG_ON(LSM_ANON_INODE_MAX > LSM_ANON_INODE_USERFAULTFD);
> +
> +               if (selinux_policycap_extended_anon_inode()) {
> +                       switch (type) {
> +                       case LSM_ANON_INODE_USERFAULTFD:
> +                               isec->sclass = SECCLASS_USERFAULTFD;
> +                               break;
> +                       default:
> +                               pr_err("SELinux:  got invalid anon inode type: %d",
> +                                      (int)type);
> +                               return -EINVAL;
> +                       }
> +               } else {
> +                       isec->sclass = SECCLASS_ANON_INODE;
> +               }
>                 rc = security_transition_sid(
>                         &selinux_state, tsec->sid, tsec->sid,
>                         isec->sclass, name, &isec->sid);
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index ba2e01a6955c..e4308cad6407 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -251,6 +251,8 @@ struct security_class_mapping secclass_map[] = {
>           { "integrity", "confidentiality", NULL } },
>         { "anon_inode",
>           { COMMON_FILE_PERMS, NULL } },
> +       { "userfaultfd",
> +         { COMMON_FILE_PERMS, NULL } },
>         { NULL }
>    };
>
> diff --git a/security/selinux/include/policycap.h b/security/selinux/include/policycap.h
> index 2ec038efbb03..969804bd6dab 100644
> --- a/security/selinux/include/policycap.h
> +++ b/security/selinux/include/policycap.h
> @@ -11,6 +11,7 @@ enum {
>         POLICYDB_CAPABILITY_CGROUPSECLABEL,
>         POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION,
>         POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS,
> +       POLICYDB_CAPABILITY_EXTENDED_ANON_INODE_CLASS,
>         __POLICYDB_CAPABILITY_MAX
>  };
>  #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
> diff --git a/security/selinux/include/policycap_names.h b/security/selinux/include/policycap_names.h
> index b89289f092c9..78651990425e 100644
> --- a/security/selinux/include/policycap_names.h
> +++ b/security/selinux/include/policycap_names.h
> @@ -12,7 +12,8 @@ const char *selinux_policycap_names[__POLICYDB_CAPABILITY_MAX] = {
>         "always_check_network",
>         "cgroup_seclabel",
>         "nnp_nosuid_transition",
> -       "genfs_seclabel_symlinks"
> +       "genfs_seclabel_symlinks",
> +       "extended_anon_inode_class",
>  };
>
>  #endif /* _SELINUX_POLICYCAP_NAMES_H_ */
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index 7130c9648ad1..4fb75101aca4 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -219,6 +219,13 @@ static inline bool selinux_policycap_genfs_seclabel_symlinks(void)
>         return READ_ONCE(state->policycap[POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS]);
>  }
>
> +static inline bool selinux_policycap_extended_anon_inode(void)
> +{
> +       struct selinux_state *state = &selinux_state;
> +
> +       return READ_ONCE(state->policycap[POLICYDB_CAPABILITY_EXTENDED_ANON_INODE_CLASS]);
> +}
> +
>  int security_mls_enabled(struct selinux_state *state);
>  int security_load_policy(struct selinux_state *state,
>                         void *data, size_t len,
> --
> 2.30.2
>
