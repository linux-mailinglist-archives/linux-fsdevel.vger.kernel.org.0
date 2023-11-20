Return-Path: <linux-fsdevel+bounces-3184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E36567F0B48
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 05:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 290C71C208CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 04:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB635226;
	Mon, 20 Nov 2023 04:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="d0vGKCk4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614F9D4D
	for <linux-fsdevel@vger.kernel.org>; Sun, 19 Nov 2023 20:15:35 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6cb9dd2ab56so363897b3a.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 Nov 2023 20:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700453735; x=1701058535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3yQNAV5i9i/OMA9ll/UNVMs7Fn6oZ5qFKK0D5McEKU=;
        b=d0vGKCk4zGx5Jop+QSR74xHH7BtSZE4ftth39YxjQjjfWGuayxxLq6UGPNKNIBdiL3
         GMSRSFvGFpl0PNU/DJi2xAwEa/ViynzkTEky0lpHfIEBeDA4So6liI0SPR68ahTSPPmf
         ghzbSc0j3L2ctAB282Uuc9MDfvqEfDIVffnesBwajJm5eHgJjXePpZbuH3Z/1MGVVfkd
         5UpZI3iOkccLRez16SQKjYsx2LoK2tJQ6C5GQcOEjqu6MVbHuLI6vWl5qAKHlRu2VCQ1
         NcNp6f2vM+fziWBp0+hN+Y5KsEw1VGFeg2KRmAXwtpjDjI/EH6oRRqrk2gRPzkAH1Qkz
         KCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700453735; x=1701058535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3yQNAV5i9i/OMA9ll/UNVMs7Fn6oZ5qFKK0D5McEKU=;
        b=B13c7ZeO+9i7bc3g0CqLaXIYWrYqO2/X1LdeJZkDZjVK0F8oRlW2TT7O2gEMO29M6F
         FISI49ilZKtf+544sYl+UZf93Gdl1y/p5zJ8EKei/xNJe4JYlQ3wpOy/pyccHoymqtwE
         ERVRi1Pv4gzGcMcMwJKrnOqoRmZcMlC6FLfYsUqg37s4ahjcOIURvI8FyrU+CamktlJx
         Xmqt3J8rwxi44xhB9S4KflkvwlgFqAqI8YzUX0vArPEElvmbMmpkySDYliAROzjLZ3AU
         Od0CTJJ18RTvKnJsCtoE8VbB0Kqd4jZbizlLy623uiCSx+JvlYwfueze84JLhxaEkymR
         MMyQ==
X-Gm-Message-State: AOJu0YzIM+xoLJCyOKVb80aCSPHrk3Q6bf5PinThFctgaJ3lBLvTJSMA
	E5bOcRHr1eFdhJ1K6++yULBNXA==
X-Google-Smtp-Source: AGHT+IFkSm1NBdoY7dzAdsWmGn420PY4USgPH4erEC9WZuyziRFrX75OKDKwLGHvlN5iggDKFyl5pw==
X-Received: by 2002:a05:6a20:438d:b0:187:b4f2:b025 with SMTP id i13-20020a056a20438d00b00187b4f2b025mr5073423pzl.27.1700453734859;
        Sun, 19 Nov 2023 20:15:34 -0800 (PST)
Received: from C02G705SMD6V.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id h18-20020a170902f7d200b001cc4e477861sm5065266plw.212.2023.11.19.20.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 20:15:34 -0800 (PST)
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
Subject: [PATCH V6 RESEND 4/5] cachefiles: narrow the scope of triggering EPOLLIN events in ondemand mode
Date: Mon, 20 Nov 2023 12:14:21 +0800
Message-Id: <20231120041422.75170-5-zhujia.zj@bytedance.com>
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

Don't trigger EPOLLIN when there are only reopening read requests in
xarray.

Suggested-by: Xin Yin <yinxin.x@bytedance.com>
Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/daemon.c   | 14 ++++++++++++--
 fs/cachefiles/internal.h | 12 ++++++++++++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index aa4efcabb5e3..70caa1946207 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -355,14 +355,24 @@ static __poll_t cachefiles_daemon_poll(struct file *file,
 					   struct poll_table_struct *poll)
 {
 	struct cachefiles_cache *cache = file->private_data;
+	XA_STATE(xas, &cache->reqs, 0);
+	struct cachefiles_req *req;
 	__poll_t mask;
 
 	poll_wait(file, &cache->daemon_pollwq, poll);
 	mask = 0;
 
 	if (cachefiles_in_ondemand_mode(cache)) {
-		if (!xa_empty(&cache->reqs))
-			mask |= EPOLLIN;
+		if (!xa_empty(&cache->reqs)) {
+			rcu_read_lock();
+			xas_for_each_marked(&xas, req, ULONG_MAX, CACHEFILES_REQ_NEW) {
+				if (!cachefiles_ondemand_is_reopening_read(req)) {
+					mask |= EPOLLIN;
+					break;
+				}
+			}
+			rcu_read_unlock();
+		}
 	} else {
 		if (test_bit(CACHEFILES_STATE_CHANGED, &cache->flags))
 			mask |= EPOLLIN;
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index b9a90f1a0c01..26e5f8f123ef 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -329,6 +329,13 @@ cachefiles_ondemand_set_object_##_state(struct cachefiles_object *object) \
 CACHEFILES_OBJECT_STATE_FUNCS(open, OPEN);
 CACHEFILES_OBJECT_STATE_FUNCS(close, CLOSE);
 CACHEFILES_OBJECT_STATE_FUNCS(reopening, REOPENING);
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
@@ -359,6 +366,11 @@ static inline int cachefiles_ondemand_init_obj_info(struct cachefiles_object *ob
 static inline void cachefiles_ondemand_deinit_obj_info(struct cachefiles_object *obj)
 {
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


