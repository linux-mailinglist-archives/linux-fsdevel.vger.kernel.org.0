Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E9A24DAFA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 18:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgHUQcM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 12:32:12 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:56470 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728473AbgHUQZY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:25:24 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 49FFF414;
        Fri, 21 Aug 2020 19:25:11 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1598027111;
        bh=P9ZLW0N+7PeIoRooFf5cnGvDnjVdte3FmzihkkkMKJg=;
        h=From:To:CC:Subject:Date;
        b=mQNJBo68JRODXV8uqYhW7YcnwC4jLiqGhgFkUgD5U3aSUe2OCePUYOhGlAEqCF+rv
         4rD/NQpjPlNQEQVJ9J3cvKM7B+5H3D1FizktJMjNuvVmXIaI0baWHAh0l5/UFwXGfV
         AfSozRWliSym91arHx/IN6BDJTS6h0SB9vwdg7NM=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 21 Aug 2020 19:25:10 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Fri, 21 Aug 2020 19:25:10 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     =?iso-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>
Subject: [PATCH v2 03/10] fs/ntfs3: Add bitmap
Thread-Topic: [PATCH v2 03/10] fs/ntfs3: Add bitmap
Thread-Index: AdZ30vgvg21hJl5JT/mlNin5wjtHrA==
Date:   Fri, 21 Aug 2020 16:25:10 +0000
Message-ID: <dcfab32866914bbab1c5af38817f8ebb@paragon-software.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.8.36]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Bitmap implementation

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com=
>
---
 fs/ntfs3/bitfunc.c |  144 +++++
 fs/ntfs3/bitmap.c  | 1545 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 1689 insertions(+)
 create mode 100644 fs/ntfs3/bitfunc.c
 create mode 100644 fs/ntfs3/bitmap.c

