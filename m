Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1EF8375A5F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 May 2021 20:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236513AbhEFSoq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 May 2021 14:44:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39692 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236546AbhEFSo0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 May 2021 14:44:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620326607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2rVW1ibsoIRZVQIC5VoQ0rlFZy8jqgzdYAHFSRq2LyE=;
        b=f/KnPdAfQyxKCxQb2yhIWQSgvH5iHDVOu0KAMFAhjvyViratDT2rakbDl+w+3wrCyLZPuj
        UmCmToU0LaDEfqxLgaxXb+2GYCIZCItZ0f5XLINhNMMim9BJfpfIMjQX1WtA2IGQibgpy0
        AGA/NowAE7jVdvWZxC1LcGwq2c47jYk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-1HwfdGnXNMGgSIe3oqBBqQ-1; Thu, 06 May 2021 14:43:25 -0400
X-MC-Unique: 1HwfdGnXNMGgSIe3oqBBqQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46BFD80059E;
        Thu,  6 May 2021 18:43:24 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-166.rdu2.redhat.com [10.10.114.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA7DF5C1A1;
        Thu,  6 May 2021 18:43:19 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 49B74223D99; Thu,  6 May 2021 14:43:19 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        miklos@szeredi.hu
Cc:     vgoyal@redhat.com, dgilbert@redhat.com,
        linux-kernel@vger.kernel.org, dan.carpenter@oracle.com
Subject: [PATCH 1/2] virtiofs, dax: Fix smatch warning about loss of info during shift
Date:   Thu,  6 May 2021 14:43:03 -0400
Message-Id: <20210506184304.321645-2-vgoyal@redhat.com>
In-Reply-To: <20210506184304.321645-1-vgoyal@redhat.com>
References: <20210506184304.321645-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dan reported a smatch warning during potentential loss of info during
left shift if this code is compiled on 32bit systems.

New smatch warnings:
fs/fuse/dax.c:113 fuse_setup_one_mapping() warn: should 'start_idx << 21' be a
+64 bit type?

I ran smatch and found two more instances of similar warning. This patch
fixes all such instances.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/dax.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index ff99ab2a3c43..f06fdad3f7b1 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -186,7 +186,7 @@ static int fuse_setup_one_mapping(struct inode *inode, unsigned long start_idx,
 	struct fuse_conn_dax *fcd = fm->fc->dax;
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_setupmapping_in inarg;
-	loff_t offset = start_idx << FUSE_DAX_SHIFT;
+	loff_t offset = (loff_t)start_idx << FUSE_DAX_SHIFT;
 	FUSE_ARGS(args);
 	ssize_t err;
 
@@ -872,7 +872,7 @@ static int dmap_writeback_invalidate(struct inode *inode,
 				     struct fuse_dax_mapping *dmap)
 {
 	int ret;
-	loff_t start_pos = dmap->itn.start << FUSE_DAX_SHIFT;
+	loff_t start_pos = (loff_t)dmap->itn.start << FUSE_DAX_SHIFT;
 	loff_t end_pos = (start_pos + FUSE_DAX_SZ - 1);
 
 	ret = filemap_fdatawrite_range(inode->i_mapping, start_pos, end_pos);
@@ -966,7 +966,7 @@ inode_inline_reclaim_one_dmap(struct fuse_conn_dax *fcd, struct inode *inode,
 	dmap = inode_lookup_first_dmap(inode);
 	if (dmap) {
 		start_idx = dmap->itn.start;
-		dmap_start = start_idx << FUSE_DAX_SHIFT;
+		dmap_start = (u64)start_idx << FUSE_DAX_SHIFT;
 		dmap_end = dmap_start + FUSE_DAX_SZ - 1;
 	}
 	up_read(&fi->dax->sem);
@@ -1118,7 +1118,7 @@ static int lookup_and_reclaim_dmap(struct fuse_conn_dax *fcd,
 {
 	int ret;
 	struct fuse_inode *fi = get_fuse_inode(inode);
-	loff_t dmap_start = start_idx << FUSE_DAX_SHIFT;
+	loff_t dmap_start = (loff_t)start_idx << FUSE_DAX_SHIFT;
 	loff_t dmap_end = (dmap_start + FUSE_DAX_SZ) - 1;
 
 	down_write(&fi->i_mmap_sem);
-- 
2.25.4

