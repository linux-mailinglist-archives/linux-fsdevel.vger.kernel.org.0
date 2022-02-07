Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD7D4AC20B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Feb 2022 15:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387301AbiBGOxq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Feb 2022 09:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392409AbiBGOa3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:30:29 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D22C0401C4
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Feb 2022 06:30:27 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220207142315epoutp0216f1262089402f4fd1b3b2ad60595c9d~RhwVWdRuv0484404844epoutp021
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Feb 2022 14:23:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220207142315epoutp0216f1262089402f4fd1b3b2ad60595c9d~RhwVWdRuv0484404844epoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644243796;
        bh=ngGeLKh/cNFBqZ2ebzcJUg1MB4xMAkdY6dg48NrWGfk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LX2obe20vhqACGCvai45rIm/5n4ZJuTANSLsjOUud5O65k5c2HZKeXyBQhhewR8Jl
         sKvRYex+TXss9JKeDLrJTtky4TpI71j1jcDEuHUkkVYKQo0m5qUBnhq/kpNmzVI9MJ
         02BaX8cdnqXKiUvo9Y6VUlIm7Re5bXfKNWMqR+qk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220207142315epcas5p2be6dc0621dddd26ec2b31fe21213bdac~RhwUdb3uA2564925649epcas5p2B;
        Mon,  7 Feb 2022 14:23:15 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JspJt0blLz4x9Pr; Mon,  7 Feb
        2022 14:23:10 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6B.5F.06423.D4B21026; Mon,  7 Feb 2022 23:23:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220207141953epcas5p32ccc3c0bbe642cea074edefcc32302a5~RhtYhzyQR0472404724epcas5p3T;
        Mon,  7 Feb 2022 14:19:53 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220207141953epsmtrp2942ef1027f5892f95340e5a0f3d86c36~RhtYgd2Ov0696106961epsmtrp2Y;
        Mon,  7 Feb 2022 14:19:53 +0000 (GMT)
X-AuditID: b6c32a49-b13ff70000001917-5b-62012b4d1175
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        9E.43.08738.88A21026; Mon,  7 Feb 2022 23:19:53 +0900 (KST)
Received: from test-zns.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220207141949epsmtip13c85572436db3ea86918946d1d20c13b~RhtUwTRkj1635016350epsmtip1f;
        Mon,  7 Feb 2022 14:19:49 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     mpatocka@redhat.com
Cc:     javier@javigon.com, chaitanyak@nvidia.com,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, roland@purestorage.com, hare@suse.de,
        kbusch@kernel.org, hch@lst.de, Frederick.Knight@netapp.com,
        zach.brown@ni.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, joshi.k@samsung.com, arnav.dawn@samsung.com,
        nj.shetty@samsung.com
