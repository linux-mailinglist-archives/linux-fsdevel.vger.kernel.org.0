Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE9576385E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 16:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbjGZOHQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 10:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234335AbjGZOHC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:07:02 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482632722
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:06:55 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230726140654euoutp025f9bf59266bd03a91cc66770d6c9b86e~1cAfUbZke1252612526euoutp02g
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 14:06:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230726140654euoutp025f9bf59266bd03a91cc66770d6c9b86e~1cAfUbZke1252612526euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690380414;
        bh=6mB52qN+R16ZSOlZbadkP2nqRgZuKLvKv4ZQP2aLimE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KsHMve4EUJuZI3y4V+x7wPfANifMyLnhuFBwTmSv8Tsbre8M7JjhzWs8djE7plcZR
         emBQvp6UDkOyyyg5mgGbp3bkvCjFczW/QSW+/a+nDyGR5UC7XuunS4kV/gJ1EiPBQM
         ovjo9zBf3t957JBw1tUH9lIT+GxcXKy0XKFEGOTU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230726140653eucas1p2d871c6dd058bd31fb2422dd12e6c3da0~1cAfFa4C30080000800eucas1p2b;
        Wed, 26 Jul 2023 14:06:53 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id FB.56.37758.D7821C46; Wed, 26
        Jul 2023 15:06:53 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230726140653eucas1p2e234b7cd0af5dc506bd27399b84292a6~1cAesXzc90711407114eucas1p2V;
        Wed, 26 Jul 2023 14:06:53 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230726140653eusmtrp148068635e752f08c3e11322422ed43d0~1cAemxqF02391823918eusmtrp14;
        Wed, 26 Jul 2023 14:06:53 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-f3-64c1287d0843
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 02.C7.10549.D7821C46; Wed, 26
        Jul 2023 15:06:53 +0100 (BST)
Received: from localhost (unknown [106.210.248.223]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230726140653eusmtip28acb5341e8d5a00219f44de2ba1c977a~1cAedM1422279822798eusmtip2A;
        Wed, 26 Jul 2023 14:06:53 +0000 (GMT)
From:   Joel Granados <j.granados@samsung.com>
To:     mcgrof@kernel.org, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Cc:     willy@infradead.org, josh@joshtriplett.org,
        Joel Granados <j.granados@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/14] sysctl: Add ctl_table_size to ctl_table_header
