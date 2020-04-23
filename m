Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8571B5143
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 02:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgDWA06 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 20:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725846AbgDWA05 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 20:26:57 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330DCC03C1AD
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2020 17:26:56 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id l40so3297870pjb.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2020 17:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to;
        bh=ORrb4UEf1wJbypW2W14BtjgaJCMRJSAaiDxPKEJIZ/U=;
        b=a6ZdhD4yH9iKxDcoTEdxCEcbWBKMpVZeG6AbvnYoX7sNV4cQSrwUQBg9AIH/T9F6nH
         kVNpHjmu+gPw9LmgmE/wLJXJdEn824WaAQ/otYW9T6Bu5Ki89IVTJZ/E8cMmOFSHPsHw
         ImwJTISQW/22UftFkX3rAvLV5rEa2YsCiBJT5+mYr43hFx47iMANlRltunFzs4mMc5+9
         A2eK67iS98TN38UHrr2gHoQlnVtuAU9liBYE+KT/Tjz4AuhKQrnF1FjxFnG+J6DVZDBt
         D3xZ050LzhKBg7M3NpIgNea4pPd7lNQ1rmlUDiprNPfLCOrIPX/Y8djvEMO3qHngpCuc
         AzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=ORrb4UEf1wJbypW2W14BtjgaJCMRJSAaiDxPKEJIZ/U=;
        b=t2y0LL151viA7S0qU4vJo7JOT/3kgyZifXUZkGmp6Q/oc1vz5znb7iDO2jaLFNsXaW
         JSgD73a1+pHWEA9keTDv7yG7RX+xMiu4G+wKmqOaI8WzCqv2rlPl1zSxljqU181bB3Jv
         HiMeu1zTv7mOSEs4GF58Ubq4Wo5puBNdRXzRiAnp5GQBRWtKgqV5wh8Pin9wyat4E/0l
         irexoNs+bqeMkdaugCOB6EhmPfmCRhFlSSMah8F86xAEXLXlesHVqzK5tU5lQsHE+UWk
         vN9ohgrG86rpLZmTYJkd6iAf9L72r+3u0izAfzAeHKVMGdZ+6blfqWovbNYI3Ht+hoHa
         SZ5A==
X-Gm-Message-State: AGi0PubTfRjW5mzhE1SyTFG2KMH8Afz6En6CeATgi2fqHDw3PDgZXT12
        uCAamwvhN/ubpdYkJOLg1d6K6Q3bT6s=
X-Google-Smtp-Source: APiQypLa+EJG7w/AjaAKFadG+PwV+ytFV63ocsJscjXMYp4P1isXQ+oFL9DO3fVFdsz1M3Km8qh0ztDBN2k=
X-Received: by 2002:a17:90a:8d02:: with SMTP id c2mr1371093pjo.113.1587601615603;
 Wed, 22 Apr 2020 17:26:55 -0700 (PDT)
Date:   Wed, 22 Apr 2020 17:26:30 -0700
Message-Id: <20200423002632.224776-1-dancol@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH 0/2] Control over userfaultfd kernel-fault handling
From:   Daniel Colascione <dancol@google.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Xu <peterx@redhat.com>,
        Daniel Colascione <dancol@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>, Shaohua Li <shli@fb.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, timmurray@google.com,
        minchan@google.com, sspatil@google.com, lokeshgidra@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This small patch series adds a new flag to userfaultfd(2) that allows
callers to give up the ability to handle user-mode faults with the
resulting UFFD file object. In then add a new sysctl to require
unprivileged callers to use this new flag.

The purpose of this new interface is to decrease the change of an
unprivileged userfaultfd user taking advantage of userfaultfd to
enhance security vulnerabilities by lengthening the race window in
kernel code.

This patch series is split from [1].

[1] https://lore.kernel.org/lkml/20200211225547.235083-1-dancol@google.com/

Daniel Colascione (2):
  Add UFFD_USER_MODE_ONLY
  Add a new sysctl knob: unprivileged_userfaultfd_user_mode_only

 Documentation/admin-guide/sysctl/vm.rst | 13 +++++++++++++
 fs/userfaultfd.c                        | 18 ++++++++++++++++--
 include/linux/userfaultfd_k.h           |  1 +
 include/uapi/linux/userfaultfd.h        |  9 +++++++++
 kernel/sysctl.c                         |  9 +++++++++
 5 files changed, 48 insertions(+), 2 deletions(-)

-- 
2.26.2.303.gf8c07b1a785-goog

