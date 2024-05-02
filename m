Return-Path: <linux-fsdevel+bounces-18484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 837988B96C5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 10:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A66161C20D3C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 08:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8142E56B85;
	Thu,  2 May 2024 08:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6ul+mi8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8138A524D6;
	Thu,  2 May 2024 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714639661; cv=none; b=TAAdBhFp+jTXufT5/QFt6MWQd25wZmQBV+XddP1U+Isymps015b9lPWwqs6e0eP/qvsWUw1/l3+t8nPRrgLOftyjZkwcfTl/vl5pDjlTiUnZahrpOh1TJpfZwFAsjsl0JsGi6rLWbG+f5/uQ1uB7ysxLkPaaLsmlwY5skY0Eyag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714639661; c=relaxed/simple;
	bh=B3jn4ua9eS8lAn0HB5zwS6E4a9p45K+H69tZmQ+KMHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=izwASeHUTipCakuI6BYsd1Ki2GmOaGZo2Fp4BxBUY4HVu396kchIs0GX5IfKTQrFXrlrlWjW1XJ5oiX63nZNpELZ3qC3YlocfhJr2PGlxmsC+RZJfTmvP0rBmQjZZ0XO54eBTCz+1ynu/YnIh1MNzRSQYcwrRfr+fGZ7xzSqXfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6ul+mi8; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-602801ea164so5205231a12.0;
        Thu, 02 May 2024 01:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714639660; x=1715244460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=o1JDj7M+VHieQbjCEGNpRgkTBIVb3xdVSM/lbKWffPE=;
        b=Y6ul+mi8BoBrJnzrE0msfNk4Ox40cKcQwQR9MrQDkvVUhoRP0KPP6lFplfkhDpPs0P
         PbXA6uOVgJQStiae3nJUIh8BDzY6qW9dfYHpnbqEN026A6khZqY2CNW22FF37bXlB3JT
         z/wpXYSfNdz7voI2djcvjGj8UcnmKNRUlWjnPxf8trbVfDwMjYTY/uyseqoA2KbSox6r
         +bjXtlwp0X5vCmi3++Fbr5t+dIEzHamhY03vtABZjt3HKQNA9uml4xYieTKeQLLeY3fV
         kvnQuBsgwH22xsFXcU/Wt+73pF/hufl/jhan82AONUifyLTNxioZ7tkOqXbRg4DYJaG6
         V9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714639660; x=1715244460;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o1JDj7M+VHieQbjCEGNpRgkTBIVb3xdVSM/lbKWffPE=;
        b=jodWbrLS8N0f2w1rfZgNfFmViIi5duEh/imyGbpbjn87HTdplH+u6xvejHjsLpEp7v
         hv2wO+XaR+qzzYKnpIZMCPAUoD+LvDBZ2Gxdcl+9cgmya35k6sE14FI86BzXlDwbMFsP
         qjrO9qxgyDCdKONHARlOxUYwKEFmye2r0jkoPF0qHZ8nnOoCQYyJLYy+lGHMCbrpHV/C
         JvKmcNtYNAS+dWQB3XA/yR+RnVG3CUMC/B0fPjdu7yjp9Nc4peD337Q0evYj9eC4Pl0W
         dwr55eJrfCcqSQq5pmltI8vc2cKbtlcf8UFjeQZhxQwlTnKsDFVizsOVE+UGWmPnK5qg
         VNLw==
X-Forwarded-Encrypted: i=1; AJvYcCWTGe4GQm+wOOHkJY8Enb2l7Ei19ZAwvmPuuRlc5QxVKxO5wLbR2xI0D4y6f1UZKrLledKat3ZQ6ct9b/IWx8yP1YDs0Btv5FNPKwWL9/aIKhmId9ICIL1QhQC9Jt2QtMC2gQhVSqBfm/mU8Q==
X-Gm-Message-State: AOJu0YyA+V4PgHZna7aVBdgwgUcomyODkKgJv+kwVo9cgpfTJMIv0xqH
	WDuL0DVPu0euj1gT6+r1QKtaxg2rRwvjnc6FCG2+EH0Jbrhb3Dm1
