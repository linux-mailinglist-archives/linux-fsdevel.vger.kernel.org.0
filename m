Return-Path: <linux-fsdevel+bounces-79657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILNQHRgzq2n2agEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 21:03:36 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2092275DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 21:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB7C7304877E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2026 20:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BF03043CF;
	Fri,  6 Mar 2026 20:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCw/r+8F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813FD309F00
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Mar 2026 20:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772827402; cv=none; b=UKZEyINDOvBa7xnjDIgj4wQltWHUlxqmRCwctYc7DrYMW68zTwuizy8qU69KlrwP6qYcoTSzYJt9xV/PLN18H/yO2UOX4dvxGXnr516y9xFgUsz8qUrFGjKs/9SpvQXCiOgNQj0CtkZcTb8gAmRnW/riIlV8UaLLM7LuV6Ee1WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772827402; c=relaxed/simple;
	bh=Y8ppU4G8/OQzMZ6eTsJIxOyR5s1YD7sfl68n5ceeh68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ip3OvH1xnsrvBixelLOxrcTyJsM+VqQZRs8VHXkXW7OHwPcbMAYAM0tkCp6W+K3546JN7GipsIFuYY46oWVc/CSzVP0BRd5QrlKwHaw1x500q8PwgdCqFUPSdpsklS1ilnoamJ8ZhUnVMTt6nT3L09wZSE19SKn6Fb39f1WAkbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCw/r+8F; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-899f8c33c11so56841246d6.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Mar 2026 12:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772827400; x=1773432200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HPRNLOamDcFlQvC9N/qMCQZ3FcaEUEmoKUrW4q9GB28=;
        b=JCw/r+8FecHGj/m0KRCdXM/pPyOKQUVT701df1RIVOSstf4fNe3kMFjRQ4l+PHDuJW
         5+Fz+lMRX7RwV22YIwtZA17W+/mlSrsvkoadQ2f6LrXCWUcQoDOWUlwUbLcj86t4gyoO
         w4j34ZaRsYGZzM7PKIspVI07flUySxlMj/a4L4KlRZj8ak9Mh+lwO/EcaKOflgF9DZvv
         3aJJ+c1Nb1KR2DkkV6t+EjrKmPEuv2j9J5Cz9WapFWz/vy1YKmAevHfHU1BjaWmTZZyR
         qVWmb8MJsay8L6GON8RVTFjPsDZmD/Ank47KhnJJue4nrX/K0Nzrb42ni+G31QsYUuOn
         Ra3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772827400; x=1773432200;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPRNLOamDcFlQvC9N/qMCQZ3FcaEUEmoKUrW4q9GB28=;
        b=L2nrCX6NXas6u8zb+w3vZprtezNT3AAEaD1XCjVxQiEup1+k15ObbxTpu2TrVWwZGE
         izuEMsNGCcQcOuw99eUyjlB9r3nx61j89BoCWWI4VmCwvIcz1y/s+NyixYA2kxutX0A0
         dj8UjItgIWFs8Nw5q0PKe8L3RmCbQWJNJqvrVJcsS4a6wRwFTt+FI7Pq0EUZhSCB/nyg
         FvsdyQWMfEjw+aSxM/K19lsNLC3mFGKl4vg4+tI7iRgTZXofk783ILtFuLUi96uDbyNt
         hN89u6tHEdvtnaHt0DwkK3wZysfSWsiSDFBqYTGqP2G/t28id/KgxEDUgL//BofS5B0Y
         J72g==
X-Forwarded-Encrypted: i=1; AJvYcCU1LfYIatw1OJ8SlKs2BWQlWd7OanlcHE+UMVL5YRAY3AXpp+fGEUlkbqZvCyMv59cAoUa4hxbGJabkgTTS@vger.kernel.org
X-Gm-Message-State: AOJu0YwLbpERN1+hQs0dLstXyJ/vItJTs6g/s4eyCO6hOP7p4Kf3XBdu
	Rmh7QsbHgYX7DM1yZEtjJXMnCKpo8HLPVJ6MCqNn3cu0GkeGiUpoY/mn
X-Gm-Gg: ATEYQzwDs79Q5OIW20lbduRORolzi4N5VH8qROHg3V7L30CwB4HSWFF4RlN2ALZV1Qs
	5CVxtnLZ5c/59XBXv6Utgvj/BV6SJbi7UqpXDKqZz9NY8a1VaUKsqjOdLEL8wmbSoHfV15Gqb6e
	eVVsXiJ/CqotzTFLUSepGeJrDJ7DY86MvGXYcMKlHCTBEE0sh2qugXZ9ryZuWXcxaEJqGNFrC37
	DFrDc/YGmgmkWRZTxW3DzDU9dJHNUeX0Ow/kEuWFXmZxVEf817wMbZ3sTye9seA6mlHFOY0GAxU
	9l2VnghwhpS4kWxIdeqx7ljQM4HY0RWOdmwiR3GGLng8BXJaxsI/+V+vWElr77N0UtCA7WOwbx8
	TyPTm7TzQTvHFBdvRuGGNEnltcUSBHj8pAoyezfty9n1AFYKY3wY92NzrSrbDKfFV2wICVG056E
	q0t1qTbsKTyt2tCtnf1pGl/s73WRupg6bsUjNSqDVG58o+m7c+/b2+pi3xCq9XuVLoDy3jqQ5VC
	MmG
