Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA0E5F84B1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Oct 2022 12:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiJHKJq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Oct 2022 06:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJHKJp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Oct 2022 06:09:45 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738B4639D;
        Sat,  8 Oct 2022 03:09:41 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id r17so15904125eja.7;
        Sat, 08 Oct 2022 03:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p6m6g60uYKUeaDSpPcV4YBPYpVUfScbBXRIkSPLgwVA=;
        b=Ma6TyAvf5UrWZ0h++POISdjbEF9jNNKUneHeo41Ap/hnd8nLIBufBRNanZ6XCFgHax
         XIM5k7IGEt+Z6qB3Cw9dfkvCRFBM6hB1kuzv1MZcs7yREJu1VJgC/q3akO77HHmkcd14
         gr+wAXoptskHRBG/+BIBYZqyecvryWezJ6pIZVcUqyVMB95aZlkmTtJuPjL7Yk4pcFqW
         CAwv57XbFgGqtdUMXmut08LJk4zOe4kDYDycO+eVFUrVSxdIuLDOhWm+CNS2WF+gD3KU
         m+scQUyT2LU5RNDkr3xjwKPsNWGDRb09pUcvEgpl/rCCkakTedq9BQ/Io6T3Dtnfui8y
         BkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p6m6g60uYKUeaDSpPcV4YBPYpVUfScbBXRIkSPLgwVA=;
        b=dTeO6akj5wDGUxCjwNucAmTZJoMNWPKJ9/UiATP/HN56SdabhUnInxR00rtdwx2xzv
         9mnx1gWtb0kFRcSo5kHutdXbPHBn/Zk3NpwPlK8uDiqtXda6VOsn1qab0zyiBjVkPp/8
         53bKlaGy53JAGDXvIxxzkzhEiGrZUoGT8ArCnnmQw3N3biC7pvU6pznoZcXmFD7MglWx
         X8e7OmwOvATxGJJWgwfm5yNqOaXkqXIxoBxg8/mqdFbYm8s+B/BDlGK3OzGNC+DoVv3Y
         n+Ci4gdEIA2Z3Wpzlrku14QIcHq7joHg2sbLtiH34s5TOtRqKq/bwp3bujPGNMyzC1dR
         SkOQ==
X-Gm-Message-State: ACrzQf2SmJSEL2n+TJ+Q5v5MG+xjUjCsj3+jE20g6aMBuir7PhdC4Iup
        5jyDebCC7tXjy3UbM/zTU+oF9T0+jFI=
X-Google-Smtp-Source: AMsMyM6HoWLABveOn41n73/TqhRVFYutli/93PgtZL3wf9C7JGSenN++qMjpWf67TRdBDJKBfnCw/Q==
X-Received: by 2002:a17:907:6e87:b0:782:2d55:f996 with SMTP id sh7-20020a1709076e8700b007822d55f996mr7309086ejc.502.1665223779798;
        Sat, 08 Oct 2022 03:09:39 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id e9-20020aa7d7c9000000b00452878cba5bsm3092012eds.97.2022.10.08.03.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 03:09:39 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Nathan Chancellor <nathan@kernel.org>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v9 00/11] landlock: truncate support
Date:   Sat,  8 Oct 2022 12:09:26 +0200
Message-Id: <20221008100935.73706-1-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The goal of these patches is to work towards a more complete coverage
of file system operations that are restrictable with Landlock.

Motivation
----------

The known set of currently unsupported file system operations in
Landlock is described at [1]. Out of the operations listed there,
truncate is the only one that modifies file contents, so these patches
should make it possible to prevent the direct modification of file
contents with Landlock.

Apart from Landlock, file truncation can also be restricted using
seccomp-bpf, but it is more difficult to use (requires BPF, requires
keeping up-to-date syscall lists) and it is not configurable by file
hierarchy, as Landlock is. The simplicity and flexibility of the
Landlock approach makes it worthwhile adding.

Implementation overview
-----------------------

The patch introduces the truncation restriction feature as an
additional bit in the access_mask_t bitmap, in line with the existing
supported operations.

The truncation flag covers both the truncate(2) and ftruncate(2)
families of syscalls, as well as open(2) with the O_TRUNC flag.
This includes usages of creat() in the case where existing regular
files are overwritten.

Additionally, this patch set introduces a new Landlock security blob
associated with opened files, to track the available Landlock access
rights at the time of opening the file. This is in line with Unix's
general approach of checking the read and write permissions during
open(), and associating this previously checked authorization with the
opened file.

In order to treat truncate(2) and ftruncate(2) calls differently in an
LSM hook, we split apart the existing security_path_truncate hook into
security_path_truncate (for truncation by path) and
security_file_truncate (for truncation of previously opened files).

We also implement the file_alloc_security hook, in order to override
the access rights in the file security blob, in cases where the file
is opened by other means than open(2), but where the opened file still
supports ftruncate(2). This is also demonstrated in a selftest, using
memfd_create(2).

