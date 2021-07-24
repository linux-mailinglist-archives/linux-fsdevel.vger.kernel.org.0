Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFFF43D498F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jul 2021 21:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhGXSys (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Jul 2021 14:54:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47356 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229697AbhGXSym (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Jul 2021 14:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627155313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cYJC8HOPNnGG8OKQqDa5Qgct6vBxVRTt9QCZJCqCWVk=;
        b=UD+PVAv+fHIqOo5OQRa4ay3RL+5hUXQE8Pm4GnPif5y3pmR8lNm2RromxTq6L0LnvxThhq
        pd56s5sbSpiih8AaCIMt5NnRmIZ7UMeyx0SiyBbGDF2kUyvpwVqEkACAgszw6v0IJsFUap
        uwsZtheA4zpoHbpXIl6xDRI4C9ycFwk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29--_mVQ8voMJiOQpNQOyaVhA-1; Sat, 24 Jul 2021 15:35:12 -0400
X-MC-Unique: -_mVQ8voMJiOQpNQOyaVhA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E4FF801AEB;
        Sat, 24 Jul 2021 19:35:10 +0000 (UTC)
Received: from max.com (unknown [10.40.194.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DCE32669F3;
        Sat, 24 Jul 2021 19:35:06 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        cluster-devel@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v4 4/8] iomap: Fix iomap_dio_rw return value for user copies
Date:   Sat, 24 Jul 2021 21:34:45 +0200
Message-Id: <20210724193449.361667-5-agruenba@redhat.com>
In-Reply-To: <20210724193449.361667-1-agruenba@redhat.com>
References: <20210724193449.361667-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When a user copy fails in one of the helpers of iomap_dio_rw, fail with -EFAULT
instead of returning 0.  This matches what iomap_dio_bio_actor already returns
when it gets an -EFAULT from bio_iov_iter_get_pages.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/iomap/direct-io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 9398b8c31323..cc0b4bc8861b 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -370,7 +370,7 @@ iomap_dio_hole_actor(loff_t length, struct iomap_dio *dio)
 {
 	length = iov_iter_zero(length, dio->submit.iter);
 	dio->size += length;
-	return length;
+	return length ?: -EFAULT;
 }
 
 static loff_t
@@ -397,7 +397,7 @@ iomap_dio_inline_actor(struct inode *inode, loff_t pos, loff_t length,
 		copied = copy_to_iter(iomap->inline_data + pos, length, iter);
 	}
 	dio->size += copied;
-	return copied;
+	return copied ?: -EFAULT;
 }
 
 static loff_t
-- 
2.26.3

