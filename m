Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C076F1B17B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 22:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgDTU6X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 16:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbgDTU6W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:58:22 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF3EC061A0C;
        Mon, 20 Apr 2020 13:58:22 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b11so13930067wrs.6;
        Mon, 20 Apr 2020 13:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=43NGMK0fl2P8vgm86aw9wz76iQWCFK0ejX7R4isfjHA=;
        b=hU6s71HDN7JFerzLh8VBd0snf1UEVzftgZBzP6zjamTSzFQJvVipg0D0LTr8cnl7TE
         Neyp9fUT2rF9LVpx1Qp0DZnTPw3jpVU8bY+j8NjHTE/yhR1dm96yM0v82l/s5axcOZiD
         U3P9eJMqHnDtRZtasywJzIQnAvys8voOhPoOz2N8I3Dffql7FAhfbDE2wTlh1qfSalBF
         T66i4zhx/PyaY1y6UqVbkddHfU+ZPD8yu/5jewofy6hWQ53koQeeHpTmZ80wLwJtwqCN
         uVmrvuvRBeTgJF+q+eTiHJ3AFYZA0qS+3su+5aLxANwWKEmpOpCrbdIIorfJFOu9u/X9
         95LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=43NGMK0fl2P8vgm86aw9wz76iQWCFK0ejX7R4isfjHA=;
        b=jOkJ0TMNOTR6EoliLpPQmTSdLhr/tzY9CrhatoaWorYOJ2ncunhue3JNNIOTmbKTmQ
         2oRXUjfk2uIaFncE/dOI3lu9HaZJCIp/EJKOYiWyO1EnjgsHkymQv6z+xAGWpInbxJYH
         zVsdl93WgQwxV8PyY2Np8UtIuC9tKWu9t02DTBs7yk6AWb0LT21eFfqOypJrZfCWpWwn
         rPoPwqC7XV3UEnH3k7FhCNQbwprFVu1S4InYFd07QJlslNanZQ5h6GzTmtPzJAjzQ7iO
         WXJkbUv85t2SzexbAVbPdKH2lzK5lmADP9DfOlITgaa9l3azd8IyLa7Xzqwe0oPWFfRS
         CTfw==
X-Gm-Message-State: AGi0Pua/WMAZitnG324KzHeyH8GtNeUN3YB5yEe6BPeVHMehNz6QVbEF
        FBWiP8cDlwPyw32iF01OJg==
X-Google-Smtp-Source: APiQypKC7Tfz05uJggulT0w9U1UB8d6/n5t8xnm7QMOQnMn36LTscGClBccjt8HSGBASVFk3E7aryw==
X-Received: by 2002:a5d:4283:: with SMTP id k3mr19538897wrq.238.1587416301014;
        Mon, 20 Apr 2020 13:58:21 -0700 (PDT)
Received: from avx2.telecom.by ([46.53.249.74])
        by smtp.gmail.com with ESMTPSA id m8sm863069wrx.54.2020.04.20.13.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 13:58:20 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     adobriyan@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk
Subject: [PATCH 14/15] print_integer, printf: rewrite the rest of lib/vsprintf.c via print_integer()
Date:   Mon, 20 Apr 2020 23:57:42 +0300
Message-Id: <20200420205743.19964-14-adobriyan@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200420205743.19964-1-adobriyan@gmail.com>
References: <20200420205743.19964-1-adobriyan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Lookup tables are cheating.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 lib/vsprintf.c | 236 +++++--------------------------------------------
 1 file changed, 20 insertions(+), 216 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index df2b5ce08fe9..b29fbd0da53f 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -138,204 +138,6 @@ int skip_atoi(const char **s)
 	return i;
 }
 
