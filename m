Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05DBB9821D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 19:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbfHUR7D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 13:59:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38972 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729766AbfHUR5i (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 13:57:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B8E92A2F6B6;
        Wed, 21 Aug 2019 17:57:38 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 914E617D29;
        Wed, 21 Aug 2019 17:57:38 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id AD0DF223D06; Wed, 21 Aug 2019 13:57:32 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc:     virtio-fs@redhat.com, vgoyal@redhat.com, miklos@szeredi.hu,
        stefanha@redhat.com, dgilbert@redhat.com,
        Peng Tao <tao.peng@linux.alibaba.com>
Subject: [PATCH 10/19] fuse: Introduce setupmapping/removemapping commands
Date:   Wed, 21 Aug 2019 13:57:11 -0400
Message-Id: <20190821175720.25901-11-vgoyal@redhat.com>
In-Reply-To: <20190821175720.25901-1-vgoyal@redhat.com>
References: <20190821175720.25901-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Wed, 21 Aug 2019 17:57:38 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce two new fuse commands to setup/remove memory mappings. This
will be used to setup/tear down file mapping in dax window.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Peng Tao <tao.peng@linux.alibaba.com>
---
 include/uapi/linux/fuse.h | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 4461fd640cf2..7c2ad3d418df 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -426,6 +426,8 @@ enum fuse_opcode {
 	FUSE_RENAME2		= 45,
 	FUSE_LSEEK		= 46,
 	FUSE_COPY_FILE_RANGE	= 47,
+	FUSE_SETUPMAPPING       = 48,
+	FUSE_REMOVEMAPPING      = 49,
 
 	/* CUSE specific operations */
 	CUSE_INIT		= 4096,
@@ -850,4 +852,41 @@ struct fuse_copy_file_range_in {
 	uint64_t	flags;
 };
 
+#define FUSE_SETUPMAPPING_ENTRIES 8
+#define FUSE_SETUPMAPPING_FLAG_WRITE (1ull << 0)
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
+struct fuse_setupmapping_out {
+	/* Offsets into the cache of mappings */
+	uint64_t	coffset[FUSE_SETUPMAPPING_ENTRIES];
+        /* Lengths of each mapping */
+        uint64_t	len[FUSE_SETUPMAPPING_ENTRIES];
+};
+
+struct fuse_removemapping_in {
+	/* number of fuse_removemapping_one follows */
+	uint32_t        count;
+};
+
+struct fuse_removemapping_one {
+	/* Offset into the dax window start the unmapping */
+	uint64_t        moffset;
+        /* Length of mapping required */
+        uint64_t	len;
+};
+
+#define FUSE_REMOVEMAPPING_MAX_ENTRY   \
+		(PAGE_SIZE / sizeof(struct fuse_removemapping_one))
+
 #endif /* _LINUX_FUSE_H */
-- 
2.20.1

