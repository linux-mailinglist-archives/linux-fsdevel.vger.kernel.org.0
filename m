Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06D5AD187B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 21:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731821AbfJITLP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 15:11:15 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:38647 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731771AbfJITLO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:11:14 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MiJIk-1hd9qo47VO-00fSl7; Wed, 09 Oct 2019 21:11:13 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH v6 17/43] compat_ioctl: move rfcomm handlers into driver
Date:   Wed,  9 Oct 2019 21:10:17 +0200
Message-Id: <20191009191044.308087-17-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191009190853.245077-1-arnd@arndb.de>
References: <20191009190853.245077-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6o+fXd+jknkQ9Kt+dvDcH2dQqv7QFvYbBe3gxSyUw1PSROtnjoC
 7emE8+IitiN6xjQXFyhJvQU8e1C2V+fxOFrCYIjgXTdqqHASt08GP0Z1d5xH9MzPLbtu66P
 J9oEstuey1r2im/khtnqN9ZUzi0/bdwd6fjul/INAkUaVFJARkaZ6IBSzGf5Q1Pru86T3TC
 RUO7i6kp1LdP3l2dPUNFA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TfUEyc2+NPc=:HQ0oFvhTGn1RZEKc3Ghs8F
 mZuFQC5DGwW0zJ1yLyyIvNeHvHuFx2WYnZpYMUgR75C8zilFGgZTc4FT5B6U4YrtxF94LBsT1
 aFMmGPdcXt3X3Aa3biEa6q2oPA+4wDN+MLN/zPKC3nFn3fip0Y8Ph9g6D+O4LLGBpgPmBOQai
 L313sbBBBn8EOvb9RlOjvEr0BvXcNml2Udlk1AZ0uMGYovu1N/CrBckv/sNivfiofL7H+n6OL
 5lPE/xH8R4808YhlRKFaObMEh7wUTg1X0m0VgvitGjs+vFHoqHpN0EkjVJF5mGEsdHsPSCIhZ
 Zvk8BvJDJJDvoNqa6XQyxJgiicAHJmt6WogcBOLTkKkfYiBx7vFVcI3OalPhRXlz9skpAyosl
 aol1tZ9f05XoxVAZSnA4S/wsNUlVhl9dvb3AAt/U1MaJ/wiIvB/YnHdgIVcRNuZ1y1Dgegx/E
 3/kLeXDYe+WOmNrgbmQejT1UE0eiMez6lxw+Z3n7huo5J2ceBwVLX8Q1z01DCfbRK1utQAOLJ
 QzJtytYoLkP8jVy0gIiZVyeaC6Ls73n9P7B0k/2i2aZ0zPruP52dMpl3d7jrxoNEG09l7k4cE
 ICvpgihvMHXrUVrfYGnn7WV+0KxeLDFBeobqJ59+jkBO2qc4MyZ2ca7nCYLsIGI+NcINZ3IO7
 8as8Yb2CgQBuqBm3B/qFhfjL7wrryfshgIMCxyI9eWyV0bHZEDC+S7Qtrr0T51BE+q2saKwmw
 JkbP3mfikcWSzZ5f27InGlbpd+5I8g9LLtKFRMpD3PR4Nt2Np/9m9DIE1f9Xr1/gSZarciwhE
 9I94MxMItu1Wl/uS3Uu3Uygx/LjFAFM3nWx2mamLAUG0Bx2iYbWpCa8qU3NQ/gSDMdGSGchra
 KsI1SHv+a3ZDDUWuGHLw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All these ioctl commands are compatible, so we can handle
them with a trivial wrapper in rfcomm/sock.c and remove
the listing in fs/compat_ioctl.c.

Acked-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c           |  6 ------
 net/bluetooth/rfcomm/sock.c | 14 ++++++++++++--
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index f3b4179d6dff..8dbef92b10fd 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -42,7 +42,6 @@
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_sock.h>
-#include <net/bluetooth/rfcomm.h>
 
 #ifdef CONFIG_BLOCK
 #include <linux/cdrom.h>
@@ -673,11 +672,6 @@ COMPATIBLE_IOCTL(HCIUARTGETPROTO)
 COMPATIBLE_IOCTL(HCIUARTGETDEVICE)
 COMPATIBLE_IOCTL(HCIUARTSETFLAGS)
 COMPATIBLE_IOCTL(HCIUARTGETFLAGS)
-COMPATIBLE_IOCTL(RFCOMMCREATEDEV)
-COMPATIBLE_IOCTL(RFCOMMRELEASEDEV)
-COMPATIBLE_IOCTL(RFCOMMGETDEVLIST)
-COMPATIBLE_IOCTL(RFCOMMGETDEVINFO)
-COMPATIBLE_IOCTL(RFCOMMSTEALDLC)
 /* Misc. */
 COMPATIBLE_IOCTL(PCIIOC_CONTROLLER)
 COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_IO)
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 90bb53aa4bee..b4eaf21360ef 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -24,7 +24,7 @@
 /*
  * RFCOMM sockets.
  */
-
+#include <linux/compat.h>
 #include <linux/export.h>
 #include <linux/debugfs.h>
 #include <linux/sched/signal.h>
@@ -909,6 +909,13 @@ static int rfcomm_sock_ioctl(struct socket *sock, unsigned int cmd, unsigned lon
 	return err;
 }
 
+#ifdef CONFIG_COMPAT
+static int rfcomm_sock_compat_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
+{
+	return rfcomm_sock_ioctl(sock, cmd, (unsigned long)compat_ptr(arg));
+}
+#endif
+
 static int rfcomm_sock_shutdown(struct socket *sock, int how)
 {
 	struct sock *sk = sock->sk;
@@ -1042,7 +1049,10 @@ static const struct proto_ops rfcomm_sock_ops = {
 	.gettstamp	= sock_gettstamp,
 	.poll		= bt_sock_poll,
 	.socketpair	= sock_no_socketpair,
-	.mmap		= sock_no_mmap
+	.mmap		= sock_no_mmap,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= rfcomm_sock_compat_ioctl,
+#endif
 };
 
 static const struct net_proto_family rfcomm_sock_family_ops = {
-- 
2.20.0

