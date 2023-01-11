Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A976653C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 06:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235874AbjAKFhx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 00:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236020AbjAKFgy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:36:54 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F0D3C725
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 21:25:40 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id jl4so15623542plb.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 21:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pDYD8kdF4QcIxV+XVTzksOOF3bsvD3XSTsyoZ+oU6es=;
        b=OmLcznBUhwb6V7Iv7/A44e+lcoabUFSifrsud2HZbjVV7xNimVZi/xOnDXpfOVYkOV
         0pgBY+uBOAHtdIjKnohFMo4hqlkBl9ZHyeqyzBaySzyKorNmjJiUSWtNAu1MnThr9bZ0
         03dCX3pZ6EOLf0aI13y7Ym+iM2d6scbetEoZSNrRqLYPoVSFETLAuGx1cNfb9JjnrSTc
         mT157ARyhoes8Nqvpe4yrO/lbpCdnXgoypUyCK5igRGq+PUyXMi/WFxz99+plbto03cw
         sJIne/4ds8ktscqloKaTaaJHVs23pSHwZOS/mCkjRrjfeSok1V4aNUnBCpmKLtHysNCz
         qxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pDYD8kdF4QcIxV+XVTzksOOF3bsvD3XSTsyoZ+oU6es=;
        b=FyosYyruU33Mr+hOF/a2ae9C9qfMuuPzhla/KKgdyIWuuZlMG3Z/18yf6WDYlzeyRM
         Emw+47zGuz3UjOspXdOacp0NVLxu9KS3N6IeUNy+vDCbAHor7lcDLnbDEoyk+2m9QlQc
         VRR7tPprLMDfAAtQ4auM3UN/GBak3zKBd0J6bgCbklLFE+lZEeIn1IGjM77RF6lkYqZK
         w5VOPbKLzqyFR8PqcE5XVE3SwoQGSt6BsaAmCx60/Fazma4qV4W/sqMTr2gbxtkYbSBU
         GthSqZ608e9oV6dBtD7+tMimb4tmLdaWw7MdqPKR+6mje8lUq1jwYDbMSKvgAp4racZZ
         SW+A==
X-Gm-Message-State: AFqh2koYerOUrK2zf2tdbzEmYFGJCnvZb+wscxeFb87kFFi+TgeVN4rL
        1bP3wdReVdoZOdfgaLgCdXCe+Q==
X-Google-Smtp-Source: AMrXdXv2i/melO+AoHL3yfAagLR5DbuQwlvc40wWx8sbnZnmAu95AVugnppbuaMQoO1kuzhzYqENDQ==
X-Received: by 2002:a17:902:968d:b0:192:8d74:99e0 with SMTP id n13-20020a170902968d00b001928d7499e0mr46324926plp.4.1673414739479;
        Tue, 10 Jan 2023 21:25:39 -0800 (PST)
Received: from C02G705SMD6V.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id l10-20020a170903244a00b0019334350ce6sm4934520pls.244.2023.01.10.21.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 21:25:39 -0800 (PST)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     dhowells@redhat.com
Cc:     linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia Zhu <zhujia.zj@bytedance.com>,
        Xin Yin <yinxin.x@bytedance.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: [PATCH V4 4/5] cachefiles: narrow the scope of triggering EPOLLIN events in ondemand mode
Date:   Wed, 11 Jan 2023 13:25:14 +0800
Message-Id: <20230111052515.53941-5-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230111052515.53941-1-zhujia.zj@bytedance.com>
References: <20230111052515.53941-1-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Don't trigger EPOLLIN when there are only reopening read requests in
xarray.

Suggested-by: Xin Yin <yinxin.x@bytedance.com>
Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/daemon.c   | 15 +++++++++++++--
 fs/cachefiles/internal.h | 12 ++++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index aa4efcabb5e3..b8d8f280fb7a 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -355,14 +355,25 @@ static __poll_t cachefiles_daemon_poll(struct file *file,
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
+			xa_lock(xa);
+			xa_for_each_marked(xa, index, req, CACHEFILES_REQ_NEW) {
+				if (!cachefiles_ondemand_is_reopening_read(req)) {
+					mask |= EPOLLIN;
+					break;
+				}
+			}
+			xa_unlock(xa);
+		}
 	} else {
 		if (test_bit(CACHEFILES_STATE_CHANGED, &cache->flags))
 			mask |= EPOLLIN;
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 2ed836d4169e..3d94990a8b38 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -326,6 +326,13 @@ cachefiles_ondemand_set_object_##_state(struct cachefiles_object *object) \
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
 static inline ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 					char __user *_buffer, size_t buflen)
@@ -353,6 +360,11 @@ static inline int cachefiles_ondemand_init_obj_info(struct cachefiles_object *ob
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

