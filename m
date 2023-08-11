Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF35778D6D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 13:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236292AbjHKLUp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 07:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236352AbjHKLUd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:20:33 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25412127
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 04:20:22 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230811112020epoutp01476bdf6df152808276aa8a0018827bc7~6UDoUwW542881128811epoutp01P
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 11:20:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230811112020epoutp01476bdf6df152808276aa8a0018827bc7~6UDoUwW542881128811epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1691752820;
        bh=x8qLr8ri6WADzLyMzJJYyA//zxjzixbCr038TulbPXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mU519Yy+ca7sDxzXs9/ycVnhUI+CqGyHcNyPaKc/Mn74nck0E/1/UIxgIs7b+iWYl
         6E78guV+eV8+6EazVYacv3oMSJbzbD9hU2QUYiVzEasaxXUB+DZ3ubP6n/aSJEVClv
         x3JatgWUVu7GFbBGpcI2z6nihoSSyRw5o0bb2GZ8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230811112019epcas5p2a57cf2476884422a636a175833c1f083~6UDnpMjsk0511305113epcas5p2o;
        Fri, 11 Aug 2023 11:20:19 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4RMhD140ltz4x9Py; Fri, 11 Aug
        2023 11:20:17 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B0.7D.55522.17916D46; Fri, 11 Aug 2023 20:20:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230811105734epcas5p1b465394a301ba85f2c52ed7fde334f52~6TvwrRB2X2729727297epcas5p1n;
        Fri, 11 Aug 2023 10:57:34 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230811105734epsmtrp1ed176f2233ebaa42c1ef6e00e48f21d4~6TvwqSCzB0371503715epsmtrp1Q;
        Fri, 11 Aug 2023 10:57:34 +0000 (GMT)
X-AuditID: b6c32a49-419ff7000000d8e2-eb-64d6197199e1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0D.01.30535.E1416D46; Fri, 11 Aug 2023 19:57:34 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230811105729epsmtip2ef78d0d5cd04032b7b1ba24b0efdf868~6Tvr-w28T1482714827epsmtip2I;
        Fri, 11 Aug 2023 10:57:29 +0000 (GMT)
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
        gost.dev@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 06/11] fs, block: copy_file_range for def_blk_ops for
 direct block device