Date:   Wed, 26 Jul 2023 16:06:23 +0200
Message-Id: <20230726140635.2059334-4-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230726140635.2059334-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfVDLcRzHfff7bfs15r5N9JHOw+ROZAmnObXjzsMPh/4R13HZtV+Ztsp+
        lbjLhQwrS566HqTlaSp2VkiIwia5SmHzcNIZd0IeJgkV88vx3+vz+bzfn4fvfSlCUsD3o9QJ
        yYwuQamRCkTkRVtv07T0yXWq6ZU3ZfKT1zuQfKAkUX4vSyu/eq2BlLfVFAnkzv2vkPzHt990
        6vKKeRRdmHGfpEusKXSleQr95G04bS3bK6CNVWWIdlvHRgijRGEqRqNOZXTBivWiDY1Pq8ik
        xmFpA1VmfgYyiAzIiwI8C+zGbtKARJQEmxHsqOgVcMEXBM3uz3wucCOoM+nJvxZnpZ3HFU4j
        uNB+btDyBoG757HQoxLgIGh+94wwIIrywevg+CGVJ03gPAQnivw9PAIvhJ6y23+akngSVHRf
        4XtYjMPhtauC4IaNA70jD3nYCyvgzNmeQY03NOS7SK7nONh5oZDw7AD4HgW1P/sHzQtgZ9Yn
        xPEI6LRXCTn2h8aD2SRnOIjgev9HIReUIzi1vZvHqeZC5gOX0HMBgQPBUhPsQcDz4en9TRwO
        B+d7b26H4XDgYh7BpcWwRy/hegSA8eShwXfzA0fbZQHHNHz8UCPcjyYU/HdNwX/XFPwbW4KI
        MuTLpLDaOIadmcBslrFKLZuSECeLSdRa0e/v09hv765G5s5PsnrEo1A9AoqQ+ohD1taqJGKV
        cstWRpcYrUvRMGw9GkORUl/x1PCGGAmOUyYz8QyTxOj+VnmUl18GL+1RYm98tVE649bnxWpV
        qsaytJ04kL3KqvHVTAzta9Huaxr5Um3G/EVbW59bbJl3jGZW3B4dk+ra9ZUfWvueLRlYjee0
        bhvvb4no6GoKGoaPb6dx8qhsAlyxJokXE3x0emaRIn5GcTOV7EjSWEymIzm+EQ/zg0o3E7ZS
        57wmylY8VLVm9nnnbFlAc/HGWHVWdd6u1pD5fqb6S+VmU1bUcsf4aNYn7YY7Lezw3XRCEPis
        JUDfcdiZG5nreBSoyOksbzOEtqzStx17sHdx5vfRuoW28+K+rpyiuGUBu+0tkY/luX03ox4O
        Cat4IVmX++Wnou6GKHblOX7XNm3Ikq9Skt2gDJlC6FjlLzzfbYStAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42I5/e/4Pd1ajYMpBp8v8lss3f+Q0eL/gnyL
        M925Fnv2nmSxuLxrDpvFjQlPGS1+/wCylu30c+DwmN1wkcVjwaZSj80rtDxuvbb12LSqk82j
        b8sqRo/Pm+QC2KP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLL
        Uov07RL0Mk7f3sJScJqn4v+WFawNjF1cXYycHBICJhI3Nh9n6mLk4hASWMoo8Xr/ZLYuRg6g
        hJTE92WcEDXCEn+udbFB1DxnlFjVOpcdJMEmoCNx/s0dZhBbRCBeYubj+2CDmAVmM0qsPnkI
        LCEs4CrxfdVRFhCbRUBVYs3X3awgNq+ArcSzJ2uYITbIS7Rdn84IYnMK2EmsXPsdrEYIqKZn
        6lN2iHpBiZMzn4DNYQaqb946m3kCo8AsJKlZSFILGJlWMYqklhbnpucWG+oVJ+YWl+al6yXn
        525iBMbJtmM/N+9gnPfqo94hRiYOxkOMEhzMSiK8hjH7UoR4UxIrq1KL8uOLSnNSiw8xmgLd
        PZFZSjQ5HxipeSXxhmYGpoYmZpYGppZmxkrivJ4FHYlCAumJJanZqakFqUUwfUwcnFINTCcZ
        /GIuexjN/dzsIB/A+uKG82Tjm02Pw5n1PFY0P3jyZGbbtuLZW0KFBYrWxwjuYPbmVc22mzF7
        /Z/LcVHJsu9vGnd7+YTtifhYs/x3gkbEle0eqhdPZF8RY+T59G5x+8F0qfWrdknKrpXfdlJB
        qmvTwr/8HS9uODyf1BeywCTeeuO8z21/m4xKPs/Y8X3uzjj3/W/mVG2TzozZ9qyId+Ii0amW
        C6XPfxfLk/kw9eSd4Jdnks/cnc/hdf1oeFrDiy3flXfyGi+UYe7P9m98KfDr0mqVWouAz262
        GyKDDl54OHVBU5V80YFMK8+vbMlllq7F/urrNZgMG0P/bVY61vlKPZzzq+ZthlUCM/X+flNi
        Kc5INNRiLipOBAChSKibHAMAAA==
X-CMS-MailID: 20230726140653eucas1p2e234b7cd0af5dc506bd27399b84292a6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230726140653eucas1p2e234b7cd0af5dc506bd27399b84292a6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230726140653eucas1p2e234b7cd0af5dc506bd27399b84292a6
References: <20230726140635.2059334-1-j.granados@samsung.com>
        <CGME20230726140653eucas1p2e234b7cd0af5dc506bd27399b84292a6@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The new ctl_table_size element will hold the size of the ctl_table
contained in the header. This value is passed by the callers to the
sysctl register infrastructure.

This is a preparation commit that allows us to systematically add
ctl_table_size and start using it only when it is in all the places
where there is a sysctl registration.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 include/linux/sysctl.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 59d451f455bf..33252ad58ebe 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -159,12 +159,22 @@ struct ctl_node {
 	struct ctl_table_header *header;
 };
 
-/* struct ctl_table_header is used to maintain dynamic lists of
-   struct ctl_table trees. */
+/**
+ * struct ctl_table_header - maintains dynamic lists of struct ctl_table trees
+ * @ctl_table: pointer to the first element in ctl_table array
+ * @ctl_table_size: number of elements pointed by @ctl_table
+ * @used: The entry will never be touched when equal to 0.
+ * @count: Upped every time something is added to @inodes and downed every time
+ *         something is removed from inodes
+ * @nreg: When nreg drops to 0 the ctl_table_header will be unregistered.
+ * @rcu: Delays the freeing of the inode. Introduced with "unfuck proc_sysctl ->d_compare()"
+ *
+ */
 struct ctl_table_header {
 	union {
 		struct {
 			struct ctl_table *ctl_table;
+			int ctl_table_size;
 			int used;
 			int count;
 			int nreg;
-- 
2.30.2

