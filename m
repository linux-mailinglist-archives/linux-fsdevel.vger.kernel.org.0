Return-Path: <linux-fsdevel+bounces-60634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53621B4A76E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 11:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F141C3ACEF0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 09:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1984429BD85;
	Tue,  9 Sep 2025 09:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4khhyGI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C990D299947;
	Tue,  9 Sep 2025 09:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409257; cv=none; b=rvPkaNgAcZ5rpNyTbPKkDaXJKk1mnduQ88vWuSqY0nXeMhhiFGHGYA4TEXTG6RXg3GW4ca0hbWOT6n+wjgt5AUneiNBbBtY/3SQvW+cyZrblsyVRpvczT+hZaFGwPtcn8hxgf7hB/UOCC0zauA1vSAHDOUiMqkQPvJcTPNl6gAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409257; c=relaxed/simple;
	bh=Ygd2xNOZ6wJl+5bd6IH5BNX7SOauXKYvij+j9ifOwTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eRrAhvHCwaFdfHFCjZd7wXPJN5GFKcOpA1U7pfh2BBGvwv5iDQdCq9PO5jbfLscTjk4JeN89psiukPXGEbiqk0yYQYvy4oNV3MlX8f7JF+mZm5pQnGhZ6+oxD7VIzveH3OQYdATPB/ewkzcLKrvsO6ldcrGOd1y3MuQKDR2kQc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4khhyGI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45de6ab6ce7so11849185e9.1;
        Tue, 09 Sep 2025 02:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757409253; x=1758014053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oqrc3yRxVyX7zMtuBTJxbswEHmIj2FBD0Au1ZvwTXKg=;
        b=A4khhyGIBDRD16Yba6h3dVvzXPDrwvQiy3x8zugzmzZmyop+RBlbvoK6BusM/HViIV
         UJwAcnEXJUmtwcnbwpsh2SBeFQRN03Zs5xJqpqmskDeX1BpjhxlMW/ajoDysuVCIzjlZ
         88jr6dNGKi2P2itNgG/GOUAsEPH19lHY+5xYVaG/PNKjYGmYOmTBHyjh7nFBCkLlqTbh
         q055EIzXybTI3qEOb/ANlehX4hdo/R0WwzeKsVMEmeP0rxSEwHATtvVz6Z4ACuxGQzj6
         3o/XD6y5HFs6NTJZbjjF8bzfUobv+SNoMnVtIZRZND++WKB+icbVS9vRKUF7/AeWSY57
         ct2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409253; x=1758014053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oqrc3yRxVyX7zMtuBTJxbswEHmIj2FBD0Au1ZvwTXKg=;
        b=QTA4hB51i00Xv5BvkUa5+AQe4gcbv1sFejsuHAFN8DZAOeKMimRIkgJoifqzMrEun5
         YweK7efbAQbevEphmIdxCusipS+t48JqBpGxFGbmI9MHfbYUtYYxCGoeG0T/NmLBn0SA
         OhBuEjI5cgE/dBSK0KygTYwzsN7nykxZVVaLLg8sosA/DDJnnIkNacNZpBQ+Y9eejCGO
         W9VXGj23u5T1VrOOeNyz8dkXboWe4eLlfJIdBYmzPYIEBQkUvsFVyVnvJ2Ml6FPowWeG
         36ZGTWEDRJhNgpqiGgMs+/SWhxdqxUMlKUBd+yHEzaNWV6Gwp/B1lvVtZmrnbKrZyhTc
         TjBw==
X-Forwarded-Encrypted: i=1; AJvYcCUpOnI8600M2LIn+G46COktIZvUUwkgflvKvavqfMZfYWKEhFtyE4Qg5TTQIdESBRSV7Aqlh2vEen2Moh7u@vger.kernel.org, AJvYcCVRatbHJ9/0gCyJFFJ05wCoQvY0liyIHKBKXG7w5+AW13mjkbP5fbCNusIJO+pdIA0abh7ova7Dz2xLJw==@vger.kernel.org, AJvYcCVaKGj7IxS+GXE9CW+nPebfqd0wPBbriqdgfPa+ZbIJTc1sSGgrcPt70Bhs5RUIBeWAIWs7vQoeQdcPyXpWcQ==@vger.kernel.org, AJvYcCW4ar2vCpoBHnQyI46d82AvvB2sM6UOR8vVv2Ite9XYF+PSRzDSB+mmvicunBe8r8BnI01EY70fgLpPCQ==@vger.kernel.org, AJvYcCXoR/d56wAaie9xajtr4vLiuZhw2sdZvHv7egZleSDYgJ+czPWMdrgzF05/8o0c9OSnxHLasMeQDG1o@vger.kernel.org
X-Gm-Message-State: AOJu0YzTXpt08VFmCVsu+t1XpfbnOjyrz4SvpyN1EW6OsLjvMamZj/GT
	rG/di6IH3L09014DDQvMvMd993JDlqaVQwMD3xoCd4n7adMtqybRYrb5
