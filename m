Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204D7607CBA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Oct 2022 18:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiJUQvs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Oct 2022 12:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiJUQvg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Oct 2022 12:51:36 -0400
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E5B273563;
        Fri, 21 Oct 2022 09:51:34 -0700 (PDT)
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
        by relayaws-01.paragon-software.com (Postfix) with ESMTPS id BE0912201;
        Fri, 21 Oct 2022 16:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1666370939;
        bh=zrg3GA4EWJkT/4Al6TICZypL9gmnHRpNe4mgRyK9fUo=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=aOjSHUzAkDwdCST/J5WWCr24gTbPuRdK6DdDWzqIxU3Ao1aGYxQ7aVE+GiywCQFxU
         d02EXm7PvSlrwKBYzB1gW7Zna55p1l+cvTXodQTsZKMWYBvy3VeaOnTc4iJcotuqNg
         V71RtJgUOb3pQh9SLesdZ1EsFf6vr0OHlKCF3AN4=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id C4B102138;
        Fri, 21 Oct 2022 16:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1666371092;
        bh=zrg3GA4EWJkT/4Al6TICZypL9gmnHRpNe4mgRyK9fUo=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=MgV6RxC3lYeFhnD0Z7L8hWVnn/1X6siCAPIlQ8kCRol/+z8E0EtVsjaFMFtCdJodv
         Q2PYE44EasMmmc0iMmNsx2KsVQF7pP9OnLg0atWG2cu1h0hIyhC7YUbbEDCPxmlFGe
         IQahmx8FwSSVG1oP1/uNJwm4zFFejIAGgCBLbzok=
Received: from [172.30.8.65] (172.30.8.65) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 21 Oct 2022 19:51:32 +0300
Message-ID: <e85b204a-c456-3c7c-f03b-3d193ffde4ac@paragon-software.com>
Date:   Fri, 21 Oct 2022 19:51:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [PATCH 1/4] fs/ntfs3: Add ntfs_bitmap_weight_le function and
 refactoring
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <9a7d08c2-e503-ac1d-1621-20369c073530@paragon-software.com>
In-Reply-To: <9a7d08c2-e503-ac1d-1621-20369c073530@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.30.8.65]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Added ntfs_bitmap_weight_le function.
Changed argument types of bits/bitmap functions.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/bitfunc.c |   4 +-
  fs/ntfs3/bitmap.c  | 100 +++++++++++++++++++++++++--------------------
  fs/ntfs3/ntfs_fs.h |  11 ++---
  3 files changed, 63 insertions(+), 52 deletions(-)

