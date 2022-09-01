Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179955A9DCF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 19:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbiIARKx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 13:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiIARKs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:10:48 -0400
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [IPv6:2001:1600:3:17::42af])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492FD6B8EB
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Sep 2022 10:10:46 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MJSH45RYVzMrQ3g;
        Thu,  1 Sep 2022 19:10:40 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4MJSH364RpzMpnPk;
        Thu,  1 Sep 2022 19:10:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1662052240;
        bh=16QPBRAio1Sz5xnBcDXpWi9zGPNQZQq5M93ZFotOayA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gfgA0rwxRoLKD0l71LFQdaH5fWKQIWHZW4oXlFJyUe4dmBpRcD6fAtoVyd18UswqA
         a0tnT9UXYDMaPhsCMdBiYWfXk174hrtjsR4LLeavCoSE+DubgHwLqTkv239ZjvYcKs
         DXkocbb7dflpGvnuw3C5IgOf0AyxSayfqLhHgucY=
Message-ID: <b336dcfc-7d28-dea9-54de-0b8e4b725c1c@digikod.net>
Date:   Thu, 1 Sep 2022 19:10:38 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v5 0/4] landlock: truncate support
Content-Language: en-US
To:     =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org
Cc:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
References: <20220817203006.21769-1-gnoack3000@gmail.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20220817203006.21769-1-gnoack3000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hmm, I think there is an issue with this series. Landlock only enforces 
restrictions at open time or when dealing with user-supplied file paths 
(relative or absolute). The use of the path_truncate hook in this series 
doesn't distinguish between file descriptor from before the current 
sandbox or from after being sandboxed. For instance, if a file 
descriptor is received through a unix socket, it is assumed that this is 
legitimate and no Landlock restriction apply on it, which is not the 
case with this series anymore. It is the same for files opened before 
the process sandbox itself.

To be able to follow the current semantic, I think we should control the 
truncate access at open time (or when dealing with a user-supplied path) 
but not on any file descriptor as it is currently done.


On 17/08/2022 22:30, Günther Noack wrote:
> The goal of these patches is to work towards a more complete coverage
> of file system operations that are restrictable with Landlock.
> 
> The known set of currently unsupported file system operations in
> Landlock is described at [1]. Out of the operations listed there,
> truncate is the only one that modifies file contents, so these patches
> should make it possible to prevent the direct modification of file
> contents with Landlock.
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
> Apart from Landlock, file truncation can also be restricted using
> seccomp-bpf, but it is more difficult to use (requires BPF, requires
> keeping up-to-date syscall lists) and it is not configurable by file
> hierarchy, as Landlock is. The simplicity and flexibility of the
> Landlock approach makes it worthwhile adding.
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
> These patches are based on version 6.0-rc1.
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
> 
> Changelog:
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
> Günther Noack (4):
>    landlock: Support file truncation
>    selftests/landlock: Selftests for file truncation support
>    samples/landlock: Extend sample tool to support
>      LANDLOCK_ACCESS_FS_TRUNCATE
>    landlock: Document Landlock's file truncation support
> 
>   Documentation/userspace-api/landlock.rst     |  52 +++-
>   include/uapi/linux/landlock.h                |  17 +-
>   samples/landlock/sandboxer.c                 |  23 +-
>   security/landlock/fs.c                       |   9 +-
>   security/landlock/limits.h                   |   2 +-
>   security/landlock/syscalls.c                 |   2 +-
>   tools/testing/selftests/landlock/base_test.c |   2 +-
>   tools/testing/selftests/landlock/fs_test.c   | 257 ++++++++++++++++++-
>   8 files changed, 336 insertions(+), 28 deletions(-)
> 
> 
> base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
> --
> 2.37.2
