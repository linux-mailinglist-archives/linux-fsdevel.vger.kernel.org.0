Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7E719341C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Mar 2020 00:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbgCYXC5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Mar 2020 19:02:57 -0400
Received: from mail-pj1-f73.google.com ([209.85.216.73]:33008 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbgCYXC4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Mar 2020 19:02:56 -0400
Received: by mail-pj1-f73.google.com with SMTP id ng13so4719122pjb.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2020 16:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bbByUOh82ool+SbMsA1rd5UPSytjb2ekUWaOBWg/qH4=;
        b=pErYkr8SQ3js+o0QvaCZ2l96awDpkh8EUrjdNxFzM5tLCD4mbraW9JddFtQK0HyshT
         Avi04q5RiTad5YbeGKaK3qQDIhPmHtahpbjhp5ypqqp+ISs/DtHKySkISX00+naohPBc
         fD3TM90efw7F9/2EnWg7pGK8DCYDlEqC0oNDigZIPpWkrmi6AIFt6BNa1XFMFl7CJiAV
         hOVMaSzmXzi4wiklS783i7sQOVKxezXdi9uI4PDANgNCZwRz2ZppnvtKA8qRImOl3799
         C2kTOSxfz7k/WCYqwqQHvko0fPJ2rYwW0Ofl7E40p6/OWTpnb50TopRg525DkYJy2QEP
         maug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bbByUOh82ool+SbMsA1rd5UPSytjb2ekUWaOBWg/qH4=;
        b=lGGgmd9f7mftFXvbMO8krCz5lrrjrhM2tIJRYUNOE4vOa159q2CFk9qKzGNYrWuayX
         LuX+iRJ5ImHVtuFLb/hM79y1Oy7ryolH4LpLclwlz1QJSppIXyggIZU/2Gtr/Rnc7j/e
         gyBjyw7vD1vxILGgtmDAcsygvFWr12SiLpw0yJcmWpuSq1RXiGCllvzr6UyUKORnwnjl
         YHCszt4Ix8igZBB+axcPcDLlBT3YijodPfSiffcCeb+duAKZrWiqftgUHK4yfXJSRHTq
         83RTX6M/2+nyAKn0HzMfPbhiFVqcWh/ZE09IxMKmH72UINNQ2H24S+qPOj1doBJC1pfU
         N5dA==
X-Gm-Message-State: ANhLgQ2C7fPv48CbnYayXs57IraZ0+WxfSZmI8mS4nsz/+87W8BHyPkT
        ZF1vNkk+lUT2gLwjOf/yU3rVSfGQVVM=
X-Google-Smtp-Source: ADFU+vtou3JvMD6bdJEzfSY7dZ8y8OPdFIieV20IdIhHvT/Kq/C6dfCeM9T+fChX6v9277hrJ2rP5pCwomI=
X-Received: by 2002:a17:90a:a484:: with SMTP id z4mr6308167pjp.77.1585177373743;
 Wed, 25 Mar 2020 16:02:53 -0700 (PDT)
Date:   Wed, 25 Mar 2020 16:02:43 -0700
In-Reply-To: <20200214032635.75434-1-dancol@google.com>
Message-Id: <20200325230245.184786-1-dancol@google.com>
Mime-Version: 1.0
References: <20200214032635.75434-1-dancol@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v2 0/3] SELinux support for anonymous inodes and UFFD
From:   Daniel Colascione <dancol@google.com>
To:     timmurray@google.com, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, viro@zeniv.linux.org.uk, paul@paul-moore.com,
        nnk@google.com, sds@tycho.nsa.gov, lokeshgidra@google.com
Cc:     Daniel Colascione <dancol@google.com>
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

[1] https://lore.kernel.org/lkml/20200211225547.235083-1-dancol@google.com/
[2] https://lore.kernel.org/linux-fsdevel/20200213194157.5877-1-sds@tycho.nsa.gov/
[3] https://lore.kernel.org/lkml/23f725ca-5b5a-5938-fcc8-5bbbfc9ba9bc@tycho.nsa.gov/

Daniel Colascione (3):
  Add a new LSM-supporting anonymous inode interface
  Teach SELinux about anonymous inodes
  Wire UFFD up to SELinux

 fs/anon_inodes.c                    | 196 ++++++++++++++++++++++------
 fs/userfaultfd.c                    |  30 ++++-
 include/linux/anon_inodes.h         |  13 ++
 include/linux/lsm_hooks.h           |   9 ++
 include/linux/security.h            |   4 +
 security/security.c                 |  10 ++
 security/selinux/hooks.c            |  54 ++++++++
 security/selinux/include/classmap.h |   2 +
 8 files changed, 272 insertions(+), 46 deletions(-)

-- 
2.25.1.696.g5e7596f4ac-goog

