Return-Path: <linux-fsdevel+bounces-20392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 910898D2A3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 04:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9101F29ACC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 02:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504FE15B546;
	Wed, 29 May 2024 01:59:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620A715AAD6;
	Wed, 29 May 2024 01:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716947964; cv=none; b=F0MNZ4PRO92o+ZN+DrrKbACemwjTZmMkjpw/7A6gTddD1FYdf9XbwTW9HHKoOyh9qHtB6n3CsveIstIB0X1fSOBTI1TbCqVv0BHxjmWrvyKCkx0ZmDmKLxWOvt+k2FQih1KwZfc9u8K147hkZkZmGNDMTRZZdtjQXA5jh+83kyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716947964; c=relaxed/simple;
	bh=HtCW9rLiVuhATKftb06fEORs43V2f6ALkTUlDurVlv4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=omRs0IZ6FF5t/3QnGePgGFTH9wYWgs36sd3zDNiuIvzsOZCeuvmqQUptH1n+ksZ25ZPevaCyxeFVyuX9ZiKUkIC/0y62rqOau+0iwXqQCM3GHiXkPHqjJkAqpN4GHIfZeqAXA4WLH9Rb3Tm3sziFjp30G04bQkLK/krY9zwkstU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Vpsxm4z7Yz4f3jHW;
	Wed, 29 May 2024 09:59:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 01E151A0572;
	Wed, 29 May 2024 09:59:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g7wi1Zmr3XbNw--.12147S6;
	Wed, 29 May 2024 09:59:17 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	brauner@kernel.org,
	david@fromorbit.com,
	chandanbabu@kernel.org,
	jack@suse.cz,
	willy@infradead.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [RFC PATCH v4 2/8] math64: add rem_u64() to just return the remainder
Date: Wed, 29 May 2024 17:52:00 +0800
Message-Id: <20240529095206.2568162-3-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
References: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn9g7wi1Zmr3XbNw--.12147S6
X-Coremail-Antispam: 1UD129KBjvJXoWxJrWfWF4ftF4kCr4fCFWrGrg_yoW8Ww47pF
	sxCr98GFW8GFy3Ja1IyF1jyr1YvFn7Gr47XFWagrW8u343tw409r4fJF4xtF48Jws3Aw45
	GFy7GrW5WryavF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
	0E87I2jVAFwI0_Jryl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2
	F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjx
	v20xvEc7CjxVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E
	87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
	kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm
	72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYx
	C7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7sRiXo2UUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Add a new helper rem_u64() to only get the remainder of unsigned 64bit
divide with 32bit divisor.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 include/linux/math64.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/math64.h b/include/linux/math64.h
index d34def7f9a8c..618df4862091 100644
--- a/include/linux/math64.h
+++ b/include/linux/math64.h
@@ -3,6 +3,7 @@
 #define _LINUX_MATH64_H
 
 #include <linux/types.h>
+#include <linux/log2.h>
 #include <linux/math.h>
 #include <asm/div64.h>
 #include <vdso/math64.h>
@@ -12,6 +13,20 @@
 #define div64_long(x, y) div64_s64((x), (y))
 #define div64_ul(x, y)   div64_u64((x), (y))
 
+/**
+ * rem_u64 - remainder of unsigned 64bit divide with 32bit divisor
+ * @dividend: unsigned 64bit dividend
+ * @divisor: unsigned 32bit divisor
+ *
+ * Return: dividend % divisor
+ */
+static inline u32 rem_u64(u64 dividend, u32 divisor)
+{
+	if (is_power_of_2(divisor))
+		return dividend & (divisor - 1);
+	return dividend % divisor;
+}
+
 /**
  * div_u64_rem - unsigned 64bit divide with 32bit divisor with remainder
  * @dividend: unsigned 64bit dividend
@@ -86,6 +101,15 @@ static inline s64 div64_s64(s64 dividend, s64 divisor)
 #define div64_long(x, y) div_s64((x), (y))
 #define div64_ul(x, y)   div_u64((x), (y))
 
+#ifndef rem_u64
+static inline u32 rem_u64(u64 dividend, u32 divisor)
+{
+	if (is_power_of_2(divisor))
+		return dividend & (divisor - 1);
+	return do_div(dividend, divisor);
+}
+#endif
+
 #ifndef div_u64_rem
 static inline u64 div_u64_rem(u64 dividend, u32 divisor, u32 *remainder)
 {
-- 
2.39.2


