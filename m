Return-Path: <linux-fsdevel+bounces-42732-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A211CA46EAB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 23:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A672416D932
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 22:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3EA25D1F4;
	Wed, 26 Feb 2025 22:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsihiHmF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6128625D1E1;
	Wed, 26 Feb 2025 22:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740609591; cv=none; b=ouffO2HfIjk8pckipqXkeJJxhYuftX+3Mo8exE8WtMSoQ18LDKaEF6C8N19T4K2/itHCLYa7VAqclxmW0SaZCYnmoLlgsUG+qlD+/TVCS3TYy7cYHztaOoVDUIBG9pKHjX91NDMD54NMNdxJSh4tA8Z4ee5X6T5duRzWeGFOG8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740609591; c=relaxed/simple;
	bh=u2A9qCjDWZkzV/a5G2DIvQAlNnCeoYE8Rtqwv4VilKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LrvYq9hWcT4GhnHe7XsJ0ej4etF6j4fFFScD39AR+PyTOVMgBMPu/1Wp5ncn99OCuinhJ5vK+ZlNTyX2X3ynU8s/sjnsrWD19HTsfqQDcse/86ikMuC4GqqeDauShamHie4dGwvtL0209iBb4lpEIg0krK3yoMw8oybhabjVOnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsihiHmF; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4397e5d5d99so2107645e9.1;
        Wed, 26 Feb 2025 14:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740609587; x=1741214387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EsxB3niZhDLQXKscUY4SNZGf3lUEcngVn+r/WMhCyzY=;
        b=bsihiHmF0kFmwEfaX3UNF0Vjwvpu2pblgDX78du3Vx7XK6E6o/669sKgf+MUpW9bZK
         Idk7hIVqQRhNMS7zWkAXrvAQrsGBO7QohCsTjQ76gzjCXAE099KjwVUarj24Yd76FNZ6
         fTGRb+wx45uwhhtC32r2PTZEH/zn+ElIK/J0MovUwT8VjdUpmiIxCDFV89P9+dotV91T
         PtJuKjWFatpEv0NsHoGU9EPzp6b0FEnqSSv2PqyVMZgAB58/xTFP3Q6BYw2UHsRm20OA
         6PuUM8P3sAbIISePjIySSt+LtXV2PAWFs5YuD9oL2//5WJvQF+Ls+VAQXyD009NOfEeJ
         jStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740609587; x=1741214387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EsxB3niZhDLQXKscUY4SNZGf3lUEcngVn+r/WMhCyzY=;
        b=v2dXJbqSdA563B+GwYxoNr4RVaQo9GeSHi1G8EgULao6gZUUV7bJvMAvUmlKOZXBoy
         j2XY1NzjW5HU2qb2+Clwp0k89C52i8QtBsEsEjB2AwyL9F1PJIuwCZ/o3QQDtaaDGiSK
         0yiX/Ab04PlymeS+H5v6cfMyD3qgLBrIu8upihwuAJjL/Sv0UgaAFZ0TrPfFe7hulepm
         shevge/t5wmQp5+q3YG955p5Ug82qk0eM+ZZIsDcuC77Sf+w5i0ifwEwO3Xt2jvahMUL
         wjojLLQy1JAjC7C9n7FGgJAKc07kFAJ3x8iYsoPgslFJd2hWEObkW7iCDtgPy0GhQOuu
         1WlA==
X-Forwarded-Encrypted: i=1; AJvYcCUQsabP8gRNG1SSZascGH/jC1h16MtlJ3sWJw2w4Z3EkcO8iaUDUUh9LWml/pymrlwL4OBQTLsgid4LhlCW@vger.kernel.org, AJvYcCXPli9OHVhWKogwldLN40GZf5w47m6bO34B9QLknX9rvD73tfNH90TXOO7U6fIFS25b2ei+GEw3AsSu8UmD@vger.kernel.org
X-Gm-Message-State: AOJu0YyxHWCV9pJW5b+fGyHaheDHyhZZB6+m8rngDfU3j+IaF7IpCeam
	lxchFkMfUiBg1ANXMl1lRG4UUp2DiDFwR1CW+Tc3abUui94jJNLh
X-Gm-Gg: ASbGncvlOjonMASt+S6xjWWUMXMfIKQMnooATnQI+APgwPfB05XBHfeHgxGVS1f6Oc4
	Vs9awGmnUzuohCcOahZRbPBIAQkoEh9QkoFz8w5mEmEvNXSbHaPegpJhmFuo1+QNnS4IVgj5o7B
	1DYtnJgxgSYfzvM1NKsc9bNk9UPyukAobDMlFhggdL/JExkMt/Q0F1oMf0SOp+8iuda2Z09y2SB
	4Pc97dg0XAkXHY0zyXvJvIaqlMw8LGjWV76Gm7LHhFHf7UwRNS67PJLMezSFNJFvef0ZCq/6fx1
	Nyxg9EchZr01lQSYjkG2S4jhXU4=
X-Google-Smtp-Source: AGHT+IEKmoN/1Etv0GnYfbieq7HiOjjWHpmIeqo/u0VjHW2My8Y0pb14MM+VqaWPvkUE+4XaiIxTew==
X-Received: by 2002:a05:6000:1fa1:b0:387:8752:5691 with SMTP id ffacd0b85a97d-390cc63ce07mr8391029f8f.47.1740609587301;
        Wed, 26 Feb 2025 14:39:47 -0800 (PST)
Received: from localhost ([194.120.133.72])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390e485d6dbsm155058f8f.82.2025.02.26.14.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 14:39:47 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] fs: Fix uninitialized variable uflags
Date: Wed, 26 Feb 2025 22:39:12 +0000
Message-ID: <20250226223913.591371-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable uflags is only being initialized in the if statement that
checks if flags & MOVE_MOUNT_F_EMPTY_PATH is non-zero.  Fix this by
initializing uflags at the start of the system call move_mount.

Fixes: b1e9423d65e3 ("fs: support getname_maybe_null() in move_mount()")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 663bacefddfa..c19e919a9108 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4599,7 +4599,7 @@ SYSCALL_DEFINE5(move_mount,
 	struct path from_path __free(path_put) = {};
 	struct filename *to_name __free(putname) = NULL;
 	struct filename *from_name __free(putname) = NULL;
-	unsigned int lflags, uflags;
+	unsigned int lflags, uflags = 0;
 	enum mnt_tree_flags_t mflags = 0;
 	int ret = 0;
 
-- 
2.47.2


