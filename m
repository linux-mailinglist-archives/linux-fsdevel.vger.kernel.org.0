Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6843E9E0E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 07:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbhHLFqq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 01:46:46 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:47215 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231287AbhHLFqp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 01:46:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UilC9jt_1628747179;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UilC9jt_1628747179)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 Aug 2021 13:46:19 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, virtio-fs@redhat.com,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com
Subject: [PATCH 1/2] fuse: disable atomic_o_trunc if no_open is enabled
Date:   Thu, 12 Aug 2021 13:46:17 +0800
Message-Id: <20210812054618.26057-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210812054618.26057-1-jefflexu@linux.alibaba.com>
References: <20210812054618.26057-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Liu Bo <bo.liu@linux.alibaba.com>

When 'no_open' is used by virtiofsd, guest kernel won't send OPEN request
any more.  However, with atomic_o_trunc, SETATTR request is also omitted in
OPEN(O_TRUNC) so that the backend file is not truncated.  With a following
GETATTR, inode size on guest side is updated to be same with that on host
side, the end result is that O_TRUNC semantic is broken.

This disables atomic_o_trunc as well if with no_open.

Reviewed-by: Peng Tao <tao.peng@linux.alibaba.com>
Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/fuse/file.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index b494ff08f08c..1231128f8dd6 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -151,10 +151,16 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 			fuse_file_free(ff);
 			return ERR_PTR(err);
 		} else {
-			if (isdir)
+			if (isdir) {
 				fc->no_opendir = 1;
-			else
+			} else {
 				fc->no_open = 1;
+				/*
+				 * In case of no_open, disable atomic_o_trunc as
+				 * well.
+				 */
+				fc->atomic_o_trunc = 0;
+			}
 		}
 	}
 
-- 
2.27.0

