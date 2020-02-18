Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE653161FD0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 05:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgBREb5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 23:31:57 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38394 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgBREb5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 23:31:57 -0500
Received: by mail-pf1-f196.google.com with SMTP id x185so9980360pfc.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Feb 2020 20:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iBXoLIrfyc9wrUtj6QOufO+uJphZkQZVHX7/I7l30xQ=;
        b=Oswal857zjOlNrnBwWfhnVnVcfz3LcG2TY2vyyYJJGR3rgQIeUuniojtyZT7biHG5J
         u1nQ7JPkjfn5ryTKUM59lRgGeU0T65HaxVKQ3pO5LcsldpGEPiHskNFTKJ1QR8DlplES
         gKD/2w8YrZ09pOzBWzzLKagVP8cg5uN+kekA3nmc8WrmfW2K+2GXz1yVVdmoSNTN/RGo
         z5FguTK3r1Kokjyyl5fFhKOZZZnkgTIZaadgPZt0A0oam4t+x+ymQLfjAgq598g/CtSj
         /ZV3b1GQBMfWrQam+/nTDIjNrCI0NNTWL11LyjPgRrSBfVEzUeIET8sJJVKI9LDkFZNp
         7dpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iBXoLIrfyc9wrUtj6QOufO+uJphZkQZVHX7/I7l30xQ=;
        b=EYEPz/3AWmsEbBq+Vkl9Rbgbi7snlEJKBO+RUW5HXkd4HvuKLRcNB+N2050Iv9BPy9
         lYVfFh+SQt3n+2A/eJpUGMiH/t2k69OseenzDZtr0gw/0k1bk15xLiq2QzElXInjoJCn
         +k7d1y6/irHx5sNi3JK8zZLSawt5C0yjz5OkLxdjRNBz90UDZet0pe2tjazXJcOfPMhl
         FojP0xNZV8cd5sJg0rDcwTJt+bKiv0XDHMCJi9GmJQYuoKFC4h3QG8bBidmJyPDbM1qB
         uZeAd2lxLgPhDEJMN2+pXnZz+fyd+yX15bSaaanYsJRolMR+FnzN7yWP7uKos0jhURQf
         8fLA==
X-Gm-Message-State: APjAAAUpsx1WnBwGaVwPr8/bfeaAEstvk/hhaXYmWCshvieKaG59OLpX
        hNrknTA9cRMVMJbYyRvUUS0=
X-Google-Smtp-Source: APXvYqy8SGDMnp9QtbgDINuNhIk8nomy8b+/9neuAZxnXjMwpwtJ7/HCq9NzmgNnY7FJBO19Lp1qrg==
X-Received: by 2002:a63:340c:: with SMTP id b12mr16840075pga.180.1582000316383;
        Mon, 17 Feb 2020 20:31:56 -0800 (PST)
Received: from localhost.localdomain ([180.70.143.152])
        by smtp.gmail.com with ESMTPSA id e6sm2011325pfh.32.2020.02.17.20.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 20:31:55 -0800 (PST)
From:   Taehee Yoo <ap420073@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     ap420073@gmail.com
Subject: [PATCH v2 RESEND] debugfs: Check module state before warning in {full/open}_proxy_open()
Date:   Tue, 18 Feb 2020 04:31:50 +0000
Message-Id: <20200218043150.29447-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When the module is being removed, the module state is set to
MODULE_STATE_GOING. At this point, try_module_get() fails.
And when {full/open}_proxy_open() is being called,
it calls try_module_get() to try to hold module reference count.
If it fails, it warns about the possibility of debugfs file leak.

If {full/open}_proxy_open() is called while the module is being removed,
it fails to hold the module.
So, It warns about debugfs file leak. But it is not the debugfs file
leak case. So, this patch just adds module state checking routine
in the {full/open}_proxy_open().

Test commands:
    #SHELL1
    while :
    do
        modprobe netdevsim
        echo 1 > /sys/bus/netdevsim/new_device
        modprobe -rv netdevsim
    done

    #SHELL2
    while :
    do
        cat /sys/kernel/debug/netdevsim/netdevsim1/ports/0/ipsec
    done

