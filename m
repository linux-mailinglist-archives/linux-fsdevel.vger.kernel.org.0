Return-Path: <linux-fsdevel+bounces-33634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B30359BC076
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 22:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6E271C21FB4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 21:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A1E1FEFCC;
	Mon,  4 Nov 2024 21:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="jJEgP3sS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6447C1FEFA7
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Nov 2024 21:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730757419; cv=none; b=GOzh4ELqPmSg51Z+iG2XsZtadyy8d9ROTXfRxFl+P7wRj3bbBVXds4qvzHX2n37qC9FDIsrZPzFChXR6/8+Eg6ilcMcCG31RWQdIw9EXidh+bF9aLn2FHGPLABByYOfHTlVN2Os9RUQEr2Dn9Cg90Aqy/zPm0NB5Ye6OhgxW4rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730757419; c=relaxed/simple;
	bh=ZvawQy978AWawDyo2L5Npe51s7GUMbBNxiumv6HwfAk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hpKmR00C4UTSfUx5q2hpvfH3bb/31XcyF/WWQF05tVSPly0kHQH9AYcWGL8HSQSpwwVaIFjIg2UbDYqvHz0xU5wOKNp5jqYj8ab5TE5IJU+Vvgl+RaleCr+nqR9n7QYlHXH83mnC965ilH4RlpXKy2wvH7YT9zb4zjKi74NXCqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=jJEgP3sS; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e2ad9825a7so3450952a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Nov 2024 13:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730757418; x=1731362218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/mZBN4ImS6YyPeWvLF6rIBEjo5ZB0WxVpPyUomkuEI=;
        b=jJEgP3sSzB4zBbUJM4ZEQSZMZ6SPVxRfGqYfKMQMFy9GWk+EVXe8d4VZRnbyEr6RXa
         Pj/cDGkYzJ+rIksmLoQVLvIn9bmvcZrEVlBz/alsPkfQiNljqFXAdwbuucaDT9Rxkmmp
         Fe4XGqy9dKqhsSqvvmTvwET9/GJALQpIghiMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730757418; x=1731362218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/mZBN4ImS6YyPeWvLF6rIBEjo5ZB0WxVpPyUomkuEI=;
        b=UHAxWTZtOGV8ULQYHn7H+ApP4U5wDezkvcC54eW0s2K1tHIq765hJYs/YaYGooMw1/
         I3b/cnttIiZUpT90D+/B/j1Xmh/nvmsjINhNJRQN0sGnFHy2jR9JzsGZcJU+dkSQBJ7X
         4NvMwxOA6Rjft4CmKRxsr3i+kmXq5VWWk9MOPHVCUn2Bk50fLx5fDjvAQc1ckqJ3PEus
         tRSoR23wZG+YUxuRYTj19wVpdsyY+alamNDZeDC80g++PNhCkbO/jKMylvBUI+2wknvn
         /QzYzmTOdyM3H00iab2u7ccrsOebbGZ2ydt6id9uMTDd+yjuhKbQ3ysLHUsGQh0+gyLM
         Szew==
X-Forwarded-Encrypted: i=1; AJvYcCVtuYJ2byDArEIVX38evKemfIDbfRX6T95Zx1pHpTTcJXPGitThOd1AtQ+NsMGNCfG4lbKsmv5LxomOgjNs@vger.kernel.org
X-Gm-Message-State: AOJu0YxCMgLrU8eREnhK1CA7ue7OYFG9nc0PBpOSXXFqictiNe6gfqd2
	jtyvk3m305+XivEM/a48eaG6FUMcNjAxvqzYeHfeN9lyX3jUnMy4cg+KmiTtxBM=
X-Google-Smtp-Source: AGHT+IENlIsq8+IIDsyU+nhB9TYp003iEeEe93gLutUdQX68yVgJFPhwu5VGXlQldD52ko60WmxTLA==
X-Received: by 2002:a17:902:d54a:b0:20c:d2d9:766f with SMTP id d9443c01a7336-210c68986efmr450019785ad.14.1730757417754;
        Mon, 04 Nov 2024 13:56:57 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057062b8sm65860255ad.63.2024.11.04.13.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 13:56:57 -0800 (PST)
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
Subject: [PATCH net-next v6 5/7] eventpoll: Control irq suspension for prefer_busy_poll
Date: Mon,  4 Nov 2024 21:55:29 +0000
Message-Id: <20241104215542.215919-6-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241104215542.215919-1-jdamato@fastly.com>
References: <20241104215542.215919-1-jdamato@fastly.com>
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


