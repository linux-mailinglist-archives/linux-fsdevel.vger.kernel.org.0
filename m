Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8514AE9FC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 07:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbiBIGFX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 01:05:23 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236072AbiBIGB4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 01:01:56 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71709C05CBA6;
        Tue,  8 Feb 2022 22:01:59 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0V3zaQVI_1644386495;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0V3zaQVI_1644386495)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 09 Feb 2022 14:01:35 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3 20/22] erofs: implement fscache-based data readahead for non-inline layout
Date:   Wed,  9 Feb 2022 14:01:06 +0800
Message-Id: <20220209060108.43051-21-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220209060108.43051-1-jefflexu@linux.alibaba.com>
References: <20220209060108.43051-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index c8a0851230e5..ef5eef33e3d5 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -197,6 +197,7 @@ static int erofs_fscache_readpage(struct file *file, struct page *page)
 
 enum erofs_fscache_readahead_type {
 	EROFS_FSCACHE_READAHEAD_TYPE_HOLE,
+	EROFS_FSCACHE_READAHEAD_TYPE_NOINLINE,
 };
 
 static int erofs_fscache_do_readahead(struct readahead_control *rac,
@@ -205,10 +206,14 @@ static int erofs_fscache_do_readahead(struct readahead_control *rac,
 {
 	size_t offset, length, done;
 	struct page *page;
+	int ret = 0;
 
 	/*
-	 * 1) For CHUNK_BASED (HOLE), the output map.m_la is rounded down to
-	 *    the nearest chunk boundary, and thus offset will be non-zero.
+	 * 1) For CHUNK_BASED (HOLE/NOINLINE), the output map.m_la is rounded
+	 *    down to the nearest chunk boundary, and thus offset will be
+	 *    non-zero.
+	 * 2) For the other cases, the output map.m_la shall be equal to o_la,
+	 *    and thus offset will be zero.
 	 */
 	offset = fsmap->o_la - fsmap->m_la;
 	length = fsmap->m_llen - offset;
@@ -222,11 +227,18 @@ static int erofs_fscache_do_readahead(struct readahead_control *rac,
 		case EROFS_FSCACHE_READAHEAD_TYPE_HOLE:
 			zero_user(page, 0, PAGE_SIZE);
 			break;
+		case EROFS_FSCACHE_READAHEAD_TYPE_NOINLINE:
+			ret = erofs_fscache_readpage_noinline(page, fsmap);
+			fsmap->m_pa += EROFS_BLKSIZ;
+			break;
 		default:
 			DBG_BUGON(1);
 			return -EINVAL;
 		}
 
+		if (ret)
+			return ret;
+
 		SetPageUptodate(page);
 		unlock_page(page);
 	}
@@ -263,7 +275,16 @@ static void erofs_fscache_readahead(struct readahead_control *rac)
 			ret = erofs_fscache_do_readahead(rac, &fsmap,
 					EROFS_FSCACHE_READAHEAD_TYPE_HOLE);
 		} else {
+			ret = erofs_fscache_get_map(&fsmap, &map, sb);
+			if (ret)
+				return;
+
 			switch (vi->datalayout) {
+			case EROFS_INODE_FLAT_PLAIN:
+			case EROFS_INODE_CHUNK_BASED:
+				ret = erofs_fscache_do_readahead(rac, &fsmap,
+					EROFS_FSCACHE_READAHEAD_TYPE_NOINLINE);
+				break;
 			default:
 				DBG_BUGON(1);
 				return;
-- 
2.27.0

