Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6E819767C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Mar 2020 10:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbgC3IcB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 04:32:01 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:60517 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729576AbgC3IcB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 04:32:01 -0400
Received: from clip-os.org (unknown [78.194.159.98])
        (Authenticated sender: thibaut.sautereau@clip-os.org)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 3D35D20000D;
        Mon, 30 Mar 2020 08:31:58 +0000 (UTC)
Date:   Mon, 30 Mar 2020 10:31:58 +0200
From:   Thibaut Sautereau <thibaut.sautereau@clip-os.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: NULL pointer dereference in coredump code
Message-ID: <20200330083158.GA21845@clip-os.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

I hit a kernel NULL pointer dereference caused by the following call chain:

do_coredump()
  file_start_write(cprm.file) # cprm.file is NULL
    file_inode(file) # NULL ptr deref

The `ispipe` path is followed in do_coredump(), and:
    # cat /proc/sys/kernel/core_pattern
    |/usr/lib/systemd/systemd-coredump %P %u %g %s %t %c %h

It seems that cprm.file can be NULL after the call to the usermode
helper, especially when setting CONFIG_STATIC_USERMODEHELPER=y and
CONFIG_STATIC_USERMODEHELPER_PATH="", which is the case for me.

One may say it's a strange combination of configuration options but I
think it should not crash the kernel anyway. As I don't know much about
coredumps in general and this code, I don't know what's the best way to
fix this issue in a clean and comprehensive way.

I attached the patch I used to temporarily work around this issue, if
that can clarify anything.

Thanks,

-- 
Thibaut Sautereau
CLIP OS developer

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="0001-coredump-FIXUP.patch"

From 613dfc60429c1fc5fc19e1c8662648620dc103af Mon Sep 17 00:00:00 2001
From: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
Date: Fri, 27 Mar 2020 16:34:59 +0100
Subject: [PATCH] coredump: FIXUP

---
 fs/coredump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index b1ea7dfbd149..d0177b81345f 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -686,7 +686,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 							  UMH_WAIT_EXEC);
 
 		kfree(helper_argv);
-		if (retval) {
+		if (retval || !cprm.file) {
 			printk(KERN_INFO "Core dump to |%s pipe failed\n",
 			       cn.corename);
 			goto close_fail;
-- 
2.26.0


--FL5UXtIhxfXey3p5--
