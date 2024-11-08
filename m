Return-Path: <linux-fsdevel+bounces-33992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 308D39C143B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 03:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 840AAB244A0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 02:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE37D194082;
	Fri,  8 Nov 2024 02:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="KBvVBaCy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C4E1922EE
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Nov 2024 02:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731033584; cv=none; b=UqefQMzxH1iZsYtFSMCN8uT81Q/W/BdEtVgNAqJOSPPVipL1hHCXnSf9gC8jV1JVBrnq0I1kEXYhzCT9v9kjzEUVG4Ugh/o8/Z+2aOzlHz9PYKY+pG2haAh6+w2OcHHGQKulZ9nMFeh+I/WixH1d8EnknTus3f3/RmMG/LuEbDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731033584; c=relaxed/simple;
	bh=ZvawQy978AWawDyo2L5Npe51s7GUMbBNxiumv6HwfAk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r0RaCrZp5N2UFq5xRb+zfSsuUOosoMr6k/XSe4npAv1ySWVDXdLBU9tg3/Cq8xng09ZTZdyGDLrraYFgRS32uZlLwDnyTuqgqxrNa7hunLgrJE98hiu3KHvez22ooRGfRgI6t+ccWWGdvwLS/FtkOo9fPxTxoyoRrRGmhwv/dZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=KBvVBaCy; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e8235f0b6so1389409b3a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Nov 2024 18:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731033582; x=1731638382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/mZBN4ImS6YyPeWvLF6rIBEjo5ZB0WxVpPyUomkuEI=;
        b=KBvVBaCyMNQx2mjQ5WhjfdkZMkYXbv5kvyR7P5SZ/22bm6lViYArN135OfVlpV8CFi
         LmUpU4YR0DNxiHi0+NopjPeTsy3DpH1Tbg6uzBLqyVmy26Ootx8o6TCzRcL8hu4IPArT
         EdbGo84BS+gtncgw85ZBnoagMMrnXrxvSimZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731033582; x=1731638382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/mZBN4ImS6YyPeWvLF6rIBEjo5ZB0WxVpPyUomkuEI=;
        b=qsGxvJR0RiX/4fUYvrA1Mfsg5v4FGXSXHapFLJo5S+IwB5/f+aYKR+JUe0PKShFmAv
         Cch4PDC5pwimLwZ8Zl1quRmFXoNIPPZEN0AkMA1rXsbhfXLo9rKstZXIXhdr33hLesYc
         sgwO1kq33IIq0UxOyq9/4LiT97ucmWrWJWEsm//+DbD8C7BS4JUHLKJqOkFNhDQxw/yc
         48amg4rByL8Yc7/NAYFv9Yqoba1IAjjqLqpa8DaYQIBcen1sHQNhaXmYgS7fkEqJJQkj
         z13ju0KuUBmJd9Z2AIGcsW2agg+rRRh9p3x4d7LuaYG77Zf9r0cZ1ygU3eNEuzSRoRRQ
         MzDw==
X-Forwarded-Encrypted: i=1; AJvYcCUya5MAL/zFk2t9slqhmjqyHEr8qFb0TqOJiMVwsmyVu+DbvnBRCz8E7FoAns/6s64PdXub1bPolcZUywQ2@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5CgciVW/1H7d3WMys8aZtn06TCC2Kcrule5av0qZmiH+jpyzK
	7hKwaQYz/zcJp/yeHQTm7lMMJAL92bYZw4bJVtpezfgbyYMHgMPHU3aF03Q3hl0=
X-Google-Smtp-Source: AGHT+IFFd92Y6ex4UQGg5rD146kqSQq96391igpoD+qpK2xzPOHsxgd87+C9O4Dav8PDOj4pNOlRDw==
X-Received: by 2002:a05:6a21:999f:b0:1db:d84f:c7d8 with SMTP id adf61e73a8af0-1dc228c6919mr1851329637.2.1731033581863;
        Thu, 07 Nov 2024 18:39:41 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079a403fsm2561208b3a.105.2024.11.07.18.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 18:39:41 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: corbet@lwn.net,
	hdanton@sina.com,
	bagasdotme@gmail.com,
	pabeni@redhat.com,
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
Subject: [PATCH net-next v7 4/6] eventpoll: Control irq suspension for prefer_busy_poll
Date: Fri,  8 Nov 2024 02:39:00 +0000
Message-Id: <20241108023912.98416-5-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241108023912.98416-1-jdamato@fastly.com>
References: <20241108023912.98416-1-jdamato@fastly.com>
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
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 v5:
   - Only call ep_suspend_napi_irqs when ep_send_events returns a
     positive value. IRQs are not suspended in error (e.g. EINTR)
     cases. This issue was pointed out by Hillf Danton.

 rfc -> v1:
   - move irq resume code from ep_free to a helper which either resumes
     IRQs or does nothing if !defined(CONFIG_NET_RX_BUSY_POLL).

 fs/eventpoll.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index f9e0d9307dad..83bcb559b89f 100644
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
@@ -2005,8 +2032,11 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 			 * trying again in search of more luck.
 			 */
 			res = ep_send_events(ep, events, maxevents);
-			if (res)
+			if (res) {
+				if (res > 0)
+					ep_suspend_napi_irqs(ep);
 				return res;
+			}
 		}
 
 		if (timed_out)
-- 
2.25.1


