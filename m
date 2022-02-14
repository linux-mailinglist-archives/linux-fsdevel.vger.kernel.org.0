Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10474B44BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 09:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242488AbiBNIqJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 03:46:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242552AbiBNIqF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:46:05 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C1E606C2;
        Mon, 14 Feb 2022 00:45:37 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220214083616epoutp04bebac9c91502b22ec389367e354046aa~TmiXeG4Dy0136801368epoutp04Z;
        Mon, 14 Feb 2022 08:36:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220214083616epoutp04bebac9c91502b22ec389367e354046aa~TmiXeG4Dy0136801368epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644827776;
        bh=ngGeLKh/cNFBqZ2ebzcJUg1MB4xMAkdY6dg48NrWGfk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T+xy6Tv4m9DEzueG2vKkPQax2Qnf/Cu9x/SRWm3SVQYzMofaa0HWWIGQKvmyz/ems
         1EN7mxX+PlcpPXYxXQqbhoQ9wzTtbNuAt4yNPOv6FaDvFeGCDa5DN+MDPn6MjxtCgp
         LCFwhlcmAmEvh6fX0YlkJECV/uyP80Tg0LPEGwxc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220214083615epcas5p139fdb7d151237f990c3306d6d6a1642a~TmiXJFcUW1332613326epcas5p1l;
        Mon, 14 Feb 2022 08:36:15 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4JxyHC4TqLz4x9QH; Mon, 14 Feb
        2022 08:36:07 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C5.17.06423.7741A026; Mon, 14 Feb 2022 17:36:07 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220214080656epcas5p31c80cce4f9638bccdf2bc225b339c37e~TmIwwT_j10612006120epcas5p3K;
        Mon, 14 Feb 2022 08:06:56 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220214080656epsmtrp13385868747ae487e254764d8bab6138b~TmIwve7fn0045300453epsmtrp1g;
        Mon, 14 Feb 2022 08:06:56 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-a2-620a147714cb
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D9.B4.08738.0AD0A026; Mon, 14 Feb 2022 17:06:56 +0900 (KST)
Received: from test-zns.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220214080651epsmtip233c40a25e259e947cf3374c16faf4684~TmIsK1UTr2418624186epsmtip2k;
        Mon, 14 Feb 2022 08:06:51 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
Cc:     javier@javigon.com, chaitanyak@nvidia.com,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, hare@suse.de, kbusch@kernel.org,
        hch@lst.de, Frederick.Knight@netapp.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, joshi.k@samsung.com, arnav.dawn@samsung.com,
        nitheshshetty@gmail.com, Nitesh Shetty <nj.shetty@samsung.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/10] dm: Enable copy offload for dm-linear target
