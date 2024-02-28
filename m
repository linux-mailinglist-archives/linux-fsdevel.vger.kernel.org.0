Return-Path: <linux-fsdevel+bounces-13083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 548C186B0E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 14:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A65F1F26894
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 13:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC2414F98B;
	Wed, 28 Feb 2024 13:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cBddTMGp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D7514F987
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 13:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128452; cv=none; b=Y4A8BfK7aEGsfuovxnt6LiYJBK/AAtWZUMDzROXNt/RLcIKumVtvaSRTqpRaVs3/fhN94uGp5Ip9UeAMCt5dVORhDtA8vWZGQ3rSfnUfIYUoAsm8/PmEc5sBGaQOZV/2hbfKaN/cacBIGigbRfi4VQvTt1XAqlmJwqOTA6+ut/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128452; c=relaxed/simple;
	bh=aV+01cbnvwYneym9pG1JuXfXvYgIVTFiDpBI353TUkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EXJ/sLz9uW5fWsUfKdrd5dXssNtXiEecIkzkvinYkbS74ZpXZP5RB3FNkwmFNmMLsJu+5/Eq/CUKUlXkrCTBD5RfAJ4pwzWDhjSm/Yqv6XjVe+Bjtmr+3qfToJE79bhB5IAANDptQmDf6XpzEm/B6GKmArjuooHlK7vq6nm7UTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cBddTMGp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709128449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7eik1TFl3fkD2jZ/xnSrKIHXhnveA7D9yMR9JohoGKk=;
	b=cBddTMGpPhUV+clNE9G3n0vGfUFofkAPueI44AWm28dyc1PwUrr8Ed+bxKxrFQSdqrq5cw
	ObD9V3xAObs0g6RZkDO3hKGoy5NnTD4cdL5/HIrsWUUqkJ1j2H6WK82T6FuiYTbMu6YcBp
	J/RHctAAuhaDsH3JX5ozhPW/ck0vKCI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-2abDcOcHNvuNVjn4T_N9AA-1; Wed, 28 Feb 2024 08:54:06 -0500
X-MC-Unique: 2abDcOcHNvuNVjn4T_N9AA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A6AFE10AFB08;
	Wed, 28 Feb 2024 13:54:04 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.45.226.168])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 854CD1121312;
	Wed, 28 Feb 2024 13:54:03 +0000 (UTC)
From: Michal Schmidt <mschmidt@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] xarray: add guard definitions for xa_lock
Date: Wed, 28 Feb 2024 14:53:52 +0100
Message-ID: <20240228135352.14444-1-mschmidt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Add DEFINE_GUARD definitions so that xa_lock can be used with guard() or
scoped_guard().

Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
---
 include/linux/xarray.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index cb571dfcf4b1..73a8fc0e830a 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -11,6 +11,7 @@
 
 #include <linux/bitmap.h>
 #include <linux/bug.h>
+#include <linux/cleanup.h>
 #include <linux/compiler.h>
 #include <linux/gfp.h>
 #include <linux/kconfig.h>
@@ -1883,4 +1884,19 @@ static inline void *xas_next(struct xa_state *xas)
 	return xa_entry(xas->xa, node, xas->xa_offset);
 }
 
+DEFINE_GUARD(xa_lock, struct xarray *,
+	     xa_lock(_T),
+	     xa_unlock(_T))
+DEFINE_GUARD(xa_lock_bh, struct xarray *,
+	     xa_lock_bh(_T),
+	     xa_unlock_bh(_T))
+DEFINE_GUARD(xa_lock_irq, struct xarray *,
+	     xa_lock_irq(_T),
+	     xa_unlock_irq(_T))
+DEFINE_GUARD_COND(xa_lock, _try, xa_trylock(_T))
+DEFINE_LOCK_GUARD_1(xa_lock_irqsave, struct xarray,
+		    xa_lock_irqsave(_T->lock, _T->flags),
+		    xa_unlock_irqrestore(_T->lock, _T->flags),
+		    unsigned long flags)
+
 #endif /* _LINUX_XARRAY_H */
-- 
2.43.2


