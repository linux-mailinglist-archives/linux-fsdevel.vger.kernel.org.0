Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93628155C8F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 18:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgBGRFD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 12:05:03 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:47875 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgBGRFC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 12:05:02 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MtwIW-1jnXJr2Ehw-00uIjU; Fri, 07 Feb 2020 18:04:55 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        youling257 <youling257@gmail.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] compat_ioctl: fix FIONREAD on devices
Date:   Fri,  7 Feb 2020 18:04:05 +0100
Message-Id: <20200207170447.1251404-1-arnd@arndb.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hA/Jn/VqwfJRoyLL7+C0dmPI0bW1y9Wy9fTJ11p/XjHH/k4igyJ
 CXJDkaADAMHHgQ/+7P+QHn4ky5AqPX6P1tQMKJo8sfcJKNyXjmX8jOq+N8LZ7XkKjzZwkLv
 pjLGpDLAKybrbEP8CRU9VYzKyTxWc+NrxqS054iIaGgPWuxOxR2kIq7gcII4LoiUxuk2pxN
 y1oRGrDvsQ4roxAYiC+Qg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yLQYzVl2pag=:bHIbF5RzszCBcwzMx6AHcX
 ACxgZUrDNgXigVujVO8f1UQZrkkE5SYAAajN1JzwRqk7zMNIzopKCB7PyviLngIRTv09ACkV7
 895B4n5art8uNiuhQtBFI8Wq3T5G4Y6ksz4ebCOqbPFc/09mwqmsbt07PhKfaloEE2MDVTExT
 f+2U7g/cwACMLViLcpf0v1S5t6+qBf+hJO81oIH5VrnwJsTtkHkhBjrm8Tt+L6dSzVQMwjiWj
 TP033bg5uysWgdGakLR7+pDd9FV98npqs3flXKYVL7W/MiWqi9oIgZ+e50k8qDhzaIZDsZjux
 jTVxe78Ec3pGwifGMQqq3eXLP+JBeEoH42gGwdTa5wHWHReQiVLfKal7aq+zKLNuMReNZAAS0
 P8ilBPokFglusgt4QpQ9urBLxaN76RE1Hu8cphUCEev1y79x3EySlP9N+8akZI40PR84Gi01Y
 M7vRqhO4vXu6NxKAx85DbSL1mN/Nny4rUoXf7r7BIDryPaljIYbLK5OKyJerRBK0t8tsrwk2H
 SDvn0sXUTH7WUc3vHOKHrlrxtegDQjOsYAQgP2tjjP0QbP111tl2NByu6pwzkS/eHPOEvt9QN
 1tZZa5isoMwe6oCVtCgTuVWOip/ybp9FlTOiKnZU0Cm5U9/Y7UFIx+jJwVV8nf0Id/x9vGHg8
 QPz+CZvtYan1H+aZcSt7S2kOiSLZWZsF/Kuf7bI1OJWbXe2fbVa/jzgkh8qFLlDWt+G323Qck
 vIpX6UVwuBUuO24q347hxC1havOXVSrswsbxHq7uQDcUjfcsvPHwJNquhOc5Bo84/8NaQ+HeX
 FkMRH+1bceoCyCWa07JhP886S42Zwr6ocIwK0rHZV08UGgOmoM=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

My final cleanup patch for sys_compat_ioctl() introduced a regression on
the FIONREAD ioctl command, which is used for both regular and special
files, but only works on regular files after my patch, as I had missed
the warning that Al Viro put into a comment right above it.

Change it back so it can work on any file again by moving the implementation
to do_vfs_ioctl() instead.

Fixes: 77b9040195de ("compat_ioctl: simplify the implementation")
Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Reported-by: youling257 <youling257@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Untested so far. Christian and youling257, can you see if this patch
addresses your problems?
---
 fs/ioctl.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 7c9a5df5a597..5152c98cfc30 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -523,13 +523,9 @@ static int compat_ioctl_preallocate(struct file *file, int mode,
 
 static int file_ioctl(struct file *filp, unsigned int cmd, int __user *p)
 {
-	struct inode *inode = file_inode(filp);
-
 	switch (cmd) {
 	case FIBMAP:
 		return ioctl_fibmap(filp, p);
-	case FIONREAD:
-		return put_user(i_size_read(inode) - filp->f_pos, p);
 	case FS_IOC_RESVSP:
 	case FS_IOC_RESVSP64:
 		return ioctl_preallocate(filp, 0, p);
@@ -721,6 +717,13 @@ static int do_vfs_ioctl(struct file *filp, unsigned int fd,
 	case FIDEDUPERANGE:
 		return ioctl_file_dedupe_range(filp, argp);
 
+	case FIONREAD:
+		if (!S_ISREG(inode->i_mode))
+			return vfs_ioctl(filp, cmd, arg);
+
+		return put_user(i_size_read(inode) - filp->f_pos,
+				(int __user *)argp);
+
 	default:
 		if (S_ISREG(inode->i_mode))
 			return file_ioctl(filp, cmd, argp);
-- 
2.25.0

