Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8363A3C6C6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 10:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbhGMIuh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 04:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbhGMIud (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 04:50:33 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AD3C061787
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jul 2021 01:47:42 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c15so10724941pls.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jul 2021 01:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FdoZ+4EM7JCQgZ86bDT9RbGlh7q+AWgllGjoIYPWL9Q=;
        b=gA1/QgaUqMMGrBGGpEVYK8fMzHiF70tOx013tB9CxkOMsIAz6K9CyWbLukiYsceeeK
         WT3omC6T/UV02GbqJntqFcUEJy/CsH+2v38lltH8hTUVi5bDMirNFM2m8jsgCd53U/1v
         Lc/Oygn7Gsw282JeKIqoiMuvIbDZt/am73WeLkzOY2/CkX4nQAuUu3ul4s5GPTxJkyx3
         dWRyzileES+3pFwFh509M/IKBfUS06G83m9tPJd2yiq3RvUawNvAiQ6SGLm5AoV3JD3Q
         Yf50mdZiBV6HqGDPHp59XIyHUg9RniZUw56YWfFOmyWOXjXu+QsXkJ6TpitVDuk7cFO9
         CT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FdoZ+4EM7JCQgZ86bDT9RbGlh7q+AWgllGjoIYPWL9Q=;
        b=Citrxpi6Bfsw5M51J2WqlRUF/YtKLnNRuZjf6EF2aoJB/rKGeBZu4yQ5kBjjUvIUyu
         Ttv0AZxpjn4qLCj+B7YDHDH7ell8/Nw7zR0ahP4qOg1WUbn5u/0G0M3tzzS84kJynuQD
         dbdehq1JxEaT/7nOLjzWyptuVYzzV9rSiRDjruUJbTySxFij/hhjqA4p8MYYX4Tl7TSq
         WOHIHMFSBbhenRjFVd0SEczrPynT6vIoy2TEuG/JP6Jsv1IWFbkSFf5ppbYaHvojDsSw
         QQJThw0hsMS0uNJfgesn/IVUQejtvZMrl7m5DYxczJoyzlD5UTxD+a73sTUcfYE0NrgN
         g87w==
X-Gm-Message-State: AOAM531PL8d+e8eUf0W0FZEXSsuMa8zNuf5Y8B6roGvP0NWmD61sfxA9
        IWd7AZpjMZMsVRqlxGdEUNhM
X-Google-Smtp-Source: ABdhPJy/YXaKCppxOExioeRxTLQv1sj8lcUHDptTXIY/sm3klehqPKR0QkOZNRfSckm4SM+jax8f+w==
X-Received: by 2002:a17:90b:1b4d:: with SMTP id nv13mr1935868pjb.216.1626166061630;
        Tue, 13 Jul 2021 01:47:41 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id w2sm15858457pjq.5.2021.07.13.01.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 01:47:41 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
        christian.brauner@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org,
        gregkh@linuxfoundation.org, zhe.he@windriver.com,
        xiaodong.liu@intel.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 05/17] vhost-vdpa: Fail the vhost_vdpa_set_status() on reset failure
Date:   Tue, 13 Jul 2021 16:46:44 +0800
Message-Id: <20210713084656.232-6-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713084656.232-1-xieyongji@bytedance.com>
References: <20210713084656.232-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Re-read the device status to ensure it's set to zero during
resetting. Otherwise, fail the vhost_vdpa_set_status() after timeout.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vhost/vdpa.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index bb374a801bda..62b6d911c57d 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -157,7 +157,7 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
 	struct vdpa_device *vdpa = v->vdpa;
 	const struct vdpa_config_ops *ops = vdpa->config;
 	u8 status, status_old;
-	int nvqs = v->nvqs;
+	int timeout = 0, nvqs = v->nvqs;
 	u16 i;
 
 	if (copy_from_user(&status, statusp, sizeof(status)))
@@ -173,6 +173,15 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
 		return -EINVAL;
 
 	ops->set_status(vdpa, status);
+	if (status == 0) {
+		while (ops->get_status(vdpa)) {
+			timeout += 20;
+			if (timeout > VDPA_RESET_TIMEOUT_MS)
+				return -EIO;
+
+			msleep(20);
+		}
+	}
 
 	if ((status & VIRTIO_CONFIG_S_DRIVER_OK) && !(status_old & VIRTIO_CONFIG_S_DRIVER_OK))
 		for (i = 0; i < nvqs; i++)
-- 
2.11.0

