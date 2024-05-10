Return-Path: <linux-fsdevel+bounces-19275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1258C23EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 13:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E6AA1C23773
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 11:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A421708B1;
	Fri, 10 May 2024 11:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7JmxddO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8E91708A8;
	Fri, 10 May 2024 11:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715341809; cv=none; b=SPkt4YBjgCChitNX5Y7ocKIwCz7MIW2+evrweN7OdbOdEqj3ZxyjxEBtSvWbe0H1vOQ/oBrwK+8KZ8Fi+9kEKzjw+sPZXV1ToWIC7Zw8fHFfW0gG2CQ6uIJLCZoa9aIFWGFKXjW7/rAFfXUUZW+81ZE5qaFI5nTSL7trcA9ujbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715341809; c=relaxed/simple;
	bh=ShAn5fhCYPl8qlhBHZU43ypZj6BFHQvlTb/1BJsqubw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TF/knX2Je4hkThBV+YMCux9npwXbwSaFYdSwRD0f7i7fC/VLXjDWdzL0Sm9rtkJtShpwp+TXDgDoqQ0p0wB4+6MMVXU496k5RkfW/3WCgn2vgoptcoRjw4Ixs7x9K53wTFBBp534TasdqqRLANFOHq8DQNpPGmMqTTQbJkU3bF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7JmxddO; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1ee5235f5c9so16379115ad.2;
        Fri, 10 May 2024 04:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715341807; x=1715946607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T/Y01wUoc8GqRpvXAplln3XTaKFYbBI0hlcfHL66MPg=;
        b=Z7JmxddOeFmyIqyuuUHxZWbKUBhPVsXdz7rrc/DQO+hWvucrWFEHiiaqMoyIdVkjV/
         wE74Y6IrgmWARCErVqGjN6F7jEEnAAqU0yf2j2HVyLpJCnIJ9gB3X9UwIyt0YUSN2nXo
         XNU2TrBvmchACbrP5XPeQpj483FON6xMVm/Xosuk4HXM2XjpMf3fR5TxSHCvdjNgoqsc
         Sbbs2lmyy6bZU6PUN85/YwNBoWVuoan1TiuBnMXo1WJqKVZT/sqGEQEQlfAHNTkXlYAA
         IenA9jUydjU/lo42kqtmXC2Z1zM0Pu4VcJzFYRMPTENlwHCGgPCVbtY7wbSZIcvdup6h
         WB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715341807; x=1715946607;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T/Y01wUoc8GqRpvXAplln3XTaKFYbBI0hlcfHL66MPg=;
        b=hT3g/y4hGKP67CRcyt9XaGVPILddiI3SpcTEwKlm88HzlredXd73d0oy5FtXjYLyt3
         tdny78vw9ChAcRHefP7au1l2XT2AWfYZi5aq7Eaa1qzD4CDDlC7yTmld5CjakEkM+Qau
         44FG3m0aZ7YSVxcf7GJe4TBkBWiksGxMYLr9K2M3K3wTNfMPUnGi4vcDTAsy4cEC+tYh
         5ob7FzEPF0EU4ptvIRilNDQNHEiELR/naRRlR+Hka+1yp2OylmnxkgGTJUDiL2xALENz
         /JH8UHxxK2OHQK28kJCMXSruZ+sxhOyTWSin7t+g1vV7QN6iWgX8Gk6/fBW1JgIs2+Aa
         4R2g==
X-Forwarded-Encrypted: i=1; AJvYcCVUbaodkwUxyOMDpVdgcQtL59/DkrCCLqa9XKRao1KUIjCL1oVH65xixHf4P2RZYLZj7ZdC0yBd7cU3aSSeJSvutlLa7DqxSv81hzQreKSuSv9KDAHD0pF8WyYQUhT5gO4/u6KAeAQL191vuUzs5lsVmiDge0TD3Eu7ULm9Vbb9CIoE6GRMfA==
X-Gm-Message-State: AOJu0YzPJtL+srdFM6SZLsPAbx5mY/FBFnnQ2OFlVjT36hc1H3w4aa99
	89MCn5ezKTWw/xRaDvHesmCFZW+e8VHyVkm3bccij56IHHFXJCiT
X-Google-Smtp-Source: AGHT+IFzfIkLucPk4sXxl+wOh9wZthAGLSllywtwnMpoejVUjDeq2V0rnDLW1ag2irzlv9JXvgqNKA==
X-Received: by 2002:a17:902:8307:b0:1e7:b7ea:2d61 with SMTP id d9443c01a7336-1ef43e26bc4mr20776495ad.37.1715341807566;
        Fri, 10 May 2024 04:50:07 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c134155sm30183825ad.231.2024.05.10.04.50.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 May 2024 04:50:07 -0700 (PDT)
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
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v5 04/12] NFS: remove nfs_page_lengthg and usage of page_index
Date: Fri, 10 May 2024 19:47:39 +0800
Message-ID: <20240510114747.21548-5-ryncsn@gmail.com>
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

This function is no longer used after
commit 4fa7a717b432 ("NFS: Fix up nfs_vm_page_mkwrite() for folios"),
all users have been converted to use folio instead, just delete it to
remove usage of page_index.

Signed-off-by: Kairui Song <kasong@tencent.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
---
 fs/nfs/internal.h | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 06253695fe53..deac98dce6ac 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -790,25 +790,6 @@ static inline void nfs_folio_mark_unstable(struct folio *folio,
 	}
 }
 
-/*
- * Determine the number of bytes of data the page contains
- */
-static inline
-unsigned int nfs_page_length(struct page *page)
-{
-	loff_t i_size = i_size_read(page_file_mapping(page)->host);
-
-	if (i_size > 0) {
-		pgoff_t index = page_index(page);
-		pgoff_t end_index = (i_size - 1) >> PAGE_SHIFT;
-		if (index < end_index)
-			return PAGE_SIZE;
-		if (index == end_index)
-			return ((i_size - 1) & ~PAGE_MASK) + 1;
-	}
-	return 0;
-}
-
 /*
  * Determine the number of bytes of data the page contains
  */
-- 
2.45.0


