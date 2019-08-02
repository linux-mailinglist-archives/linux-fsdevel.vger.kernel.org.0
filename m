Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74BB37FF55
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 19:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391609AbfHBRPa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Aug 2019 13:15:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54592 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391600AbfHBRPa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Aug 2019 13:15:30 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A289F30EA18A;
        Fri,  2 Aug 2019 17:15:29 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-230.ams2.redhat.com [10.36.117.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E91E60605;
        Fri,  2 Aug 2019 17:15:28 +0000 (UTC)
From:   "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, Nikolaus@rath.org
Cc:     stefanha@redhat.com, vgoyal@redhat.com, tao.peng@linux.alibaba.com
Subject: [PATCH 1/3] fuse: Add 'setupmapping'
Date:   Fri,  2 Aug 2019 18:15:19 +0100
Message-Id: <20190802171521.21807-2-dgilbert@redhat.com>
In-Reply-To: <20190802171521.21807-1-dgilbert@redhat.com>
References: <20190802171521.21807-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 02 Aug 2019 17:15:29 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

'setupmapping' is a command for use with 'virtiofsd', a fuse-over-virtio
implementation; it may find use in other fuse impelementations as well
in which the kernel does not have access to the address space of the
daemon directly.

A 'setupmapping' operation causes a section of a file to be mapped
into a memory window visible to the kernel.
The offsets in the file and the window are defined by the kernel performing
the operation.

The daemon may reject the request, for reasons including permissions and
limited resources.

When a request perfectly overlaps a previous mapping, the
previous mapping is replaced.  When a mapping partially overlaps a previous
mapping, the previous mapping is split into one or two smaller mappings.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/uapi/linux/fuse.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 2971d29a42e4..fb79d4d0b3a7 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -133,6 +133,7 @@
  *
  *  7.31
  *  - add FUSE_WRITE_KILL_PRIV flag
+ *  - add FUSE_SETUPMAPPING
  */
 
 #ifndef _LINUX_FUSE_H
@@ -422,6 +423,7 @@ enum fuse_opcode {
 	FUSE_RENAME2		= 45,
 	FUSE_LSEEK		= 46,
 	FUSE_COPY_FILE_RANGE	= 47,
+	FUSE_SETUPMAPPING	= 48,
 
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
@@ -845,4 +847,19 @@ struct fuse_copy_file_range_in {
 	uint64_t	flags;
 };
 
+#define FUSE_SETUPMAPPING_FLAG_WRITE	(1ull << 0)
+#define FUSE_SETUPMAPPING_FLAG_READ	(1ull << 1)
+struct fuse_setupmapping_in {
+	/* An already open handle */
+	uint64_t	fh;
+	/* Offset into the file to start the mapping */
+	uint64_t	foffset;
+	/* Length of mapping required */
+	uint64_t	len;
+	/* Flags, FUSE_SETUPMAPPING_FLAG_* */
+	uint64_t	flags;
+	/* Offset in Memory Window */
+	uint64_t	moffset;
+};
+
 #endif /* _LINUX_FUSE_H */
-- 
2.21.0

