Return-Path: <linux-fsdevel+bounces-35647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 443F99D6AB3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 19:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC52B1619B1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 18:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D480F13D8A4;
	Sat, 23 Nov 2024 18:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsSutRg6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D92195;
	Sat, 23 Nov 2024 18:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732385572; cv=none; b=N9hgXHDeW2BhdqDPp5nsyJrIJ0HAJUcMOfRC9E547iH5y3GDuPAQ+NWdAzhFO9RmwLIxxOwlHPFqR0TPGaZBOQ7y6N/Cw97VmbivVKQH4MwmygteuS6vrkoyhTiecEjWdaYNn6hxRttXDe839IJ5XErDgUj1oE29zdc0IsfzyCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732385572; c=relaxed/simple;
	bh=R2R1bJvC1JbLXYePWO1fLTwbinni8hNJ5PB3vLNn5K0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VlSLwBDm8/8nLVp2xvFi1agAfL94NWmSi8QLN6xFCJYIpcf3+ETlehbnOrJC8ycPofmg7je3BW33eqII2QecKw7zNTzUSsRiAEVtgxfFWW8pGM0OWG8LcaJPyS81aJ5w6DD6m2GFzTsJv04O2jGdUZBX1EK/N3j4VLzbZ1d/HFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BsSutRg6; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2126408cf31so23483575ad.0;
        Sat, 23 Nov 2024 10:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732385570; x=1732990370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mGwjePj2X/S6Q0LK/ColR4L57+PTf7RXOd0t5g9s6I=;
        b=BsSutRg6PUsPAXcFapMwIij4D7xLGQtWmq82EZGmNKfddgjPBlnKxdalTQucRBeyZf
         PciDs+WrkyxKoJTY3eWa+6Y75R/bbwR/bPiAgJg2K3WDCF49pTDmszp2aZBpDgTAWTwb
         jx7dhb1pMYj53iRI04+yv574Xl9Kf9WCKGLFoHJ5tquvJZJB0kwZLI2bL4/U5JoczD9r
         WryAuQUsRAt4diNxdzm3poQXLht+eqebkjiugzyz/N80/OooS3UMlH5daGbgMr9So/Sb
         GKsDym9r2QtodimeIB+s5e9QDg+7lMevy3myuWXWhezYzYnX2DB470GTtnpISLjkL00d
         tczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732385570; x=1732990370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6mGwjePj2X/S6Q0LK/ColR4L57+PTf7RXOd0t5g9s6I=;
        b=vUUyUVu8uwuHUbiDALYVBJQSRxl0EKU2I3Oh766Wc1GnvZt/lv7CHC3VbOnyE0/Nfj
         2igp+P16gXKI6wvE6ZlR1v77uBJpcHQFUEZYYeRqHQNxDc2XGLuO4wwKWQsawqGMUfHA
         Z5mcDOR8hupMjKCFvyspof6o4THsB8wuXQQwJqdu6vl0YDXTX8xBfkVluCl1bBv0HCmi
         48BRU4bfmnpLl3FORHRWxDxpPNmGcHInJk4APkRkq2d9l2wzJ3HTRReMkAGoE3uUI5eo
         HPTeLKUB5fl1RGDmDXHlV33VUPpTNqdVGL3WUWz+8VZGa9L6+z0oC1BRmN233OJKQfbL
         /88A==
X-Forwarded-Encrypted: i=1; AJvYcCU9Y0XlLnlFo9sQL4LBVqnHlKmski0BP3DSno6r6WUGkTj1IDk6eAqIBG8GVDXRs3H+UlFbSsY/MBBFU4MU@vger.kernel.org, AJvYcCWJmPm9myCd4F0gCYqC3rwQrMkRU7cyKh/rYIpuwgXpIDJtqXkd76Qu2Ylm7++WxN3kWgKHLtLcFxlZG8+8@vger.kernel.org
X-Gm-Message-State: AOJu0YwWj0baP1pGVZRfNvtCd23W2d4drDP6Fcmsd9bTCgWL0XRsS7L9
	sLS6Ydw5uZ0RcW2DbSPqhi3s8fCK6UeU4wIcBkI6gYsEq4Jzr2+jkwYq8w==
