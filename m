Return-Path: <linux-fsdevel+bounces-27246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F0595FB8F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 23:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC3DF1C2149C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 21:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85E919ADB6;
	Mon, 26 Aug 2024 21:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9cDNfSx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDE719AD87
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 21:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724707210; cv=none; b=czLwUxYT9k16I1R88YwGMIpLiq+NTiP8kH4aNt+Ic/zHlmJBWugHSaIv/PmWx8BLGyMnqYWrl/QG2JHFphu69HFElwyliFxf4Kdk0eHUWIt7lnbbscJ/A7SXGpTiGbYuRhOnM/V3me0/fBIyM8HS7gylE/lQXNS132Jh7+JtEG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724707210; c=relaxed/simple;
	bh=Yop1j2t9YENRO39cwhwSrymZmTy7TmCt7KsuK4eoc44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S3Dj7T6MhmX1V4+2/G3G5uKhQumXEn0b3aM3kWVfzwpraYIqMkuYRrdE6xUxe7/z5JNnZvacoL8spQ2oyQAoNOJT/gcCADudTEMQP2g55u8EQhjqmL4rtmJIX73G/9L/AkOBlHCoT7w6Rt9CjKM3yI5JsjSqZd4exjpyiaot8mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9cDNfSx; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e1651f48c31so4631063276.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 14:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724707208; x=1725312008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BAnUvGPJhPcjr/8DlYb3Io9IRAcd+lsouT0OcFoN3U=;
        b=S9cDNfSxFVq6v8Pn0syBIkdvOQ0Rx3JwDLA56Ccj7Xe0qhgrdYtEcWkcyaMKMzZRU6
         2RiyVTaNql6JFDACdP8Eofa7U1s1HQ8WAomNIa92vv7YELUpMBlhtGRwmpiWtc0NzcUP
         ZgDGoTZlMmZXdgzxolntvWNCfS2xahaUObUHRnD3AWllBAU5fO7sS+Mgl+ng/OGbqQQj
         iN/T7zr3mf6y/nxH/mMxFxHOfEjMmt+30gVBEgJ+1pi33TrqFUo526GZY6P9V4bp0ftB
         +Drx/CzrMsP1y76Rwwl+CtNr3QgjlbbvY5UhOuaDnvR15Kmkrzsb1d2kZ0qjAgOvNuXY
         Gv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724707208; x=1725312008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BAnUvGPJhPcjr/8DlYb3Io9IRAcd+lsouT0OcFoN3U=;
        b=gMBcp9LNu/3eB2ZYCn5V+L71JIMsHegme604iqRoYhm7vllGR1wuVGyVlv8yVUr43j
         RRFnC7nxI27FB6G0wB8W9QCGIEhcUrCftPJQAy3MWdU8fXaXKJyvIPbGygK4O2/XcmMU
         Pc7MyyofMJ1aaopFpRefz/UIcaxqSEabj2W6EJQlqZynUhiB7HughSDdjdVziQ+DVtHP
         KyN3D4yA/lnwndmJrKrOa4CkNc9C4YTZu9BJFogYzYBeLnr1w0umNJo7UWt7vSO5bbot
         bvE560zYp7bEHNYWLKwgFli+UqrTTeFPMCr6hu8uweZ1Ph8tyjKQgdj2T+dqGtqS6UvA
         /V/w==
X-Forwarded-Encrypted: i=1; AJvYcCW2sAxbLw1HOCS+3+Lyg/bpUJwgTiWyxVu/thdSVTBQ0lL6rF4M37WIU80uwDbuLD2+wdEvqGnSV1UV6YHy@vger.kernel.org
X-Gm-Message-State: AOJu0Yzot+S5bPdxRvnYyuCSZADYBXxKib0SPvjEU9juup4EIXNrI2On
	vHPh0fYhhAV0iMYK5fglqb4TZL2H67iOTOkUauDK/SZmbf3nEfZiGqSY3A==
X-Google-Smtp-Source: AGHT+IHXgvaD6/d/lIQ7b4efIHntL5vyqnZsPo2Wm4Qu782ih1Cp5NnUTB+32crxZZjiom5ZXrgzhg==
X-Received: by 2002:a05:6902:2e0c:b0:e11:7a26:29d with SMTP id 3f1490d57ef6-e17a83d4ad8mr12551128276.6.1724707207684;
        Mon, 26 Aug 2024 14:20:07 -0700 (PDT)
Received: from localhost (fwdproxy-nha-008.fbsv.net. [2a03:2880:25ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e178e5698e0sm2214033276.43.2024.08.26.14.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 14:20:07 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v4 5/7] fuse: convert fuse_writepages_fill() to use a folio for its tmp page
Date: Mon, 26 Aug 2024 14:19:06 -0700
Message-ID: <20240826211908.75190-6-joannelkoong@gmail.com>
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

To pave the way for refactoring out the shared logic in
fuse_writepages_fill() and fuse_writepage_locked(), this change converts
the temporary page in fuse_writepages_fill() to use the folio API.

This is similar to the change in e0887e095a80 ("fuse: Convert
fuse_writepage_locked to take a folio"), which converted the tmp page in
fuse_writepage_locked() to use the folio API.

inc_node_page_state() is intentionally preserved here instead of
converting to node_stat_add_folio() since it is updating the stat of the
underlying page and to better maintain API symmetry with
dec_node_page_stat() in fuse_writepage_finish_stat().

No functional changes added.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index c1e938b311fb..b879cd8711c0 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2260,7 +2260,7 @@ static int fuse_writepages_fill(struct folio *folio,
 	struct inode *inode = data->inode;
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	struct page *tmp_page;
+	struct folio *tmp_folio;
 	int err;
 
 	if (wpa && fuse_writepage_need_send(fc, &folio->page, ap, data)) {
@@ -2269,8 +2269,8 @@ static int fuse_writepages_fill(struct folio *folio,
 	}
 
 	err = -ENOMEM;
-	tmp_page = alloc_page(GFP_NOFS | __GFP_HIGHMEM);
-	if (!tmp_page)
+	tmp_folio = folio_alloc(GFP_NOFS | __GFP_HIGHMEM, 0);
+	if (!tmp_folio)
 		goto out_unlock;
 
 	/*
@@ -2290,7 +2290,7 @@ static int fuse_writepages_fill(struct folio *folio,
 		err = -ENOMEM;
 		wpa = fuse_writepage_args_alloc();
 		if (!wpa) {
-			__free_page(tmp_page);
+			folio_put(tmp_folio);
 			goto out_unlock;
 		}
 		fuse_writepage_add_to_bucket(fc, wpa);
@@ -2308,14 +2308,14 @@ static int fuse_writepages_fill(struct folio *folio,
 	}
 	folio_start_writeback(folio);
 
-	copy_highpage(tmp_page, &folio->page);
-	ap->pages[ap->num_pages] = tmp_page;
+	folio_copy(tmp_folio, folio);
+	ap->pages[ap->num_pages] = &tmp_folio->page;
 	ap->descs[ap->num_pages].offset = 0;
 	ap->descs[ap->num_pages].length = PAGE_SIZE;
 	data->orig_pages[ap->num_pages] = &folio->page;
 
 	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
-	inc_node_page_state(tmp_page, NR_WRITEBACK_TEMP);
+	inc_node_page_state(&tmp_folio->page, NR_WRITEBACK_TEMP);
 
 	err = 0;
 	if (data->wpa) {
-- 
2.43.5


