Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA70778D7C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 13:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236441AbjHKLVO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 07:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236434AbjHKLU4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:20:56 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47CA2129
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 04:20:46 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230811112043epoutp01bd8dd5ac507129a6b51004baf4e0a4e3~6UD_KxsoW3045830458epoutp01Z
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 11:20:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230811112043epoutp01bd8dd5ac507129a6b51004baf4e0a4e3~6UD_KxsoW3045830458epoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1691752843;
        bh=cp2ikyfpBdIhGRYkH19yhVPh/sP+Xdj/kjqikt163DM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dF6zR1eD2GCylgh35ir+97k7SqRGn4xP8UjuTIBcMbAC5lBone9ptm5wP/Qc7kAkz
         8vJQSDw4Ww1wAH1HNtq/0e/Bpb9bMdlDpYNCqCJCg9GSLKgzExdZ/RPvvp3xka0bpw
         UMw7tOfp+cn8XkoZFDD76UAeGVymnb4YXyHFqYWc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230811112043epcas5p25d147b9f2216bcf295549d0750a03a75~6UD9abQAJ0760807608epcas5p2k;
        Fri, 11 Aug 2023 11:20:43 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4RMhDS4Dsxz4x9Pr; Fri, 11 Aug
        2023 11:20:40 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        87.7D.55522.88916D46; Fri, 11 Aug 2023 20:20:40 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230811105819epcas5p40ddff0991c70b6d80d516dfe055bd673~6TwZyFW5P1386113861epcas5p4G;
        Fri, 11 Aug 2023 10:58:19 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230811105819epsmtrp1cae6dab938a725a7ce3ed467ec718df1~6TwZxHHYy0371503715epsmtrp1C;
        Fri, 11 Aug 2023 10:58:19 +0000 (GMT)
X-AuditID: b6c32a49-67ffa7000000d8e2-10-64d61988985e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
        E2.23.64355.A4416D46; Fri, 11 Aug 2023 19:58:18 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230811105814epsmtip2d7a93644a1886d650dc65130c3e958bb~6TwVB4lIO1103411034epsmtip28;
        Fri, 11 Aug 2023 10:58:13 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     martin.petersen@oracle.com, mcgrof@kernel.org, dlemoal@kernel.org,
        gost.dev@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 10/11] dm: Enable copy offload for dm-linear target
