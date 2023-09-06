Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C9479426B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 19:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243468AbjIFRy5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 13:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243477AbjIFRy4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 13:54:56 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0371BF7
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 10:54:28 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230906175427epoutp041d1a25b6ef5e30e2eed3bb8547efbe5f~CYNKPyhd03253832538epoutp04j
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 17:54:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230906175427epoutp041d1a25b6ef5e30e2eed3bb8547efbe5f~CYNKPyhd03253832538epoutp04j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694022867;
        bh=rQu+eYJ5S9Pd3T+/bEEM0ppe+HVr8qhFLq85Lw9ejNg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dQ4spcj7/YStXTDuW9Asl6QEHOgpT4V/sMrKVcejk3QXofeYKBjPw7g7IZAtDQeeo
         Mn48qwLllfyccY5juHCcbWmkWEXRde0j74z1TjfiD+Eao2J+iY6vJidR4DGfCMGyVu
         1n5SWbxkH0Qq4GovUym9E9RbMvexohAJ7KeEJ2KE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230906175426epcas5p1cf479baa10fcbea710eded34c9c1880f~CYNJoILnT2743727437epcas5p1c;
        Wed,  6 Sep 2023 17:54:26 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Rgqkm5vL9z4x9Pt; Wed,  6 Sep
        2023 17:54:24 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        94.04.19094.0DCB8F46; Thu,  7 Sep 2023 02:54:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230906164330epcas5p105dbc5a7edd4b47c3dce6fe94301015e~CXPOOn9xH0807208072epcas5p1x;
        Wed,  6 Sep 2023 16:43:30 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230906164330epsmtrp2c819a35afbfcb4a4749f1c5cf77004d8~CXPON2WL51133211332epsmtrp2T;
        Wed,  6 Sep 2023 16:43:30 +0000 (GMT)
X-AuditID: b6c32a50-39fff70000004a96-c4-64f8bcd0434b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A3.DA.08788.23CA8F46; Thu,  7 Sep 2023 01:43:30 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230906164328epsmtip207abf9961d02e5705cad2c3fd048642a~CXPLc_Uci1829618296epsmtip2b;
        Wed,  6 Sep 2023 16:43:27 +0000 (GMT)
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
Cc:     martin.petersen@oracle.com, mcgrof@kernel.org,
        gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v15 05/12] fs/read_write: Enable copy_file_range for block
 device.
