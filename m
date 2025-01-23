Return-Path: <linux-fsdevel+bounces-39891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 695BAA19C33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 02:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D2687A528C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 01:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84AA1EB2E;
	Thu, 23 Jan 2025 01:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KD8BJzkC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBB44A1D
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 01:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737595690; cv=none; b=eiaMhBHYUjuAlNLV5D06VSodXWS0gNAQKp2eMoGQOFgwtdZlTLmZGRbO/tuGcqcX4tcFOcucMoM78jZUuYnMVv3aH7I3ux6hqrHszdxbc1vhfKQTg2y/7O9Hbx64W4izQ1eGPd1IeJ+C2oy1WzJGUPI9kU/wN+ZgT5pDD9GJI3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737595690; c=relaxed/simple;
	bh=e6yijLXE38lcSqb8uBG2fjzWvxY+xlEUMdOAO8xoZQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cn33ZsvnFSRC/KQZY0HyIE7mrPBGfiOPbu7Gs9XEMeW4aO4XHVfcjqOmBpQaYrEIN5XAnpd9uPlYMtRfW366fWgqjgwY0OzEvHQSEYBBvNxFT3BgjSAndIsnV7kqFerTZKtfSQk+7bg8O0wsmagGqctCxBH4U4L2+aDPH4ZZqgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KD8BJzkC; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e4a6b978283so2632208276.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 17:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737595687; x=1738200487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gwK3tDYTKkO1U1L0NwwfEQJqWq5lqpjU84GTsIZI7o=;
        b=KD8BJzkC2DR6tYb5YLNVhCurvWyps6+K0X3GDdCGC0ws2X4EcAOjUpMw5cNBuqRblq
         dWg9tkq9+H4f7w+0JVpCH6mF6qUNjjfdBPUJ5wHBHqTYzeqDsLpPG0o5TF5IBFQmJL7X
         zbxSAfHVshna+ZdHfjUaKgzlO5afjEAtsk0tYPLXUfJ9sEI2w9EBhCNs3JxoT+5/TZOz
         zkqgaPn5X1Md1rJlVpPOAsVifUNeePyk0tY8y6wNhW/gWpKwkWbQGmNvuaD5BN3JNYj+
         F6DOSUYMlUMC2eOa37b0R850JHRF42LCne54wa5XAmaZYI9LYWoC53eA/IMKvLpNVn9J
         KOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737595687; x=1738200487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gwK3tDYTKkO1U1L0NwwfEQJqWq5lqpjU84GTsIZI7o=;
        b=vZMriz6NBeqsqDwmUxvsX+oh09jjeSm5ES/O9tJtuGSnFv5J3BLyCLR1F57XACmEr9
         QTKW77lNVhUkYGz6E3vj9/tRRCGhsHh3/+UWuZGMrbaC00TGFd53svgMb4lr2JMP0Ect
         3W5QvJ6yn2YGiUsqaR3qNYulsXzzIdN5XdgB2sxmW900pSy66T9YurTCuZnlxqtjHfi1
         vP7nTJoKi48Oq0vjeVGB0ECQPSkHVyABxBZovMex9ijtJ2hM8JACn8CQIgZfxIdQKvUQ
         8kqAgmaHIPkbB9wTTYP4cjknpzpnx2vXpNGKeeS80y2UPA9eI3NRxolhop2b/ojQ7/LA
         CeEg==
X-Forwarded-Encrypted: i=1; AJvYcCXlGmhV3D+eLOG+rgiG8i5YXPGveh8yi6XlfAYo+eEkqCVgwqJRdq+UTaxV7fs1Ot41jwg80iE7Y0KTSUAu@vger.kernel.org
X-Gm-Message-State: AOJu0YxOle07P+0V8Dxt4AwHc6JdcTsJoTsqCq+k4pCgYS6ACM0rQtyQ
	xRhWileGH/Z4XmuoyZQppYpahtzx3V8vD7hk7eCqWNs8VfC4B4pz51zkjA==
