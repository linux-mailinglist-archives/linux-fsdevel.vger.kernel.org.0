Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040086CD452
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 10:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjC2IRt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 04:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjC2IQz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:16:55 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75A04C29
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 01:16:31 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230329081630epoutp0117deaa98432fc1efa1cdb841f31aaa43~Q1dlXEZWk1285012850epoutp01Q
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 08:16:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230329081630epoutp0117deaa98432fc1efa1cdb841f31aaa43~Q1dlXEZWk1285012850epoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680077790;
        bh=Xr5pG5YQRmNwtteFma8PSAfaeXx0TOavDZPZ9ALIkAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RUmu20NuzDnC+HGx33YnJktvWo/SM3cRedufcqsmKYUEXDQCN7EVDMV9PiTLeKYSp
         VveA0KvJWCb25V1qaeVnvqG7N/AAinKWQw5/uH6H+bhTE/kCvKSuoHXKjbVXy5fuNr
         ChlUOIkdQ+UsMcnUiVbmTMkH+stddf7pTBErgEV8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230329081629epcas5p29eacb83ce69432a0ad642a245c809ee4~Q1dkxESEl1635016350epcas5p2t;
        Wed, 29 Mar 2023 08:16:29 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4PmfXD1pMqz4x9Pp; Wed, 29 Mar
        2023 08:16:28 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2F.D5.55678.CD3F3246; Wed, 29 Mar 2023 17:16:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230327084322epcas5p12f01e676e47d3c8ba880f3f5d58999b4~QOid0ghRO3074330743epcas5p1R;
        Mon, 27 Mar 2023 08:43:22 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230327084322epsmtrp14a16237c5338352e007443853faae221~QOidzab1c3087630876epsmtrp1O;
        Mon, 27 Mar 2023 08:43:22 +0000 (GMT)
X-AuditID: b6c32a4a-909fc7000000d97e-79-6423f3dc0d61
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C4.4C.18071.92751246; Mon, 27 Mar 2023 17:43:22 +0900 (KST)
Received: from green5.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230327084318epsmtip1e924ae0d72b9b7a598d9de0e0ac183ae~QOiakAl-c3003630036epsmtip1N;
        Mon, 27 Mar 2023 08:43:18 +0000 (GMT)
From:   Anuj Gupta <anuj20.g@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     bvanassche@acm.org, hare@suse.de, ming.lei@redhat.com,
        damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
        joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v8 8/9] dm: Enable copy offload for dm-linear target
