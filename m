Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 021E3D180A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 21:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731998AbfJITLZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 15:11:25 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:48089 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731986AbfJITLY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:11:24 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N8XgH-1i5VgB1LZh-014SRC; Wed, 09 Oct 2019 21:11:22 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH v6 42/43] pktcdvd: add compat_ioctl handler
Date:   Wed,  9 Oct 2019 21:10:43 +0200
Message-Id: <20191009191044.308087-43-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191009190853.245077-1-arnd@arndb.de>
References: <20191009190853.245077-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:93xVR2PSRzNKK3F6eEf3KloUW20yUoSchuNU1iTvhPWVCYwsH8H
 z13+p8ef1mAztjV2JdOjKqOYgaMbqp2tn3Z/Vg8IrXIlrGafn4DCxbrq/pChzzAUUHcuEV9
 RtB6cLBqK0HwCVek/0QpPj02Twg2C0IwFQBlScLKqgWIJIg8/tqbCevylU4jhp4uvGMzVBl
 3NURu7wv2UyKvLx5eGCaQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/Z06bO3lT6w=:6NXRRLxYm/LA0XwBWwo6Q7
 p/KW3+sAt3EnBV6ubbtZExBdcmG9keJjb1cALDVt3+5J5dZnQNtMCpQZqSQrSXht8Ch+KQEUG
 MD2bQvKIe+STPbvBSWGqwieBm7Nb6k22/aNSgdTepdK37zcaLHlAzt6ETugYcc8i8qCuQ23vz
 QbqIM810G2lWNY8Ap3z60/POVSiooVUxgflLJ3iW/d3y2muXKmPowKXUdofL+6iQnTQ5dlXmg
 dJKsOBWOfEtAvFnUtTy5qpbgVx1UCb1x0dYR19li7QIxHQbGImIFi4sxCanHAnpvZjTgO3XRr
 lS+mJFtS4nU8uGOxE8cu06ALG8S0LQQeYCNXgIdS8+qw9i2WqSYUCmt0JRXwhh/ACr54BSerh
 hOHIW0lShwaiuv8KRezSH42mGEBA2P0tK0W8I6MPKy9a4UZjVI/q46Fcll4C3+oun5NOK8F8r
 1HgADAwxOEctsr516d5iH4xzz/LDcZvyldyWsSEED9n7CZ7Hib4KnZNhkN4my+gFp3AySkUMs
 9Vysmz9349cTarI7TFSsIxmLZrho7bEtMoHh0NQYpq4yWmyl1sxk0RcMpATWBX/dgXoTAmlJQ
 +br7DNaAzWs8uXFUdM5iiVhmD/dZQGeJF05wYsF33UeeuY9JyZRK44XrOIulA0ppKA799aIxY
 TrlyWvXwzLaEUVi2Gmpcr6yonfuurYg1p7+y1oi0I2K5hDIBiYRbNzbWR3PD+8Z3jnrCsT0+X
 DOM8GRXm297v4+bx+scA0bJ1R7XBVvz8IxrtzT3bwNAfxyXinOjCqZK68Ml/P0kfC/EZF8Bwt
 FvkQTEKTAA29QbZszpwY36dp9F5SUveI9RVSd/U6TyhfPb2x6mbg0h+M1etFyQdCq8Ug/HyjY
 r8LwN/SEfrpnWkDGz16Q==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

pkt_ioctl() implements the generic SCSI_IOCTL_SEND_COMMAND
and some cdrom ioctls by forwarding to the underlying block
device. For compat_ioctl handling, this always takes a
roundtrip through fs/compat_ioctl.c that we should try
to avoid, at least for the compatible commands.

CDROM_SEND_PACKET is an exception here, it requires special
translation in compat_blkdev_driver_ioctl().

CDROM_LAST_WRITTEN has no compat handling at the moment.

Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/block/pktcdvd.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 76457003f140..ee67bf929fac 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2663,6 +2663,28 @@ static int pkt_ioctl(struct block_device *bdev, fmode_t mode, unsigned int cmd,
 	return ret;
 }
 
+#ifdef CONFIG_COMPAT
+static int pkt_compat_ioctl(struct block_device *bdev, fmode_t mode, unsigned int cmd, unsigned long arg)
+{
+	switch (cmd) {
+	/* compatible */
+	case CDROMEJECT:
+	case CDROMMULTISESSION:
+	case CDROMREADTOCENTRY:
+	case SCSI_IOCTL_SEND_COMMAND:
+		return pkt_ioctl(bdev, mode, cmd, (unsigned long)compat_ptr(arg));
+
+
+	/* FIXME: no handler so far */
+	case CDROM_LAST_WRITTEN:
+	/* handled in compat_blkdev_driver_ioctl */
+	case CDROM_SEND_PACKET:
+	default:
+		return -ENOIOCTLCMD;
+	}
+}
+#endif
+
 static unsigned int pkt_check_events(struct gendisk *disk,
 				     unsigned int clearing)
 {
@@ -2684,6 +2706,9 @@ static const struct block_device_operations pktcdvd_ops = {
 	.open =			pkt_open,
 	.release =		pkt_close,
 	.ioctl =		pkt_ioctl,
+#ifdef CONFIG_COMPAT
+	.ioctl =		pkt_compat_ioctl,
+#endif
 	.check_events =		pkt_check_events,
 };
 
-- 
2.20.0

