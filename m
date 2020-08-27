Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E99253DE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 08:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgH0Gfd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 02:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgH0Gf1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 02:35:27 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27D3C06121A
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2020 23:35:26 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id w11so6051135ybi.23
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2020 23:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=/zYgjye0baxZg/tSxyGziW2kTEyGPlr25yTvNVRsJ5g=;
        b=vUlvkX5HhL8LprLMIHVH8QGizNNjSM2NJ6p5hnk33lKNqAmYruPvU/+mNaXTGr/XAN
         ihUeKP4XWUtjM4EKkP3Tlwce+z15mLidCXtuYQr5oj0qeW0ScT4gAnxfl4xQRSIufHdr
         p/DNZC4MfF0ifiMwos0ztA0Rfh9yFTfloXzrCLqPK1LA2ZxPs5PMnVOfWLabnHP+Dz3X
         kR+0Jg64p90TLSujyC695hkr1hc7pUpwF/h2VKZqE3I7/JoQun9Ci3P/o+dPdEnxpjVt
         OypiCdd2swW84NWOaVSKcJ9xbH+DcY/Ur0j9AzapMRCH6Fw42e0a/xJTzsKYTp5fB7OM
         PbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=/zYgjye0baxZg/tSxyGziW2kTEyGPlr25yTvNVRsJ5g=;
        b=XCnSObFUgt7aW4Yn8SSl75cptRIWKSyaHA6KrltlO4I09+OY8X/sdALa63xYJqaxmp
         VB9TPGObC2vKu95msDkElAWKxan1dPuT1Db34GP4bwzgl0sOQBM+c/9VfNm9IGh6awn+
         K21LAnz5jGboqhuDRDyCbhaXcqmjRHXjuUGHUsLkg465aFAViazgLCpM46UI12zOapxN
         EkS3emJyL5IG9IDFXltVlFwBW8GM8b0d4cYTRTCqAdyZ3GGe06pjSj6whTJWPbzKeaeM
         GzXsIJL94LURCOIqwNMxTHFaM+yqSRJYV0Lo+ujyKXY+3qSpwYIMQqG4u4uG3CaXW6Fn
         KsfQ==
X-Gm-Message-State: AOAM532nNBf6Cox6N6FrYchHrnEZsEZV0e4VJkoAHsytorAtLkDMPKOp
        crvWWxeWvk7YJf3sBDbI69dU8nqv1/KZKEhggg==
X-Google-Smtp-Source: ABdhPJy2aWcUvIAO9BcZxJjrHYq+0aqek9xrqHcnTNBmTfvvf6anuxmAapc9Xo7sdYhj1+0P0gQ/3ew3tzQzDJSSkQ==
X-Received: from lg.mtv.corp.google.com ([100.89.4.209]) (user=lokeshgidra
 job=sendgmr) by 2002:a25:7a42:: with SMTP id v63mr25561564ybc.4.1598510125967;
 Wed, 26 Aug 2020 23:35:25 -0700 (PDT)
Date:   Wed, 26 Aug 2020 23:35:19 -0700
Message-Id: <20200827063522.2563293-1-lokeshgidra@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v8 0/3] SELinux support for anonymous inodes and UFFD
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

Changed from the seventh version of the patch:

  - Fixed error handling in _anon_inode_getfile().
  - Fixed minor comment and indentation related issues.

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
2.28.0.297.g1956fa8f8d-goog

