Return-Path: <linux-fsdevel+bounces-33446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6B29B8CD7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 09:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E24E1C21A03
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 08:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E649C1581F0;
	Fri,  1 Nov 2024 08:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="XpCgs4qU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC13D156649;
	Fri,  1 Nov 2024 08:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730449098; cv=none; b=CCRa0CoLSXOGmNGjlRRNvR+XXTg/pkXgRoh6vbKmNNYfFYzFB1awC+J2yRgvLGkM95fdL/PjjNbbM4EnkxqgcG+71p6LpPzeHhpT5mEBGM3G9TjOD1rq1R5IokrVfGnCKtyWBDNIWheM3CfuenFOK8gJmevcMp79YwokCCwHldE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730449098; c=relaxed/simple;
	bh=eEjdEWKEObATwCOy3KVNohZ3Bg9faDxQpQEjE01gX7E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FBH0x9dCpKM4HA8Z69JR/gIHGaIDGx7q1BH+gLJIX8fKulkWP55K9CmaiRFS35NrVc8oQ7L3H276lv3VSvUGDDp/ZseFlAj7uXFTW++3N0zgrfVxFxY1gOaWOZ4ry1jxL+vvDzIgkc9ttyAoqclQvkh7SAeUPxNYKnuvoUSMEWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=XpCgs4qU; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id E50CB2198;
	Fri,  1 Nov 2024 08:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1730448625;
	bh=6wt1rNVXCzuM0Dm6pcjSNL7+UwMV97d4q0WaqD2PInU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=XpCgs4qUTjjovzfOdYUGp7KTmY6NdMlkqjpvVgEB1Q8oSsd52VOn5lgmVcajicX/m
	 gdAwU7Rhj1U/p7Gf7jHwlDe5YD5kUPySdsffRtPx/uuJsQ57uc8aSlnSyUnC4Wiwiy
	 wqhxQAAEnWbHqA0lz3M2EDy7dbHUGR3TkEpzKQAE=
Received: from ntfs3vm.paragon-software.com (192.168.211.142) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 1 Nov 2024 11:18:08 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 7/7] fs/ntfs3: Accumulated refactoring changes
Date: Fri, 1 Nov 2024 11:17:53 +0300
Message-ID: <20241101081753.10585-8-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241101081753.10585-1-almaz.alexandrovich@paragon-software.com>
References: <20241101081753.10585-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Changes made to improve readability and debuggability.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/bitmap.c  | 62 +++++++++++++---------------------------------
 fs/ntfs3/frecord.c |  1 -
 fs/ntfs3/fsntfs.c  |  2 +-
 fs/ntfs3/run.c     |  6 ++---
 4 files changed, 21 insertions(+), 50 deletions(-)

diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
index cf4fe21a5039..04107b950717 100644
--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -710,20 +710,17 @@ int wnd_set_free(struct wnd_bitmap *wnd, size_t bit, size_t bits)
 {
 	int err = 0;
 	struct super_block *sb = wnd->sb;
-	size_t bits0 = bits;
 	u32 wbits = 8 * sb->s_blocksize;
 	size_t iw = bit >> (sb->s_blocksize_bits + 3);
 	u32 wbit = bit & (wbits - 1);
 	struct buffer_head *bh;
+	u32 op;
 
-	while (iw < wnd->nwnd && bits) {
-		u32 tail, op;
-
+	for (; iw < wnd->nwnd && bits; iw++, bit += op, bits -= op, wbit = 0) {
 		if (iw + 1 == wnd->nwnd)
 			wbits = wnd->bits_last;
 
-		tail = wbits - wbit;
-		op = min_t(u32, tail, bits);
+		op = min_t(u32, wbits - wbit, bits);
 
 		bh = wnd_map(wnd, iw);
 		if (IS_ERR(bh)) {
@@ -736,20 +733,15 @@ int wnd_set_free(struct wnd_bitmap *wnd, size_t bit, size_t bits)
 		ntfs_bitmap_clear_le(bh->b_data, wbit, op);
 
 		wnd->free_bits[iw] += op;
+		wnd->total_zeroes += op;
 
 		set_buffer_uptodate(bh);
 		mark_buffer_dirty(bh);
 		unlock_buffer(bh);
 		put_bh(bh);
 
-		wnd->total_zeroes += op;
-		bits -= op;
-		wbit = 0;
-		iw += 1;
+		wnd_add_free_ext(wnd, bit, op, false);
 	}
-
-	wnd_add_free_ext(wnd, bit, bits0, false);
-
 	return err;
 }
 
@@ -760,20 +752,17 @@ int wnd_set_used(struct wnd_bitmap *wnd, size_t bit, size_t bits)
 {
 	int err = 0;
 	struct super_block *sb = wnd->sb;
-	size_t bits0 = bits;
 	size_t iw = bit >> (sb->s_blocksize_bits + 3);
 	u32 wbits = 8 * sb->s_blocksize;
 	u32 wbit = bit & (wbits - 1);
 	struct buffer_head *bh;
+	u32 op;
 
-	while (iw < wnd->nwnd && bits) {
-		u32 tail, op;
-
+	for (; iw < wnd->nwnd && bits; iw++, bit += op, bits -= op, wbit = 0) {
 		if (unlikely(iw + 1 == wnd->nwnd))
 			wbits = wnd->bits_last;
 
-		tail = wbits - wbit;
-		op = min_t(u32, tail, bits);
+		op = min_t(u32, wbits - wbit, bits);
 
 		bh = wnd_map(wnd, iw);
 		if (IS_ERR(bh)) {
@@ -785,21 +774,16 @@ int wnd_set_used(struct wnd_bitmap *wnd, size_t bit, size_t bits)
 
 		ntfs_bitmap_set_le(bh->b_data, wbit, op);
 		wnd->free_bits[iw] -= op;
+		wnd->total_zeroes -= op;
 
 		set_buffer_uptodate(bh);
 		mark_buffer_dirty(bh);
 		unlock_buffer(bh);
 		put_bh(bh);
 
-		wnd->total_zeroes -= op;
-		bits -= op;
-		wbit = 0;
-		iw += 1;
+		if (!RB_EMPTY_ROOT(&wnd->start_tree))
+			wnd_remove_free_ext(wnd, bit, op);
 	}
-
-	if (!RB_EMPTY_ROOT(&wnd->start_tree))
-		wnd_remove_free_ext(wnd, bit, bits0);
-
 	return err;
 }
 
@@ -852,15 +836,13 @@ static bool wnd_is_free_hlp(struct wnd_bitmap *wnd, size_t bit, size_t bits)
 	size_t iw = bit >> (sb->s_blocksize_bits + 3);
 	u32 wbits = 8 * sb->s_blocksize;
 	u32 wbit = bit & (wbits - 1);
+	u32 op;
 
-	while (iw < wnd->nwnd && bits) {
-		u32 tail, op;
-
+	for (; iw < wnd->nwnd && bits; iw++, bits -= op, wbit = 0) {
 		if (unlikely(iw + 1 == wnd->nwnd))
 			wbits = wnd->bits_last;
 
-		tail = wbits - wbit;
-		op = min_t(u32, tail, bits);
+		op = min_t(u32, wbits - wbit, bits);
 
 		if (wbits != wnd->free_bits[iw]) {
 			bool ret;
@@ -875,10 +857,6 @@ static bool wnd_is_free_hlp(struct wnd_bitmap *wnd, size_t bit, size_t bits)
 			if (!ret)
 				return false;
 		}
-
-		bits -= op;
-		wbit = 0;
-		iw += 1;
 	}
 
 	return true;
@@ -928,6 +906,7 @@ bool wnd_is_used(struct wnd_bitmap *wnd, size_t bit, size_t bits)
 	size_t iw = bit >> (sb->s_blocksize_bits + 3);
 	u32 wbits = 8 * sb->s_blocksize;
 	u32 wbit = bit & (wbits - 1);
+	u32 op;
 	size_t end;
 	struct rb_node *n;
 	struct e_node *e;
@@ -945,14 +924,11 @@ bool wnd_is_used(struct wnd_bitmap *wnd, size_t bit, size_t bits)
 		return false;
 
 use_wnd:
-	while (iw < wnd->nwnd && bits) {
-		u32 tail, op;
-
+	for (; iw < wnd->nwnd && bits; iw++, bits -= op, wbit = 0) {
 		if (unlikely(iw + 1 == wnd->nwnd))
 			wbits = wnd->bits_last;
 
-		tail = wbits - wbit;
-		op = min_t(u32, tail, bits);
+		op = min_t(u32, wbits - wbit, bits);
 
 		if (wnd->free_bits[iw]) {
 			bool ret;
@@ -966,10 +942,6 @@ bool wnd_is_used(struct wnd_bitmap *wnd, size_t bit, size_t bits)
 			if (!ret)
 				goto out;
 		}
-
-		bits -= op;
-		wbit = 0;
-		iw += 1;
 	}
 	ret = true;
 
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index c33e818b3164..8b39d0ce5f28 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -1958,7 +1958,6 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 	if (end > alloc_size)
 		end = alloc_size;
 
-
 	while (vbo < end) {
 		if (idx == -1) {
 			ok = run_lookup_entry(&run, vcn, &lcn, &clen, &idx);
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 0fa636038b4e..03471bc9371c 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -2699,4 +2699,4 @@ int ntfs_set_label(struct ntfs_sb_info *sbi, u8 *label, int len)
 out:
 	__putname(uni);
 	return err;
-}
\ No newline at end of file
+}
diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
index 48566dff0dc9..6e86d66197ef 100644
--- a/fs/ntfs3/run.c
+++ b/fs/ntfs3/run.c
@@ -1112,9 +1112,9 @@ int run_unpack_ex(struct runs_tree *run, struct ntfs_sb_info *sbi, CLST ino,
 		err = wnd_set_used_safe(wnd, lcn, len, &done);
 		if (zone) {
 			/* Restore zone. Lock mft run. */
-			struct rw_semaphore *lock;
-			lock = is_mounted(sbi) ? &sbi->mft.ni->file.run_lock :
-						 NULL;
+			struct rw_semaphore *lock =
+				is_mounted(sbi) ? &sbi->mft.ni->file.run_lock :
+						  NULL;
 			if (lock)
 				down_read(lock);
 			ntfs_refresh_zone(sbi);
-- 
2.34.1


