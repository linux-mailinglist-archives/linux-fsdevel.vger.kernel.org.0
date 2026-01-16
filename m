Return-Path: <linux-fsdevel+bounces-74278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 15886D38A6E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Jan 2026 00:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B33D83017137
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 23:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AAA3016F5;
	Fri, 16 Jan 2026 23:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASE3wXVP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884023126DE
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 23:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768607793; cv=none; b=B92hNmV5lFQh86Z9Mo7fOrfxOvSjBFgm/8rUtkdeS6xO43sEWovUmINsWr2157bCpOQIvm6ObpmlPmQiwk3BWbouUowKgCINIReeQClaqxtrNHFjX1W/fsL5s1KS5xWeW7Vo8nJqd/FUoKlCwn8kHCb2Yrj43tBl9qhNGubbeHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768607793; c=relaxed/simple;
	bh=5FnxJ1M6TuPLg1UAZ4mg7e0YyoX3xpk0f/+QILlwIVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lpO7NtQv1h3THe0RwGWZz41+kpMYYFUnwUWjhwdRBd4XhY2hUjgvosounNt8GcW//xdudlFDW+8ahUiM8M+FuSFKAaJ8xEVG5BC+lNtMx5btVDGlSU30C7GNje8kLf7aSOqu8H21vUnyknVjuHfFQJ/RTIgoT+2r4bZvxsIx8ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASE3wXVP; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a0bb2f093aso15974575ad.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jan 2026 15:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768607792; x=1769212592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1a/am0Q9IplTzs11JTcuQh3/SjI5QV+KuEyVXGL+1SM=;
        b=ASE3wXVPcN1AWjt+hDvqKkBz/9kI6o+65vTC/wGo/HfxcYjj54nO/TtlQ5DOF9siGe
         IlJJeLoTn/TpO/sAevznzXceugO7Vf1Lt0s2EBsIFCwLeE4knapaJZy0hCAuJoVEya+W
         Y2Nf+53LjNIfh6v59czKSNSUSxDpDJRQHfiDJOd0a/4otQlJb9cEBNN3X+A+bCKu6Tvu
         OwN0MfAeqlX+e1LpAYQdFbSMkp331dyK7MjVcfX7vRXIlZGtAqGKgv5KZ4DEmMInrRRo
         7uJNHscbQ4QrxP7eb7rrMJxziFKhI55Y7/a6l2QPAVkH1+UtpMmt+4UjYyKCqlJHqgbJ
         6d/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768607792; x=1769212592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1a/am0Q9IplTzs11JTcuQh3/SjI5QV+KuEyVXGL+1SM=;
        b=pE8xkq/+HohZci+oXTEn4wyJ80pwh0CNe/lxKgKWeNeJXTpbmAhwTrz7xtIjl7xXPv
         rNvz6nnr3eU6g4pukQ4UFLjtX5ieRwgCOyhhKWsE8ltdyPrVe+L5secV5OZORhucWcK5
         vSVJ7C7I7ZrBKwKw93nYoeSiCb4E+d6NZUfkGmfQ6WfNcpnkSNnbjCy+sxX+fIgJ6D/2
         pt3+sW/+7fuAWLHaVCO5HQtxAPN5vAM184+cZQKAUx5COyJJAO0F4EF2x+DA1+lTOGfT
         usTKOFuPmVBvbmz7lH3YO/9Yw9GFDSMmUiWmV54VNgmi/8auJJp03PQRedVp5bWdrH5j
         DVOQ==
X-Gm-Message-State: AOJu0YxaFGYC2E4UEHdUpSpkFblJ8+nZRKjdX5PmU/vEQeWrElBq2WFF
	iI5KmE1C/6+DEa8E6K+Pj/hrWryLh31n6VCZAAiqrey45FBNDTQZFlQ1z3Rxmg==
