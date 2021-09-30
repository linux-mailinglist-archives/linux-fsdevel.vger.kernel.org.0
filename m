Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298E241DC76
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Sep 2021 16:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350909AbhI3Ok4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Sep 2021 10:40:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47866 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350878AbhI3Okx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633012750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CFkyMjzkyJBm3WnZsiRLAeCCVWKPXTDbggPUFe0w8QQ=;
        b=ew7kLravks+OIVsvewxz77UdESlNakooswRJ64w1gXcU5pWCzxgNRQGdJcuo9jwS3RuG+b
        /0jbxAzsqUxfb7N6EqqmOacJQ6UN+HDfB4Th38ZHJZnpeKzCuZ0zy1oDDRqyqa83h7V0i4
        8S9ezovNmTDWHGXasfp2pfieU4xFjOU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-xTjNnye1OUqsnO2Iy_XL9g-1; Thu, 30 Sep 2021 10:39:08 -0400
X-MC-Unique: xTjNnye1OUqsnO2Iy_XL9g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 837799126D;
        Thu, 30 Sep 2021 14:39:07 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.16.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 31A3318EDF;
        Thu, 30 Sep 2021 14:39:07 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id C1FA5228281; Thu, 30 Sep 2021 10:39:06 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        miklos@szeredi.hu, stefanha@redhat.com
Cc:     vgoyal@redhat.com, iangelak@redhat.com, jaggel@bu.edu,
        dgilbert@redhat.com
Subject: [PATCH 2/8] virtiofs: Fix a comment about fuse_dev allocation
Date:   Thu, 30 Sep 2021 10:38:44 -0400
Message-Id: <20210930143850.1188628-3-vgoyal@redhat.com>
In-Reply-To: <20210930143850.1188628-1-vgoyal@redhat.com>
References: <20210930143850.1188628-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now virtiofs allocates fuse_dev for all queues and does not rely on fuse
common code to allocate for request queue. Fix the comment.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/virtio_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index b9256b8f277f..f7c58a4b996d 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1307,7 +1307,7 @@ static int virtio_fs_fill_super(struct super_block *sb, struct fs_context *fsc)
 	}
 
 	err = -ENOMEM;
-	/* Allocate fuse_dev for hiprio and notification queues */
+	/* Allocate fuse_dev for all the queues */
 	for (i = 0; i < fs->nvqs; i++) {
 		struct virtio_fs_vq *fsvq = &fs->vqs[i];
 
-- 
2.31.1

