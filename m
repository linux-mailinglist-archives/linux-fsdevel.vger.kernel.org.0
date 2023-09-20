Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1E77A769F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 10:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233952AbjITI72 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 04:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbjITI6z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:58:55 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228F493
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 01:58:29 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230920085827epoutp04f8c39b3091fcd119980d1c66bd7aec24~Gj7K2Vos81275412754epoutp04-
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 08:58:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230920085827epoutp04f8c39b3091fcd119980d1c66bd7aec24~Gj7K2Vos81275412754epoutp04-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695200307;
        bh=WyEZwCEcMZEgd+uPDvb2WQHlAKDzDTA2b4v6jEJOw5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PWFFbLhFiPWRJFp6j1CYQvkocziAXRaQ2Fap9szDajTbMXd7Tqk5UG1aJHVVBTH6F
         7tuEkdCbhF9Oqh3+olTwQ6mIQ9VFSUAGww7YG6FMdXPVYyOJDvq5I+y4p6MQYWNrQy
         SqaXsNIn2hRjz655zFtYqwWHS4BefpgSZEoUk6L8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230920085826epcas5p2b0dc5c55c1e5a53f96a84d0cc4b708cb~Gj7KQdNb62273322733epcas5p2u;
        Wed, 20 Sep 2023 08:58:26 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4RrC9s0lJDz4x9Pv; Wed, 20 Sep
        2023 08:58:25 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9D.D1.19094.034BA056; Wed, 20 Sep 2023 17:58:25 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230920081508epcas5p4cf474394711300770d572af7d2fb621d~GjVW0BAaf3178931789epcas5p4f;
        Wed, 20 Sep 2023 08:15:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230920081508epsmtrp12a183029ecd76fe9e5abb1613c009e80~GjVWuJnay2250022500epsmtrp1Q;
        Wed, 20 Sep 2023 08:15:08 +0000 (GMT)
X-AuditID: b6c32a50-64fff70000004a96-a0-650ab4305868
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9C.FE.08742.C0AAA056; Wed, 20 Sep 2023 17:15:08 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230920081505epsmtip1e9d81a65c92149340cdf3edfdf69aed3~GjVTepM8F3236832368epsmtip1e;
        Wed, 20 Sep 2023 08:15:05 +0000 (GMT)
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
        nitheshshetty@gmail.com, anuj1072538@gmail.com,
        gost.dev@samsung.com, mcgrof@kernel.org,
        Anuj Gupta <anuj20.g@samsung.com>,
        Hannes Reinecke <hare@suse.de>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v16 05/12] fs/read_write: Enable copy_file_range for block
 device.
