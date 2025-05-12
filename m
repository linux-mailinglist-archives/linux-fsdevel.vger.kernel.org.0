Return-Path: <linux-fsdevel+bounces-48786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10732AB47C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 01:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52604189C189
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 23:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B50F29A9FF;
	Mon, 12 May 2025 22:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gr0eWbYA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7345229A324
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 22:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747090785; cv=none; b=uNv7ofJz8E8/bZ30IVnt12rx40zVmtEMe2ipHtoGiA1tjA16EFWboYxkZwWbndT3qaBrzh2C5TiVZytrIc18HL/7FsyZRvUCDi58XkxNWF53KZtU1a+8HinjUOhkck2Q31iDl1vWP4QPOP/LbAW1UgMXevGkRQjhgIDoYtFScBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747090785; c=relaxed/simple;
	bh=LAqaHvSLjJ2MRydzcPOGLtXWrjAwkay+yDz7k/N37O8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TIarGVW9kQbOvrmSveJmp4uq+zfk8KoqbTYLq/Xs6wX2CDtB0giRW7dM4yR93rDzqi+6EGw0xEapRjPeCG6+JuXmi5DckGXDzvbygKWZcSHEGHiFxwKshoM4XRufY8k7wqBxqB0JlY4oldqxuaANYE/6JzxNN1EJehxMdiN6dXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gr0eWbYA; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-30a8cbddce3so4360093a91.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 15:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747090784; x=1747695584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2I8wjxaoChwPDYIs3gI9lDqgAgCnqDNISUMiPQWrwuk=;
        b=Gr0eWbYAAjVFW/yJXSvpG1HPpZnpWkhJoySc8ItT42YOEw5v6yuwNx3efBoGEpNwtC
         BwOmn8YJcR5GUP+cBwmRgfD2LR8K4dLnF1fcX/8RdpArfeth3SRCeN5M7C7pEnXWm+4D
         9YYZCZCAY1PMKBNL46BUnp2IrMI63bjCMYmHd/3Gghvjhvs3uD6JDz+mwnjcDfYgB1SJ
         LJoRrqFWFja6HrmC0nZX7AfsL7uv+QO7eCUMJzcer8sQKbleRjyDEYnMC3Fz4WuFBeOQ
         /z+PRksgF2IHM87kA/xZqQvDGYLw7eSGeuyJP6Koo26Ljstvp3wzdmXPVhEIhpCk3Ysn
         /54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747090784; x=1747695584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2I8wjxaoChwPDYIs3gI9lDqgAgCnqDNISUMiPQWrwuk=;
        b=dikwgJlS7wIGl+pZn2tHFpWwFX7CehJKjBjq5qSxwo8k0r4hjPbt8bTKoAcZFAUqZM
         Z2LeIs5HGCgAi4THGABeY++SwDBKFJkIny4U8s05x/fK8MWO43Ex9GyzXN6YfGrT10sa
         Nw+uXlbXeT4X+hVvLoVYL5J8jVdGDdq2zQLqz0TwQTkJCA+aypayk8AZ51Ugg3dzKwmE
         NDMEFHu14e9Yytzbic7NzNaezITLudt16bWyTRCLDgQKPUcr7K5bnrNd6iHHRHCSIact
         SrDHkQ5vJXbnTzbsOffLpzEMc4oV76biK/p1+8sC9Vl6IlXK1fg69xNtn4CyGfgXBK3E
         4ZSQ==
X-Gm-Message-State: AOJu0Ywj24nfoIX47ybYVweyiVcwKp9BXxaORI6jUMBNu/cFlNNrfrbE
	3+5pKtBbbUsc7iBbGMEKa53w9k/qeLc5s8dlS7q4603c2rrF75Uo
