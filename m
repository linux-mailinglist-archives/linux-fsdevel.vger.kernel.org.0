Return-Path: <linux-fsdevel+bounces-46395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D67A88648
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 17:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF08019037E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 14:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D46027465F;
	Mon, 14 Apr 2025 14:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfRHhff0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D04827586B;
	Mon, 14 Apr 2025 14:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744641922; cv=none; b=t8oTFe01hxN1siQ1tM4bxXkdWXnrJf6L8HmHsVOD69rKuLOS9sLZlE6ZkxM1cRt6MGi5Ofjh8znR5Vuz4FmxhrhF+hqJHQ5fCuqzfKW5U7IACiTbd/ld/ZkIhqgy1Bg2KnQzwjBYw3nhyNxW5IO7Dxj892Grz148QbOcduo7v8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744641922; c=relaxed/simple;
	bh=2DpxWFB8GfjCpGlzdPOjDPzw7KOI6edLbKfo8ihKDf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r7PqG4hh4RZp3FGXKvrGlTz5g0p2gfDbEuzGdrlxOO5rk9ZESm1Kozf1GQbD2XHWLNDCaJes+rAwgt2JkHsgBlcx5Vk6yxoWJGDkRWOyB/GiydZpbjxw9geUgFOFm5hoNIyQs0jw+R/DD3swzWR9wXeCrZ/crZlUaYnzLPUBxRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfRHhff0; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22423adf751so40269555ad.2;
        Mon, 14 Apr 2025 07:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744641920; x=1745246720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+orTHrsoG/ME8bhkDWeas24eb9SABWKneSlnhlLedmM=;
        b=cfRHhff0nulDH7Yjz6p+6MGWtlH0WFjHM2n1kRqHCNRM/YWpOFf2zf1Fin4CqQ+vcl
         n1oUf9jmHFoTQm4e9kSsyrmCZzN4ZyqD/IM1O379+wQlpmaxN/nZhgbw7SzAdRK9Ag6Y
         Otg6fd6VIOs3wilaN5bwpX59JcUi7SywrjMd2R6dsluk2bP7/fQCjyjRlwpj3L+SlXHg
         FYypjcKXepTryec5P3PFaYlpdR7cIqyc0vVEV9Ndge0TP5x+9+rEtrxCUl4adEuVdeYQ
         1cM5SFGJx3zesTaGxuLE+K9+JdOYnjCswN+kwXG3IWdRYViwIJ/zAtSgahK3IYRcTbeC
         9igQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744641920; x=1745246720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+orTHrsoG/ME8bhkDWeas24eb9SABWKneSlnhlLedmM=;
        b=PF67pctCINCZD2woSTGN8/e0cCDEAyzL9O5lF8gBG8SCO0pZD3suyBqwEnj4ei2CXw
         QJaern3xIHCd7NOaiuiQNA+wUGwi2GLIXpVDecRHyV+lzV7joR2WQKGk2E4Nht9bOW+I
         7Hs8T/cVRPkMmpOQZiIhjyAD7jvulhMfGb5yontBb4B3hRb/JO0MK21fW7uBMwe/415h
         G0/z0id8Jv9r8JV0sjqlEr52ASE/k73BpVSBVOX6ghBPHRGw6yD4V/iT9dTFZqwkJKZ/
         N/KvoC+ndx+pbHDoTOqiDW8yFoTEZI1smfHVwyB92pm67eqgOztgLv4Yv3TlhVR9+Vm3
         QltA==
X-Forwarded-Encrypted: i=1; AJvYcCW49CF3DYWiltOmIVo8uxHHGW0LmEDHJwmAm6vJUfKWDKiimTJtU7sko86sW8LiM70/+1SHJoy9I59s1q3J@vger.kernel.org, AJvYcCWsMPU/xoEn16DJZovm28dMGyVPJdCDchtx5q/On1wsVgRGtONvVjsu1Ep2BXNVkpzI9Ryw5qEZmRTfxO0o@vger.kernel.org
X-Gm-Message-State: AOJu0YwWKFrNLktN24c+OhNa3cQk3ZT93W2eauXpdn/wtw1c8xWBxgiI
	+KESdcwHr2A92BGuxjVTuvuSudWX8vBNIJ7yZH16VfZqhU14calD
X-Gm-Gg: ASbGncsLchpdj0B72X/UnrjYcGzGUEOWLTy8RcjTjI9uMHjMq2afEkJ0zKtY+MiU0Nf
	TCszsitxCfLlDy9hZc3hcITgI2WChU6l21IJm2SHHCPE3I/iybsFGEmxsvAXvQw+Qd/IPDzHWJ5
	PvFzZJm32nuow5/9GS1oLTKrYSWc7m3npVueuvtg4nmf4Oo2aZUC6St74UxOdb2cynr+MP34Ykn
	VUMAWAbQwpxcsHGubmCy/EJNV2/s7iHUN8S/ccWxgIAZEeM8cf90rxCgbifqVe0ERrm3AOq+s9j
	U1xO7qCRdnK+h5w3+Hxjp17WXO6fjHQYz2QQEdTxucacIec=
