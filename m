Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41635778D68
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 13:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbjHKLUo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 07:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbjHKLUc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:20:32 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A34E1FE1
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 04:20:19 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230811112015epoutp03d793a24b3ebb0eee9adc68517b558888~6UDj0CUbP0704307043epoutp03s
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 11:20:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230811112015epoutp03d793a24b3ebb0eee9adc68517b558888~6UDj0CUbP0704307043epoutp03s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1691752815;
        bh=MgYJBFtmH7216xSYBP2FX2+G/oY64phd7tAep8xj414=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kLjEiHBIl/69e5H9eT/n/VMQysj4wTSLh+9EuFpQLaHrivhd28bZAMGtFtyMmxheb
         StXL7vam6UtqyMYnY21IBHve5rm9e5QN20KSI1SQkosX4Kacg0hox16/Vh2JlM2ldd
         A3bLqvyKL0gmVqEnx/+LuOQMjrY0NtJLamU0wor8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230811112014epcas5p3958f8d1967ab15897bb3be62821571ed~6UDjP4Mct0795807958epcas5p39;
        Fri, 11 Aug 2023 11:20:14 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4RMhCw0bX0z4x9Pw; Fri, 11 Aug
        2023 11:20:12 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D1.F9.44250.B6916D46; Fri, 11 Aug 2023 20:20:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230811105723epcas5p468fa65dc9c5bea39d40359ce55bcd9aa~6Tvmbnr272396023960epcas5p4J;
        Fri, 11 Aug 2023 10:57:23 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230811105723epsmtrp2adcad1d7712db43b279f48d44b4483be~6TvmaM7uj2537325373epsmtrp20;
        Fri, 11 Aug 2023 10:57:23 +0000 (GMT)
X-AuditID: b6c32a4a-c4fff7000000acda-84-64d6196bc3b0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EA.01.30535.31416D46; Fri, 11 Aug 2023 19:57:23 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230811105720epsmtip243422a725f23ed8a3fb938caebd214bf~6TvivIhqg1483514835epsmtip2E;
        Fri, 11 Aug 2023 10:57:19 +0000 (GMT)
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
        gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 05/11] fs/read_write: Enable copy_file_range for block
 device.
