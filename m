Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259AC50FCB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 14:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349898AbiDZMTZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 08:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350021AbiDZMTI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:19:08 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173442A272;
        Tue, 26 Apr 2022 05:15:41 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220426121539epoutp019241d41ee270efd3efaf29231340203f~pcVMInrPh2441224412epoutp01x;
        Tue, 26 Apr 2022 12:15:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220426121539epoutp019241d41ee270efd3efaf29231340203f~pcVMInrPh2441224412epoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1650975339;
        bh=aldYG758I5J0H6y47s6CjsKzxu4fKQN/27Pbe1yKBJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dMw1cAz19iWnNW4W6kX1MNQVffeqEiDSkyypInBoo4DxTYGH8Sv5+TCpXNSoHMx0R
         9xasddjYRQGTu4sMZ4H+2b9+MBWht7nqUZWgWMqWOQoGpjVxWqdBpxqzXmYk2uUlis
         DW6+d4yop2QOSGNa0Gb8Vv25SQj+YudS3CznhhRg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220426121539epcas5p2393b817f760d43547ab7887c4d7f4f04~pcVLv4dvy0308203082epcas5p2T;
        Tue, 26 Apr 2022 12:15:39 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Kngng3J0wz4x9Pp; Tue, 26 Apr
        2022 12:15:35 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        83.5F.09827.762E7626; Tue, 26 Apr 2022 21:15:35 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220426102025epcas5p299d9a88c30db8b9a04a05c57dc809ff7~pawkbJJwV0348803488epcas5p2P;
        Tue, 26 Apr 2022 10:20:25 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220426102025epsmtrp1948e220cdc94a40774a02893817ca764~pawkYqjmJ2358223582epsmtrp1Z;
        Tue, 26 Apr 2022 10:20:25 +0000 (GMT)
X-AuditID: b6c32a4a-b3bff70000002663-5a-6267e267ac47
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.CA.08924.867C7626; Tue, 26 Apr 2022 19:20:25 +0900 (KST)
Received: from test-zns.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220426102019epsmtip1dae65d97eba440d2158f5c1c914957da~pawfVkJ0m0427604276epsmtip1-;
        Tue, 26 Apr 2022 10:20:19 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
Cc:     chaitanyak@nvidia.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, hare@suse.de, kbusch@kernel.org,
        hch@lst.de, Frederick.Knight@netapp.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/10] dm: Enable copy offload for dm-linear target