X-Received: by 2002:a05:6214:e42:b0:899:f820:6414 with SMTP id 6a1803df08f44-89a30af509fmr43309316d6.48.1772827400370;
        Fri, 06 Mar 2026 12:03:20 -0800 (PST)
Received: from instance-20260207-1316.vcn12250046.oraclevcn.com ([150.136.248.187])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a3140da14sm23301266d6.9.2026.03.06.12.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 12:03:19 -0800 (PST)
From: Josh Law <hlcj1234567@gmail.com>
X-Google-Original-From: Josh Law <objecting@objecting.org>
To: willy@infradead.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH] lib/idr: fix ida_find_first_range() missing IDs across chunk boundaries
Date: Fri,  6 Mar 2026 20:03:19 +0000
Message-ID: <20260306200319.2819286-1-objecting@objecting.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0C2092275DB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-79657-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hlcj1234567@gmail.com,linux-fsdevel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.966];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,objecting.org:mid,objecting.org:email]
X-Rspamd-Action: no action

From: Josh Law <objecting@objecting.org>

ida_find_first_range() only examines the first XArray entry returned by
xa_find(). If that entry does not contain a set bit at or above the
requested offset, the function returns -ENOENT without searching
subsequent entries, even though later chunks may contain allocated IDs
within the requested range.

For example, a DRM driver using IDA to manage connector IDs may allocate
IDs across multiple 1024-bit IDA chunks. If early IDs are freed and the
driver calls ida_find_first_range() with a min that falls into a
sparsely populated first chunk, valid IDs in higher chunks are silently
missed. This can cause the driver to incorrectly conclude no connectors
exist in the queried range, leading to stale connector state or failed
hotplug detection.

Fix this by looping over xa_find()/xa_find_after() to continue searching
subsequent entries when the current one has no matching bit.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/idr.c | 55 ++++++++++++++++++++++++-------------------------------
 1 file changed, 24 insertions(+), 31 deletions(-)

diff --git a/lib/idr.c b/lib/idr.c
index 69bee5369670..1649f41016e7 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -495,10 +495,9 @@ int ida_find_first_range(struct ida *ida, unsigned int min, unsigned int max)
 	unsigned long index = min / IDA_BITMAP_BITS;
 	unsigned int offset = min % IDA_BITMAP_BITS;
 	unsigned long *addr, size, bit;
-	unsigned long tmp = 0;
+	unsigned long tmp;
 	unsigned long flags;
 	void *entry;
-	int ret;
 
 	if ((int)min < 0)
 		return -EINVAL;
@@ -508,40 +507,34 @@ int ida_find_first_range(struct ida *ida, unsigned int min, unsigned int max)
 	xa_lock_irqsave(&ida->xa, flags);
 
 	entry = xa_find(&ida->xa, &index, max / IDA_BITMAP_BITS, XA_PRESENT);
-	if (!entry) {
-		ret = -ENOENT;
-		goto err_unlock;
-	}
-
-	if (index > min / IDA_BITMAP_BITS)
-		offset = 0;
-	if (index * IDA_BITMAP_BITS + offset > max) {
-		ret = -ENOENT;
-		goto err_unlock;
-	}
-
-	if (xa_is_value(entry)) {
-		tmp = xa_to_value(entry);
-		addr = &tmp;
-		size = BITS_PER_XA_VALUE;
-	} else {
-		addr = ((struct ida_bitmap *)entry)->bitmap;
-		size = IDA_BITMAP_BITS;
-	}
-
-	bit = find_next_bit(addr, size, offset);
+	while (entry) {
+		if (index > min / IDA_BITMAP_BITS)
+			offset = 0;
+		if (index * IDA_BITMAP_BITS + offset > max)
+			break;
 
-	xa_unlock_irqrestore(&ida->xa, flags);
+		if (xa_is_value(entry)) {
+			tmp = xa_to_value(entry);
+			addr = &tmp;
+			size = BITS_PER_XA_VALUE;
+		} else {
+			addr = ((struct ida_bitmap *)entry)->bitmap;
+			size = IDA_BITMAP_BITS;
+		}
 
-	if (bit == size ||
-	    index * IDA_BITMAP_BITS + bit > max)
-		return -ENOENT;
+		bit = find_next_bit(addr, size, offset);
+		if (bit < size &&
+		    index * IDA_BITMAP_BITS + bit <= max) {
+			xa_unlock_irqrestore(&ida->xa, flags);
+			return index * IDA_BITMAP_BITS + bit;
+		}
 
-	return index * IDA_BITMAP_BITS + bit;
+		entry = xa_find_after(&ida->xa, &index,
+				      max / IDA_BITMAP_BITS, XA_PRESENT);
+	}
 
-err_unlock:
 	xa_unlock_irqrestore(&ida->xa, flags);
-	return ret;
+	return -ENOENT;
 }
 EXPORT_SYMBOL(ida_find_first_range);
 
-- 
2.43.0