X-Gm-Gg: ASbGncskUsxMZfB4q5Bi/nVthKEwWowdElSmJakUaznSWGkZwdtDS1HKHI9TV037slk
	hL14AdVsT60afdyqdUpKaBkbybNIIy4r7SqYtEkK6yQgHImxOMlNAivy9yIneyVzPjRpMlw2kTE
	SAvP30B/vvns4hujprvqi37w1nR8eYSi3TjQhWk2GgSMAKhnh8rbskSVTMfsdRzIn38GXHZ5qwu
	8AjB+loJVHvp2Gcqon0te98UUTS9CzH6x3SMJYJS7cFE4cJfzFdV1MrEOThWy2p+Dit/ZeUR2XM
	lPHHCopYFXGgy17nJqJcX2fkDf6bDoekf32WJeKLK2Ewtw==
X-Google-Smtp-Source: AGHT+IHjHeZpIFbO7kB+WZNw5zbBl0wG5olRPMHTxB8iHFlZ2KA4eU8S9pWCjqOWYxEqlqIgo/5Pww==
X-Received: by 2002:a17:90b:3a8f:b0:2f8:b2c:5ef3 with SMTP id 98e67ed59e1d1-30c3cff4114mr25705081a91.14.1747090783576;
        Mon, 12 May 2025 15:59:43 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:c::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b234922e4ecsm6264608a12.8.2025.05.12.15.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 15:59:43 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm,
	jlayton@kernel.org,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v6 11/11] fuse: support large folios for writeback
Date: Mon, 12 May 2025 15:58:40 -0700
Message-ID: <20250512225840.826249-12-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512225840.826249-1-joannelkoong@gmail.com>
References: <20250512225840.826249-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for folios larger than one page size for writeback.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fuse/file.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index e4d86ced9aac..b27cdbd4bffe 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2015,7 +2015,7 @@ static void fuse_writepage_args_page_fill(struct fuse_writepage_args *wpa, struc
 
 	ap->folios[folio_index] = folio;
 	ap->descs[folio_index].offset = 0;
-	ap->descs[folio_index].length = PAGE_SIZE;
+	ap->descs[folio_index].length = folio_size(folio);
 
 	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
 }
@@ -2089,6 +2089,7 @@ struct fuse_fill_wb_data {
 	struct fuse_file *ff;
 	struct inode *inode;
 	unsigned int max_folios;
+	unsigned int nr_pages;
 };
 
 static bool fuse_pages_realloc(struct fuse_fill_wb_data *data)
@@ -2136,15 +2137,15 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, struct folio *folio,
 	WARN_ON(!ap->num_folios);
 
 	/* Reached max pages */
-	if (ap->num_folios == fc->max_pages)
+	if (data->nr_pages + folio_nr_pages(folio) > fc->max_pages)
 		return true;
 
 	/* Reached max write bytes */
-	if ((ap->num_folios + 1) * PAGE_SIZE > fc->max_write)
+	if ((data->nr_pages * PAGE_SIZE) + folio_size(folio) > fc->max_write)
 		return true;
 
 	/* Discontinuity */
-	if (ap->folios[ap->num_folios - 1]->index + 1 != folio_index(folio))
+	if (folio_next_index(ap->folios[ap->num_folios - 1]) != folio_index(folio))
 		return true;
 
 	/* Need to grow the pages array?  If so, did the expansion fail? */
@@ -2175,6 +2176,7 @@ static int fuse_writepages_fill(struct folio *folio,
 	if (wpa && fuse_writepage_need_send(fc, folio, ap, data)) {
 		fuse_writepages_send(data);
 		data->wpa = NULL;
+		data->nr_pages = 0;
 	}
 
 	if (data->wpa == NULL) {
@@ -2189,6 +2191,7 @@ static int fuse_writepages_fill(struct folio *folio,
 	folio_start_writeback(folio);
 
 	fuse_writepage_args_page_fill(wpa, folio, ap->num_folios);
+	data->nr_pages += folio_nr_pages(folio);
 
 	err = 0;
 	ap->num_folios++;
@@ -2219,6 +2222,7 @@ static int fuse_writepages(struct address_space *mapping,
 	data.inode = inode;
 	data.wpa = NULL;
 	data.ff = NULL;
+	data.nr_pages = 0;
 
 	err = write_cache_pages(mapping, wbc, fuse_writepages_fill, &data);
 	if (data.wpa) {
-- 
2.47.1


