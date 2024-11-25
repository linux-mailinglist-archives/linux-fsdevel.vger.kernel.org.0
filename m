Return-Path: <linux-fsdevel+bounces-35857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CD99D8E4A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 23:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88477288D0E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 22:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3CB1CDFBE;
	Mon, 25 Nov 2024 22:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9vzX3mC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38BA1CDA3F
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 22:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732572370; cv=none; b=JlkUIDiP3Ss2lvGAxT0q9e+lIL4bJTsA2S8EP7+V94FxA+oWY1+fDQISX7VJHGGEuU9+/j31Xyh5jc4eOcAEOLLo8KmIxqQ9J94oClaWzRGNdNr4+WAWlPXZEzzwOflsCH21EBbL4w8eQK5n2XkVa9WZHPCKuw/Mb+FcgqrGSpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732572370; c=relaxed/simple;
	bh=pRMK5jPBmYa5dAxCjuvMrBsm6qEiOBch9n/UO+swXGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HjAPPiDJrjqpw1XlDyTa56vLl9AX6uZAo29Bhp2rne9sljm5iN/jQG8yeTllfzVkEs7BDVeL7n5wAw5NixFZJt1qkwuoeBsy/9oqo9UdLoTL1eNqKNK/9+u4xwbf5zS/2mDB2/kZm29Bmsvanpef7s0g0G/Dx+UlLdnDUPEO48U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9vzX3mC; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6ef15421050so14131077b3.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 14:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732572368; x=1733177168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BR4fVVGwclW4cNNwREOlT33PH/34vfDJNkSzGDsQ5QM=;
        b=f9vzX3mCnGRbnvz9AmI0lshENX3AWQfNkDBA628UaSQ+WgaejZTVGqySC7e/YeE2tR
         vQ6fgh/MOLzPGUVLYg8TsWgBMjfX6ZA41aFkYsM6YD6pnnvwcHo6ENkVyEc3yCjpdaoh
         66kcs93ZhEDKSxktDsmeIoNap0yY4hGAP5ZT61uL8B74wei6Js5mLJ6wmPbVvbxzY7/U
         k6SimjfoFCMuJyd1Fp8ashLnQXmN1dQTGEdI1T/dnRtEu9qc/RgXyIaVX/kSNkXc9DF7
         0AhLmyB4EBQ4sBabtaEpiLe1HVixOAc6yOdY9m7FnIa0Hvziyoh0e2ViZvxnwhkifLia
         aRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732572368; x=1733177168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BR4fVVGwclW4cNNwREOlT33PH/34vfDJNkSzGDsQ5QM=;
        b=G3EvzjXgB1KGxve+1e5cALShZpuBDjRi2vlH272CIzWViToIRiE/gA50BOYsSZxGoX
         sDKn83hVjD0Q8unIhgFVVTuBdTLLSD60jLzMZ5PX92c+m7tEThxES7P+kwhR/23zFphN
         8DJ5tV4O1lQ+/2cCaJNLEOkVdKVXREb6gT1pOdHsJjXGJpI2b0eBoLJYf7YDMwDrqbz/
         22v91JkqG/J7/X76woptEOXqC6oZIQvOgioR6x4lQvLjkXoViqsMD13/6kpUxuB5DJSm
         f12anhCBTbg2DyqGns+tbmqAWddZn6kyAybaMkg+WeXP5wpNnuO2q6/ik4AsQCUbmtFv
         tVHg==
X-Forwarded-Encrypted: i=1; AJvYcCXvRMMobvRrz6ZK+OxVsmzbqA+adPCuvXKZm/t+DB0z6l9L0jwdNekwzPz0I+Z56mgXupNW1o6ZML4JeCWy@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5xqGAYTukQRhcyT7c3aQsYu0coUzf7DxZP01BfLYD9yMZdDmM
	OgVYBoxP5M0o2Y4j7DcLa9Cx+M6/RfAgozacXhho75NvhWjkUAppc3nmyw==
X-Gm-Gg: ASbGnctzdrbOsz1cWkfGcVD2g/uPt9FiGiLhwMjinqtmXU8LVbraBWdS3LeqT8xOTTF
	5HAv4faaHJEBLCJoPLEP7LwwXqj3IvvgCWw7Rf6jOGwshRHqWGwORgujsyzYpmG/TZ5tdQiD5IV
	UPsm9gAMY+lGH9ckJKzX9BKD9Gt5TXAOx+OZTzIEQuN0dp4aJRKYa9/gXy7VELaIQP4+T5KKLzb
	NCc0oKWdNgFau63S6z3dSUsdviV4iBLWJyAQeYGgusdS1+nnxxBe5h/utchCJ6wGuTOwKjQ/197
	3Gz9gluNbg==
X-Google-Smtp-Source: AGHT+IGl7Ps0PAWQSveraSUUcTdip6uhB7v6JqVrbdeML/8QsSCUxYUCWFaFmi4BHLTKL9hIZlZ8aA==
X-Received: by 2002:a05:690c:2506:b0:6be:523:af4d with SMTP id 00721157ae682-6eee08c2b80mr137071507b3.11.1732572367983;
        Mon, 25 Nov 2024 14:06:07 -0800 (PST)
Received: from localhost (fwdproxy-nha-116.fbsv.net. [2a03:2880:25ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eedfe480dcsm19912457b3.60.2024.11.25.14.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 14:06:07 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	willy@infradead.org,
	shakeel.butt@linux.dev,
	kernel-team@meta.com
Subject: [PATCH v2 09/12] fuse: support large folios for readahead
Date: Mon, 25 Nov 2024 14:05:34 -0800
Message-ID: <20241125220537.3663725-10-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241125220537.3663725-1-joannelkoong@gmail.com>
References: <20241125220537.3663725-1-joannelkoong@gmail.com>
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
index 1cf11ba556f9..590a3f2fa310 100644
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


