Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74076419923
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 18:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbhI0QkE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 12:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235556AbhI0Qju (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:39:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0D1C06176E;
        Mon, 27 Sep 2021 09:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ViIgC+NY70ewIWdw46wp+bLefSO1P1qcAe6/9HqsArM=; b=0zNOY4OK5w6fw13/HSl2FaUOOV
        /GBsA/9oQDXBXR0PMDXB06j4at+EAsLkOOfoxlSfO8FZA5Oz0EB/2qvPNeEzqsttvV61CQr+qIWy2
        og2lDnGaE/QNGPi45aw8Dl2Gb96VDc8HtYTuxX/p6S+4Y0hO+f/cTK30FPePfghhfkd1crWIkGRB3
        eCzFpNHn+Y5nQBpLlBQ+rledw0r2siByUEemjyT3UYx3O7t5O7S9Q7cVevMjrvhh/EMY/CxlXb/1a
        kdx7NgEmvZJiigx+vGjvE3/5a9rYjyGFzee694Xekpinl69m7INpG2ek0Ho1Wprcdb/ErovfjetLj
        bnPy0VcQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUtdm-003ORt-BA; Mon, 27 Sep 2021 16:38:06 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org
Cc:     bvanassche@acm.org, dan.j.williams@intel.com, joe@perches.com,
        tglx@linutronix.de, mcgrof@kernel.org, keescook@chromium.org,
        rostedt@goodmis.org, linux-spdx@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 00/12] syfs: generic deadlock fix with module removal
Date:   Mon, 27 Sep 2021 09:37:53 -0700
Message-Id: <20210927163805.808907-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a follow up to my v7 series of fixes for the zram driver [0]
which ended up uncovering a generic deadlock issue with sysfs and module
removal. I've reported this issue and proposed a few patches first since
March 2021 [1]. At the end of this email you will find an itemized list
of changes since that v1 series, you can also find these changes on my
branch 20210927-sysfs-generic-deadlock-fix [4] which is based on
linux-next tag next-20210927.

Just a heads up, I'm goin on vacation in two days, won't be back until
Monday October 11th.

On this v8 I incorporate feedback from the v7 series, namely:

 - Tejun requested I move the struct module to the last attribute when
   extending functions
 - As per discussion with Tejun, trimmed and clarified the commit log
   and documentation on the generic fix on patch 7
 - As requested by Bart Van Assche, I simplied the setting of the
   struct test_config *config into one line instead of two on many
   places on patch 3 which adds the new sysfs selftest
 - Dan Williams had some questions about patch 7, and so clarified these
   questions using a more elaborate example on the commit log to show
   where the lock call was happening.
 - Trimmed the Cc list considerably as it was way too long before
 - Rebased onto linux-next tag next-20210927

Below a list of changes of this patch set since its inception:

On v1:
  - Open coded the sysfs deadlock race to only be localized by the zram
    driver
Changes on v2:
  - used bdgrab() as well for another race which was speculated by
    Minchan
  - improved documentation of fixes
Changes on v3:
  - used a localized zram macros for the sysfs attributes instead of
    open coding on each routine
  - replaced bdget() stuff for a generic get_device() and bus_get() on
    dev_attr_show() / dev_attr_store() for the issue speculated by
    Michan
Changes on v4:
  - Cosmetic fixes on the zram fixes as requested by Greg
  - Split out the driver core fix as requested by Greg for the
    issue speculated by Michan. This fix ended up getting up to its 4th
    patch iteration [2] and eventually hit linux-next. We got a 0day
    0day suspend stres fail for this patch [3]
Changes on v5:
  - I ended up writing a test_sysfs driver and with it I ended up
    proving that the issue speculated by Michen was not possible and
    so I asked Greg to drop the patch from his queue titled
    "sysfs: fix kobject refcount to address races with kobject removal"
  - checkpatch fixes for the zram changes
Changes on v6:
  - I submitted my test_sysfs driver for inclusion upstream which easily
    abstracted the deadlock issue in a driver generically [4]
  - I rebased the zram fixes and added also a new patch for zram to use
    ATTRIBUTE_GROUPS As per Minchen I sent the patches to be merged
    through Andrew Morton.
  - Greg ended up NACK'ing the patchset because he was not sure the fix
    was correct still
