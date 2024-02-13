Return-Path: <linux-fsdevel+bounces-11300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DD68528BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 07:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B3051F240BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 06:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D021C18AE4;
	Tue, 13 Feb 2024 06:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="WD72+/YR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE3317758
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 06:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707805027; cv=none; b=DIErcZ3ntU5TtPKylNPGjN5jhsRnqFcW0dSR9UZRK5rx1855B2B0nu/LhzS1nWwOks64+/vcNhTwW384a+aYffzmV+RvtzNqB7voEIEAMSsKy1sHzijnsavfZMl3Oz/iYltVHJ6JrFShZFUHRfC4MaOO2ncPU3bvC/ZqtCR8os0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707805027; c=relaxed/simple;
	bh=CJVUUyQixO3GY5CVmRJIGygCqjREOllOxrIr3Eh94fc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YXV5E/zxn7C8yFywTOrGL9yKwU75/CYqyDW6WTCTdmgInanIDIIXRr36Tn773YgW/J9vNAgdN7G4VnVfmeD28NdV+LT23vL1rpe0j7b+FUta/aGDJWGpaLqOjpkG4/cY9fbaRzQ8dekLQPEOkSkmejXCZRrUyG/4pHKdt97yYb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=WD72+/YR; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-21a95258d42so126216fac.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 22:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1707805025; x=1708409825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0NsVP2+DJYJlYo79AHfvXsFPLMqC3dLNa8zH3nE+As=;
        b=WD72+/YRyziBOOKYnxUAU4ncq/8VkvOZ2pbm0G8ifaJoOqgu2rhnZXjlbRw+CS5zyO
         4PzlYVYsvdsmDAqH299dqfe4tnhbdlnFADjLcf07aPzClb40/NoPk6GpkOG+Osnn1811
         z6d6PPASRtdJ1+jGV3QY7cvjNDhDgIrjaA09g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707805025; x=1708409825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G0NsVP2+DJYJlYo79AHfvXsFPLMqC3dLNa8zH3nE+As=;
        b=RjpuBhxkcMdyoSoYLIrDHLmcwrXQFhAgolZxya6v1wIAeyTVCzY+44OZ68gHilI2g2
         dD0vff6ECCF7S5D6EjXx2ogdUIuUBrf7iTEGZ48wDSNMXAf6RNtd1EC1dcKAWCcmFDkN
         0z8bDoeKD9/6cHalVeO2J1pHy8jKZ8etNKp4uPQb3T/Km+AaZK1IbXzuq63iMMg6uhb/
         /Vzdc0l4P4dbxhktA6pz35HPnVz7a1tuJ44yaYDIO5sm6yTZTvSewIT99/jdoaC2bYYc
         qW0Ek0W8Kh7m81vh5Xz9LDhKryN5A9JdB+w0MkpxsnGN5MdgoBLmPeVfi6Vk0bJIcMcX
         hyBA==
X-Forwarded-Encrypted: i=1; AJvYcCWisuVx7juKmzG77ouwQj36stTEMNcq7lC5Z3g15ybRLn1SeDQbbeI5pO4DjsYQOJly1YnJ1wJAdujmhSm4x+yTts6QRsMT4hLAtFvatg==
X-Gm-Message-State: AOJu0YxYEucMwxeMUH7/DG8eXz09sN4AOaXch7MAiQTd2412hTBtGt1o
	rsZss7ka0DD4l8CXaX9DeQb3l+yRcXFc9RTnrBDfBdBqlMNS61o/JXHNhimzlkQ=
