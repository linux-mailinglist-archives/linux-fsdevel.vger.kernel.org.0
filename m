Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6208737EC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 11:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjFUJKW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 05:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjFUJKM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:10:12 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FE7E60
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 02:10:10 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230621091009euoutp01414855c9150d6df69414892a6173bf5a~qoYaC9OOX1127311273euoutp01E
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 09:10:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230621091009euoutp01414855c9150d6df69414892a6173bf5a~qoYaC9OOX1127311273euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687338609;
        bh=2vCkgLvpZCXFi6D3nJ5E3ic3+Plkyq+z4m9VdlmF+tc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=p45yve07kwC68GtIMT5d4UuvqBOWu2cSFwoZ+ynWNWeyF94KAVcnnUOKpMasfav0J
         NM9OkqPVg7Ffa4vHM/Jjair7jLwFviLCYq93asj8ACGqif2BQ06zXYrwfY+wJ3/xpl
         FHLXcMpc3oSPrcrQw6bJZWow/cfpIN0AHIsbq5QY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230621091009eucas1p15b47d6bbe8cea318f99993a88cfe9fdc~qoYZ8Xc-m1959619596eucas1p1P;
        Wed, 21 Jun 2023 09:10:09 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 94.22.42423.17EB2946; Wed, 21
        Jun 2023 10:10:09 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230621091009eucas1p1e4fa56beb44e49e4d1160bfac6eb59ec~qoYZmI4cE2902229022eucas1p1L;
        Wed, 21 Jun 2023 09:10:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230621091009eusmtrp255bd4fcf710e16ebcd0800c2e9b5b1b2~qoYZlkJ072182221822eusmtrp2A;
        Wed, 21 Jun 2023 09:10:09 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-23-6492be71e45a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0B.D1.14344.07EB2946; Wed, 21
        Jun 2023 10:10:08 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230621091008eusmtip11efe1355c1286893018073e5816c5420~qoYZcDnZn2784427844eusmtip1L;
        Wed, 21 Jun 2023 09:10:08 +0000 (GMT)
