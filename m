Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799356A55CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 10:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjB1JcR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 04:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjB1JcP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 04:32:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40DD20046;
        Tue, 28 Feb 2023 01:32:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F2596103C;
        Tue, 28 Feb 2023 09:32:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8B3C433EF;
        Tue, 28 Feb 2023 09:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677576733;
        bh=+IV4AHbmCCiEKP7LF/e7iy42Typyf3Xx3wgeSC17nEE=;
        h=From:To:Cc:Subject:Date:From;
        b=qBYvEMuONtlLWEKiJFbsfuEnIlCoUwAG8yVp5ddeof5wT43ogBWspmnlcHJrXI0Bf
         8SJXID5Ak5i4IdsjswpcC9c0ONIp1PoZ5xotoc37Im1ZOfjsmhicUSXY6DdzoNDOii
         grxi0zosyAVjxfpBeWpBo6AlCWixEPtFdnD5YPC/ZV6UNvN6X/WsTW26lrJ5ie/ahp
         KnqqORvKvPBby074X7WGfJyOVD0WrOX0a0T0NtwYy8O+YIdhF2ewK2PSeTV8eE8IQ4
         nI6ChbG5LH/oPETsBv36ND6xpliUSJ5vYRr7Z9OZfh59JUS/CJcUW+Vot9SvEBfCD7
         hjBI4ILFN+/tw==
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
        Namhyung Kim <namhyung@gmail.com>
Subject: [RFC v2 bpf-next 0/9] mm/bpf/perf: Store build id in inode object
Date:   Tue, 28 Feb 2023 10:31:57 +0100
Message-Id: <20230228093206.821563-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.39.2
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
this is RFC patchset for adding build id under inode's object.

The main change to previous post [1] is to use inode object instead of file
object for build id data.

However.. ;-) while using inode as build id storage place saves some memory
by keeping just one copy of the build id for all file instances, there seems
to be another problem.

The problem is that we read the build id when the file is mmap-ed.

Which is fine for our use case, because we only access build id data through
vma->vm_file->f_inode. But there are possible scenarios/windows where the
build id can be wrong when accessed in another way.

Like when the file is overwritten with another binary version with different
build id. This will result in having wrong build id data in inode until the
new file is mmap-ed.

   - file open                 > inode->i_build_id == NULL
   - file mmap
      -> read build id         > inode->i_build_id == build_id_1

   [ file changed with same inode, inode keeps old i_build_id data ]

   - file open                 > inode->i_build_id == build_id_1
   - file mmap
      -> read build id         > inode->i_build_id == build_id_2


I guess we could release i_build_id when the last file's vma go out?

But I'm not sure how to solve this and still be able to access build id
easily just by accessing the inode->i_build_id field without any lock.

I'm inclined to go back and store build id under the file object, where the
build id would be correct (or missing).

thoughts?

thanks,
jirka


v2 changes:
  - store build id under inode [Matthew Wilcox]
  - use urandom_read and liburandom_read.so for test [Andrii]
  - add libelf-based helper to fetch build ID from elf [Andrii]
  - store build id or error we got when reading it [Andrii]
  - use full name i_build_id [Andrii]
  - several tests fixes [Andrii]


[1] https://lore.kernel.org/bpf/20230201135737.800527-2-jolsa@kernel.org/
---
Jiri Olsa (9):
      mm: Store build id in inode object
      bpf: Use file's inode object build id in stackmap
      perf: Use file object build id in perf_event_mmap_event
      libbpf: Allow to resolve binary path in current directory
      selftests/bpf: Add read_buildid function
      selftests/bpf: Add err.h header
      selftests/bpf: Replace extract_build_id with read_build_id
      selftests/bpf: Add inode_build_id test
      selftests/bpf: Add iter_task_vma_buildid test

 fs/inode.c                                                       | 12 +++++++++++
 include/linux/buildid.h                                          | 15 ++++++++++++++
 include/linux/fs.h                                               |  7 +++++++
 kernel/bpf/stackmap.c                                            | 24 +++++++++++++++++++++-
 kernel/events/core.c                                             | 46 +++++++++++++++++++++++++++++++++++++----
 lib/buildid.c                                                    | 40 ++++++++++++++++++++++++++++++++++++
 mm/Kconfig                                                       |  8 ++++++++
 mm/mmap.c                                                        | 23 +++++++++++++++++++++
 tools/lib/bpf/libbpf.c                                           |  4 +++-
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c                | 78 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/inode_build_id.c          | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/prog_tests/stacktrace_build_id.c     | 19 +++++++----------
 tools/testing/selftests/bpf/prog_tests/stacktrace_build_id_nmi.c | 17 ++++++---------
 tools/testing/selftests/bpf/progs/bpf_iter_task_vma_buildid.c    | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/err.h                          | 13 ++++++++++++
 tools/testing/selftests/bpf/progs/inode_build_id.c               | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/progs/profiler.inc.h                 |  3 +--
 tools/testing/selftests/bpf/test_progs.c                         | 25 ----------------------
 tools/testing/selftests/bpf/test_progs.h                         | 11 +++++++++-
 tools/testing/selftests/bpf/trace_helpers.c                      | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/testing/selftests/bpf/trace_helpers.h                      |  5 +++++
 21 files changed, 581 insertions(+), 57 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/inode_build_id.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_task_vma_buildid.c
 create mode 100644 tools/testing/selftests/bpf/progs/err.h
 create mode 100644 tools/testing/selftests/bpf/progs/inode_build_id.c