Date:   Fri, 11 Aug 2023 16:22:48 +0530
Message-Id: <20230811105300.15889-6-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230811105300.15889-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfVRTZRzuvXe7G+g4l2nxbp5kZx5LIGBDGJePoR3N7ik6hxOco9Yf48bu
        AWTcjX1I4x8ppALlQ4OCmQEJ8VVAC3CAExpHJ0sE9AiCqUDslJKQH5GiQIyb5X/P73l/z/P7
        eM+PjwoXMDE/nTHSeobSSDFvTmd/wKvBGtGoWrYiIFpd51Hi49IllGi+UYIRs/33ATHT9ykg
        Jnt3EPa5E1xivK8LIRqbzyHEcccoINxXLQhhnwgiaj6p5RBn7AMc4kr3VxhR9a2bR9Q7lxHi
        WqkbEJ1PqlCiZXaeQ1yY2EQMLTm5O18ih27+wCGvDJpIa1MBRv5Ye4jsGc/FyFPFn3PJorw5
        jLznnuCQ82evYmRxexMgH1g3k9aZu0jC+vcyYtNoSk3rJTSTolWnM6lK6duJql2qCIVMHiyP
        IiKlEobKpJXS3fEJwXvSNavjSiUHKY1plUqgDAZpaFysXmsy0pI0rcGolNI6tUYXrgsxUJkG
        E5MawtDGaLlMFhaxmpickVbX+JCr+0nw4e+/DPNyQcO6QsDnQzwcjtVlFQJvvhDvAfBmxTDG
        BvcBLKu4x2ODBQCLT36PFgKvNcWxpV7Eg4W4HcC20jg2KR+B80dGuB5bDA+CP6/wPfxGPBeF
        bT2ngCdAcQcCr9UM8zzqDXgSnL1exvVgDr4Vni52rPECPBo6VjoA218oLLnl66G98Bg4b72M
        sSm+cKByhuPBKO4P8zpOoB5/iJd4QVvNNMJqd8P6ljS26Q3wjrOdx2IxfDBnx1icDRvLGjBW
        exhAy5gFsA87YL6rBPX4oHgAbO0OZemXYbmrBWHr+sCiJzMIywug7etneAv8rrX6X38RHP37
        I4xth4TNpxPYXRUD+NT2JbcUSCzPjWN5bhzL/5WrAdoERLTOkJlKGyJ0YQyd/d8fp2gzrWDt
        AALfsoGpyT9DHADhAweAfFS6UaBMvKwWCtSUOYfWa1V6k4Y2OEDE6rqPoeIXU7SrF8QYVfLw
        KFm4QqEIj9qukEv9BLP5J9VCPJUy0hk0raP1z3QI30ucixijk/7YufgaF6tMXawuDzTzs154
        5a+OdztH5jm2yqcXxj5Dg7itib3Ls9+k1+vj3lRtVg7EHnTWe49uoyjK+XjBd/zctNTnjVbe
        fveBmsXcsCx/G/pFx63bpbrXXe/Xr48RJS8ef1gaOeR+LB5JVkz75bxzkYnscu3p7usbh9ap
        nMx40fjdR4nrlvbNzRw1J32gYIQDU9EK12B/DveR0eeS6bc2c4GqrhaL3D7ZXHXk0FKDUxTW
        uxynow+f8dvKkUnKq65jRaroEX+m/XZnQfPgHaTy15hNLfFdZ4/uw7z2b7nYcik58UCVKXhB
        uY0wi/eaxRW7agPsRpct7/yNvdlSjiGNkgeiegP1D3PRSP2JBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsWy7bCSvK6wyLUUg2vNZhbrTx1jtmia8JfZ
        YvXdfjaL14c/MVo8OdDOaPFgv73F3nezWS1uHtjJZLFy9VEmi0mHrjFaPL06i8li7y1ti4Vt
        S1gs9uw9yWJxedccNov5y56yWyw//o/J4saEp4wW237PZ7ZY9/o9i8WJW9IW5/8eZ3UQ8zh/
        byOLx+WzpR6bVnWyeWxeUu+x+2YDm8fivsmsHr3N79g8Pj69xeLxft9VNo++LasYPT5vkvPY
        9OQtUwBPFJdNSmpOZllqkb5dAlfG0pVfWAsO8la8uHOBvYFxBXcXIyeHhICJxMS/+5m6GLk4
        hAR2M0o8+zOTFSIhKbHs7xFmCFtYYuW/5+wQRc1MEv++TGDsYuTgYBPQljj9nwMkLiLQxSzR
        ufMdC4jDLHCOSaLt0UJ2kG5hgSCJrq1rWEBsFgFVie19h8DivAJWEof+bwUbJCGgL9F/XxAk
        zClgLfF+0yU2EFsIqOTDsoOMEOWCEidnPgEbwywgL9G8dTbzBEaBWUhSs5CkFjAyrWKUTC0o
        zk3PLTYsMMpLLdcrTswtLs1L10vOz93ECI5ULa0djHtWfdA7xMjEwXiIUYKDWUmE1zb4UooQ
        b0piZVVqUX58UWlOavEhRmkOFiVx3m+ve1OEBNITS1KzU1MLUotgskwcnFINTEdnaUsJMFsq
        s/dnczyyquZh15h8Mdbp6KR+ri+FrHcna6tP6rtz5Ued3zFfqYjIA7/mxyZvUpyVwJeqpHrX
        02HXxNlXKvfwKtU/Ps8rYNQ8v3GP/wqRSyqmpyzf910qT5z+J+SyxcX+yUuPbIr8uVS8zsbQ
        66XDjM2Nr47UvBWaYvEmZ/K5s+v/xTxdefH88ezKQ41t/UwfWiu2Tdv+qXxiPU/3bZNN3U8E
        7Lav3PPwYdHdzDdspnWNR2WzFC9V3PoStvnI+uM6xpMrXNXmyD8ynTx/55E5vHXvUrXnfeB+
        Ga4wWbZv6Y4+hc96EfViz1fdda844loWefFckdu1f7p5528ENvgJHE++6pvapaPEUpyRaKjF
        XFScCAB+WHkdQwMAAA==
X-CMS-MailID: 20230811105723epcas5p468fa65dc9c5bea39d40359ce55bcd9aa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230811105723epcas5p468fa65dc9c5bea39d40359ce55bcd9aa
References: <20230811105300.15889-1-nj.shetty@samsung.com>
        <CGME20230811105723epcas5p468fa65dc9c5bea39d40359ce55bcd9aa@epcas5p4.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Anuj Gupta <anuj20.g@samsung.com>

This is a prep patch. Allow copy_file_range to work for block devices.
Relaxing generic_copy_file_checks allows us to reuse the existing infra,
instead of adding a new user interface for block copy offload.
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
2.35.1.500.gb896f729e2

