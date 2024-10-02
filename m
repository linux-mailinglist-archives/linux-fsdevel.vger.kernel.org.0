Return-Path: <linux-fsdevel+bounces-30743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A7498E13C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 18:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11AF8B23D78
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 16:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099421D14E5;
	Wed,  2 Oct 2024 16:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmpLr+Uk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D041D14EC
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727888122; cv=none; b=B55Y1aHyGVBEaea2dzbcuNluAhHkDZGuIQxRMkMB1aYlcQjCn+nFGY9HPiLhrt9yaGYkkPmaaeLJKs/CuaC+pAvP0ldeYfNeJFk5IQtYPJpE5UAZoOSorlHcxby6JbdDVutcLx/DFJS8OSgMlq+YAgZ1FqH1lGXCMsRdgTjGvcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727888122; c=relaxed/simple;
	bh=JRHHuQwRXz2+Hnu0WUfI9TyImdvFrjKQGCg3+LxWgaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lcCuoic9V/RRgPxYLiDxxVO1DrGj8tdEsvhXR9fqCQPhJ8AWkW+qnV9BHxHFos3EE87CT2ANDLMt2y8mNVKKtUbfWcQkGygSHb0VY9PYn0/DGBjQ2EVw+ZjU4LGyqXx28Ahj1FVb3uSZIpyPsJSGrCIXGaYC90zRE13MNGLuTvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmpLr+Uk; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6e20a8141c7so27547b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Oct 2024 09:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727888120; x=1728492920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKfaqlC2fsT58zvg1HYS/en3/jjO564B4xjmIMOU3EY=;
        b=FmpLr+Uk7B9FY0Fc+bLNa12y8DPfLRcNZhxKBKyHOA6hXEWA8IXnvGpXyg5hE8ZT0T
         KCOQGokIQZCCHrDlb4KroxAlPT/JNMjisQL8qmoRGXuyKrUt0lOzYUwpv5CWzb0nQmup
         skzKW/X6tyFrsXbg6e1/hCGgPjDAitFAOJReti7UXr70eEjLn12QjqCITUEP/joIFt9t
         L68Agk0gjVQuQtAYSdhmIzTiGZizQjAWUt5/zbNEy5qzNLLcAxbF2PWlaBu5tFB/apim
         AZkymPjNxt0HaS7ZQZ+yz8U1HbxR6cPTi6xgIsfwpV+JC8PTmN3TmfzEbK4lhz2Tu6eT
         nyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727888120; x=1728492920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKfaqlC2fsT58zvg1HYS/en3/jjO564B4xjmIMOU3EY=;
        b=JE79PrLtSU7EN91FdOe2cpNeX9yh/ahL1K4S6hfzB/pO9yBjC7HwVGxwMxkJLDWGf0
         qjrFHWebrwZ09kE7YdkjxyAkyEcPt5uV6cXKRB6yqHzPEm5hEMtEtZCPj9jDK11AxrEG
         3Mh1N2pFeKFA0/+P0xEf3fpxCgBByekhT1N3arQ2CV9168Q+ZpFjkIB0MuN5as+36nri
         tfdncQd7b+JlX7ybjkIR66nWt1Vgehping8xYfjAYS95FnUcUsuvzCZajNf41oWgzer5
         vxMteh1+rbsfQ3T7m3L4X8eIcy+iPHw2g25sCnrb7PwhX663+UwlXT5YMjMazSlVgT29
         LI+g==
X-Forwarded-Encrypted: i=1; AJvYcCWtHaDAJx1hf/feJhyMRou0jGRy/aRLTAFXLKuCihoPEFs6+M6PIToCI9XI6zEbj8nGbiWAUScR4J3abOge@vger.kernel.org
X-Gm-Message-State: AOJu0YwG3xvjnqp5Hj7yhR8Js//kCHK/e46VdRgTtGQl24uzpls0sapB
	r6MGHsraWMQKCK92Ffgy7b+POhR0byccvU8ryPs18Uzw4aviaWKTQcEmhw==
X-Google-Smtp-Source: AGHT+IG0tB0qIZ6O8laQn5yErKfK5VjdOPig/HBbd6ukse4huUa669x/hy2ZdNzGdrAPd5tziH66YA==
X-Received: by 2002:a05:690c:660b:b0:6dd:cdb9:cf2a with SMTP id 00721157ae682-6e2a2ae925cmr32671447b3.1.1727888119787;
        Wed, 02 Oct 2024 09:55:19 -0700 (PDT)
Received: from localhost (fwdproxy-nha-113.fbsv.net. [2a03:2880:25ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e245369a15sm25226227b3.75.2024.10.02.09.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 09:55:19 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH 05/13] fuse: convert readdir to use folios
Date: Wed,  2 Oct 2024 09:52:45 -0700
Message-ID: <20241002165253.3872513-6-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241002165253.3872513-1-joannelkoong@gmail.com>
References: <20241002165253.3872513-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert readdir requests to use a folio instead of a page.

No functional changes.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/readdir.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 0377b6dc24c8..fd0eff1b9f2d 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -331,24 +331,25 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
 {
 	int plus;
 	ssize_t res;
-	struct page *page;
+	struct folio *folio;
 	struct inode *inode = file_inode(file);
 	struct fuse_mount *fm = get_fuse_mount(inode);
 	struct fuse_io_args ia = {};
 	struct fuse_args_pages *ap = &ia.ap;
-	struct fuse_page_desc desc = { .length = PAGE_SIZE };
+	struct fuse_folio_desc desc = { .length = PAGE_SIZE };
 	u64 attr_version = 0;
 	bool locked;
 
-	page = alloc_page(GFP_KERNEL);
-	if (!page)
+	folio = folio_alloc(GFP_KERNEL, 0);
+	if (!folio)
 		return -ENOMEM;
 
 	plus = fuse_use_readdirplus(inode, ctx);
 	ap->args.out_pages = true;
-	ap->num_pages = 1;
-	ap->pages = &page;
-	ap->descs = &desc;
+	ap->uses_folios = true;
+	ap->num_folios = 1;
+	ap->folios = &folio;
+	ap->folio_descs = &desc;
 	if (plus) {
 		attr_version = fuse_get_attr_version(fm->fc);
 		fuse_read_args_fill(&ia, file, ctx->pos, PAGE_SIZE,
@@ -367,15 +368,15 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
 			if (ff->open_flags & FOPEN_CACHE_DIR)
 				fuse_readdir_cache_end(file, ctx->pos);
 		} else if (plus) {
-			res = parse_dirplusfile(page_address(page), res,
+			res = parse_dirplusfile(folio_address(folio), res,
 						file, ctx, attr_version);
 		} else {
-			res = parse_dirfile(page_address(page), res, file,
+			res = parse_dirfile(folio_address(folio), res, file,
 					    ctx);
 		}
 	}
 
-	__free_page(page);
+	folio_put(folio);
 	fuse_invalidate_atime(inode);
 	return res;
 }
-- 
2.43.5


