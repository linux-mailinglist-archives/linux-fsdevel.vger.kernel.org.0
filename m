Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001A4528B5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 18:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343946AbiEPQzF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 12:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343957AbiEPQyg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 12:54:36 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9533833A08
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 09:54:35 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220516165434euoutp0210a28f8851b37562c465793d342d93dc~vpCa1Ala42798227982euoutp02O
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 16:54:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220516165434euoutp0210a28f8851b37562c465793d342d93dc~vpCa1Ala42798227982euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652720074;
        bh=5TXl26FaMqHEmVpoCDcYHu+PuV1m41LmMinlDGGQ4l4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=amSXskJ08T0po78lLobDG/9GeM4Mjy4BvuB11ClYKzVzKKDHCPu4tLSPbcwgZHKkd
         CCKvqp6EvOROkxy3gmSGlBqTN4nzMO9TM5uWbhEU1kRMkvN7rWWLQHFchW49jEvBW8
         0fh3yBjpmaDL9qk5aycOQmr23bkW/cPHtmp7DsVU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220516165432eucas1p28fa728357342aadebf5be26269ea5b40~vpCZc4W501887918879eucas1p2n;
        Mon, 16 May 2022 16:54:32 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id A2.4A.09887.8C182826; Mon, 16
        May 2022 17:54:32 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220516165432eucas1p2e1ea74d44738e44745f49e37b6b9e503~vpCYwJZGZ0200602006eucas1p2R;
        Mon, 16 May 2022 16:54:32 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220516165432eusmtrp1057bb593a1a030e8e478dd59b33a54e3~vpCYvYe2E2961829618eusmtrp1Q;
        Mon, 16 May 2022 16:54:32 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-43-628281c8fad5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 02.99.09522.8C182826; Mon, 16
        May 2022 17:54:32 +0100 (BST)
