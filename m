Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C4369CB62
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 13:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjBTMt7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 07:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbjBTMtb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 07:49:31 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8361E1D922
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 04:48:52 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230220124851epoutp0180e1ed909873ccc19fb369072a621f76~FiTzu21Sd1637616376epoutp01I
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 12:48:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230220124851epoutp0180e1ed909873ccc19fb369072a621f76~FiTzu21Sd1637616376epoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676897331;
        bh=xxiDP6QZKfeqkiRLoXjxlMN+FlItKe4BO652Ksxx5Yk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rvb4p4s828aNF+EMJ0SMueQ08Q8Q+Dx+98xkLJoCt9BFmxRb7qJcHwT98PT6hhWA0
         YbH63omXTe4A0f/0hW42jIZlmkbo7sLINKHZIKIW0/NNB6azu9rRIy3rXdOQSBDHdJ
         G9mw1bvUWa08BZJU8OGtanHeGxpC4AEjDLCyBdek=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230220124850epcas5p16d10e6638f58a2515de2b776d0de93ae~FiTy_AN3w2067920679epcas5p1a;
        Mon, 20 Feb 2023 12:48:50 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PL2KX2zpcz4x9Px; Mon, 20 Feb
        2023 12:48:48 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D4.59.06765.03C63F36; Mon, 20 Feb 2023 21:48:48 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230220105529epcas5p447cd449f13da54794e391b78bd1f5956~Fgw1DkzdR2307823078epcas5p4Q;
        Mon, 20 Feb 2023 10:55:29 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230220105529epsmtrp1f7f3bedff31f86864840edd7f762c623~Fgw1Cf1mh2429224292epsmtrp1q;
        Mon, 20 Feb 2023 10:55:29 +0000 (GMT)
X-AuditID: b6c32a4b-46dfa70000011a6d-cf-63f36c30aefe
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        9E.0A.17995.1A153F36; Mon, 20 Feb 2023 19:55:29 +0900 (KST)
Received: from green5.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230220105525epsmtip221cf243ac5da4c7cb295706198a8dd86~FgwyAn1a80747307473epsmtip2z;
        Mon, 20 Feb 2023 10:55:25 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     bvanassche@acm.org, hare@suse.de, ming.lei@redhat.com,
        damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
        joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 7/8] dm: Add support for copy offload.