Date:   Wed,  6 Sep 2023 22:08:30 +0530
Message-Id: <20230906163844.18754-6-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230906163844.18754-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMJsWRmVeSWpSXmKPExsWy7bCmuu6FPT9SDFrbtC3WnzrGbNE04S+z
        xeq7/WwWrw9/YrR4cqCd0WLvu9msFjcP7GSyWLn6KJPFpEPXGC2eXp3FZLH3lrbFwrYlLBZ7
        9p5ksbi8aw6bxfxlT9ktlh//x2RxY8JTRottv+czW6x7/Z7F4sQtaYvzf4+zOoh6nL+3kcXj
        8tlSj02rOtk8Ni+p99h9s4HNY3HfZFaP3uZ3bB4fn95i8Xi/7yqbR9+WVYwenzfJeWx68pYp
        gCcq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6Fcl
        hbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66Xl5qiZWhgYGRKVBh
        QnbGvTM/GAsO8lZsb//D2sC4gruLkZNDQsBEYsGSDqYuRi4OIYE9jBKTZl1igXA+MUpMn3eM
        BaRKSOAbo0TDbLUuRg6wjvun0yFq9jJKPDyzihHCaWWS2NP/kwmkiE1AW+L0fw6QuIhAA7PE
        ht2LGUEGMQusY5JY0csFYgsLhEjcfvGKCcRmEVCV6L86mxnE5hWwkvi6aAo7xDJ9if77giBh
        TgFriabGi4wQJYISJ2c+YYEYKS/RvBWklQuo/D+HREtbDytEr4vEztOWEF8KS7w6voUdwpaS
        +PxuLxuEXS6xcsoKNojeFkaJWddnMUIk7CVaT/Uzg8xhFtCUWL9LHyIsKzH11DomiL18Er2/
        nzBBxHkldsyDsZUl1qxfADVfUuLa90Y2iHM8JH7s5YUEVR+jxJcnU9gnMCrMQvLOLCTvzELY
        vICReRWjVGpBcW56arJpgaFuXmo5PI6T83M3MYJTv1bADsbVG/7qHWJk4mA8xCjBwawkwvtO
        /luKEG9KYmVValF+fFFpTmrxIUZTYHhPZJYSTc4HZp+8knhDE0sDEzMzMxNLYzNDJXHe161z
        U4QE0hNLUrNTUwtSi2D6mDg4pRqYZgfkhVn+2rFt2uX/aeWHXKb+ZudnX1Jv3NRh4vqsOTBg
        el3M+oZrQqYfpN+KJ19Mft52V/lJhMJ60VtTU2QeH4zpkJdLZbrO8E5g2m/OkO9Xj5nfvJ5W
        5rlmT5L2xWijJwp/thz2ail9+fSVXCyn14G19c5vsspfdao//ZfqzXVPMsygiq/+Xtuk0pdO
        Jr41tzYXtt7/2aBafWWmyO//Md58agVzInJao9Ykh0/+N03H92+o/fx+3fMP1PoSN6t0/N4t
        cPNKxqKG65I9mxlm2Rn5WAlx+hTVuqe01WZwCxY3uDsFLo//UC3pk6l9UI+jxNX8peCKvVxT
        A9xOhjjWtz3bc7ldefGvpJYfN5RYijMSDbWYi4oTARh8iBWGBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsWy7bCSvK7Rmh8pBqs3mVisP3WM2aJpwl9m
        i9V3+9ksXh/+xGjx5EA7o8Xed7NZLW4e2MlksXL1USaLSYeuMVo8vTqLyWLvLW2LhW1LWCz2
        7D3JYnF51xw2i/nLnrJbLD/+j8nixoSnjBbbfs9ntlj3+j2LxYlb0hbn/x5ndRD1OH9vI4vH
        5bOlHptWdbJ5bF5S77H7ZgObx+K+yawevc3v2Dw+Pr3F4vF+31U2j74tqxg9Pm+S89j05C1T
        AE8Ul01Kak5mWWqRvl0CV8a9Mz8YCw7yVmxv/8PawLiCu4uRg0NCwETi/un0LkYuDiGB3YwS
        ++Y9Zu9i5ASKS0os+3uEGcIWllj57zk7RFEzk8T6z5NZQJrZBLQlTv/nAImLCHQxS3TufMcC
        4jAL7GCSOP1yDVi3sECQxPPb68FsFgFVif6rs8FsXgEria+LprBDXKEv0X9fECTMKWAt0dR4
        kRHEFgIqubPqNSNEuaDEyZlPWEBsZgF5ieats5knMArMQpKahSS1gJFpFaNkakFxbnpusWGB
        UV5quV5xYm5xaV66XnJ+7iZGcHxqae1g3LPqg94hRiYOxkOMEhzMSiK87+S/pQjxpiRWVqUW
        5ccXleakFh9ilOZgURLn/fa6N0VIID2xJDU7NbUgtQgmy8TBKdXANI+v3X214CnfumxTxWyv
        F84x8478O5c1Q/pxQ0Bnu7tvpLpd0+0ZCo09pVxrRHdzq95d1z1ts+AfrbJr2xnmPVXOXS3D
        4eAXlMN0/VbV4YCSndLaL269E5ynvvuS6A6XY+vzwlaIyFlkVxbZn/tVkbfN9cRlV3eR8Kfa
        wbeUy0K/GHFt2iUUp3RGj8vK52Tl2yxV8aCw4qKPXK6Gnsoe9yK9zlscM8ivfVazxaBaRLef
        b3NgRW9C2Mmw/WLxLixPlvc7z752NuCbfvlyGS/33PRHAna15jfW8X1t/Wt85yaPpFDEGYvn
        NRf3u7rlGmj7/Zhq9cSmKOM4z5v3pzs5v1hpHumvkF9xz/XWGSWW4oxEQy3mouJEAJcmf8g+
        AwAA
X-CMS-MailID: 20230906164330epcas5p105dbc5a7edd4b47c3dce6fe94301015e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230906164330epcas5p105dbc5a7edd4b47c3dce6fe94301015e
References: <20230906163844.18754-1-nj.shetty@samsung.com>
        <CGME20230906164330epcas5p105dbc5a7edd4b47c3dce6fe94301015e@epcas5p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

