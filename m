Return-Path: <linux-fsdevel+bounces-44494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A52A69D25
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 01:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9CE3188CABD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 00:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BAF70803;
	Thu, 20 Mar 2025 00:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="axgfbgrc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46E441C63;
	Thu, 20 Mar 2025 00:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742429666; cv=none; b=hQr3/5OZg7eQSWWDkE89ndkbsz694Nl/MIqgDwSeoOOKzlEzziVAXZy9ErXLFwnOyM/nNgrw3vYytkxo+wRgCRaV+cMHNgoJXrGiA88ICZ2dzcj3h5RB+Mnw7ITkPuAUqEvP7IdLDCEZqURa0SOSbS4DVgSpX5cCy4YohrWPX/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742429666; c=relaxed/simple;
	bh=T8RvA4W48D/W2/6rJww/f8xcFJyl7eCZIQ52Uo0a33U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=inbWQIVS3a8rN7jqbSstmgmEUnc3btJUC5Pez0Q6FqdUF/vTHv3eWL9anF4bmwqv2lbMsQQ3gQbbn0rAG+Fg7CnuoSrl6Fs/H7egBJpxjri6BbCnJie1goOW/sfeb0z0SKv+x31btB2uxNVE4fv2ZTmelc7jAaoVTjSbQTBW8/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=axgfbgrc; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ZJ5fb2cVBz9sTb;
	Thu, 20 Mar 2025 01:14:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1742429655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hS3wUeyn5edffB0I+0408Cs6auO0ncoCTv/6FdG2OeI=;
	b=axgfbgrcGRfqz5m2HJzIr1pJhkZqI0hKJxxIl4qNbEhuI7EMGuZNTTeD/Q6cAaXCNcqry2
	ckVqDsNRV1bBehwnOi9PGiQT6qsizK7kzkBRplgJjJs3RO+QlclvBGNdE8AfUOoPe4pn4c
	OXF7eSYWAZLKyQKhKR6cvXRyAdyVFJttNUfN4m7pYy+57bx8b4xyAMWuGvB6RdlI+RG+XZ
	O4q4mKBGb1kM2PTZc9PKX73JsP3cktf/oNe/Ciz9zwu14lIUulzPN/0ImL7kp5mqiZt3t4
	TOfuEf0CukEQJg2w0jzU/1KC5FGHE6V1jyEkt/MnDlm3DBX8K+mjTsy96o8ZWA==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Wed, 19 Mar 2025 20:13:53 -0400
Subject: [PATCH RFC v2 4/8] staging: apfs: init libzbitmap.{c,h} for
 decompression
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250319-apfs-v2-4-475de2e25782@ethancedwards.com>
References: <20250319-apfs-v2-0-475de2e25782@ethancedwards.com>
In-Reply-To: <20250319-apfs-v2-0-475de2e25782@ethancedwards.com>
To: brauner@kernel.org, tytso@mit.edu, jack@suse.cz, 
 viro@zeniv.linux.org.uk
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 ernesto.mnd.fernandez@gmail.com, dan.carpenter@linaro.org, 
 sven@svenpeter.dev, ernesto@corellium.com, gargaditya08@live.com, 
 willy@infradead.org, asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-staging@lists.linux.dev, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=13474;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=T8RvA4W48D/W2/6rJww/f8xcFJyl7eCZIQ52Uo0a33U=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBOK09QZkNWLzYvcWtWY090ejFlRmgwdXZWQWRuTjA3ClM4aXBiS1BUeDduaDVZeUxi
 aWQybExJd2lIRXh5SW9wc3Z6UFVVNTdxRGxEWWVkZmx5YVlPYXhNSUVNWXVEZ0YKWUNKWG56SXl
 MSHI2NjQvUWlndE1BaFlGSFNxZmw3anhxcGc0NkpiSjJ1OTladXY1OTdxcEZ5UERCbVZqN1dVdA
 pGODZWWFpvOW8vemszNzRQejJlLzkzakIrT21ML2xyTm1XWmFEQUIrQlUvQgo9eDdyawotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE
X-Rspamd-Queue-Id: 4ZJ5fb2cVBz9sTb

