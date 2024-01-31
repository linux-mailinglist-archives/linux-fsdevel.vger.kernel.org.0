Return-Path: <linux-fsdevel+bounces-9685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FAA8446D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 19:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAC7A28C35C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 18:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E724F13A252;
	Wed, 31 Jan 2024 18:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="QN/mleoj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63515130E58
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 18:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706724581; cv=none; b=ILXNwt7W1GC4bmwsWvA36s2SM90qpVUxbk6xGx7dO8xLf3+r1dN8ZwZkouq2HzHUwo3X82dwy87SMwELdDTszQ5nXuhgMXe8O+hSKr6RAQ6TNdrdkQgBkwCJcuRc+LDRv4EwTKRbRife1gfMQfVl7G83X1nijxwbpO8/JDUoWnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706724581; c=relaxed/simple;
	bh=iOH3rDvMU6l8EibI+PkwMyfqV5hY0EoK3y01y1v3/4g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TTWJu8fa/JWrr3LLgGCRpZmOiuJFLEOM2937doW2eN0q6nrRRkj8dHUL5+Er4JDFAPU8PogDvvv1pw1cX0KgA2fNQh6Kn7z8axOXo27anbnQ0z3ghDYTGQ8PMOIIH8kgBrywV4PYfGwfnV4SyK43DjXzyB7A/IQW7cid2FJs8XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=QN/mleoj; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36395ed9a8aso363475ab.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 10:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706724578; x=1707329378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPyBFpA03VgPUcSSFnhqRnjQDUKtK8Zok+qzBXzC1y0=;
        b=QN/mleojEw9HkQpWKu/XT/shVQnhEDCSJnfeqqIU1XjaWrNL1oKAVNbbR1q4FVA8Rp
         9SGHlk517ohEulqpzVOU7svJFvmmTmjqvvc0Uf/UThQfSjVkZWhax/Vdx25yyBrf5T6Z
         ZG87YKxa0QRTrX3AMqbkiWkfms8jWWpSJzNms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706724578; x=1707329378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XPyBFpA03VgPUcSSFnhqRnjQDUKtK8Zok+qzBXzC1y0=;
        b=U8HGbwojnIxTQKFvb43jc73lkycDqA2IVjIy7D3MqW/a6xwN4cAnURJhX1Vg5qLxe7
         yfuKuQ2vK9ij+OfhpkRZAZT28Z5BckfRwj7meUvp1Br+mwGKGOIQ8SKjBCtqLZ4H/H2Z
         AEGhLi6P+fjm0aSmSO2XNDYZ2ew+qhSdpX8qiqHUrfPtuh8OLBaB9DD+0yBL4ydYBqc7
         /SdsCNoVkPs4FwagGUYPFvnUd8XtoIME9UP2XuewBHQ08fcdOy7G2P6UFQdKG9r4vHK6
         Cg6aRsRlsXpL0lL+xZnlI8JwkgCu0nMJQ+LcOGg9PHLBbY60oR5oJ4XuCgjXPGcs8dNS
         3t+g==
X-Gm-Message-State: AOJu0Yz6l2OXJL5DjMluvEx8k/VUgV01jfjE+a55Q+CpBdsWtvVMtq6Z
	AZod21+bOFGR0iBjk7gIkqBYdXI5s1oyVv31UrdJQhxXlpYir/u67QuFlzZDU8Y=
X-Google-Smtp-Source: AGHT+IEQnKYqG5wZ0X43wz7OHNsQvfZ31yCkFYMmNIOE5mHxSsf+XMuiNQRIS776w1It+V6qiBGTjA==
X-Received: by 2002:a05:6e02:1807:b0:363:792c:ac43 with SMTP id a7-20020a056e02180700b00363792cac43mr3605310ilv.3.1706724578489;
        Wed, 31 Jan 2024 10:09:38 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id v24-20020a634818000000b005cfbf96c733sm10876004pga.30.2024.01.31.10.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 10:09:38 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-api@vger.kernel.org,
	brauner@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	alexander.duyck@gmail.com,
	sridhar.samudrala@intel.com,
	kuba@kernel.org,
	willemdebruijn.kernel@gmail.com,
	weiwan@google.com,
	David.Laight@ACULAB.COM,
	arnd@arndb.de,
	Joe Damato <jdamato@fastly.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure))
