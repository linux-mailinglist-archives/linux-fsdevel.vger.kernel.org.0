Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E59D36FA24
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2019 09:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfGVHRX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jul 2019 03:17:23 -0400
Received: from relay.sw.ru ([185.231.240.75]:59240 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbfGVHRW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jul 2019 03:17:22 -0400
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.92)
        (envelope-from <vvs@virtuozzo.com>)
        id 1hpSZT-0000FE-Aq; Mon, 22 Jul 2019 10:17:19 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] fuse: cleanup fuse_wait_on_page_writeback
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>
Message-ID: <64e2db3a-cf58-0158-e097-1a504a8bb496@virtuozzo.com>
Date:   Mon, 22 Jul 2019 10:17:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Maxim Patlasov <mpatlasov@virtuozzo.com>
fuse_wait_on_page_writeback() always returns zero and nobody cares.
Let's make it void.

Signed-off-by: Maxim Patlasov <mpatlasov@virtuozzo.com>
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/fuse/file.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 5ae2828beb00..e076c2cf65b0 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -383,12 +383,11 @@ static inline bool fuse_page_is_writeback(struct inode *inode, pgoff_t index)
  * Since fuse doesn't rely on the VM writeback tracking, this has to
  * use some other means.
  */
-static int fuse_wait_on_page_writeback(struct inode *inode, pgoff_t index)
+static void fuse_wait_on_page_writeback(struct inode *inode, pgoff_t index)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
 
 	wait_event(fi->page_waitq, !fuse_page_is_writeback(inode, index));
-	return 0;
 }
 
 /*
-- 
2.17.1

