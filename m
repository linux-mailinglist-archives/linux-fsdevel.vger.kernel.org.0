Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD5617FF57
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 19:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391628AbfHBRPf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 13:15:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:22292 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391600AbfHBRPd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 13:15:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 016BB307D851;
        Fri,  2 Aug 2019 17:15:33 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-230.ams2.redhat.com [10.36.117.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9C67760623;
        Fri,  2 Aug 2019 17:15:31 +0000 (UTC)
From:   "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, Nikolaus@rath.org
Cc:     stefanha@redhat.com, vgoyal@redhat.com, tao.peng@linux.alibaba.com
Subject: [PATCH 3/3] fuse: Add map_alignment for setup/remove mapping
Date:   Fri,  2 Aug 2019 18:15:21 +0100
Message-Id: <20190802171521.21807-4-dgilbert@redhat.com>
In-Reply-To: <20190802171521.21807-1-dgilbert@redhat.com>
References: <20190802171521.21807-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 02 Aug 2019 17:15:33 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This new FUSE_INIT field communicates the alignment constraint for
FUSE_SETUPMAPPING/FUSE_REMOVEMAPPING and allows the daemon to
constrain the addresses and file offsets chosen by the kernel.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/uapi/linux/fuse.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index f14eeb5cfc14..65c2136d112e 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -134,6 +134,7 @@
  *  7.31
  *  - add FUSE_WRITE_KILL_PRIV flag
  *  - add FUSE_SETUPMAPPING and FUSE_REMOVEMAPPING
+ *  - add map_alignment to fuse_init_out
  */
 
 #ifndef _LINUX_FUSE_H
@@ -275,6 +276,9 @@ struct fuse_file_lock {
  * FUSE_CACHE_SYMLINKS: cache READLINK responses
  * FUSE_NO_OPENDIR_SUPPORT: kernel supports zero-message opendir
  * FUSE_EXPLICIT_INVAL_DATA: only invalidate cached pages on explicit request
+ * FUSE_MAP_ALIGNMENT: init_out.map_alignment contains log2(byte alignment) for
+ *                     foffset and moffset fields in struct
+ *                     fuse_setupmapping_in and fuse_removemapping_one.
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -302,6 +306,8 @@ struct fuse_file_lock {
 #define FUSE_CACHE_SYMLINKS	(1 << 23)
 #define FUSE_NO_OPENDIR_SUPPORT (1 << 24)
 #define FUSE_EXPLICIT_INVAL_DATA (1 << 25)
+#define FUSE_MAP_ALIGNMENT	(1 << 26)
+
 
 /**
  * CUSE INIT request/reply flags
@@ -655,7 +661,7 @@ struct fuse_init_out {
 	uint32_t	max_write;
 	uint32_t	time_gran;
 	uint16_t	max_pages;
-	uint16_t	padding;
+	uint16_t	map_alignment;
 	uint32_t	unused[8];
 };
 
-- 
2.21.0