X-Gm-Gg: ASbGnctgMloVVb4p93PCuBhDs/ftG4IauUiJgWMrCLnjePWQ5fDEkYKxWTEthdC8m87
	bQICxMvw91NIWklfLjqjsV+mFFqi5KS9kR9+jA83rK7IJqRQvjrQjC+eyeaK0uRn+KnMijulmsR
	geOf7B14V1AONrXiEcl8MSM6SgG1lccOSHYeb6rji/m/sVtWKpzQ8szON4MUGdZveu+HqrWQTSf
	7bcL6MBApcuNgBV0S7p4l+pW2LufMTo8V5sscAaORGWqt/lOEFF7UUqr0lygCsvUlYJGkW4mQ5q
	DJp/KADUnps8lY1EgEVYmLSmlejehUKRrqEtS+UDixw5lxySb3VJy85AJh4DM2penW3cwoAKzgR
	g960yKFAJWRwIjxi2TpUkQcXPjQvLUa3FWJvcJveVwYxPiZvThIM=
X-Google-Smtp-Source: AGHT+IHAbfflRnixVZpH4RBMAgPFhxkpEzJjRDnWXqCOhfzm++EGw6quNoSwW084M8/CBIXis2UE7g==
X-Received: by 2002:a05:600c:5247:b0:45d:e285:c4d7 with SMTP id 5b1f17b1804b1-45de285c731mr70343735e9.9.1757409253090;
        Tue, 09 Sep 2025 02:14:13 -0700 (PDT)
Received: from f.. (cst-prg-84-152.cust.vodafone.cz. [46.135.84.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521bff6esm1810784f8f.13.2025.09.09.02.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:14:12 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com,
	kernel-team@fb.com,
	amir73il@gmail.com,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 04/10] btrfs: use the new ->i_state accessors
Date: Tue,  9 Sep 2025 11:13:38 +0200
Message-ID: <20250909091344.1299099-5-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909091344.1299099-1-mjguzik@gmail.com>
References: <20250909091344.1299099-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/btrfs/inode.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5bcd8e25fa78..1cfdba42f072 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3856,7 +3856,7 @@ static int btrfs_add_inode_to_root(struct btrfs_inode *inode, bool prealloc)
 		ASSERT(ret != -ENOMEM);
 		return ret;
 	} else if (existing) {
-		WARN_ON(!(existing->vfs_inode.i_state & (I_WILL_FREE | I_FREEING)));
+		WARN_ON(!(inode_state_read_unlocked(&existing->vfs_inode) & (I_WILL_FREE | I_FREEING)));
 	}
 
 	return 0;
@@ -5317,7 +5317,7 @@ static void evict_inode_truncate_pages(struct inode *inode)
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct rb_node *node;
 
-	ASSERT(inode->i_state & I_FREEING);
+	ASSERT(inode_state_read_unlocked(inode) & I_FREEING);
 	truncate_inode_pages_final(&inode->i_data);
 
 	btrfs_drop_extent_map_range(BTRFS_I(inode), 0, (u64)-1, false);
@@ -5745,7 +5745,7 @@ struct btrfs_inode *btrfs_iget_path(u64 ino, struct btrfs_root *root,
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	if (!(inode->vfs_inode.i_state & I_NEW))
+	if (!(inode_state_read_unlocked(&inode->vfs_inode) & I_NEW))
 		return inode;
 
 	ret = btrfs_read_locked_inode(inode, path);
@@ -5769,7 +5769,7 @@ struct btrfs_inode *btrfs_iget(u64 ino, struct btrfs_root *root)
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	if (!(inode->vfs_inode.i_state & I_NEW))
+	if (!(inode_state_read_unlocked(&inode->vfs_inode) & I_NEW))
 		return inode;
 
 	path = btrfs_alloc_path();
@@ -7435,7 +7435,7 @@ static void btrfs_invalidate_folio(struct folio *folio, size_t offset,
 	u64 page_start = folio_pos(folio);
 	u64 page_end = page_start + folio_size(folio) - 1;
 	u64 cur;
-	int inode_evicting = inode->vfs_inode.i_state & I_FREEING;
+	int inode_evicting = inode_state_read_unlocked(&inode->vfs_inode) & I_FREEING;
 
 	/*
 	 * We have folio locked so no new ordered extent can be created on this
-- 
2.43.0


