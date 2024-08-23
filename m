Return-Path: <linux-fsdevel+bounces-26935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB9D95D353
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 18:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16FB31F232DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 16:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BEF18DF7E;
	Fri, 23 Aug 2024 16:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cy2dsEz2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9627118BC10
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 16:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724430465; cv=none; b=dT7R0t8+OtmCDiKoYR0ur5ncgG67MCQCyd64r43bxAoSWBnodPTRIsWRBht87yJZgcmeBzYqaVI1mW+ldFZVL3Imm+v1X9mrCQvlJ1I4fMQTRocdbyfbaY9x7HKGwR2z+YaIi+0kWdnOnQ0iK1lI8DGZBSc1dQu/68hzRMCXGFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724430465; c=relaxed/simple;
	bh=s2ckAHicpl/to3zXFLNJePIx3hN+gTnQ2xFFhBBYmXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RC9EJOuF12Ww+kWfzelLF9aKhQRsZc2d3qywLIc9jPDuEN9I6C2AuIDGs0p3jiWbMNd6NogThe3yC1esR+caZtTD2/JMcrYwgj+z3URqAMV6zsy+SKxX7vkIMuQhVpMQwMO/2kH9Ks9jxuOoc8c2mGzCvBSxmGdatRwm9jqpjmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cy2dsEz2; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e1659e9a982so2471693276.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 09:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724430462; x=1725035262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XkDoaQxIl0z3f0TI7q06kib98oK++nBTzRFtBSj71EI=;
        b=Cy2dsEz2NKD34vnwgqsOkyHAhl4Tcc8VgnUNA2cHIdUPUB6f31rvXHMIxVeOEV3djR
         Zy38ZSe1C3lwrp6XO/RVtvoqknFuRB8H9jphdhYYeHBQnTrxvv/hVPzNCbZ3CF0CusLJ
         PrvZpAb0hvbHvZFMdnYHBFH50ZT/J0iBSnqAfNy8Fp2YqIuLtqYEJKFqFXqyTfxWLPfN
         qqFKeWhp/Q/rTv9M360Cj9aFGuneCzVY4oIYBrPKCrTo6OuMst65LuTq4A98fyzBkzu4
         zp2TqmW5QZM1nEvV3t1Etg/6lL2hFKrx62lT5giFot0rhIL0Xofba99DHaUWbjxCJqLx
         Lctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724430462; x=1725035262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XkDoaQxIl0z3f0TI7q06kib98oK++nBTzRFtBSj71EI=;
        b=Ct/4TE//nTwOHdWVCmPNvAy36nal4ZMOuIcO9A6u7xuxzBSl0tzVogGSe443nhwqp1
         qNFBP3i2FnQLXV1E83eCcUO3CWek6fpqIzONoqmQ8flAhRIEdfwf7p127Np003BbBLvj
         fm4W3lvA5z1ZebUktnbmcbgVPaX5kUywrbdo5r7rWVZRuB6PQIX8LxhaLuUXPMPo7+8c
         VEhY2DsFU5MASQ/Cc8XWGxLax3e2TBjLlBOFZRBsGSjac7SZ1Sp4I8SxE9UMJnRSly+p
         jVTRuEUgh5MOO50PPE2m6iShozjvsgTwzM46enCOBMxNuyVUlKdrvJgZokNoHG4JMqRH
         7VRw==
X-Forwarded-Encrypted: i=1; AJvYcCXm2Xw4b6wNewwPQfEcExKM0mJm9jJkKQioZmBRE6m1ZvTOKjEn3KOPgAQKMVJ/2x/q8B93rBi3ysuU+cWu@vger.kernel.org
X-Gm-Message-State: AOJu0Yytp6I/tml5YfyFUr8VGiE8mWUhdo5Ui2fZm7yQMy8Ol9EVeR16
	n3JOagV2RpBvLgX6dOOzZx5W/7chMVgUga3qbCe+lLJ7Hc6wggtQ
X-Google-Smtp-Source: AGHT+IHcIZuM7nffEiX6saPg44AymkHorWl73Ly5LOppl9Fqqnd3BBc0dOHW7TVTj5Nt2NesgDxEPQ==
X-Received: by 2002:a05:6902:200e:b0:e0b:cac5:63bb with SMTP id 3f1490d57ef6-e17a86665d6mr2810326276.46.1724430462509;
        Fri, 23 Aug 2024 09:27:42 -0700 (PDT)
Received: from localhost (fwdproxy-nha-004.fbsv.net. [2a03:2880:25ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e178e4b73f2sm712335276.33.2024.08.23.09.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 09:27:42 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v3 4/9] fuse: clean up error handling in fuse_writepages()
Date: Fri, 23 Aug 2024 09:27:25 -0700
Message-ID: <20240823162730.521499-5-joannelkoong@gmail.com>
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

Clean up the error handling paths in fuse_writepages().
No functional changes added.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 1ae58f93884e..8a9b6e8dbd1b 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2352,9 +2352,8 @@ static int fuse_writepages(struct address_space *mapping,
 	struct fuse_fill_wb_data data;
 	int err;
 
-	err = -EIO;
 	if (fuse_is_bad(inode))
-		goto out;
+		return -EIO;
 
 	if (wbc->sync_mode == WB_SYNC_NONE &&
 	    fc->num_background >= fc->congestion_threshold)
@@ -2364,12 +2363,11 @@ static int fuse_writepages(struct address_space *mapping,
 	data.wpa = NULL;
 	data.ff = NULL;
 
-	err = -ENOMEM;
 	data.orig_pages = kcalloc(fc->max_pages,
 				  sizeof(struct page *),
 				  GFP_NOFS);
 	if (!data.orig_pages)
-		goto out;
+		return -ENOMEM;
 
 	err = write_cache_pages(mapping, wbc, fuse_writepages_fill, &data);
 	if (data.wpa) {
@@ -2380,7 +2378,6 @@ static int fuse_writepages(struct address_space *mapping,
 		fuse_file_put(data.ff, false);
 
 	kfree(data.orig_pages);
-out:
 	return err;
 }
 
-- 
2.43.5


