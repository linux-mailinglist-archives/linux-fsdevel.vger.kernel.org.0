Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6E23CCB5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 00:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbhGRWmy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Jul 2021 18:42:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44736 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233645AbhGRWmx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Jul 2021 18:42:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626647994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eIybQ7I3i4b8jsniJfWpWs6xOt2d968vNG/hUFJdVEY=;
        b=hd8HoSeLWbX2R/Ybb5z9UJhNc3vYLxwUCaIvTggq7h1NZLD8CfJ3Nn/8XTFcHzkQOh+vg9
        P2r9Cgw7pqHsyO7CMBWq7mZXuo6opZE+5HMib6wBOs7uru4fXlYyV/I+41d06KrnamfVMK
        ItmG72oKtG90Py0eL4Py9Uleb0FXCB0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-601--qKNU9jBNA2RoKNqILHBwg-1; Sun, 18 Jul 2021 18:39:50 -0400
X-MC-Unique: -qKNU9jBNA2RoKNqILHBwg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E57AB362F9;
        Sun, 18 Jul 2021 22:39:48 +0000 (UTC)
Received: from max.com (unknown [10.40.195.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F96860C0F;
        Sun, 18 Jul 2021 22:39:43 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v2 2/6] iomap: Fix iomap_dio_rw return value for page faults
Date:   Mon, 19 Jul 2021 00:39:28 +0200
Message-Id: <20210718223932.2703330-3-agruenba@redhat.com>
In-Reply-To: <20210718223932.2703330-1-agruenba@redhat.com>
References: <20210718223932.2703330-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When a page fault occurs during a direct I/O, iomap_dio_rw can currently return
0 when a page cannot be accessed.  In that case, -EFAULT should be returned
instead.  (For reads, a return value of 0 indicates the end of file.)  Fix that
by casting the return value of iomap_apply from 0 to -EFAULT: in that position,
we know that we should have been able to read something.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/iomap/direct-io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 9398b8c31323..a87a43ee8278 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -561,6 +561,8 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		ret = iomap_apply(inode, pos, count, iomap_flags, ops, dio,
 				iomap_dio_actor);
 		if (ret <= 0) {
+			if (ret == 0)
+				ret = -EFAULT;
 			/* magic error code to fall back to buffered I/O */
 			if (ret == -ENOTBLK) {
 				wait_for_completion = true;
-- 
2.26.3

