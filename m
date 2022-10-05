Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBBF5F5A8B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Oct 2022 21:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiJETSK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Oct 2022 15:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJETSJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Oct 2022 15:18:09 -0400
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [IPv6:2001:1600:4:17::190e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1794513D29
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Oct 2022 12:18:07 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MjPVN5nhqzMq2g2;
        Wed,  5 Oct 2022 21:18:04 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MjPVL6KgFzx4;
        Wed,  5 Oct 2022 21:18:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1664997484;
        bh=S/siV5PRviBeyZ1OcEosTCZCN+RnCXzNAgzfLNJAJ6I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=yLOm/397ilOSwpQmGq1urCOZz6hhQPiGMwt8Hf5L/rLMVzCnQb4N/2j5qLZ7MTNug
         ntANqlHH2J961rEH5UC//eGF4eOraGmEfe6MN2MQ8WnOj2SkQOKvUOh4rwvCHgcsCa
         xDP/1higQ7edJ0MxfxCFYCs8CWZnBA2P/L5hUHfk=
Message-ID: <971872fe-f2ae-ca6a-5b58-019fed8c9952@digikod.net>
Date:   Wed, 5 Oct 2022 21:18:02 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v8 0/9] landlock: truncate support
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org
Cc:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
References: <20221001154908.49665-1-gnoack3000@gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20221001154908.49665-1-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series is almost ready, I guess the next one will be the 
final one.

I sent a related PR for syzkaller: 
https://github.com/google/syzkaller/pull/3423


