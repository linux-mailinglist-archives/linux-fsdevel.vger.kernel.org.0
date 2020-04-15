Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4859C1A93DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 09:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404460AbgDOHJj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 03:09:39 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:42500 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404415AbgDOHJi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 03:09:38 -0400
Received: from sf.home (tunnel547699-pt.tunnel.tserv1.lon2.ipv6.he.net [IPv6:2001:470:1f1c:3e6::2])
        (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: slyfox)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 0C46E34F32D;
        Wed, 15 Apr 2020 07:09:37 +0000 (UTC)
Received: by sf.home (Postfix, from userid 1000)
        id 72D755A22061; Wed, 15 Apr 2020 08:09:34 +0100 (BST)
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Sergei Trofimovich <slyfox@gentoo.org>,
        Sergey Kvachonok <ravenexp@gmail.com>,
        Tony Vroon <chainsaw@gentoo.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH] umh: always return error when helper was not called
Date:   Wed, 15 Apr 2020 08:09:31 +0100
Message-Id: <20200415070931.4104491-1-slyfox@gentoo.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200415065940.4103990-1-slyfox@gentoo.org>
References: <20200415065940.4103990-1-slyfox@gentoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Before this change on a system with the following setup crashed kernel:

```
CONFIG_STATIC_USERMODEHELPER=y
CONFIG_STATIC_USERMODEHELPER_PATH=""
kernel.core_pattern = |/usr/lib/systemd/systemd-coredump %P %u %g %s %t %c %h %e
```

The crash happens when a core dump is attempted:

```
[    2.819676] BUG: kernel NULL pointer dereference, address: 0000000000000020
[    2.819859] #PF: supervisor read access in kernel mode
[    2.820035] #PF: error_code(0x0000) - not-present page
[    2.820188] PGD 0 P4D 0
[    2.820305] Oops: 0000 [#1] SMP PTI
[    2.820436] CPU: 2 PID: 89 Comm: a Not tainted 5.7.0-rc1+ #7
[    2.820680] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20190711_202441-buildvm-armv7-10.arm.fedoraproject.org-2.fc31 04/01/2014
[    2.821150] RIP: 0010:do_coredump+0xd80/0x1060
[    2.821385] Code: e8 95 11 ed ff 48 c7 c6 cc a7 b4 81 48 8d bd 28 ff ff ff 89 c2 e8 70 f1 ff ff 41 89 c2 85 c0 0f 84 72 f7 ff ff e9 b4 fe ff ff <48> 8b 57 20 0f b7 02 66 25 00 f0 66 3d 00 8
0 0f 84 9c 01 00 00 44
[    2.822014] RSP: 0000:ffffc9000029bcb8 EFLAGS: 00010246
[    2.822339] RAX: 0000000000000000 RBX: ffff88803f860000 RCX: 000000000000000a
[    2.822746] RDX: 0000000000000009 RSI: 0000000000000282 RDI: 0000000000000000
[    2.823141] RBP: ffffc9000029bde8 R08: 0000000000000000 R09: ffffc9000029bc00
[    2.823508] R10: 0000000000000001 R11: ffff88803dec90be R12: ffffffff81c39da0
[    2.823902] R13: ffff88803de84400 R14: 0000000000000000 R15: 0000000000000000
[    2.824285] FS:  00007fee08183540(0000) GS:ffff88803e480000(0000) knlGS:0000000000000000
[    2.824767] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.825111] CR2: 0000000000000020 CR3: 000000003f856005 CR4: 0000000000060ea0
[    2.825479] Call Trace:
[    2.825790]  get_signal+0x11e/0x720
[    2.826087]  do_signal+0x1d/0x670
[    2.826361]  ? force_sig_info_to_task+0xc1/0xf0
[    2.826691]  ? force_sig_fault+0x3c/0x40
[    2.826996]  ? do_trap+0xc9/0x100
[    2.827179]  exit_to_usermode_loop+0x49/0x90
[    2.827359]  prepare_exit_to_usermode+0x77/0xb0
[    2.827559]  ? invalid_op+0xa/0x30
[    2.827747]  ret_from_intr+0x20/0x20
[    2.827921] RIP: 0033:0x55e2c76d2129
[    2.828107] Code: 2d ff ff ff e8 68 ff ff ff 5d c6 05 18 2f 00 00 01 c3 0f 1f 80 00 00 00 00 c3 0f 1f 80 00 00 00 00 e9 7b ff ff ff 55 48 89 e5 <0f> 0b b8 00 00 00 00 5d c3 66 2e 0f 1f 84 0
0 00 00 00 00 0f 1f 40
[    2.828603] RSP: 002b:00007fffeba5e080 EFLAGS: 00010246
[    2.828801] RAX: 000055e2c76d2125 RBX: 0000000000000000 RCX: 00007fee0817c718
[    2.829034] RDX: 00007fffeba5e188 RSI: 00007fffeba5e178 RDI: 0000000000000001
[    2.829257] RBP: 00007fffeba5e080 R08: 0000000000000000 R09: 00007fee08193c00
[    2.829482] R10: 0000000000000009 R11: 0000000000000000 R12: 000055e2c76d2040
[    2.829727] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[    2.829964] CR2: 0000000000000020
[    2.830149] ---[ end trace ceed83d8c68a1bf1 ]---
```

