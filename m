Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72DD81FACC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 21:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbfEOT1e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 15:27:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53894 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727578AbfEOT1e (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 15:27:34 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D84653004412;
        Wed, 15 May 2019 19:27:33 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B45E51001DEF;
        Wed, 15 May 2019 19:27:33 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 00FA422548B; Wed, 15 May 2019 15:27:29 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-nvdimm@lists.01.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, swhiteho@redhat.com
Subject: [PATCH v2 23/30] fuse: Define dax address space operations
Date:   Wed, 15 May 2019 15:27:08 -0400
Message-Id: <20190515192715.18000-24-vgoyal@redhat.com>
In-Reply-To: <20190515192715.18000-1-vgoyal@redhat.com>
References: <20190515192715.18000-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 15 May 2019 19:27:33 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is done along the lines of ext4 and xfs. I primarily wanted ->writepages
hook at this time so that I could call into dax_writeback_mapping_range().
This in turn will decide which pfns need to be written back.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/file.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a053bcb9498d..2777355bc245 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2402,6 +2402,17 @@ static int fuse_writepages_fill(struct page *page,
 	return err;
 }
 
+static int fuse_dax_writepages(struct address_space *mapping,
+				struct writeback_control *wbc)
+{
+
+	struct inode *inode = mapping->host;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+
+	return dax_writeback_mapping_range(mapping,
+		NULL, fc->dax_dev, wbc);
+}
+
 static int fuse_writepages(struct address_space *mapping,
 			   struct writeback_control *wbc)
 {
@@ -3707,6 +3718,13 @@ static const struct address_space_operations fuse_file_aops  = {
 	.write_end	= fuse_write_end,
 };
 
+static const struct address_space_operations fuse_dax_file_aops  = {
+	.writepages	= fuse_dax_writepages,
+	.direct_IO	= noop_direct_IO,
+	.set_page_dirty	= noop_set_page_dirty,
+	.invalidatepage	= noop_invalidatepage,
+};
+
 void fuse_init_file_inode(struct inode *inode)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
@@ -3724,5 +3742,6 @@ void fuse_init_file_inode(struct inode *inode)
 
 	if (fc->dax_dev) {
 		inode->i_flags |= S_DAX;
+		inode->i_data.a_ops = &fuse_dax_file_aops;
 	}
 }
-- 
2.20.1