X-Gm-Gg: ASbGncsjm1gFmh4xYG89YRjGb/ZXruoUsx7aodECT9lKmMUN0BDeowEWVay9X+pth1u
	jJQUQvLI7lEPOlCs83f/uU8rzqYPvZAtbrpUU57SWKmTFe83zopt/XSxidE63nCgRl1tPsxt+x7
	kv4QEJWljhlzTGgcceD+6/zJgNWgCTbNDr9AsXR1+vALoztnsa8StuoDTSWQyEr8/xSXC5HglE0
	3B327BspwWP6VgtOs9AktGg+8XeNNOte1NKLDnZGarxEaRQGDXr/4zVU1nBTGvaDecZH1/WSJpD
	/Q==
X-Google-Smtp-Source: AGHT+IHPowTR4vEUpj9pLTQ1X07iwwTNy/u+9BTqXkmhIemhCrsUjDO+c03Yl15xiG3FqzGUo2r9Kg==
X-Received: by 2002:a05:690c:6f83:b0:6f0:697:da5f with SMTP id 00721157ae682-6f748e290famr13459607b3.14.1737595687565;
        Wed, 22 Jan 2025 17:28:07 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:3::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f6e66d10f3sm22116067b3.69.2025.01.22.17.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 17:28:07 -0800 (PST)
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
Subject: [PATCH v4 02/10] fuse: support large folios for retrieves
Date: Wed, 22 Jan 2025 17:24:40 -0800
Message-ID: <20250123012448.2479372-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250123012448.2479372-1-joannelkoong@gmail.com>
References: <20250123012448.2479372-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for folios larger than one page size for retrieves.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fuse/dev.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 61f8e7d0b8b1..ded2caa4078d 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1718,7 +1718,7 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 	unsigned int num;
 	unsigned int offset;
 	size_t total_len = 0;
-	unsigned int num_pages, cur_pages = 0;
+	unsigned int num_pages;
 	struct fuse_conn *fc = fm->fc;
 	struct fuse_retrieve_args *ra;
 	size_t args_size = sizeof(*ra);
@@ -1736,6 +1736,7 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 
 	num_pages = (num + offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	num_pages = min(num_pages, fc->max_pages);
+	num = min(num, num_pages << PAGE_SHIFT);
 
 	args_size += num_pages * (sizeof(ap->folios[0]) + sizeof(ap->descs[0]));
 
@@ -1756,25 +1757,29 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 
 	index = outarg->offset >> PAGE_SHIFT;
 
-	while (num && cur_pages < num_pages) {
+	while (num) {
 		struct folio *folio;
-		unsigned int this_num;
+		unsigned int folio_offset;
+		unsigned int nr_bytes;
+		unsigned int nr_pages;
 
 		folio = filemap_get_folio(mapping, index);
 		if (IS_ERR(folio))
 			break;
 
-		this_num = min_t(unsigned, num, PAGE_SIZE - offset);
+		folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
+		nr_bytes = min(folio_size(folio) - folio_offset, num);
+		nr_pages = (offset + nr_bytes + PAGE_SIZE - 1) >> PAGE_SHIFT;
+
 		ap->folios[ap->num_folios] = folio;
-		ap->descs[ap->num_folios].offset = offset;
-		ap->descs[ap->num_folios].length = this_num;
+		ap->descs[ap->num_folios].offset = folio_offset;
+		ap->descs[ap->num_folios].length = nr_bytes;
 		ap->num_folios++;
-		cur_pages++;
 
 		offset = 0;
-		num -= this_num;
-		total_len += this_num;
-		index++;
+		num -= nr_bytes;
+		total_len += nr_bytes;
+		index += nr_pages;
 	}
 	ra->inarg.offset = outarg->offset;
 	ra->inarg.size = total_len;
-- 
2.43.5


