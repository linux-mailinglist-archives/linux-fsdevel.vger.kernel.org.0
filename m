Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A701F2A98DD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 16:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgKFP4e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 10:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbgKFP4d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 10:56:33 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0ABC0613D3
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2020 07:56:32 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id l23so2097516ybl.23
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2020 07:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=+GYjYf+cbRBNlCgQvT5sit1+MsRwjhaXZtoVVSsYoNQ=;
        b=nN7OaNw4BTD6wrtBLCim+7os5XDvv8TwYI42eAZ+TWRheEDke3e0f2HeF4kG3sMC9G
         YNmlMiQG8XXbw9LENkUtoYaDCgKsu1SPBAcpLZrv81DQph3UidWu0GHn+uLaB3f8VsXT
         upPDsOx1Eq0b4iGYjyFt+I3f2hwTMAm7qA862MMSHCsP24gsr18vZRXhMFGPntPU8N0P
         tnhFhIp0dJe9rMOGpsA1NJPwaULqyUbrlwtV5X/tHbcSeXodJ1lUdUHjofRBedXb4cJd
         Lns0lQ2H7b74lN3P+Eem6C6kZbbZLlb0nvP93KL7HiBeLYvNbeEDhol80F4OziVwxLZB
         6Ohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=+GYjYf+cbRBNlCgQvT5sit1+MsRwjhaXZtoVVSsYoNQ=;
        b=l1ntdxUrYYBj8wmI4A0Rhg9FLTrdRehXYnWTKGprHMzgXwSbhU92/wa0ht/EGBKf48
         ik1tKtvRTLYOsRVIGlOChcb8NtAIefTaOILq74QbXwuJ5mMIL0ImM5AG2znfXAV0tLf7
         wcXsMNkeWJAOp+NK7i7D1WPfi6pPxTP4BExQKesNMVc+r0zgDKSDQ9Vg0tucGiCbR2Wz
         EWIMjo1Akz6vA/8Vwkng8OrhCby5t4vzqMHJA0osZJzA1M6yitWuG7QxHl6A4aD/67Co
         zuGUiSVSV2+RIeqUukQjPUovUD4bZzuVG9K/4mmNpG1OLZm/DWsWXGOpsyzKDiFKG8Vf
         OtWA==
X-Gm-Message-State: AOAM531Ls9i446FFmYmR1171GFtPu1sJ8XSNf9C3ioSrcvGrTbBHu7TB
        WE8CUVIbqSVo3DIGxkitKbBwp0p968QXpCNwyg==
X-Google-Smtp-Source: ABdhPJw9CdnG+IOpgahDn+lKgUr1Y4FYAenUZgj5NCcAVsPIiGRDMC1H6fLbq09USO/ftxMRrQGg9BEI0/MbtbvoAQ==
Sender: "lokeshgidra via sendgmr" <lokeshgidra@lg.mtv.corp.google.com>
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:29dd])
 (user=lokeshgidra job=sendgmr) by 2002:a5b:a87:: with SMTP id
 h7mr3604444ybq.484.1604678191823; Fri, 06 Nov 2020 07:56:31 -0800 (PST)
Date:   Fri,  6 Nov 2020 07:56:22 -0800
Message-Id: <20201106155626.3395468-1-lokeshgidra@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v12 0/4] SELinux support for anonymous inodes and UFFD
From:   Lokesh Gidra <lokeshgidra@google.com>
To:     Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
        nnk@google.com, jeffv@google.com, kernel-team@android.com,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        hch@infradead.org
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

Changes from the ninth version of the patch:

  - Fixed function names in fs/anon_inodes.c
  - Fixed comment of anon_inode_getfd_secure()
  - Fixed name of the patch wherein userfaultfd code uses
    anon_inode_getfd_secure()

Changes from the tenth version of the patch:

  - Split first patch into VFS and LSM specific patches
  - Fixed comments in fs/anon_inodes.c
  - Fixed comment of alloc_anon_inode()

Changes from the eleventh version of the patch:

  - Removed comment of alloc_anon_inode() for consistency with the code
  - Fixed explanation of LSM hook in the commit message

[1] https://lore.kernel.org/lkml/20200211225547.235083-1-dancol@google.com/
[2] https://lore.kernel.org/linux-fsdevel/20200213194157.5877-1-sds@tycho.nsa.gov/
[3] https://lore.kernel.org/lkml/23f725ca-5b5a-5938-fcc8-5bbbfc9ba9bc@tycho.nsa.gov/

Daniel Colascione (3):
  fs: add LSM-supporting anon-inode interface
  selinux: teach SELinux about anonymous inodes
  userfaultfd: use secure anon inodes for userfaultfd

Lokesh Gidra (1):
  security: add inode_init_security_anon() LSM hook

 fs/anon_inodes.c                    | 150 ++++++++++++++++++++--------
 fs/libfs.c                          |   5 -
 fs/userfaultfd.c                    |  19 ++--
 include/linux/anon_inodes.h         |   5 +
 include/linux/lsm_hook_defs.h       |   2 +
 include/linux/lsm_hooks.h           |   9 ++
 include/linux/security.h            |  10 ++
 security/security.c                 |   8 ++
 security/selinux/hooks.c            |  53 ++++++++++
 security/selinux/include/classmap.h |   2 +
 10 files changed, 209 insertions(+), 54 deletions(-)

-- 
2.29.1.341.ge80a0c044ae-goog

