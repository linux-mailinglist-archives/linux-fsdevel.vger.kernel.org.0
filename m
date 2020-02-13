Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F09CE15CB1A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2020 20:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgBMTZi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Feb 2020 14:25:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:36188 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728075AbgBMTZi (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Feb 2020 14:25:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 726C0ACE1;
        Thu, 13 Feb 2020 19:25:36 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     hch@infradead.org, darrick.wong@oracle.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH] iomap: return partial I/O count on error in direct I/O
Date:   Thu, 13 Feb 2020 13:25:03 -0600
Message-Id: <20200213192503.17267-1-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

In case of a block device error, iomap code returns 0 as opposed to
the amount of submitted I/O, which may have completed before the
error occurred. Return the count of submitted I/O for correct
accounting.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/iomap/direct-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 23837926c0c5..a980b7b7660f 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -260,7 +260,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 		size_t n;
 		if (dio->error) {
 			iov_iter_revert(dio->submit.iter, copied);
-			copied = ret = 0;
+			ret = 0;
 			goto out;
 		}
 
-- 
2.24.1

