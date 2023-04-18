Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A046E568B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 03:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjDRBk4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 21:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjDRBky (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:40:54 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10F1F5592
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:40:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id l124-20020a252582000000b00b8f5572bcdaso12290766ybl.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Apr 2023 18:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681782051; x=1684374051;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bMGkpk1YzLLB6Dkq44tjt4SD+YA/2KPf5L1MlIvm+KE=;
        b=Udx3W0F5kzh1CXU8g7LWKjoladX92jD4LTjvnTrKNMLe/kB98XFpP5SRZx2G+LODDa
         732pusGPSRXAVbNv1DIlX0Ix/mgkMpYkAhIev8U1x0W6iV79Tc3pCVNmRId45lQ0WAA/
         EZ99SloXabv8y9/w4zJ3OdFk7ysy68VPmNybl0mKuWWfNA7Y7xoxMkq0sjahR5oZ0MuY
         DPHiauTUOQRsk4baUh8TGdku8HKB7uhASof5VCYaVS/6IfbdCc+Mj7ZxVPXsXJxIxLH2
         P3qKzoLwPbp1hjacowQrK83FuYlcxOI/l+epJA+5jIXk+89QC8PPxLUm62Sti+tAzBt8
         vFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681782051; x=1684374051;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bMGkpk1YzLLB6Dkq44tjt4SD+YA/2KPf5L1MlIvm+KE=;
        b=RYP+YjZQx6ioYge8fGKB7rxKNmYKi124HxIM51Cb807RCX41GF7GDIwH/sjPiLfCaY
         GuW15Z6Ft63N1qxcJ4wYRK/KQKOPMzFS24gFImI7UZ3DvZ7zAtckiQOhFOReMRvhT1f4
         bK+N6+lCfNoB4buMboMN25odwGbnCf4mc2crhiLCBFQi+A6ixNprXHhfGijB2cpI55oG
         8BiD/z5GmNvBUcU8wM9EyWZTA7HS/rgJiIYkFP6VFnfIQeQ1CI/iywEjKUEdUfGLunKk
         zez1TENDdDM4tLMfxIRstd19WlaTZduFQMtv84E51EpW66Uix9GrcV8EkcxOpxnTzDNf
         Dxjg==
X-Gm-Message-State: AAQBX9eSXkf+RGYufAh4uR74x6a6Z0hMtwUJLPKJfwtGiLVrxS/869qL
        AwKLa9E2JT7UJjNPNAr/jNAsurm2VKk=
X-Google-Smtp-Source: AKy350ZnJUGlxh78CSx9AVxMzTV5Do1HydFLKImAN3ILv2glJWBD/IOtF7qzx+pznis4COWdPEoBhudQajU=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:e67a:98b0:942d:86aa])
 (user=drosen job=sendgmr) by 2002:a81:ac5d:0:b0:54f:b95f:8999 with SMTP id
 z29-20020a81ac5d000000b0054fb95f8999mr10086901ywj.6.1681782051211; Mon, 17
 Apr 2023 18:40:51 -0700 (PDT)
Date:   Mon, 17 Apr 2023 18:40:00 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230418014037.2412394-1-drosen@google.com>
Subject: [RFC PATCH bpf-next v3 00/37] FUSE BPF: A Stacked Filesystem
 Extension for FUSE
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
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

In this patch set, I've reworked the bpf code to add a new struct_op type
instead of a new program type, and used new kfuncs in place of new helpers.
Additionally, it now uses dynptrs for variable sized buffers. The first three
patches are repeats of a previous patch set which I have not yet adjusted for
comments. I plan to adjust those and submit them separately with fixes, but
wanted to have the current fuse-bpf code visible before then.

Patches 4-7 mostly rearrange existing code to remove noise from the main patch.
Patch 8 contains the main sections of fuse-bpf
Patches 9-25 implementing most FUSE functions as operations on a lower
filesystem. From patch 25, you can run fuse as a passthrough filesystem.
Patches 26-32 provide bpf functionality so that you can alter fuse parameters
via fuse_op programs.
Patch 33 extends this to userspace, and patches 34-37 add some testing
functionality.

