Return-Path: <linux-fsdevel+bounces-10786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A750A84E654
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 18:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01CF7B22DB9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 17:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5E686AE6;
	Thu,  8 Feb 2024 17:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/adUZJm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9D21272A2
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 17:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707412099; cv=none; b=XTZsm6xtr+Od61HSTdzzJHucf9aO7IamuXmnrcDSBe918nmLwA1vttLHt4fLgAOlPNcpEoygS7Lvdi6AkK8fx/tBL8QMQdOE8JkzmzR7E2K9xtLg8e0OOobh+L6NUjhrLX5Sss9ElVr07GQV1g11tsbIYSuOYonGDk6tgazeaOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707412099; c=relaxed/simple;
	bh=QCRkwQGjB4zMW8Mffx8RJAWlzpaJ4gee4GkAeLkE+kg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h93igrbBryr1HgPoKB6m4YjpJ0YJEkGbJwuIW+IzqGNU6uUNb/eZwwSBSDZZ5yevieO+TJ0A1oKfnIKtWB85/uwtm+afWbplc5iEuR4t+7T72/yZyuV3zcngX6dYMBChJzRTyqU76reLSHG/TybFqU3rCxaiQFx9UlcQbpZc7jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/adUZJm; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33b401fd72bso1580871f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Feb 2024 09:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707412096; x=1708016896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lvBTY0xJxU0TufxiMe2c3SJ+LGF1Xv3wU4eWZwinjg=;
        b=F/adUZJmiS+WYyElxDugc5oLranlRiVM/C8YnnXvgtRf+lRfl64DP8c8JnuboCgYM3
         wxZy7CTTkiISQe7CzKeVQ7D7dkStXHAotMs23qFTZ2e0n/b4tVJ0G/t0SxuvVxU1gZPE
         GxEIjrtQcRwVD5NJy6FV/nZo7h2hgox/EshNyfTguu9JC0f6q0LVF65X/8puIUGyp+RG
         7jMyh5DMGNfTBhn9rjoCtjbbOr9LW2fRKF6fF3UWAMvfrXgvCFUXIqdBvZjelNNiineg
         o3b/+7dhVSbPg4Bk5gm7j7TvrhZ7JnJOOvCeN0Ex04MpoQeu5DnppBuo9o71um7BrkrI
         k+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707412096; x=1708016896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lvBTY0xJxU0TufxiMe2c3SJ+LGF1Xv3wU4eWZwinjg=;
        b=f4xiy7ekOzy5d4sDqQDTk/83GSsAY8WQof/X+3LmpVtPMsTNz03IJRedpwokvOX1ID
         7VEIJdNyipL9lW3rzpk32qCBN13/0na6piCqwI8fHFcNPnAHWXeCgyO583PTmwl8hdYr
         XScp8JQD+qga13bDS0WnhDBkqW1eyA5inepnk7bZwZqV61iMX5/zXqMOkm4f7FOYl7II
         u6d/dZ01yaNN5gnsdX1+YomnlJcNZuH9lN0wBgmVK557cDP1KF9v9J8IJBLdK+nihIDP
         /gKda+B/Jbmekwi0nj3SkJM7Al3Cg5nAFwvF+mqgf2Bz+oa4t9trsU47dBEh0BEdPs2r
         rTLA==
X-Forwarded-Encrypted: i=1; AJvYcCWUBkGqCdJa85hFYnSRJU0zuqMmLO+5kkvSeCclBhpLwvvABrGk+GnfbaMJCvhID683X36s6I/TZhy0+ymam7vNtU1Ukq4Gk43fhh2c8g==
X-Gm-Message-State: AOJu0YxbDf2gFvDtNcYqau5JfEa9dslkKUlSerxdI2fqALqkuz4ftjXv
	/lNhTxN+BlkaxXiWZFhpIKL4MR0H/XPqwsfzQRumQ6BrnHEVr6jsVicHP4nB
X-Google-Smtp-Source: AGHT+IFdVBV4nVC4aaqaaTVmXaKJnGHPqrs20Yi/6acvuONoJdCFiA9QIHMl3+EBCCYZIZKuMSLSaA==
X-Received: by 2002:a5d:6307:0:b0:33a:ee4d:98c8 with SMTP id i7-20020a5d6307000000b0033aee4d98c8mr47793wru.61.1707412095900;
        Thu, 08 Feb 2024 09:08:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWU1w4Sm77qKxVpDqS79xVQ8T6HQCgC8ps9DOz6J7fzBqHSHq5O4/LmT8ba38nberjrrwwDsAEHaQsWodTxm1Pp8gnji7g7YCysfg0WPo7SC8Gd0wb74PsjHs8a994cArA=
Received: from amir-ThinkPad-T480.lan (85-250-217-151.bb.netvision.net.il. [85.250.217.151])
        by smtp.gmail.com with ESMTPSA id f5-20020adfe905000000b0033b4a77b2c7sm4005682wrm.82.2024.02.08.09.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 09:07:31 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	linux-fsdevel@vger.kernel.org,
	Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH v3 1/9] fuse: Fix VM_MAYSHARE and direct_io_allow_mmap
Date: Thu,  8 Feb 2024 19:05:55 +0200
Message-Id: <20240208170603.2078871-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208170603.2078871-1-amir73il@gmail.com>
References: <20240208170603.2078871-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bernd Schubert <bschubert@ddn.com>

There were multiple issues with direct_io_allow_mmap:
- fuse_link_write_file() was missing, resulting in warnings in
  fuse_write_file_get() and EIO from msync()
- "vma->vm_ops = &fuse_file_vm_ops" was not set, but especially
  fuse_page_mkwrite is needed.

The semantics of invalidate_inode_pages2() is so far not clearly defined
in fuse_file_mmap. It dates back to
commit 3121bfe76311 ("fuse: fix "direct_io" private mmap")
Though, as direct_io_allow_mmap is a new feature, that was for MAP_PRIVATE
only. As invalidate_inode_pages2() is calling into fuse_launder_folio()
and writes out dirty pages, it should be safe to call
invalidate_inode_pages2 for MAP_PRIVATE and MAP_SHARED as well.

Cc: Hao Xu <howeyxu@tencent.com>
Cc: stable@vger.kernel.org
Fixes: e78662e818f9 ("fuse: add a new fuse init flag to relax restrictions in no cache mode")
Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 148a71b8b4d0..243f469cac07 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2476,7 +2476,10 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 
 		invalidate_inode_pages2(file->f_mapping);
 
-		return generic_file_mmap(file, vma);
+		if (!(vma->vm_flags & VM_MAYSHARE)) {
+			/* MAP_PRIVATE */
+			return generic_file_mmap(file, vma);
+		}
 	}
 
 	if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))
-- 
2.34.1


