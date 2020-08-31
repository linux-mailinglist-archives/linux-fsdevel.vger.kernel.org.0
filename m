Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D294E258045
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 20:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbgHaSF7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 14:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgHaSFy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:05:54 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8217DC061573;
        Mon, 31 Aug 2020 11:05:54 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id e6so1750504oii.4;
        Mon, 31 Aug 2020 11:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fB2hgS86VUCnF7yNZR4pCTgsV4Yb+eIpZMc0LiTgDLY=;
        b=hzvT2JPT7Uk5rs2pbVB21bPgFFEF7nl+1cdFbDyOubsOI8kRapf0yRczK5zfxfWg4w
         zLYki7oh7AjCbHtDkh+qhTqyyjl2ZQDn60e5MmElvBWynA4feKWOwgappr263RlgQCFm
         2mWVvItWhFIIiv6wMyZ5Za+t174ujMTyVU0tum1LMZpuHO14ymMGvqQhe13d/YCMCuyD
         4hkfT/gJVeBAvVVBpuk0M+oaKIUmcFdssTihaHBnwnXO07S12/uWt16J9yt1PlRHkN7I
         pzVVxp2WrvqT2UeMooZYmQ28bvebX59rDL6lxsYhu2EvqHXCi6IOOCYYJi+ANSK86sLu
         HjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fB2hgS86VUCnF7yNZR4pCTgsV4Yb+eIpZMc0LiTgDLY=;
        b=qMf46AioisVhEp7He3MHs+6rcU1l489waYQq59bdfdraSamnlW9qGQrIysuX1XXYbD
         hmHjQCz+Mv6SwJCEvwbcwFHoqpKY+qxUyaoPmZUu9RrD5bhI5K+Ql8aTltwPPk2lTOud
         foSMtQMurMuIXvgc6YWtAZ9AbQypAj2G+ZW+UuVl+Mz0DD0ode85+30QwjS/qBPrpKOd
         uKEt+Z8kyvLGj+Zp3qSaOfkd0m93bhu/2cIfQT9wJYxe6ZLVw0bySDIOc4Sfl497DIo9
         aoNsytXruqBa2BQSYjZBtGQeF/Gu7Y+EEB5vZOVH4Y5Eye/OzD4Oa3d1w3+vfeCvUzHp
         0uTA==
X-Gm-Message-State: AOAM530zyaIZJkGxmVqOasOyRz7F0nzp3W9YENqbrOLEI6uubwmSEDaI
        2hDvaQHh3/1yPiBkn4zal2HY9ROFXc4YVMbE6So=
X-Google-Smtp-Source: ABdhPJz5/alq2jO11v8dvq3sxmEYW95eASbweizvDj75wygMmhwgpH2QV8JRAc9T0l1f6dfQRgAWn2dkXyTp5ewyOkM=
X-Received: by 2002:aca:4007:: with SMTP id n7mr328835oia.160.1598897153903;
 Mon, 31 Aug 2020 11:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200827063522.2563293-1-lokeshgidra@google.com> <20200827063522.2563293-3-lokeshgidra@google.com>
In-Reply-To: <20200827063522.2563293-3-lokeshgidra@google.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 31 Aug 2020 14:05:43 -0400
Message-ID: <CAEjxPJ7rsyw=AkRUmnshF5gWygHEN1ahKi5uD9FtYovz0JRKCQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] Teach SELinux about anonymous inodes
To:     Lokesh Gidra <lokeshgidra@google.com>
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
        SElinux list <selinux@vger.kernel.org>, kaleshsingh@google.com,
        calin@google.com, surenb@google.com,
        Nick Kralevich <nnk@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        kernel-team@android.com, Daniel Colascione <dancol@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 27, 2020 at 2:35 AM Lokesh Gidra <lokeshgidra@google.com> wrote:
>
> From: Daniel Colascione <dancol@google.com>
>
> This change uses the anon_inodes and LSM infrastructure introduced in
> the previous patch to give SELinux the ability to control
> anonymous-inode files that are created using the new anon_inode_getfd_secure()
> function.
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
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  security/selinux/hooks.c            | 53 +++++++++++++++++++++++++++++
>  security/selinux/include/classmap.h |  2 ++
>  2 files changed, 55 insertions(+)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index a340986aa92e..b83f56e5ef40 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2926,6 +2926,58 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
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
> +       if (unlikely(!selinux_state.initialized))

This should use selinux_initialized(&selinux_state) instead.