diff --git a/fs/ntfs3/bitfunc.c b/fs/ntfs3/bitfunc.c
new file mode 100644
index 000000000000..b10a13d0c3b2
--- /dev/null
+++ b/fs/ntfs3/bitfunc.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  linux/fs/ntfs3/bitfunc.c
+ *
+ * Copyright (C) 2019-2020 Paragon Software GmbH, All rights reserved.
+ *
+ */
+#include <linux/blkdev.h>
+#include <linux/buffer_head.h>
+#include <linux/fs.h>
+#include <linux/nls.h>
+#include <linux/sched/signal.h>
+
+#include "debug.h"
+#include "ntfs.h"
+#include "ntfs_fs.h"
+
+#define BITS_IN_SIZE_T (sizeof(size_t) * 8)
+
+/*
+ * fill_mask[i] - first i bits are '1' , i =3D 0,1,2,3,4,5,6,7,8
+ * fill_mask[i] =3D 0xFF >> (8-i)
+ */
+static const u8 fill_mask[] =3D { 0x00, 0x01, 0x03, 0x07, 0x0F,
+				0x1F, 0x3F, 0x7F, 0xFF };
+
+/*
+ * zero_mask[i] - first i bits are '0' , i =3D 0,1,2,3,4,5,6,7,8
+ * zero_mask[i] =3D 0xFF << i
+ */
+static const u8 zero_mask[] =3D { 0xFF, 0xFE, 0xFC, 0xF8, 0xF0,
+				0xE0, 0xC0, 0x80, 0x00 };
+
+/*
+ * are_bits_clear
+ *
+ * Returns true if all bits [bit, bit+nbits) are zeros "0"
+ */
+bool are_bits_clear(const ulong *lmap, size_t bit, size_t nbits)
+{
+	size_t pos =3D bit & 7;
+	const u8 *map =3D (u8 *)lmap + (bit >> 3);
+
+	if (!pos)
+		goto check_size_t;
+	if (8 - pos >=3D nbits)
+		return !nbits ||
+		       !(*map & fill_mask[pos + nbits] & zero_mask[pos]);
+
+	if (*map++ & zero_mask[pos])
+		return false;
+	nbits -=3D 8 - pos;
+
+check_size_t:
+	pos =3D ((size_t)map) & (sizeof(size_t) - 1);
+	if (!pos)
+		goto step_size_t;
+
+	pos =3D sizeof(size_t) - pos;
+	if (nbits < pos * 8)
+		goto step_size_t;
+	for (nbits -=3D pos * 8; pos; pos--, map++) {
+		if (*map)
+			return false;
+	}
+
+step_size_t:
+	for (pos =3D nbits / BITS_IN_SIZE_T; pos; pos--, map +=3D sizeof(size_t))=
 {
+		if (*((size_t *)map))
+			return false;
+	}
+
+	for (pos =3D (nbits % BITS_IN_SIZE_T) >> 3; pos; pos--, map++) {
+		if (*map)
+			return false;
+	}
+
+	pos =3D nbits & 7;
+	if (pos && (*map & fill_mask[pos]))
+		return false;
+
+	// All bits are zero
+	return true;
+}
+
+/*
+ * are_bits_set
+ *
+ * Returns true if all bits [bit, bit+nbits) are ones "1"
+ */
+bool are_bits_set(const ulong *lmap, size_t bit, size_t nbits)
+{
+	u8 mask;
+	size_t pos =3D bit & 7;
+	const u8 *map =3D (u8 *)lmap + (bit >> 3);
+
+	if (!pos)
+		goto check_size_t;
+
+	if (8 - pos >=3D nbits) {
+		mask =3D fill_mask[pos + nbits] & zero_mask[pos];
+		return !nbits || (*map & mask) =3D=3D mask;
+	}
+
+	mask =3D zero_mask[pos];
+	if ((*map++ & mask) !=3D mask)
+		return false;
+	nbits -=3D 8 - pos;
+
+check_size_t:
+	pos =3D ((size_t)map) & (sizeof(size_t) - 1); // 0,1,2,3
+	if (!pos)
+		goto step_size_t;
+	pos =3D sizeof(size_t) - pos;
+	if (nbits < pos * 8)
+		goto step_size_t;
+
+	for (nbits -=3D pos * 8; pos; pos--, map++) {
+		if (*map !=3D 0xFF)
+			return false;
+	}
+
+step_size_t:
+	for (pos =3D nbits / BITS_IN_SIZE_T; pos; pos--, map +=3D sizeof(size_t))=
 {
+		if (*((size_t *)map) !=3D MINUS_ONE_T)
+			return false;
+	}
+
+	for (pos =3D (nbits % BITS_IN_SIZE_T) >> 3; pos; pos--, map++) {
+		if (*map !=3D 0xFF)
+			return false;
+	}
+
+	pos =3D nbits & 7;
+	if (pos) {
+		u8 mask =3D fill_mask[pos];
+
+		if ((*map & mask) !=3D mask)
+			return false;
+	}
+
+	// All bits are ones
+	return true;
+}
diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
new file mode 100644
index 000000000000..f37a6976525b
--- /dev/null
+++ b/fs/ntfs3/bitmap.c
@@ -0,0 +1,1545 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  linux/fs/ntfs3/bitmap.c
+ *
+ * Copyright (C) 2019-2020 Paragon Software GmbH, All rights reserved.
+ *
+ */
+
+#include <linux/blkdev.h>
+#include <linux/buffer_head.h>
+#include <linux/fs.h>
+#include <linux/nls.h>
+#include <linux/sched/signal.h>
+
+#include "debug.h"
+#include "ntfs.h"
+#include "ntfs_fs.h"
+
+struct rb_node_key {
+	struct rb_node node;
+	size_t key;
+};
+
+/*
+ * Tree is sorted by start (key)
+ */
+struct e_node {
+	struct rb_node_key start; /* Tree sorted by start */
+	struct rb_node_key count; /* Tree sorted by len*/
+};
+
+static int wnd_rescan(wnd_bitmap *wnd);
+static struct buffer_head *wnd_map(wnd_bitmap *wnd, size_t iw);
+static bool wnd_is_free_hlp(wnd_bitmap *wnd, size_t bit, size_t bits);
+
+static inline u32 wnd_bits(const wnd_bitmap *wnd, size_t i)
+{
+	return i + 1 =3D=3D wnd->nwnd ? wnd->bits_last : wnd->sb->s_blocksize * 8=
;
+}
+
+/*
+ * b_pos + b_len - biggest fragment
+ * Scan range [wpos wbits) window 'buf'
+ * Returns -1 if not found
+ */
+static size_t wnd_scan(const ulong *buf, size_t wbit, u32 wpos, u32 wend,
+		       size_t to_alloc, size_t *prev_tail, size_t *b_pos,
+		       size_t *b_len)
+{
+	while (wpos < wend) {
+		size_t free_len;
+		u32 free_bits, end;
+		u32 used =3D find_next_zero_bit(buf, wend, wpos);
+
+		if (used >=3D wend) {
+			if (*b_len < *prev_tail) {
+				*b_pos =3D wbit - *prev_tail;
+				*b_len =3D *prev_tail;
+			}
+
+			*prev_tail =3D 0;
+			return -1;
+		}
+
+		if (used > wpos) {
+			wpos =3D used;
+			if (*b_len < *prev_tail) {
+				*b_pos =3D wbit - *prev_tail;
+				*b_len =3D *prev_tail;
+			}
+
+			*prev_tail =3D 0;
+		}
+
+		/*
+		 * Now we have a fragment [wpos, wend) staring with 0
+		 */
+		end =3D wpos + to_alloc - *prev_tail;
+		free_bits =3D find_next_bit(buf, min(end, wend), wpos);
+
+		free_len =3D *prev_tail + free_bits - wpos;
+
+		if (*b_len < free_len) {
+			*b_pos =3D wbit + wpos - *prev_tail;
+			*b_len =3D free_len;
+		}
+
+		if (free_len >=3D to_alloc)
+			return wbit + wpos - *prev_tail;
+
+		if (free_bits >=3D wend) {
+			*prev_tail +=3D free_bits - wpos;
+			return -1;
+		}
+
+		wpos =3D free_bits + 1;
+
+		*prev_tail =3D 0;
+	}
+
+	return -1;
+}
+
+/*
+ * wnd_close
+ *
+ *
+ */
+void wnd_close(wnd_bitmap *wnd)
+{
+	struct rb_node *node, *next;
+
+	if (wnd->free_bits !=3D wnd->free_holder)
+		ntfs_free(wnd->free_bits);
+	run_close(&wnd->run);
+
+	node =3D rb_first(&wnd->start_tree);
+
+	while (node) {
+		next =3D rb_next(node);
+		rb_erase(node, &wnd->start_tree);
+		ntfs_free(rb_entry(node, struct e_node, start.node));
+		node =3D next;
+	}
+}
+
+static struct rb_node *rb_lookup(struct rb_root *root, size_t v)
+{
+	struct rb_node **p =3D &root->rb_node;
+	struct rb_node *r =3D NULL;
+
+	while (*p) {
+		struct rb_node_key *k;
+
+		k =3D rb_entry(*p, struct rb_node_key, node);
+		if (v < k->key)
+			p =3D &(*p)->rb_left;
+		else if (v > k->key) {
+			r =3D &k->node;
+			p =3D &(*p)->rb_right;
+		} else
+			return &k->node;
+	}
+
+	return r;
+}
+
+/*
+ * rb_insert_count
+ *
+ * Helper function to insert special kind of 'count' tree
+ */
+static inline bool rb_insert_count(struct rb_root *root, struct e_node *e)
+{
+	struct rb_node **p =3D &root->rb_node;
+	struct rb_node *parent =3D NULL;
+	size_t e_ckey =3D e->count.key;
+	size_t e_skey =3D e->start.key;
+
+	while (*p) {
+		struct e_node *k =3D
+			rb_entry(parent =3D *p, struct e_node, count.node);
+
+		if (e_ckey > k->count.key)
+			p =3D &(*p)->rb_left;
+		else if (e_ckey < k->count.key)
+			p =3D &(*p)->rb_right;
+		else if (e_skey < k->start.key)
+			p =3D &(*p)->rb_left;
+		else if (e_skey > k->start.key)
+			p =3D &(*p)->rb_right;
+		else {
+			WARN_ON(1);
+			return false;
+		}
+	}
+
+	rb_link_node(&e->count.node, parent, p);
+	rb_insert_color(&e->count.node, root);
+	return true;
+}
+
+/*
+ * inline bool rb_insert_start
+ *
+ * Helper function to insert special kind of 'count' tree
+ */
+static inline bool rb_insert_start(struct rb_root *root, struct e_node *e)
+{
+	struct rb_node **p =3D &root->rb_node;
+	struct rb_node *parent =3D NULL;
+	size_t e_skey =3D e->start.key;
+
+	while (*p) {
+		struct e_node *k;
+
+		parent =3D *p;
+
+		k =3D rb_entry(parent, struct e_node, start.node);
+		if (e_skey < k->start.key)
+			p =3D &(*p)->rb_left;
+		else if (e_skey > k->start.key)
+			p =3D &(*p)->rb_right;
+		else {
+			WARN_ON(1);
+			return false;
+		}
+	}
+
+	rb_link_node(&e->start.node, parent, p);
+	rb_insert_color(&e->start.node, root);
+	return true;
+}
+
+#define NTFS_MAX_WND_EXTENTS (32u * 1024u)
+
+/*
+ * wnd_add_free_ext
+ *
+ * adds a new extent of free space
+ * build =3D 1 when building tree
+ */
+static void wnd_add_free_ext(wnd_bitmap *wnd, size_t bit, size_t len,
+			     bool build)
+{
+	struct e_node *e, *e0 =3D NULL;
+	size_t ib, end_in =3D bit + len;
+	struct rb_node *n;
+
+	if (!build)
+		goto lookup;
+
+	if (wnd->count >=3D NTFS_MAX_WND_EXTENTS && len <=3D wnd->extent_min) {
+		wnd->uptodated =3D -1;
+		return;
+	}
+
+	goto insert_new;
+
+lookup:
+	/* Try to find extent before 'bit' */
+	n =3D rb_lookup(&wnd->start_tree, bit);
+
+	if (!n)
+		n =3D rb_first(&wnd->start_tree);
+	else {
+		e =3D rb_entry(n, struct e_node, start.node);
+
+		n =3D rb_next(n);
+		if (e->start.key + e->count.key =3D=3D bit) {
+			/* Remove left */
+			bit =3D e->start.key;
+			len +=3D e->count.key;
+
+			rb_erase(&e->start.node, &wnd->start_tree);
+			rb_erase(&e->count.node, &wnd->count_tree);
+			wnd->count -=3D 1;
+			e0 =3D e;
+		}
+	}
+
+	while (n) {
+		size_t next_end;
+
+		e =3D rb_entry(n, struct e_node, start.node);
+
+		next_end =3D e->start.key + e->count.key;
+		if (e->start.key > end_in)
+			break;
+
+		/* Remove right */
+		n =3D rb_next(n);
+		len +=3D next_end - end_in;
+		end_in =3D next_end;
+		rb_erase(&e->start.node, &wnd->start_tree);
+		rb_erase(&e->count.node, &wnd->count_tree);
+		wnd->count -=3D 1;
+
+		if (!e0)
+			e0 =3D e;
+		else
+			ntfs_free(e);
+	}
+
+	if (wnd->uptodated =3D=3D 1)
+		goto insert_new;
+
+	/* Check bits before 'bit' */
+	ib =3D wnd->zone_bit =3D=3D wnd->zone_end || bit < wnd->zone_end ?
+		     0 :
+		     wnd->zone_end;
+
+	while (bit > ib && wnd_is_free_hlp(wnd, bit - 1, 1)) {
+		bit -=3D 1;
+		len +=3D 1;
+	}
+
+	/* Check bits after 'end_in' */
+	ib =3D wnd->zone_bit =3D=3D wnd->zone_end || end_in > wnd->zone_bit ?
+		     wnd->nbits :
+		     wnd->zone_bit;
+
+	while (end_in < ib && wnd_is_free_hlp(wnd, end_in, 1)) {
+		end_in +=3D 1;
+		len +=3D 1;
+	}
+
+insert_new:
+	/* Insert new fragment */
+	if (wnd->count < NTFS_MAX_WND_EXTENTS)
+		goto allocate_new;
+
+	if (e0)
+		ntfs_free(e0);
+
+	wnd->uptodated =3D -1;
+
+	/* Compare with smallest fragment */
+	n =3D rb_last(&wnd->count_tree);
+	e =3D rb_entry(n, struct e_node, count.node);
+	if (len <=3D e->count.key)
+		goto out; /* Do not insert small fragments */
+
+	if (build) {
+		struct e_node *e2;
+
+		n =3D rb_prev(n);
+		e2 =3D rb_entry(n, struct e_node, count.node);
+		/* smallest fragment will be 'e2->count.key' */
+		wnd->extent_min =3D e2->count.key;
+	}
+
+	/* Replace smallest fragment by new one */
+	rb_erase(&e->start.node, &wnd->start_tree);
+	rb_erase(&e->count.node, &wnd->count_tree);
+	wnd->count -=3D 1;
+	goto insert;
+
+allocate_new:
+	e =3D e0 ? e0 : ntfs_alloc(sizeof(struct e_node), 0);
+	if (!e) {
+		wnd->uptodated =3D -1;
+		goto out;
+	}
+
+	if (build && len <=3D wnd->extent_min)
+		wnd->extent_min =3D len;
+insert:
+	e->start.key =3D bit;
+	e->count.key =3D len;
+	if (len > wnd->extent_max)
+		wnd->extent_max =3D len;
+
+	rb_insert_start(&wnd->start_tree, e);
+	rb_insert_count(&wnd->count_tree, e);
+	wnd->count +=3D 1;
+
+out:;
+}
+
+/*
+ * wnd_remove_free_ext
+ *
+ * removes a run from the cached free space
+ */
+static void wnd_remove_free_ext(wnd_bitmap *wnd, size_t bit, size_t len)
+{
+	struct rb_node *n, *n3;
+	struct e_node *e, *e3;
+	size_t end_in =3D bit + len;
+	size_t end3, end, new_key, new_len, max_new_len;
+	bool bmax;
+
+	/* Try to find extent before 'bit' */
+	n =3D rb_lookup(&wnd->start_tree, bit);
+
+	if (!n)
+		return;
+
+	e =3D rb_entry(n, struct e_node, start.node);
+	end =3D e->start.key + e->count.key;
+
+	new_key =3D new_len =3D 0;
+	len =3D e->count.key;
+
+	/* Range [bit,end_in) must be inside 'e' or outside 'e' and 'n' */
+	if (e->start.key > bit)
+		goto check_biggest;
+
+	if (end_in <=3D end) {
+		/* Range [bit,end_in) inside 'e' */
+		new_key =3D end_in;
+		new_len =3D end - end_in;
+		len =3D bit - e->start.key;
+		goto check_biggest;
+	}
+
+	if (bit <=3D end)
+		goto check_biggest;
+
+	bmax =3D false;
+
+	n3 =3D rb_next(n);
+
+	while (n3) {
+		e3 =3D rb_entry(n3, struct e_node, start.node);
+		if (e3->start.key >=3D end_in)
+			break;
+
+		if (e3->count.key =3D=3D wnd->extent_max)
+			bmax =3D true;
+
+		end3 =3D e3->start.key + e3->count.key;
+		if (end3 > end_in) {
+			e3->start.key =3D end_in;
+			rb_erase(&e3->count.node, &wnd->count_tree);
+			e3->count.key =3D end3 - end_in;
+			rb_insert_count(&wnd->count_tree, e3);
+			break;
+		}
+
+		n3 =3D rb_next(n3);
+		rb_erase(&e3->start.node, &wnd->start_tree);
+		rb_erase(&e3->count.node, &wnd->count_tree);
+		wnd->count -=3D 1;
+		ntfs_free(e3);
+	}
+	if (!bmax)
+		return;
+	n3 =3D rb_first(&wnd->count_tree);
+	wnd->extent_max =3D
+		n3 ? rb_entry(n3, struct e_node, count.node)->count.key : 0;
+	return;
+
+check_biggest:
+	if (e->count.key !=3D wnd->extent_max)
+		goto check_len;
+
+	/* We have to change the biggest extent */
+	n3 =3D rb_prev(&e->count.node);
+	if (n3)
+		goto check_len;
+
+	n3 =3D rb_next(&e->count.node);
+	max_new_len =3D len > new_len ? len : new_len;
+	if (!n3) {
+		wnd->extent_max =3D max_new_len;
+		goto check_len;
+	}
+	e3 =3D rb_entry(n3, struct e_node, count.node);
+	wnd->extent_max =3D max(e3->count.key, max_new_len);
+
+check_len:
+	if (!len) {
+		if (new_len) {
+			e->start.key =3D new_key;
+			rb_erase(&e->count.node, &wnd->count_tree);
+			e->count.key =3D new_len;
+			rb_insert_count(&wnd->count_tree, e);
+		} else {
+			rb_erase(&e->start.node, &wnd->start_tree);
+			rb_erase(&e->count.node, &wnd->count_tree);
+			wnd->count -=3D 1;
+			ntfs_free(e);
+		}
+		goto out;
+	}
+	rb_erase(&e->count.node, &wnd->count_tree);
+	e->count.key =3D len;
+	rb_insert_count(&wnd->count_tree, e);
+
+	if (!new_len)
+		goto out;
+
+	if (wnd->count >=3D NTFS_MAX_WND_EXTENTS) {
+		wnd->uptodated =3D -1;
+
+		/* Get minimal extent */
+		e =3D rb_entry(rb_last(&wnd->count_tree), struct e_node,
+			     count.node);
+		if (e->count.key > new_len)
+			goto out;
+
+		/* Replace minimum */
+		rb_erase(&e->start.node, &wnd->start_tree);
+		rb_erase(&e->count.node, &wnd->count_tree);
+		wnd->count -=3D 1;
+	} else {
+		e =3D ntfs_alloc(sizeof(struct e_node), 0);
+		if (!e)
+			wnd->uptodated =3D -1;
+	}
+
+	if (e) {
+		e->start.key =3D new_key;
+		e->count.key =3D new_len;
+		rb_insert_start(&wnd->start_tree, e);
+		rb_insert_count(&wnd->count_tree, e);
+		wnd->count +=3D 1;
+	}
+
+out:
+	if (!wnd->count && 1 !=3D wnd->uptodated)
+		wnd_rescan(wnd);
+}
+
+/*
+ * wnd_rescan
+ *
+ * Scan all bitmap. used while initialization.
+ */
+static int wnd_rescan(wnd_bitmap *wnd)
+{
+	int err =3D 0;
+	size_t prev_tail =3D 0;
+	struct super_block *sb =3D wnd->sb;
+	ntfs_sb_info *sbi =3D sb->s_fs_info;
+	u64 lbo, len =3D 0;
+	u32 blocksize =3D sb->s_blocksize;
+	u8 cluster_bits =3D sbi->cluster_bits;
+	const u32 ra_bytes =3D 512 * 1024;
+	const u32 ra_pages =3D ra_bytes >> PAGE_SHIFT;
+	u32 wbits =3D 8 * sb->s_blocksize;
+	u32 ra_mask =3D (ra_bytes >> sb->s_blocksize_bits) - 1;
+	struct address_space *mapping =3D sb->s_bdev->bd_inode->i_mapping;
+	u32 used, frb;
+	const ulong *buf;
+	size_t wpos, wbit, iw, vbo;
+	struct buffer_head *bh =3D NULL;
+	CLST lcn, clen;
+
+	wnd->uptodated =3D 0;
+	wnd->extent_max =3D 0;
+	wnd->extent_min =3D MINUS_ONE_T;
+	wnd->total_zeroes =3D 0;
+
+	vbo =3D 0;
+	iw =3D 0;
+
+start_wnd:
+
+	if (iw + 1 =3D=3D wnd->nwnd)
+		wbits =3D wnd->bits_last;
+
+	if (wnd->inited) {
+		if (!wnd->free_bits[iw]) {
+			/* all ones */
+			if (!prev_tail)
+				goto next_wnd;
+
+			wnd_add_free_ext(wnd, vbo * 8 - prev_tail, prev_tail,
+					 true);
+			prev_tail =3D 0;
+			goto next_wnd;
+		}
+		if (wbits =3D=3D wnd->free_bits[iw]) {
+			/* all zeroes */
+			prev_tail +=3D wbits;
+			wnd->total_zeroes +=3D wbits;
+			goto next_wnd;
+		}
+	}
+
+	if (len)
+		goto read_wnd;
+
+	if (!run_lookup_entry(&wnd->run, vbo >> cluster_bits, &lcn, &clen,
+			      NULL)) {
+		err =3D -ENOENT;
+		goto out;
+	}
+
+	lbo =3D (u64)lcn << cluster_bits;
+	len =3D (u64)clen << cluster_bits;
+
+read_wnd:
+	if (!(iw & ra_mask))
+		page_cache_readahead_unbounded(mapping, NULL, lbo >> PAGE_SHIFT,
+					       ra_pages, 0);
+
+	bh =3D ntfs_bread(sb, lbo >> sb->s_blocksize_bits);
+	if (!bh) {
+		err =3D -EIO;
+		goto out;
+	}
+
+	buf =3D (ulong *)bh->b_data;
+
+	used =3D __bitmap_weight(buf, wbits);
+	if (used < wbits) {
+		frb =3D wbits - used;
+		wnd->free_bits[iw] =3D frb;
+		wnd->total_zeroes +=3D frb;
+	}
+
+	wpos =3D 0;
+	wbit =3D vbo * 8;
+
+	if (wbit + wbits > wnd->nbits)
+		wbits =3D wnd->nbits - wbit;
+
+next_range:
+	used =3D find_next_zero_bit(buf, wbits, wpos);
+
+	if (used > wpos && prev_tail) {
+		wnd_add_free_ext(wnd, wbit + wpos - prev_tail, prev_tail, true);
+		prev_tail =3D 0;
+	}
+
+	wpos =3D used;
+
+	if (wpos >=3D wbits) {
+		/* No free blocks */
+		prev_tail =3D 0;
+		goto next_wnd;
+	}
+
+	frb =3D find_next_bit(buf, wbits, wpos);
+	if (frb >=3D wbits) {
+		/* keep last free block */
+		prev_tail +=3D frb - wpos;
+		goto next_wnd;
+	}
+
+	wnd_add_free_ext(wnd, wbit + wpos - prev_tail, frb + prev_tail - wpos,
+			 true);
+
+	/* Skip free block and first '1' */
+	wpos =3D frb + 1;
+	/* Reset previous tail */
+	prev_tail =3D 0;
+	if (wpos < wbits)
+		goto next_range;
+next_wnd:
+
+	if (bh)
+		put_bh(bh);
+	bh =3D NULL;
+
+	vbo +=3D blocksize;
+	if (len) {
+		len -=3D blocksize;
+		lbo +=3D blocksize;
+	}
+
+	if (++iw < wnd->nwnd)
+		goto start_wnd;
+
+	/* Add last block */
+	if (prev_tail)
+		wnd_add_free_ext(wnd, wnd->nbits - prev_tail, prev_tail, true);
+
+	/*
+	 * Before init cycle wnd->uptodated was 0
+	 * If any errors or limits occurs while initialization then
+	 * wnd->uptodated will be -1
+	 * If 'uptodated' is still 0 then Tree is really updated
+	 */
+	if (!wnd->uptodated)
+		wnd->uptodated =3D 1;
+
+	if (wnd->zone_bit !=3D wnd->zone_end) {
+		size_t zlen =3D wnd->zone_end - wnd->zone_bit;
+
+		wnd->zone_end =3D wnd->zone_bit;
+		wnd_zone_set(wnd, wnd->zone_bit, zlen);
+	}
+
+out:
+	return err;
+}
+
+/*
+ * wnd_init
+ */
+int wnd_init(wnd_bitmap *wnd, struct super_block *sb, size_t nbits)
+{
+	int err;
+	u32 blocksize =3D sb->s_blocksize;
+	u32 wbits =3D blocksize * 8;
+
+	init_rwsem(&wnd->rw_lock);
+
+	wnd->sb =3D sb;
+	wnd->nbits =3D nbits;
+	wnd->total_zeroes =3D nbits;
+	wnd->extent_max =3D MINUS_ONE_T;
+	wnd->zone_bit =3D wnd->zone_end =3D 0;
+	wnd->nwnd =3D bytes_to_block(sb, bitmap_size(nbits));
+	wnd->bits_last =3D nbits & (wbits - 1);
+	if (!wnd->bits_last)
+		wnd->bits_last =3D wbits;
+
+	if (wnd->nwnd <=3D ARRAY_SIZE(wnd->free_holder)) {
+		wnd->free_bits =3D wnd->free_holder;
+	} else {
+		wnd->free_bits =3D ntfs_alloc(wnd->nwnd * sizeof(u16), 1);
+		if (!wnd->free_bits)
+			return -ENOMEM;
+	}
+
+	err =3D wnd_rescan(wnd);
+	if (err)
+		return err;
+
+	wnd->inited =3D true;
+
+	return 0;
+}
+
+/*
+ * wnd_map
+ *
+ * call sb_bread for requested window
+ */
+static struct buffer_head *wnd_map(wnd_bitmap *wnd, size_t iw)
+{
+	size_t vbo;
+	CLST lcn, clen;
+	struct super_block *sb =3D wnd->sb;
+	ntfs_sb_info *sbi;
+	struct buffer_head *bh;
+	u64 lbo;
+
+	sbi =3D sb->s_fs_info;
+	vbo =3D (u64)iw << sb->s_blocksize_bits;
+
+	if (!run_lookup_entry(&wnd->run, vbo >> sbi->cluster_bits, &lcn, &clen,
+			      NULL)) {
+		return ERR_PTR(-ENOENT);
+	}
+
+	lbo =3D ((u64)lcn << sbi->cluster_bits) + (vbo & sbi->cluster_mask);
+
+	bh =3D ntfs_bread(wnd->sb, lbo >> sb->s_blocksize_bits);
+
+	if (!bh)
+		return ERR_PTR(-EIO);
+
+	return bh;
+}
+
+/*
+ * wnd_set_free
+ *
+ * Marks the bits range from bit to bit + bits as free
+ */
+int wnd_set_free(wnd_bitmap *wnd, size_t bit, size_t bits)
+{
+	int err =3D 0;
+	struct super_block *sb =3D wnd->sb;
+	size_t bits0 =3D bits;
+	u32 wbits =3D 8 * sb->s_blocksize;
+	size_t iw =3D bit >> (sb->s_blocksize_bits + 3);
+	u32 wbit =3D bit & (wbits - 1);
+	struct buffer_head *bh;
+
+	while (iw < wnd->nwnd && bits) {
+		u32 tail, op;
+		ulong *buf;
+
+		if (iw + 1 =3D=3D wnd->nwnd)
+			wbits =3D wnd->bits_last;
+
+		tail =3D wbits - wbit;
+		op =3D tail < bits ? tail : bits;
+
+		bh =3D wnd_map(wnd, iw);
+		if (IS_ERR(bh)) {
+			err =3D PTR_ERR(bh);
+			break;
+		}
+
+		buf =3D (ulong *)bh->b_data;
+
+		lock_buffer(bh);
+
+		__bitmap_clear(buf, wbit, op);
+
+		wnd->free_bits[iw] +=3D op;
+
+		set_buffer_uptodate(bh);
+		mark_buffer_dirty(bh);
+		unlock_buffer(bh);
+		put_bh(bh);
+
+		wnd->total_zeroes +=3D op;
+		bits -=3D op;
+		wbit =3D 0;
+		iw +=3D 1;
+	}
+
+	wnd_add_free_ext(wnd, bit, bits0, false);
+
+	return err;
+}
+
+/*
+ * wnd_set_used
+ *
+ * Marks the bits range from bit to bit + bits as used
+ */
+int wnd_set_used(wnd_bitmap *wnd, size_t bit, size_t bits)
+{
+	int err =3D 0;
+	struct super_block *sb =3D wnd->sb;
+	size_t bits0 =3D bits;
+	size_t iw =3D bit >> (sb->s_blocksize_bits + 3);
+	u32 wbits =3D 8 * sb->s_blocksize;
+	u32 wbit =3D bit & (wbits - 1);
+	struct buffer_head *bh;
+
+	while (iw < wnd->nwnd && bits) {
+		u32 tail, op;
+		ulong *buf;
+
+		if (unlikely(iw + 1 =3D=3D wnd->nwnd))
+			wbits =3D wnd->bits_last;
+
+		tail =3D wbits - wbit;
+		op =3D tail < bits ? tail : bits;
+
+		bh =3D wnd_map(wnd, iw);
+		if (IS_ERR(bh)) {
+			err =3D PTR_ERR(bh);
+			break;
+		}
+		buf =3D (ulong *)bh->b_data;
+
+		lock_buffer(bh);
+
+		__bitmap_set(buf, wbit, op);
+		wnd->free_bits[iw] -=3D op;
+
+		set_buffer_uptodate(bh);
+		mark_buffer_dirty(bh);
+		unlock_buffer(bh);
+		put_bh(bh);
+
+		wnd->total_zeroes -=3D op;
+		bits -=3D op;
+		wbit =3D 0;
+		iw +=3D 1;
+	}
+
+	if (!RB_EMPTY_ROOT(&wnd->start_tree))
+		wnd_remove_free_ext(wnd, bit, bits0);
+
+	return err;
+}
+
+/*
+ * wnd_is_free_hlp
+ *
+ * Returns true if all clusters [bit, bit+bits) are free (bitmap only)
+ */
+static bool wnd_is_free_hlp(wnd_bitmap *wnd, size_t bit, size_t bits)
+{
+	struct super_block *sb =3D wnd->sb;
+	size_t iw =3D bit >> (sb->s_blocksize_bits + 3);
+	u32 wbits =3D 8 * sb->s_blocksize;
+	u32 wbit =3D bit & (wbits - 1);
+
+	while (iw < wnd->nwnd && bits) {
+		u32 tail, op;
+
+		if (unlikely(iw + 1 =3D=3D wnd->nwnd))
+			wbits =3D wnd->bits_last;
+
+		tail =3D wbits - wbit;
+		op =3D tail < bits ? tail : bits;
+
+		if (wbits !=3D wnd->free_bits[iw]) {
+			bool ret;
+			struct buffer_head *bh =3D wnd_map(wnd, iw);
+
+			if (IS_ERR(bh))
+				return false;
+
+			ret =3D are_bits_clear((ulong *)bh->b_data, wbit, op);
+
+			put_bh(bh);
+			if (!ret)
+				return false;
+		}
+
+		bits -=3D op;
+		wbit =3D 0;
+		iw +=3D 1;
+	}
+
+	return true;
+}
+
+/*
+ * wnd_is_free
+ *
+ * Returns true if all clusters [bit, bit+bits) are free
+ */
+bool wnd_is_free(wnd_bitmap *wnd, size_t bit, size_t bits)
+{
+	bool ret;
+	struct rb_node *n;
+	size_t end;
+	struct e_node *e;
+
+	if (RB_EMPTY_ROOT(&wnd->start_tree))
+		goto use_wnd;
+
+	n =3D rb_lookup(&wnd->start_tree, bit);
+	if (!n)
+		goto use_wnd;
+
+	e =3D rb_entry(n, struct e_node, start.node);
+
+	end =3D e->start.key + e->count.key;
+
+	if (bit < end && bit + bits <=3D end)
+		return true;
+
+use_wnd:
+	ret =3D wnd_is_free_hlp(wnd, bit, bits);
+
+	return ret;
+}
+
+/*
+ * wnd_is_used
+ *
+ * Returns true if all clusters [bit, bit+bits) are used
+ */
+bool wnd_is_used(wnd_bitmap *wnd, size_t bit, size_t bits)
+{
+	bool ret =3D false;
+	struct super_block *sb =3D wnd->sb;
+	size_t iw =3D bit >> (sb->s_blocksize_bits + 3);
+	u32 wbits =3D 8 * sb->s_blocksize;
+	u32 wbit =3D bit & (wbits - 1);
+	size_t end;
+	struct rb_node *n;
+	struct e_node *e;
+
+	if (RB_EMPTY_ROOT(&wnd->start_tree))
+		goto use_wnd;
+
+	end =3D bit + bits;
+	n =3D rb_lookup(&wnd->start_tree, end - 1);
+	if (!n)
+		goto use_wnd;
+
+	e =3D rb_entry(n, struct e_node, start.node);
+	if (e->start.key + e->count.key > bit)
+		return false;
+
+use_wnd:
+	while (iw < wnd->nwnd && bits) {
+		u32 tail, op;
+
+		if (unlikely(iw + 1 =3D=3D wnd->nwnd))
+			wbits =3D wnd->bits_last;
+
+		tail =3D wbits - wbit;
+		op =3D tail < bits ? tail : bits;
+
+		if (wnd->free_bits[iw]) {
+			bool ret;
+			struct buffer_head *bh =3D wnd_map(wnd, iw);
+
+			if (IS_ERR(bh))
+				goto out;
+
+			ret =3D are_bits_set((ulong *)bh->b_data, wbit, op);
+			put_bh(bh);
+			if (!ret)
+				goto out;
+		}
+
+		bits -=3D op;
+		wbit =3D 0;
+		iw +=3D 1;
+	}
+	ret =3D true;
+
+out:
+	return ret;
+}
+
+/*
+ * wnd_find
+ * - flags - BITMAP_FIND_XXX flags
+ *
+ * looks for free space
+ * Returns 0 if not found
+ */
+size_t wnd_find(wnd_bitmap *wnd, size_t to_alloc, size_t hint, size_t flag=
s,
+		size_t *allocated)
+{
+	struct super_block *sb;
+	u32 wbits, wpos, wzbit, wzend;
+	size_t fnd, max_alloc, b_len, b_pos;
+	size_t iw, prev_tail, nwnd, wbit, ebit, zbit, zend;
+	size_t to_alloc0 =3D to_alloc;
+	const ulong *buf;
+	const struct e_node *e;
+	const struct rb_node *pr, *cr;
+	u8 log2_bits;
+	bool fbits_valid;
+	struct buffer_head *bh;
+
+	/* fast checking for available free space */
+	if (flags & BITMAP_FIND_FULL) {
+		size_t zeroes =3D wnd_zeroes(wnd);
+
+		zeroes -=3D wnd->zone_end - wnd->zone_bit;
+		if (zeroes < to_alloc0)
+			goto no_space;
+
+		if (to_alloc0 > wnd->extent_max)
+			goto no_space;
+	} else {
+		if (to_alloc > wnd->extent_max)
+			to_alloc =3D wnd->extent_max;
+	}
+
+	if (wnd->zone_bit <=3D hint && hint < wnd->zone_end)
+		hint =3D wnd->zone_end;
+
+	max_alloc =3D wnd->nbits;
+	b_len =3D b_pos =3D 0;
+
+	if (hint >=3D max_alloc)
+		hint =3D 0;
+
+	if (RB_EMPTY_ROOT(&wnd->start_tree)) {
+		if (wnd->uptodated =3D=3D 1) {
+			/* extents tree is updated -> no free space */
+			goto no_space;
+		}
+		goto scan_bitmap;
+	}
+
+	e =3D NULL;
+	if (!hint)
+		goto allocate_biggest;
+
+	/* Use hint: enumerate extents by start >=3D hint */
+	pr =3D NULL;
+	cr =3D wnd->start_tree.rb_node;
+
+	for (;;) {
+		e =3D rb_entry(cr, struct e_node, start.node);
+
+		if (e->start.key =3D=3D hint)
+			break;
+
+		if (e->start.key < hint) {
+			pr =3D cr;
+			cr =3D cr->rb_right;
+			if (!cr)
+				break;
+			continue;
+		}
+
+		cr =3D cr->rb_left;
+		if (!cr) {
+			e =3D pr ? rb_entry(pr, struct e_node, start.node) : NULL;
+			break;
+		}
+	}
+
+	if (!e)
+		goto allocate_biggest;
+
+	if (e->start.key + e->count.key > hint) {
+		/* We have found extension with 'hint' inside */
+		size_t len =3D e->start.key + e->count.key - hint;
+
+		if (len >=3D to_alloc && hint + to_alloc <=3D max_alloc) {
+			fnd =3D hint;
+			goto found;
+		}
+
+		if (!(flags & BITMAP_FIND_FULL)) {
+			if (len > to_alloc)
+				len =3D to_alloc;
+
+			if (hint + len <=3D max_alloc) {
+				fnd =3D hint;
+				to_alloc =3D len;
+				goto found;
+			}
+		}
+	}
+
+allocate_biggest:
+
+	/* Allocate from biggest free extent */
+	e =3D rb_entry(rb_first(&wnd->count_tree), struct e_node, count.node);
+	if (e->count.key !=3D wnd->extent_max)
+		wnd->extent_max =3D e->count.key;
+
+	if (e->count.key < max_alloc) {
+		if (e->count.key >=3D to_alloc)
+			;
+		else if (flags & BITMAP_FIND_FULL) {
+			if (e->count.key < to_alloc0) {
+				/* Biggest free block is less then requested */
+				goto no_space;
+			}
+			to_alloc =3D e->count.key;
+		} else if (-1 !=3D wnd->uptodated)
+			to_alloc =3D e->count.key;
+		else {
+			/* Check if we can use more bits */
+			size_t op, max_check;
+			struct rb_root start_tree;
+
+			memcpy(&start_tree, &wnd->start_tree,
+			       sizeof(struct rb_root));
+			memset(&wnd->start_tree, 0, sizeof(struct rb_root));
+
+			max_check =3D e->start.key + to_alloc;
+			if (max_check > max_alloc)
+				max_check =3D max_alloc;
+			for (op =3D e->start.key + e->count.key; op < max_check;
+			     op++) {
+				if (!wnd_is_free(wnd, op, 1))
+					break;
+			}
+			memcpy(&wnd->start_tree, &start_tree,
+			       sizeof(struct rb_root));
+			to_alloc =3D op - e->start.key;
+		}
+
+		/* Prepare to return */
+		fnd =3D e->start.key;
+		if (e->start.key + to_alloc > max_alloc)
+			to_alloc =3D max_alloc - e->start.key;
+		goto found;
+	}
+
+	if (wnd->uptodated =3D=3D 1) {
+		/* extents tree is updated -> no free space */
+		goto no_space;
+	}
+
+	b_len =3D e->count.key;
+	b_pos =3D e->start.key;
+
+scan_bitmap:
+	sb =3D wnd->sb;
+	log2_bits =3D sb->s_blocksize_bits + 3;
+
+	/* At most two ranges [hint, max_alloc) + [0, hint) */
+Again:
+
+	/* TODO: optimize request for case nbits > wbits */
+	iw =3D hint >> log2_bits;
+	wbits =3D sb->s_blocksize * 8;
+	wpos =3D hint & (wbits - 1);
+	prev_tail =3D 0;
+	fbits_valid =3D true;
+
+	if (max_alloc =3D=3D wnd->nbits) {
+		nwnd =3D wnd->nwnd;
+	} else {
+		size_t t =3D max_alloc + wbits - 1;
+
+		nwnd =3D likely(t > max_alloc) ? (t >> log2_bits) : wnd->nwnd;
+	}
+
+	/* Enumerate all windows */
+	iw -=3D 1;
+next_wnd:
+	iw +=3D 1;
+	if (iw >=3D nwnd)
+		goto estimate;
+
+	wbit =3D iw << log2_bits;
+
+	if (!wnd->free_bits[iw]) {
+		if (prev_tail > b_len) {
+			b_pos =3D wbit - prev_tail;
+			b_len =3D prev_tail;
+		}
+
+		/* Skip full used window */
+		prev_tail =3D 0;
+		wpos =3D 0;
+		goto next_wnd;
+	}
+
+	if (unlikely(iw + 1 =3D=3D nwnd)) {
+		if (max_alloc =3D=3D wnd->nbits)
+			wbits =3D wnd->bits_last;
+		else {
+			size_t t =3D max_alloc & (wbits - 1);
+
+			if (t) {
+				wbits =3D t;
+				fbits_valid =3D false;
+			}
+		}
+	}
+
+	if (wnd->zone_end <=3D wnd->zone_bit)
+		goto skip_zone;
+
+	ebit =3D wbit + wbits;
+	zbit =3D max(wnd->zone_bit, wbit);
+	zend =3D min(wnd->zone_end, ebit);
+
+	/* Here we have a window [wbit, ebit) and zone [zbit, zend) */
+	if (zend <=3D zbit) {
+		/* Zone does not overlap window */
+		goto skip_zone;
+	}
+
+	wzbit =3D zbit - wbit;
+	wzend =3D zend - wbit;
+
+	/* Zone overlaps window */
+	if (wnd->free_bits[iw] =3D=3D wzend - wzbit) {
+		prev_tail =3D 0;
+		wpos =3D 0;
+		goto next_wnd;
+	}
+
+	/* Scan two ranges window: [wbit, zbit) and [zend, ebit) */
+	bh =3D wnd_map(wnd, iw);
+
+	if (IS_ERR(bh)) {
+		/* TODO: error */
+		prev_tail =3D 0;
+		wpos =3D 0;
+		goto next_wnd;
+	}
+
+	buf =3D (ulong *)bh->b_data;
+
+	/* Scan range [wbit, zbit) */
+	if (wpos < wzbit) {
+		/* Scan range [wpos, zbit) */
+		fnd =3D wnd_scan(buf, wbit, wpos, wzbit, to_alloc, &prev_tail,
+			       &b_pos, &b_len);
+		if (fnd !=3D MINUS_ONE_T) {
+			put_bh(bh);
+			goto found;
+		}
+	}
+
+	prev_tail =3D 0;
+
+	/* Scan range [zend, ebit) */
+	if (wzend < wbits) {
+		fnd =3D wnd_scan(buf, wbit, max(wzend, wpos), wbits, to_alloc,
+			       &prev_tail, &b_pos, &b_len);
+		if (fnd !=3D MINUS_ONE_T) {
+			put_bh(bh);
+			goto found;
+		}
+	}
+
+	wpos =3D 0;
+	put_bh(bh);
+	goto next_wnd;
+
+skip_zone:
+	/* Current window does not overlap zone */
+	if (!wpos && fbits_valid && wnd->free_bits[iw] =3D=3D wbits) {
+		/* window is empty */
+		if (prev_tail + wbits >=3D to_alloc) {
+			fnd =3D wbit + wpos - prev_tail;
+			goto found;
+		}
+
+		/* Increase 'prev_tail' and process next window */
+		prev_tail +=3D wbits;
+		wpos =3D 0;
+		goto next_wnd;
+	}
+
+	/* read window */
+	bh =3D wnd_map(wnd, iw);
+	if (IS_ERR(bh)) {
+		// TODO: error
+		prev_tail =3D 0;
+		wpos =3D 0;
+		goto next_wnd;
+	}
+
+	buf =3D (ulong *)bh->b_data;
+
+	/* Scan range [wpos, eBits) */
+	fnd =3D wnd_scan(buf, wbit, wpos, wbits, to_alloc, &prev_tail, &b_pos,
+		       &b_len);
+	put_bh(bh);
+	if (fnd !=3D MINUS_ONE_T)
+		goto found;
+	goto next_wnd;
+
+estimate:
+	if (b_len < prev_tail) {
+		/* The last fragment */
+		b_len =3D prev_tail;
+		b_pos =3D max_alloc - prev_tail;
+	}
+
+	if (hint) {
+		/*
+		 * We have scanned range [hint max_alloc)
+		 * Prepare to scan range [0 hint + to_alloc)
+		 */
+		size_t nextmax =3D hint + to_alloc;
+
+		if (likely(nextmax >=3D hint) && nextmax < max_alloc)
+			max_alloc =3D nextmax;
+		hint =3D 0;
+		goto Again;
+	}
+
+	if (!b_len)
+		goto no_space;
+
+	wnd->extent_max =3D b_len;
+
+	if (flags & BITMAP_FIND_FULL)
+		goto no_space;
+
+	fnd =3D b_pos;
+	to_alloc =3D b_len;
+
+found:
+	if (flags & BITMAP_FIND_MARK_AS_USED) {
+		/* TODO optimize remove extent (pass 'e'?) */
+		if (wnd_set_used(wnd, fnd, to_alloc))
+			goto no_space;
+	} else if (wnd->extent_max !=3D MINUS_ONE_T &&
+		   to_alloc > wnd->extent_max) {
+		wnd->extent_max =3D to_alloc;
+	}
+
+	*allocated =3D fnd;
+	return to_alloc;
+
+no_space:
+	return 0;
+}
+
+/*
+ * wnd_extend
+ *
+ * Extend bitmap ($MFT bitmap)
+ */
+int wnd_extend(wnd_bitmap *wnd, size_t new_bits)
+{
+	int err;
+	struct super_block *sb =3D wnd->sb;
+	ntfs_sb_info *sbi =3D sb->s_fs_info;
+	u32 blocksize =3D sb->s_blocksize;
+	u32 wbits =3D blocksize * 8;
+	u32 b0, new_last;
+	size_t bits, iw, new_wnd;
+	size_t old_bits =3D wnd->nbits;
+	u16 *new_free;
+
+	if (new_bits <=3D old_bits)
+		return -EINVAL;
+
+	/* align to 8 byte boundary */
+	new_wnd =3D bytes_to_block(sb, bitmap_size(new_bits));
+	new_last =3D new_bits & (wbits - 1);
+	if (!new_last)
+		new_last =3D wbits;
+
+	if (new_wnd =3D=3D wnd->nwnd)
+		goto skip_reallocate;
+
+	if (new_wnd <=3D ARRAY_SIZE(wnd->free_holder))
+		new_free =3D wnd->free_holder;
+	else {
+		new_free =3D ntfs_alloc(new_wnd * sizeof(u16), 0);
+		if (!new_free)
+			return -ENOMEM;
+	}
+
+	if (new_free !=3D wnd->free_bits)
+		memcpy(new_free, wnd->free_bits, wnd->nwnd * sizeof(short));
+	memset(new_free + wnd->nwnd, 0, (new_wnd - wnd->nwnd) * sizeof(short));
+	if (wnd->free_bits !=3D wnd->free_holder)
+		ntfs_free(wnd->free_bits);
+
+	wnd->free_bits =3D new_free;
+
+skip_reallocate:
+	/* Zero bits [old_bits,new_bits) */
+	bits =3D new_bits - old_bits;
+	b0 =3D old_bits & (wbits - 1);
+
+	for (iw =3D old_bits >> (sb->s_blocksize_bits + 3); bits; iw +=3D 1) {
+		u32 op;
+		size_t frb;
+		u64 vbo, lbo, bytes;
+		struct buffer_head *bh;
+		ulong *buf;
+
+		if (iw + 1 =3D=3D new_wnd)
+			wbits =3D new_last;
+
+		op =3D b0 + bits > wbits ? wbits - b0 : bits;
+		vbo =3D (u64)iw * blocksize;
+
+		err =3D ntfs_vbo_to_pbo(sbi, &wnd->run, vbo, &lbo, &bytes);
+		if (err)
+			break;
+
+		bh =3D ntfs_bread(sb, lbo >> sb->s_blocksize_bits);
+		if (!bh)
+			return -EIO;
+
+		lock_buffer(bh);
+		buf =3D (ulong *)bh->b_data;
+
+		__bitmap_clear(buf, b0, blocksize * 8 - b0);
+		frb =3D wbits - __bitmap_weight(buf, wbits);
+		wnd->total_zeroes +=3D frb - wnd->free_bits[iw];
+		wnd->free_bits[iw] =3D frb;
+
+		set_buffer_uptodate(bh);
+		mark_buffer_dirty(bh);
+		unlock_buffer(bh);
+		/*err =3D sync_dirty_buffer(bh);*/
+
+		b0 =3D 0;
+		bits -=3D op;
+	}
+
+	wnd->nbits =3D new_bits;
+	wnd->nwnd =3D new_wnd;
+	wnd->bits_last =3D new_last;
+
+	wnd_add_free_ext(wnd, old_bits, new_bits - old_bits, false);
+
+	return 0;
+}
+
+/*
+ * wnd_zone_set
+ */
+void wnd_zone_set(wnd_bitmap *wnd, size_t lcn, size_t len)
+{
+	size_t zlen;
+
+	zlen =3D wnd->zone_end - wnd->zone_bit;
+	if (zlen)
+		wnd_add_free_ext(wnd, wnd->zone_bit, zlen, false);
+
+	if (!RB_EMPTY_ROOT(&wnd->start_tree) && len)
+		wnd_remove_free_ext(wnd, lcn, len);
+
+	wnd->zone_bit =3D lcn;
+	wnd->zone_end =3D lcn + len;
+}
+
+int ntfs_trim_fs(ntfs_sb_info *sbi, struct fstrim_range *range)
+{
+	int err =3D 0;
+	struct super_block *sb =3D sbi->sb;
+	wnd_bitmap *wnd =3D &sbi->used.bitmap;
+	u32 wbits =3D 8 * sb->s_blocksize;
+	CLST len =3D 0, lcn =3D 0, done =3D 0;
+	CLST minlen =3D bytes_to_cluster(sbi, range->minlen);
+	CLST lcn_from =3D bytes_to_cluster(sbi, range->start);
+	size_t iw =3D lcn_from >> (sb->s_blocksize_bits + 3);
+	u32 wbit =3D lcn_from & (wbits - 1);
+	const ulong *buf;
+	CLST lcn_to;
+
+	if (!minlen)
+		minlen =3D 1;
+
+	if (range->len =3D=3D (u64)-1)
+		lcn_to =3D wnd->nbits;
+	else
+		lcn_to =3D bytes_to_cluster(sbi, range->start + range->len);
+
+	down_read_nested(&wnd->rw_lock, BITMAP_MUTEX_CLUSTERS);
+
+	for (; iw < wnd->nbits; iw++, wbit =3D 0) {
+		CLST lcn_wnd =3D iw * wbits;
+		struct buffer_head *bh;
+
+		if (lcn_wnd > lcn_to)
+			break;
+
+		if (!wnd->free_bits[iw])
+			continue;
+
+		if (iw + 1 =3D=3D wnd->nwnd)
+			wbits =3D wnd->bits_last;
+
+		if (lcn_wnd + wbits > lcn_to)
+			wbits =3D lcn_to - lcn_wnd;
+
+		bh =3D wnd_map(wnd, iw);
+		if (IS_ERR(bh)) {
+			err =3D PTR_ERR(bh);
+			break;
+		}
+
+		buf =3D (ulong *)bh->b_data;
+
+		for (; wbit < wbits; wbit++) {
+			if (!test_bit(wbit, buf)) {
+				if (!len)
+					lcn =3D lcn_wnd + wbit;
+				len +=3D 1;
+				continue;
+			}
+			if (len >=3D minlen) {
+				err =3D ntfs_discard(sbi, lcn, len);
+				if (err)
+					goto out;
+				done +=3D len;
+			}
+			len =3D 0;
+		}
+		put_bh(bh);
+	}
+
+	/* Process the last fragment */
+	if (len >=3D minlen) {
+		err =3D ntfs_discard(sbi, lcn, len);
+		if (err)
+			goto out;
+		done +=3D len;
+	}
+
+out:
+	range->len =3D done << sbi->cluster_bits;
+
+	up_read(&wnd->rw_lock);
+
+	return err;
+}
--=20
2.25.2

