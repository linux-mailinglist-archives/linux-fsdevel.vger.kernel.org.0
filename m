Return-Path: <linux-fsdevel+bounces-26949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E0D95D453
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 19:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF8721C21C77
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 17:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362EF193075;
	Fri, 23 Aug 2024 17:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="UDZ0sT8u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA4A192B6D
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 17:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724434318; cv=none; b=qyYQAIgKcDqGq9y/ZhNgrg+Mb+puERpMkKU4zte+PThkulXYpuazXS8FOxcHKjaGzwpCpBq2Xsk63yEuWpZcZC13OD2Nf0Bc9F5hpqnQir5CP9sRPb9FLl0Xgf5irDfdcVtFmDGY1wKG0QZnXX2iCnVE8T8pp7tnX+Cmkq1eeBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724434318; c=relaxed/simple;
	bh=x08ZrLW3d91mrWZQmC/v9H7iJRa473+4x/SsWYtS3JE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SsssUIItGMIzn6wWDiJG6WP7qBe6kr8ey4pwV51Wc9JzDuSlH6kVH7Tu6azDByL8rQN2ewS9zZ4UvjNM5MbkzYpyIr8aduvKYYi6mV3wufpQUswuFg9uyzHjcwr2d5zlA557aix4JxisYXUeM3n6DLAKHmA7vzZVd0j0GXwe/W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=UDZ0sT8u; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71433cba1b7so1811114b3a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 10:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1724434316; x=1725039116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IoqQBySxLV4Sefg/kJRVr1Dr3C923zx/iiQfn4tblTE=;
        b=UDZ0sT8u5MrIFsQ3wnGp9F9y8pQUiZjszYOkWFxo0DmRD7PgI+tWFNlusmmu2kUoI4
         7Y51sqGcrLLr9mdv95q3Xg5gPbYTJJwQh280N/zECe56Ppl2iIuY2WwaGeMFHAFrTixS
         fL8fumpgh/G5j6qj65gnWQugCyPUtzs5Zxseo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724434316; x=1725039116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IoqQBySxLV4Sefg/kJRVr1Dr3C923zx/iiQfn4tblTE=;
        b=Q38GnB+iPusiTeGkLACy0l/SnMr/MeVZiHVmrrQ2a3smapemuZ/mFc3iEVT4dn09sh
         ETuBHEzbA+Z9MpJ0DBQm01i3VEHKBZM9Vlt57o96PwImDCEo1TxYgGcozGaiasRy6/Sq
         2xjYqimAL18Mw2S1+CPJB+oVQIVD1vvCOU1rzqEIBQpZlsMQCFscQUyWl1nzCY1gh8Am
         xDKNQ9KBsERV6H94neT4wA00FglnzhNLZCa6SzfL4HQC4pTK8PjHO1o9ASyGzBQsrJUD
         hjwt/kZbqCftCDvymPuHAqbhMOI5/8oStlYGOEKoZPhShxPHKIq4oYpR8Sfb49IX5tI5
         aDAg==
X-Forwarded-Encrypted: i=1; AJvYcCUyV47ILaPUEn/tyJUV9LUfjPQoowpm5NChVJf5zoU8JwamJmvAYsYik46u0XBhm2EjGh/5z45sGX9pOKeq@vger.kernel.org
X-Gm-Message-State: AOJu0YyCBD3Hz7Sc72h+SWK550969SiaZuXNKaUOL0U/b8x2xxXKfHlK
	5AUoJxNvge+kMbKUrJ7d0Ubs3BTvuSD7S7alnJAN7u5+c4Dvcps2f0r8OmF1q8g=
X-Google-Smtp-Source: AGHT+IHXsgl2NQYO+yMV9X1gIfvGuclsqseoRzkfOcO3p7twoiEGni5X0dIXcScV5If78qjNaxucOA==
X-Received: by 2002:a05:6a00:3e2a:b0:710:5605:a986 with SMTP id d2e1a72fcca58-714454098b9mr3730824b3a.0.1724434316322;
        Fri, 23 Aug 2024 10:31:56 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143430964fsm3279624b3a.150.2024.08.23.10.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 10:31:56 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: amritha.nambiar@intel.com,
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
Subject: [PATCH net-next 5/6] eventpoll: Control irq suspension for prefer_busy_poll
Date: Fri, 23 Aug 2024 17:30:56 +0000
Message-Id: <20240823173103.94978-6-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240823173103.94978-1-jdamato@fastly.com>
References: <20240823173103.94978-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Karsten <mkarsten@uwaterloo.ca>

When events are reported to userland and prefer_busy_poll is set, irqs are
temporarily suspended using napi_suspend_irqs.

If no events are found and ep_poll would go to sleep, irq suspension is
cancelled using napi_resume_irqs.

Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
Co-developed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
---
 rfc -> v1:
   - move irq resume code from ep_free to a helper which either resumes
     IRQs or does nothing if !defined(CONFIG_NET_RX_BUSY_POLL).

 fs/eventpoll.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index cc47f72005ed..5dbe717c06b4 100644
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
@@ -557,6 +575,13 @@ static long ep_eventpoll_bp_ioctl(struct file *file, unsigned int cmd,
 	return -EOPNOTSUPP;
 }
 
+static void ep_suspend_napi_irqs(struct eventpoll *ep)
+{
+}
+
+static void ep_resume_napi_irqs(struct eventpoll *ep)
+{
+}
 #endif /* CONFIG_NET_RX_BUSY_POLL */
 
 /*
@@ -788,6 +813,7 @@ static bool ep_refcount_dec_and_test(struct eventpoll *ep)
 
 static void ep_free(struct eventpoll *ep)
 {
+	ep_resume_napi_irqs(ep);
 	mutex_destroy(&ep->mtx);
 	free_uid(ep->user);
 	wakeup_source_unregister(ep->ws);
@@ -2005,8 +2031,10 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
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


