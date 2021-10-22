Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCDE6437F38
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 22:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbhJVUSD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 16:18:03 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57146 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbhJVUR6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:17:58 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A9DFF1FD63;
        Fri, 22 Oct 2021 20:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634933739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MpD9AU6mFSzq/UrIZ82eenxsvTEJbrN/1mPlrY2rh/o=;
        b=wrtAC4psBbwmYIMYvx1KS+FlcizjWTjwKYKVbTJvzeqf7XYWynoKzAIMiuVtNK7rmFc/cU
        PZzP570F3JHE31T5Vu5W7OCzLnbN55RekCnVZ5ErXfsg84luommP4BFUyMj6t1b7J7/SDK
        blATlEsId/0Tq+9apJkjmySutYFJHQ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634933739;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MpD9AU6mFSzq/UrIZ82eenxsvTEJbrN/1mPlrY2rh/o=;
        b=M9qe3dwXjS2cOYG+Lgk4sNlJ28rvx5KOAYOYqUsUpBfZaqDvNyTBwlk2EVSRhz3YOxc4Zn
        IRMuCEZP3X3Cw+CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4FF7E1348D;
        Fri, 22 Oct 2021 20:15:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JLWzCesbc2ECdwAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Fri, 22 Oct 2021 20:15:39 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [RFC PATCH 5/5] btrfs: function to convert file offset to device offset
Date:   Fri, 22 Oct 2021 15:15:05 -0500
Message-Id: <2be14d6e2e1e888f2a0f1f272c1fd6cc0b681e97.1634933122.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1634933121.git.rgoldwyn@suse.com>
References: <cover.1634933121.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

btrfs_file_to_device_offset() converts a file offset to device offset.
It also calculates the last_index which represents the last page in the
range which is within the extent.

btrfs_file_to_device_offset() is only passed conditionally based on if
BTRFS_SHAREDEXT is set in the mount flag.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/file.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index e171d822a05e..f0b97d020575 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3643,18 +3643,56 @@ static ssize_t btrfs_direct_read(struct kiocb *iocb, struct iov_iter *to)
 	return ret;
 }
 
+static pgoff_t btrfs_file_offset_to_device(struct file *filp, loff_t pos,
+		size_t len, pgoff_t *last_index)
+{
+	struct extent_map *em;
+	struct btrfs_inode *inode = BTRFS_I(file_inode(filp));
+	u64 device_offset;
+	u64 device_len;
+
+	if (inode->flags & BTRFS_INODE_NODATACOW)
+		return 0;
+
+	em = btrfs_get_extent(inode, NULL, 0, pos, len);
+
+	device_offset = em->block_start;
+	if (device_offset == EXTENT_MAP_HOLE) {
+		free_extent_map(em);
+		return 0;
+	}
+
+	/* Delalloc should be in file's pagecache */
+	BUG_ON(device_offset == EXTENT_MAP_DELALLOC);
+
+	device_offset = (device_offset + (pos - em->start)) >> PAGE_SHIFT;
+	device_len = (em->len - (pos - em->start)) >> PAGE_SHIFT;
+	*last_index = device_offset + device_len;
+
+	free_extent_map(em);
+
+	return device_offset;
+}
+
 static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	ssize_t ret = 0;
+	struct inode *inode = file_inode(iocb->ki_filp);
+	struct btrfs_fs_info *fs_info;
+	file_offset_to_device_t file_offset_to_device = NULL;
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		ret = btrfs_direct_read(iocb, to);
 		if (ret < 0 || !iov_iter_count(to) ||
-		    iocb->ki_pos >= i_size_read(file_inode(iocb->ki_filp)))
+		    iocb->ki_pos >= i_size_read(inode))
 			return ret;
 	}
 
-	return filemap_read(iocb, to, ret, NULL);
+	fs_info = btrfs_sb(inode->i_sb);
+	if (btrfs_test_opt(fs_info, SHAREDEXT))
+		file_offset_to_device = btrfs_file_offset_to_device;
+
+	return filemap_read(iocb, to, ret, file_offset_to_device);
 }
 
 const struct file_operations btrfs_file_operations = {
-- 
2.33.1