Subject: [PATCH v2 09/10] dm: Enable copy offload for dm-linear target
Date:   Mon,  7 Feb 2022 19:43:47 +0530
Message-Id: <20220207141348.4235-10-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.30.0-rc0
In-Reply-To: <20220207141348.4235-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTZxT3u/dyW8iQO8TwSUboarYMCNg6ih8MJnFgrkOgzvHPlsmucFee
        bdeWbT4COGThIe/HGGY8nCkTCDiQDoSCYNAgYJjQMggICD6oW2HgmAiuK7Q6//udc36/75zf
        +XK4uOMvHBdunFTFKqRMIp+0IzTX3d/xCvcExwXrJQB1jq/YoPqpfBKVLa3haLFnzgYV5Zdz
        0Mj8dqQ1nrdBw0/PYGiu2YShzgtFGLpU34ehh7U/AZQ1MIyhjVkh6jP9SaKiXj1A2glP1Knt
        J1CV+j4H5Yy1kajrsRZHtTf/xVBhpg5Dtys2SKRZr8LR9bs6AtVvIJRxbo2DDN3HglzpkdFQ
        ujDdyKHTqycJemQomW6uyyLploupdPHvtYDuGE8j6W8H+3C6fPkJSY8N/orRuelGkv7r/gRB
        a2ZzOfRil46k867UAbHTJwkBsSwTwyp4rDRaFhMnlQTyQ49GfRAl8hUIvYR+aB+fJ2WS2EB+
        8GGx18G4RPOS+LyvmMRkc0rMKJX8Pe8HKGTJKpYXK1OqAvmsPCZR7iP3VjJJymSpxFvKqvyF
        AsFekZn4eULs7HIvIX9EfFN67Xs8DZjwbGDLhZQPbMmvJbOBHdeR6gBQN1qJW4JlAPUPDRxL
        sAJgy8w4eCGZGe+ySq4C2DFpxCxBBgbb/3hirnC5JOUJB0zcTYET5Qw3hjVgk4NTKwTUj1Vw
        Ngs7qIOw/9Y4sYkJ6i14x9S+he0pf7hSq8Ys3XbDmtkem01sa86vbpRZOa/D/h/mtzBOucH0
        1vNbc0NKbws1eZWERRwMF55nW53ugIabVzgW7AJXjFrSIsgB8OngNGYJygFML0gnLaz98LfO
        59imHZxyh01X91jSrrD0ViNm6bwd5q7PWye1h22V8y+nbmiqtj6zC+r/OWPFNJwoLbWxrGsU
        QE2nligAvIpXHFW84qji/9bVAK8Du1i5MknCKkVyoZT9+uVHR8uSmsHW7XgcagNTM0vevQDj
        gl4AuTjfyf6NHBPjaB/DnDjJKmRRiuREVtkLROaVF+IuO6Nl5uOTqqKEPn4CH19fXx+/d32F
        fGf7AcllxpGSMCo2gWXlrOKFDuPauqRhIl1Iw9q5BP+SywtvZg3N9wkCP102tfMGQ0Rr6oJT
        Orthl8jw/YO2x0S121aDMzJ/Dtwo7gtveDskTnx3ahbnd3RM26Xk5kUdbpyIv6hudObdFquC
        kOvZ1dH3KIe21A9Tfuz+0rTTZ2E47FG8YaLkdP01qqfsRtqlB0MOzyQU8jjienS6RnNc084c
        CLinFHwU711fnhomSjp9tmmxOFR2bym+QDL5GASpW/c62YmcxTml0Z9FKG6cigjaltHx4Mjf
        vLyTwsI1d5HoUKRSHME/YNsZNuj2RfedwH0jRkEK70JZlb4ltApkqn2jv3MwND5rnas5OCuy
        e21c97HRLTLMcIJPKGMZoQeuUDL/ATJBsrHEBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsWy7bCSnG6nFmOSwdo7zBZ7bn5mtVh9t5/N
        YtqHn8wW7w8+ZrWY1D+D3eLyEz6Lve9ms1pc+NHIZPF4038miz2LJjFZrFx9lMni+fLFjBad
        py8wWfx5aGhx9P9bNotJh64xWuy9pW2xZ+9JFov5y56yW3Rf38Fmse/1XmaL5cf/MVlM7LjK
        ZHFu1h82i22/5zNbHL53lcVi9R8Li9aen+wWr/bHOch6XL7i7TGx+R27R/OCOywel8+Wemxa
        1cnmsXlJvcfkG8sZPXbfbGDzaDpzlNljxqcvbB7Xz2xn8uhtfsfm8fHpLRaPbQ972T3e77vK
        5tG3ZRVjgEgUl01Kak5mWWqRvl0CV8bDT4dYCl6wVEw9MJ25gfE/cxcjJ4eEgInEg5v72LoY
        uTiEBHYwSsw/3sMGkZCUWPb3CFSRsMTKf8/ZIYqamSTeLP4DVMTBwSagLXH6PwdIjYiAuMSf
        C9sYQWqYBaazSjScuswEkhAWcJM4eeomC4jNIqAqcen/TjCbV8BK4vPyZUwQC5QlFj48yApi
        cwLFv/2ZxgKxrIFRouHcClaIBkGJkzOfgDUzC8hLNG+dzTyBUWAWktQsJKkFjEyrGCVTC4pz
        03OLDQuM8lLL9YoTc4tL89L1kvNzNzGCk4KW1g7GPas+6B1iZOJgPMQowcGsJMIr0/0/UYg3
        JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQamuSLugvUOQnum
        7n0VVJr/qeFg0LWK35NshS+d5DcuLPIw27ym5e2XWY+q0/Zp3XTnX5YYdtRzknWzZGRq6Ncm
        zZkb9EpC2yf835vOsCsgo+Nfn80VnuaPpaFZQW9Wr9ZkjXGX//PJOTnt/2qx2/O3On7g2+i5
        aFs81yyZu4rT1/7Tlerk3c9+LrOkTfjRhqaXZiJW7yvnGV1is2KYojU99Zu1nktJnoXZ31qr
        A47sRaH/lvzWruoJ+z/zHfvVNvFL/gsUz5mt638StnLu9V3NfA6tFZ8dBHc2TZvKNqf+l9kH
        uZkybYGfDRyzurK+vFCe7SGtwiF5zNr8yikm35XVHdLZf3afuv+4XXTJ1KtKLMUZiYZazEXF
        iQDOaJpbeQMAAA==
X-CMS-MailID: 20220207141953epcas5p32ccc3c0bbe642cea074edefcc32302a5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220207141953epcas5p32ccc3c0bbe642cea074edefcc32302a5
References: <CAOSviJ0HmT9iwdHdNtuZ8vHETCosRMpR33NcYGVWOV0ki3EYgw@mail.gmail.com>
        <20220207141348.4235-1-nj.shetty@samsung.com>
        <CGME20220207141953epcas5p32ccc3c0bbe642cea074edefcc32302a5@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Setting copy_supported flag to enable offload.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 drivers/md/dm-linear.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 1b97a11d7151..8910728bc8df 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -62,6 +62,7 @@ static int linear_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	ti->num_secure_erase_bios = 1;
 	ti->num_write_same_bios = 1;
 	ti->num_write_zeroes_bios = 1;
+	ti->copy_supported = 1;
 	ti->private = lc;
 	return 0;
 
-- 
2.30.0-rc0

