Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56153EEBB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 13:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239773AbhHQLaB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 07:30:01 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:23667 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239726AbhHQL37 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 07:29:59 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210817112925epoutp04070c55d3a6a7f4686c2690f350109cb7~cFI3_YCiD1039610396epoutp04v
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 11:29:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210817112925epoutp04070c55d3a6a7f4686c2690f350109cb7~cFI3_YCiD1039610396epoutp04v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1629199765;
        bh=wc+WvxlrxFo6cfYgE96D3st/XNkIhsyXUXNjiBbfxn8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZedZ/tENruX7+OWaROCLdRskFtf7AvaHUPKhTlj+Qq+OpWzSOHsRsoTRLs9nyOG8T
         hrjDl8eLivDlJ6ryhH+61fh5zkyxG2IwbixMPLjjxyT2fEMw4tDcs+RL7jXT2vL/ch
         O3iPIR7TUzxh70VB+eH4zUWyrPp7fH7CZgxSTNLw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20210817112924epcas5p34748629b4eefb2a5e4447803ad88bac6~cFI3VRqJF0728107281epcas5p34;
        Tue, 17 Aug 2021 11:29:24 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4GpphX07Jgz4x9Q3; Tue, 17 Aug
        2021 11:29:16 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D4.3C.40257.B8D9B116; Tue, 17 Aug 2021 20:29:15 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20210817101809epcas5p39eed3531ed82f5f08127eb3dba1fc50f~cEKpkFYrp2834328343epcas5p35;
        Tue, 17 Aug 2021 10:18:09 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210817101809epsmtrp12dea27ad71f675f5748808fd117e1e45~cEKpiyntr2042320423epsmtrp1G;
        Tue, 17 Aug 2021 10:18:09 +0000 (GMT)
X-AuditID: b6c32a49-ed1ff70000019d41-55-611b9d8bb635
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        58.19.32548.0EC8B116; Tue, 17 Aug 2021 19:18:09 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210817101805epsmtip21f597ab79bcdfc0f01aa56cbc0e830ab~cEKl0OOkM0079500795epsmtip2j;
        Tue, 17 Aug 2021 10:18:05 +0000 (GMT)
From:   SelvaKumar S <selvakuma.s1@samsung.com>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc:     linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        kbusch@kernel.org, axboe@kernel.dk, damien.lemoal@wdc.com,
        asml.silence@gmail.com, johannes.thumshirn@wdc.com, hch@lst.de,
        willy@infradead.org, kch@kernel.org, martin.petersen@oracle.com,
        mpatocka@redhat.com, bvanassche@acm.org, djwong@kernel.org,
        snitzer@redhat.com, agk@redhat.com, selvajove@gmail.com,
        joshiiitr@gmail.com, nj.shetty@samsung.com,
        nitheshshetty@gmail.com, joshi.k@samsung.com,
        javier.gonz@samsung.com, SelvaKumar S <selvakuma.s1@samsung.com>
