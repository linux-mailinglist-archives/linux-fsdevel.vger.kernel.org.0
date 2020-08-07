Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADD5E23F350
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 21:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgHGT4d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 15:56:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22709 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726635AbgHGTzz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 15:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596830154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MNhZc9pvovR9Cq1uBbizVm5zzTun4Iu/OyAwM/glcug=;
        b=akHGDvF0V30KptZ5bMgCyN55au+55f1Y/goXdfJmFjVdX2E4pnFAKLs3T1xX8XJiPNWq7o
        8NeVoZ9tXZshMiB7FGTG0HDJJsAdpGu+qCG83HBqfPwwn5MIpLbaISA3Sq6p6C9qwz41Xt
        kUK9DYSHqjpTWtzqjWY9FzcK1eiCvWM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-FFTQ3eGHNwGOcza_pXEmRw-1; Fri, 07 Aug 2020 15:55:48 -0400
X-MC-Unique: FFTQ3eGHNwGOcza_pXEmRw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79EC41005504;
        Fri,  7 Aug 2020 19:55:47 +0000 (UTC)
Received: from horse.redhat.com (ovpn-113-142.rdu2.redhat.com [10.10.113.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 598202DE74;
        Fri,  7 Aug 2020 19:55:47 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 2881E222E5F; Fri,  7 Aug 2020 15:55:39 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com
Subject: [PATCH v2 17/20] fuse,virtiofs: Maintain a list of busy elements
Date:   Fri,  7 Aug 2020 15:55:23 -0400
Message-Id: <20200807195526.426056-18-vgoyal@redhat.com>
In-Reply-To: <20200807195526.426056-1-vgoyal@redhat.com>
References: <20200807195526.426056-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This list will be used selecting fuse_dax_mapping to free when number of
free mappings drops below a threshold.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/file.c   | 22 ++++++++++++++++++++++
 fs/fuse/fuse_i.h |  7 +++++++
 fs/fuse/inode.c  |  4 ++++
 3 files changed, 33 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 54708cb24da0..ecd2a42f6e30 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -213,6 +213,23 @@ static struct fuse_dax_mapping *alloc_dax_mapping(struct fuse_conn *fc)
 	return dmap;
 }
 
+/* This assumes fc->lock is held */
+static void __dmap_remove_busy_list(struct fuse_conn *fc,
+				    struct fuse_dax_mapping *dmap)
+{
+	list_del_init(&dmap->busy_list);
+	WARN_ON(fc->nr_busy_ranges == 0);
+	fc->nr_busy_ranges--;
+}
+
+static void dmap_remove_busy_list(struct fuse_conn *fc,
+				  struct fuse_dax_mapping *dmap)
+{
+	spin_lock(&fc->lock);
+	__dmap_remove_busy_list(fc, dmap);
+	spin_unlock(&fc->lock);
+}
+
 /* This assumes fc->lock is held */
 static void __dmap_add_to_free_pool(struct fuse_conn *fc,
 				struct fuse_dax_mapping *dmap)
@@ -266,6 +283,10 @@ static int fuse_setup_one_mapping(struct inode *inode, unsigned long start_idx,
 		/* Protected by fi->i_dmap_sem */
 		interval_tree_insert(&dmap->itn, &fi->dmap_tree);
 		fi->nr_dmaps++;
+		spin_lock(&fc->lock);
+		list_add_tail(&dmap->busy_list, &fc->busy_ranges);
+		fc->nr_busy_ranges++;
+		spin_unlock(&fc->lock);
 	}
 	return 0;
 }
@@ -335,6 +356,7 @@ static void dmap_reinit_add_to_free_pool(struct fuse_conn *fc,
 	pr_debug("fuse: freeing memory range start_idx=0x%lx end_idx=0x%lx "
 		 "window_offset=0x%llx length=0x%llx\n", dmap->itn.start,
 		 dmap->itn.last, dmap->window_offset, dmap->length);
+	__dmap_remove_busy_list(fc, dmap);
 	dmap->itn.start = dmap->itn.last = 0;
 	__dmap_add_to_free_pool(fc, dmap);
 }
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 1ddf526330a5..f84ec9c661ab 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -80,6 +80,9 @@ struct fuse_dax_mapping {
 	/* For interval tree in file/inode */
 	struct interval_tree_node itn;
 
+	/* Will connect in fc->busy_ranges to keep track busy memory */
+	struct list_head busy_list;
+
 	/** Position in DAX window */
 	u64 window_offset;
 
@@ -812,6 +815,10 @@ struct fuse_conn {
 	/** DAX device, non-NULL if DAX is supported */
 	struct dax_device *dax_dev;
 
+	/* List of memory ranges which are busy */
+	unsigned long nr_busy_ranges;
+	struct list_head busy_ranges;
+
 	/*
 	 * DAX Window Free Ranges
 	 */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 4bd965d0ecf6..cfc04c5eda73 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -636,6 +636,8 @@ static void fuse_free_dax_mem_ranges(struct list_head *mem_list)
 	/* Free All allocated elements */
 	list_for_each_entry_safe(range, temp, mem_list, list) {
 		list_del(&range->list);
+		if (!list_empty(&range->busy_list))
+			list_del(&range->busy_list);
 		kfree(range);
 	}
 }
@@ -680,6 +682,7 @@ static int fuse_dax_mem_range_init(struct fuse_conn *fc,
 		 */
 		range->window_offset = i * FUSE_DAX_SZ;
 		range->length = FUSE_DAX_SZ;
+		INIT_LIST_HEAD(&range->busy_list);
 		list_add_tail(&range->list, &mem_ranges);
 	}
 
@@ -727,6 +730,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns,
 	fc->user_ns = get_user_ns(user_ns);
 	fc->max_pages = FUSE_DEFAULT_MAX_PAGES_PER_REQ;
 	INIT_LIST_HEAD(&fc->free_ranges);
+	INIT_LIST_HEAD(&fc->busy_ranges);
 }
 EXPORT_SYMBOL_GPL(fuse_conn_init);
 
-- 
2.25.4

