Return-Path: <linux-fsdevel+bounces-30281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E49C7988B73
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 22:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA413282B50
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 20:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38A41C3314;
	Fri, 27 Sep 2024 20:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="efXUwW9f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5631C2DCC
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 20:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727469957; cv=none; b=kX0HXT3+CUCkTaoEkWpgiuc7y4MZ+YVGI6c/dQ6B1w2MjdWDbrMMKmbiwwCcnYaL0LMlO+GPU3p0u7I5jDtPXc1jkHl4KDsgp097KYjie20ZIwGPkfu8kcfi8utLlXtfGg6MoHOD7gnEE851GtOcysDTwIl7EFhs0t5tXk1gZ1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727469957; c=relaxed/simple;
	bh=+HnPfo1rD7Vgc5AIyDlbXn29yOYJwGnHhzSitOUVI8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oWfDBO33HPX/Whr9lk0UKgJxv+VUTQYlypfzjFV9jf9qLKrAEiccoXcZSI5MKwx02XPAl7jgXUQN8GXXQf8r1X2lJ2EMS3kPpAoZm/sNDjjtYZb1pxxooiPbiMg0et5Rsgy131OWl8vwFWa6oFUmdeKhZPY6KgL2GmOhpi9LEkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=efXUwW9f; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e260b747fdcso682770276.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 13:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727469953; x=1728074753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Z5BCJNtJV/IvtlHntdQ6UJVoG2UpNpzKZHzKW76QrQ=;
        b=efXUwW9f3tycqSji8Rid3lcjbou6Mz4cHll3C7dn+kKQo/8A5z1bgIbpAH3QmNFcuT
         /hBbs3ExxDjFzXBhvj0xzIySYig7bOZTvX4G526owL/LpySPGwFE/bikcLz3BJuzA5xE
         YqEO2Dd1w5m0ODByXUf0sITEZtJqKerYRnVKpyLU80zouPrgxFou43HDZ/D+F2v2QWfe
         rEfGJSyiMx0egxoxOwoWbrHSaIoI8Iq5PDg8T0xbeyzF03204vqfjRuNXnTSCDECaibU
         fWW980OL6xPgIRwjnATk09+dUhkpgQC98V5COV9UyYR6IcOqDYy+SWWSG/t1MH3RsS8O
         W7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727469953; x=1728074753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Z5BCJNtJV/IvtlHntdQ6UJVoG2UpNpzKZHzKW76QrQ=;
        b=ZU3/9VIj1QrmYe5x4B8eyEkDi6iULg0EfBvwTO+g6gOqXG9vxVZw+zS+tSxqVzUQfI
         M0TtTu+FGwGu8EPhWT7Mokh3d3aGItFijlSuuW3+Z5t9sOZGNh8IMsJ4UJyuC5pB1TlP
         zYGt8+rW1/jg0PjwwpfudGZR9PzJb8rz8a5aGJYIVcGevc1b6+wwwKupIJGZjywjCWW/
         pJ7o4jz+09dYezelpdqicr0w2TiirCkLU3UsBmiohn8DEjufuTbQX2ASjXTpXg74yiXw
         YrHqjy9qv1OACjQv77JvQIg+IyiB7MqTVV3E8HHXaSUplG+HQhngAuW6n8tHIXLNtisA
         wx4Q==
X-Gm-Message-State: AOJu0Yz8KZ9sjuZ998HXCzMz+23cmarOT1z3ffzJXx3PpwW91jcoLwL8
	GwnSsD5h36nosg7qNoU6yKNU4iGcGVb/2fbRxjKX9JfXKSpzRXAK6/FN9xibCdCD2s/QTrCpi+r
	v
X-Google-Smtp-Source: AGHT+IGfQT05VlxWYk1EoK77iZjJNtULSY3oA6W5c3MxiHJw9uKqjG8d4V0+QqWpR8Yzttv2cFhujw==
X-Received: by 2002:a05:6902:1b8d:b0:e1d:2f11:3eb9 with SMTP id 3f1490d57ef6-e2604b5f1c3mr3475439276.2.1727469953579;
        Fri, 27 Sep 2024 13:45:53 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e25e400f009sm610712276.17.2024.09.27.13.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 13:45:52 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	kernel-team@fb.com
Cc: Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH v3 08/10] fuse: use the folio based vmstat helpers
Date: Fri, 27 Sep 2024 16:44:59 -0400
Message-ID: <f2a67dd4c204b7de69d9c765c5c33857d1b2654f.1727469663.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727469663.git.josef@toxicpanda.com>
References: <cover.1727469663.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to make it easier to switch to folios in the fuse_args_pages
update the places where we update the vmstat counters for writeback to
use the folio related helpers.  On the inc side this is easy as we
already have the folio, on the dec side we have to page_folio() the
pages for now.

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/file.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index e02093fe539a..4c6eb724212d 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1794,12 +1794,12 @@ static void fuse_writepage_free(struct fuse_writepage_args *wpa)
 	kfree(wpa);
 }
 
-static void fuse_writepage_finish_stat(struct inode *inode, struct page *page)
+static void fuse_writepage_finish_stat(struct inode *inode, struct folio *folio)
 {
 	struct backing_dev_info *bdi = inode_to_bdi(inode);
 
 	dec_wb_stat(&bdi->wb, WB_WRITEBACK);
-	dec_node_page_state(page, NR_WRITEBACK_TEMP);
+	node_stat_sub_folio(folio, NR_WRITEBACK_TEMP);
 	wb_writeout_inc(&bdi->wb);
 }
 
@@ -1811,7 +1811,7 @@ static void fuse_writepage_finish(struct fuse_writepage_args *wpa)
 	int i;
 
 	for (i = 0; i < ap->num_pages; i++)
-		fuse_writepage_finish_stat(inode, ap->pages[i]);
+		fuse_writepage_finish_stat(inode, page_folio(ap->pages[i]));
 
 	wake_up(&fi->page_waitq);
 }
@@ -1866,7 +1866,8 @@ __acquires(fi->lock)
 	for (aux = wpa->next; aux; aux = next) {
 		next = aux->next;
 		aux->next = NULL;
-		fuse_writepage_finish_stat(aux->inode, aux->ia.ap.pages[0]);
+		fuse_writepage_finish_stat(aux->inode,
+					   page_folio(aux->ia.ap.pages[0]));
 		fuse_writepage_free(aux);
 	}
 
@@ -2086,7 +2087,7 @@ static void fuse_writepage_args_page_fill(struct fuse_writepage_args *wpa, struc
 	ap->descs[page_index].length = PAGE_SIZE;
 
 	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
-	inc_node_page_state(&tmp_folio->page, NR_WRITEBACK_TEMP);
+	node_stat_add_folio(tmp_folio, NR_WRITEBACK_TEMP);
 }
 
 static struct fuse_writepage_args *fuse_writepage_args_setup(struct folio *folio,
@@ -2260,7 +2261,8 @@ static bool fuse_writepage_add(struct fuse_writepage_args *new_wpa,
 	spin_unlock(&fi->lock);
 
 	if (tmp) {
-		fuse_writepage_finish_stat(new_wpa->inode, new_ap->pages[0]);
+		fuse_writepage_finish_stat(new_wpa->inode,
+					   page_folio(new_ap->pages[0]));
 		fuse_writepage_free(new_wpa);
 	}
 
-- 
2.43.0