Date:   Mon, 20 Feb 2023 16:23:30 +0530
Message-Id: <20230220105336.3810-8-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230220105336.3810-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf1CTdRzHeZ5nezbI2cMP4evUWjMsQGALWA/EJJPo6bCTOzM4rcZz44ER
        Y5t7NhS5DgbaBRzMUDgYXBBSMjAQEI6fZvMQGS0s0IIYCId/lAfYyEg5pI0Hy/9en8/n/fm+
        7/P53oeLeBVz+Nx0lY7SqkilEPVgdV0PCAwWKZflosk2H7zVegPB88+uIXiz3YjiFQ8eIfiq
        bRTBBxar2fjEtR4Y768vg3Fz8yCM9331J4wPri+geJnlDoTfu22C8YHJILx/YJiFj/XWoHjt
        N/c4uOVcAYx3zxsgvGu1FsFb7i+x8JuTO/DRtSH2m37E2Hg8YZqxoUSPyc4hRqfbWMSYTU+0
        NxWiREdDLtE3kYcSJQWLTsGZGTaxdPU2SpReaYKIjpEcYrn9BaJ9fgFOeP5oRrSCIlMorYBS
        ydUp6ao0qTD+sOyALEIiEgeLI/HXhQIVmUlJhbEHE4Lj0pXOFQgFWaRS70wlkDQtDN0XrVXr
        dZRAoaZ1UiGlSVFqwjUhNJlJ61VpISpKFyUWiV6LcAqTMxTjJTfYGjv/ZEuVEc2DJrYVQe5c
        gIWDJ9UWtAjy4HphfRCoumXlMIEDAp93PoaYYBkCjqs2p4y70WJ4fJTJ90Lg/ugCzAQFMJg0
        9rNcIhQLAiPrXJeFDzYFg56R3S4Ngt2FQW1+A+QqeGORoPnvetjFLMwf9DdWbDDPmTcVNcGM
        WSgwzni60B2LAiunsxmFJxiumme5GMFeBAWd1YjreYDVuoO2wZ/YzGixYOjnaZhhb/DH0BUO
        w3zwu/GzTT4BzOcbUab5NARMv5ggphADzliNiMsYwQJAa28ok94Fyq0tMGO8FZSszm++zwPd
        Xz7l3eBSax3K8HZwZ8WwyQQo6ru2ud0SCDy6tMY5CwlMzwxkemYg0//WdRDSBG2nNHRmGkVH
        aMJU1In/PlmuzmyHNq4iML4bmrv7IMQCwVzIAgEuIvThrfOW5V68FDL7FKVVy7R6JUVboAjn
        vr9A+NvkaudZqXQycXikKFwikYRHhknEQj/eK9JhuReWRuqoDIrSUNqnfTDXnZ8Hpx+0V1x8
        aWdWGJZeeDFu55akmuP1cdZMmf/+55qzPQLDfistj63bK93zncIRQJIHluh3ZwtXg0QXkkun
        VorNlfq/TmpCtBHFx8w5USO5tpUfy/OPXPZ8q/KHqdQ3OqeaCxN7s/y02bNmu1l72SZJtu/x
        enW2TRFm/Ohw0ts1hzoKHVuOiV7u18wZKkN+zatO3fr1jkWFz6FEw9ZvHWz/96n39kcHLqU8
        SVpUfSAtsE43PBywCt7pmjylTaXLbrr1DO1iycY7vRPKvh/9JNlt73E3dQd1ITEvptQXQc5X
        /+Mgu4LPwX2yjEbfjzUxHz7kH7m+b+JWTq7k0zr3OZ+xJF8Dv1PIohWkOBDR0uS/jRpmh54E
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02RfUgTYRzHee5u52nMzrnq0ki5FGWWZUU8hllBxVlZKlTkH65hN62crZ1a
        voAzLdjCtFWWM8g3TCdoatnMrWy9aSaWU0HBl2L2gu8aWtk0Twn67/P7fj8/fg88BCp6gbkR
        Z+ITWFW8LI7GnbD6l7THpqLw6egtWpMAVr97g8LLuXYUVvbl4DBv4hcK59raUWgeKxDAnqYG
        BJqKdQisqHyNwMaiSQS+XhjFoc7SDeBQlx6B5l4/aDK3YND69B4O75cNOUDLzUwEGm0ZANbP
        3Udh1fA4Bpt73WG7/a1gzxrG2nmI0Q+04UyDvs+Bae+vwRhrWyJTa9DgTF1pOtPYo8aZ7Myx
        ReHKgIAZf9aFM9cfGQBT15rKTNeuZ2pto0jYykinoNNs3JkkVrU5+JRTbGf2G4Gyz+1SVX4O
        rgY9q7SAIChyO5XxO1ILnAgRaQTUtQdmBy1wXMzXUmX2V+gyu1IV818dlqUMhBp8Ugf4ZZz0
        o1oXCD4Xk18Qqq3/M8oPKDmGUIZPZQJ+25UMpCpnihGeMdKbMpXnLbFwMddrDcjyKzZTOQMu
        PDqSO6nZrGTeEC0azTr+FG+7UC35NoxnlPSgMh8XoLmA1P9X6f+rCgFiAGtZJaeIUXAByq3x
        7EV/TqbgEuNj/KPPK2rB0i9LJEZgMkz4WwBCAAugCJQWCxeE09Ei4WlZcgqrOi9VJcaxnAW4
        Exi9RvhB2yIVkTGyBPYcyypZ1b8WIRzd1Ijs5O2Pq49+po0+4RtnYiV329N9Ako1w3b8eX6T
        tG6+IztYU/3WnJhWYqi44XesTDpqw9+n3byArrATox3fMdnqh00hw9MbC3JLXMXNt7sTvELL
        C4/20l7yYGtEyHZxvVLjzGYPeW47kqDqSZotDvDMnPTacnhX9fcDpSmTTdVRmlD3gyJ5zU+f
        EdMMd2Jdl7foT2uYc2PEbuf+jsHhvJH8U2LfoLB+a7exT2DEOstf4ZYi+mqI/A4XBdJnzw7W
        /IjTNfxSGEc8drgPyqNsJRLFLvXAXnyuWBWqTl0okLfQ+30L9Q2Gs1Ld1NjxfVmpU0Ug8Fbw
        hpzJGjfuWzKNcbGyAAmq4mR/AS8xISlUAwAA
