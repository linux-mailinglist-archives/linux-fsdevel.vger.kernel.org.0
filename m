Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B72B2FB047
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 06:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388330AbhASFWi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 00:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389124AbhASFGj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:06:39 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8328FC061796
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jan 2021 21:04:49 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id x20so5976627pjh.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jan 2021 21:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N9j+IrVlTXg9S1haunx/u+0liG07Ca/vG3BAfTTRth0=;
        b=c0lyfDzoS5QB6OBrKysFm/8ri6zOlvieJn8PK4hMjXVxXJVepylfobD8qrU/efAP+8
         uxzJUp2XXpUNM9vHpFBqdG1ny23yuIw6VXqGQ09j2KVBOxh8UZIUffJwQs1I79SPA6ZR
         et1ER1BhrBRSQSzxSN377DwkEP+mzYVKCmnN2Q5x/2L0dx1mzo6VQy6AMn3BGX7J+KAR
         kbB01iNMvc9O6hfDzpM8BYwecLzj5ahKiOFQSrFiv5DV1NrzqoxoXC/7EnVK1zE6Tk61
         ys6ucMWwrfuNPw7UpMQNfKiBv7Vuvd3K7JE5j1VuUahfpbZG+klHnewhTwhXKNN7ULdY
         iqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N9j+IrVlTXg9S1haunx/u+0liG07Ca/vG3BAfTTRth0=;
        b=Mayhop/+a8YTWayK/9NHW6VT0zfGl/FZtTBfbpw17q9XNh7e1RJ0ndARE4z0qflduf
         BY4EWZ13JFhNF0+ATHUTIAHgqX1KsY2vGb+CHQ+ll5QTXKArMV9/VM5SGWhDL+pfIkD9
         wKlTN01mCFihXvc4fjANwf7rqrPL9oMIYWgBqi2NzFgsPLDPQ9F0Ob8e1NnuguKeH25w
         DKN4g15qzu+GHF/EeCzuuossHKtLT1ydjnfMDLR4tfQmu6rjBsjGui75Ih83/CKdQk4s
         WKAIQjc2NIjzZlyy08v1r+R2iOgPnrkrXkv6YqJ70IxW0bYMt29B5O5ocpmeMgRlgJgj
         sOKA==
X-Gm-Message-State: AOAM533R15BWzkmkhalfRFOXGljL1i0A/TsroRDeQ44nf6pZFsCWYs1M
        8I+Zo8wPz/TJNSZYtcJbIw76
X-Google-Smtp-Source: ABdhPJxCgeMC/Vp9b1Ucmz89KU0Ng1jFwBXGSGBKRDk7q1sBsQ76nH4litH5FKUFM0pgi1pzDUNObg==
X-Received: by 2002:a17:902:848e:b029:dc:b38:98f0 with SMTP id c14-20020a170902848eb02900dc0b3898f0mr2732883plo.82.1611032689158;
        Mon, 18 Jan 2021 21:04:49 -0800 (PST)
Received: from localhost ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id j15sm17627186pfn.180.2021.01.18.21.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 21:04:48 -0800 (PST)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        sgarzare@redhat.com, parav@nvidia.com, bob.liu@oracle.com,
        hch@infradead.org, rdunlap@infradead.org, willy@infradead.org,
        viro@zeniv.linux.org.uk, axboe@kernel.dk, bcrl@kvack.org,
        corbet@lwn.net
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: [RFC v3 04/11] vhost-vdpa: protect concurrent access to vhost device iotlb
Date:   Tue, 19 Jan 2021 12:59:13 +0800
Message-Id: <20210119045920.447-5-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210119045920.447-1-xieyongji@bytedance.com>
References: <20210119045920.447-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce a mutex to protect vhost device iotlb from
concurrent access.

Fixes: 4c8cf318("vhost: introduce vDPA-based backend")
Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vhost/vdpa.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 448be7875b6d..4a241d380c40 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -49,6 +49,7 @@ struct vhost_vdpa {
 	struct eventfd_ctx *config_ctx;
 	int in_batch;
 	struct vdpa_iova_range range;
+	struct mutex mutex;
 };
 
 static DEFINE_IDA(vhost_vdpa_ida);
@@ -728,6 +729,7 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev,
 	if (r)
 		return r;
 
+	mutex_lock(&v->mutex);
 	switch (msg->type) {
 	case VHOST_IOTLB_UPDATE:
 		r = vhost_vdpa_process_iotlb_update(v, msg);
@@ -747,6 +749,7 @@ static int vhost_vdpa_process_iotlb_msg(struct vhost_dev *dev,
 		r = -EINVAL;
 		break;
 	}
+	mutex_unlock(&v->mutex);
 
 	return r;
 }
@@ -1017,6 +1020,7 @@ static int vhost_vdpa_probe(struct vdpa_device *vdpa)
 		return minor;
 	}
 
+	mutex_init(&v->mutex);
 	atomic_set(&v->opened, 0);
 	v->minor = minor;
 	v->vdpa = vdpa;
-- 
2.11.0

