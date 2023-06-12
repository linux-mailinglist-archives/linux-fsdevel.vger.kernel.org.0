Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39B572CF17
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 21:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238038AbjFLTOo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 15:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237944AbjFLTOm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 15:14:42 -0400
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [IPv6:2001:1600:4:17::42aa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55588E4E
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 12:14:40 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Qg1b23pH8zMq94q;
        Mon, 12 Jun 2023 19:14:38 +0000 (UTC)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Qg1b12W4MzMqmsh;
        Mon, 12 Jun 2023 21:14:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1686597278;
        bh=IyGVL/IDfihrZ3aEmE9iwusUGzsJURKRriLT2zxWZro=;
        h=From:To:Cc:Subject:Date:From;
        b=e3g9IqhKw1rGaPe68hX+Rw5YNj1RnNxL/Vjdw6KjhQnt6JRteAcyfr8t0+nm5Qy7l
         EWO1ML1nD0yHNjfeENmIWHjkBweHDdMqouRltkE5PwslyW1nacJ8yD+8oKW/DGeKeM
         0f9bXfRiKckLQOkzzsojx8g85/jhF1LobJ5QoTvU=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Richard Weinberger <richard@nod.at>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        James Morris <jmorris@namei.org>, Jeff Xu <jeffxu@google.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        Ritesh Raj Sarraf <ritesh@collabora.com>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sjoerd Simons <sjoerd@collabora.com>,
        Willem de Bruijn <willemb@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 0/6] Landlock support for UML
Date:   Mon, 12 Jun 2023 21:14:24 +0200
Message-ID: <20230612191430.339153-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Commit cb2c7d1a1776 ("landlock: Support filesystem access-control")
introduced a new ARCH_EPHEMERAL_INODES configuration, only enabled for
User-Mode Linux.  The reason was that UML's hostfs managed inodes in an
ephemeral way: from the kernel point of view, the same inode struct
could be created several times while being used by user space because
the kernel didn't hold references to inodes.  Because Landlock (and
probably other subsystems) ties properties (i.e. access rights) to inode
objects, it wasn't possible to create rules that match inodes and then
allow specific accesses.

This patch series fixes the way UML manages inodes according to the
underlying filesystem.  They are now properly handles as for other
filesystems, which enables to support Landlock (and probably other
features).

Changes since v1:
https://lore.kernel.org/r/20230309165455.175131-1-mic@digikod.net
- Remove Cc stable@ (suggested by Richard).
- Add Acked-by: Richard Weinberger to the first patch.
- Split the test patch into two patches: one for the common
  pseudo-filesystems, and another patch dedicated to hostfs.
- Remove CONFIG_SECURITY_PATH because it is useless for merge_config.sh
- Move CONFIG_HOSTFS to a new config.um file.
- Fix commit message spelling and test warnings.
- Improve prepare_layout_opt() with remove_path() call to avoid
  cascading errors when some tested filesystems are not supported.
- Remove cgroup-v1 tests because this filesystem cannot really be
  mounted several times.
- Add test coverage with and without kernel debug code, according to
  GCC 12 and GCC 13.

Regards,

Mickaël Salaün (6):
  hostfs: Fix ephemeral inodes
  selftests/landlock: Don't create useless file layouts
  selftests/landlock: Add supports_filesystem() helper
  selftests/landlock: Make mounts configurable
  selftests/landlock: Add tests for pseudo filesystems
  selftests/landlock: Add hostfs tests

 arch/Kconfig                               |   7 -
 arch/um/Kconfig                            |   1 -
 fs/hostfs/hostfs.h                         |   1 +
 fs/hostfs/hostfs_kern.c                    | 213 ++++++------
 fs/hostfs/hostfs_user.c                    |   1 +
 security/landlock/Kconfig                  |   2 +-
 tools/testing/selftests/landlock/config    |   9 +-
 tools/testing/selftests/landlock/config.um |   1 +
 tools/testing/selftests/landlock/fs_test.c | 387 +++++++++++++++++++--
 9 files changed, 478 insertions(+), 144 deletions(-)
 create mode 100644 tools/testing/selftests/landlock/config.um


base-commit: 858fd168a95c5b9669aac8db6c14a9aeab446375
-- 
2.41.0