Date:   Mon, 27 Mar 2023 14:10:56 +0530
Message-Id: <20230327084103.21601-9-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230327084103.21601-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ta0xbZRjHfc9pT8uweLiYvesca85QBAVabOFljKkZM2cbM3iJH9SBDT2B
        BmhLL264MJEONggVZJFpQS6KRugyXMe4toQxGQKBjnBZysZtlk1ABhveCcOWFt233/N/nn+e
        y5uXi/uVcvhcuULLqBXSDIrYxmq+FhIcdnt1j0xoKfJGjf3XcZRXuo4j02QJgRavPQSofOVv
        HK0N2nBkvV/BRvauNgxZvi7DUL2pB0MdtQ8w1LOxRKCy7nGA5saMGLJOvIAs1j4WGmmvJFD1
        d3Mc1H1Oj6FWxycANa9V4+ji4jIL/TSxE9nWe9mvQHpk9AhtnB4k6DbjJIe2TV1i0SODOtrc
        UEjQl+s+pjvsuQRt0N93FuRPs+nlzjGC/rSpAdCXB07Sq+ZA2uxYwhKfejd9XxojlTFqAaNI
        UcrkitQ46shbyQeSJVFCUZgoBkVTAoU0k4mj4hMSw16TZzjvQAk+lGbonFKiVKOhIvbvUyt1
        WkaQptRo4yhGJctQiVXhGmmmRqdIDVcw2r0ioTBS4iz8ID0t1z5AqH5gn7i7scrOBV2sIuDF
        haQYnq+/hReBbVw/sgPATrsFcwcPAbRZhgh38AeA9QY7sWWx9q1y3AkrgNbmBeBK+JF6DE6O
        8l1MkMHwx3v5wFUUQBbg8MFcIcsV4OQMBqvz6jYd/mQ87DPUYC5mkc9CU3mLU+dweWQMrFEU
        Aa6zWQQsmfZ1FXiRe2Flaz/bxTzSF/Z96dhcASd3Q/2Vis0VIGnygu2dXRz3oPFw6c6wZ2h/
        uNDb5NH5cL6kwMOp8K+ROczNKqi/3gnc/DLM7y/BXTPgZAhsbI9wy7vg5/0XMXdfH2hYc3is
        PNhatcUUPFNf6WEIrUO5HqbhvZ5lz6kNzuv+focoBQLjY/sYH9vH+H/rGoA3gB2MSpOZymgk
        qkgFc/y/R05RZprB5tcIPdwKZmdWwrsBxgXdAHJxKoC3Nk7J/HgyafZHjFqZrNZlMJpuIHFe
        +zOc/3SK0vm3FNpkkThGKI6KihLHvBQlorbzguP6UvzIVKmWSWcYFaPe8mFcL34uVqrzbju6
        Wm6pOsM6uHBMeywlZ/aXcPuTsT4jOq9hzqFvbxb8s8N/PYcsaLka32l+u6dWaHguizkRG3ng
        ktZcm1N1oeK906ySR/B4Ul6gXo4/keu4m7T4RWjSm2L72KNfT8dNZ/k2JVC20v0FU5KAd1Rn
        DytuFbeMB8nBhiDrmarW+Whlw7n3K4dnp9jz2ljiSn3xSu/VhubdpqYuZbf1+ehD/SEHT/qs
        h8qGlm2OIPafr18Iq5q48bOJVJcbkkzBjZIXEwLPZ8Z775Tv2c4/RRTSFZNv/Fa78lXdwO3i
        /KxRfZBp19m47Fdnyk7Jh28mH2V9k11d3nqjSxezEiD+XhTVmEexNGlSUSiu1kj/BXih46aj
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Re0hTYRjG/c45OzsuVscp9JVkNMrKanNd4OtedOGUUCPoKmWrnSzTaZuW
        WayjdqGRzQykpunsYjnD1sy7ps4spy0jU5hdhqJZmJtlRiWzmhX03+/leZ73eeGlcNFjYjJ1
        SBXPqlWKaDEpIEobxEHzQrZPU4ZWpWDoXvNjHKWke3BU+EZPov6GzwBlDn7H0Yi9FUc1riwe
        ctRVYKj6egaGCgobMVSV9wlDjT8HSJRh7QCot92AoZrOOai6xkagtspsEuXm9/KR9XIqhsp7
        kgEqHcnFUVG/m0BNnYGo1fOEtwoybS/DGIPTTjIVhjd8pvXtfYJpsycwFtN5kim+eYqpcnAk
        k5bq+m044+Qx7oftJHPxgQkwxS0nmCFLEGPpGcDkE3YJlinZ6ENHWbV0xV7BQc7RQsaZeYnv
        fg7xOFBH6IAvBemFsMY2xNcBASWiqwC8OlgG/ggQNn/I/8v+sGC0j+9lEZ2MwdLOMSbpmfBR
        3xngDQfQ6Th84eRI74DTLgyauvJ5Xpc/vRba0oyYlwl6BizM9DbwKSG9GBpVOkD93i+Feqef
        1+BLL4HZ5c28P1WLof5c5VhQSPtB29WesZtxeipMLcnC0wFt+E8y/CcZAWYCk9g4TUxkjEYW
        J1OxxyQaRYwmQRUp2R8bYwFjrw6ZXQ7KTIMSK8AoYAWQwsUBwuKwaUqRUKk4nsSqYyPUCdGs
        xgoCKUI8UfhcZ4sQ0ZGKePYwy8ax6n8qRvlO5rDwJZuad4yETrG3b1sqT0zRxXNrTE7zwHBw
        Cy/xyxOLNsJUFxhq3DEasF3l5mJ3n1zqMd96tdrsDHfIfc6iJkdtXvzw1g5DwfiF9d9G0etF
        TfyLG80PTcsEXXvu6lMaRleFpXFZ8tUr7+Tv8QQv8sOeVa7s6rib9DTp/L4cqf1933Ltlymy
        5OgTXffXefr12pe1Ubk/sg+IG3Wnr8y/pfQpn7W594LWsv5a9biGxJPpStfbGz/c/ve+HRmv
        zfnUsvVjTma4qJtlurmPM6IqNmwxlmxbIMheQWbJpEU+EyQlRvexw/LMeqck6tLAhjs76eTb
        8unPvq7rFL7fEiQtut7tmismNAcVshBcrVH8AmNSxplZAwAA
X-CMS-MailID: 20230327084322epcas5p12f01e676e47d3c8ba880f3f5d58999b4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230327084322epcas5p12f01e676e47d3c8ba880f3f5d58999b4
References: <20230327084103.21601-1-anuj20.g@samsung.com>
        <CGME20230327084322epcas5p12f01e676e47d3c8ba880f3f5d58999b4@epcas5p1.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Nitesh Shetty <nj.shetty@samsung.com>

Setting copy_offload_supported flag to enable offload.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 drivers/md/dm-linear.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 3e622dcc9dbd..785a6822d06c 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -62,6 +62,7 @@ static int linear_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	ti->num_discard_bios = 1;
 	ti->num_secure_erase_bios = 1;
 	ti->num_write_zeroes_bios = 1;
+	ti->copy_offload_supported = 1;
 	ti->private = lc;
 	return 0;
 
-- 
2.35.1.500.gb896f729e2

