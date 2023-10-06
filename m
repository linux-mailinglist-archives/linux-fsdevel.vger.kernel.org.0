Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BA07BBF26
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 20:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbjJFSyG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 14:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbjJFSyB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:54:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2D8ED
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Oct 2023 11:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696618351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VJUiSpfPMzcl28TFVJjzzuncoLSne12d470beZMPYcY=;
        b=L2xD6Llp1BgCE7yCAwxa982v2i4U3HVlUC/VslEZDf90wSKtD9k4ZfmfYIIsxqv2k6YYod
        j7cyvt1daXbEzyD8oqciTkp+mv36cnFR3/OoNe+vUr2Wj7o2q9Qo4Slllh6LIWGGRY7x9b
        mey4+A0HEVjWLla6MvpXyF+TN66bQes=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-3GEBDfSLOWmP0kGuvhYDMg-1; Fri, 06 Oct 2023 14:52:29 -0400
X-MC-Unique: 3GEBDfSLOWmP0kGuvhYDMg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9a1cf3e6c04so207826166b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Oct 2023 11:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696618348; x=1697223148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJUiSpfPMzcl28TFVJjzzuncoLSne12d470beZMPYcY=;
        b=Gq4cfRytOlqY9hQ2NJIX2Jjr+q9TGwBTK1tGB1aOgSoyRp7RjV4hF1gUFOTS4Dxd6t
         dgIL8H4KCDY8K9ygHGVfVxcRHQY/wQjTReI7EWJm7NVooTmU7b4xed1LJokzUlJ503Ab
         Cw0bjYgFs8FeYMwEvCqPPLp8es4SvxVVRmyPRmQZn+zgtELl/cy6GT0FFCS/baw6etNM
         C4Q63HuSSUCUzjPrUms8fVXSIwtyO7uv93QpBiJdiZIVOMrPVCwb6Aj2McHO6sRZwdYZ
         tOUsLq1Y8WLAgvdgJ93JbCvyLxmmmBddxSS8XpW5MoZSCsvC1GLNpVWUVJVDwwJ7Um8S
         0FqQ==
X-Gm-Message-State: AOJu0YzNniOtqTtxFfuvxiiP+T8qDDhuKRQwEtXPPlynpWGpt/UDJBEU
        c0ErzTdzpKZKyGmme6wrWsGO6f7Q3YdY1o8klIkSJ4myVV/pQ84tbzvLSAJBbTsuwszAVMRs6w8
        ba2Sa3xqNMDVghHJwZJwYxGFp
X-Received: by 2002:a17:907:7891:b0:9b9:325f:9be9 with SMTP id ku17-20020a170907789100b009b9325f9be9mr6905137ejc.73.1696618348754;
        Fri, 06 Oct 2023 11:52:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6693S4s/pd1mNyLR7i5gSJ+yywVELtJcWxdgdXWVai6POFCFoxzt5ozN8gK51meBnXnTb8A==
X-Received: by 2002:a17:907:7891:b0:9b9:325f:9be9 with SMTP id ku17-20020a170907789100b009b9325f9be9mr6905129ejc.73.1696618348563;
        Fri, 06 Oct 2023 11:52:28 -0700 (PDT)
Received: from localhost.localdomain ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id os5-20020a170906af6500b009b947f81c4asm3304741ejb.155.2023.10.06.11.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:52:28 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        fsverity@lists.linux.dev
Cc:     djwong@kernel.org, ebiggers@kernel.org, david@fromorbit.com,
        dchinner@redhat.com, Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v3 11/28] iomap: pass readpage operation to read path
Date:   Fri,  6 Oct 2023 20:49:05 +0200
Message-Id: <20231006184922.252188-12-aalbersh@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231006184922.252188-1-aalbersh@redhat.com>
References: <20231006184922.252188-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Preparation for allowing filesystems to provide bio_set and
->submit_io() for read path. This will allow fs to do an additional
processing of ioend on ioend completion.

