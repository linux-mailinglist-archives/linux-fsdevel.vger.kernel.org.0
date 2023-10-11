Return-Path: <linux-fsdevel+bounces-77-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A273A7C57AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 17:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 817C928247B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 15:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7C32033B;
	Wed, 11 Oct 2023 15:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pTZ1lgAJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+FxpQiz8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9443F1F5E1
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 15:02:57 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA081A4
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 08:02:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 41E8A1FE48;
	Wed, 11 Oct 2023 15:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1697036573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yTF/NvbaX3ADAmP5xAWDHmisXQSvNcLD+llcuRroTfQ=;
	b=pTZ1lgAJqdqVzja+OfowqIbAfdjZNfOPo5XX8s51wrp4mZgq4BMLD34SxXdts2WLkAC9qG
	jnW0qX0sYTT/FlyTRO471kk7Ah90MPqCW9NDSoWU9COZNkdwlQYFBT6xUsrWdIHeY2vQqi
	QN2Z3wJGJV9BDta6ey4EoPrJvjol1Dw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1697036573;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yTF/NvbaX3ADAmP5xAWDHmisXQSvNcLD+llcuRroTfQ=;
	b=+FxpQiz8zkr5ulnNXDBrI3JNox2nNkJaNL3UhsYRY9ph76i+791W8+SKWnOYdvKBu7LCM7
	9cps1NB6XOEbyPCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2FE4013A87;
	Wed, 11 Oct 2023 15:02:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id AnseCx25JmVVfwAAMHmgww
	(envelope-from <jack@suse.cz>); Wed, 11 Oct 2023 15:02:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 91F96A05C4; Wed, 11 Oct 2023 17:02:52 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Yury Norov <yury.norov@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Matthew Wilcox <willy@infradead.org>,
	<linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] lib/find: Make functions safe on changing bitmaps
Date: Wed, 11 Oct 2023 17:02:31 +0200
Message-Id: <20231011150252.32737-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231011144320.29201-1-jack@suse.cz>
References: <20231011144320.29201-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13113; i=jack@suse.cz; h=from:subject; bh=3Kz4P7tvkvENCvzDxIeFbUtZWZ0Yvwg7rAWE5J8lTkY=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlJrkGWRKZUXqIgcfoGppBHH1MFo8YSsvAZI4781gh l7b7j+WJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZSa5BgAKCRCcnaoHP2RA2Yv/CA DmII1zr2ynZWbfKwRqjKWruPeQULJmEjAME8R3dTKxsIEaLTOWtTotQXep8hNXVoPZQ00MnecPbZ/k JqT3zeGhKD8dmIdI+f+JrK8v7pHJ1XLT9XnIIc9kKlEg6YdtzAkK2C+y9cGMdgR456ufZb3O8bXTTY ZtRSQQOJ2jXbtaXWx2s2Cs48Em/JNAbyZ31SjpdsE1Z8Qe4llmvzS43VwvNzitvvqSzArM3UmgaSci KqtJOciAF5Hm/QKhvIR5eNzKd8lToEZ1C/LYytR+dE7RdwNhLD6eR+TNFzuqXjCEg8kt723zhqqjpu xZDu21XW381c77fB7jFRsN/Ev1H8lu
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>

Some users of lib/find functions can operate on bitmaps that change
while we are looking at the bitmap. For example xarray code looks at tag
bitmaps only with RCU protection. The xarray users are prepared to
handle a situation were tag modification races with reading of a tag
bitmap (and thus we get back a stale information) but the find_*bit()
functions should return based on bitmap contents at *some* point in time.
As UBSAN properly warns, the code like:

	val = *addr;
	if (val)
		__ffs(val)

prone to refetching 'val' contents from addr by the compiler and thus
passing 0 to __ffs() which has undefined results.

