Return-Path: <linux-fsdevel+bounces-18171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A948B61A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 21:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C246E1F21BA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635B813C9A9;
	Mon, 29 Apr 2024 19:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8gTenSg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8957513C91B;
	Mon, 29 Apr 2024 19:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714417635; cv=none; b=RjeR9nCN77R7vKgIHcnS5rvsTMnPfRJkGy/VJa7889gFl4+/6BTX/dEaVXq3OetEGwt7EK+k4lPoP7THWY8WFjNJYagxFOaO42ciUboZT2zlSgAMpBjxAnIXjktgM7BwOi/uTfjIWKfKd3T0WgVEhG4APcZC+gcltSqtHXc+sjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714417635; c=relaxed/simple;
	bh=VNvVFoX6vwMwHN/TEFwnJJ3gkjqMJfxSRhvUOpIkZtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTBZtyXXTEcgR32F/b+NXJKV+kIDg4QBDpIedbVC9BHeBBmbw9s2JBJ23m5nK3ceCka04ojJrzSZQIVQ6Qv28j0Bmzqs/6AekJyTdUfWSu0bXiOFJNkBEMOJIwCSzYptkWsT94/VifWD8wOCPgizhUmu0M6rItPLS+oxA/gYWwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8gTenSg; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-1e3e84a302eso36602495ad.0;
        Mon, 29 Apr 2024 12:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714417634; x=1715022434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j8CUFoSDp/EKaskCJGmVh167O46FIA8Hx1fDOeQzssk=;
        b=k8gTenSg2WTnuO2QR3Y2N7+9dKvs/L6LEdM3IiWpC/b5UVSz6IDlv4YIeNZVM1I36W
         vcqQa7BPR040roJVeqbjuJlgz0Hb/lT0cr4SPl21aDN8KIc9KcclH6OvuH1FLUVpjP6e
         bbFxlFKkAXwkjUkF+c9o0wpibRcdfz+shWNdTA2JEp8Qw0LgG9Lty1rnSJCQTYYohRJs
         jpADovMF/Oy3vkBQ1WSpC8t5CkhVycmSBBbQJUX+M31ZpFsPaBD4qQeUDZ199GY5mhf3
         n+Kiqzi/8nP74rBiOb7y3Udo0pJhDATzI7hemTgwFq2+hEMC36fy9GcY63pRUPdiQGya
         WZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714417634; x=1715022434;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j8CUFoSDp/EKaskCJGmVh167O46FIA8Hx1fDOeQzssk=;
        b=X9SLa/pD7IbWZAzG4Ro+aHarss1Y7vRF1nMvq18UvmndbjoDb/vmHrldj8RvNyvTTU
         wes5Gbg8FXjbRsChwJCi88v3BAhoD1RFNiID9j5/lCR1WXCw+1AcPqQvlBx5ZONeb7c2
         yRzKcvmo/+osGGLgv0rA5ksEjpiLKNPJ5ERUfLGCZ0pkCGrrS6FSZ3J6uviKDdWUUI6n
         3kpIsuRdA4S4EmEXh3N3HwxCdvxpjNfOrbmRCNEPB04flOa5QkOBOgwVSurr8GkTHEEV
         7DaFhWpwOxxRle8vKK6IHSPLz7f+KNVjzPnHM9zYmmo7fMSnB/BmH9yLcq02K9HdsD9e
         lTcA==
X-Forwarded-Encrypted: i=1; AJvYcCXOWDycAxiGeO8Ihz7fs9DsSnFzXgMShLr7pqEhMBU/emydI11tKJ8aKE0m/vXCpPgZlR/OLVrnv0eVaPYvodFcymXx6BXuifoRtPNZiaVY/PExogRvxkVpZTgKdLXC3FSPN1omYdxXelzj2Q==
X-Gm-Message-State: AOJu0YxGImba/jlYkuIE1Mj1gVEaDGUpl81QL5Fd8epZmG4BFtFVC79S
	KBE4anERMJgWnvbTqhx1XmEYYrqd6rZ9B81jZK1lzisGj2zVUVEd
X-Google-Smtp-Source: AGHT+IG1HlTPPFifaefvEDj8u3MJ3k3c8t/hPDMkQJOfz5CIi3ml/ryyLddQigyVsR+TdOh10trzuA==
X-Received: by 2002:a17:902:f688:b0:1e5:8629:44d with SMTP id l8-20020a170902f68800b001e58629044dmr14089278plg.1.1714417633924;
        Mon, 29 Apr 2024 12:07:13 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([1.203.116.31])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902864400b001e49428f313sm20619356plt.261.2024.04.29.12.07.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Apr 2024 12:07:13 -0700 (PDT)
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
Subject: [PATCH v3 06/12] afs: drop usage of folio_file_pos
Date: Tue, 30 Apr 2024 03:04:54 +0800
Message-ID: <20240429190500.30979-7-ryncsn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429190500.30979-1-ryncsn@gmail.com>
References: <20240429190500.30979-1-ryncsn@gmail.com>
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

It can't be a swap cache page here, swap cache is never exposed
to afs, so just drop it and use folio_pos instead.

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


