Return-Path: <linux-fsdevel+bounces-74307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6240D3946A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 12:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D0C6300CA3B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 11:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFC532AAA1;
	Sun, 18 Jan 2026 11:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCSpdxPL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568AD2E2EF2
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jan 2026 11:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768734289; cv=none; b=ho7tleYLEOcDOTJNoSSfWSggOo7d07mGH2DfUagfy31mUEwI38G97bHv52WyEk8+GmTR4jRnLMlnsNlyrqENmS1MrBl7/Q84tkmgCqbg6RmXtwqlzlJ5L0kkEB/9dC+wq/h7kthy+OjVyHA5zaWjEhhFJIXTgXiR1RtqrYjIxoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768734289; c=relaxed/simple;
	bh=r4uWeHohkE289LoTNv8GpIVlnQUlC3zCtKgj8uU2v5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YbX0dfMlCvu8PPOlahO+kZ3Ww0jCEhhkBMxxFip8tKVKsALOo7AyQRDeo0mGIL4wvBBlmscTLFp7KUIQg8F7Y/kLlDg36WAvhKduvUZZkB/pHeei5apCzC1xtDBEYoSPQoEAh1/arfFvU2N2vp5ujHFSNhDLOIunHlWeqLTBKGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCSpdxPL; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47ee301a06aso30127465e9.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jan 2026 03:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768734287; x=1769339087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rGOmWd4RF6L7Er27bVWEMPyI+kmYwKf7smupinnsaE4=;
        b=UCSpdxPLYB5L+NPxo4QrWTiGZLd1TGEZwuK+ojLf6ofCC98tLrTP/PGR4jV/HSh6MW
         +19sCQXYmdN/i8eOpQNQOmBtmU5GU/IcIKAORGHGdxXGmqb1XDnXxNoBWNniYoVzsu5c
         E5x80JpQEXGfOytGyWmsKOyuRQvlBYpJ2b3WjIxDvpfZIaD372fd1rtF3BvNAOVKQNw5
         tnTlEkvGyRZyYGiJCuZO1wxu3xsWoEccrezahe83IRia2e+C9e9mWEQB6Bo8K6tfvnbk
         E2t6HyrJndDq+zb4A+RsFU7BHE8E5O0qdhnCo5T4FTUd++c/45I+J0SPKhBi1SS2lKt/
         NHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768734287; x=1769339087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGOmWd4RF6L7Er27bVWEMPyI+kmYwKf7smupinnsaE4=;
        b=MeIo0tnXemZlMpxnp1Wplc0b97K4VZ/VqMbwRhrBwIJwb7Q1h7X9ekwxzTjgrnCoW5
         aQ1qfFQb4E4ojTVVrCMgANEe2Ia2ictSmZZH+rX6c4GYXiHKYty0m8pcJx6gwmlT8ZXc
         xtYc5A/joa65Tl8KkC6P9Fk4ZetgwOQoDaGcYGf3uD/QVnExIXy+HwnI7wQfgpEIjkDv
         iWTgip+Rjbl+9gAbm+QpWKHfokLMdS99I4g30TXkzvgj6+u5c/4/L7yIjSZDGVKiQc9z
         fFS25Jvb1BjaKd7OqsczX3X6GK61TxvRMquoCvJoybCDtU0sEeczMI0RMUbGWPv4ObWz
         IHjw==
X-Forwarded-Encrypted: i=1; AJvYcCVkDqltqzMKadUdBFMvJlTBkZ1JjvIrxJ9PoLXTWN/r2bqm0Eup2d8bTNiC5kPnkpGp3FghoajPX9YakG93@vger.kernel.org
X-Gm-Message-State: AOJu0YypR3FTHGgLIx99v7kgeWJ6x+9E0PQSSLaChfOUzXAcGaLZ0sTe
	AynZXTkreOQ9uk+x3f8qWCdl9/zriX+agfAmbEEZ0yPFLEuz4e2O3gpeRzxbLw==
X-Gm-Gg: AY/fxX5TPe5mxFhFR7NHeHu8vOgsvTiXD5sX/AXW6aXaXXStYD1yNgtEOcq8xPB1ipu
	w+hSoGFm6aJt9HmS6gKZigEBEAdW9U0EpHx27qVHgNbZ7sbW/rmOJtvkA+q8reT1JsFFzsBZVuY
	k/0kOkHnCebCsK7xrOF5jRvV5qUiqHwM5TkwQ57xoPjAOeXw4Y4pm5lonG8RdT3oq8TrT5Hi7D/
	RFDIjLnUy1lQ2Uu8/JKYk+nq11pkoggpLl0WKfba7BMnr1yzpJ3lz7KoaABTo9rSn3sJJUwsJJ3
	39IfBeBN9xt9MCHI6dnJUZybpwnU/nEyZTYjolpflQAkPWPdn4UV2OpeR4NRSbfQy2i5vfGYVQL
	zg8z/Q6GXj9riRghzv5sV9Gr5gNmy0JDbA5y7Lx3KPDtaciA/dCUflfrX2VIna/2z8ePHjbTV89
	ZVSEiEbB/vEUgSgErTiTmMpqLOnLQ=
X-Received: by 2002:a05:600c:1d28:b0:45d:5c71:769a with SMTP id 5b1f17b1804b1-4801eb0d727mr95491315e9.26.1768734286528;
        Sun, 18 Jan 2026 03:04:46 -0800 (PST)
Received: from practice.local ([147.235.205.132])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f428bb0b5sm191862165e9.8.2026.01.18.03.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 03:04:46 -0800 (PST)
From: Jay Winston <jaybenjaminwinston@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jay Winston <jaybenjaminwinston@gmail.com>
Subject: [PATCH] fs/namei: fix kernel-doc markup for dentry_create
Date: Sun, 18 Jan 2026 13:04:01 +0200
Message-ID: <20260118110401.2651-1-jaybenjaminwinston@gmail.com>
X-Mailer: git-send-email 2.46.4
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

O_ is interpreted as a broken hyperlink target. Escape _ with a backslash.

The asterisk in "struct file *" is interpreted as an opening emphasis
string that never closes. Replace double quotes with rST backticks.

Change "a ERR_PTR" to "an ERR_PTR".

Signed-off-by: Jay Winston <jaybenjaminwinston@gmail.com>
---
 fs/namei.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index b19890758646..f511288af463 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4975,7 +4975,7 @@ EXPORT_SYMBOL(start_creating_user_path);
 /**
  * dentry_create - Create and open a file
  * @path: path to create
- * @flags: O_ flags
+ * @flags: O\_ flags
  * @mode: mode bits for new file
  * @cred: credentials to use
  *
@@ -4986,7 +4986,7 @@ EXPORT_SYMBOL(start_creating_user_path);
  * the new file is to be created. The parent directory and the
  * negative dentry must reside on the same filesystem instance.
  *
- * On success, returns a "struct file *". Otherwise a ERR_PTR
+ * On success, returns a ``struct file *``. Otherwise an ERR_PTR
  * is returned.
  */
 struct file *dentry_create(struct path *path, int flags, umode_t mode,
-- 
2.46.4


