Return-Path: <linux-fsdevel+bounces-17529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE71A8AF4E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 19:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFBB21C21E88
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 17:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E9513E3FF;
	Tue, 23 Apr 2024 17:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCFP2ODN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8825F13E057;
	Tue, 23 Apr 2024 17:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891841; cv=none; b=PXGqUV3dEX3GEkvSAFNKI25HcpvEU2LN1C7Zy0G00kl0aU0bIXtQBIinZnk3KDWAI/gzc5ixV2Af8wJXTSNNswz3xMFPsJf4xj/ep6OMK055VAZQD6otvLh7kqjXMx4W0aY/nDEl/qVMDtE0rcQI2NIFPgUPd+3sW81h+ODyX1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891841; c=relaxed/simple;
	bh=Uyce+dc3t6E+2F7Kun0sqcdJkKyU2ngW6vMHcIsFCvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tct6ryTyJMpb4orilm0cwG47EVe8FeE896aBKpVn1NOpt+ppLUbPG2q/wiyFg25obXXjXaDheS3QYSm9G4XoUfP+eOksxU64Fc6sM64WXK/iY90d01whzwJCxRMbMaCGBDs14jauUhKm5VZv09K2IZCWohY0iqmNYmpaHXkZUOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCFP2ODN; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ee0642f718so56017b3a.0;
        Tue, 23 Apr 2024 10:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713891840; x=1714496640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YfpxwnN8CfoAe7aR3YgTjEdl37ZW9GmobE0CddHnTJA=;
        b=OCFP2ODN36AyfHCRosaPabwYhrhVdgjZi9lQb/qWno2ZbQ5JXjGHPEA1UQPTHNcvcN
         A62jdVQCEk7JA+LyZlLwLpU3ZVc4apy0WJcBTquV5seDzcgUjcQ/K/M/rwMfXGuypfP9
         9nv04vQZ2lEN+95Bg05sBOk7lakWcdEiCnHN0t+jOP1b36kpetnd59MqCHJw4Tdqd/kx
         gPdKrlIZZ7Ex33o0dvO5DHd/a3AGO1ZNUJDdIZFvED2q7nwP0kPdhrsK5kujSTizZYry
         x6jNG0WNyF+1pS9c3/nCVjHWbsazdk1z2FurhTSyH0gNjnV7YUpTD0T1mPYzBp5SJnn6
         6soA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713891840; x=1714496640;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YfpxwnN8CfoAe7aR3YgTjEdl37ZW9GmobE0CddHnTJA=;
        b=XkxUIRUFIEaxaaeP1EcGeGS3CndOUGCLV/wOJQceuIZX+Y/+LH8Z6mXEWqa+gmh45P
         mYDnPa27ymTlsNzwy/odx9oN49KKbY76oayI8NBSsUZVlXXNgAANuLIpa7d6mHu9/FRm
         mowF9WkHQ/eLhuYHJSHvItRuQlWVQe/F32l7g9/u+JmILLLyMlkhhuYjAhLmueQyHTkL
         IumMukUu4eOB5A5SjQQcxon3DQFBge3FGLPgqshKaGFdns5RJRtZkxWKc+PuWPjIcsZm
         B++gMO/w3Tl3mZKcvkxP+oA/zoqFme5gHUAzqCSJyeglwh++oH9bsIiPy2gJKsUQNuSB
         +atw==
X-Forwarded-Encrypted: i=1; AJvYcCVesD5poqBCes0urYixToMHi8rQz8xfgYu7txzyjNAZsFY0EfTdxlmiBdevULHgQuAkxqTDB1O0Fv+fiITUIq6Lm8jQTNERtxBkoURxV6tjGoKkKOjWYsl/GvROSATHcSaqjujrq+QIOkqn5Q/3QcZOBHGSohXHoAek4ZejCzYRHXqMnC3e6OK6
X-Gm-Message-State: AOJu0YzIUajgjT1oDe/EPC+E3iRLmnW3OEJ6oDYh5JFfGfblu1bhhfPD
	VbgUutACNUb+o+K0hVm8H50T5EfNz8YXxKDzaa1Tz3cLlVOO61Tq
X-Google-Smtp-Source: AGHT+IEWWHhF19ksGF0RHc9H2/SNsHmOpvGzFHUqvC8eQ1hIjSvMBjQypYUZq4AUNd9PZKflJXxjrw==
X-Received: by 2002:a17:90b:815:b0:2a7:8674:a0c8 with SMTP id bk21-20020a17090b081500b002a78674a0c8mr4130992pjb.1.1713891839853;
        Tue, 23 Apr 2024 10:03:59 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([1.203.116.31])
        by smtp.gmail.com with ESMTPSA id s19-20020a17090a881300b002a5d684a6a7sm9641148pjn.10.2024.04.23.10.03.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Apr 2024 10:03:59 -0700 (PDT)
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
Subject: [PATCH v2 2/8] nilfs2: drop usage of page_index
Date: Wed, 24 Apr 2024 01:03:33 +0800
Message-ID: <20240423170339.54131-3-ryncsn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423170339.54131-1-ryncsn@gmail.com>
References: <20240423170339.54131-1-ryncsn@gmail.com>
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
so just drop it, also convert it to use folio.

Signed-off-by: Kairui Song <kasong@tencent.com>
Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: linux-nilfs@vger.kernel.org
---
 fs/nilfs2/bmap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/nilfs2/bmap.c b/fs/nilfs2/bmap.c
index 383f0afa2cea..9f561afe864f 100644
--- a/fs/nilfs2/bmap.c
+++ b/fs/nilfs2/bmap.c
@@ -453,8 +453,7 @@ __u64 nilfs_bmap_data_get_key(const struct nilfs_bmap *bmap,
 	struct buffer_head *pbh;
 	__u64 key;
 
-	key = page_index(bh->b_page) << (PAGE_SHIFT -
-					 bmap->b_inode->i_blkbits);
+	key = bh->b_folio->index << (PAGE_SHIFT - bmap->b_inode->i_blkbits);
 	for (pbh = page_buffers(bh->b_page); pbh != bh; pbh = pbh->b_this_page)
 		key++;
 
-- 
2.44.0


