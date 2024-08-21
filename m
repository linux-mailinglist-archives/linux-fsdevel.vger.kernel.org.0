Return-Path: <linux-fsdevel+bounces-26572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F129195A826
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 01:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 353C5B220FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 23:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B3817C9FC;
	Wed, 21 Aug 2024 23:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6DboccK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7F317DFF5
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 23:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724282721; cv=none; b=uG3CMtb2mhq4fzBwZJP3/P9iqZ2nWkFxLK6gJr6Opn2QlCVRaOI3aXc8ACPEVN6ovVjaR10YUubrRR2sqOJ2saQ8BD8ZK5Fik3WNb/PXdVPkD+2nH5Kk924ADNeHTY7Gx8GOhQ8WchEFj7v+UGzvm04GhtF0Wvb/5Zxscc0QAVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724282721; c=relaxed/simple;
	bh=AvGQ2/ApBbWCF0FR4kKYvKKwB6/51/NSgtC96l4Pp0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HmKo9fzzkp4hPhm4J0BOD1WigKQ3sgXx/f0KLv8OsgokzZCIqoELB5W4A5supv/FXYhx2Cdw6A+PrH5E1FiY8DdTgNRny8EIJNNq8LL6LvWmMAFYvpTOrtKVtbmzjR4TLGSWe32Id55WcWD3dc9PlKSHUgbr47w4FMg2jy+6bfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6DboccK; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6b44dd520ceso2874607b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 16:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724282719; x=1724887519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbaJT4tVpba03OH7U7d5AXfEsyZGDpXKX9B2OFgYQIE=;
        b=H6DboccKNgZNbUzdPUiB/cA9trXBJhgj/2rM9crIFClScxAslmtoVIF/zgbffFrPKq
         FtM4KuLAtYv3AUu12OAYVn1hg6vwmC0g0peI7jeQb3ebGQfDalqW1Sc2aOC48YorlSVb
         SqVj98punrCLu/HRF4M0Hrz8QoXPD0E1ri1JVBY/TPxmKipeNNlugMJ184vI7H4qc14c
         gKOTI6GOYp55y4R0XyXqC7aYqQ2TnG2X6JyjgjrwfmORsWOdSlgeKLkptU6rL9mvdgIQ
         sTt4iksEFcQbCD2K2qkBpEcFwcZsoqILBJJkp0AwIT6dEbdIcYI2kIdzn2Iskw0NfHB4
         t+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724282719; x=1724887519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gbaJT4tVpba03OH7U7d5AXfEsyZGDpXKX9B2OFgYQIE=;
        b=t/a2fiDp/xovg/ygs0yVVvpK+OlrgsTig3qREa2bZVKlmGTuMzAEAhVSExQfU26PL7
         T50GJjtOK8SyPKvJjgG6neDOjJlazWBA9PHwOa2xzbh0NIN83PhguUE7Pzx8++Jz30iA
         rjYWysQ9hh47rxYRhHQg4q3CC2IDIxXYhpN45t79lxy6aZ5ZsvMpU+S15elj7IjYekxK
         Ou4y3JkOzjA/YDbtMxtwG/V2v4A0v+danyzXG5OU8UD+L1jDqBug6zzY+CU/oyAJyVb5
         DeXjSNp5fjyqt3K8O5ktLZvThOUF80P1IOJ3Ml6hiKAXmUNCgpWYX4gTp+E5L58jdMN+
         DtQA==
X-Forwarded-Encrypted: i=1; AJvYcCVYUfLAwHrdDu53bO8MelwnCfQbuXVKZdDmNMDVIjqKSAiYhnx5LmJk1ZTF9Xd6dISOpjJ4OKSALD5LYSZy@vger.kernel.org
X-Gm-Message-State: AOJu0YzgIRyl6mguQj4O3TdLbY/B4zy29P+Jcwu5D3RLES8rZ6LBjVMT
	CyzEwne2DqXTuvZe4q3UJpWe7fU+r2zWR/3u1wf90cCbPC0cXYXXVIyLAg==
X-Google-Smtp-Source: AGHT+IHjJTVR+Tan64fSPCMHyvBxYGXeXQTYXx2TNasECeveD7Ze91IPztRycNo3foW/gPBWh+Cr7A==
X-Received: by 2002:a05:690c:108:b0:664:5957:f7a with SMTP id 00721157ae682-6c0fb640ef6mr45626757b3.15.1724282719197;
        Wed, 21 Aug 2024 16:25:19 -0700 (PDT)
Received: from localhost (fwdproxy-nha-114.fbsv.net. [2a03:2880:25ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39d3a9dfdsm374087b3.86.2024.08.21.16.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 16:25:19 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v2 7/9] fuse: move folio_start_writeback to after the allocations in fuse_writepage_locked()
Date: Wed, 21 Aug 2024 16:22:39 -0700
Message-ID: <20240821232241.3573997-8-joannelkoong@gmail.com>
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

Start writeback on the folio after allocating the fuse_writepage_args
and temporary folio, instead of before the allocations.

This change is to pave the way for a following patch which will refactor
out the shared logic in fuse_writepages_fill() and fuse_writepage_locked().

No functional changes added.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 113b7429a818..812b3d043b26 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2060,12 +2060,9 @@ static int fuse_writepage_locked(struct folio *folio)
 	struct folio *tmp_folio;
 	int error = -ENOMEM;
 
-	folio_start_writeback(folio);
-
 	wpa = fuse_writepage_args_alloc();
 	if (!wpa)
 		goto err;
-	ap = &wpa->ia.ap;
 
 	tmp_folio = folio_alloc(GFP_NOFS | __GFP_HIGHMEM, 0);
 	if (!tmp_folio)
@@ -2079,16 +2076,20 @@ static int fuse_writepage_locked(struct folio *folio)
 	fuse_writepage_add_to_bucket(fc, wpa);
 	fuse_write_args_fill(&wpa->ia, wpa->ia.ff, folio_pos(folio), 0);
 
-	folio_copy(tmp_folio, folio);
 	wpa->ia.write.in.write_flags |= FUSE_WRITE_CACHE;
 	wpa->next = NULL;
+	wpa->inode = inode;
+
+	ap = &wpa->ia.ap;
 	ap->args.in_pages = true;
 	ap->num_pages = 1;
+	ap->args.end = fuse_writepage_end;
+
+	folio_start_writeback(folio);
+	folio_copy(tmp_folio, folio);
 	ap->pages[0] = &tmp_folio->page;
 	ap->descs[0].offset = 0;
 	ap->descs[0].length = PAGE_SIZE;
-	ap->args.end = fuse_writepage_end;
-	wpa->inode = inode;
 
 	inc_wb_stat(&inode_to_bdi(inode)->wb, WB_WRITEBACK);
 	node_stat_add_folio(tmp_folio, NR_WRITEBACK_TEMP);
@@ -2109,7 +2110,6 @@ static int fuse_writepage_locked(struct folio *folio)
 	kfree(wpa);
 err:
 	mapping_set_error(folio->mapping, error);
-	folio_end_writeback(folio);
 	return error;
 }
 
-- 
2.43.5


