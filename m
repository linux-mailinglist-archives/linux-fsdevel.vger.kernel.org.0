Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3ABA44024E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 20:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhJ2Srn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 14:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbhJ2Sri (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 14:47:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0DCC061766;
        Fri, 29 Oct 2021 11:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=eiqoJ/sT9tSkAQMOpJ5WDTuQjnGh8Wt2Zkw+2oSs1CA=; b=um+YvmgtYbJVDArMu18M/ab5/3
        /HHXWIshZWdnhLpeVdILVapOVlGFL8kNlJjD3DbllVL1fIucru3dDk2A4KYvfuYX1FldHCX+G+Q9V
        Z0Bx2XtzXJ5jJ2BTIMy371wj6EQzlfPmzUrWJ/k+YFZow6ZYh4X6uJ5rawUuAZcN93CJdBnkGji6f
        k2jQ3HwMuUoETLKCZh2PSIqAt2SZQ46LxV3uFZpwbkJANgBuFHhM8GgMX7zDPD92PRN8mepSQwlNM
        9i4GGeyKay/H6hFS2l+F3AuDpZDoTH8Xr1CcqNd4pHffLeQ//JN8cQrP4/NDWTHhMc3oR9f6gQV0f
        tnKHSqjw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mgWsA-00Bq0K-16; Fri, 29 Oct 2021 18:45:02 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, jeyu@kernel.org, shuah@kernel.org
Cc:     bvanassche@acm.org, dan.j.williams@intel.com, joe@perches.com,
        tglx@linutronix.de, mcgrof@kernel.org, keescook@chromium.org,
        rostedt@goodmis.org, minchan@kernel.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 0/6] test_sysfs: add new selftest for sysfs
Date:   Fri, 29 Oct 2021 11:44:54 -0700
Message-Id: <20211029184500.2821444-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On this v9 I've dropped the generic sysfs deadlock fix given Ming Lei
has provided alternative fixes for the zram driver without incurring
a generic lock *and* we don't yet have full assessment of how wide
spread the deadlock case might be in the kernel. A full assessment
effort is still underway using Coccinelle with iteration support,
however that effort will take a bit more time to complete. We can
re-evaluate the value of a generic fix later after the assessment
is complete.

This series now just adds the test_sysfs selftest and failure injection
support for it on kernfs. The most valuable tests are those which
confirm that once a kernfs active reference is obtained with
kernfs_get_active() the pointers used there are still valid, and so
using sysfs ops *are* safe if we race against module removal. Likewise
it also confirms how module removal will *wait* for these ops to
complete if a kernfs node is already active.

This v9 series also addresses feedback mostly provided by Kees Cook and Greg.
I also made a few changes to the test_sysfs driver to account for changes in
the block layer. I also improved the kernfs failure injection tests with
documentation of how they work and to account for the real expected return
value of a write before the kernfs active reference is obtained. Upstream
commit 8e141f9eb803e ("block: drain file system I/O on del_gendisk") has
revealed that small minor induced delays on del_gendisk() can make a few
writes succeed if the delays used are small. So we clarify the logic of why
writes could either fail or succeed before the kernfs active reference is taken.

These changes also availble on this tree:

https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20211029-test-sysfs-v2

v9:
  * rebased onto linux-next tag next-20211029
  * add Reviewed-by tags for the SPDX change, and the drivers which
    get the tag for it
  * drop the generic sysfs deadlock fix for now as the scope of how
    wide spread the issue is still needs to be assessed
  * drop the zram patches as they are replaced by Ming Lei's fixes
  * drop already merged patches
  * try_module_get() docs: enhanced using feedback from Kees Cook. I
    extended the documention to make it clear that if proper care is not
    taken the use of this routine could crash the kernel.
  * kernfs: move failure injection knobs under /sys/kernel/debug/fail_kernfs
    as suggested by Kees Cook
  * kernfs: rename failure injection file to fault_inject.c as suggested
    by Kees Cook
  * kernfs: split up documentation of failure injection knobs as
    suggested by Kees Cook
  * kernfs: move the wait into debug call, and use a simple one liner
    may_wait() calls to make the changes much less intrusive and more
    readable  as suggested by Kees Cook 
  * kernfs: drop __func__ uses as suggested by Kees Cook
  * test_sysfs: use sizeof() instead of open coded 16 as suggested by
    Kees Cook
  * test_sysfs: use sysfs_emit as suggested by Kees Cook
  * test_sysfs: drop boiler place license as suggested by Greg KH
  * test_sysfs: use depends instead of select as suggested by Kees Cook
  * test_sysfs: drop #ifdefery as suggested by Kees Cook
  * test_sysfs: clarified that the use of a lock on rmmod which causes
    a deadlock is something drivers should avoid, and its why we leave
    the test disabled.
  * test_sysfs: now that device_add_disk() returns an error, use the
    new error return code, otherwise this is going to prevent us from
    eventually embracing __must_check() on that call on the block layer.
  * test_syfs: testdev_submit_bio() needed to change data types as now
    it returns void.
  * test_sysfs: enhance kernfs failure injection tests with documenation
    and correct the expected return value for writes

Luis Chamberlain (6):
  LICENSES: Add the copyleft-next-0.3.1 license
  testing: use the copyleft-next-0.3.1 SPDX tag
  selftests: add tests_sysfs module
  kernfs: add initial failure injection support
  test_sysfs: add support to use kernfs failure injection
  kernel/module: add documentation for try_module_get()

 .../fault-injection/fault-injection.rst       |   50 +
 LICENSES/dual/copyleft-next-0.3.1             |  237 +++
 MAINTAINERS                                   |    9 +-
 fs/kernfs/Makefile                            |    1 +
 fs/kernfs/fault_inject.c                      |   93 ++
 fs/kernfs/file.c                              |    9 +
 fs/kernfs/kernfs-internal.h                   |   70 +
 include/linux/kernfs.h                        |    5 +
 include/linux/module.h                        |   37 +-
 lib/Kconfig.debug                             |   23 +
 lib/Makefile                                  |    1 +
 lib/test_kmod.c                               |   12 +-
 lib/test_sysctl.c                             |   12 +-
 lib/test_sysfs.c                              |  913 +++++++++++
 tools/testing/selftests/kmod/kmod.sh          |   13 +-
 tools/testing/selftests/sysctl/sysctl.sh      |   12 +-
 tools/testing/selftests/sysfs/Makefile        |   12 +
 tools/testing/selftests/sysfs/config          |    5 +
 tools/testing/selftests/sysfs/settings        |    1 +
 tools/testing/selftests/sysfs/sysfs.sh        | 1411 +++++++++++++++++
 20 files changed, 2878 insertions(+), 48 deletions(-)
 create mode 100644 LICENSES/dual/copyleft-next-0.3.1
 create mode 100644 fs/kernfs/fault_inject.c
 create mode 100644 lib/test_sysfs.c
 create mode 100644 tools/testing/selftests/sysfs/Makefile
 create mode 100644 tools/testing/selftests/sysfs/config
 create mode 100644 tools/testing/selftests/sysfs/settings
 create mode 100755 tools/testing/selftests/sysfs/sysfs.sh

-- 
2.30.2

