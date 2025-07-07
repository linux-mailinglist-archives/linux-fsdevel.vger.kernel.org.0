Return-Path: <linux-fsdevel+bounces-54200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E32AFBEBF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 01:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5877D560CF6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 23:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA3728DB56;
	Mon,  7 Jul 2025 23:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gj3KtSB8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FB228C024
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 23:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751932022; cv=none; b=rGx/xDZiXzGC96iFrXWM64O8dvrzU1UMFrfVgHg9/D/kaPNGwbgTxIaEVn2322e5kIMSroMwgIa5KotuqeroD67MJ64JubVnugofd2lkRGOrjaH0/i6hgA/l8gOOSMK3yQIvBrIpTTWyyy0dikVVHctvQ6bJmT5TCglIfdAiq7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751932022; c=relaxed/simple;
	bh=plSTx801thNcpCcLoh72RwerLpzwzm2+rum6mriNwxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Az2LLSoeDL0KWZ7TeF7JSox7v7oj56L20k9k3K8YmsTC8vfcx9grINFyEqKEM0y+Wo1Hdgh27tlQ+GRHZi6AJE1WVHf3BJrwdG0lJGeoH4n9ff278JMmpLKuQb8j0lC2IDItzif7a1NAaqY3Dst5UmQcolgMuGNEEvTYhPD9h+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gj3KtSB8; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-236192f8770so24085155ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Jul 2025 16:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751932020; x=1752536820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+twz9nr+oQVhpvFokmcqjrb/5z1Gf99fDgsi3H9vX0s=;
        b=gj3KtSB827ciuixmmv5/P7FRmUKQHEkPVm51VstB3aJ6rnpTPWxhCxqEY1lyypbCIp
         osOnYEVLal4ZExuI9vHwUfKhA+8EnQ7KZi60hJw3tVGJq1tjP/GZNNXaEHwboGLF8Yy3
         AmAVBUEKGNU6ZbbalmEFCIEzfvGeplOtnCboYM/pT1TqD5/jIkjtMlLZopFzQW21qEyu
         eDBfoUYPtCf19E3NG/SRyqGVAc01oy6defL6ljFcyiy/d3/xnzPXUCi4Gpk/lOZzcsNA
         3zzZ7Kl60ox5cUkHXOruypSWArWCT8RqoblzebwnWe/nOdeZ8OGsQJvFNYrbZSin1E5i
         VQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751932020; x=1752536820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+twz9nr+oQVhpvFokmcqjrb/5z1Gf99fDgsi3H9vX0s=;
        b=fNZQ5YMwt0LVfepDWAnGOWmivv+yI/OuqsQRcovroDXc1DuPU0o/8P98Gv2byqsKk7
         c0C3VjQE+tHFAopFPd/kax57QSn71bGtZyvGoM1Z+lHCSs1Zh/rLMhHKqotIvml2IYyK
         7q7x+qc8pwq4hLEh0vRvVim9VEBHpfT0B7mtDhsx/lVr6h3Mf2xQ5lD5M6ULireP1437
         sGuw696beBQr7sDRFZxsdR/4IShZ2m9RRrmnVTQQHvkCOTAm++OD+O/4XbcFzG8QO0be
         kUqikC6bfCBBKc3KrmHiaj0fwJH5wuggFEjaghY3WwZgS8PniJRPi9jL4vZ5nQOLVRL2
         aa5A==
X-Gm-Message-State: AOJu0YxEMW6bgYpSCv9vdVd33Yoqj7CxQ3VpC7UeneQ3+u53AW9x+Vle
	c8ZH05Payl6oF4z07XW3D+ATwvtt9BTHO5k2pbxxLJwB5ZBbYqQ3g86u
X-Gm-Gg: ASbGncsSnc9eUqFXdt8SWrE+1CTKIIHAxBIRlNTqFINeAk31agQWU0OBf/UoQm7E5kg
	C9LDNaWTZVMk8KI1PhvBP/DMQHynEmJabrYsmd54S1TWV3/BJK1XvY5Clo1FCeBq242fVUoouPq
	Tbyc9d8WYr/OFjbiO15y7YDHhp10YPi/R1H7AvrK9yLccCFbPV+NzDzXiQFcFODtukJfG8VIGjt
	tzrXhNuQ02oZdvh53Y2F7OLuT1Dsaiw/7/oB4aeJ0mDeNWaiQBqpfwQRPdvscdrhByMi77vbaMs
	NQru1jrCD4ashnRCkg4BAElzle2yd4lw8LI52pwLc5InggqoruWhLYTW
