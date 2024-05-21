Return-Path: <linux-fsdevel+bounces-19925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3818CB334
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 20:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D78FB22112
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 18:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EA9149C68;
	Tue, 21 May 2024 17:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jd4qPjh7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72952148FF1;
	Tue, 21 May 2024 17:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716314366; cv=none; b=VF349zFHFZJf3AF8UNYhoaEN2kH4BkrgVME7sGvJnMQaLiztUpwUwv2DGcKcMk6BG7+wa+Pn/h2nr9ruCeA5h/jLVpphEhevbd8TV9nQL07AC5PIWBPQDQQPnRIcfC3EfG4olAAFBiReVndpqZOsGj0oDIkE7ORAXLUZS76HBvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716314366; c=relaxed/simple;
	bh=1MRIiBP0wDFyNfh4532Vxucv6112mEx/goVx7Jaownk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJ7wv/Sr2g76zg4v5JUVIyC3loWcb+pdMTNrL0kZSxIN24aAntpWKeE7HH0GX1plhGQeELjo38ClM/cq3jjYw28FYZeA9puAZNA54I2QepWv5fW0YouBH2P6R8t1ESXbWoC+MdmLVv3apYDcfl8gkYRy0lF0vj0NwnhOgRc0kPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jd4qPjh7; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1ecddf96313so94012535ad.2;
        Tue, 21 May 2024 10:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716314365; x=1716919165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P42QJurgga8X3tClV+VU5iyd0pTaBz/Ss0EAkzfZsy4=;
        b=Jd4qPjh7XF3FpqO3jJ1mrhTFtw8Q5Z7RA9eTKtPSrTyX6r5XvLx5A/HCdHylRWEWWb
         3EKV6BRMrVrBxmBHJtpA/78GpLuRslIS4RYmnGUlgvLYoWZHjsgWO+wi5kIgZiMK2Eps
         gOE0pDGPSHHzoCelzQAwM5mr2UrdfLVzIngUyn8HHHjjsGo6MY8B8SwbUOHI78EyDkx1
         HbT/y/5U3167TE/o2pNmo73H0ETSULZ3V9plGxdk53UhK4fPjTPZ39HISS92E00H1LN9
         h/l/227k96h0Mz0kKlUejJYvRTLfdpGJZiN6WTr78xyT3wjUlNV6d78uCk2Ake+JjnCW
         SSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716314365; x=1716919165;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P42QJurgga8X3tClV+VU5iyd0pTaBz/Ss0EAkzfZsy4=;
        b=T7m30ppjskFUeC2yamRf0fRr2+cfXdaiHJguwRw5ljJxGrDrEDJ3we2gaRcDTkHdH1
         XXKbopOr8Bf1MFc809aj2M/KmhsYNYEVv6QAH8fqogUs02t3xEdofNb4uVXN1l/OlS18
         V0t4pXyhfMjahMnX1AMGIaa8JcFPMcLzEONWsTgiacuy/aFs0T4HGYCYGEZ8lKSaSsN/
         BHhBd9Xufu3mEZbdPMhNMJKGyo1Rs721yGJvrQVwDcukGTfBjprvaI3QAyOHHulWnj06
         GI9/aJGJjgazEK35+5pn5jkVNSQ1ICR1MQcbN1MojQZA98agprOd5RPF/Ud2oz/Xl79f
         XYCg==
X-Forwarded-Encrypted: i=1; AJvYcCXtcnEktI3AeCFifikeYkOqWMeAtWADAsIG8V1JJj84mG6qeno7nMfKGPv0eWwfKj6teDqOPqLna7twHNjQAFQpEi+JEftA3/9uZPyvEP2KewdbmqU9Elh725jYCNI3DwAjigfO5ggLECFQrw==
X-Gm-Message-State: AOJu0YxBmS0DxLYL573p6gTrdGbMxGBdoiPWFoB9npNMEAJcgAEpLUgw
	zNNjFhtvFskHXOyYrD3Q7ZejFWOu6UOnr9XysuoevYOPHk0gMXI4
X-Google-Smtp-Source: AGHT+IF1cRebeOkZju1vxHpZ1ZTdsLqq2r6EkmnYiCv6kOq5t90eVHUHeUPz1jz1sKsUOH9AfM/KuQ==
X-Received: by 2002:a17:902:760e:b0:1e5:a025:12f9 with SMTP id d9443c01a7336-1ef43d2836fmr395328615ad.28.1716314364758;
        Tue, 21 May 2024 10:59:24 -0700 (PDT)
Received: from localhost.localdomain ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f2fcdf87besm44646935ad.105.2024.05.21.10.59.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 May 2024 10:59:24 -0700 (PDT)
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
Subject: [PATCH v6 05/11] afs: drop usage of folio_file_pos
Date: Wed, 22 May 2024 01:58:47 +0800
Message-ID: <20240521175854.96038-6-ryncsn@gmail.com>
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


