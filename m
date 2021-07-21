Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B2D3D1054
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 15:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238815AbhGUNTD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 09:19:03 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49054 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbhGUNS5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 09:18:57 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8BC1F2253E;
        Wed, 21 Jul 2021 13:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626875968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=VoOIs6oTwSqmAIBkC1wkZWeiKHWApmKcZ7uSo5O6ncM=;
        b=a8vP2nUvclGFtU2/JKni1TSpYJ/pHtxGT0HeFYFgQHOEVrrKwCblNbSAzjtWESc25WxdRy
        zjlctSiyhUb81d9iVPJP76jOq4s4M22cw7DMvhrXzt9hpBR8ajofuTyWDdvLm/eWutAtPh
        BOQwpTwc/JoV7gC1bIX5vrxavUUwEB4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 331A513B39;
        Wed, 21 Jul 2021 13:59:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id w5yDCUAo+GDDbgAAMHmgww
        (envelope-from <nborisov@suse.com>); Wed, 21 Jul 2021 13:59:28 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-kernel@vger.kernel.org
Cc:     ndesaulniers@google.com, torvalds@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, david@fromorbit.com,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] lib/string: Bring optimized memcmp from glibc
Date:   Wed, 21 Jul 2021 16:59:26 +0300
Message-Id: <20210721135926.602840-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is glibc's memcmp version. The upside is that for architectures
which don't have an optimized version the kernel can provide some
solace in the form of a generic, word-sized optimized memcmp. I tested
this with a heavy IOCTL_FIDEDUPERANGE(2) workload and here are the
results I got:

	    UNPATCHED		PATCHED
real	    1m13.127s		1m10.611s
user	    0m0.030s            0m0.033s
sys         0m5.890s            0m4.001s  (32% decrease)

Comparing 2 perf profiles of the workload yield:

    30.44%    -29.39%  [kernel.vmlinux]         [k] memcmp

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 lib/string.c | 303 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 293 insertions(+), 10 deletions(-)

diff --git a/lib/string.c b/lib/string.c
index 7548eb715ddb..915db7e49804 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -923,22 +923,305 @@ EXPORT_SYMBOL(memmove);
 #endif
 
 #ifndef __HAVE_ARCH_MEMCMP
