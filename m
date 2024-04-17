Return-Path: <linux-fsdevel+bounces-17161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D018A887D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 18:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F951F23271
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 16:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E7A1487FF;
	Wed, 17 Apr 2024 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0lTodGu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C75815252D;
	Wed, 17 Apr 2024 16:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713370188; cv=none; b=BCRted07gp2eU6fH3pC6yJOmCNWA5s6DkGq54NdN7erLOiQnaVmjt857xWD9GKPt6vbfR5MqFO1PEF/y7uBZjuiJxLnIovQpzbSnZLOf5Ry9nQJiDIUeyRZZLO4pUS9qSAWhcDCjtlQln4Pn0/dAmo6mSvSrk2xUmfDYcdTznhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713370188; c=relaxed/simple;
	bh=CGj+WNrIUV3l61RyE0q4VlcKcvdYqAZ7eo8PGn+yS3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hd0HtJGdwuuAQHFah2BtoycuopMwyHkcrY/jpZn7E0VWVItpd1ghULB6KbjUv6TdPOob5O0ysSEDVue1FALUrrGt5PcVicWjTspldsM6T1T9ImY1WM35CfwPEmrr2QJV5g8c+szkFn6MB5qSRaFRaZyclxKNBYIGV1wxrgmA85g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0lTodGu; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ecf406551aso4776285b3a.2;
        Wed, 17 Apr 2024 09:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713370187; x=1713974987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EKBCpzMJJOybw3E+mN0Qu57krGqjseTa24mZvlKHSk4=;
        b=B0lTodGucJ5UnljoLMZJ6r8QsKpHWUvZTtaIL9NZ52ZDvK5DVYxfzwgiAUyNHcMfsY
         iHjL3AH2T9SXosi9aiQmiXv7QnW7lRR0iYTQGjN6/ERo8GmrDF8bEUHTXJNbgCuVgGeI
         5ykzPvqlwvuFOgU/DA2vwtBL5qUILsw53Zj0U/VxlCL86sr100pF7zNrgi06Vx23fAyY
         IXaaX+M34nMIhAhV/sJ11FHXbaAaGD5BNODV53uvtv1UBrKpvBis7m3T4pmEmQ4nFyhS
         e43ZY/Ti+WP6+qQyDTYEf9AleVfedKrASKycPcSA6j6pzHHbzbkq/lqHRl8LzHXC9nXj
         ITNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713370187; x=1713974987;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EKBCpzMJJOybw3E+mN0Qu57krGqjseTa24mZvlKHSk4=;
        b=C2233+fFGN1LF0ZNQBDPZm41ELsb6Vl5IeDBezhZJPz+MyZSqyXL2fjwRKKjyapKRh
         UQzhvmVN2kOpgAM3wXrFp9lbGxb9kNIGmzEX7DYEj1vVecX2jCUU4uUlm0gP5pzuleI5
         lNzx9eF2+ysBkV+xf0Vooalf96d6lXysiyS1arUkEe56UGh0yXtIOQ76CA3dv0B6W0ML
         dqXmUVZL68bIatEZBBjKQ1dQyThe5U+wljNWtq9u12GZ7x2qzstbNAgtodUQGaRQCVao
         l4xwbHvJPHxYUn8bkFDXozemuW32sYZD7F8VbhFQ4PNDkPCSkzfb/YD6lqRENAWNvnaf
         +OqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQX8JuMIOQKUjS9+EhdQ8B5rfvLs41f0LkBSUyyCc0aK21xoNhr4NKRXMh4w6xSqUqLM9aZ5ypdQU4EqeSLK26Iq6hDtehfqOvCoA7RGTBN0E91Ko3xlLA48aak5gWt/NULHOJhpxgUVk5xcl/zhaHN0ZISwGC1lXJCowkR4JQzDYJvQgGmOdz
X-Gm-Message-State: AOJu0YzTV9kZ1zMBoSi9WgQ67SIiBShmPz1rZ909XQeF9qxvWFGFg8mp
	y2dWAXtaododZSOrTtckepTclZZvwKefglbQgIGMmyprG2Y1CS7u
X-Google-Smtp-Source: AGHT+IEUIsD2UfwALUBzZ9zgNwZkhBtp79KdHPB59HWhpiWeEDWZ5TAduyfuawXCnxiRfUFyeMAZ7g==
X-Received: by 2002:a05:6a20:1042:b0:1a7:a21b:66f9 with SMTP id gt2-20020a056a20104200b001a7a21b66f9mr48906pzc.43.1713370186696;
        Wed, 17 Apr 2024 09:09:46 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([115.171.40.106])
        by smtp.gmail.com with ESMTPSA id h189-20020a6383c6000000b005f75cf4db92sm5708366pge.82.2024.04.17.09.09.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Apr 2024 09:09:46 -0700 (PDT)
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
Subject: [PATCH 2/8] nilfs2: drop usage of page_index
Date: Thu, 18 Apr 2024 00:08:36 +0800
Message-ID: <20240417160842.76665-3-ryncsn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417160842.76665-1-ryncsn@gmail.com>
References: <20240417160842.76665-1-ryncsn@gmail.com>
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
so just drop it.

Signed-off-by: Kairui Song <kasong@tencent.com>
Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: linux-nilfs@vger.kernel.org
---
 fs/nilfs2/bmap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nilfs2/bmap.c b/fs/nilfs2/bmap.c
index 383f0afa2cea..4594a4459862 100644
--- a/fs/nilfs2/bmap.c
+++ b/fs/nilfs2/bmap.c
@@ -453,8 +453,7 @@ __u64 nilfs_bmap_data_get_key(const struct nilfs_bmap *bmap,
 	struct buffer_head *pbh;
 	__u64 key;
 
-	key = page_index(bh->b_page) << (PAGE_SHIFT -
-					 bmap->b_inode->i_blkbits);
+	key = bh->b_page->index << (PAGE_SHIFT - bmap->b_inode->i_blkbits);
 	for (pbh = page_buffers(bh->b_page); pbh != bh; pbh = pbh->b_this_page)
 		key++;
 
-- 
2.44.0


