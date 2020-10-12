Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79BE28B9DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Oct 2020 16:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390923AbgJLOEW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Oct 2020 10:04:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38708 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403775AbgJLODz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Oct 2020 10:03:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602511434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pzsvx7UXT6aMAjxWW6vN5RJBkTTB9fPQ/VOY1YyM6DY=;
        b=N3Eji2kwaKMEgtbDL57r1c+fddABUabX+Evs775H5Hslg8SdsXdKLncKM8cDCCWH6fF78U
        nSn2Vk8p6hTiUyC1ku+Q743vWIqvlDR2i+AlEN4HP81/4Ehi+eRxFe108qFeVtUONzubc5
        H/3hYJX6ICcMDKjeIB5TOyTexmnJbPg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-7C6Z62cfPfaSZTTQYsppNw-1; Mon, 12 Oct 2020 10:03:52 -0400
X-MC-Unique: 7C6Z62cfPfaSZTTQYsppNw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FED0802B4B;
        Mon, 12 Oct 2020 14:03:51 +0000 (UTC)
Received: from bfoster.redhat.com (ovpn-112-249.rdu2.redhat.com [10.10.112.249])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 37D4260C07;
        Mon, 12 Oct 2020 14:03:51 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org
Subject: [PATCH 1/2] iomap: use page dirty state to seek data over unwritten extents
Date:   Mon, 12 Oct 2020 10:03:49 -0400
Message-Id: <20201012140350.950064-2-bfoster@redhat.com>
In-Reply-To: <20201012140350.950064-1-bfoster@redhat.com>
References: <20201012140350.950064-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

iomap seek hole/data currently uses page Uptodate state to track
data over unwritten extents. This is odd and unpredictable in that
the existence of clean pages changes behavior. For example:

  $ xfs_io -fc "falloc 0 32k" -c "seek -d 0" \
	    -c "pread 16k 4k" -c "seek -d 0" /mnt/file
  Whence  Result
  DATA    EOF
  ...
  Whence  Result
  DATA    16384

Instead, use page dirty state to locate data over unwritten extents.
This causes seek data to land on the first uptodate block of a dirty
page since we don't have per-block dirty state in iomap. This is
consistent with writeback, however, which converts all uptodate
blocks of a dirty page for similar reasons.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---
 fs/iomap/seek.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/seek.c b/fs/iomap/seek.c
index 107ee80c3568..981a74c8d60f 100644
--- a/fs/iomap/seek.c
+++ b/fs/iomap/seek.c
@@ -40,7 +40,7 @@ page_seek_hole_data(struct inode *inode, struct page *page, loff_t *lastoff,
 	 * Just check the page unless we can and should check block ranges:
 	 */
 	if (bsize == PAGE_SIZE || !ops->is_partially_uptodate)
-		return PageUptodate(page) == seek_data;
+		return PageDirty(page) == seek_data;
 
 	lock_page(page);
 	if (unlikely(page->mapping != inode->i_mapping))
@@ -49,7 +49,8 @@ page_seek_hole_data(struct inode *inode, struct page *page, loff_t *lastoff,
 	for (off = 0; off < PAGE_SIZE; off += bsize) {
 		if (offset_in_page(*lastoff) >= off + bsize)
 			continue;
-		if (ops->is_partially_uptodate(page, off, bsize) == seek_data) {
+		if ((ops->is_partially_uptodate(page, off, bsize) &&
+		     PageDirty(page)) == seek_data) {
 			unlock_page(page);
 			return true;
 		}
-- 
2.25.4

