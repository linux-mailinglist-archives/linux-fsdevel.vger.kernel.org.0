Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E8B2EFB12
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 23:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbhAHWXH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 17:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbhAHWXG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 17:23:06 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACA5C061793
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Jan 2021 14:22:26 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id u17so10339600qku.17
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Jan 2021 14:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=LdaCO9PuI/GJnppuVvwg+RGHm8M5CHk4YUsuvcElhEI=;
        b=Y37jVPhu7aFRi1H7jZYqdKPFCRwJaJshzfDxyFVi17KLBBtq81c3VrKnsmLu39NrRH
         1JGrgnKDiWEUiBKFEjddkAfSg1GOWSpdeEO5oCDCWC54677U4FhLkB1uLGm4Sf6M2KEV
         Oe+7whKCYR0dDOf2vddxVmfOzbpG75VhrZA/oc7cy7Zgb6uvbDxa+3cL0aefOUaD41Kb
         926yrz6I/MSSdvCDUzdqcFQO6ZF/eL6jOOkdY5Is5UTOD12zzZEOiHx2XMghE/CfLzKh
         B4jgx++MnQo+V1172WX55+C7LpkCndS6LHOo4wDFT9/DnxqW9GwrkwrKUGeEfuB3j13j
         cW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=LdaCO9PuI/GJnppuVvwg+RGHm8M5CHk4YUsuvcElhEI=;
        b=cvHeXKx1+z4dxk8nfjf7HBNmPjAYnqTu1q0pp0WqZKows24+xTBq0Bfr0BuEhS3gyC
         famDeIM+GJ0YcwUDs7BUEE8kDqqrEhSS9dgaLw/d4iQgRQ3VUFpxtNrWuLrSYVOJyBLI
         1ZY6fR6ba920PPzahqNuJhg1ltNTjcowwR6bYnIhSR2gZYZN1buYV5WFOD0bQF4NxIqj
         QIzKWhrroY0QWjKVf42pNbB8BDSHtuvTqQGNCUN937+D3Z2lW4K7tNFJxFt+sSaKVjxi
         EHrb06solRApMwWJenFffVrY9N3WZUVembjmdlGH6KW/PwAxFSFlP03XBbMX6bGpR/F0
         nlZw==
X-Gm-Message-State: AOAM5308DW9Rk3iXiddTDaw9kVpDrudxCqoPMxsRDhNK8bAQuIJghgg4
        QjqZ6b1XBIzg7hwY4E6VdSvvuNhRGoaJP1oafw==
X-Google-Smtp-Source: ABdhPJzuehlSHqXC0dYeg+sgwDnbppsK5jICXYtzQLJuIT905cAObqEyTR7RhOpE4WQYOVahKCR1YxRoCuZXK7T2Lw==
Sender: "lokeshgidra via sendgmr" <lokeshgidra@lg.mtv.corp.google.com>
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:29dd])
 (user=lokeshgidra job=sendgmr) by 2002:a05:6214:6af:: with SMTP id
 s15mr5740563qvz.34.1610144545425; Fri, 08 Jan 2021 14:22:25 -0800 (PST)
Date:   Fri,  8 Jan 2021 14:22:19 -0800
Message-Id: <20210108222223.952458-1-lokeshgidra@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v15 0/4] SELinux support for anonymous inodes and UFFD
From:   Lokesh Gidra <lokeshgidra@google.com>
To:     Andrea Arcangeli <aarcange@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Paul Moore <paul@paul-moore.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Eric Paris <eparis@parisplace.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
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

Changes from the twelfth version of the patch:
  - Replaced FILE__CREATE with ANON_INODE__CREATE while initializing
    anon-inode's SELinux security struct.
  - Check context_inode's SELinux label and return -EACCES if it's
    invalid.

Changes from the thirteenth version of the patch:
  - Initialize anon-inode's sclass with SECCLASS_ANON_INODE.
  - Check if context_inode has sclass set to SECCLASS_ANON_INODE.

Changes from the forteenth version of the patch:
  - Revert changes of v14.
  - Use FILE__CREATE (instead of ANON_INODE__CREATE) while initializing
    anon-inode's SELinux security struct.
  - Added a pr_err() message if context_inode is not initialized.

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
 security/selinux/hooks.c            |  57 +++++++++++
 security/selinux/include/classmap.h |   2 +
 10 files changed, 213 insertions(+), 54 deletions(-)

-- 
2.30.0.284.gd98b1dd5eaa7-goog