Relationship between "truncate" and "write" rights
--------------------------------------------------

While it's possible to use the "write file" and "truncate" rights
independent of each other, it simplifies the mental model for
userspace callers to always use them together.

Specifically, the following behaviours might be surprising for users
when using these independently:

 * The commonly creat() syscall requires the truncate right when
   overwriting existing files, as it is equivalent to open(2) with
   O_TRUNC|O_CREAT|O_WRONLY.
 * The "write file" right is not always required to truncate a file,
   even through the open(2) syscall (when using O_RDONLY|O_TRUNC).

Nevertheless, keeping the two flags separate is the correct approach
to guarantee backwards compatibility for existing Landlock users.

When the "truncate" right is checked for ftruncate(2)
-----------------------------------------------------

Notably, for the purpose of ftruncate(2), the Landlock truncation
access right is looked up when *opening* the file, not when calling
ftruncate(). The availability of the truncate right is associated with
the opened file and is later checked to authorize ftruncate(2)
operations.

This is similar to how the write mode gets remembered after a
open(..., O_WRONLY) to authorize later write() operations.

These opened file descriptors can also be passed between processes and
will continue to enforce their truncation properties when these
processes attempt an ftruncate().

These patches are based on master, commit e8bc52cb8df8 ("Merge tag
'driver-core-6.1-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core").

Best regards,
Günther

[1] https://docs.kernel.org/userspace-api/landlock.html#filesystem-flags

Past discussions:
V1: https://lore.kernel.org/all/20220707200612.132705-1-gnoack3000@gmail.com/
V2: https://lore.kernel.org/all/20220712211405.14705-1-gnoack3000@gmail.com/
V3: https://lore.kernel.org/all/20220804193746.9161-1-gnoack3000@gmail.com/
V4: https://lore.kernel.org/all/20220814192603.7387-1-gnoack3000@gmail.com/
V5: https://lore.kernel.org/all/20220817203006.21769-1-gnoack3000@gmail.com/
V6: https://lore.kernel.org/all/20220908195805.128252-1-gnoack3000@gmail.com/
V7: https://lore.kernel.org/all/20220930160144.141504-1-gnoack3000@gmail.com/
V8: https://lore.kernel.org/all/20221001154908.49665-1-gnoack3000@gmail.com/

Changelog:

V9:
* Implement file_alloc_security hook
  * Needs to grant all Landlock rights by default for use cases where
    files are opened by other means than open(2), i.e. memfd_create(2)
  * Discovered and fixed by Mickaël Salaün on his -next branch
  * Add a selftest for the memfd_create(2) example
* file_open_hook: Reorder the logic a bit as discussed in review
* selftests: Return -errno from recv_fd() and send_fd()
* Rebase to master branch
* Reorder __maybe_unused patch before its use
* Various small formatting and documentation fixes in code,
  documentation and commit messages

V8:
* landlock: Refactor check_access_path_dual() into
  is_access_to_paths_allowed(), as suggested by Mickaël Salaün on the
  v7 review. Added this as a separate commit.
* landlock truncate feature: inline get_path_access()
* Documentation: update documentation date to October 2022
* selftests: locally #define __maybe_unused (checkpatch started
  complaining about it, but the header where it's defined is not
  usable from selftests)

V7:
* security: Create file_truncate hook
  * Fix the build on kernels without CONFIG_SECURITY_PATH (fixed by
    Mickaël Salaün)
  * lsm_hooks.h: Document file_truncate hook
  * fs/open.c: undo accidental indentation changes
* landlock: Support file truncation
  * Use the init_layer_masks() result as input for
    check_access_path_dual()
  * Naming
    * Rename the landlock_file_security.allowed_access field
      (previously called "rights")
    * Rename get_path_access_rights() to get_path_access()
    * Rename get_file_access() to get_required_file_open_access() to
      avoid confusion with get_path_access()
    * Use "access_request" for access_mask_t variables, access_req for
      unsigned long
  * Documentation:
    * Fixed some comments according to review
    * Added comments to get_required_file_open_access() and
      init_layer_masks()
* selftests:
  * remove unused variables
  * rename fd0,...,fd3 to fd_layer0,...,fd_layer3.
  * test_ftruncate: define layers on top and inline the helper function
* New tests (both added as separate commits)
  * More exhaustive ftruncate test: Add open_and_ftruncate test that
    exercises ftruncate more thoroughly with fixture variants
  * FD-passing test: exercise restricted file descriptors getting
    passed between processes, also using the same fixture variants
