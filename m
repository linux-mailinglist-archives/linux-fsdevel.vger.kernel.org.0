Return-Path: <linux-fsdevel+bounces-48782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D08AB47C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 01:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED3724A0300
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 22:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CE329A9E7;
	Mon, 12 May 2025 22:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZ2GyJ/U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B9529A324
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 22:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747090779; cv=none; b=AWlPWlz1UeAvoDaPEVy8h5ML60k3CtbZCiKzAvL8JI+mmRpHh7xVTmmPUQ/tCBGPWzoeVXHKwJvWYmnxkbNNT0wUcPQue8bOD78SIKiOYk2wQzjL5cIURshgxAlnoTb7NnjTFru1Hp4P8nMJzAvdh/c1SxRL0MxccKHr2RVsULE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747090779; c=relaxed/simple;
	bh=QeH64RdViViugDAU0Kn+rUhWjTD05LYUWSl906uwQf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJK5dO3D//2ACRA2AoncTdSmHak4ck5WAxhbGyxiyh2qJTqBy7ORI8Cq6J3MUvSCWmxq+r+sxOunlpMwrEiARUDcXMJZwne9gPJWmzpc6vLwCBKY4UvmlLahIO2AJqQErC9AlIr0q8q/ej+LyankD7hLmm4MqM+y16LeCpMSfEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZ2GyJ/U; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-30a8cfa713fso4763125a91.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 15:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747090778; x=1747695578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGzft7eQgDC1xVmXzqLbagCzkSYMK56vovoBoAqfRCQ=;
        b=MZ2GyJ/U1wtAsSHbT6KgGD3mfO77YdqSdCYvJpADNpPxLZM528maLEtyMdH72Kb9Mj
         vfWtCIKsQRgUkbxbPHTDjmb+zR5txeWA+1+kjNVqDMKu+jsIGCS/Xn3I5LM4uCQDV8MJ
         NRcrF6LmWCIpU3Um6mwt1eg1lvh4CXds2c51j3eJe2dUTThT80EHcMwbQGyxN6grfdVN
         BuppwY9C4gl1lm1oDxANShzU2tklj1l6487jHdynRrWZ5dmETVfqMvFuJiBnAv/rML7y
         ChqjYO1gfju5yv7VnSEpngHlG/8Z6U9d81KWfUdIu+rRnBR5kWW8sOVIOAVrY7gu94u7
         3x1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747090778; x=1747695578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGzft7eQgDC1xVmXzqLbagCzkSYMK56vovoBoAqfRCQ=;
        b=N0BxA1rK+HcyMQOngDGu6xoV+BvTU28FJiC0uGXPGYUw0lOgf7tOXWJHdD5gOLj5t0
         LIA5AjuXMWxG0G5gDM5gRbzlifwfYoBNC1dSI1YS81NAwlXXR7SwjedIGU40vqMkP5+h
         7gE+ylX6Q2xZErz1w33iAcsPjP8AVUXcAN4KC0fqzooIIsjAaodqAR9aLR7fmSu1Cvgr
         xKlGx8VrU1coxhezLRiTOVDWtpPVqakTgYKPxNFZAFFfieifi54BycnxJNDRf6xLwxI2
         rHhRleL91SLhHAy0R6ub6MIK26UIPC9io+iuJzG4oEVwdNfQV/REAb5AbvlnJQCklefP
         frsQ==
X-Gm-Message-State: AOJu0Yx4zMQMATFdoBhtVvRkMyZSdtCB75jkayidf4BlK6dIwUxOKWrg
	V9uLiTgBVZEJ6td/JdWmYe0368LMIsBJarT2xisdofu6ha7vEvSM
X-Gm-Gg: ASbGnctWCQyA44MBknzUiqg2GqXIEhDiUc7kECfR37YDkiYihEn6TSez1z4NMx2+QKf
	Uvvmcl8ilDcoR15yDUcu2bN/AqhFVrL491SPKpkbfmiKBithQMp3TTmVqk9yGp5VbRq7WWTCW0X
	JSXktDsBFDVP4v3YdEAA5qgoM6hk4tLN7+0D9QP4N6TyLZ3JSeKDHlWCalgXfSUuD1XsDTvs5Au
	aGkqETBuQiDWm01griNui8YIwbgxe0l7Tam7X4VTe3yVHeRqgTXJtTUwnNZYGgrHjD3mIHkctJe
	0PjBXd+qSXXc7yBwo1X5GVXFQnyMdOc8tfilwxd79znPYw==
X-Google-Smtp-Source: AGHT+IGpPrqHDsW1x2KcOMz+3YPHOLFWegMLvuaY5IviKDmEaZr0SPwQWc/hoYFdbyA7ByxN/WLe+g==
X-Received: by 2002:a17:90b:54cf:b0:2f4:49d8:e6f6 with SMTP id 98e67ed59e1d1-30c3cafdb55mr22593430a91.3.1747090777572;
        Mon, 12 May 2025 15:59:37 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30ad4fe229dsm10318828a91.33.2025.05.12.15.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 15:59:37 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	bernd.schubert@fastmail.fm,
	jlayton@kernel.org,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v6 07/11] fuse: support large folios for stores
Date: Mon, 12 May 2025 15:58:36 -0700
Message-ID: <20250512225840.826249-8-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512225840.826249-1-joannelkoong@gmail.com>
References: <20250512225840.826249-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for folios larger than one page size for stores.
Also change variable naming from "this_num" to "nr_bytes".

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fuse/dev.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index fb81c0a1c6cd..a6ee8cd0f5cb 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1776,18 +1776,23 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 	num = outarg.size;
 	while (num) {
 		struct folio *folio;
-		unsigned int this_num;
+		unsigned int folio_offset;
+		unsigned int nr_bytes;
+		unsigned int nr_pages;
 
 		folio = filemap_grab_folio(mapping, index);
 		err = PTR_ERR(folio);
 		if (IS_ERR(folio))
 			goto out_iput;
 
-		this_num = min_t(unsigned, num, folio_size(folio) - offset);
-		err = fuse_copy_folio(cs, &folio, offset, this_num, 0);
+		folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
+		nr_bytes = min_t(unsigned, num, folio_size(folio) - folio_offset);
+		nr_pages = (offset + nr_bytes + PAGE_SIZE - 1) >> PAGE_SHIFT;
+
+		err = fuse_copy_folio(cs, &folio, folio_offset, nr_bytes, 0);
 		if (!folio_test_uptodate(folio) && !err && offset == 0 &&
-		    (this_num == folio_size(folio) || file_size == end)) {
-			folio_zero_segment(folio, this_num, folio_size(folio));
+		    (nr_bytes == folio_size(folio) || file_size == end)) {
+			folio_zero_segment(folio, nr_bytes, folio_size(folio));
 			folio_mark_uptodate(folio);
 		}
 		folio_unlock(folio);
@@ -1796,9 +1801,9 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 		if (err)
 			goto out_iput;
 
-		num -= this_num;
+		num -= nr_bytes;
 		offset = 0;
-		index++;
+		index += nr_pages;
 	}
 
 	err = 0;
-- 
2.47.1


