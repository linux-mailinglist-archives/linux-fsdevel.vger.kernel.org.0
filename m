Return-Path: <linux-fsdevel+bounces-70476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B6667C9CCD6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 20:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 247EE34AE33
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 19:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2268E2F2618;
	Tue,  2 Dec 2025 19:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T2w60A/J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C617F2F12DE
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Dec 2025 19:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764704294; cv=none; b=Y8+3H+qMmgTARmiaogcVYYNUk2eO6GBlBgPDEgrGiRxjcKAQEnK6qPRcCpvtK22e2gIDMiIEro+YUmcE3/E4jJPfG0jXn0sU1NkVZuYzttdVSf8ylzT6floBu/g9psnMBZbm9z2VzyUK8FBKV3RLnDdcK9wEeUmQ2JnSpBEvzT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764704294; c=relaxed/simple;
	bh=nrmkOqCV7ocjGEn6QgTEPI62gVcQmYigMQiNH975fcE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BjLp7chs4Gue+e9cN1jK7lsgwFhwRnxlUA2aoSinsUS+S9qIxLvyHxKMeii1R6S+isNzXsRgzNDFPq1sQpTBXJWqMDVktsv6aWW7g6e2/5nhC0mrVzMVvADa3NwLC8st/urAqAMCg0/PNqZshYdGwRRJv/fxovYUbQC0jpyUwPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T2w60A/J; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47775585257so41062775e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Dec 2025 11:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764704291; x=1765309091; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+O21Y6BxBrJfbXbsXUMMfUGXrVsdmNULpo//ikWcag8=;
        b=T2w60A/JtNYuOAKLKXUBlK31FZQ3EsuTx4DtqpW6jCFnjSbqX39tIG5+GgxZhVd7by
         RKoTiNvqG0uXg2WhcgXiE0C4HL1vJm4XIrMu3Khc3HNkfEZ5CF4WpikRzrdUEkrwA4rU
         zVWRbFx67VA/MLIU3jEAOnVO2BlKCGSZFzQ/9MQWaEXqPvJ/Tms7qJ2ZNogKKiYLjKfh
         tOVa5d4h4dHPF+D3uVMerQ6vO2Ty4hDH/i70qyiRKyF5ahNSjrJSZsn3tdmFuATpkBwE
         ynFrXLUXCdlUEOv3GOcNMIk9Lq9PQdiUActTGEIoHCe2c8kFBSQSKqGeofr5SqU5WRhy
         SvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764704291; x=1765309091;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+O21Y6BxBrJfbXbsXUMMfUGXrVsdmNULpo//ikWcag8=;
        b=lUCFmV+5rGxWFJ9kGRbVQwCpecidBRSx+RtSmfWoAtsWCYvJg/67O6LU7TcdKVRDId
         luhkP0r0RHPihTyOjIj11hOexBuUGE8P6V6Z6ib3QYNiDdnfMYlFe7PVJICHHXfJfynM
         XHMoyINZr0kiFbacudid+vspJ4qqf+xXxPwyHEU6p1nOccYTBLIurFvSzLuqIPoVrytH
         kcdqBLLZ/Df0CyR36LCvPs7okrJz+DN1x7UsGT9Vt7S+xlSENn68Qv3N7e+CAFvPf2UR
         zf0O+q0kaaafBcej2JWTphqqepVjAEXae0N46alcfTgfZotGKDRFvEU+hzqlgJqDrYTf
         Hb5A==
X-Forwarded-Encrypted: i=1; AJvYcCW8vC0X5UCS2Xq2Gs3xApLWuu70p+Vw1b376oLZz6BVKg5GNzMneUD9d/mh0D8Ab8OyBRUsOC0BTMW2vn3T@vger.kernel.org
X-Gm-Message-State: AOJu0Yx39FGalTXCXxSc8JjUVlkk3nRlaMPlri4VcSLkX2AKAT6c8XAa
	twfyuQtb8Ct4SPghIlUKBNhmkuxlIK8ewC4zu8uxk4ZopxC7tm4jfwHE0p3N5tOY/8eTkZuFVWu
	YpCkdQuzjTqNtbblW6g==
