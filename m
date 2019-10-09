Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41627D1888
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 21:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732151AbfJITOz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 15:14:55 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:33077 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731798AbfJITLP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:11:15 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MI59b-1iLGB40u1P-00FEcy; Wed, 09 Oct 2019 21:11:13 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH v6 18/43] compat_ioctl: move hci_sock handlers into driver
Date:   Wed,  9 Oct 2019 21:10:18 +0200
Message-Id: <20191009191044.308087-18-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191009190853.245077-1-arnd@arndb.de>
References: <20191009190853.245077-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3b9/EnEmRxtjq9xec8nuAiDp4EeBAPlIlguXDpmUbx5+b5wz/3H
 vVaQkpTtaA/szT2d3L/bAiVbxOuNJTxl1WQpIlu3yVpJDiXwTWIseqYi/ZFt8Xp5NwKArDY
 rOLB7Nc92AJX7A8KhERCB71rlnqDPMm0OcGDrzJFp2ADsTnCkpe7bVTbbsVZq0qW7AdSGSh
 3L7dkLWIAfN034tnXTrzA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lrKm9W1vy5Q=:FrUQun1LEglGNsblDtuJIM
 3/8y6eHSHjcHUrag6kQIOcmvyt9XVkmrJouJTQx5HZCspjXg6PjVGEMesPfPNs7Ifj5Tk1uua
 BljHakosdQWFnAULMNU1Ws0WrLAl3yx/DT5p3YKcKMnhweMTkQRNtmM5X+Q2wjcfRZb0Wz9Vk
 tbkc0JFksT5ghmO/A0GOxN+ZqHG9Cz57gdQUmyHSvvMazkZCSqlST4uBKS8w5l9UdeUt4R3TF
 ahIQ1qculoOibIUplUodcfG6jL22UukgMrCXtZ97jGIhxZw4pNjW8aYZUltysnveOaatIU+85
 nd6KmiAyAf8gMzUZ+eGsFgb4kYLtXMtt+vcw2emMkTQoB2ts6lQsjGxlzvuiALG8eJZi9lUgz
 AV0KdvnmlIOHI3YcdUJjT4/tU2SFpditmA/98J6q4S2TUIpwm5rSuOF8UrCoabxiGi+xHh/3M
 n4/1C78ksCFTFnGENCX6PcT8epFaC6HBoIh0t7uxsyhtfJtlKSZmbkeLZlMYdX5MAX7rjtDOw
 ELSRxeOHXOGNilEuNmJw0DFVR5VVJ4s1M4hNxQZyoerPzU35l7BCurELkJRnjXjzejxrwvc0p
 iY7CIF1uLlozw3aB42OquZ1nrvM+FmKie47F0lckkGxVlTYCsls0ew/x9PO+3Bb1h8QBeTgrT
 i+x0t7An9ig8Hpurgeki8w+jTB/6uTIKA9YjcLV+pugJGzK8hBKnRE5tc0RhictQ6/WQMKRW/
 HvUJygiFQ+YPjQr4W1MisU5dMiyXaZGy+UMpGg0XdreoIIAkAhaBf7CWd61KFqqZtW7ahE5d/
 etNyibqz1M4nhPvXNDDYj3IKmiMHOeLLT5w2vnRjct8PJcHgA/DgEsDF1yslnFDyH2Hou3qon
 Zp9aPGellO4i0EzELdKA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All these ioctl commands are compatible, so we can handle
them with a trivial wrapper in hci_sock.c and remove
the listing in fs/compat_ioctl.c.

A few of the commands pass integer arguments instead of
pointers, so for correctness skip the compat_ptr() conversion
here.

Acked-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c        | 24 ------------------------
 net/bluetooth/hci_sock.c | 21 ++++++++++++++++++++-
 2 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 8dbef92b10fd..9302157d1471 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -40,9 +40,6 @@
 
 #include "internal.h"
 
-#include <net/bluetooth/bluetooth.h>
-#include <net/bluetooth/hci_sock.h>
-
 #ifdef CONFIG_BLOCK
 #include <linux/cdrom.h>
 #include <linux/fd.h>
@@ -646,27 +643,6 @@ COMPATIBLE_IOCTL(RNDADDENTROPY)
 COMPATIBLE_IOCTL(RNDZAPENTCNT)
 COMPATIBLE_IOCTL(RNDCLEARPOOL)
 /* Bluetooth */
-COMPATIBLE_IOCTL(HCIDEVUP)
-COMPATIBLE_IOCTL(HCIDEVDOWN)
-COMPATIBLE_IOCTL(HCIDEVRESET)
-COMPATIBLE_IOCTL(HCIDEVRESTAT)
-COMPATIBLE_IOCTL(HCIGETDEVLIST)
-COMPATIBLE_IOCTL(HCIGETDEVINFO)
-COMPATIBLE_IOCTL(HCIGETCONNLIST)
-COMPATIBLE_IOCTL(HCIGETCONNINFO)
-COMPATIBLE_IOCTL(HCIGETAUTHINFO)
-COMPATIBLE_IOCTL(HCISETRAW)
-COMPATIBLE_IOCTL(HCISETSCAN)
-COMPATIBLE_IOCTL(HCISETAUTH)
-COMPATIBLE_IOCTL(HCISETENCRYPT)
-COMPATIBLE_IOCTL(HCISETPTYPE)
-COMPATIBLE_IOCTL(HCISETLINKPOL)
-COMPATIBLE_IOCTL(HCISETLINKMODE)
-COMPATIBLE_IOCTL(HCISETACLMTU)
-COMPATIBLE_IOCTL(HCISETSCOMTU)
-COMPATIBLE_IOCTL(HCIBLOCKADDR)
-COMPATIBLE_IOCTL(HCIUNBLOCKADDR)
-COMPATIBLE_IOCTL(HCIINQUIRY)
 COMPATIBLE_IOCTL(HCIUARTSETPROTO)
 COMPATIBLE_IOCTL(HCIUARTGETPROTO)
 COMPATIBLE_IOCTL(HCIUARTGETDEVICE)
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index d32077b28433..5d0ed28c0d3a 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -23,7 +23,7 @@
 */
 
 /* Bluetooth HCI sockets. */
-
+#include <linux/compat.h>
 #include <linux/export.h>
 #include <linux/utsname.h>
 #include <linux/sched.h>
@@ -1054,6 +1054,22 @@ static int hci_sock_ioctl(struct socket *sock, unsigned int cmd,
 	return err;
 }
 
+#ifdef CONFIG_COMPAT
+static int hci_sock_compat_ioctl(struct socket *sock, unsigned int cmd,
+				 unsigned long arg)
+{
+	switch (cmd) {
+	case HCIDEVUP:
+	case HCIDEVDOWN:
+	case HCIDEVRESET:
+	case HCIDEVRESTAT:
+		return hci_sock_ioctl(sock, cmd, arg);
+	}
+
+	return hci_sock_ioctl(sock, cmd, (unsigned long)compat_ptr(arg));
+}
+#endif
+
 static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 			 int addr_len)
 {
@@ -1974,6 +1990,9 @@ static const struct proto_ops hci_sock_ops = {
 	.sendmsg	= hci_sock_sendmsg,
 	.recvmsg	= hci_sock_recvmsg,
 	.ioctl		= hci_sock_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= hci_sock_compat_ioctl,
+#endif
 	.poll		= datagram_poll,
 	.listen		= sock_no_listen,
 	.shutdown	= sock_no_shutdown,
-- 
2.20.0