+
+/* Threshold value for when to enter the unrolled loops.  */
+#define MEMCMP_THRESH 16
+
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+# define MERGE(w0, sh_1, w1, sh_2) (((w0) >> (sh_1)) | ((w1) << (sh_2)))
+# define CMP_LT_OR_GT(a, b) memcmp_bytes((a), (b))
+/*
+ * Compare A and B bytewise in the byte order of the machine.
+ * A and B are known to be different. This is needed only on little-endian
+ * machines.
+ */
+static inline int memcmp_bytes(unsigned long a, unsigned long b)
+{
+	long srcp1 = (long) &a;
+	long srcp2 = (long) &b;
+	unsigned long a0, b0;
+
+	do {
+		a0 = ((uint8_t *) srcp1)[0];
+		b0 = ((uint8_t *) srcp2)[0];
+		srcp1 += 1;
+		srcp2 += 1;
+	} while (a0 == b0);
+	return a0 - b0;
+}
+
+#else
+# define MERGE(w0, sh_1, w1, sh_2) (((w0) << (sh_1)) | ((w1) >> (sh_2)))
+# define CMP_LT_OR_GT(a, b) ((a) > (b) ? 1 : -1)
+#endif
+
+/*
+ * The strategy of this memcmp is:
+ *  1. Compare bytes until one of the block pointers is aligned.
+ *
+ *  2. Compare using memcmp_common_alignment or memcmp_not_common_alignment,
+ *  regarding the alignment of the other block after the initial byte operations.
+ *  The maximum number of full words (of type unsigned long) are compared in
+ *  this way.
+ *
+ *  3. Compare the few remaining bytes.
+ */
+
+/*
+ * Compare blocks at SRCP1 and SRCP2 with LEN `unsigned long' objects (not LEN
+ * bytes!). Both SRCP1 and SRCP2 should be aligned for memory operations on
+ * `unsigned long's.
+ */
+static int memcmp_common_alignment(long srcp1, long srcp2, size_t len)
+{
+	unsigned long a0, a1;
+	unsigned long b0, b1;
+
+	switch (len % 4) {
+	default: /* Avoid warning about uninitialized local variables.  */
+	case 2:
+		a0 = ((unsigned long *) srcp1)[0];
+		b0 = ((unsigned long *) srcp2)[0];
+		srcp1 -= 2 * sizeof(unsigned long);
+		srcp2 -= 2 * sizeof(unsigned long);
+		len += 2;
+		goto do1;
+	case 3:
+		a1 = ((unsigned long *) srcp1)[0];
+		b1 = ((unsigned long *) srcp2)[0];
+		srcp1 -= sizeof(unsigned long);
+		srcp2 -= sizeof(unsigned long);
+		len += 1;
+		goto do2;
+	case 0:
+		if (MEMCMP_THRESH <= 3 * sizeof(unsigned long) && len == 0)
+			return 0;
+		a0 = ((unsigned long *) srcp1)[0];
+		b0 = ((unsigned long *) srcp2)[0];
+		goto do3;
+	case 1:
+		a1 = ((unsigned long *) srcp1)[0];
+		b1 = ((unsigned long *) srcp2)[0];
+		srcp1 += sizeof(unsigned long);
+		srcp2 += sizeof(unsigned long);
+		len -= 1;
+		if (MEMCMP_THRESH <= 3 * sizeof(unsigned long) && len == 0)
+			goto do0;
+		/* Fallthrough */
+	}
+
+	do {
+		a0 = ((unsigned long *) srcp1)[0];
+		b0 = ((unsigned long *) srcp2)[0];
+		if (a1 != b1)
+			return CMP_LT_OR_GT(a1, b1);
+
+do3:
+		a1 = ((unsigned long *) srcp1)[1];
+		b1 = ((unsigned long *) srcp2)[1];
+		if (a0 != b0)
+			return CMP_LT_OR_GT(a0, b0);
+
+do2:
+		a0 = ((unsigned long *) srcp1)[2];
+		b0 = ((unsigned long *) srcp2)[2];
+		if (a1 != b1)
+			return CMP_LT_OR_GT(a1, b1);
+
+do1:
+		a1 = ((unsigned long *) srcp1)[3];
+		b1 = ((unsigned long *) srcp2)[3];
+		if (a0 != b0)
+			return CMP_LT_OR_GT(a0, b0);
+
+		srcp1 += 4 * sizeof(unsigned long);
+		srcp2 += 4 * sizeof(unsigned long);
+		len -= 4;
+	}  while (len != 0);
+
+	/*
+	 * This is the right position for do0. Please don't move it into the
+	 * loop.
+	 */
+do0:
+	if (a1 != b1)
+		return CMP_LT_OR_GT(a1, b1);
+	return 0;
+}
+
+/*
+ * Compare blocks at SRCP1 and SRCP2 with LEN `unsigned long' objects (not LEN
+ * bytes!). SRCP2 should be aligned for memory operations on `unsigned long',
+ * but SRCP1 *should be unaligned*.
+ */
+static int memcmp_not_common_alignment(long srcp1, long srcp2, size_t len)
+{
+	unsigned long a0, a1, a2, a3;
+	unsigned long b0, b1, b2, b3;
+	unsigned long x;
+	int shl, shr;
+
+	/*
+	 * Calculate how to shift a word read at the memory operation
+	 * aligned srcp1 to make it aligned for comparison.
+	 */
+
+	shl = 8 * (srcp1 % sizeof(unsigned long));
+	shr = 8 * sizeof(unsigned long) - shl;
+
+	/*
+	 * Make SRCP1 aligned by rounding it down to the beginning of the
+	 * `unsigned long' it points in the middle of.
+	 */
+	srcp1 &= -sizeof(unsigned long);
+
+	switch (len % 4) {
+	default: /* Avoid warning about uninitialized local variables.  */
+	case 2:
+		a1 = ((unsigned long *) srcp1)[0];
+		a2 = ((unsigned long *) srcp1)[1];
+		b2 = ((unsigned long *) srcp2)[0];
+		srcp1 -= 1 * sizeof(unsigned long);
+		srcp2 -= 2 * sizeof(unsigned long);
+		len += 2;
+		goto do1;
+	case 3:
+		a0 = ((unsigned long *) srcp1)[0];
+		a1 = ((unsigned long *) srcp1)[1];
+		b1 = ((unsigned long *) srcp2)[0];
+		srcp2 -= 1 * sizeof(unsigned long);
+		len += 1;
+		goto do2;
+	case 0:
+		if (MEMCMP_THRESH <= 3 * sizeof(unsigned long) && len == 0)
+			return 0;
+		a3 = ((unsigned long *) srcp1)[0];
+		a0 = ((unsigned long *) srcp1)[1];
+		b0 = ((unsigned long *) srcp2)[0];
+		srcp1 += 1 * sizeof(unsigned long);
+		goto do3;
+	case 1:
+		a2 = ((unsigned long *) srcp1)[0];
+		a3 = ((unsigned long *) srcp1)[1];
+		b3 = ((unsigned long *) srcp2)[0];
+		srcp1 += 2 * sizeof(unsigned long);
+		srcp2 += 1 * sizeof(unsigned long);
+		len -= 1;
+		if (MEMCMP_THRESH <= 3 * sizeof(unsigned long) && len == 0)
+			goto do0;
+		/* Fallthrough */
+	}
+
+	do {
+		a0 = ((unsigned long *) srcp1)[0];
+		b0 = ((unsigned long *) srcp2)[0];
+		x = MERGE(a2, shl, a3, shr);
+		if (x != b3)
+			return CMP_LT_OR_GT(x, b3);
+
+do3:
+		a1 = ((unsigned long *) srcp1)[1];
+		b1 = ((unsigned long *) srcp2)[1];
+		x = MERGE(a3, shl, a0, shr);
+		if (x != b0)
+			return CMP_LT_OR_GT(x, b0);
+
+do2:
+		a2 = ((unsigned long *) srcp1)[2];
+		b2 = ((unsigned long *) srcp2)[2];
+		x = MERGE(a0, shl, a1, shr);
+		if (x != b1)
+			return CMP_LT_OR_GT(x, b1);
+
+do1:
+		a3 = ((unsigned long *) srcp1)[3];
+		b3 = ((unsigned long *) srcp2)[3];
+		x = MERGE(a1, shl, a2, shr);
+		if (x != b2)
+			return CMP_LT_OR_GT(x, b2);
+
+		srcp1 += 4 * sizeof(unsigned long);
+		srcp2 += 4 * sizeof(unsigned long);
+		len -= 4;
+	} while (len != 0);
+
+	/*
+	 * This is the right position for do0. Please don't move it into
+	 * the loop.
+	 */
+do0:
+	x = MERGE(a2, shl, a3, shr);
+	if (x != b3)
+		return CMP_LT_OR_GT(x, b3);
+	return 0;
+}
+
+#undef memcmp
 /**
  * memcmp - Compare two areas of memory
- * @cs: One area of memory
- * @ct: Another area of memory
+ * @s1: One area of memory
+ * @s2: Another area of memory
  * @count: The size of the area.
  */
