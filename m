Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBD73202C6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Feb 2021 03:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhBTCC1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Feb 2021 21:02:27 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:34566 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhBTCCN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Feb 2021 21:02:13 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210220020130epoutp0312295547f9e72f58f127963f799f62d6~lUkM2qTb71243212432epoutp03N
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Feb 2021 02:01:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210220020130epoutp0312295547f9e72f58f127963f799f62d6~lUkM2qTb71243212432epoutp03N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1613786490;
        bh=ZhE54QrP9Esext3Id8H+6Dj0C4CK135+mB3xLLrGwj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OvHZr0rigD39h85TOjG0V0lO9/f8iYW0acUT486mTorAtI6YpmrbH4t8gobgB5pFt
         KWtm2+2+gyxmah+clcQjRYtPtjcNc9apTMDs678Fl0Dcw4+gMRZjlu+/mgZKB4ahT2
         3LC+y0A9VC1EBpBoYP18MyGWslHMjlC4thj0qUU8=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20210220020129epcas5p3c13f985c823c12ccb8b383e911355eeb~lUkMAbWS92049720497epcas5p3a;
        Sat, 20 Feb 2021 02:01:29 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9D.F7.50652.97D60306; Sat, 20 Feb 2021 11:01:29 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20210219124559epcas5p41da46f1c248e334953d407a154697903~lJtoHS3Mt2098420984epcas5p4K;
        Fri, 19 Feb 2021 12:45:59 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210219124559epsmtrp1fef1b54166bacd3d630f5686fcb408ca~lJtoFV7DI0509805098epsmtrp1T;
        Fri, 19 Feb 2021 12:45:59 +0000 (GMT)
X-AuditID: b6c32a4a-6c9ff7000000c5dc-95-60306d79ea3e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E6.7A.13470.703BF206; Fri, 19 Feb 2021 21:45:59 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210219124556epsmtip294ecebf376f5ad1f2f7d9beb2f4d0c4e~lJtlh9Gr51410314103epsmtip2S;
        Fri, 19 Feb 2021 12:45:56 +0000 (GMT)
From:   SelvaKumar S <selvakuma.s1@samsung.com>
To:     linux-nvme@lists.infradead.org
Cc:     kbusch@kernel.org, axboe@kernel.dk, damien.lemoal@wdc.com,
        hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        snitzer@redhat.com, selvajove@gmail.com, joshiiitr@gmail.com,
        nj.shetty@samsung.com, joshi.k@samsung.com,
        javier.gonz@samsung.com, kch@kernel.org,
        linux-fsdevel@vger.kernel.org,
        SelvaKumar S <selvakuma.s1@samsung.com>
