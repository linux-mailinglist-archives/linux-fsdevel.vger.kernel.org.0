Return-Path: <linux-fsdevel+bounces-27245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C163495FB8E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 23:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34AFAB2330B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 21:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C56A19AD9E;
	Mon, 26 Aug 2024 21:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uyg2jQrL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C68A19AA58
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 21:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724707209; cv=none; b=bkqF3/mI0TKi3DJt9a2OjD22vRsyw0bRCse3n6q1fLJzGzUsjQlzu1c6hpeZz5NQ8Z07MjRhDSC1gzH9wVHfnbIEDcOfLB0EOYvnNCCM0+jWPRNcygLWd90wMSgffwKKdQc4uHtHe3j3MIbGCI1YmJrK118wKqdI0s1vF/kMK4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724707209; c=relaxed/simple;
	bh=MI67R3EFlEteAIneyFvcwUjoT88X/jb216z/arR+gWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bZVsE7949blIxQ9VjoZ76MV4RHCkr+kclCldE/dxMamaXh5bztk6tSGLsVhITv4zdG0z4r5Hu2Bys5bl7IpT6Y9BcvtKbcRuuidmYBHG90xsQklt9TO8dqR9cvT7zwmTwTmhayzribNBLpQFjJFLBuWqa87jxIzRYtQKnDpezGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uyg2jQrL; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6b4412fac76so42780137b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 14:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724707206; x=1725312006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9vnF1Yy0n52GKgZoGqTfLdAbmplD+rdXNElY03loVQ=;
        b=Uyg2jQrL4c7KG+ZDRD/9PeSsdn2wQrpCfsiDerIgIM+04T+7HYmdm9wSHUfhxuFKU+
         zRsDqBAnP2i0ViVuvac5/YUnFU22RQnFIQBhI498xgGYJ4McOaLQvD8UgIi8sW3+w3sW
         rtnDSwck98IaTS4Cq/pQJ8DSgi1aBQyNnOP5QYBH1QAfX5RI4Ymxld7R3shEE+fJR6Wt
         XHEEAErIxWW1QuPnyK+jZNopIXVtvE9YxMDs4o9FuVrYWQbGYzHFz1uNp5ZYNz62qIGx
         Nwl+XKQRgcbbXCfcBimrZV4k/g4116LkE9mKjuK/Dy875nZC4X4rk7LQoPBFqsJ6MgCs
         9LQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724707206; x=1725312006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9vnF1Yy0n52GKgZoGqTfLdAbmplD+rdXNElY03loVQ=;
        b=RcPhE89dn3z/6p8bbbSqP76Lz2AvMgVYk/mJkGsmnc9Ejy9quYKDmL6rHM9rS58doQ
         XeFzKekCH4S0wNZ81AXmNzP/zTZJZt8g6iUfhAAKDRwPG0+OQsDJuD42Dq77cZfLZZTS
         u7Dm2OrJONHvxofYcflYqOHEeYx3WoeCG/KQsp3alvB7Vwlwwhzz5f94wzERGTESN6Wl
         D9ef7QHSmxv1xPSiozcl2B4UWYabu7Phf+uEFCEoxAx39lPyMCufCWvCOxTFv+pCfPeM
         iLpLjQy+1Bdt2KGrvFY41FJRO7/zidgDJKUxUiPDmj0yOGOR1X3UoWid3IVQEPSdvPzZ
         j0NQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV3Zdnm+C/4ieErJNth5XtQTBZJNy0QLtDEgWUGEx5wNBfhCCfcmWMJF+gllsgWgCE/apipkFtKLgb8R2l@vger.kernel.org
X-Gm-Message-State: AOJu0YwAhtHxmn/YKm1Rm5xbcpUWOqkFZDIYVsGOweTO1fULqVnZfaJA
	NqOZhS+GUoBVWD8XfwvzitFAUJwXbPhTzyu/QTiqsSkE9Gst1aTl
X-Google-Smtp-Source: AGHT+IEJ4+PPCuMbKBBlj/iLl+4b1colQAO20+w3poqvXpnQzUT9S7/U74fzBYgj6eMUyVlN7C46CA==
X-Received: by 2002:a05:690c:380b:b0:6c1:2b6d:1964 with SMTP id 00721157ae682-6c62906557cmr137667497b3.38.1724707206594;
        Mon, 26 Aug 2024 14:20:06 -0700 (PDT)
Received: from localhost (fwdproxy-nha-114.fbsv.net. [2a03:2880:25ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39b005b4asm16618867b3.62.2024.08.26.14.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 14:20:06 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v4 4/7] fuse: move initialization of fuse_file to fuse_writepages() instead of in callback
Date: Mon, 26 Aug 2024 14:19:05 -0700
Message-ID: <20240826211908.75190-5-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240826211908.75190-1-joannelkoong@gmail.com>
References: <20240826211908.75190-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prior to this change, data->ff is checked and if not initialized then
initialized in the fuse_writepages_fill() callback, which gets called
for every dirty page in the address space mapping.

This logic is better placed in the main fuse_writepages() caller where
data.ff is initialized before walking the dirty pages.

No functional changes added.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 1ae58f93884e..c1e938b311fb 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2263,13 +2263,6 @@ static int fuse_writepages_fill(struct folio *folio,
 	struct page *tmp_page;
 	int err;
 
-	if (!data->ff) {
-		err = -EIO;
-		data->ff = fuse_write_file_get(fi);
-		if (!data->ff)
-			goto out_unlock;
-	}
-
 	if (wpa && fuse_writepage_need_send(fc, &folio->page, ap, data)) {
 		fuse_writepages_send(data);
 		data->wpa = NULL;
@@ -2348,13 +2341,13 @@ static int fuse_writepages(struct address_space *mapping,
 			   struct writeback_control *wbc)
 {
 	struct inode *inode = mapping->host;
+	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_fill_wb_data data;
 	int err;
 
-	err = -EIO;
 	if (fuse_is_bad(inode))
-		goto out;
+		return -EIO;
 
 	if (wbc->sync_mode == WB_SYNC_NONE &&
 	    fc->num_background >= fc->congestion_threshold)
@@ -2362,7 +2355,9 @@ static int fuse_writepages(struct address_space *mapping,
 
 	data.inode = inode;
 	data.wpa = NULL;
-	data.ff = NULL;
+	data.ff = fuse_write_file_get(fi);
+	if (!data.ff)
+		return -EIO;
 
 	err = -ENOMEM;
 	data.orig_pages = kcalloc(fc->max_pages,
@@ -2376,11 +2371,10 @@ static int fuse_writepages(struct address_space *mapping,
 		WARN_ON(!data.wpa->ia.ap.num_pages);
 		fuse_writepages_send(&data);
 	}
-	if (data.ff)
-		fuse_file_put(data.ff, false);
 
 	kfree(data.orig_pages);
 out:
+	fuse_file_put(data.ff, false);
 	return err;
 }
 
-- 
2.43.5


