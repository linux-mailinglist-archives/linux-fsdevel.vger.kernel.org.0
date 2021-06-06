Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F6F39D098
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jun 2021 21:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhFFTMo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 15:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhFFTMn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:12:43 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9667FC061766;
        Sun,  6 Jun 2021 12:10:52 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lpyAd-0056Yx-9p; Sun, 06 Jun 2021 19:10:51 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Anton Altaparmakov <anton@tuxera.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [RFC PATCH 03/37] fuse_fill_write_pages(): don't bother with iov_iter_single_seg_count()
Date:   Sun,  6 Jun 2021 19:10:17 +0000
Message-Id: <20210606191051.1216821-3-viro@zeniv.linux.org.uk>
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

another rudiment of fault-in originally having been limited to the
first segment, same as in generic_perform_write() and friends.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/fuse/file.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 09ef2a4d25ed..44bd301fa4fb 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1178,7 +1178,6 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 		if (!tmp) {
 			unlock_page(page);
 			put_page(page);
-			bytes = min(bytes, iov_iter_single_seg_count(ii));
 			goto again;
 		}
 
-- 
2.11.0

