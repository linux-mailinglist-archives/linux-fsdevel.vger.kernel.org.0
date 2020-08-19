Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE6424A935
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 00:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgHSWWY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 18:22:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33099 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727902AbgHSWVL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 18:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597875670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mul6xYMxBSgZ+hw59Zt3uye6OAmruS4cZeubQ0rXxgM=;
        b=GAzVoJWiJ5Ts+Vn/nmhj5nIh5WgtvFm1IN6EAheaTNa7oP1hBO1tyAV1hpAunDbgqbktwC
        9M+4RhSbrRemKzPJjG+srXHRyoKKKrEff5L+HDWYPykvYoxw2Ax04S93eC5Ou/zW3JDBgd
        RmQjHJ0mjudclqO9p8nG/KUkAbi9RhQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-535-dmD4I7AnOHuEHQVyL9Tchw-1; Wed, 19 Aug 2020 18:21:08 -0400
X-MC-Unique: dmD4I7AnOHuEHQVyL9Tchw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72E668030B0;
        Wed, 19 Aug 2020 22:21:07 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-197.rdu2.redhat.com [10.10.115.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 85FBD5D9E8;
        Wed, 19 Aug 2020 22:21:01 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 10D3E2256EA; Wed, 19 Aug 2020 18:20:54 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, dan.j.williams@intel.com,
        Peng Tao <tao.peng@linux.alibaba.com>
Subject: [PATCH v3 12/18] fuse: Introduce setupmapping/removemapping commands
Date:   Wed, 19 Aug 2020 18:19:50 -0400
Message-Id: <20200819221956.845195-13-vgoyal@redhat.com>
In-Reply-To: <20200819221956.845195-1-vgoyal@redhat.com>
References: <20200819221956.845195-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce two new fuse commands to setup/remove memory mappings. This
will be used to setup/tear down file mapping in dax window.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
Signed-off-by: Peng Tao <tao.peng@linux.alibaba.com>
---
 include/uapi/linux/fuse.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 5b85819e045f..60a7bfc787ce 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -894,4 +894,33 @@ struct fuse_copy_file_range_in {
 	uint64_t	flags;
 };
 
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
+struct fuse_removemapping_in {
+	/* number of fuse_removemapping_one follows */
+	uint32_t        count;
+};
+
+struct fuse_removemapping_one {
+	/* Offset into the dax window start the unmapping */
+	uint64_t        moffset;
+	/* Length of mapping required */
+	uint64_t	len;
+};
+
+#define FUSE_REMOVEMAPPING_MAX_ENTRY   \
+		(PAGE_SIZE / sizeof(struct fuse_removemapping_one))
+
 #endif /* _LINUX_FUSE_H */
-- 
2.25.4

