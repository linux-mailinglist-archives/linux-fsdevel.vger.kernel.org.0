Return-Path: <linux-fsdevel+bounces-27655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5219633B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 23:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C88A81F2336C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 21:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAA51AD3FD;
	Wed, 28 Aug 2024 21:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="SbNd7aJw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C551AC89A
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 21:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724879695; cv=none; b=MyyvSOpImsBdIM2vY/6aJrx/qcFV2YodvH6xfDtZoOOmSiKJtS8+jhpYWFD+a7Cm3XMWb5yngJ4wtovQrGSwHe4+iLNroFtZhiOQC64ArOhAVkxCFD9NJ5on7LvW3tSapoEMnP350Oktb3klZS8H3VgWhxsOuh3t+T7UhYoGwM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724879695; c=relaxed/simple;
	bh=4rZvwGfbKAIBj9NqclSxFrsSSbejHF9TcbujolMP7AU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rh4zDhZghCUVlt4d7gJufO5PXkfrTvvo42bFYyQb180OKWTeeMozcKYcCQd6ZyNFVih0B75VU6yFj/vzQ0bdJ4yfnm7zBL25nzz2g67QyEnYU9O9v4A2zqCurUb2lKxcA/LG4OktVKvu8btuWI3uBBmY0wwe6YoQ44qL0EQKJMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=SbNd7aJw; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a80511d124so8074485a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 14:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724879692; x=1725484492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MusPcByFgHJNuDczFs5hE0TNcGAUiigavtLQWBQ3zbQ=;
        b=SbNd7aJwj0Eo2CT1f5Kll99+sfijmm25TFxpuGnh4YeneV5Gpvfrnx7tk5lYkmk6uu
         VokHWyjDTTdRbQ04ePAG88WC55aJBAP4ZMvx6dMOXnW6pEb0bL/LacwTNeEza8Ddge2i
         dDSNZ2PJARfeHpnQYnhjMgRihtLl0Ro0rAUvAanP/SXSz/HgYvE5zqLXvXFKVky7UPfd
         1n0IliZqQBQoETTmPXI/5XfbgXsLpvWZpre8iwQLVgHRZ4w+s880xOINjEjuBjAOvhZs
         SeW3yjbTvQkKwzZGJ6plVFLjhlKFpONYt8eec2a0bbKCka77Nt8I4MxJfY/Sazhm6BdC
         rWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724879692; x=1725484492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MusPcByFgHJNuDczFs5hE0TNcGAUiigavtLQWBQ3zbQ=;
        b=WmefK6TvVvu8kE15GWEq0J4LArcWaMipU/diTSCxte/Y5fAyETrHLqB+aLxoGq0FJe
         SjVN0Mn7mELxuIrjnoONS8hk+QzCVcPlyrF5q+TFuHYTXU91a/U4xAYSKFQpaOecWDG5
         IfNQTl6V1ixO47MHsXoQD3eTXMtgjkqKsgA448HCA+ijKW5XiqiqtdZGr/tl4Z1RYpYH
         ouvaYmZxYK7raTJIBUXFqUqJuJrwHUBwv1JvGe8eO49yfbRxs034CQdRz/IXWMqqSiH6
         Z5KDrJwvzRFCzc6QMJw4OVCdQlGlqs/mEem6ruuukwAuFSJTZaR1f+/fWUllHhsyub+v
         dr/w==
X-Gm-Message-State: AOJu0YzjQSAJuClb340iYlYveHrw/+6ZD9GXRFeuY67mkBmcr0a1UYyP
	PTeS7xIDAKAUuPfymWPWalqFIxFw4Wb0YoIRmu71KHQ/gNQGSpnV1B5SoXi8B6hVvaCTjJ3VkJ3
	T
X-Google-Smtp-Source: AGHT+IGuFCvTlbgVLr0XDdKTxJsNDwVAp9iuVTPXA8hWxUAPIk6Uf+K4ynAcRjIw7cIUXEIEr1TXzA==
X-Received: by 2002:a05:620a:3945:b0:79f:1105:be3 with SMTP id af79cd13be357-7a8041dcddbmr79627785a.40.1724879692589;
        Wed, 28 Aug 2024 14:14:52 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f41cdd7sm663410785a.135.2024.08.28.14.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 14:14:52 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	joannelkoong@gmail.com,
	bschubert@ddn.com,
	willy@infradead.org
Subject: [PATCH v2 09/11] fuse: use the folio based vmstat helpers
Date: Wed, 28 Aug 2024 17:13:59 -0400
Message-ID: <dcf5cbe34a929057a63b979c9b51850470f77ccb.1724879414.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724879414.git.josef@toxicpanda.com>
References: <cover.1724879414.git.josef@toxicpanda.com>
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
index 8cbfdf4ba136..9556cd31039a 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1852,12 +1852,12 @@ static void fuse_writepage_free(struct fuse_writepage_args *wpa)
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
 
@@ -1869,7 +1869,7 @@ static void fuse_writepage_finish(struct fuse_writepage_args *wpa)
 	int i;
 
 	for (i = 0; i < ap->num_pages; i++)
-		fuse_writepage_finish_stat(inode, ap->pages[i]);
+		fuse_writepage_finish_stat(inode, page_folio(ap->pages[i]));
 
 	wake_up(&fi->page_waitq);
 }
@@ -1924,7 +1924,8 @@ __acquires(fi->lock)
 	for (aux = wpa->next; aux; aux = next) {
 		next = aux->next;
 		aux->next = NULL;
-		fuse_writepage_finish_stat(aux->inode, aux->ia.ap.pages[0]);
+		fuse_writepage_finish_stat(aux->inode,
+					   page_folio(aux->ia.ap.pages[0]));
 		fuse_writepage_free(aux);
 	}
 
@@ -2144,7 +2145,7 @@ static void fuse_writepage_args_page_fill(struct fuse_writepage_args *wpa, struc
 	ap->descs[page_index].length = PAGE_SIZE;
 
 	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
-	inc_node_page_state(&tmp_folio->page, NR_WRITEBACK_TEMP);
+	node_stat_add_folio(tmp_folio, NR_WRITEBACK_TEMP);
 }
 
 static struct fuse_writepage_args *fuse_writepage_args_setup(struct folio *folio,
@@ -2318,7 +2319,8 @@ static bool fuse_writepage_add(struct fuse_writepage_args *new_wpa,
 	spin_unlock(&fi->lock);
 
 	if (tmp) {
-		fuse_writepage_finish_stat(new_wpa->inode, new_ap->pages[0]);
+		fuse_writepage_finish_stat(new_wpa->inode,
+					   page_folio(new_ap->pages[0]));
 		fuse_writepage_free(new_wpa);
 	}
 
-- 
2.43.0