Date:   Mon, 14 Feb 2022 13:29:59 +0530
Message-Id: <20220214080002.18381-10-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.30.0-rc0
In-Reply-To: <20220214080002.18381-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTZxTfd+/ltmXBXbCTD2Sx6WYWMGDrWvYhMnCiXqJsGLMtumVwgTsg
        QNu0ZTr9A1hHIzDk4VBWioAOkPdEZYzXEIKM12BDqBqesUSF8J4B5NFRis7/ft85v9/5nXO+
        HC5u185x5EbI1KxSxkQJSWuiusXZxfUM3zpYZCwUoMqOeziqf7hghUqHUkl0eXYZRzN3H1uh
        jNQsDuozbkMN09lWqHcpHkOPq0wYqr+WgaHi0lYMPSm6DlBd/hyGEjt7MbQ6JkatpikSZTQP
        ADTer8NQw6M9qL6hnUB9tXoS5RaOc1CyoYZEjZMNOCpqW8fQX7pVEtUY4wGqXsnFUctwP4Eq
        JmcIpL35HKCEH5c5qGetzcpHSPfdP0brRrpJOl0zzaF/1w1x6J7hmwStyRsk6L7uGLqqJJGk
        b/0SS196UATouodxJP19VytOZ83/S9IpmmmSnht/RNAzjf1kwI7TkQfCWSaUVQpYWYg8NEIW
        5iU8djLwUKDUXSR2FXugD4UCGRPNegl9jwe4HomI2tifUPAtExWzEQpgVCrh3o8OKOUxalYQ
        LlepvYSsIjRKIVG4qZhoVYwszE3GqveLRaJ90g1iUGT42HwzoXhKnM1suoLHAROeBHhcSElg
        3twASALWXDuqDsDlpDQrc8KOmgdwJmmnJbEAYMf9XPKlIj1xaotUC+B6HNdCSsBg8Y2LWBLg
        cklqD+w0cc0cPkXA4sVFwszBqQUS/lm2ssnZTh2BlQufmDkEtRv+ZpgDZmxDeUJtyWXM4vUu
        zB+7u+nF24g3TRbhFo4tbP/ZSJgxTu2CmjvZuLk+pF7wYHtjj5VF7AtHV3sIC94OJ9pucyzY
        ET5L1XIsgmQAl7pGMMsjC0BNmmZrTG/4d/3aZqc45Qwra/dawu/AzI4KzOK8DaasGLc6tYE1
        V42vui6rzNsq4wAHFuO3MA2fG8o4lm1dBLBhaolIAwLdaxPpXptI9791HsBLgAOrUEWHsSqp
        Qixjz7z65RB5dBXYvCkXvxowNDrr1gwwLmgGkIsL+TZfd/OC7WxCme/OsUp5oDImilU1A+nG
        ytNxx7dD5BtHKVMHiiUeIom7u7vE4wN3sdDepjPsV8aOCmPUbCTLKljlSx3G5TnGYTeu+686
        HVqvCPEuLvk8Uz9SfuqNhKGnyW/Kzg9PV8r0balfGtKKP5X25aQzef31hHRKqo3WHz3n4pm7
        FKxyMvIlvCj7/Mbyfe+ZDhZ0n/fGg3zeOhh44fSE9VjJFxqvItuGlUuDV78KERX/ZND8MIg3
        qjvjXhy+XflEUcZ2iCYiffX21zLD5NkSJ+2KIaes3bdavXt0/pTqZE5rStqVVoeaiPeXTuzw
        t/1Y45Xr5/NZk+lZRcIMOlrgzzs733ln3Fj+wL2lcOi4diX+j9gC7Uh+262u+HTx7D+lfoJ7
        zOqunYOeojEUf6I3NClW7/RNd7CWFfIjhp0Tg5CEX3Jhv25NSKjCGbELrlQx/wHDR1On3AQA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf1CTdRzH7/t9nj3Ps3Wzx0HwaJzEkBQ4wHV2fSKyrjx9qtN+/FUeJ458
        DjkH0rORGlciK5JBh8yEuaHgj4MYAQk5STZvjCaHQtAtfqZ2S5B0OZiaQDlXE7vzv9d9Xq+7
        9z8fhlCEyOVMbr5OEPPVGiUlI209ytiUerkse03976ug7eIFAuzjdyTQfKWSgurZBQJmuq9J
        wFhposEzuQQcfosEhub3Y7jWHsJgP2HE0NTsxjDdeBJB1/EAhrJLQxjue1XgDt2iwOgaQTA1
        bMbgmEgGu6OPBM+5WgrqGqZoKB/tpOC8z0FAY+8DDD+Z71PQObkfge2fOgJ6rg6T0OqbIaH0
        9F8IvqhYoGEw2Ct5Vcl7fnmLN/82QPFVej/N/2C+QvODV0+TvL7+Msl7Bgr5dmsZxXec2scf
        GmtEfNd4McWX9LsJ3nT7LsV/pfdTfGBqguRnzg9T70RtkWVsFzS5Hwti2rptsh3e2y6y4A9y
        z2FnDVGMQoQBSRmOXctVld2SGJCMUbCdiKt0B/CiWMY1BH98FEVwTQ+m6cVIj7numqOkATEM
        xSZzl0JMuIlkSa5pbo4MNwR7lOb6ff10uIlgN3BtdzaHG5JN4M6OBlCY5exLXKm1+tFWPHfc
        2y0Js/S/u9PX+HBXwaZzpmEXvdgv5fqOTJJhJthYTn/GQhxErPkxZX5M1SNsRcuEAm1eTp5W
        VfBcvrA7VavO0xbm56R+uCuvHT38kaSkTmS3zqa6EGaQC3EMoYyUbx2QZivk29V7PxHEXVli
        oUbQutDTDKmMlg8Z+rIUbI5aJ+wUhAJB/N9iRrq8GL9tm+5+ofp6/8+HR8tft39UEhHo6Aie
        8woLNbrEwK8V358tjXvj5fSFZ++9yfdpPyeKlq7F6S1pDdS7iau/qa07mLTu+WaNUVzd5ivf
        F7eyOBpfyI2afdJ0stZ8zFM0NqaWPlV98bOthzKX3MxIcyQ4/ZVzcQLoeluiYv789sZAW7rh
        zIqWmA3uTclHvsvIdJR88ETXdX9wVc/G9SnxRTszDCa3bv6ZxDT3zXnvi+YKyxpn66fj5Cnj
        MVVUlcWqcji34KwRcWMwsuLrcVvsyN5t7pQvYyYGdyfcoHxgMd9bn9W6Z1r62nvvrzzQdbmB
        yZ6dFK3xLlv0gSC+G9Ss+PuVzZlKUrtDrUoiRK36X2mdGvKSAwAA
X-CMS-MailID: 20220214080656epcas5p31c80cce4f9638bccdf2bc225b339c37e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220214080656epcas5p31c80cce4f9638bccdf2bc225b339c37e
References: <20220214080002.18381-1-nj.shetty@samsung.com>
        <CGME20220214080656epcas5p31c80cce4f9638bccdf2bc225b339c37e@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
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

