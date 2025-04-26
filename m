Return-Path: <linux-fsdevel+bounces-47432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3FBA9D695
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 02:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4A324C7FA2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 00:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C60F18E743;
	Sat, 26 Apr 2025 00:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/GzTvp0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7994A1898FB
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Apr 2025 00:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745626223; cv=none; b=hpBuE7mZLJYJGa5io4MsR6XNoH2T95jTC6rCTZBqCMNO5X8gapaT6Yr7axor/5DINf9AZ67cChHp1Z7jePdpNRpGyHJigMAxHd7Plyr5MrkPq3P3Tgf8x1Frh4IUVGWEssppZqtcWgp6ddZMLRvys06n5M7nH2c1lfrYJnUtSNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745626223; c=relaxed/simple;
	bh=Xwi+3YXrfGt2aRsbQTdmcwjzuIejtaiyYLLiGjzdXy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4jAWUtIp36F8KMsws4RMosDYwfydlWszilfXyfsxE1eqtprHcAxfLRHnLGZOdSCh6jMqNHb+ri/Mr4l/WaqrisfoJuBwLoTOdu1jg6hLk57h6mypWA8zrRWyamJKI8BWIwJBgz/d+qRbsni1dK7r6XN9hHNt60zoZGmpAheTLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/GzTvp0; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22d95f0dda4so45283795ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 17:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745626222; x=1746231022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmCF7vGpm9cgnohfV46LCMeO6HeYKM3SCDGgf1HBG60=;
        b=E/GzTvp0MVA1EOQfSrtmloKLyYBiCFohbeEWnHYtgA4UiiCLMw7+PG4hX2rZUgiR9a
         7EiNwxirTRr8Ks8HquXu5lzaKgg5jEuXDUKa1J06AbK1f4hOcecaD9ST2OC7p9X7pRgq
         497SudGdv7KS+OeLNZPVBoTmQG9+XYTgaIIDjYMKsedw8c/+xhCGP+0sxYi36chIksWg
         E3w1s1iCEznAf7H2fNZBMpfY5vnN0EE7OXaRQRsldp8T+3eU2O8dBmt9URVx0Xl/bUcD
         gxq5e6llBbX7xG5n1uR88dwxnACyCBHg7i9IaTqT6rnziyPEj/h7DN4WJzvpdCyMmTCe
         Q0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745626222; x=1746231022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mmCF7vGpm9cgnohfV46LCMeO6HeYKM3SCDGgf1HBG60=;
        b=wy1m30IGd2AZL8UrtRIUJMQMZICO/xHUwoSqa663dk3ZSmNaDY3dBKxF6EHXPWt0Vp
         cyc5t4L0v5afQAxvatctLAIIRzFcaVbZo74vLB3dn3SvaQsJ1Pq1Kcjkna9GsbN6r7Ld
         i0ZlF+Ll0fapIwpN3zn0VXjW+CvYwbXkTHsVW0sXC+O2OmsdqzSY01OuVZzJhheFnuxr
         nR2Ac2HWRjopr0X7DDYBi5I6mBhYtru7Abc7KnpOeKxmMO7/9AqHYqH9dcNWqpvbk6ey
         7640VloCQTRhkl+v/vWddzUPfHiUZS1LKrZkluXXMcyKRQbt09uepn07OCFUXi+89MdC
         Z3tA==
X-Gm-Message-State: AOJu0Yzp84Y0Gf0kTWxxHbSwHOjTvCfTM4a4Q/Vfm9p54CEku3rAifBM
	2LIfgY+ZtQJxIX5zdgV2AHbJHLsgaK+br08lyiF/4mYvrtPS9boo2kVbFQ==
X-Gm-Gg: ASbGncvXHe8Q3Ivpdp7AEMmtDBMhgDvAAs1oP5W33iJ4OEar9ToHURVvNY8n6is8LWs
	oxsCqoERkKQrQC0TTe1P5iW5WUf9JCRMly/Cfwa5mecvUgiHgThUB7z02X9EFUAKiruTmhbfxXL
	VZclOur7wE8qKj4Awf6WChRKuTvHwRLzISRH09ThK4MXvsPVKxpWM5Q6YUxhUUF2rweispbTnPz
	2BGeCRI9uhgA5Z03okwKVA7grT/o4zPqP75qhsKlL1kwIeJY27mwx+KeZvPAG8FMAuQi/u+s6UB
	l6Iw5G1nsC0EL/9PtbvRDTsYkGuOnBxfGRwe
