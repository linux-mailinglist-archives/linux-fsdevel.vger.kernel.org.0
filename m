Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93B8294DA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 15:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441714AbgJUNdh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Oct 2020 09:33:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50384 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2410033AbgJUNdg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Oct 2020 09:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603287215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LRRH3/o/stv5fGw1hq7YbL4nSRLwHjrBqVKmzZj0aFg=;
        b=Pdfyzh9CsQhU2xzjZr4QdxFeLEhNjPq5VNJ36KJgwHc5ku84Mw4TUkjpAYRS5Y2TmbUNu9
        3qpggqPgNIl2M3CyOQ36q6aYrNUnaPG6/DRshdtWbwrCT8IIY6VPcI2SpD5Dw7EA7XbMy7
        zYODbOul6Vx9mJK3TaJDJnsuiTzfcFc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-lm8iBuDzOk-JekCkEGSElw-1; Wed, 21 Oct 2020 09:33:31 -0400
X-MC-Unique: lm8iBuDzOk-JekCkEGSElw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AD308799F0;
        Wed, 21 Oct 2020 13:33:30 +0000 (UTC)
Received: from bfoster.redhat.com (ovpn-113-186.rdu2.redhat.com [10.10.113.186])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AADA15D9CA;
        Wed, 21 Oct 2020 13:33:29 +0000 (UTC)
From:   Brian Foster <bfoster@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org
Subject: [PATCH v2] iomap: zero cached page over unwritten extent on truncate page
Date:   Wed, 21 Oct 2020 09:33:29 -0400
Message-Id: <20201021133329.1337689-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

iomap_truncate_page() relies on zero range and zero range
unconditionally skips unwritten mappings. This is normally not a
problem as most users synchronize in-core state to the underlying
block mapping by flushing pagecache prior to calling into iomap.
This is not the case for iomap_truncate_page(), however. XFS calls
iomap_truncate_page() on truncate down before flushing the new EOF
page of the file. This means that if the new EOF block is unwritten
but covered by a dirty or writeback page (i.e. awaiting unwritten
conversion after writeback), iomap fails to zero that page. The
subsequent truncate_setsize() call does perform page zeroing, but
doesn't dirty the page. Therefore if the new EOF page is written
back after calling into iomap but before the pagecache truncate, the
post-EOF zeroing is lost on page reclaim. This exposes stale
post-EOF data on mapped reads.

Rework iomap_truncate_page() to check pagecache state before calling
into iomap_apply() and use that info to determine whether we can
safely skip zeroing unwritten extents. The filesystem has locked out
concurrent I/O and mapped operations at this point but is not
serialized against writeback, unwritten extent conversion (I/O
completion) or page reclaim. Therefore if a page does not exist
before we acquire the mapping, we can be certain that an unwritten
extent cannot be converted before we return and thus it is safe to
skip. If a page does exist over an unwritten block, it could be in
the dirty or writeback states, convert the underlying mapping at any
time, and thus should be explicitly written to avoid racing with
writeback. Finally, since iomap_truncate_page() only targets the new
EOF block and must now pass additional state to the actor, open code
the zeroing actor instead of plumbing through zero range.

This does have the tradeoff that an existing clean page is dirtied
and causes unwritten conversion, but this is analogous to historical
behavior implemented by block_truncate_page(). This patch restores
historical behavior to address the data exposure problem and leaves
filtering out the clean page case for a separate patch.

Fixes: 68a9f5e7007c ("xfs: implement iomap based buffered write path")
Signed-off-by: Brian Foster <bfoster@redhat.com>
---

v2:
- Rework to check for cached page explicitly and avoid use of seek data.
v1: https://lore.kernel.org/linux-fsdevel/20201012140350.950064-1-bfoster@redhat.com/

 fs/iomap/buffered-io.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index bcfc288dba3f..2cdfcff02307 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1000,17 +1000,56 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 }
 EXPORT_SYMBOL_GPL(iomap_zero_range);
 
+struct iomap_trunc_priv {
+	bool *did_zero;
+	bool has_page;
+};
+
+static loff_t
+iomap_truncate_page_actor(struct inode *inode, loff_t pos, loff_t count,
+		void *data, struct iomap *iomap, struct iomap *srcmap)
+{
+	struct iomap_trunc_priv	*priv = data;
+	unsigned offset;
+	int status;
+
+	if (srcmap->type == IOMAP_HOLE)
+		return count;
+	if (srcmap->type == IOMAP_UNWRITTEN && !priv->has_page)
+		return count;
+
+	offset = offset_in_page(pos);
+	if (IS_DAX(inode))
+		status = dax_iomap_zero(pos, offset, count, iomap);
+	else
+		status = iomap_zero(inode, pos, offset, count, iomap, srcmap);
+	if (status < 0)
+		return status;
+
+	if (priv->did_zero)
+		*priv->did_zero = true;
+	return count;
+}
+
 int
 iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
 		const struct iomap_ops *ops)
 {
+	struct iomap_trunc_priv priv = { .did_zero = did_zero };
 	unsigned int blocksize = i_blocksize(inode);
 	unsigned int off = pos & (blocksize - 1);
+	loff_t ret;
 
 	/* Block boundary? Nothing to do */
 	if (!off)
 		return 0;
-	return iomap_zero_range(inode, pos, blocksize - off, did_zero, ops);
+
+	priv.has_page = filemap_range_has_page(inode->i_mapping, pos, pos);
+	ret = iomap_apply(inode, pos, blocksize - off, IOMAP_ZERO, ops, &priv,
+			  iomap_truncate_page_actor);
+	if (ret <= 0)
+		return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(iomap_truncate_page);
 
-- 
2.25.4

