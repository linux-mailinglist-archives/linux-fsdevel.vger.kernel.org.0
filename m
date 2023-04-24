Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740E46ED811
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 00:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbjDXWjA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 18:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjDXWi7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 18:38:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31094658F
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Apr 2023 15:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=XySu42StUALcsupn1IvtqVQZPN6UXRQfFa0x6cYtopM=; b=Jg99Qr3oxnRZAosVQ9EeJVqiMP
        swNF9CpSdNkDXh9Wm04NS7cppDdza+wFYPdF2+BGC+vHtQEXKkAWx4xR/1wl9+IVtUk1KO0Q6YBHy
        j7yBVqEKAJMfEO7Ns/4AXbY5yJJpsyNX3eC5h61i2PZOjEt1XbuaOfNn6HWZYXfe2WUXSU1cyivJp
        49ufdxAXVaw4If67zNDNrsGN/n7FC6iE9TcvTlX7DB6ULmGTroB6lhEox5dq8C10P3XKWU3XpPQ7+
        oKqG8Xyq5ollEkdWBhmfoX5DpaGxU1p+1WyMnSr3XZ5uXMpZ/WDHPMv3y7otXCEA282VhHOQKUOy8
        X7EO/LTw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pr4pM-00HISc-1v;
        Mon, 24 Apr 2023 22:38:32 +0000
Date:   Mon, 24 Apr 2023 15:38:32 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     keescook@chromium.org, yzaikin@google.com, ebiederm@xmission.com,
        arnd@arndb.de, chi.minghao@zte.com.cn, mcgrof@kernel.org,
        wangkefeng.wang@huawei.com, zhangpeng362@huawei.com,
        tangmeng@uniontech.com, sujiaxun@uniontech.com,
        nixiaoming@huawei.com, akpm@linux-foundation.org, vbabka@suse.cz,
        willy@infradead.org, j.granados@samsung.com,
        linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] sysctl changes for v6.4-rc1
Message-ID: <ZEcE6Ex20CwMfMKj@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Note: given we *save* memory per each change move away from each
deprecated call, I don't see a need to immediately *pause* all
kernel/sysctl.c moves. Each replacement of a deprecated call saves
us memory and likely more than a the simple empty entry when we move
a kernel/syctl.c entry to its own file.

So if you're doing a move of a sysctl from kernel/sysctl.c, help with
karma points by replacing a deprecated call :)

The following changes since commit 17214b70a159c6547df9ae204a6275d983146f6b:

  Merge tag 'fsverity-for-linus' of git://git.kernel.org/pub/scm/fs/fsverity/linux (2023-03-20 15:20:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/sysctl-6.4-rc1

for you to fetch changes up to e3184de9d46c2eebdb776face2e2662c6733331d:

  fs: fix sysctls.c built (2023-04-13 12:39:44 -0700)

----------------------------------------------------------------
sysctl-6.4-rc1

This pull request goes with only a few sysctl moves from the
kernel/sysctl.c file, the rest of the work has been put towards
deprecating two API calls which incur recursion and prevent us
from simplifying the registration process / saving memory per
move. Most of the changes have been soaking on linux-next since
v6.3-rc3.

I've slowed down the kernel/sysctl.c moves due to Matthew Wilcox's
feedback that we should see if we could *save* memory with these
moves instead of incurring more memory. We currently incur more
memory since when we move a syctl from kernel/sysclt.c out to its
own file we end up having to add a new empty sysctl used to register
it. To achieve saving memory we want to allow syctls to be passed
without requiring the end element being empty, and just have our
registration process rely on ARRAY_SIZE(). Without this, supporting
both styles of sysctls would make the sysctl registration pretty
brittle, hard to read and maintain as can be seen from Meng Tang's
efforts to do just this [0]. Fortunately, in order to use ARRAY_SIZE()
for all sysctl registrations also implies doing the work to deprecate
two API calls which use recursion in order to support sysctl
declarations with subdirectories.

And so during this development cycle quite a bit of effort went into
this deprecation effort. I've annotated the following two APIs are
deprecated and in few kernel releases we should be good to remove them:

  * register_sysctl_table()
  * register_sysctl_paths()

During this merge window we should be able to deprecate and unexport
register_sysctl_paths(), we can probably do that towards the end
of this merge window.

Deprecating register_sysctl_table() will take a bit more time but
this pull request goes with a few example of how to do this.

