Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319D43B8AB6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jul 2021 00:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbhF3XBB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 19:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbhF3XA6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 19:00:58 -0400
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [IPv6:2001:1600:3:17::8fa9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA4BC0613A3
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Jun 2021 15:58:29 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4GFc3M5JwzzMqHN1;
        Thu,  1 Jul 2021 00:49:19 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4GFc3L6dnnzlh8mg;
        Thu,  1 Jul 2021 00:49:18 +0200 (CEST)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v1 0/4] Landlock filesystem caching
Date:   Thu,  1 Jul 2021 00:48:52 +0200
Message-Id: <20210630224856.1313928-1-mic@digikod.net>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

The goal of this patch series is to reduce the performance impact of
walking through a lot of files while being landlocked.  Indeed, because
of the unprivileged nature of Landlock, each file access implies to
check access granted to each directory of the path, which slows down
open time.

Currently, openat(2) calls spend more than 22% of their time in
hook_file_open().  The performance impact for a common worth case
scenario is significantly reduced thanks to this patch series,
theoretically going from O(n) with n as the depth of a path, to O(1)
(cf. benchmarks in the caching patch).

This series adds a new security hook (resolve_path_at) and uses it to
implement access caching in Landlock.  I'm planning to build on top of
that for other improvements (using task's working directory and task's
root directory) but that will require other hook changes.

This new hook is also a first step to be able to securely restrict file
descriptors used for path resolution (e.g. dirfd in openat2).

Caching may be difficult to get right especially for security checks.  I
extended the current tests and I'm still working on new ones.  If you
have test/attack scenarios, please share them.  I would really
appreciate constructive reviews for these critical changes.  This series
can be applied on top of v5.13 .

Regards,

Mickaël Salaün (4):
  fs,security: Add resolve_path_at() hook
  landlock: Add filesystem rule caching
  selftests/landlock: Work in a temporary directory
  selftests/landlock: Check all possible intermediate directories

 fs/namei.c                                 |   9 +
 include/linux/lsm_hook_defs.h              |   2 +
 include/linux/lsm_hooks.h                  |   8 +
 include/linux/security.h                   |   9 +
 security/landlock/cache.h                  |  77 +++++++
 security/landlock/cred.c                   |  15 +-
 security/landlock/cred.h                   |  20 +-
 security/landlock/fs.c                     | 224 +++++++++++++++++++--
 security/landlock/fs.h                     |  29 +++
 security/landlock/setup.c                  |   2 +
 security/security.c                        |   6 +
 tools/testing/selftests/landlock/fs_test.c | 205 ++++++++++++++-----
 12 files changed, 544 insertions(+), 62 deletions(-)
 create mode 100644 security/landlock/cache.h


base-commit: 62fb9874f5da54fdb243003b386128037319b219
-- 
2.32.0