Subject: [PATCH net-next v5 1/3] eventpoll: support busy poll per epoll instance
Date: Wed, 31 Jan 2024 18:08:03 +0000
Message-Id: <20240131180811.23566-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240131180811.23566-1-jdamato@fastly.com>
References: <20240131180811.23566-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow busy polling on a per-epoll context basis. The per-epoll context
usec timeout value is preferred, but the pre-existing system wide sysctl
value is still supported if it specified.

Note that this change uses an xor: either per epoll instance busy polling
is enabled on the epoll instance or system wide epoll is enabled. Enabling
both is disallowed.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 fs/eventpoll.c | 49 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 3534d36a1474..ce75189d46df 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -227,6 +227,8 @@ struct eventpoll {
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	/* used to track busy poll napi_id */
 	unsigned int napi_id;
+	/* busy poll timeout */
+	u64 busy_poll_usecs;
 #endif
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -386,12 +388,44 @@ static inline int ep_events_available(struct eventpoll *ep)
 		READ_ONCE(ep->ovflist) != EP_UNACTIVE_PTR;
 }
 
+/**
+ * busy_loop_ep_timeout - check if busy poll has timed out. The timeout value
+ * from the epoll instance ep is preferred, but if it is not set fallback to
+ * the system-wide global via busy_loop_timeout.
+ *
+ * @start_time: The start time used to compute the remaining time until timeout.
+ * @ep: Pointer to the eventpoll context.
+ *
+ * Return: true if the timeout has expired, false otherwise.
+ */
+static inline bool busy_loop_ep_timeout(unsigned long start_time, struct eventpoll *ep)
+{
+#ifdef CONFIG_NET_RX_BUSY_POLL
+	unsigned long bp_usec = READ_ONCE(ep->busy_poll_usecs);
+
+	if (bp_usec) {
+		unsigned long end_time = start_time + bp_usec;
+		unsigned long now = busy_loop_current_time();
+
+		return time_after(now, end_time);
+	} else {
+		return busy_loop_timeout(start_time);
+	}
+#endif
+	return true;
+}
+
 #ifdef CONFIG_NET_RX_BUSY_POLL
+static bool ep_busy_loop_on(struct eventpoll *ep)
+{
+	return !!ep->busy_poll_usecs || net_busy_loop_on();
+}
+
 static bool ep_busy_loop_end(void *p, unsigned long start_time)
 {
 	struct eventpoll *ep = p;
 
-	return ep_events_available(ep) || busy_loop_timeout(start_time);
+	return ep_events_available(ep) || busy_loop_ep_timeout(start_time, ep);
 }
 
 /*
@@ -404,7 +438,7 @@ static bool ep_busy_loop(struct eventpoll *ep, int nonblock)
 {
 	unsigned int napi_id = READ_ONCE(ep->napi_id);
 
-	if ((napi_id >= MIN_NAPI_ID) && net_busy_loop_on()) {
+	if ((napi_id >= MIN_NAPI_ID) && ep_busy_loop_on(ep)) {
 		napi_busy_loop(napi_id, nonblock ? NULL : ep_busy_loop_end, ep, false,
 			       BUSY_POLL_BUDGET);
 		if (ep_events_available(ep))
@@ -430,7 +464,8 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
 	struct socket *sock;
 	struct sock *sk;
 
-	if (!net_busy_loop_on())
+	ep = epi->ep;
+	if (!ep_busy_loop_on(ep))
 		return;
 
 	sock = sock_from_file(epi->ffd.file);
@@ -442,7 +477,6 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
 		return;
 
 	napi_id = READ_ONCE(sk->sk_napi_id);
-	ep = epi->ep;
 
 	/* Non-NAPI IDs can be rejected
 	 *	or
@@ -466,6 +500,10 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
 {
 }
 
+static inline bool ep_busy_loop_on(struct eventpoll *ep)
+{
+	return false;
+}
 #endif /* CONFIG_NET_RX_BUSY_POLL */
 
 /*
@@ -2058,6 +2096,9 @@ static int do_epoll_create(int flags)
 		error = PTR_ERR(file);
 		goto out_free_fd;
 	}
+#ifdef CONFIG_NET_RX_BUSY_POLL
+	ep->busy_poll_usecs = 0;
+#endif
 	ep->file = file;
 	fd_install(fd, file);
 	return fd;
-- 
2.25.1


