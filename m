Return-Path: <linux-fsdevel+bounces-49653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1381AC01BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 03:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51C334A82D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 01:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775273770B;
	Thu, 22 May 2025 01:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOSyP7Rw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B5628F1;
	Thu, 22 May 2025 01:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747877537; cv=none; b=gy6TTFug5bdXTNOqAmSkl1sIrnCvIDcBBYodwCLi8xROZq5xD/Ezx+qTvjkwIR2961o/1Iza7joB8ZHLgIa+Tn3kkFYS3kpvTVe8ZQYcF/h23tHUWi1FG247P3OPZPp4EM1WoxJdQBvxQo+mvE2QMHLYSEW2yEkXK8CQMVYinj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747877537; c=relaxed/simple;
	bh=06UIssbwd5l8JLbK276k1DZEw8irYqO/MphdE/JEBSk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YLUV4cIlSAkrzXy00n6b63gfBi+62W+egQmF28gfi0PpxXTl9pnVTQTsSYTux3afSLvVvvHOzO67RAbFOCFsM11W3gqSxWaMDIiTdhLKp/l586FD4A4NbSWMwrBTi5a2tnPx3kxrbMEIgsbEe2uEFrzqJFiif0U7JXX/s2JoQpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOSyP7Rw; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-74264d1832eso9289291b3a.0;
        Wed, 21 May 2025 18:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747877535; x=1748482335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Xpj5IjZEKOCpR3msXBMmi/TzXWSFtxZDAfgAFNSR0I8=;
        b=IOSyP7RwYXIdgNVbr0HP1AXCycpiMtCPz26YJTToT7OU/of9vpbuCYoBIIQO3hvxUP
         dZ19x7OdBsQcPwpwsx9WiWH3/d3Ktog3R6Co7PegX7xtho5uCOILS/wZAeATDawgPkL4
         s+Nrs6hXe4iDi6naR+H+uJjHa9/kTVOajQG71TsXFkItjoTKUNlp/XheCQBQo8sSYNmi
         uNRRHu8XWIVB+DjLWLoHhFEYJkMLs+S1/gqCPUZUtymuN4iehOMEu9jofYzWqyrP2dkr
         /8nCiK3QNp56E3vwicpSIi0PQEGzHt62uZy4VJ2VQFss1xCkD7oxpaMQF7f/NuLh6iF9
         4+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747877535; x=1748482335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xpj5IjZEKOCpR3msXBMmi/TzXWSFtxZDAfgAFNSR0I8=;
        b=UDLnLL0lndMdUwLRCvqxO3uLLwuGl5zM/2bW4sJy3/iQQcdjqs2IBnXYmLd+pZq6R3
         GEfvwMOEkkCpT9aIgn6/vamzjO+YmRC7UP6/QbMIUBvgWNveM1q8W1GA9aN2raFngA+3
         CU8qh0jyE+SkPX4wshQxHP1xqEQgTVNL50aXM5TFLwn0DGfxJs+6MOZJBpNG93lsoXbo
         rWI4zLOAoX97Ix91zsYgXa6r8LzlsYAKgrX9749D1NPOq4jZwRj2tCOFT9G2rEROKvhR
         IW2toFXtz4hzrObwKWkgVqODfSrdTW3xPIZ19WEkKHY7lba4mUfMjf21KqlBmo7CXnUN
         959Q==
X-Forwarded-Encrypted: i=1; AJvYcCVsG7o9gQKQR7H3QAU/oS/lxsqQKhRHNXvpWhTgWQmgefZ+hw9tfi6G/vD9GH43qd20dUjy9LK81jOrojPW@vger.kernel.org, AJvYcCXP19Nnjx0SoFyAlfyK7s4Vf/VxRxFCkckhjNYFCxaTRSq8iG88gRK41vM/CO8DzuEV06B2oCq251mjnr4p@vger.kernel.org
X-Gm-Message-State: AOJu0YxOWJo+WtVsZOEyT4hrkDms3wT9bfbA2zzyPNCJofn75kp5sITn
	ECkplN/o2ftMMw0hhyuqHfBIsYaE4aBk3tEVeKUt6Uvy+iFWpGfj+J4q
X-Gm-Gg: ASbGncua1uBf2SX2TJa6h7ey8Uh2obEceZl/+ix/s4EHyjYrGgwcUHWS4Yk4WrK6qaP
	iMMYEepmxVUyrNCD3bBhdLoEaRTujgnB7jGkeHsz07cJlHGOfZr3FKwpsSh6THfOJCuFQz5VPte
	2LvzIlTphYdADdkGA2jyWe3+gM4C7pVZU2Hbmj/tohuREltIDb6uwxFWrzXN7HzIMaSjilXkuQq
	0+ku+m+lhWe54YIioXBdQhcsVvkq/TGeMOpPACBv+KPcu40ZNAA6zBW37HFTchO2C+BKdF4im6t
	gT+BATHiLPNVUMaW0+srzQW5s/KjqO0RNiTRmpYpWxar/FAR381+w2ByweThmR5S
X-Google-Smtp-Source: AGHT+IHGS2Zt3wvNdwAbmUPl/HP1o7k28Kdq9juV5heyDiKMffrrayGbfLd/xCYYx8D9x27bI9NmcQ==
X-Received: by 2002:a05:6a00:3d0c:b0:742:da7c:3f30 with SMTP id d2e1a72fcca58-742da7c3fdamr15827863b3a.19.1747877533862;
        Wed, 21 May 2025 18:32:13 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9709534sm10115288b3a.41.2025.05.21.18.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 18:32:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Kees Cook <kees@kernel.org>
Cc: Joel Granados <joel.granados@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH] kernel/sysctl-test: Unregister sysctl table after test completion
Date: Wed, 21 May 2025 18:32:11 -0700
Message-ID: <20250522013211.3341273-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One of the sysctl tests registers a valid sysctl table. This operation
is expected to succeed. However, it does not unregister the table after
executing the test. If the code is built as module and the module is
unloaded after the test, the next operation trying to access the table
(such as 'sysctl -a') will trigger a crash.

Unregister the registered table after test completiion to solve the
problem.

Fixes: b5ffbd139688 ("sysctl: move the extra1/2 boundary check of u8 to sysctl_check_table_array")
Cc: Wen Yang <wen.yang@linux.dev>
Cc: Joel Granados <joel.granados@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 kernel/sysctl-test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
index eb2842bd0557..ac84f64dbdeb 100644
--- a/kernel/sysctl-test.c
+++ b/kernel/sysctl-test.c
@@ -374,6 +374,7 @@ static void sysctl_test_register_sysctl_sz_invalid_extra_value(
 		struct kunit *test)
 {
 	unsigned char data = 0;
+	struct ctl_table_header *header;
 	const struct ctl_table table_foo[] = {
 		{
 			.procname	= "foo",
@@ -412,7 +413,9 @@ static void sysctl_test_register_sysctl_sz_invalid_extra_value(
 
 	KUNIT_EXPECT_NULL(test, register_sysctl("foo", table_foo));
 	KUNIT_EXPECT_NULL(test, register_sysctl("foo", table_bar));
-	KUNIT_EXPECT_NOT_NULL(test, register_sysctl("foo", table_qux));
+	header = register_sysctl("foo", table_qux);
+	KUNIT_EXPECT_NOT_NULL(test, header);
+	unregister_sysctl_table(header);
 }
 
 static struct kunit_case sysctl_test_cases[] = {
-- 
2.45.2


