Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C076DD521
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 10:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjDKIVQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 04:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjDKIUm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:20:42 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53DE468C
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Apr 2023 01:19:50 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230411081949epoutp013326876d994e43e681f771c2f5887129~U05L4K3ZS0630706307epoutp01f
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Apr 2023 08:19:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230411081949epoutp013326876d994e43e681f771c2f5887129~U05L4K3ZS0630706307epoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681201189;
        bh=LSWdD3MQyN53kHS/yCDz0oi55FM+zMca65KKpSIzhUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A+gRVZy8wxEWhLMjG7PTNg3FIqPbv0U9tdhLuaMIGsy0OfazrWjkNIHl7jkkw6FUY
         GFPLYyLm9l+O7zTdDS1byHi8gcm4gPBgPXUWxFnQZiUvWfXbxk6EYmFB0MFdAbWD9C
         W+LVgX/MdsLaFU/M44vdj8CvWEsTUzRhAp0byDgs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230411081948epcas5p259aff7c3e4caa110a36836bab23b8110~U05LUqq1Z0093700937epcas5p2X;
        Tue, 11 Apr 2023 08:19:48 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Pwf0218Y5z4x9QF; Tue, 11 Apr
        2023 08:19:46 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        67.4F.09540.22815346; Tue, 11 Apr 2023 17:19:46 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230411081351epcas5p3c2a85087cce368f6c2e0ffdbf18f29b2~U0z_dpTVe2461924619epcas5p3v;
        Tue, 11 Apr 2023 08:13:51 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230411081351epsmtrp14c71460f7f29de5d9fca595fba7313c5~U0z_cD27P1918219182epsmtrp1f;
        Tue, 11 Apr 2023 08:13:51 +0000 (GMT)
X-AuditID: b6c32a4a-4afff70000002544-86-64351822eb6f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A0.0E.08609.EB615346; Tue, 11 Apr 2023 17:13:50 +0900 (KST)
Received: from green5.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230411081347epsmtip224a26827cc4aeef86f955c4275720480~U0z7VJIRW2247222472epsmtip2J;
        Tue, 11 Apr 2023 08:13:47 +0000 (GMT)
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
        dlemoal@kernel.org, anuj20.g@samsung.com, joshi.k@samsung.com,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v9 8/9] dm: Enable copy offload for dm-linear target
