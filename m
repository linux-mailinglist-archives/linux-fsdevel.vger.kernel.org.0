Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94E6740A6E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 10:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbjF1IGQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 04:06:16 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:35671 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbjF1ICe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:02:34 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230628064455epoutp04d043959b67f8c84b96751477e66a7141~sv6mmj0Qz2912729127epoutp04a
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 06:44:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230628064455epoutp04d043959b67f8c84b96751477e66a7141~sv6mmj0Qz2912729127epoutp04a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687934695;
        bh=cp2ikyfpBdIhGRYkH19yhVPh/sP+Xdj/kjqikt163DM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NRd+lGcaozhMWc1I/VDbAqgD65RbrdsNheCym648l2bDAAo/kddI7DELMytBSKndC
         9nGq3GXvK8xXayYda/z5mTyUJTo9PK9cVNtkqyP16a8nDhsJ0bXFrhA5PQnc8vXBzH
         LTD+zSLwfM56hREpY/nPJ2BLaoHS93KsbXjT00Ng=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230628064454epcas5p1105def2a4a48815b269ffb5a749e4a74~sv6l3pwdt2101721017epcas5p1Q;
        Wed, 28 Jun 2023 06:44:54 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4QrXBY5TSZz4x9Q1; Wed, 28 Jun
        2023 06:44:53 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        46.4D.06099.5E6DB946; Wed, 28 Jun 2023 15:44:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230627184107epcas5p3e01453c42bafa3ba08b8c8ba183927e6~smCo_byDD0780707807epcas5p3p;
        Tue, 27 Jun 2023 18:41:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230627184107epsmtrp10062d7cd1e21b793dd2a7d1a851343b4~smCo9f2dH1856518565epsmtrp1a;
        Tue, 27 Jun 2023 18:41:07 +0000 (GMT)
X-AuditID: b6c32a4b-cafff700000017d3-cc-649bd6e5a170
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        09.49.34491.34D2B946; Wed, 28 Jun 2023 03:41:07 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230627184103epsmtip21d124411e8c89e5b7683f606750615a0~smClcbl4h0383203832epsmtip2j;
        Tue, 27 Jun 2023 18:41:03 +0000 (GMT)
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
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        willy@infradead.org, hare@suse.de, djwong@kernel.org,
        bvanassche@acm.org, ming.lei@redhat.com, dlemoal@kernel.org,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 8/9] dm: Enable copy offload for dm-linear target
