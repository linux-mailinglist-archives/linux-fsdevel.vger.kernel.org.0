Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92D4824E022
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 20:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgHUS5G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 14:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgHUS5C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:57:02 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D982C061573
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 11:57:01 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id y11so1886888pfq.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 11:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=oWFdh/PRo3gGpAV+9k5dRsjIEptJbJCkCMmQ8ucgmPk=;
        b=eIM0ewALXtMVmYnzBh1gd4g4cgWboGe0k6p4lIbSnc4fQ9pdVfb/Lou19RPdZZRuvW
         LQ1XfkVQ7fNa7xZdIxLlxZVnD85d40wlITdn0IogFA8+wRa6Km6GAMS6AR77/FyVikhn
         k7I2TtjHFF28aa4JRfiYHZpYN13mSNw6UmnKj2E0VdZiuoz0P9iY12JQ0q2WtMJbiLKP
         ABwU3IpnqkAQwDr6il5lNzibh2vxu4CCl2w0fflGUVCCj5sOS2BZeOejFV49RTluCkBQ
         kINmFvUY++dvTYPkUrPciNOdDObE1Gk0zpF8P5GtYe2+xl0tMOJlJJ+70ilrXz9Bdt5/
         h0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=oWFdh/PRo3gGpAV+9k5dRsjIEptJbJCkCMmQ8ucgmPk=;
        b=PBIJNl6J7T1RUWlXSYvFtZTBRL3d/DVCVW5MbQIdEVFFvHQ9bKy72i1pMc488wkVI9
         CSvQnySoU4mOOv3xQ9zq7KKVlqHHbchOblu/pfnGYbm9WIsEHVrVbkyv4RUPvhu2oJVI
         fL2zmEkVBJ++/UW4nQNtb4JQ57NBVdKJ+YQ1FduuShMsOt51DiogAnwx43RttNS7+D87
         Bfy7I8HHz1ScOjJWcOJMLySIOaN9vsxIfxWZ7tTK47nj/KNoCzHsvyFOJGnl0TCzWZ7/
         hqs95c/TZc4iVnjQGSz+kCqo3E9BKBkIm+wsaANDkfgKcjzJ+sbEvwH/U1fDDN4RceJi
         eMuw==
X-Gm-Message-State: AOAM533ydj07YCeKMpZJCSvrQiUoJ6w02Udt8L4ktDrAsravBrdfeP6o
        3MQpkayLmBiaKN/9u0FdZQXAIKFA+jXn4/l2bg==
X-Google-Smtp-Source: ABdhPJyD3Yh3CAqaICxx5JQmoTQsRkSWlUNlrc+z2K5FgB5OskDZ16gE5AERUF9KvVPCjDJ27Vch2q4YlRDdaNWY1Q==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:29dd])
 (user=lokeshgidra job=sendgmr) by 2002:a17:90a:9405:: with SMTP id
 r5mr3668948pjo.74.1598036220902; Fri, 21 Aug 2020 11:57:00 -0700 (PDT)
Date:   Fri, 21 Aug 2020 11:56:42 -0700
Message-Id: <20200821185645.801971-1-lokeshgidra@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v7 0/3] SELinux support for anonymous inodes and UFFD
From:   Lokesh Gidra <lokeshgidra@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
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
        nnk@google.com, jeffv@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Userfaultfd in unprivileged contexts could be potentially very
useful. We'd like to harden userfaultfd to make such unprivileged use
less risky. This patch series allows SELinux to manage userfaultfd
file descriptors and in the future, other kinds of
anonymous-inode-based file descriptor.  SELinux policy authors can
apply policy types to anonymous inodes by providing name-based
transition rules keyed off the anonymous inode internal name (
"[userfaultfd]" in the case of userfaultfd(2) file descriptors) and
applying policy to the new SIDs thus produced.

