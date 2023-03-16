Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72ED36BD692
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 18:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjCPRCH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 13:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjCPRCF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:02:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43A79B2F7;
        Thu, 16 Mar 2023 10:01:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 746D3B8228C;
        Thu, 16 Mar 2023 17:01:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABF6C4339B;
        Thu, 16 Mar 2023 17:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678986117;
        bh=iAe83v06CelvQ5x9yL4BVebJHJ8BOoQ+WiuxJO46PLc=;
        h=From:To:Cc:Subject:Date:From;
        b=UrAFSXvLQU2L+HELh4Ww55FjwUFPh88C4WrAY8SuExteQeDon/zQi9uIlnQ0FeLUN
         IloCjLYHlbUgUQ9Q9TsI1exG7B+AjPZNwB2NWj39PMHS3epq0d2Mth7nidheT4cxW4
         6qSEwwCxL3uVBH8whbcX+/nskeSD772HAApttUAqVdHZy8vIyYxWVVxNA5XPFAi4m7
         zQjb2XvY9Mw+JrwQftcZWPS7Jfx/qmNqGiaWa0KcCqz2SuzuIhhWdOqR32100jjvvw
         f3raN7WrqQRL9KfyDpOifwgo1nJj0rDvM57S64hE+TJjTBKfS/cDZ7fCeanU41XyGw
         z6eEp+AwgZg0w==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Namhyung Kim <namhyung@gmail.com>,
        Dave Chinner <david@fromorbit.com>
Subject: [PATCHv3 bpf-next 0/9] mm/bpf/perf: Store build id in file object
Date:   Thu, 16 Mar 2023 18:01:40 +0100
Message-Id: <20230316170149.4106586-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

hi,
this patchset adds build id object pointer to struct file object.

We have several use cases for build id to be used in BPF programs
[2][3].

Having build id pointer stored directly in file object allows to get
build id reliably regardless of the execution context as described
in [3].

Previous iteration [1] stored build id pointer into inode, but it
became clear that struct file object is better place, because we read 
the build id when the file is mmap-ed and as Dave Chinner said [4]:

> Yes, the problem being that we can cache hundreds of millions of
> inodes in memory, and only a very small subset of them are going to
> have open files associated with them. And an even smaller subset are
> going to be mmapped.

thanks,
jirka


v3 changes:
  - moved build id back to file object (discussed in [4])
  - drop patch 4, it's not needed [Andrii]
  - added ack to patch 7 [Andrii]
  - replaced BUILD_ID_SIZE_MAX macro with enum [Andrii]
  - few re-formatting fixes [Andrii]

v2 changes:
  - store build id under inode [Matthew Wilcox]
  - use urandom_read and liburandom_read.so for test [Andrii]
  - add libelf-based helper to fetch build ID from elf [Andrii]
  - store build id or error we got when reading it [Andrii]
  - use full name i_build_id [Andrii]
  - several tests fixes [Andrii]


[1] https://lore.kernel.org/bpf/20230228093206.821563-1-jolsa@kernel.org/
[2] https://lore.kernel.org/bpf/CA+khW7juLEcrTOd7iKG3C_WY8L265XKNo0iLzV1fE=o-cyeHcQ@mail.gmail.com/
[3] https://lore.kernel.org/bpf/ZABf26mV0D0LS7r%2F@krava/
[4] https://lore.kernel.org/bpf/20230228220714.GJ2825702@dread.disaster.area/
---
Jiri Olsa (9):
      mm: Store build id in file object
      perf: Use file object build id in perf_event_mmap_event
      bpf: Use file object build id in stackmap
      bpf: Switch BUILD_ID_SIZE_MAX to enum
      selftests/bpf: Add read_buildid function
      selftests/bpf: Add err.h header
      selftests/bpf: Replace extract_build_id with read_build_id
      selftests/bpf: Add iter_task_vma_buildid test
      selftests/bpf: Add file_build_id test

 fs/file_table.c                                                  |  3 +++
 include/linux/buildid.h                                          | 21 ++++++++++++++++++-
 include/linux/fs.h                                               |  7 +++++++
 kernel/bpf/stackmap.c                                            | 24 +++++++++++++++++++++-
 kernel/events/core.c                                             | 43 ++++++++++++++++++++++++++++++++++----
 lib/buildid.c                                                    | 42 +++++++++++++++++++++++++++++++++++++
 mm/Kconfig                                                       |  9 ++++++++
 mm/mmap.c                                                        | 18 ++++++++++++++++
 tools/testing/selftests/bpf/Makefile                             |  7 ++++++-
 tools/testing/selftests/bpf/no_build_id.c                        |  6 ++++++
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c                | 78 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/file_build_id.c           | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/stacktrace_build_id.c     | 19 +++++++----------
 tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c | 17 ++++++---------
 tools/testing/selftests/bpf/progs/bpf_iter_task_vma_buildid.c    | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/err.h                          | 18 ++++++++++++++++
 tools/testing/selftests/bpf/progs/file_build_id.c                | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/profiler.inc.h                 |  3 +--
 tools/testing/selftests/bpf/test_progs.c                         | 25 ----------------------
 tools/testing/selftests/bpf/test_progs.h                         | 11 +++++++++-
 tools/testing/selftests/bpf/trace_helpers.c                      | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/trace_helpers.h                      |  5 +++++
 22 files changed, 608 insertions(+), 58 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/no_build_id.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/file_build_id.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_task_vma_buildid.c
 create mode 100644 tools/testing/selftests/bpf/progs/err.h
 create mode 100644 tools/testing/selftests/bpf/progs/file_build_id.c