Received: from localhost (unknown [106.210.248.7]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220516165431eusmtip2bac363d67d5edcb5d23957c2ace71c86~vpCYcv3fi0272502725eusmtip2v;
        Mon, 16 May 2022 16:54:31 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
        pankydev8@gmail.com, dsterba@suse.com, hch@lst.de
Cc:     linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, jiangbo.365@bytedance.com,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        p.raghav@samsung.com, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v4 10/13] zonefs: allow non power of 2 zoned devices
Date:   Mon, 16 May 2022 18:54:13 +0200
Message-Id: <20220516165416.171196-11-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516165416.171196-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAKsWRmVeSWpSXmKPExsWy7djP87onGpuSDNY+MbZYfbefzeL32fPM
        FnvfzWa1uPCjkcni5oGdTBYrVx9lsug58IHFYu8tbYtLj1ewW+zZe5LF4vKuOWwW85c9Zbe4
        MeEpo8XnpS3sFmtuPmVx4Pf4d2INm8fOWXfZPS6fLfXYtKqTzWPzknqP3TcbgMKt91k93u+7
        yubRt2UVo8f6LVdZPD5vkgvgjuKySUnNySxLLdK3S+DKOPvgCFPBdoGK6ZtOMDcwnuXtYuTk
        kBAwkbg2/QhbFyMXh5DACkaJNVP72SGcL4wSHR9nQTmfGSV+TtzMDtPS/fcgE0RiOaPE5m3L
        mEESQgLPGSV+vZToYuTgYBPQkmjsBKsXEciSmHbiISNIPbPAYiaJlXsms4AkhAVcJF5sPcsG
        YrMIqEoc+riICaSXV8Ba4tl0O4hd8hIzL31nBwlzAoVXd3GDhHkFBCVOznwCNoUZqKR562xm
        kPESAvM5Jeb8aWKG6HWR2HFvPyOELSzx6vgWqPtlJE5P7mGBsKslnt74DdXcwijRv3M9G8gy
        CaBlfWdyQExmAU2J9bv0IcodJb6fvsUEUcEnceOtIMQJfBKTtk1nhgjzSnS0CUFUK0ns/PkE
        aqmExOWmOSwQJR4SE78oTmBUnIXkl1lIfpmFsHYBI/MqRvHU0uLc9NRio7zUcr3ixNzi0rx0
        veT83E2MwER3+t/xLzsYl7/6qHeIkYmD8RCjBAezkgivQUVDkhBvSmJlVWpRfnxRaU5q8SFG
        aQ4WJXHe5MwNiUIC6YklqdmpqQWpRTBZJg5OqQYm78zlAn+e6wUbhnYXpJxsbGOen3uwIXjh
        3NkHRRQnR3FW1S3YZ7VO4fIBsScOL6a/ahCcveJVp0HF9Efn/q2d5XL8P4t20ZtdWVfYTa9W
        +on897i48uHuZU8v/Pgv6p6b1xcoqvOo+FeIa5vftN/q32UYZrPrmR4umrgwMoVL8ZOqwood
        NRsChP/2dSoJOoWWnf3dlRb74rlp+OXmZ7vOqNftmHNoVw/zBafdSqvtP5z9nNg927CsgdUg
        ZYuXNMeE6Px77zbonupobDP8N7H036c1b1b4Vzt3POP+ldk7haNI6spKn+v16358n6p2/OtV
        xrSsPT5bfu5q2f/kQZKxvtVUo7ria5X6AatYz6ybocRSnJFoqMVcVJwIAGjJCBjjAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsVy+t/xe7onGpuSDM4dZrdYfbefzeL32fPM
        FnvfzWa1uPCjkcni5oGdTBYrVx9lsug58IHFYu8tbYtLj1ewW+zZe5LF4vKuOWwW85c9Zbe4
        MeEpo8XnpS3sFmtuPmVx4Pf4d2INm8fOWXfZPS6fLfXYtKqTzWPzknqP3TcbgMKt91k93u+7
        yubRt2UVo8f6LVdZPD5vkgvgjtKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV
        0rezSUnNySxLLdK3S9DLOPvgCFPBdoGK6ZtOMDcwnuXtYuTkkBAwkej+e5Cpi5GLQ0hgKaNE
        46XfrBAJCYnbC5sYIWxhiT/Xutggip4ySjz++Ji5i5GDg01AS6Kxkx2kRkSgQGJO/xYWkBpm
        gbVMEq9/vAdrFhZwkXix9SwbiM0ioCpx6OMiJpBeXgFriWfT7SDmy0vMvPSdHSTMCRRe3cUN
        EhYSsJL4+uQW2HheAUGJkzOfsIDYzEDlzVtnM09gFJiFJDULSWoBI9MqRpHU0uLc9NxiQ73i
        xNzi0rx0veT83E2MwLjcduzn5h2M81591DvEyMTBeIhRgoNZSYTXoKIhSYg3JbGyKrUoP76o
        NCe1+BCjKdDVE5mlRJPzgYkhryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQim
        j4mDU6qBSWyaspCrxJeaZzVzlFm6Fh7e6Puu9qWQTs+Hg/OqjH46mCpnut9I+HXC5H/apc//
        t+9RvtR6Iadwe/DxZl32YDmZm49OTBHayb52r+ihZTdu2e1KPqCtzmuo8v5CaOBehYTomA0P
        T3Qezz/lN/fi7dLVmysCUrL/GlYUTpc9saBwx4cD2xrq0ws+R3XNCPSqi/Mp0PY6G8Z3J6BU
        euoR51se3Wzxe9JE6qYVl+s0vbNrZBD0sjDRXfaPYZp6pnpYRdfD2gV15/8cVTbQ93p31mmr
        /umFHLNd/st+eXChVsnI/R9X762/h9sWH3X0VDvzOP+s+iHOmbckJJ6rmGqmZmf4uu9e5hO5
        UO1dkESNEktxRqKhFnNRcSIAA7FWCVQDAAA=
X-CMS-MailID: 20220516165432eucas1p2e1ea74d44738e44745f49e37b6b9e503
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220516165432eucas1p2e1ea74d44738e44745f49e37b6b9e503
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220516165432eucas1p2e1ea74d44738e44745f49e37b6b9e503
References: <20220516165416.171196-1-p.raghav@samsung.com>
        <CGME20220516165432eucas1p2e1ea74d44738e44745f49e37b6b9e503@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 57ca775f5..e302c889a 100644
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