diff --git a/fs/ntfs3/bitfunc.c b/fs/ntfs3/bitfunc.c
index 50d838093790..25a4d4896aa9 100644
--- a/fs/ntfs3/bitfunc.c
+++ b/fs/ntfs3/bitfunc.c
@@ -30,7 +30,7 @@ static const u8 zero_mask[] = { 0xFF, 0xFE, 0xFC, 0xF8, 0xF0,
   *
   * Return: True if all bits [bit, bit+nbits) are zeros "0".
   */
-bool are_bits_clear(const ulong *lmap, size_t bit, size_t nbits)
+bool are_bits_clear(const void *lmap, size_t bit, size_t nbits)
  {
  	size_t pos = bit & 7;
  	const u8 *map = (u8 *)lmap + (bit >> 3);
@@ -78,7 +78,7 @@ bool are_bits_clear(const ulong *lmap, size_t bit, size_t nbits)
   *
   * Return: True if all bits [bit, bit+nbits) are ones "1".
   */
-bool are_bits_set(const ulong *lmap, size_t bit, size_t nbits)
+bool are_bits_set(const void *lmap, size_t bit, size_t nbits)
  {
  	u8 mask;
  	size_t pos = bit & 7;
diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
index 899a631863c8..6e68887597ac 100644
--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -59,7 +59,7 @@ void ntfs3_exit_bitmap(void)
   *
   * Return: -1 if not found.
   */
-static size_t wnd_scan(const ulong *buf, size_t wbit, u32 wpos, u32 wend,
+static size_t wnd_scan(const void *buf, size_t wbit, u32 wpos, u32 wend,
  		       size_t to_alloc, size_t *prev_tail, size_t *b_pos,
  		       size_t *b_len)
  {
@@ -504,7 +504,6 @@ static int wnd_rescan(struct wnd_bitmap *wnd)
  	u8 cluster_bits = sbi->cluster_bits;
  	u32 wbits = 8 * sb->s_blocksize;
  	u32 used, frb;
-	const ulong *buf;
  	size_t wpos, wbit, iw, vbo;
  	struct buffer_head *bh = NULL;
  	CLST lcn, clen;
@@ -558,9 +557,7 @@ static int wnd_rescan(struct wnd_bitmap *wnd)
  			goto out;
  		}
  
-		buf = (ulong *)bh->b_data;
-
-		used = __bitmap_weight(buf, wbits);
+		used = ntfs_bitmap_weight_le(bh->b_data, wbits);
  		if (used < wbits) {
  			frb = wbits - used;
  			wnd->free_bits[iw] = frb;
@@ -574,7 +571,7 @@ static int wnd_rescan(struct wnd_bitmap *wnd)
  			wbits = wnd->nbits - wbit;
  
  		do {
-			used = find_next_zero_bit_le(buf, wbits, wpos);
+			used = find_next_zero_bit_le(bh->b_data, wbits, wpos);
  
  			if (used > wpos && prev_tail) {
  				wnd_add_free_ext(wnd, wbit + wpos - prev_tail,
@@ -590,7 +587,7 @@ static int wnd_rescan(struct wnd_bitmap *wnd)
  				break;
  			}
  
-			frb = find_next_bit_le(buf, wbits, wpos);
+			frb = find_next_bit_le(bh->b_data, wbits, wpos);
  			if (frb >= wbits) {
  				/* Keep last free block. */
  				prev_tail += frb - wpos;
@@ -718,7 +715,6 @@ int wnd_set_free(struct wnd_bitmap *wnd, size_t bit, size_t bits)
  
  	while (iw < wnd->nwnd && bits) {
  		u32 tail, op;
-		ulong *buf;
  
  		if (iw + 1 == wnd->nwnd)
  			wbits = wnd->bits_last;
@@ -732,11 +728,9 @@ int wnd_set_free(struct wnd_bitmap *wnd, size_t bit, size_t bits)
  			break;
  		}
  
-		buf = (ulong *)bh->b_data;
-
  		lock_buffer(bh);
  
-		ntfs_bitmap_clear_le(buf, wbit, op);
+		ntfs_bitmap_clear_le(bh->b_data, wbit, op);
  
  		wnd->free_bits[iw] += op;
  
@@ -771,7 +765,6 @@ int wnd_set_used(struct wnd_bitmap *wnd, size_t bit, size_t bits)
  
  	while (iw < wnd->nwnd && bits) {
  		u32 tail, op;
-		ulong *buf;
  
  		if (unlikely(iw + 1 == wnd->nwnd))
  			wbits = wnd->bits_last;
@@ -784,11 +777,10 @@ int wnd_set_used(struct wnd_bitmap *wnd, size_t bit, size_t bits)
  			err = PTR_ERR(bh);
  			break;
  		}
-		buf = (ulong *)bh->b_data;
  
  		lock_buffer(bh);
  
-		ntfs_bitmap_set_le(buf, wbit, op);
+		ntfs_bitmap_set_le(bh->b_data, wbit, op);
  		wnd->free_bits[iw] -= op;
  
  		set_buffer_uptodate(bh);
@@ -836,7 +828,7 @@ static bool wnd_is_free_hlp(struct wnd_bitmap *wnd, size_t bit, size_t bits)
  			if (IS_ERR(bh))
  				return false;
  
-			ret = are_bits_clear((ulong *)bh->b_data, wbit, op);
+			ret = are_bits_clear(bh->b_data, wbit, op);
  
  			put_bh(bh);
  			if (!ret)
@@ -928,7 +920,7 @@ bool wnd_is_used(struct wnd_bitmap *wnd, size_t bit, size_t bits)
  			if (IS_ERR(bh))
  				goto out;
  
-			ret = are_bits_set((ulong *)bh->b_data, wbit, op);
+			ret = are_bits_set(bh->b_data, wbit, op);
  			put_bh(bh);
  			if (!ret)
  				goto out;
@@ -959,7 +951,6 @@ size_t wnd_find(struct wnd_bitmap *wnd, size_t to_alloc, size_t hint,
  	size_t fnd, max_alloc, b_len, b_pos;
  	size_t iw, prev_tail, nwnd, wbit, ebit, zbit, zend;
  	size_t to_alloc0 = to_alloc;
-	const ulong *buf;
  	const struct e_node *e;
  	const struct rb_node *pr, *cr;
  	u8 log2_bits;
@@ -1185,14 +1176,13 @@ size_t wnd_find(struct wnd_bitmap *wnd, size_t to_alloc, size_t hint,
  					continue;
  				}
  
-				buf = (ulong *)bh->b_data;
-
  				/* Scan range [wbit, zbit). */
  				if (wpos < wzbit) {
  					/* Scan range [wpos, zbit). */
-					fnd = wnd_scan(buf, wbit, wpos, wzbit,
-						       to_alloc, &prev_tail,
-						       &b_pos, &b_len);
+					fnd = wnd_scan(bh->b_data, wbit, wpos,
+						       wzbit, to_alloc,
+						       &prev_tail, &b_pos,
+						       &b_len);
  					if (fnd != MINUS_ONE_T) {
  						put_bh(bh);
  						goto found;
@@ -1203,7 +1193,7 @@ size_t wnd_find(struct wnd_bitmap *wnd, size_t to_alloc, size_t hint,
  
  				/* Scan range [zend, ebit). */
  				if (wzend < wbits) {
-					fnd = wnd_scan(buf, wbit,
+					fnd = wnd_scan(bh->b_data, wbit,
  						       max(wzend, wpos), wbits,
  						       to_alloc, &prev_tail,
  						       &b_pos, &b_len);
@@ -1242,11 +1232,9 @@ size_t wnd_find(struct wnd_bitmap *wnd, size_t to_alloc, size_t hint,
  			continue;
  		}
  
-		buf = (ulong *)bh->b_data;
-
  		/* Scan range [wpos, eBits). */
-		fnd = wnd_scan(buf, wbit, wpos, wbits, to_alloc, &prev_tail,
-			       &b_pos, &b_len);
+		fnd = wnd_scan(bh->b_data, wbit, wpos, wbits, to_alloc,
+			       &prev_tail, &b_pos, &b_len);
  		put_bh(bh);
  		if (fnd != MINUS_ONE_T)
  			goto found;
@@ -1344,7 +1332,6 @@ int wnd_extend(struct wnd_bitmap *wnd, size_t new_bits)
  		size_t frb;
  		u64 vbo, lbo, bytes;
  		struct buffer_head *bh;
-		ulong *buf;
  
  		if (iw + 1 == new_wnd)
  			wbits = new_last;
@@ -1361,10 +1348,9 @@ int wnd_extend(struct wnd_bitmap *wnd, size_t new_bits)
  			return -EIO;
  
  		lock_buffer(bh);
-		buf = (ulong *)bh->b_data;
  
-		ntfs_bitmap_clear_le(buf, b0, blocksize * 8 - b0);
-		frb = wbits - __bitmap_weight(buf, wbits);
+		ntfs_bitmap_clear_le(bh->b_data, b0, blocksize * 8 - b0);
+		frb = wbits - ntfs_bitmap_weight_le(bh->b_data, wbits);
  		wnd->total_zeroes += frb - wnd->free_bits[iw];
  		wnd->free_bits[iw] = frb;
  
@@ -1411,7 +1397,6 @@ int ntfs_trim_fs(struct ntfs_sb_info *sbi, struct fstrim_range *range)
  	CLST lcn_from = bytes_to_cluster(sbi, range->start);
  	size_t iw = lcn_from >> (sb->s_blocksize_bits + 3);
  	u32 wbit = lcn_from & (wbits - 1);
-	const ulong *buf;
  	CLST lcn_to;
  
  	if (!minlen)
@@ -1446,10 +1431,8 @@ int ntfs_trim_fs(struct ntfs_sb_info *sbi, struct fstrim_range *range)
  			break;
  		}
  
-		buf = (ulong *)bh->b_data;
-
  		for (; wbit < wbits; wbit++) {
-			if (!test_bit_le(wbit, buf)) {
+			if (!test_bit_le(wbit, bh->b_data)) {
  				if (!len)
  					lcn = lcn_wnd + wbit;
  				len += 1;
@@ -1482,42 +1465,69 @@ int ntfs_trim_fs(struct ntfs_sb_info *sbi, struct fstrim_range *range)
  	return err;
  }
  
-void ntfs_bitmap_set_le(unsigned long *map, unsigned int start, int len)
+#if BITS_PER_LONG == 64
+typedef __le64 bitmap_ulong;
+#define cpu_to_ul(x) cpu_to_le64(x)
+#define ul_to_cpu(x) le64_to_cpu(x)
+#else
+typedef __le32 bitmap_ulong;
+#define cpu_to_ul(x) cpu_to_le32(x)
+#define ul_to_cpu(x) le32_to_cpu(x)
+#endif
+
+void ntfs_bitmap_set_le(void *map, unsigned int start, int len)
  {
-	unsigned long *p = map + BIT_WORD(start);
+	bitmap_ulong *p = (bitmap_ulong *)map + BIT_WORD(start);
  	const unsigned int size = start + len;
  	int bits_to_set = BITS_PER_LONG - (start % BITS_PER_LONG);
-	unsigned long mask_to_set = cpu_to_le32(BITMAP_FIRST_WORD_MASK(start));
+	bitmap_ulong mask_to_set = cpu_to_ul(BITMAP_FIRST_WORD_MASK(start));
  
  	while (len - bits_to_set >= 0) {
  		*p |= mask_to_set;
  		len -= bits_to_set;
  		bits_to_set = BITS_PER_LONG;
-		mask_to_set = ~0UL;
+		mask_to_set = cpu_to_ul(~0UL);
  		p++;
  	}
  	if (len) {
-		mask_to_set &= cpu_to_le32(BITMAP_LAST_WORD_MASK(size));
+		mask_to_set &= cpu_to_ul(BITMAP_LAST_WORD_MASK(size));
  		*p |= mask_to_set;
  	}
  }
  
-void ntfs_bitmap_clear_le(unsigned long *map, unsigned int start, int len)
+void ntfs_bitmap_clear_le(void *map, unsigned int start, int len)
  {
-	unsigned long *p = map + BIT_WORD(start);
+	bitmap_ulong *p = (bitmap_ulong *)map + BIT_WORD(start);
  	const unsigned int size = start + len;
  	int bits_to_clear = BITS_PER_LONG - (start % BITS_PER_LONG);
-	unsigned long mask_to_clear = cpu_to_le32(BITMAP_FIRST_WORD_MASK(start));
+	bitmap_ulong mask_to_clear = cpu_to_ul(BITMAP_FIRST_WORD_MASK(start));
  
  	while (len - bits_to_clear >= 0) {
  		*p &= ~mask_to_clear;
  		len -= bits_to_clear;
  		bits_to_clear = BITS_PER_LONG;
-		mask_to_clear = ~0UL;
+		mask_to_clear = cpu_to_ul(~0UL);
  		p++;
  	}
  	if (len) {
-		mask_to_clear &= cpu_to_le32(BITMAP_LAST_WORD_MASK(size));
+		mask_to_clear &= cpu_to_ul(BITMAP_LAST_WORD_MASK(size));
  		*p &= ~mask_to_clear;
  	}
  }
+
+unsigned int ntfs_bitmap_weight_le(const void *bitmap, int bits)
+{
+	const ulong *bmp = bitmap;
+	unsigned int k, lim = bits / BITS_PER_LONG;
+	unsigned int w = 0;
+
+	for (k = 0; k < lim; k++)
+		w += hweight_long(bmp[k]);
+
+	if (bits % BITS_PER_LONG) {
+		w += hweight_long(ul_to_cpu(((bitmap_ulong *)bitmap)[k]) &
+				  BITMAP_LAST_WORD_MASK(bits));
+	}
+
+	return w;
+}
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index a71b4a0a66d8..2f6fb6ceaeca 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -471,9 +471,9 @@ static inline size_t al_aligned(size_t size)
  }
  
  /* Globals from bitfunc.c */
-bool are_bits_clear(const ulong *map, size_t bit, size_t nbits);
-bool are_bits_set(const ulong *map, size_t bit, size_t nbits);
-size_t get_set_bits_ex(const ulong *map, size_t bit, size_t nbits);
+bool are_bits_clear(const void *map, size_t bit, size_t nbits);
+bool are_bits_set(const void *map, size_t bit, size_t nbits);
+size_t get_set_bits_ex(const void *map, size_t bit, size_t nbits);
  
  /* Globals from dir.c */
  int ntfs_utf16_to_nls(struct ntfs_sb_info *sbi, const __le16 *name, u32 len,
@@ -837,8 +837,9 @@ int wnd_extend(struct wnd_bitmap *wnd, size_t new_bits);
  void wnd_zone_set(struct wnd_bitmap *wnd, size_t Lcn, size_t Len);
  int ntfs_trim_fs(struct ntfs_sb_info *sbi, struct fstrim_range *range);
  
-void ntfs_bitmap_set_le(unsigned long *map, unsigned int start, int len);
-void ntfs_bitmap_clear_le(unsigned long *map, unsigned int start, int len);
+void ntfs_bitmap_set_le(void *map, unsigned int start, int len);
+void ntfs_bitmap_clear_le(void *map, unsigned int start, int len);
+unsigned int ntfs_bitmap_weight_le(const void *bitmap, int bits);
  
  /* Globals from upcase.c */
  int ntfs_cmp_names(const __le16 *s1, size_t l1, const __le16 *s2, size_t l2,
-- 
2.37.0