Here is the sequence of events why it happens:
fs/coredump.c:do_coredump():
1. create 'coredump_params = { .file = NULL }'
2. detect pipe mode
3. `call_usermodehelper_setup(..., umh_pipe_setup, ...)`
4. `call_usermodehelper_exec()`
5. (if both succeeded) `file_start_write(cprm.file);`

Here crash happens at [5.] as `cprm.file` is still NULL.

Normally it works because `fs/coredump.c:umh_pipe_setup()` is called
successfully and populates `.file` field (or returns the error):

```
static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
{
        //...
        struct coredump_params *cp = (struct coredump_params *)info->data;
        // ...
        cp->file = files[1];
        // ...
}
```

But in our case neither happens because `kernel/umh.c:call_usermodehelper_exec()`
has a special case:

```
int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
{
    int retval = 0;
    // ...
    /*
     * If there is no binary for us to call, then just return and get out of
     * here.  This allows us to set STATIC_USERMODEHELPER_PATH to "" and
     * disable all call_usermodehelper() calls.
     */
    if (strlen(sub_info->path) == 0)
        goto out;
    ...
    out:
        // ...
        return retval;

```

This breaks assumption of `do_coredump()`: "either helper was called successfully
and created a file to dump core to or it failed".

This change converts this special case to `-EPERM` error.

This way we notify user that helper call was not successful
and don't attempt to act on uninitialized `.file` field.

User gets `"Core dump to |%s pipe failed\n` dmesg entry.

Reported-by: Sergey Kvachonok <ravenexp@gmail.com>
Reported-by: Tony Vroon <chainsaw@gentoo.org>
Bug: https://bugzilla.kernel.org/show_bug.cgi?id=199795
Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
CC: Luis Chamberlain <mcgrof@kernel.org>
CC: Alexander Viro <viro@zeniv.linux.org.uk>
CC: linux-fsdevel@vger.kernel.org
---
 kernel/umh.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/umh.c b/kernel/umh.c
index 7f255b5a8845..66b02634a9ba 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -565,8 +565,10 @@ int call_usermodehelper_exec(struct subprocess_info *sub_info, int wait)
 	 * here.  This allows us to set STATIC_USERMODEHELPER_PATH to "" and
 	 * disable all call_usermodehelper() calls.
 	 */
-	if (strlen(sub_info->path) == 0)
+	if (strlen(sub_info->path) == 0) {
+		retval = -EPERM;
 		goto out;
+	}
 
 	/*
 	 * Set the completion pointer only if there is a waiter.
-- 
2.26.1

