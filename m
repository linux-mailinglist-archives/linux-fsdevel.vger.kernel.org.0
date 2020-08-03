Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C0623AEB0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 23:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgHCU7V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 16:59:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40611 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728570AbgHCU7V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 16:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596488360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=or+zNAibqtaoCeVVGOGdUm20NwzQtJQIDqrZeu9+GCU=;
        b=TwkydxG/QH72p48OLC6OaIreqgXJB38DjSy33FeNt36OWFT+QjSKpwiGD0BDC5UIgj0U4p
        Dxo0eJtmBlw31v8zV4ew6tTBjszgizSzRzDvOhyuFWne0UfdpalRrD9rcAwK8rSGk+VUN7
        NISfbN4+kTrisagAM/P1xlmG0QivN/8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-OSRWWy5lPZKq57oU8zyzPg-1; Mon, 03 Aug 2020 16:59:18 -0400
X-MC-Unique: OSRWWy5lPZKq57oU8zyzPg-1
Received: by mail-qt1-f198.google.com with SMTP id d24so20335102qtg.23
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Aug 2020 13:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=or+zNAibqtaoCeVVGOGdUm20NwzQtJQIDqrZeu9+GCU=;
        b=H2Gy4EEqPPHmzaUp+A0BnywLbjcqlkxx9/2EUU82zbwJ66gf8EEv+GHMHero47ai8L
         fLH0q/5zXlSH5b80hvL3P9cInkA+MGpbhjjxlYsicbhgyy9DuijtW8iyx6NLYy5UNHld
         /BywArji0yCEWuchuaWL0beq6pHBYnLV7GhzNJrki5QZsbZbqQ246zEB48aYYxVpMIyz
         OKxbhUlE6e5/F/uJr9x7iYrLToTYCnMu6wLks8C0ZICGuMzKIcVaykeHopH/nckOsO/e
         f6R+R5pA3Rw0aq3jzGelhktYPM2bAO+oIPuCn1eMq2UZnT+Qn2lIb7yKFQH7uyVhD6UN
         6X7A==
X-Gm-Message-State: AOAM533Ldpla/c76w5IWMs0GKNd//ertDIqdRGdGHNbki9GaaSc5ncy1
        KyfVW2ZIHwaU5JMHKC1JsXkJQkd0z/WkL79Y1zQ4eQ/rYgF8mtjz966UM6B/vO5NyVXntZRMqg2
        AddLtn4SwdqoJtP1ljDcaRZyrkg==
X-Received: by 2002:ac8:1084:: with SMTP id a4mr17555986qtj.83.1596488358265;
        Mon, 03 Aug 2020 13:59:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrapOZB7Hdxu0x7Z+dBtzskHcpM/llP/zvUq8ucoKtu/KA509zj05FQ3vDOugv6knjeTkoqw==
X-Received: by 2002:ac8:1084:: with SMTP id a4mr17555977qtj.83.1596488358075;
        Mon, 03 Aug 2020 13:59:18 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net. [79.177.102.128])
        by smtp.gmail.com with ESMTPSA id z14sm21310391qtn.92.2020.08.03.13.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 13:59:17 -0700 (PDT)
Date:   Mon, 3 Aug 2020 16:59:13 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 09/24] virtio_fs: correct tags for config space fields
Message-ID: <20200803205814.540410-10-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803205814.540410-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since fs is a modern-only device,
tag config space fields as having little endian-ness.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/virtio_fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/virtio_fs.h b/include/uapi/linux/virtio_fs.h
index b02eb2ac3d99..3056b6e9f8ce 100644
--- a/include/uapi/linux/virtio_fs.h
+++ b/include/uapi/linux/virtio_fs.h
@@ -13,7 +13,7 @@ struct virtio_fs_config {
 	__u8 tag[36];
 
 	/* Number of request queues */
-	__u32 num_request_queues;
+	__le32 num_request_queues;
 } __attribute__((packed));
 
 #endif /* _UAPI_LINUX_VIRTIO_FS_H */
-- 
MST

