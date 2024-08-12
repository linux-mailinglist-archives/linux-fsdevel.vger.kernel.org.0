Return-Path: <linux-fsdevel+bounces-25678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0231D94ED88
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 14:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 357171C217D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 12:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD54317D8A3;
	Mon, 12 Aug 2024 12:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ubMnQW0u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B811717D895
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723467473; cv=none; b=JBEp1EElK7TyuulkpA7ZfK9Rjk7Q8D8HHCDSCObeIs95CLFnZMtkQL3ds3YrfwW0Nlu2v95Xhen8aZfUtmGhETjN8NyElxMfcl8y0big58/UdNjGRiq/ELDjnHLsuJ5A4rlRTH8x4X5eyuFnfbTBaRWtqGCGIEAzvBHOZ+EUgJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723467473; c=relaxed/simple;
	bh=ayLYRx3QKfi6gmR7b4DhUiYvDsWYqJuL4KCn2w5LCzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZCbPYbmNarbDsfy+27pI6+XVJWUV/6X9I62mERrd+E55Szf75kHh5DXHysZI76OLqR7Yupt58PN3kNstXiSWelJx87UzxR0Ty24MejsY2+vjQ8ZBOIVWuB7OpLWygQAepOYqCbxvSfWPUfGA2qcVp8KqEg+0BX1K4OwQ42VTrcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ubMnQW0u; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7c3d8f260easo1108991a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 05:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723467471; x=1724072271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GsO15pwNsB215SzDNzNe7pDnu6o5GjMMYX4qU8sz+wY=;
        b=ubMnQW0uWxTuFizaWewZgJbZ97O4EkKDpmEsQFN7xS4dEszQFfFkx4eGTDO8LuJm4H
         3pnCBEA+HEoUMQ+iClrGRVvOUCY9RialylxtfhtgqDeDWf8R+Vxow786n5CRWIXzw7/j
         i+ZDNJ/QQHrP0hL78HO7J+1cSvqk14KxFqURY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723467471; x=1724072271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GsO15pwNsB215SzDNzNe7pDnu6o5GjMMYX4qU8sz+wY=;
        b=dG6fGe7cmS++lZS4RZp8tolZrMpUSaLSsBpvDjY/LB5pk7RpO+qnATC/cO+kC8aovy
         RfH+PpjIHaU+3JNeI2j7hlPgf9ohgQjoefs0SL1zW4NzAncTvFNgizs6+4SJraFWuAtx
         8jboBTsdz3ROUuFoFWGgASyDt4JgvLsLB+/uDj7d1T1WE8VMs8VzlaOMJyTQqeU4bGda
         TaW1joZDcgGcdc4NJ9ZcWpw0w73Xq4pYgEm3qb3U8K5Jt6sx/YgBQDsQRba4aq2TFejJ
         KfhOq5yydWBrP9wD2rDHNkYImp/p8b/fJNUXfO7FtkpR/TdY0mqx1gpja7NGmWhzWFXn
         ni+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWmy09FypheUNy6pT2KHzhlFCLPcS3WQ2I7ab2uddqJLqrdm07ZDvJ+gcxZEwcjcM+rsqcIHm3rrVW359TjSWDG0BDeMNu0xu2igbSPdA==
X-Gm-Message-State: AOJu0YxOtZnwvPGtmtjSiweCEdbt3QmMY5KulKt6PmiUr8kZ37rU9ZmF
	nnrnmqwtMsAxeVkHV8aoRDFfkt8fuqTKn7kUF09+ne4BgjQDpeLOp/rQHtPte38=
X-Google-Smtp-Source: AGHT+IFORSWX0ysgwFR7RQ99ft+D14MIbt0Ie8vdK9uiCSKuM0XLaRfZUtZDgUJaa+RQRY7CagNyAw==
X-Received: by 2002:a17:90a:bf05:b0:2c5:10a6:e989 with SMTP id 98e67ed59e1d1-2d39265846bmr99107a91.35.1723467471060;
        Mon, 12 Aug 2024 05:57:51 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1c9ca6fafsm8183368a91.34.2024.08.12.05.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 05:57:50 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	sdf@fomichev.me,
	Joe Damato <jdamato@fastly.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure)),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next 5/5] eventpoll: Control irq suspension for prefer_busy_poll
Date: Mon, 12 Aug 2024 12:57:08 +0000
Message-Id: <20240812125717.413108-6-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240812125717.413108-1-jdamato@fastly.com>
References: <20240812125717.413108-1-jdamato@fastly.com>
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
 fs/eventpoll.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index cc47f72005ed..d74b5b9c1f51 100644
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
@@ -540,6 +542,14 @@ static long ep_eventpoll_bp_ioctl(struct file *file, unsigned int cmd,
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
 #else
 
 static inline bool ep_busy_loop(struct eventpoll *ep, int nonblock)
@@ -557,6 +567,10 @@ static long ep_eventpoll_bp_ioctl(struct file *file, unsigned int cmd,
 	return -EOPNOTSUPP;
 }
 
+static void ep_suspend_napi_irqs(struct eventpoll *ep)
+{
+}
+
 #endif /* CONFIG_NET_RX_BUSY_POLL */
 
 /*
@@ -788,6 +802,10 @@ static bool ep_refcount_dec_and_test(struct eventpoll *ep)
 
 static void ep_free(struct eventpoll *ep)
 {
+	unsigned int napi_id = READ_ONCE(ep->napi_id);
+
+	if (napi_id >= MIN_NAPI_ID && READ_ONCE(ep->prefer_busy_poll))
+		napi_resume_irqs(napi_id);
 	mutex_destroy(&ep->mtx);
 	free_uid(ep->user);
 	wakeup_source_unregister(ep->ws);
@@ -2005,8 +2023,10 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
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