As it turns out each of the conversions to move away from either of
these two API calls *also* saves memory. And so long term, all these
changes *will* prove to have saved a bit of memory on boot.

The way I see it then is if remove a user of one deprecated call, it
gives us enough savings to move one kernel/sysctl.c out from the
generic arrays as we end up with about the same amount of bytes.

Since deprecating register_sysctl_table() and register_sysctl_paths()
does not require maintainer coordination except the final unexport
you'll see quite a bit of these changes from other pull requests, I've
just kept the stragglers after rc3.

Most of these changes have been soaking on linux-next since around rc3.

[0] https://lkml.kernel.org/r/ZAD+cpbrqlc5vmry@bombadil.infradead.org

----------------------------------------------------------------
Arnd Bergmann (1):
      mm: compaction: remove incorrect #ifdef checks

Kefeng Wang (3):
      mm: hugetlb: move hugeltb sysctls to its own file
      mm: memory-failure: Move memory failure sysctls to its own file
      fs: fix sysctls.c built

Luis Chamberlain (23):
      proc_sysctl: update docs for __register_sysctl_table()
      proc_sysctl: move helper which creates required subdirectories
      sysctl: clarify register_sysctl_init() base directory order
      apparmor: simplify sysctls with register_sysctl_init()
      loadpin: simplify sysctls use with register_sysctl()
      yama: simplfy sysctls with register_sysctl()
      seccomp: simplify sysctls with register_sysctl_init()
      csky: simplify alignment sysctl registration
      scsi: simplify sysctl registration with register_sysctl()
      hv: simplify sysctl registration
      md: simplify sysctl registration
      xen: simplify sysctl registration for balloon
      proc_sysctl: enhance documentation
      lockd: simplify two-level sysctl registration for nlm_sysctls
      nfs: simplify two-level sysctl registration for nfs4_cb_sysctls
      nfs: simplify two-level sysctl registration for nfs_cb_sysctls
      xfs: simplify two-level sysctl registration for xfs_table
      fs/cachefiles: simplify one-level sysctl registration for cachefiles_sysctls
      coda: simplify one-level sysctl registration for coda_table
      ntfs: simplfy one-level sysctl registration for ntfs_sysctls
      utsname: simplify one-level sysctl registration for uts_kern_table
      ia64: simplify one-level sysctl registration for kdump_ctl_table
      arm: simplify two-level sysctl registration for ctl_isa_vars

Minghao Chi (1):
      mm: compaction: move compaction sysctl to its own file

ZhangPeng (1):
      userfaultfd: move unprivileged_userfaultfd sysctl to its own file

 arch/arm/kernel/isa.c         |  18 +------
 arch/csky/abiv1/alignment.c   |  15 +-----
 arch/ia64/kernel/crash.c      |  11 +---
 drivers/hv/vmbus_drv.c        |  11 +---
 drivers/md/md.c               |  22 +-------
 drivers/scsi/scsi_sysctl.c    |  16 +-----
 drivers/xen/balloon.c         |  20 +------
 fs/Makefile                   |   3 +-
 fs/cachefiles/error_inject.c  |  11 +---
 fs/coda/sysctl.c              |  11 +---
 fs/lockd/svc.c                |  20 +------
 fs/nfs/nfs4sysctl.c           |  21 +-------
 fs/nfs/sysctl.c               |  20 +------
 fs/ntfs/sysctl.c              |  12 +----
 fs/proc/proc_sysctl.c         |  88 +++++++++++++++++++-----------
 fs/userfaultfd.c              |  20 ++++++-
 fs/xfs/xfs_sysctl.c           |  20 +------
 include/linux/compaction.h    |   7 ---
 include/linux/hugetlb.h       |   8 ---
 include/linux/mm.h            |   2 -
 include/linux/userfaultfd_k.h |   2 -
 kernel/seccomp.c              |  15 +-----
 kernel/sysctl.c               | 122 ------------------------------------------
 kernel/utsname_sysctl.c       |  11 +---
 mm/compaction.c               |  80 ++++++++++++++++++++++-----
 mm/hugetlb.c                  |  51 ++++++++++++++++--
 mm/memory-failure.c           |  36 ++++++++++++-
 security/apparmor/lsm.c       |   8 +--
 security/loadpin/loadpin.c    |   8 +--
 security/yama/yama_lsm.c      |   8 +--
 30 files changed, 248 insertions(+), 449 deletions(-)