-/*
- * Decimal conversion is by far the most typical, and is used for
- * /proc and /sys data. This directly impacts e.g. top performance
- * with many processes running. We optimize it for speed by emitting
- * two characters at a time, using a 200 byte lookup table. This
- * roughly halves the number of multiplications compared to computing
- * the digits one at a time. Implementation strongly inspired by the
- * previous version, which in turn used ideas described at
- * <http://www.cs.uiowa.edu/~jones/bcd/divide.html> (with permission
- * from the author, Douglas W. Jones).
- *
- * It turns out there is precisely one 26 bit fixed-point
- * approximation a of 64/100 for which x/100 == (x * (u64)a) >> 32
- * holds for all x in [0, 10^8-1], namely a = 0x28f5c29. The actual
- * range happens to be somewhat larger (x <= 1073741898), but that's
- * irrelevant for our purpose.
- *
- * For dividing a number in the range [10^4, 10^6-1] by 100, we still
- * need a 32x32->64 bit multiply, so we simply use the same constant.
- *
- * For dividing a number in the range [100, 10^4-1] by 100, there are
- * several options. The simplest is (x * 0x147b) >> 19, which is valid
- * for all x <= 43698.
- */
-
-static const u16 decpair[100] = {
-#define _(x) (__force u16) cpu_to_le16(((x % 10) | ((x / 10) << 8)) + 0x3030)
-	_( 0), _( 1), _( 2), _( 3), _( 4), _( 5), _( 6), _( 7), _( 8), _( 9),
-	_(10), _(11), _(12), _(13), _(14), _(15), _(16), _(17), _(18), _(19),
-	_(20), _(21), _(22), _(23), _(24), _(25), _(26), _(27), _(28), _(29),
-	_(30), _(31), _(32), _(33), _(34), _(35), _(36), _(37), _(38), _(39),
-	_(40), _(41), _(42), _(43), _(44), _(45), _(46), _(47), _(48), _(49),
-	_(50), _(51), _(52), _(53), _(54), _(55), _(56), _(57), _(58), _(59),
-	_(60), _(61), _(62), _(63), _(64), _(65), _(66), _(67), _(68), _(69),
-	_(70), _(71), _(72), _(73), _(74), _(75), _(76), _(77), _(78), _(79),
-	_(80), _(81), _(82), _(83), _(84), _(85), _(86), _(87), _(88), _(89),
-	_(90), _(91), _(92), _(93), _(94), _(95), _(96), _(97), _(98), _(99),
-#undef _
-};
-
-/*
- * This will print a single '0' even if r == 0, since we would
- * immediately jump to out_r where two 0s would be written but only
- * one of them accounted for in buf. This is needed by ip4_string
- * below. All other callers pass a non-zero value of r.
-*/
-static noinline_for_stack
-char *put_dec_trunc8(char *buf, unsigned r)
-{
-	unsigned q;
-
-	/* 1 <= r < 10^8 */
-	if (r < 100)
-		goto out_r;
-
-	/* 100 <= r < 10^8 */
-	q = (r * (u64)0x28f5c29) >> 32;
-	*((u16 *)buf) = decpair[r - 100*q];
-	buf += 2;
-
-	/* 1 <= q < 10^6 */
-	if (q < 100)
-		goto out_q;
-
-	/*  100 <= q < 10^6 */
-	r = (q * (u64)0x28f5c29) >> 32;
-	*((u16 *)buf) = decpair[q - 100*r];
-	buf += 2;
-
-	/* 1 <= r < 10^4 */
-	if (r < 100)
-		goto out_r;
-
-	/* 100 <= r < 10^4 */
-	q = (r * 0x147b) >> 19;
-	*((u16 *)buf) = decpair[r - 100*q];
-	buf += 2;
-out_q:
-	/* 1 <= q < 100 */
-	r = q;
-out_r:
-	/* 1 <= r < 100 */
-	*((u16 *)buf) = decpair[r];
-	buf += r < 10 ? 1 : 2;
-	return buf;
-}
-
-#if BITS_PER_LONG == 64 && BITS_PER_LONG_LONG == 64
-static noinline_for_stack
-char *put_dec_full8(char *buf, unsigned r)
-{
-	unsigned q;
-
-	/* 0 <= r < 10^8 */
-	q = (r * (u64)0x28f5c29) >> 32;
-	*((u16 *)buf) = decpair[r - 100*q];
-	buf += 2;
-
-	/* 0 <= q < 10^6 */
-	r = (q * (u64)0x28f5c29) >> 32;
-	*((u16 *)buf) = decpair[q - 100*r];
-	buf += 2;
-
-	/* 0 <= r < 10^4 */
-	q = (r * 0x147b) >> 19;
-	*((u16 *)buf) = decpair[r - 100*q];
-	buf += 2;
-
-	/* 0 <= q < 100 */
-	*((u16 *)buf) = decpair[q];
-	buf += 2;
-	return buf;
-}
-
-static noinline_for_stack
-char *put_dec(char *buf, unsigned long long n)
-{
-	if (n >= 100*1000*1000)
-		buf = put_dec_full8(buf, do_div(n, 100*1000*1000));
-	/* 1 <= n <= 1.6e11 */
-	if (n >= 100*1000*1000)
-		buf = put_dec_full8(buf, do_div(n, 100*1000*1000));
-	/* 1 <= n < 1e8 */
-	return put_dec_trunc8(buf, n);
-}
-
-#elif BITS_PER_LONG == 32 && BITS_PER_LONG_LONG == 64
-
-static void
-put_dec_full4(char *buf, unsigned r)
-{
-	unsigned q;
-
-	/* 0 <= r < 10^4 */
-	q = (r * 0x147b) >> 19;
-	*((u16 *)buf) = decpair[r - 100*q];
-	buf += 2;
-	/* 0 <= q < 100 */
-	*((u16 *)buf) = decpair[q];
-}
-
-/*
- * Call put_dec_full4 on x % 10000, return x / 10000.
- * The approximation x/10000 == (x * 0x346DC5D7) >> 43
- * holds for all x < 1,128,869,999.  The largest value this
- * helper will ever be asked to convert is 1,125,520,955.
- * (second call in the put_dec code, assuming n is all-ones).
- */
-static noinline_for_stack
-unsigned put_dec_helper4(char *buf, unsigned x)
-{
-        uint32_t q = (x * (uint64_t)0x346DC5D7) >> 43;
-
-        put_dec_full4(buf, x - q * 10000);
-        return q;
-}
-
-/* Based on code by Douglas W. Jones found at
- * <http://www.cs.uiowa.edu/~jones/bcd/decimal.html#sixtyfour>
- * (with permission from the author).
- * Performs no 64-bit division and hence should be fast on 32-bit machines.
- */
-static
-char *put_dec(char *buf, unsigned long long n)
-{
-	uint32_t d3, d2, d1, q, h;
-
-	if (n < 100*1000*1000)
-		return put_dec_trunc8(buf, n);
-
-	d1  = ((uint32_t)n >> 16); /* implicit "& 0xffff" */
-	h   = (n >> 32);
-	d2  = (h      ) & 0xffff;
-	d3  = (h >> 16); /* implicit "& 0xffff" */
-
-	/* n = 2^48 d3 + 2^32 d2 + 2^16 d1 + d0
-	     = 281_4749_7671_0656 d3 + 42_9496_7296 d2 + 6_5536 d1 + d0 */
-	q   = 656 * d3 + 7296 * d2 + 5536 * d1 + ((uint32_t)n & 0xffff);
-	q = put_dec_helper4(buf, q);
-
-	q += 7671 * d3 + 9496 * d2 + 6 * d1;
-	q = put_dec_helper4(buf+4, q);
-
-	q += 4749 * d3 + 42 * d2;
-	q = put_dec_helper4(buf+8, q);
-
-	q += 281 * d3;
-	buf += 12;
-	if (q)
-		buf = put_dec_trunc8(buf, q);
-	else while (buf[-1] == '0')
-		--buf;
-
-	return buf;
-}
-
-#endif
-
 /*
  * Convert passed number to decimal string.
  * Returns the length of string.  On buffer overflow, returns 0.
@@ -410,8 +212,6 @@ static noinline_for_stack
 char *number(char *buf, char *end, unsigned long long num,
 	     struct printf_spec spec)
 {
-	/* put_dec requires 2-byte alignment of the buffer. */
-	char tmp[3 * sizeof(num)] __aligned(2);
 	char sign;
 	char locase;
 	int need_pfx = ((spec.flags & SPECIAL) && spec.base != 10);