This code handles lzbitmap decompression in filesystem reads. Write
support is not yet implemented.

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 drivers/staging/apfs/libzbitmap.c | 448 ++++++++++++++++++++++++++++++++++++++
 drivers/staging/apfs/libzbitmap.h |  32 +++
 2 files changed, 480 insertions(+)

diff --git a/drivers/staging/apfs/libzbitmap.c b/drivers/staging/apfs/libzbitmap.c
new file mode 100644
index 0000000000000000000000000000000000000000..26e8827b7b1b8d40684127a735743ffc8da7d8de
--- /dev/null
+++ b/drivers/staging/apfs/libzbitmap.c
@@ -0,0 +1,448 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2022 Corellium LLC
+ *
+ * Author: Ernesto A. Fernández <ernesto@corellium.com>
+ *
+ * Ported from libzbitmap (https://github.com/eafer/libzbitmap). Only the
+ * decompression code is included.
+ */
+
+#include <linux/errno.h>
+#include <linux/string.h>
+#include "libzbitmap.h"
+
+#define ZBM_MAGIC "ZBM\x09"
+#define ZBM_MAGIC_SZ 4
+
+#define ZBM_MAX_DECMP_CHUNK_SIZE 0x8000
+#define ZBM_MAX_DECMP_CHUNK_SIZE_BITS 15
+
+struct uint24 {
+	uint8_t low;
+	uint8_t mid;
+	uint8_t hig;
+};
+
+/* This header is shared by both compressed and decompressed chunks */
+struct zbm_chunk_hdr {
+	struct uint24 len; /* Length of the chunk */
+	struct uint24 decmp_len; /* Length of the chunk after decompression */
+};
+
+/* The full header for compressed chunks */
+struct zbm_cmp_chunk_hdr {
+	/* Shared with decompressed chunks */
+	struct zbm_chunk_hdr hdr;
+
+	/* Offset for each of the three metadata areas */
+	struct uint24 meta_off_1;
+	struct uint24 meta_off_2;
+	struct uint24 meta_off_3;
+};
+
+/* Pointer to a half-byte */
+struct nybl_ptr {
+	uint8_t *addr; /* Address of the byte */
+	int nibble; /* Which of the two nibbles? */
+};
+
+/* 0-2 and 0xf are not real bitmap indexes */
+#define ZBM_BITMAP_COUNT (16 - 1 - 3)
+#define ZBM_BITMAP_BASE 3
+#define ZBM_BITMAP_BYTECNT 17
+#define ZBM_MAX_PERIOD_BYTECNT 2
+
+struct zbm_bmap {
+	uint8_t bitmap; /* The bitmap */
+	uint8_t period_bytecnt; /* Read this many bytes to get the new period */
+};
+
+struct zbm_state {
+	/* Updated during a chunk read */
+	uint8_t *dest; /* Write the next byte here */
+	size_t dest_left; /* Room left in destination buffer */
+	uint32_t written; /* Bytes written so far for current chunk */
+	uint16_t period; /* Repetition period for decompression, in bytes */
+
+	/* Updated right before a chunk read */
+	const uint8_t *src_end; /* End of current chunk */
+	uint32_t len; /* Length of the chunk */
+	uint32_t decmp_len; /* Expected chunk length after decompression */
+
+	/* Updated after a chunk read */
+	const uint8_t *src; /* Start of buffer, or current chunk if any */
+	size_t src_left; /* Room left in the source buffer */
+	size_t prewritten; /* Bytes written for previous chunks */
+
+	/* Current position in data and metadata areas for this chunk */
+	const uint8_t *data;
+	const uint8_t *meta_1;
+	const uint8_t *meta_2;
+	struct nybl_ptr meta_3;
+
+	/* Array of bitmaps for the current chunk */
+	struct zbm_bmap bitmaps[ZBM_BITMAP_COUNT];
+};
+
+static int zbm_check_magic(struct zbm_state *state)
+{
+	if (state->src_left < ZBM_MAGIC_SZ)
+		return -EINVAL;
+
+	if (memcmp(state->src, ZBM_MAGIC, ZBM_MAGIC_SZ))
+		return -EINVAL;
+
+	state->src += ZBM_MAGIC_SZ;
+	state->src_left -= ZBM_MAGIC_SZ;
+	return 0;
+}
+
+static uint32_t zbm_u24_to_u32(struct uint24 n)
+{
+	uint32_t res;
+
+	res = n.hig;
+	res <<= 8;
+	res += n.mid;
+	res <<= 8;
+	res += n.low;
+	return res;
+}
+
+/* Some chunks just have regular uncompressed data, but with a header */
+static int zbm_chunk_is_uncompressed(struct zbm_state *state)
+{
+	return state->len == state->decmp_len + sizeof(struct zbm_chunk_hdr);
+}
+
+static int zbm_handle_uncompressed_chunk(struct zbm_state *state)
+{
+	state->meta_1 = state->meta_2 = NULL;
+	state->meta_3.addr = NULL;
+	state->meta_3.nibble = 0;
+	state->data = state->src + sizeof(struct zbm_chunk_hdr);
+	memcpy(state->dest, state->data, state->decmp_len);
+
+	state->dest += state->decmp_len;
+	state->dest_left -= state->decmp_len;
+	state->written = state->decmp_len;
+	return 0;
+}
+
+static int zbm_read_nibble(struct nybl_ptr *nybl, const uint8_t *limit,
+			   uint8_t *result)
+{
+	if (nybl->addr >= limit)
+		return -EINVAL;
+
+	if (nybl->nibble == 0) {
+		*result = *nybl->addr & 0xf;
+		nybl->nibble = 1;
+	} else {
+		*result = (*nybl->addr >> 4) & 0xf;
+		nybl->nibble = 0;
+		++nybl->addr;
+	}
+	return 0;
+}
+
+static void zbm_rewind_nibble(struct nybl_ptr *nybl)
+{
+	if (nybl->nibble == 0) {
+		nybl->nibble = 1;
+		--nybl->addr;
+	} else {
+		nybl->nibble = 0;
+	}
+}
+
+static int zbm_apply_bitmap(struct zbm_state *state, struct zbm_bmap *bitmap)
+{
+	int i;
+
+	/* The periods are stored in the first metadata area */
+	if (bitmap->period_bytecnt) {
+		state->period = 0;
+		for (i = 0; i < bitmap->period_bytecnt; ++i) {
+			if (state->meta_1 >= state->src_end)
+				return -EINVAL;
+			state->period |= *state->meta_1 << i * 8;
+			++state->meta_1;
+		}
+	}
+	if (state->period == 0)
+		return -EINVAL;
+
+	for (i = 0; i < 8; ++i) {
+		if (state->written == state->decmp_len)
+			break;
+		if (bitmap->bitmap & 1 << i) {
+			if (state->data >= state->src_end)
+				return -EINVAL;
+			*state->dest = *state->data;
+			++state->data;
+		} else {
+			if (state->prewritten + state->written < state->period)
+				return -EINVAL;
+			*state->dest = *(state->dest - state->period);
+		}
+		++state->dest;
+		--state->dest_left;
+		++state->written;
+	}
+
+	return 0;
+}
+
+static int zbm_apply_bitmap_number(struct zbm_state *state, uint8_t bmp_num)
+{
+	struct zbm_bmap next = { 0 };
+
+	/* Not a valid bitmap number (it signals a repetition) */
+	if (bmp_num == 0xf)
+		return -EINVAL;
+
+	/* An actual index in the bitmap array */
+	if (bmp_num > ZBM_MAX_PERIOD_BYTECNT)
+		return zbm_apply_bitmap(
+			state, &state->bitmaps[bmp_num - ZBM_BITMAP_BASE]);
+
+	/* For < 2, use the next bitmap in the second metadata area */
+	if (state->meta_2 >= state->src_end)
+		return -EINVAL;
+	next.bitmap = *state->meta_2;
+	next.period_bytecnt = bmp_num;
+	++state->meta_2;
+	return zbm_apply_bitmap(state, &next);
+}
+
+/* Find out how many times we need to repeat the current bitmap operation */
+static int zbm_read_repetition_count(struct zbm_state *state, uint16_t *repeat)
+{
+	uint8_t nibble;
+	uint16_t total;
+	int err;
+
+	/* Don't confuse the trailing bitmaps with a repetition count */
+	if (state->decmp_len - state->written <= 8) {
+		*repeat = 1;
+		return 0;
+	}
+
+	err = zbm_read_nibble(&state->meta_3, state->src_end, &nibble);
+	if (err)
+		return err;
+
+	if (nibble != 0xf) {
+		/* No repetition count: the previous bitmap number gets applied once */
+		zbm_rewind_nibble(&state->meta_3);
+		*repeat = 1;
+		return 0;
+	}
+
+	/*
+     * Under this scheme, repeating a bitmap number 3 times wouldn't save any
+     * space, so the repetition count starts from 4.
+     */
+	total = 4;
+	while (nibble == 0xf) {
+		err = zbm_read_nibble(&state->meta_3, state->src_end, &nibble);
+		if (err)
+			return err;
+		total += nibble;
+		if (total < nibble)
+			return -EINVAL;
+	}
+
+	*repeat = total;
+	return 0;
+}
+
+static int zbm_decompress_single_bitmap(struct zbm_state *state)
+{
+	uint8_t bmp_num;
+	uint16_t repeat;
+	int i;
+	int err;
+
+	/* The current nibble is the offset of the next bitmap to apply */
+	err = zbm_read_nibble(&state->meta_3, state->src_end, &bmp_num);
+	if (err)
+		return err;
+
+	err = zbm_read_repetition_count(state, &repeat);
+	if (err)
+		return err;
+
+	for (i = 0; i < repeat; ++i) {
+		err = zbm_apply_bitmap_number(state, bmp_num);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
+/* Pointer to a bit */
+struct bit_ptr {
+	uint8_t *addr; /* Address of the byte */
+	int offset; /* Bit number */
+};
+
+/* This function does not perform boundary checks, the caller must do it */
+static int zbm_read_single_bit(struct bit_ptr *bit)
+{
+	int res = *bit->addr >> bit->offset & 1;
+
+	++bit->offset;
+	if (bit->offset != 8)
+		return res;
+	bit->offset = 0;
+	++bit->addr;
+	return res;
+}
+
+static int zbm_read_single_bitmap(struct bit_ptr *bit, const uint8_t *limit,
+				  struct zbm_bmap *result)
+{
+	int i;
+
+	result->bitmap = 0;
+	result->period_bytecnt = 0;
+
+	/* The bitmap itself */
+	for (i = 0; i < 8; ++i) {
+		if (bit->addr >= limit)
+			return -EINVAL;
+		result->bitmap |= zbm_read_single_bit(bit) << i;
+	}
+
+	/*
+     * The two trailing bits tell us how many bytes to read for the next
+     * repetition period
+     */
+	for (i = 0; i < 2; ++i) {
+		if (bit->addr >= limit)
+			return -EINVAL;
+		result->period_bytecnt |= zbm_read_single_bit(bit) << i;
+	}
+
+	return 0;
+}
+
+static int zbm_read_bitmaps(struct zbm_state *state)
+{
+	struct bit_ptr bmap = { 0 };
+	int err, i;
+
+	if (state->len < ZBM_BITMAP_BYTECNT)
+		return -EINVAL;
+
+	bmap.addr = (uint8_t *)state->src_end - ZBM_BITMAP_BYTECNT;
+	bmap.offset = 0;
+
+	for (i = 0; i < ZBM_BITMAP_COUNT; ++i) {
+		err = zbm_read_single_bitmap(&bmap, state->src_end,
+					     &state->bitmaps[i]);
+		if (err)
+			return err;
+		if (state->bitmaps[i].period_bytecnt > ZBM_MAX_PERIOD_BYTECNT)
+			return -EINVAL;
+	}
+	return 0;
+}
+
+static int zbm_handle_compressed_chunk(struct zbm_state *state)
+{
+	const struct zbm_cmp_chunk_hdr *hdr = NULL;
+	uint32_t meta_off_1, meta_off_2, meta_off_3;
+	int err;
+
+	state->written = 0;
+	state->period = 8;
+
+	if (state->len < sizeof(*hdr))
+		return -EINVAL;
+	hdr = (struct zbm_cmp_chunk_hdr *)state->src;
+	state->data = state->src + sizeof(*hdr);
+
+	meta_off_1 = zbm_u24_to_u32(hdr->meta_off_1);
+	meta_off_2 = zbm_u24_to_u32(hdr->meta_off_2);
+	meta_off_3 = zbm_u24_to_u32(hdr->meta_off_3);
+	if (meta_off_1 >= state->len || meta_off_2 >= state->len ||
+	    meta_off_3 >= state->len)
+		return -EINVAL;
+	state->meta_1 = state->src + meta_off_1;
+	state->meta_2 = state->src + meta_off_2;
+	state->meta_3.addr = (uint8_t *)state->src + meta_off_3;
+	state->meta_3.nibble = 0;
+
+	err = zbm_read_bitmaps(state);
+	if (err)
+		return err;
+
+	while (state->written < state->decmp_len) {
+		err = zbm_decompress_single_bitmap(state);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int zbm_handle_chunk(struct zbm_state *state)
+{
+	const struct zbm_chunk_hdr *decmp_hdr = NULL;
+
+	if (state->src_left < sizeof(*decmp_hdr))
+		return -EINVAL;
+	decmp_hdr = (struct zbm_chunk_hdr *)state->src;
+
+	state->len = zbm_u24_to_u32(decmp_hdr->len);
+	if (state->len > state->src_left)
+		return -EINVAL;
+	state->src_end = state->src + state->len;
+
+	state->decmp_len = zbm_u24_to_u32(decmp_hdr->decmp_len);
+	if (state->decmp_len > ZBM_MAX_DECMP_CHUNK_SIZE)
+		return -EINVAL;
+	if (!state->dest) /* We just wanted the length, so we are done */
+		return 0;
+	if (state->decmp_len > state->dest_left)
+		return -ERANGE;
+
+	if (zbm_chunk_is_uncompressed(state))
+		return zbm_handle_uncompressed_chunk(state);
+
+	return zbm_handle_compressed_chunk(state);
+}
+
+int zbm_decompress(void *dest, size_t dest_size, const void *src,
+		   size_t src_size, size_t *out_len)
+{
+	struct zbm_state state = { 0 };
+	int err;
+
+	state.src = src;
+	state.src_left = src_size;
+	state.dest = dest;
+	state.dest_left = dest_size;
+	state.prewritten = 0;
+
+	err = zbm_check_magic(&state);
+	if (err)
+		return err;
+
+	/* The final chunk has zero decompressed length */
+	do {
+		err = zbm_handle_chunk(&state);
+		if (err)
+			return err;
+		state.src += state.len;
+		state.src_left -= state.len;
+		state.prewritten += state.decmp_len;
+	} while (state.decmp_len != 0);
+
+	*out_len = state.prewritten;
+	return 0;
+}
diff --git a/drivers/staging/apfs/libzbitmap.h b/drivers/staging/apfs/libzbitmap.h
new file mode 100644
index 0000000000000000000000000000000000000000..3b5ac4d828ad5dddc6fbcf32a99ade19ae06046f
--- /dev/null
+++ b/drivers/staging/apfs/libzbitmap.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
+/*
+ * Copyright (c) 2022 Corellium LLC
+ *
+ * Author: Ernesto A. Fernández <ernesto@corellium.com>
+ *
+ * Ported from libzbitmap (https://github.com/eafer/libzbitmap). Only the
+ * decompression code is included.
+ */
+
+#ifndef _LIBZBITMAP_H
+#define _LIBZBITMAP_H
+
+#include <linux/errno.h>
+#include <linux/types.h>
+
+/**
+ * zbm_decompress - Decompress an LZBITMAP buffer
+ * @dest:       destination buffer (may be NULL)
+ * @dest_size:  size of the destination buffer
+ * @src:        source buffer
+ * @src_size:   size of the source buffer
+ * @out_len:    on return, the length of the decompressed output
+ *
+ * May be called with a NULL destination buffer to retrieve the expected length
+ * of the decompressed data. Returns 0 on success, or a negative error code in
+ * case of failure.
+ */
+int zbm_decompress(void *dest, size_t dest_size, const void *src,
+		   size_t src_size, size_t *out_len);
+
+#endif /* _LIBZBITMAP_H */

-- 
2.48.1


