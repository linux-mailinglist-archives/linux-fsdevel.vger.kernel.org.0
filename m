Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5029D4BEC8A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Feb 2022 22:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbiBUVYL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Feb 2022 16:24:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234772AbiBUVXR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Feb 2022 16:23:17 -0500
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [IPv6:2001:1600:3:17::190b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07F22737
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Feb 2022 13:22:51 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4K2Znp6nTfzMqFht;
        Mon, 21 Feb 2022 22:15:10 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4K2Znp0FmxzljTg3;
        Mon, 21 Feb 2022 22:15:09 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Paul Moore <paul@paul-moore.com>,
        Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v1 00/11] Landlock: file linking and renaming support
Date:   Mon, 21 Feb 2022 22:25:11 +0100
Message-Id: <20220221212522.320243-1-mic@digikod.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

One of the most annoying limitations of Landlock is that sandboxed
processes can only link and rename files to the same directory (i.e.
file reparenting is always denied).  Indeed, because of the unprivileged
nature of Landlock, file hierarchy are identified thanks to ephemeral
inode tagging, which may cause arbitrary renaming and linking to change
the security policy in an unexpected way.

This patch series brings a new access right, LANDLOCK_ACCESS_FS_REFER,
which enables to allow safe file linking and renaming.  In a nutshell,
Landlock checks that the inherited access rights of a moved or renamed
file cannot increase but only reduce.  Six new test suits cover file
renaming and linking, which brings coverage for security/landlock/ from
93.5% of lines to 94.4%.

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

Because of the current path_rename security hook, Landlock cannot yet
return consistent error codes with RENAME_EXCHANGE.  I plan to address
this issue with a next series.

This patch series was developed with some complementary new tests sent
in a standalone patch series:
https://lore.kernel.org/r/20220221155311.166278-1-mic@digikod.net

Additionally, a new dedicated syzkaller test has been developed to cover
new paths.

Regards,

Mickaël Salaün (11):
  landlock: Define access_mask_t to enforce a consistent access mask
    size
  landlock: Reduce the maximum number of layers to 16
  landlock: Create find_rule() from unmask_layers()
  landlock: Fix same-layer rule unions
  landlock: Move filesystem helpers and add a new one
  landlock: Add support for file reparenting with
    LANDLOCK_ACCESS_FS_REFER
  selftest/landlock: Add 6 new test suites dedicated to file reparenting
  samples/landlock: Add support for file reparenting
  landlock: Document LANDLOCK_ACCESS_FS_REFER and ABI versioning
  landlock: Document good practices about filesystem policies
  landlock: Add design choices documentation for filesystem access
    rights

 Documentation/security/landlock.rst          |  17 +-
 Documentation/userspace-api/landlock.rst     | 145 +++-
 include/uapi/linux/landlock.h                |  27 +-
 samples/landlock/sandboxer.c                 |  37 +-
 security/landlock/fs.c                       | 721 +++++++++++++++----
 security/landlock/fs.h                       |   2 +-
 security/landlock/limits.h                   |   6 +-
 security/landlock/ruleset.c                  |   6 +-
 security/landlock/ruleset.h                  |  23 +-
 security/landlock/syscalls.c                 |   2 +-
 tools/testing/selftests/landlock/base_test.c |   2 +-
 tools/testing/selftests/landlock/fs_test.c   | 634 +++++++++++++++-
 12 files changed, 1447 insertions(+), 175 deletions(-)


base-commit: cfb92440ee71adcc2105b0890bb01ac3cddb8507
-- 
2.35.1

