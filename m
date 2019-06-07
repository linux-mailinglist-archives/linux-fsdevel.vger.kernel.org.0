Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3661038B1C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 15:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbfFGNL6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 09:11:58 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:53172 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729427AbfFGNL4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 09:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559913116; x=1591449116;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=34wqI78X3YG1tFhgA4iF1bvmBfVutYvEGOanZcd3z6c=;
  b=WVB6fdKLv21M/9yn5bLblyC/IzuLUrXFc00Mxcm71dAHEcszZgUxnT08
   7ExgwnstcCP+AAYugelUnYyPcc8PBIfmrLjDiSe9pBtkYOYRKeyDKTjpt
   gSzdRYCWC75+0NDo1cEiiodY4iWerModERJwWztd50o86tJliBwmk2JKu
   88VvpaCl5/JZZHahuc47L2/s8DiY8PZ9PF2LzAaOlP7A1RSQUR048OdJ8
   gDKWohwSc+xUupT5ZFHgs/fcnxPc5QxXEm7T/lzlqgI5ujPXfLC4wfwsk
   yzkYVn9CvmZYtLa2oQ9tDt/1X1HodW8E2yKPZwFQfkEevE/EgBl4jMVpG
   g==;
X-IronPort-AV: E=Sophos;i="5.63,563,1557158400"; 
   d="scan'208";a="110027840"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 21:11:56 +0800
IronPort-SDR: mQHflmnJrCvmb2Ff+xpTb7R15qem5brXecU7yy8KtETCIT0dRThwcJ8TmCRHIrf3Lqd2JEqwKW
 +MH+8af10NrNvlkGnd4ifubhswrB50qyKyV7RaseHJBIvcBRWiN5WVSyZRXsmIeMG18+NTSaJK
 B7X5LdxYEKpZ3usKExCdyd9MTbFGNlbwWTQg3nZOF/pEYkBZGB5nK7N0sJtO0GhaYXb5tVfANA
 ayxcxVehA31+oLsEhhGuNhtlOP8Uae8hOtHMiejlUg9ocK/EMuXN1mCkksUuu7Gi6M+Oa78L8J
 cxjJLcZG9HgDtz8Or6AijL8v
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 07 Jun 2019 05:49:13 -0700
IronPort-SDR: wHtmOKsPawBuLEPy2aJrCCD3lu2JG3Ie90aB6xkYjS12NfUo2EliNollxKWvghp6NrQD/0Oyhu
 NhcLnJQCH3IMdvgGXXnKAp+KaVPzVPutYH/sO19tj3ILP2++7HMea8Q0vRqP8nr/cMUa4Xc9d9
 rsABvFAXonXcYklBAIkAAjuq30HzqSNfkPe6+4e+OttnhHD0/VXg11hT9VMPMWwt8mJQZhBfo/
 187gZr0gaY6yqNWlYDTxBYKcVMy+TrJs4PEToFtObDD7K1raTTMdncXMz/MvIA0viHIuFgAfSR
 w4k=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2019 06:11:54 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 19/19] btrfs: enable to mount HMZONED incompat flag
Date:   Fri,  7 Jun 2019 22:10:25 +0900
Message-Id: <20190607131025.31996-20-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607131025.31996-1-naohiro.aota@wdc.com>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This final patch adds the HMZONED incompat flag to
BTRFS_FEATURE_INCOMPAT_SUPP and enables btrfs to mount HMZONED flagged file
system.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/ctree.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index a0be2b96117a..b30af9bbf22f 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -285,7 +285,8 @@ struct btrfs_super_block {
 	 BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF |		\
 	 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |	\
 	 BTRFS_FEATURE_INCOMPAT_NO_HOLES	|	\
-	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID)
+	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID	|	\
+	 BTRFS_FEATURE_INCOMPAT_HMZONED)
 
 #define BTRFS_FEATURE_INCOMPAT_SAFE_SET			\
 	(BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF)
-- 
2.21.0

