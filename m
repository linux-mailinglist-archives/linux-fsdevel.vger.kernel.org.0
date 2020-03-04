Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 305891795DF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 17:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730011AbgCDQ7T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 11:59:19 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28499 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729976AbgCDQ7R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:59:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583341157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Er9GaMZzdsOf9xEWkAkuca5dLTt+xn8O50AMDB2wK58=;
        b=eS0D8yRTILwjQo5R/DCskAIlQl5qbiUkl4JpSJeqrl3hS4HtCOFO44so6QB/eiIU0H0JgL
        L/zS/TTO4SUdDoSj2o2e5vaj+5DsVEoVwnLVDXyiLf6KgAMbsVG1Swdn49AxLAtXpabTf6
        OGXjvTNI6o/JQQFO+7RiTWnPHdXv6Ts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-M5lHkdEMMj-8WUyOMMWnBA-1; Wed, 04 Mar 2020 11:59:13 -0500
X-MC-Unique: M5lHkdEMMj-8WUyOMMWnBA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BC1EDB64;
        Wed,  4 Mar 2020 16:59:12 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15B9873892;
        Wed,  4 Mar 2020 16:59:12 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 6A74C225812; Wed,  4 Mar 2020 11:59:03 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com, miklos@szeredi.hu
Cc:     vgoyal@redhat.com, stefanha@redhat.com, dgilbert@redhat.com,
        mst@redhat.com, Peng Tao <tao.peng@linux.alibaba.com>
Subject: [PATCH 12/20] fuse: Introduce setupmapping/removemapping commands
Date:   Wed,  4 Mar 2020 11:58:37 -0500
Message-Id: <20200304165845.3081-13-vgoyal@redhat.com>
In-Reply-To: <20200304165845.3081-1-vgoyal@redhat.com>
References: <20200304165845.3081-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce two new fuse commands to setup/remove memory mappings. This
will be used to setup/tear down file mapping in dax window.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Peng Tao <tao.peng@linux.alibaba.com>
---
 include/uapi/linux/fuse.h | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 5b85819e045f..62633555d547 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -894,4 +894,41 @@ struct fuse_copy_file_range_in {
 	uint64_t	flags;
 };
=20
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
--=20
2.20.1