There's definitely a lot of cleanup and some restructuring I would like to do.
In the current form, I could get rid of the large macro in place of a function
that takes a struct that groups a bunch of function pointers, although I'm not
sure a function that takes three void*'s is much better than the macro... I'm
definitely open to suggestions on how to clean that up.

This changes the format of adding a backing file/bpf slightly from v2. fuse_op
programs are specified by name, limited to 15 characters. The block added to
fuse_bpf_entires has been increased to compensate. This adds one more unused
field when specifying the backing file.

Lookups responses that add a backing file must go through an ioctl interface.
This is to prevent any attempts at fooling priveledged programs with fd
trickery.

Currently, there are two types of fuse_bpf_entry. One for passing the fuse_op
program you wish to use, specified by name, and one for passing the fd of the
backing file you'd like to associate with the given lookup. In the future, this
may be extended to a more complicated system allowing for multiple bpf programs
or backing files. This would come with kfuncs for bpf to indicate which backing
file should be acted upon. Multiple bpf programs would allow chaining existing
programs to extend functionality without requiring an entirely new program set.

You can run this without needing to set up a userspace daemon by adding these
mount options: root_dir=[fd],no_daemon where fd is an open file descriptor
pointing to the folder you'd like to use as the root directory. The fd can be
immediately closed after mounting. You may also set a root_bpf program by
setting root_bpf=[fuse_op name] after registering a fuse_op program.
This is useful for running various fs tests.

This patch set is against bpf-next

The main changes for v3:
Restructured around struct_op programs
Using dynptrs instead of packets
Using kfuncs instead of new helpers
Selftests now use skel for loading

Alessio Balsini (1):
  fs: Generic function to convert iocb to rw flags

