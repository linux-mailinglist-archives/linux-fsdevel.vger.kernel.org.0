Return-Path: <linux-fsdevel+bounces-16876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 702EF8A3FC7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Apr 2024 02:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15E391F215D2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Apr 2024 00:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B992F4E2;
	Sun, 14 Apr 2024 00:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=orbstack.dev header.i=@orbstack.dev header.b="T3CaZWKs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3F5C142
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Apr 2024 00:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713054882; cv=none; b=CRyCAW1i0LZ4Rdx6VgRc7FvpHFMumqmvJKpJzcyHejnMKQj0CVSkmanaj4/f2gpkU6x4ER8dWo1iS3VaNfs5FM4hFyx1gius/UuDebl5gu/CPPLGjN2v8vtYBKglekPvOlTZVOM6sBh+IgFsI6x1jirB3s39zJdB/C6u8gqCCpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713054882; c=relaxed/simple;
	bh=L+hcPMDz664CiSzjx5vCeaIpcd0SuW4AkOW1T87ubao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ddrNZF0RvlWsoD6r8u8Rf8b7M4uWNBzh8R8GQTO+Mjnr+ROZUqQZsgD5ugwNX+qd9BVyU/TwEuMjY0NkVztZTyHlFVIUU4+bvmyZElO/oY2gvr+4nBLEL7/YFNePG48CHFAvLBLp51rjLaT5CMOnv1Nj52k/ovJPBckrQKHdohA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=orbstack.dev; spf=pass smtp.mailfrom=orbstack.dev; dkim=pass (2048-bit key) header.d=orbstack.dev header.i=@orbstack.dev header.b=T3CaZWKs; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=orbstack.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orbstack.dev
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5d862e8b163so357435a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Apr 2024 17:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=orbstack.dev; s=google; t=1713054881; x=1713659681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sPkffr7oJwwppX/b4yHu5vHFxXVuD8HMrnwiaJycajs=;
        b=T3CaZWKs9FZtNf1QuBReuhNmCdB2z6KwCLivsVd8+Tj+JNeBLndh8WoFUHGdSUEfe9
         eUT11iYt1fyYF0ZVZCLJUbv8geY5QA20HiNDmDvHOLXvdi45M/MZvQw4tO1bKwRE2cuC
         3yS50l1RJJtPvLg3xRVDFjwfkYpcfAds/iZEU/hGwFOIHkGnJmyDXM72fAsb8zeGOIMg
         P4jCM+xdCKC2lucEWueigZF9Hr52sn2Fqymm6Pg+h6vyqKhPh9F2GKfMn63Gs59YEYNc
         QWZhKIswb4doWlCuUU0nPtY3dPPxR3N6Y0zt29CJaYN6lMo7JmCnqrY4tDudas3wo3pW
         cVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713054881; x=1713659681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sPkffr7oJwwppX/b4yHu5vHFxXVuD8HMrnwiaJycajs=;
        b=ZNWc/o2fNBttdZZXMoGQiKc1TC3kDEvisXruT8JTH7lLfUfq0Y3e6IcI5jdwD48ldM
         7hyHS4+JcHcSouhJJyGtJ4GOJyx5tOWuh1naVfT8kjOVTI7iHfSDRM/tuyFpntwHZa/E
         hdQdmC8TME7z56mbEH+CTgeL94LlkKcFsuW1PuLaVLgCGm/J25Zv6iWFid6t+2jkS+Ai
         49PB4FU+Ol+QnMsoQbaYwgH9rqR5jpKqK1YIflFRDnpHwW1uPTs2t041/wHxxXUcJDvq
         yVFj6/dV/naH+g7PrjzUmUd+rLe4EBM6KlLJnY7fsp137O6A6/qJAzvg7674yTksqLbN
         IxfA==
X-Forwarded-Encrypted: i=1; AJvYcCUbWC20a0HoF2AECft2BngBELhuM+1DxQ+pqXoB5SkCsiWRpq1mKXitBbIRu8CVzfka84BL4U1fHlR96XsNfhJx9U1lSRUTn2oQ9NshuQ==
X-Gm-Message-State: AOJu0YwYjR3UvXF51n5HNrj4Tw0L9QiaKpOzLQopFisHJsVa8PbQRd6i
	sUiTjFQjKtLnfXGmAiSqH4KbQTnNIlx6/mMxkn/wEvI7/4DW3LM6wpWOtjZwRG/JKXnpFVvWcEm
	b
X-Google-Smtp-Source: AGHT+IGZ6S8G0CCgNd4/Hh9ER28bC30ZT6Nn8CO+e7t8gmRLHN84YqdmTld2xWVSDkY17bs6yi8PWg==
X-Received: by 2002:a17:902:f682:b0:1dd:e128:16b1 with SMTP id l2-20020a170902f68200b001dde12816b1mr7760259plg.6.1713054880697;
        Sat, 13 Apr 2024 17:34:40 -0700 (PDT)
Received: from arch.. ([68.65.175.34])
        by smtp.gmail.com with ESMTPSA id n16-20020a17090aab9000b002a46c730a5csm4646143pjq.39.2024.04.13.17.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 17:34:40 -0700 (PDT)
From: Danny Lin <danny@orbstack.dev>
To: danny@orbstack.dev
Cc: stable@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fuse: fix leaked ENOSYS error on first statx call
Date: Sat, 13 Apr 2024 17:34:31 -0700
Message-ID: <20240414003434.2659-1-danny@orbstack.dev>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FUSE attempts to detect server support for statx by trying it once and
setting no_statx=1 if it fails with ENOSYS, but consider the following
scenario:

- Userspace (e.g. sh) calls stat() on a file
  * succeeds
- Userspace (e.g. lsd) calls statx(BTIME) on the same file
  - request_mask = STATX_BASIC_STATS | STATX_BTIME
  - first pass: sync=true due to differing cache_mask
  - statx fails and returns ENOSYS
  - set no_statx and retry
  - retry sets mask = STATX_BASIC_STATS
  - now mask == cache_mask; sync=false (time_before: still valid)
  - so we take the "else if (stat)" path
  - "err" is still ENOSYS from the failed statx call

Fix this by zeroing "err" before retrying the failed call.

Fixes: d3045530bdd2 ("fuse: implement statx")
Cc: stable@vger.kernel.org # v6.6
Signed-off-by: Danny Lin <danny@orbstack.dev>
---
 fs/fuse/dir.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index de452cdbf3cf..a63125ce70a4 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1362,6 +1362,7 @@ static int fuse_update_get_attr(struct inode *inode, struct file *file,
 			err = fuse_do_statx(inode, file, stat);
 			if (err == -ENOSYS) {
 				fc->no_statx = 1;
+				err = 0;
 				goto retry;
 			}
 		} else {
-- 
2.44.0


