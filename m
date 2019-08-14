Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 356058DF86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 22:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbfHNU5f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 16:57:35 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:50785 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfHNU5f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 16:57:35 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MPowd-1hckJz13UB-00MpFs; Wed, 14 Aug 2019 22:57:32 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Hannes Reinecke <hare@suse.de>
Subject: [PATCH v5 17/18] pktcdvd: add compat_ioctl handler
Date:   Wed, 14 Aug 2019 22:54:52 +0200
Message-Id: <20190814205521.122180-8-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190814204259.120942-1-arnd@arndb.de>
References: <20190814204259.120942-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vtBRrSTbxRM+4N7JG/SqINjMT8OwhCCnfEV9GLfJMlj7zzHmXqL
 wFcQBgM7/r/60w0dHWdIX39QTgYM4f/6oLGxqnTXmb0CHbl9e834v0p2Rmzje1ZTzLFB0d4
 ArUarrUL7+s3fgxa94yevKS1w3wmtdSr7o3Jo/MviF7gzdbq7Vr5Sa0PLjOc3+0XsDb7ayd
 Im2A9aO8g12wUfvh63IzQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:oXxoA9Saf5U=:wn2CxSLASoltE+VPtsKsmS
 DbM3bcSOL5toXC7kI5Wz6RafyaM3cAUqLlE3zjj3c2paNf19x+xqkxDbfmVmBPA63QSHuNvlo
 aNikgXHDUJ8bhRVl3ntnHP/QQQhffoJlfbuIOka54SfVt754KI6HKMfBnl1uLRKT5k4+4ItGZ
 /itPTJ3SDZA1hRH4ZojXudrHRYkPWnJmzt4GYzIPq3Ewf2uH0vIg2s4swG5LPGrVV4gMiUiXf
 3b3TQPCWgpHmS4mBiAigr/vnrj7Ps7Lr3BVqSAR8ioWfzXjnFesSIO3H8YHlIB5VZCYnozlpK
 rpXwIG8gGgfZejIX2FD5CW+2QCT766pjpVsSiQlCWlsREd7u4WNA+CcS3CX7WaAIKx0z8vSe5
 7obgtro6nmMuqzOTcjPLrfLt4NQNPitX7upsF5WWyhUiMBqMnhBb95qBmr61t1yaR30GgYaKa
 nmKXPddvpCL8Dx+/T2jw2Eh7FDG5rr/H6Sh/ti8cH0/L0PBate4GA8OTM6yV3dwtOdSIMJEmO
 GcI941L57d5nOl7fZDJe2DxZyjKA6RG9kcEr17w+Ff/hJ6CbTGBAhwHDt9WMZsplcRj7LdJoO
 yv14a5pkTALtpSrjJd9JhqIn1MVYvyoTPee7UiU5MUtw366JG52QkMRjoDzcC7CBKlnrDDJDX
 47JwnZHHclHBGahHLCJehDayQgvWpgjncjEbJpYMi5AVfW8LQrzJZ1Ue1XnaOM4sMLkd2HJJb
 zRdDmZjFRSEBmUUiGjtz5uyZGpGQ34zVToeIOg==
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

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/block/pktcdvd.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 024060165afa..b5950b7851b0 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2664,6 +2664,28 @@ static int pkt_ioctl(struct block_device *bdev, fmode_t mode, unsigned int cmd,
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
@@ -2685,6 +2707,9 @@ static const struct block_device_operations pktcdvd_ops = {
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

