Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D916593D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Dec 2022 01:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbiL3AaM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Dec 2022 19:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiL3AaK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Dec 2022 19:30:10 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F72164B3
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Dec 2022 16:30:05 -0800 (PST)
Received: from epcas3p3.samsung.com (unknown [182.195.41.21])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221230003002epoutp04c38a803d4f5a5186080969c3340f20c7~1ar5RAYVH1590315903epoutp04X
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Dec 2022 00:30:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221230003002epoutp04c38a803d4f5a5186080969c3340f20c7~1ar5RAYVH1590315903epoutp04X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1672360202;
        bh=+tvtuSUWl1NzTezDXYG0Z6wCNch06t+kT3NNHwqxPys=;
        h=From:To:Cc:Subject:Date:References:From;
        b=eJvj8DIsPPnWe3zhKQUjnYns6IJFiIkKZOSOFBQkXEcG3Usp6CbLPGGPVLaj5J9RB
         J1pI/ELmkEHaKV5DXmVvBtOKJnXCvH5dHOBa/+YCuJxBihImorwaoXpJ4TNF6QOheM
         EVgBi/HxDvqeK8u27ZYSig2knM1EG5rK/lvqXBz4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas3p3.samsung.com (KnoxPortal) with ESMTP id
        20221230003001epcas3p3363d51c49cbbc6de4379d25b9622fbce~1ar46CLWH1067710677epcas3p3B;
        Fri, 30 Dec 2022 00:30:01 +0000 (GMT)
Received: from epcpadp3 (unknown [182.195.40.17]) by epsnrtp1.localdomain
        (Postfix) with ESMTP id 4NjmP55KHRz4x9Q0; Fri, 30 Dec 2022 00:30:01 +0000
        (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20221229115257epcas1p27195844dc54cf09608dad9967808530a~1QW4L37ph2094120941epcas1p2w;
        Thu, 29 Dec 2022 11:52:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221229115257epsmtrp1d43ffca1fd9e78952882933bda8838ba~1QW4LKav82629826298epsmtrp14;
        Thu, 29 Dec 2022 11:52:57 +0000 (GMT)
X-AuditID: b6c32a29-f05bc700000008a3-dc-63ad7f99bacb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7B.74.02211.99F7DA36; Thu, 29 Dec 2022 20:52:57 +0900 (KST)
Received: from u20pb1-0435.tn.corp.samsungelectronics.net (unknown
        [10.91.133.14]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221229115257epsmtip183731033688138e7f4e545a6111df90b~1QW373ajx1835018350epsmtip1K;
        Thu, 29 Dec 2022 11:52:57 +0000 (GMT)
From:   Sungjong Seo <sj1557.seo@samsung.com>
To:     linkinjeon@kernel.org
Cc:     pali@kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Yuezhang Mo <Yuezhang.Mo@sony.com>
Subject: [PATCH] exfat: redefine DIR_DELETED as the bad cluster number
Date:   Thu, 29 Dec 2022 20:52:38 +0900
Message-Id: <1891546521.01672360201726.JavaMail.epsvc@epcpadp3>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHLMWRmVeSWpSXmKPExsWy7bCSnO7M+rXJBreXSli8PKRpMXHaUmaL
        PXtPslhc3jWHzWLBntNsFlv+HWG1OP/3OKvF9TcPWR04PDat6mTz6NuyitGjfcJOZo/Pm+Q8
        Nj15yxTAGsVlk5Kak1mWWqRvl8CVMWn/YaaCFs6Kf+cXMzUwHmLvYuTgkBAwkXh/wLeLkYtD
        SGA3o8SJ3o2MEHEpiYP7NCFMYYnDh4u7GDmBSlqZJB5MLwCx2QS0JZY3LWMGKRERkJRYez8V
        ZAqzwD5GiU3LnjOD1AgLuEnMuvuECaSGRUBVYtGxSJAwr4CtxJOm/4wgtoSAvMTMS9/ZIeKC
        EidnPmEBsZmB4s1bZzNPYOSbhSQ1C0lqASPTKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT8
        3E2M4CDV0tzBuH3VB71DjEwcjIcYJTiYlUR4Nc6uThbiTUmsrEotyo8vKs1JLT7EKM3BoiTO
        e6HrZLyQQHpiSWp2ampBahFMlomDU6qBKTPAIZ9zadvEFc3b6wIPzvWXrH7pckJGIo+JdUfC
        87taIk4HHVkO393BN+nrA5M7nvodK2Yzm2yJyZ+duXZFtebm3f7rr01rY0qze7fkUe8fYd0b
        PIbzjLWcPRdaBX6e0nrEKWHXS2XJ53o5MvYySdNKt72IOTXDTGKh5ZfUyAf8NVdLDxrqbVv4
        VYuR2XW+7OxklrKF2oU8cQprV3JdVut5t+KZ8OHO9Q+5RPJLI3zvKVdnpigYOBVYaq+6WCCv
        z/d/09GEpKXrvddoHbD8Gp9eOM/llnPH7eZPvMWnZ27mnKYSzsj8wcn0idKKU+6up4+sUOze
        MUEo7t7m2Isc/zSOyyyzUrOcNlUofMomJZbijERDLeai4kQA4hbc98ECAAA=
X-CMS-MailID: 20221229115257epcas1p27195844dc54cf09608dad9967808530a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
X-CPGSPASS: Y
X-ArchiveUser: EV
X-Hop-Count: 3
X-CMS-RootMailID: 20221229115257epcas1p27195844dc54cf09608dad9967808530a
References: <CGME20221229115257epcas1p27195844dc54cf09608dad9967808530a@epcas1p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When a file or a directory is deleted, the hint for the cluster of
its parent directory in its in-memory inode is set as DIR_DELETED.
Therefore, DIR_DELETED must be one of invalid cluster numbers. According
to the exFAT specification, a volume can have at most 2^32-11 clusters.
However, DIR_DELETED is wrongly defined as 0xFFFF0321, which could be
a valid cluster number. To fix it, let's redefine DIR_DELETED as
0xFFFFFFF7, the bad cluster number.

Fixes: 1acf1a564b60 ("exfat: add in-memory and on-disk structures and headers")

Reported-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 fs/exfat/exfat_fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index bc6d21d7c5ad..25a5df0fdfe0 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -50,7 +50,7 @@ enum {
 #define ES_IDX_LAST_FILENAME(name_len)	\
 	(ES_IDX_FIRST_FILENAME + EXFAT_FILENAME_ENTRY_NUM(name_len) - 1)
 
-#define DIR_DELETED		0xFFFF0321
+#define DIR_DELETED		0xFFFFFFF7
 
 /* type values */
 #define TYPE_UNUSED		0x0000
-- 
2.25.1


