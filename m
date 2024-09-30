Return-Path: <linux-fsdevel+bounces-30368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B821E98A5B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 15:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E98DC1C2164F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2024 13:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388AA19047C;
	Mon, 30 Sep 2024 13:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="VcxRb5fS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3482918E343
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 13:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727703944; cv=none; b=m0qINLtoBAOSx5q4S9/ujA9QJBkE5KjvdtoNrV1c5JAypGOkn9HvbviYhUhs4Ws0bHEeX1C68qpg733Wh7ExAnaqnBAOY3wSGKYqIR24D1PXVuxFc68VUatf8zjHtPQsHHxDiGDfbrZnnPfRlUJmlFFGi1WGk/qcPyyvPpv6lr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727703944; c=relaxed/simple;
	bh=hkji6g9KRmvGRiod0999Qw4pNzeDVZriSsV/ihIGiC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PUJ7DXuvJeYs3EA6BZioRymuiRAb0Xt+7vbK0cBIOxU9JXZ5Nbr5y2sd8Ng1P/VpXrGRX7Jx8DDx6nrS6G6hQBJULitbr7UyZokiHFnneLYmodBs4iz6edYsjiHiF7Y12R5FqxYyHoihuhcC3UZklq+Ef4lsZWU4ziZOeMeZZc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=VcxRb5fS; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-84e9dda8266so1014308241.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Sep 2024 06:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727703941; x=1728308741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPu7E8gCGa+P+gKtfRE2uglpSB3dSETJKz0VOQ1VXsY=;
        b=VcxRb5fSk1lr+LwvxRu5D1bgQOsW2b0m8SsAhXdltAZOCjrnY83TN8w17ouYHzPkCH
         D9jm6Hnxm1gjY33USD8wCaMz6jATKxCQz0KdcOrU+n/XD+GoOFlgBlw+6L19JFhUtRat
         5kOad764GnuREsBUoAapmoQY9nxli2Mh4opz2/os80/A6lONVdCifyZufsvD/8Zfq6Nw
         t4dqFdigva6KZLdH0vBnigD4JO07ZJcep1KQxOneVm9pMGZN08EoRPsG+zih5dyEEzpR
         mQbW838bxDJ31DlTqQz8xxTw6lp62svRiMLhCfri9HFvZGoICqZ/o3IDisbISw7Bpb93
         rL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727703941; x=1728308741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPu7E8gCGa+P+gKtfRE2uglpSB3dSETJKz0VOQ1VXsY=;
        b=NxUTEm+bz6e0jwXNtcyDg6xaiF1hm9NF2KDWIh+Kchfovtyc4o1Ek8fE0A9LIGQsMK
         ygykW5B4zGtSBLeVtGmkWXtxeFDD/TOULc9RjC1jjbhvZ0DfDRZUREYVYStBJBtKCCwH
         Ttr0PIspfuRcKCUsCIxIykITCCxV+H8rqpDznY4ywXCh9o8lnBAOPFdSlseIEp1Apgbe
         L3JF3wAsm/NDv6i/kAjsz4ezfQ+NFY/lWtUUwNkKtSxAW5b+edMPNj4hirVLo0jgaRwB
         JoRQun46Uq3VZgHvHCxOGfx7MtwO7n6NtKXS6zlqk8lKNKEP2TY8bYFFzRtS0Hz8UI+R
         gVqQ==
X-Gm-Message-State: AOJu0YzfFYwc8hXggqpegB0DtUt7N9CK9EgN4VNJDPy5NCNiImXI7yCZ
	enwjN5kYmuntxZWL9qNwIqyVrPHvHXruA5KCPfPA/zr+4OR8XOTxvrfBpbHmqeIB3bYcJ4LlL3r
	N
X-Google-Smtp-Source: AGHT+IF2CLcB3SR2OHM98yyt8fIdc5sTi3K//9JkTEfpJ69wDkpBhtOZuKYF08syizKKDCWB7vEo6A==
X-Received: by 2002:a05:6122:4687:b0:50a:c8bf:dadc with SMTP id 71dfb90a1353d-50ac8bfdeb4mr973580e0c.6.1727703941600;
        Mon, 30 Sep 2024 06:45:41 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b68ec2dsm39621336d6.136.2024.09.30.06.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 06:45:41 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	kernel-team@fb.com
Cc: Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH v4 03/10] fuse: convert fuse_fill_write_pages to use folios
Date: Mon, 30 Sep 2024 09:45:11 -0400
Message-ID: <32197de556a7d51e416449588a233bb904abc1fa.1727703714.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727703714.git.josef@toxicpanda.com>
References: <cover.1727703714.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert this to grab the folio directly, and update all the helpers to
use the folio related functions.

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/file.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 17ac2de61cdb..1f7fe5416139 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1206,7 +1206,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 
 	do {
 		size_t tmp;
-		struct page *page;
+		struct folio *folio;
 		pgoff_t index = pos >> PAGE_SHIFT;
 		size_t bytes = min_t(size_t, PAGE_SIZE - offset,
 				     iov_iter_count(ii));
@@ -1218,25 +1218,27 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 		if (fault_in_iov_iter_readable(ii, bytes))
 			break;
 
-		err = -ENOMEM;
-		page = grab_cache_page_write_begin(mapping, index);
-		if (!page)
+		folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
+					    mapping_gfp_mask(mapping));
+		if (IS_ERR(folio)) {
+			err = PTR_ERR(folio);
 			break;
+		}
 
 		if (mapping_writably_mapped(mapping))
-			flush_dcache_page(page);
+			flush_dcache_folio(folio);
 
-		tmp = copy_page_from_iter_atomic(page, offset, bytes, ii);
-		flush_dcache_page(page);
+		tmp = copy_folio_from_iter_atomic(folio, offset, bytes, ii);
+		flush_dcache_folio(folio);
 
 		if (!tmp) {
-			unlock_page(page);
-			put_page(page);
+			folio_unlock(folio);
+			folio_put(folio);
 			goto again;
 		}
 
 		err = 0;
-		ap->pages[ap->num_pages] = page;
+		ap->pages[ap->num_pages] = &folio->page;
 		ap->descs[ap->num_pages].length = tmp;
 		ap->num_pages++;
 
@@ -1248,10 +1250,10 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 
 		/* If we copied full page, mark it uptodate */
 		if (tmp == PAGE_SIZE)
-			SetPageUptodate(page);
+			folio_mark_uptodate(folio);
 
-		if (PageUptodate(page)) {
-			unlock_page(page);
+		if (folio_test_uptodate(folio)) {
+			folio_unlock(folio);
 		} else {
 			ia->write.page_locked = true;
 			break;
-- 
2.43.0


