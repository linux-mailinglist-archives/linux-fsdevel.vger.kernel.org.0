Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672486E21BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 13:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjDNLIe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 07:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjDNLIc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:08:32 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60344199
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 04:08:29 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230414110827euoutp02937ad90799f08982ff53b97a81f790fd~VyISSaBtr0810608106euoutp02f
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 11:08:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230414110827euoutp02937ad90799f08982ff53b97a81f790fd~VyISSaBtr0810608106euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681470507;
        bh=lOgNCG8+j9glN6g01kkt3qiHQuDvi5vkCnsii6V5uAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iWE/tHfMioyKOEecs7lOsNIQD2wiGi4J7iD8mokUHLffG+SDIfB67l00xjQU6B7l8
         SDbJgpoQjal9+YvVKmOUsjsoV0e9GkVPr184l8ekaZjt7e13/2G9v/YrDEpYeXsTjY
         tm5O2pRzURtX+2At0XfxyEaJTluNzrFPEvCtFcCs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230414110826eucas1p2801083c055bbebf8b958862c5a463047~VyIRh-Xsc3134131341eucas1p21;
        Fri, 14 Apr 2023 11:08:26 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 1D.25.09966.A2439346; Fri, 14
        Apr 2023 12:08:26 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230414110826eucas1p2c5afcbd64c536a803751b41d03eb9e99~VyIRPTb5z0087400874eucas1p2A;
        Fri, 14 Apr 2023 11:08:26 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230414110826eusmtrp201580c3c89bd58675a349e7c6c7667b0~VyIROq8NL0913109131eusmtrp2V;
        Fri, 14 Apr 2023 11:08:26 +0000 (GMT)
X-AuditID: cbfec7f4-d39ff700000026ee-e8-6439342a5fc5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id FD.39.34412.A2439346; Fri, 14
        Apr 2023 12:08:26 +0100 (BST)
Received: from localhost (unknown [106.210.248.243]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230414110826eusmtip2f71aa69c101c25276f134b498a5df907~VyIRCV4Yn2606126061eusmtip2f;
        Fri, 14 Apr 2023 11:08:26 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     brauner@kernel.org, willy@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org, gost.dev@samsung.com, hare@suse.de,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [RFC 2/4] buffer: add alloc_folio_buffers() helper
Date:   Fri, 14 Apr 2023 13:08:19 +0200
Message-Id: <20230414110821.21548-3-p.raghav@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414110821.21548-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe3fm2XE4Oc7KB7O0dTOb617HZlphdKI++KWIAm3p8VJz2ubK
        MkIrlkuadsNLC+1m5qqRM2tm1IyctzAScjNQyllpmXjBVlLL0zHqy8vveZ7//7nAS2Diq16B
        RKoqk1GrFEoJLuTXNn5vDw9bFZG4zHMinDKa7+DU5+cjiHI+s/Ko+mvnJ58nzXyqo86IU47C
        PkSN3jwloNp/2r2oCbcR3yCkLZVhdHWVHqebiif4tKGmCtGW1mx6tHoOXe0a5MUKdgsjExll
        6iFGvTRqrzDF9jguI98va3jYg+egDtEZ5E0AuQp+OnWCM0hIiMlKBOc8N3hcMIbA8L4XccEo
        gp47bZMV4o/FrMNZt5i8hSC/7CCn6UdQ9sSOsxqcDINcvYDF6aQCnEMhrAQjyxF0vR0SsF5/
        Ug4FZ99hrIZPLoB7RTPZtIiMgEsOC8YtFwxPbS//sDe5Dr5UvMI5jR80l7j4LGOTmpMPLmNs
        fyAdBHzS26fWjIFc51qujz8M2GsEHAeBx1rG4zgb+hwTU95TCAqsZpzzysHQpmQRIxeDuW4p
        l90ITXd9OPQFx6Aft4AvnK8twri0CPJ0Yq63BKzfXVMzATpOGPkc0/Cuv5hXiOaW/ndK6X+n
        lP4bW46wKhTAaDVpyYxmhYo5LNMo0jRaVbIsIT2tGk3+otZf9rFH6NbAsKwB8QjUgIDAJNNF
        7pjViWJRouLIUUadHq/WKhlNA5pF8CUBoiXrmxPEZLIikznAMBmM+m+VR3gH5vC2aRttzs6d
        oc7YlTJp34buo9evXxgx1gy0fu2Wz1980rO7IijeYDt+3/Si7/TqlixMF1m5fWfJh0UTys+h
        x0zFTne0uz1jmly9OQl9eFE/3lnulRC1LMbHd98W/ZCtPiM7pKjQbFaVmnJedlrrev1zXeMf
        b+8ojBxcfm1XQEKgYEwKc0+3RPlGydJveDK7b2syFzZIIoINMxrF1jV3u0YtsXrp3iYzQeRZ
        HAsC3uS3B/UG/6Dd65KG52zdNH7xERUnf9MvbYkuAmlFj3+X+0pc6EqtK+Ss38M9i1Iff7PF
        Pzw4+9nhp9S55IrQmHlV+1X31qMa3ad9pte1M/LrTd15Er4mRbE8DFNrFL8B/RPjZLQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsVy+t/xe7paJpYpBtveSFjMWb+GzeL14U+M
        FjcP7GSy2LNoEpDYe5LF4vKuOWwWNyY8ZbT4vLSF3eL83+OsFr9/zGFz4PLYvELLY9OqTjaP
        EzN+s3j0bVnF6LH5dLXH501yHpuevGUKYI/SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQz
        NDaPtTIyVdK3s0lJzcksSy3St0vQyzi4O66gW7Di48f/bA2Ml3m7GDk4JARMJNa3sXUxcnEI
        CSxllNh4YjZrFyMnUFxC4vbCJkYIW1jiz7UuqKLnjBIn52xjB2lmE9CSaOxkB6kREUiVOH3i
        I1gNs8AyRok1c1+wgSSEBawl+nsfMoPUswioSqybLgYS5hWwlJh6YzMzxHx5if0Hz4LZnAJW
        Em+WXQBrFQKqad+yhAWiXlDi5MwnYDYzUH3z1tnMExgFZiFJzUKSWsDItIpRJLW0ODc9t9hI
        rzgxt7g0L10vOT93EyMwerYd+7llB+PKVx/1DjEycTAeYpTgYFYS4f3hYpoixJuSWFmVWpQf
        X1Sak1p8iNEU6OyJzFKiyfnA+M0riTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5NLUgt
        gulj4uCUamCa+16y507ZkiPKpbof33/4c6v73aW7PjEptosKFrDFRIgEnt56I9QpaX1l3f5d
        1TvNml4+PZddfO+gGt/K7zOic8xEk07sjeypyP70/qDA758tBjlG00PqJnz+z1uvvrL/jp7l
        bFe9DfLhP6sfiNcKWNiHrby8hPX8lN/Z/h/dw7RF9y1fc0tn4UqvSQ+mBDU/vF3d+lTSQ9Wh
        T8ghRHu7xAqDrY/vvQv9lauusOJsj/RE9d8KdpZph7UWvpNYNH/z2yLd+A8nvt/1bDcUWXE3
        T3PmJPXC/hsRokz8uj9nrb0deXbbPd8Oh5uv1oWph79dlbO/5NodwbSHLDle7438pinnCC6v
        nNIeYGH0Z/4XJZbijERDLeai4kQAKyWFnycDAAA=
X-CMS-MailID: 20230414110826eucas1p2c5afcbd64c536a803751b41d03eb9e99
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230414110826eucas1p2c5afcbd64c536a803751b41d03eb9e99
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230414110826eucas1p2c5afcbd64c536a803751b41d03eb9e99
References: <20230414110821.21548-1-p.raghav@samsung.com>
        <CGME20230414110826eucas1p2c5afcbd64c536a803751b41d03eb9e99@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Folio version of alloc_page_buffers() helper. This is required to convert
create_page_buffers() to create_folio_buffers() later in the series.

It removes one call to compound_head() compared to alloc_page_buffers().

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/buffer.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index 44380ff3a31f..0f9c2127543d 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -900,6 +900,65 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 }
 EXPORT_SYMBOL_GPL(alloc_page_buffers);
 
