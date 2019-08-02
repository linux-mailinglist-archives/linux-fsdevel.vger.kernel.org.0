Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7BB7FF56
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 19:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391613AbfHBRPc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 13:15:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391600AbfHBRPb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 13:15:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 550AF307D848;
        Fri,  2 Aug 2019 17:15:31 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-230.ams2.redhat.com [10.36.117.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ECF0860623;
        Fri,  2 Aug 2019 17:15:29 +0000 (UTC)
From:   "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, Nikolaus@rath.org
Cc:     stefanha@redhat.com, vgoyal@redhat.com, tao.peng@linux.alibaba.com
Subject: [PATCH 2/3] fuse: add 'removemapping'
Date:   Fri,  2 Aug 2019 18:15:20 +0100
Message-Id: <20190802171521.21807-3-dgilbert@redhat.com>
In-Reply-To: <20190802171521.21807-1-dgilbert@redhat.com>
References: <20190802171521.21807-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 02 Aug 2019 17:15:31 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

'removemapping' is the complement to 'setupmapping', it unmaps
a range of mapped files from the window visible to the kernel.

A 'removemapping' call consists of 'count' regions to unmap,
each consisting of an offset and length.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Peng Tao <tao.peng@linux.alibaba.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/uapi/linux/fuse.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index fb79d4d0b3a7..f14eeb5cfc14 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -133,7 +133,7 @@
  *
  *  7.31
  *  - add FUSE_WRITE_KILL_PRIV flag
- *  - add FUSE_SETUPMAPPING
+ *  - add FUSE_SETUPMAPPING and FUSE_REMOVEMAPPING
  */
 
 #ifndef _LINUX_FUSE_H
@@ -424,6 +424,7 @@ enum fuse_opcode {
 	FUSE_LSEEK		= 46,
 	FUSE_COPY_FILE_RANGE	= 47,
 	FUSE_SETUPMAPPING	= 48,
+	FUSE_REMOVEMAPPING	= 49,
 
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
@@ -862,4 +863,16 @@ struct fuse_setupmapping_in {
 	uint64_t	moffset;
 };
 
+struct fuse_removemapping_in {
+	/* number of fuse_removemapping_one following */
+	uint32_t	count;
+};
+
+struct fuse_removemapping_one {
+	/* Offset into the dax window at start of unmapping */
+	uint64_t	moffset;
+	/* Length of unmapping required */
+	uint64_t	len;
+};
+
 #endif /* _LINUX_FUSE_H */
-- 
2.21.0

