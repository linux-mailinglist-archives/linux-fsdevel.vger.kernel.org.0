Return-Path: <linux-fsdevel+bounces-65632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B9465C09C9B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 18:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56CD8580061
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 16:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A32C324B1D;
	Sat, 25 Oct 2025 16:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6Bz5I2O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EF5322C60
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Oct 2025 16:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409751; cv=none; b=cLiIDSKwh/a/UtpBLCI2A2k2HQ71xxO1wKRaYpB6nMDnASdRZdVpAiDdbQX3mZr1t9ZA8QuGJDsGfEdyag+tZ/yYM92pD1GXDhRZ4SsVEN2t+qWVZFd2ewB2z330Q/IyZmXUlZa5hpjoLyQ7NQJtFYMiRamMftOXXr1x53iBUwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409751; c=relaxed/simple;
	bh=zAr2NN3Jns2OMOMJhebylpaZ7+Fr+NR7SMgQK33hi4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XmlgfLEuvTHzMgRYRC/Ryt+VON47WlU/2xxal4OwGWfYVlKch52T1WK1M60RCrTrTAMHa0y+HwYarT8IJiquzS7WOBL8sDFAD/Vae7Qo1lxE6b++r7lLZCNSpRwX3G2BecNJXvqcQLviuWHpJKC40YfRlAtNpYDdH/pBa4/X8RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6Bz5I2O; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-7f7835f4478so22886006d6.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Oct 2025 09:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761409748; x=1762014548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdGq6o03y1IFQKw38Yd5zNXdE2p5YkP/ZYXUEcu9OkE=;
        b=i6Bz5I2O9jVbID42iDVIbOzlEr5XwhUAAjk8FWt0wYGbdmgSQ7+rQOE3yf8siJqS2c
         LKwXvWYtS4g4AsyaLon14YeHlKq5s7rAVUp3v0VbAvkEPuE4ZzZ3HswDQtJ8umgRzqFO
         5UVGrtYlOrOoc3RmNYTVseuQ+Og+2oo92dJ9CIuPws6U68ALLIwe9Ei+onlmo2aGCM+L
         OhkYxevNLYgCRp4TeKfHuMvyU/c2ZB0ZIEsyPKmPQN0XwW3vN1JHEqx4QVii8Seh2TOY
         zIcQBi1OjFRHwLHH1wHwcqIF8eKWtuz4u4nAgbvxP3jYwQ1xHM03ZW2FQVZg50/uuZeZ
         j8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761409748; x=1762014548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdGq6o03y1IFQKw38Yd5zNXdE2p5YkP/ZYXUEcu9OkE=;
        b=P9qbqqRmeqIiM1DBGEAEFIPod02EDespQ/gjgX4dTCOujRgDmt70fNRFQ6Txyim4DW
         hjZpWHL5/KXcE5YRk9J/QZ3SPiol356Jd5ESXNFPGlECm+h0rUmfL6tKb3SwptE4AcX4
         upqVSrXQFusIU1jSji+tLT2FOBpNdWM6pXcqib1CRlvtbHYQl9PMqynemx/RkMkJ4h0k
         s47q0tJ5Z2FhUj1ZmbrsewDLuC9UxjfayHzAQKCFwQxYZbtCLnP3kYr++TsYRHnIxanq
         xqfM1E9eOZv2oxqnrQYrmilghoaCXhVUpChsDHTzcwfJeWBRQUmtcJZTGj9EWs1gYTHJ
         1BQg==
X-Forwarded-Encrypted: i=1; AJvYcCVDdEaKRmQuJjzVkqjlIspw0H02PRAXxUHsrd3OvUqAIoN2S9ZsDX/Yubz/gn7YzaIFUVQMUuCqzTIUsJlA@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgg08J70S0Ts9mAjlr//2Aiea/g0eZ6GmQpjbejp6XBh7o41L6
	DzNBqPAkKJ4wdt1jkW6qZHU5uG+ileiQJ4kxIvRI/xGcyqJRvQt59IfU
X-Gm-Gg: ASbGncvyAHsyGiSXUmku3997AGQ31MJr/PAEFW8dT2tMvwQDw+P1A6svd/7TnCp0uNa
	GiPc5vWrHMcjc81gDayRvlar/bqpdRPG3wUcqpctPQH+RmQazpyROWV6WTBGKtK1fZU8cSyHGmW
	XvM58tIZgnoTbUPeJXB+FCPEEeUL2iTYBEMJTEaT0G6b/MCT0f5qUh+e/FwgWoawPKeKSFfDO1X
	oD+zOS6gRBdBMR6KH/fPQLesJ/YzKuQeOOCFQ+cX+6TFESqS/eKP9sh1L40UkIMlB1hFbvLZqiT
	6XNYKpVt8MXKGkAd8V40lmrKqLeUqVoHuPMf7sZncFnkyKowEj5/PMIx6V112B/FLLgKSD5dPFT
	jlrpD/+FcbKDvIR2j/5wMvzhknRyVD+yjx/1l6ZXwmXC93WdE0u+p6yemZ6YqB68rAAx2DyDjI8
	mwbf9+LRTvhBosNjn58g==
X-Google-Smtp-Source: AGHT+IEWdMIG+klSNN4Q5YLgAGeFSgXTpZGuYAcS8sJZ75faWnXPFFjnzC68BJ5CVQ3F20pqCi+JnQ==
X-Received: by 2002:a05:6214:450d:b0:87d:fee6:727c with SMTP id 6a1803df08f44-87dfee67d65mr177200556d6.59.1761409748012;
        Sat, 25 Oct 2025 09:29:08 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc4944d57sm16187276d6.35.2025.10.25.09.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:29:07 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 03/21] select: rename BITS() to FDS_BITS()
Date: Sat, 25 Oct 2025 12:28:39 -0400
Message-ID: <20251025162858.305236-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025162858.305236-1-yury.norov@gmail.com>
References: <20251025162858.305236-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding generic BITS() macro, rename the local one.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 fs/select.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/select.c b/fs/select.c
index 082cf60c7e23..ad5bfb4907ea 100644
--- a/fs/select.c
+++ b/fs/select.c
@@ -412,7 +412,7 @@ void zero_fd_set(unsigned long nr, unsigned long *fdset)
 #define FDS_OUT(fds, n)		(fds->out + n)
 #define FDS_EX(fds, n)		(fds->ex + n)
 
-#define BITS(fds, n)	(*FDS_IN(fds, n)|*FDS_OUT(fds, n)|*FDS_EX(fds, n))
+#define FDS_BITS(fds, n)	(*FDS_IN(fds, n)|*FDS_OUT(fds, n)|*FDS_EX(fds, n))
 
 static int max_select_fd(unsigned long n, fd_set_bits *fds)
 {
@@ -428,7 +428,7 @@ static int max_select_fd(unsigned long n, fd_set_bits *fds)
 	open_fds = fdt->open_fds + n;
 	max = 0;
 	if (set) {
-		set &= BITS(fds, n);
+		set &= FDS_BITS(fds, n);
 		if (set) {
 			if (!(set & ~*open_fds))
 				goto get_max;
@@ -438,7 +438,7 @@ static int max_select_fd(unsigned long n, fd_set_bits *fds)
 	while (n) {
 		open_fds--;
 		n--;
-		set = BITS(fds, n);
+		set = FDS_BITS(fds, n);
 		if (!set)
 			continue;
 		if (set & ~*open_fds)
-- 
2.43.0