Daniel Rosenberg (36):
  bpf: verifier: Accept dynptr mem as mem in herlpers
  bpf: Allow NULL buffers in bpf_dynptr_slice(_rw)
  selftests/bpf: Test allowing NULL buffer in dynptr slice
  fuse-bpf: Update fuse side uapi
  fuse-bpf: Add data structures for fuse-bpf
  fuse-bpf: Prepare for fuse-bpf patch
  fuse: Add fuse-bpf, a stacked fs extension for FUSE
  fuse-bpf: Add ioctl interface for /dev/fuse
  fuse-bpf: Don't support export_operations
  fuse-bpf: Add support for access
  fuse-bpf: Partially add mapping support
  fuse-bpf: Add lseek support
  fuse-bpf: Add support for fallocate
  fuse-bpf: Support file/dir open/close
  fuse-bpf: Support mknod/unlink/mkdir/rmdir
  fuse-bpf: Add support for read/write iter
  fuse-bpf: support readdir
  fuse-bpf: Add support for sync operations
  fuse-bpf: Add Rename support
  fuse-bpf: Add attr support
  fuse-bpf: Add support for FUSE_COPY_FILE_RANGE
  fuse-bpf: Add xattr support
  fuse-bpf: Add symlink/link support
  fuse-bpf: allow mounting with no userspace daemon
  bpf: Increase struct_op limits
  fuse-bpf: Add fuse-bpf constants
  WIP: bpf: Add fuse_ops struct_op programs
  fuse-bpf: Export Functions
  fuse: Provide registration functions for fuse-bpf
  fuse-bpf: Set fuse_ops at mount or lookup time
  fuse-bpf: Call bpf for pre/post filters
  fuse-bpf: Add userspace pre/post filters
  WIP: fuse-bpf: add error_out
  tools: Add FUSE, update bpf includes
  fuse-bpf: Add selftests
  fuse: Provide easy way to test fuse struct_op call

 Documentation/bpf/kfuncs.rst                  |   23 +-
 fs/fuse/Kconfig                               |    8 +
 fs/fuse/Makefile                              |    1 +
 fs/fuse/backing.c                             | 4241 +++++++++++++++++
 fs/fuse/bpf_register.c                        |  209 +
 fs/fuse/control.c                             |    2 +-
 fs/fuse/dev.c                                 |   85 +-
 fs/fuse/dir.c                                 |  344 +-
 fs/fuse/file.c                                |   63 +-
 fs/fuse/fuse_i.h                              |  495 +-
 fs/fuse/inode.c                               |  360 +-
 fs/fuse/ioctl.c                               |    2 +-
 fs/fuse/readdir.c                             |    5 +
 fs/fuse/xattr.c                               |   18 +
 fs/overlayfs/file.c                           |   23 +-
 include/linux/bpf.h                           |    2 +-
 include/linux/bpf_fuse.h                      |  283 ++
 include/linux/fs.h                            |    5 +
 include/uapi/linux/bpf.h                      |   12 +
 include/uapi/linux/fuse.h                     |   41 +
 kernel/bpf/Makefile                           |    4 +
 kernel/bpf/bpf_fuse.c                         |  241 +
 kernel/bpf/bpf_struct_ops.c                   |    6 +-
 kernel/bpf/bpf_struct_ops_types.h             |    4 +
 kernel/bpf/btf.c                              |    1 +
 kernel/bpf/helpers.c                          |   32 +-
 kernel/bpf/verifier.c                         |   32 +
 tools/include/uapi/linux/bpf.h                |   12 +
 tools/include/uapi/linux/fuse.h               | 1135 +++++
 .../testing/selftests/bpf/prog_tests/dynptr.c |    1 +
 .../selftests/bpf/progs/dynptr_success.c      |   21 +
 .../selftests/filesystems/fuse/.gitignore     |    2 +
 .../selftests/filesystems/fuse/Makefile       |  189 +
 .../testing/selftests/filesystems/fuse/OWNERS |    2 +
 .../selftests/filesystems/fuse/bpf_common.h   |   51 +
 .../selftests/filesystems/fuse/bpf_loader.c   |  597 +++
 .../testing/selftests/filesystems/fuse/fd.txt |   21 +
 .../selftests/filesystems/fuse/fd_bpf.bpf.c   |  397 ++
 .../selftests/filesystems/fuse/fuse_daemon.c  |  300 ++
 .../selftests/filesystems/fuse/fuse_test.c    | 2412 ++++++++++
 .../filesystems/fuse/struct_op_test.bpf.c     |  642 +++
 .../selftests/filesystems/fuse/test.bpf.c     |  996 ++++
 .../filesystems/fuse/test_framework.h         |  172 +
 .../selftests/filesystems/fuse/test_fuse.h    |  494 ++
 44 files changed, 13755 insertions(+), 231 deletions(-)
 create mode 100644 fs/fuse/backing.c
 create mode 100644 fs/fuse/bpf_register.c
 create mode 100644 include/linux/bpf_fuse.h
 create mode 100644 kernel/bpf/bpf_fuse.c
 create mode 100644 tools/include/uapi/linux/fuse.h
 create mode 100644 tools/testing/selftests/filesystems/fuse/.gitignore
 create mode 100644 tools/testing/selftests/filesystems/fuse/Makefile
 create mode 100644 tools/testing/selftests/filesystems/fuse/OWNERS
 create mode 100644 tools/testing/selftests/filesystems/fuse/bpf_common.h
 create mode 100644 tools/testing/selftests/filesystems/fuse/bpf_loader.c
 create mode 100644 tools/testing/selftests/filesystems/fuse/fd.txt
 create mode 100644 tools/testing/selftests/filesystems/fuse/fd_bpf.bpf.c
 create mode 100644 tools/testing/selftests/filesystems/fuse/fuse_daemon.c
 create mode 100644 tools/testing/selftests/filesystems/fuse/fuse_test.c
 create mode 100644 tools/testing/selftests/filesystems/fuse/struct_op_test.bpf.c
 create mode 100644 tools/testing/selftests/filesystems/fuse/test.bpf.c
 create mode 100644 tools/testing/selftests/filesystems/fuse/test_framework.h
 create mode 100644 tools/testing/selftests/filesystems/fuse/test_fuse.h


base-commit: 49859de997c3115b85544bce6b6ceab60a7fabc4
-- 
2.40.0.634.g4ca3ef3211-goog