@@ -419,6 +219,8 @@ char *number(char *buf, char *end, unsigned long long num,
 	bool is_zero = num == 0LL;
 	int field_width = spec.field_width;
 	int precision = spec.precision;
+	char tmp[22];
+	char *p = tmp + sizeof(tmp);
 
 	/* locase = 0 or 0x20. ORing digits or letters with 'locase'
 	 * produces same digits or (maybe lowercased) letters */
@@ -446,10 +248,9 @@ char *number(char *buf, char *end, unsigned long long num,
 			field_width--;
 	}
 
-	/* generate full string in tmp[], in reverse order */
-	i = 0;
+	/* generate full string in tmp[] */
 	if (num < spec.base)
-		tmp[i++] = hex_asc_upper[num] | locase;
+		*--p = hex_asc_upper[num] | locase;
 	else if (spec.base != 10) { /* 8 or 16 */
 		int mask = spec.base - 1;
 		int shift = 3;
@@ -457,12 +258,13 @@ char *number(char *buf, char *end, unsigned long long num,
 		if (spec.base == 16)
 			shift = 4;
 		do {
-			tmp[i++] = (hex_asc_upper[((unsigned char)num) & mask] | locase);
+			*--p = hex_asc_upper[((unsigned char)num) & mask] | locase;
 			num >>= shift;
 		} while (num);
 	} else { /* base 10 */
-		i = put_dec(tmp, num) - tmp;
+		p = _print_integer_u64(p, num);
 	}
+	i = tmp + sizeof(tmp) - p;
 
 	/* printing 100 using %2d gives "100", not "00" */
 	if (i > precision)
@@ -512,10 +314,11 @@ char *number(char *buf, char *end, unsigned long long num,
 		++buf;
 	}
 	/* actual digits of result */
-	while (--i >= 0) {
+	while (p != tmp + sizeof(tmp)) {
 		if (buf < end)
-			*buf = tmp[i];
+			*buf = *p;
 		++buf;
+		p++;
 	}
 	/* trailing space padding */
 	while (--field_width >= 0) {
@@ -1297,17 +1100,18 @@ char *ip4_string(char *p, const u8 *addr, const char *fmt)
 		break;
 	}
 	for (i = 0; i < 4; i++) {
-		char temp[4] __aligned(2);	/* hold each IP quad in reverse order */
-		int digits = put_dec_trunc8(temp, addr[index]) - temp;
+		char tmp[3];
+		char *q = tmp + sizeof(tmp);
+
+		tmp[0] = tmp[1] = '0';
+		q = _print_integer_u32(q, addr[index]);
 		if (leading_zeros) {
-			if (digits < 3)
-				*p++ = '0';
-			if (digits < 2)
-				*p++ = '0';
+			q = tmp;
 		}
-		/* reverse the digits in the quad */
-		while (digits--)
-			*p++ = temp[digits];
+		do {
+			*p++ = *q++;
+		} while (q != tmp + sizeof(tmp));
+
 		if (i < 3)
 			*p++ = '.';
 		index += step;
-- 
2.24.1