Fix the problem by using READ_ONCE() in all the appropriate places so
that the compiler cannot accidentally refetch the contents of addr
between the test and __ffs(). This makes the undefined behavior
impossible. The generated code is somewhat larger due to gcc tracking
both the index and target fetch address in separate registers (according
to GCC folks the volatile cast confuses their optimizer a bit, they are
looking into a fix). The difference in performance is minimal though.
Targetted microbenchmark (in userspace) of the bit searching loop shows
about 2% regression on some x86 microarchitectures so for normal kernel
workloads this should be in the noise and not worth introducing special
set of bitmap searching functions.

[JK: Wrote commit message]

CC: Yury Norov <yury.norov@gmail.com>
Link: https://lore.kernel.org/all/20230918044739.29782-1-mirsad.todorovac@alu.unizg.hr/
Signed-off-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/linux/find.h | 40 ++++++++++++++++++++++++----------------
 lib/find_bit.c       | 39 +++++++++++++++++++++++----------------
 2 files changed, 47 insertions(+), 32 deletions(-)

diff --git a/include/linux/find.h b/include/linux/find.h
index 5e4f39ef2e72..5ef6466dc7cc 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -60,7 +60,7 @@ unsigned long find_next_bit(const unsigned long *addr, unsigned long size,
 		if (unlikely(offset >= size))
 			return size;
 
-		val = *addr & GENMASK(size - 1, offset);
+		val = READ_ONCE(*addr) & GENMASK(size - 1, offset);
 		return val ? __ffs(val) : size;
 	}
 
@@ -90,7 +90,8 @@ unsigned long find_next_and_bit(const unsigned long *addr1,
 		if (unlikely(offset >= size))
 			return size;
 
-		val = *addr1 & *addr2 & GENMASK(size - 1, offset);
+		val = READ_ONCE(*addr1) & READ_ONCE(*addr2) &
+						GENMASK(size - 1, offset);
 		return val ? __ffs(val) : size;
 	}
 
@@ -121,7 +122,8 @@ unsigned long find_next_andnot_bit(const unsigned long *addr1,
 		if (unlikely(offset >= size))
 			return size;
 
-		val = *addr1 & ~*addr2 & GENMASK(size - 1, offset);
+		val = READ_ONCE(*addr1) & ~READ_ONCE(*addr2) &
+						GENMASK(size - 1, offset);
 		return val ? __ffs(val) : size;
 	}
 
@@ -151,7 +153,8 @@ unsigned long find_next_or_bit(const unsigned long *addr1,
 		if (unlikely(offset >= size))
 			return size;
 
-		val = (*addr1 | *addr2) & GENMASK(size - 1, offset);
+		val = (READ_ONCE(*addr1) | READ_ONCE(*addr2)) &
+						GENMASK(size - 1, offset);
 		return val ? __ffs(val) : size;
 	}
 
@@ -179,7 +182,7 @@ unsigned long find_next_zero_bit(const unsigned long *addr, unsigned long size,
 		if (unlikely(offset >= size))
 			return size;
 
-		val = *addr | ~GENMASK(size - 1, offset);
+		val = READ_ONCE(*addr) | ~GENMASK(size - 1, offset);
 		return val == ~0UL ? size : ffz(val);
 	}
 
