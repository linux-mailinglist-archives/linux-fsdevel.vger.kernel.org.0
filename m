Return-Path: <linux-fsdevel+bounces-47425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99488A9D68E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 02:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC4D4C7F71
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 00:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736C71891A8;
	Sat, 26 Apr 2025 00:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkkfbHOj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C481865E5
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Apr 2025 00:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745626210; cv=none; b=iVN8GsimPws/+tummUMgfXTdW0vauKUN9IC1Y/fRAoZ/xGUu7AFGcl+2a+eaEYdOiuwYKskb1QT9WAHxBiRN27ZQq0tCHbJr9af0TUmS3yJCj1Uk1oCx87dgqw807DTnzzkGGQOqUb+iXbUx0g07E5zPVx/Hq7ehGfNH+yRzTHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745626210; c=relaxed/simple;
	bh=PTtbp5yOOr8kKi8Z1EtI8sLun6i+0SGw/IWroOogD6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZbVMfYyxk2BJDQxQKwubmpv8oRpSLIlO1FTgIZL1S37f7XEzh4FwkdCrftnhMBmFfZ8OzymW6+Hqm3DgrRZCFewCObz2y7qwWvzTwqRWxgYdN1Wyu8fpE36uteaopWGpb8NyI4GjaWcI3VS3f8lia54EWVyTXUBsBEwW/03Gruc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkkfbHOj; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-306bf444ba2so2942900a91.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 17:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745626208; x=1746231008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9ehhEUR8qWwJYSEMIEbswL1o/mk6yykVFOlItIAzbo=;
        b=OkkfbHOjcUsbTMZN8GjGhPww22eX8zxEwI47Ak9zHqimFA+1TamP1yaW7Zs/vV0SrE
         /ykaxAoMEmR3crPATKZF+1IpWttINWpGUo3y8OjTo6GtdDIsHclf9hkSt18xX6Ayop27
         5hscVUcMP7HRl1+1CVTS1QEHtfnJi2Al2nCbKCm6tnujRIcT4lwiGMKSgV/zEbxsgLxp
         iPggGKT1vcvbF7Sr1Z9hI1SLpSxkf2AzPvx5hs1SeIea4KOdAmEffYSdfCSvXciSNjKe
         6WZNIMJNzIN6Zf8V6tZQ16zs6NTzGrGZoz+a85KGzamMc1NrYMA/5gaJW4WWA6ZhXbC3
         ZEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745626208; x=1746231008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H9ehhEUR8qWwJYSEMIEbswL1o/mk6yykVFOlItIAzbo=;
        b=rDJLb0x4bbwz/jUquByTROyMqEDGSLI54iXCggdN2mXlrRSwuvjmYjk3e03504JF77
         yIpB2vA9ribgvXGRslI5bamdkT8EbyaSHW4t9aWUddSD3W9UI9/9LYEKIQ8POnKP5oRL
         eAcV+aBMBT2bJEmw+Ost7wE5SUppHCxDX5dgGNkOrfgGQA+o8H8GA+CwUAhpPzrMON5C
         13IkP40Raz9+B6hR+NLNFT6i4vJGQGHHK2kjC8prQKYhE+L8llnNWpzudzhc4o2Qj8LI
         ug4lsyxkW6o15Z4uELvUcuzWQNpTLOay1LI60WKz1dw8EBqq46z1o6niht6ewkkUOZ9g
         u9Pw==
X-Gm-Message-State: AOJu0YwobnKulSjDduF80QkxgLl0fAUvxmX7wE0nNnTQ2dykSUCCplV0
	VXOKz5RA4WFB+nhOHwhNLk5WSVkby84xvERCmFp9ZhvG6IFq7+8fgF9png==
X-Gm-Gg: ASbGncuPEc+bNLWHFZwQz+WLTCNLkTMiw2yWdjP0g5al6JhLS3jX98iQjCSF+8KfweV
	BjjLjdH/y41iOqciXdzdaN5m4UM21NEyscxt8uxIoUivIcold7kQq/yzQA8ceXUEj+Lf5lSL0Hb
	YrA/yjVKtz4ent1w3iH9qtcjZPitjyg5WfWdtosTZswMPCj0O+HlvWI9S/gu2XCuv8mVFEpw5Ym
	JPSAMDRPM7Wz89fQXT/+UxPnSQWO5wrfKh8W5f6vZ118qGqQhGl0fIXhNkxD0Ku+ZTrG8dK9rWJ
	9i4q/Y6tg+McIs1KAR9d4gT49og/dG8daas=
X-Google-Smtp-Source: AGHT+IEzJLarEdxrb6mnyVeLuM6N8CcVkQpMnWWhAe8bHpqmoQvzg9i0TAGX7giYIeqY58/Pnz64cA==
X-Received: by 2002:a17:90b:5111:b0:2ee:741c:e9f4 with SMTP id 98e67ed59e1d1-309f7dd8748mr6229441a91.11.1745626208613;
        Fri, 25 Apr 2025 17:10:08 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:b::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef03bb74sm4123508a91.2.2025.04.25.17.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 17:10:08 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	jlayton@kernel.org,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v5 02/11] fuse: support large folios for retrieves
Date: Fri, 25 Apr 2025 17:08:19 -0700
Message-ID: <20250426000828.3216220-3-joannelkoong@gmail.com>
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

Add support for folios larger than one page size for retrieves.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fuse/dev.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 7b0e3a394480..fb81c0a1c6cd 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1837,7 +1837,7 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 	unsigned int num;
 	unsigned int offset;
 	size_t total_len = 0;
-	unsigned int num_pages, cur_pages = 0;
+	unsigned int num_pages;
 	struct fuse_conn *fc = fm->fc;
 	struct fuse_retrieve_args *ra;
 	size_t args_size = sizeof(*ra);
@@ -1855,6 +1855,7 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 
 	num_pages = (num + offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	num_pages = min(num_pages, fc->max_pages);
+	num = min(num, num_pages << PAGE_SHIFT);
 
 	args_size += num_pages * (sizeof(ap->folios[0]) + sizeof(ap->descs[0]));
 
@@ -1875,25 +1876,29 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 
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
2.47.1