X-Google-Smtp-Source: AGHT+IFBu+Fs+rmoaivL9bptW5t+ch5V+p6LPKN15/2dRUJC/IPaj96UkzDDRSMAnS5vPG9aDDkxww==
X-Received: by 2002:a17:90a:550e:b0:2b2:9d08:82d2 with SMTP id b14-20020a17090a550e00b002b29d0882d2mr4896166pji.42.1714639659690;
        Thu, 02 May 2024 01:47:39 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([1.203.116.31])
        by smtp.gmail.com with ESMTPSA id q6-20020a17090a938600b002b273cbbdf1sm686805pjo.49.2024.05.02.01.47.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 May 2024 01:47:39 -0700 (PDT)
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
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org
Subject: [PATCH v4 06/12] afs: drop usage of folio_file_pos
Date: Thu,  2 May 2024 16:46:03 +0800
Message-ID: <20240502084609.28376-7-ryncsn@gmail.com>
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

folio_file_pos is only needed for mixed usage of page cache and
swap cache, for pure page cache usage, the caller can just use
folio_pos instead.

It can't be a swap cache page here. Swap mapping may only call into
fs through swap_rw and that is not supported for afs. So just drop
it and use folio_pos instead.

Signed-off-by: Kairui Song <kasong@tencent.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Marc Dionne <marc.dionne@auristor.com>
Cc: linux-afs@lists.infradead.org
---
 fs/afs/dir.c      | 6 +++---
 fs/afs/dir_edit.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 67afe68972d5..f8622ed72e08 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -533,14 +533,14 @@ static int afs_dir_iterate(struct inode *dir, struct dir_context *ctx,
 			break;
 		}
 
-		offset = round_down(ctx->pos, sizeof(*dblock)) - folio_file_pos(folio);
+		offset = round_down(ctx->pos, sizeof(*dblock)) - folio_pos(folio);
 		size = min_t(loff_t, folio_size(folio),
-			     req->actual_len - folio_file_pos(folio));
+			     req->actual_len - folio_pos(folio));
 
 		do {
 			dblock = kmap_local_folio(folio, offset);
 			ret = afs_dir_iterate_block(dvnode, ctx, dblock,
-						    folio_file_pos(folio) + offset);
+						    folio_pos(folio) + offset);
 			kunmap_local(dblock);
 			if (ret != 1)
 				goto out;
diff --git a/fs/afs/dir_edit.c b/fs/afs/dir_edit.c
index e2fa577b66fe..a71bff10496b 100644
--- a/fs/afs/dir_edit.c
+++ b/fs/afs/dir_edit.c
@@ -256,7 +256,7 @@ void afs_edit_dir_add(struct afs_vnode *vnode,
 			folio = folio0;
 		}
 
-		block = kmap_local_folio(folio, b * AFS_DIR_BLOCK_SIZE - folio_file_pos(folio));
+		block = kmap_local_folio(folio, b * AFS_DIR_BLOCK_SIZE - folio_pos(folio));
 
 		/* Abandon the edit if we got a callback break. */
 		if (!test_bit(AFS_VNODE_DIR_VALID, &vnode->flags))
@@ -417,7 +417,7 @@ void afs_edit_dir_remove(struct afs_vnode *vnode,
 			folio = folio0;
 		}
 
-		block = kmap_local_folio(folio, b * AFS_DIR_BLOCK_SIZE - folio_file_pos(folio));
+		block = kmap_local_folio(folio, b * AFS_DIR_BLOCK_SIZE - folio_pos(folio));
 
 		/* Abandon the edit if we got a callback break. */
 		if (!test_bit(AFS_VNODE_DIR_VALID, &vnode->flags))
-- 
2.44.0