X-CMS-MailID: 20230220105529epcas5p447cd449f13da54794e391b78bd1f5956
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230220105529epcas5p447cd449f13da54794e391b78bd1f5956
References: <20230220105336.3810-1-nj.shetty@samsung.com>
        <CGME20230220105529epcas5p447cd449f13da54794e391b78bd1f5956@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Before enabling copy for dm target, check if underlying devices and
dm target support copy. Avoid split happening inside dm target.
Fail early if the request needs split, currently splitting copy
request is not supported.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 drivers/md/dm-table.c         | 42 +++++++++++++++++++++++++++++++++++
 drivers/md/dm.c               |  7 ++++++
 include/linux/device-mapper.h |  5 +++++
 3 files changed, 54 insertions(+)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 8541d5688f3a..4a1bbbb2493b 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1875,6 +1875,39 @@ static bool dm_table_supports_nowait(struct dm_table *t)
 	return true;
 }
 
+static int device_not_copy_capable(struct dm_target *ti, struct dm_dev *dev,
+				      sector_t start, sector_t len, void *data)
+{
+	struct request_queue *q = bdev_get_queue(dev->bdev);
+
+	return !blk_queue_copy(q);
+}
+
+static bool dm_table_supports_copy(struct dm_table *t)
+{
+	struct dm_target *ti;
+	unsigned int i;
+
+	for (i = 0; i < t->num_targets; i++) {
+		ti = dm_table_get_target(t, i);
+
+		if (!ti->copy_offload_supported)
+			return false;
+
+		/*
+		 * target provides copy support (as implied by setting
+		 * 'copy_offload_supported')
+		 * and it relies on _all_ data devices having copy support.
+		 */
+		if (!ti->type->iterate_devices ||
+		     ti->type->iterate_devices(ti,
+			     device_not_copy_capable, NULL))
+			return false;
+	}
+
+	return true;
+}
+
 static int device_not_discard_capable(struct dm_target *ti, struct dm_dev *dev,
 				      sector_t start, sector_t len, void *data)
 {
@@ -1957,6 +1990,15 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 		q->limits.discard_misaligned = 0;
 	}
 
+	if (!dm_table_supports_copy(t)) {
+		blk_queue_flag_clear(QUEUE_FLAG_COPY, q);
+		/* Must also clear copy limits... */
+		q->limits.max_copy_sectors = 0;
+		q->limits.max_copy_sectors_hw = 0;
+	} else {
+		blk_queue_flag_set(QUEUE_FLAG_COPY, q);
+	}
+
 	if (!dm_table_supports_secure_erase(t))
 		q->limits.max_secure_erase_sectors = 0;
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index b424a6ee27ba..0b04093fbeb2 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1690,6 +1690,13 @@ static blk_status_t __split_and_process_bio(struct clone_info *ci)
 	if (unlikely(ci->is_abnormal_io))
 		return __process_abnormal_io(ci, ti);
 
+	if ((unlikely(op_is_copy(ci->bio->bi_opf)) &&
+			max_io_len(ti, ci->sector) < ci->sector_count)) {
+		DMERR("Error, IO size(%u) > max target size(%llu)\n",
+			ci->sector_count, max_io_len(ti, ci->sector));
+		return BLK_STS_IOERR;
+	}
+
 	/*
 	 * Only support bio polling for normal IO, and the target io is
 	 * exactly inside the dm_io instance (verified in dm_poll_dm_io)
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 04c6acf7faaa..da4e77e81011 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -379,6 +379,11 @@ struct dm_target {
 	 * bio_set_dev(). NOTE: ideally a target should _not_ need this.
 	 */
 	bool needs_bio_set_dev:1;
+
+	/*
+	 * copy offload is supported
+	 */
+	bool copy_offload_supported:1;
 };
 
 void *dm_per_bio_data(struct bio *bio, size_t data_size);
-- 
2.35.1.500.gb896f729e2

