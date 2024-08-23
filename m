Return-Path: <linux-fsdevel+bounces-26936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5DA95D354
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 18:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E813228479E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 16:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDDD18DF96;
	Fri, 23 Aug 2024 16:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWNvzrwq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEF318BC2C
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 16:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724430466; cv=none; b=ko1W+t+OoNqW3k60ozRH0Mgn0chvWEcTJ6kNZuviJbAL4dy3kGfjM0+Yv3A8IT4cZWMD4AdOPkgwB4taqXMRY5ICjxz+wwMNB84cKbGeHEGgGk2UlYp5Ymf/ffUfavXEg9BXhZyJ31KuIMkmW4ZBiIoLt0B9S0ogdPXrfQGYIFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724430466; c=relaxed/simple;
	bh=2hl7CHEMpJthJ2Gv/rGTxI8M0xUZep1a2SROzXYq36Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/Ko+2aLTTJKSxxwQTR5lPouXbYeeaRNsPfyjyFp4fcxIA3vLBI0I2G/5Gboahv1BFIGEf7QwG5E2/lOZd4VtlfOKCAiyW4EgsaGpmvJ4kQzbGzuWardhKq2WVQansB3E85Z0SnNoK9ROyWm0DfwZRNMO76f/SvrnuWgEaL1t90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWNvzrwq; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e13cce6dc85so2196781276.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 09:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724430464; x=1725035264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SnBL8Jku7P0e8a6SKmjqla9DRPRM4ac6C8nHST2s0DI=;
        b=DWNvzrwqN+8U5QAX3ACBlFIubNOS7FBUKJIQ1Vf9ad8zxjrfdTeV4+6xL5SPchn+dG
         L25wIDX88qRIV2HqPEw4a+R/FLyALTtN7Ai1rGbZYHegjOnlm60ozE2LDiN+4baUjVux
         nIrLKWksAX2SF79Rrm+s7hmjGjy11GkV1+xDOPnT25K6eMkRA3dgn1ulp7qqys6LGvTK
         yK6MPvvobH0JX1mEnusD6LFMLxUThuXK20xi6SiOwA0ZQZipfTUnO9bwap5HQq+/qyQu
         6ogsHKlgp/hqUvSYLOxocQHOImelmxr2G0V4g7ORfQT524mWvUlbN7PCeE9eWeqn7dcu
         rTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724430464; x=1725035264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SnBL8Jku7P0e8a6SKmjqla9DRPRM4ac6C8nHST2s0DI=;
        b=F0zUdbWqBZ+rD+kpbmn0JkagkVGNQyTsZX1nFvyBJAMhpcV3HMMfJ/beRVo1RWwQuf
         2UpBNALqzenr55dpjZKbqL/zEee0sEJXDgSFcUYIrWJ6aYtMV2EtjA3btpIlXtjCIuxB
         c4acTX30Io9GEKqEixF0J4a73NGdDtiMwaq1k+tvGQ7/4HtOdRwAwsiBpuJMMkn+Gexs
         +4lJW85i0cOIZOfVgoOswSbpfdSa5tSXF4V4eEX/UOHE2+6HTrOSIvBjnT7I2AZihMfs
         l7Bly60Yw+1RvgJCL2iQLDKObYRCzHb/jLrwfUBVadi9OQhgP27JsTM6J5wutcwYBC5C
         fY1A==
X-Forwarded-Encrypted: i=1; AJvYcCVzx/iybwV6OxcKHL81PFq5ONTAOtQsafcYj8chQOaZpiVa5rjlOBWS+3J0ciZfqjv+rV7pyj+gKTrtaTJv@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7BFEL1nuDI8SWF+4rx/eJySnuEPRKew7qO4TTcWJDwNL0lOW+
	QiYj1PkEOv1tMFFAgU2gG3gK68SDMA7KsqDxNXyZLekJGU3BJzMw
X-Google-Smtp-Source: AGHT+IHJH2XLTpUohMXuQqmUTWAKU8wYYmIoz+Fo+A5raRnZ12ua2TS7XHr6e/mVKh9EWNmV7sA0GQ==
X-Received: by 2002:a05:690c:ed5:b0:6ad:75f6:679f with SMTP id 00721157ae682-6c6251a3c1bmr32712627b3.6.1724430463638;
        Fri, 23 Aug 2024 09:27:43 -0700 (PDT)
Received: from localhost (fwdproxy-nha-112.fbsv.net. [2a03:2880:25ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39b007fbesm5983697b3.70.2024.08.23.09.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 09:27:43 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v3 5/9] fuse: move initialization of fuse_file to fuse_writepages() instead of in callback
Date: Fri, 23 Aug 2024 09:27:26 -0700
Message-ID: <20240823162730.521499-6-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240823162730.521499-1-joannelkoong@gmail.com>
References: <20240823162730.521499-1-joannelkoong@gmail.com>
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
 fs/fuse/file.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 8a9b6e8dbd1b..a51b0b085616 100644
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
@@ -2361,23 +2355,26 @@ static int fuse_writepages(struct address_space *mapping,
 
 	data.inode = inode;
 	data.wpa = NULL;
-	data.ff = NULL;
+	data.ff = fuse_write_file_get(fi);
+	if (!data.ff)
+		return -EIO;
 
 	data.orig_pages = kcalloc(fc->max_pages,
 				  sizeof(struct page *),
 				  GFP_NOFS);
+	err = -ENOMEM;
 	if (!data.orig_pages)
-		return -ENOMEM;
+		goto out;
 
 	err = write_cache_pages(mapping, wbc, fuse_writepages_fill, &data);
 	if (data.wpa) {
 		WARN_ON(!data.wpa->ia.ap.num_pages);
 		fuse_writepages_send(&data);
 	}
-	if (data.ff)
-		fuse_file_put(data.ff, false);
 
 	kfree(data.orig_pages);
+out:
+	fuse_file_put(data.ff, false);
 	return err;
 }
 
-- 
2.43.5


