Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 541D210DCA7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2019 06:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfK3FbU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Nov 2019 00:31:20 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39179 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbfK3FbT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Nov 2019 00:31:19 -0500
Received: by mail-pj1-f68.google.com with SMTP id v93so11028566pjb.6;
        Fri, 29 Nov 2019 21:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3yGQn+iiQJUO9GKnXnkOFOtv94PHfEunM5yutQgfYz4=;
        b=Z8gfwWDS8fngo0CFYRMI015w2/aTU/TwhQBZ+GkrJmW2J2tl0dtjKq77JKCJEBIe8M
         z5JKNnjm4fQpc/BgJHwU8quoC4dJNYcXtIPK2uwWV4aHVHH2Nch31BduJliDB7WzvIjW
         NDZHRKK5K1NyYWLQn6aN7Ln0her5Bx08tYOxUB8hRXTMM3Q6km6m+L0WjVNjRSwpFaQn
         lz+KW6jAZKJn8VxO5FQr83MSDA8KaLeuQ0MWM2OCJXjOGLxI+hpobbvXuOERN1oEfQ25
         nWCypGglQ92bPPZKDUePE9h5/PmcyrenxXht9bBQHJTrKK1lpAbUOyKObNnw/xguypS1
         k/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3yGQn+iiQJUO9GKnXnkOFOtv94PHfEunM5yutQgfYz4=;
        b=XEzp6WSQOyXmMME0S0sNI01Y4S0WQslCYkHWCZzEJXOCNt9Klstua1oooAyxwx/ZFK
         O7/+TvrIHvnWAjAd5HWrZKYz8wi9HfoPZuYu3xyQFvgmA+D1ltTwyojxNcRZxfkGctb2
         Fys+ueF6e1/YxHK4D8q54upt0OkFIp7YsO3V4OK2HA0utyqr+WAZKu+bQj0LT0uFGfQA
         dMUlYYI4wppxbBX+3aS+vywjDF8/IFINsQY4xM8ONZG2gQjc+WNHrM6p0X5aOqIpjEJs
         hbGMHWL2CfkrFKKmRRVJBJwhsA8v4k9Zr6Ao0TKJ63bu6K8mnb+effz5xlfBZdaT4CAV
         OouQ==
X-Gm-Message-State: APjAAAVaTPF1wb4Cev2IPU6je/djORUWCY27AeLZ6EBvOnT2Qrm/j3Bq
        SNCvQ+G1CtxawtCgqa8tDfw=
X-Google-Smtp-Source: APXvYqwjTogqYXJ/8/ZBbuTkMsannOQsuO+jop3OO+IlN09OCUIHRza2bNsjA5C6osCWH3aSy1CMgg==
X-Received: by 2002:a17:90a:2a44:: with SMTP id d4mr22653988pjg.91.1575091878527;
        Fri, 29 Nov 2019 21:31:18 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id a13sm26131734pfi.187.2019.11.29.21.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 21:31:18 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, arnd@arndb.de, jlayton@kernel.org,
        ceph-devel@vger.kernel.org
Subject: [PATCH 4/7] fs: ceph: Delete timespec64_trunc() usage
Date:   Fri, 29 Nov 2019 21:30:27 -0800
Message-Id: <20191130053030.7868-5-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191130053030.7868-1-deepa.kernel@gmail.com>
References: <20191130053030.7868-1-deepa.kernel@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since ceph always uses ns granularity, skip the
truncation which is a no-op.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: jlayton@kernel.org
Cc: ceph-devel@vger.kernel.org
---
 fs/ceph/mds_client.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 068b029cf073..c2aa290f6c3e 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2088,8 +2088,7 @@ ceph_mdsc_create_request(struct ceph_mds_client *mdsc, int op, int mode)
 	init_completion(&req->r_safe_completion);
 	INIT_LIST_HEAD(&req->r_unsafe_item);
 
-	ktime_get_coarse_real_ts64(&ts);
-	req->r_stamp = timespec64_trunc(ts, mdsc->fsc->sb->s_time_gran);
+	ktime_get_coarse_real_ts64(&req->r_stamp);
 
 	req->r_op = op;
 	req->r_direct_mode = mode;
-- 
2.17.1

