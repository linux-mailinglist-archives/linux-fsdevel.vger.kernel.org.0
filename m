Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440E475EB42
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 08:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjGXGLU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 02:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjGXGLR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:11:17 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488441B8
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Jul 2023 23:11:16 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230724061114epoutp0483464dbfd521e6eb2f3b48776beff22a~0uOnee0Wa2686526865epoutp04C
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jul 2023 06:11:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230724061114epoutp0483464dbfd521e6eb2f3b48776beff22a~0uOnee0Wa2686526865epoutp04C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690179074;
        bh=IK3dxHmN4H0mrKlZYjtF8HydO/F3EynIGSvvTtPQyYo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=gaU9lxo5L2d62LSVOkqafz2Tm3GaNW/u8Wz7NQBvvei2c10rcQbGxIf674pqoAJ/q
         KGZ8jnGONHlWU26Sy0kN7KNU9gT4NcUb2WwTEu/53YoQLyetVfbNKJiut6cQKaJU48
         DMa8lTG8uicmNRXp5h3KfRBB0CuhkEUXX8p4xwd0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230724061114epcas5p2ede7af22d682b0b0ca9a2d78aad5e658~0uOnG8x--0258702587epcas5p2D;
        Mon, 24 Jul 2023 06:11:14 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4R8VCh1rD9z4x9Py; Mon, 24 Jul
        2023 06:11:12 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        64.49.44250.0061EB46; Mon, 24 Jul 2023 15:11:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230724060655epcas5p24f21ce77480885c746b9b86d27585492~0uK2VvzRT2148421484epcas5p25;
        Mon, 24 Jul 2023 06:06:55 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230724060655epsmtrp12375dce4a7600f368a4d6c2ea1201731~0uK2VCzLu0052600526epsmtrp1P;
        Mon, 24 Jul 2023 06:06:55 +0000 (GMT)
X-AuditID: b6c32a4a-c4fff7000000acda-5e-64be1600b2e0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        6C.95.34491.FF41EB46; Mon, 24 Jul 2023 15:06:55 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230724060654epsmtip2702415b5f52b1f1a85a44b20693599a6~0uK1JO11Z2599125991epsmtip2X;
        Mon, 24 Jul 2023 06:06:54 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     hch@lst.de, gost.dev@samsung.com,
        Anuj Gupta <anuj20.g@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/read_write: Enable copy_file_range for block device.
