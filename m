Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1241276114
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 21:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgIWTd3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 15:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgIWTd3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 15:33:29 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27077C0613CE
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2020 12:33:29 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id l67so689111ybb.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2020 12:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=WVSvTUrYOLntpcfEv21un6OtJaYezAF3iVaHLu7hkAE=;
        b=ArKXeABL055dP9UaAHA02G3C5k50VagybqYti7opUKzF6LQsQaVxD/h8N2sNItDgDp
         OHUaKhz9LSLg+YtA+c+ZTJUIs4uXRIN19skiynV6k3oxFeub8TU9UmYcGOqfR1X46ms/
         v/XOqLRTnY5rTaEuS9iRqMJu+Y4Bb+j+ejblZdFt8TzjW2i8rwY/nogh8o41FBCauhR9
         ZRkh5efI5RaAWXVhsEwTjdCNCs4kbCUPg6oGwBFfPFfjasSbiEY1jKM9VAJnyrVNvudF
         rAmisW6mZUGAbLlCQo/PSlpoR/3N4FPTPOT/oWLnQEpCf/uM4mpee1MTLbWbNSb1T+WQ
         wKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=WVSvTUrYOLntpcfEv21un6OtJaYezAF3iVaHLu7hkAE=;
        b=KdjpJod1k/tBr7lWY/uELuQkLaruv2842SUI3bgK1G85yYmY4DDKj6mHXUpbv+TK2x
         iw0jV/bSpHLZJfifG4Qb4KyQdcAMOHZFNytRDQ3AcQ4PksDigSD0GPiYhoKxMtJK0JrK
         +B1JH0FN6dAppjoIjO+fh1N6hcOb9UPfKhayZ5wbpkDOOgdLE37xmH5nLU0Kvxm6qIJG
         mG9BMMGS/5TffmEL6JqiTXrgTFWYQxV6FdQ07xNxgZH3GvBwkVmkxL10Z5OR4LbFVoVP
         jO6DURvcyHB7P21QM+xNn+PNkyIbBFh449eGcF5mN5NBg/qYL+7+FdIo+asHy+wodvno
         mrcA==
X-Gm-Message-State: AOAM5313h29pHg5tSZP8bhitCwwgGK7DiJ6HapDsZ/2qGADhl6+DBH8R
        SRCAxb9kjv5RvrDE9HZEs2CwtHM57fDvXPhVaQ==
X-Google-Smtp-Source: ABdhPJxwWhdQE8FL1xGbEa/t7GC9wDt3JQqUARq0x5zA68UzAR5KMkKne7LxCP0in38Ahq4E7JgWQD1GuFZHOd0a3A==
Sender: "lokeshgidra via sendgmr" <lokeshgidra@lg.mtv.corp.google.com>
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:29dd])
 (user=lokeshgidra job=sendgmr) by 2002:a25:ae90:: with SMTP id
 b16mr2522880ybj.128.1600889608275; Wed, 23 Sep 2020 12:33:28 -0700 (PDT)
Date:   Wed, 23 Sep 2020 12:33:21 -0700
Message-Id: <20200923193324.3090160-1-lokeshgidra@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v9 0/3] SELinux support for anonymous inodes and UFFD
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

Changes from the sixth version of the patch:

  - Removed definition of anon_inode_getfile_secure() as there are no
    callers.
  - Simplified function description of anon_inode_getfd_secure().
  - Elaborated more on the purpose of 'context_inode' in commit message.

Changes from the seventh version of the patch:

  - Fixed error handling in _anon_inode_getfile().
  - Fixed minor comment and indentation related issues.

Changes from the eighth version of the patch:

  - Replaced selinux_state.initialized with selinux_state.initialized


[1] https://lore.kernel.org/lkml/20200211225547.235083-1-dancol@google.com/
[2] https://lore.kernel.org/linux-fsdevel/20200213194157.5877-1-sds@tycho.nsa.gov/
[3] https://lore.kernel.org/lkml/23f725ca-5b5a-5938-fcc8-5bbbfc9ba9bc@tycho.nsa.gov/

Daniel Colascione (3):
  Add a new LSM-supporting anonymous inode interface
  Teach SELinux about anonymous inodes
  Wire UFFD up to SELinux

 fs/anon_inodes.c                    | 147 ++++++++++++++++++++--------
 fs/userfaultfd.c                    |  19 ++--
 include/linux/anon_inodes.h         |   8 ++
 include/linux/lsm_hook_defs.h       |   2 +
 include/linux/lsm_hooks.h           |   9 ++
 include/linux/security.h            |  10 ++
 security/security.c                 |   8 ++
 security/selinux/hooks.c            |  53 ++++++++++
 security/selinux/include/classmap.h |   2 +
 9 files changed, 209 insertions(+), 49 deletions(-)

-- 
2.28.0.681.g6f77f65b4e-goog

