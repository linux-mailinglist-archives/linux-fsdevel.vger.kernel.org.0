Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF738DF6E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 22:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbfHNUzp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 16:55:45 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:51841 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfHNUzp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 16:55:45 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MTRAS-1hqCnc1bOG-00TlOd; Wed, 14 Aug 2019 22:55:36 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Dmitry Safonov <dima@arista.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH v5 11/18] tty: handle compat PPP ioctls
Date:   Wed, 14 Aug 2019 22:54:46 +0200
Message-Id: <20190814205521.122180-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190814204259.120942-1-arnd@arndb.de>
References: <20190814204259.120942-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:y1TEGeFNHzbv3ETSzk+Ge7p4uSUBKqjD+pi67GZ8vNmcEncSU+X
 1IQY9Q6UrEwfRXHUMi3/6VO1B4JiA7auIN8FTuZkAd0aan9A+Sv1fJHZCOh8CaLkgr3WNe/
 mb/zuw5Ipe5QabrBL0ZBpELKzmAg9ssO4IfGKeaazgB/e3vl2JjE+Z0l3MRiYRWXE7IVYzd
 f6S52cChTD9gcOj6xchjg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BcyhzUX7r0k=:36Bg5SmEhv6QI58j05fqOJ
 zRFzfLjnx2+NXJ94g6sbAlbxkt1G1kfNu0ThXI689mhlP4PlymW33q6B9YxfN8SiSfj9vsK2s
 NDiRg6SPt/oBWnGC9F2NZO7kGrPcTePqAOCRUd0u5Qt3BrdgMJSaNEhErHlJzKYIV6sd4cfag
 Vu62mgxv/3rOljIz+64aaTKk16eXsLmKQ/Ntt6G5NvpZvXphS/sJ/YzePF+vH8/uS/4YYiIjw
 zuD5wUuhJQM9hStTJEjztHvwVSf0/CFUfqkuXzZSCsPP6fAVfxvCcgBLhSFqABLhBZt6dRw3H
 ndTiIsBSaCMPtBjCHDl3NLLBr1Ep7mvhiM14AeuTsLr2s1+/vLoOaIvZ0rikQIuxD8tjVFsAt
 SQmdxZn/VsACNHRoiAWHSLMRfHJdte4M7xWDS/OIB8LtZeGdWicfo7vP9zLg7EHs+ZlHrZCjk
 Abq0duqYJur3IPp/IoLRgHTC5puRC57dblZsM1kM9AxkBmsJZ0lAVCWUmvrYnAj5g3x48/6Kz
 dJSJeSkjS/rLCMoHoPRVLAK//powwIz7eDzqjEX9laHSwVh2K8rXS9ayRlbnSMt7GYJZZHR1J
 7jIVvNng3jE+R8ywVzIiL4VyXBGqmuAAjTh4sEmfxTZmNKxu0sMHLO1qQbNPyYjwttARiDhzm
 XNek1pPVFmVUsKDNE/up0qrtWiQ9qr8Xq59cY6yKBjV2rQk26bttdYWcbsKLwKZm9TQNsISbw
 vmxc/G7hmEN1/rxyRj5ntic86Q7RX3JObMaWyA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Multiple tty devices are have tty devices that handle the
PPPIOCGUNIT and PPPIOCGCHAN ioctls. To avoid adding a compat_ioctl
handler to each of those, add it directly in tty_compat_ioctl
so we can remove the calls from fs/compat_ioctl.c.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/tty_io.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index cee8b69c6f72..bf5241e0d772 100644
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

