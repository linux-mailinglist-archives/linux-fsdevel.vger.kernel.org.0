Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C083F701BAB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 May 2023 07:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjENFpl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 May 2023 01:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjENFpj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 May 2023 01:45:39 -0400
Received: from out-15.mta0.migadu.com (out-15.mta0.migadu.com [IPv6:2001:41d0:1004:224b::f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66281FDB
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 May 2023 22:45:37 -0700 (PDT)
Date:   Sun, 14 May 2023 01:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684043134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qjw9R07t509s4y9z5LtStC5k9C/e0uq9CvIhkbXJnQc=;
        b=O+AZ8Mb+2d7xaS2/Gh0spUNLJ9ot0yP8kYnoSU4+o7Lhb7xJ5fQYOv9b7C/5Wfz7SoXD9p
        YgC1kS5j8+4EAMT6uG7PtwPjb5JHKDnLgZzc0Z11vnbmcNLFHaY0ugHEOF84WYbGz9CnRd
        6DtNe8XUAt8LpqtqpceWYji9TIp44cU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Message-ID: <ZGB1eevk/u2ssIBT@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <ZFqxEWqD19eHe353@infradead.org>
 <ZFq3SdSBJ_LWsOgd@murray>
 <ZFq7JhrhyrMTNfd/@moria.home.lan>
 <20230510064849.GC1851@quark.localdomain>
 <ZF6HHRDeUWLNtuL7@moria.home.lan>
 <20230513015752.GC3033@quark.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230513015752.GC3033@quark.localdomain>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 12, 2023 at 06:57:52PM -0700, Eric Biggers wrote:
> First, I wanted to mention that decoding of variable-length fields has been
> extensively studied for decompression algorithms, e.g. for Huffman decoding.
> And it turns out that it can be done branchlessly.  The basic idea is that you
> have a branchless refill step that looks like the following:
> 
> #define REFILL_BITS_BRANCHLESS()                    \
>         bitbuf |= get_unaligned_u64(p) << bitsleft; \
>         p += 7 - ((bitsleft >> 3) & 0x7);           \
>         bitsleft |= 56;
> 
> That branchlessly ensures that 'bitbuf' contains '56 <= bitsleft <= 63' bits.
> Then, the needed number of bits can be removed and returned:
> 
> #define READ_BITS(n)                          \
>         REFILL_BITS_BRANCHLESS();             \
>         tmp = bitbuf & (((u64)1 << (n)) - 1); \
>         bitbuf >>= (n);                       \
>         bitsleft -= (n);                      \
>         tmp
> 
> If you're interested, I can give you some references about the above method.

I might be interested in those references, new bit tricks and integer
encodings are always fun :)

> But, I really just wanted to mention it for completeness, since I think you'd
> actually want to go in a slightly different direction, since (a) you have all
> the field widths available from the beginning, as opposed to being interleaved
> into the bitstream itself (as is the case in Huffman decoding for example), so
> you're not limited to serialized decoding of each field, (b) your fields are up
> to 96 bits, and (c) you've selected a bitstream convention that seems to make it
> such that your stream *must* be read in aligned units of u64, so I don't think
> something like REFILL_BITS_BRANCHLESS() could work for you anyway.
> 
> What I would suggest instead is preprocessing the list of 6 field lengths to
> create some information that can be used to extract all 6 fields branchlessly
> with no dependencies between different fields.  (And you clearly *can* add a
> preprocessing step, as you already have one -- the dynamic code generator.)
> 
> So, something like the following:
> 
>     const struct field_info *info = &format->fields[0];
> 
>     field0 = (in->u64s[info->word_idx] >> info->shift1) & info->mask;
>     field0 |= in->u64s[info->word_idx - 1] >> info->shift2;
> 
> ... but with the code for all 6 fields interleaved.
> 
> On modern CPUs, I think that would be faster than your current C code.
> 
> You could do better by creating variants that are specialized for specific
> common sets of parameters.  During "preprocessing", you would select a variant
> and set an enum accordingly.  During decoding, you would switch on that enum and
> call the appropriate variant.  (This could also be done with a function pointer,
> of course, but indirect calls are slow these days...)

testing random btree updates:

dynamically generated unpack:
rand_insert: 20.0 MiB with 1 threads in    33 sec,  1609 nsec per iter, 607 KiB per sec

old C unpack:
rand_insert: 20.0 MiB with 1 threads in    35 sec,  1672 nsec per iter, 584 KiB per sec

the Eric Biggers special:
rand_insert: 20.0 MiB with 1 threads in    35 sec,  1676 nsec per iter, 583 KiB per sec

Tested two versions of your approach, one without a shift value, one
where we use a shift value to try to avoid unaligned access - second was
perhaps 1% faster

so it's not looking good. This benchmark doesn't even hit on
unpack_key() quite as much as I thought, so the difference is
significant.

diff --git a/fs/bcachefs/bkey.c b/fs/bcachefs/bkey.c
index 6d3a1c096f..128d96766c 100644
--- a/fs/bcachefs/bkey.c
+++ b/fs/bcachefs/bkey.c
@@ -7,6 +7,8 @@
 #include "bset.h"
 #include "util.h"
 
+#include <asm/unaligned.h>
+
 #undef EBUG_ON
 
 #ifdef DEBUG_BKEYS
@@ -19,9 +21,35 @@ const struct bkey_format bch2_bkey_format_current = BKEY_FORMAT_CURRENT;
 
 struct bkey_format_processed bch2_bkey_format_postprocess(const struct bkey_format f)
 {
-	return (struct bkey_format_processed) {
-		.f = f,
-	};
+	struct bkey_format_processed ret = { .f = f, .aligned = true };
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+	unsigned offset = f.key_u64s * 64;
+#else
+	unsigned offset = KEY_PACKED_BITS_START;
+#endif
+
+	for (unsigned i = 0; i < BKEY_NR_FIELDS; i++) {
+		unsigned bits = f.bits_per_field[i];
+
+		if (bits & 7) {
+			ret.aligned = false;
+			break;
+		}
+
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+		offset -= bits;
+#endif
+
+		ret.shift[i]	= min(offset & 63, 64 - bits);
+		ret.offset[i]	= (offset - ret.shift[i]) / 8;
+		ret.mask[i]	= bits ? ~0ULL >> (64 - bits) : 0;
+
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+		offset += bits;
+#endif
+	}
+
+	return ret;
 }
 
 void bch2_bkey_packed_to_binary_text(struct printbuf *out,
@@ -191,6 +219,19 @@ static u64 get_inc_field(struct unpack_state *state, unsigned field)
 	return v + offset;
 }
 
+__always_inline
+static u64 get_aligned_field(const struct bkey_format_processed *f,
+			     const struct bkey_packed *in,
+			     unsigned field_idx)
+{
+	u64 v = get_unaligned((u64 *) (((u8 *) in->_data) + f->offset[field_idx]));
+
+	v >>= f->shift[field_idx];
+	v &= f->mask[field_idx];
+
+	return v + le64_to_cpu(f->f.field_offset[field_idx]);
+}
+
 __always_inline
 static bool set_inc_field(struct pack_state *state, unsigned field, u64 v)
 {
@@ -269,45 +310,57 @@ bool bch2_bkey_transform(const struct bkey_format *out_f,
 	return true;
 }
 
-struct bkey __bch2_bkey_unpack_key(const struct bkey_format_processed *format_p,
+struct bkey __bch2_bkey_unpack_key(const struct bkey_format_processed *format,
 				   const struct bkey_packed *in)
 {
-	const struct bkey_format *format = &format_p->f;
-	struct unpack_state state = unpack_state_init(format, in);
 	struct bkey out;
 
-	EBUG_ON(format->nr_fields != BKEY_NR_FIELDS);
-	EBUG_ON(in->u64s < format->key_u64s);
+	EBUG_ON(format->f.nr_fields != BKEY_NR_FIELDS);
+	EBUG_ON(in->u64s < format->f.key_u64s);
 	EBUG_ON(in->format != KEY_FORMAT_LOCAL_BTREE);
-	EBUG_ON(in->u64s - format->key_u64s + BKEY_U64s > U8_MAX);
+	EBUG_ON(in->u64s - format->f.key_u64s + BKEY_U64s > U8_MAX);
 
-	out.u64s	= BKEY_U64s + in->u64s - format->key_u64s;
+	out.u64s	= BKEY_U64s + in->u64s - format->f.key_u64s;
 	out.format	= KEY_FORMAT_CURRENT;
 	out.needs_whiteout = in->needs_whiteout;
 	out.type	= in->type;
 	out.pad[0]	= 0;
 
+	if (likely(format->aligned)) {
+#define x(id, field)	out.field = get_aligned_field(format, in, id);
+		bkey_fields()
+#undef x
+	} else {
+		struct unpack_state state = unpack_state_init(&format->f, in);
+
 #define x(id, field)	out.field = get_inc_field(&state, id);
-	bkey_fields()
+		bkey_fields()
 #undef x
+	}
 
 	return out;
 }
 
-struct bpos __bkey_unpack_pos(const struct bkey_format_processed *format_p,
+struct bpos __bkey_unpack_pos(const struct bkey_format_processed *format,
 			      const struct bkey_packed *in)
 {
-	const struct bkey_format *format = &format_p->f;
-	struct unpack_state state = unpack_state_init(format, in);
 	struct bpos out;
 
-	EBUG_ON(format->nr_fields != BKEY_NR_FIELDS);
-	EBUG_ON(in->u64s < format->key_u64s);
+	EBUG_ON(format->f.nr_fields != BKEY_NR_FIELDS);
+	EBUG_ON(in->u64s < format->f.key_u64s);
 	EBUG_ON(in->format != KEY_FORMAT_LOCAL_BTREE);
 
-	out.inode	= get_inc_field(&state, BKEY_FIELD_INODE);
-	out.offset	= get_inc_field(&state, BKEY_FIELD_OFFSET);
-	out.snapshot	= get_inc_field(&state, BKEY_FIELD_SNAPSHOT);
+	if (likely(format->aligned)) {
+		out.inode	= get_aligned_field(format, in, BKEY_FIELD_INODE);
+		out.offset	= get_aligned_field(format, in, BKEY_FIELD_OFFSET);
+		out.snapshot	= get_aligned_field(format, in, BKEY_FIELD_SNAPSHOT);
+	} else {
+		struct unpack_state state = unpack_state_init(&format->f, in);
+
+		out.inode	= get_inc_field(&state, BKEY_FIELD_INODE);
+		out.offset	= get_inc_field(&state, BKEY_FIELD_OFFSET);
+		out.snapshot	= get_inc_field(&state, BKEY_FIELD_SNAPSHOT);
+	}
 
 	return out;
 }
diff --git a/fs/bcachefs/btree_types.h b/fs/bcachefs/btree_types.h
index 58ce60c37e..38c3ec6852 100644
--- a/fs/bcachefs/btree_types.h
+++ b/fs/bcachefs/btree_types.h
@@ -70,6 +70,10 @@ struct btree_bkey_cached_common {
 
 struct bkey_format_processed {
 	struct bkey_format	f;
+	bool			aligned;
+	u8			offset[6];
+	u8			shift[6];
+	u64			mask[6];
 };
 
 struct btree {
diff --git a/fs/bcachefs/btree_update_interior.h b/fs/bcachefs/btree_update_interior.h
index dcfd7ceacc..72aedc1e34 100644
--- a/fs/bcachefs/btree_update_interior.h
+++ b/fs/bcachefs/btree_update_interior.h
@@ -181,7 +181,11 @@ static inline void btree_node_reset_sib_u64s(struct btree *b)
 
 static inline void *btree_data_end(struct bch_fs *c, struct btree *b)
 {
-	return (void *) b->data + btree_bytes(c);
+	/*
+	 * __bch2_bkey_unpack_key() may read up to 8 bytes past the end of the
+	 * input buffer:
+	 */
+	return (void *) b->data + btree_bytes(c) - 8;
 }
 
 static inline struct bkey_packed *unwritten_whiteouts_start(struct bch_fs *c,