On 01/10/2022 17:48, Günther Noack wrote:
> The goal of these patches is to work towards a more complete coverage
> of file system operations that are restrictable with Landlock.
> 
> Motivation
> ----------
> 
> The known set of currently unsupported file system operations in
> Landlock is described at [1]. Out of the operations listed there,
> truncate is the only one that modifies file contents, so these patches
> should make it possible to prevent the direct modification of file
> contents with Landlock.
> 
> Apart from Landlock, file truncation can also be restricted using
> seccomp-bpf, but it is more difficult to use (requires BPF, requires
> keeping up-to-date syscall lists) and it is not configurable by file
> hierarchy, as Landlock is. The simplicity and flexibility of the
> Landlock approach makes it worthwhile adding.
> 
> Implementation overview
> -----------------------
> 
> The patch introduces the truncation restriction feature as an
> additional bit in the access_mask_t bitmap, in line with the existing
> supported operations.
> 
> The truncation flag covers both the truncate(2) and ftruncate(2)
> families of syscalls, as well as open(2) with the O_TRUNC flag.
> This includes usages of creat() in the case where existing regular
> files are overwritten.
> 
> Additionally, this patch set introduces a new Landlock security blob
> associated with opened files, to track the available Landlock access
> rights at the time of opening the file. This is in line with Unix's
> general approach of checking the read and write permissions during
> open(), and associating this previously checked authorization with the
> opened file.
> 
> In order to treat truncate(2) and ftruncate(2) calls differently in an
> LSM hook, we split apart the existing security_path_truncate hook into
> security_path_truncate (for truncation by path) and
> security_file_truncate (for truncation of previously opened files).
> 
> Relationship between "truncate" and "write" rights
> --------------------------------------------------
> 
> While it's possible to use the "write file" and "truncate" rights
> independent of each other, it simplifies the mental model for
> userspace callers to always use them together.
> 
> Specifically, the following behaviours might be surprising for users
> when using these independently:
> 
>   * The commonly creat() syscall requires the truncate right when
>     overwriting existing files, as it is equivalent to open(2) with
>     O_TRUNC|O_CREAT|O_WRONLY.
>   * The "write file" right is not always required to truncate a file,
>     even through the open(2) syscall (when using O_RDONLY|O_TRUNC).
> 
> Nevertheless, keeping the two flags separate is the correct approach
> to guarantee backwards compatibility for existing Landlock users.
> 
> When the "truncate" right is checked for ftruncate(2)
> -----------------------------------------------------
> 
> Notably, for the purpose of ftruncate(2), the Landlock truncation
> access right is looked up when *opening* the file, not when calling
> ftruncate(). The availability of the truncate right is associated with
> the opened file and is later checked to authorize ftruncate(2)
> operations.
> 
> This is similar to how the write mode gets remembered after a
> open(..., O_WRONLY) to authorize later write() operations.
> 
> These opened file descriptors can also be passed between processes and
> will continue to enforce their truncation properties when these
> processes attempt an ftruncate().
> 
> Ongoing discussions
> -------------------
> 
> The one remaining ongoing discussion from v6 of the patch set is the
> question whether we need to touch fs/ksmbd and fs/cachefiles, which
> are both using vfs_truncate() to truncate files by path, even though
> they already have the same struct file open. The proposal was to
> introduce a "vfs_ftruncate()" that would work on opened files.
> 
> I think we should decouple this from the truncate patch set, with the
> reasoning that:
> 
> (a) it would be a bigger change to create a "vfs_ftruncate()" which
> would reach beyond the scope of this patch set.
> 
> (b) it seems likely that both components do not need to run under
> Landlock at the moment and can be updated independently (just like it
> needs to happen for normal userspace software in order to run it under
> Landlock).
> 
> (c) vfs_truncate() is not the perfectly narrowest API for truncating
> an opened file, but it's a legitimate way to do that and the operation
> *is* checked with a Landlock LSM hook, although it might potentially
> permit for a narrower sandboxing if that was done differently. That's
> speculative though.
> 
> Overall, it's unclear whether doing this has any sandboxing benefits
> for ksmbd and cachefiles, whereas on the downside, it would expand the
> scope of the patch set quite a bit and would have to touch core parts
> of the kernel (fs/open.c).
> 
> These patches are based on version 6.0-rc7.
> 
> Best regards,
> Günther
> 
> [1] https://docs.kernel.org/userspace-api/landlock.html#filesystem-flags
> 
> Past discussions:
> V1: https://lore.kernel.org/all/20220707200612.132705-1-gnoack3000@gmail.com/
> V2: https://lore.kernel.org/all/20220712211405.14705-1-gnoack3000@gmail.com/
> V3: https://lore.kernel.org/all/20220804193746.9161-1-gnoack3000@gmail.com/
> V4: https://lore.kernel.org/all/20220814192603.7387-1-gnoack3000@gmail.com/
> V5: https://lore.kernel.org/all/20220817203006.21769-1-gnoack3000@gmail.com/
> V6: https://lore.kernel.org/all/20220908195805.128252-1-gnoack3000@gmail.com/
> V7: https://lore.kernel.org/all/20220930160144.141504-1-gnoack3000@gmail.com/
> 
> Changelog:
> 
> V8:
> * landlock: Refactor check_access_path_dual() into
>    is_access_to_paths_allowed(), as suggested by Mickaël Salaün on the
>    v7 review. Added this as a separate commit.
> * landlock truncate feature: inline get_path_access()
> * Documentation: update documentation date to October 2022
> * selftests: locally #define __maybe_unused (checkpatch started
>    complaining about it, but the header where it's defined is not
>    usable from selftests)
> 
> V7:
> * security: Create file_truncate hook
>    * Fix the build on kernels without CONFIG_SECURITY_PATH (fixed by
>      Mickaël Salaün)
>    * lsm_hooks.h: Document file_truncate hook
>    * fs/open.c: undo accidental indentation changes
> * landlock: Support file truncation
>    * Use the init_layer_masks() result as input for
>      check_access_path_dual()
>    * Naming
>      * Rename the landlock_file_security.allowed_access field
>        (previously called "rights")
>      * Rename get_path_access_rights() to get_path_access()
>      * Rename get_file_access() to get_required_file_open_access() to
>        avoid confusion with get_path_access()
>      * Use "access_request" for access_mask_t variables, access_req for
>        unsigned long
>    * Documentation:
>      * Fixed some comments according to review
>      * Added comments to get_required_file_open_access() and
>        init_layer_masks()
> * selftests:
>    * remove unused variables
>    * rename fd0,...,fd3 to fd_layer0,...,fd_layer3.
>    * test_ftruncate: define layers on top and inline the helper function
> * New tests (both added as separate commits)
>    * More exhaustive ftruncate test: Add open_and_ftruncate test that
>      exercises ftruncate more thoroughly with fixture variants
>    * FD-passing test: exercise restricted file descriptors getting
>      passed between processes, also using the same fixture variants
> * Documentation: integrate review comments by Mickaël Salaün
>    * do not use contraptions (don't)
>    * use double backquotes in all touched lines
>    * add the read/write open() analogy to the truncation docs
>    * in code example, check for abi<0 explicitly and fix indentation
> 
> V6:
> * LSM hooks: create file_truncate hook in addition to path_truncate.
>    Use it in the existing path_truncate call sites where appropriate.
> * landlock: check LANDLOCK_ACCESS_FS_TRUNCATE right during open(), and
>    associate that right with the opened struct file in a security blob.
>    Introduce get_path_access_rights() helper function.
> * selftests: test ftruncate in a separate test, to exercise that
>    the rights are associated with the file descriptor.
> * Documentation: Rework documentation to reflect new ftruncate() semantics.
> * Applied small fixes by Mickaël Salaün which he added on top of V5, in
>    https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/log/?h=next
>    (I hope I found them all.)
> 
> V5:
> * Documentation
>    * Fix wording in userspace-api headers and in landlock.rst.
>    * Move the truncation limitation section one to the bottom.
>    * Move all .rst changes into the documentation commit.
> * selftests
>    * Remove _metadata argument from helpers where it became unnecessary.
>    * Open writable file descriptors at the top of both tests, before Landlock
>      is enabled, to exercise ftruncate() independently from open().
>    * Simplify test_ftruncate and decouple it from exercising open().
>    * test_creat(): Return errno on close() failure (it does not conflict).
>    * Fix /* comment style */
>    * Reorder blocks of EXPECT_EQ checks to be consistent within a test.
>    * Add missing |O_TRUNC to a check in one test.
>    * Put the truncate_unhandled test before the other.
> 
> V4:
>   * Documentation
>     * Clarify wording and syntax as discussed in review.
>     * Use a less confusing error message in the example.
>   * selftests:
>     * Stop using ASSERT_EQ in test helpers, return EBADFD instead.
>       (This is an intentionally uncommon error code, so that the source
>       of the error is clear and the test can distinguish test setup
>       failures from failures in the actual system call under test.)
>   * samples/Documentation:
>     * Use additional clarifying comments in the kernel backwards
>       compatibility logic.
> 
> V3:
>   * selftests:
>     * Explicitly test ftruncate with readonly file descriptors
>       (returns EINVAL).
>     * Extract test_ftruncate, test_truncate, test_creat helpers,
>       which simplified the previously mixed usage of EXPECT/ASSERT.
>     * Test creat() behaviour as part of the big truncation test.
>     * Stop testing the truncate64(2) and ftruncate64(2) syscalls.
>       This simplifies the tests a bit. The kernel implementations are the
>       same as for truncate(2) and ftruncate(2), so there is little benefit
>       from testing them exhaustively. (We aren't testing all open(2)
>       variants either.)
>   * samples/landlock/sandboxer.c:
>     * Use switch() to implement best effort mode.
>   * Documentation:
>     * Give more background on surprising truncation behaviour.
>     * Use switch() in the example too, to stay in-line with the sample tool.
>     * Small fixes in header file to address previous comments.
> * misc:
>    * Fix some typos and const usages.
> 
> V2:
>   * Documentation: Mention the truncation flag where needed.
>   * Documentation: Point out connection between truncation and file writing.
>   * samples: Add file truncation to the landlock/sandboxer.c sample tool.
>   * selftests: Exercise open(2) with O_TRUNC and creat(2) exhaustively.
>   * selftests: Exercise truncation syscalls when the truncate right
>     is not handled by Landlock.
> 
> Günther Noack (9):
>    security: Create file_truncate hook from path_truncate hook
>    selftests/landlock: Locally define __maybe_unused
>    landlock: Refactor check_access_path_dual() into
>      is_access_to_paths_allowed()
>    landlock: Support file truncation
>    selftests/landlock: Selftests for file truncation support
>    selftests/landlock: Test open() and ftruncate() in multiple scenarios
>    selftests/landlock: Test FD passing from a Landlock-restricted to an
>      unrestricted process
>    samples/landlock: Extend sample tool to support
>      LANDLOCK_ACCESS_FS_TRUNCATE
>    landlock: Document Landlock's file truncation support
> 
>   Documentation/userspace-api/landlock.rst     |  66 ++-
>   fs/namei.c                                   |   2 +-
>   fs/open.c                                    |   2 +-
>   include/linux/lsm_hook_defs.h                |   1 +
>   include/linux/lsm_hooks.h                    |  10 +-
>   include/linux/security.h                     |   6 +
>   include/uapi/linux/landlock.h                |  21 +-
>   samples/landlock/sandboxer.c                 |  23 +-
>   security/apparmor/lsm.c                      |   6 +
>   security/landlock/fs.c                       | 191 +++++---
>   security/landlock/fs.h                       |  24 +
>   security/landlock/limits.h                   |   2 +-
>   security/landlock/setup.c                    |   1 +
>   security/landlock/syscalls.c                 |   2 +-
>   security/security.c                          |   5 +
>   security/tomoyo/tomoyo.c                     |  13 +
>   tools/testing/selftests/landlock/base_test.c |  38 +-
>   tools/testing/selftests/landlock/common.h    |  85 +++-
>   tools/testing/selftests/landlock/fs_test.c   | 452 ++++++++++++++++++-
>   19 files changed, 828 insertions(+), 122 deletions(-)
> 
> 
> base-commit: f76349cf41451c5c42a99f18a9163377e4b364ff
