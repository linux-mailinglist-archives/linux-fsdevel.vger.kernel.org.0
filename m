Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682AE6332D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Nov 2022 03:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbiKVCP7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 21:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKVCPz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 21:15:55 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9665E0CB1
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 18:15:54 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-39ce6773614so58065937b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 18:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QwnVufQmqgsD71rU58/FXnZ6Kqu/OdIMDvlzn78hKF0=;
        b=k4vZ9/HUzOIP2zBuWKoMtl7qYaF7WljtXH1qLMOjUPNFZJcho4S6mcX9oJEpI4eEhd
         jQaDsDTCWLUiqZD9gEJJFxO5PXor/IPqkbWeHOf7/uBxPI/E42dhTBwWw9pGFQOWfXAz
         XDQ8fyBePklEduv9JeWkDQ4ti9U2YQjgKEpwKg/jWHBZfFhH4Wu+UWVBtFUv25SKyusZ
         fSg7ZhiEjA0ThA2qFhWu1e3M4PLIRyFPrs/duf2FcIkJ/FvMpg33uhosLAvbGHdEgxYZ
         /ZnujCg1Q8yPcTksxCuAuCvR2S9fKlQMl0DKNoWVw/W4d1VCUoEAFxKyWrQ4PB5xS8r4
         TzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QwnVufQmqgsD71rU58/FXnZ6Kqu/OdIMDvlzn78hKF0=;
        b=JKnOlBE2dJC+Yiq1QItPjmLk60bzG9GTjihak/mvzksrERJENYrX5nRJemNYDvI1/g
         /pw4kI2T4McBmStY8/cCDXj8+b6xKvnth618YuYZbvkd7z4UnULOQCjB2zTDUDeR6MCb
         SMsKY1YzZjLuKWstYm1C9o+Qhr+zdnQ7usd8+/31rQtYxfEZnSde95V+OCvBkdUa1ckW
         ZQIUAmeiItMITDwc19toSwW6vC8BOUQO92cTgOsEAT2+BFLsC8W3X7UVlkgthhuQKhV4
         aZwRz+kw89MHMZrFXI8xeOyztiX2QJsbs49RtKtk4lhZzUnYqkiB6NYJSTd8LyLod+bQ
         tYOw==
X-Gm-Message-State: ANoB5pkIUYsLyT7noZsj/yEbdf+E4RrAxGUo5Sav/7k91PnWaLPrDp05
        /3sO0/3wFM8r54Z4DE0BBsv7A3VfGFg=
X-Google-Smtp-Source: AA0mqf4z6uMzBSUfVnuK3UoNIzNb/xg7g2J6WN3bup/hKRF8Re0V4qO2ezY0m7hXj/NH+yxnxq3+nl70YfU=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:200:8539:aadd:13be:6e82])
 (user=drosen job=sendgmr) by 2002:a81:d449:0:b0:38f:af02:ee94 with SMTP id
 g9-20020a81d449000000b0038faf02ee94mr3ywl.230.1669083353587; Mon, 21 Nov 2022
 18:15:53 -0800 (PST)
Date:   Mon, 21 Nov 2022 18:15:15 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221122021536.1629178-1-drosen@google.com>
Subject: [RFC PATCH v2 00/21] FUSE BPF: A Stacked Filesystem Extension for FUSE
From:   Daniel Rosenberg <drosen@google.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
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

For this patch set, I have removed the code related to the bpf side of things
since that is undergoing some large reworks to get it in line with the more
recent BPF developements. This set of patches implements direct passthrough to
the lower filesystem with no alteration. Looking at the v1 code should give a
pretty good idea of what the general shape of the bpf calls will look like.
Without the bpf side, it's like a less efficient bind mount. Not very useful
on its own, but still useful to get eyes on it since the backing calls will be
larglely the same when bpf is in the mix.

This changes the format of adding a backing file/bpf slightly from v1. It's now
a bit more modular. You add a block of data at the end of a lookup response to
give the bpf fd and backing id, but there is now a type header to both blocks,
and a reserved value for future additions. In the future, we may allow for
multiple bpfs or backing files, and this will allow us to extend it without any
UAPI breaking changes. Multiple BPFs would be useful for combining fuse-bpf
implementations without needing to manually combine bpf fragments. Multiple
backing files would allow implementing things like a limited overlayfs.
In this patch set, this is only a single block, with only backing supported,
although I've left the definitions reflecting the BPF case as well.
For bpf, the plan is to have two blocks, with the bpf one coming first.
Any further extensions are currently just speculative.

You can run this without needing to set up a userspace daemon by adding these
mount options: root_dir=[fd],no_daemon where fd is an open file descriptor
pointing to the folder you'd like to use as the root directory. The fd can be
immediately closed after mounting. This is useful for running various fs tests.

The main changes for v2:
-Refactored code to remove many of the ifdefs
-Adjusted attr related code per Amir's suggestions
-Added ioctl interface for responding to fuse requests (required for backing)
-Adjusted lookup add-on block for adding backing file/bpf
-Moved bpf related patches to the end of the stack (not included currently)

TODO:
override_creds to interact with backing files in the same context the daemon
would

Implement backing calls for other FUSE operations (i.e. File Locking/tmp files)

Convert BPF over to more modern version

Alessio Balsini (1):
  fs: Generic function to convert iocb to rw flags

Daniel Rosenberg (20):
  fuse-bpf: Update fuse side uapi
  fuse-bpf: Prepare for fuse-bpf patch
  fuse: Add fuse-bpf, a stacked fs extension for FUSE
  fuse-bpf: Add ioctl interface for /dev/fuse
  fuse-bpf: Don't support export_operations
  fuse-bpf: Add support for FUSE_ACCESS
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

 fs/fuse/Kconfig           |    8 +
 fs/fuse/Makefile          |    1 +
 fs/fuse/backing.c         | 3118 +++++++++++++++++++++++++++++++++++++
 fs/fuse/control.c         |    2 +-
 fs/fuse/dev.c             |   83 +-
 fs/fuse/dir.c             |  326 ++--
 fs/fuse/file.c            |   62 +-
 fs/fuse/fuse_i.h          |  424 ++++-
 fs/fuse/inode.c           |  264 +++-
 fs/fuse/ioctl.c           |    2 +-
 fs/fuse/readdir.c         |    5 +
 fs/fuse/xattr.c           |   18 +
 fs/overlayfs/file.c       |   23 +-
 include/linux/fs.h        |    5 +
 include/uapi/linux/fuse.h |   24 +-
 15 files changed, 4154 insertions(+), 211 deletions(-)
 create mode 100644 fs/fuse/backing.c


base-commit: 23a60a03d9a9980d1e91190491ceea0dc58fae62
-- 
2.38.1.584.g0f3c55d4c2-goog

