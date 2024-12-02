Return-Path: <linux-fsdevel+bounces-36225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 804179DFBAA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 09:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08D8EB213BC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 08:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097931F9ABC;
	Mon,  2 Dec 2024 08:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMIkt7BF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227301F8AEA;
	Mon,  2 Dec 2024 08:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733127125; cv=none; b=sgPnJog+tNPbkSC4UdljfDsH21LI2bIrkZAj7nIhX2Cdz6vj+h6xveuTHfJOOpNXXsvORLDut2l19+3r9MgKbPTnpob3CxkbFl9Cu4BYp1X2LQGp+9ULOk6NcOc6EOv55hnaAlZkjmJZG1Uul9Cm/NKC2KMr9RRnQUN7AKy/azo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733127125; c=relaxed/simple;
	bh=VSUjNizr/1GTzlmCcQz8331y/PCGwzGRf2PuxJ6n7DA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L/s+AmmhtiJUK8zf/woM5/wda1EJiqs/ws0o4PeEOVHw87llghbBjFckRm0e8aLWsrQ7dKpXTOndwEElA7jhKahTN7kHXgUZkyOdplAUxVbmeuaqLVoV14T5Zvz4AzGlj5diBzA6Yj4miRWfySoRA3rSwomQKzDXZ6zb/4CW9Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMIkt7BF; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2156e078563so9256205ad.2;
        Mon, 02 Dec 2024 00:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733127123; x=1733731923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rgCxp/kcDTssayp9qUntP//DVF1RVvwjAC+aQl3a/8c=;
        b=BMIkt7BF9MA9zAJWPu2YYufYI1H5OeEug+Va8zHvtyn9PexVUjlHC4DV6DCbT2sMYC
         P9j6OKeCzzg/eI75ibooJL87AO9cLPZdGKL976O6gQOIhEMxgKkQx7oaqq9ubg0lDsby
         YpnmZAMKTCUrSgarCaeRDe3yR3NghRmW4uEqgis2KvKYP8heWjr/kHq4o3rWqNDdjTTA
         /HJ+/y2t8qSvTPGcYzpUX5YpYEJM/+pSm2SA3xYjXhw8uXHdO/FkNAsAsHt/PWrOFJqN
         gYbpCIGemh6FXp0Z5Wjo3j9a40I/6Z0ZmhZADXfW+i89MixVghajyH9VeGHPBSHl8o41
         +dVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733127123; x=1733731923;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rgCxp/kcDTssayp9qUntP//DVF1RVvwjAC+aQl3a/8c=;
        b=DgvH//xwV5Wht/skHO8UERjqInfzBdtz5qbrmIkYezPU4awtVoJNHEfN0wwYl9Fb4I
         05x/zxcK90Inb0CLY3iXLNLKNCY5AWncjdBvpK6ooTO+WYumiUNvgVneWeSZ9NFMMj32
         JpKvxuvF6Zr389G1l3bK/fSQU3J67EWFpJDUmG27aZkZ5q26PFyn0KPMnWPXkyQ8RLC1
         DK69Yei0zKtHpcl+0ACscV6wBrTW/Z+NjQdANIEtIUDlOHxjsSdwdzquiPFrF2ZhiDzC
         67HRvY/KRpwIvTvIch6tmh1mGwo6yZbBCnXbrTuKfJ1ALhprkKzbKdhzbyo8sbBP4OOx
         TLBw==
X-Forwarded-Encrypted: i=1; AJvYcCV61XswLtp3ra+NKodpFaBRbCGdxxl/uD/ksliqFVJDnhSamhnMU9msMT3QPKPtJoG+v3sjtAmTTM/tvYBL@vger.kernel.org, AJvYcCVN/BJ85EdS+RW4jUMBsFLSONva5lCpM1W1S3RxaCvtiufomIGcMnZrPo6xbmpdYu4RhrLdhsEeiFIcC4tB@vger.kernel.org
X-Gm-Message-State: AOJu0YwLS1JhYuK5l8LaOoVkKbmML/pSQtw3ddgM3wELIQYfUp9qbHBr
	uO6btmncw4yvz7evVzyk6eCW+Ng69utPy3GTPfkQiwhTdqjEsJtN
X-Gm-Gg: ASbGnct8e+91sJvE5baGL+e7ioxvTzflxDC8ALQM4mevcbssK19V2I411M16XGGzte4
	ekO1k1F/KxNP6Vw1VcRQy1NV46blSGje8ASjTnyZMBW2dHmFwXdutbQ3TqiuEfcdib9eWTtcSYO
	pBHDUUFOV8+ChUYkDvLiFsGqeOsTCkvcmy2cRlrd0/A54tsxpEqm4i7gVHjdEbeYRrEaQvM/0Dd
	t2iXS2CU9XvdRCZ5Z+Kp/N7TyQEnMlmlu3w1Vv/KbOzUKbSINmgdXYAz7eeRd9SYexZaK0YGQ==
X-Google-Smtp-Source: AGHT+IEuUbONqs8zxBj3T/WQhEm8JRiFYXFVrrZ0qaCD6pVq7HPF7oqFAtRt4C8+IUp4BKeTLb/CsA==
X-Received: by 2002:a17:903:2344:b0:215:711d:d59 with SMTP id d9443c01a7336-215711d0fa0mr97535105ad.2.1733127123344;
        Mon, 02 Dec 2024 00:12:03 -0800 (PST)
Received: from localhost.localdomain ([36.110.106.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2153d61aabfsm55517385ad.136.2024.12.02.00.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 00:12:03 -0800 (PST)
From: Guo Weikang <guoweikang.kernel@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Guo Weikang <guoweikang.kernel@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fs:fc_log replace magic number 7 with ARRAY_SIZE()
Date: Mon,  2 Dec 2024 16:11:45 +0800
Message-Id: <20241202081146.1031780-1-guoweikang.kernel@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the hardcoded value `7` in `put_fc_log()` with `ARRAY_SIZE`.
This improves maintainability by ensuring the loop adapts to changes
in the buffer size.

Signed-off-by: Guo Weikang <guoweikang.kernel@gmail.com>
---
 fs/fs_context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 98589aae5208..582d33e81117 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -493,7 +493,7 @@ static void put_fc_log(struct fs_context *fc)
 	if (log) {
 		if (refcount_dec_and_test(&log->usage)) {
 			fc->log.log = NULL;
-			for (i = 0; i <= 7; i++)
+			for (i = 0; i < ARRAY_SIZE(log->buffer) ; i++)
 				if (log->need_free & (1 << i))
 					kfree(log->buffer[i]);
 			kfree(log);
-- 
2.25.1