Received: from localhost (106.210.248.248) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 21 Jun 2023 10:10:08 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
CC:     Joel Granados <j.granados@samsung.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH 03/11] sysctl: Add ctl_table_size to ctl_table_header
Date:   Wed, 21 Jun 2023 11:09:52 +0200
Message-ID: <20230621091000.424843-4-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230621091000.424843-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.248]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42LZduzned3CfZNSDO4tErQ4051rsWfvSRaL
        y7vmsFncmPCU0WLZTj8HVo/ZDRdZPBZsKvXYtKqTzePzJrkAligum5TUnMyy1CJ9uwSujF/f
        rjIV7OCpmHLxIHsD43fOLkYODgkBE4nd78K6GLk4hARWMEqsndjIBuF8YZRYsHw7M4TzmVHi
        7ubZQBlOsI5djRehqpYzSrz/dIIFrqphWyMrhLOVUWLW/yXMIC1sAjoS59/cAbNFBOIlZq/Z
        zghiMwvkSsxaDlEjLOAq8fzbDCYQm0VAVeJf7wawdbwCNhLzFjxlh1gtL9F2fTpYL6eArcT5
        x+9ZIGoEJU7OfMICMVNeonnrbGYIW0Li4IsXzBC9yhLX9y2GeqFW4tSWW0wgh0oIXOCQaFt3
        mREi4SKx9+kzqAZhiVfHt0AtlpH4v3M+VMNkRon9/z6wQzirGSWWNX5lgqiylmi58gSqw1Gi
        cfEVVkgY80nceCsIcRGfxKRt05khwrwSHW1CExhVZiH5YRaSH2Yh+WEBI/MqRvHU0uLc9NRi
        w7zUcr3ixNzi0rx0veT83E2MwHRy+t/xTzsY5776qHeIkYmD8RCjBAezkgiv7KZJKUK8KYmV
        ValF+fFFpTmpxYcYpTlYlMR5tW1PJgsJpCeWpGanphakFsFkmTg4pRqYxBVvHrhdZ3dUmqm+
        8uC9KhtmNRXXi1emWC1xXmu7oa1tlbcI58IT9nyFwtV17vc/mWd8vbf8xrkP3/dsOmH7zeHN
        2gtXO0NS/fpnORw8di/86MJlSaVT7OY5er0JVOviP7hDxt9upfwFw4/b1s1Nidh472Wx9rZn
        EkmOex5vKeXVsfc1qnnCHfvO9HtWcdfnk9Wni9kXrP8rqsOxkOfW/4U933j7Vk658emGfMnU
        +er5K05euXT3oZqCaYr3F7mlXxVsn/A0vMj95Tkt+L3PJqFrCyq3WbZsvd40I3hJjPWO7e2X
        JoUU7vA9K/RHaP89qV979266xv//ncrvf335xq9//r/Vd3LxqZBbncE79pUrsRRnJBpqMRcV
        JwIATg9LHJYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsVy+t/xu7oF+yalGLz6YGlxpjvXYs/ekywW
        l3fNYbO4MeEpo8WynX4OrB6zGy6yeCzYVOqxaVUnm8fnTXIBLFF6NkX5pSWpChn5xSW2StGG
        FkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6Gb++XWUq2MFTMeXiQfYGxu+cXYyc
        HBICJhK7Gi+ydTFycQgJLGWU+Ne6gg0iISOx8ctVVghbWOLPtS6ooo+MEo0L37NDOFsZJb5P
        msoOUsUmoCNx/s0dZhBbRCBeYvaa7YwgNrNArsSs5UvA4sICrhLPv81gArFZBFQl/vVuANvG
        K2AjMW/BU3aIbfISbdeng/VyCthKnH/8ngXEFgKqmf/hMiNEvaDEyZlPWCDmy0s0b53NDGFL
        SBx88YIZYo6yxPV9i6G+qZX4/PcZ4wRGkVlI2mchaZ+FpH0BI/MqRpHU0uLc9NxiI73ixNzi
        0rx0veT83E2MwFjbduznlh2MK1991DvEyMTBeIhRgoNZSYRXdtOkFCHelMTKqtSi/Pii0pzU
        4kOMpkB/TmSWEk3OB0Z7Xkm8oZmBqaGJmaWBqaWZsZI4r2dBR6KQQHpiSWp2ampBahFMHxMH
        p1QDk5PFL31en64ZJ/XUoy2vrtjByV5j2PzakdH+zEeGvx5Lf2zgms75sv5S+IGdEqvmcqpf
        akreosbdoLS2XIwn/VKbyprGLwb11vuOha6ZuHL2pyNNRzucstxfi5RZXWLsE20Wz+KSfyss
        cl0le0GLZCjPqY+yc2Zt1N+vpeMkJfVH0Vq06cDa94oWum8Xbcl77TzpzaXDdcerhaRY1p+2
        +vdOSLvbS5g/8fKKPUv8dzDdPGt3+lTInO1u64Jz1s/KnHBC0NGQWW3jjADX7TF/xa0+zo4o
        qLjlmnGlrO7LW4+/bwNXnpjU7rXnarHJrYV6K1L2ifksVtjv9nAqD6PN3edbA/Z/uXBFeEH0
        jOlNfEosxRmJhlrMRcWJAGf+NPc+AwAA
X-CMS-MailID: 20230621091009eucas1p1e4fa56beb44e49e4d1160bfac6eb59ec
X-Msg-Generator: CA
X-RootMTR: 20230621091009eucas1p1e4fa56beb44e49e4d1160bfac6eb59ec
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230621091009eucas1p1e4fa56beb44e49e4d1160bfac6eb59ec
References: <20230621091000.424843-1-j.granados@samsung.com>
        <CGME20230621091009eucas1p1e4fa56beb44e49e4d1160bfac6eb59ec@eucas1p1.samsung.com>
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
sysctl register infra.
Add a new macro that uses the size to traverse the ctl_table in the
header. This moves away from using the last empty element in the
ctl_table array as a stop post

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