X-Gm-Gg: ASbGncsEGRO7iZJ4bZlbaxkXdeqgyoLuQAOjGE6g36OgpqGX2mV8fLm4sJIqc+OWyJ9
	H+AQQez9NJ/6kkzIQY6WxGsux/XDeB8KvnXV5Ru32czRoGROkJfPNHX3ZMLXBhIZRkv9ycJnar1
	tU5SjRaQUb6oagTDeGJH/idlso+KIV2ujr4pCKXZ+83kTSoDxE427u8c2ilI/7X461IEIZP7SgT
	XN8DxxAWvamHjcjUrvrQmlCMBsDJUYGuTX5p8IqmlAhA97PCVhlsGS/CutTm16/Ww==
X-Google-Smtp-Source: AGHT+IFp9UCIDEv0Gz0cA9PNGKtpFJy6qbbAmWV3AZj7ST53U3JGReI0r6WzfznTycx67ZquKXpIZA==
X-Received: by 2002:a17:902:dac5:b0:212:500:74e with SMTP id d9443c01a7336-2129f51d2c6mr104835925ad.11.1732385570210;
        Sat, 23 Nov 2024 10:12:50 -0800 (PST)
Received: from localhost.localdomain ([119.28.17.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc1746fsm35555305ad.219.2024.11.23.10.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 10:12:49 -0800 (PST)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: alexjlzheng@gmail.com
Cc: adobriyan@gmail.com,
	alexjlzheng@tencent.com,
	brauner@kernel.org,
	flyingpeng@tencent.com,
	jack@suse.cz,
	joel.granados@kernel.org,
	kees@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mcgrof@kernel.org,
	viro@zeniv.linux.org.uk
Subject: [PATCH 3/6] sysctl: refactor __do_proc_doulongvec_minmax()
Date: Sun, 24 Nov 2024 02:12:44 +0800
Message-ID: <20241123181244.183918-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.41.1
In-Reply-To: <20241123180901.181825-1-alexjlzheng@tencent.com>
References: <20241123180901.181825-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extract the local variables min and max as parameters in
__do_proc_doulongvec_minmax() to facilitate code reuse in subsequent
patches. There are no functional changes.

Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 kernel/sysctl.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 79e6cb1d5c48..05b48b204ed4 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1020,9 +1020,10 @@ static int sysrq_sysctl_handler(const struct ctl_table *table, int write,
 static int __do_proc_doulongvec_minmax(void *data,
 		const struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos,
-		unsigned long convmul, unsigned long convdiv)
+		unsigned long convmul, unsigned long convdiv,
+		unsigned long *min, unsigned long *max)
 {
-	unsigned long *i, *min, *max;
+	unsigned long *i;
 	int vleft, first = 1, err = 0;
 	size_t left;
 	char *p;
@@ -1033,8 +1034,6 @@ static int __do_proc_doulongvec_minmax(void *data,
 	}
 
 	i = data;
-	min = table->extra1;
-	max = table->extra2;
 	vleft = table->maxlen / sizeof(unsigned long);
 	left = *lenp;
 
@@ -1095,8 +1094,10 @@ static int do_proc_doulongvec_minmax(const struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos, unsigned long convmul,
 		unsigned long convdiv)
 {
+	unsigned long *min = table->extra1;
+	unsigned long *max = table->extra2;
 	return __do_proc_doulongvec_minmax(table->data, table, write,
-			buffer, lenp, ppos, convmul, convdiv);
+			buffer, lenp, ppos, convmul, convdiv, min, max);
 }
 
 /**
-- 
2.41.1


