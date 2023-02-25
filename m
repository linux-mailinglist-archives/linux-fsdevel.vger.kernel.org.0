Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1BC6A2656
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Feb 2023 02:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjBYBTQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 20:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjBYBRS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:17:18 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5FD13533
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:13 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id y184so797916oiy.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 17:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEG8PxvPPDHctUHzEMZC7jp24LlXiCWPf+XiGalvf6E=;
        b=shGUeMll5ZaAhcGSzivdIXo6wU8GJff3MFx0a6RNPcLGDHFtcP7D8cptTg8GW4dUk+
         mVYGoQTWNthIxRhWvmL1FQdmlzBmAqxfVPiWrtzWZOtpWDrToKz+CHdsrlvVBhBL9iYD
         9zLAFwbD87lTC8BhH+gJLAUL6U5JV0la6mLgSxJJromPpknn8OuisZuvyXFTxANICF+e
         mYLU9qBiLDmHdGBl4sbGUvfGg8Oyj6wWOFW0RbEuRlDkXV8vrsw9J8P5A2/TN0tyLYeL
         nPuU5Aanbhw/0KCuVadKUVrVTjd3DiiWlDK8TjuvwYbkuHE+eZe0A1Br5UAeascGjDQe
         KpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SEG8PxvPPDHctUHzEMZC7jp24LlXiCWPf+XiGalvf6E=;
        b=y0iwlLvZ/PqY2WgnPlyZCs+kJe/QH91LY3mpesOhrQxmP197UYdrvbg70mu8+qWomo
         959n1pTOdetxr4xx9NYv+K/AECzeRz6xlUbcZVTybvqrdq5+C4dgAHON7rj1M53vI3ly
         mDSkZJZ3DCKPVgX44JTbRCkaEedONjGhNPTkriQ0Rkds6R6cMmWiEYK9hZp8sBZRRnJe
         +DVSmoPb4DrJJ0tACvKz28RU6EE2pGzGgw4QUZYA9/hqf+5eRV03uGbvPBRCNVxuIvDy
         Jki7iQ8lIEdPJUNyGEpW8Cj6UsZJ41yVPeWC7kESSIh7/K5FCy99T5yPjQ8frx+xPexl
         mlaQ==
X-Gm-Message-State: AO0yUKUx26Trlc59W2vk/HWlcP0Qm7Ut8B+phYbNCEutd8A2wJUNx2ZK
        9PQCcYgIUQ0+3db3qlW4cxhltAWY5Lu6IEoS
X-Google-Smtp-Source: AK7set9OC61ibfcPLoFn2wJbOrjIsGmVy4korVplKbTHV8NefOS7XaWHgs25q7evQFoTtcscIVdb0Q==
X-Received: by 2002:aca:f0d:0:b0:35a:d192:9a53 with SMTP id 13-20020aca0f0d000000b0035ad1929a53mr7336955oip.41.1677287832242;
        Fri, 24 Feb 2023 17:17:12 -0800 (PST)
Received: from system76-pc.. (172-125-78-211.lightspeed.sntcca.sbcglobal.net. [172.125.78.211])
        by smtp.gmail.com with ESMTPSA id q3-20020acac003000000b0037d74967ef6sm363483oif.44.2023.02.24.17.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 17:17:11 -0800 (PST)
From:   Viacheslav Dubeyko <slava@dubeyko.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     viacheslav.dubeyko@bytedance.com, luka.perkov@sartura.hr,
        bruno.banelli@sartura.hr, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH 46/76] ssdfs: segment bitmap API implementation
Date:   Fri, 24 Feb 2023 17:08:57 -0800
Message-Id: <20230225010927.813929-47-slava@dubeyko.com>
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

Segment bitmap implements API:
(1) create - create empty segment bitmap object
(2) destroy - destroy segment bitmap object
(3) fragment_init - init fragment of segment bitmap
(4) flush - flush dirty segment bitmap
(5) check_state - check that segment has particular state
(6) get_state - get current state of particular segment
(7) change_state - change state of segment
(8) find - find segment for requested state or state mask
(9) find_and_set - find segment for requested state and change state

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
CC: Viacheslav Dubeyko <viacheslav.dubeyko@bytedance.com>
CC: Luka Perkov <luka.perkov@sartura.hr>
CC: Bruno Banelli <bruno.banelli@sartura.hr>
---
 fs/ssdfs/segment_bitmap.c | 3014 +++++++++++++++++++++++++++++++++++++
 1 file changed, 3014 insertions(+)

diff --git a/fs/ssdfs/segment_bitmap.c b/fs/ssdfs/segment_bitmap.c
index 633cd4cfca0a..50a7cc692fe3 100644
--- a/fs/ssdfs/segment_bitmap.c
+++ b/fs/ssdfs/segment_bitmap.c
@@ -1805,3 +1805,3017 @@ int ssdfs_segbmap_issue_fragments_update(struct ssdfs_segment_bmap *segbmap,
 
 	return err;
 }