With SELinux managed userfaultfd, an admin can control creation and
movement of the file descriptors. In particular, handling of
a userfaultfd descriptor by a different process is essentially a
ptrace access into the process, without any of the corresponding
security_ptrace_access_check() checks. For privacy, the admin may
want to deny such accesses, which is possible with SELinux support.

Inside the kernel, a new anon_inode interface, anon_inode_getfd_secure,
allows callers to opt into this SELinux management. In this new "secure"
mode, anon_inodes create new ephemeral inodes for anonymous file objects
instead of reusing the normal anon_inodes singleton dummy inode. A new
LSM hook gives security modules an opportunity to configure and veto
these ephemeral inodes.

This patch series is one of two fork of [1] and is an
alternative to [2].

The primary difference between the two patch series is that this
partch series creates a unique inode for each "secure" anonymous
inode, while the other patch series ([2]) continues using the
singleton dummy anonymous inode and adds a way to attach SELinux
security information directly to file objects.

I prefer the approach in this patch series because 1) it's a smaller
patch than [2], and 2) it produces a more regular security
architecture: in this patch series, secure anonymous inodes aren't
S_PRIVATE and they maintain the SELinux property that the label for a
file is in its inode. We do need an additional inode per anonymous
file, but per-struct-file inode creation doesn't seem to be a problem
for pipes and sockets.

The previous version of this feature ([1]) created a new SELinux
security class for userfaultfd file descriptors. This version adopts
the generic transition-based approach of [2].

This patch series also differs from [2] in that it doesn't affect all
anonymous inodes right away --- instead requiring anon_inodes callers
to opt in --- but this difference isn't one of basic approach. The
important question to resolve is whether we should be creating new
inodes or enhancing per-file data.

Changes from the first version of the patch:

  - Removed some error checks
  - Defined a new anon_inode SELinux class to resolve the
    ambiguity in [3]
  - Inherit sclass as well as descriptor from context inode

Changes from the second version of the patch:

  - Fixed example policy in the commit message to reflect the use of
    the new anon_inode class.

Changes from the third version of the patch:

  - Dropped the fops parameter to the LSM hook
  - Documented hook parameters
  - Fixed incorrect class used for SELinux transition
  - Removed stray UFFD changed early in the series
  - Removed a redundant ERR_PTR(PTR_ERR())

Changes from the fourth version of the patch:

  - Removed an unused parameter from an internal function
  - Fixed function documentation

Changes from the fifth version of the patch:

  - Fixed function documentation in fs/anon_inodes.c and
    include/linux/lsm_hooks.h
  - Used anon_inode_getfd_secure() in userfaultfd() syscall and removed
    owner from userfaultfd_ctx.

Changed from the sixth version of the patch:

  - Removed definition of anon_inode_getfile_secure() as there are no
    callers.
  - Simplified function description of anon_inode_getfd_secure().
  - Elaborated more on the purpose of 'context_inode' in commit message.

[1] https://lore.kernel.org/lkml/20200211225547.235083-1-dancol@google.com/
[2] https://lore.kernel.org/linux-fsdevel/20200213194157.5877-1-sds@tycho.nsa.gov/
[3] https://lore.kernel.org/lkml/23f725ca-5b5a-5938-fcc8-5bbbfc9ba9bc@tycho.nsa.gov/

Daniel Colascione (3):
  Add a new LSM-supporting anonymous inode interface
  Teach SELinux about anonymous inodes
  Wire UFFD up to SELinux

 fs/anon_inodes.c                    | 148 ++++++++++++++++++++--------
 fs/userfaultfd.c                    |  23 +++--
 include/linux/anon_inodes.h         |  13 +++
 include/linux/lsm_hook_defs.h       |   2 +
 include/linux/lsm_hooks.h           |   7 ++
 include/linux/security.h            |   3 +
 security/security.c                 |   9 ++
 security/selinux/hooks.c            |  53 ++++++++++
 security/selinux/include/classmap.h |   2 +
 9 files changed, 210 insertions(+), 50 deletions(-)

-- 
2.28.0.297.g1956fa8f8d-goog

