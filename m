Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20A23F20CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 21:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbhHSTmV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Aug 2021 15:42:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53203 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234893AbhHSTmP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Aug 2021 15:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629402098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hSS15ajp7yjVj1XeNBbLODAMJtXekv1X+I9IyWo/qGc=;
        b=RIs4uOMKawuxvi06y28BkaD+mDgBERqOSMLPeed22AoYUNlLOagTV5LmttiwBfye2UCR2C
        a7hGjUN5jTjA66HUf/dFTG8SIAimKgQnQ/x5S2anOgmZscS+NBwZk8VAj3685JWnVGWMhi
        YS1/aDHZzW/jPXMPMMvFWJ1rXhGNEsc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-VnZYh0QvPpyI0VNUKiv4JA-1; Thu, 19 Aug 2021 15:41:35 -0400
X-MC-Unique: VnZYh0QvPpyI0VNUKiv4JA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF10687D541;
        Thu, 19 Aug 2021 19:41:33 +0000 (UTC)
Received: from max.com (unknown [10.40.194.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 543C61B46B;
        Thu, 19 Aug 2021 19:41:31 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v6 06/19] gfs2: Add wrapper for iomap_file_buffered_write
Date:   Thu, 19 Aug 2021 21:40:49 +0200
Message-Id: <20210819194102.1491495-7-agruenba@redhat.com>
In-Reply-To: <20210819194102.1491495-1-agruenba@redhat.com>
References: <20210819194102.1491495-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a wrapper around iomap_file_buffered_write.  We'll add code for when
the operation needs to be retried here later.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/file.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 84ec053d43b4..55ec1cadc9e6 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -876,6 +876,18 @@ static ssize_t gfs2_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	return written ? written : ret;
 }
 
+static ssize_t gfs2_file_buffered_write(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file_inode(file);
+	ssize_t ret;
+
+	current->backing_dev_info = inode_to_bdi(inode);
+	ret = iomap_file_buffered_write(iocb, from, &gfs2_iomap_ops);
+	current->backing_dev_info = NULL;
+	return ret;
+}
+
 /**
  * gfs2_file_write_iter - Perform a write to a file
  * @iocb: The io context
@@ -927,9 +939,7 @@ static ssize_t gfs2_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			goto out_unlock;
 
 		iocb->ki_flags |= IOCB_DSYNC;
-		current->backing_dev_info = inode_to_bdi(inode);
-		buffered = iomap_file_buffered_write(iocb, from, &gfs2_iomap_ops);
-		current->backing_dev_info = NULL;
+		buffered = gfs2_file_buffered_write(iocb, from);
 		if (unlikely(buffered <= 0)) {
 			if (!ret)
 				ret = buffered;
@@ -951,9 +961,7 @@ static ssize_t gfs2_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		if (!ret || ret2 > 0)
 			ret += ret2;
 	} else {
-		current->backing_dev_info = inode_to_bdi(inode);
-		ret = iomap_file_buffered_write(iocb, from, &gfs2_iomap_ops);
-		current->backing_dev_info = NULL;
+		ret = gfs2_file_buffered_write(iocb, from);
 		if (likely(ret > 0)) {
 			iocb->ki_pos += ret;
 			ret = generic_write_sync(iocb, ret);
-- 
2.26.3