X-Google-Smtp-Source: AGHT+IEMgRpQYfoBA1S0n/al1fUAyAoCcCwKAz83jLvqKd8Jlsw51W5KzaB+ji8UoJnK9Zaf7WJETQ==
X-Received: by 2002:a17:902:cec9:b0:227:e980:9190 with SMTP id d9443c01a7336-22bea4fcad1mr187715005ad.44.1744641916935;
        Mon, 14 Apr 2025 07:45:16 -0700 (PDT)
Received: from noctura.suse.cz ([103.210.134.105])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22ac7b8b2ccsm99959365ad.70.2025.04.14.07.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 07:45:16 -0700 (PDT)
From: Brahmajit Das <brahmajit.xyz@gmail.com>
X-Google-Original-From: Brahmajit Das <listout@listout.xyz>
To: 
Cc: jlayton@kernel.org,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	netfs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/1] netfs: fix building with GCC 15
Date: Mon, 14 Apr 2025 20:14:57 +0530
Message-ID: <20250414144500.20934-1-listout@listout.xyz>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414141945.11044-1-listout@listout.xyz>
References: <20250414141945.11044-1-listout@listout.xyz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since the Linux kernel initializes many non-C-string char arrays with
literals. While it would be possible to convert initializers from:
   { "BOOP", ... }
to:
   { { 'B', 'O', 'O', 'P' }, ... }
that is annoying.
Making -Wunterminated-string-initialization stay silent about char
arrays marked with nonstring would be much better.

Without the __attribute__((nonstring)) we would get the following build
error:
fs/netfs/fscache_cache.c:375:67: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
  375 | static const char fscache_cache_states[NR__FSCACHE_CACHE_STATE] = "-PAEW";
      |                                                                   ^~~~~~~
...
fs/netfs/fscache_cookie.c:32:69: error: initializer-string for array of ‘char’ is too long [-Werror=unterminated-string-initialization]
   32 | static const char fscache_cookie_states[FSCACHE_COOKIE_STATE__NR] = "-LCAIFUWRD";
      |                                                                     ^~~~~~~~~~~~
cc1: all warnings being treated as errors

Upstream GCC has added this commit
622968990beee7499e951590258363545b4a3b57[0][1] which silences warning
about truncating NUL char when initializing nonstring arrays.

[0]: https://gcc.gnu.org/cgit/gcc/commit/?id=622968990beee7499e951590258363545b4a3b57
[1]: https://gcc.gnu.org/cgit/gcc/commit/?id=afb46540d3921e96c4cd7ba8fa2c8b0901759455

Thanks to Jakub Jelinek <jakub@gcc.gnu.org> for the gcc patch.

Signed-off-by: Brahmajit Das <listout@listout.xyz>
---
 fs/cachefiles/key.c       | 2 +-
 fs/netfs/fscache_cache.c  | 3 ++-
 fs/netfs/fscache_cookie.c | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/cachefiles/key.c b/fs/cachefiles/key.c
index bf935e25bdbe..1d5685edd1c9 100644
--- a/fs/cachefiles/key.c
+++ b/fs/cachefiles/key.c
@@ -8,7 +8,7 @@
 #include <linux/slab.h>
 #include "internal.h"
 
-static const char cachefiles_charmap[64] =
+static const char cachefiles_charmap[64] __attribute((nonstring)) =
 	"0123456789"			/* 0 - 9 */
 	"abcdefghijklmnopqrstuvwxyz"	/* 10 - 35 */
 	"ABCDEFGHIJKLMNOPQRSTUVWXYZ"	/* 36 - 61 */
diff --git a/fs/netfs/fscache_cache.c b/fs/netfs/fscache_cache.c
index 9397ed39b0b4..ccfe52056ed3 100644
--- a/fs/netfs/fscache_cache.c
+++ b/fs/netfs/fscache_cache.c
@@ -372,7 +372,8 @@ void fscache_withdraw_cache(struct fscache_cache *cache)
 EXPORT_SYMBOL(fscache_withdraw_cache);
 
 #ifdef CONFIG_PROC_FS
-static const char fscache_cache_states[NR__FSCACHE_CACHE_STATE] = "-PAEW";
+static const char fscache_cache_states[NR__FSCACHE_CACHE_STATE]
+	__attribute__((nonstring)) = "-PAEW";
 
 /*
  * Generate a list of caches in /proc/fs/fscache/caches
diff --git a/fs/netfs/fscache_cookie.c b/fs/netfs/fscache_cookie.c
index d4d4b3a8b106..c455d1b0f440 100644
--- a/fs/netfs/fscache_cookie.c
+++ b/fs/netfs/fscache_cookie.c
@@ -29,7 +29,8 @@ static LIST_HEAD(fscache_cookie_lru);
 static DEFINE_SPINLOCK(fscache_cookie_lru_lock);
 DEFINE_TIMER(fscache_cookie_lru_timer, fscache_cookie_lru_timed_out);
 static DECLARE_WORK(fscache_cookie_lru_work, fscache_cookie_lru_worker);
-static const char fscache_cookie_states[FSCACHE_COOKIE_STATE__NR] = "-LCAIFUWRD";
+static const char fscache_cookie_states[FSCACHE_COOKIE_STATE__NR]
+	__attribute__((nonstring)) = "-LCAIFUWRD";
 static unsigned int fscache_lru_cookie_timeout = 10 * HZ;
 
 void fscache_print_cookie(struct fscache_cookie *cookie, char prefix)
-- 
2.49.0