@@ -200,7 +203,7 @@ static inline
 unsigned long find_first_bit(const unsigned long *addr, unsigned long size)
 {
 	if (small_const_nbits(size)) {
-		unsigned long val = *addr & GENMASK(size - 1, 0);
+		unsigned long val = READ_ONCE(*addr) & GENMASK(size - 1, 0);
 
 		return val ? __ffs(val) : size;
 	}
@@ -229,7 +232,7 @@ unsigned long find_nth_bit(const unsigned long *addr, unsigned long size, unsign
 		return size;
 
 	if (small_const_nbits(size)) {
-		unsigned long val =  *addr & GENMASK(size - 1, 0);
+		unsigned long val = READ_ONCE(*addr) & GENMASK(size - 1, 0);
 
 		return val ? fns(val, n) : size;
 	}
@@ -255,7 +258,8 @@ unsigned long find_nth_and_bit(const unsigned long *addr1, const unsigned long *
 		return size;
 
 	if (small_const_nbits(size)) {
-		unsigned long val =  *addr1 & *addr2 & GENMASK(size - 1, 0);
+		unsigned long val = READ_ONCE(*addr1) & READ_ONCE(*addr2)
+							& GENMASK(size - 1, 0);
 
 		return val ? fns(val, n) : size;
 	}
@@ -282,7 +286,8 @@ unsigned long find_nth_andnot_bit(const unsigned long *addr1, const unsigned lon
 		return size;
 
 	if (small_const_nbits(size)) {
-		unsigned long val =  *addr1 & (~*addr2) & GENMASK(size - 1, 0);
+		unsigned long val = READ_ONCE(*addr1) & ~READ_ONCE(*addr2) &
+							GENMASK(size - 1, 0);
 
 		return val ? fns(val, n) : size;
 	}
@@ -312,7 +317,8 @@ unsigned long find_nth_and_andnot_bit(const unsigned long *addr1,
 		return size;
 
 	if (small_const_nbits(size)) {
-		unsigned long val =  *addr1 & *addr2 & (~*addr3) & GENMASK(size - 1, 0);
+		unsigned long val = READ_ONCE(*addr1) & READ_ONCE(*addr2) &
+				~READ_ONCE(*addr3) & GENMASK(size - 1, 0);
 
 		return val ? fns(val, n) : size;
 	}
@@ -336,7 +342,8 @@ unsigned long find_first_and_bit(const unsigned long *addr1,
 				 unsigned long size)
 {
 	if (small_const_nbits(size)) {
-		unsigned long val = *addr1 & *addr2 & GENMASK(size - 1, 0);
+		unsigned long val = READ_ONCE(*addr1) & READ_ONCE(*addr2) &
+							GENMASK(size - 1, 0);
 
 		return val ? __ffs(val) : size;
 	}
@@ -358,7 +365,7 @@ static inline
 unsigned long find_first_zero_bit(const unsigned long *addr, unsigned long size)
 {
 	if (small_const_nbits(size)) {
-		unsigned long val = *addr | ~GENMASK(size - 1, 0);
+		unsigned long val = READ_ONCE(*addr) | ~GENMASK(size - 1, 0);
 
 		return val == ~0UL ? size : ffz(val);
 	}
@@ -379,7 +386,7 @@ static inline
 unsigned long find_last_bit(const unsigned long *addr, unsigned long size)
 {
 	if (small_const_nbits(size)) {
-		unsigned long val = *addr & GENMASK(size - 1, 0);
+		unsigned long val = READ_ONCE(*addr) & GENMASK(size - 1, 0);
 
 		return val ? __fls(val) : size;
 	}
@@ -505,7 +512,7 @@ unsigned long find_next_zero_bit_le(const void *addr, unsigned
 		long size, unsigned long offset)
 {
 	if (small_const_nbits(size)) {
-		unsigned long val = *(const unsigned long *)addr;
+		unsigned long val = READ_ONCE(*(const unsigned long *)addr);
 
 		if (unlikely(offset >= size))
 			return size;
@@ -523,7 +530,8 @@ static inline
 unsigned long find_first_zero_bit_le(const void *addr, unsigned long size)
 {
 	if (small_const_nbits(size)) {
-		unsigned long val = swab(*(const unsigned long *)addr) | ~GENMASK(size - 1, 0);
+		unsigned long val = swab(READ_ONCE(*(const unsigned long *)addr))
+						| ~GENMASK(size - 1, 0);
 
 		return val == ~0UL ? size : ffz(val);
 	}
@@ -538,7 +546,7 @@ unsigned long find_next_bit_le(const void *addr, unsigned
 		long size, unsigned long offset)
 {
 	if (small_const_nbits(size)) {
-		unsigned long val = *(const unsigned long *)addr;
+		unsigned long val = READ_ONCE(*(const unsigned long *)addr);
 
 		if (unlikely(offset >= size))
 			return size;
diff --git a/lib/find_bit.c b/lib/find_bit.c
index 32f99e9a670e..6867ef8a85e0 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -98,7 +98,7 @@ out:										\
  */
 unsigned long _find_first_bit(const unsigned long *addr, unsigned long size)
 {
-	return FIND_FIRST_BIT(addr[idx], /* nop */, size);
+	return FIND_FIRST_BIT(READ_ONCE(addr[idx]), /* nop */, size);
 }
 EXPORT_SYMBOL(_find_first_bit);
 #endif
@@ -111,7 +111,8 @@ unsigned long _find_first_and_bit(const unsigned long *addr1,
 				  const unsigned long *addr2,
 				  unsigned long size)
 {
-	return FIND_FIRST_BIT(addr1[idx] & addr2[idx], /* nop */, size);
+	return FIND_FIRST_BIT(READ_ONCE(addr1[idx]) & READ_ONCE(addr2[idx]),
+				/* nop */, size);
 }
 EXPORT_SYMBOL(_find_first_and_bit);
 #endif
@@ -122,7 +123,7 @@ EXPORT_SYMBOL(_find_first_and_bit);
  */
 unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size)
 {
-	return FIND_FIRST_BIT(~addr[idx], /* nop */, size);
+	return FIND_FIRST_BIT(~READ_ONCE(addr[idx]), /* nop */, size);
 }
 EXPORT_SYMBOL(_find_first_zero_bit);
 #endif
@@ -130,28 +131,30 @@ EXPORT_SYMBOL(_find_first_zero_bit);
 #ifndef find_next_bit
 unsigned long _find_next_bit(const unsigned long *addr, unsigned long nbits, unsigned long start)
 {
-	return FIND_NEXT_BIT(addr[idx], /* nop */, nbits, start);
+	return FIND_NEXT_BIT(READ_ONCE(addr[idx]), /* nop */, nbits, start);
 }
 EXPORT_SYMBOL(_find_next_bit);
 #endif
 
 unsigned long __find_nth_bit(const unsigned long *addr, unsigned long size, unsigned long n)
 {
-	return FIND_NTH_BIT(addr[idx], size, n);
+	return FIND_NTH_BIT(READ_ONCE(addr[idx]), size, n);
 }
 EXPORT_SYMBOL(__find_nth_bit);
 
 unsigned long __find_nth_and_bit(const unsigned long *addr1, const unsigned long *addr2,
 				 unsigned long size, unsigned long n)
 {
-	return FIND_NTH_BIT(addr1[idx] & addr2[idx], size, n);
+	return FIND_NTH_BIT(READ_ONCE(addr1[idx]) & READ_ONCE(addr2[idx]),
+			    size, n);
 }
 EXPORT_SYMBOL(__find_nth_and_bit);
 
 unsigned long __find_nth_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
 				 unsigned long size, unsigned long n)
 {
-	return FIND_NTH_BIT(addr1[idx] & ~addr2[idx], size, n);
+	return FIND_NTH_BIT(READ_ONCE(addr1[idx]) & ~READ_ONCE(addr2[idx]),
+			    size, n);
 }
 EXPORT_SYMBOL(__find_nth_andnot_bit);
 
@@ -160,7 +163,8 @@ unsigned long __find_nth_and_andnot_bit(const unsigned long *addr1,
 					const unsigned long *addr3,
 					unsigned long size, unsigned long n)
 {
-	return FIND_NTH_BIT(addr1[idx] & addr2[idx] & ~addr3[idx], size, n);
+	return FIND_NTH_BIT(READ_ONCE(addr1[idx]) & READ_ONCE(addr2[idx]) &
+			    ~READ_ONCE(addr3[idx]), size, n);
 }
 EXPORT_SYMBOL(__find_nth_and_andnot_bit);
 
@@ -168,7 +172,8 @@ EXPORT_SYMBOL(__find_nth_and_andnot_bit);
 unsigned long _find_next_and_bit(const unsigned long *addr1, const unsigned long *addr2,
 					unsigned long nbits, unsigned long start)
 {
-	return FIND_NEXT_BIT(addr1[idx] & addr2[idx], /* nop */, nbits, start);
+	return FIND_NEXT_BIT(READ_ONCE(addr1[idx]) & READ_ONCE(addr2[idx]),
+			     /* nop */, nbits, start);
 }
 EXPORT_SYMBOL(_find_next_and_bit);
 #endif
@@ -177,7 +182,8 @@ EXPORT_SYMBOL(_find_next_and_bit);
 unsigned long _find_next_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
 					unsigned long nbits, unsigned long start)
 {
-	return FIND_NEXT_BIT(addr1[idx] & ~addr2[idx], /* nop */, nbits, start);
+	return FIND_NEXT_BIT(READ_ONCE(addr1[idx]) & ~READ_ONCE(addr2[idx]),
+			     /* nop */, nbits, start);
 }
 EXPORT_SYMBOL(_find_next_andnot_bit);
 #endif
@@ -186,7 +192,8 @@ EXPORT_SYMBOL(_find_next_andnot_bit);
 unsigned long _find_next_or_bit(const unsigned long *addr1, const unsigned long *addr2,
 					unsigned long nbits, unsigned long start)
 {
-	return FIND_NEXT_BIT(addr1[idx] | addr2[idx], /* nop */, nbits, start);
+	return FIND_NEXT_BIT(READ_ONCE(addr1[idx]) | READ_ONCE(addr2[idx]),
+			     /* nop */, nbits, start);
 }
 EXPORT_SYMBOL(_find_next_or_bit);
 #endif
@@ -195,7 +202,7 @@ EXPORT_SYMBOL(_find_next_or_bit);
 unsigned long _find_next_zero_bit(const unsigned long *addr, unsigned long nbits,
 					 unsigned long start)
 {
-	return FIND_NEXT_BIT(~addr[idx], /* nop */, nbits, start);
+	return FIND_NEXT_BIT(~READ_ONCE(addr[idx]), /* nop */, nbits, start);
 }
 EXPORT_SYMBOL(_find_next_zero_bit);
 #endif
@@ -208,7 +215,7 @@ unsigned long _find_last_bit(const unsigned long *addr, unsigned long size)
 		unsigned long idx = (size-1) / BITS_PER_LONG;
 
 		do {
-			val &= addr[idx];
+			val &= READ_ONCE(addr[idx]);
 			if (val)
 				return idx * BITS_PER_LONG + __fls(val);
 
@@ -242,7 +249,7 @@ EXPORT_SYMBOL(find_next_clump8);
  */
 unsigned long _find_first_zero_bit_le(const unsigned long *addr, unsigned long size)
 {
-	return FIND_FIRST_BIT(~addr[idx], swab, size);
+	return FIND_FIRST_BIT(~READ_ONCE(addr[idx]), swab, size);
 }
 EXPORT_SYMBOL(_find_first_zero_bit_le);
 
@@ -252,7 +259,7 @@ EXPORT_SYMBOL(_find_first_zero_bit_le);
 unsigned long _find_next_zero_bit_le(const unsigned long *addr,
 					unsigned long size, unsigned long offset)
 {
-	return FIND_NEXT_BIT(~addr[idx], swab, size, offset);
+	return FIND_NEXT_BIT(~READ_ONCE(addr[idx]), swab, size, offset);
 }
 EXPORT_SYMBOL(_find_next_zero_bit_le);
 #endif
@@ -261,7 +268,7 @@ EXPORT_SYMBOL(_find_next_zero_bit_le);
 unsigned long _find_next_bit_le(const unsigned long *addr,
 				unsigned long size, unsigned long offset)
 {
-	return FIND_NEXT_BIT(addr[idx], swab, size, offset);
+	return FIND_NEXT_BIT(READ_ONCE(addr[idx]), swab, size, offset);
 }
 EXPORT_SYMBOL(_find_next_bit_le);
 
-- 
2.35.3


