Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B53751C16A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 15:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380256AbiEENy5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 09:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358988AbiEENyx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 09:54:53 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C938557145
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 May 2022 06:51:12 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220505135111euoutp025438d296648f837ba0ca33919f508666~sOcKp-RTx0099100991euoutp02Q
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 May 2022 13:51:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220505135111euoutp025438d296648f837ba0ca33919f508666~sOcKp-RTx0099100991euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651758671;
        bh=I6AyG+zKNeMaILZF7R/I3A5VoGI+O7z0EZ5WLMlZFWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sJFPG+22dFxs08m9XBm4DNVS1gcwy3rTAnQCb/prAEpUe8mMEUUHvh4ovjReVIq9J
         YYP1E/RAfEMrShXzX0snffQnd3l7a5ey99/SPnHvQT50xwS2UHJcZ1waL76a+g+xZ5
         sE3zbZoRL9UKSd60Fbc5OFafiLtCcsgQEEbIbAME=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220505135109eucas1p12733aa50a44f0279ae2073d2c31ece8b~sOcJBDU_i2600826008eucas1p1L;
        Thu,  5 May 2022 13:51:09 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 6F.FC.10009.D46D3726; Thu,  5
        May 2022 14:51:09 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220505135109eucas1p168fb7625ef67de5a1f98520cdd29311e~sOcIiRC_k0188401884eucas1p1d;
        Thu,  5 May 2022 13:51:09 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220505135109eusmtrp134d7d24a60aa807d7548ab994f7b26b0~sOcIgDUsR1310613106eusmtrp1e;
        Thu,  5 May 2022 13:51:09 +0000 (GMT)
X-AuditID: cbfec7f2-e7fff70000002719-48-6273d64d3b0e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B5.03.09522.D46D3726; Thu,  5
        May 2022 14:51:09 +0100 (BST)
Received: from localhost (unknown [106.210.248.170]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220505135108eusmtip1ef50c2abc61dca028faab13b23861be3~sOcIOYZxD0087500875eusmtip1N;
        Thu,  5 May 2022 13:51:08 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk, hch@lst.de, damien.lemoal@opensource.wdc.com,
        dsterba@suse.com, jaegeuk@kernel.org, bvanassche@acm.org,
        hare@suse.de
Cc:     jonathan.derrick@linux.dev, jiangbo.365@bytedance.com,
        matias.bjorling@wdc.com, gost.dev@samsung.com, pankydev8@gmail.com,
        Pankaj Raghav <p.raghav@samsung.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/11] zonefs: allow non power of 2 zoned devices
Date:   Thu,  5 May 2022 15:47:09 +0200
Message-Id: <20220505134710.132630-10-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505134710.132630-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsWy7djPc7q+14qTDLb+0rVYfbefzWLah5/M
        Fr/Pnme2uPCjkcni5oGdTBZ7Fk1isli5+iiTxZP1s5gteg58YLFY2fKQ2eLhl1ssFnv2nmSx
        uLxrDpvFhLavzBY3JjxltJh4fDOrxeelLewWa24+ZXEQ8rh8xdvj34k1bB47Z91l97h8ttRj
        06pONo+FDVOZPXbfbACKt95n9ejbsorRY/2Wqywem09Xe3zeJOfRfqCbKYA3issmJTUnsyy1
        SN8ugStj05VOloLtAhWr2tayNDCe5e1i5OSQEDCRuLPmIXsXIxeHkMAKRomlK88xQzhfGCW+
        T/nPBuF8ZpQ4vqEZyOEAa+loioeILweKX9oNVfSSUeJrbyc7SBGbgJZEYyfYWBGBbkaJs81v
        WEAcZoEbTBLzL39iB1kuLOAi8XLPIkYQm0VAVaJl3gIWEJtXwFriRssBVogD5SVmXvoOVs8J
        FJ/T+ZAVokZQ4uTMJ2D1zEA1zVtng90tIbCfU2LPn4VMEM0uEpd6j0INEpZ4dXwLO4QtI3F6
        cg8LhF0t8fTGb6jmFkaJ/p3rof60lug7kwNiMgtoSqzfpQ8RdZRYfFgawuSTuPFWEOICPolJ
        26YzQ4R5JTrahCBmK0ns/PkEaqeExOWmOVA7PSSOnprJNoFRcRaSX2Yh+WUWwtoFjMyrGMVT
        S4tz01OLDfNSy/WKE3OLS/PS9ZLzczcxAhPk6X/HP+1gnPvqo94hRiYOxkOMEhzMSiK8zksL
        koR4UxIrq1KL8uOLSnNSiw8xSnOwKInzJmduSBQSSE8sSc1OTS1ILYLJMnFwSjUwTVLRYzGu
        enKmU3Ly7esTL0+3fKrA8mvJoizTm8pzZ9kqif3Ne3ljw/5awbPRPMUT6uvj/73cZZN8OOCm
        1aFIEe7qXOsd9kZq/taMb1NORGmnVP2vye/e77nz3HathisXns6WcDefo/5i38YTLyMyXsoH
        9RnvMzFfPWmxif+Eu+U5Z9PX+ExS1J6+o+JlstV5hYAC38YlzAEnFNMFeK572W1+/vSByIp9
        VnvaHfYENTULTuup4LW4KXht24WtZqW9N+qON5uWaPVOeGMpHyiveUWuQUPu4acn555IsSmp
        /12ZvdDGW/qjYqTHQlazWww7MvRiI0+W5gpeaJ5yUCovpGXNXeM3vl97dbf98Z2mxFKckWio
        xVxUnAgAmH9KUP8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsVy+t/xu7q+14qTDL4t47ZYfbefzWLah5/M
        Fr/Pnme2uPCjkcni5oGdTBZ7Fk1isli5+iiTxZP1s5gteg58YLFY2fKQ2eLhl1ssFnv2nmSx
        uLxrDpvFhLavzBY3JjxltJh4fDOrxeelLewWa24+ZXEQ8rh8xdvj34k1bB47Z91l97h8ttRj
        06pONo+FDVOZPXbfbACKt95n9ejbsorRY/2Wqywem09Xe3zeJOfRfqCbKYA3Ss+mKL+0JFUh
        I7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS9j05VOloLtAhWr2tay
        NDCe5e1i5OCQEDCR6GiK72Lk4hASWMoocXljD2MXIydQXELi9sImKFtY4s+1LjaIoueMEg/W
        f2YHaWYT0JJo7GQHiYsITGWUuLD9AguIwyzwhElixY9GNpBuYQEXiZd7FoFNYhFQlWiZt4AF
        xOYVsJa40XKAFWKDvMTMS9/ZQWxOoPiczodgcSEBK4mJD9+xQdQLSpyc+QSslxmovnnrbOYJ
        jAKzkKRmIUktYGRaxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJERjN24793LyDcd6rj3qHGJk4
        GA8xSnAwK4nwOi8tSBLiTUmsrEotyo8vKs1JLT7EaAp090RmKdHkfGA6ySuJNzQzMDU0MbM0
        MLU0M1YS5/Us6EgUEkhPLEnNTk0tSC2C6WPi4JRqYFq05tjceouiW0E8gT8KhB3LLnUcNnv6
        57TXQS7uoLij29UPnzwjeP/L80Uh+x5bBWaYyuyTX1TPuGveWSGLX1fTmFu+nToSEDhr9yPX
        jBrOItmGf/c5/tjYM1StdOKY+E7viT43s9Z13mm3T/37naATsqeRV7Pw5fSNsyq7JCy9gl6x
        x+h8l9yz4NeZE04825PdfQ+eLZ9twZvgck07reZv+PIoz3ylsN3LV60unRtp1DbzxbGPuk1R
        WSY/hRSiHui4tLbM1tN7v/5SIJ/B3lsG03rN/cpsTtkyqnw44vUnwcE8Y7G2g22FQPmLHPbb
        RXOm3dKLtbtZ+H2vVqu9RWfO8vvG/0V0LreoL1wao8RSnJFoqMVcVJwIAG+/PttvAwAA
