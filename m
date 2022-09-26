Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077CB5EB566
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 01:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiIZXSu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 19:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiIZXSc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:18:32 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D033BB2853
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:18:29 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-349e90aa547so75169357b3.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Sep 2022 16:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date;
        bh=snPbjGkRfdDn+amka8Cfpny4oszLrwQ5Iz+olT6AgyI=;
        b=KxyFh4S41EERkmMpwwUeKwwAI3ma6INO8a3O4eNNIly9pY62dEXJXW6ZkQe7j+Ln3X
         AAMxT+rVHHmt0gN2ZoUHfThSF+5huOiw/vPWMv6VH2FL3N1MD2xRbPMQQjQhATLF8gZc
         qEyYGSyoowCu53NFIOTcQaSjFHfdLE1PK3FP3ScwAQHZpXIqhOI2bq2vORdugRkueMng
         vhwHnUk2RT0LS3oO+P+C10mDijJt5OjsMWyVg4TQNQ0tpEu0ro6bL/3biQLc1ATnffOh
         5jc7vbSFEU/QMLS8Ohl+N2aIkc4c4/Qat0Z+JECOZPF7Fr6omD76AfIrokaKqHW+uJYi
         mCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=snPbjGkRfdDn+amka8Cfpny4oszLrwQ5Iz+olT6AgyI=;
        b=BcRd3yKo6VT9Ao/jbwFnvG3KHsRe0kSZEXKT4+xdGl8l98ySUoDmrjTn6iH4VdwphQ
         ISp8JmgUORFvCrXtEL6bhopSJTHFT7qJ2Jmzs34adg6SljRuKlN/L0IdgNU4pUBZupCU
         +FWCwWej+vq/rJ0eerBaX4G4+9tXOnAFOZnHYL0iejjaHsyRrKErE4HwBizqXuN+m8t1
         rRNO/ZO6yV4rzJJT0pCM8n8eSB8OeniSFOTuLuSpnB4NXR8US3HfogIadnUWZBXZIthW
         8Q6XQr1+um0FHm27gQdo8DXEfGpxBwZ4TSfxRjppr7xYqWXl9Q8EVOw6Uh6ZDNF4oi9M
         ub2g==
X-Gm-Message-State: ACrzQf2cZjzkXPK5pV9pkqJqcyZXwopoI5eYtq4zJPg7qwiQ8oTS0zn1
        qnVXeyR7MBlc+2cc8/Y/Mr7mKP1LXOI=
X-Google-Smtp-Source: AMsMyM7AOosbC/YggjGQKtFh7Dq1QUAmCw2k/HKEI/K4/qK0ZUJmy+ZPiLIRhLdTRsfNoICXpTwlRqmmLWw=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:4643:a68e:2b7:f873])
 (user=drosen job=sendgmr) by 2002:a81:bb50:0:b0:345:4e87:bdcb with SMTP id
 a16-20020a81bb50000000b003454e87bdcbmr24360729ywl.443.1664234309089; Mon, 26
 Sep 2022 16:18:29 -0700 (PDT)
Date:   Mon, 26 Sep 2022 16:17:56 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
Message-ID: <20220926231822.994383-1-drosen@google.com>
Subject: [PATCH 00/26] FUSE BPF: A Stacked Filesystem Extension for FUSE
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@google.com>,
        David Anderson <dvander@google.com>,
        Sandeep Patil <sspatil@google.com>,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These patches extend FUSE to be able to act as a stacked filesystem. This
allows pure passthrough, where the fuse file system simply reflects the lower
filesystem, and also allows optional pre and post filtering in BPF and/or the
userspace daemon as needed. This can dramatically reduce or even eliminate
transitions to and from userspace.

Currently, we either set the backing file/bpf at mount time at the root level,
or at lookup time, via an optional block added at the end of the lookup return
call. The added lookup block contains an fd for the backing file/folder and bpf
if necessary, or a signal to clear or inherit the parent values. We're looking
into two options for extending this to mkdir/mknod/etc, as we currently only
support setting the backing to a pre-existing file, although naturally you can
create new ones. When we're doing a lookup for create, we could pass an
fd for the parent dir and the name of the backing file we're creating. This has
the benefit of avoiding an additional call to userspace, but requires hanging
on to some data in a negative dentry where there is no elegant place to store it.
Another option is adding the same block we added to lookup to the create type
op codes. This keeps that code more uniform, but means userspace must implement
that logic in more areas.

As is, the patches definitely need some work before they're ready. We still
need to go through and ensure we respect changed filter values/disallow changes
that don't make sense. We aren't currently calling mnt_want_write for the lower
calls where appropriate, and we don't have an override_creds layer either. We
also plan to add to our read/write iter filters to allow for more interesting
use cases. There are also probably some node id inconsistencies. For nodes that
will be completely passthrough, we give an id of 0.

For the BPF verification side, we have currently set things set up in the old
style, with a new bpf program type and helper functions. From LPC, my
understanding is that newer bpf additions are done in a new style, so I imagine
much of that will need to be redone as well, but hopefully these patches get
across what our needs there are.

For testing, we've provided the selftest code we have been using. We also have
a mode to run with no userspace daemon in a pure passthrough mode that I have
been running xfstests over to get some coverage on the backing operation code.
I had to modify mounts/unmounts to get that running, along with some other
small touch ups. The most notable failure I currently see there is in
generic/126, which I suspect is likely related to override_creds.


