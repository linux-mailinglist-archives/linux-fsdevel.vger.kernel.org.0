Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 035BE1239C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 23:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfLQWUJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 17:20:09 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:60465 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbfLQWRi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 17:17:38 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MLz7f-1iPOdC2idl-00Hxzz; Tue, 17 Dec 2019 23:17:27 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux-doc@vger.kernel.org, corbet@lwn.net, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 10/27] compat_ioctl: ubd, aoe: use blkdev_compat_ptr_ioctl
Date:   Tue, 17 Dec 2019 23:16:51 +0100
Message-Id: <20191217221708.3730997-11-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191217221708.3730997-1-arnd@arndb.de>
References: <20191217221708.3730997-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:pXgtQR2qBCnSxJSJP7Y8qCzLQ/VoWcKI8ZIUVUSLjozoL96eoEm
 jS/dQT773HwnIlYtCaz/VwTxsgiorHcK0GE59g6ES4DCAbJYDR1pNRuCqoUrPHL4Ry4d3U7
 TBlboU8N5E4h71VTNV7UqnqgBwVPx8dGUD6nhs40UU5t+Hdgl82MsiuumI+NIWKdfJpzvX4
 BT+G3Xk7tKgva9zDuTjig==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3Sn1qxFJj1c=:tUMSxbPiYFrI6EX1e3mwt7
 rHN1+PnajD2XFYaIDBNraD9FEMOuqalFH++3MPe70YKbWzHjPVXp2SL1e2amVBuwM/tQF2poX
 ZAxg9IGxSpByjPBLphmGwJ8tzfMgc23wRM9E/pheclEc7m26cxOfl3TGgSCxXueTFmEB3ohUE
 8SFPImb/0CCIBMaoCC2lrjkTXrQWtrhzYfy0hXOg5SKiZCFOn2hsV1NwgrfqVUF2XXM4zDZB3
 mFdH5RfFHOMubdOiTJhBtV81Q6rN0AaRiJ2t9RYKpPKv8kBfzJsECcI2K3Wo6P3e84R8oAQ/+
 8TSMWS/N3oAkC0IXVoOtDUhRyPVSZnXGkarWjwRIAkOZ+m1p0E1QXhImXsX71oNmMzdJNOk17
 LbnQyUIr+3uUxLO/OKVOqRlfMs0UBbLGTD/7WdEw8jF3Lxy1jW8ohmVl35A9BqT57HpCnJz6H
 ttP+634RpDmKwCHYo+tJT3VYhKH5pOi7ScDUJPa5Vcaqc6WOgT56/xSvxPWv5SQp/2+TsCOOe
 YMqIbm2UwTskJlSOMI72+cmdPr+mFZomb7+1H5hjHOuj6HNO9PLZ7KLPCjgs+bJoYdqWKCXFO
 oAvSVUClMcvqPYvrqNSGkawmqmMsocU5kEZQGQV8/+FbJMXd+iN3AyE4T2iZQrk76Lbci7NCc
 U4jzy012goNB6UshKCU1nzNVTz2E1LKl7rD8liiurZhA7iCl4VsKQEMOSuS557ulSbEkt+thf
 sHP2x/MvCyoZiGz5M2N2lUQhAX1hz1I3NDvqZ7pT1wef7kU8blXu2l61NyozCxE59CEaM6fNv
 MakRtMJYuEDJbktoFgqDV2ycF6ZejToGYzbs6Qj86pA/GACn7UrBO5Uup/i/sqiz9Axo6UzW+
 6CAa68o34dGq7Dc9F0mA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These drivers implement the HDIO_GET_IDENTITY and CDROMVOLREAD ioctl
commands, which are compatible between 32-bit and 64-bit user space and
traditionally handled by compat_blkdev_driver_ioctl().

As a prerequisite to removing that function, make both drivers use
blkdev_compat_ptr_ioctl() as their .compat_ioctl callback.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/um/drivers/ubd_kern.c | 1 +
 drivers/block/aoe/aoeblk.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 6627d7c30f37..582eb5b1f09b 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -113,6 +113,7 @@ static const struct block_device_operations ubd_blops = {
         .open		= ubd_open,
         .release	= ubd_release,
         .ioctl		= ubd_ioctl,
+        .compat_ioctl	= blkdev_compat_ptr_ioctl,
 	.getgeo		= ubd_getgeo,
 };
 
diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index bd19f8af950b..7b32fb673375 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -329,6 +329,7 @@ static const struct block_device_operations aoe_bdops = {
 	.open = aoeblk_open,
 	.release = aoeblk_release,
 	.ioctl = aoeblk_ioctl,
+	.compat_ioctl = blkdev_compat_ptr_ioctl,
 	.getgeo = aoeblk_getgeo,
 	.owner = THIS_MODULE,
 };
-- 
2.20.0

