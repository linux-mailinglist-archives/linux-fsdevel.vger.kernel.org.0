Return-Path: <linux-fsdevel+bounces-26570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2B295A824
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C70FD1F22C3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 23:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD84F17DFF0;
	Wed, 21 Aug 2024 23:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RM3qbp1v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB811494AD
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 23:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724282719; cv=none; b=XB5Whfd7LmIFJo/sRcqjxZIpZJ5tGW3juqztryIiboJywajigqTlAcUXlmC7oQZB0EcPXj1zNG1sBEg8DAWs2UJrjGbRoBO3wJz1cANXli4W33y7+9EIimu2EDtZyLiDLsKmtT7tNi5be0ANJJMzMTWFysTlexAlnR8W6sBmQXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724282719; c=relaxed/simple;
	bh=HWgCgryQWKqUPf1F23GgzyxFpEVzrg4+0deuTRBk/8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cIt7aY28ySc+CAXcwI0xwI4Fjozer5x/Dt0XJ/nHbfExXLFIdxUexyG7xYAKzuiW+Z+/W+V5jTR3DAYFC0nSxpn4K5srY0QWf1hWR9B2yfAIYhVqDyBw266/JHCf/ZVKA9ih2Y+Kc15GKJfsVVZ8U1REM3RDyLck/0Tcq9y6UTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RM3qbp1v; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e16582cb9f9so183903276.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 16:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724282716; x=1724887516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWSf9y4vnGgRe1UtTUvWGOAMlUUVPnm9f7sh6h6bro4=;
        b=RM3qbp1vXa3qf1VCwA6Vew17Ieatq9Hc2+HW/qr6ScUFrzEaiL2Wu+MDKuzKnDjAYn
         tGo4ZR59yAXsnJgctMdDIWVI/k3zh14EZFOaLdoIZYhuL50zH9XC+OeFM+Alqfe3ry9k
         tfpKGyxQLN2Zb56wyiWqFP1U+9OFezuKXhMdq4OSvTg+3/uVV7P2Yq0cjCjoLVDqkjR5
         cZjKsKqmN3OVEdsjCkfjag55UxfZ03LHp42lZONBLoQWobbc5rhhWonVLyEJHnp6noUq
         Wa6Sf0Di11e9WYNKkhDWIG+8ubtmCpONeSLSbCitqEmu4wVu+zru403TrhqlEjwovl6B
         hO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724282716; x=1724887516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWSf9y4vnGgRe1UtTUvWGOAMlUUVPnm9f7sh6h6bro4=;
        b=SymlJ3niRqItgD6VSXwQsUllFvspQV5NjDW+Um3GuNjuV+d8EuOUrq9eveKmU28bLV
         mYnJl/hbQsI2c95dviHMPyK7/C9FXV/9vhYl/DQwXoBnEkXyua66nE4dSlb2cSFMvMOS
         eN28SbQjXi58wdxtnrFiQNzpB0Hws+q6MsszrPFC1Iqj2O1RVgzsV9zBNBOIJ3r8HYTF
         vl5iZBGiVdH7L9xKjMX32wH+EKxherSMG/iAbo48y8TVWQXS707XN0Sn+6CRc0u684Wj
         65cqDDcFD7ancwdiz4w5CpfPW3Y6IrZV0Z23Agcr4ZDv1iFt0T+h/g/ZX2jyg+CjrnMM
         9WxA==
X-Forwarded-Encrypted: i=1; AJvYcCU81vz1Vg6nZZi0XRDSfcVViibAcZRw/2aQURCxxogWTh/AuBGQ3LuD2kJ90F+ly1GDayzo7yJUT1p/C5NV@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy8lTOpu4s0GMjuwSoORDevcE/9XFcYmXUis/VSKEdZBvd/0Oj
	rTzu3mOjO6uyZr2PL6mErya2nMAf7ZxdYKfo16t/UZcBO2msQe8N
X-Google-Smtp-Source: AGHT+IE0DmLuZ41ciAIo1sTcFw4sAEG19VFaf0/TxAp+RiC4MYEkN5l3IbUOIh8d/qjP66CFmZuMIQ==
X-Received: by 2002:a05:6902:2288:b0:e0b:d2e3:4da7 with SMTP id 3f1490d57ef6-e177e0ca53emr1252154276.18.1724282716617;
        Wed, 21 Aug 2024 16:25:16 -0700 (PDT)
Received: from localhost (fwdproxy-nha-116.fbsv.net. [2a03:2880:25ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e178e6813e1sm56555276.64.2024.08.21.16.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 16:25:16 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v2 5/9] fuse: move initialization of fuse_file to fuse_writepages() instead of in callback
Date: Wed, 21 Aug 2024 16:22:37 -0700
Message-ID: <20240821232241.3573997-6-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240821232241.3573997-1-joannelkoong@gmail.com>
References: <20240821232241.3573997-1-joannelkoong@gmail.com>
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
 fs/fuse/file.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 8a9b6e8dbd1b..147645d7e5d9 100644
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
@@ -2348,6 +2341,7 @@ static int fuse_writepages(struct address_space *mapping,
 			   struct writeback_control *wbc)
 {
 	struct inode *inode = mapping->host;
+	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_fill_wb_data data;
 	int err;
@@ -2361,21 +2355,25 @@ static int fuse_writepages(struct address_space *mapping,
 
 	data.inode = inode;
 	data.wpa = NULL;
-	data.ff = NULL;
+	data.ff = fuse_write_file_get(fi);
+	if (!data.ff)
+		return -EIO;
 
 	data.orig_pages = kcalloc(fc->max_pages,
 				  sizeof(struct page *),
 				  GFP_NOFS);
-	if (!data.orig_pages)
+	if (!data.orig_pages) {
+		fuse_file_put(data.ff, false);
 		return -ENOMEM;
+	}
 
 	err = write_cache_pages(mapping, wbc, fuse_writepages_fill, &data);
 	if (data.wpa) {
 		WARN_ON(!data.wpa->ia.ap.num_pages);
 		fuse_writepages_send(&data);
 	}
-	if (data.ff)
-		fuse_file_put(data.ff, false);
+
+	fuse_file_put(data.ff, false);
 
 	kfree(data.orig_pages);
 	return err;
-- 
2.43.5


