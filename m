Return-Path: <linux-fsdevel+bounces-27448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4869618BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 22:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80D011C2198A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 20:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AA61D4146;
	Tue, 27 Aug 2024 20:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="u4F7p8ps"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6781D3653
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 20:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724791592; cv=none; b=LmyXd+VKsL+NoL8Imr+6MVYEE3/4nZzXJumDN0gb5F8WbolxxazIg6kQ/CX3UMcrivkN8nIoIcwRqSm/fsD3lUe0KheXMV/J+tyElUkrZmt/ohHHPmjU8PUjjHpZf6cSG60R+ckoatQt5+n5dohlrWNJ8VNAZhi544ljI0FtBys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724791592; c=relaxed/simple;
	bh=XgJYggbPBA2c9Xr1EQQjg7BmU9Fov0L6xwdn15TjMz4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kRtOml1b4dxXVWqifI0KHU+Yuv5WoWD1Pai5Rc9h3dOpv7hVcTa/aE+ejGWBKAG+FrmWzGDJSuGmKAn2j7W9hX6ghFtV+aDTKmJ6iaODTYqp/l6ju3lXsgQrFM1uN+/PYsx8eQ5prL9Z8Ylob8e6ebLU3LDCPgk5RA3uMFVqGqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=u4F7p8ps; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-709340f1cb1so3063999a34.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 13:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724791590; x=1725396390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=he4O+sxrssYyZF27J4CmArR86KDscMItuRK1/tSV4qI=;
        b=u4F7p8ps+mRppfFepdao25Fs2IJ/9fj0Mz5RjbkAYFH/LdolZRfeFTHG6C66anDRhu
         iges8b4qHcF/e4yMn+VOU8fJh2LRCKIM3Md1UduQzF/ZPkfiDQ0Vy/stutkjWrYrOcOS
         NgA4IzdQqeIHVr+hzwjq/yUetKSIAmvt0L6qgEHNSkRwnKOwOLQ2lH3waKainGb7Nqs4
         91OJrT7qu3O/bAf/EaAdkVY8QU+DrEtgaB78kyyvJKUMqR++rTj8sXsL68G3//l1xbMz
         6YvR4o22RsTpvRmdn8xcsf/VUyqVqUWYbXb09FRfp4MOJpPv3lsg60XTHPtSqG3VNzEZ
         xwcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724791590; x=1725396390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=he4O+sxrssYyZF27J4CmArR86KDscMItuRK1/tSV4qI=;
        b=Wj1KOjo4/5F6ilm/GS5/bhSH1Rpd1Ha3f/jP+24elzj1hC6CWnqcsWQUuBqwI40Rei
         K765M3DKHqGBx9ik090qvYOoAlFulYiw0TvNeeQiaK/gUp03lAqcx0aGFWYHNvyaygri
         GjkZbN/HSKhEqCUCjXyih8vqLAPnH1MNQLQJH/LujAo871PT9VGZufhZGj+/Lq7VxymL
         2sD+mJVNTAZ812NhvqfI9y/6bbUWBo1mp/M4iy8rrMpgG2/rW4xmICtS7CKvkXBwpJiz
         XB2/5TVofXKQyUrB4Z6CkjA3pe8ZCK0YR+NTM+oJ9YrHkw74YM3yo1xruanRxke7ndFr
         V94w==
X-Gm-Message-State: AOJu0YzceH4z/FQrw8hivTCR53aJzYqXXnmqbsN5SMUfyF2t1b0YSLzB
	lST98X0HeUlEdF6+spy8/fI73qqgLnqZ6YjOtq99+miTOPwZHaMo08vLquilx6ZfSPX7Oo4DQ1A
	U
X-Google-Smtp-Source: AGHT+IGRr1vvrfRhnw3diZwAnhvHrwp3KuH7GnnWmsZ2B0dcO5KQ/qhUWXG6A7PCfZTS8RjH6HRAMQ==
X-Received: by 2002:a05:6830:6f87:b0:709:4d7a:3438 with SMTP id 46e09a7af769-70e0eb2b8a6mr17441012a34.11.1724791589916;
        Tue, 27 Aug 2024 13:46:29 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162dcd590sm59035616d6.109.2024.08.27.13.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 13:46:29 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	joannelkoong@gmail.com,
	bschubert@ddn.com
Subject: [PATCH 09/11] fuse: use the folio based vmstat helpers
Date: Tue, 27 Aug 2024 16:45:22 -0400
Message-ID: <d3cc890dfeefcd79d0217c7f1aab7debe604b395.1724791233.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724791233.git.josef@toxicpanda.com>
References: <cover.1724791233.git.josef@toxicpanda.com>
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

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/file.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 3ef6c2f58940..e03b915d8229 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1853,12 +1853,12 @@ static void fuse_writepage_free(struct fuse_writepage_args *wpa)
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
 
@@ -1870,7 +1870,7 @@ static void fuse_writepage_finish(struct fuse_writepage_args *wpa)
 	int i;
 
 	for (i = 0; i < ap->num_pages; i++)
-		fuse_writepage_finish_stat(inode, ap->pages[i]);
+		fuse_writepage_finish_stat(inode, page_folio(ap->pages[i]));
 
 	wake_up(&fi->page_waitq);
 }
@@ -1925,7 +1925,8 @@ __acquires(fi->lock)
 	for (aux = wpa->next; aux; aux = next) {
 		next = aux->next;
 		aux->next = NULL;
-		fuse_writepage_finish_stat(aux->inode, aux->ia.ap.pages[0]);
+		fuse_writepage_finish_stat(aux->inode,
+					   page_folio(aux->ia.ap.pages[0]));
 		fuse_writepage_free(aux);
 	}
 
@@ -2145,7 +2146,7 @@ static void fuse_writepage_args_page_fill(struct fuse_writepage_args *wpa, struc
 	ap->descs[page_index].length = PAGE_SIZE;
 
 	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
-	inc_node_page_state(&tmp_folio->page, NR_WRITEBACK_TEMP);
+	node_stat_add_folio(tmp_folio, NR_WRITEBACK_TEMP);
 }
 
 static struct fuse_writepage_args *fuse_writepage_args_setup(struct folio *folio,
@@ -2319,7 +2320,8 @@ static bool fuse_writepage_add(struct fuse_writepage_args *new_wpa,
 	spin_unlock(&fi->lock);
 
 	if (tmp) {
-		fuse_writepage_finish_stat(new_wpa->inode, new_ap->pages[0]);
+		fuse_writepage_finish_stat(new_wpa->inode,
+					   page_folio(new_ap->pages[0]));
 		fuse_writepage_free(new_wpa);
 	}
 
-- 
2.43.0