Changes on v7:
  - Formalizes the original proposed generic sysfs fix intead of using
    macro helpers to work around the issue
  - I decided it is best to merge all the effort together into
    one patch set because communication was being lost when I split the
    patches up. This was not helping in any way to either fix the zram
    issues or come to consensus on a generic solution. The patches are
    also merged now because they are all related now.
  - Running checkpatch exposed that S_IRWXUGO and S_IRWXU|S_IRUGO|S_IXUGO
    should be replaced, so I did that in this series in two new patches
  - Adds a try_module_get() documentation extension with tribal
    knowledge and new information I don't think some folks still believe
    in. The new test_sysfs selftest however proves this information to
    be correct, the same selftest can be used to try to prove that
    documentation incorrect
  - Because the fix is now generic zram's deadlock can easily be fixed
    now by just making it use ATTRIBUTE_GROUPS().

[0] https://lkml.kernel.org/r/YUjLAbnEB5qPfnL8@slm.duckdns.org
[1] https://lkml.kernel.org/r/20210306022035.11266-1-mcgrof@kernel.org
[2] https://lkml.kernel.org/r/20210623215007.862787-1-mcgrof@kernel.org                                                                                                      
[3] https://lkml.kernel.org/r/20210701022737.GC21279@xsang-OptiPlex-9020                                                                                                     
[4] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/log/?h=20210927-sysfs-generic-deadlock-fix

Luis Chamberlain (12):
  LICENSES: Add the copyleft-next-0.3.1 license
  testing: use the copyleft-next-0.3.1 SPDX tag
  selftests: add tests_sysfs module
  kernfs: add initial failure injection support
  test_sysfs: add support to use kernfs failure injection
  kernel/module: add documentation for try_module_get()
  fs/kernfs/symlink.c: replace S_IRWXUGO with 0777 on
    kernfs_create_link()
  fs/sysfs/dir.c: replace S_IRWXU|S_IRUGO|S_IXUGO with 0755
    sysfs_create_dir_ns()
  sysfs: fix deadlock race with module removal
  test_sysfs: enable deadlock tests by default
  zram: fix crashes with cpu hotplug multistate
  zram: use ATTRIBUTE_GROUPS to fix sysfs deadlock module removal

 .../fault-injection/fault-injection.rst       |   22 +
 LICENSES/dual/copyleft-next-0.3.1             |  237 +++
 MAINTAINERS                                   |    9 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c        |    4 +-
 drivers/block/zram/zram_drv.c                 |   74 +-
 fs/kernfs/Makefile                            |    1 +
 fs/kernfs/dir.c                               |   44 +-
 fs/kernfs/failure-injection.c                 |   91 ++
 fs/kernfs/file.c                              |   19 +-
 fs/kernfs/kernfs-internal.h                   |   75 +-
 fs/kernfs/symlink.c                           |    4 +-
 fs/sysfs/dir.c                                |    5 +-
 fs/sysfs/file.c                               |    6 +-
 fs/sysfs/group.c                              |    3 +-
 include/linux/kernfs.h                        |   19 +-
 include/linux/module.h                        |   34 +-
 include/linux/sysfs.h                         |   52 +-
 kernel/cgroup/cgroup.c                        |    2 +-
 lib/Kconfig.debug                             |   25 +
 lib/Makefile                                  |    1 +
 lib/test_kmod.c                               |   12 +-
 lib/test_sysctl.c                             |   12 +-
 lib/test_sysfs.c                              |  952 ++++++++++++
 tools/testing/selftests/kmod/kmod.sh          |   13 +-
 tools/testing/selftests/sysctl/sysctl.sh      |   12 +-
 tools/testing/selftests/sysfs/Makefile        |   12 +
 tools/testing/selftests/sysfs/config          |    5 +
 tools/testing/selftests/sysfs/sysfs.sh        | 1383 +++++++++++++++++
 28 files changed, 3026 insertions(+), 102 deletions(-)
 create mode 100644 LICENSES/dual/copyleft-next-0.3.1
 create mode 100644 fs/kernfs/failure-injection.c
 create mode 100644 lib/test_sysfs.c
 create mode 100644 tools/testing/selftests/sysfs/Makefile
 create mode 100644 tools/testing/selftests/sysfs/config
 create mode 100755 tools/testing/selftests/sysfs/sysfs.sh

-- 
2.30.2

