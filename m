Return-Path: <linux-fsdevel+bounces-13226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5331B86D708
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 23:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C99C287976
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 22:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3F460EEA;
	Thu, 29 Feb 2024 22:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KG3THHXW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEA016FF47;
	Thu, 29 Feb 2024 22:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709247102; cv=none; b=leCUTGzlcz0KQVNycH15hSryZGacKXtTnOYlzDuyaKdK0eXhap7gT9kM39h3wZfTFVKbrOeTRoszvpgmaO3Gzs8Cz4COLeUMy2cH7TbBN91cSfytTxsLhxpzhOBhxDHg0F81P/J3FjSzzzamm6wMTlFHqOt9kptqgatDJZNEBRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709247102; c=relaxed/simple;
	bh=gENCS1RwyKGGjAJ+g0H0xutNIpNay1XIcumfYiGBmXk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=dlRIuT1meW1BTL2rb9fOM3lCHb2JVgvGQfCRm9HRrkERxMjXFAyzCV8vMltX60Qz1scPRk0VHCXcbXdRGlW0na618CRBqxi8mnL0WeZ2Kr5VMMjLG2cqRiILV+kasXQA7wYPviJMrYR9v8o9UVJqBO1fzTFfP7IW6ii/HMqAh68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KG3THHXW; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33e1692fb02so360303f8f.0;
        Thu, 29 Feb 2024 14:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709247099; x=1709851899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3L9ixUueiI05jpi7f65YJ28x09hBlNI3L5Dn4dXdhtw=;
        b=KG3THHXWTlwmOz7fRdMrOyf7QTI6SBz1zlS3vhVSk/wBOrlp3rkaqvL5/0NQ/84A+T
         x4VjIxidH42trSgnvKBoDhoqJDyd2RsNP8F4Ibb0b+ECdgKkn8wbRuLjF8ePTI3BYivX
         mZf1uKnTg2pqLn0dtU9iRUNy/inbG5uXGdj287jJUf96tzLpzKKe9chF2hkmHw5u6r4Z
         +WBy5C8ZHXTkQW8zArf4rqEI2ENshY+i8Kl6XvCyZ1uk67V7M2MFDLc2YqeQp7kcLJpk
         DT8hX3Ay2VGMulaqoLzepfnqhuHAdeuDV3QxGBZphSqQ6eHmY6qTJinDRgLyxlVuPjq7
         qHfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709247099; x=1709851899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3L9ixUueiI05jpi7f65YJ28x09hBlNI3L5Dn4dXdhtw=;
        b=VTB0vI/WniSkuUbqmTu6x3UvyzQI7JjRWM3i/1bnIRdlWR1FLdo4/9mQZ59o+af5bT
         n/+Qb3iX0fFfBaJVdjH8KkLIKN+9Z6TTNJ48A2A7OY1P56mbCXyc6TvW2StycJYJf8Gw
         hKv0H5l/v9satJvekSelFBGCNEyOR0FsgtNTl6bCeGCiHV7jRruyGqQ0k1PbUwAblhUj
         5Fc59LmpHNnUOe5Fku7ydkrQ4mTumrUQKtTy2PHgtba33nLNZZ4ZHl2amptZIXpvFVwZ
         d2mbVCvgU2o9QZsL541o+oi/jKhbjGBnlb93kVfddecCXJEXb1edSGhgecQNeWomTz2H
         tyyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaI1TJT9Vv68cT3XpD/m2qttwP6lIHjfgR83jLx7a1g8Xjvhc65C3ExZ+tBJ5giKJ1ddTOzcmFLzCxtrr64XYgCXJB0gZqsQCuToqN8zWOZ0Oj4+MCcPW1+949t3AX3o/KAy7ntCzxyqm4Ww==
X-Gm-Message-State: AOJu0YxQIqJciZgh6pdWl6MLARXK9Z92ejKj03BlnWt4zqjMoZW4g3uN
	fYSsecpjQeqTLIEXSni30b/C2+IU1qDVTnnYiQXTBI7B/341emr+
X-Google-Smtp-Source: AGHT+IGuz0LwrlRo/C7GfS+teQBq2Sq2iggdwk8ap0kAYWevKtiR09uv8paoPiASXzl3JLqzfZYY6A==
X-Received: by 2002:a5d:498c:0:b0:33d:e2d9:8401 with SMTP id r12-20020a5d498c000000b0033de2d98401mr239007wrq.51.1709247099315;
        Thu, 29 Feb 2024 14:51:39 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id q13-20020adfcb8d000000b0033ce06c303csm2861408wrh.40.2024.02.29.14.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 14:51:38 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Hans de Goede <hdegoede@redhat.com>,
	linux-fsdevel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] vboxsf: remove redundant variable out_len
Date: Thu, 29 Feb 2024 22:51:38 +0000
Message-Id: <20240229225138.351909-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable out_len is being used to accumulate the number of
bytes but it is not being used for any other purpose. The variable
is redundant and can be removed.

Cleans up clang scan build warning:
fs/vboxsf/utils.c:443:9: warning: variable 'out_len' set but not
used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/vboxsf/utils.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/vboxsf/utils.c b/fs/vboxsf/utils.c
index 72ac9320e6a3..9515bbf0b54c 100644
--- a/fs/vboxsf/utils.c
+++ b/fs/vboxsf/utils.c
@@ -440,7 +440,6 @@ int vboxsf_nlscpy(struct vboxsf_sbi *sbi, char *name, size_t name_bound_len,
 {
 	const char *in;
 	char *out;
-	size_t out_len;
 	size_t out_bound_len;
 	size_t in_bound_len;
 
@@ -448,7 +447,6 @@ int vboxsf_nlscpy(struct vboxsf_sbi *sbi, char *name, size_t name_bound_len,
 	in_bound_len = utf8_len;
 
 	out = name;
-	out_len = 0;
 	/* Reserve space for terminating 0 */
 	out_bound_len = name_bound_len - 1;
 
@@ -469,7 +467,6 @@ int vboxsf_nlscpy(struct vboxsf_sbi *sbi, char *name, size_t name_bound_len,
 
 		out += nb;
 		out_bound_len -= nb;
-		out_len += nb;
 	}
 
 	*out = 0;
-- 
2.39.2


