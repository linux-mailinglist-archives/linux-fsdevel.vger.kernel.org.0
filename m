Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1681C4EADD7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 14:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236892AbiC2Mxb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 08:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237145AbiC2Mw7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 08:52:59 -0400
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6533D65DE
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 05:51:00 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KSTvQ1PW2zMq12m;
        Tue, 29 Mar 2022 14:50:58 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4KSTvN48RFzlhRV5;
        Tue, 29 Mar 2022 14:50:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1648558258;
        bh=30DsOpvra0kSW59WSQV7y+gbtpJ+JQgeFCNzw4XWLXI=;
        h=From:To:Cc:Subject:Date:From;
        b=Z5sh+qFGfjJpuUF5qsB5XzdkskXrGFLBI3Q6fzWTYyXKD+nhwaqOvB5HiegtH2D8w
         RDfu3m4SO160S/f0OOmoS0kbP7OyZw1GI2Yln5ATMN6k/srgFbRZS28BKKaAoVH+/Z
         qIUNkVv8mSRMXPNMny64kCBix40BpgleK56Jib+M=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Paul Moore <paul@paul-moore.com>,
        Shuah Khan <shuah@kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v2 00/12] Landlock: file linking and renaming support
Date:   Tue, 29 Mar 2022 14:51:05 +0200
Message-Id: <20220329125117.1393824-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This second patch series includes a path_rename hook update:
https://lore.kernel.org/r/20220222175332.384545-1-mic@digikod.net
This enables to return consistent errors (EXDEV or EACCES) in case of
file renaming with RENAME_EXCHANGE.  This led to a some refactoring of
check_access_path_dual(), no_more_access() and
current_check_refer_path() to make them more generic and properly handle
access requests indifferently for a source or a destination path.  I
also added 5 new test suites to cover new edge cases.

Problem
=======

One of the most annoying limitations of Landlock is that sandboxed
processes can only link and rename files to the same directory (i.e.
file reparenting is always denied).  Indeed, because of the unprivileged
nature of Landlock, file hierarchy are identified thanks to ephemeral
inode tagging, which may cause arbitrary renaming and linking to change
the security policy in an unexpected way.

Solution
========

This patch series brings a new access right, LANDLOCK_ACCESS_FS_REFER,
which enables to allow safe file linking and renaming.  In a nutshell,
Landlock checks that the inherited access rights of a moved or renamed
file cannot increase but only reduce.  Eleven new test suits cover file
renaming and linking, which brings coverage for security/landlock/ from
93.5% of lines to 94.6%.

The documentation and the tutorial is extended with this new access
right, along with more explanations about backward and forward
compatibility, good practices, and a bit about the current access
rights rational.

While developing this new feature, I also found an issue with the
current implementation of Landlock.  In some (rare) cases, sandboxed
processes may be more restricted than intended.  Indeed, because of the
current way to check file hierarchy access rights, composition of rules
may be incomplete when requesting multiple accesses at the same time.
This is fixed with a dedicated patch involving some refactoring.  A new
test suite checks relevant new edge cases.

As a side effect, and to limit the increased use of the stack, I reduced
the number of Landlock nested domains from 64 to 16.  I think this
should be more than enough for legitimate use cases, but feel free to
challenge this decision with real and legitimate use cases.

This patch series was developed with some complementary new tests sent
in a standalone patch series:
https://lore.kernel.org/r/20220221155311.166278-1-mic@digikod.net

Additionally, a new dedicated syzkaller test has been developed to cover
new paths.

Previous version:
https://lore.kernel.org/r/20220221212522.320243-1-mic@digikod.net

Regards,

Mickaël Salaün (12):
  landlock: Define access_mask_t to enforce a consistent access mask
    size
  landlock: Reduce the maximum number of layers to 16
  landlock: Create find_rule() from unmask_layers()
  landlock: Fix same-layer rule unions
  landlock: Move filesystem helpers and add a new one
  LSM: Remove double path_rename hook calls for RENAME_EXCHANGE
  landlock: Add support for file reparenting with
    LANDLOCK_ACCESS_FS_REFER
  selftest/landlock: Add 11 new test suites dedicated to file
    reparenting
  samples/landlock: Add support for file reparenting
  landlock: Document LANDLOCK_ACCESS_FS_REFER and ABI versioning
  landlock: Document good practices about filesystem policies
  landlock: Add design choices documentation for filesystem access
    rights

 Documentation/security/landlock.rst          |   17 +-
 Documentation/userspace-api/landlock.rst     |  149 ++-
 include/linux/lsm_hook_defs.h                |    2 +-
 include/linux/lsm_hooks.h                    |    1 +
 include/uapi/linux/landlock.h                |   27 +-
 samples/landlock/sandboxer.c                 |   37 +-
 security/apparmor/lsm.c                      |   30 +-
 security/landlock/fs.c                       |  776 ++++++++++---
 security/landlock/fs.h                       |    2 +-
 security/landlock/limits.h                   |    6 +-
 security/landlock/ruleset.c                  |    6 +-
 security/landlock/ruleset.h                  |   23 +-
 security/landlock/syscalls.c                 |    2 +-
 security/security.c                          |    9 +-
 security/tomoyo/tomoyo.c                     |   11 +-
 tools/testing/selftests/landlock/base_test.c |    2 +-
 tools/testing/selftests/landlock/fs_test.c   | 1038 ++++++++++++++++--
 17 files changed, 1857 insertions(+), 281 deletions(-)


base-commit: 59db887d13b3a4df2713c2a866fa2767e0dea569
-- 
2.35.1

