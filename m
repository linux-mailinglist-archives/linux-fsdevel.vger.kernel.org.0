Return-Path: <linux-fsdevel+bounces-44492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F07A69D22
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 01:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63BEF188B877
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 00:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E053594E;
	Thu, 20 Mar 2025 00:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="EnnK+nTV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E1DF9EC;
	Thu, 20 Mar 2025 00:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742429660; cv=none; b=r/0cYwudOf5PQYEanYX/H1X4pD05KgrGB4ghCDADeA4gy32buTnYEOFG6P+GtrzXF7QOScb0y9VkYY4yRT75DMnURnEjMqd2la2haDZ6pq7STey3VZn280TaLH5KRgxNaa/e+B5R/aWUiL9iiOc2LP4/qXB3WRZdRqDlzmQvwGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742429660; c=relaxed/simple;
	bh=IQD/WkOJfc5phCetAzkaKwIj97ZUOvgtO49R9uNWzf0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ScnYSJ2XDc5ObzG7gs5FsE95LsGHTfbVMU/ey/KxucPX9zDbs+CTSpM6xq/E/AwvplEbIL1dotuNrSmzB5O6n8F46E7Co1ZX4RseDQy3sIMqQXaFASUD4l4iM7SzRLJ5N+uBWKJoDF1WNmokIMbB8NfKgc9OQ5jWh3jWtvdaur4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=EnnK+nTV; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZJ5fM4J44z9slw;
	Thu, 20 Mar 2025 01:14:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1742429643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P3h7+jgJMu97p1y++7Pr4Z96jEu5zW6d8IrvdDcOQ48=;
	b=EnnK+nTV29CTbvJnR1HGIFzfaw6bMUew0a8B1m+jRXjzTLCmfTD26gRcJ/jK7KWYqVWgtr
	Pb0NlqjucI96tshFOON9I89J8CE3tO832ZezLHO3Wpw1GTwox8HuaH5stPH+ypm34KXNfi
	iudn5+GIHslAj5H29EuOMRJXY0XICFs5nNQuvyfmws6vvt6WZuPyX6yQ27u68qip6SSBC4
	1mOpN0GDaEjCvGbVW2VO5OrJwcfJTnYbFQM5neyilkeNgzUFIyXbA6nuD+K6PjtEPuE9hK
	jvZf0KVHyMsUJxQ/vfALZu9j0qsm352pfUWFVtnwZTon4stc2i7IMnAFKehQ/g==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Wed, 19 Mar 2025 20:13:50 -0400
Subject: [PATCH RFC v2 1/8] staging: apfs: init lzfse compression library
 for APFS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-apfs-v2-1-475de2e25782@ethancedwards.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=127447;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=IQD/WkOJfc5phCetAzkaKwIj97ZUOvgtO49R9uNWzf0=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeHBOK08zYTlTWFgvMnhicGR3WTNIM0pkOXJPcXVDTmJ0CmtMdHlJN3RQOGNNZWwzZGRa
 a29kcFN3TVlsd01zbUtLTFA5emxOTWVhczVRMlBuWHBRbG1EaXNUeUJBR0xrNEIKdUlnZ0kwTnJ
 nOXlHNlZkNWlpUS9DOXQ2SFpOVHU2SDhVK3p4aDdtdXkrS215MXA2M3cxbitDdVcxbEJXczVqLw
 pWUHlOR2V0MEp5ZDZoYmg5WENOMDAzR2lXNXJjak9UK2pXd0EwTEZMenc9PQo9ZkZIZAotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE

This library was originally developed by Apple and is BSD3 licensed. It
allows for the reading and writing of LZFSE and LZVN compressed files
on APFS filesystems. Encode functionality is not included as the
filesystem implementation does not yet support it but could be easily
added later if needed.

Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
 drivers/staging/apfs/lzfse/lzfse.h               |  86 +++
 drivers/staging/apfs/lzfse/lzfse_decode.c        |  66 +++
 drivers/staging/apfs/lzfse/lzfse_decode_base.c   | 725 +++++++++++++++++++++++
 drivers/staging/apfs/lzfse/lzfse_encode_tables.h | 224 +++++++
 drivers/staging/apfs/lzfse/lzfse_fse.c           | 214 +++++++
 drivers/staging/apfs/lzfse/lzfse_fse.h           | 632 ++++++++++++++++++++
 drivers/staging/apfs/lzfse/lzfse_internal.h      | 599 +++++++++++++++++++
 drivers/staging/apfs/lzfse/lzfse_tunables.h      |  50 ++
 drivers/staging/apfs/lzfse/lzvn_decode_base.c    | 721 ++++++++++++++++++++++
 drivers/staging/apfs/lzfse/lzvn_decode_base.h    |  53 ++
 drivers/staging/apfs/lzfse/lzvn_encode_base.h    | 105 ++++
 11 files changed, 3475 insertions(+)

