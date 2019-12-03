Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04AC510F6EC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2019 06:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfLCFUO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Dec 2019 00:20:14 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34988 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfLCFUN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Dec 2019 00:20:13 -0500
Received: by mail-pl1-f196.google.com with SMTP id s10so1215187plp.2;
        Mon, 02 Dec 2019 21:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uY2QG58kzGEqaCGR7UmQKvscEap1XpvW7KPcaFFGZH0=;
        b=Dwv7oCgyLvufvYLeLRzMwe6yJWXvwTZcsL4hY36GtT6tUoG+/ujy697/eU9HOVoVeD
         61kUnWfMnw7InOz5Zx+IyK06HBrzit+48tCEBba3bnstghTMM9BteNOU2CostXaY5GB+
         OHgQJ9Yayd96Vj1r8Xic4WDPeQgfxVAopDZIzhAYkCcyAf2A5ZMRWnE23CdHsV2aYsV8
         S9ZrVro0inM5m8RIkdpmz7FpcwAAtMdXoKVR30kQ8o57N3N5uCg1IwTfyWUtlhdWD08p
         P+VhLoJ+X3adQP86EiasnJ+zwhKSLVh/3Hyz0Q25jZzqycSzZYx2BJ1kQ1L5NMjqwQQj
         MUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uY2QG58kzGEqaCGR7UmQKvscEap1XpvW7KPcaFFGZH0=;
        b=VeW8C8i6kG0rTm8MAiyWJKTITzei1PlfKz/zqy2GMi5i5LIlYgqHeiZQzqoH40GYtD
         y027rKoKLEEOF+WZofXcaRn4BJdsGt8YleoMoTj8HH8ppcekTPM8gINZpE+q/WDJkuPn
         cFBviotIJcezvn0z3W0Etq5zcG98LC14iK3qwDN9kmHAufk8sf8kMtvEYO05V/PhoBHH
         IEabXvaQF0ir/leuN4o2JQmWqmgxGD5p66NxdyPXZi3MAB9HY2SY+/2KUu7UTb9OBbxI
         9UdNCjW4Tzorbl/6Itm76b1udpjzeB4Sap1PPh/MBBv+3QN7ZBUDDIOyDMBPnr2r9mSe
         YZDA==
X-Gm-Message-State: APjAAAU+P7LgnsuQsWvkBB6hjp6vLpP00ZrvaLxp0pv1XVsiTTRShNNu
        KXLEB57+zPKaVvd1Hwx30IslQuJR
X-Google-Smtp-Source: APXvYqzDgx8INoeZxdQp1PJtJjENI+ChJSa1vX6DYbZjaNzNcWkYL193jZVNhMWOY/a0Mw1ZTEqQsw==
X-Received: by 2002:a17:90a:a114:: with SMTP id s20mr3579555pjp.44.1575350413045;
        Mon, 02 Dec 2019 21:20:13 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id h9sm1451915pgk.84.2019.12.02.21.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 21:20:12 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, arnd@arndb.de, jlayton@kernel.org,
        ceph-devel@vger.kernel.org
Subject: [PATCH v2 3/6] fs: ceph: Delete timespec64_trunc() usage
Date:   Mon,  2 Dec 2019 21:19:42 -0800
Message-Id: <20191203051945.9440-4-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191203051945.9440-1-deepa.kernel@gmail.com>
References: <20191203051945.9440-1-deepa.kernel@gmail.com>
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
 fs/ceph/mds_client.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 068b029cf073..88687ed65cff 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2069,7 +2069,6 @@ struct ceph_mds_request *
 ceph_mdsc_create_request(struct ceph_mds_client *mdsc, int op, int mode)
 {
 	struct ceph_mds_request *req = kzalloc(sizeof(*req), GFP_NOFS);
-	struct timespec64 ts;
 
 	if (!req)
 		return ERR_PTR(-ENOMEM);
@@ -2088,8 +2087,7 @@ ceph_mdsc_create_request(struct ceph_mds_client *mdsc, int op, int mode)
 	init_completion(&req->r_safe_completion);
 	INIT_LIST_HEAD(&req->r_unsafe_item);
 
-	ktime_get_coarse_real_ts64(&ts);
-	req->r_stamp = timespec64_trunc(ts, mdsc->fsc->sb->s_time_gran);
+	ktime_get_coarse_real_ts64(&req->r_stamp);
 
 	req->r_op = op;
 	req->r_direct_mode = mode;
-- 
2.17.1

