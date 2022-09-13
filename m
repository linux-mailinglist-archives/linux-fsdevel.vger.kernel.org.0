Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29AA85B792A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Sep 2022 20:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiIMSKS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Sep 2022 14:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbiIMSJt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:09:49 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34D461DB0
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Sep 2022 10:15:32 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id k2so6601324ilu.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Sep 2022 10:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=O9TvDLWjTy4TmsyuvXQ5nhjUzi6WXSFOfw/78rsm4YU=;
        b=AoRfXHQcLnCwoUa+E+8OZaJgkeuIrvoreP1dwsUERz6XrwYLbxQFaxrw5MoMNV9WHv
         +7WfRDjeUwPWpK2EIa1Adc5FS0xqw6w+dlloKd5/6jKN03s/0P65P57+yR8nIUGNIInv
         LXvCqCGnIZVyd1iAJOnIRU+amZ/kDVSZAEAI8w8X6/8qmGQupoVHiYSEjgmTjJq5m6Au
         oEoNH56lCc1RFyetbMgW5wXGoQSpltMxt4CQIMrEnhB0bFxhFN3hWhBgsqD8L5Y6KRbe
         S9xZKy9o4yAhrbBNILyasYg/DUIGWNCHrNwDsVzSpoQ8XFku2Nzv6mxrRpomJv4SRY+0
         oI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=O9TvDLWjTy4TmsyuvXQ5nhjUzi6WXSFOfw/78rsm4YU=;
        b=2kVXClLOFVO2LWDpzegHh4ELayqof2OCGhDrQx0TtZum4heIB9OEe3ZYX8QRd8JhSL
         uR/CGkbeEnMolp43IL4xWLbVyAmygUWCjnVhqReUsEFB8W3L+4Bg/NgABBgBGHj+WfIn
         pxLZBbsYXeALthZAVyQbk45FeC5dDO97GG++Oebr3IrdGX0dfYJIrg4S2INOK5y90q8k
         PF2545gQOcAK2/H8LkETod3g9KCrb7usY6oJWjIznYwexgYw/gIzVy37n38lJiSmz3ya
         nBCYxQD1nItGliZmj/z2knh4hSmRyqu2/0fBCvjpnBXfgqQPGVu9GT7bxCiOTqov3NvX
         +zKg==
X-Gm-Message-State: ACgBeo1xV27wEKVSW71faEtsCaSbLjOMyYX7VZHdwM25TCR13qINKlv9
        JVdNGlfhczXEIsNVfX8xI008m5sN+0wpgakACldOhw==
X-Google-Smtp-Source: AA6agR7+sMKiXBwvpQ5HLTZGj2HndkyZqYuOjyFBz5Ryg+hvPfuJBI6JP8FN+aiwow+nPS17C4Jo/299hDMXTwzHADg=
X-Received: by 2002:a05:6e02:174c:b0:2f1:62c8:787e with SMTP id
 y12-20020a056e02174c00b002f162c8787emr13291618ill.254.1663089330420; Tue, 13
 Sep 2022 10:15:30 -0700 (PDT)
MIME-Version: 1.0
From:   Jann Horn <jannh@google.com>
Date:   Tue, 13 Sep 2022 19:14:56 +0200
Message-ID: <CAG48ez2dS04ONb-EVQGOtmeU6vTpKLe4J0W1yqa+Q9j+Hg3hFw@mail.gmail.com>
Subject: BUG: d_path() races with do_move_mount() on ->mnt_ns, leading to use-after-free
To:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As the subject says, there's a race between d_path() (specifically
__prepend_path()) looking at mnt->mnt_ns with is_anon_ns(), and
do_move_mount() switching out the ->mnt_ns and freeing the old one.
This can theoretically lead to a use-after-free read, but it doesn't
seem to be very interesting from a security perspective, since all it
gets you is a comparison of a value in freed memory with zero.

KASAN splat from a kernel that's been patched to widen the race window:


 ==================================================================
 BUG: KASAN: use-after-free in prepend_path (fs/mount.h:146
fs/d_path.c:127 fs/d_path.c:177)
 Read of size 8 at addr ffff88800add2748 by task SLOWME/685

 CPU: 8 PID: 685 Comm: SLOWME Not tainted
6.0.0-rc5-00015-ge839a756012b-dirty #110
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.16.0-debian-1.16.0-4 04/01/2014
 Call Trace:
  <TASK>
 dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1))
 print_report.cold (mm/kasan/report.c:318 mm/kasan/report.c:433)
[...]
 kasan_report (mm/kasan/report.c:162 mm/kasan/report.c:497)
[...]
 prepend_path (fs/mount.h:146 fs/d_path.c:127 fs/d_path.c:177)
[...]
 __do_sys_getcwd (fs/d_path.c:438)
