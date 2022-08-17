Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC035969F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 09:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiHQHAn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 03:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbiHQHAk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 03:00:40 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462C477E9B
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 00:00:34 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id d65-20020a17090a6f4700b001f303a97b14so1026775pjk.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 00:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Xbm/wyqskz5snHxq2g1yeZAZ3+AJBvaKvNU9/dTWKU8=;
        b=J7lQzL6DbyaZqiaelUyc3lIuVhBm18PSRgdzyCSP3CflVLDQjNA+GyI4dIHLVZMA6N
         U478skiJtSu7dn2U5YryxuxNDUCPtqmCgJbS1qBJEek6H2a7bjf8XyRMrM4anonmmW0v
         kfWt48mjlnnw+Ark90RAkvr9AQp9AunwUNFjht9V4xjBOHVbYYvOiOfFP0zljAEATsxd
         +A9NTohFNCKWVGqTGr50+w2+PXe2OtHVWjzLvh9BOVntiYi2EWVxriqDwr0rgAyELWXw
         ir6MXMZ0FtyK6KHzpRAY2fbwpAOmvVjg0R+DM8d7xU7cdzesXT8IpFBXC0A57V5Sg4Q+
         QhBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Xbm/wyqskz5snHxq2g1yeZAZ3+AJBvaKvNU9/dTWKU8=;
        b=4Tayy7a+i86796PKLpXVm2SPLu2HD5mc+R3Lun84tIyPFXGV6pCED+rNFwsMp7vNSy
         UH0z8Aa+9yQZ4mwY8M7m4jEDVno0lX4g7sbM9Af8T+t/yqHfs53qILGQBpXa9BFCPZfx
         HrFjD3PRZ9KHmSwKw1/uUJf8XwZ63fFGyJkgo0S06FaEt7fp+ftotl03knEP2+0paD+T
         XVtB7RLIIwaR6cFIKDib1RtvFRSEx0AO6j5pEgVB7xh610KiGsJ56Dmbu6+dN/lvKTnV
         lARkIRalMngGFpda5TmCLMZaentzvj9uJVxleNDwZKF2o59D2du6nnF4Tjxk4hVP/bsB
         tMQg==
X-Gm-Message-State: ACgBeo0VWF+tra3FEiieH6Pc84JzehHcp60A7QPtfjYpWTCoIY/DLYP1
        Gm4pwvi4Pl6tJjcbGsMUFBJTmQ==
X-Google-Smtp-Source: AA6agR7MR1nDPn694Df7E6dSO8plWbt83o/ItWckji2Jh6DpRFkl2sbG0GzwTd39dbt+uXJ/h2LThQ==
X-Received: by 2002:a17:90a:ac0f:b0:1f5:555:c37 with SMTP id o15-20020a17090aac0f00b001f505550c37mr2347114pjq.37.1660719633747;
        Wed, 17 Aug 2022 00:00:33 -0700 (PDT)
Received: from yinxin.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id ja19-20020a170902efd300b0016d4f05eb95sm581779plb.272.2022.08.17.00.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 00:00:33 -0700 (PDT)
From:   Xin Yin <yinxin.x@bytedance.com>
To:     dhowells@redhat.com, xiang@kernel.org, jefflexu@linux.alibaba.com
Cc:     linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        zhujia.zj@bytedance.com, Xin Yin <yinxin.x@bytedance.com>,
        Yongqing Li <liyongqing@bytedance.com>
Subject: [PATCH] cachefiles: make on-demand request distribution fairer
Date:   Wed, 17 Aug 2022 14:52:00 +0800
Message-Id: <20220817065200.11543-1-yinxin.x@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For now, enqueuing and dequeuing on-demand requests all start from
idx 0, this makes request distribution unfair. In the weighty
concurrent I/O scenario, the request stored in higher idx will starve.

Searching requests cyclically in cachefiles_ondemand_daemon_read,
makes distribution fairer.

Reported-by: Yongqing Li <liyongqing@bytedance.com>
Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
---
 fs/cachefiles/internal.h |  1 +
 fs/cachefiles/ondemand.c | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 6cba2c6de2f9..2ad58c465208 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -111,6 +111,7 @@ struct cachefiles_cache {
 	char				*tag;		/* cache binding tag */
 	refcount_t			unbind_pincount;/* refcount to do daemon unbind */
 	struct xarray			reqs;		/* xarray of pending on-demand requests */
+	unsigned long			req_id_next;
 	struct xarray			ondemand_ids;	/* xarray for ondemand_id allocation */
 	u32				ondemand_id_next;
 };
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 1fee702d5529..247961d65369 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -238,14 +238,19 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 	unsigned long id = 0;
 	size_t n;
 	int ret = 0;
-	XA_STATE(xas, &cache->reqs, 0);
+	XA_STATE(xas, &cache->reqs, cache->req_id_next);
 
 	/*
-	 * Search for a request that has not ever been processed, to prevent
-	 * requests from being processed repeatedly.
+	 * Cyclically search for a request that has not ever been processed,
+	 * to prevent requests from being processed repeatedly, and make
+	 * request distribution fair.
 	 */
 	xa_lock(&cache->reqs);
 	req = xas_find_marked(&xas, UINT_MAX, CACHEFILES_REQ_NEW);
+	if (!req && cache->req_id_next > 0) {
+		xas_set(&xas, 0);
+		req = xas_find_marked(&xas, cache->req_id_next - 1, CACHEFILES_REQ_NEW);
+	}
 	if (!req) {
 		xa_unlock(&cache->reqs);
 		return 0;
@@ -260,6 +265,7 @@ ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 	}
 
 	xas_clear_mark(&xas, CACHEFILES_REQ_NEW);
+	cache->req_id_next = xas.xa_index + 1;
 	xa_unlock(&cache->reqs);
 
 	id = xas.xa_index;
-- 
2.25.1

