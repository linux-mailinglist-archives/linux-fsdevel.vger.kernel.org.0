Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008883C6C79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 10:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235167AbhGMIvB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 04:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbhGMIut (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 04:50:49 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E43EC0613AB
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jul 2021 01:47:56 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d12so18953495pfj.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jul 2021 01:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=79+lwfgqPqTMCDJYOtelsxZhwWsCxwv7dGGvPGe+0Sw=;
        b=XPYV6AqgUbZp6+vdppARBpAYCPqTsziLqNwvNsrjLuNKQsh6GS3q19GuTFueLqfI3W
         2mpioxtWWYo5lHGzcp+Jutobs4GmHGUTQiIvyRJOrhRaSYEd2g13fYjJdx8IqQbpVtg+
         U5M3F2NmfDR26UxFi92Yzg5HX/fYV6AYnZdE6d7ugOH+Y9vAV4e5UbOMWrmsG3AqiEzX
         NUPQt8B7lzQDca2Wt8iUkhnTLPaw8kJJmv71Rv4l+iNrRzjIvV51afp0ikEMovNJIa3w
         l3GoRQ485RyPX6RthpBauL0J2/vlNzokMcWZNI71JmewCwtjndkIJDGd4VS80mquizHp
         zreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=79+lwfgqPqTMCDJYOtelsxZhwWsCxwv7dGGvPGe+0Sw=;
        b=VDZO9eWsXi1nhpAlQAFLMOJ7vzlDMEAe8ACmEveAEHp5HfUoLNJrmTSYiWF8refx1W
         ElPt/x5/Yzy0BLzI+ayXhn9MSECnjS4CYtnHp4ZsRcB1j1stbikszDVqRvb1dWDAC71q
         zlkYo3kfPY67Y1chO8kR4Db9bYpee1oXKlnChbbQoBsTjGxLcMkWhpMW2+SUOM00XX2o
         gvTCOeYFM1x+G9M8I4NdklWP9LuhCA5BVhotCiKeUBA+JEs7op2C3qlW5D5Xc0+ABKO6
         bZHsCiI2d5IsxQhEvl1ir3DlYK+DcLRh6uW+q74sS+Y7m9I5EiHafprLRlvNqxKTALUq
         Fu8g==
X-Gm-Message-State: AOAM532qYrkw+WQRpMvG6SojoUCdO+so+Vl8ASCfDZrfc/BRDkFiMbk9
        Y+KbJzMNuqaSkjD7rkhKdsHu
X-Google-Smtp-Source: ABdhPJya/3d83k8xmEEz7mxN/KfDFTYEWfRDpJqmURKX4t0jIlbAdO7JalzXWyaKhiHPR7hvAQh/zQ==
X-Received: by 2002:aa7:808b:0:b029:2ef:cdd4:8297 with SMTP id v11-20020aa7808b0000b02902efcdd48297mr3574498pff.27.1626166076154;
        Tue, 13 Jul 2021 01:47:56 -0700 (PDT)
Received: from localhost ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id q21sm11607775pff.55.2021.07.13.01.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 01:47:55 -0700 (PDT)
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
Subject: [PATCH v9 09/17] virtio-vdpa: Handle the failure of vdpa_reset()
Date:   Tue, 13 Jul 2021 16:46:48 +0800
Message-Id: <20210713084656.232-10-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210713084656.232-1-xieyongji@bytedance.com>
References: <20210713084656.232-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The vpda_reset() may fail now. This adds check to its return
value and fail the virtio_vdpa_reset().

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/virtio/virtio_vdpa.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index 3e666f70e829..ebbd8471bbee 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -101,9 +101,7 @@ static int virtio_vdpa_reset(struct virtio_device *vdev)
 {
 	struct vdpa_device *vdpa = vd_get_vdpa(vdev);
 
-	vdpa_reset(vdpa);
-
-	return 0;
+	return vdpa_reset(vdpa);
 }
 
 static bool virtio_vdpa_notify(struct virtqueue *vq)
-- 
2.11.0