+/*
+ * Create the appropriate buffers when given a folio for data area and
+ * the size of each buffer.. Use the bh->b_this_page linked list to
+ * follow the buffers created.  Return NULL if unable to create more
+ * buffers.
+ *
+ * The retry flag is used to differentiate async IO (paging, swapping)
+ * which may not fail from ordinary buffer allocations.
+ */
+struct buffer_head *alloc_folio_buffers(struct folio *folio, unsigned long size,
+					bool retry)
+{
+	struct buffer_head *bh, *head;
+	gfp_t gfp = GFP_NOFS | __GFP_ACCOUNT;
+	long offset;
+	struct mem_cgroup *memcg, *old_memcg;
+
+	if (retry)
+		gfp |= __GFP_NOFAIL;
+
+	/* The folio lock pins the memcg */
+	memcg = folio_memcg(folio);
+	old_memcg = set_active_memcg(memcg);
+
+	head = NULL;
+	offset = folio_size(folio);
+	while ((offset -= size) >= 0) {
+		bh = alloc_buffer_head(gfp);
+		if (!bh)
+			goto no_grow;
+
+		bh->b_this_page = head;
+		bh->b_blocknr = -1;
+		head = bh;
+
+		bh->b_size = size;
+
+		/* Link the buffer to its folio */
+		set_bh_folio(bh, folio, offset);
+	}
+out:
+	set_active_memcg(old_memcg);
+	return head;
+/*
+ * In case anything failed, we just free everything we got.
+ */
+no_grow:
+	if (head) {
+		do {
+			bh = head;
+			head = head->b_this_page;
+			free_buffer_head(bh);
+		} while (head);
+	}
+
+	goto out;
+}
+EXPORT_SYMBOL_GPL(alloc_folio_buffers);
+
 static inline void
 link_dev_buffers(struct page *page, struct buffer_head *head)
 {
-- 
2.34.1

