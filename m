Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C2E24E482
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Aug 2020 03:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbgHVBkZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 21:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgHVBkY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 21:40:24 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399A6C061573
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 18:40:24 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k11so4057693ybp.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 18:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=yI2W6XOAECLWWz1vxp8A2D0OjzZ6EM2hcqCHiaj5HuY=;
        b=TGR+lsyK3bcOwfDOvhbrkZPJhPT7NSLH+l9HfLzVxRnJO1cucaMAPrlFYr3SollIVB
         Q8DeGaUQyFQvckXiCZEFjkV5oPHLtoTDNqSua0q1QHpQj/OSZZBuzhelPf5BC0OXuUmg
         C3MSmkgDFvDVUOA1UBzE67AwHnDAbZSHmxKKibDFE3HhAhaWaigNxMlKUUVCLRCE9Ooy
         9K6pNdw5tZvtjXf8NB/d8SmutZT3n+SIjFoRnCq1PgHNOpgJBfpLct7R0F1hptU0G8TE
         PdO0h47aCJjsJsbOztR74D4U42GTILnjnM91A43CkbHk/G79/cZXSb0BoiBPDno+MK0z
         zsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=yI2W6XOAECLWWz1vxp8A2D0OjzZ6EM2hcqCHiaj5HuY=;
        b=RtaKL1wvL56zCPtWJDtR9yBEr9unU8n3AOc53zM+oMEMatqJyfMBqcuFmppCL+0NMn
         Zde2gNjrxTu5jQSiy0k+l5STmCI/ZgelvRxez7hms+yajciyx0XLiLkHOPf+17mKccI3
         mp9+U1WJOLrPpwod+XAsVXO+4jlE3E4EDf7lXvNzjoTHPegXXCyJO1TJ+h+tBJvsn1Qv
         1DgVVaH0XeUt8Svctbx5sJFqKjaof+cUS/RuRlZyI4LYIEq8oFYm5Kcropb6KbcathJh
         qY+Ud0O9OhAbW8zev+HO32dE/bIC/bY/TXscZV4zqcyNl6CbOmBn1CsaochFt2Cp4a3q
         KZXA==
X-Gm-Message-State: AOAM533lbXVsB9uDQOePpw/CVOQAkoj0v1pcuWIh3mJnAyW8NntuBCXF
        e64ZraQMea60Cv0l0VROYZtAOd9R/GENCqr3Bw==
X-Google-Smtp-Source: ABdhPJyMbZ5EQZgoIAE5xx9h3TpYZZz10xRs8x2nvbqmtq7u7p4MrurW+Xl6HKu/QGhj9B4xBqwrRRAqe6zZStZSjw==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:29dd])
 (user=lokeshgidra job=sendgmr) by 2002:a5b:c44:: with SMTP id
 d4mr6981423ybr.488.1598060423377; Fri, 21 Aug 2020 18:40:23 -0700 (PDT)
Date:   Fri, 21 Aug 2020 18:40:16 -0700
Message-Id: <20200822014018.913868-1-lokeshgidra@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v2 0/2] Control over userfaultfd kernel-fault handling
From:   Lokesh Gidra <lokeshgidra@google.com>
To:     Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Biggers <ebiggers@kernel.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Daniel Colascione <dancol@dancol.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kaleshsingh@google.com,
        calin@google.com, surenb@google.com, nnk@google.com,
        jeffv@google.com, kernel-team@android.com,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Jerome Glisse <jglisse@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nitin Gupta <nigupta@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Iurii Zaikin <yzaikin@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
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

Changes since v1:

  - Added external references to the threats from allowing unprivileged
    users to handle page faults from kernel-mode.
  - Removed the new sysctl knob restricting handling of page
    faults from kernel-mode, and added an option for the same
    in the existing 'unprivileged_userfaultfd' knob.

Lokesh Gidra (2):
  Add UFFD_USER_MODE_ONLY
  Add user-mode only option to unprivileged_userfaultfd sysctl knob

 Documentation/admin-guide/sysctl/vm.rst | 10 +++++++---
 fs/userfaultfd.c                        | 17 ++++++++++++++---
 include/uapi/linux/userfaultfd.h        |  9 +++++++++
 kernel/sysctl.c                         |  2 +-
 4 files changed, 31 insertions(+), 7 deletions(-)

-- 
2.28.0.297.g1956fa8f8d-goog

