Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7EFF471229
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Dec 2021 07:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbhLKGkD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Dec 2021 01:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhLKGkC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Dec 2021 01:40:02 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4195C061714;
        Fri, 10 Dec 2021 22:40:01 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id z6so7694499plk.6;
        Fri, 10 Dec 2021 22:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6TTBLJjhklbgzaorxrN5YNkFqXZat3dzZj3OM3PWduE=;
        b=FcBnjgd+cmQ5JxcCoDykVJaF4bZWiPRhpgAyOGgiCRi83+lVWgaSJT3Q8sxAI8b67L
         a/Lu60kjlr8+hGGhtkbgIPtZL2KTOlobi3jaNj2/qw3MzZIItnxnJ9vYmZwfxuJgPOJS
         0hY21zVD27Ah3/Fie+1utflqjviajWileOHP9lrwnnpgvrbCoYv+s7db9iohAJ0lK/q5
         HSrvQBQtHjJraMcvMuAQpeskYpNIlBLayj0nOZeYk+oVG7IR5RyM97ITOj/1zdagzYUf
         OoIlD0XJLwsihCddx/vUEu2NGGjFd11krwaJb936Y69OPgQ2KgDzXWIb2lNmwk7nnRui
         ncaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6TTBLJjhklbgzaorxrN5YNkFqXZat3dzZj3OM3PWduE=;
        b=zEPwJzx/tLw8VjFEjdy8ZItBIGZ6V26vbPjWviFselbzVPEofnUDEV74mnM1Qerm6w
         1xkqSMeL2ju8zQU+S8iU6jVPK4YDWLI/5SGDAu6hAMF/OW5aCTgOEjB/dSKDKpT+R8qW
         ABdZ/JVgyGvF7eMcEUBAOt3r+GzsLRRaoY0OdgiYRtKOjcEwfoERWdqjx5JL9fh0SpJM
         7Z1KS3rEEIJzLObl8oduVAc3R1Toed2ByQRsta2qo6/Lvridtpe8p3Cq4Dkdu/dqwL3v
         XZX3+LL8Lql2oxt+NccTiETFQoZyaZunp3dL4NEef7tsUNdGMz4uK/jYURTdoiGgVHAJ
         EB7Q==
X-Gm-Message-State: AOAM533wOfKk6bdVqf/QeuPoIrqG7YcknJNYW1JM4y1c3F1wg2drp8hr
        QflcM2ajLrfXyL0LvbQgWRo=
X-Google-Smtp-Source: ABdhPJwIh7sOCDWjFOxGKD2DybyXks0pbOAHtYI/ZjEXWDeEyOyf77V+kWHcehoxUrGeXkhT3oAauw==
X-Received: by 2002:a17:902:e544:b0:144:e3fa:3c2e with SMTP id n4-20020a170902e54400b00144e3fa3c2emr81575705plf.17.1639204801449;
        Fri, 10 Dec 2021 22:40:01 -0800 (PST)
Received: from vultr.guest ([45.76.74.237])
        by smtp.gmail.com with ESMTPSA id mr2sm869638pjb.25.2021.12.10.22.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 22:40:00 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     akpm@linux-foundation.org, rostedt@goodmis.org,
        keescook@chromium.org, pmladek@suse.com, david@redhat.com,
        arnaldo.melo@gmail.com, andrii.nakryiko@gmail.com,
        alexei.starovoitov@gmail.com
Cc:     linux-mm@kvack.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michal Miroslaw <mirq-linux@rere.qmqm.pl>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH -mm v2 0/3] Phase 2 of task comm cleanups 
Date:   Sat, 11 Dec 2021 06:39:46 +0000
Message-Id: <20211211063949.49533-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the followup work of task comm cleanups[1].

In this phase, the hard-coded 16 is replaced by TASK_COMM_LEN_16 to make
it grepable. The difference between this two marcos is: 
- TASK_COMM_LEN
  The size should be same with the TASK_COMM_LEN defined in linux/sched.h.
- TASK_COMM_LEN_16
  The size must be a fixed-size 16 no matter what TASK_COMM_LEN is. It may
  be exposed to userspace so we can't change it. 

1. https://lore.kernel.org/lkml/20211120112738.45980-1-laoar.shao@gmail.com/

Changes since v1:
- use TASK_COMM_LEN_16 instead of TASK_COMM_LEN in patch #3 (Steven)
- avoid changing samples/bpf and bpf/progs (Alexei)

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Michal Miroslaw <mirq-linux@rere.qmqm.pl>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Kees Cook <keescook@chromium.org>
Cc: Petr Mladek <pmladek@suse.com>

Yafang Shao (3):
  elfcore: replace old hard-code 16 with TASK_COMM_LEN_16
  cn_proc: replaced old hard-coded 16 with TASK_COMM_LEN_16
  tools/perf: replace old hard-coded 16 with TASK_COMM_LEN_16

 include/linux/elfcore-compat.h    | 8 ++------
 include/linux/elfcore.h           | 9 ++-------
 include/linux/sched.h             | 5 +++++
 include/uapi/linux/cn_proc.h      | 4 +++-
 tools/perf/tests/evsel-tp-sched.c | 8 +++++---
 5 files changed, 17 insertions(+), 17 deletions(-)

-- 
2.17.1