Date:   Tue, 11 Apr 2023 13:40:35 +0530
Message-Id: <20230411081041.5328-9-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230411081041.5328-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xTZxjeOac9FJOaQ5HsswusO5Nx2YBWWvaxiDhh25mYjcSMZMsSOGlP
        CqG0tZcJOhHoAK1yGQaiVUS2AQIGJgWCQBFbi4JRNxkymSJmJaTIRXRkAwXW0rL573mf73ne
        25eXg/GO+/A5GUodo1HSChLfxOq0hYVGkEAiE5b3s2Hr0AAGC8pXMNj8sAyHT2zPEFj1dAmD
        E1fioWXuDBve77+Mwt4fKlDY2GxHYU/tAgrta7M4rLDeQ+DkiAmFlrF3Ya9lkAWHu8/isKZ+
        0gdaTxpQ2OXIR2DnixoMtjyZZ8EbY2/AOyvX2bsANfxbEmV6dAunLpse+lB3xi+xqOFbeqqt
        6RhOmX86QvXcz8OpEsMcTs33jeBUaXsTQplvHqKetwVRbY5ZNHnzV5k70hlaxmgEjFKqkmUo
        5XFk0r7UhFRJjFAUIYqF75MCJZ3FxJGJe5MjPs5QuDZACr6hFXoXlUxrtWTUzh0alV7HCNJV
        Wl0cyahlCrVYHamls7R6pTxSyeg+EAmF2yUuYVpmuuW0BVX/zM4ebPgdz0P6WUbElwMIMVgc
        mECMyCYOj+hBQKf9Ku4JniHAeLuf7VbxiOcImGnhbDgej5awPKJuBPxV+yvqCQwoMC84ELcK
        J0LAtanC9bxbiCIMLEweW7dgxF0UvGyfx9wqfyIRnCvtcz1wOCwiGCyN5bppLgHBgHXKx00D
        IgqUPfJz075ELHhZfRT3SPzA4GnH+gwY8SYwdJzB3OkB8aMvqDZPoJ5WE8Hx72a82B9MX2/3
        8WA+cJYVebEc/DM86dWogWGgD/HgeFA4VIa5e8CIMNDaHeWhA0HlUAvqqbsZlLxweK1c0HVu
        A5OguPGsFwNguZ3nxRToLTzqXdYJBBQ7Z9ByRGB6ZR7TK/OY/i99HsGakK2MWpslZ7QS9XYl
        c+C/X5aqstqQ9asI39OFPJ54GmlFUA5iRQAHI7dwF9eiZTyujM45yGhUqRq9gtFaEYlr3d9j
        /ACpynVWSl2qSBwrFMfExIhjo2NE5OvckLhBKY+Q0zomk2HUjGbDh3J8+XmocO7CbloSNjvl
        5zxouQDtxqaUd0avlugVDQ9Gt3WkBSaV8Bucb4vQsYjSX2jV4V3SafP5FFFZ4I0VefCIriCU
        qH6LU4kf+XY8qOqkYz9bWuGU/uFUJ1QGhWjj2eG59HJxrm5uKrE2WtZqBdJJ6ejsobp8mz1/
        1NgUXFB4wD/FMHzlRFXO8h5q+WLIXsFA8r7VbsZeVL/zvbtLmpxVMatW0VjBj1zK67bVhVzk
        9szV3fs0bf9HsubPtg0tKDhjhyXT1akqv69j47fSAae6Vj9/8Mlato1KSVisCb1mSzYbvyxs
        GN/92qlLAdn1X3yIUQoz8Tevvlx+07955M+OfpJkadNpUTim0dL/AjrFP6meBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra0xSYRjHe885HI822xEVX+/JdDkqS7v4mq360IezVcvWyuXalOKkTSEC
        7bqVZi7NLIarKWZXVxOdGqZBgikWimZWZqVl2NJMTaOLlhmRaG19+z//32/P8+GhcG4j4UPt
        laSyMokwhU+6ELVN/MDF9bwVoqWW7ihU2WrC0QmFDUdlvedINNL0BaAL1kkc9d1biwxjRRzU
        3aDDkP6aEkOlZQ8wVHf1M4Ye2EdJpDQ+B2igS4UhQ89CpDeYCdR59yKJLt8YcELG/EwMafsz
        AKqduoyjipFPBGrp8UUdtmbOOsh0PtvAqCztJKNT9ToxHW9uEUxnexqjUeeQTHXJcaauO51k
        8jLHSOZTfRfJnL2tBkx121HmqyaA0fSPYjHz4lxWi9iUvQdY2ZI1CS5JhkIDJq3iHDLffEmm
        gwbiNHCmIL0cvn2RN51dKC6tBfDRzXwwCyBsHbrxN7vD0t+DTrNSBgYbs16TDkDSC+D9wSzg
        AB60AodPLemkY8DpPgx2DH7jOCx3ej28dLZ++gZFEXQInOw55qhdaQRNRsdWavrCEnjO4uao
        neko+Ks4m3TU3GmlRE/M2m7QXNg/k3E6EGbWFOEKQKv+Q6r/0BWAqYE3K5WLE8XycGmEhD0Y
        JheK5WmSxLDd+8QaMPNlgUAL9GprmBFgFDACSOF8D9dx+zIR11UkPHyEle2Ll6WlsHIj8KUI
        vpfr49PmeC6dKExlk1lWysr+UYxy9knHuN5YsdAzIfNI+2f7z7aVHisq9QWx3/uI7DR33vgO
        +aKoC0Mm0+bhBv+J6qD3T/g8WwFWsGuP23yOOJYKHbYNfLm+1i/k1caIBJ/muYuCeb6Lkzc9
        bVMuU47MrwxNprWC1KKPkruwMVfzQ69rjcm9Wi6Az7wzdkuL74zRy8MqckYmz+/3iq88YEiO
        brL5lE4UFgfH7ekNjAxomvP15MqCDy3bcu2KbRvnlueEr5l8e+xhxpBOqVd75g17Tg3HfHj0
        whrsro3OX6U61aXoeee/dTzAmrW9MIg3YLrU3F0u3FWyX+fRZiurD4qsCzdD/zOsTbTQvrN5
        S43VK8Kv6qXEwifkScJwAS6TC/8ACa8Kg1QDAAA=
X-CMS-MailID: 20230411081351epcas5p3c2a85087cce368f6c2e0ffdbf18f29b2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230411081351epcas5p3c2a85087cce368f6c2e0ffdbf18f29b2
References: <20230411081041.5328-1-anuj20.g@samsung.com>
        <CGME20230411081351epcas5p3c2a85087cce368f6c2e0ffdbf18f29b2@epcas5p3.samsung.com>
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