X-CMS-MailID: 20220505135109eucas1p168fb7625ef67de5a1f98520cdd29311e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220505135109eucas1p168fb7625ef67de5a1f98520cdd29311e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220505135109eucas1p168fb7625ef67de5a1f98520cdd29311e
References: <20220505134710.132630-1-p.raghav@samsung.com>
        <CGME20220505135109eucas1p168fb7625ef67de5a1f98520cdd29311e@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The zone size shift variable is useful only if the zone sizes are known
to be power of 2. Remove that variable and use generic helpers from
block layer to calculate zone index in zonefs.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/zonefs/super.c  | 6 ++----
 fs/zonefs/zonefs.h | 1 -
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 978a35c45..50a1e000c 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -451,10 +451,9 @@ static void __zonefs_io_error(struct inode *inode, bool write)
 {
 	struct zonefs_inode_info *zi = ZONEFS_I(inode);
 	struct super_block *sb = inode->i_sb;
-	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
 	unsigned int noio_flag;
 	unsigned int nr_zones =
-		zi->i_zone_size >> (sbi->s_zone_sectors_shift + SECTOR_SHIFT);
+		bdev_zone_no(sb->s_bdev, zi->i_zone_size >> SECTOR_SHIFT);
 	struct zonefs_ioerr_data err = {
 		.inode = inode,
 		.write = write,
@@ -1375,7 +1374,7 @@ static int zonefs_init_file_inode(struct inode *inode, struct blk_zone *zone,
 	struct zonefs_inode_info *zi = ZONEFS_I(inode);
 	int ret;
 
-	inode->i_ino = zone->start >> sbi->s_zone_sectors_shift;
+	inode->i_ino = bdev_zone_no(sb->s_bdev, zone->start);
 	inode->i_mode = S_IFREG | sbi->s_perm;
 
 	zi->i_ztype = type;
@@ -1752,7 +1751,6 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
 	 * interface constraints.
 	 */
 	sb_set_blocksize(sb, bdev_zone_write_granularity(sb->s_bdev));
-	sbi->s_zone_sectors_shift = ilog2(bdev_zone_sectors(sb->s_bdev));
 	sbi->s_uid = GLOBAL_ROOT_UID;
 	sbi->s_gid = GLOBAL_ROOT_GID;
 	sbi->s_perm = 0640;
diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h
index 4b3de66c3..39895195c 100644
--- a/fs/zonefs/zonefs.h
+++ b/fs/zonefs/zonefs.h
@@ -177,7 +177,6 @@ struct zonefs_sb_info {
 	kgid_t			s_gid;
 	umode_t			s_perm;
 	uuid_t			s_uuid;
-	unsigned int		s_zone_sectors_shift;
 
 	unsigned int		s_nr_files[ZONEFS_ZTYPE_MAX];
 
-- 
2.25.1

