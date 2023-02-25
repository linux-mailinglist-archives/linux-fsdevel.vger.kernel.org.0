Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406E36A264B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjBYBRs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjBYBQ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:16:56 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F392216AFE
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:51 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id s41so6237oiw.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGm1e+/JzjM4HZAccv9T5Ee/s9Q/Dd9h0fJqrYK+zWw=;
        b=guxOqtrg5l9lXvc3i82eFd23M560WN7rdy2cKvpL9GHW6mV86rjQ/AwZP3RwUYO+Xf
         Knqxvyia6b59SHgJRGyqL5Zl3EDX+QBp1beilND4zAqVy7AFrnse35yFUqQ+TDhJj9/N
         5kgezvUBuyCws+poQ/s9xU7KPIzM8g1cQPrMmOhdeUp38OsGFsbOyqFWigRS8QDFYRA8
         FU3j73IiBSifag9I6wHvDG5oFvAGBK8vZ3tuNJ+FLV96tN8/k1tZ6bmxWErh02E+KMgW
         zfHIH+kCBox5ypN2PIF+jX9kjfeHH0m+pVKeyS5NDlj+hHjgyI6fygeeIcPC8DNYKkdp
         JbqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lGm1e+/JzjM4HZAccv9T5Ee/s9Q/Dd9h0fJqrYK+zWw=;
        b=v7JTKzvInLdCDnAK6TUYAwTmt9LrcPOSF3D2x4lUnsGaJdAc0FqDyARB5hFT+j7Dar
         l5jPJ6gAhBBfVt9RtmOvRNfQPH8CXF5Fg3wbvpb9QfTR23QH03Nymh2DEPY/7UwGgdp9
         adLtbxIALb8v9E7j/1qJAua+gAweHB8X2B8b/ru54G/ImCFLtnZDQ2PUibHe5CmrnnLX
         DJG/DtPRSXrBR3dsQwGrK0w8riONySTC1KJf8ck84DUi+XeGZOukQtuipl1BIiesvq0l
         4r8Ds5Mr0mjPQ1+QVI3OKC9AiefHLooiN8HBJ1mrBaKde/hbla7zYuxjs9XBosUyrAQr
         4kXg==
X-Gm-Message-State: AO0yUKVQ6GK941V25oMQW9SBZLu8FpRAwGs2vdVSmoCKZxPSyU6dJ+6t
        wUjpoKCVeX5l4Y++SLbqZ0y6sFbKDC9a0Ux3
X-Google-Smtp-Source: AK7set/NS440RLO+v7amaSL0E6G7L2iW74nK9GX5jgJm61WwoAPmgUkbjoXgkrQ9AIIyj1vwom3uYQ==
X-Received: by 2002:a05:6808:2b0a:b0:378:954e:95b7 with SMTP id fe10-20020a0568082b0a00b00378954e95b7mr4725779oib.58.1677287810702;
        Fri, 24 Feb 2023 17:16:50 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:16:49 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 36/76] ssdfs: segment object's add data/metadata operations
Date:   Fri, 24 Feb 2023 17:08:47 -0800
Message-Id: <20230225010927.813929-37-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230225010927.813929-1-slava@dubeyko.com>
References: <20230225010927.813929-1-slava@dubeyko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Segment object implements API of adding logical blocks
into user files or metadata structures. It means that if file
or metadata structure (for example, b-tree) needs to grow,
then file system logic has to add/allocate new block or extent.
Add/Allocate logical block operation requires several steps:
(1) Reserve logical block(s) by means decrementing/checking
    the counter of free logical blocks for the whole volume;
(2) Allocate logical block ID(s) by offset translation table
    of segment object;
(3) Add create request into flush thread's queue;
(4) Flush thread processes create request by means of
    compressing user data or metadata and compact several
    compressed logical block into one or several memory pages;
(5) Flush thread execute commit operation by means of preparing
    the log (header + payload + footer) and stores into offset
    translation table the association of logical block ID with
    particular offset into log's payload.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/segment.c | 2426 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 2426 insertions(+)

diff --git a/fs/ssdfs/segment.c b/fs/ssdfs/segment.c
index 6f23c16fe800..9496b18aa1f3 100644
--- a/fs/ssdfs/segment.c
+++ b/fs/ssdfs/segment.c
@@ -1313,3 +1313,2429 @@ ssdfs_grab_segment(struct ssdfs_fs_info *fsi, int seg_type, u64 seg_id,
 
 	return si;
 }
