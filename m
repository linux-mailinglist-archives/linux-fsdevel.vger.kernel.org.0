Return-Path: <linux-fsdevel+bounces-9814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1C284530E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 09:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27D671F220AD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 08:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60FB158D8E;
	Thu,  1 Feb 2024 08:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MwCHKcgt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26071586FE
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Feb 2024 08:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706777267; cv=none; b=PwY4ybIrzqyjW69TADVBkJXR85tiueDH+V+Utdpmidw86libV4OTNoDamZ/+ZYmZRghNnxsPpzJ9oWkK88AyhOl+nIacZrJEIFzmMd2W6yH3cI322GNbPqvwSE7MPK6DfVYTLpRGvcBOaQn2R6o5nbfl61C3hocnc0/MENsrDjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706777267; c=relaxed/simple;
	bh=RhJCGSqtg+lQOjMf14y8RYem6UsJutbmhYP65QnXxY4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=n5yxOo7TIAgS4LtUVpQY73u+crWW4/cB9/mvD8WwQhKCyEBymffsWRCoXI0SlMa50cbJFms/Dcn5EFEN5YHI4BV5MIkLlmuyrtQFXTB/xu6r6G/XdUBGULQZw2GRg29vfDc5ewG6NHtgwTyBs4/YKd9mZic4xbCuZTH0fA/b8Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MwCHKcgt; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6040ffa60ddso13861987b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Feb 2024 00:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706777264; x=1707382064; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ut6iMrGe0Fe7IMukcbrdTGUANM5JE5jZNaHWvk8D0fg=;
        b=MwCHKcgtkDFjSGiV47psn9uMZd7Yo+1pRaX9yeqEhtdkWYrQ0ABvxP7KR4duuJ+zaB
         tqDCL6OPCEdbrr79oL3hiXm3FbYD0ni12cKpdRbmqRnWv/TMFCuc4VWlF6KZbseeWEQj
         zJZWcZiqoiLHEoMrZ5l43GzHXYSYTLHi9ytjxnRT37LwBHu6fnONTp/FkvZx1Uk0SDf2
         TUhSuEjOT2+gu5aM+2IR33eqjp4YYCuTwUs7Luq9jAnv2VG7n58YodWSlvEp3QQk92ZK
         sEi+zxpnk/4ASyEuULrJlThUlxDyxKti2mx1eMjO7P6vs6NOyNwQSK40qPafjPSVmOLq
         sQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706777264; x=1707382064;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ut6iMrGe0Fe7IMukcbrdTGUANM5JE5jZNaHWvk8D0fg=;
        b=CU4VxN2sNVzPA/emqeqw9VE4v8oayuwwXbC6V9vuSV8aEQwrRqLMqgLTJjxHwRl2gV
         2q1UnCbmgIf3lkRru5+455Xp8oGHnkXUJTh3CPLxqpkO4QWXMOodNiJ806ikYde3YBMD
         j4Iq5/0jXeSoq14loVSTb9RFVdIFOYvs0YqVRWTokqYqwTdoAfqr/6BytDYFWxqwA0a2
         qtWmHN2YCS3M4BFEjR+Lopgsp9ymL5BFmfUapMWsUo5VRFcRKksqQqoGKd4z2QBc+OKr
         YsfSktQmCCDnqEBzk5N68CUi9i2l9ddjpApdZU6piAm1mwmeE5HyTkmCZb0iWa8s5qRG
         7uNw==
X-Gm-Message-State: AOJu0Yz8oemGL0oSKHZBLrqJ+cGMZpACDBFTLgtq+SDScXkOw+p8jdBU
	8vtRzDu2eoHSBHMVmzjgvSg9TPuRe9evsu5/VOwnPAdBjtmE77qw9pEONcImZt6+iMcBb8PRw16
	qGeX7mLzGKP+eOw==
X-Google-Smtp-Source: AGHT+IEwC2Sq+6nJ4cPi4xRUxsLrbdif3maAi4tV/OsTRC4SRRj3pncHKyErUMxRhqPd+mlOla5u99yynevNafM=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a81:9946:0:b0:604:45a:6740 with SMTP id
 q67-20020a819946000000b00604045a6740mr942684ywg.2.1706777264640; Thu, 01 Feb
 2024 00:47:44 -0800 (PST)