Splat looks like:
[  298.766738][T14664] debugfs file owner did not clean up at exit: ipsec
[  298.766766][T14664] WARNING: CPU: 2 PID: 14664 at fs/debugfs/file.c:312 full_proxy_open+0x10f/0x650
[  298.768595][T14664] Modules linked in: netdevsim(-) openvswitch nsh nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 n][  298.771343][T14664] CPU: 2 PID: 14664 Comm: cat Tainted: G        W         5.5.0+ #1
[  298.772373][T14664] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
[  298.773545][T14664] RIP: 0010:full_proxy_open+0x10f/0x650
[  298.774247][T14664] Code: 48 c1 ea 03 80 3c 02 00 0f 85 c1 04 00 00 49 8b 3c 24 e8 e4 b5 78 ff 84 c0 75 2d 4c 89 ee 48
[  298.776782][T14664] RSP: 0018:ffff88805b7df9b8 EFLAGS: 00010282[  298.777583][T14664] RAX: dffffc0000000008 RBX: ffff8880511725c0 RCX: 0000000000000000
[  298.778610][T14664] RDX: 0000000000000000 RSI: 0000000000000006 RDI: ffff8880540c5c14
[  298.779637][T14664] RBP: 0000000000000000 R08: fffffbfff15235ad R09: 0000000000000000
[  298.780664][T14664] R10: 0000000000000001 R11: 0000000000000000 R12: ffffffffc06b5000
[  298.781702][T14664] R13: ffff88804c234a88 R14: ffff88804c22dd00 R15: ffffffff8a1b5660
[  298.782722][T14664] FS:  00007fafa13a8540(0000) GS:ffff88806c800000(0000) knlGS:0000000000000000
[  298.783845][T14664] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  298.784672][T14664] CR2: 00007fafa0e9cd10 CR3: 000000004b286005 CR4: 00000000000606e0
[  298.785739][T14664] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  298.786769][T14664] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  298.787785][T14664] Call Trace:
[  298.788237][T14664]  do_dentry_open+0x63c/0xf50
[  298.788872][T14664]  ? open_proxy_open+0x270/0x270
[  298.789524][T14664]  ? __x64_sys_fchdir+0x180/0x180
[  298.790169][T14664]  ? inode_permission+0x65/0x390
[  298.790832][T14664]  path_openat+0xc45/0x2680
[  298.791425][T14664]  ? save_stack+0x69/0x80
[  298.791988][T14664]  ? save_stack+0x19/0x80
[  298.792544][T14664]  ? path_mountpoint+0x2e0/0x2e0
[  298.793233][T14664]  ? check_chain_key+0x236/0x5d0
[  298.793910][T14664]  ? sched_clock_cpu+0x18/0x170
[  298.794527][T14664]  ? find_held_lock+0x39/0x1d0
[  298.795153][T14664]  do_filp_open+0x16a/0x260
[ ... ]

Fixes: 9fd4dcece43a ("debugfs: prevent access to possibly dead file_operations at file open")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v1 -> v2:
 - Fix compile error

 fs/debugfs/file.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 634b09d18b77..e3075389fba0 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -175,8 +175,13 @@ static int open_proxy_open(struct inode *inode, struct file *filp)
 	if (r)
 		goto out;
 
-	real_fops = fops_get(real_fops);
-	if (!real_fops) {
+	if (!fops_get(real_fops)) {
+#ifdef MODULE
+		if (real_fops->owner &&
+		    real_fops->owner->state == MODULE_STATE_GOING)
+			goto out;
+#endif
+
 		/* Huh? Module did not clean up after itself at exit? */
 		WARN(1, "debugfs file owner did not clean up at exit: %pd",
 			dentry);
@@ -305,8 +310,13 @@ static int full_proxy_open(struct inode *inode, struct file *filp)
 	if (r)
 		goto out;
 
-	real_fops = fops_get(real_fops);
-	if (!real_fops) {
+	if (!fops_get(real_fops)) {
+#ifdef MODULE
+		if (real_fops->owner &&
+		    real_fops->owner->state == MODULE_STATE_GOING)
+			goto out;
+#endif
+
 		/* Huh? Module did not cleanup after itself at exit? */
 		WARN(1, "debugfs file owner did not clean up at exit: %pd",
 			dentry);
-- 
2.17.1

