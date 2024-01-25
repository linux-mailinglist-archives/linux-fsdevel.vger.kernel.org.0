Return-Path: <linux-fsdevel+bounces-9016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B10A83CFE1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 00:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1E61F21CF3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 23:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3A817BC9;
	Thu, 25 Jan 2024 22:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="gK/gao8L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83165134A5
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jan 2024 22:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706223470; cv=none; b=DXp0DksnZnNz+HIJ3S3ueNSRU2aHH1cKIFJ/ryWd3ZjEtSsR/pz4hPcWa7bxTMrT0UfKVc2l9AKZ1l1fonNMAKpgFU06caQA1/Tr/A5QzrgMiBjDh5YOIkrV5qzM9HPXulK63+y737cqPQHnqG/pODs6cwVJfkxobwssFbZxbFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706223470; c=relaxed/simple;
	bh=3yteI2ybUubAH5CujHpgcS7qoJxKc8vJCs7EzjX9vMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sx4+LNpLYjy3KQOaTTAHSjrbxTSM0LqC4rv2VPb4KKyWVTtz8L3XyUJgjtHqtYIuaQVKP17iFRZpDVyHfOwSqDBWASr/AbpvWB3HUEP+VaR5vti9Zp+c75lrNlGjlKVTUKkqWEdjIPdvDcpnxAjkpD/rTR2g8zLnNexbrK+FUEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=gK/gao8L; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-362a24b13e6so4780755ab.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jan 2024 14:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706223468; x=1706828268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o95DHArKhHsVxZUrtiTfK3GJrg5R+5zGPrNbLEZjDzs=;
        b=gK/gao8LZPQ14f+0l1Z/+ivgHpju3xt99PQTI/cOjX4zckT76Ao7/ofkfMZOM/dKY3
         huhuUoAasEEsNHDBwxKIkVMhT1VBnxGfnbjiPJKJbswZYdFIkXci5IsVQOmx9poTHHD1
         hWZFcA8fGZDbx+laWc3yhOV75Uj8m/jdqrEIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706223468; x=1706828268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o95DHArKhHsVxZUrtiTfK3GJrg5R+5zGPrNbLEZjDzs=;
        b=Nd/7zi7jM5m6u+BzXE6HQDJFNhxQOHA4A8o1yFJYgnHc6SnoxUyWkXatB38gsOSSWU
         ffGXsk/ZMuZV2ykIgADSsZ11tIIblnBJzWugGWFgHBZ873FzRoc+HKdjOmn7ea2jdGBS
         TlI/V1JgDxDlzsdckSJUxvhljW8g4COCBzTpZlELTrxv9LHGYhcLoZAnPRJTjcIHh9py
         JEgjqk5V7lxKgaCTDCf7Adl7RHgnEmhQ24p/ZLeB2pHDP6lKfVmkSKnn7tK4/GS4pWeJ
         vPylIhhO3dOG1HUHKOOh+tXQ9cpjLIZI/vd/wm/5N4rZ8Z5oBKDMW3gFRnRZ3kcy7RqS
         X6Qw==
X-Gm-Message-State: AOJu0YxY8CNplHBGmRa+pq9fgGkxBqJy6s/8Gs1/DOP62bRQDlWBcgqD
	BRIu4nYJ8ZHMXyLozc+fyW6s6F2Fqoe1fg5RgB6d7zbVnI2N2ebkIQ478b0asng=
X-Google-Smtp-Source: AGHT+IGAK1VuD1OD6e8Ft02aMvZ4LCBGzC3c9/ElbXUFGVr5EYlwpCty3o6SVFhtKkGYwoGiIA7Yrw==
X-Received: by 2002:a05:6e02:12ea:b0:360:76fb:a894 with SMTP id l10-20020a056e0212ea00b0036076fba894mr557277iln.62.1706223467756;
        Thu, 25 Jan 2024 14:57:47 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id z24-20020a631918000000b005d68962e1a7sm19948pgl.24.2024.01.25.14.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 14:57:47 -0800 (PST)
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
	Joe Damato <jdamato@fastly.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure))
Subject: [PATCH net-next v3 2/3] eventpoll: Add per-epoll busy poll packet budget
Date: Thu, 25 Jan 2024 22:56:58 +0000
Message-Id: <20240125225704.12781-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240125225704.12781-1-jdamato@fastly.com>
References: <20240125225704.12781-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using epoll-based busy poll, the packet budget is hardcoded to
BUSY_POLL_BUDGET (8). Users may desire larger busy poll budgets, which
can potentially increase throughput when busy polling under high network
load.

Other busy poll methods allow setting the busy poll budget via
SO_BUSY_POLL_BUDGET, but epoll-based busy polling uses a hardcoded
value.

Fix this edge case by adding support for a per-epoll context busy poll
packet budget. If not specified, the default value (BUSY_POLL_BUDGET) is
used.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 fs/eventpoll.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 4503fec01278..40bd97477b91 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -229,6 +229,8 @@ struct eventpoll {
 	unsigned int napi_id;
 	/* busy poll timeout */
 	u64 busy_poll_usecs;
+	/* busy poll packet budget */
+	u16 busy_poll_budget;
 #endif
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -437,10 +439,14 @@ static bool ep_busy_loop_end(void *p, unsigned long start_time)
 static bool ep_busy_loop(struct eventpoll *ep, int nonblock)
 {
 	unsigned int napi_id = READ_ONCE(ep->napi_id);
+	u16 budget = READ_ONCE(ep->busy_poll_budget);
+
+	if (!budget)
+		budget = BUSY_POLL_BUDGET;
 
 	if ((napi_id >= MIN_NAPI_ID) && ep_busy_loop_on(ep)) {
 		napi_busy_loop(napi_id, nonblock ? NULL : ep_busy_loop_end, ep, false,
-			       BUSY_POLL_BUDGET);
+			       budget);
 		if (ep_events_available(ep))
 			return true;
 		/*
@@ -2098,6 +2104,7 @@ static int do_epoll_create(int flags)
 	}
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	ep->busy_poll_usecs = 0;
+	ep->busy_poll_budget = 0;
 #endif
 	ep->file = file;
 	fd_install(fd, file);
-- 
2.25.1


