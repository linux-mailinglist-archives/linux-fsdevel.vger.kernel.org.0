Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE4D4D1864
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 21:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731885AbfJITNj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 15:13:39 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:59653 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731968AbfJITLW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:11:22 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N5VXu-1i2Ujq2Hqk-016vHR; Wed, 09 Oct 2019 21:11:20 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Mackerras <paulus@samba.org>
Subject: [PATCH v6 36/43] tty: handle compat PPP ioctls
Date:   Wed,  9 Oct 2019 21:10:37 +0200
Message-Id: <20191009191044.308087-37-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191009190853.245077-1-arnd@arndb.de>
References: <20191009190853.245077-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:43BP+32+2SiwTrW6MHUM/okhpG3+oHxC7RcOSEJIqMvz5OLkUqt
 4/etTty+G8dCqllqFpFIPxLDCLHphxe0yjLccmA9PMIloSi4DvuMfEWE+N9gX0loKtl12KN
 e2rIOaV9KpRmAdGGcnVEWrBiQ0lG5bqZodCI5jWL9IINqIFdiDQmwA7Ho6rWDHEHg3gBxjT
 M+ZwTu5E43IV5LS9jLXww==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:gtDDUaRl35U=:cNNhWfh43v/g15sk9Sw8Jk
 qJ0JStosDeWOibvIqepXRzxCr/5DpPxW6r8CBD7JouAQn+zp7ipRB3BJ8bLu4dsRzmWoZ/Vsc
 ujtTtGIT5tCt16EADFOYAfScuXBkuSEKcFjvqKA0C3uGZVGM7oMOcEps/gZY2Zhhqd/DoyvZJ
 s6c1tiQWYNTIj5JFmAUEg3kM1Gt7WkPhAqtVtvjVvyZJNQU7fM6zAixHnhYtLqUyoxcv4HJWS
 l20OpT3/OiJEepE0Zv5vRmJ+G48YWNoxc/8VkSqZCFFu6Ndx2X6rQLcyUIeDjdkwr6P9NDcXu
 0rVwnfVceb6M4rf0IiBruPUe4rhoyrq8QZja9QUzRbSpLyTVXb9x6BnF1Mpq32KF9eflgs20P
 Nv9vCc3vmvuqXHcq4MnNx5h3gORAAA+vfNZI5BM0vK+qR7jajhGc92ONFasYswahZ+Bt7jUzT
 wPHAfQStt6mek+qiSDGtlXtmByOlRsTP7/a07aaaNiGp0W3XXzM3w1UoLaV4lNJrE6O1Um9zx
 hJEs6cclD5D653vrsjCLHKYGUb2NgMMKLpRCYPltRj3OoGNH4w6VPrlMNbTmQ6rCQxUpBlU0c
 76dZWRV42PYz85hj+HO740aHQBt4WscIPmXyr8DKP08ZNuWsATyo3vMjyL4QzSNUZmsPHIBBd
 MSMZlrF0kcudKDKGpoPDit5D8JA8niV2asWhDYJYSndCB+z5hH1vgCX4aBJruEaKNo74v35FF
 nYHF74YeFzDORpXF7RvyyfSt3gZ/mD18cz5GmKLZ2raM4USL9uDjjc1UlNaBamGmArU/7usuN
 DSSq36+6+sF+mDfCZtG+WOnnrIXO63z3M/lsxwSk8cyyzcIAHFvV5qnrySF1Cz6XpSxuy7YIc
 JUA7GVYrBlSzgov2GTAw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Multiple tty devices are have tty devices that handle the
PPPIOCGUNIT and PPPIOCGCHAN ioctls. To avoid adding a compat_ioctl
handler to each of those, add it directly in tty_compat_ioctl
so we can remove the calls from fs/compat_ioctl.c.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/tty_io.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index c09691b20a25..a81807b394d1 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -87,6 +87,7 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/poll.h>
+#include <linux/ppp-ioctl.h>
 #include <linux/proc_fs.h>
 #include <linux/init.h>
 #include <linux/module.h>
@@ -2811,6 +2812,9 @@ static long tty_compat_ioctl(struct file *file, unsigned int cmd,
 #endif
 	case TIOCGSOFTCAR:
 	case TIOCSSOFTCAR:
+
+	case PPPIOCGCHAN:
+	case PPPIOCGUNIT:
 		return tty_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
 	case TIOCCONS:
 	case TIOCEXCL:
-- 
2.20.0

