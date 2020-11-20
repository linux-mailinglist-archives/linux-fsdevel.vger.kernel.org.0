Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FBB2BA0C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 04:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgKTDES (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Nov 2020 22:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgKTDES (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Nov 2020 22:04:18 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F157C0613CF
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2020 19:04:16 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id e142so9988835ybf.16
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2020 19:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=8XFAGaMnZpaYT0ztE4+ED+zm8jGUSJs5c4zzKttTIPI=;
        b=BLljEWyfBU6MrGtybZ+HWm2CfYE4oGLcD3L+xxb5kEOx5ilALIDKkVQlH6oubTxp6L
         BBZTmpiz8uXxqqtHEhsFdDU6VTag6k3qtgSbyzUTrbxcEKDWDv3nuTYOQcqxDG2+Luqu
         Y7mZURx+7aeBj5HvS8JuF4nSnoJ4X/RwElcATSf8h99LbSpkeq0mE+wSYWodCBJn09aV
         zuF0FtCgIwr/ukk1vgBu+9GsvQo+vBe7TqF4dmSd+e62WwwIhb/of9is4L7vqWxZEM7h
         fLD1Dh8hjkGCpDCiJn42Ntat0/VIFIOfI0GG3hwN9iaO7eVyfAAQPb3lcs9mcrRDzhBy
         LNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=8XFAGaMnZpaYT0ztE4+ED+zm8jGUSJs5c4zzKttTIPI=;
        b=I1W+pG9YPHSmDCuOlOmr4rPSKfWETIliRophF+neyqi7qkowX2a/HbmyWxeTgSdLwC
         o7on9/2fLet8q97Q2P7tqazBX1yCi1pnubW+IMhZp7/e3iRIqcuwVM7zqxI3fJdoJtlx
         GYYK1vVknxlwvVNNiopWL7m4mVRGSmFMaqKAUvtlWGjSNM6BCK26kynRuImxgvvb5lQg
         30BbL+XJIgS1LF33wlH+dNHI4wmRwx0h0qKB1xy4zBeETDR5Y8JUx1EsQ5ifaB72NHZM
         AhSC67aPNav6ZyX0WnxuNtfBZg3kiPTTol4ERa6Ssv43XY3LsJVGaxNBPoErZRTxKfVh
         ALMw==
X-Gm-Message-State: AOAM531JvGc7BDBuexkLixhFicGe+HlVR7HVOH2OMTByMMuh8ozjZjcI
        MXEsbCAYCVu9liYdM5DsfDJGuWJ8+N/8DEyFWQ==
X-Google-Smtp-Source: ABdhPJyzXLRqU2uLJ4PTem5aB9mGgB98rkzGCcOgbzeOlWOc4omKQdbXxNUk7El2Ic8Wjh8MK4DlbpnhP3swOgdDAA==
Sender: "lokeshgidra via sendgmr" <lokeshgidra@lg.mtv.corp.google.com>
X-Received: from lg.mtv.corp.google.com ([100.89.4.209]) (user=lokeshgidra
 job=sendgmr) by 2002:a25:abea:: with SMTP id v97mr16686450ybi.275.1605841455790;
 Thu, 19 Nov 2020 19:04:15 -0800 (PST)
Date:   Thu, 19 Nov 2020 19:04:09 -0800
Message-Id: <20201120030411.2690816-1-lokeshgidra@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v6 0/2] Control over userfaultfd kernel-fault handling
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
        calin@google.com, surenb@google.com, jeffv@google.com,
        kernel-team@android.com, Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Jerome Glisse <jglisse@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nitin Gupta <nigupta@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Iurii Zaikin <yzaikin@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>, linux-mm@kvack.kernel.org
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

Changes since v5:

  - Added printk_once when unprivileged_userfaultfd is set to 0 and
    userfaultfd syscall is called without UFFD_USER_MODE_ONLY in the
    absence of CAP_SYS_PTRACE capability.

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
 fs/userfaultfd.c                        | 20 +++++++++++++++++---
 include/uapi/linux/userfaultfd.h        |  9 +++++++++
 3 files changed, 36 insertions(+), 8 deletions(-)

-- 
2.29.0.rc1.297.gfa9743e501-goog