Subject: [PATCH 5/7] block: add emulation for simple copy
Date:   Tue, 17 Aug 2021 15:44:21 +0530
Message-Id: <20210817101423.12367-6-selvakuma.s1@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210817101423.12367-1-selvakuma.s1@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf1CTZRy/533Hu+Ft+AZ6PAyq3cAMCtiKrQcDzKB8O72OhM6TTHwP3gOO
        sa1tiFhdmMoPSQRElIGIQCijIgYRDLBugPLLwwQUEQJ0qFnIlOPXAdHG0Pzv8/1+P5/nc9/P
        c18O7pjP5nPi5BpGJadlQmIdq77V83XvzHOutOhErgRVd13BUZGuHqCqkZMEyjcv4OhY2iyG
        +kwOqOVxoR2qrGrH0L3haTZaPv4nhtpXJgnUO9mKoVzjTYCa9XksVDuXTqCWoTdQc0snC52v
        mGCjzFsNBLp49V8M5aQPYKjBdBig+sXzOOrPK8XR2NQtNvp7vpNAqTUzAC3OFxHvuVF9/Tuo
        Ru0Im6q95EX1XUuk9LoMgqot/4Zqup1CUE8mhljU1OUBgsqq0wFqWv8KlfZ7JhbKjYgPiGXo
        aEYlYORRiug4eUygcEdYZHCkRCoSe4v90TtCgZxOYAKFITtDvT+Mk1nCEAoO0LJESyuUVquF
        vkEBKkWihhHEKtSaQCGjjJYp/ZQ+ajpBnSiP8ZEzmi1ikegtiYW4Pz62+/SCnXLA/eBUzwqe
        Au64HQf2HEj6we9SevDjYB3HkWwC8Lf2x5iteApgdlE921ZMA/jAcJF4JintvQZsAwOAVRl9
        2HNWUWoHbmURpDe8Wa5nWfEGciusXNDZWUk42cWCZ6ZK2daBE+kPCxbSVjGL3AT1lYOYFfPI
        QHhhdBbY7F6FBTfmLBwOx54Mgoanm2yUl2BngWn1fdxCOfJL4eoSkKyyh+dmr7Bs2hCYdXd4
        DTvBR1fr2DbMh3+dTF3DSfB+Rj5mwykAZk0l2fBW+EfzMmb1xUlPWG3wtbVfhqe7fsJsvg7w
        xKJpTcqDDcWmVTokX4Ndv0ptbTdobjWsBUfBxiHdWlY5AKbmNdplA4H2hXW0L6yj/d+5BOA6
        4MIo1QkxjFqiFMuZpOe/HKVI0IPVA/H6qAGMjJl9jADjACOAHFy4gbeZw6cdedF08iFGpYhU
        JcoYtRFILHHn4PyNUQrLhck1kWI/f5GfVCr1839bKhY68/budKUdyRhaw8QzjJJRPdNhHHt+
        CobjvPSyCOf07NHSu77jDyu5W+47R/Uuj3evP1rGlObMlBxxmPsRLAUdaBpuq4n9oCIkuEfy
        5Q/HuHanZnd10CtLzPKhzOptnl8Xpx/s2NwzH+bxQNSIRpcMex4+0h09O+jAKenYbW5y2buL
        K8iZ3njB8UxBzRy1Pc4/XObzpnuGa+i3pMAzkAsDfk7aHryv3rjbYSL0sDvmerbjsxuF3W39
        16+vJL//PSfI42MWGTlTNxL+7n7uV7PdWcZP9rhFXMIuf95ToY9qK6/YV2NeDNaO3wvTJoed
        emL2+EKeq6z1ME06FWdDYQI/6074+n+6zIOezXOMCz83Yhv56VhZUd7tlhEhSx1Li71wlZr+
        D8IJLompBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Rf1CLcRzHfZ/n8explMfK+aouZ84wK7ULX786P89zuMud487PGh4V22RT
        5JxGZVkoKncl0vxs5dfKrrTIQla6Omskll/DifSTVTvS2rnz3/s+r9fd648PhfPqCV8qRr6P
        VcglUj7JJQzV/ImB70/4SYK/tGHoVu0THOXpDAAV2dJJdLazH0cp6l8Ysti9UOWPcyNRYdFj
        DH1808NBvzWtGHo82E6ihvZqDJ0xvQDIqM8iUIkjlUSVLTOQsdJMoPyrnzgo7WUZia7V/MHQ
        6VQrhsrsRwAyOPNx1JSlxdG7jpcc9K3PTKJjd34C5OzLIxf5M5amVUx5ro3DlFwXMpb6OEav
        O04yJZcTmYpXKpLp+tRCMB33rSRzqlQHmB59AKOuSsPWjN7IXbCDlcbEs4qZYZHc6Lrs/pGx
        1skHOp4N4irw2l8DPChIh0JtQz3QAC7Fo8sAzDmahbmBP7xhO066tzcs/POF45a6APygeUe4
        AEkHwheX9cPbh14M67oNmEvC6TYCttoqcBfwpufCnH41x7UJegrUFzYPFzzphbDg7S/gLkyE
        Oc8dQw5FedBh8F73FNeZN6Q8MGZz3PpYaM6xD7fwIT3p7jk8A9C5/6Hc/9BFgOnABDZWKYuS
        KUNixXJ2f5BSIlPGyaOCtu+R6cHwx4XCMmDUdQaZAEYBE4AUzvfxnEr5SnieOyQJB1nFnghF
        nJRVmoAfRfDHezZqzBE8Okqyj93NsrGs4h/FKA9fFbZ06+z7AyJvsfqeI1TnWBs/vWnO7oH0
        n1Z6TevNTON4ca0ps2vc4fDvquDe2SFekX3ra9fx+2puG1cLekIvbRP1zpPfujJLZNauPP9U
        rCm2LCnyHqgrn7QsISOi4EKHx5b+4u+azTGqk7LGjRh1qUKjDfsxzW9/aX57t2VqzIhEYzhF
        PHm2IiF9L7NTOmA7OL8qKWnTibYVqaHXA5rFvLERR5cGWkssBb2iKu7DdLZ5gXCMwGfXzRpn
        4DH7V/9xdmVncoDK0dIQLCg+XMxrBKNup43OW36oXBBlEPp2//6cLIrOrp7klwrVzkyv8I9k
        ijRkA1/rFByJrC8d8wjG54v5hDJaEiLEFUrJX9ryORVgAwAA
X-CMS-MailID: 20210817101809epcas5p39eed3531ed82f5f08127eb3dba1fc50f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210817101809epcas5p39eed3531ed82f5f08127eb3dba1fc50f
References: <20210817101423.12367-1-selvakuma.s1@samsung.com>
        <CGME20210817101809epcas5p39eed3531ed82f5f08127eb3dba1fc50f@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Nitesh Shetty <nj.shetty@samsung.com>

For the devices which does not support simple copy, copy emulation is
added. Also for stacked devices, copy is performed via emulation.