+
+/*
+ * ssdfs_segbmap_flush_dirty_fragments() - flush dirty fragments
+ * @segbmap: pointer on segment bitmap object
+ * @fragments_count: count of fragments in segbmap
+ * @fragment_size: size of fragment in bytes
+ *
+ * This method tries to flush all dirty fragments.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENODATA    - segbmap hasn't dirty fragments.
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_segbmap_flush_dirty_fragments(struct ssdfs_segment_bmap *segbmap,
+					u16 fragments_count,
+					u16 fragment_size)
+{
+	unsigned long *fbmap;
+	int size;
+	unsigned long *found;
+	u16 start_fragment;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!segbmap);
+	BUG_ON(!rwsem_is_locked(&segbmap->search_lock));
+
+	SSDFS_DBG("segbmap %p, fragments_count %u, fragment_size %u\n",
+		  segbmap, fragments_count, fragment_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fbmap = segbmap->fbmap[SSDFS_SEGBMAP_MODIFICATION_FBMAP];
+
+	size = fragments_count;
+	err = ssdfs_find_first_dirty_fragment(fbmap, size, &found);
+	if (err == -ENODATA) {
+		SSDFS_DBG("segbmap hasn't dirty fragments\n");
+		return err;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to find dirty fragments: "
+			  "err %d\n",
+			  err);
+		return err;
+	} else if (!found) {
+		SSDFS_ERR("invalid bitmap pointer\n");
+		return -ERANGE;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(((found - fbmap) * BITS_PER_LONG) >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	start_fragment = (u16)((found - fbmap) * BITS_PER_LONG);
+
+	err = ssdfs_segbmap_issue_fragments_update(segbmap, start_fragment,
+						   fragment_size, *found);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to issue fragments update: "
+			  "start_fragment %u, found %#lx, err %d\n",
+			  start_fragment, *found, err);
+		return err;
+	}
+
+	err = ssdfs_clear_dirty_state(found);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to clear dirty state: "
+			  "err %d\n",
+			  err);
+		return err;
+	}
+
+	size = fragments_count - (start_fragment + BITS_PER_LONG);
+	while (size > 0) {
+		err = ssdfs_find_first_dirty_fragment(++found, size,
+						      &found);
+		if (err == -ENODATA)
+			return 0;
+		else if (unlikely(err)) {
+			SSDFS_ERR("fail to find dirty fragments: "
+				  "err %d\n",
+				  err);
+			return err;
+		} else if (!found) {
+			SSDFS_ERR("invalid bitmap pointer\n");
+			return -ERANGE;
+		}
+
+#ifdef CONFIG_SSDFS_DEBUG
+		BUG_ON(((found - fbmap) * BITS_PER_LONG) >= U16_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+		start_fragment = (u16)((found - fbmap) * BITS_PER_LONG);
+
+		err = ssdfs_segbmap_issue_fragments_update(segbmap,
+							   start_fragment,
+							   fragment_size,
+							   *found);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to issue fragments update: "
+				  "start_fragment %u, found %#lx, err %d\n",
+				  start_fragment, *found, err);
+			return err;
+		}
+
+		err = ssdfs_clear_dirty_state(found);
+		if (unlikely(err)) {
+			SSDFS_ERR("fail to clear dirty state: "
+				  "err %d\n",
+				  err);
+			return err;
+		}
+
+		size = fragments_count - (start_fragment + BITS_PER_LONG);
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_segbmap_wait_flush_end() - wait flush ending
+ * @segbmap: pointer on segment bitmap object
+ * @fragments_count: count of fragments in segbmap
+ *
+ * This method is waiting the end of flush operation.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_segbmap_wait_flush_end(struct ssdfs_segment_bmap *segbmap,
+				 u16 fragments_count)
+{
+	struct ssdfs_segbmap_fragment_desc *fragment;
+	struct ssdfs_segment_request *req1 = NULL, *req2 = NULL;
+	bool has_backup;
+	wait_queue_head_t *wq = NULL;
+	int i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!segbmap);
+	BUG_ON(!rwsem_is_locked(&segbmap->search_lock));
+
+	SSDFS_DBG("segbmap %p, fragments_count %u\n",
+		  segbmap, fragments_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	has_backup = segbmap->flags & SSDFS_SEGBMAP_HAS_COPY;
+
+	for (i = 0; i < fragments_count; i++) {
+		fragment = &segbmap->desc_array[i];
+
+		switch (fragment->state) {
+		case SSDFS_SEGBMAP_FRAG_DIRTY:
+			SSDFS_ERR("found unprocessed dirty fragment: "
+				  "index %d\n", i);
+			return -ERANGE;
+
+		case SSDFS_SEGBMAP_FRAG_TOWRITE:
+			req1 = &fragment->flush_req1;
+			req2 = &fragment->flush_req2;
+
+check_req1_state:
+			switch (atomic_read(&req1->result.state)) {
+			case SSDFS_REQ_CREATED:
+			case SSDFS_REQ_STARTED:
+				wq = &req1->private.wait_queue;
+
+				err = wait_event_killable_timeout(*wq,
+					    has_request_been_executed(req1),
+					    SSDFS_DEFAULT_TIMEOUT);
+				if (err < 0)
+					WARN_ON(err < 0);
+				else
+					err = 0;
+
+				goto check_req1_state;
+				break;
+
+			case SSDFS_REQ_FINISHED:
+				/* do nothing */
+				break;
+
+			case SSDFS_REQ_FAILED:
+				err = req1->result.err;
+
+				if (!err) {
+					err = -ERANGE;
+					SSDFS_ERR("error code is absent\n");
+				}
+
+				SSDFS_ERR("flush request is failed: "
+					  "err %d\n", err);
+				return err;
+
+			default:
+				SSDFS_ERR("invalid result's state %#x\n",
+				    atomic_read(&req1->result.state));
+				return -ERANGE;
+			}
+
+			if (!has_backup)
+				goto finish_fragment_check;
+
+check_req2_state:
+			switch (atomic_read(&req2->result.state)) {
+			case SSDFS_REQ_CREATED:
+			case SSDFS_REQ_STARTED:
+				wq = &req2->private.wait_queue;
+
+				err = wait_event_killable_timeout(*wq,
+					    has_request_been_executed(req2),
+					    SSDFS_DEFAULT_TIMEOUT);
+				if (err < 0)
+					WARN_ON(err < 0);
+				else
+					err = 0;
+
+				goto check_req2_state;
+				break;
+
+			case SSDFS_REQ_FINISHED:
+				/* do nothing */
+				break;
+
+			case SSDFS_REQ_FAILED:
+				err = req2->result.err;
+
+				if (!err) {
+					err = -ERANGE;
+					SSDFS_ERR("error code is absent\n");
+				}
+
+				SSDFS_ERR("flush request failed: "
+					  "err %d\n", err);
+				return err;
+
+			default:
+				SSDFS_ERR("invalid result's state %#x\n",
+				    atomic_read(&req2->result.state));
+				return -ERANGE;
+			}
+
+finish_fragment_check:
+			break;
+
+		default:
+			/* do nothing */
+			break;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_segbmap_issue_commit_logs() - request logs commit
+ * @segbmap: pointer on segment bitmap object
+ * @fragments_count: count of fragments in segbmap
+ * @fragment_size: size of fragment in bytes
+ *
+ * This method tries to issue the commit logs operation.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_segbmap_issue_commit_logs(struct ssdfs_segment_bmap *segbmap,
+				    u16 fragments_count,
+				    u16 fragment_size)
+{
+	struct ssdfs_segbmap_fragment_desc *fragment;
+	struct ssdfs_segbmap_fragment_header *hdr;
+	struct ssdfs_segment_request *req1 = NULL, *req2 = NULL;
+	struct ssdfs_segment_info *si;
+	struct page *page;
+	void *kaddr;
+	size_t extent_size = sizeof(struct ssdfs_volume_extent);
+	u64 ino = SSDFS_SEG_BMAP_INO;
+	bool has_backup;
+	u64 offset;
+	u16 seg_index;
+	int copy_id;
+	u16 i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!segbmap);
+	BUG_ON(!rwsem_is_locked(&segbmap->search_lock));
+
+	SSDFS_DBG("segbmap %p, fragments_count %u, fragment_size %u\n",
+		  segbmap, fragments_count, fragment_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	has_backup = segbmap->flags & SSDFS_SEGBMAP_HAS_COPY;
+
+	for (i = 0; i < fragments_count; i++) {
+		fragment = &segbmap->desc_array[i];
+
+		switch (fragment->state) {
+		case SSDFS_SEGBMAP_FRAG_DIRTY:
+			SSDFS_ERR("found unprocessed dirty fragment: "
+				  "index %d\n", i);
+			return -ERANGE;
+
+		case SSDFS_SEGBMAP_FRAG_TOWRITE:
+			req1 = &fragment->flush_req1;
+			req2 = &fragment->flush_req2;
+
+			ssdfs_request_init(req1);
+			ssdfs_get_request(req1);
+
+			offset = (u64)i;
+			offset *= fragment_size;
+
+			ssdfs_request_prepare_logical_extent(ino, offset,
+							     0, 0, 0, req1);
+
+			page = find_lock_page(&segbmap->pages, i);
+			if (!page) {
+				err = -ERANGE;
+				SSDFS_ERR("fail to find page: "
+					  "fragment_index %u\n",
+					  i);
+				goto fail_issue_commit_logs;
+			}
+
+			ssdfs_account_locked_page(page);
+			kaddr = kmap_local_page(page);
+
+			hdr = SSDFS_SBMP_FRAG_HDR(kaddr);
+
+			err = ssdfs_segbmap_define_volume_extent(segbmap, req1,
+								 hdr, 1,
+								 &seg_index);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to define volume extent: "
+					  "err %d\n",
+					  err);
+			}
+
+			kunmap_local(kaddr);
+			ssdfs_unlock_page(page);
+			ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("page %p, count %d\n",
+				  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			if (unlikely(err))
+				goto fail_issue_commit_logs;
+
+			copy_id = SSDFS_MAIN_SEGBMAP_SEG;
+			si = segbmap->segs[seg_index][copy_id];
+
+			err = ssdfs_segment_commit_log_async(si,
+							SSDFS_REQ_ASYNC_NO_FREE,
+							req1);
+			if (unlikely(err)) {
+				SSDFS_ERR("fail to issue the commit log: "
+					  "seg_index %u, err %d\n",
+					  seg_index, err);
+				goto fail_issue_commit_logs;
+			}
+
+			if (has_backup) {
+				ssdfs_request_init(req2);
+				ssdfs_get_request(req2);
+
+				ssdfs_request_prepare_logical_extent(ino,
+								     offset,
+								     0, 0, 0,
+								     req2);
+
+				ssdfs_memcpy(&req2->place, 0, extent_size,
+					     &req1->place, 0, extent_size,
+					     extent_size);
+
+				copy_id = SSDFS_COPY_SEGBMAP_SEG;
+				si = segbmap->segs[seg_index][copy_id];
+
+				err = ssdfs_segment_commit_log_async(si,
+							SSDFS_REQ_ASYNC_NO_FREE,
+							req2);
+				if (unlikely(err)) {
+					SSDFS_ERR("fail to issue log commit: "
+						  "seg_index %u, err %d\n",
+						  seg_index, err);
+					goto fail_issue_commit_logs;
+				}
+			}
+			break;
+
+		default:
+			/* do nothing */
+			break;
+		}
+	}
+
+	return 0;
+
+fail_issue_commit_logs:
+	ssdfs_put_request(req1);
+
+	if (has_backup)
+		ssdfs_put_request(req2);
+
+	return err;
+}
+
+/*
+ * ssdfs_segbmap_wait_finish_commit_logs() - wait commit logs ending
+ * @segbmap: pointer on segment bitmap object
+ * @fragments_count: count of fragments in segbmap
+ *
+ * This method is waiting the end of commit logs operation.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ERANGE     - internal error.
+ */
+static
+int ssdfs_segbmap_wait_finish_commit_logs(struct ssdfs_segment_bmap *segbmap,
+					  u16 fragments_count)
+{
+	struct ssdfs_segbmap_fragment_desc *fragment;
+	struct ssdfs_segment_request *req1 = NULL, *req2 = NULL;
+	bool has_backup;
+	wait_queue_head_t *wq = NULL;
+	int i;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!segbmap);
+	BUG_ON(!rwsem_is_locked(&segbmap->search_lock));
+
+	SSDFS_DBG("segbmap %p, fragments_count %u\n",
+		  segbmap, fragments_count);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	has_backup = segbmap->flags & SSDFS_SEGBMAP_HAS_COPY;
+
+	for (i = 0; i < fragments_count; i++) {
+		fragment = &segbmap->desc_array[i];
+
+		switch (fragment->state) {
+		case SSDFS_SEGBMAP_FRAG_DIRTY:
+			SSDFS_ERR("found unprocessed dirty fragment: "
+				  "index %d\n", i);
+			return -ERANGE;
+
+		case SSDFS_SEGBMAP_FRAG_TOWRITE:
+			req1 = &fragment->flush_req1;
+			req2 = &fragment->flush_req2;
+
+check_req1_state:
+			switch (atomic_read(&req1->result.state)) {
+			case SSDFS_REQ_CREATED:
+			case SSDFS_REQ_STARTED:
+				wq = &req1->private.wait_queue;
+
+				err = wait_event_killable_timeout(*wq,
+					    has_request_been_executed(req1),
+					    SSDFS_DEFAULT_TIMEOUT);
+				if (err < 0)
+					WARN_ON(err < 0);
+				else
+					err = 0;
+
+				goto check_req1_state;
+				break;
+
+			case SSDFS_REQ_FINISHED:
+				/* do nothing */
+				break;
+
+			case SSDFS_REQ_FAILED:
+				err = req1->result.err;
+
+				if (!err) {
+					err = -ERANGE;
+					SSDFS_ERR("error code is absent\n");
+				}
+
+				SSDFS_ERR("flush request is failed: "
+					  "err %d\n", err);
+				return err;
+
+			default:
+				SSDFS_ERR("invalid result's state %#x\n",
+				    atomic_read(&req1->result.state));
+				return -ERANGE;
+			}
+
+			if (!has_backup)
+				goto finish_fragment_check;
+
+check_req2_state:
+			switch (atomic_read(&req2->result.state)) {
+			case SSDFS_REQ_CREATED:
+			case SSDFS_REQ_STARTED:
+				wq = &req2->private.wait_queue;
+
+				err = wait_event_killable_timeout(*wq,
+					    has_request_been_executed(req2),
+					    SSDFS_DEFAULT_TIMEOUT);
+				if (err < 0)
+					WARN_ON(err < 0);
+				else
+					err = 0;
+
+				goto check_req2_state;
+				break;
+
+			case SSDFS_REQ_FINISHED:
+				/* do nothing */
+				break;
+
+			case SSDFS_REQ_FAILED:
+				err = req2->result.err;
+
+				if (!err) {
+					err = -ERANGE;
+					SSDFS_ERR("error code is absent\n");
+				}
+
+				SSDFS_ERR("flush request is failed: "
+					  "err %d\n", err);
+				return err;
+
+			default:
+				SSDFS_ERR("invalid result's state %#x\n",
+				    atomic_read(&req2->result.state));
+				return -ERANGE;
+			}
+
+finish_fragment_check:
+			fragment->state = SSDFS_SEGBMAP_FRAG_INITIALIZED;
+			break;
+
+		default:
+			/* do nothing */
+			break;
+		}
+	}
+
+	return 0;
+}
+
+/* TODO: copy all fragments' headers into checkpoint */
+/* TODO: mark superblock as dirty */
+/* TODO: new checkpoint should be stored into superblock segment */
+static
+int ssdfs_segbmap_create_checkpoint(struct ssdfs_segment_bmap *segbmap)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	/* TODO: implement */
+	SSDFS_DBG("TODO: implement %s\n", __func__);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_segbmap_flush() - flush segbmap current state
+ * @segbmap: pointer on segment bitmap object
+ *
+ * This method tries to flush current state of segbmap.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EFAULT     - segbmap has corrupted state.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segbmap_flush(struct ssdfs_segment_bmap *segbmap)
+{
+	u16 fragments_count;
+	u16 fragment_size;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!segbmap);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("segbmap %p\n",
+		  segbmap);
+#else
+	SSDFS_DBG("segbmap %p\n",
+		  segbmap);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	inode_lock_shared(segbmap->fsi->segbmap_inode);
+	down_read(&segbmap->resize_lock);
+
+	if (segbmap->flags & SSDFS_SEGBMAP_ERROR) {
+		err = -EFAULT;
+		ssdfs_fs_error(segbmap->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"segbmap has corrupted state\n");
+		goto finish_segbmap_flush;
+	}
+
+	fragments_count = segbmap->fragments_count;
+	fragment_size = segbmap->fragment_size;
+
+	ssdfs_sb_segbmap_header_correct_state(segbmap);
+
+	down_write(&segbmap->search_lock);
+
+	err = ssdfs_segbmap_flush_dirty_fragments(segbmap,
+						  fragments_count,
+						  fragment_size);
+	if (err == -ENODATA) {
+		err = 0;
+		up_write(&segbmap->search_lock);
+		SSDFS_DBG("segbmap hasn't dirty fragments\n");
+		goto finish_segbmap_flush;
+	} else if (unlikely(err)) {
+		up_write(&segbmap->search_lock);
+		ssdfs_fs_error(segbmap->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"fail to flush segbmap: err %d\n",
+				err);
+		goto finish_segbmap_flush;
+	}
+
+	err = ssdfs_segbmap_wait_flush_end(segbmap, fragments_count);
+	if (unlikely(err)) {
+		up_write(&segbmap->search_lock);
+		ssdfs_fs_error(segbmap->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"fail to flush segbmap: err %d\n",
+				err);
+		goto finish_segbmap_flush;
+	}
+
+	err = ssdfs_segbmap_issue_commit_logs(segbmap,
+					      fragments_count,
+					      fragment_size);
+	if (unlikely(err)) {
+		up_write(&segbmap->search_lock);
+		ssdfs_fs_error(segbmap->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"fail to flush segbmap: err %d\n",
+				err);
+		goto finish_segbmap_flush;
+	}
+
+	err = ssdfs_segbmap_wait_finish_commit_logs(segbmap,
+						    fragments_count);
+	if (unlikely(err)) {
+		up_write(&segbmap->search_lock);
+		ssdfs_fs_error(segbmap->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"fail to flush segbmap: err %d\n",
+				err);
+		goto finish_segbmap_flush;
+	}
+
+	downgrade_write(&segbmap->search_lock);
+
+	err = ssdfs_segbmap_create_checkpoint(segbmap);
+	if (unlikely(err)) {
+		ssdfs_fs_error(segbmap->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"fail to create segbmap's checkpoint: "
+				"err %d\n",
+				err);
+	}
+
+	up_read(&segbmap->search_lock);
+
+finish_segbmap_flush:
+	up_read(&segbmap->resize_lock);
+	inode_unlock_shared(segbmap->fsi->segbmap_inode);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#else
+	SSDFS_DBG("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return err;
+}
+
+int ssdfs_segbmap_resize(struct ssdfs_segment_bmap *segbmap,
+			 u64 new_items_count)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	/* TODO: implement */
+	SSDFS_DBG("TODO: implement %s\n", __func__);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return -ENOSYS;
+}
+
+/*
+ * ssdfs_segbmap_check_fragment_validity() - check fragment validity
+ * @segbmap: pointer on segment bitmap object
+ * @fragment_index: fragment index
+ *
+ * This method checks that fragment is ready for operations.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EAGAIN     - fragment is under initialization yet.
+ * %-EFAULT     - fragment initialization has failed.
+ */
+static
+int ssdfs_segbmap_check_fragment_validity(struct ssdfs_segment_bmap *segbmap,
+					  pgoff_t fragment_index)
+{
+	struct ssdfs_segbmap_fragment_desc *fragment;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!segbmap);
+	BUG_ON(!rwsem_is_locked(&segbmap->search_lock));
+
+	SSDFS_DBG("segbmap %p, fragment_index %lu\n",
+		  segbmap, fragment_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	fragment = &segbmap->desc_array[fragment_index];
+
+	switch (fragment->state) {
+	case SSDFS_SEGBMAP_FRAG_CREATED:
+		return -EAGAIN;
+
+	case SSDFS_SEGBMAP_FRAG_INIT_FAILED:
+		return -EFAULT;
+
+	case SSDFS_SEGBMAP_FRAG_INITIALIZED:
+	case SSDFS_SEGBMAP_FRAG_DIRTY:
+		/* do nothing */
+		break;
+
+	default:
+		BUG();
+	}
+
+	return 0;
+}
+
+/*
+ * ssdfs_segbmap_get_state() - get segment state
+ * @segbmap: pointer on segment bitmap object
+ * @seg: segment number
+ * @end: pointer on completion for waiting init ending [out]
+ *
+ * This method tries to get state of @seg.
+ *
+ * RETURN:
+ * [success] - segment state
+ * [failure] - error code:
+ *
+ * %-EAGAIN     - fragment is under initialization yet.
+ * %-EFAULT     - segbmap has inconsistent state.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segbmap_get_state(struct ssdfs_segment_bmap *segbmap,
+			    u64 seg, struct completion **end)
+{
+	u32 items_per_byte = SSDFS_ITEMS_PER_BYTE(SSDFS_SEG_STATE_BITS);
+	u32 hdr_size = sizeof(struct ssdfs_segbmap_fragment_header);
+	u64 items_count;
+	u16 fragments_count;
+	u16 fragment_size;
+	pgoff_t fragment_index;
+	struct page *page;
+	u64 page_item;
+	u32 byte_offset;
+	void *kaddr;
+	u8 *byte_ptr;
+	u32 byte_item;
+	int state = SSDFS_SEG_STATE_MAX;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!segbmap);
+
+	SSDFS_DBG("segbmap %p, seg %llu\n",
+		  segbmap, seg);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*end = NULL;
+
+	inode_lock_shared(segbmap->fsi->segbmap_inode);
+	down_read(&segbmap->resize_lock);
+
+	items_count = segbmap->items_count;
+	fragments_count = segbmap->fragments_count;
+	fragment_size = segbmap->fragment_size;
+
+	if (segbmap->flags & SSDFS_SEGBMAP_ERROR) {
+		err = -EFAULT;
+		ssdfs_fs_error(segbmap->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"segbmap has corrupted state\n");
+		goto finish_segment_check;
+	}
+
+	if (seg >= items_count) {
+		err = -ERANGE;
+		SSDFS_ERR("seg %llu >= items_count %llu\n",
+			  seg, items_count);
+		goto finish_segment_check;
+	}
+
+	fragment_index = ssdfs_segbmap_seg_2_fragment_index(seg);
+	if (fragment_index >= fragments_count) {
+		err = -EFAULT;
+		ssdfs_fs_error(segbmap->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"fragment_index %lu >= fragments_count %u\n",
+				fragment_index, fragments_count);
+		goto finish_segment_check;
+	}
+
+	down_read(&segbmap->search_lock);
+
+	*end = &segbmap->desc_array[fragment_index].init_end;
+
+	err = ssdfs_segbmap_check_fragment_validity(segbmap, fragment_index);
+	if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("fragment %lu is not initialized yet\n",
+			  fragment_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_get_state;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fragment %lu init has failed\n",
+			  fragment_index);
+		goto finish_get_state;
+	}
+
+	page = find_lock_page(&segbmap->pages, fragment_index);
+	if (!page) {
+		err = -ERANGE;
+		SSDFS_ERR("fail to get fragment %lu page\n",
+			  fragment_index);
+		goto finish_get_state;
+	}
+
+	ssdfs_account_locked_page(page);
+
+	page_item = ssdfs_segbmap_define_first_fragment_item(fragment_index,
+							     fragment_size);
+	if (seg < page_item) {
+		err = -ERANGE;
+		SSDFS_ERR("seg %llu < page_item %llu\n",
+			  seg, page_item);
+		goto free_page;
+	}
+
+	page_item = seg - page_item;
+
+	if (page_item >= ssdfs_segbmap_items_per_fragment(fragment_size)) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid page_item %llu\n",
+			  page_item);
+		goto free_page;
+	}
+
+	byte_offset = ssdfs_segbmap_get_item_byte_offset(page_item);
+
+	if (byte_offset >= PAGE_SIZE) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid byte_offset %u\n",
+			  byte_offset);
+		goto free_page;
+	}
+
+	byte_item = page_item - ((byte_offset - hdr_size) * items_per_byte);
+
+	kaddr = kmap_local_page(page);
+	byte_ptr = (u8 *)kaddr + byte_offset;
+	state = ssdfs_segbmap_get_state_from_byte(byte_ptr, byte_item);
+	kunmap_local(kaddr);
+
+free_page:
+	ssdfs_unlock_page(page);
+	ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_get_state:
+	up_read(&segbmap->search_lock);
+
+finish_segment_check:
+	up_read(&segbmap->resize_lock);
+	inode_unlock_shared(segbmap->fsi->segbmap_inode);
+
+	if (unlikely(err))
+		return err;
+
+	return state;
+}
+
+/*
+ * ssdfs_segbmap_check_state() - check segment state
+ * @segbmap: pointer on segment bitmap object
+ * @seg: segment number
+ * @state: checking state
+ * @end: pointer on completion for waiting init ending [out]
+ *
+ * This method checks that @seg has @state.
+ *
+ * RETURN:
+ * [success] - segment has (1) or hasn't (0) requested @state
+ * [failure] - error code:
+ *
+ * %-EAGAIN     - fragment is under initialization yet.
+ * %-EFAULT     - segbmap has inconsistent state.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segbmap_check_state(struct ssdfs_segment_bmap *segbmap,
+				u64 seg, int state,
+				struct completion **end)
+{
+	int res;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!segbmap);
+	BUG_ON(state < SSDFS_SEG_CLEAN ||
+		state >= SSDFS_SEG_STATE_MAX);
+
+	SSDFS_DBG("segbmap %p, seg %llu, state %#x\n",
+		  segbmap, seg, state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	res = ssdfs_segbmap_get_state(segbmap, seg, end);
+	if (res == -EAGAIN) {
+		SSDFS_DBG("fragment is not initialized yet\n");
+		return res;
+	} else if (unlikely(res < 0)) {
+		SSDFS_WARN("fail to get segment %llu state: err %d\n",
+			   seg, res);
+		return res;
+	} else if (res != state) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("res %#x != state %#x\n",
+			  res, state);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return 0;
+	}
+
+	return 1;
+}
+
+/*
+ * ssdfs_segbmap_set_state_in_byte() - set state of item in byte
+ * @byte_ptr: pointer on byte
+ * @byte_item: index of item in byte
+ * @old_state: pointer on old state value [in|out]
+ * @new_state: new state value
+ */
+static inline
+int ssdfs_segbmap_set_state_in_byte(u8 *byte_ptr, u32 byte_item,
+				    int *old_state, int new_state)
+{
+	u8 value;
+	int shift = byte_item * SSDFS_SEG_STATE_BITS;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("byte_ptr %p, byte_item %u, "
+		  "old_state %p, new_state %#x\n",
+		  byte_ptr, byte_item,
+		  old_state, new_state);
+
+	BUG_ON(!byte_ptr || !old_state);
+	BUG_ON(byte_item >= SSDFS_ITEMS_PER_BYTE(SSDFS_SEG_STATE_BITS));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*old_state = (int)((*byte_ptr >> shift) & SSDFS_SEG_STATE_MASK);
+
+	if (*old_state < SSDFS_SEG_CLEAN ||
+	    *old_state >= SSDFS_SEG_STATE_MAX) {
+		SSDFS_ERR("invalid old_state %#x\n",
+			  *old_state);
+		return -ERANGE;
+	}
+
+	if (*old_state == new_state) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("old_state %#x == new_state %#x\n",
+			  *old_state, new_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -EEXIST;
+	}
+
+	value = new_state & SSDFS_SEG_STATE_MASK;
+	value <<= shift;
+
+	*byte_ptr &= ~(SSDFS_SEG_STATE_MASK << shift);
+	*byte_ptr |= value;
+
+	return 0;
+}
+
+/*
+ * ssdfs_segbmap_correct_fragment_header() - correct fragment's header
+ * @segbmap: pointer on segment bitmap object
+ * @fragment_index: fragment index
+ * @old_state: old state value
+ * @new_state: new state value
+ * @kaddr: pointer on fragment's buffer
+ */
+static
+void ssdfs_segbmap_correct_fragment_header(struct ssdfs_segment_bmap *segbmap,
+					   pgoff_t fragment_index,
+					   int old_state, int new_state,
+					   void *kaddr)
+{
+	struct ssdfs_segbmap_fragment_desc *fragment;
+	struct ssdfs_segbmap_fragment_header *hdr;
+	unsigned long *fbmap;
+	u16 fragment_bytes;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!segbmap || !kaddr);
+	BUG_ON(!rwsem_is_locked(&segbmap->search_lock));
+
+	SSDFS_DBG("segbmap %p, fragment_index %lu, "
+		  "old_state %#x, new_state %#x, kaddr %p\n",
+		  segbmap, fragment_index,
+		  old_state, new_state, kaddr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (old_state == new_state) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("old_state %#x == new_state %#x\n",
+			  old_state, new_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return;
+	}
+
+	fragment = &segbmap->desc_array[fragment_index];
+	hdr = SSDFS_SBMP_FRAG_HDR(kaddr);
+	fragment_bytes = le16_to_cpu(hdr->fragment_bytes);
+
+	fragment->state = SSDFS_SEGBMAP_FRAG_DIRTY;
+
+	switch (old_state) {
+	case SSDFS_SEG_CLEAN:
+		switch (new_state) {
+		case SSDFS_SEG_DATA_USING:
+		case SSDFS_SEG_LEAF_NODE_USING:
+		case SSDFS_SEG_HYBRID_NODE_USING:
+		case SSDFS_SEG_INDEX_NODE_USING:
+		case SSDFS_SEG_USED:
+		case SSDFS_SEG_PRE_DIRTY:
+		case SSDFS_SEG_DIRTY:
+		case SSDFS_SEG_RESERVED:
+		case SSDFS_SEG_BAD:
+			/* expected state */
+			break;
+
+		default:
+			SSDFS_WARN("unexpected change: "
+				   "old_state %#x, new_state %#x\n",
+				   old_state, new_state);
+			break;
+		}
+		break;
+
+	case SSDFS_SEG_DATA_USING:
+	case SSDFS_SEG_LEAF_NODE_USING:
+	case SSDFS_SEG_HYBRID_NODE_USING:
+	case SSDFS_SEG_INDEX_NODE_USING:
+		switch (new_state) {
+		case SSDFS_SEG_CLEAN:
+		case SSDFS_SEG_USED:
+		case SSDFS_SEG_PRE_DIRTY:
+		case SSDFS_SEG_DIRTY:
+			/* expected state */
+			break;
+
+		default:
+			SSDFS_WARN("unexpected change: "
+				   "old_state %#x, new_state %#x\n",
+				   old_state, new_state);
+			break;
+		}
+		break;
+
+	case SSDFS_SEG_USED:
+		switch (new_state) {
+		case SSDFS_SEG_CLEAN:
+		case SSDFS_SEG_DATA_USING:
+		case SSDFS_SEG_LEAF_NODE_USING:
+		case SSDFS_SEG_HYBRID_NODE_USING:
+		case SSDFS_SEG_INDEX_NODE_USING:
+		case SSDFS_SEG_PRE_DIRTY:
+		case SSDFS_SEG_DIRTY:
+			/* expected state */
+			break;
+
+		default:
+			SSDFS_WARN("unexpected change: "
+				   "old_state %#x, new_state %#x\n",
+				   old_state, new_state);
+			break;
+		}
+		break;
+
+	case SSDFS_SEG_PRE_DIRTY:
+		switch (new_state) {
+		case SSDFS_SEG_CLEAN:
+		case SSDFS_SEG_DATA_USING:
+		case SSDFS_SEG_LEAF_NODE_USING:
+		case SSDFS_SEG_HYBRID_NODE_USING:
+		case SSDFS_SEG_INDEX_NODE_USING:
+		case SSDFS_SEG_USED:
+		case SSDFS_SEG_DIRTY:
+			/* expected state */
+			break;
+
+		default:
+			SSDFS_WARN("unexpected change: "
+				   "old_state %#x, new_state %#x\n",
+				   old_state, new_state);
+			break;
+		}
+		break;
+
+	case SSDFS_SEG_RESERVED:
+		switch (new_state) {
+		case SSDFS_SEG_DIRTY:
+			/* expected state */
+			break;
+
+		default:
+			SSDFS_WARN("unexpected change: "
+				   "old_state %#x, new_state %#x\n",
+				   old_state, new_state);
+			break;
+		}
+		break;
+
+	case SSDFS_SEG_DIRTY:
+		switch (new_state) {
+		case SSDFS_SEG_CLEAN:
+		case SSDFS_SEG_DATA_USING:
+		case SSDFS_SEG_LEAF_NODE_USING:
+		case SSDFS_SEG_HYBRID_NODE_USING:
+		case SSDFS_SEG_INDEX_NODE_USING:
+		case SSDFS_SEG_USED:
+		case SSDFS_SEG_PRE_DIRTY:
+			/* expected state */
+			break;
+
+		default:
+			SSDFS_WARN("unexpected change: "
+				   "old_state %#x, new_state %#x\n",
+				   old_state, new_state);
+			break;
+		}
+		break;
+
+	case SSDFS_SEG_BAD:
+		switch (new_state) {
+		case SSDFS_SEG_CLEAN:
+		case SSDFS_SEG_BAD:
+			/* expected state */
+			break;
+
+		default:
+			SSDFS_WARN("unexpected change: "
+				   "old_state %#x, new_state %#x\n",
+				   old_state, new_state);
+			break;
+		}
+		break;
+
+
+	default:
+		SSDFS_WARN("unexpected state: "
+			   "old_state %#x\n",
+			   old_state);
+		break;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("BEFORE: total_segs %u, "
+		  "clean_or_using_segs %u, "
+		  "used_or_dirty_segs %u, "
+		  "bad_segs %u\n",
+		  fragment->total_segs,
+		  fragment->clean_or_using_segs,
+		  fragment->used_or_dirty_segs,
+		  fragment->bad_segs);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (old_state) {
+	case SSDFS_SEG_CLEAN:
+	case SSDFS_SEG_DATA_USING:
+	case SSDFS_SEG_LEAF_NODE_USING:
+	case SSDFS_SEG_HYBRID_NODE_USING:
+	case SSDFS_SEG_INDEX_NODE_USING:
+	case SSDFS_SEG_RESERVED:
+		fbmap = segbmap->fbmap[SSDFS_SEGBMAP_CLEAN_USING_FBMAP];
+		BUG_ON(fragment->clean_or_using_segs == 0);
+		fragment->clean_or_using_segs--;
+		if (fragment->clean_or_using_segs == 0)
+			bitmap_clear(fbmap, fragment_index, 1);
+		break;
+
+	case SSDFS_SEG_USED:
+	case SSDFS_SEG_PRE_DIRTY:
+	case SSDFS_SEG_DIRTY:
+		fbmap = segbmap->fbmap[SSDFS_SEGBMAP_USED_DIRTY_FBMAP];
+		BUG_ON(fragment->used_or_dirty_segs == 0);
+		fragment->used_or_dirty_segs--;
+		if (fragment->used_or_dirty_segs == 0)
+			bitmap_clear(fbmap, fragment_index, 1);
+		break;
+
+	case SSDFS_SEG_BAD:
+		fbmap = segbmap->fbmap[SSDFS_SEGBMAP_BAD_FBMAP];
+		BUG_ON(fragment->bad_segs == 0);
+		fragment->bad_segs--;
+		if (fragment->bad_segs == 0)
+			bitmap_clear(fbmap, fragment_index, 1);
+		break;
+
+	default:
+		BUG();
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("OLD_STATE: total_segs %u, "
+		  "clean_or_using_segs %u, "
+		  "used_or_dirty_segs %u, "
+		  "bad_segs %u\n",
+		  fragment->total_segs,
+		  fragment->clean_or_using_segs,
+		  fragment->used_or_dirty_segs,
+		  fragment->bad_segs);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (new_state) {
+	case SSDFS_SEG_CLEAN:
+	case SSDFS_SEG_DATA_USING:
+	case SSDFS_SEG_LEAF_NODE_USING:
+	case SSDFS_SEG_HYBRID_NODE_USING:
+	case SSDFS_SEG_INDEX_NODE_USING:
+	case SSDFS_SEG_RESERVED:
+		fbmap = segbmap->fbmap[SSDFS_SEGBMAP_CLEAN_USING_FBMAP];
+		if (fragment->clean_or_using_segs == 0)
+			bitmap_set(fbmap, fragment_index, 1);
+		BUG_ON((fragment->clean_or_using_segs + 1) == U16_MAX);
+		fragment->clean_or_using_segs++;
+		break;
+
+	case SSDFS_SEG_USED:
+	case SSDFS_SEG_PRE_DIRTY:
+	case SSDFS_SEG_DIRTY:
+		fbmap = segbmap->fbmap[SSDFS_SEGBMAP_USED_DIRTY_FBMAP];
+		if (fragment->used_or_dirty_segs == 0)
+			bitmap_set(fbmap, fragment_index, 1);
+		BUG_ON((fragment->used_or_dirty_segs + 1) == U16_MAX);
+		fragment->used_or_dirty_segs++;
+		break;
+
+	case SSDFS_SEG_BAD:
+		fbmap = segbmap->fbmap[SSDFS_SEGBMAP_BAD_FBMAP];
+		if (fragment->bad_segs == 0)
+			bitmap_set(fbmap, fragment_index, 1);
+		BUG_ON((fragment->bad_segs + 1) == U16_MAX);
+		fragment->bad_segs++;
+		break;
+
+	default:
+		BUG();
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("NEW_STATE: total_segs %u, "
+		  "clean_or_using_segs %u, "
+		  "used_or_dirty_segs %u, "
+		  "bad_segs %u\n",
+		  fragment->total_segs,
+		  fragment->clean_or_using_segs,
+		  fragment->used_or_dirty_segs,
+		  fragment->bad_segs);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	hdr->clean_or_using_segs = cpu_to_le16(fragment->clean_or_using_segs);
+	hdr->used_or_dirty_segs = cpu_to_le16(fragment->used_or_dirty_segs);
+	hdr->bad_segs = cpu_to_le16(fragment->bad_segs);
+
+	hdr->checksum = 0;
+	hdr->checksum = ssdfs_crc32_le(kaddr, fragment_bytes);
+
+	fbmap = segbmap->fbmap[SSDFS_SEGBMAP_MODIFICATION_FBMAP];
+	bitmap_set(fbmap, fragment_index, 1);
+}
+
+/*
+ * __ssdfs_segbmap_change_state() - change segment state
+ * @segbmap: pointer on segment bitmap object
+ * @seg: segment number
+ * @new_state: new state
+ * @fragment_index: index of fragment
+ * @fragment_size: size of fragment in bytes
+ *
+ * This method tries to change state of @seg.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EAGAIN     - fragment is under initialization yet.
+ * %-EFAULT     - segbmap has inconsistent state.
+ * %-ERANGE     - internal error.
+ */
+static
+int __ssdfs_segbmap_change_state(struct ssdfs_segment_bmap *segbmap,
+				 u64 seg, int new_state,
+				 pgoff_t fragment_index,
+				 u16 fragment_size)
+{
+	u32 items_per_byte = SSDFS_ITEMS_PER_BYTE(SSDFS_SEG_STATE_BITS);
+	struct page *page;
+	u64 page_item;
+	u32 byte_offset;
+	u32 byte_item;
+	void *kaddr;
+	u8 *byte_ptr;
+	int old_state;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!segbmap);
+	BUG_ON(!rwsem_is_locked(&segbmap->search_lock));
+
+	SSDFS_DBG("segbmap %p, seg %llu, new_state %#x, "
+		  "fragment_index %lu, fragment_size %u\n",
+		  segbmap, seg, new_state,
+		  fragment_index, fragment_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = ssdfs_segbmap_check_fragment_validity(segbmap, fragment_index);
+	if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("fragment %lu is not initialized yet\n",
+			  fragment_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+		goto finish_set_state;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fragment %lu init has failed\n",
+			  fragment_index);
+		goto finish_set_state;
+	}
+
+	page = find_lock_page(&segbmap->pages, fragment_index);
+	if (!page) {
+		err = -ERANGE;
+		SSDFS_ERR("fail to get fragment %lu page\n",
+			  fragment_index);
+		goto finish_set_state;
+	}
+
+	ssdfs_account_locked_page(page);
+
+	page_item = ssdfs_segbmap_define_first_fragment_item(fragment_index,
+							     fragment_size);
+	if (seg < page_item) {
+		err = -ERANGE;
+		SSDFS_ERR("seg %llu < page_item %llu\n",
+			  seg, page_item);
+		goto free_page;
+	}
+
+	page_item = seg - page_item;
+
+	if (page_item >= ssdfs_segbmap_items_per_fragment(fragment_size)) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid page_item %llu\n",
+			  page_item);
+		goto free_page;
+	}
+
+	byte_offset = ssdfs_segbmap_get_item_byte_offset(page_item);
+
+	if (byte_offset >= PAGE_SIZE) {
+		err = -ERANGE;
+		SSDFS_ERR("invalid byte_offset %u\n",
+			  byte_offset);
+		goto free_page;
+	}
+
+	div_u64_rem(page_item, items_per_byte, &byte_item);
+
+	kaddr = kmap_local_page(page);
+	byte_ptr = (u8 *)kaddr + byte_offset;
+	err = ssdfs_segbmap_set_state_in_byte(byte_ptr, byte_item,
+					      &old_state, new_state);
+	if (!err) {
+		ssdfs_segbmap_correct_fragment_header(segbmap, fragment_index,
+							old_state, new_state,
+							kaddr);
+	}
+	kunmap_local(kaddr);
+
+	if (err == -EEXIST) {
+		err = 0;
+		SetPageUptodate(page);
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("old_state %#x == new_state %#x\n",
+			  old_state, new_state);
+#endif /* CONFIG_SSDFS_DEBUG */
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fail to set state: "
+			  "seg %llu, new_state %#x, err %d\n",
+			  seg, new_state, err);
+		goto free_page;
+	} else {
+		SetPageUptodate(page);
+		if (!PageDirty(page))
+			ssdfs_set_page_dirty(page);
+	}
+
+free_page:
+	ssdfs_unlock_page(page);
+	ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+finish_set_state:
+	return err;
+}
+
+/*
+ * ssdfs_segbmap_change_state() - change segment state
+ * @segbmap: pointer on segment bitmap object
+ * @seg: segment number
+ * @new_state: new state
+ * @end: pointer on completion for waiting init ending [out]
+ *
+ * This method tries to change state of @seg.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EAGAIN     - fragment is under initialization yet.
+ * %-EFAULT     - segbmap has inconsistent state.
+ * %-ERANGE     - internal error.
+ */
+int ssdfs_segbmap_change_state(struct ssdfs_segment_bmap *segbmap,
+				u64 seg, int new_state,
+				struct completion **end)
+{
+	u64 items_count;
+	u16 fragments_count;
+	u16 fragment_size;
+	pgoff_t fragment_index;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!segbmap);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("segbmap %p, seg %llu, new_state %#x\n",
+		  segbmap, seg, new_state);
+#else
+	SSDFS_DBG("segbmap %p, seg %llu, new_state %#x\n",
+		  segbmap, seg, new_state);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	*end = NULL;
+
+	inode_lock_shared(segbmap->fsi->segbmap_inode);
+	down_read(&segbmap->resize_lock);
+
+	items_count = segbmap->items_count;
+	fragments_count = segbmap->fragments_count;
+	fragment_size = segbmap->fragment_size;
+
+	if (segbmap->flags & SSDFS_SEGBMAP_ERROR) {
+		err = -EFAULT;
+		ssdfs_fs_error(segbmap->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"segbmap has corrupted state\n");
+		goto finish_segment_check;
+	}
+
+	if (seg >= items_count) {
+		err = -ERANGE;
+		SSDFS_ERR("seg %llu >= items_count %llu\n",
+			  seg, items_count);
+		goto finish_segment_check;
+	}
+
+	fragment_index = ssdfs_segbmap_seg_2_fragment_index(seg);
+	if (fragment_index >= fragments_count) {
+		err = -EFAULT;
+		ssdfs_fs_error(segbmap->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"fragment_index %lu >= fragments_count %u\n",
+				fragment_index, fragments_count);
+		goto finish_segment_check;
+	}
+
+	down_write(&segbmap->search_lock);
+	*end = &segbmap->desc_array[fragment_index].init_end;
+	err = __ssdfs_segbmap_change_state(segbmap, seg, new_state,
+					   fragment_index, fragment_size);
+	up_write(&segbmap->search_lock);
+
+finish_segment_check:
+	up_read(&segbmap->resize_lock);
+	inode_unlock_shared(segbmap->fsi->segbmap_inode);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return err;
+}
+
+/*
+ * ssdfs_segbmap_choose_fbmap() - choose fragment bitmap
+ * @segbmap: pointer on segment bitmap object
+ * @state: requested state
+ * @mask: requested mask
+ *
+ * RETURN:
+ * [success] - pointer on fragment bitmap
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-EOPNOTSUPP - operation is not supported.
+ */
+static
+unsigned long *ssdfs_segbmap_choose_fbmap(struct ssdfs_segment_bmap *segbmap,
+					  int state, int mask)
+{
+	unsigned long *fbmap;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!segbmap);
+	BUG_ON(!rwsem_is_locked(&segbmap->search_lock));
+
+	if (state < SSDFS_SEG_CLEAN || state >= SSDFS_SEG_STATE_MAX) {
+		SSDFS_ERR("unknown segment state %#x\n", state);
+		return ERR_PTR(-EINVAL);
+	}
+
+	if ((mask & SSDFS_SEG_CLEAN_USING_MASK) != mask &&
+	    (mask & SSDFS_SEG_USED_DIRTY_MASK) != mask &&
+	    (mask & SSDFS_SEG_BAD_STATE_MASK) != mask) {
+		SSDFS_ERR("unsupported set of flags %#x\n",
+			  mask);
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	SSDFS_DBG("segbmap %p, state %#x, mask %#x\n",
+		  segbmap, state, mask);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (mask & SSDFS_SEG_CLEAN_USING_MASK) {
+		fbmap = segbmap->fbmap[SSDFS_SEGBMAP_CLEAN_USING_FBMAP];
+
+		switch (state) {
+		case SSDFS_SEG_CLEAN:
+		case SSDFS_SEG_DATA_USING:
+		case SSDFS_SEG_LEAF_NODE_USING:
+		case SSDFS_SEG_HYBRID_NODE_USING:
+		case SSDFS_SEG_INDEX_NODE_USING:
+			return fbmap;
+
+		default:
+			return ERR_PTR(-EOPNOTSUPP);
+		}
+	} else if (mask & SSDFS_SEG_USED_DIRTY_MASK) {
+		fbmap = segbmap->fbmap[SSDFS_SEGBMAP_USED_DIRTY_FBMAP];
+
+		switch (state) {
+		case SSDFS_SEG_USED:
+		case SSDFS_SEG_PRE_DIRTY:
+		case SSDFS_SEG_DIRTY:
+			return fbmap;
+
+		default:
+			return ERR_PTR(-EOPNOTSUPP);
+		}
+	} else if (mask & SSDFS_SEG_BAD_STATE_MASK) {
+		fbmap = segbmap->fbmap[SSDFS_SEGBMAP_BAD_FBMAP];
+
+		switch (state) {
+		case SSDFS_SEG_BAD:
+			return fbmap;
+
+		default:
+			return ERR_PTR(-EOPNOTSUPP);
+		}
+	}
+
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+/*
+ * ssdfs_segbmap_find_fragment() - find fragment
+ * @segbmap: pointer on segment bitmap object
+ * @fbmap: bitmap of fragments
+ * @start_fragment: start fragment for search
+ * @max_fragment: upper bound for fragment search
+ * @found_fragment: found fragment index [out]
+ *
+ * This method tries to find fragment in bitmap of
+ * fragments.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-EAGAIN     - fragment is under initialization yet.
+ * %-EFAULT     - segbmap has inconsistent state.
+ * %-ENODATA    - bitmap hasn't any valid fragment.
+ */
+static
+int ssdfs_segbmap_find_fragment(struct ssdfs_segment_bmap *segbmap,
+				unsigned long *fbmap,
+				u16 start_fragment, u16 max_fragment,
+				int *found_fragment)
+{
+	unsigned long *addr;
+	u16 long_offset;
+	u16 first_fragment;
+	u16 checking_fragment;
+	u16 size, requested_size, checked_size;
+	unsigned long found;
+	u16 i;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!segbmap || !fbmap || !found_fragment);
+	BUG_ON(!rwsem_is_locked(&segbmap->search_lock));
+
+	SSDFS_DBG("fbmap %p, start_fragment %u, max_fragment %u\n",
+		  fbmap, start_fragment, max_fragment);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*found_fragment = U16_MAX;
+
+	if (start_fragment >= max_fragment) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("start_fragment %u >= max_fragment %u\n",
+			  start_fragment, max_fragment);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENODATA;
+	}
+
+	long_offset = (start_fragment + BITS_PER_LONG - 1) / BITS_PER_LONG;
+	first_fragment = long_offset * BITS_PER_LONG;
+
+	checking_fragment = min_t(u16, start_fragment, first_fragment);
+	checked_size = max_fragment - checking_fragment;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("start_fragment %u, max_fragment %u, "
+		  "long_offset %u, first_fragment %u, "
+		  "checking_fragment %u, checked_size %u\n",
+		  start_fragment, max_fragment,
+		  long_offset, first_fragment,
+		  checking_fragment, checked_size);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	for (i = 0; i < checked_size; i++) {
+		struct ssdfs_segbmap_fragment_desc *desc;
+		u16 index = checking_fragment + i;
+
+		desc = &segbmap->desc_array[index];
+
+		switch (desc->state) {
+		case SSDFS_SEGBMAP_FRAG_INITIALIZED:
+		case SSDFS_SEGBMAP_FRAG_DIRTY:
+			/*
+			 * We can use this fragment.
+			 * Simply go ahead.
+			 */
+			break;
+
+		case SSDFS_SEGBMAP_FRAG_CREATED:
+			/* It needs to wait the fragment's init */
+			err = -EAGAIN;
+			checked_size = index - checking_fragment;
+			goto check_presence_valid_fragments;
+			break;
+
+		case SSDFS_SEGBMAP_FRAG_INIT_FAILED:
+			err = -EFAULT;
+			*found_fragment = index;
+			SSDFS_ERR("fragment %u is corrupted\n",
+				  index);
+			checked_size = 0;
+			goto check_presence_valid_fragments;
+			break;
+
+		default:
+			err = -ERANGE;
+			SSDFS_ERR("invalid fragment's state %#x\n",
+				  desc->state);
+			goto check_presence_valid_fragments;
+			break;
+		}
+	}
+
+check_presence_valid_fragments:
+	if (err == -ERANGE || err == -EFAULT) {
+		/* Simply return the error */
+		return err;
+	} else if (err == -EAGAIN) {
+		if (checked_size == 0) {
+			SSDFS_DBG("no valid fragments yet\n");
+			return err;
+		} else
+			err = 0;
+	}
+
+	if (start_fragment < first_fragment) {
+		unsigned long value = *(fbmap + (long_offset - 1));
+
+		size = start_fragment - ((long_offset - 1) * BITS_PER_LONG);
+		size = min_t(u16, size, checked_size);
+		bitmap_clear(&value, 0, size);
+
+		if (value != 0) {
+			found = __ffs(value);
+			*found_fragment = start_fragment + (u16)(found - size);
+			return 0;
+		} else {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to find fragment: "
+				  "value %#lx\n",
+				  value);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return -ENODATA;
+		}
+	} else {
+		/* first_fragment <= start_fragment */
+		addr = fbmap + long_offset;
+		requested_size = max_fragment - first_fragment;
+		size = min_t(u16, requested_size, checked_size);
+
+		if (size == 0) {
+			SSDFS_DBG("no valid fragments yet\n");
+			return -EAGAIN;
+		}
+
+		found = find_first_bit(addr, size);
+
+		found += first_fragment;
+		BUG_ON(found >= U16_MAX);
+		*found_fragment = found;
+
+		if (found >= size) {
+			if (size < requested_size) {
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("Wait init of fragment %lu\n",
+					  found);
+#endif /* CONFIG_SSDFS_DEBUG */
+				return -EAGAIN;
+			} else {
+#ifdef CONFIG_SSDFS_DEBUG
+				SSDFS_DBG("unable to find fragment: "
+					  "found %lu, size %u\n",
+					  found, size);
+#endif /* CONFIG_SSDFS_DEBUG */
+				return -ENODATA;
+			}
+		}
+
+		return 0;
+	}
+
+	return -ERANGE;
+}
+
+/*
+ * ssdfs_segbmap_correct_search_start() - correct start item for search
+ * @fragment_index: index of fragment
+ * @old_start: old start value
+ * @max: upper bound for search
+ * @fragment_size: size of fragment in bytes
+ */
+static
+u64 ssdfs_segbmap_correct_search_start(u16 fragment_index,
+					u64 old_start, u64 max,
+					u16 fragment_size)
+{
+	u64 first_item, corrected_value;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	if (old_start >= max) {
+		SSDFS_ERR("old_start %llu >= max %llu\n",
+			  old_start, max);
+		return U64_MAX;
+	}
+
+	SSDFS_DBG("fragment_index %u, old_start %llu, max %llu\n",
+		  fragment_index, old_start, max);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	first_item = ssdfs_segbmap_define_first_fragment_item(fragment_index,
+							      fragment_size);
+
+	if (first_item >= max) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("first_item %llu >= max %llu\n",
+			  first_item, max);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return U64_MAX;
+	}
+
+	corrected_value = first_item > old_start ? first_item : old_start;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("corrected_value %llu\n", corrected_value);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return corrected_value;
+}
+
+/*
+ * ssdfs_segbmap_define_items_count() - define items count for state/mask
+ * @desc: fragment descriptor
+ * @state: requested state
+ * @mask: requested mask
+ */
+static inline
+u16 ssdfs_segbmap_define_items_count(struct ssdfs_segbmap_fragment_desc *desc,
+				     int state, int mask)
+{
+	int complex_mask;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!desc);
+	BUG_ON(!mask);
+
+	SSDFS_DBG("desc %p, state %#x, mask %#x\n",
+		  desc, state, mask);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	switch (state) {
+	case SSDFS_SEG_CLEAN:
+		complex_mask = SSDFS_SEG_CLEAN_STATE_FLAG | mask;
+		break;
+
+	case SSDFS_SEG_DATA_USING:
+		complex_mask = SSDFS_SEG_DATA_USING_STATE_FLAG | mask;
+		break;
+
+	case SSDFS_SEG_LEAF_NODE_USING:
+		complex_mask = SSDFS_SEG_LEAF_NODE_USING_STATE_FLAG | mask;
+		break;
+
+	case SSDFS_SEG_HYBRID_NODE_USING:
+		complex_mask = SSDFS_SEG_HYBRID_NODE_USING_STATE_FLAG | mask;
+		break;
+
+	case SSDFS_SEG_INDEX_NODE_USING:
+		complex_mask = SSDFS_SEG_INDEX_NODE_USING_STATE_FLAG | mask;
+		break;
+
+	case SSDFS_SEG_USED:
+		complex_mask = SSDFS_SEG_USED_STATE_FLAG | mask;
+		break;
+
+	case SSDFS_SEG_PRE_DIRTY:
+		complex_mask = SSDFS_SEG_PRE_DIRTY_STATE_FLAG | mask;
+		break;
+
+	case SSDFS_SEG_DIRTY:
+		complex_mask = SSDFS_SEG_DIRTY_STATE_FLAG | mask;
+		break;
+
+	case SSDFS_SEG_BAD:
+		complex_mask = SSDFS_SEG_BAD_STATE_FLAG | mask;
+		break;
+
+	default:
+		BUG();
+	}
+
+	if ((complex_mask & SSDFS_SEG_CLEAN_USING_MASK) != complex_mask &&
+	    (complex_mask & SSDFS_SEG_USED_DIRTY_MASK) != complex_mask &&
+	    (complex_mask & SSDFS_SEG_BAD_STATE_MASK) != complex_mask) {
+		SSDFS_ERR("unsupported set of flags %#x\n",
+			  complex_mask);
+		return U16_MAX;
+	}
+
+	if (complex_mask & SSDFS_SEG_CLEAN_USING_MASK)
+		return desc->clean_or_using_segs;
+	else if (complex_mask & SSDFS_SEG_USED_DIRTY_MASK)
+		return desc->used_or_dirty_segs;
+	else if (complex_mask & SSDFS_SEG_BAD_STATE_MASK)
+		return desc->bad_segs;
+
+	return U16_MAX;
+}
+
+/*
+ * BYTE_CONTAINS_STATE() - check that byte contains requested state
+ * @value: pointer on byte
+ * @state: requested state
+ */
+static inline
+bool BYTE_CONTAINS_STATE(u8 *value, int state)
+{
+	switch (state) {
+	case SSDFS_SEG_CLEAN:
+		return detect_clean_seg[*value];
+
+	case SSDFS_SEG_DATA_USING:
+		return detect_data_using_seg[*value];
+
+	case SSDFS_SEG_LEAF_NODE_USING:
+		return detect_lnode_using_seg[*value];
+
+	case SSDFS_SEG_HYBRID_NODE_USING:
+		return detect_hnode_using_seg[*value];
+
+	case SSDFS_SEG_INDEX_NODE_USING:
+		return detect_idxnode_using_seg[*value];
+
+	case SSDFS_SEG_USED:
+		return detect_used_seg[*value];
+
+	case SSDFS_SEG_PRE_DIRTY:
+		return detect_pre_dirty_seg[*value];
+
+	case SSDFS_SEG_DIRTY:
+		return detect_dirty_seg[*value];
+
+	case SSDFS_SEG_BAD:
+		return detect_bad_seg[*value];
+	};
+
+	return false;
+}
+
+/*
+ * BYTE_CONTAINS_MASK() - check that byte contains any state under mask
+ * @value: pointer on byte
+ * @mask: requested mask
+ */
+static inline
+bool BYTE_CONTAINS_MASK(u8 *value, int mask)
+{
+	if (mask & SSDFS_SEG_CLEAN_USING_MASK)
+		return detect_clean_using_mask[*value];
+	else if (mask & SSDFS_SEG_USED_DIRTY_MASK)
+		return detect_used_dirty_mask[*value];
+	else if (mask & SSDFS_SEG_BAD_STATE_MASK)
+		return detect_bad_seg[*value];
+
+	return false;
+}
+
+/*
+ * FIRST_MASK_IN_BYTE() - determine first item's offset for requested mask
+ * @value: pointer on analysed byte
+ * @mask: requested mask
+ * @start_offset: starting item's offset for analysis beginning
+ * @state_bits: bits per state
+ * @state_mask: mask of a bitmap's state
+ *
+ * This function tries to determine an item for @mask in
+ * @value starting from @start_off.
+ *
+ * RETURN:
+ * [success] - found item's offset.
+ * [failure] - BITS_PER_BYTE.
+ */
+static inline
+u8 FIRST_MASK_IN_BYTE(u8 *value, int mask,
+		      u8 start_offset, u8 state_bits,
+		      int state_mask)
+{
+	u8 i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!value);
+	BUG_ON(state_bits > BITS_PER_BYTE);
+	BUG_ON((state_bits % 2) != 0);
+	BUG_ON(start_offset > SSDFS_ITEMS_PER_BYTE(state_bits));
+
+	SSDFS_DBG("value %#x, mask %#x, "
+		  "start_offset %u, state_bits %u\n",
+		  *value, mask, start_offset, state_bits);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	i = start_offset * state_bits;
+	for (; i < BITS_PER_BYTE; i += state_bits) {
+		if (IS_STATE_GOOD_FOR_MASK(mask, (*value >> i) & state_mask)) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("found bit %u, found item %u\n",
+				  i, i / state_bits);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return i / state_bits;
+		}
+	}
+
+	return SSDFS_ITEMS_PER_BYTE(state_bits);
+}
+
+/*
+ * FIND_FIRST_ITEM_IN_FRAGMENT() - find first item in fragment
+ * @hdr: pointer on segbmap fragment's header
+ * @fragment: pointer on bitmap in fragment
+ * @start_item: start segment number for search
+ * @max_item: upper bound of segment number for search
+ * @state: primary state for search
+ * @mask: mask of additonal states that can be retrieved too
+ * @found_seg: found segment number [out]
+ * @found_for_mask: found segment number for mask [out]
+ * @found_state_for_mask: found state for mask [out]
+ *
+ * This method tries to find first item with requested
+ * state in fragment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-ENOENT     - found segment number for the mask.
+ * %-ENODATA    - fragment doesn't include segment with requested state/mask.
+ */
+static
+int FIND_FIRST_ITEM_IN_FRAGMENT(struct ssdfs_segbmap_fragment_header *hdr,
+				u8 *fragment, u64 start_item, u64 max_item,
+				int state, int mask,
+				u64 *found_seg, u64 *found_for_mask,
+				int *found_state_for_mask)
+{
+	u32 items_per_byte = SSDFS_ITEMS_PER_BYTE(SSDFS_SEG_STATE_BITS);
+	u64 fragment_start_item;
+	u64 aligned_start, aligned_end;
+	u32 byte_index, search_bytes;
+	u64 byte_range;
+	u8 start_offset;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!hdr || !fragment || !found_seg || !found_for_mask);
+
+	if (start_item >= max_item) {
+		SSDFS_ERR("start_item %llu >= max_item %llu\n",
+			  start_item, max_item);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("hdr %p, fragment %p, "
+		  "start_item %llu, max_item %llu, "
+		  "state %#x, mask %#x, "
+		  "found_seg %p, found_for_mask %p\n",
+		  hdr, fragment, start_item, max_item,
+		  state, mask, found_seg, found_for_mask);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*found_seg = U64_MAX;
+	*found_for_mask = U64_MAX;
+	*found_state_for_mask = SSDFS_SEG_STATE_MAX;
+
+	fragment_start_item = le64_to_cpu(hdr->start_item);
+
+	if (fragment_start_item == U64_MAX) {
+		SSDFS_ERR("invalid fragment start item\n");
+		return -ERANGE;
+	}
+
+	search_bytes = le16_to_cpu(hdr->fragment_bytes) -
+			sizeof(struct ssdfs_segbmap_fragment_header);
+
+	if (search_bytes == 0 || search_bytes > PAGE_SIZE) {
+		SSDFS_ERR("invalid fragment_bytes %u\n",
+			  search_bytes);
+		return -ERANGE;
+	}
+
+	aligned_start = ALIGNED_START_ITEM(start_item, SSDFS_SEG_STATE_BITS);
+	aligned_end = ALIGNED_END_ITEM(max_item, SSDFS_SEG_STATE_BITS);
+
+	byte_range = (aligned_end - fragment_start_item) / items_per_byte;
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(byte_range >= U32_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	search_bytes = min_t(u32, search_bytes, (u32)byte_range);
+
+	if (fragment_start_item <= aligned_start) {
+		u32 items_range = aligned_start - fragment_start_item;
+		byte_index = items_range / items_per_byte;
+		start_offset = (u8)(start_item - aligned_start);
+	} else {
+		byte_index = 0;
+		start_offset = 0;
+	}
+
+	for (; byte_index < search_bytes; byte_index++) {
+		u8 *value = fragment + byte_index;
+		u8 found_offset;
+
+		err = FIND_FIRST_ITEM_IN_BYTE(value, state,
+					      SSDFS_SEG_STATE_BITS,
+					      SSDFS_SEG_STATE_MASK,
+					      start_offset,
+					      BYTE_CONTAINS_STATE,
+					      FIRST_STATE_IN_BYTE,
+					      &found_offset);
+
+		if (err != -ENODATA || *found_for_mask != U64_MAX)
+			goto ignore_search_for_mask;
+
+		err = FIND_FIRST_ITEM_IN_BYTE(value, mask,
+					      SSDFS_SEG_STATE_BITS,
+					      SSDFS_SEG_STATE_MASK,
+					      start_offset,
+					      BYTE_CONTAINS_MASK,
+					      FIRST_MASK_IN_BYTE,
+					      &found_offset);
+
+		if (!err && found_offset != U64_MAX) {
+			err = -ENOENT;
+
+			*found_for_mask = fragment_start_item;
+			*found_for_mask += byte_index * items_per_byte;
+			*found_for_mask += found_offset;
+
+			if (*found_for_mask >= max_item) {
+				*found_for_mask = U64_MAX;
+				goto ignore_search_for_mask;
+			}
+
+			*found_state_for_mask =
+				ssdfs_segbmap_get_state_from_byte(value,
+								  found_offset);
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("found_for_mask %llu, "
+				  "found_state_for_mask %#x\n",
+				  *found_for_mask,
+				  *found_state_for_mask);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			if (IS_STATE_GOOD_FOR_MASK(mask, *found_state_for_mask))
+				break;
+			else {
+				err = -ENODATA;
+				*found_for_mask = U64_MAX;
+				*found_state_for_mask = SSDFS_SEG_STATE_MAX;
+			}
+		}
+
+ignore_search_for_mask:
+		if (err == -ENODATA) {
+			start_offset = 0;
+			continue;
+		} else if (err == -ENOENT) {
+			/*
+			 * Value for mask has been found.
+			 * Simply end the search.
+			 */
+			break;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find items in byte: "
+				  "byte_index %u, state %#x, "
+				  "err %d\n",
+				  byte_index, state, err);
+			goto end_search;
+		}
+
+		*found_seg = fragment_start_item;
+		*found_seg += byte_index * items_per_byte;
+		*found_seg += found_offset;
+
+		if (*found_seg >= max_item)
+			*found_seg = U64_MAX;
+
+		break;
+	}
+
+	if (*found_seg == U64_MAX && *found_for_mask == U64_MAX)
+		err = -ENODATA;
+	else if (*found_seg == U64_MAX && *found_for_mask != U64_MAX)
+		err = -ENOENT;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	if (!err || err == -ENOENT) {
+		SSDFS_DBG("found_seg %llu, found_for_mask %llu\n",
+			  *found_seg, *found_for_mask);
+	} else
+		SSDFS_DBG("nothing was found: err %d\n", err);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+end_search:
+	return err;
+}
+
+/*
+ * ssdfs_segbmap_find_in_fragment() - find segment with state in fragment
+ * @segbmap: pointer on segment bitmap object
+ * @fragment_index: index of fragment
+ * @fragment_size: size of fragment in bytes
+ * @start: start segment number for search
+ * @max: upper bound of segment number for search
+ * @state: primary state for search
+ * @mask: mask of additonal states that can be retrieved too
+ * @found_seg: found segment number [out]
+ * @found_for_mask: found segment number for mask [out]
+ * @found_state_for_mask: found state for mask [out]
+ *
+ * This method tries to find segment number for requested state
+ * in fragment.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-ERANGE     - internal error.
+ * %-EAGAIN     - fragment is under initialization yet.
+ * %-EFAULT     - fragment has inconsistent state.
+ */
+static
+int ssdfs_segbmap_find_in_fragment(struct ssdfs_segment_bmap *segbmap,
+				   u16 fragment_index,
+				   u16 fragment_size,
+				   u64 start, u64 max,
+				   int state, int mask,
+				   u64 *found_seg, u64 *found_for_mask,
+				   int *found_state_for_mask)
+{
+	struct ssdfs_segbmap_fragment_desc *fragment;
+	size_t hdr_size = sizeof(struct ssdfs_segbmap_fragment_header);
+	struct page *page;
+	u64 first_item;
+	u32 items_per_fragment;
+	u16 items_count;
+	void *kaddr;
+	unsigned long *bmap;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!segbmap || !found_seg || !found_for_mask);
+	BUG_ON(!rwsem_is_locked(&segbmap->search_lock));
+
+	if (start >= max) {
+		SSDFS_ERR("start %llu >= max %llu\n",
+			  start, max);
+		return -EINVAL;
+	}
+
+	SSDFS_DBG("segbmap %p, fragment_index %u, "
+		  "fragment_size %u, start %llu, max %llu, "
+		  "found_seg %p, found_for_mask %p\n",
+		  segbmap, fragment_index, fragment_size,
+		  start, max,
+		  found_seg, found_for_mask);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*found_seg = U64_MAX;
+	*found_for_mask = U64_MAX;
+
+	first_item = ssdfs_segbmap_define_first_fragment_item(fragment_index,
+							      fragment_size);
+	items_per_fragment = ssdfs_segbmap_items_per_fragment(fragment_size);
+
+	if (first_item >= max) {
+		SSDFS_ERR("first_item %llu >= max %llu\n",
+			  first_item, max);
+		return -ERANGE;
+	} else if ((first_item + items_per_fragment) <= start) {
+		SSDFS_ERR("first_item %llu, items_per_fragment %u, "
+			  "start %llu\n",
+			  first_item, items_per_fragment, start);
+		return -ERANGE;
+	}
+
+	err = ssdfs_segbmap_check_fragment_validity(segbmap, fragment_index);
+	if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("fragment %u is not initilaized yet\n",
+			  fragment_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return err;
+	} else if (err == -EFAULT) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("fragment %u initialization was failed\n",
+			  fragment_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return err;
+	} else if (unlikely(err)) {
+		SSDFS_ERR("fragment %u is corrupted: err %d\n",
+			  fragment_index, err);
+		return err;
+	}
+
+	fragment = &segbmap->desc_array[fragment_index];
+
+	items_count = ssdfs_segbmap_define_items_count(fragment, state, mask);
+	if (items_count == U16_MAX) {
+		SSDFS_ERR("segbmap has inconsistent state\n");
+		return -ERANGE;
+	} else if (items_count == 0) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("fragment %u hasn't items for search\n",
+			  fragment_index);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENODATA;
+	}
+
+	items_count = fragment->total_segs;
+
+	if (items_count == 0 || items_count > items_per_fragment) {
+		SSDFS_ERR("invalid total_segs %u\n", items_count);
+		return -ERANGE;
+	}
+
+	page = find_lock_page(&segbmap->pages, fragment_index);
+	if (!page) {
+		SSDFS_ERR("fragment %u hasn't memory page\n",
+			  fragment_index);
+		return -ERANGE;
+	}
+
+	ssdfs_account_locked_page(page);
+	kaddr = kmap_local_page(page);
+	bmap = (unsigned long *)((u8 *)kaddr + hdr_size);
+
+	err = FIND_FIRST_ITEM_IN_FRAGMENT(SSDFS_SBMP_FRAG_HDR(kaddr),
+					  (u8 *)bmap, start, max, state, mask,
+					  found_seg, found_for_mask,
+					  found_state_for_mask);
+
+	kunmap_local(kaddr);
+	ssdfs_unlock_page(page);
+	ssdfs_put_page(page);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("page %p, count %d\n",
+		  page, page_ref_count(page));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return err;
+}
+
+/*
+ * __ssdfs_segbmap_find() - find segment with state
+ * @segbmap: pointer on segment bitmap object
+ * @start: start segment number for search
+ * @max: upper bound of segment number for search
+ * @state: primary state for search
+ * @mask: mask of additonal states that can be retrieved too
+ * @fragment_size: fragment size in bytes
+ * @seg: found segment number [out]
+ * @end: pointer on completion for waiting init ending [out]
+ *
+ * This method tries to find segment number for requested state.
+ *
+ * RETURN:
+ * [success] - found segment state
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-EAGAIN     - fragment is under initialization yet.
+ * %-EOPNOTSUPP - operation is not supported.
+ * %-ENOMEM     - fail to allocate memory.
+ * %-EFAULT     - segbmap has inconsistent state.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - unable to find segment as for state as for mask.
+ */
+static
+int __ssdfs_segbmap_find(struct ssdfs_segment_bmap *segbmap,
+			 u64 start, u64 max,
+			 int state, int mask,
+			 u16 fragment_size,
+			 u64 *seg, struct completion **end)
+{
+	unsigned long *fbmap;
+	int start_fragment, max_fragment, found_fragment;
+	u64 found = U64_MAX, found_for_mask = U64_MAX;
+	int found_state_for_mask = SSDFS_SEG_STATE_MAX;
+	int err = -ENODATA;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!segbmap || !seg);
+	BUG_ON(!rwsem_is_locked(&segbmap->search_lock));
+
+	SSDFS_DBG("segbmap %p, start %llu, max %llu, "
+		  "state %#x, mask %#x, fragment_size %u, seg %p\n",
+		  segbmap, start, max, state, mask,
+		  fragment_size, seg);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*end = NULL;
+
+	if (start >= max) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("start %llu >= max %llu\n",
+			  start, max);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENODATA;
+	}
+
+	fbmap = ssdfs_segbmap_choose_fbmap(segbmap, state, mask);
+	if (IS_ERR_OR_NULL(fbmap)) {
+		err = (fbmap == NULL ? -ENOMEM : PTR_ERR(fbmap));
+		SSDFS_ERR("unable to choose fragment bitmap: err %d\n",
+			  err);
+		return err;
+	}
+
+	start_fragment = SEG_BMAP_FRAGMENTS(start + 1);
+	if (start_fragment > 0)
+		start_fragment -= 1;
+
+	max_fragment = SEG_BMAP_FRAGMENTS(max);
+
+	do {
+		u64 found_for_iter = U64_MAX;
+		int found_state_for_iter = -1;
+
+		err = ssdfs_segbmap_find_fragment(segbmap,
+						  fbmap,
+						  start_fragment,
+						  max_fragment,
+						  &found_fragment);
+		if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to find fragment: "
+				  "state %#x, mask %#x, "
+				  "start_fragment %d, max_fragment %d\n",
+				  state, mask,
+				  start_fragment, max_fragment);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_seg_search;
+		} else if (err == -EFAULT) {
+			ssdfs_fs_error(segbmap->fsi->sb,
+					__FILE__, __func__, __LINE__,
+					"segbmap inconsistent state: "
+					"found_fragment %d\n",
+					found_fragment);
+			goto finish_seg_search;
+		} else if (err == -EAGAIN) {
+			if (found_fragment >= U16_MAX) {
+				/* select the first fragment by default */
+				found_fragment = 0;
+			}
+
+			*end = &segbmap->desc_array[found_fragment].init_end;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("fragment %u is not initilaized yet\n",
+				  found_fragment);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_seg_search;
+		} else if (unlikely(err)) {
+			SSDFS_ERR("fail to find fragment: "
+				  "start_fragment %d, max_fragment %d, "
+				  "err %d\n",
+				  start_fragment, max_fragment, err);
+			goto finish_seg_search;
+		} else if (found_fragment >= U16_MAX) {
+			err = -ERANGE;
+			SSDFS_ERR("fail to find fragment: "
+				  "start_fragment %d, max_fragment %d, "
+				  "err %d\n",
+				  start_fragment, max_fragment, err);
+			goto finish_seg_search;
+		}
+
+		start = ssdfs_segbmap_correct_search_start(found_fragment,
+							   start, max,
+							   fragment_size);
+		if (start == U64_MAX || start >= max) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("break search: start %llu, max %llu\n",
+				  start, max);
+#endif /* CONFIG_SSDFS_DEBUG */
+			break;
+		}
+
+		*end = &segbmap->desc_array[found_fragment].init_end;
+
+		err = ssdfs_segbmap_find_in_fragment(segbmap, found_fragment,
+						     fragment_size,
+						     start, max,
+						     state, mask,
+						     &found, &found_for_iter,
+						     &found_state_for_iter);
+		if (err == -ENODATA) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("unable to find segment: "
+				  "fragment %d, "
+				  "state %#x, mask %#x, "
+				  "start %llu, max %llu\n",
+				  found_fragment,
+				  state, mask,
+				  start, max);
+#endif /* CONFIG_SSDFS_DEBUG */
+			/* try next fragment */
+		} else if (err == -ENOENT) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("mask %#x, found_for_mask %llu, "
+				  "found_for_iter %llu, "
+				  "found_state %#x\n",
+				  mask, found_for_mask, found_for_iter,
+				  found_state_for_iter);
+#endif /* CONFIG_SSDFS_DEBUG */
+			err = 0;
+			found_for_mask = found_for_iter;
+			found_state_for_mask = found_state_for_iter;
+			goto check_search_result;
+		} else if (err == -EFAULT) {
+			/* Just try another iteration */
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("fragment %d is inconsistent\n",
+				  found_fragment);
+#endif /* CONFIG_SSDFS_DEBUG */
+		} else if (err == -EAGAIN) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("fragment %u is not initilaized yet\n",
+				  found_fragment);
+#endif /* CONFIG_SSDFS_DEBUG */
+			goto finish_seg_search;
+		} else if (unlikely(err < 0)) {
+			SSDFS_ERR("fail to find segment: "
+				  "found_fragment %d, start %llu, "
+				  "max %llu, err %d\n",
+				  found_fragment, start, max, err);
+			goto finish_seg_search;
+		} else if (found == U64_MAX) {
+			err = -ERANGE;
+			SSDFS_ERR("invalid segment number: "
+				  "found_fragment %d, start %llu, "
+				  "max %llu\n",
+				  found_fragment, start, max);
+			goto finish_seg_search;
+		} else
+			break;
+
+		start_fragment = found_fragment + 1;
+	} while (start_fragment <= max_fragment);
+
+check_search_result:
+	if (unlikely(err < 0)) {
+		/* we have some error */
+		goto finish_seg_search;
+	} else if (found == U64_MAX) {
+		if (found_for_mask == U64_MAX) {
+			err = -ENODATA;
+			SSDFS_DBG("fail to find segment\n");
+		} else {
+			*seg = found_for_mask;
+			err = found_state_for_mask;
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("found for mask %llu, state %#x\n",
+				  *seg, err);
+#endif /* CONFIG_SSDFS_DEBUG */
+		}
+	} else {
+		*seg = found;
+		err = state;
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("found segment %llu\n", *seg);
+#endif /* CONFIG_SSDFS_DEBUG */
+	}
+
+finish_seg_search:
+	return err;
+}
+
+/*
+ * ssdfs_segbmap_find() - find segment with state
+ * @segbmap: pointer on segment bitmap object
+ * @start: start segment number for search
+ * @max: upper bound of segment number for search
+ * @state: primary state for search
+ * @mask: mask of additonal states that can be retrieved too
+ * @seg: found segment number [out]
+ * @end: pointer on completion for waiting init ending [out]
+ *
+ * This method tries to find segment number for requested state.
+ *
+ * RETURN:
+ * [success] - found segment state
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-EAGAIN     - fragment is under initialization yet.
+ * %-EOPNOTSUPP - operation is not supported.
+ * %-ENOMEM     - fail to allocate memory.
+ * %-EFAULT     - segbmap has inconsistent state.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - unable to find segment as for state as for mask.
+ */
+int ssdfs_segbmap_find(struct ssdfs_segment_bmap *segbmap,
+			u64 start, u64 max,
+			int state, int mask,
+			u64 *seg, struct completion **end)
+{
+	u64 items_count;
+	u16 fragment_size;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!segbmap || !seg);
+
+	if (start >= segbmap->items_count) {
+		SSDFS_ERR("start %llu >= items_count %llu\n",
+			  start, segbmap->items_count);
+		return -EINVAL;
+	}
+
+	if (start >= max) {
+		SSDFS_ERR("start %llu >= max %llu\n",
+			  start, max);
+		return -EINVAL;
+	}
+
+	if (state < SSDFS_SEG_CLEAN || state >= SSDFS_SEG_STATE_MAX) {
+		SSDFS_ERR("unknown segment state %#x\n", state);
+		return -EINVAL;
+	}
+
+	if ((mask & SSDFS_SEG_CLEAN_USING_MASK) != mask &&
+	    (mask & SSDFS_SEG_USED_DIRTY_MASK) != mask &&
+	    (mask & SSDFS_SEG_BAD_STATE_MASK) != mask) {
+		SSDFS_ERR("unsupported set of flags %#x\n",
+			  mask);
+		return -EOPNOTSUPP;
+	}
+
+	SSDFS_DBG("segbmap %p, start %llu, max %llu, "
+		  "state %#x, mask %#x, seg %p\n",
+		  segbmap, start, max, state, mask, seg);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*end = NULL;
+
+	inode_lock_shared(segbmap->fsi->segbmap_inode);
+	down_read(&segbmap->resize_lock);
+
+	items_count = segbmap->items_count;
+	fragment_size = segbmap->fragment_size;
+
+	if (segbmap->flags & SSDFS_SEGBMAP_ERROR) {
+		err = -EFAULT;
+		ssdfs_fs_error(segbmap->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"segbmap has corrupted state\n");
+		goto finish_search_preparation;
+	}
+
+	max = min_t(u64, max, items_count);
+
+	down_read(&segbmap->search_lock);
+	err = __ssdfs_segbmap_find(segbmap, start, max, state, mask,
+				   fragment_size, seg, end);
+	up_read(&segbmap->search_lock);
+
+finish_search_preparation:
+	up_read(&segbmap->resize_lock);
+	inode_unlock_shared(segbmap->fsi->segbmap_inode);
+
+	return err;
+}
+
+/*
+ * ssdfs_segbmap_find_and_set() - find segment and change state
+ * @segbmap: pointer on segment bitmap object
+ * @start: start segment number for search
+ * @max: upper bound of segment number for search
+ * @state: primary state for search
+ * @mask: mask of additonal states that can be retrieved too
+ * @new_state: new state of segment
+ * @seg: found segment number [out]
+ * @end: pointer on completion for waiting init ending [out]
+ *
+ * This method tries to find segment number for requested state
+ * and to set segment state as @new_state.
+ *
+ * RETURN:
+ * [success] - found segment state before changing
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-EAGAIN     - fragment is under initialization yet.
+ * %-EOPNOTSUPP - operation is not supported.
+ * %-ENOMEM     - fail to allocate memory.
+ * %-EFAULT     - segbmap has inconsistent state.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - unable to find segment as for state as for mask.
+ */
+int ssdfs_segbmap_find_and_set(struct ssdfs_segment_bmap *segbmap,
+				u64 start, u64 max,
+				int state, int mask,
+				int new_state,
+				u64 *seg, struct completion **end)
+{
+	u64 items_count;
+	u16 fragments_count;
+	u16 fragment_size;
+	pgoff_t fragment_index;
+	int err = 0, res = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!segbmap || !seg);
+
+	if (start >= segbmap->items_count) {
+		SSDFS_ERR("start %llu >= items_count %llu\n",
+			  start, segbmap->items_count);
+		return -EINVAL;
+	}
+
+	if (start >= max) {
+		SSDFS_ERR("start %llu >= max %llu\n",
+			  start, max);
+		return -EINVAL;
+	}
+
+	if (state < SSDFS_SEG_CLEAN || state >= SSDFS_SEG_STATE_MAX) {
+		SSDFS_ERR("unknown segment state %#x\n", state);
+		return -EINVAL;
+	}
+
+	if ((mask & SSDFS_SEG_CLEAN_USING_MASK) != mask &&
+	    (mask & SSDFS_SEG_USED_DIRTY_MASK) != mask &&
+	    (mask & SSDFS_SEG_BAD_STATE_MASK) != mask) {
+		SSDFS_ERR("unsupported set of flags %#x\n",
+			  mask);
+		return -EOPNOTSUPP;
+	}
+
+	if (new_state < SSDFS_SEG_CLEAN || new_state >= SSDFS_SEG_STATE_MAX) {
+		SSDFS_ERR("unknown new segment state %#x\n", new_state);
+		return -EINVAL;
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("segbmap %p, start %llu, max %llu, "
+		  "state %#x, mask %#x, new_state %#x, seg %p\n",
+		  segbmap, start, max, state, mask, new_state, seg);
+#else
+	SSDFS_DBG("segbmap %p, start %llu, max %llu, "
+		  "state %#x, mask %#x, new_state %#x, seg %p\n",
+		  segbmap, start, max, state, mask, new_state, seg);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	*end = NULL;
+
+	inode_lock_shared(segbmap->fsi->segbmap_inode);
+	down_read(&segbmap->resize_lock);
+
+	items_count = segbmap->items_count;
+	fragments_count = segbmap->fragments_count;
+	fragment_size = segbmap->fragment_size;
+
+	if (segbmap->flags & SSDFS_SEGBMAP_ERROR) {
+		err = -EFAULT;
+		ssdfs_fs_error(segbmap->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"segbmap has corrupted state\n");
+		goto finish_search_preparation;
+	}
+
+	max = min_t(u64, max, items_count);
+
+	down_write(&segbmap->search_lock);
+
+try_to_find_seg_id:
+	res = __ssdfs_segbmap_find(segbmap, start, max,
+				   state, mask,
+				   fragment_size, seg, end);
+	if (res == -ENODATA) {
+		err = res;
+		SSDFS_DBG("unable to find any segment\n");
+		goto finish_find_set;
+	} else if (res == -EAGAIN) {
+		err = res;
+		SSDFS_DBG("fragment is not initilaized yet\n");
+		goto finish_find_set;
+	} else if (unlikely(res < 0)) {
+		err = res;
+		SSDFS_ERR("fail to find clean segment: err %d\n",
+			  err);
+		goto finish_find_set;
+	}
+
+	if (res == new_state) {
+		/* everything is done */
+		goto finish_find_set;
+	} else if (res == SSDFS_SEG_CLEAN) {
+		/*
+		 * we can change clean state on any other
+		 */
+	} else {
+		start = *seg + 1;
+		*seg = U64_MAX;
+		goto try_to_find_seg_id;
+	}
+
+	if (*seg >= items_count) {
+		err = -ERANGE;
+		SSDFS_ERR("seg %llu >= items_count %llu\n",
+			  *seg, items_count);
+		goto finish_find_set;
+	}
+
+	fragment_index = ssdfs_segbmap_seg_2_fragment_index(*seg);
+	if (fragment_index >= fragments_count) {
+		err = -EFAULT;
+		ssdfs_fs_error(segbmap->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"fragment_index %lu >= fragments_count %u\n",
+				fragment_index, fragments_count);
+		goto finish_find_set;
+	}
+
+	err = __ssdfs_segbmap_change_state(segbmap, *seg,
+					   new_state,
+					   fragment_index,
+					   fragment_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to reserve segment: err %d\n",
+			  err);
+		goto finish_find_set;
+	}
+
+finish_find_set:
+	up_write(&segbmap->search_lock);
+
+finish_search_preparation:
+	up_read(&segbmap->resize_lock);
+	inode_unlock_shared(segbmap->fsi->segbmap_inode);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished\n");
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	if (unlikely(err))
+		return err;
+
+	return res;
+}
+
+/*
+ * ssdfs_segbmap_reserve_clean_segment() - reserve clean segment
+ * @segbmap: pointer on segment bitmap object
+ * @start: start segment number for search
+ * @max: upper bound of segment number for search
+ * @seg: found segment number [out]
+ * @end: pointer on completion for waiting init ending [out]
+ *
+ * This method tries to find clean segment and to reserve it.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-EINVAL     - invalid input.
+ * %-EAGAIN     - fragment is under initialization yet.
+ * %-EOPNOTSUPP - operation is not supported.
+ * %-ENOMEM     - fail to allocate memory.
+ * %-EFAULT     - segbmap has inconsistent state.
+ * %-ERANGE     - internal error.
+ * %-ENODATA    - unable to find segment.
+ */
+int ssdfs_segbmap_reserve_clean_segment(struct ssdfs_segment_bmap *segbmap,
+					u64 start, u64 max,
+					u64 *seg, struct completion **end)
+{
+	u64 items_count;
+	u16 fragments_count;
+	u16 fragment_size;
+	pgoff_t fragment_index;
+	int err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!segbmap || !seg);
+
+	if (start >= segbmap->items_count) {
+		SSDFS_ERR("start %llu >= items_count %llu\n",
+			  start, segbmap->items_count);
+		return -EINVAL;
+	}
+
+	if (start >= max) {
+		SSDFS_ERR("start %llu >= max %llu\n",
+			  start, max);
+		return -EINVAL;
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("segbmap %p, start %llu, max %llu, "
+		  "seg %p\n",
+		  segbmap, start, max, seg);
+#else
+	SSDFS_DBG("segbmap %p, start %llu, max %llu, "
+		  "seg %p\n",
+		  segbmap, start, max, seg);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	*end = NULL;
+
+	inode_lock_shared(segbmap->fsi->segbmap_inode);
+	down_read(&segbmap->resize_lock);
+
+	items_count = segbmap->items_count;
+	fragments_count = segbmap->fragments_count;
+	fragment_size = segbmap->fragment_size;
+
+	if (segbmap->flags & SSDFS_SEGBMAP_ERROR) {
+		err = -EFAULT;
+		ssdfs_fs_error(segbmap->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"segbmap has corrupted state\n");
+		goto finish_segment_check;
+	}
+
+	down_write(&segbmap->search_lock);
+
+	err = __ssdfs_segbmap_find(segbmap, start, max,
+				   SSDFS_SEG_CLEAN,
+				   SSDFS_SEG_CLEAN_STATE_FLAG,
+				   fragment_size, seg, end);
+	if (err == -ENODATA) {
+		SSDFS_DBG("unable to find clean segment\n");
+		goto finish_reserve_segment;
+	} else if (err == -EAGAIN) {
+		SSDFS_DBG("fragment is not initilaized yet\n");
+		goto finish_reserve_segment;
+	} else if (unlikely(err < 0)) {
+		SSDFS_ERR("fail to find clean segment: err %d\n",
+			  err);
+		goto finish_reserve_segment;
+	}
+
+	if (*seg >= items_count) {
+		err = -ERANGE;
+		SSDFS_ERR("seg %llu >= items_count %llu\n",
+			  *seg, items_count);
+		goto finish_reserve_segment;
+	}
+
+	fragment_index = ssdfs_segbmap_seg_2_fragment_index(*seg);
+	if (fragment_index >= fragments_count) {
+		err = -EFAULT;
+		ssdfs_fs_error(segbmap->fsi->sb,
+				__FILE__, __func__, __LINE__,
+				"fragment_index %lu >= fragments_count %u\n",
+				fragment_index, fragments_count);
+		goto finish_reserve_segment;
+	}
+
+	err = __ssdfs_segbmap_change_state(segbmap, *seg,
+					   SSDFS_SEG_RESERVED,
+					   fragment_index,
+					   fragment_size);
+	if (unlikely(err)) {
+		SSDFS_ERR("fail to reserve segment: err %d\n",
+			  err);
+		goto finish_reserve_segment;
+	}
+
+finish_reserve_segment:
+	up_write(&segbmap->search_lock);
+
+finish_segment_check:
+	up_read(&segbmap->resize_lock);
+	inode_unlock_shared(segbmap->fsi->segbmap_inode);
+
+#ifdef CONFIG_SSDFS_TRACK_API_CALL
+	SSDFS_ERR("finished: seg %llu, err %d\n", *seg, err);
+#else
+	SSDFS_DBG("finished: seg %llu, err %d\n", *seg, err);
+#endif /* CONFIG_SSDFS_TRACK_API_CALL */
+
+	return err;
+}
-- 
2.34.1

