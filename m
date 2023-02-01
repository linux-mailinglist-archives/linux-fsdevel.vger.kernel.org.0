Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6A06867B8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Feb 2023 14:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjBAN6P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Feb 2023 08:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjBAN6K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:58:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4213693F0;
        Wed,  1 Feb 2023 05:57:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0C40617B2;
        Wed,  1 Feb 2023 13:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C58C433EF;
        Wed,  1 Feb 2023 13:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675259864;
        bh=SpI7KwADUFU7LsbCXaag3YbpvOzij0u/n2sLMpli8zM=;
        h=From:To:Cc:Subject:Date:From;
        b=J+gWjVwhlExx/kQG6HBH333Bk6FbQ3RN+UdWZ0kJIewW9wN3j8Mf3kQteaovGFv86
         u2oE9NGNpu9NmrB/ownkgk2gQKCRIj2OedRN4vuA9WhTshG4lufDkeknzyQkpY6UdY
         AS6p64fr4NTxNvP/d5OkLNkzWL0qydlmOkQsI5l0bUeDwiPxwZB8EHJbZUyDFuFtbI
         sEijVQfSNJq7AqeMorekg6Z+53JqVokPn71gIEW/2r6QhiHNzBidvbYlGC3TeIdTsU
         cmSJkCagjvADr3IrUJ8WtYRbFaLwYhz0B0axL1N+J6ahLdweQ+b24KAxeJAbjW5ard
         H//g0Cj7MvffA==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Luo <haoluo@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     bpf@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [RFC 0/5] mm/bpf/perf: Store build id in file object
Date:   Wed,  1 Feb 2023 14:57:32 +0100
Message-Id: <20230201135737.800527-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

hi,
we have a use cases for bpf programs to use binary file's build id.

After some attempts to add helpers/kfuncs [1] [2] Andrii had an idea [3]
to store build id directly in the file object. That would solve our use
case and might be beneficial for other profiling/tracing use cases with
bpf programs.

This RFC patchset adds new config CONFIG_FILE_BUILD_ID option, which adds
build id object pointer to the file object when enabled. The build id is
read/populated when the file is mmap-ed.

I also added bpf and perf changes that would benefit from this.

I'm not sure what's the policy on adding stuff to file object, so apologies
if that's out of line. I'm open to any feedback or suggestions if there's
better place or way to do this.

thanks,
jirka


[1] https://lore.kernel.org/bpf/20221108222027.3409437-1-jolsa@kernel.org/
[2] https://lore.kernel.org/bpf/20221128132915.141211-1-jolsa@kernel.org/
[3] https://lore.kernel.org/bpf/CAEf4BzaZCUoxN_X2ALXwQeFTCwtL17R4P_B_-hUCcidfyO2xyQ@mail.gmail.com/
---
Jiri Olsa (5):
      mm: Store build id in file object
      bpf: Use file object build id in stackmap
      perf: Use file object build id in perf_event_mmap_event
      selftests/bpf: Add file_build_id test
      selftests/bpf: Add iter_task_vma_buildid test

 fs/file_table.c                                               |  3 +++
 include/linux/buildid.h                                       | 17 +++++++++++++++++
 include/linux/fs.h                                            |  3 +++
 kernel/bpf/stackmap.c                                         |  8 ++++++++
 kernel/events/core.c                                          | 43 +++++++++++++++++++++++++++++++++++++++----
 lib/buildid.c                                                 | 44 ++++++++++++++++++++++++++++++++++++++++++++
 mm/Kconfig                                                    |  7 +++++++
 mm/mmap.c                                                     | 15 +++++++++++++++
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c             | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/file_build_id.c        | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_iter_task_vma_buildid.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/file_build_id.c             | 34 ++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/trace_helpers.c                   | 35 +++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/trace_helpers.h                   |  1 +
 14 files changed, 413 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/file_build_id.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_task_vma_buildid.c
 create mode 100644 tools/testing/selftests/bpf/progs/file_build_id.c
