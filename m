Return-Path: <linux-fsdevel+bounces-19922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4628CB32A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 19:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53E0A1C2183A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 17:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCC314901C;
	Tue, 21 May 2024 17:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXdbpYbE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F50149015;
	Tue, 21 May 2024 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716314352; cv=none; b=W6XwCj/RD0S2eFJlWlXijNQPjs59HqLDxCtUXtHojYPBb6j51l+KF3g3y2MwDC0LlCElXDma/Rogo/REbSxktx3V+tM507avYa+oAiD4gbUrp4C23W98o6ZmKPlfd7LSm+QjmfSyXEqRpkH+rBTK66V6RlvZbcV2tWlqB7/HqdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716314352; c=relaxed/simple;
	bh=9nVCD8ADnlgjsIYAZwlJG/eJ9+TUZ5nuVmBLfa+tbeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G97xFckkGYsrVqaKEjWDlKObmR5r9QwpwoA0sezELBKlQt1IsNtPo22aVj9/EsrKnAr42sY9/DH/FNlH37Ryz5q/nPZQeB6lF51vxDOfzwT10AFzDazc5kZ8YaaA+1OwuRw4rdF1cQ3sErktxuKrZsDvXmBmLdGNBKlA/hNUtL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXdbpYbE; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ec69e3dbcfso3509225ad.0;
        Tue, 21 May 2024 10:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716314350; x=1716919150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xFpAHzqRgSiz2xm2CXznKixemcT6aD8kBzQB3tTCfzo=;
        b=AXdbpYbEAfuLEYRX3SQzUbJMqXNn7QUJotHE1x+yFtvoQ/xFFZMYW8iIrBXs1WlN64
         P2RDDjgYy/b/Xqoy8DCSi+sXfF5HnyKf3Y+Pm4DbR6Fv2a/WKjz9stNobOnT6dt9qWfY
         747qO0TrioFx8vR70JWNNO5y74x61vAiA9J7hN7fVxczEcWq6jJl176VAhdmngL3Bn5B
         FZiufn9FLz6fC8KXbsEy7Wj8ZukIMHaDAwYDlrOn4B4/uiulLb5fAYA4ZLB49sPqmiCv
         XLVVJVrPN95nyTMRlpt6Lgl6gVgQjobIJm7kjniFAb95Q/TQdCWdqUSTMcATgfJspI5B
         X99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716314350; x=1716919150;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xFpAHzqRgSiz2xm2CXznKixemcT6aD8kBzQB3tTCfzo=;
        b=carrzeq7+mbLdNgEfPanGcROCz/qJK1mJRKxja4Kp1uJvGfXKC9caYtQq/kOn9RrJi
         oCJ+ecxTo5hIKdAB2LJzPtx8tEgPIlVlOY+rcLQXkTHGTO+2uRV9X3Clh7ZTMhe/nVoW
         xxW+LcmKMVgXlboWhLApwMEGUkIo5EMM/1zvD4/GEPZeIC3bEKUI26ww/cxEOxvyVCj0
         /Hp8u1gzpsYByjQZ0FHmfXnTrbItTZzUz4yztCC9KmSeWAQhe8CohTjiYpBsl8UmWVDZ
         8P0u7euCec2DgTLJkvSnGg6UDJ0uvlTc86BcWvUcjdE1imVeUS3VSDQSHltbUwslj6ix
         tYDw==
X-Forwarded-Encrypted: i=1; AJvYcCXOSi4xS1qlfdBtXA3dh8x0g4TC+9UqzYA7y/HjVlNaRWF3kghhEFeMUS+/28h3EKkxUH7lsWLpM+LYA6eBpsLeYBcIN1z7xI6eO2Uz+p/e5hVrh9Ghq/lptEeTZvhMyS0K6xS1MFNtKkplAsn8ETbbCWFEJTUfBopZuSluFYlP3QUVwvIkl+0H
X-Gm-Message-State: AOJu0YzM2IBt1WEmI0AMBZxb/ucuIis/KTQPsBAeRKwT175eba5rricv
	rfNSdp03G8+XvJmo1t+crw2EiorgSm73Em6bUw9YMKImCoPZ6dHG
X-Google-Smtp-Source: AGHT+IEQVix1xCQAJ7lu1JC4bqBxGgwlzW9PigTCcx2l2HRAdtg3GNuIH6M9NtM55RShJgSvR61swA==
X-Received: by 2002:a17:902:c407:b0:1e4:3b58:7720 with SMTP id d9443c01a7336-1ef43c0c962mr357191475ad.2.1716314350150;
        Tue, 21 May 2024 10:59:10 -0700 (PDT)
Received: from localhost.localdomain ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f2fcdf87besm44646935ad.105.2024.05.21.10.59.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 May 2024 10:59:09 -0700 (PDT)
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
Subject: [PATCH v6 02/11] nilfs2: drop usage of page_index
Date: Wed, 22 May 2024 01:58:44 +0800
Message-ID: <20240521175854.96038-3-ryncsn@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240521175854.96038-1-ryncsn@gmail.com>
References: <20240521175854.96038-1-ryncsn@gmail.com>
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
Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: linux-nilfs@vger.kernel.org
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


