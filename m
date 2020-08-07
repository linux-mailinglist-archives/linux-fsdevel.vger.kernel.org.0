Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F99B23F34E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 21:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgHGT4U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 15:56:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53020 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726985AbgHGTz4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 15:55:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596830155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qdlNr90CBeIrDZm/k8M3WSYgAxr0kUHBQSfXY3HBR3M=;
        b=OEtcWCE8O5fZ4rbGITleBlsU0WLxb7Ef7hxXcd01DHmtitoBa3RrwXzJ2bSNVOSz8WIaAE
        NlVvekfuoTCWwJJjrf+rsMOUKqg4bk51ghjCsDLtUr1lYF4hBcP6eWW058k/9+i7ek5DNs
        bTG07R6oi+v53wt4Nr0zM8gLhCGCv0g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-fTI0CLrNPD-IHN_fsiNHLQ-1; Fri, 07 Aug 2020 15:55:53 -0400
X-MC-Unique: fTI0CLrNPD-IHN_fsiNHLQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8351A1005510;
        Fri,  7 Aug 2020 19:55:52 +0000 (UTC)
Received: from horse.redhat.com (ovpn-113-142.rdu2.redhat.com [10.10.113.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 60A975C1D0;
        Fri,  7 Aug 2020 19:55:52 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 19357222E5E; Fri,  7 Aug 2020 15:55:39 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com
Subject: [PATCH v2 16/20] fuse,virtiofs: Define dax address space operations
Date:   Fri,  7 Aug 2020 15:55:22 -0400
Message-Id: <20200807195526.426056-17-vgoyal@redhat.com>
In-Reply-To: <20200807195526.426056-1-vgoyal@redhat.com>
References: <20200807195526.426056-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is done along the lines of ext4 and xfs. I primarily wanted ->writepages
hook at this time so that I could call into dax_writeback_mapping_range().
This in turn will decide which pfns need to be written back.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/file.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 00ad27216cc3..54708cb24da0 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2669,6 +2669,16 @@ static int fuse_writepages_fill(struct page *page,
 	return err;
 }
 
+static int fuse_dax_writepages(struct address_space *mapping,
+				struct writeback_control *wbc)
+{
+
+	struct inode *inode = mapping->host;
+	struct fuse_conn *fc = get_fuse_conn(inode);
+
+	return dax_writeback_mapping_range(mapping, fc->dax_dev, wbc);
+}
+
 static int fuse_writepages(struct address_space *mapping,
 			   struct writeback_control *wbc)
 {
@@ -4030,6 +4040,13 @@ static const struct address_space_operations fuse_file_aops  = {
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
@@ -4045,6 +4062,8 @@ void fuse_init_file_inode(struct inode *inode)
 	fi->writepages = RB_ROOT;
 	fi->dmap_tree = RB_ROOT_CACHED;
 
-	if (fc->dax_dev)
+	if (fc->dax_dev) {
 		inode->i_flags |= S_DAX;
+		inode->i_data.a_ops = &fuse_dax_file_aops;
+	}
 }
-- 
2.25.4

