Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4A62F36D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 18:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391722AbhALRQT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 12:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391110AbhALRQS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 12:16:18 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51324C061795
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jan 2021 09:15:37 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id e18so3131950ejt.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jan 2021 09:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tlN+SR1GxJrZealRnBj4IK5rirhuxkSGuR3XMgHjbM8=;
        b=2JSJLgjjYoRmh4WKyhvwd7P5EYDVodgao689juYrDTUOryxHHdbBFMvk6F49hQeANI
         0ncsHC6TWKiQttECpHZrIyibJPz+veA90aIDcBmWL8CoCxSzcbVkT+1W9ZlazKYMz/h2
         1U+NJdpU2NaPSMv/3Vcpq2YAuJEHuqV6eG6jOOiBvDIozHbxI3BklrmCl45uL2220jUW
         ESl6nOXuVqKatMmHbrqSdiXJkN9Pim4J5Ue8lUTHALCuTETNbMgXoLGGXl/x8o30mu7E
         c4TyKsipejVO9TqPCAFj2Ot6gBV0ui2tytc4Nb1V65qr081j32kxNtvVrCJ0L/mppkvw
         eXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tlN+SR1GxJrZealRnBj4IK5rirhuxkSGuR3XMgHjbM8=;
        b=FVPfuy8YpFjKVwj3LhR2RbuoK+mRy1OO9gxxyXRv17qOH+VnHiWizwoIqRF0u/IJn1
         8Un4abaEYO+BPyfVNRnA6nAKk+CUlgyjg2ZeEnuGBiPThFBRsMKv3GOWUGh7YwlnvViE
         btg09mPjyU7XbneTHLyCzkD7KoP4heaUK8ZqASjDfxbEJBr6xWCF7QEHdfQDhBney8nr
         zsd/gh6FSh6siWRt79aVnlZUBJGC0nkK1DquVva8oy/n4PwBTrvBpwqI3ZIS9hgaisbp
         D8A0BLZ5hFmZV+Md10F9oep/kvWGB+k+jzi729T6wbynx2auCqQZDNxBiZwpNoPfIVtR
         sAvg==
X-Gm-Message-State: AOAM531Akc2g8fWM2gMf0wb7DNCYMEBY+ARA09/6Wd36oIg5fg+1+ZXh
        LoVNscQKsOGSmgeCdqYRDUh/6PHoYU0ACb/d4c8+
X-Google-Smtp-Source: ABdhPJzveLbKd2/fd+yW9COqHniIV8xf3qTx7Ia1dcnpsn0rSIKQjLxMysH9YBtmMRiS0RAcwMxpM8nudC4fcrMjxEQ=
X-Received: by 2002:a17:906:1393:: with SMTP id f19mr3814197ejc.431.1610471735707;
 Tue, 12 Jan 2021 09:15:35 -0800 (PST)
MIME-Version: 1.0
References: <20210108222223.952458-1-lokeshgidra@google.com>
In-Reply-To: <20210108222223.952458-1-lokeshgidra@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 12 Jan 2021 12:15:24 -0500
Message-ID: <CAHC9VhSLFUyeo8he4t7rFoHgRHfpB=URoAioF+a3+xjZP8JdSQ@mail.gmail.com>
Subject: Re: [PATCH v15 0/4] SELinux support for anonymous inodes and UFFD
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
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Adrian Reber <areber@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        kaleshsingh@google.com, calin@google.com, surenb@google.com,
        jeffv@google.com, kernel-team@android.com, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>, hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 8, 2021 at 5:22 PM Lokesh Gidra <lokeshgidra@google.com> wrote:
>
> Userfaultfd in unprivileged contexts could be potentially very
> useful. We'd like to harden userfaultfd to make such unprivileged use
> less risky. This patch series allows SELinux to manage userfaultfd
> file descriptors and in the future, other kinds of
> anonymous-inode-based file descriptor.

...

> Daniel Colascione (3):
>   fs: add LSM-supporting anon-inode interface
>   selinux: teach SELinux about anonymous inodes
>   userfaultfd: use secure anon inodes for userfaultfd
>
> Lokesh Gidra (1):
>   security: add inode_init_security_anon() LSM hook
>
>  fs/anon_inodes.c                    | 150 ++++++++++++++++++++--------
>  fs/libfs.c                          |   5 -
>  fs/userfaultfd.c                    |  19 ++--
>  include/linux/anon_inodes.h         |   5 +
>  include/linux/lsm_hook_defs.h       |   2 +
>  include/linux/lsm_hooks.h           |   9 ++
>  include/linux/security.h            |  10 ++
>  security/security.c                 |   8 ++
>  security/selinux/hooks.c            |  57 +++++++++++
>  security/selinux/include/classmap.h |   2 +
>  10 files changed, 213 insertions(+), 54 deletions(-)

With several rounds of reviews done and the corresponding SELinux test
suite looking close to being ready I think it makes sense to merge
this via the SELinux tree.  VFS folks, if you have any comments or
objections please let me know soon.  If I don't hear anything within
the next day or two I'll go ahead and merge this for linux-next.

Thanks.

-- 
paul moore
www.paul-moore.com
