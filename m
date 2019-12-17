Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9268A1239B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 23:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfLQWRf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 17:17:35 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:43261 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfLQWRf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 17:17:35 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Ma1sQ-1iDauk3LgC-00W0Di; Tue, 17 Dec 2019 23:17:22 +0100
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
Subject: [PATCH v2 01/27] pktcdvd: fix regression on 64-bit architectures
Date:   Tue, 17 Dec 2019 23:16:42 +0100
Message-Id: <20191217221708.3730997-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191217221708.3730997-1-arnd@arndb.de>
References: <20191217221708.3730997-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QMSOPeED49s201CoV/Q/8aHXf5yX2aoiUQkXnT4FSnobAR1P+ZS
 AjHcXURC1TcBRJslcM0go+hX9iCUkxwOPBvAe3WaNg3lqMqQFjSIfMlrLToOT1N/tCw6hO2
 zOwEghWIgnPEe89YRhjL6pmHZYOlIxHRc6VqAA5VLAnaxIqc9epmlzoZE2W28a+I11/E1T8
 eN7v7rzsLAL52VPep87VA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:q3r9egq/gLI=:eaRnFNzwV13WGZeABhyoCa
 kG6pSxM3N1jBbw3ItFcU5G6gCoLl6A20jd6nWRhp35jlLNyqBxWhRYZ8QIRjtnoL5Qk8vjNQm
 hDtQSpTngcgQO89psiQHtXxIsxlggGZOlPf2yawlOrfLb/SvakZpuY7BQCrV0WRG0LTyw4gvy
 afJx3VGKecnLAuvMQaV22cGRGlyz9pZfPQG0ygZVSYZV1FiyYh5ZQSX+mer5k6mfvHmkUn+3T
 YzHfUa+OyIC/Mamfdnu/bjuJG52WXGYFay1onrbGSNYms13077RIudBaIaWiHWBIh+3LJAIHS
 pKIe4/iNUYIIiYdcFx/p/jkg0JYMmWMKOB++MhNCdcsCKvcboEVQyzF2580ni2QV9L79sfSpp
 f3M4Cg7b9wWO9696JpTfpFoSCF7L6Ojt2W5tFp+nAn4i7ZHtyNgKpE2PxoI9zyMdm8/88wo5o
 Ir0gAKQcWJCyrIh461fpNETWT9UdaCZPt5J/vI3O9R4hzGIzm9nS4z55DqcTBmqWc8KQxS+5u
 xpUha18j3X3Tvf/Ckcq0vJ7SnSm4QOI1m9Hk7Roul2tz5+HL9bXEaJ6O4aBACvZiBAK0NQfO2
 55iUqzA2Do9ZUxr07cSZOMz6j2VB80hXlCcQKu0g8HWsp73LJmFQ5VlD7Vm3DZ9R1M+w72zX2
 bhQFI10kiVC9sGNSOIemMXU5lYjvDynxia/KafBznmGNhDIkQ5P8QyElg37HCZVjQuxzmKiw9
 5U/sNmQG2oheV7assA7oI62z+vjrg2xZC6KBoiGsoM1iB4lNjM9ql5Y7ZR9Ulz5ZtDhCqMlxd
 ihoE9fwLKdX3XySzRDbM3JoPdOb04RmsNAiVkkeIasEjWfw6dgd8mdLqt5JWldxd3/cM/tc61
 af5LnUUHqowZxtUs87eg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The support for the compat ioctl did not actually do what it was
supposed to do because of a typo, instead it broke native support for
CDROM_LAST_WRITTEN and CDROM_SEND_PACKET on all architectures with
CONFIG_COMPAT enabled.

Fixes: 1b114b0817cc ("pktcdvd: add compat_ioctl handler")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
----
Please apply for v5.5, I just noticed the regression while
rebasing some of the patches I created on top.
---
 drivers/block/pktcdvd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index ee67bf929fac..861fc65a1b75 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2707,7 +2707,7 @@ static const struct block_device_operations pktcdvd_ops = {
 	.release =		pkt_close,
 	.ioctl =		pkt_ioctl,
 #ifdef CONFIG_COMPAT
-	.ioctl =		pkt_compat_ioctl,
+	.compat_ioctl =		pkt_compat_ioctl,
 #endif
 	.check_events =		pkt_check_events,
 };
-- 
2.20.0