Date:   Tue, 26 Apr 2022 15:42:36 +0530
Message-Id: <20220426101241.30100-9-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20220426101241.30100-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TazBcZxjOuezZZWY5bvXRdqKrJoPBLpZPRHQqk55ZnWHaTpuYTHVxshS7
        O7ur2k6aLOsypKmSoSxJVNIq2iiWumZKKm5RRdxW3Ip0rMy6VJBKotaRNv+e93ne53sv37wc
        zLqP7ciJk6pohVScwCPM8Ybbrkc8JH9KovhTg3awuvcOBqumcghYsPoYgyvt8yyYl1PIhjv9
        AxgcXrCAbcZiFvxjOwWF87W7KJz4tQmFrWV5KKyo6kThX+XXEdjy7RoKn8wJ4NyGHod5HaMI
        XBzRorBN7w5b23pwONxcQsBr3y+y4cWxRgLeWm7DYHnXMxT+rn1CwNyuOhZsXEhBYMPONQze
        nh7B4c3lFRx261+G6V8+ZsOBp12sN5yp4XuhlHamn6ByNUY21aSdYlMD0zU4NdyfRNVWZhFU
        3Y0L1OXxcoRqmVATVOrdTowqXN8gqEsaI0E1pc+wqLVFPU6t3Bohwu0j4o/F0uIYWuFES6Nl
        MXFSSRAv9N3IkEihH1/gIQiA/jwnqTiRDuKdeDvc42Rcwt4OeU6fiBOS9qhwsVLJ8zp+TCFL
        UtFOsTKlKohHy2MS5L5yT6U4UZkklXhKadVRAZ/vLdxL/Cg+tk6XypKnsD7NqTKw1Ughno1w
        OID0BRtGr2zEnGNNtiBgrHoNY4J1BPykMSBM8DcCOrfb9xSzfYf+QQaLEZoRcPlK175gTaaj
        IKvGxvQsQbqDvl2OibYlcVCxtYWb8jGyhw00Tf+gJsGGPAmqBw1sE8ZJF5B5vXQfc8mjYCtt
        6KA9L5AzY2WizchA8F2nEWVSrEBP0QJuwhh5GGjqi/e7BmSqOShUP2Mz3hOgdNyJ6dkGGLp0
        bAY7gqWcjAOcDH7JKEUZbxoCsnt7cUYIBoOtT1HTOxjpCqqbvRj6VZDfexNl6lqASzsLKMNz
        QePV59gZ/FhdSjDYAYxupRxgCszqpg8W+hUCjLkP0K8RJ+0L82hfmEf7f+lSBKtEHGi5MlFC
        K4Vybymd/N8fR8sSa5H9q3ITNSJzs6ueHQjKQToQwMF4ttx8l7NR1twY8Wef0wpZpCIpgVZ2
        IMK9fedijnbRsr2zlKoiBb4BfF8/Pz/fAB8/Ac+e2yf5WWxNSsQqOp6m5bTiuQ/lmDmqUZ3X
        UiWVGqN6ae3c8ddXXew2xmS1bgNoWdwZ3ZBQNLfzPnAffOtGZRgImPwi5b3z03xDzYcexenK
        b3wM0OrjrXuj7FNnstSnze52xEnTRPfdI4Y1h4e876DJY5yzXOeS8TmBRZTqSrTnwxWbN3+T
        tCOSsvXgNc6mJWu1z5UOtD21VK/b+SFN5vvK6kCz8uFsgoOdM3/ykLd+OrU44MLpbDPHEu9M
        YYTNJhkaErag3ZhYEuavvLN+vmjQkvdo0/5IiM7BcshaoxcGt1TURo64FsWI/MMO3e8WiVIK
        zsU/6i6YDbTk+7iGN1hm1l9NHFcHrTW+xvGZ95/cbQxNvbj8wTYPV8aKBW6YQin+F161QYPe
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SXUyTZxiG837/MMs+a6evMnSpcoIB1gXZK3V1yRb9CDqnLjtw2WjBb5Ws
        xaYV53YCtCApzjDqdFglyChU6CobCBalTJGC/FSclUlLEDthLOoKdS6UFOpWyBLP7tzXlTvP
        wcPgQj25jsnLP8Jr8xUqMRVLtN8Ur0/O61PmvHn1H4CaB3pxZBuvoNCZ2Xkczdx4RCJTRRWN
        wu5hHHkm45AzcI5Ed0LFGHrU8gJD3usdGOr8wYShRpsLQ9PWOoCu1QYxtOCXIP9zH4FM3b8B
        NDVixpDTtxl1OvsJ5Ll6nkI1DVM0OnHfQaGuJ04cWfsiGLptXqBQZV8riRyTxQC1h2twdPPB
        CIEuPZkh0C1fPCr9Zp5Gw4t95LsbOc+9LM484aa4SkOA5jrM4zQ3/OBngvO4C7iWJiPFtVoK
        uVOjVsBd8xZRnH7IhXNVz55T3ElDgOI6SidILjjlI7iZrhHqwzUHYrcd5FV5R3ltqkwee6j1
        sp7UFJPHKmyP6SJQRZSDGAayadD3x3GyHMQyQtYB4O/hp/QyWAsbFnvw5bwKNkam6WXJgMHI
        oIUqBwxDsZvh4Asm6ohYAjbOzRFRB2eDNKzuCpFRsIrdAZt/fbw0SrCJsKzuwlIWsBlwruQu
        Ed2BbCqsmFgZrWNYKax3BbBoLfxPGQ0fW7ZXwv6zk0s34+wGaGg7h38LWPNLyPwSugCwJrCW
        1+jUSrVOonkrn/8yRadQ6wrylSm5h9UtYOlNkpIcoLNpNqUbYAzoBpDBxSLB6cTPc4SCg4qv
        vua1h7O1BSpe1w3iGUK8RnCnvD9byCoVR/gveF7Da/+nGBOzrghL3zMq3y9f3KlPk/35074f
        JUMJphLl9VceytwDG82+o6eT4ryyh2cuLuRuSaz92/sGO5bZU/+dKuGDXTX96lddnpC9MH0b
        NquqS977feWQPes9aZlxcS5+/x4Tk/paW7pmYJN8t6DEklNT3XCg1sha39lwYjpjt3P7VPWO
        U2qLfWubwTXe25ucmhHwD6Q9PfnZhMglT7jt/yU07e69Etw+GrKprbukq312ScaKrcJOiyyx
        7Nk91eW81883/qVYHbw0jz4qzTZmtndlNuvpwU/3Hv8kOcvG1LvfvihyFDNWyZaxyIor0ob3
        C7136/yi3DH2lrQjEh6O69nJ29cb7398Q0zoDikkSbhWp/gXLU8g4JUDAAA=
X-CMS-MailID: 20220426102025epcas5p299d9a88c30db8b9a04a05c57dc809ff7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220426102025epcas5p299d9a88c30db8b9a04a05c57dc809ff7
References: <20220426101241.30100-1-nj.shetty@samsung.com>
        <CGME20220426102025epcas5p299d9a88c30db8b9a04a05c57dc809ff7@epcas5p2.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Setting copy_offload_supported flag to enable offload.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 drivers/md/dm-linear.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 0a6abbbe3745..3b8de6d5ca9c 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -61,6 +61,7 @@ static int linear_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	ti->num_discard_bios = 1;
 	ti->num_secure_erase_bios = 1;
 	ti->num_write_zeroes_bios = 1;
+	ti->copy_offload_supported = 1;
 	ti->private = lc;
 	return 0;
 
-- 
2.35.1.500.gb896f729e2