X-Google-Smtp-Source: AGHT+IFh4jvIWWPM+oKYM5Pcwjwj6cDCpi2wb4U4h5lQyI9X4WuqXohNJj09+rRyASQPf+C3lCkDOQ==
X-Received: by 2002:a17:902:cf10:b0:223:635d:3e38 with SMTP id d9443c01a7336-22dbf5da657mr71280745ad.15.1745626221739;
        Fri, 25 Apr 2025 17:10:21 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:40::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d76e16sm38715155ad.44.2025.04.25.17.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 17:10:21 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	jlayton@kernel.org,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v5 09/11] fuse: support large folios for readahead
Date: Fri, 25 Apr 2025 17:08:26 -0700
Message-ID: <20250426000828.3216220-10-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250426000828.3216220-1-joannelkoong@gmail.com>
References: <20250426000828.3216220-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for folios larger than one page size for readahead.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fuse/file.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 1d38486fae50..9a31f2a516b9 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -876,14 +876,13 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
 	fuse_io_free(ia);
 }
 
-static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file)
+static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file,
+				unsigned int count)
 {
 	struct fuse_file *ff = file->private_data;
 	struct fuse_mount *fm = ff->fm;
 	struct fuse_args_pages *ap = &ia->ap;
 	loff_t pos = folio_pos(ap->folios[0]);
-	/* Currently, all folios in FUSE are one page */
-	size_t count = ap->num_folios << PAGE_SHIFT;
 	ssize_t res;
 	int err;
 
@@ -918,6 +917,7 @@ static void fuse_readahead(struct readahead_control *rac)
 	struct inode *inode = rac->mapping->host;
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	unsigned int max_pages, nr_pages;
+	struct folio *folio = NULL;
 
 	if (fuse_is_bad(inode))
 		return;
@@ -939,8 +939,8 @@ static void fuse_readahead(struct readahead_control *rac)
 	while (nr_pages) {
 		struct fuse_io_args *ia;
 		struct fuse_args_pages *ap;
-		struct folio *folio;
 		unsigned cur_pages = min(max_pages, nr_pages);
+		unsigned int pages = 0;
 
 		if (fc->num_background >= fc->congestion_threshold &&
 		    rac->ra->async_size >= readahead_count(rac))
@@ -952,10 +952,12 @@ static void fuse_readahead(struct readahead_control *rac)
 
 		ia = fuse_io_alloc(NULL, cur_pages);
 		if (!ia)
-			return;
+			break;
 		ap = &ia->ap;
 
-		while (ap->num_folios < cur_pages) {
+		while (pages < cur_pages) {
+			unsigned int folio_pages;
+
 			/*
 			 * This returns a folio with a ref held on it.
 			 * The ref needs to be held until the request is
@@ -963,13 +965,29 @@ static void fuse_readahead(struct readahead_control *rac)
 			 * fuse_try_move_page()) drops the ref after it's
 			 * replaced in the page cache.
 			 */
-			folio = __readahead_folio(rac);
+			if (!folio)
+				folio =  __readahead_folio(rac);
+
+			folio_pages = folio_nr_pages(folio);
+			if (folio_pages > cur_pages - pages)
+				break;
+
 			ap->folios[ap->num_folios] = folio;
 			ap->descs[ap->num_folios].length = folio_size(folio);
 			ap->num_folios++;
+			pages += folio_pages;
+			folio = NULL;
+		}
+		if (!pages) {
+			fuse_io_free(ia);
+			break;
 		}
-		fuse_send_readpages(ia, rac->file);
-		nr_pages -= cur_pages;
+		fuse_send_readpages(ia, rac->file, pages << PAGE_SHIFT);
+		nr_pages -= pages;
+	}
+	if (folio) {
+		folio_end_read(folio, false);
+		folio_put(folio);
 	}
 }
 
-- 
2.47.1


