Return-Path: <linux-fsdevel+bounces-50958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E834AD175A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 05:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDC1B1889500
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 03:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B9F248F63;
	Mon,  9 Jun 2025 03:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iIs9s9nS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60DD248F5A
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jun 2025 03:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749438556; cv=none; b=nFltp/2FOmdHlE1lSSoHYw68A4LOg2ZziVmYF39CLZPE+XEtEMLVxlp7mMeUeQGwliBH3dyEc2mpMVolEj3YuRC9ZKnVFovCcNWb+p7Wn07bNtSgHP/m30I0SjM/6R9WnTo2cvc7lfo1EFpiDEqgfC0XdyEoxli5Z1Sr+rITIB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749438556; c=relaxed/simple;
	bh=+aCBd2ghwW/klUL9zxXGFrDo3NyzpBmQuv2HbBfHcbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lr1n3K5+QDCaEwKeT6xJ+BrbW+Fy+Spsp3VgarUD3kizjbQPOIfXJhfxLTdpPQKTt6iFM4ImbRfYTzIDMwDBCMBAnC7DUtHzm1YrjCPQ0a20upIzM0+qDQb0u9QK/A6bJMXvLHS1R7jTtLbL/xUO4aHA4VuF6KoYGE4vXBWX+CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iIs9s9nS; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-234c5b57557so34423665ad.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Jun 2025 20:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1749438554; x=1750043354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7CXEUIqwkwbaC9WL4kfbAYO9r9qnWAQ32Tn1bWOs0k=;
        b=iIs9s9nS4Eya2LU6cU9CgPrVN7L97Ys7O2xg+SJJPoySvOIkSVVuWeTLsdXTt7sAqi
         DLXA3shE1t9BYZDCDYZY7lz+JfJ3yBLZmeyTpwH9LluEJTeaAZIaZKBmrTorUZ2eJCm3
         CteWo6POVViKTNuTZBoXxMTh4fWO+pK6kdKM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749438554; x=1750043354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7CXEUIqwkwbaC9WL4kfbAYO9r9qnWAQ32Tn1bWOs0k=;
        b=EOT1H/sdUaiQ9MUpFYXGo4tjUpYksHzywlOeqZil+c8NtqxfhvgirWwbf/fJkYhStY
         7jBUX/2yJBnBbnEQqCSoYPxaRv2r5cMR5jopdNSPzX6QDeXRbja6gC0RMS8WfO5oRKR3
         a/zp0iCj6egzrVgylpEGnpB50ltIAo5822e2cOJhmP3XPEqipxGnvVoOqiS+WS+2qFQe
         QCcZq7bYwg87kJ6Asyvj7xlLBs7Gk5u++fI9MBXiyb/S5cX02lvWIwXNxsqOLq3J3t0V
         6nT2+/XPQW+cnZWnvc23LchzoDDtVBHrnjynzN9gp8jkla60qb1FPRr+8/KOEISGZdfk
         49nA==
X-Forwarded-Encrypted: i=1; AJvYcCWJvQtzTzAV9aVsvEyLu66KjRWEdb0wP8/9QprWNSSyJl9VhF5L8IX4vut1kraQBUwOWJSRV/tJ+SKj/7i9@vger.kernel.org
X-Gm-Message-State: AOJu0YxjngyFC+L/fli4bBWiRCQz1XMk4voDq4cfCYp29nufYSrCClvD
	ZnqJP5tZRkoCFXxt1+Cn/m+pPwOzIXCipIpKwLjcgRKqQEE/E27YbynKs8+Tis0sdw==
X-Gm-Gg: ASbGncsPCG0UgdPJ1OVrWNrdI/v6ey3r/kyk4WzFD5mE/WFMROKSh/aYNPUay5HHtVE
	cyxDccHBHIZysVFFR01WQII2JxXyP4jV7MlGkLKNyprHv1uAeA7G7THO1fGA9C+9ibjxN6dWJoK
	q4gp71wV+4dUEpVntkzp52D+h3nNmiUd+cdzJtIRg5NFQhMpCYmGlud0EGIMruTxsHHysFx3n55
	ddW3u65mvJxnAnFaMLqZgrYRp/AYAe9VWCpUDfoZOgnHa0mNWQUMSBrLrclmQ+ecyDW9rDsQKTm
	JRbWrJWGPlxXI5oAs81eB7rxHg+u+8XWZHBd55EmZXD5l7ZhpgLw+j6IwHWH85Rqvbv9ZBOEwoB
	FqdsirdpNT42v
X-Google-Smtp-Source: AGHT+IF9SqoM0enwHHeEeJDm6HNEPI1J9jfQ2jOvh5ECV8YfsU6gawfWVryQ79XsWdg7P2+sC2CUgA==
X-Received: by 2002:a17:902:d48d:b0:234:a139:120d with SMTP id d9443c01a7336-23601cf1e13mr147061665ad.7.1749438554311;
        Sun, 08 Jun 2025 20:09:14 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:eb64:2cdb:5573:f6f1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603410716sm44649645ad.199.2025.06.08.20.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 20:09:13 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Tomasz Figa <tfiga@chromium.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 2/2] fuse: use freezable wait in fuse_get_req()
Date: Mon,  9 Jun 2025 12:07:39 +0900
Message-ID: <20250609030759.3576335-4-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
In-Reply-To: <20250609030759.3576335-1-senozhatsky@chromium.org>
References: <20250609030759.3576335-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use freezable wait in fuse_get_req() so that it won't block
the system from entering suspend in some situations:

 Freezing user space processes failed after 20.009 seconds
 Call trace:
  __switch_to+0xcc/0x168
  schedule+0x57c/0x1138
  fuse_get_req+0xd0/0x2b0
  fuse_simple_request+0x120/0x620
  fuse_getxattr+0xe4/0x158
  fuse_xattr_get+0x2c/0x48
  __vfs_getxattr+0x160/0x1d8
  get_vfs_caps_from_disk+0x74/0x1a8
  __audit_inode+0x244/0x4d8
  user_path_at_empty+0x2e0/0x390
  __arm64_sys_faccessat+0xdc/0x260

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 fs/fuse/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index e80cd8f2c049..3792ca26c42f 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -207,7 +207,7 @@ static struct fuse_req *fuse_get_req(struct mnt_idmap *idmap,
 
 	if (fuse_block_alloc(fc, for_background)) {
 		err = -EINTR;
-		if (wait_event_killable_exclusive(fc->blocked_waitq,
+		if (wait_event_freezable_killable_exclusive(fc->blocked_waitq,
 				!fuse_block_alloc(fc, for_background)))
 			goto out;
 	}
-- 
2.50.0.rc1.591.g9c95f17f64-goog


