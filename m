Return-Path: <linux-fsdevel+bounces-3185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEA67F0B4A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 05:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B16E1C2090D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 04:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7195823A2;
	Mon, 20 Nov 2023 04:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cRiHIofC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80164194
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Nov 2023 20:15:39 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc9b626a96so28410585ad.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Nov 2023 20:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700453739; x=1701058539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1pCEGuj3QlPT+22tLUxveNeazv04i3uHRdJIvmcJDY=;
        b=cRiHIofC6lBoTaNGTTXbgD5XM/5YYq0ngFcBNUcvj2nDMUYqtDxAGlMRyixQ4LCOs+
         V8psW/TBZKZsm8963Cp49DrQEcf9eQebkTu6YIPlXMuP3n3nenXtINtdz9bY2EDyzayD
         2AZbi/TSiWP0LtSp9ocWpJbfhOvEa1NaQI1wJU1bkFCEwe7fqmgOrbkR8WBGVB3JcZU4
         hxGx+LVJypDcjabd+thD8NOFNkvW6sx/p0EZWUCXTz1qis9b6/QNr9nLQhZAiCF/AWAC
         vtRFPBEnXyCugRrZpsR1jCNGx3xYLErrlRNxdhn2rcy7HDg/ndVQLxMhNfUvs4c/x7fG
         bBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700453739; x=1701058539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1pCEGuj3QlPT+22tLUxveNeazv04i3uHRdJIvmcJDY=;
        b=Y/pOlnCU17c/43Y237YffHhKbZkif8YzmacfE3hZU5Vw4kKFxMTuy+Wi8AMW6sD4ON
         a8Y8aUJK0Bwy0Fa1avpcO12BTBxGPEN8Xo2vqZML/JgSM+2iZFKeEu8FrIVUXNpgT4ux
         4ofEHfM5royTN/D6LtTDi3qHAmzlS7xsygEXMls5YXHPtMFuXqnb0uAOKe4lvqT14MwX
         uzJ0j1pt5O0+3xNY0LhzaVhHJDwMw7GAMKaRm8JLQJSNww6X5NemF48AS90RmGrwJHB5
         9B/1KNDjS+NxT0mSNeUu5mzI7BKQL5Q1mFmZbVGVOaGNeiq1IpA1sKixm/+1YOlwxE1K
         3Qbw==
X-Gm-Message-State: AOJu0YwIqlY3jEh/y60DCrp95T4Z6JstLiwiNDc21KZP8wOwLb7poRod
	AM4qUAMT2KBjUT9GnPbw7rLNqQ==
X-Google-Smtp-Source: AGHT+IF1cVI+2neDu9j2yxeuSo0UsEVuHEe5IYfjic0fxvskW7o2Dkv7YVI+VOm6U5rYdsHBVkmZtw==
X-Received: by 2002:a17:902:d2d2:b0:1ce:67fa:b398 with SMTP id n18-20020a170902d2d200b001ce67fab398mr4710323plc.16.1700453739021;
        Sun, 19 Nov 2023 20:15:39 -0800 (PST)
Received: from C02G705SMD6V.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id h18-20020a170902f7d200b001cc4e477861sm5065266plw.212.2023.11.19.20.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 20:15:38 -0800 (PST)
From: Jia Zhu <zhujia.zj@bytedance.com>
To: dhowells@redhat.com,
	linux-cachefs@redhat.com
Cc: linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jefflexu@linux.alibaba.com,
	hsiangkao@linux.alibaba.com,
	Jia Zhu <zhujia.zj@bytedance.com>,
	Xin Yin <yinxin.x@bytedance.com>
Subject: [PATCH V6 RESEND 5/5] cachefiles: add restore command to recover inflight ondemand read requests
Date: Mon, 20 Nov 2023 12:14:22 +0800
Message-Id: <20231120041422.75170-6-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20231120041422.75170-1-zhujia.zj@bytedance.com>
References: <20231120041422.75170-1-zhujia.zj@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 70caa1946207..3f24905f4066 100644
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
index 26e5f8f123ef..4a87c9d714a9 100644
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
index 8e130de952f7..b8fbbb1961bb 100644
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


