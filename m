Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5DC1B6E24
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 08:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgDXG0J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 02:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725898AbgDXG0J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 02:26:09 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82813C09B045
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2020 23:26:08 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id y6so3538454pjc.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2020 23:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gfc0cFO2L1HUkwddTCsuj4a1zB9/jwWzyBDO+mCQarU=;
        b=BLtx0N5LC85qAEv11FxLkhD7+543mklwOA7DxGaz3qkPFpdnaz1m7zbbl3uVeEGQ0D
         ORDeFnGX68cXXK4ozkw24hStQgus/kwSbJcFYz8wTJwea9ogyQ9HGMSFUCy9lU0AgVZC
         D2/IIWNRLKY2JTEZ7YgoDEeOi2H30WOoVG8Ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gfc0cFO2L1HUkwddTCsuj4a1zB9/jwWzyBDO+mCQarU=;
        b=aqsCRmD4PbgufvalfV9Qb7qzfsSyJHTSe1dJd8WHqRfAg0Qv3XFVJqPJSYpmNO/Diu
         4FarKFy2c12aVh/wBeeJnEMxWY87YyFcc4NrYs9iXZfFb3RUXvSNcLQcqgW1f7DA0pZu
         GByXjAV1uB5TO2hi8UJoUT8987P3gPGp4bu0MueRCWPm79p6NyBwQBds00ikYo8XBFM3
         L3NGT1fUZStY3yl0Bs2brhVnGlq9jqiMFqANtwZTFJaLvfqDd0kCqqDAUf3iczvCdezS
         SOJrMUEKnOdrP8D8umNUatVNWm/0ApjfMJD66xKJJqSLep49xsuMRn/zPM2F7H+Sz9YB
         xnuw==
X-Gm-Message-State: AGi0PuZs8fEg8Dqa1SIQrf8+t+pOPxOoVKmHngRiGFDvHZX4J/2UbeXk
        HxGymIaBUqU4RR/xM8k2mLX1jQ==
X-Google-Smtp-Source: APiQypI9p+1f+TDu6sMOE3JqkpBE7ZVPzayuw85gi85pw3JPaz8plV06L9tpj4eXp2x3bj7MukOQxA==
X-Received: by 2002:a17:90a:589:: with SMTP id i9mr4611312pji.156.1587709568073;
        Thu, 23 Apr 2020 23:26:08 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:2:1c5:cb1a:7c95:326])
        by smtp.gmail.com with ESMTPSA id i190sm4656562pfe.114.2020.04.23.23.26.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 23:26:07 -0700 (PDT)
From:   Chirantan Ekbote <chirantan@chromium.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
        Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH 1/2] fuse: virtiofs: Fix nullptr dereference
Date:   Fri, 24 Apr 2020 15:25:39 +0900
Message-Id: <20200424062540.23679-1-chirantan@chromium.org>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

virtiofs device implementations are allowed to provide more than one
request queue.  In this case `fsvq->fud` would not be initialized,
leading to a nullptr dereference later during driver initialization.

Make sure that `fsvq->fud` is initialized for all request queues even if
the driver doesn't use them.

Signed-off-by: Chirantan Ekbote <chirantan@chromium.org>
---
 fs/fuse/virtio_fs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index bade747689033..d3c38222a7e4e 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1066,10 +1066,13 @@ static int virtio_fs_fill_super(struct super_block *sb)
 	}
 
 	err = -ENOMEM;
-	/* Allocate fuse_dev for hiprio and notification queues */
-	for (i = 0; i < VQ_REQUEST; i++) {
+	/* Allocate fuse_dev for all queues except the first request queue. */
+	for (i = 0; i < fs->nvqs; i++) {
 		struct virtio_fs_vq *fsvq = &fs->vqs[i];
 
+		if (i == VQ_REQUEST)
+			continue;
+
 		fsvq->fud = fuse_dev_alloc();
 		if (!fsvq->fud)
 			goto err_free_fuse_devs;
-- 
2.26.2.303.gf8c07b1a785-goog