X-Google-Smtp-Source: AGHT+IGJhNJ6fdkKPz0fEer0RCHqcdeCiQS5QAFfJGasqEvSFa0DpvrJs94MsIvPxEzzdpQYnq2TpN3p6gEfAw8=
X-Received: from wmco13.prod.google.com ([2002:a05:600c:a30d:b0:477:9d88:de6d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:45cd:b0:477:952d:fc11 with SMTP id 5b1f17b1804b1-4792a6112c1mr8153245e9.16.1764704291267;
 Tue, 02 Dec 2025 11:38:11 -0800 (PST)
Date: Tue, 02 Dec 2025 19:37:42 +0000
In-Reply-To: <20251202-define-rust-helper-v1-0-a2e13cbc17a6@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251202-define-rust-helper-v1-0-a2e13cbc17a6@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=780; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=nrmkOqCV7ocjGEn6QgTEPI62gVcQmYigMQiNH975fcE=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpL0AIG8MtytrS+nDHlPRvfJf7YOQNDYwcAWYVB
 YM8U3hFPleJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaS9ACAAKCRAEWL7uWMY5
 Rh0JEACH8pjfDtrai2a6Zg0Alno+thLKmojRD0ODC8gNoJKM/iTpVgQ4W/BElUkBzeZ0/WVUKES
 BZv0jeYQxQfkiSwkm8SncMlXb5ZgOY2jRVzzzCEQSYMs+XWkVCf4phy58X89dPwXG7LYGuTbCv5
 rWOpTTw7rDK3fDN1krHOXHad3oXuP5cb3F2MU2wsVUJfvLjGLYGi+dfE8lVHoxQQZ+RD432p4z8
 KUcTPJGqVMmF/+/p8If+eT1idfSAHFxqe4xWnijqd+dgZaTWUiL3joE9Gn/67sg6QcDgZ2YChNa
 hzXb17CM5FihJPUNk7jelAmHv1yuV9DQeiY5gsOiqI8BUjtS4BQk1HJZzz/WK8jGmEkLtTPiMtY
 jj5C9MaKlzpOaVQ2QPY/CPnnE2kxiZgiJ/v7pfI41AUZ3a+HrlFst7IVunicvj5VG1esswCwLti
 DlpCqsemkFl0F+GAYKnNPQ9RbVgtqG/uplHdT+zZPwwNTikCPIVFMAlLc5XfOWlVLBL5sil0osv
 ryv4yBUTIJ9fzyoAHtHSt50qPyo8iiV9JV/leyRtBUoUySTy0fJi1YXJ1B4AHUmMgpnm/J2UWHH
 qMQnxZzXbZRJPpBD9LiLs+vqzb2bZA8L0WojMUcW010qkBw2mu4lHXuqwCrXlIF1MK8lLchCsi1 qZp8JqfAY/oSRAg==
X-Mailer: b4 0.14.2
Message-ID: <20251202-define-rust-helper-v1-18-a2e13cbc17a6@google.com>
Subject: [PATCH 18/46] rust: fs: add __rust_helper to helpers
From: Alice Ryhl <aliceryhl@google.com>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

This is needed to inline these helpers into Rust code.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
---
 rust/helpers/fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/helpers/fs.c b/rust/helpers/fs.c
index a75c9676337246ce532ef694e64ba9a7d7ad5842..789d60fb8908b99d5c50293cb7a3ec6c61e768f1 100644
--- a/rust/helpers/fs.c
+++ b/rust/helpers/fs.c
@@ -6,7 +6,7 @@
 
 #include <linux/fs.h>
 
-struct file *rust_helper_get_file(struct file *f)
+__rust_helper struct file *rust_helper_get_file(struct file *f)
 {
 	return get_file(f);
 }

-- 
2.52.0.158.g65b55ccf14-goog


