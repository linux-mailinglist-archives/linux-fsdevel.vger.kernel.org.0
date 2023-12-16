Return-Path: <linux-fsdevel+bounces-6272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 012E68156E3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 04:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9476D1F25B57
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 03:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBBE1E4B0;
	Sat, 16 Dec 2023 03:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sUg/6tnz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D902199BC;
	Sat, 16 Dec 2023 03:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1702697417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oI0gL82RwetzQrsOnD2Q7yVz4Ukcn+iFt6/nG0yTLOM=;
	b=sUg/6tnz1B6gJ/av17WrZwTZK2+EAPO23D3Ddws0I3GYt1HBByMrOOXokxXGS7UH1DM9oZ
	gxDGgQVJq7rQRWbglUfSffuO32ZjkSpfYVQvtKNPh/S2MjHg0mXPDJiYPZDPyAl/YfonBh
	72er+KPbDqETxqo9G5qA05jrHdqkTBU=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	tglx@linutronix.de,
	x86@kernel.org,
	tj@kernel.org,
	peterz@infradead.org,
	mathieu.desnoyers@efficios.com,
	paulmck@kernel.org,
	keescook@chromium.org,
	dave.hansen@linux.intel.com,
	mingo@redhat.com,
	will@kernel.org,
	longman@redhat.com,
	boqun.feng@gmail.com,
	brauner@kernel.org
Subject: [PATCH 28/50] signal: Kill bogus dependency on list.h
Date: Fri, 15 Dec 2023 22:29:34 -0500
Message-ID: <20231216032957.3553313-7-kent.overstreet@linux.dev>
In-Reply-To: <20231216032957.3553313-1-kent.overstreet@linux.dev>
References: <20231216024834.3510073-1-kent.overstreet@linux.dev>
 <20231216032957.3553313-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

list_head is in types.h, not list.h.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/signal.h       | 1 +
 include/linux/signal_types.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/signal.h b/include/linux/signal.h
index 3b98e7a28538..f19816832f05 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -3,6 +3,7 @@
 #define _LINUX_SIGNAL_H
 
 #include <linux/bug.h>
+#include <linux/list.h>
 #include <linux/signal_types.h>
 #include <linux/string.h>
 
diff --git a/include/linux/signal_types.h b/include/linux/signal_types.h
index a70b2bdbf4d9..caf4f7a59ab9 100644
--- a/include/linux/signal_types.h
+++ b/include/linux/signal_types.h
@@ -6,7 +6,7 @@
  * Basic signal handling related data type definitions:
  */
 
-#include <linux/list.h>
+#include <linux/types.h>
 #include <uapi/linux/signal.h>
 
 typedef struct kernel_siginfo {
-- 
2.43.0