Date:   Wed, 28 Jun 2023 00:06:22 +0530
Message-Id: <20230627183629.26571-9-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230627183629.26571-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfzCbdxzH+32e5BFu0UdQX3qzXLZ2h5GE0C+jdiv1qF3nzna36/6ITJ7D
        iSRNomV2N6q0rJrWj7LI0eG2+p3SWgilWjO6nZqWlWMO2c60GF0xZ1sibP3v9fl8P+/Pr+99
        WDin2s6DlSzX0Cq5RMYjHBjt97y8fM1jFVLB1EVn1DL0HY4aprQEWry3CtC1lU0czfdeAGh0
        3hHN9ISj7qUKJnrS24GhruoiDNU19GOoqG8MIPNjHYa6J3zQV3m1DNTVPchAo516AlV9bbZD
        X4wbCfTNwN8Y6ivOwZBxPhug9q0qHDUvLjPQ9xMH0fD2ABNtbeiJdw5So49iqA7dlB01PH2T
        QbXd8KZGf0yjWuvzCaqt9nPK9CSLoGouFzOpwpwlgvrDPMGglu88JqjLt+oB1fYgk1pr9aRa
        559hseSplNAkWiKlVVxanqCQJssTw3gxceJj4sAggdBXGIyO8LhySSodxot4L9b3eLLMshge
        94xElmZxxUrUah7/aKhKkaahuUkKtSaMRyulMqVI6aeWpKrT5Il+cloTIhQI/AMtgfEpSWX1
        ZUxlNjP91+27RBYoZxQAexYkRbCy6S5RABxYHNIEoH590s5mrAJoql5i2IwXAF6aasb3JBf/
        MgArc8huAAc7Q21BuRg0Gs5bcrFYBOkDH/zDsvpdyCwcGkw1wGrgZC0O656uMK1qZzIS6v8c
        tLMygzwEF8zbO2I2GQKbJvytCEk+1P7iZI2wJ9+GpuH7O0o26QQHv5zfGQEnX4M5tytwa3pI
        DtnDH3L0mK3RCKgv3dplZ/j7wC07G3vABW3eLp+FdSU3CJv4PIC6cR2wPYTD3CEtbm0CJ71g
        Syff5n4Vlg41Y7bCjrBwa343PxsaK/f4ddjYcp2wsTscW8/eZQoW9z/cXe9lAC/U92NXAFf3
        0kC6lwbS/V/6OsDrgTutVKcm0upAZYCcPvvfLycoUlvBzrF4xxjB7MyKXx/AWKAPQBbOc2Ef
        2CiTcthSScantEohVqXJaHUfCLTs+yru4ZqgsFybXCMWioIFoqCgIFFwQJCQ58YeGS+UcshE
        iYZOoWklrdrTYSx7jyys0e3FUk97tO+J8lXKaJ78WVpy5tTmm3GFEdsHuub6p9dWMjO1s+dq
        VKcV68OfeV+J/NYU9a56M9u13SX6FUWj+0YTL+D4c96++KcZxWX5prw49wLRzaM1zw7JmSvv
        Lxr4czHayoQZGGmmqejD/CX/24bqOIOnMOoTcfLIkcN1uucc5vBpbrbAnhPVGJ8b7bxQEjk7
        Ev6xLOOYmM23/zDdT6+fGxTd3+x49MZGcIBS4RPQ89bCSfYH7qVrWR+d3MoJdkoMEJ5IL2+6
        Ni5vMuuX3bSODHqu/U7B8G/nUiOxqnjX/SH7ZJ4J7IfbRfkdkz81zE2Hdo7u1wtiFb2ZDpdE
        ZTyGOkki9MZVasm/d9PekrUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsWy7bCSvK6z7uwUg2efpC3WnzrGbLH6bj+b
        xevDnxgtpn34yWzx5EA7o8XlJ3wWD/bbW+x9N5vV4uaBnUwWexZNYrJYufook8WkQ9cYLZ5e
        ncVksfeWtsXCtiUsFnv2nmSxuLxrDpvF/GVP2S26r+9gs1h+/B+TxaHJzUwWO540Mlps+z2f
        2WLd6/csFiduSVuc/3uc1eL3jzlsDtIel694e+ycdZfd4/y9jSwem1doeVw+W+qxaVUnm8fm
        JfUeu282sHks7pvM6tHb/I7N4+PTWywe7/ddZfPo27KK0WPz6WqPz5vkPDY9ecsUIBDFZZOS
        mpNZllqkb5fAlTF91XTWgkbWimd/D7I1MM5g6WLk5JAQMJHo+LWBsYuRi0NIYDejxK27ixkh
        EpISy/4eYYawhSVW/nvODlHUzCRx9dUjoG4ODjYBbYnT/zlA4iICXcwSnTvfsYA4zALbmCU+
        fPjCDtItLOAqMefrSTCbRUBV4uXTv2wgzbwCVhJrbxmBmBIC+hL99wVBKjgFrCV2nz/CChIW
        Aqp4fzwAJMwrIChxcuYTsJuZBeQlmrfOZp7AKDALSWoWktQCRqZVjJKpBcW56bnFhgWGeanl
        esWJucWleel6yfm5mxjBca+luYNx+6oPeocYmTgYDzFKcDArifCK/ZieIsSbklhZlVqUH19U
        mpNafIhRmoNFSZxX/EVvipBAemJJanZqakFqEUyWiYNTqoFpUVz7lax1vkX732xdJf3RU333
        QfMKFfE8LyGOxYH1mvmnFs3tW37KI+XahRj/GVLrslxFz2kbtfXc/+fevPaaxCrRqQ/qotbP
        MLlkP0PUPzVl5xltoe7mrM3OVob2K5bOC2H6x/th4trOUL4m55kn+eYc4ds/V+nvLvfsyyu5
        HRxdDhU+/P0sPvfainV9jysS23dFXvmYHXdT5867Vb0uhwun/H5e1zrNrcPD5pjGhc9Fa15J
        vAq+Uvf999+G2LA8w7pXB6u28bxiNlg2/fvib2fKNuiYr992auV92+dfWHsDL9qsCdC5Iljx
        b+Es7mbGJu5TO9MfiMnzJzX5P1nDfPJW/fmwuaExxzd0HFvrqsRSnJFoqMVcVJwIAJFLCRlq
        AwAA
X-CMS-MailID: 20230627184107epcas5p3e01453c42bafa3ba08b8c8ba183927e6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230627184107epcas5p3e01453c42bafa3ba08b8c8ba183927e6
References: <20230627183629.26571-1-nj.shetty@samsung.com>
        <CGME20230627184107epcas5p3e01453c42bafa3ba08b8c8ba183927e6@epcas5p3.samsung.com>
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