[...]
 do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
[...]
  </TASK>

 Allocated by task 685:
 kasan_save_stack (mm/kasan/common.c:39)
 __kasan_kmalloc (mm/kasan/common.c:45 mm/kasan/common.c:437
mm/kasan/common.c:516 mm/kasan/common.c:525)
 alloc_mnt_ns (./include/linux/slab.h:600 ./include/linux/slab.h:733
fs/namespace.c:3426)
 __do_sys_fsmount (fs/namespace.c:3720)
 do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)

 Freed by task 686:
 kasan_save_stack (mm/kasan/common.c:39)
 kasan_set_track (mm/kasan/common.c:45)
 kasan_set_free_info (mm/kasan/generic.c:372)
 ____kasan_slab_free (mm/kasan/common.c:369 mm/kasan/common.c:329)
 kfree (mm/slub.c:1780 mm/slub.c:3534 mm/slub.c:4562)
 do_move_mount (fs/namespace.c:2899)
 __x64_sys_move_mount (fs/namespace.c:3812 fs/namespace.c:3765
fs/namespace.c:3765)
 do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)

 The buggy address belongs to the object at ffff88800add2700
  which belongs to the cache kmalloc-128 of size 128
 The buggy address is located 72 bytes inside of
  128-byte region [ffff88800add2700, ffff88800add2780)

[...]

 Memory state around the buggy address:
  ffff88800add2600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff88800add2680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 >ffff88800add2700: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                               ^
  ffff88800add2780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff88800add2800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ==================================================================



To reproduce, apply this kernel patch to widen the race window:


diff --git a/fs/d_path.c b/fs/d_path.c
index e4e0ebad1f153..51fbed8deffe4 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -7,6 +7,7 @@
 #include <linux/slab.h>
 #include <linux/prefetch.h>
 #include "mount.h"
+#include <linux/delay.h>

 struct prepend_buffer {
        char *buf;
@@ -117,6 +118,11 @@ static int __prepend_path(const struct dentry
*dentry, const struct mount *mnt,
                        }
                        /* Global root */
                        mnt_ns = READ_ONCE(mnt->mnt_ns);
+                       if (strcmp(current->comm, "SLOWME") == 0) {
+                               pr_warn("%s: begin delay\n", __func__);
+                               mdelay(1000);
+                               pr_warn("%s: end delay\n", __func__);
+                       }
                        /* open-coded is_mounted() to use local mnt_ns */
                        if (!IS_ERR_OR_NULL(mnt_ns) && !is_anon_ns(mnt_ns))
                                return 1;       // absolute root


Then run this reproducer (build with "-pthread"):


#define _GNU_SOURCE
#include <pthread.h>
#include <unistd.h>
#include <err.h>
#include <fcntl.h>
#include <sys/syscall.h>
#include <sys/stat.h>
#include <sys/prctl.h>
#include <sys/mount.h>
#include <linux/mount.h>

#define SYSCHK(x) ({          \
  typeof(x) __res = (x);      \
  if (__res == (typeof(x))-1) \
    err(1, "SYSCHK(" #x ")"); \
  __res;                      \
})

void fsconfig(int fd, unsigned int cmd, char *key, void *value, int aux) {
  SYSCHK(syscall(__NR_fsconfig, fd, cmd, key, value, aux));
}

static int mnt_fd = -1;

static void *thread_fn(void *dummy) {
  mkdir("/dev/shm/test", 0700);
  SYSCHK(syscall(__NR_move_mount, mnt_fd, "", AT_FDCWD, "/dev/shm/test",
                 MOVE_MOUNT_F_EMPTY_PATH));
  sleep(1);
  SYSCHK(umount2("/dev/shm/test", MNT_DETACH));
  return NULL;
}

int main(void) {
  int fs_fd = SYSCHK(syscall(__NR_fsopen, "tmpfs", 0));
  fsconfig(fs_fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
  mnt_fd = SYSCHK(syscall(__NR_fsmount, fs_fd, 0, MOUNT_ATTR_NOSUID |
MOUNT_ATTR_NODEV));
  SYSCHK(close(fs_fd));
  SYSCHK(fchdir(mnt_fd));

  pthread_t thread;
  if (pthread_create(&thread, NULL, thread_fn, NULL))
    errx(1, "pthread_create");

  char buf[0x10000];
  SYSCHK(prctl(PR_SET_NAME, "SLOWME"));
  SYSCHK(getcwd(buf, sizeof(buf)));
  SYSCHK(prctl(PR_SET_NAME, "dummy"));
  SYSCHK(chdir("/"));
  if (pthread_join(thread, NULL))
    errx(1, "pthread_join");
  SYSCHK(close(mnt_fd));
  return 0;
}
