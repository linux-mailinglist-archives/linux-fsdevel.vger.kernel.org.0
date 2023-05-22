Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3C770BB86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 13:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjEVLRk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 07:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjEVLPt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 07:15:49 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0353212D
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 04:10:56 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230522111055epoutp04cd198b57794e6879a986e964d092f5fb~hcrSPPrf01725517255epoutp04g
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 11:10:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230522111055epoutp04cd198b57794e6879a986e964d092f5fb~hcrSPPrf01725517255epoutp04g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684753855;
        bh=cp2ikyfpBdIhGRYkH19yhVPh/sP+Xdj/kjqikt163DM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IzQJrA5xfmVQexqHTuv8PLDMXc1xR/Gr7ke6dXvs6vYXRavsdUbuSr0wFp6fOzn5Z
         zP4G78bIKvJd4ZiR574V6AwYTFshFBjPtF0tfG8rIfD/2NFhU/pQ+Z84LniB2ZlS2c
         qzvGud0Sn0/wU0Svzwm/er4Kgk9+pBMg1RB8EKrQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230522111054epcas5p33acd05785f22834d299a20230b560857~hcrRipPPd1390713907epcas5p3i;
        Mon, 22 May 2023 11:10:54 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4QPvrX4txBz4x9Ps; Mon, 22 May
        2023 11:10:52 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FB.03.54880.CBD4B646; Mon, 22 May 2023 20:10:52 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230522104657epcas5p19117017c9dfd3d7a4860d2f9122b1277~hcWXN8Hld1779017790epcas5p18;
        Mon, 22 May 2023 10:46:57 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230522104657epsmtrp151d988d04f34f0cc5a959c2d73aa022c~hcWXM9K5l1501415014epsmtrp1W;
        Mon, 22 May 2023 10:46:57 +0000 (GMT)
X-AuditID: b6c32a49-b21fa7000001d660-f2-646b4dbc5e45
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        07.FF.28392.1284B646; Mon, 22 May 2023 19:46:57 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230522104653epsmtip2d7d619611d9ae6ee3b4a9dd3ccc0c4dd~hcWTcnaV61590015900epsmtip2B;
        Mon, 22 May 2023 10:46:53 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, bvanassche@acm.org,
        hare@suse.de, ming.lei@redhat.com, dlemoal@kernel.org,
        anuj20.g@samsung.com, joshi.k@samsung.com, nitheshshetty@gmail.com,
        gost.dev@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v11 8/9] dm: Enable copy offload for dm-linear target
