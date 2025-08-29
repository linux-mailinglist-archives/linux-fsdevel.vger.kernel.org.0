Return-Path: <linux-fsdevel+bounces-59697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCC2B3C5FA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 02:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECE14189D837
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 00:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD53635FC27;
	Fri, 29 Aug 2025 23:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cp14i4Co"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E547431AF0C;
	Fri, 29 Aug 2025 23:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756511921; cv=none; b=Vi+xIZ9MMgkuqGsXwmX+ZhFyUIZ1OKC/eigFkojuYgJeV2cz5KgfgiuTXx3WaIjwLl0VmvIDh2G2EvK3opggRVcwRv55KSyQAa2aV2tZ6alVhtUl+BqPY1NGzPwo6CgOcLs9wvYqdKFt5nSWwbmJCT292OzPVQuIAdn1jpQdbAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756511921; c=relaxed/simple;
	bh=DIlpHFkPr9r2IcaB+pqFT4ySOzEm4lOta5iviaZTkeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YmunxPq20fHq5oywnyJ+S2d5LQ/gSUxUilRG/2JIulZYFl/+5SCou2JlMKYVBeYPcfSaAaRGpXHdbLxpV0smolSiLc8rCZxcpEw/8EeZ233gIod6Jh7anS5F299z0R/JLOOUwg3VWr3koxBo74ZZ1K9pnsU+N8YNJo8WbQf39d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cp14i4Co; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24a1274cfb1so157005ad.2;
        Fri, 29 Aug 2025 16:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756511919; x=1757116719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zn8sDyIvTxrBue4t1ODFxInW7Pz/mV9YXc1UtehcE5A=;
        b=Cp14i4Co5EMEVimX8ruToLsPmaUPYhPKRbbgakqmM05hYMe9/9bkSS2KkQYbi3wNn5
         +RknzORs6j6N0h84xsdN60sfBr3Yw0H4HkAdqG9XiHsfkdhcSVnbuaMcOvXgv9TQmGoY
         TUryUGOFQbX0j+29B3UxjvjQMB090AteO2VAa8TeifWYPK2tDqkhcuf8mn6R1vJOPadA
         EFK4Sp+cFTP5LZzFPNie/lqLic9Kv8lnhpoy+ceKojK1HQEgzGaa/8JqnDv38JmiOHJu
         +BR3WZguvfSH80s1Cat9Yc5oO/66I1Va1pfFBStXOSs6ie2TvpZBw8jwlGAbfdCpx462
         rSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756511919; x=1757116719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zn8sDyIvTxrBue4t1ODFxInW7Pz/mV9YXc1UtehcE5A=;
        b=XmUUPd9PyxYVy4uFhEWv1upZNfw2bxlGpsKWzOuhHXNHze6Z0ggv6Ix0riUiM3yCYs
         Ym6ZqCVH3Sg1/vUqyKARukZ8XwC0qDl+JqfevCicF6BDsWZ7IRoZqnAAmri8u2jSW3QX
         YV2WPuwg/YaI6XrK9CaYMu1Au1LbuwB3sPsfay87BMdMWDTHaHYtDOExTf46CmD9mF6B
         J98G/6/hduQFl8iDGf6AcuxTQ4Mf23zTtSplZB5ibWadOd3pIOH9pP7dcHjYv+26RZB2
         ChEadAFXfH0qi/OPVLyuJrd4yzvWAV5DmAKiqYLne5wIQPKVX8sIRh3hkbw1xpzdUw1+
         AK3w==
X-Forwarded-Encrypted: i=1; AJvYcCVnNbx4oFXjvNqdGsJHBt1QSatgEeoBOMliKG1pVFaQy+/YnpQDS2pPB+ptec4qG+o1kRUcfot8OVGp@vger.kernel.org, AJvYcCXBpGECya2Ie7D1zrSD6fDX30BDn+FNg6RRrWOtD/zWrSZeDbWR69TwG0JJAPuhUUIYI/f7vFtN8t8W3buwvQ==@vger.kernel.org, AJvYcCXC1KUvTr8QE6HRNZRqFJbFFipNZ3/YhJRWCAXfIjTCAXTW+l085b6OOb0qdXYCLD8bY4A9IYkQ74Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIVahtmuRNuYoesP0zCACIjXuNQ0uG+fncKXh+0ONnS/go8oVp
	Cm7nWkuIQSeAKAu8O1qXA+fDjgTpSNxXeNHbBHG38bW2N00VmZsMotWH