Date:   Fri, 11 Aug 2023 16:22:53 +0530
Message-Id: <20230811105300.15889-11-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230811105300.15889-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIJsWRmVeSWpSXmKPExsWy7bCmhm6H5LUUg7bVchbrTx1jtlh9t5/N
        4vXhT4wWTw60M1o82G9vsffdbFaLmwd2MlmsXH2UyWLSoWuMFk+vzmKy2HtL22Jh2xIWiz17
        T7JYXN41h81i/rKn7BbLj/9jsrgx4Smjxbbf85kt1r1+z2Jx4pa0xfm/x1kdRD3O39vI4nH5
        bKnHplWdbB6bl9R77L7ZwOaxuG8yq0dv8zs2j49Pb7F4vN93lc2jb8sqRo/Pm+Q8Nj15yxTA
        E5Vtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQP0qpJC
        WWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAh
        O2P6qumsBY2sFc/+HmRrYJzB0sXIySEhYCLRM/UQkM3FISSwm1HizdvlzBDOJ0aJxo3LGeGc
        uUfOMsG0vLt7lAkisZNRYlPnFaiWViaJH3/WsnYxcnCwCWhLnP7PARIXEWhgltiwezEjSDez
        wHwmib3vIkFqhAXcJY6cYgYxWQRUJfq6RUEqeAWsJaZ0T2QECUsI6Ev03xcECXMChd9vusQG
        USIocXLmExaIgfISzVtnM0Oc9p9D4sVxVQjbRaJ36mWoL4UlXh3fwg5hS0m87G+DssslVk5Z
        wQZypYRAC6PErOuzGCES9hKtp/rBTmMW0JRYv0sfIiwrMfXUOiaIvXwSvb+fQIOEV2LHPBhb
        WWLN+gVsELakxLXvjVC2h0TvtK9g9wgJ9DFKvNhiPYFRYRaSd2YheWcWwuYFjMyrGCVTC4pz
        01OLTQsM81LL4VGcnJ+7iRGc9rU8dzDeffBB7xAjEwfjIUYJDmYlEV7b4EspQrwpiZVVqUX5
        8UWlOanFhxhNgaE9kVlKNDkfmHnySuINTSwNTMzMzEwsjc0MlcR5X7fOTRESSE8sSc1OTS1I
        LYLpY+LglGpg4p5i02o0Y9Kz55Y1Gt4ujW90uI+m6FZOWSI937bg4aEKl7UhS/0TCpOfpeuV
        Kx7687frkOPqTimjGTpWnsukpTbErpc6r7Xvxt1/HGfSYtRq9PbypdrMVVr4xWbHPG7nP97r
        D29xKGH9a5eekr3vseL+7vc3vtz/FCK0+drMgLs6EidvXzEPS0mcq79d5s4fK4YFy9nWsEqs
        8urmtxdNtfoQZ6twRevGC65Ebk+r06/ut/Sv2cIWvnQvb5Z/zVQNhsAFx46sair465GhkNHk
        fFv42RZZ4Z8vv7NK73vaIVs9cf/uL9er1tmvPdp09Efl1y28d/3WX9v+PHn2pYb86lxTXrfl
        619r1RgWd/SuU2Ipzkg01GIuKk4EAD5Wi+2EBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsWy7bCSvK6XyLUUg11/bCzWnzrGbLH6bj+b
        xevDnxgtnhxoZ7R4sN/eYu+72awWNw/sZLJYufook8WkQ9cYLZ5encVksfeWtsXCtiUsFnv2
        nmSxuLxrDpvF/GVP2S2WH//HZHFjwlNGi22/5zNbrHv9nsXixC1pi/N/j7M6iHqcv7eRxePy
        2VKPTas62Tw2L6n32H2zgc1jcd9kVo/e5ndsHh+f3mLxeL/vKptH35ZVjB6fN8l5bHrylimA
        J4rLJiU1J7MstUjfLoErY/qq6awFjawVz/4eZGtgnMHSxcjJISFgIvHu7lGmLkYuDiGB7YwS
        f2buYoVISEos+3uEGcIWllj57zk7RFEzk8SBr0+AHA4ONgFtidP/OUDiIgJdzBKdO9+xgDjM
        AiuZJHYenskIUiQs4C5x5BQziMkioCrR1y0KMpNXwFpiSvdEsAoJAX2J/vuCIGFOoPD7TZfY
        QGwhASuJD8sOMkKUC0qcnPkE7GZmAXmJ5q2zmScwCsxCkpqFJLWAkWkVo2hqQXFuem5ygaFe
        cWJucWleul5yfu4mRnBMagXtYFy2/q/eIUYmDsZDjBIczEoivLbBl1KEeFMSK6tSi/Lji0pz
        UosPMUpzsCiJ8yrndKYICaQnlqRmp6YWpBbBZJk4OKUamHK+z4189cfz4oJFETfYRPe29elG
        7ajpun5mNvMbjnJPXuFzL1S+7bK57stx++2l7fG3J9++fIPx8unLNj9K9/27fafnxqlpkW63
        o/e+2BHorPBTmXHbJMNlL9ZNmbsrZ8c2i///PvoITWz7ymYQsHGlqbJ9VfX9HzZe0+u5pyzS
        e//+llVouPdN1q7yt7cj3r9749iwkSnfbv7P8zkLzI9Lv02bvOV21cLMz5pbvyzPTp7xzUFx
        R/OTJal7c/Y3v8o6xcCVOX0/P1eS7fvGqDm11zTTp8XKO+w0r1c4WRYd/SRKre/YednMeMFV
        LSIvjx8M/9SY3j4v+sncuMdT5h1jnOCbzyR0rnPdiVXsrTHzlFiKMxINtZiLihMB2tOUUzgD
        AAA=
X-CMS-MailID: 20230811105819epcas5p40ddff0991c70b6d80d516dfe055bd673
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230811105819epcas5p40ddff0991c70b6d80d516dfe055bd673
References: <20230811105300.15889-1-nj.shetty@samsung.com>
        <CGME20230811105819epcas5p40ddff0991c70b6d80d516dfe055bd673@epcas5p4.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
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

