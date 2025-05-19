Return-Path: <linux-fsdevel+bounces-49445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CC1ABC708
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 20:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3398D1B61021
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 18:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777BC289349;
	Mon, 19 May 2025 18:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnAiQYmG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E7D1DEFD9;
	Mon, 19 May 2025 18:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747678815; cv=none; b=Z/YiNTEtGozN70eCuOnOGoL/k6vEA0NwZwME/KKzg/gRBrdMloDdDjEZ09uTgHAn7PjEWR3QBb/4YzkSMHLhX9EdzlztwBlu1ey95B+a1KI9NxpIYp88exfM8dcllWHGjyK5IRqM9KqqrF/Wp1eU+d+RvMLeyGdDf+MjIdOyPrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747678815; c=relaxed/simple;
	bh=/yp6l4/QuPdRIMBpxiZ4qgoNzB1EnpeZrtNWGwKa8RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X9Z6kOsoPgK+Yy3KfYrL0VhtihWFmlRksOLvrOBdsWZdvfTEjJnc1uw+NY7GzYqZ49nacVc6C4Z96+PoyWq56SF6Zfiys953kav86oQilEEmzIBa9A9fCqV/v3gLVizUnP/hlAMMzmUtSSlKw4Xo+uCqBdCebpIFSU4Y89F21eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnAiQYmG; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22d95f0dda4so51001385ad.2;
        Mon, 19 May 2025 11:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747678813; x=1748283613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bl3kloQIYExcBzmMs6Zl45FMSSUIPiZvGCce2ZtNaEM=;
        b=hnAiQYmGcMHv4tDg9f3hkvO4MK71MkpaltwD3qfXv8OH9Rc3nAT3iTavFwq1YMFUsp
         PEMBxGUdIBCHBdAGTXW06jcEnKn7Ym86hSND6TPWpcST9Ny/uKb0+EFJ1GSKGAUPq7e6
         FnHr8incD4g+kn5tGweZp8zKUuVSNX26IsOKBa/816h1q7a4RQBXMYrCzo/s8BCvbqoO
         Jyp/TdyNFtx3G7m+3PNN/svLDn9/JT8Jm1s5AVP5n4TPbvqP2utizAzaO9wOaoa5vETT
         Cn1QqqnWsDn47M/9inrurmEBdsQof/X+LrxHn24b2+PPaFebphkI/xwkPNXmC9VkENkD
         TIiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747678813; x=1748283613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bl3kloQIYExcBzmMs6Zl45FMSSUIPiZvGCce2ZtNaEM=;
        b=EA3xgytySl3bvNtgZmyKC98gzkPsPGXEhHciEUP8TsVm/3o4cUHvBE1eB8Rlo24LuQ
         qzptNcZA1OgFoovY42P2dxOlj88awrxwZsq40qHJmUKbzNyUigj/jwZGjPlZ5v+d+wes
         8Y2vuD0R6n4AE9uCpTOZqbpwoyPlGPow/04dZ9CuMlIHk1JPk2qHItxPfm4vYQssp/5U
         xF1mbstQK5TBL5HWXnV+d69uIEtFY26EjAtnIfXWo0AuDWiCO7jBnUGZqbTL9fwznxcA
         5c5i6zggJ4mODyPpF+SW2l57MFk0J8FNMOnpOIQg43TSlDDt/ddmXBF2EddbeC5LkIbs
         J6UA==
X-Forwarded-Encrypted: i=1; AJvYcCW0plONt5EkuImyXoxfZGe33msfEgI3Rx4C9nj4YQv69ORsZMjpmz1PWDuR9GDUDalbEmdq3usEdffHfp8J@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6lOTE7+tMRkeyCs/RllN51hfL0p/KasxxokQxlojiMKFsdut6
	vZHfFLu/i7Y10yHMe5G9xvgH096zDX8GZHoIVAABJU8oABIkmQ8mdGjNdAJgrw==
X-Gm-Gg: ASbGncsulurDdEPpogz+KjmbqqxbixxxcNCbVoQh2MPWskOFMplXjyDm3SBeTjO5tPs
	okvbyKRCSulKRAlciN25AHvsAUD3UUIPBPOER/QTuOpqycgaZeduuw5hNvo+RrTdUu0YuW0OQ22
	XPz2Qz7I3OsxM3Dva0V8uduBH8K1XOOlY0YcHXvWK5yNZ0RKO8vUu4zYIwd7CZWHqKQDXJEaI8W
	ddDjI/oqnKWZWOKVbzoVACY90BAs/KMGKsmbSjJ9GFMotA+wd+WWBhl6HiWkLYcjr74GIjLJ8bs
	OF9nJeQsm90wjz9X2DJwlz2DTsHUTeFyiXo6SwCdQHwdNR/UtPUgEwwg
X-Google-Smtp-Source: AGHT+IF/aWhHTiFGH3NWeaALb9RFMHehef5OM+EcfYiVjCmcJDeVl8ISJAJvdFboA6I61y9xgehFcQ==
X-Received: by 2002:a17:903:3d0f:b0:220:faa2:c911 with SMTP id d9443c01a7336-231d44e8833mr195512945ad.14.1747678812795;
        Mon, 19 May 2025 11:20:12 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([171.76.82.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ed4ec3sm63156245ad.233.2025.05.19.11.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 11:20:12 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	John Garry <john.g.garry@oracle.com>,
	djwong@kernel.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v1 3/5] ext4: Rename and document EXT4_EX_FILTER to EXT4_EX_QUERY_FILTER
Date: Mon, 19 May 2025 23:49:28 +0530
Message-ID: <51f05d0ba286372eb8693af95bd4b10194b53141.1747677758.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747677758.git.ritesh.list@gmail.com>
References: <cover.1747677758.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename EXT4_EX_FILTER to EXT4_EX_QUERY_FILTER to better describe its
purpose as a filter mask used specifically in ext4_map_query_blocks().
Add a comment explaining that this macro is used to filter flags needed
when querying the on-disk extent tree.

We will later use EXT4_EX_QUERY_FILTER mask to add another
EXT4_GET_BLOCKS_QUERY needed to lookup in on-disk extent tree.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/ext4.h  | 7 ++++++-
 fs/ext4/inode.c | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 201afaaa508a..c0489220d3c4 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -757,7 +757,12 @@ enum {
 #define EXT4_EX_NOCACHE				0x40000000
 #define EXT4_EX_FORCE_CACHE			0x20000000
 #define EXT4_EX_NOFAIL				0x10000000
-#define EXT4_EX_FILTER				0x70000000
+/*
+ * ext4_map_query_blocks() uses this filter mask to filter the flags needed to
+ * pass while lookup/querying of on disk extent tree.
+ */
+#define EXT4_EX_QUERY_FILTER	(EXT4_EX_NOCACHE | EXT4_EX_FORCE_CACHE |\
+				 EXT4_EX_NOFAIL)
 
 /*
  * Flags used by ext4_free_blocks
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 459ffc6af1d3..d662ff486a82 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -546,7 +546,7 @@ static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
 	unsigned int orig_mlen = map->m_len;
 	unsigned int query_flags = flags & EXT4_GET_BLOCKS_QUERY_LAST_IN_LEAF;
 
-	flags &= EXT4_EX_FILTER;
+	flags &= EXT4_EX_QUERY_FILTER;
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
 		retval = ext4_ext_map_blocks(handle, inode, map,
 					     flags | query_flags);
-- 
2.49.0


