Return-Path: <linux-fsdevel+bounces-33387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 564C59B87DE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 01:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDF2A1F22FF9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 00:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F79136357;
	Fri,  1 Nov 2024 00:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="g4FsDE9h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E22C5588E
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Nov 2024 00:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730422168; cv=none; b=UDzrA+efHowJh8Vofbyj0qAI5QeZ9cTrQGzewjw46L1uC7YBdKnsAtVCz/qHBl72TgzNUMb3fYkfDwcEJA7PMle6u8cFn7r2CjNqayy7js6LnnxugfmwuQxy5zafyE3N4IM59GeIVIz9DHhfXqrT84eijwBSEY91Z9sCnonkxGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730422168; c=relaxed/simple;
	bh=nTVHqzMjxVaFGtFwKysoiZKk4YEWDQibSQdexzn6DUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eW0aO2NtgMv/pKrWumUTHDBpUR21c9D7qMXxywc49KKY6hXsb+SNpz2pfd9YhjIiFVNfYhR5xHf/EoNkcOxbg74KrYek0J+W9wpwYOuPa/SyosVN8soRpBCx1W495NiKDn9+Nj8W00a13i33M3/gxip3ylL+MJWb8JY6G+RWEN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=g4FsDE9h; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e4c2e36daso1836747b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Oct 2024 17:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730422162; x=1731026962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhVjl1Gry+K7A+Im8XGVxnCvKP7p4PT8RH2VXkmIRG8=;
        b=g4FsDE9hSub8oOafoJ2gM6+1cVpVJSgXSqTISVkXgSXVlUIXFLAUkorN+2I2tYb8w4
         ZsAr5Ny9y75dp1e0RNzDFG9s0bKUTrmtgxuETbtBLqHq09jH6z+8QCdgiZL4qSUNoDPG
         OoHAeZhE5nXBgAsjOtK+lnDwVSncQedRyhq9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730422162; x=1731026962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PhVjl1Gry+K7A+Im8XGVxnCvKP7p4PT8RH2VXkmIRG8=;
        b=JHXLMoKIi4GtTTtdfGxnQiW7ulqAuxg3okULtXdAMOBNN4BFRxvhOjR3/zhzQfGcPs
         G+7HIByJYx0sFeO7VMVDqMA02asYtS0RBz4KlaaF0AmRhfT3/kxDiD0fH1gEpd5CNEhL
         Ej9tVgEvuewz0y8bLnTiyHAlXC5j6nlUknnMuRUXgqU4TJ5W8rk4l8/uWUVBztfhUzmG
         j6VclTzy3uaAUeI7eZJo8HeUt5q8GOcBrlYhReSqg6csb0S2vYP++c+QJAx8G5IPCwoo
         NLsNuI+ayhNo2L2/dPaRWtl99nZawL7tWwDKxGCY6mz3tAKah2x7EhcD2HNo3Wkeq23v
         OeTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6wIUUAwcmli8VJiDATwFLX6ypxHpgsCQ6zXsh+MYhcUxJ1+2G262q+1NyJzgIvvWBqAfcSPB836+fAvQW@vger.kernel.org
X-Gm-Message-State: AOJu0YwfQCRVi7F7+PtzdL8ZUJNmJMZoo3ERbz2YlCBn6YtaO6DzksJf
	+wi2VjxvnK4A8basE9bt28Ztv7te+qKGz6v8sUKyYFDjk6/B6J94tefkyXx94CA=
X-Google-Smtp-Source: AGHT+IEH+IJhhOqJTbEvWAGa+fGdT8tPf8aU+VscbzoV1yq0/QUbvAn4d2Gmi8WnlrR0slwEVeyS9g==
X-Received: by 2002:a05:6a20:be18:b0:1db:822f:36d8 with SMTP id adf61e73a8af0-1db94f33e87mr6081599637.3.1730422161735;
        Thu, 31 Oct 2024 17:49:21 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee45a12c27sm1585365a12.93.2024.10.31.17.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 17:49:21 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	namangulati@google.com,
	edumazet@google.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	sdf@fomichev.me,
	peter@typeblog.net,
	m2shafiei@uwaterloo.ca,
	bjorn@rivosinc.com,
	hch@infradead.org,
	willy@infradead.org,
	willemdebruijn.kernel@gmail.com,
	skhawaja@google.com,
	kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Joe Damato <jdamato@fastly.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure)),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v3 5/7] eventpoll: Control irq suspension for prefer_busy_poll
Date: Fri,  1 Nov 2024 00:48:32 +0000
Message-Id: <20241101004846.32532-6-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241101004846.32532-1-jdamato@fastly.com>
References: <20241101004846.32532-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Karsten <mkarsten@uwaterloo.ca>

When events are reported to userland and prefer_busy_poll is set, irqs
are temporarily suspended using napi_suspend_irqs.

If no events are found and ep_poll would go to sleep, irq suspension is
cancelled using napi_resume_irqs.

Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
Co-developed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
---
 rfc -> v1:
   - move irq resume code from ep_free to a helper which either resumes
     IRQs or does nothing if !defined(CONFIG_NET_RX_BUSY_POLL).

 fs/eventpoll.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index f9e0d9307dad..36a657594352 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -457,6 +457,8 @@ static bool ep_busy_loop(struct eventpoll *ep, int nonblock)
 		 * it back in when we have moved a socket with a valid NAPI
 		 * ID onto the ready list.
 		 */
+		if (prefer_busy_poll)
+			napi_resume_irqs(napi_id);
 		ep->napi_id = 0;
 		return false;
 	}
@@ -540,6 +542,22 @@ static long ep_eventpoll_bp_ioctl(struct file *file, unsigned int cmd,
 	}
 }
 
+static void ep_suspend_napi_irqs(struct eventpoll *ep)
+{
+	unsigned int napi_id = READ_ONCE(ep->napi_id);
+
+	if (napi_id >= MIN_NAPI_ID && READ_ONCE(ep->prefer_busy_poll))
+		napi_suspend_irqs(napi_id);
+}
+
+static void ep_resume_napi_irqs(struct eventpoll *ep)
+{
+	unsigned int napi_id = READ_ONCE(ep->napi_id);
+
+	if (napi_id >= MIN_NAPI_ID && READ_ONCE(ep->prefer_busy_poll))
+		napi_resume_irqs(napi_id);
+}
+
 #else
 
 static inline bool ep_busy_loop(struct eventpoll *ep, int nonblock)
@@ -557,6 +575,14 @@ static long ep_eventpoll_bp_ioctl(struct file *file, unsigned int cmd,
 	return -EOPNOTSUPP;
 }
 
+static void ep_suspend_napi_irqs(struct eventpoll *ep)
+{
+}
+
+static void ep_resume_napi_irqs(struct eventpoll *ep)
+{
+}
+
 #endif /* CONFIG_NET_RX_BUSY_POLL */
 
 /*
@@ -788,6 +814,7 @@ static bool ep_refcount_dec_and_test(struct eventpoll *ep)
 
 static void ep_free(struct eventpoll *ep)
 {
+	ep_resume_napi_irqs(ep);
 	mutex_destroy(&ep->mtx);
 	free_uid(ep->user);
 	wakeup_source_unregister(ep->ws);
@@ -2005,8 +2032,10 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 			 * trying again in search of more luck.
 			 */
 			res = ep_send_events(ep, events, maxevents);
-			if (res)
+			if (res) {
+				ep_suspend_napi_irqs(ep);
 				return res;
+			}
 		}
 
 		if (timed_out)
-- 
2.25.1


