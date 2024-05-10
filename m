Return-Path: <linux-fsdevel+bounces-19273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1B98C23E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 13:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64262283FD6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 11:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4802617082E;
	Fri, 10 May 2024 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdHmK+eE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE0C16F911;
	Fri, 10 May 2024 11:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715341800; cv=none; b=M/odq1Jyn78iUcRodU/Bd9eTAJslMcOFMEey9ihmhcQXTWJmd7vcRWBM6yaAKdmw3IZABi75Xnd9Nuur75sxH7cx21G3b/ayiJi8ygCQk9IRY03NRN25Nh4KaGV0F/HGALrbo0cD7svuIB14ATiijxaO0dZZ9wfmWS92FzTHsmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715341800; c=relaxed/simple;
	bh=J7ZhPE4n1TNebqti4ceg9RBUgnFcG5UzDJV9uxEpxbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pd3fYv2MjIKB/OHQflgFo2enKyQBW66a1OyZxvwXVl+H0P84bXXBuuOlfJLmTLoJ04m6v2hpH/WxvLggIt3uUlNmAgw9qhN5/a8qpKNBoDDaqHeQENBkRlzT/rkfcXBXA4YUxzfdb+2x3ttRRXLGGajUaHIGH7429dJLSWONFNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdHmK+eE; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e651a9f3ffso12281415ad.1;
        Fri, 10 May 2024 04:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715341798; x=1715946598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AlJsO7PWN4Jf79ghcMCVByM1+QjN19p/5hJE9J581cg=;
        b=RdHmK+eE22GvcFOO0YWliqxAvHM43g5E6LQC6iQlCPMGtXUQ137SyuLxaV03W0oc/n
         BXt9GUZUYciREyd2xPDPQ/dCSbYsODtFnqtnO9s0Ie5uILn1vbq9CgqNJkm7PNib84L4
         COwR3CAwt8XtbKFJdrUwwIHoSAf1SibeIVG0uXW1vS6NvWozE6KehvzREf+ArvjJMt4g
         hZUIfPHZkZpqmbUMVB7s8R1xpJrciJQr01HL9aSHkhaW4aZkqECo1axgoBZMCMbmEtvC
         W0aUyfSKqLf2W/xQlkcTWvD5wExDnj3vlUrAQaDWqrbXqPT7w4wYX8Mdn5NHOvRSIUXc
         ctmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715341798; x=1715946598;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AlJsO7PWN4Jf79ghcMCVByM1+QjN19p/5hJE9J581cg=;
        b=igzcJ/UOQvP9z3vz/So8P+YINBmPu8JOYccP/eOG/Gmitoasz/xSL28pY9J2qDlaNg
         2MowrSX+13f3A7vM29nlbRSHQP4+7SdNusVGvA0SQ7SHG5omq+oEwLp7I5gLsW3lwnOv
         NqSDUvw9x/Y/qnoduAAioWXk9lW1Ao1C5Pa+ot2DbYNpduPHhwYBu74sKYz6K1Xdtqh9
         JtaOeH/kxo9Qw0MKiSfUfnhC2Yh17mqVKyuFHTm2f9meOuc04BSD8k/gf+OUA6jotxGc
         1/dC56C/JIYKooMMX3usRR/vWNPUBAKXaTub2tVxZqag/2y3tmuN3l7Q2KTPzPmsUkHF
         d42w==
X-Forwarded-Encrypted: i=1; AJvYcCUqAGISDLzKpWMZY/Fg43sWUSRaQ5PjNokVBe+6Y0JJFEjh5owouDpyhwy5ETM6ZTd2QgpMAbdiznnrcA4weBrIdkoAAkn2uxGyH8rTZiivBGxDbMzk/oBx5p534zllv2WeCVeWd1tw0ErgX99PEdqubqh5GpCcgcE6YCI3dCxoc9mJbTqFlcnB
X-Gm-Message-State: AOJu0YzfwAtHPUOSA8EbjipTLLc+7fb7/MYFKVgZADFaan7Rq3Fu/TFE
	5vhH8qOirp5QQquvajTxdrjbeNQvHnnn3zp58icFaLYne8GpCbsf
X-Google-Smtp-Source: AGHT+IEgC/5PItwGLdBO3mEfXM0RAVpswT1aq1A3QBfgABXJzBC0a91j/oU3l3ssnynmf+QFhY0xNQ==
X-Received: by 2002:a17:902:c145:b0:1ec:659c:95fb with SMTP id d9443c01a7336-1ef43e25e5cmr22881935ad.32.1715341798221;
        Fri, 10 May 2024 04:49:58 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c134155sm30183825ad.231.2024.05.10.04.49.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 May 2024 04:49:57 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Huang, Ying" <ying.huang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Neil Brown <neilb@suse.de>,
	Minchan Kim <minchan@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	linux-nilfs@vger.kernel.org
Subject: [PATCH v5 02/12] nilfs2: drop usage of page_index
Date: Fri, 10 May 2024 19:47:37 +0800
Message-ID: <20240510114747.21548-3-ryncsn@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240510114747.21548-1-ryncsn@gmail.com>
References: <20240510114747.21548-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

page_index is only for mixed usage of page cache and swap cache, for
pure page cache usage, the caller can just use page->index instead.

It can't be a swap cache page here (being part of buffer head),
so just drop it. And while we are at it, optimize the code by retrieving
the offset of the buffer head within the folio directly using bh_offset,
and get rid of the loop and usage of page helpers.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Kairui Song <kasong@tencent.com>
Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: linux-nilfs@vger.kernel.org
Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/bmap.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/nilfs2/bmap.c b/fs/nilfs2/bmap.c
index 383f0afa2cea..cd14ea25968c 100644
--- a/fs/nilfs2/bmap.c
+++ b/fs/nilfs2/bmap.c
@@ -450,15 +450,9 @@ int nilfs_bmap_test_and_clear_dirty(struct nilfs_bmap *bmap)
 __u64 nilfs_bmap_data_get_key(const struct nilfs_bmap *bmap,
 			      const struct buffer_head *bh)
 {
-	struct buffer_head *pbh;
-	__u64 key;
+	loff_t pos = folio_pos(bh->b_folio) + bh_offset(bh);
 
-	key = page_index(bh->b_page) << (PAGE_SHIFT -
-					 bmap->b_inode->i_blkbits);
-	for (pbh = page_buffers(bh->b_page); pbh != bh; pbh = pbh->b_this_page)
-		key++;
-
-	return key;
+	return pos >> bmap->b_inode->i_blkbits;
 }
 
 __u64 nilfs_bmap_find_target_seq(const struct nilfs_bmap *bmap, __u64 key)
-- 
2.45.0