+
+/*
+ * __ssdfs_segment_read_block() - read segment's block
+ * @si: segment info
+ * @req: segment request [in|out]
+ */
+static
+int __ssdfs_segment_read_block(struct ssdfs_segment_info *si,
+			       struct ssdfs_segment_request *req)
+{
+	struct ssdfs_blk2off_table *table;
+	struct ssdfs_phys_offset_descriptor *po_desc;
+	struct ssdfs_peb_container *pebc;
+	struct ssdfs_requests_queue *rq;
+	wait_queue_head_t *wait;
+	u16 peb_index = U16_MAX;
+	u16 logical_blk;
+	struct ssdfs_offset_position pos = {0};
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si || !req);
+
+	SSDFS_DBG("seg %llu, ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu\n",
+		  si->seg_id,
+		  req->extent.ino, req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	table = si->blk2off_table;
+	logical_blk = req->place.start.blk_index;
+
+	po_desc = ssdfs_blk2off_table_convert(table, logical_blk,
+						&peb_index, NULL, &pos);
+	if (IS_ERR(po_desc) && PTR_ERR(po_desc) == -EAGAIN) {
+		struct completion *end = &table->full_init_end;
+
+		err = SSDFS_WAIT_COMPLETION(end);
+		if (unlikely(err)) {
+			SSDFS_ERR("blk2off init failed: "
+				  "err %d\n", err);
+			return err;
+		}
+
+		po_desc = ssdfs_blk2off_table_convert(table, logical_blk,
+							&peb_index, NULL,
+							&pos);
+	}
+
+	if (IS_ERR_OR_NULL(po_desc)) {
+		err = (po_desc == NULL ? -ERANGE : PTR_ERR(po_desc));
+		SSDFS_ERR("fail to convert: "
+			  "logical_blk %u, err %d\n",
+			  logical_blk, err);
+		return err;
+	}
+
+	if (peb_index >= si->pebs_count) {
+		SSDFS_ERR("peb_index %u >= si->pebs_count %u\n",
+			  peb_index, si->pebs_count);
+		return -ERANGE;
+	}
+
+	pebc = &si->peb_array[peb_index];
+
+	ssdfs_peb_read_request_cno(pebc);
+
+	rq = &pebc->read_rq;
+	ssdfs_requests_queue_add_tail(rq, req);
+
+	wait = &si->wait_queue[SSDFS_PEB_READ_THREAD];
+	wake_up_all(wait);
+
+	return 0;
+}
+
+/*
+ * ssdfs_segment_read_block_sync() - read segment's block synchronously
+ * @si: segment info
+ * @req: segment request [in|out]
+ */
+int ssdfs_segment_read_block_sync(struct ssdfs_segment_info *si,
+				  struct ssdfs_segment_request *req)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si || !req);
+
+	SSDFS_DBG("seg %llu, ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu\n",
+		  si->seg_id, req->extent.ino,
+		  req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_READ_REQ,
+					    SSDFS_READ_PAGE,
+					    SSDFS_REQ_SYNC,
+					    req);
+	ssdfs_request_define_segment(si->seg_id, req);
+
+	return __ssdfs_segment_read_block(si, req);
+}
+
+/*
+ * ssdfs_segment_read_block_async() - read segment's block asynchronously
+ * @req_type: request type
+ * @si: segment info
+ * @req: segment request [in|out]
+ */
+int ssdfs_segment_read_block_async(struct ssdfs_segment_info *si,
+				  int req_type,
+				  struct ssdfs_segment_request *req)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si || !req);
+
+	SSDFS_DBG("seg %llu, ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu\n",
+		  si->seg_id, req->extent.ino,
+		  req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (req_type) {
+	case SSDFS_REQ_ASYNC:
+	case SSDFS_REQ_ASYNC_NO_FREE:
+		/* expected request type */
+		break;
+
+	default:
+		SSDFS_ERR("unexpected request type %#x\n",
+			  req_type);
+		return -EINVAL;
+	}
+
+	ssdfs_request_prepare_internal_data(SSDFS_PEB_READ_REQ,
+					    SSDFS_READ_PAGE,
+					    req_type, req);
+	ssdfs_request_define_segment(si->seg_id, req);
+
+	return __ssdfs_segment_read_block(si, req);
+}
+
+/*
+ * ssdfs_segment_get_used_data_pages() - get segment's used data pages count
+ * @si: segment object
+ *
+ * This function tries to get segment's used data pages count.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code.
+ */
+int ssdfs_segment_get_used_data_pages(struct ssdfs_segment_info *si)
+{
+	int used_pages = 0;
+	int i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si);
+
+	SSDFS_DBG("seg %llu\n", si->seg_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (i = 0; i < si->pebs_count; i++) {
+		struct ssdfs_peb_container *pebc = &si->peb_array[i];
+
+		err = ssdfs_peb_get_used_data_pages(pebc);
+		if (err < 0) {
+			SSDFS_ERR("fail to get used data pages count: "
+				  "seg %llu, peb index %d, err %d\n",
+				  si->seg_id, i, err);
+			return err;
+		} else
+			used_pages += err;
+	}
+
+	return used_pages;
+}
+
+/*
+ * ssdfs_segment_change_state() - change segment state
+ * @si: pointer on segment object
+ */
+int ssdfs_segment_change_state(struct ssdfs_segment_info *si)
+{
+	struct ssdfs_segment_bmap *segbmap;
+	struct ssdfs_blk2off_table *blk2off_tbl;
+	u32 pages_per_seg;
+	u16 used_logical_blks;
+	int free_pages, invalid_pages;
+	bool need_change_state = false;
+	int seg_state, old_seg_state;
+	int new_seg_state = SSDFS_SEG_STATE_MAX;
+	u64 seg_id;
+	struct completion *init_end;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	seg_id = si->seg_id;
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("si %p, seg_id %llu\n",
+		  si, seg_id);
+#else
+	SSDFS_DBG("si %p, seg_id %llu\n",
+		  si, seg_id);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	blk2off_tbl = si->blk2off_table;
+	segbmap = si->fsi->segbmap;
+
+	err = ssdfs_blk2off_table_get_used_logical_blks(blk2off_tbl,
+							&used_logical_blks);
+	if (err == -EAGAIN) {
+		init_end = &blk2off_tbl->partial_init_end;
+
+		err = SSDFS_WAIT_COMPLETION(init_end);
+		if (unlikely(err)) {
+			SSDFS_ERR("blk2off init failed: "
+				  "err %d\n", err);
+			return err;
+		}
+
+		err = ssdfs_blk2off_table_get_used_logical_blks(blk2off_tbl,
+							    &used_logical_blks);
+	}
+
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to get used logical blocks count: "
+			  "err %d\n",
+			  err);
+		return err;
+	} else if (used_logical_blks == U16_MAX) {
+		SSDFS_ERR("invalid used logical blocks count\n");
+		return -ERANGE;
+	}
+
+	pages_per_seg = si->fsi->pages_per_seg;
+	seg_state = atomic_read(&si->seg_state);
+	free_pages = ssdfs_segment_blk_bmap_get_free_pages(&si->blk_bmap);
+	invalid_pages = ssdfs_segment_blk_bmap_get_invalid_pages(&si->blk_bmap);
+
+	if (free_pages > pages_per_seg) {
+		SSDFS_ERR("free_pages %d > pages_per_seg %u\n",
+			  free_pages, pages_per_seg);
+		return -ERANGE;
+	}
+
+	switch (seg_state) {
+	case SSDFS_SEG_CLEAN:
+		if (free_pages == pages_per_seg) {
+			/*
+			 * Do nothing.
+			 */
+		} else if (free_pages > 0) {
+			need_change_state = true;
+
+			if (invalid_pages > 0) {
+				new_seg_state = SSDFS_SEG_PRE_DIRTY;
+			} else {
+				new_seg_state =
+					SEG_TYPE_TO_USING_STATE(si->seg_type);
+				if (new_seg_state < 0 ||
+				    new_seg_state == SSDFS_SEG_STATE_MAX) {
+					SSDFS_ERR("invalid seg_type %#x\n",
+						  si->seg_type);
+					return -ERANGE;
+				}
+			}
+		} else {
+			need_change_state = true;
+
+			if (invalid_pages == 0)
+				new_seg_state = SSDFS_SEG_USED;
+			else if (used_logical_blks == 0)
+				new_seg_state = SSDFS_SEG_DIRTY;
+			else
+				new_seg_state = SSDFS_SEG_PRE_DIRTY;
+		}
+		break;
+
+	case SSDFS_SEG_DATA_USING:
+	case SSDFS_SEG_LEAF_NODE_USING:
+	case SSDFS_SEG_HYBRID_NODE_USING:
+	case SSDFS_SEG_INDEX_NODE_USING:
+		if (free_pages == pages_per_seg) {
+			if (invalid_pages == 0 && used_logical_blks == 0) {
+				need_change_state = true;
+				new_seg_state = SSDFS_SEG_CLEAN;
+			} else {
+				SSDFS_ERR("free_pages %d == pages_per_seg %u\n",
+					  free_pages, pages_per_seg);
+				return -ERANGE;
+			}
+		} else if (free_pages > 0) {
+			if (invalid_pages > 0) {
+				need_change_state = true;
+				new_seg_state = SSDFS_SEG_PRE_DIRTY;
+			}
+		} else {
+			need_change_state = true;
+
+			if (invalid_pages == 0)
+				new_seg_state = SSDFS_SEG_USED;
+			else if (used_logical_blks == 0)
+				new_seg_state = SSDFS_SEG_DIRTY;
+			else
+				new_seg_state = SSDFS_SEG_PRE_DIRTY;
+		}
+		break;
+
+	case SSDFS_SEG_USED:
+		if (free_pages == pages_per_seg) {
+			if (invalid_pages == 0 && used_logical_blks == 0) {
+				need_change_state = true;
+				new_seg_state = SSDFS_SEG_CLEAN;
+			} else {
+				SSDFS_ERR("free_pages %d == pages_per_seg %u\n",
+					  free_pages, pages_per_seg);
+				return -ERANGE;
+			}
+		} else if (invalid_pages > 0) {
+			need_change_state = true;
+
+			if (used_logical_blks > 0) {
+				/* pre-dirty state */
+				new_seg_state = SSDFS_SEG_PRE_DIRTY;
+			} else if (free_pages > 0) {
+				/* pre-dirty state */
+				new_seg_state = SSDFS_SEG_PRE_DIRTY;
+			} else {
+				/* dirty state */
+				new_seg_state = SSDFS_SEG_DIRTY;
+			}
+		} else if (free_pages > 0) {
+			need_change_state = true;
+			new_seg_state = SEG_TYPE_TO_USING_STATE(si->seg_type);
+			if (new_seg_state < 0 ||
+			    new_seg_state == SSDFS_SEG_STATE_MAX) {
+				SSDFS_ERR("invalid seg_type %#x\n",
+					  si->seg_type);
+				return -ERANGE;
+			}
+		}
+		break;
+
+	case SSDFS_SEG_PRE_DIRTY:
+		if (free_pages == pages_per_seg) {
+			if (invalid_pages == 0 && used_logical_blks == 0) {
+				need_change_state = true;
+				new_seg_state = SSDFS_SEG_CLEAN;
+			} else {
+				SSDFS_ERR("free_pages %d == pages_per_seg %u\n",
+					  free_pages, pages_per_seg);
+				return -ERANGE;
+			}
+		} else if (invalid_pages > 0) {
+			if (used_logical_blks == 0) {
+				need_change_state = true;
+				new_seg_state = SSDFS_SEG_DIRTY;
+			}
+		} else if (free_pages > 0) {
+			need_change_state = true;
+			new_seg_state = SEG_TYPE_TO_USING_STATE(si->seg_type);
+			if (new_seg_state < 0 ||
+			    new_seg_state == SSDFS_SEG_STATE_MAX) {
+				SSDFS_ERR("invalid seg_type %#x\n",
+					  si->seg_type);
+				return -ERANGE;
+			}
+		} else if (free_pages == 0 && invalid_pages == 0) {
+			if (used_logical_blks == 0) {
+				SSDFS_ERR("invalid state: "
+					  "invalid_pages %d, "
+					  "free_pages %d, "
+					  "used_logical_blks %u\n",
+					  invalid_pages,
+					  free_pages,
+					  used_logical_blks);
+				return -ERANGE;
+			} else {
+				need_change_state = true;
+				new_seg_state = SSDFS_SEG_USED;
+			}
+		}
+		break;
+
+	case SSDFS_SEG_DIRTY:
+		if (free_pages == pages_per_seg) {
+			if (invalid_pages == 0 && used_logical_blks == 0) {
+				need_change_state = true;
+				new_seg_state = SSDFS_SEG_CLEAN;
+			} else {
+				SSDFS_ERR("free_pages %d == pages_per_seg %u\n",
+					  free_pages, pages_per_seg);
+				return -ERANGE;
+			}
+		} else if (invalid_pages > 0) {
+			if (used_logical_blks > 0 || free_pages > 0) {
+				need_change_state = true;
+				new_seg_state = SSDFS_SEG_PRE_DIRTY;
+			}
+		} else if (free_pages > 0) {
+			need_change_state = true;
+			new_seg_state = SEG_TYPE_TO_USING_STATE(si->seg_type);
+			if (new_seg_state < 0 ||
+			    new_seg_state == SSDFS_SEG_STATE_MAX) {
+				SSDFS_ERR("invalid seg_type %#x\n",
+					  si->seg_type);
+				return -ERANGE;
+			}
+		} else if (free_pages == 0 && invalid_pages == 0) {
+			if (used_logical_blks == 0) {
+				SSDFS_ERR("invalid state: "
+					  "invalid_pages %d, "
+					  "free_pages %d, "
+					  "used_logical_blks %u\n",
+					  invalid_pages,
+					  free_pages,
+					  used_logical_blks);
+				return -ERANGE;
+			} else {
+				need_change_state = true;
+				new_seg_state = SSDFS_SEG_USED;
+			}
+		}
+		break;
+
+	case SSDFS_SEG_BAD:
+	case SSDFS_SEG_RESERVED:
+		/* do nothing */
+		break;
+
+	default:
+		break;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("old_state %#x, new_state %#x, "
+		  "need_change_state %#x, free_pages %d, "
+		  "invalid_pages %d, used_logical_blks %u\n",
+		  seg_state, new_seg_state,
+		  need_change_state, free_pages,
+		  invalid_pages, used_logical_blks);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!need_change_state) {
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+		SSDFS_ERR("no need to change state\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+		return 0;
+	}
+
+	err = ssdfs_segbmap_change_state(segbmap, seg_id,
+					 new_seg_state, &init_end);
+	if (err == -EAGAIN) {
+		err = SSDFS_WAIT_COMPLETION(init_end);
+		if (unlikely(err)) {
+			SSDFS_ERR("segbmap init failed: "
+				  "err %d\n", err);
+			return err;
+		}
+
+		err = ssdfs_segbmap_change_state(segbmap, seg_id,
+						 new_seg_state,
+						 &init_end);
+		if (unlikely(err))
+			goto fail_change_state;
+	} else if (unlikely(err)) {
+fail_change_state:
+		SSDFS_ERR("fail to change segment state: "
+			  "seg %llu, state %#x, err %d\n",
+			  seg_id, new_seg_state, err);
+		return err;
+	}
+
+	old_seg_state = atomic_cmpxchg(&si->seg_state,
+					seg_state, new_seg_state);
+	if (old_seg_state != seg_state) {
+		SSDFS_WARN("old_seg_state %#x != seg_state %#x\n",
+			   old_seg_state, seg_state);
+	}
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return 0;
+}
+
+/*
+ * ssdfs_current_segment_change_state() - change current segment state
+ * @cur_seg: pointer on current segment
+ */
+static
+int ssdfs_current_segment_change_state(struct ssdfs_current_segment *cur_seg)
+{
+	struct ssdfs_segment_info *si;
+	u64 seg_id;
+	int seg_state;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!cur_seg || !cur_seg->real_seg);
+	BUG_ON(!mutex_is_locked(&cur_seg->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	si = cur_seg->real_seg;
+	seg_id = si->seg_id;
+	seg_state = atomic_read(&cur_seg->real_seg->seg_state);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("cur_seg %p, si %p, seg_id %llu, seg_state %#x\n",
+		  cur_seg, si, seg_id, seg_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (seg_state) {
+	case SSDFS_SEG_CLEAN:
+	case SSDFS_SEG_DATA_USING:
+	case SSDFS_SEG_LEAF_NODE_USING:
+	case SSDFS_SEG_HYBRID_NODE_USING:
+	case SSDFS_SEG_INDEX_NODE_USING:
+	case SSDFS_SEG_USED:
+	case SSDFS_SEG_PRE_DIRTY:
+		err = ssdfs_segment_change_state(si);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to change segment's state: "
+				  "seg_id %llu, err %d\n",
+				  seg_id, err);
+			return err;
+		}
+		break;
+
+	case SSDFS_SEG_DIRTY:
+	case SSDFS_SEG_BAD:
+	case SSDFS_SEG_RESERVED:
+		SSDFS_ERR("invalid segment state: %#x\n",
+			  seg_state);
+		return -ERANGE;
+
+	default:
+		BUG();
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_calculate_zns_reservation_threshold() - reservation threshold
+ */
+static inline
+u32 ssdfs_calculate_zns_reservation_threshold(void)
+{
+	u32 threshold;
+
+	threshold = SSDFS_CUR_SEGS_COUNT * 2;
+	threshold += SSDFS_SB_CHAIN_MAX * SSDFS_SB_SEG_COPY_MAX;
+	threshold += SSDFS_SEGBMAP_SEGS * SSDFS_SEGBMAP_SEG_COPY_MAX;
+	threshold += SSDFS_MAPTBL_RESERVED_EXTENTS * SSDFS_MAPTBL_SEG_COPY_MAX;
+
+	return threshold;
+}
+
+/*
+ * CHECKED_SEG_TYPE() - correct segment type
+ * @fsi: pointer on shared file system object
+ * @cur_seg_type: checking segment type
+ */
+static inline
+int CHECKED_SEG_TYPE(struct ssdfs_fs_info *fsi, int cur_seg_type)
+{
+	u32 threshold = ssdfs_calculate_zns_reservation_threshold();
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (!fsi->is_zns_device)
+		return cur_seg_type;
+
+	if (threshold < (fsi->max_open_zones / 2))
+		return cur_seg_type;
+
+	switch (cur_seg_type) {
+	case SSDFS_CUR_LNODE_SEG:
+	case SSDFS_CUR_HNODE_SEG:
+	case SSDFS_CUR_IDXNODE_SEG:
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("segment type %#x is corrected to %#x\n",
+			  cur_seg_type, SSDFS_CUR_LNODE_SEG);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return SSDFS_CUR_LNODE_SEG;
+
+	default:
+		/* do nothing */
+		break;
+	}
+
+	return cur_seg_type;
+}
+
+/*
+ * can_current_segment_be_added() - check that current segment can be added
+ * @si: pointer on segment object
+ */
+static inline
+bool can_current_segment_be_added(struct ssdfs_segment_info *si)
+{
+	struct ssdfs_fs_info *fsi;
+	u32 threshold = ssdfs_calculate_zns_reservation_threshold();
+	int open_zones;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!si);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fsi = si->fsi;
+
+	if (!fsi->is_zns_device)
+		return true;
+
+	switch (si->seg_type) {
+	case SSDFS_LEAF_NODE_SEG_TYPE:
+	case SSDFS_HYBRID_NODE_SEG_TYPE:
+	case SSDFS_INDEX_NODE_SEG_TYPE:
+		open_zones = atomic_read(&fsi->open_zones);
+
+		if (threshold < ((fsi->max_open_zones - open_zones) / 2))
+			return true;
+		else
+			return false;
+
+	case SSDFS_USER_DATA_SEG_TYPE:
+		return true;
+
+	default:
+		/* do nothing */
+		break;
+	}
+
+	SSDFS_WARN("unexpected segment type %#x\n",
+		   si->seg_type);
+
+	return false;
+}
+
+/*
+ * __ssdfs_segment_add_block() - add new block into segment
+ * @cur_seg: current segment container
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to add new block into segment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+static
+int __ssdfs_segment_add_block(struct ssdfs_current_segment *cur_seg,
+			       struct ssdfs_segment_request *req,
+			       u64 *seg_id,
+			       struct ssdfs_blk2off_range *extent)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_segment_info *si;
+	int seg_type;
+	u64 start = U64_MAX;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!cur_seg || !req || !seg_id || !extent);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu\n",
+		  req->extent.ino, req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot);
+#else
+	SSDFS_DBG("ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu\n",
+		  req->extent.ino, req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	fsi = cur_seg->fsi;
+	*seg_id = U64_MAX;
+
+	ssdfs_current_segment_lock(cur_seg);
+
+	seg_type = CHECKED_SEG_TYPE(fsi, SEG_TYPE(req->private.class));
+
+try_current_segment:
+	if (is_ssdfs_current_segment_empty(cur_seg)) {
+add_new_current_segment:
+		start = cur_seg->seg_id;
+		si = ssdfs_grab_segment(cur_seg->fsi, seg_type,
+					U64_MAX, start);
+		if (IS_ERR_OR_NULL(si)) {
+			err = (si == NULL ? -ENOMEM : PTR_ERR(si));
+			if (err == -ENOSPC) {
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("unable to create segment object: "
+					  "err %d\n", err);
+#endif /* CONFIG_SSDFS_DEBUG */
+			} else {
+				SSDFS_ERR("fail to create segment object: "
+					  "err %d\n", err);
+			}
+
+			goto finish_add_block;
+		}
+
+		err = ssdfs_current_segment_add(cur_seg, si);
+		/*
+		 * ssdfs_grab_segment() has got object already.
+		 */
+		ssdfs_segment_put_object(si);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to add segment %llu as current: "
+				  "err %d\n",
+				  si->seg_id, err);
+			goto finish_add_block;
+		}
+
+		goto try_current_segment;
+	} else {
+		si = cur_seg->real_seg;
+
+		err = ssdfs_segment_blk_bmap_reserve_block(&si->blk_bmap);
+		if (err == -E2BIG) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("segment %llu hasn't enough free pages\n",
+				  si->seg_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			err = ssdfs_current_segment_change_state(cur_seg);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to change segment state: "
+					  "seg %llu, err %d\n",
+					  si->seg_id, err);
+				goto finish_add_block;
+			}
+
+			if (can_current_segment_be_added(si)) {
+				err = 0;
+				ssdfs_current_segment_remove(cur_seg);
+				goto add_new_current_segment;
+			}
+
+			err = -ENOSPC;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to add current segment: "
+				  "err %d\n", err);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_add_block;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to reserve logical block: "
+				  "seg %llu, err %d\n",
+				  cur_seg->real_seg->seg_id, err);
+			goto finish_add_block;
+		} else {
+			struct ssdfs_blk2off_table *table;
+			struct ssdfs_requests_queue *create_rq;
+			wait_queue_head_t *wait;
+			u16 blk;
+
+			table = si->blk2off_table;
+
+			*seg_id = si->seg_id;
+			ssdfs_request_define_segment(si->seg_id, req);
+
+			err = ssdfs_blk2off_table_allocate_block(table, &blk);
+			if (err == -EAGAIN) {
+				struct completion *end;
+				end = &table->partial_init_end;
+
+				err = SSDFS_WAIT_COMPLETION(end);
+				if (unlikely(err)) {
+					SSDFS_ERR("blk2off init failed: "
+						  "err %d\n", err);
+					goto finish_add_block;
+				}
+
+				err = ssdfs_blk2off_table_allocate_block(table,
+									 &blk);
+			}
+
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to allocate logical block\n");
+				goto finish_add_block;
+			}
+
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG_ON(blk > U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			extent->start_lblk = blk;
+			extent->len = 1;
+
+			ssdfs_request_define_volume_extent(blk, 1, req);
+
+			err = ssdfs_current_segment_change_state(cur_seg);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to change segment state: "
+					  "seg %llu, err %d\n",
+					  cur_seg->real_seg->seg_id, err);
+				goto finish_add_block;
+			}
+
+			ssdfs_account_user_data_flush_request(si);
+			ssdfs_segment_create_request_cno(si);
+
+			create_rq = &si->create_rq;
+			ssdfs_requests_queue_add_tail_inc(si->fsi,
+							create_rq, req);
+
+			wait = &si->wait_queue[SSDFS_PEB_FLUSH_THREAD];
+			wake_up_all(wait);
+		}
+	}
+
+finish_add_block:
+	ssdfs_current_segment_unlock(cur_seg);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished: seg %llu\n",
+		  cur_seg->real_seg->seg_id);
+#else
+	SSDFS_DBG("finished: seg %llu\n",
+		  cur_seg->real_seg->seg_id);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	if (err == -ENOSPC) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to add block: "
+			  "ino %llu, logical_offset %llu, err %d\n",
+			  req->extent.ino, req->extent.logical_offset, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return err;
+	} else if (err) {
+		SSDFS_ERR("fail to add block: "
+			  "ino %llu, logical_offset %llu, err %d\n",
+			  req->extent.ino, req->extent.logical_offset, err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * __ssdfs_segment_add_extent() - add new extent into segment
+ * @cur_seg: current segment container
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to add new extent into segment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+static
+int __ssdfs_segment_add_extent(struct ssdfs_current_segment *cur_seg,
+			       struct ssdfs_segment_request *req,
+			       u64 *seg_id,
+			       struct ssdfs_blk2off_range *extent)
+{
+	struct ssdfs_fs_info *fsi;
+	struct ssdfs_segment_info *si;
+	int seg_type;
+	u64 start = U64_MAX;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!cur_seg || !req || !seg_id || !extent);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu\n",
+		  req->extent.ino, req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot);
+#else
+	SSDFS_DBG("ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu\n",
+		  req->extent.ino, req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot);
+	SSDFS_DBG("current segment: type %#x, seg_id %llu, real_seg %px\n",
+		  cur_seg->type, cur_seg->seg_id, cur_seg->real_seg);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	fsi = cur_seg->fsi;
+	*seg_id = U64_MAX;
+
+	ssdfs_current_segment_lock(cur_seg);
+
+	seg_type = CHECKED_SEG_TYPE(fsi, SEG_TYPE(req->private.class));
+
+try_current_segment:
+	if (is_ssdfs_current_segment_empty(cur_seg)) {
+add_new_current_segment:
+		start = cur_seg->seg_id;
+		si = ssdfs_grab_segment(fsi, seg_type, U64_MAX, start);
+		if (IS_ERR_OR_NULL(si)) {
+			err = (si == NULL ? -ENOMEM : PTR_ERR(si));
+			if (err == -ENOSPC) {
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("unable to create segment object: "
+					  "err %d\n", err);
+#endif /* CONFIG_SSDFS_DEBUG */
+			} else {
+				SSDFS_ERR("fail to create segment object: "
+					  "err %d\n", err);
+			}
+
+			goto finish_add_extent;
+		}
+
+		err = ssdfs_current_segment_add(cur_seg, si);
+		/*
+		 * ssdfs_grab_segment() has got object already.
+		 */
+		ssdfs_segment_put_object(si);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to add segment %llu as current: "
+				  "err %d\n",
+				  si->seg_id, err);
+			goto finish_add_extent;
+		}
+
+		goto try_current_segment;
+	} else {
+		struct ssdfs_segment_blk_bmap *blk_bmap;
+		u32 extent_bytes = req->extent.data_bytes;
+		u16 blks_count;
+
+		if (fsi->pagesize > PAGE_SIZE)
+			extent_bytes += fsi->pagesize - 1;
+		else if (fsi->pagesize <= PAGE_SIZE)
+			extent_bytes += PAGE_SIZE - 1;
+
+		si = cur_seg->real_seg;
+		blk_bmap = &si->blk_bmap;
+		blks_count = extent_bytes >> fsi->log_pagesize;
+
+		err = ssdfs_segment_blk_bmap_reserve_extent(&si->blk_bmap,
+							    blks_count);
+		if (err == -E2BIG) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("segment %llu hasn't enough free pages\n",
+				  cur_seg->real_seg->seg_id);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			err = ssdfs_current_segment_change_state(cur_seg);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to change segment state: "
+					  "seg %llu, err %d\n",
+					  cur_seg->real_seg->seg_id, err);
+				goto finish_add_extent;
+			}
+
+			if (can_current_segment_be_added(si)) {
+				err = 0;
+				ssdfs_current_segment_remove(cur_seg);
+				goto add_new_current_segment;
+			}
+
+			err = -ENOSPC;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to add current segment: "
+				  "err %d\n", err);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_add_extent;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to reserve logical extent: "
+				  "seg %llu, err %d\n",
+				  cur_seg->real_seg->seg_id, err);
+			goto finish_add_extent;
+		} else {
+			struct ssdfs_blk2off_table *table;
+			struct ssdfs_requests_queue *create_rq;
+
+			table = si->blk2off_table;
+
+			*seg_id = si->seg_id;
+			ssdfs_request_define_segment(si->seg_id, req);
+
+			err = ssdfs_blk2off_table_allocate_extent(table,
+								  blks_count,
+								  extent);
+			if (err == -EAGAIN) {
+				struct completion *end;
+				end = &table->partial_init_end;
+
+				err = SSDFS_WAIT_COMPLETION(end);
+				if (unlikely(err)) {
+					SSDFS_ERR("blk2off init failed: "
+						  "err %d\n", err);
+					goto finish_add_extent;
+				}
+
+				err = ssdfs_blk2off_table_allocate_extent(table,
+								     blks_count,
+								     extent);
+			}
+
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to allocate logical extent\n");
+				goto finish_add_extent;
+			}
+
+#ifdef CONFIG_SSDFS_DEBUG
+			BUG_ON(extent->start_lblk >= U16_MAX);
+			BUG_ON(extent->len != blks_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			ssdfs_request_define_volume_extent(extent->start_lblk,
+							   extent->len, req);
+
+			err = ssdfs_current_segment_change_state(cur_seg);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to change segment state: "
+					  "seg %llu, err %d\n",
+					  cur_seg->real_seg->seg_id, err);
+				goto finish_add_extent;
+			}
+
+			ssdfs_account_user_data_flush_request(si);
+			ssdfs_segment_create_request_cno(si);
+
+			create_rq = &si->create_rq;
+			ssdfs_requests_queue_add_tail_inc(si->fsi,
+							create_rq, req);
+			wake_up_all(&si->wait_queue[SSDFS_PEB_FLUSH_THREAD]);
+		}
+	}
+
+finish_add_extent:
+	ssdfs_current_segment_unlock(cur_seg);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	if (cur_seg->real_seg) {
+		SSDFS_ERR("finished: seg %llu\n",
+			  cur_seg->real_seg->seg_id);
+	}
+#else
+	if (cur_seg->real_seg) {
+		SSDFS_DBG("finished: seg %llu\n",
+			  cur_seg->real_seg->seg_id);
+	}
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	if (err == -ENOSPC) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to add extent: "
+			  "ino %llu, logical_offset %llu, err %d\n",
+			  req->extent.ino, req->extent.logical_offset, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return err;
+	} else if (err) {
+		SSDFS_ERR("fail to add extent: "
+			  "ino %llu, logical_offset %llu, err %d\n",
+			  req->extent.ino, req->extent.logical_offset, err);
+		return err;
+	}
+
+	return 0;
+}
+
+/*
+ * __ssdfs_segment_add_block_sync() - add new block synchronously
+ * @fsi: pointer on shared file system object
+ * @req_class: request class
+ * @req_type: request type
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to add new block into segment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+static
+int __ssdfs_segment_add_block_sync(struct ssdfs_fs_info *fsi,
+				   int req_class,
+				   int req_type,
+				   struct ssdfs_segment_request *req,
+				   u64 *seg_id,
+				   struct ssdfs_blk2off_range *extent)
+{
+	struct ssdfs_current_segment *cur_seg;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !req);
+	BUG_ON(req_class <= SSDFS_PEB_READ_REQ ||
+		req_class > SSDFS_PEB_CREATE_IDXNODE_REQ);
+
+	SSDFS_DBG("ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu\n",
+		  req->extent.ino, req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (req_type) {
+	case SSDFS_REQ_SYNC:
+		/* expected request type */
+		break;
+
+	default:
+		SSDFS_ERR("unexpected request type %#x\n",
+			  req_type);
+		return -EINVAL;
+	}
+
+	ssdfs_request_prepare_internal_data(req_class,
+					    SSDFS_CREATE_BLOCK,
+					    req_type, req);
+
+	down_read(&fsi->cur_segs->lock);
+	cur_seg = fsi->cur_segs->objects[CUR_SEG_TYPE(req_class)];
+	err = __ssdfs_segment_add_block(cur_seg, req, seg_id, extent);
+	up_read(&fsi->cur_segs->lock);
+
+	return err;
+}
+
+/*
+ * __ssdfs_segment_add_block_async() - add new block asynchronously
+ * @fsi: pointer on shared file system object
+ * @req_class: request class
+ * @req_type: request type
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to add new block into segment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+static
+int __ssdfs_segment_add_block_async(struct ssdfs_fs_info *fsi,
+				    int req_class,
+				    int req_type,
+				    struct ssdfs_segment_request *req,
+				    u64 *seg_id,
+				    struct ssdfs_blk2off_range *extent)
+{
+	struct ssdfs_current_segment *cur_seg;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !req);
+	BUG_ON(req_class <= SSDFS_PEB_READ_REQ ||
+		req_class > SSDFS_PEB_CREATE_IDXNODE_REQ);
+
+	SSDFS_DBG("ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu\n",
+		  req->extent.ino, req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (req_type) {
+	case SSDFS_REQ_ASYNC:
+	case SSDFS_REQ_ASYNC_NO_FREE:
+		/* expected request type */
+		break;
+
+	default:
+		SSDFS_ERR("unexpected request type %#x\n",
+			  req_type);
+		return -EINVAL;
+	}
+
+	ssdfs_request_prepare_internal_data(req_class,
+					    SSDFS_CREATE_BLOCK,
+					    req_type, req);
+
+	down_read(&fsi->cur_segs->lock);
+	cur_seg = fsi->cur_segs->objects[CUR_SEG_TYPE(req_class)];
+	err = __ssdfs_segment_add_block(cur_seg, req, seg_id, extent);
+	up_read(&fsi->cur_segs->lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_segment_pre_alloc_data_block_sync() - synchronous pre-alloc data block
+ * @fsi: pointer on shared file system object
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to pre-allocate a new data block into segment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_pre_alloc_data_block_sync(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent)
+{
+	return __ssdfs_segment_add_block_sync(fsi,
+					      SSDFS_PEB_PRE_ALLOCATE_DATA_REQ,
+					      SSDFS_REQ_SYNC,
+					      req, seg_id, extent);
+}
+
+/*
+ * ssdfs_segment_pre_alloc_data_block_async() - async pre-alloc data block
+ * @fsi: pointer on shared file system object
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to pre-allocate a new data block into segment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_pre_alloc_data_block_async(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent)
+{
+	return __ssdfs_segment_add_block_async(fsi,
+					       SSDFS_PEB_PRE_ALLOCATE_DATA_REQ,
+					       SSDFS_REQ_ASYNC,
+					       req, seg_id, extent);
+}
+
+/*
+ * ssdfs_segment_pre_alloc_leaf_node_block_sync() - sync pre-alloc leaf node
+ * @fsi: pointer on shared file system object
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to pre-allocate a leaf node's block into segment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_pre_alloc_leaf_node_block_sync(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent)
+{
+	return __ssdfs_segment_add_block_sync(fsi,
+					      SSDFS_PEB_PRE_ALLOCATE_LNODE_REQ,
+					      SSDFS_REQ_SYNC,
+					      req, seg_id, extent);
+}
+
+/*
+ * ssdfs_segment_pre_alloc_leaf_node_block_async() - async pre-alloc leaf node
+ * @fsi: pointer on shared file system object
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to pre-allocate a leaf node's block into segment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_pre_alloc_leaf_node_block_async(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent)
+{
+	return __ssdfs_segment_add_block_async(fsi,
+					       SSDFS_PEB_PRE_ALLOCATE_LNODE_REQ,
+					       SSDFS_REQ_ASYNC,
+					       req, seg_id, extent);
+}
+
+/*
+ * ssdfs_segment_pre_alloc_hybrid_node_block_sync() - sync pre-alloc hybrid node
+ * @fsi: pointer on shared file system object
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to pre-allocate a hybrid node's block into segment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_pre_alloc_hybrid_node_block_sync(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent)
+{
+	return __ssdfs_segment_add_block_sync(fsi,
+					      SSDFS_PEB_PRE_ALLOCATE_HNODE_REQ,
+					      SSDFS_REQ_SYNC,
+					      req, seg_id, extent);
+}
+
+/*
+ * ssdfs_segment_pre_alloc_hybrid_node_block_async() - pre-alloc hybrid node
+ * @fsi: pointer on shared file system object
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to pre-allocate a hybrid node's block into segment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_pre_alloc_hybrid_node_block_async(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent)
+{
+	return __ssdfs_segment_add_block_async(fsi,
+					       SSDFS_PEB_PRE_ALLOCATE_HNODE_REQ,
+					       SSDFS_REQ_ASYNC,
+					       req, seg_id, extent);
+}
+
+/*
+ * ssdfs_segment_pre_alloc_index_node_block_sync() - sync pre-alloc index node
+ * @fsi: pointer on shared file system object
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to pre-allocate an index node's block into segment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_pre_alloc_index_node_block_sync(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent)
+{
+	return __ssdfs_segment_add_block_sync(fsi,
+					     SSDFS_PEB_PRE_ALLOCATE_IDXNODE_REQ,
+					     SSDFS_REQ_SYNC,
+					     req, seg_id, extent);
+}
+
+/*
+ * ssdfs_segment_pre_alloc_index_node_block_async() - pre-alloc index node
+ * @fsi: pointer on shared file system object
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to pre-allocate an index node's block into segment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_pre_alloc_index_node_block_async(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent)
+{
+	return __ssdfs_segment_add_block_async(fsi,
+					     SSDFS_PEB_PRE_ALLOCATE_IDXNODE_REQ,
+					     SSDFS_REQ_ASYNC,
+					     req, seg_id, extent);
+}
+
+/*
+ * ssdfs_segment_add_data_block_sync() - add new data block synchronously
+ * @fsi: pointer on shared file system object
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to add new data block into segment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_add_data_block_sync(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent)
+{
+	return __ssdfs_segment_add_block_sync(fsi,
+						SSDFS_PEB_CREATE_DATA_REQ,
+						SSDFS_REQ_SYNC,
+						req, seg_id, extent);
+}
+
+/*
+ * ssdfs_segment_add_data_block_async() - add new data block asynchronously
+ * @fsi: pointer on shared file system object
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to add new data block into segment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_add_data_block_async(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent)
+{
+	return __ssdfs_segment_add_block_async(fsi,
+						SSDFS_PEB_CREATE_DATA_REQ,
+						SSDFS_REQ_ASYNC,
+						req, seg_id, extent);
+}
+
+/*
+ * ssdfs_segment_migrate_zone_block_sync() - migrate zone block synchronously
+ * @fsi: pointer on shared file system object
+ * @req_type: request type
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to migrate user data block from
+ * exhausted zone into current zone for user data updates.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_migrate_zone_block_sync(struct ssdfs_fs_info *fsi,
+					  int req_type,
+					  struct ssdfs_segment_request *req,
+					  u64 *seg_id,
+					  struct ssdfs_blk2off_range *extent)
+{
+	struct ssdfs_current_segment *cur_seg;
+	int req_class = SSDFS_ZONE_USER_DATA_MIGRATE_REQ;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !req);
+
+	SSDFS_DBG("ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu\n",
+		  req->extent.ino, req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (req_type) {
+	case SSDFS_REQ_SYNC:
+		/* expected request type */
+		break;
+
+	default:
+		SSDFS_ERR("unexpected request type %#x\n",
+			  req_type);
+		return -EINVAL;
+	}
+
+	ssdfs_request_prepare_internal_data(req_class,
+					    SSDFS_MIGRATE_ZONE_USER_BLOCK,
+					    req_type, req);
+
+	down_read(&fsi->cur_segs->lock);
+	cur_seg = fsi->cur_segs->objects[CUR_SEG_TYPE(req_class)];
+	err = __ssdfs_segment_add_block(cur_seg, req, seg_id, extent);
+	up_read(&fsi->cur_segs->lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_segment_migrate_zone_block_async() - migrate zone block asynchronously
+ * @fsi: pointer on shared file system object
+ * @req_type: request type
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to migrate user data block from
+ * exhausted zone into current zone for user data updates.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_migrate_zone_block_async(struct ssdfs_fs_info *fsi,
+					   int req_type,
+					   struct ssdfs_segment_request *req,
+					   u64 *seg_id,
+					   struct ssdfs_blk2off_range *extent)
+{
+	struct ssdfs_current_segment *cur_seg;
+	int req_class = SSDFS_ZONE_USER_DATA_MIGRATE_REQ;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !req);
+
+	SSDFS_DBG("ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu\n",
+		  req->extent.ino, req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (req_type) {
+	case SSDFS_REQ_ASYNC:
+	case SSDFS_REQ_ASYNC_NO_FREE:
+		/* expected request type */
+		break;
+
+	default:
+		SSDFS_ERR("unexpected request type %#x\n",
+			  req_type);
+		return -EINVAL;
+	}
+
+	ssdfs_request_prepare_internal_data(req_class,
+					    SSDFS_MIGRATE_ZONE_USER_BLOCK,
+					    req_type, req);
+
+	down_read(&fsi->cur_segs->lock);
+	cur_seg = fsi->cur_segs->objects[CUR_SEG_TYPE(req_class)];
+	err = __ssdfs_segment_add_block(cur_seg, req, seg_id, extent);
+	up_read(&fsi->cur_segs->lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_segment_add_leaf_node_block_sync() - add new leaf node synchronously
+ * @fsi: pointer on shared file system object
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to add new leaf node's block into segment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_add_leaf_node_block_sync(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent)
+{
+	return __ssdfs_segment_add_block_sync(fsi,
+						SSDFS_PEB_CREATE_LNODE_REQ,
+						SSDFS_REQ_SYNC,
+						req, seg_id, extent);
+}
+
+/*
+ * ssdfs_segment_add_leaf_node_block_async() - add new leaf node asynchronously
+ * @fsi: pointer on shared file system object
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to add new leaf node's block into segment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_add_leaf_node_block_async(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent)
+{
+	return __ssdfs_segment_add_block_async(fsi,
+						SSDFS_PEB_CREATE_LNODE_REQ,
+						SSDFS_REQ_ASYNC,
+						req, seg_id, extent);
+}
+
+/*
+ * ssdfs_segment_add_hybrid_node_block_sync() - add new hybrid node
+ * @fsi: pointer on shared file system object
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to add new hybrid node's block into segment
+ * synchronously.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_add_hybrid_node_block_sync(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent)
+{
+	return __ssdfs_segment_add_block_sync(fsi,
+						SSDFS_PEB_CREATE_HNODE_REQ,
+						SSDFS_REQ_SYNC,
+						req, seg_id, extent);
+}
+
+/*
+ * ssdfs_segment_add_hybrid_node_block_async() - add new hybrid node
+ * @fsi: pointer on shared file system object
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to add new hybrid node's block into segment
+ * asynchronously.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_add_hybrid_node_block_async(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent)
+{
+	return __ssdfs_segment_add_block_async(fsi,
+						SSDFS_PEB_CREATE_HNODE_REQ,
+						SSDFS_REQ_ASYNC,
+						req, seg_id, extent);
+}
+
+/*
+ * ssdfs_segment_add_index_node_block_sync() - add new index node
+ * @fsi: pointer on shared file system object
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to add new index node's block into segment
+ * synchronously.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_add_index_node_block_sync(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent)
+{
+	return __ssdfs_segment_add_block_sync(fsi,
+						SSDFS_PEB_CREATE_IDXNODE_REQ,
+						SSDFS_REQ_SYNC,
+						req, seg_id, extent);
+}
+
+/*
+ * ssdfs_segment_add_index_node_block_async() - add new index node
+ * @fsi: pointer on shared file system object
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to add new index node's block into segment
+ * asynchronously.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_add_index_node_block_async(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent)
+{
+	return __ssdfs_segment_add_block_async(fsi,
+						SSDFS_PEB_CREATE_IDXNODE_REQ,
+						SSDFS_REQ_ASYNC,
+						req, seg_id, extent);
+}
+
+/*
+ * __ssdfs_segment_add_extent_sync() - add new extent synchronously
+ * @fsi: pointer on shared file system object
+ * @req_class: request class
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to add new extent into segment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+static
+int __ssdfs_segment_add_extent_sync(struct ssdfs_fs_info *fsi,
+				    int req_class,
+				    struct ssdfs_segment_request *req,
+				    u64 *seg_id,
+				    struct ssdfs_blk2off_range *extent)
+{
+	struct ssdfs_current_segment *cur_seg;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !req);
+	BUG_ON(req_class <= SSDFS_PEB_READ_REQ ||
+		req_class > SSDFS_PEB_CREATE_IDXNODE_REQ);
+
+	SSDFS_DBG("ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu\n",
+		  req->extent.ino, req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_request_prepare_internal_data(req_class,
+					    SSDFS_CREATE_EXTENT,
+					    SSDFS_REQ_SYNC,
+					    req);
+
+	down_read(&fsi->cur_segs->lock);
+	cur_seg = fsi->cur_segs->objects[CUR_SEG_TYPE(req_class)];
+	err = __ssdfs_segment_add_extent(cur_seg, req, seg_id, extent);
+	up_read(&fsi->cur_segs->lock);
+
+	return err;
+}
+
+/*
+ * __ssdfs_segment_add_extent_async() - add new extent asynchronously
+ * @fsi: pointer on shared file system object
+ * @req_class: request class
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to add new extent into segment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+static
+int __ssdfs_segment_add_extent_async(struct ssdfs_fs_info *fsi,
+				     int req_class,
+				     struct ssdfs_segment_request *req,
+				     u64 *seg_id,
+				     struct ssdfs_blk2off_range *extent)
+{
+	struct ssdfs_current_segment *cur_seg;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !req);
+	BUG_ON(req_class <= SSDFS_PEB_READ_REQ ||
+		req_class > SSDFS_PEB_CREATE_IDXNODE_REQ);
+
+	SSDFS_DBG("ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu\n",
+		  req->extent.ino, req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	ssdfs_request_prepare_internal_data(req_class,
+					    SSDFS_CREATE_EXTENT,
+					    SSDFS_REQ_ASYNC,
+					    req);
+
+	down_read(&fsi->cur_segs->lock);
+	cur_seg = fsi->cur_segs->objects[CUR_SEG_TYPE(req_class)];
+	err = __ssdfs_segment_add_extent(cur_seg, req, seg_id, extent);
+	up_read(&fsi->cur_segs->lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_segment_pre_alloc_data_extent_sync() - sync pre-alloc a data extent
+ * @fsi: pointer on shared file system object
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to pre-allocate a new data extent into segment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_pre_alloc_data_extent_sync(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent)
+{
+	return __ssdfs_segment_add_extent_sync(fsi,
+					       SSDFS_PEB_PRE_ALLOCATE_DATA_REQ,
+					       req, seg_id, extent);
+}
+
+/*
+ * ssdfs_segment_pre_alloc_data_extent_async() - async pre-alloc a data extent
+ * @fsi: pointer on shared file system object
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to pre-allocate a new data extent into segment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_pre_alloc_data_extent_async(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent)
+{
+	return __ssdfs_segment_add_extent_async(fsi,
+						SSDFS_PEB_PRE_ALLOCATE_DATA_REQ,
+						req, seg_id, extent);
+}
+
+/*
+ * ssdfs_segment_pre_alloc_leaf_node_extent_sync() - pre-alloc a leaf node
+ * @fsi: pointer on shared file system object
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to pre-allocate a leaf node's extent into segment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_pre_alloc_leaf_node_extent_sync(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent)
+{
+	return __ssdfs_segment_add_extent_sync(fsi,
+					       SSDFS_PEB_PRE_ALLOCATE_LNODE_REQ,
+					       req, seg_id, extent);
+}
+
+/*
+ * ssdfs_segment_pre_alloc_leaf_node_extent_async() - pre-alloc a leaf node
+ * @fsi: pointer on shared file system object
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to pre-allocate a leaf node's extent into segment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_pre_alloc_leaf_node_extent_async(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent)
+{
+	return __ssdfs_segment_add_extent_async(fsi,
+					    SSDFS_PEB_PRE_ALLOCATE_LNODE_REQ,
+					    req, seg_id, extent);
+}
+
+/*
+ * ssdfs_segment_pre_alloc_hybrid_node_extent_sync() - pre-alloc a hybrid node
+ * @fsi: pointer on shared file system object
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to pre-allocate a hybrid node's extent into segment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_pre_alloc_hybrid_node_extent_sync(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent)
+{
+	return __ssdfs_segment_add_extent_sync(fsi,
+					       SSDFS_PEB_PRE_ALLOCATE_HNODE_REQ,
+					       req, seg_id, extent);
+}
+
+/*
+ * ssdfs_segment_pre_alloc_hybrid_node_extent_sync() - pre-alloc a hybrid node
+ * @fsi: pointer on shared file system object
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to pre-allocate a hybrid node's extent into segment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_pre_alloc_hybrid_node_extent_async(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent)
+{
+	return __ssdfs_segment_add_extent_async(fsi,
+					    SSDFS_PEB_PRE_ALLOCATE_HNODE_REQ,
+					    req, seg_id, extent);
+}
+
+/*
+ * ssdfs_segment_pre_alloc_index_node_extent_sync() - pre-alloc an index node
+ * @fsi: pointer on shared file system object
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to pre-allocate an index node's extent into segment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_pre_alloc_index_node_extent_sync(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent)
+{
+	return __ssdfs_segment_add_extent_sync(fsi,
+					    SSDFS_PEB_PRE_ALLOCATE_IDXNODE_REQ,
+					    req, seg_id, extent);
+}
+
+/*
+ * ssdfs_segment_pre_alloc_index_node_extent_sync() - pre-alloc an index node
+ * @fsi: pointer on shared file system object
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to pre-allocate an index node's extent into segment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_pre_alloc_index_node_extent_async(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent)
+{
+	return __ssdfs_segment_add_extent_async(fsi,
+					    SSDFS_PEB_PRE_ALLOCATE_IDXNODE_REQ,
+					    req, seg_id, extent);
+}
+
+/*
+ * ssdfs_segment_add_data_extent_sync() - add new data extent synchronously
+ * @fsi: pointer on shared file system object
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to add new data extent into segment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_add_data_extent_sync(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent)
+{
+	return __ssdfs_segment_add_extent_sync(fsi,
+						SSDFS_PEB_CREATE_DATA_REQ,
+						req, seg_id, extent);
+}
+
+/*
+ * ssdfs_segment_add_data_extent_async() - add new data extent asynchronously
+ * @fsi: pointer on shared file system object
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to add new data extent into segment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_add_data_extent_async(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent)
+{
+	return __ssdfs_segment_add_extent_async(fsi,
+						SSDFS_PEB_CREATE_DATA_REQ,
+						req, seg_id, extent);
+}
+
+/*
+ * ssdfs_segment_migrate_zone_extent_sync() - migrate zone extent synchronously
+ * @fsi: pointer on shared file system object
+ * @req_type: request type
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to migrate user data extent from
+ * exhausted zone into current zone for user data updates.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_migrate_zone_extent_sync(struct ssdfs_fs_info *fsi,
+					   int req_type,
+					   struct ssdfs_segment_request *req,
+					   u64 *seg_id,
+					   struct ssdfs_blk2off_range *extent)
+{
+	struct ssdfs_current_segment *cur_seg;
+	int req_class = SSDFS_ZONE_USER_DATA_MIGRATE_REQ;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !req);
+
+	SSDFS_DBG("ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu\n",
+		  req->extent.ino, req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (req_type) {
+	case SSDFS_REQ_SYNC:
+		/* expected request type */
+		break;
+
+	default:
+		SSDFS_ERR("unexpected request type %#x\n",
+			  req_type);
+		return -EINVAL;
+	}
+
+	ssdfs_request_prepare_internal_data(req_class,
+					    SSDFS_MIGRATE_ZONE_USER_EXTENT,
+					    req_type, req);
+
+	down_read(&fsi->cur_segs->lock);
+	cur_seg = fsi->cur_segs->objects[CUR_SEG_TYPE(req_class)];
+	err = __ssdfs_segment_add_extent(cur_seg, req, seg_id, extent);
+	up_read(&fsi->cur_segs->lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_segment_migrate_zone_extent_async() - migrate zone extent asynchronously
+ * @fsi: pointer on shared file system object
+ * @req_type: request type
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to migrate user data exent from
+ * exhausted zone into current zone for user data updates.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_migrate_zone_extent_async(struct ssdfs_fs_info *fsi,
+					    int req_type,
+					    struct ssdfs_segment_request *req,
+					    u64 *seg_id,
+					    struct ssdfs_blk2off_range *extent)
+{
+	struct ssdfs_current_segment *cur_seg;
+	int req_class = SSDFS_ZONE_USER_DATA_MIGRATE_REQ;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!fsi || !req);
+
+	SSDFS_DBG("ino %llu, logical_offset %llu, "
+		  "data_bytes %u, cno %llu, parent_snapshot %llu\n",
+		  req->extent.ino, req->extent.logical_offset,
+		  req->extent.data_bytes, req->extent.cno,
+		  req->extent.parent_snapshot);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (req_type) {
+	case SSDFS_REQ_ASYNC:
+	case SSDFS_REQ_ASYNC_NO_FREE:
+		/* expected request type */
+		break;
+
+	default:
+		SSDFS_ERR("unexpected request type %#x\n",
+			  req_type);
+		return -EINVAL;
+	}
+
+	ssdfs_request_prepare_internal_data(req_class,
+					    SSDFS_MIGRATE_ZONE_USER_EXTENT,
+					    req_type, req);
+
+	down_read(&fsi->cur_segs->lock);
+	cur_seg = fsi->cur_segs->objects[CUR_SEG_TYPE(req_class)];
+	err = __ssdfs_segment_add_extent(cur_seg, req, seg_id, extent);
+	up_read(&fsi->cur_segs->lock);
+
+	return err;
+}
+
+/*
+ * ssdfs_segment_add_leaf_node_extent_sync() - add new leaf node synchronously
+ * @fsi: pointer on shared file system object
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to add new leaf node's extent into segment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_add_leaf_node_extent_sync(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent)
+{
+	return __ssdfs_segment_add_extent_sync(fsi,
+						SSDFS_PEB_CREATE_LNODE_REQ,
+						req, seg_id, extent);
+}
+
+/*
+ * ssdfs_segment_add_leaf_node_extent_async() - add new leaf node asynchronously
+ * @fsi: pointer on shared file system object
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to add new leaf node's extent into segment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_add_leaf_node_extent_async(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent)
+{
+	return __ssdfs_segment_add_extent_async(fsi,
+						SSDFS_PEB_CREATE_LNODE_REQ,
+						req, seg_id, extent);
+}
+
+/*
+ * ssdfs_segment_add_hybrid_node_extent_sync() - add new hybrid node
+ * @fsi: pointer on shared file system object
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to add new hybrid node's extent into segment
+ * synchronously.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_add_hybrid_node_extent_sync(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent)
+{
+	return __ssdfs_segment_add_extent_sync(fsi,
+						SSDFS_PEB_CREATE_HNODE_REQ,
+						req, seg_id, extent);
+}
+
+/*
+ * ssdfs_segment_add_hybrid_node_extent_async() - add new hybrid node
+ * @fsi: pointer on shared file system object
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to add new hybrid node's extent into segment
+ * asynchronously.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_add_hybrid_node_extent_async(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent)
+{
+	return __ssdfs_segment_add_extent_async(fsi,
+						SSDFS_PEB_CREATE_HNODE_REQ,
+						req, seg_id, extent);
+}
+
+/*
+ * ssdfs_segment_add_index_node_extent_sync() - add new index node
+ * @fsi: pointer on shared file system object
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to add new index node's extent into segment
+ * synchronously.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_add_index_node_extent_sync(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent)
+{
+	return __ssdfs_segment_add_extent_sync(fsi,
+						SSDFS_PEB_CREATE_IDXNODE_REQ,
+						req, seg_id, extent);
+}
+
+/*
+ * ssdfs_segment_add_index_node_extent_async() - add new index node
+ * @fsi: pointer on shared file system object
+ * @req: segment request [in|out]
+ * @seg_id: segment ID [out]
+ * @extent: (pre-)allocated extent [out]
+ *
+ * This function tries to add new index node's extent into segment
+ * asynchronously.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENOSPC     - segment hasn't free pages.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segment_add_index_node_extent_async(struct ssdfs_fs_info *fsi,
+					struct ssdfs_segment_request *req,
+					u64 *seg_id,
+					struct ssdfs_blk2off_range *extent)
+{
+	return __ssdfs_segment_add_extent_async(fsi,
+						SSDFS_PEB_CREATE_IDXNODE_REQ,
+						req, seg_id, extent);
+}
-- 
2.34.1