Date:   Mon, 22 May 2023 16:11:39 +0530
Message-Id: <20230522104146.2856-9-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230522104146.2856-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TazBcZxie75zdY5nqHCTjw0T1JJ2W1GUTtp97tUnmGDFxq8500pEde1hj
        9+x2dyW0yWRFJaLDujVkaUPT0QRFEHWNlorQMSY2rkFIKaIukalUDbprafPveZ/3fd7L883H
        wy3rTGx5cayKUbBCCUWYceo7HB2dW4LjRW65Px5CVT33cVRUVUGgS1mbOCof1xBooWMVoGsr
        6ziabPNHrUuFXDTycyOGWr7LwdDt8k4M3dHwUHPJcwx1bi8SKKd9EKCZAS2GWkcPo5bWbg7S
        NRURaKJim4tulM6YoK+GGgj0Q9cWhtpzUzDUMJ0MUP3GDRxVLixz0INRO9S32cVFG38XEe/b
        07pHQbT2SS9BN2rHTei+iTsc+lpOD0HX3nKidb0JdE3ZVYKuWc0xoR8UbHDo2u8v0s0jaoLO
        SFki6Oczoxx6+d4AQWfWlYEQq0/ifcSMUMQoHBg2WiaKY2N9qaDwqA+jPARufGe+J3qPcmCF
        UsaXOnYyxPlEnETvFOVwVihJ0FMhQqWScvXzUcgSVIyDWKZU+VKMXCSRu8tdlEKpMoGNdWEZ
        lRffze2Ih77wTLw4vyyfK0/mJv6x+QuhBgWcdGDKg6Q7LBi4jBmwJdkMYFpyQjow0+NVACsq
        87jG4AWA/feriT1FsfrZbqIJwPS0IWAMUjFYODanz/B4BHkY/rbNM/D7yGkcLjb9iRsCnOzC
        YVZpN25oZUUeh9Ulv+8M55BvwT7dDDBgc9IT5s9V7zSCpCvUPLEw0KakF5x7qMWNJRaw+/r0
        zg04+QZMuVu40x+SE6awNq8UN656DK4XLAMjtoLPuupMjNgWzmsu7+Jz8HbeLcIo/hJA7ZB2
        V+APU3s0uGEJnHSEVU2uRvoA/LqnEjMOfh1mbExjRt4cNny7hw/CiqriXbts4ODL5F1Mw1+n
        SnbdygDwytNqIgs4aF85SPvKQdr/RxcDvAzYMHKlNJZResj5LHPuv2eOlklrwM73cQpsAOOT
        Ky7tAOOBdgB5OLXPPDQzWmRpLhImfc4oZFGKBAmjbAceesOzcdv90TL9/2NVUXx3Tzd3gUDg
        7nlUwKeszd/27Y62JGOFKiaeYeSMYk+H8Uxt1Vgae1ISUCm8ZBGw348fofkiidqK++t0xEJY
        umkklLG6RU1fr+7U9Q9aT0HtN62RmaKYjs3J+nKz0rGpm2tJ/LHOYxuDIXlBF+zPlygu3sxQ
        n7jS9VgXcPT82pqd9KV41Tp0q6LbP/g1aWV6meDTF2dOu/jZ+36c6KMO5siveqtj/CNxb+5C
        ugk1JesvfSRKpMad0w6kFsxbD4es/4MrZv3bbGwc2Y9S7/0ERrzDYLY3792Vp3ltY4HhDd6W
        EXZzoRes3nkoIKzm2IPhw7lpTLHtbE2V1GuiWhmt+6wxDD1uGZNIZv2yhwfy598U97NHDiHx
        9NnALd8lxULM3ZbcYYqjFAv5TrhCKfwXX8ItBscEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SXUxTZxzG855zenpoqBxaZa9gdOvYxWpAQI2vH/Ej6vImEIEtW9hEoaFn
        yIBCWnDDXazYaGKNtKsKpTThQ8egOj6KlGKLsCpSJMikU1KUShAUx5QCXmgIViuaePfk+f3+
        z9WfIUXTVCSToyjilApZnoQWULbrknUxn+FceVxA/TlqvnWTRObmyzQ6rl8i0aUxHY1mrs8D
        VO5/RaLx7l2o63kVD3l7OgnkrDMQqPFSL4FadQxy1M4RqDfwjEYG1z2Apu6aCNQ1uh45u/op
        5LlqppHvcoCHquun+Oj0iJ1Gf/a9JpDrrIZA9slSgGyL1SRqmpmlkHs0Cg0t9fHQ4kszvXst
        9vybiE0PB2ncaRrj4yFfK4XLDbdo3NYgxZ7BYmy1nKKxdd7Ax27jIoXbLv6GHV41jc9ontN4
        bmqUwrPX7tK47IoFpIh/EOyQc3k5Rznlhp2ZgiMVlgpeYSnvl8dLf9NqYKS0IISB7CZYo/6P
        pwUCRsTaAeypXngPVsP6pRvkchbDxtdP+MuShoDW3/20FjAMza6HAwEm2K9k/SRsvlIHggck
        e5+EtpG0YBaz+2FL7SMimCn2CzjkmXrnCNmtsGK6hRfcgewGqHsYHqxD2G1w+o6JDNait4q+
        PmHZDof9lZPU8vo6qGmvIvWANX2ETB+hGkBYwGquUJWfna+KL0xQcD/HqmT5qmJFdmxWQb4V
        vHsGqdQOnBZ/rAsQDHAByJCSlcLUsiy5SCiXlRzjlAUZyuI8TuUCUQwl+UT4j7Y/Q8Rmy4q4
        XI4r5JQfKMGERKqJ6Ju3XzR8ZYhOf/LguPQPz0u3+evNzj2mVWJizVhcajhaSORvDHPuajiz
        IrlAH+MY/7/1wrPHZ8/zB35t3Bum3+9rcRXPDib21e8rCZXqLm4M9PvW+hO6S73DvsrWqKfe
        sttf5oyv+BS6ztd4mrj0trQ1w8b4FxUdfRPfMsmqcz9mLhg7Zzo7xt1JJQ1mOzV47bCwRaRo
        qs3N2xc6eyMiK+5AxkQEq7EZfyqr3PJNe8FYVtIdddpBNy9i+6aYvw7pTuTOWT0dTYLQyMnv
        UpNsaNW27zOTy+dThuSjzipn0cDJC9HNTgerlobV8lO8igmt1jEs6H1wbkTsJvfEnFpsk1Cq
        I7J4KalUyd4AmRghvnsDAAA=
X-CMS-MailID: 20230522104657epcas5p19117017c9dfd3d7a4860d2f9122b1277
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230522104657epcas5p19117017c9dfd3d7a4860d2f9122b1277
References: <20230522104146.2856-1-nj.shetty@samsung.com>
        <CGME20230522104657epcas5p19117017c9dfd3d7a4860d2f9122b1277@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Setting copy_offload_supported flag to enable offload.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 drivers/md/dm-linear.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index f4448d520ee9..1d1ee30bbefb 100644
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

