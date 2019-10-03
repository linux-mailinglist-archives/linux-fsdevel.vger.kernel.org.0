Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFA07C9D6E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2019 13:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbfJCLeo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Oct 2019 07:34:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44175 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730018AbfJCLen (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Oct 2019 07:34:43 -0400
Received: by mail-pf1-f196.google.com with SMTP id q21so1558949pfn.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Oct 2019 04:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UQEtX9xV6QoOzwhI4K3Zgq+aHHgBiMKDDNW6NF4ZZlk=;
        b=2LZ/1FWaO6D10wZiz7AhibWPbArsNFJpckQ4crRa3K8GtxkC6HX9CjMqS9JyEaevi3
         F5HUKnxZXdoH64ed9aerLacCs5A66EqTe7n1HOicmg57rrRhWRxkBK6W2t5xOJMxgl49
         Jg7aJUzVjY22AvD1n+/AsO/dDpBClGO6MAnuyI118JFEDlV94W4UQ1yZqJ8GpXBWqrYa
         qqszhi7qW1SMXj5XNxpbZDyUOcr3FEp7oIW90c0Waz/HOSo3IBsL4dDwbc1zXUU1amme
         UY3o0hPvqTy8sYyur1avU7opnN/u5CAEGJIeZVsZIKNaiQL2H4tOObIvcwxcaf+YmSiJ
         USAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UQEtX9xV6QoOzwhI4K3Zgq+aHHgBiMKDDNW6NF4ZZlk=;
        b=RiPA6Hpt3tIGT4mqvOyhsuegl7J7dtFgVoDO0gn1LMpQoiYlszIt1SkwfiBK8H2eDv
         ZCLR8fscR1kVuRVEADd1q4uiOcSeGLMZTXpyTwS55SoHmv1rV2HBCQWQaQwM6y7fCC9q
         FfRcY8zBLiTl+CU1M9/xF7dnh5e/VxnhStE6sK4ZAWOFXf7OJX98Cg1R2/LU4QoXLFVO
         PwiPGx9h20MPZEhOw0SRX6uSt624wZ8WNnbQ7H4jxDFP6vCzJTDNXR2ntaoMfQh3afqB
         olKtsyI23H3RvgOzI3pckADiJWhESOsk+L7X2W3dwN1RTxQvEaZEJflh+sZ3vj/VEYc3
         Ml3w==
X-Gm-Message-State: APjAAAV1qJbOkW+xdxJ+ABYTH9ev6S9vRAydEKJmQOoltuWywlFWJ3DX
        q549TcE7IBHcXXzYTw96TMBF
X-Google-Smtp-Source: APXvYqz/1fcWZvv4TSLLTLnXTVXqIBvxzhIGqqPB45sdpVged+0rtncMRkZ5AleKzndce8KcbFzbYg==
X-Received: by 2002:a63:154d:: with SMTP id 13mr9244083pgv.163.1570102483111;
        Thu, 03 Oct 2019 04:34:43 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id d20sm4781328pfq.88.2019.10.03.04.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 04:34:42 -0700 (PDT)
Date:   Thu, 3 Oct 2019 21:34:36 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: [PATCH v4 6/8] ext4: move inode extension checks out from
 ext4_iomap_alloc()
Message-ID: <d1ca9cc472175760ef629fb66a88f0c9b0625052.1570100361.git.mbobrowski@mbobrowski.org>
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1570100361.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We lift the inode extension/orphan list handling logic out from
ext4_iomap_alloc() and place it within the caller
ext4_dax_write_iter().

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
---
 fs/ext4/file.c  | 17 +++++++++++++++++
 fs/ext4/inode.c | 22 ----------------------
 2 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 2883711e8a33..f64da0c590b2 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -309,6 +309,7 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	ssize_t ret;
 	size_t count;
 	loff_t offset;
+	handle_t *handle;
 	struct inode *inode = file_inode(iocb->ki_filp);
 
 	if (!inode_trylock(inode)) {
@@ -328,6 +329,22 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	offset = iocb->ki_pos;
 	count = iov_iter_count(from);
+
+	if (offset + count > EXT4_I(inode)->i_disksize) {
+		handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
+		if (IS_ERR(handle)) {
+			ret = PTR_ERR(handle);
+			goto out;
+		}
+
+		ret = ext4_orphan_add(handle, inode);
+		if (ret) {
+			ext4_journal_stop(handle);
+			goto out;
+		}
+		ext4_journal_stop(handle);
+	}
+
 	ret = dax_iomap_rw(iocb, from, &ext4_iomap_ops);
 
 	error = ext4_handle_inode_extension(inode, offset, ret, count);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d616062b603e..e133dda55063 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3508,7 +3508,6 @@ static int ext4_iomap_alloc(struct inode *inode,
 			    struct ext4_map_blocks *map)
 {
 	handle_t *handle;
-	u8 blkbits = inode->i_blkbits;
 	int ret, dio_credits, retries = 0;
 
 	/*
@@ -3530,28 +3529,7 @@ static int ext4_iomap_alloc(struct inode *inode,
 		return PTR_ERR(handle);
 
 	ret = ext4_map_blocks(handle, inode, map, EXT4_GET_BLOCKS_CREATE_ZERO);
-	if (ret < 0)
-		goto journal_stop;
 
-	/*
-	 * If we have allocated blocks beyond the EOF, we need to make
-	 * sure that they get truncate if we crash before updating the
-	 * inode size metadata in ext4_iomap_end(). For faults, we
-	 * don't need to do that (and cannot due to the orphan list
-	 * operations needing an inode_lock()). If we happen to
-	 * instantiate blocks beyond EOF, it is because we race with a
-	 * truncate operation, which already has added the inode onto
-	 * the orphan list.
-	 */
-	if (!(flags & IOMAP_FAULT) && first_block + map->m_len >
-	    (i_size_read(inode) + (1 << blkbits) - 1) >> blkbits) {
-		int err;
-
-		err = ext4_orphan_add(handle, inode);
-		if (err < 0)
-			ret = err;
-	}
-journal_stop:
 	ext4_journal_stop(handle);
 	if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
 		goto retry;
-- 
2.20.1

