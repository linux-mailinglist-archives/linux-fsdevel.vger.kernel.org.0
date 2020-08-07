Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFAB23F4F9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Aug 2020 00:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgHGWuR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 18:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgHGWuO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 18:50:14 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B61C061A28
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Aug 2020 15:50:13 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id c4so2556615qvq.15
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Aug 2020 15:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=DQO/d2NW9ycP8DpTdbgC9T07rqomhGHKBXOmCuHa3fI=;
        b=skihW5FsoS5B78IzyrqqnSUBgOERm/DgSjBN+uMjnt0AZnPktaxaQbH2qQou65YQmU
         qP21JoLind2jMwtpvkUtQldXZyx2lxVWdw0ROo0fDFRei2PlwNCMAdF/NA7atmf1rSDB
         H7kEdhYhgDhiDrf8XmbVr9tEFsAU5rlfePr16DRyDkDz6gSCvwU4V8ZSUUK2oxRzfgsS
         munPXEMVTA90J6c38s3k83pWnxFTpLR9v9nQreC1CwIf7cllzdpDOGRD96jwPxYDm58R
         q6Qtrly3U9bt3QCQAvZaY2pCYItO38lzL923Ms6TFxmvinsPFI0AsgcvV6ABS9gDigIt
         DrWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DQO/d2NW9ycP8DpTdbgC9T07rqomhGHKBXOmCuHa3fI=;
        b=PgJPLH85F/HQooC7g6QOi3fqCKobAdOCRBNKimknvOv+zkOREum1gb20ksttq6FZHE
         5dl9mLYabIj+HgVsE39OpRWq7r2R5uw3UCmXzBuRrP9yr5WMju+VanoLOys23NHdYMZs
         EbRGtLq8Q4SyM1Jy9iRF7NBqSQTCihKqPfnY+uV9ZFygvg7pBg35vyQsoxlrYbhy+fB2
         NvM9KmbiMCduhFx/zb8S7KDbgzHJKcHkYcc3Sv5ZYRZyAmErPaGh/M+xuAUUCdlWaTqk
         Be9Eu09JKQ/vnSOoFVtdDscmAPUTbP70EH/FszGEVL2D90vFKCfyBXrKvrKz7iVW8/RE
         h5VA==
X-Gm-Message-State: AOAM532xaPvn/rof1OyLLP8LcH2Npt8wfwEpB8u7suCVIrVZ9qQ7nsx3
        +/ATn6MORceIKo3NZgM6/RaCxiLoYFDcFWJKzg==
X-Google-Smtp-Source: ABdhPJyG3KGIHkCpGfBzgWcWyqw9H33fn3v9KCn90f9K5GXlgb5Y6RbVNwWjkzPw3a2FniVWsQnK4tgwCbB49VCiMw==
X-Received: by 2002:a0c:e604:: with SMTP id z4mr17234420qvm.222.1596840612573;
 Fri, 07 Aug 2020 15:50:12 -0700 (PDT)
Date:   Fri,  7 Aug 2020 15:49:38 -0700
Message-Id: <20200807224941.3440722-1-lokeshgidra@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH v6 0/3] SELinux support for anonymous inodes and UFFD
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

Inside the kernel, a pair of new anon_inodes interface,
anon_inode_getfile_secure and anon_inode_getfd_secure, allow callers
to opt into this SELinux management. In this new "secure" mode,
anon_inodes creates new ephemeral inodes for anonymous file objects
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

[1] https://lore.kernel.org/lkml/20200211225547.235083-1-dancol@google.com/
[2] https://lore.kernel.org/linux-fsdevel/20200213194157.5877-1-sds@tycho.nsa.gov/
[3] https://lore.kernel.org/lkml/23f725ca-5b5a-5938-fcc8-5bbbfc9ba9bc@tycho.nsa.gov/

Daniel Colascione (3):
  Add a new LSM-supporting anonymous inode interface
  Teach SELinux about anonymous inodes
  Wire UFFD up to SELinux

 fs/anon_inodes.c                    | 193 ++++++++++++++++++++++------
 fs/userfaultfd.c                    |  23 ++--
 include/linux/anon_inodes.h         |  13 ++
 include/linux/lsm_hook_defs.h       |   2 +
 include/linux/lsm_hooks.h           |   7 +
 include/linux/security.h            |   3 +
 security/security.c                 |   9 ++
 security/selinux/hooks.c            |  53 ++++++++
 security/selinux/include/classmap.h |   2 +
 9 files changed, 255 insertions(+), 50 deletions(-)

-- 
2.28.0.236.gb10cc79966-goog

