Return-Path: <linux-fsdevel+bounces-18485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDF38B96C7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 10:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 568E0285C3E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 08:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1FB535DB;
	Thu,  2 May 2024 08:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vuvoz1Mi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01069535B7;
	Thu,  2 May 2024 08:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714639668; cv=none; b=r5AV6rUMMcZSU2gKsfC0D1tkMNRlxNoF4rjlL+qQfZY+D9WdXLp6idZroV7LQe0wyaQWhrT8CF3Z1WmqpECUZ6KDMIPjrbS1Q2afiVmQgposfoJbN77n8nS7fjyT1eL4RUqb4kjjwAi9TUgTwZszduvEM+nlq331VCAGubXa2ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714639668; c=relaxed/simple;
	bh=7wUERS10zASkjeML5DECo0InMoy+pGZDK8UElMVW8H4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ve4LagS/4AdjDI5L48hEa5GAI0+widojdPTiYH9Qd5KyzTz0Hjskev+gOlP4p9T7q5iE1UiU05bLHGuG/uVQrk69895jmFMqu6lnSAXJ8fswFOhUJpk7s+8xwIjEyPIs19K9Ap9tY/tP4irIV9ahJdwox9LJifh2DYGxFV+k5GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vuvoz1Mi; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-2ae913878b0so5745437a91.2;
        Thu, 02 May 2024 01:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714639666; x=1715244466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UP9GO2qb86H7nq2iI26LPAW8N+Z2bRcTv9KbrkM7mY8=;
        b=Vuvoz1Mi95c0Ee3Smu8CAdWhgkT3IpyGSn9+MqZry8VoxQnt9Bwmrf2tG2w+vslkJm
         6+NekY84YGEMf4nH7Mvb3FpzHDSqZaa0Bzy7L/JsAsQO/flA1Z3837Fgh5TwDzgPz/n1
         hKhpYlSFklEZIenVlGpO1bqdCauUMLdzCxfoK+nu0IUnBGO3xTjsWiIkCI20YIBH1hS8
         SvUcACo5dPMXNd2uMd9olYJwrR8M4W0DHxAqU/dX/oNQ4Rqv0QFhPZr6Rix2aOwhNvIi
         SvlFpyWqF19Ai62mUI/vChDJcAg7OIXTL4w/jIzr+zy8s9wFJdzJc8SUAlp9ckqaQ1uF
         ODxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714639666; x=1715244466;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UP9GO2qb86H7nq2iI26LPAW8N+Z2bRcTv9KbrkM7mY8=;
        b=aDhx57IlKg6dYhcC5lyLLlHVizhUv4WY7fEFBfi81y10xXE66qHWTDgJr0yKNMyYpS
         p6IDHuoRBwN5dD4mw9wJYsYEZrq1twTBhHaHDxIK09aBtpecmaFM51Papnqf3qTFDVx/
         YhPBRp6/sAtrcaf+H0KYgNbuvmWl+Sfes33HB7fO+cVMpf2AHhhvkJ3+dHivuC5qSQsk
         u1joW1O1W6bgdW/ue2sOGqAm4QNuv9GwICwUu8D2kKOkhh/h1SKSQnXUJuAEw5gWRhRR
         mjUrRh8xk0XuZBg8+7h+RZE3Hyq4u130AQYLIUHUj5G6QHAVTd27pY6uzt5wNTn4JZKe
         yrFw==
X-Forwarded-Encrypted: i=1; AJvYcCUzYYi2QqbiGTxczGoQ+BffZDsv2X/PwKPwY01+hbZ33ip+8AG7zII8GioQ39/bKw17oXo6WxwD94FhRHQPR0USW/jhKWdvWx38fVfpA/v1S7SqJQ6bJbOSEkaHCkV76cjIUy3eOUkxLwSxxA==
X-Gm-Message-State: AOJu0YwY4/kynzcmEB0ZCg9FPJIUqGqbW2lmr30MUspwS0u+vCBwey0k
	52RbRGidwAKse/OVeTTgL4SZ29/ySBKJDI2ZAwo1HhkDMi7QqDoJ
X-Google-Smtp-Source: AGHT+IGyyg1F0OUABpcZNF++9ikGsOK3Q2kFtyAm+9ixtgSVwbvUEaYTKBIULHXdrWlHyTAR46Kcsw==
X-Received: by 2002:a17:90b:2303:b0:2ab:f9af:cdce with SMTP id mt3-20020a17090b230300b002abf9afcdcemr4828016pjb.36.1714639666422;
        Thu, 02 May 2024 01:47:46 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([1.203.116.31])
        by smtp.gmail.com with ESMTPSA id q6-20020a17090a938600b002b273cbbdf1sm686805pjo.49.2024.05.02.01.47.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 May 2024 01:47:45 -0700 (PDT)
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
	Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev
Subject: [PATCH v4 07/12] netfs: drop usage of folio_file_pos
Date: Thu,  2 May 2024 16:46:04 +0800
Message-ID: <20240502084609.28376-8-ryncsn@gmail.com>
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
fs through swap_rw and that is not supported for netfs. So just drop
it and use folio_pos instead.

Signed-off-by: Kairui Song <kasong@tencent.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: netfs@lists.linux.dev
---
 fs/netfs/buffered_read.c  | 4 ++--
 fs/netfs/buffered_write.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
index 3298c29b5548..d3687d81229f 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -255,7 +255,7 @@ int netfs_read_folio(struct file *file, struct folio *folio)
 	_enter("%lx", folio->index);
 
 	rreq = netfs_alloc_request(mapping, file,
-				   folio_file_pos(folio), folio_size(folio),
+				   folio_pos(folio), folio_size(folio),
 				   NETFS_READPAGE);
 	if (IS_ERR(rreq)) {
 		ret = PTR_ERR(rreq);
@@ -454,7 +454,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 	}
 
 	rreq = netfs_alloc_request(mapping, file,
-				   folio_file_pos(folio), folio_size(folio),
+				   folio_pos(folio), folio_size(folio),
 				   NETFS_READ_FOR_WRITE);
 	if (IS_ERR(rreq)) {
 		ret = PTR_ERR(rreq);
diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 9a0d32e4b422..859a22a740c3 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -63,7 +63,7 @@ static enum netfs_how_to_modify netfs_how_to_modify(struct netfs_inode *ctx,
 						    bool maybe_trouble)
 {
 	struct netfs_folio *finfo = netfs_folio_info(folio);
-	loff_t pos = folio_file_pos(folio);
+	loff_t pos = folio_pos(folio);
 
 	_enter("");
 
-- 
2.44.0