diff --git a/drivers/staging/apfs/lzfse/lzfse.h b/drivers/staging/apfs/lzfse/lzfse.h
new file mode 100644
index 0000000000000000000000000000000000000000..573c85b8c9a476291cd8ef89833ae13caf5eaeb6
--- /dev/null
+++ b/drivers/staging/apfs/lzfse/lzfse.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+/*
+ * Copyright (c) 2015-2016, Apple Inc. All rights reserved.
+ *
+ */
+
+#ifndef LZFSE_H
+#define LZFSE_H
+
+#include <linux/stddef.h>
+#include <linux/types.h>
+
+/*! @abstract Get the required scratch buffer size to compress using LZFSE.   */
+size_t lzfse_encode_scratch_size(void);
+
+/*! @abstract Compress a buffer using LZFSE.
+ *
+ *  @param dst_buffer
+ *  Pointer to the first byte of the destination buffer.
+ *
+ *  @param dst_size
+ *  Size of the destination buffer in bytes.
+ *
+ *  @param src_buffer
+ *  Pointer to the first byte of the source buffer.
+ *
+ *  @param src_size
+ *  Size of the source buffer in bytes.
+ *
+ *  @param scratch_buffer
+ *  If non-NULL, a pointer to scratch space for the routine to use as workspace;
+ *  the routine may use up to lzfse_encode_scratch_size( ) bytes of workspace
+ *  during its operation, and will not perform any internal allocations. If
+ *  NULL, the routine may allocate its own memory to use during operation via
+ *  a single call to malloc( ), and will release it by calling free( ) prior
+ *  to returning. For most use, passing NULL is perfectly satisfactory, but if
+ *  you require strict control over allocation, you will want to pass an
+ *  explicit scratch buffer.
+ *
+ *  @return
+ *  The number of bytes written to the destination buffer if the input is
+ *  successfully compressed. If the input cannot be compressed to fit into
+ *  the provided buffer, or an error occurs, zero is returned, and the
+ *  contents of dst_buffer are unspecified.                                   */
+size_t lzfse_encode_buffer(uint8_t *__restrict dst_buffer, size_t dst_size,
+			   const uint8_t *__restrict src_buffer,
+			   size_t src_size, void *__restrict scratch_buffer);
+
+/*! @abstract Get the required scratch buffer size to decompress using LZFSE. */
+size_t lzfse_decode_scratch_size(void);
+
+/*! @abstract Decompress a buffer using LZFSE.
+ *
+ *  @param dst_buffer
+ *  Pointer to the first byte of the destination buffer.
+ *
+ *  @param dst_size
+ *  Size of the destination buffer in bytes.
+ *
+ *  @param src_buffer
+ *  Pointer to the first byte of the source buffer.
+ *
+ *  @param src_size
+ *  Size of the source buffer in bytes.
+ *
+ *  @param scratch_buffer
+ *  If non-NULL, a pointer to scratch space for the routine to use as workspace;
+ *  the routine may use up to lzfse_decode_scratch_size( ) bytes of workspace
+ *  during its operation, and will not perform any internal allocations. If
+ *  NULL, the routine may allocate its own memory to use during operation via
+ *  a single call to malloc( ), and will release it by calling free( ) prior
+ *  to returning. For most use, passing NULL is perfectly satisfactory, but if
+ *  you require strict control over allocation, you will want to pass an
+ *  explicit scratch buffer.
+ *
+ *  @return
+ *  The number of bytes written to the destination buffer if the input is
+ *  successfully decompressed. If there is not enough space in the destination
+ *  buffer to hold the entire expanded output, only the first dst_size bytes
+ *  will be written to the buffer and dst_size is returned. Note that this
+ *  behavior differs from that of lzfse_encode_buffer.                        */
+size_t lzfse_decode_buffer(uint8_t *__restrict dst_buffer, size_t dst_size,
+			   const uint8_t *__restrict src_buffer,
+			   size_t src_size, void *__restrict scratch_buffer);
+
+#endif /* LZFSE_H */
diff --git a/drivers/staging/apfs/lzfse/lzfse_decode.c b/drivers/staging/apfs/lzfse/lzfse_decode.c
new file mode 100644
index 0000000000000000000000000000000000000000..ef7d3487343af5387a9a5dacc8ed95212ec641c0
--- /dev/null
+++ b/drivers/staging/apfs/lzfse/lzfse_decode.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2015-2016, Apple Inc. All rights reserved.
+ *
+ */
+
+/*  LZFSE decode API
+ */
+
+#include <linux/slab.h>
+#include "lzfse.h"
+#include "lzfse_internal.h"
+
+size_t lzfse_decode_scratch_size(void)
+{
+	return sizeof(lzfse_decoder_state);
+}
+
+static size_t lzfse_decode_buffer_with_scratch(
+	uint8_t *__restrict dst_buffer, size_t dst_size,
+	const uint8_t *__restrict src_buffer, size_t src_size,
+	void *__restrict scratch_buffer)
+{
+	int status;
+	lzfse_decoder_state *s = (lzfse_decoder_state *)scratch_buffer;
+	memset(s, 0x00, sizeof(*s));
+
+	// Initialize state
+	s->src = src_buffer;
+	s->src_begin = src_buffer;
+	s->src_end = s->src + src_size;
+	s->dst = dst_buffer;
+	s->dst_begin = dst_buffer;
+	s->dst_end = dst_buffer + dst_size;
+
+	// Decode
+	status = lzfse_decode(s);
+	if (status == LZFSE_STATUS_DST_FULL)
+		return dst_size;
+	if (status != LZFSE_STATUS_OK)
+		return 0; // failed
+	return (size_t)(s->dst - dst_buffer); // bytes written
+}
+
+size_t lzfse_decode_buffer(uint8_t *__restrict dst_buffer, size_t dst_size,
+			   const uint8_t *__restrict src_buffer,
+			   size_t src_size, void *__restrict scratch_buffer)
+{
+	int has_malloc = 0;
+	size_t ret = 0;
+
+	// Deal with the possible NULL pointer
+	if (scratch_buffer == NULL) {
+		// +1 in case scratch size could be zero
+		scratch_buffer =
+			kmalloc(lzfse_decode_scratch_size() + 1, GFP_KERNEL);
+		has_malloc = 1;
+	}
+	if (scratch_buffer == NULL)
+		return 0;
+	ret = lzfse_decode_buffer_with_scratch(dst_buffer, dst_size, src_buffer,
+					       src_size, scratch_buffer);
+	if (has_malloc)
+		kfree(scratch_buffer);
+	return ret;
+}
diff --git a/drivers/staging/apfs/lzfse/lzfse_decode_base.c b/drivers/staging/apfs/lzfse/lzfse_decode_base.c
new file mode 100644
index 0000000000000000000000000000000000000000..5fb9e374b40e7e7c11a27e2e3baf79886b3f0474
--- /dev/null
+++ b/drivers/staging/apfs/lzfse/lzfse_decode_base.c
@@ -0,0 +1,725 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2015-2016, Apple Inc. All rights reserved.
+ *
+ */
+
+#include "lzfse_internal.h"
+#include "lzvn_decode_base.h"
+
+/*! @abstract Decode an entry value from next bits of stream.
+ *  Return \p value, and set \p *nbits to the number of bits to consume
+ *  (starting with LSB). */
+static inline int lzfse_decode_v1_freq_value(uint32_t bits, int *nbits)
+{
+	static const int8_t lzfse_freq_nbits_table[32] = {
+		2, 3, 2, 5, 2, 3, 2, 8, 2, 3, 2, 5, 2, 3, 2, 14,
+		2, 3, 2, 5, 2, 3, 2, 8, 2, 3, 2, 5, 2, 3, 2, 14
+	};
+	static const int8_t lzfse_freq_value_table[32] = {
+		0, 2, 1, 4, 0, 3, 1, -1, 0, 2, 1, 5, 0, 3, 1, -1,
+		0, 2, 1, 6, 0, 3, 1, -1, 0, 2, 1, 7, 0, 3, 1, -1
+	};
+
+	uint32_t b = bits & 31; // lower 5 bits
+	int n = lzfse_freq_nbits_table[b];
+	*nbits = n;
+
+	// Special cases for > 5 bits encoding
+	if (n == 8)
+		return 8 + ((bits >> 4) & 0xf);
+	if (n == 14)
+		return 24 + ((bits >> 4) & 0x3ff);
+
+	// <= 5 bits encoding from table
+	return lzfse_freq_value_table[b];
+}
+
+/*! @abstract Extracts up to 32 bits from a 64-bit field beginning at
+ *  \p offset, and zero-extends them to a \p uint32_t.
+ *
+ *  If we number the bits of \p v from 0 (least significant) to 63 (most
+ *  significant), the result is bits \p offset to \p offset+nbits-1. */
+static inline uint32_t get_field(uint64_t v, int offset, int nbits)
+{
+	if (nbits == 32)
+		return (uint32_t)(v >> offset);
+	return (uint32_t)((v >> offset) & ((1 << nbits) - 1));
+}
+
+/*! @abstract Return \c header_size field from a \c lzfse_compressed_block_header_v2. */
+static inline uint32_t
+lzfse_decode_v2_header_size(const lzfse_compressed_block_header_v2 *in)
+{
+	return get_field(in->packed_fields[2], 0, 32);
+}
+
+/*! @abstract Decode all fields from a \c lzfse_compressed_block_header_v2 to a
+ * \c lzfse_compressed_block_header_v1.
+ * @return 0 on success.
+ * @return -1 on failure. */
+static inline int lzfse_decode_v1(lzfse_compressed_block_header_v1 *out,
+				  const lzfse_compressed_block_header_v2 *in)
+{
+	uint64_t v0;
+	uint64_t v1;
+	uint64_t v2;
+	uint16_t *dst = NULL;
+	const uint8_t *src = NULL;
+	const uint8_t *src_end = NULL;
+	uint32_t accum = 0;
+	int accum_nbits = 0;
+	int nbits = 0;
+	int i;
+
+	// Clear all fields
+	memset(out, 0x00, sizeof(lzfse_compressed_block_header_v1));
+
+	v0 = in->packed_fields[0];
+	v1 = in->packed_fields[1];
+	v2 = in->packed_fields[2];
+
+	out->magic = LZFSE_COMPRESSEDV1_BLOCK_MAGIC;
+	out->n_raw_bytes = in->n_raw_bytes;
+
+	// Literal state
+	out->n_literals = get_field(v0, 0, 20);
+	out->n_literal_payload_bytes = get_field(v0, 20, 20);
+	out->literal_bits = (int)get_field(v0, 60, 3) - 7;
+	out->literal_state[0] = get_field(v1, 0, 10);
+	out->literal_state[1] = get_field(v1, 10, 10);
+	out->literal_state[2] = get_field(v1, 20, 10);
+	out->literal_state[3] = get_field(v1, 30, 10);
+
+	// L,M,D state
+	out->n_matches = get_field(v0, 40, 20);
+	out->n_lmd_payload_bytes = get_field(v1, 40, 20);
+	out->lmd_bits = (int)get_field(v1, 60, 3) - 7;
+	out->l_state = get_field(v2, 32, 10);
+	out->m_state = get_field(v2, 42, 10);
+	out->d_state = get_field(v2, 52, 10);
+
+	// Total payload size
+	out->n_payload_bytes =
+		out->n_literal_payload_bytes + out->n_lmd_payload_bytes;
+
+	// Freq tables
+	dst = &(out->l_freq[0]);
+	src = &(in->freq[0]);
+	src_end = (const uint8_t *)in +
+		  get_field(v2, 0, 32); // first byte after header
+	accum = 0;
+	accum_nbits = 0;
+
+	// No freq tables?
+	if (src_end == src)
+		return 0; // OK, freq tables were omitted
+
+	for (i = 0;
+	     i < LZFSE_ENCODE_L_SYMBOLS + LZFSE_ENCODE_M_SYMBOLS +
+			 LZFSE_ENCODE_D_SYMBOLS + LZFSE_ENCODE_LITERAL_SYMBOLS;
+	     i++) {
+		// Refill accum, one byte at a time, until we reach end of header, or accum
+		// is full
+		while (src < src_end && accum_nbits + 8 <= 32) {
+			accum |= (uint32_t)(*src) << accum_nbits;
+			accum_nbits += 8;
+			src++;
+		}
+
+		// Decode and store value
+		nbits = 0;
+		dst[i] = lzfse_decode_v1_freq_value(accum, &nbits);
+
+		if (nbits > accum_nbits)
+			return -1; // failed
+
+		// Consume nbits bits
+		accum >>= nbits;
+		accum_nbits -= nbits;
+	}
+
+	if (accum_nbits >= 8 || src != src_end)
+		return -1; // we need to end up exactly at the end of header, with less than
+			// 8 bits in accumulator
+
+	return 0;
+}
+
+static inline void copy(uint8_t *dst, const uint8_t *src, size_t length)
+{
+	const uint8_t *dst_end = dst + length;
+	do {
+		copy8(dst, src);
+		dst += 8;
+		src += 8;
+	} while (dst < dst_end);
+}
+
+static int lzfse_decode_lmd(lzfse_decoder_state *s)
+{
+	lzfse_compressed_block_decoder_state *bs =
+		&(s->compressed_lzfse_block_state);
+	fse_state l_state = bs->l_state;
+	fse_state m_state = bs->m_state;
+	fse_state d_state = bs->d_state;
+	fse_in_stream in = bs->lmd_in_stream;
+	const uint8_t *src_start = s->src_begin;
+	const uint8_t *src = s->src + bs->lmd_in_buf;
+	const uint8_t *lit = bs->current_literal;
+	uint8_t *dst = s->dst;
+	uint32_t symbols = bs->n_matches;
+	int32_t L = bs->l_value;
+	int32_t M = bs->m_value;
+	int32_t D = bs->d_value;
+	int32_t new_d;
+
+	//  Number of bytes remaining in the destination buffer, minus 32 to
+	//  provide a margin of safety for using overlarge copies on the fast path.
+	//  This is a signed quantity, and may go negative when we are close to the
+	//  end of the buffer.  That's OK; we're careful about how we handle it
+	//  in the slow-and-careful match execution path.
+	ptrdiff_t remaining_bytes = s->dst_end - dst - 32;
+
+	//  If L or M is non-zero, that means that we have already started decoding
+	//  this block, and that we needed to interrupt decoding to get more space
+	//  from the caller.  There's a pending L, M, D triplet that we weren't
+	//  able to completely process.  Jump ahead to finish executing that symbol
+	//  before decoding new values.
+	if (L || M)
+		goto ExecuteMatch;
+
+	while (symbols > 0) {
+		int res;
+		//  Decode the next L, M, D symbol from the input stream.
+		res = fse_in_flush(&in, &src, src_start);
+		if (res) {
+			return LZFSE_STATUS_ERROR;
+		}
+		L = fse_value_decode(&l_state, bs->l_decoder, &in);
+		if ((lit + L) >=
+		    (bs->literals + LZFSE_LITERALS_PER_BLOCK + 64)) {
+			return LZFSE_STATUS_ERROR;
+		}
+		res = fse_in_flush2(&in, &src, src_start);
+		if (res) {
+			return LZFSE_STATUS_ERROR;
+		}
+		M = fse_value_decode(&m_state, bs->m_decoder, &in);
+		res = fse_in_flush2(&in, &src, src_start);
+		if (res) {
+			return LZFSE_STATUS_ERROR;
+		}
+		new_d = fse_value_decode(&d_state, bs->d_decoder, &in);
+		D = new_d ? new_d : D;
+		symbols--;
+
+ExecuteMatch:
+		//  Error if D is out of range, so that we avoid passing through
+		//  uninitialized data or accesssing memory out of the destination
+		//  buffer.
+		if ((uint32_t)D > dst + L - s->dst_begin)
+			return LZFSE_STATUS_ERROR;
+
+		if (L + M <= remaining_bytes) {
+			size_t i;
+			//  If we have plenty of space remaining, we can copy the literal
+			//  and match with 16- and 32-byte operations, without worrying
+			//  about writing off the end of the buffer.
+			remaining_bytes -= L + M;
+			copy(dst, lit, L);
+			dst += L;
+			lit += L;
+			//  For the match, we have two paths; a fast copy by 16-bytes if
+			//  the match distance is large enough to allow it, and a more
+			//  careful path that applies a permutation to account for the
+			//  possible overlap between source and destination if the distance
+			//  is small.
+			if (D >= 8 || D >= M)
+				copy(dst, dst - D, M);
+			else
+				for (i = 0; i < M; i++)
+					dst[i] = dst[i - D];
+			dst += M;
+		}
+
+		else {
+			//  Otherwise, we are very close to the end of the destination
+			//  buffer, so we cannot use wide copies that slop off the end
+			//  of the region that we are copying to. First, we restore
+			//  the true length remaining, rather than the sham value we've
+			//  been using so far.
+			remaining_bytes += 32;
+			//  Now, we process the literal. Either there's space for it
+			//  or there isn't; if there is, we copy the whole thing and
+			//  update all the pointers and lengths to reflect the copy.
+			if (L <= remaining_bytes) {
+				size_t i;
+				for (i = 0; i < L; i++)
+					dst[i] = lit[i];
+				dst += L;
+				lit += L;
+				remaining_bytes -= L;
+				L = 0;
+			}
+			//  There isn't enough space to fit the whole literal. Copy as
+			//  much of it as we can, update the pointers and the value of
+			//  L, and report that the destination buffer is full. Note that
+			//  we always write right up to the end of the destination buffer.
+			else {
+				size_t i;
+				for (i = 0; i < remaining_bytes; i++)
+					dst[i] = lit[i];
+				dst += remaining_bytes;
+				lit += remaining_bytes;
+				L -= remaining_bytes;
+				goto DestinationBufferIsFull;
+			}
+			//  The match goes just like the literal does. We copy as much as
+			//  we can byte-by-byte, and if we reach the end of the buffer
+			//  before finishing, we return to the caller indicating that
+			//  the buffer is full.
+			if (M <= remaining_bytes) {
+				size_t i;
+				for (i = 0; i < M; i++)
+					dst[i] = dst[i - D];
+				dst += M;
+				remaining_bytes -= M;
+				M = 0;
+				(void)M; // no dead store warning
+					//  We don't need to update M = 0, because there's no partial
+					//  symbol to continue executing. Either we're at the end of
+					//  the block, in which case we will never need to resume with
+					//  this state, or we're going to decode another L, M, D set,
+					//  which will overwrite M anyway.
+					//
+					// But we still set M = 0, to maintain the post-condition.
+			} else {
+				size_t i;
+				for (i = 0; i < remaining_bytes; i++)
+					dst[i] = dst[i - D];
+				dst += remaining_bytes;
+				M -= remaining_bytes;
+DestinationBufferIsFull:
+				//  Because we want to be able to resume decoding where we've left
+				//  off (even in the middle of a literal or match), we need to
+				//  update all of the block state fields with the current values
+				//  so that we can resume execution from this point once the
+				//  caller has given us more space to write into.
+				bs->l_value = L;
+				bs->m_value = M;
+				bs->d_value = D;
+				bs->l_state = l_state;
+				bs->m_state = m_state;
+				bs->d_state = d_state;
+				bs->lmd_in_stream = in;
+				bs->n_matches = symbols;
+				bs->lmd_in_buf = (uint32_t)(src - s->src);
+				bs->current_literal = lit;
+				s->dst = dst;
+				return LZFSE_STATUS_DST_FULL;
+			}
+			//  Restore the "sham" decremented value of remaining_bytes and
+			//  continue to the next L, M, D triple. We'll just be back in
+			//  the careful path again, but this only happens at the very end
+			//  of the buffer, so a little minor inefficiency here is a good
+			//  tradeoff for simpler code.
+			remaining_bytes -= 32;
+		}
+	}
+	//  Because we've finished with the whole block, we don't need to update
+	//  any of the blockstate fields; they will not be used again. We just
+	//  update the destination pointer in the state object and return.
+	s->dst = dst;
+	return LZFSE_STATUS_OK;
+}
+
+int lzfse_decode(lzfse_decoder_state *s)
+{
+	while (1) {
+		// Are we inside a block?
+		switch (s->block_magic) {
+		case LZFSE_NO_BLOCK_MAGIC: {
+			uint32_t magic;
+			// We need at least 4 bytes of magic number to identify next block
+			if (s->src + 4 > s->src_end)
+				return LZFSE_STATUS_SRC_EMPTY; // SRC truncated
+			magic = load4(s->src);
+
+			if (magic == LZFSE_ENDOFSTREAM_BLOCK_MAGIC) {
+				s->src += 4;
+				s->end_of_stream = 1;
+				return LZFSE_STATUS_OK; // done
+			}
+
+			if (magic == LZFSE_UNCOMPRESSED_BLOCK_MAGIC) {
+				uncompressed_block_decoder_state *bs = NULL;
+				if (s->src + sizeof(uncompressed_block_header) >
+				    s->src_end)
+					return LZFSE_STATUS_SRC_EMPTY; // SRC truncated
+				// Setup state for uncompressed block
+				bs = &(s->uncompressed_block_state);
+				bs->n_raw_bytes = load4(
+					s->src +
+					offsetof(uncompressed_block_header,
+						 n_raw_bytes));
+				s->src += sizeof(uncompressed_block_header);
+				s->block_magic = magic;
+				break;
+			}
+
+			if (magic == LZFSE_COMPRESSEDLZVN_BLOCK_MAGIC) {
+				lzvn_compressed_block_decoder_state *bs = NULL;
+				if (s->src +
+					    sizeof(lzvn_compressed_block_header) >
+				    s->src_end)
+					return LZFSE_STATUS_SRC_EMPTY; // SRC truncated
+				// Setup state for compressed LZVN block
+				bs = &(s->compressed_lzvn_block_state);
+				bs->n_raw_bytes = load4(
+					s->src +
+					offsetof(lzvn_compressed_block_header,
+						 n_raw_bytes));
+				bs->n_payload_bytes = load4(
+					s->src +
+					offsetof(lzvn_compressed_block_header,
+						 n_payload_bytes));
+				bs->d_prev = 0;
+				s->src += sizeof(lzvn_compressed_block_header);
+				s->block_magic = magic;
+				break;
+			}
+
+			if (magic == LZFSE_COMPRESSEDV1_BLOCK_MAGIC ||
+			    magic == LZFSE_COMPRESSEDV2_BLOCK_MAGIC) {
+				lzfse_compressed_block_header_v1 header1;
+				size_t header_size = 0;
+				lzfse_compressed_block_decoder_state *bs = NULL;
+
+				// Decode compressed headers
+				if (magic == LZFSE_COMPRESSEDV2_BLOCK_MAGIC) {
+					const lzfse_compressed_block_header_v2
+						*header2;
+					int decodeStatus;
+					// Check we have the fixed part of the structure
+					if (s->src +
+						    offsetof(
+							    lzfse_compressed_block_header_v2,
+							    freq) >
+					    s->src_end)
+						return LZFSE_STATUS_SRC_EMPTY; // SRC truncated
+
+					// Get size, and check we have the entire structure
+					header2 =
+						(const lzfse_compressed_block_header_v2
+							 *)s
+							->src; // not aligned, OK
+					header_size =
+						lzfse_decode_v2_header_size(
+							header2);
+					if (s->src + header_size > s->src_end)
+						return LZFSE_STATUS_SRC_EMPTY; // SRC truncated
+					decodeStatus = lzfse_decode_v1(&header1,
+								       header2);
+					if (decodeStatus != 0)
+						return LZFSE_STATUS_ERROR; // failed
+				} else {
+					if (s->src +
+						    sizeof(lzfse_compressed_block_header_v1) >
+					    s->src_end)
+						return LZFSE_STATUS_SRC_EMPTY; // SRC truncated
+					memcpy(&header1, s->src,
+					       sizeof(lzfse_compressed_block_header_v1));
+					header_size = sizeof(
+						lzfse_compressed_block_header_v1);
+				}
+
+				// We require the header + entire encoded block to be present in SRC
+				// during the entire block decoding.
+				// This can be relaxed somehow, if it becomes a limiting factor, at the
+				// price of a more complex state maintenance.
+				// For DST, we can't easily require space for the entire decoded block,
+				// because it may expand to something very very large.
+				if (s->src + header_size +
+					    header1.n_literal_payload_bytes +
+					    header1.n_lmd_payload_bytes >
+				    s->src_end)
+					return LZFSE_STATUS_SRC_EMPTY; // need all encoded block
+
+				// Sanity checks
+				if (lzfse_check_block_header_v1(&header1) !=
+				    0) {
+					return LZFSE_STATUS_ERROR;
+				}
+
+				// Skip header
+				s->src += header_size;
+
+				// Setup state for compressed V1 block from header
+				bs = &(s->compressed_lzfse_block_state);
+				bs->n_lmd_payload_bytes =
+					header1.n_lmd_payload_bytes;
+				bs->n_matches = header1.n_matches;
+				fse_init_decoder_table(
+					LZFSE_ENCODE_LITERAL_STATES,
+					LZFSE_ENCODE_LITERAL_SYMBOLS,
+					header1.literal_freq,
+					bs->literal_decoder);
+				fse_init_value_decoder_table(
+					LZFSE_ENCODE_L_STATES,
+					LZFSE_ENCODE_L_SYMBOLS, header1.l_freq,
+					l_extra_bits, l_base_value,
+					bs->l_decoder);
+				fse_init_value_decoder_table(
+					LZFSE_ENCODE_M_STATES,
+					LZFSE_ENCODE_M_SYMBOLS, header1.m_freq,
+					m_extra_bits, m_base_value,
+					bs->m_decoder);
+				fse_init_value_decoder_table(
+					LZFSE_ENCODE_D_STATES,
+					LZFSE_ENCODE_D_SYMBOLS, header1.d_freq,
+					d_extra_bits, d_base_value,
+					bs->d_decoder);
+
+				// Decode literals
+				{
+					fse_in_stream in;
+					const uint8_t *buf_start = s->src_begin;
+					const uint8_t *buf;
+					fse_state state0;
+					fse_state state1;
+					fse_state state2;
+					fse_state state3;
+					uint32_t i;
+
+					s->src +=
+						header1.n_literal_payload_bytes; // skip literal payload
+					buf = s->src; // read bits backwards from the end
+					if (fse_in_init(&in,
+							header1.literal_bits,
+							&buf, buf_start) != 0)
+						return LZFSE_STATUS_ERROR;
+
+					state0 = header1.literal_state[0];
+					state1 = header1.literal_state[1];
+					state2 = header1.literal_state[2];
+					state3 = header1.literal_state[3];
+
+					for (i = 0; i < header1.n_literals;
+					     i +=
+					     4) // n_literals is multiple of 4
+					{
+#if FSE_IOSTREAM_64
+						if (fse_in_flush(&in, &buf,
+								 buf_start) !=
+						    0)
+							return LZFSE_STATUS_ERROR; // [57, 64] bits
+						bs->literals[i + 0] = fse_decode(
+							&state0,
+							bs->literal_decoder,
+							&in); // 10b max
+						bs->literals[i + 1] = fse_decode(
+							&state1,
+							bs->literal_decoder,
+							&in); // 10b max
+						bs->literals[i + 2] = fse_decode(
+							&state2,
+							bs->literal_decoder,
+							&in); // 10b max
+						bs->literals[i + 3] = fse_decode(
+							&state3,
+							bs->literal_decoder,
+							&in); // 10b max
+#else
+						if (fse_in_flush(&in, &buf,
+								 buf_start) !=
+						    0)
+							return LZFSE_STATUS_ERROR; // [25, 23] bits
+						bs->literals[i + 0] = fse_decode(
+							&state0,
+							bs->literal_decoder,
+							&in); // 10b max
+						bs->literals[i + 1] = fse_decode(
+							&state1,
+							bs->literal_decoder,
+							&in); // 10b max
+						if (fse_in_flush(&in, &buf,
+								 buf_start) !=
+						    0)
+							return LZFSE_STATUS_ERROR; // [25, 23] bits
+						bs->literals[i + 2] = fse_decode(
+							&state2,
+							bs->literal_decoder,
+							&in); // 10b max
+						bs->literals[i + 3] = fse_decode(
+							&state3,
+							bs->literal_decoder,
+							&in); // 10b max
+#endif
+					}
+
+					bs->current_literal = bs->literals;
+				} // literals
+
+				// SRC is not incremented to skip the LMD payload, since we need it
+				// during block decode.
+				// We will increment SRC at the end of the block only after this point.
+
+				// Initialize the L,M,D decode stream, do not start decoding matches
+				// yet, and store decoder state
+				{
+					fse_in_stream in;
+					// read bits backwards from the end
+					const uint8_t *buf =
+						s->src +
+						header1.n_lmd_payload_bytes;
+					if (fse_in_init(&in, header1.lmd_bits,
+							&buf, s->src) != 0)
+						return LZFSE_STATUS_ERROR;
+
+					bs->l_state = header1.l_state;
+					bs->m_state = header1.m_state;
+					bs->d_state = header1.d_state;
+					bs->lmd_in_buf =
+						(uint32_t)(buf - s->src);
+					bs->l_value = bs->m_value = 0;
+					//  Initialize D to an illegal value so we can't erroneously use
+					//  an uninitialized "previous" value.
+					bs->d_value = -1;
+					bs->lmd_in_stream = in;
+				}
+
+				s->block_magic = magic;
+				break;
+			}
+
+			// Here we have an invalid magic number
+			return LZFSE_STATUS_ERROR;
+		} // LZFSE_NO_BLOCK_MAGIC
+
+		case LZFSE_UNCOMPRESSED_BLOCK_MAGIC: {
+			uncompressed_block_decoder_state *bs =
+				&(s->uncompressed_block_state);
+
+			//  Compute the size (in bytes) of the data that we will actually copy.
+			//  This size is minimum(bs->n_raw_bytes, space in src, space in dst).
+
+			uint32_t copy_size =
+				bs->n_raw_bytes; // bytes left to copy
+			size_t src_space, dst_space;
+			if (copy_size == 0) {
+				s->block_magic = 0;
+				break;
+			} // end of block
+
+			if (s->src_end <= s->src)
+				return LZFSE_STATUS_SRC_EMPTY; // need more SRC data
+			src_space = s->src_end - s->src;
+			if (copy_size > src_space)
+				copy_size = (uint32_t)
+					src_space; // limit to SRC data (> 0)
+
+			if (s->dst_end <= s->dst)
+				return LZFSE_STATUS_DST_FULL; // need more DST capacity
+			dst_space = s->dst_end - s->dst;
+			if (copy_size > dst_space)
+				copy_size = (uint32_t)
+					dst_space; // limit to DST capacity (> 0)
+
+			// Now that we know that the copy size is bounded to the source and
+			// dest buffers, go ahead and copy the data.
+			// We always have copy_size > 0 here
+			memcpy(s->dst, s->src, copy_size);
+			s->src += copy_size;
+			s->dst += copy_size;
+			bs->n_raw_bytes -= copy_size;
+
+			break;
+		} // LZFSE_UNCOMPRESSED_BLOCK_MAGIC
+
+		case LZFSE_COMPRESSEDV1_BLOCK_MAGIC:
+		case LZFSE_COMPRESSEDV2_BLOCK_MAGIC: {
+			int status;
+			lzfse_compressed_block_decoder_state *bs =
+				&(s->compressed_lzfse_block_state);
+			// Require the entire LMD payload to be in SRC
+			if (s->src_end <= s->src ||
+			    bs->n_lmd_payload_bytes >
+				    (size_t)(s->src_end - s->src))
+				return LZFSE_STATUS_SRC_EMPTY;
+
+			status = lzfse_decode_lmd(s);
+			if (status != LZFSE_STATUS_OK)
+				return status;
+
+			s->block_magic = LZFSE_NO_BLOCK_MAGIC;
+			s->src += bs->n_lmd_payload_bytes; // to next block
+			break;
+		} // LZFSE_COMPRESSEDV1_BLOCK_MAGIC || LZFSE_COMPRESSEDV2_BLOCK_MAGIC
+
+		case LZFSE_COMPRESSEDLZVN_BLOCK_MAGIC: {
+			lzvn_compressed_block_decoder_state *bs =
+				&(s->compressed_lzvn_block_state);
+			lzvn_decoder_state dstate;
+			size_t src_used, dst_used;
+			if (bs->n_payload_bytes > 0 && s->src_end <= s->src)
+				return LZFSE_STATUS_SRC_EMPTY; // need more SRC data
+
+			// Init LZVN decoder state
+			memset(&dstate, 0x00, sizeof(dstate));
+			dstate.src = s->src;
+			dstate.src_end = s->src_end;
+			if (dstate.src_end - s->src > bs->n_payload_bytes)
+				dstate.src_end =
+					s->src +
+					bs->n_payload_bytes; // limit to payload bytes
+			dstate.dst_begin = s->dst_begin;
+			dstate.dst = s->dst;
+			dstate.dst_end = s->dst_end;
+			if (dstate.dst_end - s->dst > bs->n_raw_bytes)
+				dstate.dst_end =
+					s->dst +
+					bs->n_raw_bytes; // limit to raw bytes
+			dstate.d_prev = bs->d_prev;
+			dstate.end_of_stream = 0;
+
+			// Run LZVN decoder
+			lzvn_decode(&dstate);
+
+			// Update our state
+			src_used = dstate.src - s->src;
+			dst_used = dstate.dst - s->dst;
+			if (src_used > bs->n_payload_bytes ||
+			    dst_used > bs->n_raw_bytes)
+				return LZFSE_STATUS_ERROR; // sanity check
+			s->src = dstate.src;
+			s->dst = dstate.dst;
+			bs->n_payload_bytes -= (uint32_t)src_used;
+			bs->n_raw_bytes -= (uint32_t)dst_used;
+			bs->d_prev = (uint32_t)dstate.d_prev;
+
+			// Test end of block
+			if (bs->n_payload_bytes == 0 && bs->n_raw_bytes == 0 &&
+			    dstate.end_of_stream) {
+				s->block_magic = 0;
+				break;
+			} // block done
+
+			// Check for invalid state
+			if (bs->n_payload_bytes == 0 || bs->n_raw_bytes == 0 ||
+			    dstate.end_of_stream)
+				return LZFSE_STATUS_ERROR;
+
+			// Here, block is not done and state is valid, so we need more space in dst.
+			return LZFSE_STATUS_DST_FULL;
+		}
+
+		default:
+			return LZFSE_STATUS_ERROR; // invalid magic
+
+		} // switch magic
+
+	} // block loop
+
+	return LZFSE_STATUS_OK;
+}
diff --git a/drivers/staging/apfs/lzfse/lzfse_encode_tables.h b/drivers/staging/apfs/lzfse/lzfse_encode_tables.h
new file mode 100644
index 0000000000000000000000000000000000000000..da8daac3c8be161a284ca570d60c7903c3703d75
--- /dev/null
+++ b/drivers/staging/apfs/lzfse/lzfse_encode_tables.h
@@ -0,0 +1,224 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+/*
+ * Copyright (c) 2015-2016, Apple Inc. All rights reserved.
+ *
+ */
+
+#ifndef LZFSE_ENCODE_TABLES_H
+#define LZFSE_ENCODE_TABLES_H
+
+static inline uint8_t l_base_from_value(int32_t value)
+{
+	static const uint8_t sym[LZFSE_ENCODE_MAX_L_VALUE + 1] = {
+		0,  1,	2,  3,	4,  5,	6,  7,	8,  9,	10, 11, 12, 13, 14, 15,
+		16, 16, 16, 16, 17, 17, 17, 17, 17, 17, 17, 17, 18, 18, 18, 18,
+		18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18,
+		18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19
+	};
+	return sym[value];
+}
+static inline uint8_t m_base_from_value(int32_t value)
+{
+	static const uint8_t sym[LZFSE_ENCODE_MAX_M_VALUE + 1] = {
+		0,  1,	2,  3,	4,  5,	6,  7,	8,  9,	10, 11, 12, 13, 14, 15,
+		16, 16, 16, 16, 16, 16, 16, 16, 17, 17, 17, 17, 17, 17, 17, 17,
+		17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17,
+		17, 17, 17, 17, 17, 17, 17, 17, 18, 18, 18, 18, 18, 18, 18, 18,
+		18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18,
+		18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18,
+		18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18,
+		18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18,
+		18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18,
+		18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18,
+		18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18,
+		18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18,
+		18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18,
+		18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18,
+		18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18,
+		18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18,
+		18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18,
+		18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18,
+		18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18, 18,
+		18, 18, 18, 18, 18, 18, 18, 18, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19,
+		19, 19, 19, 19, 19, 19, 19, 19
+	};
+	return sym[value];
+}
+
+static inline uint8_t d_base_from_value(int32_t value)
+{
+	static const uint8_t sym[64 * 4] = {
+		0,  1,	2,  3,	4,  4,	5,  5,	6,  6,	7,  7,	8,  8,	8,  8,
+		9,  9,	9,  9,	10, 10, 10, 10, 11, 11, 11, 11, 12, 12, 12, 12,
+		12, 12, 12, 12, 13, 13, 13, 13, 13, 13, 13, 13, 14, 14, 14, 14,
+		14, 14, 14, 14, 15, 15, 15, 15, 15, 15, 15, 15, 16, 16, 16, 16,
+		16, 17, 18, 19, 20, 20, 21, 21, 22, 22, 23, 23, 24, 24, 24, 24,
+		25, 25, 25, 25, 26, 26, 26, 26, 27, 27, 27, 27, 28, 28, 28, 28,
+		28, 28, 28, 28, 29, 29, 29, 29, 29, 29, 29, 29, 30, 30, 30, 30,
+		30, 30, 30, 30, 31, 31, 31, 31, 31, 31, 31, 31, 32, 32, 32, 32,
+		32, 33, 34, 35, 36, 36, 37, 37, 38, 38, 39, 39, 40, 40, 40, 40,
+		41, 41, 41, 41, 42, 42, 42, 42, 43, 43, 43, 43, 44, 44, 44, 44,
+		44, 44, 44, 44, 45, 45, 45, 45, 45, 45, 45, 45, 46, 46, 46, 46,
+		46, 46, 46, 46, 47, 47, 47, 47, 47, 47, 47, 47, 48, 48, 48, 48,
+		48, 49, 50, 51, 52, 52, 53, 53, 54, 54, 55, 55, 56, 56, 56, 56,
+		57, 57, 57, 57, 58, 58, 58, 58, 59, 59, 59, 59, 60, 60, 60, 60,
+		60, 60, 60, 60, 61, 61, 61, 61, 61, 61, 61, 61, 62, 62, 62, 62,
+		62, 62, 62, 62, 63, 63, 63, 63, 63, 63, 63, 63, 0,  0,	0,  0
+	};
+	int index = 0;
+	int in_range_k;
+	in_range_k = (value >= 0 && value < 60);
+	index |= (((value - 0) >> 0) + 0) & -in_range_k;
+	in_range_k = (value >= 60 && value < 1020);
+	index |= (((value - 60) >> 4) + 64) & -in_range_k;
+	in_range_k = (value >= 1020 && value < 16380);
+	index |= (((value - 1020) >> 8) + 128) & -in_range_k;
+	in_range_k = (value >= 16380 && value < 262140);
+	index |= (((value - 16380) >> 12) + 192) & -in_range_k;
+	return sym[index & 255];
+}
+
+#endif // LZFSE_ENCODE_TABLES_H
diff --git a/drivers/staging/apfs/lzfse/lzfse_fse.c b/drivers/staging/apfs/lzfse/lzfse_fse.c
new file mode 100644
index 0000000000000000000000000000000000000000..50329ccfae48d150b7b3c2322cc76bc8235fedd4
--- /dev/null
+++ b/drivers/staging/apfs/lzfse/lzfse_fse.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2015-2016, Apple Inc. All rights reserved.
+ *
+ */
+
+#include "lzfse_internal.h"
+
+/*  Initialize encoder table T[NSYMBOLS].
+ *  NSTATES = sum FREQ[i] is the number of states (a power of 2)
+ *  NSYMBOLS is the number of symbols.
+ *  FREQ[NSYMBOLS] is a normalized histogram of symbol frequencies, with FREQ[i]
+ *  >= 0.
+ *  Some symbols may have a 0 frequency.  In that case, they should not be
+ *  present in the data.
+ */
+void fse_init_encoder_table(int nstates, int nsymbols,
+			    const uint16_t *__restrict freq,
+			    fse_encoder_entry *__restrict t)
+{
+	int offset = 0; // current offset
+	int n_clz = __builtin_clz(nstates);
+	int i;
+	for (i = 0; i < nsymbols; i++) {
+		int f = (int)freq[i];
+		int k;
+		if (f == 0)
+			continue; // skip this symbol, no occurrences
+		k = __builtin_clz(f) -
+		    n_clz; // shift needed to ensure N <= (F<<K) < 2*N
+		t[i].s0 = (int16_t)((f << k) - nstates);
+		t[i].k = (int16_t)k;
+		t[i].delta0 = (int16_t)(offset - f + (nstates >> k));
+		t[i].delta1 = (int16_t)(offset - f + (nstates >> (k - 1)));
+		offset += f;
+	}
+}
+
+/*  Initialize decoder table T[NSTATES].
+ *  NSTATES = sum FREQ[i] is the number of states (a power of 2)
+ *  NSYMBOLS is the number of symbols.
+ *  FREQ[NSYMBOLS] is a normalized histogram of symbol frequencies, with FREQ[i]
+ *  >= 0.
+ *  Some symbols may have a 0 frequency.  In that case, they should not be
+ *  present in the data.
+ */
+int fse_init_decoder_table(int nstates, int nsymbols,
+			   const uint16_t *__restrict freq,
+			   int32_t *__restrict t)
+{
+	int n_clz = __builtin_clz(nstates);
+	int sum_of_freq = 0;
+	int i, j0, j;
+	for (i = 0; i < nsymbols; i++) {
+		int f = (int)freq[i];
+		int k;
+		if (f == 0)
+			continue; // skip this symbol, no occurrences
+
+		sum_of_freq += f;
+
+		if (sum_of_freq > nstates) {
+			return -1;
+		}
+
+		k = __builtin_clz(f) -
+		    n_clz; // shift needed to ensure N <= (F<<K) < 2*N
+		j0 = ((2 * nstates) >> k) - f;
+
+		// Initialize all states S reached by this symbol: OFFSET <= S < OFFSET + F
+		for (j = 0; j < f; j++) {
+			fse_decoder_entry e;
+
+			e.symbol = (uint8_t)i;
+			if (j < j0) {
+				e.k = (int8_t)k;
+				e.delta = (int16_t)(((f + j) << k) - nstates);
+			} else {
+				e.k = (int8_t)(k - 1);
+				e.delta = (int16_t)((j - j0) << (k - 1));
+			}
+
+			memcpy(t, &e, sizeof(e));
+			t++;
+		}
+	}
+
+	return 0; // OK
+}
+
+/*  Initialize value decoder table T[NSTATES].
+ *  NSTATES = sum FREQ[i] is the number of states (a power of 2)
+ *  NSYMBOLS is the number of symbols.
+ *  FREQ[NSYMBOLS] is a normalized histogram of symbol frequencies, with FREQ[i]
+ *  >= 0.
+ *  SYMBOL_VBITS[NSYMBOLS] and SYMBOLS_VBASE[NSYMBOLS] are the number of value
+ *  bits to read and the base value for each symbol.
+ *  Some symbols may have a 0 frequency.  In that case, they should not be
+ *  present in the data.
+ */
+void fse_init_value_decoder_table(int nstates, int nsymbols,
+				  const uint16_t *__restrict freq,
+				  const uint8_t *__restrict symbol_vbits,
+				  const int32_t *__restrict symbol_vbase,
+				  fse_value_decoder_entry *__restrict t)
+{
+	int n_clz = __builtin_clz(nstates);
+	int i;
+	for (i = 0; i < nsymbols; i++) {
+		fse_value_decoder_entry ei = { 0 };
+		int f = (int)freq[i];
+		int k, j0, j;
+		if (f == 0)
+			continue; // skip this symbol, no occurrences
+
+		k = __builtin_clz(f) -
+		    n_clz; // shift needed to ensure N <= (F<<K) < 2*N
+		j0 = ((2 * nstates) >> k) - f;
+
+		ei.value_bits = symbol_vbits[i];
+		ei.vbase = symbol_vbase[i];
+
+		// Initialize all states S reached by this symbol: OFFSET <= S < OFFSET + F
+		for (j = 0; j < f; j++) {
+			fse_value_decoder_entry e = ei;
+
+			if (j < j0) {
+				e.total_bits = (uint8_t)k + e.value_bits;
+				e.delta = (int16_t)(((f + j) << k) - nstates);
+			} else {
+				e.total_bits = (uint8_t)(k - 1) + e.value_bits;
+				e.delta = (int16_t)((j - j0) << (k - 1));
+			}
+
+			memcpy(t, &e, 8);
+			t++;
+		}
+	}
+}
+
+/*  Remove states from symbols until the correct number of states is used.
+ */
+static void fse_adjust_freqs(uint16_t *freq, int overrun, int nsymbols)
+{
+	int shift;
+	for (shift = 3; overrun != 0; shift--) {
+		int sym;
+		for (sym = 0; sym < nsymbols; sym++) {
+			if (freq[sym] > 1) {
+				int n = (freq[sym] - 1) >> shift;
+				if (n > overrun)
+					n = overrun;
+				freq[sym] -= n;
+				overrun -= n;
+				if (overrun == 0)
+					break;
+			}
+		}
+	}
+}
+
+/*  Normalize a table T[NSYMBOLS] of occurrences to FREQ[NSYMBOLS].
+ */
+void fse_normalize_freq(int nstates, int nsymbols, const uint32_t *__restrict t,
+			uint16_t *__restrict freq)
+{
+	uint32_t s_count = 0;
+	int remaining = nstates; // must be signed; this may become < 0
+	int max_freq = 0;
+	int max_freq_sym = 0;
+	int shift = __builtin_clz(nstates) - 1;
+	uint32_t highprec_step;
+	int i;
+
+	// Compute the total number of symbol occurrences
+	for (i = 0; i < nsymbols; i++)
+		s_count += t[i];
+
+	if (s_count == 0)
+		highprec_step = 0; // no symbols used
+	else
+		highprec_step = ((uint32_t)1 << 31) / s_count;
+
+	for (i = 0; i < nsymbols; i++) {
+		// Rescale the occurrence count to get the normalized frequency.
+		// Round up if the fractional part is >= 0.5; otherwise round down.
+		// For efficiency, we do this calculation using integer arithmetic.
+		int f = (((t[i] * highprec_step) >> shift) + 1) >> 1;
+
+		// If a symbol was used, it must be given a nonzero normalized frequency.
+		if (f == 0 && t[i] != 0)
+			f = 1;
+
+		freq[i] = f;
+		remaining -= f;
+
+		// Remember the maximum frequency and which symbol had it.
+		if (f > max_freq) {
+			max_freq = f;
+			max_freq_sym = i;
+		}
+	}
+
+	// If there remain states to be assigned, then just assign them to the most
+	// frequent symbol.  Alternatively, if we assigned more states than were
+	// actually available, then either remove states from the most frequent symbol
+	// (for minor overruns) or use the slower adjustment algorithm (for major
+	// overruns).
+	if (-remaining < (max_freq >> 2)) {
+		freq[max_freq_sym] += remaining;
+	} else {
+		fse_adjust_freqs(freq, -remaining, nsymbols);
+	}
+}
diff --git a/drivers/staging/apfs/lzfse/lzfse_fse.h b/drivers/staging/apfs/lzfse/lzfse_fse.h
new file mode 100644
index 0000000000000000000000000000000000000000..c6a5e4342cba554e391d3b54d5983c659c4e06bb
--- /dev/null
+++ b/drivers/staging/apfs/lzfse/lzfse_fse.h
@@ -0,0 +1,632 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+/*
+ * Copyright (c) 2015-2016, Apple Inc. All rights reserved.
+ *
+ */
+
+/*  Finite state entropy coding (FSE)
+ *  This is an implementation of the tANS algorithm described by Jarek Duda,
+ *  we use the more descriptive name "Finite State Entropy".
+ */
+
+#ifndef LZFSE_FSE_H
+#define LZFSE_FSE_H
+
+#include <linux/types.h>
+#include <linux/string.h>
+
+/*   Select between 32/64-bit I/O streams for FSE. Note that the FSE stream
+ *   size need not match the word size of the machine, but in practice you
+ *   want to use 64b streams on 64b systems for better performance.
+ */
+#define FSE_IOSTREAM_64 0
+
+#define FSE_INLINE static inline __attribute__((__always_inline__))
+
+/*  MARK: - Bit utils
+ */
+
+/*! @abstract Signed type used to represent bit count. */
+typedef int32_t fse_bit_count;
+
+/*! @abstract Unsigned type used to represent FSE state. */
+typedef uint16_t fse_state;
+
+/*  Mask the NBITS lsb of X. 0 <= NBITS < 64
+ */
+static inline uint64_t fse_mask_lsb64(uint64_t x, fse_bit_count nbits)
+{
+	static const uint64_t mtable[65] = {
+		0x0000000000000000LLU, 0x0000000000000001LLU,
+		0x0000000000000003LLU, 0x0000000000000007LLU,
+		0x000000000000000fLLU, 0x000000000000001fLLU,
+		0x000000000000003fLLU, 0x000000000000007fLLU,
+		0x00000000000000ffLLU, 0x00000000000001ffLLU,
+		0x00000000000003ffLLU, 0x00000000000007ffLLU,
+		0x0000000000000fffLLU, 0x0000000000001fffLLU,
+		0x0000000000003fffLLU, 0x0000000000007fffLLU,
+		0x000000000000ffffLLU, 0x000000000001ffffLLU,
+		0x000000000003ffffLLU, 0x000000000007ffffLLU,
+		0x00000000000fffffLLU, 0x00000000001fffffLLU,
+		0x00000000003fffffLLU, 0x00000000007fffffLLU,
+		0x0000000000ffffffLLU, 0x0000000001ffffffLLU,
+		0x0000000003ffffffLLU, 0x0000000007ffffffLLU,
+		0x000000000fffffffLLU, 0x000000001fffffffLLU,
+		0x000000003fffffffLLU, 0x000000007fffffffLLU,
+		0x00000000ffffffffLLU, 0x00000001ffffffffLLU,
+		0x00000003ffffffffLLU, 0x00000007ffffffffLLU,
+		0x0000000fffffffffLLU, 0x0000001fffffffffLLU,
+		0x0000003fffffffffLLU, 0x0000007fffffffffLLU,
+		0x000000ffffffffffLLU, 0x000001ffffffffffLLU,
+		0x000003ffffffffffLLU, 0x000007ffffffffffLLU,
+		0x00000fffffffffffLLU, 0x00001fffffffffffLLU,
+		0x00003fffffffffffLLU, 0x00007fffffffffffLLU,
+		0x0000ffffffffffffLLU, 0x0001ffffffffffffLLU,
+		0x0003ffffffffffffLLU, 0x0007ffffffffffffLLU,
+		0x000fffffffffffffLLU, 0x001fffffffffffffLLU,
+		0x003fffffffffffffLLU, 0x007fffffffffffffLLU,
+		0x00ffffffffffffffLLU, 0x01ffffffffffffffLLU,
+		0x03ffffffffffffffLLU, 0x07ffffffffffffffLLU,
+		0x0fffffffffffffffLLU, 0x1fffffffffffffffLLU,
+		0x3fffffffffffffffLLU, 0x7fffffffffffffffLLU,
+		0xffffffffffffffffLLU,
+	};
+	return x & mtable[nbits];
+}
+
+/*  Mask the NBITS lsb of X. 0 <= NBITS < 32
+ */
+static inline uint32_t fse_mask_lsb32(uint32_t x, fse_bit_count nbits)
+{
+	static const uint32_t mtable[33] = {
+		0x0000000000000000U, 0x0000000000000001U, 0x0000000000000003U,
+		0x0000000000000007U, 0x000000000000000fU, 0x000000000000001fU,
+		0x000000000000003fU, 0x000000000000007fU, 0x00000000000000ffU,
+		0x00000000000001ffU, 0x00000000000003ffU, 0x00000000000007ffU,
+		0x0000000000000fffU, 0x0000000000001fffU, 0x0000000000003fffU,
+		0x0000000000007fffU, 0x000000000000ffffU, 0x000000000001ffffU,
+		0x000000000003ffffU, 0x000000000007ffffU, 0x00000000000fffffU,
+		0x00000000001fffffU, 0x00000000003fffffU, 0x00000000007fffffU,
+		0x0000000000ffffffU, 0x0000000001ffffffU, 0x0000000003ffffffU,
+		0x0000000007ffffffU, 0x000000000fffffffU, 0x000000001fffffffU,
+		0x000000003fffffffU, 0x000000007fffffffU, 0x00000000ffffffffU,
+	};
+	return x & mtable[nbits];
+}
+
+/*! @abstract Select \c nbits at index \c start from \c x.
+ *  0 <= start <= start+nbits <= 64 */
+FSE_INLINE uint64_t fse_extract_bits64(uint64_t x, fse_bit_count start,
+				       fse_bit_count nbits)
+{
+#if defined(__GNUC__)
+	// If START and NBITS are constants, map to bit-field extraction instructions
+	if (__builtin_constant_p(start) && __builtin_constant_p(nbits))
+		return (x >> start) & ((1LLU << nbits) - 1LLU);
+#endif
+
+	// Otherwise, shift and mask
+	return fse_mask_lsb64(x >> start, nbits);
+}
+
+/*! @abstract Select \c nbits at index \c start from \c x.
+ *  0 <= start <= start+nbits <= 32 */
+FSE_INLINE uint32_t fse_extract_bits32(uint32_t x, fse_bit_count start,
+				       fse_bit_count nbits)
+{
+#if defined(__GNUC__)
+	// If START and NBITS are constants, map to bit-field extraction instructions
+	if (__builtin_constant_p(start) && __builtin_constant_p(nbits))
+		return (x >> start) & ((1U << nbits) - 1U);
+#endif
+
+	// Otherwise, shift and mask
+	return fse_mask_lsb32(x >> start, nbits);
+}
+
+/*  MARK: - Bit stream
+ */
+
+/*  I/O streams
+ *  The streams can be shared between several FSE encoders/decoders, which is why
+ *  they are not in the state struct
+ */
+
+/*! @abstract Output stream, 64-bit accum. */
+typedef struct {
+	uint64_t accum; // Output bits
+	fse_bit_count
+		accum_nbits; // Number of valid bits in ACCUM, other bits are 0
+} fse_out_stream64;
+
+/*! @abstract Output stream, 32-bit accum. */
+typedef struct {
+	uint32_t accum; // Output bits
+	fse_bit_count
+		accum_nbits; // Number of valid bits in ACCUM, other bits are 0
+} fse_out_stream32;
+
+/*! @abstract Object representing an input stream. */
+typedef struct {
+	uint64_t accum; // Input bits
+	fse_bit_count
+		accum_nbits; // Number of valid bits in ACCUM, other bits are 0
+} fse_in_stream64;
+
+/*! @abstract Object representing an input stream. */
+typedef struct {
+	uint32_t accum; // Input bits
+	fse_bit_count
+		accum_nbits; // Number of valid bits in ACCUM, other bits are 0
+} fse_in_stream32;
+
+/*! @abstract Initialize an output stream object. */
+FSE_INLINE void fse_out_init64(fse_out_stream64 *s)
+{
+	s->accum = 0;
+	s->accum_nbits = 0;
+}
+
+/*! @abstract Initialize an output stream object. */
+FSE_INLINE void fse_out_init32(fse_out_stream32 *s)
+{
+	s->accum = 0;
+	s->accum_nbits = 0;
+}
+
+/*! @abstract Write full bytes from the accumulator to output buffer, ensuring
+ * accum_nbits is in [0, 7].
+ * We assume we can write 8 bytes to the output buffer \c (*pbuf[0..7]) in all
+ * cases.
+ * @note *pbuf is incremented by the number of written bytes. */
+FSE_INLINE void fse_out_flush64(fse_out_stream64 *s, uint8_t **pbuf)
+{
+	fse_bit_count nbits = s->accum_nbits &
+			      -8; // number of bits written, multiple of 8
+
+	// Write 8 bytes of current accumulator
+	memcpy(*pbuf, &(s->accum), 8);
+	*pbuf += (nbits >> 3); // bytes
+
+	// Update state
+	s->accum >>= nbits; // remove nbits
+	s->accum_nbits -= nbits;
+}
+
+/*! @abstract Write full bytes from the accumulator to output buffer, ensuring
+ * accum_nbits is in [0, 7].
+ * We assume we can write 4 bytes to the output buffer \c (*pbuf[0..3]) in all
+ * cases.
+ * @note *pbuf is incremented by the number of written bytes. */
+FSE_INLINE void fse_out_flush32(fse_out_stream32 *s, uint8_t **pbuf)
+{
+	fse_bit_count nbits = s->accum_nbits &
+			      -8; // number of bits written, multiple of 8
+
+	// Write 4 bytes of current accumulator
+	memcpy(*pbuf, &(s->accum), 4);
+	*pbuf += (nbits >> 3); // bytes
+
+	// Update state
+	s->accum >>= nbits; // remove nbits
+	s->accum_nbits -= nbits;
+}
+
+/*! @abstract Write the last bytes from the accumulator to output buffer,
+ * ensuring accum_nbits is in [-7, 0]. Bits are padded with 0 if needed.
+ * We assume we can write 8 bytes to the output buffer \c (*pbuf[0..7]) in all
+ * cases.
+ * @note *pbuf is incremented by the number of written bytes. */
+FSE_INLINE void fse_out_finish64(fse_out_stream64 *s, uint8_t **pbuf)
+{
+	fse_bit_count nbits = (s->accum_nbits + 7) &
+			      -8; // number of bits written, multiple of 8
+
+	// Write 8 bytes of current accumulator
+	memcpy(*pbuf, &(s->accum), 8);
+	*pbuf += (nbits >> 3); // bytes
+
+	// Update state
+	s->accum = 0; // remove nbits
+	s->accum_nbits -= nbits;
+}
+
+/*! @abstract Write the last bytes from the accumulator to output buffer,
+ * ensuring accum_nbits is in [-7, 0]. Bits are padded with 0 if needed.
+ * We assume we can write 4 bytes to the output buffer \c (*pbuf[0..3]) in all
+ * cases.
+ * @note *pbuf is incremented by the number of written bytes. */
+FSE_INLINE void fse_out_finish32(fse_out_stream32 *s, uint8_t **pbuf)
+{
+	fse_bit_count nbits = (s->accum_nbits + 7) &
+			      -8; // number of bits written, multiple of 8
+
+	// Write 8 bytes of current accumulator
+	memcpy(*pbuf, &(s->accum), 4);
+	*pbuf += (nbits >> 3); // bytes
+
+	// Update state
+	s->accum = 0; // remove nbits
+	s->accum_nbits -= nbits;
+}
+
+/*! @abstract Accumulate \c n bits \c b to output stream \c s. We \b must have:
+ * 0 <= b < 2^n, and N + s->accum_nbits <= 64.
+ * @note The caller must ensure out_flush is called \b before the accumulator
+ * overflows to more than 64 bits. */
+FSE_INLINE void fse_out_push64(fse_out_stream64 *s, fse_bit_count n, uint64_t b)
+{
+	s->accum |= b << s->accum_nbits;
+	s->accum_nbits += n;
+}
+
+/*! @abstract Accumulate \c n bits \c b to output stream \c s. We \b must have:
+ * 0 <= n < 2^n, and n + s->accum_nbits <= 32.
+ * @note The caller must ensure out_flush is called \b before the accumulator
+ * overflows to more than 32 bits. */
+FSE_INLINE void fse_out_push32(fse_out_stream32 *s, fse_bit_count n, uint32_t b)
+{
+	s->accum |= b << s->accum_nbits;
+	s->accum_nbits += n;
+}
+
+#define DEBUG_CHECK_INPUT_STREAM_PARAMETERS
+
+/*! @abstract   Initialize the fse input stream so that accum holds between 56
+ *  and 63 bits. We never want to have 64 bits in the stream, because that allows
+ *  us to avoid a special case in the fse_in_pull function (eliminating an
+ *  unpredictable branch), while not requiring any additional fse_flush
+ *  operations. This is why we have the special case for n == 0 (in which case
+ *  we want to load only 7 bytes instead of 8). */
+FSE_INLINE int fse_in_checked_init64(fse_in_stream64 *s, fse_bit_count n,
+				     const uint8_t **pbuf,
+				     const uint8_t *buf_start)
+{
+	if (n) {
+		if (*pbuf < buf_start + 8)
+			return -1; // out of range
+		*pbuf -= 8;
+		memcpy(&(s->accum), *pbuf, 8);
+		s->accum_nbits = n + 64;
+	} else {
+		if (*pbuf < buf_start + 7)
+			return -1; // out of range
+		*pbuf -= 7;
+		memcpy(&(s->accum), *pbuf, 7);
+		s->accum &= 0xffffffffffffff;
+		s->accum_nbits = n + 56;
+	}
+
+	if ((s->accum_nbits < 56 || s->accum_nbits >= 64) ||
+	    ((s->accum >> s->accum_nbits) != 0)) {
+		return -1; // the incoming input is wrong (encoder should have zeroed the
+			// upper bits)
+	}
+
+	return 0; // OK
+}
+
+/*! @abstract Identical to previous function, but for 32-bit operation
+ * (resulting bit count is between 24 and 31 bits). */
+FSE_INLINE int fse_in_checked_init32(fse_in_stream32 *s, fse_bit_count n,
+				     const uint8_t **pbuf,
+				     const uint8_t *buf_start)
+{
+	if (n) {
+		if (*pbuf < buf_start + 4)
+			return -1; // out of range
+		*pbuf -= 4;
+		memcpy(&(s->accum), *pbuf, 4);
+		s->accum_nbits = n + 32;
+	} else {
+		if (*pbuf < buf_start + 3)
+			return -1; // out of range
+		*pbuf -= 3;
+		memcpy(&(s->accum), *pbuf, 3);
+		s->accum &= 0xffffff;
+		s->accum_nbits = n + 24;
+	}
+
+	if ((s->accum_nbits < 24 || s->accum_nbits >= 32) ||
+	    ((s->accum >> s->accum_nbits) != 0)) {
+		return -1; // the incoming input is wrong (encoder should have zeroed the
+			// upper bits)
+	}
+
+	return 0; // OK
+}
+
+/*! @abstract  Read in new bytes from buffer to ensure that we have a full
+ * complement of bits in the stream object (again, between 56 and 63 bits).
+ * checking the new value of \c *pbuf remains >= \c buf_start.
+ * @return 0 if OK.
+ * @return -1 on failure. */
+FSE_INLINE int fse_in_checked_flush64(fse_in_stream64 *s, const uint8_t **pbuf,
+				      const uint8_t *buf_start)
+{
+	//  Get number of bits to add to bring us into the desired range.
+	fse_bit_count nbits = (63 - s->accum_nbits) & -8;
+	//  Convert bits to bytes and decrement buffer address, then load new data.
+	const uint8_t *buf = (*pbuf) - (nbits >> 3);
+	uint64_t incoming;
+	if (buf < buf_start) {
+		return -1; // out of range
+	}
+	*pbuf = buf;
+	memcpy(&incoming, buf, 8);
+	// Update the state object and verify its validity (in DEBUG).
+	s->accum = (s->accum << nbits) | fse_mask_lsb64(incoming, nbits);
+	s->accum_nbits += nbits;
+	DEBUG_CHECK_INPUT_STREAM_PARAMETERS
+	return 0; // OK
+}
+
+/*! @abstract Identical to previous function (but again, we're only filling
+ * a 32-bit field with between 24 and 31 bits). */
+FSE_INLINE int fse_in_checked_flush32(fse_in_stream32 *s, const uint8_t **pbuf,
+				      const uint8_t *buf_start)
+{
+	//  Get number of bits to add to bring us into the desired range.
+	fse_bit_count nbits = (31 - s->accum_nbits) & -8;
+
+	if (nbits > 0) {
+		//  Convert bits to bytes and decrement buffer address, then load new data.
+		const uint8_t *buf = (*pbuf) - (nbits >> 3);
+		uint32_t incoming;
+		if (buf < buf_start) {
+			return -1; // out of range
+		}
+
+		*pbuf = buf;
+
+		incoming = *((uint32_t *)buf);
+
+		// Update the state object and verify its validity (in DEBUG).
+		s->accum = (s->accum << nbits) |
+			   fse_mask_lsb32(incoming, nbits);
+		s->accum_nbits += nbits;
+	}
+	DEBUG_CHECK_INPUT_STREAM_PARAMETERS
+	return 0; // OK
+}
+
+/*! @abstract Pull n bits out of the fse stream object. */
+FSE_INLINE uint64_t fse_in_pull64(fse_in_stream64 *s, fse_bit_count n)
+{
+	uint64_t result;
+	s->accum_nbits -= n;
+	result = s->accum >> s->accum_nbits;
+	s->accum = fse_mask_lsb64(s->accum, s->accum_nbits);
+	return result;
+}
+
+/*! @abstract Pull n bits out of the fse stream object. */
+FSE_INLINE uint32_t fse_in_pull32(fse_in_stream32 *s, fse_bit_count n)
+{
+	uint32_t result;
+	s->accum_nbits -= n;
+	result = s->accum >> s->accum_nbits;
+	s->accum = fse_mask_lsb32(s->accum, s->accum_nbits);
+	return result;
+}
+
+/*  MARK: - Encode/Decode
+ */
+
+/*  Map to 32/64-bit implementations and types for I/O
+ */
+#if FSE_IOSTREAM_64
+
+typedef uint64_t fse_bits;
+typedef fse_out_stream64 fse_out_stream;
+typedef fse_in_stream64 fse_in_stream;
+#define fse_mask_lsb fse_mask_lsb64
+#define fse_extract_bits fse_extract_bits64
+#define fse_out_init fse_out_init64
+#define fse_out_flush fse_out_flush64
+#define fse_out_finish fse_out_finish64
+#define fse_out_push fse_out_push64
+#define fse_in_init fse_in_checked_init64
+#define fse_in_checked_init fse_in_checked_init64
+#define fse_in_flush fse_in_checked_flush64
+#define fse_in_checked_flush fse_in_checked_flush64
+#define fse_in_flush2(_unused, _parameters, _unused2) 0 /* nothing */
+#define fse_in_checked_flush2(_unused, _parameters) /* nothing */
+#define fse_in_pull fse_in_pull64
+
+#else
+
+typedef uint32_t fse_bits;
+typedef fse_out_stream32 fse_out_stream;
+typedef fse_in_stream32 fse_in_stream;
+#define fse_mask_lsb fse_mask_lsb32
+#define fse_extract_bits fse_extract_bits32
+#define fse_out_init fse_out_init32
+#define fse_out_flush fse_out_flush32
+#define fse_out_finish fse_out_finish32
+#define fse_out_push fse_out_push32
+#define fse_in_init fse_in_checked_init32
+#define fse_in_checked_init fse_in_checked_init32
+#define fse_in_flush fse_in_checked_flush32
+#define fse_in_checked_flush fse_in_checked_flush32
+#define fse_in_flush2 fse_in_checked_flush32
+#define fse_in_checked_flush2 fse_in_checked_flush32
+#define fse_in_pull fse_in_pull32
+
+#endif
+
+/*! @abstract Entry for one symbol in the encoder table (64b). */
+typedef struct {
+	int16_t s0; // First state requiring a K-bit shift
+	int16_t k; // States S >= S0 are shifted K bits. States S < S0 are
+		// shifted K-1 bits
+	int16_t delta0; // Relative increment used to compute next state if S >= S0
+	int16_t delta1; // Relative increment used to compute next state if S < S0
+} fse_encoder_entry;
+
+/*! @abstract  Entry for one state in the decoder table (32b). */
+typedef struct { // DO NOT REORDER THE FIELDS
+	int8_t k; // Number of bits to read
+	uint8_t symbol; // Emitted symbol
+	int16_t delta; // Signed increment used to compute next state (+bias)
+} fse_decoder_entry;
+
+/*! @abstract  Entry for one state in the value decoder table (64b). */
+typedef struct { // DO NOT REORDER THE FIELDS
+	uint8_t total_bits; // state bits + extra value bits = shift for next decode
+	uint8_t value_bits; // extra value bits
+	int16_t delta; // state base (delta)
+	int32_t vbase; // value base
+} fse_value_decoder_entry;
+
+/*! @abstract Encode SYMBOL using the encoder table, and update \c *pstate,
+ *  \c out.
+ *  @note The caller must ensure we have enough bits available in the output
+ *  stream accumulator. */
+FSE_INLINE void fse_encode(fse_state *__restrict pstate,
+			   const fse_encoder_entry *__restrict encoder_table,
+			   fse_out_stream *__restrict out, uint8_t symbol)
+{
+	int s = *pstate;
+	fse_encoder_entry e = encoder_table[symbol];
+	int s0 = e.s0;
+	int k = e.k;
+	int delta0 = e.delta0;
+	int delta1 = e.delta1;
+
+	// Number of bits to write
+	int hi = s >= s0;
+	fse_bit_count nbits = hi ? k : (k - 1);
+	fse_state delta = hi ? delta0 : delta1;
+
+	// Write lower NBITS of state
+	fse_bits b = fse_mask_lsb(s, nbits);
+	fse_out_push(out, nbits, b);
+
+	// Update state with remaining bits and delta
+	*pstate = delta + (s >> nbits);
+}
+
+/*! @abstract Decode and return symbol using the decoder table, and update
+ *  \c *pstate, \c in.
+ *  @note The caller must ensure we have enough bits available in the input
+ *  stream accumulator. */
+FSE_INLINE uint8_t fse_decode(fse_state *__restrict pstate,
+			      const int32_t *__restrict decoder_table,
+			      fse_in_stream *__restrict in)
+{
+	int32_t e = decoder_table[*pstate];
+
+	// Update state from K bits of input + DELTA
+	*pstate = (fse_state)(e >> 16) + (fse_state)fse_in_pull(in, e & 0xff);
+
+	// Return the symbol for this state
+	return fse_extract_bits(e, 8, 8); // symbol
+}
+
+/*! @abstract Decode and return value using the decoder table, and update \c
+ *  *pstate, \c in.
+ * \c value_decoder_table[nstates]
+ * @note The caller must ensure we have enough bits available in the input
+ * stream accumulator. */
+FSE_INLINE int32_t
+fse_value_decode(fse_state *__restrict pstate,
+		 const fse_value_decoder_entry *value_decoder_table,
+		 fse_in_stream *__restrict in)
+{
+	fse_value_decoder_entry entry = value_decoder_table[*pstate];
+	uint32_t state_and_value_bits =
+		(uint32_t)fse_in_pull(in, entry.total_bits);
+	*pstate = (fse_state)(entry.delta +
+			      (state_and_value_bits >> entry.value_bits));
+	return (int32_t)(entry.vbase +
+			 fse_mask_lsb(state_and_value_bits, entry.value_bits));
+}
+
+/*  MARK: - Tables
+ */
+
+/*  IMPORTANT: To properly decode an FSE encoded stream, both encoder/decoder
+ *  tables shall be initialized with the same parameters, including the
+ *  FREQ[NSYMBOL] array.
+ * 
+ */
+
+/*! @abstract Sanity check on frequency table, verify sum of \c freq
+ *  is <= \c number_of_states. */
+FSE_INLINE int fse_check_freq(const uint16_t *freq_table,
+			      const size_t table_size,
+			      const size_t number_of_states)
+{
+	size_t sum_of_freq = 0;
+	int i;
+	for (i = 0; i < table_size; i++) {
+		sum_of_freq += freq_table[i];
+	}
+	return (sum_of_freq > number_of_states) ? -1 : 0;
+}
+
+/*! @abstract Initialize encoder table \c t[nsymbols].
+ *
+ * @param nstates
+ * sum \c freq[i]; the number of states (a power of 2).
+ *
+ * @param nsymbols
+ * the number of symbols.
+ *
+ * @param freq[nsymbols]
+ * is a normalized histogram of symbol frequencies, with \c freq[i] >= 0.
+ * Some symbols may have a 0 frequency. In that case they should not be
+ * present in the data.
+ */
+void fse_init_encoder_table(int nstates, int nsymbols,
+			    const uint16_t *__restrict freq,
+			    fse_encoder_entry *__restrict t);
+
+/*! @abstract Initialize decoder table \c t[nstates].
+ *
+ * @param nstates
+ * sum \c freq[i]; the number of states (a power of 2).
+ *
+ * @param nsymbols
+ * the number of symbols.
+ *
+ * @param feq[nsymbols]
+ * a normalized histogram of symbol frequencies, with \c freq[i] >= 0.
+ * Some symbols may have a 0 frequency. In that case they should not be
+ * present in the data.
+ *
+ * @return 0 if OK.
+ * @return -1 on failure.
+ */
+int fse_init_decoder_table(int nstates, int nsymbols,
+			   const uint16_t *__restrict freq,
+			   int32_t *__restrict t);
+
+/*! @abstract Initialize value decoder table \c t[nstates].
+ *
+ * @param nstates
+ * sum \cfreq[i]; the number of states (a power of 2).
+ *
+ * @param nsymbols
+ * the number of symbols.
+ *
+ * @param freq[nsymbols]
+ * a normalized histogram of symbol frequencies, with \c freq[i] >= 0.
+ * \c symbol_vbits[nsymbols] and \c symbol_vbase[nsymbols] are the number of
+ * value bits to read and the base value for each symbol.
+ * Some symbols may have a 0 frequency.  In that case they should not be
+ * present in the data.
+ */
+void fse_init_value_decoder_table(int nstates, int nsymbols,
+				  const uint16_t *__restrict freq,
+				  const uint8_t *__restrict symbol_vbits,
+				  const int32_t *__restrict symbol_vbase,
+				  fse_value_decoder_entry *__restrict t);
+
+/*! @abstract Normalize a table \c t[nsymbols] of occurrences to
+ *  \c freq[nsymbols]. */
+void fse_normalize_freq(int nstates, int nsymbols, const uint32_t *__restrict t,
+			uint16_t *__restrict freq);
+
+#endif /* LZFSE_FSE_H */
diff --git a/drivers/staging/apfs/lzfse/lzfse_internal.h b/drivers/staging/apfs/lzfse/lzfse_internal.h
new file mode 100644
index 0000000000000000000000000000000000000000..afca0b3eae410dc0ac4b93b319186a16c3441a4d
--- /dev/null
+++ b/drivers/staging/apfs/lzfse/lzfse_internal.h
@@ -0,0 +1,599 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+/*
+ * Copyright (c) 2015-2016, Apple Inc. All rights reserved.
+ *
+ */
+
+#ifndef LZFSE_INTERNAL_H
+#define LZFSE_INTERNAL_H
+
+/*   Unlike the tunable parameters defined in lzfse_tunables.h, you probably
+ *   should not modify the values defined in this header. Doing so will either
+ *   break the compressor, or result in a compressed data format that is
+ *   incompatible.
+ */
+
+#define LZFSE_INLINE static inline __attribute__((__always_inline__))
+
+#include "lzfse_fse.h"
+#include "lzfse_tunables.h"
+#include <linux/limits.h>
+#include <linux/stddef.h>
+
+/*   Throughout LZFSE we refer to "L", "M" and "D"; these will always appear as
+ *   a triplet, and represent a "usual" LZ-style literal and match pair.  "L"
+ *   is the number of literal bytes, "M" is the number of match bytes, and "D"
+ *   is the match "distance"; the distance in bytes between the current pointer
+ *   and the start of the match.
+ */
+#define LZFSE_ENCODE_HASH_VALUES (1 << LZFSE_ENCODE_HASH_BITS)
+#define LZFSE_ENCODE_L_SYMBOLS 20
+#define LZFSE_ENCODE_M_SYMBOLS 20
+#define LZFSE_ENCODE_D_SYMBOLS 64
+#define LZFSE_ENCODE_LITERAL_SYMBOLS 256
+#define LZFSE_ENCODE_L_STATES 64
+#define LZFSE_ENCODE_M_STATES 64
+#define LZFSE_ENCODE_D_STATES 256
+#define LZFSE_ENCODE_LITERAL_STATES 1024
+#define LZFSE_MATCHES_PER_BLOCK 10000
+#define LZFSE_LITERALS_PER_BLOCK (4 * LZFSE_MATCHES_PER_BLOCK)
+#define LZFSE_DECODE_LITERALS_PER_BLOCK (4 * LZFSE_DECODE_MATCHES_PER_BLOCK)
+
+/*   LZFSE internal status. These values are used by internal LZFSE routines
+ *   as return codes.  There should not be any good reason to change their
+ *   values; it is plausible that additional codes might be added in the
+ *   future.
+ */
+#define LZFSE_STATUS_OK 0
+#define LZFSE_STATUS_SRC_EMPTY -1
+#define LZFSE_STATUS_DST_FULL -2
+#define LZFSE_STATUS_ERROR -3
+
+/*   Type representing an offset between elements in a buffer. On 64-bit
+ *   systems, this is stored in a 64-bit container to avoid extra sign-
+ *   extension operations in addressing arithmetic, but the value is always
+ *   representable as a 32-bit signed value in LZFSE's usage.
+ */
+#if defined(_M_AMD64) || defined(__x86_64__) || defined(__arm64__)
+typedef int64_t lzfse_offset;
+#else
+typedef int32_t lzfse_offset;
+#endif
+
+typedef uint64_t uintmax_t;
+
+/*! @abstract History table set. Each line of the history table represents a set
+ *  of candidate match locations, each of which begins with four bytes with the
+ *  same hash. The table contains not only the positions, but also the first
+ *  four bytes at each position. This doubles the memory footprint of the
+ *  table, but allows us to quickly eliminate false-positive matches without
+ *  doing any pointer chasing and without pulling in any additional cachelines.
+ *  This provides a large performance win in practice. */
+typedef struct {
+	int32_t pos[LZFSE_ENCODE_HASH_WIDTH];
+	uint32_t value[LZFSE_ENCODE_HASH_WIDTH];
+} lzfse_history_set;
+
+/*! @abstract An lzfse match is a sequence of bytes in the source buffer that
+ *  exactly matches an earlier (but possibly overlapping) sequence of bytes in
+ *  the same buffer.
+ *  @code
+ *  exeMPLARYexaMPLE
+ *  |  |     | ||-|--- lzfse_match2.length=3
+ *  |  |     | ||----- lzfse_match2.pos
+ *  |  |     |-|------ lzfse_match1.length=3
+ *  |  |     |-------- lzfse_match1.pos
+ *  |  |-------------- lzfse_match2.ref
+ *  |----------------- lzfse_match1.ref
+ *  @endcode
+ */
+typedef struct {
+	//  Offset of the first byte in the match.
+	lzfse_offset pos;
+	//  First byte of the source -- the earlier location in the buffer with the
+	//  same contents.
+	lzfse_offset ref;
+	//  Length of the match.
+	uint32_t length;
+} lzfse_match;
+
+/*  MARK: - Encoder and Decoder state objects
+ */
+
+/*! @abstract Encoder state object. */
+typedef struct {
+	//  Pointer to first byte of the source buffer.
+	const uint8_t *src;
+	//  Length of the source buffer in bytes. Note that this is not a size_t,
+	//  but rather lzfse_offset, which is a signed type. The largest
+	//  representable buffer is 2GB, but arbitrarily large buffers may be
+	//  handled by repeatedly calling the encoder function and "translating"
+	//  the state between calls. When doing this, it is beneficial to use
+	//  blocks smaller than 2GB in order to maintain residency in the last-level
+	//  cache. Consult the implementation of lzfse_encode_buffer for details.
+	lzfse_offset src_end;
+	//  Offset of the first byte of the next literal to encode in the source
+	//  buffer.
+	lzfse_offset src_literal;
+	//  Offset of the byte currently being checked for a match.
+	lzfse_offset src_encode_i;
+	//  The last byte offset to consider for a match.  In some uses it makes
+	//  sense to use a smaller offset than src_end.
+	lzfse_offset src_encode_end;
+	//  Pointer to the next byte to be written in the destination buffer.
+	uint8_t *dst;
+	//  Pointer to the first byte of the destination buffer.
+	uint8_t *dst_begin;
+	//  Pointer to one byte past the end of the destination buffer.
+	uint8_t *dst_end;
+	//  Pending match; will be emitted unless a better match is found.
+	lzfse_match pending;
+	//  The number of matches written so far. Note that there is no problem in
+	//  using a 32-bit field for this quantity, because the state already limits
+	//  us to at most 2GB of data; there cannot possibly be more matches than
+	//  there are bytes in the input.
+	uint32_t n_matches;
+	//  The number of literals written so far.
+	uint32_t n_literals;
+	//  Lengths of found literals.
+	uint32_t l_values[LZFSE_MATCHES_PER_BLOCK];
+	//  Lengths of found matches.
+	uint32_t m_values[LZFSE_MATCHES_PER_BLOCK];
+	//  Distances of found matches.
+	uint32_t d_values[LZFSE_MATCHES_PER_BLOCK];
+	//  Concatenated literal bytes.
+	uint8_t literals[LZFSE_LITERALS_PER_BLOCK];
+	//  History table used to search for matches. Each entry of the table
+	//  corresponds to a group of four byte sequences in the input stream
+	//  that hash to the same value.
+	lzfse_history_set history_table[LZFSE_ENCODE_HASH_VALUES];
+} lzfse_encoder_state;
+
+/*! @abstract Decoder state object for lzfse compressed blocks. */
+typedef struct {
+	//  Number of matches remaining in the block.
+	uint32_t n_matches;
+	//  Number of bytes used to encode L, M, D triplets for the block.
+	uint32_t n_lmd_payload_bytes;
+	//  Pointer to the next literal to emit.
+	const uint8_t *current_literal;
+	//  L, M, D triplet for the match currently being emitted. This is used only
+	//  if we need to restart after reaching the end of the destination buffer in
+	//  the middle of a literal or match.
+	int32_t l_value, m_value, d_value;
+	//  FSE stream object.
+	fse_in_stream lmd_in_stream;
+	//  Offset of L,M,D encoding in the input buffer. Because we read through an
+	//  FSE stream *backwards* while decoding, this is decremented as we move
+	//  through a block.
+	uint32_t lmd_in_buf;
+	//  The current state of the L, M, and D FSE decoders.
+	uint16_t l_state, m_state, d_state;
+	//  Internal FSE decoder tables for the current block. These have
+	//  alignment forced to 8 bytes to guarantee that a single state's
+	//  entry cannot span two cachelines.
+	fse_value_decoder_entry l_decoder[LZFSE_ENCODE_L_STATES]
+		__attribute__((__aligned__(8)));
+	fse_value_decoder_entry m_decoder[LZFSE_ENCODE_M_STATES]
+		__attribute__((__aligned__(8)));
+	fse_value_decoder_entry d_decoder[LZFSE_ENCODE_D_STATES]
+		__attribute__((__aligned__(8)));
+	int32_t literal_decoder[LZFSE_ENCODE_LITERAL_STATES];
+	//  The literal stream for the block, plus padding to allow for faster copy
+	//  operations.
+	uint8_t literals[LZFSE_LITERALS_PER_BLOCK + 64];
+} lzfse_compressed_block_decoder_state;
+
+/*   Decoder state object for uncompressed blocks.
+ */
+typedef struct {
+	uint32_t n_raw_bytes;
+} uncompressed_block_decoder_state;
+
+/*! @abstract Decoder state object for lzvn-compressed blocks. */
+typedef struct {
+	uint32_t n_raw_bytes;
+	uint32_t n_payload_bytes;
+	uint32_t d_prev;
+} lzvn_compressed_block_decoder_state;
+
+/*! @abstract Decoder state object. */
+typedef struct {
+	//  Pointer to next byte to read from source buffer (this is advanced as we
+	//  decode; src_begin describe the buffer and do not change).
+	const uint8_t *src;
+	//  Pointer to first byte of source buffer.
+	const uint8_t *src_begin;
+	//  Pointer to one byte past the end of the source buffer.
+	const uint8_t *src_end;
+	//  Pointer to the next byte to write to destination buffer (this is advanced
+	//  as we decode; dst_begin and dst_end describe the buffer and do not change).
+	uint8_t *dst;
+	//  Pointer to first byte of destination buffer.
+	uint8_t *dst_begin;
+	//  Pointer to one byte past the end of the destination buffer.
+	uint8_t *dst_end;
+	//  1 if we have reached the end of the stream, 0 otherwise.
+	int end_of_stream;
+	//  magic number of the current block if we are within a block,
+	//  LZFSE_NO_BLOCK_MAGIC otherwise.
+	uint32_t block_magic;
+	lzfse_compressed_block_decoder_state compressed_lzfse_block_state;
+	lzvn_compressed_block_decoder_state compressed_lzvn_block_state;
+	uncompressed_block_decoder_state uncompressed_block_state;
+} lzfse_decoder_state;
+
+/*  MARK: - Block header objects
+ */
+
+#define LZFSE_NO_BLOCK_MAGIC 0x00000000 // 0    (invalid)
+#define LZFSE_ENDOFSTREAM_BLOCK_MAGIC 0x24787662 // bvx$ (end of stream)
+#define LZFSE_UNCOMPRESSED_BLOCK_MAGIC 0x2d787662 // bvx- (raw data)
+#define LZFSE_COMPRESSEDV1_BLOCK_MAGIC \
+	0x31787662 // bvx1 (lzfse compressed, uncompressed tables)
+#define LZFSE_COMPRESSEDV2_BLOCK_MAGIC \
+	0x32787662 // bvx2 (lzfse compressed, compressed tables)
+#define LZFSE_COMPRESSEDLZVN_BLOCK_MAGIC 0x6e787662 // bvxn (lzvn compressed)
+
+/*! @abstract Uncompressed block header in encoder stream. */
+typedef struct {
+	//  Magic number, always LZFSE_UNCOMPRESSED_BLOCK_MAGIC.
+	uint32_t magic;
+	//  Number of raw bytes in block.
+	uint32_t n_raw_bytes;
+} uncompressed_block_header;
+
+/*! @abstract Compressed block header with uncompressed tables. */
+typedef struct {
+	//  Magic number, always LZFSE_COMPRESSEDV1_BLOCK_MAGIC.
+	uint32_t magic;
+	//  Number of decoded (output) bytes in block.
+	uint32_t n_raw_bytes;
+	//  Number of encoded (source) bytes in block.
+	uint32_t n_payload_bytes;
+	//  Number of literal bytes output by block (*not* the number of literals).
+	uint32_t n_literals;
+	//  Number of matches in block (which is also the number of literals).
+	uint32_t n_matches;
+	//  Number of bytes used to encode literals.
+	uint32_t n_literal_payload_bytes;
+	//  Number of bytes used to encode matches.
+	uint32_t n_lmd_payload_bytes;
+
+	//  Final encoder states for the block, which will be the initial states for
+	//  the decoder:
+	//  Final accum_nbits for literals stream.
+	int32_t literal_bits;
+	//  There are four interleaved streams of literals, so there are four final
+	//  states.
+	uint16_t literal_state[4];
+	//  accum_nbits for the l, m, d stream.
+	int32_t lmd_bits;
+	//  Final L (literal length) state.
+	uint16_t l_state;
+	//  Final M (match length) state.
+	uint16_t m_state;
+	//  Final D (match distance) state.
+	uint16_t d_state;
+
+	//  Normalized frequency tables for each stream. Sum of values in each
+	//  array is the number of states.
+	uint16_t l_freq[LZFSE_ENCODE_L_SYMBOLS];
+	uint16_t m_freq[LZFSE_ENCODE_M_SYMBOLS];
+	uint16_t d_freq[LZFSE_ENCODE_D_SYMBOLS];
+	uint16_t literal_freq[LZFSE_ENCODE_LITERAL_SYMBOLS];
+} lzfse_compressed_block_header_v1;
+
+/*! @abstract Compressed block header with compressed tables. Note that because
+ *  freq[] is compressed, the structure-as-stored-in-the-stream is *truncated*;
+ *  we only store the used bytes of freq[]. This means that some extra care must
+ *  be taken when reading one of these headers from the stream. */
+typedef struct {
+	//  Magic number, always LZFSE_COMPRESSEDV2_BLOCK_MAGIC.
+	uint32_t magic;
+	//  Number of decoded (output) bytes in block.
+	uint32_t n_raw_bytes;
+	//  The fields n_payload_bytes ... d_state from the
+	//  lzfse_compressed_block_header_v1 object are packed into three 64-bit
+	//  fields in the compressed header, as follows:
+	//
+	//    offset  bits  value
+	//    0       20    n_literals
+	//    20      20    n_literal_payload_bytes
+	//    40      20    n_matches
+	//    60      3     literal_bits
+	//    63      1     --- unused ---
+	//
+	//    0       10    literal_state[0]
+	//    10      10    literal_state[1]
+	//    20      10    literal_state[2]
+	//    30      10    literal_state[3]
+	//    40      20    n_lmd_payload_bytes
+	//    60      3     lmd_bits
+	//    63      1     --- unused ---
+	//
+	//    0       32    header_size (total header size in bytes; this does not
+	//                  correspond to a field in the uncompressed header version,
+	//                  but is required; we wouldn't know the size of the
+	//                  compresssed header otherwise.
+	//    32      10    l_state
+	//    42      10    m_state
+	//    52      10    d_state
+	//    62      2     --- unused ---
+	uint64_t packed_fields[3];
+	//  Variable size freq tables, using a Huffman-style fixed encoding.
+	//  Size allocated here is an upper bound (all values stored on 16 bits).
+	uint8_t freq[2 *
+		     (LZFSE_ENCODE_L_SYMBOLS + LZFSE_ENCODE_M_SYMBOLS +
+		      LZFSE_ENCODE_D_SYMBOLS + LZFSE_ENCODE_LITERAL_SYMBOLS)];
+} __attribute__((__packed__, __aligned__(1))) lzfse_compressed_block_header_v2;
+
+/*! @abstract LZVN compressed block header. */
+typedef struct {
+	//  Magic number, always LZFSE_COMPRESSEDLZVN_BLOCK_MAGIC.
+	uint32_t magic;
+	//  Number of decoded (output) bytes.
+	uint32_t n_raw_bytes;
+	//  Number of encoded (source) bytes.
+	uint32_t n_payload_bytes;
+} lzvn_compressed_block_header;
+
+/*  MARK: - LZFSE encode/decode interfaces
+ */
+
+int lzfse_encode_init(lzfse_encoder_state *s);
+int lzfse_encode_translate(lzfse_encoder_state *s, lzfse_offset delta);
+int lzfse_encode_base(lzfse_encoder_state *s);
+int lzfse_encode_finish(lzfse_encoder_state *s);
+int lzfse_decode(lzfse_decoder_state *s);
+
+/*  MARK: - LZVN encode/decode interfaces
+ */
+
+/*   Minimum source buffer size for compression. Smaller buffers will not be
+ *   compressed; the lzvn encoder will simply return.
+ */
+#define LZVN_ENCODE_MIN_SRC_SIZE ((size_t)8)
+
+/*   Maximum source buffer size for compression. Larger buffers will be
+ *   compressed partially.
+ */
+#define LZVN_ENCODE_MAX_SRC_SIZE ((size_t)0xffffffffU)
+
+/*   Minimum destination buffer size for compression. No compression will take
+ *   place if smaller.
+ */
+#define LZVN_ENCODE_MIN_DST_SIZE ((size_t)8)
+
+size_t lzvn_decode_scratch_size(void);
+size_t lzvn_encode_scratch_size(void);
+size_t lzvn_encode_buffer(void *__restrict dst, size_t dst_size,
+			  const void *__restrict src, size_t src_size,
+			  void *__restrict work);
+size_t lzvn_decode_buffer(void *__restrict dst, size_t dst_size,
+			  const void *__restrict src, size_t src_size);
+
+/*! @abstract Signed offset in buffers, stored on either 32 or 64 bits. */
+#if defined(_M_AMD64) || defined(__x86_64__) || defined(__arm64__)
+typedef int64_t lzvn_offset;
+#else
+typedef int32_t lzvn_offset;
+#endif
+
+/*  MARK: - LZFSE utility functions
+ */
+
+/*! @abstract Load bytes from memory location SRC. */
+LZFSE_INLINE uint16_t load2(const void *ptr)
+{
+	uint16_t data;
+	memcpy(&data, ptr, sizeof data);
+	return data;
+}
+
+LZFSE_INLINE uint32_t load4(const void *ptr)
+{
+	uint32_t data;
+	memcpy(&data, ptr, sizeof data);
+	return data;
+}
+
+LZFSE_INLINE uint64_t load8(const void *ptr)
+{
+	uint64_t data;
+	memcpy(&data, ptr, sizeof data);
+	return data;
+}
+
+/*! @abstract Store bytes to memory location DST. */
+LZFSE_INLINE void store2(void *ptr, uint16_t data)
+{
+	memcpy(ptr, &data, sizeof data);
+}
+
+LZFSE_INLINE void store4(void *ptr, uint32_t data)
+{
+	memcpy(ptr, &data, sizeof data);
+}
+
+LZFSE_INLINE void store8(void *ptr, uint64_t data)
+{
+	memcpy(ptr, &data, sizeof data);
+}
+
+/*! @abstract Load+store bytes from locations SRC to DST. Not intended for use
+ * with overlapping buffers. Note that for LZ-style compression, you need
+ * copies to behave like naive memcpy( ) implementations do, splatting the
+ * leading sequence if the buffers overlap. This copy does not do that, so
+ * should not be used with overlapping buffers. */
+LZFSE_INLINE void copy8(void *dst, const void *src)
+{
+	store8(dst, load8(src));
+}
+LZFSE_INLINE void copy16(void *dst, const void *src)
+{
+	uint64_t m0 = load8(src);
+	uint64_t m1 = load8((const unsigned char *)src + 8);
+	store8(dst, m0);
+	store8((unsigned char *)dst + 8, m1);
+}
+
+/*  ===============================================================
+ *  Bitfield Operations
+ */
+
+/*! @abstract Extracts \p width bits from \p container, starting with \p lsb; if
+ * we view \p container as a bit array, we extract \c container[lsb:lsb+width]. */
+LZFSE_INLINE uintmax_t extract(uintmax_t container, unsigned lsb,
+			       unsigned width)
+{
+	static const size_t container_width = sizeof container * 8;
+	if (width == container_width)
+		return container;
+	return (container >> lsb) & (((uintmax_t)1 << width) - 1);
+}
+
+/*! @abstract Inserts \p width bits from \p data into \p container, starting with \p lsb.
+ *  Viewed as bit arrays, the operations is:
+ * @code
+ * container[:lsb] is unchanged
+ * container[lsb:lsb+width] <-- data[0:width]
+ * container[lsb+width:] is unchanged
+ * @endcode
+ */
+LZFSE_INLINE uintmax_t insert(uintmax_t container, uintmax_t data, unsigned lsb,
+			      unsigned width)
+{
+	static const size_t container_width = sizeof container * 8;
+	uintmax_t mask;
+	if (width == container_width)
+		return container;
+	mask = ((uintmax_t)1 << width) - 1;
+	return (container & ~(mask << lsb)) | (data & mask) << lsb;
+}
+
+/*! @abstract Perform sanity checks on the values of lzfse_compressed_block_header_v1.
+ * Test that the field values are in the allowed limits, verify that the
+ * frequency tables sum to value less than total number of states.
+ * @return 0 if all tests passed.
+ * @return negative error code with 1 bit set for each failed test. */
+LZFSE_INLINE int
+lzfse_check_block_header_v1(const lzfse_compressed_block_header_v1 *header)
+{
+	int tests_results = 0;
+	uint16_t literal_state[4];
+	int res;
+	tests_results = tests_results |
+			((header->magic == LZFSE_COMPRESSEDV1_BLOCK_MAGIC) ?
+				 0 :
+				 (1 << 0));
+	tests_results = tests_results |
+			((header->n_literals <= LZFSE_LITERALS_PER_BLOCK) ?
+				 0 :
+				 (1 << 1));
+	tests_results =
+		tests_results |
+		((header->n_matches <= LZFSE_MATCHES_PER_BLOCK) ? 0 : (1 << 2));
+
+	memcpy(literal_state, header->literal_state, sizeof(uint16_t) * 4);
+
+	tests_results = tests_results |
+			((literal_state[0] < LZFSE_ENCODE_LITERAL_STATES) ?
+				 0 :
+				 (1 << 3));
+	tests_results = tests_results |
+			((literal_state[1] < LZFSE_ENCODE_LITERAL_STATES) ?
+				 0 :
+				 (1 << 4));
+	tests_results = tests_results |
+			((literal_state[2] < LZFSE_ENCODE_LITERAL_STATES) ?
+				 0 :
+				 (1 << 5));
+	tests_results = tests_results |
+			((literal_state[3] < LZFSE_ENCODE_LITERAL_STATES) ?
+				 0 :
+				 (1 << 6));
+
+	tests_results =
+		tests_results |
+		((header->l_state < LZFSE_ENCODE_L_STATES) ? 0 : (1 << 7));
+	tests_results =
+		tests_results |
+		((header->m_state < LZFSE_ENCODE_M_STATES) ? 0 : (1 << 8));
+	tests_results =
+		tests_results |
+		((header->d_state < LZFSE_ENCODE_D_STATES) ? 0 : (1 << 9));
+
+	res = fse_check_freq(header->l_freq, LZFSE_ENCODE_L_SYMBOLS,
+			     LZFSE_ENCODE_L_STATES);
+	tests_results = tests_results | ((res == 0) ? 0 : (1 << 10));
+	res = fse_check_freq(header->m_freq, LZFSE_ENCODE_M_SYMBOLS,
+			     LZFSE_ENCODE_M_STATES);
+	tests_results = tests_results | ((res == 0) ? 0 : (1 << 11));
+	res = fse_check_freq(header->d_freq, LZFSE_ENCODE_D_SYMBOLS,
+			     LZFSE_ENCODE_D_STATES);
+	tests_results = tests_results | ((res == 0) ? 0 : (1 << 12));
+	res = fse_check_freq(header->literal_freq, LZFSE_ENCODE_LITERAL_SYMBOLS,
+			     LZFSE_ENCODE_LITERAL_STATES);
+	tests_results = tests_results | ((res == 0) ? 0 : (1 << 13));
+
+	if (tests_results) {
+		return tests_results |
+		       0x80000000; // each 1 bit is a test that failed
+			// (except for the sign bit)
+	}
+
+	return 0; // OK
+}
+
+/*  MARK: - L, M, D encoding constants for LZFSE
+ */
+
+/*   Largest encodable L (literal length), M (match length) and D (match
+ *   distance) values.
+ */
+#define LZFSE_ENCODE_MAX_L_VALUE 315
+#define LZFSE_ENCODE_MAX_M_VALUE 2359
+#define LZFSE_ENCODE_MAX_D_VALUE 262139
+
+/*! @abstract The L, M, D data streams are all encoded as a "base" value, which is
+ * FSE-encoded, and an "extra bits" value, which is the difference between
+ * value and base, and is simply represented as a raw bit value (because it
+ * is the low-order bits of a larger number, not much entropy can be
+ * extracted from these bits by more complex encoding schemes). The following
+ * tables represent the number of low-order bits to encode separately and the
+ * base values for each of L, M, and D.
+ *
+ * @note The inverse tables for mapping the other way are significantly larger.
+ * Those tables have been split out to lzfse_encode_tables.h in order to keep
+ * this file relatively small. */
+static const uint8_t l_extra_bits[LZFSE_ENCODE_L_SYMBOLS] = {
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 3, 5, 8
+};
+static const int32_t l_base_value[LZFSE_ENCODE_L_SYMBOLS] = {
+	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 20, 28, 60
+};
+static const uint8_t m_extra_bits[LZFSE_ENCODE_M_SYMBOLS] = {
+	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 5, 8, 11
+};
+static const int32_t m_base_value[LZFSE_ENCODE_M_SYMBOLS] = {
+	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 24, 56, 312
+};
+static const uint8_t d_extra_bits[LZFSE_ENCODE_D_SYMBOLS] = {
+	0,  0,	0,  0,	1,  1,	1,  1,	2,  2,	2,  2,	3,  3,	3,  3,
+	4,  4,	4,  4,	5,  5,	5,  5,	6,  6,	6,  6,	7,  7,	7,  7,
+	8,  8,	8,  8,	9,  9,	9,  9,	10, 10, 10, 10, 11, 11, 11, 11,
+	12, 12, 12, 12, 13, 13, 13, 13, 14, 14, 14, 14, 15, 15, 15, 15
+};
+static const int32_t d_base_value[LZFSE_ENCODE_D_SYMBOLS] = {
+	0,     1,     2,     3,	     4,	     6,	     8,	     10,
+	12,    16,    20,    24,     28,     36,     44,     52,
+	60,    76,    92,    108,    124,    156,    188,    220,
+	252,   316,   380,   444,    508,    636,    764,    892,
+	1020,  1276,  1532,  1788,   2044,   2556,   3068,   3580,
+	4092,  5116,  6140,  7164,   8188,   10236,  12284,  14332,
+	16380, 20476, 24572, 28668,  32764,  40956,  49148,  57340,
+	65532, 81916, 98300, 114684, 131068, 163836, 196604, 229372
+};
+
+#endif // LZFSE_INTERNAL_H
diff --git a/drivers/staging/apfs/lzfse/lzfse_tunables.h b/drivers/staging/apfs/lzfse/lzfse_tunables.h
new file mode 100644
index 0000000000000000000000000000000000000000..cb699bba5bf175a4ad525403f958d0c29aaee4e4
--- /dev/null
+++ b/drivers/staging/apfs/lzfse/lzfse_tunables.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+/*
+ * Copyright (c) 2015-2016, Apple Inc. All rights reserved.
+ *
+ */
+
+#ifndef LZFSE_TUNABLES_H
+#define LZFSE_TUNABLES_H
+
+/*   Parameters controlling details of the LZ-style match search. These values
+ *   may be modified to fine tune compression ratio vs. encoding speed, while
+ *   keeping the compressed format compatible with LZFSE. Note that
+ *   modifying them will also change the amount of work space required by
+ *   the encoder. The values here are those used in the compression library
+ *   on iOS and OS X.
+ */
+
+/*   Number of bits for hash function to produce. Should be in the range
+ *   [10, 16]. Larger values reduce the number of false-positive found during
+ *   the match search, and expand the history table, which may allow additional
+ *   matches to be found, generally improving the achieved compression ratio.
+ *   Larger values also increase the workspace size, and make it less likely
+ *   that the history table will be present in cache, which reduces performance.
+ */
+#define LZFSE_ENCODE_HASH_BITS 14
+
+/*   Number of positions to store for each line in the history table. May
+ *   be either 4 or 8. Using 8 doubles the size of the history table, which
+ *   increases the chance of finding matches (thus improving compression ratio),
+ *   but also increases the workspace size.
+ */
+#define LZFSE_ENCODE_HASH_WIDTH 4
+
+/*   Match length in bytes to cause immediate emission. Generally speaking,
+ *   LZFSE maintains multiple candidate matches and waits to decide which match
+ *   to emit until more information is available. When a match exceeds this
+ *   threshold, it is emitted immediately. Thus, smaller values may give
+ *   somewhat better performance, and larger values may give somewhat better
+ *   compression ratios.
+ */
+#define LZFSE_ENCODE_GOOD_MATCH 40
+
+/*   When the source buffer is very small, LZFSE doesn't compress as well as
+ *   some simpler algorithms. To maintain reasonable compression for these
+ *   cases, we transition to use LZVN instead if the size of the source buffer
+ *   is below this threshold.
+ */
+#define LZFSE_ENCODE_LZVN_THRESHOLD 4096
+
+#endif // LZFSE_TUNABLES_H
diff --git a/drivers/staging/apfs/lzfse/lzvn_decode_base.c b/drivers/staging/apfs/lzfse/lzvn_decode_base.c
new file mode 100644
index 0000000000000000000000000000000000000000..632bdd6e4da3c6e1db4a0e9fe45609b6d68a408e
--- /dev/null
+++ b/drivers/staging/apfs/lzfse/lzvn_decode_base.c
@@ -0,0 +1,721 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2015-2016, Apple Inc. All rights reserved.
+ *
+ */
+
+/*  LZVN low-level decoder
+ */
+
+#include "lzvn_decode_base.h"
+
+#if !defined(HAVE_LABELS_AS_VALUES)
+#  if defined(__GNUC__) || defined(__clang__)
+#    define HAVE_LABELS_AS_VALUES 1
+#  else
+#    define HAVE_LABELS_AS_VALUES 0
+#  endif
+#endif
+
+/*   Both the source and destination buffers are represented by a pointer and
+ *   a length; they are *always* updated in concert using this macro; however
+ *   many bytes the pointer is advanced, the length is decremented by the same
+ *   amount. Thus, pointer + length always points to the byte one past the end
+ *   of the buffer.
+ */
+#define PTR_LEN_INC(_pointer, _length, _increment) \
+	(_pointer += _increment, _length -= _increment)
+
+/*   Update state with current positions and distance, corresponding to the
+ *   beginning of an instruction in both streams
+ */
+#define UPDATE_GOOD \
+	(state->src = src_ptr, state->dst = dst_ptr, state->d_prev = D)
+
+void lzvn_decode(lzvn_decoder_state *state)
+{
+#if HAVE_LABELS_AS_VALUES
+	// Jump table for all instructions
+	static const void *opc_tbl[256] = {
+		&&sml_d, &&sml_d, &&sml_d, &&sml_d, &&sml_d, &&sml_d, &&eos,
+		&&lrg_d, &&sml_d, &&sml_d, &&sml_d, &&sml_d, &&sml_d, &&sml_d,
+		&&nop,	 &&lrg_d, &&sml_d, &&sml_d, &&sml_d, &&sml_d, &&sml_d,
+		&&sml_d, &&nop,	  &&lrg_d, &&sml_d, &&sml_d, &&sml_d, &&sml_d,
+		&&sml_d, &&sml_d, &&udef,  &&lrg_d, &&sml_d, &&sml_d, &&sml_d,
+		&&sml_d, &&sml_d, &&sml_d, &&udef,  &&lrg_d, &&sml_d, &&sml_d,
+		&&sml_d, &&sml_d, &&sml_d, &&sml_d, &&udef,  &&lrg_d, &&sml_d,
+		&&sml_d, &&sml_d, &&sml_d, &&sml_d, &&sml_d, &&udef,  &&lrg_d,
+		&&sml_d, &&sml_d, &&sml_d, &&sml_d, &&sml_d, &&sml_d, &&udef,
+		&&lrg_d, &&sml_d, &&sml_d, &&sml_d, &&sml_d, &&sml_d, &&sml_d,
+		&&pre_d, &&lrg_d, &&sml_d, &&sml_d, &&sml_d, &&sml_d, &&sml_d,
+		&&sml_d, &&pre_d, &&lrg_d, &&sml_d, &&sml_d, &&sml_d, &&sml_d,
+		&&sml_d, &&sml_d, &&pre_d, &&lrg_d, &&sml_d, &&sml_d, &&sml_d,
+		&&sml_d, &&sml_d, &&sml_d, &&pre_d, &&lrg_d, &&sml_d, &&sml_d,
+		&&sml_d, &&sml_d, &&sml_d, &&sml_d, &&pre_d, &&lrg_d, &&sml_d,
+		&&sml_d, &&sml_d, &&sml_d, &&sml_d, &&sml_d, &&pre_d, &&lrg_d,
+		&&udef,	 &&udef,  &&udef,  &&udef,  &&udef,  &&udef,  &&udef,
+		&&udef,	 &&udef,  &&udef,  &&udef,  &&udef,  &&udef,  &&udef,
+		&&udef,	 &&udef,  &&sml_d, &&sml_d, &&sml_d, &&sml_d, &&sml_d,
+		&&sml_d, &&pre_d, &&lrg_d, &&sml_d, &&sml_d, &&sml_d, &&sml_d,
+		&&sml_d, &&sml_d, &&pre_d, &&lrg_d, &&sml_d, &&sml_d, &&sml_d,
+		&&sml_d, &&sml_d, &&sml_d, &&pre_d, &&lrg_d, &&sml_d, &&sml_d,
+		&&sml_d, &&sml_d, &&sml_d, &&sml_d, &&pre_d, &&lrg_d, &&med_d,
+		&&med_d, &&med_d, &&med_d, &&med_d, &&med_d, &&med_d, &&med_d,
+		&&med_d, &&med_d, &&med_d, &&med_d, &&med_d, &&med_d, &&med_d,
+		&&med_d, &&med_d, &&med_d, &&med_d, &&med_d, &&med_d, &&med_d,
+		&&med_d, &&med_d, &&med_d, &&med_d, &&med_d, &&med_d, &&med_d,
+		&&med_d, &&med_d, &&med_d, &&sml_d, &&sml_d, &&sml_d, &&sml_d,
+		&&sml_d, &&sml_d, &&pre_d, &&lrg_d, &&sml_d, &&sml_d, &&sml_d,
+		&&sml_d, &&sml_d, &&sml_d, &&pre_d, &&lrg_d, &&udef,  &&udef,
+		&&udef,	 &&udef,  &&udef,  &&udef,  &&udef,  &&udef,  &&udef,
+		&&udef,	 &&udef,  &&udef,  &&udef,  &&udef,  &&udef,  &&udef,
+		&&lrg_l, &&sml_l, &&sml_l, &&sml_l, &&sml_l, &&sml_l, &&sml_l,
+		&&sml_l, &&sml_l, &&sml_l, &&sml_l, &&sml_l, &&sml_l, &&sml_l,
+		&&sml_l, &&sml_l, &&lrg_m, &&sml_m, &&sml_m, &&sml_m, &&sml_m,
+		&&sml_m, &&sml_m, &&sml_m, &&sml_m, &&sml_m, &&sml_m, &&sml_m,
+		&&sml_m, &&sml_m, &&sml_m, &&sml_m
+	};
+#endif
+	size_t src_len = state->src_end - state->src;
+	size_t dst_len = state->dst_end - state->dst;
+	const unsigned char *src_ptr = state->src;
+	unsigned char *dst_ptr = state->dst;
+	size_t D = state->d_prev;
+	size_t M;
+	size_t L;
+	size_t opc_len;
+	unsigned char opc;
+	uint16_t opc23;
+
+	if (src_len == 0 || dst_len == 0)
+		return; // empty buffer
+
+	// Do we have a partially expanded match saved in state?
+	if (state->L != 0 || state->M != 0) {
+		L = state->L;
+		M = state->M;
+		D = state->D;
+		opc_len = 0; // we already skipped the op
+		state->L = state->M = state->D = 0;
+		if (M == 0)
+			goto copy_literal;
+		if (L == 0)
+			goto copy_match;
+		goto copy_literal_and_match;
+	}
+
+	opc = src_ptr[0];
+
+#if HAVE_LABELS_AS_VALUES
+	goto *opc_tbl[opc];
+#else
+	for (;;) {
+		switch (opc) {
+#endif
+/*   ===============================================================
+ *   These four opcodes (sml_d, med_d, lrg_d, and pre_d) encode both a
+ *   literal and a match. The bulk of their implementations are shared;
+ *   each label here only does the work of setting the opcode length (not
+ *   including any literal bytes), and extracting the literal length, match
+ *   length, and match distance (except in pre_d). They then jump into the
+ *   shared implementation to actually output the literal and match bytes.
+ * 
+ *   No error checking happens in the first stage, except for ensuring that
+ *   the source has enough length to represent the full opcode before
+ *   reading past the first byte.
+ */
+sml_d:
+#if !HAVE_LABELS_AS_VALUES
+case 0:
+case 1:
+case 2:
+case 3:
+case 4:
+case 5:
+case 8:
+case 9:
+case 10:
+case 11:
+case 12:
+case 13:
+case 16:
+case 17:
+case 18:
+case 19:
+case 20:
+case 21:
+case 24:
+case 25:
+case 26:
+case 27:
+case 28:
+case 29:
+case 32:
+case 33:
+case 34:
+case 35:
+case 36:
+case 37:
+case 40:
+case 41:
+case 42:
+case 43:
+case 44:
+case 45:
+case 48:
+case 49:
+case 50:
+case 51:
+case 52:
+case 53:
+case 56:
+case 57:
+case 58:
+case 59:
+case 60:
+case 61:
+case 64:
+case 65:
+case 66:
+case 67:
+case 68:
+case 69:
+case 72:
+case 73:
+case 74:
+case 75:
+case 76:
+case 77:
+case 80:
+case 81:
+case 82:
+case 83:
+case 84:
+case 85:
+case 88:
+case 89:
+case 90:
+case 91:
+case 92:
+case 93:
+case 96:
+case 97:
+case 98:
+case 99:
+case 100:
+case 101:
+case 104:
+case 105:
+case 106:
+case 107:
+case 108:
+case 109:
+case 128:
+case 129:
+case 130:
+case 131:
+case 132:
+case 133:
+case 136:
+case 137:
+case 138:
+case 139:
+case 140:
+case 141:
+case 144:
+case 145:
+case 146:
+case 147:
+case 148:
+case 149:
+case 152:
+case 153:
+case 154:
+case 155:
+case 156:
+case 157:
+case 192:
+case 193:
+case 194:
+case 195:
+case 196:
+case 197:
+case 200:
+case 201:
+case 202:
+case 203:
+case 204:
+case 205:
+#endif
+	UPDATE_GOOD;
+	// "small distance": This opcode has the structure LLMMMDDD DDDDDDDD LITERAL
+	//  where the length of literal (0-3 bytes) is encoded by the high 2 bits of
+	//  the first byte. We first extract the literal length so we know how long
+	//  the opcode is, then check that the source can hold both this opcode and
+	//  at least one byte of the next (because any valid input stream must be
+	//  terminated with an eos token).
+	opc_len = 2;
+	L = (size_t)extract(opc, 6, 2);
+	M = (size_t)extract(opc, 3, 3) + 3;
+	//  We need to ensure that the source buffer is long enough that we can
+	//  safely read this entire opcode, the literal that follows, and the first
+	//  byte of the next opcode.  Once we satisfy this requirement, we can
+	//  safely unpack the match distance. A check similar to this one is
+	//  present in all the opcode implementations.
+	if (src_len <= opc_len + L)
+		return; // source truncated
+	D = (size_t)extract(opc, 0, 3) << 8 | src_ptr[1];
+	goto copy_literal_and_match;
+
+med_d:
+#if !HAVE_LABELS_AS_VALUES
+case 160:
+case 161:
+case 162:
+case 163:
+case 164:
+case 165:
+case 166:
+case 167:
+case 168:
+case 169:
+case 170:
+case 171:
+case 172:
+case 173:
+case 174:
+case 175:
+case 176:
+case 177:
+case 178:
+case 179:
+case 180:
+case 181:
+case 182:
+case 183:
+case 184:
+case 185:
+case 186:
+case 187:
+case 188:
+case 189:
+case 190:
+case 191:
+#endif
+	UPDATE_GOOD;
+	//  "medium distance": This is a minor variant of the "small distance"
+	//  encoding, where we will now use two extra bytes instead of one to encode
+	//  the restof the match length and distance. This allows an extra two bits
+	//  for the match length, and an extra three bits for the match distance. The
+	//  full structure of the opcode is 101LLMMM DDDDDDMM DDDDDDDD LITERAL.
+	opc_len = 3;
+	L = (size_t)extract(opc, 3, 2);
+	if (src_len <= opc_len + L)
+		return; // source truncated
+	opc23 = load2(&src_ptr[1]);
+	M = (size_t)((extract(opc, 0, 3) << 2 | extract(opc23, 0, 2)) + 3);
+	D = (size_t)extract(opc23, 2, 14);
+	goto copy_literal_and_match;
+
+lrg_d:
+#if !HAVE_LABELS_AS_VALUES
+case 7:
+case 15:
+case 23:
+case 31:
+case 39:
+case 47:
+case 55:
+case 63:
+case 71:
+case 79:
+case 87:
+case 95:
+case 103:
+case 111:
+case 135:
+case 143:
+case 151:
+case 159:
+case 199:
+case 207:
+#endif
+	UPDATE_GOOD;
+	//  "large distance": This is another variant of the "small distance"
+	//  encoding, where we will now use two extra bytes to encode the match
+	//  distance, which allows distances up to 65535 to be represented. The full
+	//  structure of the opcode is LLMMM111 DDDDDDDD DDDDDDDD LITERAL.
+	opc_len = 3;
+	L = (size_t)extract(opc, 6, 2);
+	M = (size_t)extract(opc, 3, 3) + 3;
+	if (src_len <= opc_len + L)
+		return; // source truncated
+	D = load2(&src_ptr[1]);
+	goto copy_literal_and_match;
+
+pre_d:
+#if !HAVE_LABELS_AS_VALUES
+case 70:
+case 78:
+case 86:
+case 94:
+case 102:
+case 110:
+case 134:
+case 142:
+case 150:
+case 158:
+case 198:
+case 206:
+#endif
+	UPDATE_GOOD;
+	//  "previous distance": This opcode has the structure LLMMM110, where the
+	//  length of the literal (0-3 bytes) is encoded by the high 2 bits of the
+	//  first byte. We first extract the literal length so we know how long
+	//  the opcode is, then check that the source can hold both this opcode and
+	//  at least one byte of the next (because any valid input stream must be
+	//  terminated with an eos token).
+	opc_len = 1;
+	L = (size_t)extract(opc, 6, 2);
+	M = (size_t)extract(opc, 3, 3) + 3;
+	if (src_len <= opc_len + L)
+		return; // source truncated
+	goto copy_literal_and_match;
+
+copy_literal_and_match:
+	//  Common implementation of writing data for opcodes that have both a
+	//  literal and a match. We begin by advancing the source pointer past
+	//  the opcode, so that it points at the first literal byte (if L
+	//  is non-zero; otherwise it points at the next opcode).
+	PTR_LEN_INC(src_ptr, src_len, opc_len);
+	//  Now we copy the literal from the source pointer to the destination.
+	if (__builtin_expect(dst_len >= 4 && src_len >= 4, 1)) {
+		//  The literal is 0-3 bytes; if we are not near the end of the buffer,
+		//  we can safely just do a 4 byte copy (which is guaranteed to cover
+		//  the complete literal, and may include some other bytes as well).
+		store4(dst_ptr, load4(src_ptr));
+	} else if (L <= dst_len) {
+		//  We are too close to the end of either the input or output stream
+		//  to be able to safely use a four-byte copy, but we will not exhaust
+		//  either stream (we already know that the source will not be
+		//  exhausted from checks in the individual opcode implementations,
+		//  and we just tested that dst_len > L). Thus, we need to do a
+		//  byte-by-byte copy of the literal. This is slow, but it can only ever
+		//  happen near the very end of a buffer, so it is not an important case to
+		//  optimize.
+		size_t i;
+		for (i = 0; i < L; ++i)
+			dst_ptr[i] = src_ptr[i];
+	} else {
+		// Destination truncated: fill DST, and store partial match
+
+		// Copy partial literal
+		size_t i;
+		for (i = 0; i < dst_len; ++i)
+			dst_ptr[i] = src_ptr[i];
+		// Save state
+		state->src = src_ptr + dst_len;
+		state->dst = dst_ptr + dst_len;
+		state->L = L - dst_len;
+		state->M = M;
+		state->D = D;
+		return; // destination truncated
+	}
+	//  Having completed the copy of the literal, we advance both the source
+	//  and destination pointers by the number of literal bytes.
+	PTR_LEN_INC(dst_ptr, dst_len, L);
+	PTR_LEN_INC(src_ptr, src_len, L);
+	//  Check if the match distance is valid; matches must not reference
+	//  bytes that preceed the start of the output buffer, nor can the match
+	//  distance be zero.
+	if (D > dst_ptr - state->dst_begin || D == 0)
+		goto invalid_match_distance;
+copy_match:
+	//  Now we copy the match from dst_ptr - D to dst_ptr. It is important to keep
+	//  in mind that we may have D < M, in which case the source and destination
+	//  windows overlap in the copy. The semantics of the match copy are *not*
+	//  those of memmove( ); if the buffers overlap it needs to behave as though
+	//  we were copying byte-by-byte in increasing address order. If, for example,
+	//  D is 1, the copy operation is equivalent to:
+	//
+	//      memset(dst_ptr, dst_ptr[-1], M);
+	//
+	//  i.e. it splats the previous byte. This means that we need to be very
+	//  careful about using wide loads or stores to perform the copy operation.
+	if (__builtin_expect(dst_len >= M + 7 && D >= 8, 1)) {
+		//  We are not near the end of the buffer, and the match distance
+		//  is at least eight. Thus, we can safely loop using eight byte
+		//  copies. The last of these may slop over the intended end of
+		//  the match, but this is OK because we know we have a safety bound
+		//  away from the end of the destination buffer.
+		size_t i;
+		for (i = 0; i < M; i += 8)
+			store8(&dst_ptr[i], load8(&dst_ptr[i - D]));
+	} else if (M <= dst_len) {
+		//  Either the match distance is too small, or we are too close to
+		//  the end of the buffer to safely use eight byte copies. Fall back
+		//  on a simple byte-by-byte implementation.
+		size_t i;
+		for (i = 0; i < M; ++i)
+			dst_ptr[i] = dst_ptr[i - D];
+	} else {
+		// Destination truncated: fill DST, and store partial match
+
+		// Copy partial match
+		size_t i;
+		for (i = 0; i < dst_len; ++i)
+			dst_ptr[i] = dst_ptr[i - D];
+		// Save state
+		state->src = src_ptr;
+		state->dst = dst_ptr + dst_len;
+		state->L = 0;
+		state->M = M - dst_len;
+		state->D = D;
+		return; // destination truncated
+	}
+	//  Update the destination pointer and length to account for the bytes
+	//  written by the match, then load the next opcode byte and branch to
+	//  the appropriate implementation.
+	PTR_LEN_INC(dst_ptr, dst_len, M);
+	opc = src_ptr[0];
+#if HAVE_LABELS_AS_VALUES
+	goto *opc_tbl[opc];
+#else
+			break;
+#endif
+
+/*  ===============================================================
+ *  Opcodes representing only a match (no literal).
+ *   These two opcodes (lrg_m and sml_m) encode only a match. The match
+ *   distance is carried over from the previous opcode, so all they need
+ *   to encode is the match length. We are able to reuse the match copy
+ *   sequence from the literal and match opcodes to perform the actual
+ *   copy implementation.
+ */
+sml_m:
+#if !HAVE_LABELS_AS_VALUES
+case 241:
+case 242:
+case 243:
+case 244:
+case 245:
+case 246:
+case 247:
+case 248:
+case 249:
+case 250:
+case 251:
+case 252:
+case 253:
+case 254:
+case 255:
+#endif
+	UPDATE_GOOD;
+	//  "small match": This opcode has no literal, and uses the previous match
+	//  distance (i.e. it encodes only the match length), in a single byte as
+	//  1111MMMM.
+	opc_len = 1;
+	if (src_len <= opc_len)
+		return; // source truncated
+	M = (size_t)extract(opc, 0, 4);
+	PTR_LEN_INC(src_ptr, src_len, opc_len);
+	goto copy_match;
+
+lrg_m:
+#if !HAVE_LABELS_AS_VALUES
+case 240:
+#endif
+	UPDATE_GOOD;
+	//  "large match": This opcode has no literal, and uses the previous match
+	//  distance (i.e. it encodes only the match length). It is encoded in two
+	//  bytes as 11110000 MMMMMMMM.  Because matches smaller than 16 bytes can
+	//  be represented by sml_m, there is an implicit bias of 16 on the match
+	//  length; the representable values are [16,271].
+	opc_len = 2;
+	if (src_len <= opc_len)
+		return; // source truncated
+	M = src_ptr[1] + 16;
+	PTR_LEN_INC(src_ptr, src_len, opc_len);
+	goto copy_match;
+
+/*  ===============================================================
+ *  Opcodes representing only a literal (no match).
+ *   These two opcodes (lrg_l and sml_l) encode only a literal.  There is no
+ *   match length or match distance to worry about (but we need to *not*
+ *   touch D, as it must be preserved between opcodes).
+ */
+sml_l:
+#if !HAVE_LABELS_AS_VALUES
+case 225:
+case 226:
+case 227:
+case 228:
+case 229:
+case 230:
+case 231:
+case 232:
+case 233:
+case 234:
+case 235:
+case 236:
+case 237:
+case 238:
+case 239:
+#endif
+	UPDATE_GOOD;
+	//  "small literal": This opcode has no match, and encodes only a literal
+	//  of length up to 15 bytes. The format is 1110LLLL LITERAL.
+	opc_len = 1;
+	L = (size_t)extract(opc, 0, 4);
+	goto copy_literal;
+
+lrg_l:
+#if !HAVE_LABELS_AS_VALUES
+case 224:
+#endif
+	UPDATE_GOOD;
+	//  "large literal": This opcode has no match, and uses the previous match
+	//  distance (i.e. it encodes only the match length). It is encoded in two
+	//  bytes as 11100000 LLLLLLLL LITERAL.  Because literals smaller than 16
+	//  bytes can be represented by sml_l, there is an implicit bias of 16 on
+	//  the literal length; the representable values are [16,271].
+	opc_len = 2;
+	if (src_len <= 2)
+		return; // source truncated
+	L = src_ptr[1] + 16;
+	goto copy_literal;
+
+copy_literal:
+	//  Check that the source buffer is large enough to hold the complete
+	//  literal and at least the first byte of the next opcode. If so, advance
+	//  the source pointer to point to the first byte of the literal and adjust
+	//  the source length accordingly.
+	if (src_len <= opc_len + L)
+		return; // source truncated
+	PTR_LEN_INC(src_ptr, src_len, opc_len);
+	//  Now we copy the literal from the source pointer to the destination.
+	if (dst_len >= L + 7 && src_len >= L + 7) {
+		//  We are not near the end of the source or destination buffers; thus
+		//  we can safely copy the literal using wide copies, without worrying
+		//  about reading or writing past the end of either buffer.
+		size_t i;
+		for (i = 0; i < L; i += 8)
+			store8(&dst_ptr[i], load8(&src_ptr[i]));
+	} else if (L <= dst_len) {
+		//  We are too close to the end of either the input or output stream
+		//  to be able to safely use an eight-byte copy. Instead we copy the
+		//  literal byte-by-byte.
+		size_t i;
+		for (i = 0; i < L; ++i)
+			dst_ptr[i] = src_ptr[i];
+	} else {
+		// Destination truncated: fill DST, and store partial match
+
+		// Copy partial literal
+		size_t i;
+		for (i = 0; i < dst_len; ++i)
+			dst_ptr[i] = src_ptr[i];
+		// Save state
+		state->src = src_ptr + dst_len;
+		state->dst = dst_ptr + dst_len;
+		state->L = L - dst_len;
+		state->M = 0;
+		state->D = D;
+		return; // destination truncated
+	}
+	//  Having completed the copy of the literal, we advance both the source
+	//  and destination pointers by the number of literal bytes.
+	PTR_LEN_INC(dst_ptr, dst_len, L);
+	PTR_LEN_INC(src_ptr, src_len, L);
+	//  Load the first byte of the next opcode, and jump to its implementation.
+	opc = src_ptr[0];
+#if HAVE_LABELS_AS_VALUES
+	goto *opc_tbl[opc];
+#else
+			break;
+#endif
+
+/*  ===============================================================
+ *  Other opcodes
+ */
+nop:
+#if !HAVE_LABELS_AS_VALUES
+case 14:
+case 22:
+#endif
+	UPDATE_GOOD;
+	opc_len = 1;
+	if (src_len <= opc_len)
+		return; // source truncated
+	PTR_LEN_INC(src_ptr, src_len, opc_len);
+	opc = src_ptr[0];
+#if HAVE_LABELS_AS_VALUES
+	goto *opc_tbl[opc];
+#else
+			break;
+#endif
+
+eos:
+#if !HAVE_LABELS_AS_VALUES
+case 6:
+#endif
+	opc_len = 8;
+	if (src_len < opc_len)
+		return; // source truncated (here we don't need an extra byte for next op
+			// code)
+	PTR_LEN_INC(src_ptr, src_len, opc_len);
+	state->end_of_stream = 1;
+	UPDATE_GOOD;
+	return; // end-of-stream
+
+/*  ===============================================================
+ *  Return on error
+ */
+udef:
+#if !HAVE_LABELS_AS_VALUES
+case 30:
+case 38:
+case 46:
+case 54:
+case 62:
+case 112:
+case 113:
+case 114:
+case 115:
+case 116:
+case 117:
+case 118:
+case 119:
+case 120:
+case 121:
+case 122:
+case 123:
+case 124:
+case 125:
+case 126:
+case 127:
+case 208:
+case 209:
+case 210:
+case 211:
+case 212:
+case 213:
+case 214:
+case 215:
+case 216:
+case 217:
+case 218:
+case 219:
+case 220:
+case 221:
+case 222:
+case 223:
+#endif
+invalid_match_distance:
+
+	return; // we already updated state
+#if !HAVE_LABELS_AS_VALUES
+}
+}
+#endif
+}
diff --git a/drivers/staging/apfs/lzfse/lzvn_decode_base.h b/drivers/staging/apfs/lzfse/lzvn_decode_base.h
new file mode 100644
index 0000000000000000000000000000000000000000..ef6b0244cbf8adb15a77a68c920753adce7d93b4
--- /dev/null
+++ b/drivers/staging/apfs/lzfse/lzvn_decode_base.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+/*
+ * Copyright (c) 2015-2016, Apple Inc. All rights reserved.
+ *
+ */
+
+/*  LZVN low-level decoder (v2)
+ *  Functions in the low-level API should switch to these at some point.
+ *  Apr 2014
+ */
+
+#ifndef LZVN_DECODE_BASE_H
+#define LZVN_DECODE_BASE_H
+
+#include "lzfse_internal.h"
+
+/*! @abstract Base decoder state. */
+typedef struct {
+	// Decoder I/O
+
+	// Next byte to read in source buffer
+	const unsigned char *src;
+	// Next byte after source buffer
+	const unsigned char *src_end;
+
+	// Next byte to write in destination buffer (by decoder)
+	unsigned char *dst;
+	// Valid range for destination buffer is [dst_begin, dst_end - 1]
+	unsigned char *dst_begin;
+	unsigned char *dst_end;
+	// Next byte to read in destination buffer (modified by caller)
+	unsigned char *dst_current;
+
+	// Decoder state
+
+	// Partially expanded match, or 0,0,0.
+	// In that case, src points to the next literal to copy, or the next op-code
+	// if L==0.
+	size_t L, M, D;
+
+	// Distance for last emitted match, or 0
+	lzvn_offset d_prev;
+
+	// Did we decode end-of-stream?
+	int end_of_stream;
+
+} lzvn_decoder_state;
+
+/*! @abstract Decode source to destination.
+ *  Updates \p state (src,dst,d_prev). */
+void lzvn_decode(lzvn_decoder_state *state);
+
+#endif // LZVN_DECODE_BASE_H
diff --git a/drivers/staging/apfs/lzfse/lzvn_encode_base.h b/drivers/staging/apfs/lzfse/lzvn_encode_base.h
new file mode 100644
index 0000000000000000000000000000000000000000..c65457143bb5d330c6172d690993250e3a6aab77
--- /dev/null
+++ b/drivers/staging/apfs/lzfse/lzvn_encode_base.h
@@ -0,0 +1,105 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+/*
+ * Copyright (c) 2015-2016, Apple Inc. All rights reserved.
+ *
+ */
+
+/*  LZVN low-level encoder
+ */
+
+#ifndef LZVN_ENCODE_BASE_H
+#define LZVN_ENCODE_BASE_H
+
+#include "lzfse_internal.h"
+
+/*  ===============================================================
+ *  Types and Constants
+ */
+
+#define LZVN_ENCODE_HASH_BITS \
+	14 // number of bits returned by the hash function [10, 16]
+#define LZVN_ENCODE_OFFSETS_PER_HASH \
+	4 // stored offsets stack for each hash value, MUST be 4
+#define LZVN_ENCODE_HASH_VALUES \
+	(1 << LZVN_ENCODE_HASH_BITS) // number of entries in hash table
+#define LZVN_ENCODE_MAX_DISTANCE                                                  \
+	0xffff // max match distance we can represent with LZVN encoding, MUST be \
+		// 0xFFFF
+#define LZVN_ENCODE_MIN_MARGIN                                                     \
+	8 // min number of bytes required between current and end during encoding, \
+		// MUST be >= 8
+#define LZVN_ENCODE_MAX_LITERAL_BACKLOG                                         \
+	400 // if the number of pending literals exceeds this size, emit a long \
+		// literal, MUST be >= 271
+
+/*! @abstract Type of table entry. */
+typedef struct {
+	int32_t indices[4]; // signed indices in source buffer
+	uint32_t values[4]; // corresponding 32-bit values
+} lzvn_encode_entry_type;
+
+/*  Work size
+ */
+#define LZVN_ENCODE_WORK_SIZE \
+	(LZVN_ENCODE_HASH_VALUES * sizeof(lzvn_encode_entry_type))
+
+/*! @abstract Match */
+typedef struct {
+	lzvn_offset m_begin; // beginning of match, current position
+	lzvn_offset
+		m_end; // end of match, this is where the next literal would begin
+		// if we emit the entire match
+	lzvn_offset M; // match length M: m_end - m_begin
+	lzvn_offset D; // match distance D
+	lzvn_offset K; // match gain: M - distance storage (L not included)
+} lzvn_match_info;
+
+/*  ===============================================================
+ *  Internal encoder state
+ */
+
+/*! @abstract Base encoder state and I/O. */
+typedef struct {
+	// Encoder I/O
+
+	// Source buffer
+	const unsigned char *src;
+	// Valid range in source buffer: we can access src[i] for src_begin <= i <
+	// src_end. src_begin may be negative.
+	lzvn_offset src_begin;
+	lzvn_offset src_end;
+	// Next byte to process in source buffer
+	lzvn_offset src_current;
+	// Next byte after the last byte to process in source buffer. We MUST have:
+	// src_current_end + 8 <= src_end.
+	lzvn_offset src_current_end;
+	// Next byte to encode in source buffer, may be before or after src_current.
+	lzvn_offset src_literal;
+
+	// Next byte to write in destination buffer
+	unsigned char *dst;
+	// Valid range in destination buffer: [dst_begin, dst_end - 1]
+	unsigned char *dst_begin;
+	unsigned char *dst_end;
+
+	// Encoder state
+
+	// Pending match
+	lzvn_match_info pending;
+
+	// Distance for last emitted match, or 0
+	lzvn_offset d_prev;
+
+	// Hash table used to find matches. Stores LZVN_ENCODE_OFFSETS_PER_HASH 32-bit
+	// signed indices in the source buffer, and the corresponding 4-byte values.
+	// The number of entries in the table is LZVN_ENCODE_HASH_VALUES.
+	lzvn_encode_entry_type *table;
+
+} lzvn_encoder_state;
+
+/*! @abstract Encode source to destination.
+ *  Update \p state.
+ *  The call ensures \c src_literal is never left too far behind \c src_current. */
+void lzvn_encode(lzvn_encoder_state *state);
+
+#endif // LZVN_ENCODE_BASE_H

-- 
2.48.1


