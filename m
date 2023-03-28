Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1616CBD97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 13:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjC1L13 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 07:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjC1L11 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:27:27 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03E51FFB
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 04:27:22 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230328112721euoutp02532b2385a50071116877c9b92372c017~Qka7VAROK3247932479euoutp02d
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 11:27:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230328112721euoutp02532b2385a50071116877c9b92372c017~Qka7VAROK3247932479euoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680002841;
        bh=CdQ/QAA4HUstxavQOVZ/jTlQypv2+dxHUXTfyjJfsFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VlzGtKbKqfX+5cBNh5Hh7eQh+UnR46lbFD2VmnTOtRDIpE6gKEtgCRlBFqS2RIXKI
         s7aYIGYbJplH+ki6LLrAEkWShD65oAX4NuiIKVfnxUopgZLDdbiZX6TZjLBCc5HkaO
         2kjH53fd4S6va4PhcQ6VD62owlvOgtpt4UgtmNBI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230328112719eucas1p10474fc62f4ae26a7ac767e7ac1743a89~Qka50krkB2133321333eucas1p1P;
        Tue, 28 Mar 2023 11:27:19 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id A8.01.09966.71FC2246; Tue, 28
        Mar 2023 12:27:19 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230328112718eucas1p263dacecb2a59f5fce510f81685f9d497~Qka5WYQr60534405344eucas1p2V;
        Tue, 28 Mar 2023 11:27:18 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230328112718eusmtrp13eff014ff761dc9f74c78ad532d3ee62~Qka5VkdI00876308763eusmtrp1T;
        Tue, 28 Mar 2023 11:27:18 +0000 (GMT)
X-AuditID: cbfec7f4-d39ff700000026ee-21-6422cf1759f9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 1F.19.08862.61FC2246; Tue, 28
        Mar 2023 12:27:18 +0100 (BST)
Received: from localhost (unknown [106.210.248.108]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230328112718eusmtip26b96643ca4ec913cd0e3480ce3a23477~Qka5JB9ZZ0051900519eusmtip2L;
        Tue, 28 Mar 2023 11:27:18 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     martin@omnibond.com, axboe@kernel.dk, minchan@kernel.org,
        akpm@linux-foundation.org, hubcap@omnibond.com,
        willy@infradead.org, viro@zeniv.linux.org.uk,
        senozhatsky@chromium.org, brauner@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        mcgrof@kernel.org, linux-block@vger.kernel.org,
        gost.dev@samsung.com, linux-mm@kvack.org, devel@lists.orangefs.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 2/5] orangefs: use folios in orangefs_readahead