Date: Thu,  1 Feb 2024 08:47:39 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2507; i=aliceryhl@google.com;
 h=from:subject; bh=RhJCGSqtg+lQOjMf14y8RYem6UsJutbmhYP65QnXxY4=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlu1ovgg0/kO+AwbQOpm/x9i67t3KgnisFNXUNB
 Inyb0i3XUWJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZbtaLwAKCRAEWL7uWMY5
 RubYD/9xlb20HFn+H3WxCU2CRg6XGIz9MaIXEUHE5OsE3WrbL9m8IP5VR3eHLBrgXOF+Hz9NUJK
 uj5zxhC5v6PYqae+Zb+QL5noZsvh/eT7pelzBpQla/Oo6zVyUbzflAxbamg1Xy14s5und2I0sRI
 s4wKvP1ODScDZBMe5BUj+GWQ+6x5UXp6RR91f1IXwNbjgazj7HWrw8ZaxqBcYnhDpoFUS8x0mZ7
 O68eVoRjO2tE6zeltWEPw4THnvkS4qVbPxBihetT+RFs7jynTh5LNQno+r/3UcUbFWPtbad7R9Y
 SYGT/9Io85R0M7M9to2ITnn+nafzXzizkAA+9QrnkBztvkhFnBJOomaQPsxGAo6EbGat9AA1Til
 JQUWBWhpUl0qOFxkA7addbLIoOsVHpxWLB7xdlFbr3SVk0immZ1/xe6irqw7lYMLKAJIHvH/21E
 N9YR29AhYhPXR5lM0pQxD5Kmut3EunY+pKTJ6eXu3kbJx6E/kOI4khL1dar5jlFeGVWuPIzM3aD
 VKu55UanXk0ChcyfhMu7fOpFfqwUujOEQ5yMOYh400Bnj8gM4XdJCtXMJ/NGig2L23YB1W3cLbg
 KJnCC2FC9e/XpHtXFwVF3KBlyGmrlQfsQ08g7oL2JZzT6SZ+o7VRvVTHVszFwJZZTa3VROoHCxp VFW5uPQeLw/0h9w==
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240201084739.1452854-1-aliceryhl@google.com>
Subject: [PATCH] xarray: document that xa_alloc uses the smallest index
From: Alice Ryhl <aliceryhl@google.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Alice Ryhl <aliceryhl@google.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The deprecated IDR data structure was used to allocate *small* ids for
things, and the property that the ids are small is often desireable for
various reasons. However, the IDR interface is deprecated in favor of
XArray.

Clarify that when replacing IDR with XArray, you do not give up the
guarantee that the generated ids are small, even if you use a very large
range such as xa_limit_32b.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 include/linux/xarray.h | 6 ++++++
 lib/xarray.c           | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index cb571dfcf4b1..e5f273d3f2bc 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -856,6 +856,8 @@ static inline int __must_check xa_insert_irq(struct xarray *xa,
  * stores the index into the @id pointer, then stores the entry at
  * that index.  A concurrent lookup will not see an uninitialised @id.
  *
+ * Always allocates the entry at the smallest possible index.
+ *
  * Must only be operated on an xarray initialized with flag XA_FLAGS_ALLOC set
  * in xa_init_flags().
  *
@@ -889,6 +891,8 @@ static inline __must_check int xa_alloc(struct xarray *xa, u32 *id,
  * stores the index into the @id pointer, then stores the entry at
  * that index.  A concurrent lookup will not see an uninitialised @id.
  *
+ * Always allocates the entry at the smallest possible index.
+ *
  * Must only be operated on an xarray initialized with flag XA_FLAGS_ALLOC set
  * in xa_init_flags().
  *
@@ -922,6 +926,8 @@ static inline int __must_check xa_alloc_bh(struct xarray *xa, u32 *id,
  * stores the index into the @id pointer, then stores the entry at
  * that index.  A concurrent lookup will not see an uninitialised @id.
  *
+ * Always allocates the entry at the smallest possible index.
+ *
  * Must only be operated on an xarray initialized with flag XA_FLAGS_ALLOC set
  * in xa_init_flags().
  *
diff --git a/lib/xarray.c b/lib/xarray.c
index 39f07bfc4dcc..ccc64005fe3e 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1802,6 +1802,8 @@ EXPORT_SYMBOL(xa_get_order);
  * stores the index into the @id pointer, then stores the entry at
  * that index.  A concurrent lookup will not see an uninitialised @id.
  *
+ * Always allocates the entry at the smallest possible index.
+ *
  * Must only be operated on an xarray initialized with flag XA_FLAGS_ALLOC set
  * in xa_init_flags().
  *
-- 
2.43.0.429.g432eaa2c6b-goog