Date:   Fri, 11 Aug 2023 16:22:49 +0530
Message-Id: <20230811105300.15889-7-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230811105300.15889-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf1CTdRzH+z7PeBji8nFofIF0c2YJBmw41heDzODyKb2OO7S77Lg12RMg
        Yxv7IUlyDRxQeGwo5uUWv46ZCQI2lF9rhuOUH+lBcIIgmNk4Q34ZFVYgxTYo/3t93vd5fz8/
        vvdh4uy/iUBmqlxDq+QSGY9YxWhsD94amhEwIOVP2QJRffd1HOUWP8FRzaiRQBPtswA52woA
        uvfdTmSfNnuhobYWDJ2vuYahk44BgMZumTBkH96GKvMtDPStvYuB+lu/JFD5V2Pe6FzHIoZu
        F48B1DhfjqO6iRkG6hwOQj1POrxef47qufsNg+q/qaWs1Z8RVIPlE8o2pCOoKkOJF1V0bJqg
        fh0bZlAzV24RlOFSNaB+s26krM4pLH71gbToFFoipVVcWp6kkKbKk2N4exLEseJIEV8QKohC
        r/C4ckk6HcOL2xsf+maqbGleHvewRKZdkuIlajUv/LVolUKrobkpCrUmhkcrpTKlUBmmlqSr
        tfLkMDmt2SHg8yMilxI/SEsZ7C0llBVrPnrYrPfWgYurC4EPE5JCONk+CgrBKiabtAFYYrXg
        nmAWwJacT708wRyA7WWTjBWL8bTFzWzSDuBfp2M9SXkYzKvTexcCJpMgt8Hv/2G69HWkDocX
        bVXuGjjpwKCpcgpzuf1IMXSeKXe/xCC3wJnedtzFLHIHXOh87OV6CJLh0PjjWpfsQ74KZ6x9
        hCdlLew643RbcZIDj102u9uG5HEfqOsvwTydxkGD4Q7wsB982HHJ28OBcNyYv8yZ8PyprwmP
        WQ+gadC0bNgJ87qNuKsJnAyG9a3hHnkD/Ly7DvMUfhYWzTuXa7Fgc9kKb4YX6isIDwfAgcc5
        y0zBgtxHy8s2AKgfn8OLAdf01ECmpwYy/V+6AuDVIIBWqtOTaXWkUiCnM//75iRFuhW4jyDk
        rWYweu9RmANgTOAAkInz1rFiEvqkbJZUciSLVinEKq2MVjtA5NLCT+CB65MUS1ck14gFwii+
        UCQSCaO2iwQ8f9ZEXqmUTSZLNHQaTStp1YoPY/oE6jCOKqflbuntxAXT/RJzMxiOaMG7398l
        KmUfWZwzlh+/qj3XhPe8lK+fDK7RLTaGj/P/MGc3DjU0+LNUjkTf3de0C1mbXyQD/A5dSaoO
        ey/rJyGDyyGzN2QoZv2LZCP7nx/h3OmC9piRN04s5nahPQ3zZRcsfZdt7z6o1x82//Dxbpbe
        W/tMf8PBP+1BEfs3vj1wNv2drbUVvjc5uu1rpCFlN07uyjpYa/Kt73w5aq7v0Ka8tOnr0Xaf
        hLj+2qirlYnBpzgjN/bu0/RkN2358JcmmWz9geDyQefP5k3302K+ONpmcFqcGUZbY4E2s3ef
        scr+e+xAyNmK1qOjQSUvmNm9VQ/EPIY6RSIIwVVqyb+Ahb/zjQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsWy7bCSvK6cyLUUgy2bzSzWnzrGbNE04S+z
        xeq7/WwWrw9/YrR4cqCd0eLBfnuLve9ms1rcPLCTyWLl6qNMFpMOXWO0eHp1FpPF3lvaFgvb
        lrBY7Nl7ksXi8q45bBbzlz1lt1h+/B+TxY0JTxkttv2ez2yx7vV7FosTt6Qtzv89zuog5nH+
        3kYWj8tnSz02repk89i8pN5j980GNo/FfZNZPXqb37F5fHx6i8Xj/b6rbB59W1YxenzeJOex
        6clbpgCeKC6blNSczLLUIn27BK6M6xfmshUs4K94taOFvYFxA08XIyeHhICJRP+0JSxdjFwc
        QgK7GSWO77vEBJGQlFj29wgzhC0ssfLfc3aIomYmiRcn/rJ1MXJwsAloS5z+zwESFxHoYpbo
        3PmOBaSBWeAck8TJ2/wgtrBArMTLK1sYQWwWAVWJ9xcOgw3lFbCS+HPiOyvIHAkBfYn++4Ig
        YU4Ba4n3my6xgdhCQCUflh1khCgXlDg58wnUeHmJ5q2zmScwCsxCkpqFJLWAkWkVo2RqQXFu
        em6xYYFRXmq5XnFibnFpXrpecn7uJkZwnGpp7WDcs+qD3iFGJg7GQ4wSHMxKIry2wZdShHhT
        EiurUovy44tKc1KLDzFKc7AoifN+e92bIiSQnliSmp2aWpBaBJNl4uCUamBarm9pmbptUv63
        RzuP+zaej/Jaq8F5fe+vz5utDd7rnY1klI15GnV8wlXbaXmdT9e/1kkNmi0tmC1u6ejVptYf
        rtkW+GZmTf3UvYsEdn3NiXOsmJt0SMioiKMlaOcn0a3+/kynqlfPb9vqZjc7i/fzn39O68/O
        rd29m2mn0QX2XSefpYaVNiX6iKTsD6m123VtvafcJ60OV6nsg/vOf3gfvilg16LZqzbEN2rc
        v/6++cccJ4uTd3cp+Ds3yDOmqfM7XJCt/lT26Si/xb4U32zTNl6V29qvrmpkXz0TXKIzWfzM
        wglhXgwRifd5J9zLfrkuevqcjPv5ixao3jh6pC8o9JvovL/nVv2+6lok/FZWiaU4I9FQi7mo
        OBEAh25GcEIDAAA=
X-CMS-MailID: 20230811105734epcas5p1b465394a301ba85f2c52ed7fde334f52
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230811105734epcas5p1b465394a301ba85f2c52ed7fde334f52
References: <20230811105300.15889-1-nj.shetty@samsung.com>
        <CGME20230811105734epcas5p1b465394a301ba85f2c52ed7fde334f52@epcas5p1.samsung.com>
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

For direct block device opened with O_DIRECT, use copy_file_range to
issue device copy offload, and fallback to generic_copy_file_range incase
device copy offload capability is absent or the device files are not open
with O_DIRECT.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 block/fops.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index eaa98a987213..f5cf061ea91b 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -738,6 +738,30 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return ret;
 }
 
+static ssize_t blkdev_copy_file_range(struct file *file_in, loff_t pos_in,
+				      struct file *file_out, loff_t pos_out,
+				      size_t len, unsigned int flags)
+{
+	struct block_device *in_bdev = I_BDEV(bdev_file_inode(file_in));
+	struct block_device *out_bdev = I_BDEV(bdev_file_inode(file_out));
+	ssize_t copied = 0;
+
+	if ((in_bdev == out_bdev) && bdev_max_copy_sectors(in_bdev) &&
+	    (file_in->f_iocb_flags & IOCB_DIRECT) &&
+	    (file_out->f_iocb_flags & IOCB_DIRECT)) {
+		copied = blkdev_copy_offload(in_bdev, pos_in, pos_out, len,
+					     NULL, NULL, GFP_KERNEL);
+		if (copied < 0)
+			copied = 0;
+	}
+	if (copied != len)
+		copied = generic_copy_file_range(file_in, pos_in + copied,
+						 file_out, pos_out + copied,
+						 len - copied, flags);
+
+	return copied;
+}
+
 #define	BLKDEV_FALLOC_FL_SUPPORTED					\
 		(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |		\
 		 FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE)
@@ -831,6 +855,7 @@ const struct file_operations def_blk_fops = {
 	.splice_read	= filemap_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= blkdev_fallocate,
+	.copy_file_range = blkdev_copy_file_range,
 };
 
 static __init int blkdev_init(void)
-- 
2.35.1.500.gb896f729e2

