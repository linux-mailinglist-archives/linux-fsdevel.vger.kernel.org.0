Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367FB39D0AC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jun 2021 21:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhFFTNA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 15:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbhFFTMp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:12:45 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05890C061789;
        Sun,  6 Jun 2021 12:10:55 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lpyAf-0056ak-VR; Sun, 06 Jun 2021 19:10:54 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC PATCH 19/37] [xarray] iov_iter_npages(): just use DIV_ROUND_UP()
Date:   Sun,  6 Jun 2021 19:10:33 +0000
Message-Id: <20210606191051.1216821-19-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210606191051.1216821-1-viro@zeniv.linux.org.uk>
References: <YL0dCEVEiVL+NwG6@zeniv-ca.linux.org.uk>
 <20210606191051.1216821-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Compiler is capable of recognizing division by power of 2 and turning
it into shifts.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 lib/iov_iter.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 04c81481d309..6a968d2ff081 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1938,20 +1938,8 @@ int iov_iter_npages(const struct iov_iter *i, int maxpages)
 		return min(npages, maxpages);
 	}
 	if (iov_iter_is_xarray(i)) {
-		size_t size = i->count;
-		unsigned offset;
-		int npages;
-
-		offset = (i->xarray_start + i->iov_offset) & ~PAGE_MASK;
-
-		npages = 1;
-		if (size > PAGE_SIZE - offset) {
-			size -= PAGE_SIZE - offset;
-			npages += size >> PAGE_SHIFT;
-			size &= ~PAGE_MASK;
-			if (size)
-				npages++;
-		}
+		unsigned offset = (i->xarray_start + i->iov_offset) % PAGE_SIZE;
+		int npages = DIV_ROUND_UP(offset + i->count, PAGE_SIZE);
 		return min(npages, maxpages);
 	}
 	return 0;
-- 
2.11.0

