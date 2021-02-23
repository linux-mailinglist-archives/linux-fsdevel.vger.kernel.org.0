Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A39E3229D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 13:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbhBWLze (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 06:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbhBWLxf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 06:53:35 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583DCC0617A9
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 03:51:56 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id f8so9670960plg.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Feb 2021 03:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H5pYvaPbrMIxKLcyQlCmLi7ENSgIrcUqDHSwAfTT3Bc=;
        b=uAbkaiDMGWc604JHIcQVDYByzZVoEeGu7SyJIqA0IhjlL+MTB568yxSLXt4vGg++63
         RKSY0vXfFcx5CJXdmX7Ubrhh8y+3weWqv5SxMYCVRr7vO0sP1C1cdZL+AH5TIa90X5bw
         g8w7cK5dlINPEC4KKty6Mat0XtnkZKbWzzH2mWEdd18i49aeHVQfaDps0jaC4iNIoRav
         HMQ915J3+frT0EatXgB956DhFZmFaGMpLi64fVURY2g4g8ccO2aXBSTwbLqpffV8o8VG
         vdqp95CdngZmGGW3AwSs+fl6DZWyVet89x1G3PyGbco4XcwKhwHKNJIeAsE+n/Fy7RGt
         1tig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H5pYvaPbrMIxKLcyQlCmLi7ENSgIrcUqDHSwAfTT3Bc=;
        b=LmkaJAbmusEt7LBJhc/tiipDslyU0yWxE6rRKoVROO1gMdfrCTwO+LV9Ugh2yoqZOd
         G7UVcHXEgG3zPjekcNX8dGS97C2a9CjO3a4FQH0CGHXL04Iu7OYJzjJFAFsTjY+jIbzZ
         7qi4/Q9ByYPs6Q2WwD1XxVGKVMmt4m9G6C9kcoEbIDIBIQKkdq9GW48ownPNk+WnMuBD
         VKTEn2tbxFbSdtWuZ2I80K21sFFTZCelIGmw/y4QurUKBOPqGFyVdHqhLAMZZ0Og78Gh
         /O/kYJ7/M2WBKwsWRTBu/R7sE0w8UFxslOumiuaIK/plbZbZJGuQrl3i51skMvtOFf1W
         5P8w==
X-Gm-Message-State: AOAM5310WPM6STqn9KZ+wLxg78veWFuFno2zPE9i1VoaAKqjS88a7xys
        WTTm53E3xnKJXl2ct7FVeoFT
X-Google-Smtp-Source: ABdhPJxIRjqlLohL2qQdhCvXk/w+oPLa9KjPD7KvhuRCAkItq9fp2WG4P28iah9KVEQFzIO4znt1bQ==
X-Received: by 2002:a17:90a:4092:: with SMTP id l18mr28912229pjg.1.1614081115991;
        Tue, 23 Feb 2021 03:51:55 -0800 (PST)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id l74sm11894608pga.86.2021.02.23.03.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 03:51:55 -0800 (PST)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, bob.liu@oracle.com,
        hch@infradead.org, rdunlap@infradead.org, willy@infradead.org,
        viro@zeniv.linux.org.uk, axboe@kernel.dk, bcrl@kvack.org,
        corbet@lwn.net
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: [RFC v4 03/11] vhost-iotlb: Add an opaque pointer for vhost IOTLB
Date:   Tue, 23 Feb 2021 19:50:40 +0800
Message-Id: <20210223115048.435-4-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210223115048.435-1-xieyongji@bytedance.com>
References: <20210223115048.435-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add an opaque pointer for vhost IOTLB. And introduce
vhost_iotlb_add_range_ctx() to accept it.

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vhost/iotlb.c       | 20 ++++++++++++++++----
 include/linux/vhost_iotlb.h |  3 +++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/iotlb.c b/drivers/vhost/iotlb.c
index 0fd3f87e913c..5c99e1112cbb 100644
--- a/drivers/vhost/iotlb.c
+++ b/drivers/vhost/iotlb.c
@@ -36,19 +36,21 @@ void vhost_iotlb_map_free(struct vhost_iotlb *iotlb,
 EXPORT_SYMBOL_GPL(vhost_iotlb_map_free);
 
 /**
- * vhost_iotlb_add_range - add a new range to vhost IOTLB
+ * vhost_iotlb_add_range_ctx - add a new range to vhost IOTLB
  * @iotlb: the IOTLB
  * @start: start of the IOVA range
  * @last: last of IOVA range
  * @addr: the address that is mapped to @start
  * @perm: access permission of this range
+ * @opaque: the opaque pointer for the new mapping
  *
  * Returns an error last is smaller than start or memory allocation
  * fails
  */
-int vhost_iotlb_add_range(struct vhost_iotlb *iotlb,
-			  u64 start, u64 last,
-			  u64 addr, unsigned int perm)
+int vhost_iotlb_add_range_ctx(struct vhost_iotlb *iotlb,
+			      u64 start, u64 last,
+			      u64 addr, unsigned int perm,
+			      void *opaque)
 {
 	struct vhost_iotlb_map *map;
 
@@ -71,6 +73,7 @@ int vhost_iotlb_add_range(struct vhost_iotlb *iotlb,
 	map->last = last;
 	map->addr = addr;
 	map->perm = perm;
+	map->opaque = opaque;
 
 	iotlb->nmaps++;
 	vhost_iotlb_itree_insert(map, &iotlb->root);
@@ -80,6 +83,15 @@ int vhost_iotlb_add_range(struct vhost_iotlb *iotlb,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(vhost_iotlb_add_range_ctx);
+
+int vhost_iotlb_add_range(struct vhost_iotlb *iotlb,
+			  u64 start, u64 last,
+			  u64 addr, unsigned int perm)
+{
+	return vhost_iotlb_add_range_ctx(iotlb, start, last,
+					 addr, perm, NULL);
+}
 EXPORT_SYMBOL_GPL(vhost_iotlb_add_range);
 
 /**
diff --git a/include/linux/vhost_iotlb.h b/include/linux/vhost_iotlb.h
index 6b09b786a762..2d0e2f52f938 100644
--- a/include/linux/vhost_iotlb.h
+++ b/include/linux/vhost_iotlb.h
@@ -17,6 +17,7 @@ struct vhost_iotlb_map {
 	u32 perm;
 	u32 flags_padding;
 	u64 __subtree_last;
+	void *opaque;
 };
 
 #define VHOST_IOTLB_FLAG_RETIRE 0x1
@@ -29,6 +30,8 @@ struct vhost_iotlb {
 	unsigned int flags;
 };
 
+int vhost_iotlb_add_range_ctx(struct vhost_iotlb *iotlb, u64 start, u64 last,
+			      u64 addr, unsigned int perm, void *opaque);
 int vhost_iotlb_add_range(struct vhost_iotlb *iotlb, u64 start, u64 last,
 			  u64 addr, unsigned int perm);
 void vhost_iotlb_del_range(struct vhost_iotlb *iotlb, u64 start, u64 last);
-- 
2.11.0

