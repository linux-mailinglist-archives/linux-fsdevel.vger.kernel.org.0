Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A104412399A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 23:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbfLQWTW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 17:19:22 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:34075 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfLQWTV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 17:19:21 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M8QJq-1icvIw1gYq-004PCA; Tue, 17 Dec 2019 23:17:30 +0100
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
Subject: [PATCH v2 16/27] compat_ioctl: bsg: add handler
Date:   Tue, 17 Dec 2019 23:16:57 +0100
Message-Id: <20191217221708.3730997-17-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191217221708.3730997-1-arnd@arndb.de>
References: <20191217221708.3730997-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:CcW0OER95wDXq0YetFdqoTdTEnAWcPISLF3QDQtri9hrxSFvPXG
 fBdpTLjhv0iKK2rBmn4jyDnjys1/pVoz09rAJLkDNE6wj+fddgYodj6iKfELZj3+/PdHrcO
 tw2Gy4JzU2ZMgdpd+jxtzid1wBePiv+WmdPlrT6nYzzMvTt7km/aGxMnd97UOOoejnfCoWW
 3LytDdHjU3oriRUGkNmhg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Yj2mPlnFp94=:fKjchY6xasw3iPgAiTTlST
 y2fJLfy8whAQA/X2JktR72kckWBi+i+GEgdIL1mIGmyUXnZeEfx3jWleiclTjPFTEBCBFDJG1
 LoMm7vit2smCIWZGk0nKs7UkMSSPS6mvR65hs5LpSANX+RaU3V7ZeKeA2idWlUnrHmUdvvibW
 +LQWNNSDTYtRkk/PNlXcEA6YkgeLx1SHpOD+VHOB5cmlFFpYGyeM3RLnFFo619lx1X5D4ussB
 uqqdu+Nw6bQm+WKgAQewdSLPTnLm4UDHvOeL4FglMwkbnotBzQ5uEclxuKlWcJqgGkCI3Wlsa
 YlrYI4rnIsbPU1T3/dxGG+MXkafh0q8q/Q3x/aJPHzic/vq6ILaZ5oqEB3Jpjm7qZlXfvjiLC
 KRicjRF7eptVnI8dEu+/dRlm2wIKp5QbMekshiCZ6dMt5Hu70cie3YtrGyG/l3nsFgAOcgEQD
 3I9TUzjmYpQ6XfZYgGk1k5Tyv6UhDeccLVyIDIGneWMxwg/8JRCDHiU3nVKTTX2x9JlepYfYA
 pn44I3n4hpd2M7d/Mozo5exhR/zqgs/OqS5dv2B5egGWjpFEm0cSNddo4KOjqs1VMhFN9IWci
 rJnQWp8uhzgSp7R2NGiD+cpQpiJDTzFkNYFo+mUeQdwyqECBf/UxeyIC6fgkRO8AbH1jCnRuq
 Bdk4xAS8wttqqA5ORCTI+u4uCS6TvUopNrl7ez2lDq2Ytoqn9wweQHdfiSMwxQaroKFRt2JO2
 sz7QiNH9ux8S3D0ZAMAZXmZ7xZPAQNAqU4s4Spd0Du7vRE8GYvEvbtl0FQCX8LSuIZukuOnaC
 eAGqMMEkqmSN+sY8xwVupa0n2qbWj21AbUF4pNA9Bw1h4CY3Utti2W04Du/wCUTADSvQkO5Jz
 Eo+g0fwG0WoTSGpv4V5w==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

bsg_ioctl() calls into scsi_cmd_ioctl() for a couple of generic commands
and relies on fs/compat_ioctl.c to handle it correctly in compat mode.

Adding a private compat_ioctl() handler avoids that round-trip and lets
us get rid of the generic emulation once this is done.

Note that bsg implements an SG_IO command that is different from the
other drivers and does not need emulation.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 block/bsg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bsg.c b/block/bsg.c
index 833c44b3d458..d7bae94b64d9 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -382,6 +382,7 @@ static const struct file_operations bsg_fops = {
 	.open		=	bsg_open,
 	.release	=	bsg_release,
 	.unlocked_ioctl	=	bsg_ioctl,
+	.compat_ioctl	=	compat_ptr_ioctl,
 	.owner		=	THIS_MODULE,
 	.llseek		=	default_llseek,
 };
-- 
2.20.0