X-Google-Smtp-Source: AGHT+IH6tEPjTYyV//I8LPOrehOWbCypj9Hd1LrKx0cLt6U4i1deM0lscT4i2KzvpUBGIBbmDWluaA==
X-Received: by 2002:a05:6870:a70c:b0:21a:8e6c:26ea with SMTP id g12-20020a056870a70c00b0021a8e6c26eamr1009371oam.8.1707805024793;
        Mon, 12 Feb 2024 22:17:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXkJlRyC/W6VSYAmeZ1aCoK74M/3UKA0+2neN2NqfNbLyNKu4MHpMMUr10S7ecIiGbjnW456R3jcLu6FwQBUI3Gb4QMYHa4mPbrF3curridEb+72102soyx7XqYNSu4FaBe4jAAB6nNo2BnRB8IjCjJiq2hRGMJ2yTa++suyZct7Iw1/9PjcL9nxbH9ZaeQwYIM+neBHpzAtj/YjQyo1jfytfYSEEqIc5PsojR4d05HO0PiY0uK3G5YuNz5H9RDhpyDFLbnCCpAmn5XrEhylbuPOBj1hmg7VLfQHFjO68YRZJtEjFk7DBGoGRabx+YFy7C4Of1xi+E6EX6wKq0VOCdPwGKGCqGAfBjcCCuZ+Uyj8hyktlF4cZmW3dKpYXQbYoUIwBu9nyrdujVcAVmcOxVRlE3oLNSIdRNKt2YeZhADYmmAbE2NsRvzmNjuljG3DDBIoM9Xnz4qkc4EIFCcSJThKY6zo3L29b0QUfBlYrKhvbkhQNSEROhXJUjiBiDIxIzVCoRfecHuI0PepA9BoDfvVatxwCh4VL+sI8ygu3NtdrKF+92STBO+F4xDNb8ZmI5mqkPp3jbL2TKPK31S/umYDVy89zuENeM6b8jsLXMfJYn+ffmBEfF0xANMUm8=
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id n19-20020a638f13000000b005dc87f5dfcfsm342936pgd.78.2024.02.12.22.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 22:17:03 -0800 (PST)
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
	sdf@google.com,
	amritha.nambiar@intel.com,
	Joe Damato <jdamato@fastly.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure))
Subject: [PATCH net-next v8 3/4] eventpoll: Add per-epoll prefer busy poll option
Date: Tue, 13 Feb 2024 06:16:44 +0000
Message-Id: <20240213061652.6342-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240213061652.6342-1-jdamato@fastly.com>
References: <20240213061652.6342-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using epoll-based busy poll, the prefer_busy_poll option is hardcoded
to false. Users may want to enable prefer_busy_poll to be used in
conjunction with gro_flush_timeout and defer_hard_irqs_count to keep device
IRQs masked.

Other busy poll methods allow enabling or disabling prefer busy poll via
SO_PREFER_BUSY_POLL, but epoll-based busy polling uses a hardcoded value.

Fix this edge case by adding support for a per-epoll context
prefer_busy_poll option. The default is false, as it was hardcoded before
this change.

Signed-off-by: Joe Damato <jdamato@fastly.com>
Acked-by: Stanislav Fomichev <sdf@google.com>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 fs/eventpoll.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index ed83ae33dd45..1b8d01af0c2c 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -231,6 +231,7 @@ struct eventpoll {
 	u32 busy_poll_usecs;
 	/* busy poll packet budget */
 	u16 busy_poll_budget;
+	bool prefer_busy_poll;
 #endif
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -438,13 +439,14 @@ static bool ep_busy_loop(struct eventpoll *ep, int nonblock)
 {
 	unsigned int napi_id = READ_ONCE(ep->napi_id);
 	u16 budget = READ_ONCE(ep->busy_poll_budget);
+	bool prefer_busy_poll = READ_ONCE(ep->prefer_busy_poll);
 
 	if (!budget)
 		budget = BUSY_POLL_BUDGET;
 
 	if (napi_id >= MIN_NAPI_ID && ep_busy_loop_on(ep)) {
-		napi_busy_loop(napi_id, nonblock ? NULL : ep_busy_loop_end, ep, false,
-			       budget);
+		napi_busy_loop(napi_id, nonblock ? NULL : ep_busy_loop_end,
+			       ep, prefer_busy_poll, budget);
 		if (ep_events_available(ep))
 			return true;
 		/*
@@ -2098,6 +2100,7 @@ static int do_epoll_create(int flags)
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	ep->busy_poll_usecs = 0;
 	ep->busy_poll_budget = 0;
+	ep->prefer_busy_poll = false;
 #endif
 	ep->file = file;
 	fd_install(fd, file);
-- 
2.25.1


