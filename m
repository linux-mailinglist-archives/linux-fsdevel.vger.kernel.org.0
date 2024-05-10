Return-Path: <linux-fsdevel+bounces-19277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC968C23F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 13:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC4ED1F22376
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 11:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD315171656;
	Fri, 10 May 2024 11:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7S6kZ7B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F194516F26B;
	Fri, 10 May 2024 11:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715341819; cv=none; b=XbRp1Qw4k68mr4F1glwHaFDD+JjUj/jJRrOlh1MruoEg11cIadjBkzlCDJHqjQSj+7JNZAhnFwg/Z61/R1ifVVkKDKIE+pvboN/LWyE3A6qjyBt89/WGsb1Vax1qoLnk3/p2PIj0AjAwIWPBnvM6g3Jrt4/kO0VFgC3Y0dUPY+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715341819; c=relaxed/simple;
	bh=1MRIiBP0wDFyNfh4532Vxucv6112mEx/goVx7Jaownk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DTwZYE+HiAvGPWuF0QJwZWmm/2cN0P14eolcGWeTojX6aYdIfuJF4GGzQTBQh18oo5uka6Sf2m4WZzsD7aOGrzGpc6y1OzZAkzkf558M54ifuOgzJZKVf48sq51ZMXtdu8wvEczN61+TkA2XR6phOcT/OgNosd0S/JpcVbSkTRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7S6kZ7B; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6f44e3fd382so1692418b3a.1;
        Fri, 10 May 2024 04:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715341817; x=1715946617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P42QJurgga8X3tClV+VU5iyd0pTaBz/Ss0EAkzfZsy4=;
        b=F7S6kZ7Br8XjhqdCitErqbXDQ+GeQ0BadVuNOcCxLvZLCcKYFtmCDbEwTAV3xoVrpv
         IkCVTAzMXlOhnQqaIzcnfsDcu9ZUFMQauFIbJvQgt+jMjETTArJplzhoqlRxuoVASsbf
         cmUFRI6mZVxRfCOmMQk8ry+oKL5EUCOvv2AbGoH3dWzl4qRyvqmSgo1/Mq4wMRCs3kWM
         H81rSZXhjlFnVfFFgDwj+YWCTtksVncbZJNP1lB+H2e7gK7s9aOBrZS1+5pDpJsPPIc/
         pploIPt6SvA7+XiCUFZiDMqOumvv4f7Bp4YPE7QlzEZxU+1mK79xB7nt36tRZ776XMTg
         7uxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715341817; x=1715946617;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P42QJurgga8X3tClV+VU5iyd0pTaBz/Ss0EAkzfZsy4=;
        b=fng64SkjMlzftBfoqOTVqvqrtKT10LHwqX/6VkTKJVwEjH9Ku+MUrntijoD4gjheD4
         KWNH8tjUB5UZIBi5lLwAba38i8D0uoUSOEa0XSpRDrkVncTquHsdwGx0sDkm30Y+iDug
         lt6zHi/LJFfhYowpbgn2DDOGwtD3qYwfzWdsRik1qQ2CY4RKw68KLCcRARCSqqeL0VGQ
         GKrxqp9uwzoyB2vlvVW8QJZr7HLXwbdkwmC3ncLE3Z3NsqYYghpkRL3tF9u2Fdkexcir
         Atwd1qCHSEhF5qC2hKMNLs7O8XQa/pYBWMyXO8kqz4Uf7YqiB4SPZOnsHurzBHlY5Qxl
         UFgw==
X-Forwarded-Encrypted: i=1; AJvYcCW45tSyDld0mij1MGoQgzSxpzNLyibnlhqvbTK/SyXA0aFuGfTDWPtGMfd+m+Rsrwos1cF7H3o0t8OG6RLrVBZmn2/UDD+sWZVlcbpHIS3lqFLMxCw0mRJCNezjr2cuwbh6iZdZWyk7MWMl3g==
X-Gm-Message-State: AOJu0YzBc197nYnjtcbKeY8rDD+BYPspMA4P6GzjJZHDjQgVW42+yAmq
	nqzmqNKtDVw4KRi72z27Hy8UxMTIEZuH0HjxH+cX3tpxwjb6B69B
X-Google-Smtp-Source: AGHT+IG7UAvfga0ZG2yNv2RJVoigr75WJ+wAKzDPiq9W3zLhf2/XYb9zpcIAAYXrq2V/r060tL2Rzw==
X-Received: by 2002:a05:6a21:3991:b0:1a3:dc61:926a with SMTP id adf61e73a8af0-1afde234e8bmr2652358637.54.1715341817254;
        Fri, 10 May 2024 04:50:17 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c134155sm30183825ad.231.2024.05.10.04.50.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 May 2024 04:50:16 -0700 (PDT)
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
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org
Subject: [PATCH v5 06/12] afs: drop usage of folio_file_pos
Date: Fri, 10 May 2024 19:47:41 +0800
Message-ID: <20240510114747.21548-7-ryncsn@gmail.com>
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
2.45.0


