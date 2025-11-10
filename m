Return-Path: <linux-fsdevel+bounces-67695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AFCC47489
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 15:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 525534ED49B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 14:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8F7314A80;
	Mon, 10 Nov 2025 14:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfoQaK8+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BFC313524
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 14:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762785793; cv=none; b=iGHEENYcJo3ZPJgnjf9neekfJBAKCvrxaeUtG0gHa3pnO3Xbpug00uYZXbUKg1PKThsP/9zg1Vf+z1kLkOcNohpygQmAlMMy7Cj0GGARGUaAQ1ZSLEuMrdj+6NDLvksk5jfXpShki2SPEQ0Xp6DGSM+/KMr9yj4Yyy8I4gALrXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762785793; c=relaxed/simple;
	bh=/E3gJIQjBTJ6pBJSXNOjyTL+w6L6Y1/FtKLBYQhekO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZdrEwzNOtrko2dNeRQL1Y7qhBMzXI4KicAj+SHfW6oiA2nTEqxOBM6wZMmu4jw6yfVbxHziVzYawHHNYdHSvYJqOQc/BUPD8BNGm59ozbVs0EUQA7RdhOKoGM7b5yym3R3z0DlC82n9bsckfTp68YUgsj6JLaqMJgi+2u+dZGtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfoQaK8+; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-340c2dfc1daso492483a91.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 06:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762785791; x=1763390591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9990Zs5Z5XVH5d3pKn1lkTCNXa3vBYG5og1GHLxwso=;
        b=AfoQaK8+zes7Nzru3pGNenzbk5dmTfEp4axm1tczXdaPnG3Hvm0fFhv2+2uoiw1VBD
         XQyIrkaUpF3JZ/gV+KmHE/bxTutXWqCrOft/Z4d24HGMZBT605vg05ThumZuuTrQ4LZ4
         F709XjvlJvBPZqliGDrfhABchTXB52l6WAJZY0HArY0DbMOTvLL9JjCS2F+n+MA15KcK
         JHRZqu2FwjLGzAe8ErtK1/p/hIsaj0rwL7FZdI/5uaGMOwBJeN13kTp+LStOvmtfqY8b
         bMyWZlZvUrz2DQzjQ73TwkMjKzda4EK4PMoWsRfkWl1Jx0zBjFYhIEV6nDe3CdK1BFtY
         0yhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762785791; x=1763390591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F9990Zs5Z5XVH5d3pKn1lkTCNXa3vBYG5og1GHLxwso=;
        b=MY7KEA+eD/KFuLmXmxFRoPyz6ybtQEvfcxkPmRM02u6EfWjwxzejnmZdguXAOWMSIA
         v7yowFbIux2z8maEVq16UNzEYVzVmi3XJ0lnJHRsmQmDgm1/Aa0s5YOA0cCYoAMzD642
         no5wHtZ95mDcZEZNWNRIyP5UpJCeOoXOkyFctnQ3MILzlD0gPo40fjkzNa9qPlL6CMh7
         XHdEsfVo7BTZDH2TmhRzJHE1UVKAKFwS4G/O9cZtw7cWSGIVwbbyd8kUfV1jXar3+ngv
         c/A47OTZZPaI/VnTLAMTbB47LjyvSsVooRaisjrSWg6QgZFrEjT5/QgQQyM+28TYLhuI
         2UmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXH0JUIeo0KxFYBrJia0eC5ntwJ1UgS0hhzt/MTjHX5GfzqoHn14bnKuVgpFrKaqPY5r4eBVj9L94cJVY3p@vger.kernel.org
X-Gm-Message-State: AOJu0YxvAf01nTqYUB5QSKItFeZ8/p3To/cQ0raIfHGKRfDbLWKPOnSC
	ZSlbIHLX75PQIYnlmYcKbU6Sj5B2sbzLVsz8u8PGx4GtJsFf/5tRSKn7
X-Gm-Gg: ASbGncsbwYZGMpCSrvKtse3UuVVxJurjDZJvX1nplIDnA7HF2IcKFMByR8CAAyEr7Gh
	5Xq2WqeiYSRz3c1fwC54EjBuxN7H8OB6/FloWdMePBai0PFLVRN+CK50hWFrUisZDF72YMpb+cS
	9myyOtQ+wV6O55CC3/YIZcVtWCT3WRiIyFwE/dkJw5ZSHItQAbTl+EEHvvK9c+SyXWzWfgtVvX8
	EActMPvgI/vYDISjSsNr4zQMl6iIzyzuYOkYgZD3rXzOR7RL+7zLyMs8DIikdN/GKLKZVVJ25wc
	Xldu7UsNe3w6rDK2o3sXmdZ8dL6GH7V9exn05CIWiPBBryRCn43RjpZ65fN4EH/PNrSP1g5r1Fx
	CFFkR66VN3JOm6YaXX56hC6hyQBdcpNoVA4RQGQ6j20eO9JvZ4eAh1gplID4FPhi+aidg3SS8EU
	Rku4U8yKnVE4gnxc/+M79zWiLGUtnAt8cO8/5mk8E=
X-Google-Smtp-Source: AGHT+IHya+A0auZJFr6yNuX36i+1/oEdX5PqTd5tyOpfqW09H+Ff+mZ5vBFnIAIjcQ2qncxi+Eqb0g==
X-Received: by 2002:a17:90b:164a:b0:32e:1213:1ec1 with SMTP id 98e67ed59e1d1-3436cb9c0d9mr6237006a91.3.1762785790881;
        Mon, 10 Nov 2025 06:43:10 -0800 (PST)
Received: from elitemini.flets-east.jp ([2400:4050:d860:9700:75bf:9e2e:8ac9:3001])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343abec3836sm2163308a91.18.2025.11.10.06.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 06:43:10 -0800 (PST)
From: Masaharu Noguchi <nogunix@gmail.com>
To: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Cc: Jesper Juhl <jesperjuhl76@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Masaharu Noguchi <nogunix@gmail.com>
Subject: [PATCH v2 2/2] samples: vfs: avoid libc AT_RENAME_* redefinitions
Date: Mon, 10 Nov 2025 23:42:32 +0900
Message-ID: <20251110144232.3765169-3-nogunix@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251110144232.3765169-1-nogunix@gmail.com>
References: <20251110144232.3765169-1-nogunix@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Users building the sample after including libc headers such as stdio.h
may inherit libc's AT_RENAME_* macros before <linux/fcntl.h> is pulled
in.  When that happens, the sample ends up with conflicting definitions
or the libc values leak into the rest of the build.

Drop any existing AT_RENAME_* macros before including the uapi header so
that the sample always uses the kernel values and does not trip -Werror
redefinition checks.

Signed-off-by: Masaharu Noguchi <nogunix@gmail.com>
---
 samples/vfs/test-statx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/samples/vfs/test-statx.c b/samples/vfs/test-statx.c
index 49c7a46cee07..0123ab4efe0a 100644
--- a/samples/vfs/test-statx.c
+++ b/samples/vfs/test-statx.c
@@ -20,7 +20,16 @@
 #include <sys/syscall.h>
 #include <sys/types.h>
 #include <linux/stat.h>
+
+/* Undefine AT_RENAME_* macros that may have been set by libc headers
+ * (e.g. stdio.h) to avoid redefinition conflicts with uapi fcntl.h.
+ */
+#undef AT_RENAME_NOREPLACE
+#undef AT_RENAME_EXCHANGE
+#undef AT_RENAME_WHITEOUT
+
 #include <linux/fcntl.h>
+
 #define statx foo
 #define statx_timestamp foo_timestamp
 struct statx;
-- 
2.51.1