Subject: [RFC PATCH v5 1/4] block: make bio_map_kern() non static
Date:   Fri, 19 Feb 2021 18:15:14 +0530
Message-Id: <20210219124517.79359-2-selvakuma.s1@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210219124517.79359-1-selvakuma.s1@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0xTVxTHc997fe/RWPdoYbur6LYmuMBCi0zlkkg3N7M894c/ojNmMUKD
        DyRQIK3AKn+scRGUTcEF2ChjEANEyyihQGXQLqQVBTrGilrCHMi0oANrxTpKVpDt8Vjmf59z
        zv2e7zknl8alPpGczs47xenyNLkKUkzYXHFvJxi0iemJfU4KtU5WkOhs2SKGHE/qROhq6wCG
        HvwepNDAqp9Eo34Xhr52egGyW6sI5PjtHWR3DBHoVu93JGpomaGQLdyAo9tVl3FkmQ8QaDow
        TqH5pSESlXb8Bd6XsT+aJil2dKqDYG+NFLJW83mS7Wz6nO2bMJJs4Kc7JHuxywzYoHULW9b/
        JXZA/Kl41wkuN7uI06nU6eKTjVXNoGB8w2eh3hrSCGzichBBQ2Y7/PauGysHYlrK9AFYV98G
        hOAZgP2lbkoIFgH8e3mAKAf0msR175iQdwBo7FoEfCspEwSwuSyHZ5JJgN4mK8FzFKOAK+1n
        CF6AM5U4vDBej/MFGbMbtt17TvJMMLFwZKJRxBtImFR45pFBGO8NWDsWoniOYNTQ9ti7JpUw
        kXCo1rfWH//3zRfddTjfHzI+GpadqyQF8R7YULssElgG5252UQLL4Z8VpetcDGfP12ACGwG8
        GCgW+D3osa9g/Dw4Ewfbe1VCejOsHrZggu9GeCHsW5dKYM/3Pky4z1Y4fG2nkI6BT12969Ow
        cLBigRROdQnAwNxbleBN00vbmF7axvS/cSPAzeB1rkCvzeL0OwqS8rhipV6j1RfmZSkz8rVW
        sPYR4z/uAX9MP1U6AUYDJ4A0roiSXHuoTJdKTmgMpzldfpquMJfTO8EmmlC8JulJnE6TMlma
        U1wOxxVwuv+qGB0hN2Kd/nZLjmIHMlenHynJLVIfPS4RbzycuTt2140bEcnZV0pS+hVTCp2j
        ryjUpjO+kvZB9yetLwLh1E1u1YcJhqW7bnqDZ388EXs9/ISIsXts951HucgVZcjbM1sTo26s
        PjxHLq0apsLbis9Gy0Ob2y6du6mMfHframwG1Zyjjpr1yycPbsGfPx7Vgkh5gzf6arLKMTNv
        9KSqm5JnfnmWoq6X0ZYXpeYfzIMD9tPu4yke6a+Zj1RSIvjRwt5lWH1ENVwSNu3JH0u6nS/K
        uNPhF19vwQjLz52D0Ts1rUnBtKiWgNxy7OC0CzEdmQe6A/sefiUzx+2feHVsZvvIN4cUhP6k
        Zls8rtNr/gGXAnrr9wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsWy7bCSvC77Zv0Eg+vNPBar7/azWbS2f2Oy
        2PtuNqvFytVHmSwe3/nMbnH0/1s2i/NvDzNZTDp0jdFiz6YpLBZ7b2lb7Nl7ksXi8q45bBbz
        lz1lt9j2ez6zxZUpi5gt1r1+z2Lx4P11dovXP06yWbRt/MroIOyxc9Zddo/z9zayeFw+W+qx
        aVUnm8fmJfUeu282sHm833eVzaNvyypGj8+b5DzaD3QzBXBFcdmkpOZklqUW6dslcGUsmLKU
        seA6T8X3XdPYGhi3cXUxcnBICJhIHL4f08XIxSEksJtR4uGHpyxdjJxAcRmJtXc72SBsYYmV
        /56zQxR9ZJSYsucAK0iCTUBX4tqSTWANIgJKEn/XN4HZzALLmCUezVQEsYUFHCXW3v8CNohF
        QFXi7M0FrCCLeQVsJZpeVELMl5eYeek7O4jNKWAnse3NNWYQWwio5MP3aWCtvAKCEidnPoEa
        Ly/RvHU28wRGgVlIUrOQpBYwMq1ilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dLzs/dxAiOOy3N
        HYzbV33QO8TIxMF4iFGCg1lJhHf7c70EId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmk
        J5akZqemFqQWwWSZODilGpi28FRLFwhFz/3y7j/fU/9sqXqX/SLrd/8JfrAkcQ3r3B1/9fuZ
        r9rrxzHFG75k/6q69OHuydMOmou/NkloOtgQOtOr9pxrzWzNu5MUl6j7Tb7mIMTw0u7xydtm
        yUVbPmh+ipVuq3dWOdVuXRTY91tFv++L4cKAtzHP+U7/DfVVqjp7kqMtZ+OWZymdWrUZW5oV
        Pj+NW/P7wqebKRovkz6EtBdfvs8y/9kTxwMaT0J+7F++5QND0X2BM4wRGauNPeIm1ap0Ljwv
        Ebj0pNIbxT0OXAw+0Z/rcg4dqlp9fpHiBN9fJ/4/76s4tF+CvUunlnnr9jcvOXpC7Pc0L35+
        8ZKZn6ql5z+mxksa2ZXMspVKLMUZiYZazEXFiQB9lYxxKgMAAA==
X-CMS-MailID: 20210219124559epcas5p41da46f1c248e334953d407a154697903
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210219124559epcas5p41da46f1c248e334953d407a154697903
References: <20210219124517.79359-1-selvakuma.s1@samsung.com>
        <CGME20210219124559epcas5p41da46f1c248e334953d407a154697903@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make bio_map_kern() non static, so that copy offload emulation can use
it to add vmalloced memory to bio.

Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
Signed-off-by: Chaitanya Kulkarni <kch@kernel.org>
---
 block/blk-map.c        | 2 +-
 include/linux/blkdev.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 21630dccac62..17381b1643b8 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -378,7 +378,7 @@ static void bio_map_kern_endio(struct bio *bio)
  *	Map the kernel address into a bio suitable for io to a block
  *	device. Returns an error pointer in case of error.
  */
-static struct bio *bio_map_kern(struct request_queue *q, void *data,
+struct bio *bio_map_kern(struct request_queue *q, void *data,
 		unsigned int len, gfp_t gfp_mask)
 {
 	unsigned long kaddr = (unsigned long)data;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f94ee3089e01..699ace6b25ff 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -944,6 +944,8 @@ extern int blk_rq_map_user(struct request_queue *, struct request *,
 			   struct rq_map_data *, void __user *, unsigned long,
 			   gfp_t);
 extern int blk_rq_unmap_user(struct bio *);
+struct bio *bio_map_kern(struct request_queue *q, void *data, unsigned int len,
+			gfp_t gfp_mask);
 extern int blk_rq_map_kern(struct request_queue *, struct request *, void *, unsigned int, gfp_t);
 extern int blk_rq_map_user_iov(struct request_queue *, struct request *,
 			       struct rq_map_data *, const struct iov_iter *,
-- 
2.25.1