X-Gm-Gg: ASbGncvKDSVYdB3F+B5nLUtkPILWuU3rCMtENhIW3tau8rFUj+aR9R1uzCFhOTKLVeR
	kefhAxaCpUkBKUvxunv9EYGSGnpHHqPkz5LwKdLrnul9LjJxX/AsOGNpsKxczs8wGkPbtkfNtUf
	cS/yQew2SxpiKt2G5zvOZ8UbKVIs4vRdWz7Q72dIw6hxOqakmOB4mz/eYeqO27ow7J6qvmiQoir
	R5xmmvAoWwK+jlDmu+wDovOVYimf+F4qL2DsmyymkmfsOGM+wtvvh1DYN4vzWZL45uwSoJV1aB6
	jSvqhZjUSnrUx7AODDRRcdGB7EoiriyMnvTwg90bIWbQCs91bNaoLm6S7166jKFUFQM+tsmfNqU
	1ybLSakks2vRZWiO5uQ==
X-Google-Smtp-Source: AGHT+IHALHHB1104RJNmfTC5QM3Bbyxp+9H4chOY1TYOaWtmbav78Px1Oi5FPbpY9b7sZBnfKz3Ccg==
X-Received: by 2002:a17:902:e80d:b0:248:9b4f:f688 with SMTP id d9443c01a7336-2494485db43mr4535705ad.4.1756511919164;
        Fri, 29 Aug 2025 16:58:39 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:41::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24906598815sm35229055ad.117.2025.08.29.16.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 16:58:38 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v1 16/16] fuse: remove fuse_readpages_end() null mapping check
Date: Fri, 29 Aug 2025 16:56:27 -0700
Message-ID: <20250829235627.4053234-17-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250829235627.4053234-1-joannelkoong@gmail.com>
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove extra logic in fuse_readpages_end() that checks against null
folio mappings. This was added in commit ce534fb05292 ("fuse: allow
splice to move pages"):

"Since the remove_from_page_cache() + add_to_page_cache_locked()
are non-atomic it is possible that the page cache is repopulated in
between the two and add_to_page_cache_locked() will fail.  This
could be fixed by creating a new atomic replace_page_cache_page()
function.

fuse_readpages_end() needed to be reworked so it works even if
page->mapping is NULL for some or all pages which can happen if the
add_to_page_cache_locked() failed."

Commit ef6a3c63112e ("mm: add replace_page_cache_page() function") added
atomic page cache replacement, which means the check against null
mappings can be removed.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 1659603f4cb6..87078f40d446 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -981,22 +981,20 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 	struct fuse_args_pages *ap = &ia->ap;
 	size_t count = ia->read.in.size;
 	size_t num_read = args->out_args[0].size;
-	struct address_space *mapping = NULL;
-
-	for (i = 0; mapping == NULL && i < ap->num_folios; i++)
-		mapping = ap->folios[i]->mapping;
+	struct address_space *mapping;
+	struct inode *inode;
 
-	if (mapping) {
-		struct inode *inode = mapping->host;
+	WARN_ON_ONCE(!ap->num_folios);
+	mapping = ap->folios[0]->mapping;
+	inode = mapping->host;
 
-		/*
-		 * Short read means EOF. If file size is larger, truncate it
-		 */
-		if (!err && num_read < count)
-			fuse_short_read(inode, ia->read.attr_ver, num_read, ap);
+	/*
+	 * Short read means EOF. If file size is larger, truncate it
+	 */
+	if (!err && num_read < count)
+		fuse_short_read(inode, ia->read.attr_ver, num_read, ap);
 
-		fuse_invalidate_atime(inode);
-	}
+	fuse_invalidate_atime(inode);
 
 	for (i = 0; i < ap->num_folios; i++) {
 		iomap_finish_folio_read(ap->folios[i], ap->descs[i].offset,
-- 
2.47.3


