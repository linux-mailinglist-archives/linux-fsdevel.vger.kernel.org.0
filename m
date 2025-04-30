Return-Path: <linux-fsdevel+bounces-47739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B71AA5365
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 20:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0AD81BA129B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 18:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861BE276049;
	Wed, 30 Apr 2025 18:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDRoUlFl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB06270578;
	Wed, 30 Apr 2025 18:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746036669; cv=none; b=HsHzvYbNsPT/m267O4rqO9oBlSmEIU4C5kkGIWyhtjzXuQss7CqbzKrssQW6YePIznvO+XVlNHHWUzuGCmjAvc6VoZjjTtFtXq0sXX7qij3g3Y81eHaLkXbRAsb7nfTHinjvEdYnAgU+S6FXGwW0vXZ938ocayBBCeCoGMLl3iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746036669; c=relaxed/simple;
	bh=uKkWq78XfYV8C1wGjeLxUClR6JZktKdqmRzCLRPiniM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=beY816YOwo2dS9A2YUT4EqWVHfNZqyL0CrbuUNVVHxwz60WQXPOWNgfLtQRcelnxPtaPg7FZ+lYI+3SvOf3So4I+7TDHIYhKvJTPBTxV/nJFdlRsGH3DsxJQphLkWH7JJvvpdKdlKKaDOt6FbfCd3xV5xQikHDqekv7BbHeR1is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDRoUlFl; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-73bf1cef6ceso280641b3a.0;
        Wed, 30 Apr 2025 11:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746036667; x=1746641467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rWrdBEdzmL3R/kfX7rqlGT9fsre+XXLU7YQDNncr/vk=;
        b=LDRoUlFlQPkVRrLEixPf8YnIJbnSTGunj5E9QMx5Ns3tbwn/gUmSBxynpVp5yEVwvE
         zhobKS63DUh31l0LwTzWiWueAi0eF+UkJtFJ1Un2YkTy3PROmtMBdJVX5Dxprnwt9Oj5
         A1X9swcuukrcpk+RlgYKXr9I8GxK/+Xj1oGQc7amNj7S6ijhWRgaqwaVL2uWkcAgfJd/
         ha2MJG7m2tRjN+EykqXHLF0pNoWg3iRMWXGYYrkneK9St8F5ZgeEuPEK94U7GhI8vZmt
         H45xUZVXIfHkOOmCczYj1RsHswL8rTr0cR9J+Zx+dhKrj5Wmm+65P8CDZrfGebYo8EI/
         6cGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746036667; x=1746641467;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rWrdBEdzmL3R/kfX7rqlGT9fsre+XXLU7YQDNncr/vk=;
        b=I4QZkPYO8fPWBpoKVyAWArmBLWdeU9XSBmrMJPMCShOWL4ROMF4LmjBVzseazN0yFH
         CIrQ+zKV5AbAIxTI9sM/+qxjFfuB6UDwpSmvejyRxHq//IoEUOYQI0UHb8X8BvXoQmsX
         Ab9wL0ZyoWbmpmUdo5Yr2JNrg2qTHw5p0XYl8WUPadXicRfFHlDbzHp/L+ooQeAnrLQL
         ci+Qecg4nWsb4/xOWB54PMGYZ4+rApCznXzxbWR2Q9E2cjKL5p/Jrgro88FMx0Kgl6WT
         P9ac2MRenVvnb4/gPgCC71DaakD4MAD0z68JmsOMpXqCkFjkW8WheRZ+mb3O3KqZgrRI
         T3vQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5oa7+3bWuxgz/5YjXdbPKLRn2taRzzeWBKay3rqIINKgLNqMjm73zlEKXR9ZztR9oU0hu3+EFxFJA3viH@vger.kernel.org, AJvYcCVtiU53SwwwnHPF5HAaVeikFAZf4c97r+ym6NvkHcYsFJRVUxsVNKsChig2QrSDql/ZFRf127DnQWt4TyTq@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+GLF6pEcB6wFUocYo2GZxJYvkGdaPEGgsORQM9fj6wuWL0BJH
	ncxkD4XITEqxpq1NHSDxdEzp+SsvYCSRXZAlcExUwvcqbsXTY8UK
X-Gm-Gg: ASbGnctSa0AaXdtbF6cyDNG/hCeCtvmGSllxPQj7x5NNwUbKxE+yMyGiXJeEyhCpBCe
	siwd77l9G1kGYhjVYZ1WEUwIxvPAjmRXYisBxTxR84BGmffTfPIeUviOL7NI2zRaN+tzSn2jwcG
	vh4Dwnt7cIGxL0PWfUbUGfdCg7aKb7PrKV5oNOpDSMceYoQeNJRAufH1XdMeRLg8n8gcTU8zv2d
	CaPJ3wQkP87ijDYcYMtVMYpQsKFY1pB8kS5XUSHFIorU1wzTlvpgh9ZlkryZlDV1OOuWMDpJ6Pq
	mO1w+0q080ZNPO4TiiYE0oi9ap4yRudDR7HvdGd4qby9T4jzztm9x6GAdnx4Kg==
X-Google-Smtp-Source: AGHT+IF9cU95gPYlg/+BueaWtgjVYu+duwRSmPeVQaR4peuDgpv89pIl+iXc0sQ4jiHvcfNXy2gTMg==
X-Received: by 2002:a05:6a00:4651:b0:736:9f20:a175 with SMTP id d2e1a72fcca58-7403a75be24mr5326968b3a.2.1746036667491;
        Wed, 30 Apr 2025 11:11:07 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([106.37.122.198])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039947976sm1983822b3a.84.2025.04.30.11.11.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Apr 2025 11:11:06 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Chris Li <chrisl@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 1/6] fuse: drop usage of folio_index
Date: Thu,  1 May 2025 02:10:47 +0800
Message-ID: <20250430181052.55698-2-ryncsn@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430181052.55698-1-ryncsn@gmail.com>
References: <20250430181052.55698-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

folio_index is only needed for mixed usage of page cache and swap
cache, for pure page cache usage, the caller can just use
folio->index instead.

It can't be a swap cache folio here.  Swap mapping may only call into fs
through `swap_rw` but fuse does not use that method for SWAP.

Signed-off-by: Kairui Song <kasong@tencent.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/fuse/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 754378dd9f71..6f19a4daa559 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -487,7 +487,7 @@ static inline bool fuse_folio_is_writeback(struct inode *inode,
 					   struct folio *folio)
 {
 	pgoff_t last = folio_next_index(folio) - 1;
-	return fuse_range_is_writeback(inode, folio_index(folio), last);
+	return fuse_range_is_writeback(inode, folio->index, last);
 }
 
 static void fuse_wait_on_folio_writeback(struct inode *inode,
@@ -2349,7 +2349,7 @@ static bool fuse_writepage_need_send(struct fuse_conn *fc, struct folio *folio,
 		return true;
 
 	/* Discontinuity */
-	if (data->orig_folios[ap->num_folios - 1]->index + 1 != folio_index(folio))
+	if (data->orig_folios[ap->num_folios - 1]->index + 1 != folio->index)
 		return true;
 
 	/* Need to grow the pages array?  If so, did the expansion fail? */
-- 
2.49.0