Date:   Wed, 20 Sep 2023 13:37:42 +0530
Message-Id: <20230920080756.11919-6-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230920080756.11919-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te1BUVRzHO/de7i7U0gVpPGDJtgUMb9YWPCBEJeSdZILGZrBmEFe4AbLc
        3XaXgBpHkFeuI4tkD1dbCNd4yfsxqzwiNIElBhsGEAwtZ5cIDBQHreEVy4Xyv8/5/X7f8/v+
        fmcOH3cs4bnwU1g1o2SlMhFpR7Rd8/T0FbfYMQEr3QDVm27g6OHiEoFOFK/gqGZSS6LZawsA
        mbsLAeqcO2+DxruvYKijvARDVTU/YaikZxQgy4gOQ50T3ui7AgOBOjr7CTR89QKJSr+38NCp
        MSOJKnpXMXSr2AKQ0ZwDUNtSKY7qZucJ1DexAw2t9Nq84Uxf0U3y6KE7jQQ9PJhON1WfJOlm
        w3G6fTybpC8WfWFDn86dI+mHlgmCnu8aIemilmpANw98Rj9q2kk3mf/CYuw/TA1NZqSJjFLI
        sAnyxBQ2KUy0/0D83vjAoACxrzgY7RYJWWkaEyaKiIrxfTtFtr4IkfATqSx9PRQjValE/q+H
        KuXpakaYLFepw0SMIlGmkCj8VNI0VTqb5Mcy6hBxQMCuwPXCw6nJazlTNoo5Qebcjd952eDm
        sxpgy4eUBN5eHcE0wI7vSHUA2HbyMWZNOFILAPZpnbnEYwCzp5uJLcU3SyYbLtEJ4ANNDskp
        8jH4dzVfA/h8kvKGA2t8a40TlY3DhvaLwHrAKT0Op9bKgFWwjXofDtzV2liZoNzg8MmbGyyg
        QmD/rTzSehGk/KH2roM1bEvtgY8MYzyuxAH2nzNvGMIpV5jbeh7nzNXbQl15CscR0Fg3Azje
        Bmd6W3gcu8A/tQWbnAGrzlaSVm+QygNQN6bbFITDfJMWt3rAKU9Yf9WfC78EvzTVYVxfe3h6
        yYxxcQE06rf4FXi5vozk2BmOPsnZZBo+KDcR3OKKAOwp7COKgVD31Dy6p+bR/d+6DODVwIVR
        qNKSmIRAhdiXZTL+e+UEeVoT2PgcXjFGUNOw4tcDMD7oAZCPi5wEae52jKMgUZr1KaOUxyvT
        ZYyqBwSuL/wM7vJCgnz9d7HqeLEkOEASFBQkCX4tSCzaLpjN/zbRkUqSqplUhlEwyi0dxrd1
        ycZ8CgXbL987kn/E4PGb29GyvtjSuUHJfh+dPRm+WLD8ZuaZX30y34oenWLF4d6iobWvE9VO
        ml6J4pf2KnPl8/pp38Mau4qjGvaOxftQbeTiTF6uW7PGOK2asL0/uye21q373Yq1puW9X01m
        DF7qOtGxfM5BwVtdfO62nn2R9RAecB4VRv+htMzufJIlcT1LGYzP/HhQv5B1sMt93LNOFBxZ
        a4i0j3KKOmTq2J1mapeFlO+Ihj9Mvbpwf/SfKB5fLx55Jy608eX39ItszbGEIrdL+hLl8YXr
        RO2u7irtfGNr3rDXiEwe94E9ecz1858jQuovXL9n8PjIrzTu40r3hn37RmNbRYQqWSr2wpUq
        6b9DTlutpQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra0hTYRjHe885OzvOVmdT6tXEaFGhS82QeK0QI4tDCdW6Et1GHix0a2yt
        vAReJpYr81KWunBdRN2sxEu6pXaZ5Vx2EdYqJ3ahuYJqZWKS5qwlQd9+z//3f54vD4ULbUQw
        dVh+lFXKpakikke0dolCI2Yaeeyy6pplqOFRN46GRycIlFs8iaP6wSISfer6DpDr3kmAOj06
        Duq/Z8ZQx9VSDBnqH2Ko1PICoCFHJYY6nWJ0Jb+aQB2dNgLZb18ikb5miItOvzSRqNbqxdCr
        4iGATK4cgFon9Di6+ekrgXqc89CzSSsnPogxVw5ymWevGwnG/kTNNBkLSKa5Ootp788mmWtn
        z3GYQo2HZIaHnATz9Y6DZM62GAHT3JvJjDSFMk2uL9jmWbt5q5PY1MPHWGVU3AHeoakcN0fh
        4ad5ut9xs0Gfvxb4UZCOgeUTjzhawKOEdDuA4+fzwbQIgjWTD/BpDoAG7wfudEmDwev3dZgW
        UBRJi2HvFOXLA2ktDgvMHsI34PR1HD53VJC+7QBaAm1V/X8vEfQiaC/o4/iYT6+Etld5pO8Q
        pKNg0RuBL/ajV8GR6pdcHwv/VHr79NzpugDaKlyEj3F6PtTc0uHFgK78T1X+py4DzAiCWIVK
        lixTRSui5ezxSJVUplLLkyMPHpE1gb/fDg8zgTbjt0gLwChgAZDCRYF82WIeK+QnSdMzWOWR
        /Up1KquygHkUIZrLn/uxMElIJ0uPsiksq2CV/yxG+QVnY2Z9XFv5+5ZNzjH5xtwkt3edofSH
        WNPtSLS4vBLr7Yy37SWazlG1NtglTzHkloXGxOvSut3hwyFidcTOPQUJ/I4QLPbzeIk4f+Bc
        0EF3BDF7oDaBOL18fU9LbciCMwlXSgIVBh32q9Fr1dsv5G3qWvPLWWG92IrfaEOX59/F6t9J
        6p+atl/a0VF6IOZBWNTY07bwvC7CVNeQIfiorWvYcvJEIjnecmppoacu4X2hZGHY3bGfZfln
        NlydrH1cFbM1K2XFnG27GsvX+ic3CkoWSAfcsx6usBfZm8+fiD+WSMfu/hBXNUOaI4BrpzLF
        +3jmdIlXX5bpkAcM9MS9WCLfKyJUh6TR4bhSJf0NJJLZrFwDAAA=
X-CMS-MailID: 20230920081508epcas5p4cf474394711300770d572af7d2fb621d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230920081508epcas5p4cf474394711300770d572af7d2fb621d
References: <20230920080756.11919-1-nj.shetty@samsung.com>
        <CGME20230920081508epcas5p4cf474394711300770d572af7d2fb621d@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 fs/read_write.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 4771701c896b..f0f52bf48f57 100644
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