X-Gm-Gg: AY/fxX4Nj7yFtfkZSp9qpkntgtBxvrrUwy9d+ptNY/40XU0AoZRuEaHJkGkuqRVu4Ax
	ssJNe/pde3xPaIgYiLHqQT5lK3DRYUKG59+PO3bqoxm3J8Z3nkt7bXxXmcSbj7hCNF//o4vE3gw
	KvOeHSSbwuBDgtkA483/E9kOpkR9rOCqKP/Ib8YCIwpFMwpSp/ByR4VLBmKklc9Dl3CDGVfxtJW
	GJRfrBTTUNbCG1UjSxid6+xKkPK84AJI2EJSoXR2/cDv7e8U887ch+EQxLqn/dKl4u+tg3JsKcR
	m0djfTY/dh/IraW7WsnYxqdRqlBlUjC9N1BTX+b64zEke9B5ghekVFL0KwhHpmdaRXbThyi6TNf
	N77z/WLacU+RN1TVR/SRP2EgxZM8GWUcbAjjhzSEW2qL/0sV3zfKj5CkzsoGFxqvJzjhME64wxF
	NcoC3JJQ==
X-Received: by 2002:a17:903:41ca:b0:2a0:d4e3:7181 with SMTP id d9443c01a7336-2a7176d2a06mr43430515ad.49.1768607791914;
        Fri, 16 Jan 2026 15:56:31 -0800 (PST)
Received: from localhost ([2a03:2880:ff:43::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ce53fsm31196735ad.30.2026.01.16.15.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 15:56:31 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	jefflexu@linux.alibaba.com
Subject: [PATCH v1 3/3] fuse: use offset_in_page() for page offset calculations
Date: Fri, 16 Jan 2026 15:56:06 -0800
Message-ID: <20260116235606.2205801-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116235606.2205801-1-joannelkoong@gmail.com>
References: <20260116235606.2205801-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace open-coded (x & ~PAGE_MASK) with offset_in_page().

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev.c     | 4 ++--
 fs/fuse/readdir.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 4dda4e24cc90..9ba8ca796ff3 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1792,7 +1792,7 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 
 	mapping = inode->i_mapping;
 	index = outarg.offset >> PAGE_SHIFT;
-	offset = outarg.offset & ~PAGE_MASK;
+	offset = offset_in_page(outarg.offset);
 	file_size = i_size_read(inode);
 	end = outarg.offset + outarg.size;
 	if (end > file_size) {
@@ -1874,7 +1874,7 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 	struct fuse_args_pages *ap;
 	struct fuse_args *args;
 
-	offset = outarg->offset & ~PAGE_MASK;
+	offset = offset_in_page(outarg->offset);
 	file_size = i_size_read(inode);
 
 	num = min(outarg->size, fc->max_write);
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index c2aae2eef086..c88194e52d18 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -52,7 +52,7 @@ static void fuse_add_dirent_to_cache(struct file *file,
 	}
 	version = fi->rdc.version;
 	size = fi->rdc.size;
-	offset = size & ~PAGE_MASK;
+	offset = offset_in_page(size);
 	index = size >> PAGE_SHIFT;
 	/* Dirent doesn't fit in current page?  Jump to next page. */
 	if (offset + reclen > PAGE_SIZE) {
@@ -392,7 +392,7 @@ static enum fuse_parse_result fuse_parse_cache(struct fuse_file *ff,
 					       void *addr, unsigned int size,
 					       struct dir_context *ctx)
 {
-	unsigned int offset = ff->readdir.cache_off & ~PAGE_MASK;
+	unsigned int offset = offset_in_page(ff->readdir.cache_off);
 	enum fuse_parse_result res = FOUND_NONE;
 
 	WARN_ON(offset >= size);
@@ -518,13 +518,13 @@ static int fuse_readdir_cached(struct file *file, struct dir_context *ctx)
 	index = ff->readdir.cache_off >> PAGE_SHIFT;
 
 	if (index == (fi->rdc.size >> PAGE_SHIFT))
-		size = fi->rdc.size & ~PAGE_MASK;
+		size = offset_in_page(fi->rdc.size);
 	else
 		size = PAGE_SIZE;
 	spin_unlock(&fi->rdc.lock);
 
 	/* EOF? */
-	if ((ff->readdir.cache_off & ~PAGE_MASK) == size)
+	if (offset_in_page(ff->readdir.cache_off) == size)
 		return 0;
 
 	page = find_get_page_flags(file->f_mapping, index,
-- 
2.47.3


