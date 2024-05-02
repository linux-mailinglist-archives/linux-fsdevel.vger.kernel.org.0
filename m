Return-Path: <linux-fsdevel+bounces-18480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E71CA8B96BB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 10:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1468CB20E10
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 08:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647F153E27;
	Thu,  2 May 2024 08:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xzfq58w1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C86C53814;
	Thu,  2 May 2024 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714639642; cv=none; b=oubLweWrMQ+HQtyRMYgFVbnqt8fkEuul3TDMQcmhbBSDoXeEKEHBHpUSSJbtZTFHZyKL7pL4qhHBkVfQ2YOAyw+N18tHQwDUqvFwSAXYozq3cnJBh0Y+J2vb9gSVOhs/nHXXaQ7vgl7kDtyTrukD7jKwt9NezBjdmX7cHGw/1TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714639642; c=relaxed/simple;
	bh=out7TTbYJtYzFrjWSVWEYtQyDDZ86WVDSmk+A+q/jqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Plg7H4liYSfEE/ZynhJm/gCpbBigGBLWt+wzZiXGDkPfY7ZsUITcNslXnZCg5uhjWfnlZ0+5WT0gJ85LWe5IdtWNWgLgoo/sOuEuP2MQkKBzK8BdjtPe9D04Qk1lXqclVSltzztgXoTfOnBT7OBPge3J+LnLwz1U7C6y/4gtCVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xzfq58w1; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6eff9dc1821so7070384b3a.3;
        Thu, 02 May 2024 01:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714639641; x=1715244441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dKeW621Yklmzy6NXiq7Wct3/1VaKARCv12uVKwULRiw=;
        b=Xzfq58w1uIEfCN/UuIzsy1Mnn/LZOhAP8+Tw0cATRiPH/RqkXNnz+UUglmzJpUgtvI
         Jm2INLgOFtENgLeSAp1aJsMfl2hvrqArAddFXnBZq8RbOyOGVQkiHadpLzLh10ZZjM6t
         fryh8buznJtSqfh7meV6OAl6GyapL40oajwC8i7TU4pTh0uOx++pMvyPlNcF3r4MSApj
         TSJz8oXA909V5vOtaH3Ualm5JCek7SHyr7wRja/6+oMGwbSlcxfD8RDUNBWU14UFhODX
         uBZeQWt064P0rR10c9ATSIvR4nu0HMPEo0MQZLhsJ799HfFaYP3B5b/h3kbO9q3zQmBB
         7wKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714639641; x=1715244441;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dKeW621Yklmzy6NXiq7Wct3/1VaKARCv12uVKwULRiw=;
        b=C7t6Tgo1ltiF0u7H/KE/Li6UQ/iQkPXDwHODA5878VDVs32pczY3rFBHfrBFrbnZ1T
         fwiP7nnX4iU6WJJJBOclmORlRAYXuk/LVML2oy4Pf/jQlirTjShyzoErJmauGoQfH7Gp
         cwJPSt7hWLE0Qz4oAQ84cPUX3o5db/rfp6o84O9Mu+RhyXdPj9uBPe+RJQOEdNlORCqH
         y2o0DlISN9oVuaLZO7wcmw0cCnWZrZ0TWp+b1ULc/Gh2yF/Uet+Gnzfn2eWJzPKdcttq
         TqSZyHX9ok1oCwZTgOeskInIDKJN3LnMKyjV7XwnlRSze4pciXNJIM2ORFnz8THFQXjO
         1l1g==
X-Forwarded-Encrypted: i=1; AJvYcCUmVw485CHmnrOiuDKXm61VIbiaKapnq+YhdRMNHYWN35LiZPjr/R6ln3bc495nsgKHkfYxkusIjFfvpmkFFuZO2l8TXRdiQ1wTnrGQsN6wvFTwvoItrAbog3DDqiPArZa3RlUiaoPKl7cWe38KguQfE0ksNPjHVxwktMp1/9Yq1v8x2NnV3YSK
X-Gm-Message-State: AOJu0YydtxW//GmefM8Kix4vZ9m6oyPWN2Ga8JSh7wQK4qG/PpIOF6kk
	P5on7xNFDi823+3nhnQa61ixVDnuTYnCsaADK0oLAfBq6RErl8gs
X-Google-Smtp-Source: AGHT+IFw7DPiHNZRifdJPZ097xuBBnwfxycsF06NxKzZyaEaRqiuEdjNax8xBn+KkdLO8zdGBCA7rg==
X-Received: by 2002:a05:6a21:338f:b0:1af:66aa:f968 with SMTP id yy15-20020a056a21338f00b001af66aaf968mr6570426pzb.20.1714639640628;
        Thu, 02 May 2024 01:47:20 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([1.203.116.31])
        by smtp.gmail.com with ESMTPSA id q6-20020a17090a938600b002b273cbbdf1sm686805pjo.49.2024.05.02.01.47.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 May 2024 01:47:20 -0700 (PDT)
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
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	linux-nilfs@vger.kernel.org
Subject: [PATCH v4 02/12] nilfs2: drop usage of page_index
Date: Thu,  2 May 2024 16:45:59 +0800
Message-ID: <20240502084609.28376-3-ryncsn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502084609.28376-1-ryncsn@gmail.com>
References: <20240502084609.28376-1-ryncsn@gmail.com>
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
2.44.0


