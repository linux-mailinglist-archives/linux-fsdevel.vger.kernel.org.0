Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0E64683C8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Dec 2021 10:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384543AbhLDJ4e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Dec 2021 04:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbhLDJ4c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Dec 2021 04:56:32 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33710C061751;
        Sat,  4 Dec 2021 01:53:07 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso4565926pjb.0;
        Sat, 04 Dec 2021 01:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+JuXsVUnS+mGqaHxKyE0o/YKYrOHZGXxsAcg+PajcAw=;
        b=iAXXWVOx9HNr6e7AStRCe78OXfyen74stssIx+IspwcnYxedIjo/XrtfOv1040hRjR
         ImfCvgBr+l0CoPZ+nlbDKQui2IoZZE3KbqgpzcdOD9X0Y6O9Oc2W017XddVHTI/SY45S
         i3iySAFhXUek0YFLJI9/O4UsrX64RNWBtLux+vCU7IsezQJ1H9Vto5cxfPwnEPNuVsuf
         8ApKoHaJFIv/y5H4LXqVe9cSW/By8ffUGcnMi8XWIT6LAfrN1o7JSFeUf3Ov0J06WKKw
         TYsxSBz/hNkNNdrbVBfuaf82Fj2rHB90VTgcEdkh/7QtHZoOgV6+mUAv2ApSssKR4Hfc
         GA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+JuXsVUnS+mGqaHxKyE0o/YKYrOHZGXxsAcg+PajcAw=;
        b=XAHw1Yvrw5KgOQme+P6ndDemqLKxeiAicq9rO3MULhDp8jm9qAdC/pISXwNQwLGoll
         MkG7pQYd7j46sFzALY3+jMWJXt6TE7sFf/+oQfvOVdaZ9vD29d8vXWu3qcWxAGLoMc8q
         QrTkvNoJfUC/mETyp4WikkFXkwfDAMBSUmOIlNzAOynhUa2UuWnQmTGqkv8QtW8fhMVF
         sAVaE5Jnb+irhn0LILzFodF5i6zk+d+JwMKPD/AkIVXlwHpxzjfWFoZiK1tVr9Bnwxtv
         N1Q2DgakBpDp1sbp37OceBlQAGqrSdLcOJmqLc6Vl1KcMfX+rnQk7w3ThpDvR804b3oc
         L2Dg==
X-Gm-Message-State: AOAM533mGdpv+l8ZrPFhhcTM41tpeoTi8t0klsoDvxtCmoEnhUsOMo6a
        ge8h9x4aBEihG8u8qGmitKA=
X-Google-Smtp-Source: ABdhPJzaXGdpxyp5qIfx9US29iDUhZtFjsXlPg+SLpc8UsVegALcv/ZDWvLIdf1ITkI+JLfT1DRSEw==
X-Received: by 2002:a17:90b:38c1:: with SMTP id nn1mr21160422pjb.91.1638611586767;
        Sat, 04 Dec 2021 01:53:06 -0800 (PST)
Received: from vultr.guest ([45.76.74.237])
        by smtp.gmail.com with ESMTPSA id ms15sm4343198pjb.26.2021.12.04.01.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 01:53:06 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     akpm@linux-foundation.org, rostedt@goodmis.org,
        keescook@chromium.org, pmladek@suse.com, david@redhat.com,
        arnaldo.melo@gmail.com, andrii.nakryiko@gmail.com
Cc:     linux-mm@kvack.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Michal Miroslaw <mirq-linux@rere.qmqm.pl>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH -mm 0/5] Phase 2 of task comm cleanups
Date:   Sat,  4 Dec 2021 09:52:51 +0000
Message-Id: <20211204095256.78042-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the followup work of task comm cleanups[1].

In this phase, the hard-coded 16 is replaced by either TASK_COMM_LEN or
TASK_COMM_LEN_16, to make it grepable. The difference between this two 
marcos is: 
- TASK_COMM_LEN
  The size should be same with the TASK_COMM_LEN defined in linux/sched.h.
  For the src file which can't include linux/sched.h, a macro with the 
  the same name is defined in this file specifically. 
- TASK_COMM_LEN_16
  The size must be a fixed-size 16. It may be exposed to userspace so we
  can't change it. 

In order to include vmlinux.h in bpf progs under sample/bpf or
tools/testing/selftests/bpf, some structs are renamed and some included
headers are removed.

1. https://lore.kernel.org/lkml/20211120112738.45980-1-laoar.shao@gmail.com/

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

Yafang Shao (5):
  elfcore: replace old hard-code 16 with TASK_COMM_LEN_16
  cn_proc: replaced old hard-coded 16 with TASK_COMM_LEN_16
  samples/bpf/tracex2: replace hard-coded 16 with TASK_COMM_LEN
  tools/perf: replace hard-coded 16 with TASK_COMM_LEN
  bpf/progs: replace hard-coded 16 with TASK_COMM_LEN

 include/linux/elfcore-compat.h                        |  8 ++------
 include/linux/elfcore.h                               |  9 ++-------
 include/linux/sched.h                                 |  5 +++++
 include/uapi/linux/cn_proc.h                          |  4 +++-
 samples/bpf/tracex2_kern.c                            |  3 ++-
 samples/bpf/tracex2_user.c                            |  3 ++-
 tools/perf/tests/evsel-tp-sched.c                     |  8 +++++---
 tools/testing/selftests/bpf/prog_tests/ringbuf.c      |  9 +++++----
 .../testing/selftests/bpf/prog_tests/ringbuf_multi.c  |  8 +++++---
 .../selftests/bpf/prog_tests/sk_storage_tracing.c     |  3 ++-
 .../testing/selftests/bpf/prog_tests/test_overhead.c  |  3 ++-
 .../selftests/bpf/prog_tests/trampoline_count.c       |  3 ++-
 .../selftests/bpf/progs/test_core_reloc_kernel.c      | 11 +++++------
 tools/testing/selftests/bpf/progs/test_ringbuf.c      |  8 ++++----
 .../testing/selftests/bpf/progs/test_ringbuf_multi.c  |  8 ++++----
 .../selftests/bpf/progs/test_sk_storage_tracing.c     |  4 ++--
 16 files changed, 52 insertions(+), 45 deletions(-)

-- 
2.17.1

