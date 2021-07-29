Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8EAD3D9E9A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jul 2021 09:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbhG2Hgc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jul 2021 03:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbhG2Hg1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jul 2021 03:36:27 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84FBC0613D5
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jul 2021 00:36:24 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id ca5so9000799pjb.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jul 2021 00:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X6m+j6D+552UMlknTc2y1DCtUDa099ibFfLa+38yD24=;
        b=L80tblxe3wtC2HKOtW3renZJvhfc7GFjS2AU2pPB5D73BMRY5myTcL/dhJfOO3bvlS
         JtQFCV+tA2gcpqYeaWfCYxb8vXm8jpR+HCadwYr5BhMkmKpmvKsmqB9UTRdts+3U9SP1
         z3jVWGbtk9bPdxyirEaJmHDRgjeE+wxcZ6RxbnBwB78D9RNokjcCtEUjS/aYPQ1BGtRp
         QFcakWAIabACF+QbfqNnv3dJP3ygewcdcN8WcuxnO6USt7gbjEjTS14J3bC3C+ylNHGA
         u7uQ2WlKZfweCuq8ckMwiJvO3WR69GUOvElFAR5Jm7PnsV3dbG2bnld3LKJUmpYFmdKv
         gQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X6m+j6D+552UMlknTc2y1DCtUDa099ibFfLa+38yD24=;
        b=uD9EVAYIg2QmE+Fi5Bnhpl2KZgfl/8IDO60FwlroXqEGdvUQSKftuHixEgkTOqSRE5
         5+UJVgkqiBjw83MFxjV6z5lbqJuRDY+x7T+OP0qlywmH8bWw8uhgQZyyFJvEy2fzNp43
         WDmvg0r+kBGHaoV+UlbyZvwGYtJNmPDZ2M5rIL55+qJ3gAH9ocva+MrcwGtAlfHVATJi
         LVfrpsVTDMRnHMb1QyJ4OwLI+VA8XczM18TERZrVNRFSrK19tezcThP5fVFKQFvGXwwb
         7I3XexnIe2rt+i94kckTDkh76v7ojByY2jNJKDWe++Dsp9NFeQ7CMNAurwA5OWltbAro
         Cc1g==
X-Gm-Message-State: AOAM531swQ3DU6o5/4VKBF91+I5JPDa0vzasaCltqjtrbENS1h2Tb8gg
        /BJnKN3f6f6PHDzAN+LaweFL
X-Google-Smtp-Source: ABdhPJzL8jwmp/JqGX6fQcP4HFWd79KgnMjKHajdRntovUI/IJhBr5JEygiGnHX6aUTtQVmAfW1PyA==
X-Received: by 2002:a62:e90b:0:b029:30e:4530:8dca with SMTP id j11-20020a62e90b0000b029030e45308dcamr3799994pfh.17.1627544184395;
        Thu, 29 Jul 2021 00:36:24 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id l10sm2164343pjg.11.2021.07.29.00.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 00:36:23 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, hch@infradead.org,
        christian.brauner@canonical.com, rdunlap@infradead.org,
        willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
        bcrl@kvack.org, corbet@lwn.net, mika.penttila@nextfour.com,
        dan.carpenter@oracle.com, joro@8bytes.org,
        gregkh@linuxfoundation.org, zhe.he@windriver.com,
        xiaodong.liu@intel.com, joe@perches.com
Cc:     songmuchun@bytedance.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 05/17] vhost-vdpa: Fail the vhost_vdpa_set_status() on reset failure
Date:   Thu, 29 Jul 2021 15:34:51 +0800
Message-Id: <20210729073503.187-6-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210729073503.187-1-xieyongji@bytedance.com>
References: <20210729073503.187-1-xieyongji@bytedance.com>
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
index b07aa161f7ad..dd05c1e1133c 100644
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