* Documentation: integrate review comments by Mickaël Salaün
  * do not use contraptions (don't)
  * use double backquotes in all touched lines
  * add the read/write open() analogy to the truncation docs
  * in code example, check for abi<0 explicitly and fix indentation

V6:
* LSM hooks: create file_truncate hook in addition to path_truncate.
  Use it in the existing path_truncate call sites where appropriate.
* landlock: check LANDLOCK_ACCESS_FS_TRUNCATE right during open(), and
  associate that right with the opened struct file in a security blob.
  Introduce get_path_access_rights() helper function.
* selftests: test ftruncate in a separate test, to exercise that
  the rights are associated with the file descriptor.
* Documentation: Rework documentation to reflect new ftruncate() semantics.
* Applied small fixes by Mickaël Salaün which he added on top of V5, in
  https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/log/?h=next
  (I hope I found them all.)

V5:
* Documentation
  * Fix wording in userspace-api headers and in landlock.rst.
  * Move the truncation limitation section one to the bottom.
  * Move all .rst changes into the documentation commit.
* selftests
  * Remove _metadata argument from helpers where it became unnecessary.
  * Open writable file descriptors at the top of both tests, before Landlock
    is enabled, to exercise ftruncate() independently from open().
  * Simplify test_ftruncate and decouple it from exercising open().
  * test_creat(): Return errno on close() failure (it does not conflict).
  * Fix /* comment style */
  * Reorder blocks of EXPECT_EQ checks to be consistent within a test.
  * Add missing |O_TRUNC to a check in one test.
  * Put the truncate_unhandled test before the other.

V4:
 * Documentation
   * Clarify wording and syntax as discussed in review.
   * Use a less confusing error message in the example.
 * selftests:
   * Stop using ASSERT_EQ in test helpers, return EBADFD instead.
     (This is an intentionally uncommon error code, so that the source
     of the error is clear and the test can distinguish test setup
     failures from failures in the actual system call under test.)
 * samples/Documentation:
   * Use additional clarifying comments in the kernel backwards
     compatibility logic.

V3:
 * selftests:
   * Explicitly test ftruncate with readonly file descriptors
     (returns EINVAL).
   * Extract test_ftruncate, test_truncate, test_creat helpers,
     which simplified the previously mixed usage of EXPECT/ASSERT.
   * Test creat() behaviour as part of the big truncation test.
   * Stop testing the truncate64(2) and ftruncate64(2) syscalls.
     This simplifies the tests a bit. The kernel implementations are the
     same as for truncate(2) and ftruncate(2), so there is little benefit
     from testing them exhaustively. (We aren't testing all open(2)
     variants either.)
 * samples/landlock/sandboxer.c:
   * Use switch() to implement best effort mode.
 * Documentation:
   * Give more background on surprising truncation behaviour.
   * Use switch() in the example too, to stay in-line with the sample tool.
   * Small fixes in header file to address previous comments.
* misc:
  * Fix some typos and const usages.

V2:
 * Documentation: Mention the truncation flag where needed.
 * Documentation: Point out connection between truncation and file writing.
 * samples: Add file truncation to the landlock/sandboxer.c sample tool.
 * selftests: Exercise open(2) with O_TRUNC and creat(2) exhaustively.
 * selftests: Exercise truncation syscalls when the truncate right
   is not handled by Landlock.

Günther Noack (11):
  security: Create file_truncate hook from path_truncate hook
  landlock: Refactor check_access_path_dual() into
    is_access_to_paths_allowed()
  landlock: Document init_layer_masks() helper
  landlock: Support file truncation
  selftests/landlock: Test file truncation support
  selftests/landlock: Test open() and ftruncate() in multiple scenarios
  selftests/landlock: Locally define __maybe_unused
  selftests/landlock: Test FD passing from restricted to unrestricted
    processes
  selftests/landlock: Test ftruncate on FDs created by memfd_create(2)
  samples/landlock: Extend sample tool to support
    LANDLOCK_ACCESS_FS_TRUNCATE
  landlock: Document Landlock's file truncation support

 Documentation/userspace-api/landlock.rst     |  67 ++-
 fs/namei.c                                   |   2 +-
 fs/open.c                                    |   2 +-
 include/linux/lsm_hook_defs.h                |   1 +
 include/linux/lsm_hooks.h                    |  10 +-
 include/linux/security.h                     |   6 +
 include/uapi/linux/landlock.h                |  21 +-
 samples/landlock/sandboxer.c                 |  12 +-
 security/apparmor/lsm.c                      |   6 +
 security/landlock/fs.c                       | 204 ++++++--
 security/landlock/fs.h                       |  24 +
 security/landlock/limits.h                   |   2 +-
 security/landlock/setup.c                    |   1 +
 security/landlock/syscalls.c                 |   2 +-
 security/security.c                          |   5 +
 security/tomoyo/tomoyo.c                     |  13 +
 tools/testing/selftests/landlock/base_test.c |  38 +-
 tools/testing/selftests/landlock/common.h    |  85 +++-
 tools/testing/selftests/landlock/fs_test.c   | 468 ++++++++++++++++++-
 19 files changed, 854 insertions(+), 115 deletions(-)


base-commit: e8bc52cb8df80c31c73c726ab58ea9746e9ff734
-- 
2.38.0

