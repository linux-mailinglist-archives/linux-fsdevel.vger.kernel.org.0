Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DC7610821
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 04:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236271AbiJ1Ceb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Oct 2022 22:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236217AbiJ1CeP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Oct 2022 22:34:15 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E00BE50B;
        Thu, 27 Oct 2022 19:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=oNwPMmiiscZmalT9QLvPSdkFnXwrjrYyn6HHUyvdsv4=; b=LbdCd+xJUOlW3tD7fkPV+2qFD/
        2/kv9EI0i4NvoRNnB1R1pc2GGkbcPmtDn/sh91RdGr8ESJi0bm5hUmC1uh16DGOIrrjScda8hXxc2
        SurHC9lK9wt3sFqZZWh0iwpXlYLbo2i4RRFtDI5yO8F0XKX6qMejxYjkBu7Sn8DPoLMBblDqC1sfT
        epkZBu1g0Dibf6FRMivfmiVUAr+N+CzaS46IenKgpd3sdbx5c0hbbmUWg5qFjipGq/wXAlMd9J6Gm
        moayWH7xe23ORfVyaJXkYsBVxibYDstao/gn/KEj8Uh/BKS664wsLCjA9tHgZg+cGoM1KGk79i6S+
        E3vy9XjA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ooFBx-00EorP-2B;
        Fri, 28 Oct 2022 02:33:53 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>, willy@infradead.org,
        dchinner@redhat.com, Steve French <smfrench@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>, torvalds@linux-foundation.org,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/12] [vhost] fix 'direction' argument of iov_iter_{init,bvec}()
Date:   Fri, 28 Oct 2022 03:33:49 +0100
Message-Id: <20221028023352.3532080-9-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028023352.3532080-1-viro@zeniv.linux.org.uk>
References: <Y1btOP0tyPtcYajo@ZenIV>
 <20221028023352.3532080-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

READ means "data destination", WRITE - "data source".

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/vhost/vhost.c  | 6 +++---
 drivers/vhost/vringh.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 40097826cff0..da0ff415b0a1 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -832,7 +832,7 @@ static int vhost_copy_to_user(struct vhost_virtqueue *vq, void __user *to,
 				     VHOST_ACCESS_WO);
 		if (ret < 0)
 			goto out;
-		iov_iter_init(&t, WRITE, vq->iotlb_iov, ret, size);
+		iov_iter_init(&t, READ, vq->iotlb_iov, ret, size);
 		ret = copy_to_iter(from, size, &t);
 		if (ret == size)
 			ret = 0;
@@ -871,7 +871,7 @@ static int vhost_copy_from_user(struct vhost_virtqueue *vq, void *to,
 			       (unsigned long long) size);
 			goto out;
 		}
-		iov_iter_init(&f, READ, vq->iotlb_iov, ret, size);
+		iov_iter_init(&f, WRITE, vq->iotlb_iov, ret, size);
 		ret = copy_from_iter(to, size, &f);
 		if (ret == size)
 			ret = 0;
@@ -2135,7 +2135,7 @@ static int get_indirect(struct vhost_virtqueue *vq,
 			vq_err(vq, "Translation failure %d in indirect.\n", ret);
 		return ret;
 	}
-	iov_iter_init(&from, READ, vq->indirect, ret, len);
+	iov_iter_init(&from, WRITE, vq->indirect, ret, len);
 	count = len / sizeof desc;
 	/* Buffers are chained via a 16 bit next field, so
 	 * we can have at most 2^16 of these. */
diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 11f59dd06a74..8be8f30a78f7 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -1162,7 +1162,7 @@ static inline int copy_from_iotlb(const struct vringh *vrh, void *dst,
 		else if (ret < 0)
 			return ret;
 
-		iov_iter_bvec(&iter, READ, iov, ret, translated);
+		iov_iter_bvec(&iter, WRITE, iov, ret, translated);
 
 		ret = copy_from_iter(dst, translated, &iter);
 		if (ret < 0)
@@ -1195,7 +1195,7 @@ static inline int copy_to_iotlb(const struct vringh *vrh, void *dst,
 		else if (ret < 0)
 			return ret;
 
-		iov_iter_bvec(&iter, WRITE, iov, ret, translated);
+		iov_iter_bvec(&iter, READ, iov, ret, translated);
 
 		ret = copy_to_iter(src, translated, &iter);
 		if (ret < 0)
-- 
2.30.2