-#undef memcmp
-__visible int memcmp(const void *cs, const void *ct, size_t count)
+__visible int memcmp(const void *s1, const void *s2, size_t len)
 {
-	const unsigned char *su1, *su2;
-	int res = 0;
+	unsigned long a0;
+	unsigned long b0;
+	long srcp1 = (long) s1;
+	long srcp2 = (long) s2;
+	unsigned long res;
+
+	if (len >= MEMCMP_THRESH) {
+		/*
+		 * There are at least some bytes to compare. No need to test
+		 * for LEN == 0 in this alignment loop.
+		 */
+		while (!IS_ALIGNED(srcp2, sizeof(unsigned long))) {
+			a0 = ((uint8_t *) srcp1)[0];
+			b0 = ((uint8_t *) srcp2)[0];
+			srcp1 += 1;
+			srcp2 += 1;
+			res = a0 - b0;
+			if (res != 0)
+				return res;
+			len -= 1;
+		}
 
-	for (su1 = cs, su2 = ct; 0 < count; ++su1, ++su2, count--)
-		if ((res = *su1 - *su2) != 0)
-			break;
-	return res;
+		/*
+		 * SRCP2 is now aligned for memory operations on `unsigned long'.
+		 * SRCP1 alignment determines if we can do a simple, aligned
+		 * compare or need to shuffle bits.
+		 */
+
+		if (IS_ALIGNED(srcp1, sizeof(unsigned long)))
+			res = memcmp_common_alignment(srcp1, srcp2,
+						len / sizeof(unsigned long));
+		else
+			res = memcmp_not_common_alignment(srcp1, srcp2,
+						len / sizeof(unsigned long));
+
+		if (res != 0)
+			return res;
+
+		/* Number of bytes remaining in the interval [0..sizeof(unsigned long)-1].  */
+		srcp1 += len & -sizeof(unsigned long);
+		srcp2 += len & -sizeof(unsigned long);
+		len %= sizeof(unsigned long);
+	}
+
+	/* There are just a few bytes to compare. Use byte memory operations.  */
+	while (len != 0) {
+		a0 = ((uint8_t *) srcp1)[0];
+		b0 = ((uint8_t *) srcp2)[0];
+		srcp1 += 1;
+		srcp2 += 1;
+		res = a0 - b0;
+		if (res != 0)
+			return res;
+		len -= 1;
+	}
+
+	return 0;
 }
 EXPORT_SYMBOL(memcmp);
 #endif
-- 
2.25.1

