Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6D628A5E6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Oct 2020 08:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgJKGZB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Oct 2020 02:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgJKGZB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Oct 2020 02:25:01 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7700C0613CE
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Oct 2020 23:25:00 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id l12so10237983qtu.22
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Oct 2020 23:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=UJx97gIPGIXFXkRks4Wo0vV6Q6PxKBpX120vcE6WJsg=;
        b=sWYTJbGOpsmE70syYCNzGsAplxbAsaDGvmNcakNaECKP+Ez8bD3Rdi6wI3rU59lXC9
         6gfqTcuW9qjebxjGoE/SlnfNpby5Lx9LohoeIR0wNuoONARjym5sepDDSAAzRvXJTOvh
         jWgsUd7YnS0HYTD/FqQ5fTCIc4Egy70KtDZFi4GTlSgAJR+du+MoKKkmnVxmYz+VjXsm
         /LRCyixeYm3wQkxoj7oL5e4ruFzoYKC/W4hO6hQ+Fby9VjHr2ghxh2G+ODkOMtdkOl2L
         n/3z5bO46TzAHYpXmxMlyLX3xSV5i+mcGQEM8lPmKs5wXtRt8EL6d6bXbmBDWTELZFnI
         Xcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=UJx97gIPGIXFXkRks4Wo0vV6Q6PxKBpX120vcE6WJsg=;
        b=ZngxjSFd5RxBhXWinrJ1j/AruujHd8BVVDk4csiwirarzoxmpncnqBmUhSrLvhNWeU
         UAedpS+Qr/vqdodKXW9kNbpn3qgjVfUEWVPQAdB0jK4sbs12n5toUbo+9PXiTiTL7Yb5
         zkdKF4aQBRcPTDp7JO1hNKe3FcG4iVKQWfX+86uuPx9N9+uJ1AcuB1Wl4eGyO2z1Q0DK
         VFmjmROXumQO++pYWz15+jbgLTErWJN9Kd86uRkNXFROQ8KpWyLnBI14HCC/Sp0drVdV
         XwD0Z1R7/jJ31kTOnQJ07gaNhqcbN8yJXOEmLRs7lXwc+ywwmsYpdpvxJnczkLWz7Rvs
         DnxA==
X-Gm-Message-State: AOAM533wSEGM6IAFEseYuGJU14iNFAuU73dzELh1QHBiMkuDFqmrcO2i
        fuqpGynl9ptGmDNnYACe1D3RW3aCirqZBptKMQ==
X-Google-Smtp-Source: ABdhPJwwuHEwTJas51CDs0CXwMgtZ6GF8BpLVVQwMWpZxEVKux8CKK116qNPOrQYZazm9+cW7Nre45/LrKMgXOFtEA==
Sender: "lokeshgidra via sendgmr" <lokeshgidra@lg.mtv.corp.google.com>
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:29dd])
 (user=lokeshgidra job=sendgmr) by 2002:a0c:a203:: with SMTP id
 f3mr20270612qva.33.1602397499810; Sat, 10 Oct 2020 23:24:59 -0700 (PDT)
Date:   Sat, 10 Oct 2020 23:24:54 -0700
Message-Id: <20201011062456.4065576-1-lokeshgidra@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v5 0/2] Control over userfaultfd kernel-fault handling
From:   Lokesh Gidra <lokeshgidra@google.com>
To:     Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Daniel Colascione <dancol@dancol.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kaleshsingh@google.com,
        calin@google.com, surenb@google.com, nnk@google.com,
        jeffv@google.com, kernel-team@android.com,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Jerome Glisse <jglisse@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nitin Gupta <nigupta@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Iurii Zaikin <yzaikin@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series is split from [1]. The other series enables SELinux
support for userfaultfd file descriptors so that its creation and
movement can be controlled.

It has been demonstrated on various occasions that suspending kernel
code execution for an arbitrary amount of time at any access to
userspace memory (copy_from_user()/copy_to_user()/...) can be exploited
to change the intended behavior of the kernel. For instance, handling
page faults in kernel-mode using userfaultfd has been exploited in [2, 3].
Likewise, FUSE, which is similar to userfaultfd in this respect, has been
exploited in [4, 5] for similar outcome.

This small patch series adds a new flag to userfaultfd(2) that allows
callers to give up the ability to handle kernel-mode faults with the
resulting UFFD file object. It then adds a 'user-mode only' option to
the unprivileged_userfaultfd sysctl knob to require unprivileged
callers to use this new flag.

The purpose of this new interface is to decrease the chance of an
unprivileged userfaultfd user taking advantage of userfaultfd to
enhance security vulnerabilities by lengthening the race window in
kernel code.

[1] https://lore.kernel.org/lkml/20200211225547.235083-1-dancol@google.com/
[2] https://duasynt.com/blog/linux-kernel-heap-spray
[3] https://duasynt.com/blog/cve-2016-6187-heap-off-by-one-exploit
[4] https://googleprojectzero.blogspot.com/2016/06/exploiting-recursion-in-linux-kernel_20.html
[5] https://bugs.chromium.org/p/project-zero/issues/detail?id=808

Changes since v4:

  - Added warning when bailing out from handling kernel fault.

Changes since v3:

  - Modified the meaning of value '0' of unprivileged_userfaultfd
    sysctl knob. Setting this knob to '0' now allows unprivileged users
    to use userfaultfd, but can handle page faults in user-mode only.
  - The default value of unprivileged_userfaultfd sysctl knob is changed
    to '0'.

Changes since v2:

  - Removed 'uffd_flags' and directly used 'UFFD_USER_MODE_ONLY' in
    userfaultfd().

Changes since v1:

  - Added external references to the threats from allowing unprivileged
    users to handle page faults from kernel-mode.
  - Removed the new sysctl knob restricting handling of page
    faults from kernel-mode, and added an option for the same
    in the existing 'unprivileged_userfaultfd' knob.

Lokesh Gidra (2):
  Add UFFD_USER_MODE_ONLY
  Add user-mode only option to unprivileged_userfaultfd sysctl knob

 Documentation/admin-guide/sysctl/vm.rst | 15 ++++++++++-----
 fs/userfaultfd.c                        | 16 +++++++++++++---
 include/uapi/linux/userfaultfd.h        |  9 +++++++++
 3 files changed, 32 insertions(+), 8 deletions(-)

-- 
2.28.0.1011.ga647a8990f-goog

