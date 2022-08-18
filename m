Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857DD5984DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 15:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245378AbiHRNxf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 09:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245356AbiHRNxI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:53:08 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271EA6555F
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Aug 2022 06:52:56 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id x19so1563380plc.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Aug 2022 06:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=gH5/oCi30DEBEz19XNsVtoVzaMHu/eBGPrlN2e1Y2h0=;
        b=rGllJ5qfUKtgRcE6ph85inw6yJ/YbZxn/wFWsyQ7ROH2rCs31NiBACpx7H7Muz3lqH
         Rnh0DAKL15v0O+ccWZpbJgGIoZQN2nMg1XB2xV6pf/bt03k6ttpgkkYmwEDuXdV8IDJi
         DmhJb88Y/BaK9TFk9JopbxPHtjay1COsouFWqklIWkkwoDzbENOLtz5/DxckQOR4vG4u
         k/2RcaJXCAvLPIRplAk8Jq6jPowhJeG/CyWiUddUwlcmUnQAwsFcL09hDtd5Zn4U0Td4
         dRv0RWiDimE8V3nV39YGAEZZc41wDRLqyJQQW6ARLX5RIQQz7RhFnbKp1Knw12QHDHB7
         ZMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=gH5/oCi30DEBEz19XNsVtoVzaMHu/eBGPrlN2e1Y2h0=;
        b=44P0FC53QLTps0sfn9cAJ7t+TITxEPu3l76Rvw1/Eu996Z32NXj4mWAFqJMJS7/TIE
         W3n9RrA909NgCbdwsktdVGNwx7YRV6WdbDxcMFneox5yejuo/29bW4TPS/gFAt5lMOrv
         MM4yCpfUAm64zm7JOqVAVgYU/KYGY86ecWXnHSMiao5Z7WiOyfLxl9rrqOpfFPe6SeZf
         wG6RqiguODTlaiJADiSpJVm1jfAZ9ZO2Ysx2Lo3mcLhSDbiadUQf6i9lDOug9cvmSKpN
         X567OEiPjxUc9Exf7HrKUJ2wQIKoR7t4WZQvKWlAUi/Na9vKyadYb6wSKM9YbTY5Eg9l
         10xA==
X-Gm-Message-State: ACgBeo1gVdGgcQcY+KnSIIZRgteUaxJ9kbluf4f03chbQ61aKkHibJfq
        hZ2fNUfhaCo5p+0V20navGvZAg==
X-Google-Smtp-Source: AA6agR4vq2EHchwptoVCg1mL3pnZdHv9shuA3Z4UdpvUSOc05rSXrUr55WTmmTrNbpL0lo6Pne9Iow==
X-Received: by 2002:a17:90b:3a85:b0:1fa:bf98:5e3e with SMTP id om5-20020a17090b3a8500b001fabf985e3emr3183373pjb.102.1660830776207;
        Thu, 18 Aug 2022 06:52:56 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id k17-20020a170902ce1100b0016db0d877e4sm1385697plg.221.2022.08.18.06.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 06:52:55 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     dhowells@redhat.com, xiang@kernel.org, jefflexu@linux.alibaba.com
Cc:     linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, Jia Zhu <zhujia.zj@bytedance.com>
Subject: [RFC PATCH 4/5] cachefiles: narrow the scope of triggering EPOLLIN events in ondemand mode
Date:   Thu, 18 Aug 2022 21:52:03 +0800
Message-Id: <20220818135204.49878-5-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20220818135204.49878-1-zhujia.zj@bytedance.com>
References: <20220818135204.49878-1-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Don't trigger EPOLLIN when there are only reopening read requests in
xarray.

Suggested-by: Xin Yin <yinxin.x@bytedance.com>
Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
---
 fs/cachefiles/daemon.c   | 13 +++++++++++--
 fs/cachefiles/internal.h | 12 ++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index aa4efcabb5e3..c74bd1f4ecf5 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -355,14 +355,23 @@ static __poll_t cachefiles_daemon_poll(struct file *file,
 					   struct poll_table_struct *poll)
 {
 	struct cachefiles_cache *cache = file->private_data;
+	struct xarray *xa = &cache->reqs;
+	struct cachefiles_req *req;
+	unsigned long index;
 	__poll_t mask;
 
 	poll_wait(file, &cache->daemon_pollwq, poll);
 	mask = 0;
 
 	if (cachefiles_in_ondemand_mode(cache)) {
-		if (!xa_empty(&cache->reqs))
-			mask |= EPOLLIN;
+		if (!xa_empty(xa)) {
+			xa_for_each_marked(xa, index, req, CACHEFILES_REQ_NEW) {
+				if (!cachefiles_ondemand_is_reopening_read(req)) {
+					mask |= EPOLLIN;
+					break;
+				}
+			}
+		}
 	} else {
 		if (test_bit(CACHEFILES_STATE_CHANGED, &cache->flags))
 			mask |= EPOLLIN;
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 66bbd4f1d22a..b4af67f1cbd6 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -344,6 +344,13 @@ cachefiles_ondemand_set_object_##_state(struct cachefiles_object *object) \
 CACHEFILES_OBJECT_STATE_FUNCS(open);
 CACHEFILES_OBJECT_STATE_FUNCS(close);
 CACHEFILES_OBJECT_STATE_FUNCS(reopening);
+
+static inline bool cachefiles_ondemand_is_reopening_read(struct cachefiles_req *req)
+{
+	return cachefiles_ondemand_object_is_reopening(req->object) &&
+			req->msg.opcode == CACHEFILES_OP_READ;
+}
+
 #else
 #define CACHEFILES_ONDEMAND_OBJINFO(object)	NULL
 
@@ -373,6 +380,11 @@ static inline int cachefiles_ondemand_init_obj_info(struct cachefiles_object *ob
 {
 	return 0;
 }
+
+static inline bool cachefiles_ondemand_is_reopening_read(struct cachefiles_req *req)
+{
+	return false;
+}
 #endif
 
 /*
-- 
2.20.1