Date:   Mon, 24 Jul 2023 11:33:36 +0530
Message-Id: <20230724060336.8939-1-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnk+LIzCtJLcpLzFFi42LZdlhTXZdBbF+Kwe7ZHBZNE/4yW7w+/InR
        4uaBnUwWK1cfZbLYs/cki8XlXXPYLLb9ns9scf7vcVYHDo9NqzrZPHbfbGDz6NuyitHj8yY5
        j01P3jIFsEZl22SkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6
        ZeYA3aKkUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTAp0CtOzC0uzUvXy0stsTI0
        MDAyBSpMyM64+Hslc8F97ooz2y0bGF9ydjFyckgImEhsu/WeuYuRi0NIYDejxPmptxkhnE+M
        ErvmXGKCcL4xSqz4d5wdpqVv3VtGEFtIYC+jxL4zBhBFrUwSxye9BEpwcLAJaEuc/s8BUiMi
        ECbx5G0XK0gNs8B6RokL6+YzgSSEBTwkXn9sZQGxWQRUJc7c/MwGYvMKWEq0XvrABDJHQkBf
        ov++IERYUOLkzCdg5cwC8hLNW2eDnS0hcI1d4vOr00wQx7lI7P73jQ3CFpZ4dXwL1NFSEi/7
        26DscomVU1awQTS3MErMuj6LESJhL9F6qp8ZZDGzgKbE+l36EGFZiamn1jFBLOaT6P39BGoX
        r8SOeTC2ssSa9Qug9kpKXPveCGV7SDxavZMVElixEge+f2KfwCg/C8k/s5D8Mwth8wJG5lWM
        kqkFxbnpqcWmBUZ5qeXweE3Oz93ECE6RWl47GB8++KB3iJGJg/EQowQHs5IIb3r6rhQh3pTE
        yqrUovz4otKc1OJDjKbAMJ7ILCWanA9M0nkl8YYmlgYmZmZmJpbGZoZK4ryvW+emCAmkJ5ak
        ZqemFqQWwfQxcXBKNTAt7/D4pjhZOcpCU8vVjqlf7/m+LVebtz7vZJhr9/Bb4PnFBx0NN/gU
        F8j9vpB29nfdUvPeRxOU3OOYM+q+3Ty7pmTvrOy7N360TD14sHZn9YWY2w71JxQZ3q1Mfb33
        X6VgrOc7zSyjiBUZr/znezAdnF8280ztEsuJCZsZLHgWN59a435HNpK3s6TzyllDV9GDe8QY
        V7iEKyRKm6/ZlPu1K/rwYinRC2m1TJt8amLdf5aofUjvfhR/dlNZdo/K3ad6Juz7eOzfiy8/
        /Z7r5bOfq3kENfrN6puPNOifjXq9bL7C7wdMmrrapfs55aWMDRo1u7sdKqWjpV/frbv/VunA
        5WWJ8X7txUvXGH3svaXEUpyRaKjFXFScCADqmQdCGgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsWy7bCSvO5/kX0pBt+7DSyaJvxltnh9+BOj
        xc0DO5ksVq4+ymSxZ+9JFovLu+awWWz7PZ/Z4vzf46wOHB6bVnWyeey+2cDm0bdlFaPH501y
        HpuevGUKYI3isklJzcksSy3St0vgyrj4eyVzwX3uijPbLRsYX3J2MXJySAiYSPSte8vYxcjF
        ISSwm1Hi8aU3bBAJSYllf48wQ9jCEiv/PWeHKGpmkujfcw3I4eBgE9CWOP2fA8QUEQiTOPeQ
        H6SEWWAro8TXY6/ZQXqFBTwkXn9sZQGxWQRUJc7c/Aw2n1fAUqL10gcmkF4JAX2J/vuCEGFB
        iZMzn4CVMwvISzRvnc08gZFvFpLULCSpBYxMqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLz
        czcxgkNVS3MH4/ZVH/QOMTJxMB5ilOBgVhLhTU/flSLEm5JYWZValB9fVJqTWnyIUZqDRUmc
        V/xFb4qQQHpiSWp2ampBahFMlomDU6qBqcBD+NQfXfdlOdZCmw6tTH1oGcT7urTxgXycVNTR
        hcflF86X1rNzU1iV0HQn68yHtZyyolcKORIcYxfXTfUPfXp39W6/qFiO9U+Upjm0THzK4fiy
        dYoOd0bfnEDfX9X+NYcdPZauaZ9+8fRnfvWX98TzZQ2rD0laB8mvbAv231Sxdca/ZtviR4vP
        CU5hCM3in3JmGp9cL9PCclbrc+8XMbNKFN3c3f4x9ypXrUKbtMdx8Y97bH+ztXS6fnmq9mX7
        Ws9rLs7NzD72tnunOGyQF9p8fe1MO4WVy/PnK3Lw+/3y+PNqc4W6S/VPh7mZzAm2y7hnd+xR
        WXHvxeMnNfNr29Isl/xsDQvVbd6+tu22EktxRqKhFnNRcSIAE2JtBsQCAAA=
X-CMS-MailID: 20230724060655epcas5p24f21ce77480885c746b9b86d27585492
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230724060655epcas5p24f21ce77480885c746b9b86d27585492
References: <CGME20230724060655epcas5p24f21ce77480885c746b9b86d27585492@epcas5p2.samsung.com>
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

From: Anuj Gupta <anuj20.g@samsung.com>

Change generic_copy_file_checks to use ->f_mapping->host for both inode_in
and inode_out. Allow block device in generic_file_rw_checks.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 fs/read_write.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index b07de77ef126..eaeb481477f4 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1405,8 +1405,8 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 				    struct file *file_out, loff_t pos_out,
 				    size_t *req_count, unsigned int flags)
 {
-	struct inode *inode_in = file_inode(file_in);
-	struct inode *inode_out = file_inode(file_out);
+	struct inode *inode_in = file_in->f_mapping->host;
+	struct inode *inode_out = file_out->f_mapping->host;
 	uint64_t count = *req_count;
 	loff_t size_in;
 	int ret;
@@ -1708,7 +1708,9 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
 	/* Don't copy dirs, pipes, sockets... */
 	if (S_ISDIR(inode_in->i_mode) || S_ISDIR(inode_out->i_mode))
 		return -EISDIR;
-	if (!S_ISREG(inode_in->i_mode) || !S_ISREG(inode_out->i_mode))
+	if (!S_ISREG(inode_in->i_mode) && !S_ISBLK(inode_in->i_mode))
+		return -EINVAL;
+	if ((inode_in->i_mode & S_IFMT) != (inode_out->i_mode & S_IFMT))
 		return -EINVAL;
 
 	if (!(file_in->f_mode & FMODE_READ) ||
-- 
2.25.1