Make iomap_read_end_io() exportable, so, it can be called back from
filesystem callout after verification is done.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/erofs/data.c        |  4 ++--
 fs/gfs2/aops.c         |  4 ++--
 fs/iomap/buffered-io.c | 13 ++++++++++---
 fs/xfs/xfs_aops.c      |  4 ++--
 fs/zonefs/file.c       |  4 ++--
 include/linux/iomap.h  | 21 +++++++++++++++++++--
 6 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 0c2c99c58b5e..3f5482d6cedb 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -357,12 +357,12 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
  */
 static int erofs_read_folio(struct file *file, struct folio *folio)
 {
-	return iomap_read_folio(folio, &erofs_iomap_ops);
+	return iomap_read_folio(folio, &erofs_iomap_ops, NULL);
 }
 
 static void erofs_readahead(struct readahead_control *rac)
 {
-	return iomap_readahead(rac, &erofs_iomap_ops);
+	return iomap_readahead(rac, &erofs_iomap_ops, NULL);
 }
 
 static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index c26d48355cc2..9c09ff75e586 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -456,7 +456,7 @@ static int gfs2_read_folio(struct file *file, struct folio *folio)
 
 	if (!gfs2_is_jdata(ip) ||
 	    (i_blocksize(inode) == PAGE_SIZE && !folio_buffers(folio))) {
-		error = iomap_read_folio(folio, &gfs2_iomap_ops);
+		error = iomap_read_folio(folio, &gfs2_iomap_ops, NULL);
 	} else if (gfs2_is_stuffed(ip)) {
 		error = stuffed_readpage(ip, &folio->page);
 		folio_unlock(folio);
@@ -534,7 +534,7 @@ static void gfs2_readahead(struct readahead_control *rac)
 	else if (gfs2_is_jdata(ip))
 		mpage_readahead(rac, gfs2_block_map);
 	else
-		iomap_readahead(rac, &gfs2_iomap_ops);
+		iomap_readahead(rac, &gfs2_iomap_ops, NULL);
 }
 
 /**
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 644479ccefbd..ca78c7f62527 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -264,7 +264,7 @@ static void iomap_finish_folio_read(struct folio *folio, size_t offset,
 		folio_unlock(folio);
 }
 
-static void iomap_read_end_io(struct bio *bio)
+void iomap_read_end_io(struct bio *bio)
 {
 	int error = blk_status_to_errno(bio->bi_status);
 	struct folio_iter fi;
@@ -273,12 +273,14 @@ static void iomap_read_end_io(struct bio *bio)
 		iomap_finish_folio_read(fi.folio, fi.offset, fi.length, error);
 	bio_put(bio);
 }
+EXPORT_SYMBOL_GPL(iomap_read_end_io);
 
 struct iomap_readpage_ctx {
 	struct folio		*cur_folio;
 	bool			cur_folio_in_bio;
 	struct bio		*bio;
 	struct readahead_control *rac;
+	const struct iomap_readpage_ops *ops;
 };
 
 /**
@@ -402,7 +404,8 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 	return pos - orig_pos + plen;
 }
 
-int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
+int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops,
+		const struct iomap_readpage_ops *readpage_ops)
 {
 	struct iomap_iter iter = {
 		.inode		= folio->mapping->host,
@@ -411,6 +414,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	};
 	struct iomap_readpage_ctx ctx = {
 		.cur_folio	= folio,
+		.ops		= readpage_ops,
 	};
 	int ret;
 
@@ -468,6 +472,7 @@ static loff_t iomap_readahead_iter(const struct iomap_iter *iter,
  * iomap_readahead - Attempt to read pages from a file.
  * @rac: Describes the pages to be read.
  * @ops: The operations vector for the filesystem.
+ * @readpage_ops: Filesystem supplied folio processiong operation
  *
  * This function is for filesystems to call to implement their readahead
  * address_space operation.
@@ -479,7 +484,8 @@ static loff_t iomap_readahead_iter(const struct iomap_iter *iter,
  * function is called with memalloc_nofs set, so allocations will not cause
  * the filesystem to be reentered.
  */
-void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
+void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops,
+		const struct iomap_readpage_ops *readpage_ops)
 {
 	struct iomap_iter iter = {
 		.inode	= rac->mapping->host,
@@ -488,6 +494,7 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 	};
 	struct iomap_readpage_ctx ctx = {
 		.rac	= rac,
+		.ops	= readpage_ops,
 	};
 
 	trace_iomap_readahead(rac->mapping->host, readahead_count(rac));
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 465d7630bb21..b413a2dbcc18 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -553,14 +553,14 @@ xfs_vm_read_folio(
 	struct file		*unused,
 	struct folio		*folio)
 {
-	return iomap_read_folio(folio, &xfs_read_iomap_ops);
+	return iomap_read_folio(folio, &xfs_read_iomap_ops, NULL);
 }
 
 STATIC void
 xfs_vm_readahead(
 	struct readahead_control	*rac)
 {
-	iomap_readahead(rac, &xfs_read_iomap_ops);
+	iomap_readahead(rac, &xfs_read_iomap_ops, NULL);
 }
 
 static int
diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index b2c9b35df8f7..29428c012150 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -112,12 +112,12 @@ static const struct iomap_ops zonefs_write_iomap_ops = {
 
 static int zonefs_read_folio(struct file *unused, struct folio *folio)
 {
-	return iomap_read_folio(folio, &zonefs_read_iomap_ops);
+	return iomap_read_folio(folio, &zonefs_read_iomap_ops, NULL);
 }
 
 static void zonefs_readahead(struct readahead_control *rac)
 {
-	iomap_readahead(rac, &zonefs_read_iomap_ops);
+	iomap_readahead(rac, &zonefs_read_iomap_ops, NULL);
 }
 
 /*
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 96dd0acbba44..3565c449f3c9 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -262,8 +262,25 @@ int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
 		struct iomap *iomap, loff_t pos, loff_t length, ssize_t written,
 		int (*punch)(struct inode *inode, loff_t pos, loff_t length));
 
-int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops);
-void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
+struct iomap_readpage_ops {
+	/*
+	 * Filesystems wishing to attach private information to a direct io bio
+	 * must provide a ->submit_io method that attaches the additional
+	 * information to the bio and changes the ->bi_end_io callback to a
+	 * custom function.  This function should, at a minimum, perform any
+	 * relevant post-processing of the bio and end with a call to
+	 * iomap_read_end_io.
+	 */
+	void (*submit_io)(const struct iomap_iter *iter, struct bio *bio,
+			loff_t file_offset);
+	struct bio_set *bio_set;
+};
+
+void iomap_read_end_io(struct bio *bio);
+int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops,
+		const struct iomap_readpage_ops *readpage_ops);
+void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops,
+		const struct iomap_readpage_ops *readpage_ops);
 bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
 struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos, size_t len);
 bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
-- 
2.40.1

