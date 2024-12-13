Return-Path: <linux-fsdevel+bounces-37388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 287599F1910
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 23:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90A54188F020
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 22:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE541F03E3;
	Fri, 13 Dec 2024 22:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5L7xbJ5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F42E1EF092
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 22:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734128601; cv=none; b=GOkHkDAZGRidnBjCbNRFUDq827noqUDFOcZKkPnPeBlGOG8CgOVRWnKeqLvjuptP1q3/pss78gX2WjuAYXNUY+2I9vrCBxgoF4mK5ftpTTQJxH2s4F1VXOpgFqftfW8bpNJAoRmrIlxdQGg4rMvVclgBxb/3AtS+hlsxXofBsM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734128601; c=relaxed/simple;
	bh=0Zvj+ySnMUIReLWVh/5PQ0zXytuL1VW9GMCIkqgX2cM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJr4X2cGEpGO5GJ6JdK9oxx6Rj0qq+UXzT9LkEBJ4zSj4buWqc/BTXj8tuPjgEw7y3+kqMICvZ1h3+eB6UWU9htJAiOEFIpNiUN8v7lBFQc0kx77p09k2xTXClqDGAmgoFTd+cgzjwPlog/V8yLK+cGxLxhmG9HozT6XZXHPbqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5L7xbJ5; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e460717039fso494056276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 14:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734128598; x=1734733398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6w76K9YeaXpnU4/sQG9t66TH+CfDvGBOfAKZrQMVHII=;
        b=B5L7xbJ5jc4DmtOaqIB0Tda5iCpri1NeIaDbXoaSwcnYC5BmUFXymiYfqjBEkQ3VW9
         iiDTOS/gKFTT/Eki2W75l7aG8A20tZDHuRVTshRgCRI4R076u2tDpgmIR4RUKyL8T3fw
         N3I+8foF+EPgx01vlP5CTVkx5zqnmzeXfeza/oaArlhNk8E0SH2s/vq4RLdfVbCHIr9G
         sDPnpnTE0227vomKYvmqKEd4VXfZERox1+oF8q0tZiq7kCuSwxo+CHzfMml5x1YDOmRw
         dTKA1qeemNG3yA2XdntsCH6BcSoH7qKnkMqE4lOZd2gBZIpHJTIkFsDknSC2sJBd83W6
         VcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734128598; x=1734733398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6w76K9YeaXpnU4/sQG9t66TH+CfDvGBOfAKZrQMVHII=;
        b=vriHpGXuss739wqT31gSeMALit7wif9XCJ6EXj2L3ZsWyIodVzb6Mp/kll+6Zezlsl
         obdSrKwy0Gqj1W7WK2nQkw+EwtOGM8Kh5AtIRl39q2YadbxuZXu7CSvyFxIK2uPuVgzg
         7fOirOQNCmVr9NMxeZ4zMUb+3QKOeh7GNDPt1DkrhHSQjuKTIb6Jro1/ARljS3es8mKY
         eOPMDfORyFTscaeG3hVkkwS8jKeI+R+lQiIfsN2+wzOnqIwcKrR8nE+x1q7fLtsXl4qz
         ulJFzwV5WtvsvpwWHdLBs4SajB6gFew4CfH4F3iTqoZXLovCFk2B3tjPSm+AlCcwzf4z
         CA6A==
X-Forwarded-Encrypted: i=1; AJvYcCXtPf9utz9Q3cFnRWfkNjz2UycECAjllKE+xhjwVo+OHOj+byC1UUFiy/g74xNtfPX8b/8ZHWXryVagPtQ9@vger.kernel.org
X-Gm-Message-State: AOJu0YzXyj+KpRkfVMM5+MGB700Rlr9qJ3RqfHilltC5r934n/SkypgO
	Pn8G+LNQeB4RdTgYIdBw9sDAtXZDk0AlktCzJjBkj10ykLLe99se2q2/+A==
X-Gm-Gg: ASbGnctZ62GHIK614NvNWgVb+okypu0OGaxed2wTon377dsl6SNVJVoddO6J8/TXjrC
	lmgCvc0fTB98RhcZDEL4iygu+eVlLpbzN1Z2ppoiKAVRwu1k2oE0H1bD5UnsHGJILJYU009gJaB
	9fuMJR7rTcgx6FrnvRmO0kGJBl3f4opeTcStHO3C8rlzNgpuQqmi1jz8Y3fGbsPaWjJqh7Gvx7Y
	078kAXCCJOlmC39bV+NbtM7pPLermDzucE7ZPseHwQkJgPF4yd2inQBGvFmjmGm3tw6C8dvr/iV
	GGQ2o/pZo/RhRIGf
X-Google-Smtp-Source: AGHT+IHycN0NWUe0CEF1vA+jHP4uR18d01jpRZgsostOHxkZ2nR/gVJuH6TE9h2AiC7/d65+etuH9Q==
X-Received: by 2002:a05:690c:8b1a:b0:6ef:641a:2a76 with SMTP id 00721157ae682-6f279b01889mr28475717b3.15.1734128598391;
        Fri, 13 Dec 2024 14:23:18 -0800 (PST)
Received: from localhost (fwdproxy-nha-116.fbsv.net. [2a03:2880:25ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f288ff26cfsm1234397b3.36.2024.12.13.14.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 14:23:18 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	jefflexu@linux.alibaba.com,
	shakeel.butt@linux.dev,
	jlayton@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v3 09/12] fuse: support large folios for readahead
Date: Fri, 13 Dec 2024 14:18:15 -0800
Message-ID: <20241213221818.322371-10-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241213221818.322371-1-joannelkoong@gmail.com>
References: <20241213221818.322371-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for folios larger than one page size for readahead.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 94e304a63f9d..971624557810 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -885,14 +885,13 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
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
 
@@ -929,6 +928,7 @@ static void fuse_readahead(struct readahead_control *rac)
 	unsigned int max_pages, nr_pages;
 	loff_t first = readahead_pos(rac);
 	loff_t last = first + readahead_length(rac) - 1;
+	struct folio *folio = NULL;
 
 	if (fuse_is_bad(inode))
 		return;
@@ -952,8 +952,8 @@ static void fuse_readahead(struct readahead_control *rac)
 	while (nr_pages) {
 		struct fuse_io_args *ia;
 		struct fuse_args_pages *ap;
-		struct folio *folio;
 		unsigned cur_pages = min(max_pages, nr_pages);
+		unsigned int pages = 0;
 
 		if (fc->num_background >= fc->congestion_threshold &&
 		    rac->ra->async_size >= readahead_count(rac))
@@ -968,14 +968,24 @@ static void fuse_readahead(struct readahead_control *rac)
 			return;
 		ap = &ia->ap;
 
-		while (ap->num_folios < cur_pages) {
-			folio = readahead_folio(rac);
+		while (pages < cur_pages) {
+			unsigned int folio_pages;
+
+			if (!folio)
+				folio = readahead_folio(rac);
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
 		}
-		fuse_send_readpages(ia, rac->file);
-		nr_pages -= cur_pages;
+		fuse_send_readpages(ia, rac->file, pages << PAGE_SHIFT);
+		nr_pages -= pages;
 	}
 }
 
-- 
2.43.5


