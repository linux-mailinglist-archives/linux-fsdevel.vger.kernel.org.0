Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2B86E2934
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 19:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjDNRXv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 13:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjDNRXo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 13:23:44 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF86476B4
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 10:23:37 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id k65-20020a17090a3ec700b00247131783f7so4592083pjc.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 10:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681493017; x=1684085017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgUvM997QJXfBj7OoFl5jxJ2P02ysazlJ3MfSoqKoTg=;
        b=T3zZn09jU30v3X8gm7zDVFka4YxfNrNYqbfTW7odCAvrYSgeHu3+TWK/Uex+lInrl0
         ZR1SLxQQ2glTEULCFiZ8A/qnkb3MFe92XInJENc/PcgdijaRXP2jIN6X1kDLUnP++6IQ
         QxplK7Pa9BQFppNM64xGUztMw2VnSlZCV2zATAGfF/9q2HqmOLCVZbagxFdEGTigAVE7
         RRP7UH3QmA5SfzjT8wMk+gaqYPYHMimKUVP4jk4csTXP/FrA5rfpwAOvMO2aZza7K1yL
         I+DdpAxZdgWcfk37FG8L7ECQ6ETodw8zhueKCA6Z7daSTQ1CBJEUdu45EQFDRCXK1SVa
         kMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681493017; x=1684085017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qgUvM997QJXfBj7OoFl5jxJ2P02ysazlJ3MfSoqKoTg=;
        b=C5rrnLls7w7hSnMVSsg/l06SR+8eeVYSn1bwm7p4LiDQnT/Jgh1l1IweN5CisGYcJW
         KYZbI+ab9vogWH36ZwSYvsr02gCnLXKm2TzijN0Kf2JWejKwh4sOaMrFvPmmHmuE3qGZ
         vz3Jqlffc+fdXtb8qIQLHKmB2H5wrZllvumJdDPMlyvFz3pItfCM5tZnHXUPfGN9WeRp
         ujX7Po82EL+uxA9Fue76EssPCIazn2WpYfrLZ8hk66xwvzP1M+a7RSCpnRlWvv45sose
         kAx7hbE6ei7RNf0NzRHCHhFB5BTJ9z1z2Bbn/QOnt9MqHt9ScvACyiasA4m38Fn7pZv9
         BwuQ==
X-Gm-Message-State: AAQBX9cHolePkVsTYbi5mpMAuoDmRtMB9PTxUzNVhNSDoY8NWDYWNc3a
        9F7JIojG/ZfqRUuLFidWFKwDnA4stiJT1xdosqTBtA==
X-Google-Smtp-Source: AKy350aBgZHg/laFWLHOBjKb0DZ6Hi2flL729hh8PovcVeBU4tyJFAUENy+tE8fTCKXuvB2+OR9kVQ==
X-Received: by 2002:a05:6a20:8f2a:b0:ee:b24e:a40b with SMTP id b42-20020a056a208f2a00b000eeb24ea40bmr335653pzk.53.1681493017046;
        Fri, 14 Apr 2023 10:23:37 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id q12-20020a631f4c000000b0051b8172fa68sm370315pgm.38.2023.04.14.10.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 10:23:36 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com
Cc:     linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, jefflexu@linux.alibaba.com,
        hsiangkao@linux.alibaba.com, Jia Zhu <zhujia.zj@bytedance.com>,
        Xin Yin <yinxin.x@bytedance.com>
Subject: [PATCH V6 5/5] cachefiles: add restore command to recover inflight ondemand read requests
Date:   Sat, 15 Apr 2023 01:22:39 +0800
Message-Id: <20230414172239.33743-6-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230414172239.33743-1-zhujia.zj@bytedance.com>
References: <20230414172239.33743-1-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Previously, in ondemand read scenario, if the anonymous fd was closed by
user daemon, inflight and subsequent read requests would return EIO.
As long as the device connection is not released, user daemon can hold
and restore inflight requests by setting the request flag to
CACHEFILES_REQ_NEW.

Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/daemon.c   |  1 +
 fs/cachefiles/internal.h |  3 +++
 fs/cachefiles/ondemand.c | 23 +++++++++++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 70caa1946207d..3f24905f40661 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -77,6 +77,7 @@ static const struct cachefiles_daemon_cmd cachefiles_daemon_cmds[] = {
 	{ "tag",	cachefiles_daemon_tag		},
 #ifdef CONFIG_CACHEFILES_ONDEMAND
 	{ "copen",	cachefiles_ondemand_copen	},
+	{ "restore",	cachefiles_ondemand_restore	},
 #endif
 	{ "",		NULL				}
 };
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 26e5f8f123ef1..4a87c9d714a94 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -303,6 +303,9 @@ extern ssize_t cachefiles_ondemand_daemon_read(struct cachefiles_cache *cache,
 extern int cachefiles_ondemand_copen(struct cachefiles_cache *cache,
 				     char *args);
 
+extern int cachefiles_ondemand_restore(struct cachefiles_cache *cache,
+					char *args);
+
 extern int cachefiles_ondemand_init_object(struct cachefiles_object *object);
 extern void cachefiles_ondemand_clean_object(struct cachefiles_object *object);
 
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 8e130de952f7d..b8fbbb1961bbc 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -182,6 +182,29 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
 	return ret;
 }
 
+int cachefiles_ondemand_restore(struct cachefiles_cache *cache, char *args)
+{
+	struct cachefiles_req *req;
+
+	XA_STATE(xas, &cache->reqs, 0);
+
+	if (!test_bit(CACHEFILES_ONDEMAND_MODE, &cache->flags))
+		return -EOPNOTSUPP;
+
+	/*
+	 * Reset the requests to CACHEFILES_REQ_NEW state, so that the
+	 * requests have been processed halfway before the crash of the
+	 * user daemon could be reprocessed after the recovery.
+	 */
+	xas_lock(&xas);
+	xas_for_each(&xas, req, ULONG_MAX)
+		xas_set_mark(&xas, CACHEFILES_REQ_NEW);
+	xas_unlock(&xas);
+
+	wake_up_all(&cache->daemon_pollwq);
+	return 0;
+}
+
 static int cachefiles_ondemand_get_fd(struct cachefiles_req *req)
 {
 	struct cachefiles_object *object;
-- 
2.20.1