X-Google-Smtp-Source: AGHT+IHe6aWFkmZiHY5nT8j5aoB0QRlnyEc6aSnXFc+EinKV4FZp1IRJAIdkssVpYR5VErXOdJwaiQ==
X-Received: by 2002:a17:902:e886:b0:235:e1d6:2ac0 with SMTP id d9443c01a7336-23dd1b589dcmr8614215ad.24.1751932020375;
        Mon, 07 Jul 2025 16:47:00 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:8::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455e720sm94844915ad.118.2025.07.07.16.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 16:47:00 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	david@redhat.com,
	willy@infradead.org,
	linux-mm@kvack.org
Subject: [PATCH v2 1/2] fuse: use default writeback accounting
Date: Mon,  7 Jul 2025 16:46:05 -0700
Message-ID: <20250707234606.2300149-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250707234606.2300149-1-joannelkoong@gmail.com>
References: <20250707234606.2300149-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 0c58a97f919c ("fuse: remove tmp folio for writebacks and internal
rb tree") removed temp folios for dirty page writeback. Consequently,
fuse can now use the default writeback accounting.

With switching fuse to use default writeback accounting, there are some
added benefits. This updates wb->writeback_inodes tracking as well now
and updates writeback throughput estimates after writeback completion.

This commit also removes inc_wb_stat() and dec_wb_stat(). These have no
callers anymore now that fuse does not call them.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c              |  9 +--------
 fs/fuse/inode.c             |  2 --
 include/linux/backing-dev.h | 10 ----------
 3 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index adc4aa6810f5..e53331c851eb 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1784,19 +1784,15 @@ static void fuse_writepage_finish(struct fuse_writepage_args *wpa)
 	struct fuse_args_pages *ap = &wpa->ia.ap;
 	struct inode *inode = wpa->inode;
 	struct fuse_inode *fi = get_fuse_inode(inode);
-	struct backing_dev_info *bdi = inode_to_bdi(inode);
 	int i;
 
-	for (i = 0; i < ap->num_folios; i++) {
+	for (i = 0; i < ap->num_folios; i++)
 		/*
 		 * Benchmarks showed that ending writeback within the
 		 * scope of the fi->lock alleviates xarray lock
 		 * contention and noticeably improves performance.
 		 */
 		folio_end_writeback(ap->folios[i]);
-		dec_wb_stat(&bdi->wb, WB_WRITEBACK);
-		wb_writeout_inc(&bdi->wb);
-	}
 
 	wake_up(&fi->page_waitq);
 }
@@ -1982,14 +1978,11 @@ static void fuse_writepage_add_to_bucket(struct fuse_conn *fc,
 static void fuse_writepage_args_page_fill(struct fuse_writepage_args *wpa, struct folio *folio,
 					  uint32_t folio_index)
 {
-	struct inode *inode = folio->mapping->host;
 	struct fuse_args_pages *ap = &wpa->ia.ap;
 
 	ap->folios[folio_index] = folio;
 	ap->descs[folio_index].offset = 0;
 	ap->descs[folio_index].length = folio_size(folio);
-
-	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
 }
 
 static struct fuse_writepage_args *fuse_writepage_args_setup(struct folio *folio,
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index bfe8d8af46f3..a6c064eb7d08 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1557,8 +1557,6 @@ static int fuse_bdi_init(struct fuse_conn *fc, struct super_block *sb)
 	if (err)
 		return err;
 
-	/* fuse does it's own writeback accounting */
-	sb->s_bdi->capabilities &= ~BDI_CAP_WRITEBACK_ACCT;
 	sb->s_bdi->capabilities |= BDI_CAP_STRICTLIMIT;
 
 	/*
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index e721148c95d0..9a1e895dd5df 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -66,16 +66,6 @@ static inline void wb_stat_mod(struct bdi_writeback *wb,
 	percpu_counter_add_batch(&wb->stat[item], amount, WB_STAT_BATCH);
 }
 
-static inline void inc_wb_stat(struct bdi_writeback *wb, enum wb_stat_item item)
-{
-	wb_stat_mod(wb, item, 1);
-}
-
-static inline void dec_wb_stat(struct bdi_writeback *wb, enum wb_stat_item item)
-{
-	wb_stat_mod(wb, item, -1);
-}
-
 static inline s64 wb_stat(struct bdi_writeback *wb, enum wb_stat_item item)
 {
 	return percpu_counter_read_positive(&wb->stat[item]);
-- 
2.47.1


