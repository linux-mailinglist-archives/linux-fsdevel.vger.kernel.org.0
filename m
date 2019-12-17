Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBFA71239E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 23:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfLQWWl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 17:22:41 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:43763 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfLQWWk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 17:22:40 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N4yyQ-1hiwzo35zY-010xJi; Tue, 17 Dec 2019 23:17:24 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux-doc@vger.kernel.org, corbet@lwn.net, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v2 04/27] compat_ioctl: block: handle add zone open, close and finish ioctl
Date:   Tue, 17 Dec 2019 23:16:45 +0100
Message-Id: <20191217221708.3730997-5-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191217221708.3730997-1-arnd@arndb.de>
References: <20191217221708.3730997-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gu/sZ8TIEZHaNMokJWZJ2X/rL2ysrVtrFNyi0SMX6prix2pGIWW
 bAPVJ8fwpN8E/mH6Nc/QBm6u/qo4Tvn5SQjEffGJQQ0pqczFhRJkII1FGsCprkk0Bm9Mp7S
 bPZtEphmmlcYdUTV6MyI0eM1M+OkiwJopBU1dcguNoVzj0J/NcGJldmWoOE4st0Vk3Wc+EZ
 AsAGp/sInmVO2GHX+D+bg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PZzd4xrTh1k=:O4HFuv5nV8diiq/ph5n5Gr
 qf4n+7oCpROKsWo1y2SYeW91P85f6Qflgw/6lY7L1mr97wtEbH6FSNZD5YVHljnyqEpuEge/x
 igMySXnwDbTKop7DCYDSAsYWFVUMr82xvXBwq9CPkuIyH3mWCbap4y+gTZtGuR5UVlO9XD0DX
 csBbpzz/fdeVdn18z9BVw7IF0cP3xbNq9ATsOs4oO2D23gSuRlETFGY32yYd+mld9NAAfFFID
 VntMuQCrGbwBsICwhCOcBfGmUQFGHlG8hOaNOHQPQNgbo2l5f0h0uSF0wQCr3UQG1a7jLq0zP
 E8hunDXra3WNSNh+Fb48UCaYoj1hqmAylf69bDnJJNO1AMGd4ydVAj1sGBqKEjliixmMVBQ6D
 aybJCJCv/RJiJMT8Lvh3jgCFKX9VURq5G/vMOvSArwRi7Bp1/IQCuAkhvIXPQKed4dFIMy7qj
 GGZ0FmDM1X/sOr2EDL572pMUoPN8lDpApPfjkar0u31u3tzsmWWpPIIw3DAb9bMOOCIH101zL
 /z6ilD/gTLCeVqMjNQXZH34TDDsMp8sjlHLXGBmC0jdp8OyQsWNpOL4nOZFdbxPq/nbXE+97f
 NeW73c8z807bRs9C15zVqFwVrTZHPWYl9fq20EOQG8FStNxQx7028GQpWMPvqxFiZPcpOyUxf
 a4r8+swDX3SaUnxU5fiwKyqNrx5bfGZ/kl4iNtSz8xpXT68QSSY1JZ4chjAiHdtk0/k+lk1iP
 +s8EGZZJVn+Hqf8F/NdDYJZM0dpzajmFia1hLchlr6J7nLCK+yEzAdNmhVGQwLPV1hC1U1szV
 4PY/3xiTfZkiaDLxyvlIrB5l+LE7JEd/x7p0JTG5Ze7QPa1vX/AeCbYOtkhpJYT5ZwM0lqEUY
 C1MhosgOmGZqGHhJZDIw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These were added to blkdev_ioctl() in linux-5.5 but not
blkdev_compat_ioctl, so add them now.

Fixes: e876df1fe0ad ("block: add zone open, close and finish ioctl support")
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 block/compat_ioctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/compat_ioctl.c b/block/compat_ioctl.c
index f5c1140b8624..5b13e344229c 100644
--- a/block/compat_ioctl.c
+++ b/block/compat_ioctl.c
@@ -356,6 +356,9 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 	case BLKRRPART:
 	case BLKREPORTZONE:
 	case BLKRESETZONE:
+	case BLKOPENZONE:
+	case BLKCLOSEZONE:
+	case BLKFINISHZONE:
 	case BLKGETZONESZ:
 	case BLKGETNRZONES:
 		return blkdev_ioctl(bdev, mode, cmd,
-- 
2.20.0