Date:   Tue, 28 Mar 2023 13:27:13 +0200
Message-Id: <20230328112716.50120-3-p.raghav@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230328112716.50120-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFKsWRmVeSWpSXmKPExsWy7djPc7ri55VSDJaeFbWYs34Nm8Xqu/1s
        Fq8Pf2K02L95CpPFzQM7mSza7/YxWey9pW2xZ+9JFovLu+awWdxb85/V4uT6/8wWNyY8ZbRY
        9vU9u8XnpS3sFrs3LmKzOP/3OKvF7x9z2BwEPWY3XGTx2LxCy+Py2VKPTas62Tw2fZrE7nFi
        xm8Wj4apt9g8ft2+w+rRt2UVo8fnTXIem568ZQrgjuKySUnNySxLLdK3S+DKuLnsLmvBc86K
        PSeOsjYw/mLvYuTkkBAwkTizcjtrFyMXh5DACkaJtVtWskE4Xxgl5kzrZYJwPjNK9P9qYoJp
        ObjpDjNEYjmjxL/n7YwQzktGidd/NwNVcXCwCWhJNHayg8RFBM4wSixe3gg2l1ngPqPEt5fn
        wYqEBewljvWlgJgsAqoSF+7FgJi8ApYSfw4EQeySl9h/8CwzSJhTwEpi2m8rkDCvgKDEyZlP
        WEBsZqCS5q2zmSHKV3NKPN1aCWG7SHR/3ggVF5Z4dXwL1McyEqcn97BA2NUST2/8BntFQqAF
        6Med69lAdkkIWEv0nckBMZkFNCXW79KHKHeUON++hBmigk/ixltBiAv4JCZtmw4V5pXoaBOC
        qFaS2PnzCdRSCYnLTXOglnpIXD63iH0Co+IsJL/MQvLLLIS9CxiZVzGKp5YW56anFhvlpZbr
        FSfmFpfmpesl5+duYgQmv9P/jn/Zwbj81Ue9Q4xMHIyHGCU4mJVEeDd7K6YI8aYkVlalFuXH
        F5XmpBYfYpTmYFES59W2PZksJJCeWJKanZpakFoEk2Xi4JRqYNI/M/dBa/fr/Xmb/06s/nDg
        yNSPr6V229pGqh/ifS5i0yjmz7S3Ud5wUcOcxby1K6dP+vL9i3LzzM4QpkuSk2d8EDKYdjNf
        Sv5ese/Tj2XR8Z9c39aH9rdtv3upKFa2Z0PlWSH9qOu+50tcjvAFikXqTMs3Ph2v2LDbZ9Hq
        80cvS+1p/rw0MGGta2boh+xHLg9U7Dw5Xr9rM5i80V4/eZKMk7Rw7BTnfY+Znx0+VVsm8/hb
        E+fpqCtcvhZh31bPfXj+/aUTbdnSMzvTUr7ts/Zf4shVGDs7P+y46NxLRhM3Sx3VYHnW9Dpc
        x8y5xeDjl1sdHizqX24VfXlmMo/nmHRm6YVn97d8n7GNTe2PkKASS3FGoqEWc1FxIgBcAppX
        7QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsVy+t/xe7pi55VSDL58MLOYs34Nm8Xqu/1s
        Fq8Pf2K02L95CpPFzQM7mSza7/YxWey9pW2xZ+9JFovLu+awWdxb85/V4uT6/8wWNyY8ZbRY
        9vU9u8XnpS3sFrs3LmKzOP/3OKvF7x9z2BwEPWY3XGTx2LxCy+Py2VKPTas62Tw2fZrE7nFi
        xm8Wj4apt9g8ft2+w+rRt2UVo8fnTXIem568ZQrgjtKzKcovLUlVyMgvLrFVija0MNIztLTQ
        MzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLuLnsLmvBc86KPSeOsjYw/mLvYuTkkBAwkTi4
        6Q5zFyMXh5DAUkaJmwfPQiUkJG4vbGKEsIUl/lzrYoMoes4oMWPLcaAODg42AS2Jxk52kLiI
        wA1GibVPf7GCOMwgRXf3vWYFKRIWsJc41pcCYrIIqEpcuBcDYvIKWEr8ORAEMV5eYv/Bs2AT
        OQWsJKb9tgIJCwFVXD3zHuwCXgFBiZMzn7CA2MxA5c1bZzNPYBSYhSQ1C0lqASPTKkaR1NLi
        3PTcYkO94sTc4tK8dL3k/NxNjMBI3Xbs5+YdjPNefdQ7xMjEwXiIUYKDWUmEd7O3YooQb0pi
        ZVVqUX58UWlOavEhRlOgoycyS4km5wNTRV5JvKGZgamhiZmlgamlmbGSOK9nQUeikEB6Yklq
        dmpqQWoRTB8TB6dUA9NRfbesI9a7PnUauj5sOjnZfOm0Sq9kfqa79zfuX77iXT/nxNu61mt1
        1zNe/3nvE9OTddHeCwoOXe16tfOK++VrKrW35zHLl7yuPWKQ+2PCJUEhYUPpnOKSaVe8PdZP
        PHF/o5Ag/ybXm7Mn80/mSLglJs14QHPFU45+2X2JRgGbFhyc36yvPS9pjtKPDsHJv5ZmFj98
        VOhsqKaV3lEyX4XXseeAf3bsLqY1IXP/i0oKP4/+/1Jvbp6BTvKtl0d28D1QurRcy+9NydEA
        voSNBqG79lekLwteyJx+6PNRvYsBU86yVm1YdSVP8dPE5kiD8yqaPyxyN1fYPO31OvwioELo
        r8vdO6fsEmbu/aeVYTpBiaU4I9FQi7moOBEAcj2KYl0DAAA=
X-CMS-MailID: 20230328112718eucas1p263dacecb2a59f5fce510f81685f9d497
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230328112718eucas1p263dacecb2a59f5fce510f81685f9d497
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230328112718eucas1p263dacecb2a59f5fce510f81685f9d497
References: <20230328112716.50120-1-p.raghav@samsung.com>
        <CGME20230328112718eucas1p263dacecb2a59f5fce510f81685f9d497@eucas1p2.samsung.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert orangefs_readahead() from using struct page to struct folio.
This conversion removes the call to page_endio() which is soon to be
removed, and simplifies the final page handling.

The page error flags is not required to be set in the error case as
orangefs doesn't depend on them.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/orangefs/inode.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index aefdf1d3be7c..9014bbcc8031 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -244,7 +244,7 @@ static void orangefs_readahead(struct readahead_control *rac)
 	struct iov_iter iter;
 	struct inode *inode = rac->mapping->host;
 	struct xarray *i_pages;
-	struct page *page;
+	struct folio *folio;
 	loff_t new_start = readahead_pos(rac);
 	int ret;
 	size_t new_len = 0;
@@ -275,9 +275,10 @@ static void orangefs_readahead(struct readahead_control *rac)
 		ret = 0;
 
 	/* clean up. */
-	while ((page = readahead_page(rac))) {
-		page_endio(page, false, ret);
-		put_page(page);
+	while ((folio = readahead_folio(rac))) {
+		if (!ret)
+			folio_mark_uptodate(folio);
+		folio_unlock(folio);
 	}
 }
 
-- 
2.34.1