Copy-emulation is implemented by allocating maximum possible memory
less than or equal to total copy size. The source ranges are read
into memory by chaining bio for each source ranges and submitting them
async and the last bio waits for completion. After data is read, it is
written to the destination and the process is repeated till no source
ranges left.

bio_map_kern() is used to allocate bio and add pages of copy buffer to
bio. As bio->bi_private and bio->bi_end_io are needed for chaining the
bio and gets over-written, invalidate_kernel_vmap_range() for read is
called in the caller.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
---
 block/blk-lib.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 7fee0ae95c44..d29c52b90dcf 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -333,6 +333,64 @@ int blk_copy_offload_scc(struct block_device *src_bdev, int nr_srcs,
 	return ret;
 }
 
+int blk_submit_rw_buf(struct block_device *bdev, void *buf, sector_t buf_len,
+				sector_t sector, unsigned int op, gfp_t gfp_mask)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+	struct bio *bio, *parent = NULL;
+	sector_t max_hw_len = min_t(unsigned int, queue_max_hw_sectors(q),
+			queue_max_segments(q) << (PAGE_SHIFT - SECTOR_SHIFT));
+	sector_t len, remaining;
+	int ret;
+
+	for (remaining = buf_len; remaining > 0; remaining -= len) {
+		len = min_t(int, max_hw_len, remaining);
+retry:
+		bio = bio_map_kern(q, buf, len << SECTOR_SHIFT, gfp_mask);
+		if (IS_ERR(bio)) {
+			len >>= 1;
+			if (len)
+				goto retry;
+			return PTR_ERR(bio);
+		}
+
+		bio->bi_iter.bi_sector = sector;
+		bio->bi_opf = op;
+		bio_set_dev(bio, bdev);
+		bio->bi_end_io = NULL;
+		bio->bi_private = NULL;
+
+		if (parent) {
+			bio_chain(parent, bio);
+			submit_bio(parent);
+		}
+		parent = bio;
+		sector += len;
+	}
+	ret = submit_bio_wait(bio);
+	bio_put(bio);
+
+	return ret;
+}
+
+static void *blk_alloc_buf(sector_t req_size, sector_t *alloc_size, gfp_t gfp_mask)
+{
+	int min_size = PAGE_SIZE;
+	void *buf;
+
+	while (req_size >= min_size) {
+		buf = kvmalloc(req_size, gfp_mask);
+		if (buf) {
+			*alloc_size = (req_size >> SECTOR_SHIFT);
+			return buf;
+		}
+		/* retry half the requested size */
+		req_size >>= 1;
+	}
+
+	return NULL;
+}
+
 static inline sector_t blk_copy_len(struct range_entry *rlist, int nr_srcs)
 {
 	int i;
@@ -348,6 +406,46 @@ static inline sector_t blk_copy_len(struct range_entry *rlist, int nr_srcs)
 	return len;
 }
 
+/*
+ * If native copy offload feature is absent, this function tries to emulate,
+ * by copying data from source to a temporary buffer and from buffer to
+ * destination device.
+ */
+static int blk_copy_emulate(struct block_device *src_bdev, int nr_srcs,
+		struct range_entry *rlist, struct block_device *dest_bdev,
+		sector_t dest, gfp_t gfp_mask)
+{
+	void *buf = NULL;
+	int ret, nr_i = 0;
+	sector_t src_blk, copy_len, buf_len, read_len, copied_len, remaining = 0;
+
+	copy_len = blk_copy_len(rlist, nr_srcs);
+	buf = blk_alloc_buf(copy_len << SECTOR_SHIFT, &buf_len, gfp_mask);
+	if (!buf)
+		return -ENOMEM;
+
+	for (copied_len = 0; copied_len < copy_len; copied_len += read_len) {
+		if (!remaining) {
+			src_blk = rlist[nr_i].src;
+			remaining = rlist[nr_i++].len;
+		}
+
+		read_len = min_t(sector_t, remaining, buf_len);
+		ret = blk_submit_rw_buf(src_bdev, buf, read_len, src_blk, REQ_OP_READ, gfp_mask);
+		if (ret)
+			goto out;
+		src_blk += read_len;
+		remaining -= read_len;
+		ret = blk_submit_rw_buf(dest_bdev, buf, read_len, dest + copied_len, REQ_OP_WRITE,
+				gfp_mask);
+		if (ret)
+			goto out;
+	}
+out:
+	kvfree(buf);
+	return ret;
+}
+
 static inline bool blk_check_offload_scc(struct request_queue *src_q,
 		struct request_queue *dest_q)
 {
@@ -398,6 +496,8 @@ int blkdev_issue_copy(struct block_device *src_bdev, int nr_srcs,
 
 	if (blk_check_offload_scc(src_q, dest_q))
 		ret = blk_copy_offload_scc(src_bdev, nr_srcs, src_rlist, dest_bdev, dest, gfp_mask);
+	else
+		ret = blk_copy_emulate(src_bdev, nr_srcs, src_rlist, dest_bdev, dest, gfp_mask);
 
 	return ret;
 }
-- 
2.25.1