Alessio Balsini (1):
  fs: Generic function to convert iocb to rw flags

Daniel Rosenberg (25):
  bpf: verifier: Allow for multiple packets
  bpf: verifier: Allow single packet invalidation
  fuse-bpf: Update uapi for fuse-bpf
  fuse-bpf: Add BPF supporting functions
  bpf: Export bpf_prog_fops
  fuse-bpf: Prepare for fuse-bpf patch
  fuse: Add fuse-bpf, a stacked fs extension for FUSE
  fuse-bpf: Don't support export_operations
  fuse-bpf: Partially add mapping support
  fuse-bpf: Add lseek support
  fuse-bpf: Add support for fallocate
  fuse-bpf: Support file/dir open/close
  fuse-bpf: Support mknod/unlink/mkdir/rmdir
  fuse-bpf: Add support for read/write iter
  fuse-bpf: support FUSE_READDIR
  fuse-bpf: Add support for sync operations
  fuse-bpf: Add Rename support
  fuse-bpf: Add attr support
  fuse-bpf: Add support for FUSE_COPY_FILE_RANGE
  fuse-bpf: Add xattr support
  fuse-bpf: Add symlink/link support
  fuse-bpf: allow mounting with no userspace daemon
  fuse-bpf: Call bpf for pre/post filters
  fuse-bpf: Add userspace pre/post filters
  fuse-bpf: Add selftests

 fs/fuse/Kconfig                               |   10 +
 fs/fuse/Makefile                              |    1 +
 fs/fuse/backing.c                             | 2753 +++++++++++++++++
 fs/fuse/control.c                             |    2 +-
 fs/fuse/dev.c                                 |   33 +-
 fs/fuse/dir.c                                 |  443 ++-
 fs/fuse/file.c                                |  125 +-
 fs/fuse/fuse_i.h                              |  804 ++++-
 fs/fuse/inode.c                               |  292 +-
 fs/fuse/ioctl.c                               |    2 +-
 fs/fuse/readdir.c                             |   22 +
 fs/fuse/xattr.c                               |   36 +
 fs/overlayfs/file.c                           |   23 +-
 include/linux/bpf.h                           |    4 +
 include/linux/bpf_fuse.h                      |   64 +
 include/linux/bpf_types.h                     |    4 +
 include/linux/bpf_verifier.h                  |    5 +-
 include/linux/fs.h                            |    5 +
 include/uapi/linux/bpf.h                      |   33 +
 include/uapi/linux/fuse.h                     |   19 +-
 kernel/bpf/Makefile                           |    4 +
 kernel/bpf/bpf_fuse.c                         |  342 ++
 kernel/bpf/btf.c                              |    1 +
 kernel/bpf/core.c                             |    5 +
 kernel/bpf/syscall.c                          |    1 +
 kernel/bpf/verifier.c                         |  144 +-
 tools/include/uapi/linux/bpf.h                |   33 +
 tools/include/uapi/linux/fuse.h               | 1066 +++++++
 .../selftests/filesystems/fuse/.gitignore     |    2 +
 .../selftests/filesystems/fuse/Makefile       |   41 +
 .../testing/selftests/filesystems/fuse/OWNERS |    2 +
 .../selftests/filesystems/fuse/bpf_loader.c   |  798 +++++
 .../testing/selftests/filesystems/fuse/fd.txt |   21 +
 .../selftests/filesystems/fuse/fd_bpf.c       |  370 +++
 .../selftests/filesystems/fuse/fuse_daemon.c  |  294 ++
 .../selftests/filesystems/fuse/fuse_test.c    | 2147 +++++++++++++
 .../selftests/filesystems/fuse/test_bpf.c     |  800 +++++
 .../filesystems/fuse/test_framework.h         |  173 ++
 .../selftests/filesystems/fuse/test_fuse.h    |  328 ++
 39 files changed, 11017 insertions(+), 235 deletions(-)
 create mode 100644 fs/fuse/backing.c
 create mode 100644 include/linux/bpf_fuse.h
 create mode 100644 kernel/bpf/bpf_fuse.c
 create mode 100644 tools/include/uapi/linux/fuse.h
 create mode 100644 tools/testing/selftests/filesystems/fuse/.gitignore
 create mode 100644 tools/testing/selftests/filesystems/fuse/Makefile
 create mode 100644 tools/testing/selftests/filesystems/fuse/OWNERS
 create mode 100644 tools/testing/selftests/filesystems/fuse/bpf_loader.c
 create mode 100644 tools/testing/selftests/filesystems/fuse/fd.txt
 create mode 100644 tools/testing/selftests/filesystems/fuse/fd_bpf.c
 create mode 100644 tools/testing/selftests/filesystems/fuse/fuse_daemon.c
 create mode 100644 tools/testing/selftests/filesystems/fuse/fuse_test.c
 create mode 100644 tools/testing/selftests/filesystems/fuse/test_bpf.c
 create mode 100644 tools/testing/selftests/filesystems/fuse/test_framework.h
 create mode 100644 tools/testing/selftests/filesystems/fuse/test_fuse.h


base-commit: bf682942cd26ce9cd5e87f73ae099b383041e782
-- 
2.37.3.998.g577e59143f-goog

