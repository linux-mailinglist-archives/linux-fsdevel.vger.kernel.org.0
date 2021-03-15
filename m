Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0EFC33AB26
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 06:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhCOFit (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 01:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbhCOFi1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 01:38:27 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54803C061762
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Mar 2021 22:38:27 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id j6so14717707plx.6
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Mar 2021 22:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P/3zALspLSxFVgxa420xFghjxZDebD6dVQ7y7utAibE=;
        b=ACAc2f1GmAazLjOqMvvxvkxWPsJsk5l8GH5Gs5zEQgoozUM3itrYVk4Wx3X+k9Ha0Z
         Zfcd/wBYz+Hy+fKyl1Ypi/qAgRzNhBN0MtSUomXEYb7fqnnGSRY0Z5jckrthOZqGMS0c
         CEYTgBfHllx/+8Vw04THD5n6xmPdqNFvqvqu8+Dod4nWcae1yx3i9i6w7mhApfdjoSF0
         JZVB6JZxwQPA3Fd4YMIBTI2lo/z997gsskQEQPZd3ZVKdsv6muV5n/HpueE9uqa3ua8f
         yN1ChaYUuXTuQ7h0bq1Eo56PAzOpOLaEkTSqApmb1RH62M9YDfUGk4HE/9dx0xjiYDym
         5n4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P/3zALspLSxFVgxa420xFghjxZDebD6dVQ7y7utAibE=;
        b=INSXZdC2Vt3LbE1LlHL+HZE3/xAZf7lu814JiET5cOsQT5nxrG5lfbb+FSv20n589i
         pXr7wlS5y63vG0tFMEkZbs+VgK07bsvw6IHqTiYy7q6Xu+x1t67gIYrBNKcJvxo3+s3O
         nSuGx6n/Ii7ysI7btVfTuRjyw/NUj86OoOkMitpBFWJVP45eeqIwoNJxb06T0Q6+mE0m
         mCJ9CgeNRnPVfvIHhIvfXSJKA2Y7CF9NhldtqVavLk6JnjBcUPCN3pMCxViiCHpB1aZj
         syIPgAv6dl5+L5EpXrgF0MDdrGb6+ihuWAOgB7qMs/HPBddU7K9ZP9yFd3Qi3ymRWCxM
         PSvQ==
X-Gm-Message-State: AOAM530pqevDQU+QQGTSghN4KwLz1Fdc8T515il2fWlH8tHnXKedysZv
        KwSVLDKborip8cFM5BuNL13b
X-Google-Smtp-Source: ABdhPJy7OEuy5awQEQoSJcJXbxqYr6jjC5aj/lbgmiXvRp3orJRy+soCtvCRBg08Gq4rmHmLxlGXTg==
X-Received: by 2002:a17:90b:16cd:: with SMTP id iy13mr4607320pjb.46.1615786706994;
        Sun, 14 Mar 2021 22:38:26 -0700 (PDT)
Received: from localhost ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id s1sm11783866pfe.151.2021.03.14.22.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 22:38:26 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, bob.liu@oracle.com,
        hch@infradead.org, rdunlap@infradead.org, willy@infradead.org,
        viro@zeniv.linux.org.uk, axboe@kernel.dk, bcrl@kvack.org,
        corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 10/11] vduse: Add config interrupt support
Date:   Mon, 15 Mar 2021 13:37:20 +0800
Message-Id: <20210315053721.189-11-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210315053721.189-1-xieyongji@bytedance.com>
References: <20210315053721.189-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch introduces a new ioctl VDUSE_INJECT_CONFIG_IRQ
to support injecting config interrupt.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 24 +++++++++++++++++++++++-
 include/uapi/linux/vduse.h         |  3 +++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 07d0ae92d470..cc12b58bdc09 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -64,6 +64,8 @@ struct vduse_dev {
 	struct list_head send_list;
 	struct list_head recv_list;
 	struct list_head list;
+	struct vdpa_callback config_cb;
+	spinlock_t irq_lock;
 	bool connected;
 	int minor;
 	u16 vq_size_max;
@@ -439,6 +441,11 @@ static void vduse_dev_reset(struct vduse_dev *dev)
 	vduse_domain_reset_bounce_map(dev->domain);
 	vduse_dev_update_iotlb(dev, 0ULL, ULLONG_MAX);
 
+	spin_lock(&dev->irq_lock);
+	dev->config_cb.callback = NULL;
+	dev->config_cb.private = NULL;
+	spin_unlock(&dev->irq_lock);
+
 	for (i = 0; i < dev->vq_num; i++) {
 		struct vduse_virtqueue *vq = &dev->vqs[i];
 
@@ -557,7 +564,12 @@ static int vduse_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
 static void vduse_vdpa_set_config_cb(struct vdpa_device *vdpa,
 				  struct vdpa_callback *cb)
 {
-	/* We don't support config interrupt */
+	struct vduse_dev *dev = vdpa_to_vduse(vdpa);
+
+	spin_lock(&dev->irq_lock);
+	dev->config_cb.callback = cb->callback;
+	dev->config_cb.private = cb->private;
+	spin_unlock(&dev->irq_lock);
 }
 
 static u16 vduse_vdpa_get_vq_num_max(struct vdpa_device *vdpa)
@@ -842,6 +854,15 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 		ret = 0;
 		queue_work(vduse_irq_wq, &dev->vqs[arg].inject);
 		break;
+	case VDUSE_INJECT_CONFIG_IRQ:
+		ret = -EINVAL;
+		spin_lock_irq(&dev->irq_lock);
+		if (dev->config_cb.callback) {
+			dev->config_cb.callback(dev->config_cb.private);
+			ret = 0;
+		}
+		spin_unlock_irq(&dev->irq_lock);
+		break;
 	default:
 		ret = -ENOIOCTLCMD;
 		break;
@@ -918,6 +939,7 @@ static struct vduse_dev *vduse_dev_create(void)
 	INIT_LIST_HEAD(&dev->send_list);
 	INIT_LIST_HEAD(&dev->recv_list);
 	atomic64_set(&dev->msg_unique, 0);
+	spin_lock_init(&dev->irq_lock);
 
 	init_waitqueue_head(&dev->waitq);
 
diff --git a/include/uapi/linux/vduse.h b/include/uapi/linux/vduse.h
index 37f7d7059aa8..337e766f5622 100644
--- a/include/uapi/linux/vduse.h
+++ b/include/uapi/linux/vduse.h
@@ -150,4 +150,7 @@ struct vduse_vq_eventfd {
 /* Inject an interrupt for specific virtqueue */
 #define VDUSE_INJECT_VQ_IRQ	_IO(VDUSE_BASE, 0x05)
 
+/* Inject a config interrupt */
+#define VDUSE_INJECT_CONFIG_IRQ	_IO(VDUSE_BASE, 0x06)
+
 #endif /* _UAPI_VDUSE_H_ */
-- 
2.11.0

