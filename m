Return-Path: <linux-fsdevel+bounces-17528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B28F8AF4E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 19:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B598D1F2392C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 17:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C59813DDC6;
	Tue, 23 Apr 2024 17:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZykjQRt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C0713D635;
	Tue, 23 Apr 2024 17:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891838; cv=none; b=ZgdSY2bMJy5Ej6YOPEwMsqR3mZ3DOzMSZlaAhY2nb5pSzx6Bf9CGSjmp05ifo3iD2qeSUVTghvsgckWBawzRoid725HE6fbgj0z95pC8Fe9EKdYvDHY2QMnQrIA8dvTXHrJmN+FNEw9xJIW/qIYBipjxvdglTcwQK9x1ajJ/EDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891838; c=relaxed/simple;
	bh=pMXBuRSYRvxJ/Pm5/D0Ih9VGkrkcDFfmsJy8ADz5Yxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tALBB1kQ3qA6ZHOi/6cPi9ds7dR8pqTYB1gftb2HXxLY2VZ6ykQRN9FugPjVE7F4qC8NHI5nW5nptKV3XgMtlZF95wEoNEFNTr+t5yFK+Dnt7ct5O8xva/1HKmBMDGdWNXDjLn8isz38Wtrjon/B7TUydwLyPjPasJEQkHDq/cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZykjQRt; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2a559928f46so3877789a91.0;
        Tue, 23 Apr 2024 10:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713891836; x=1714496636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BixicrujN2w/NN7W8Yk1bOtYDD16jf87ysiCrI+mjZw=;
        b=jZykjQRtlxsp8nD4pOJ5uzQhDja3LTfe9CXKa8lo7w/ZlAUf7TJrOBMK+9wuogOR1B
         SuyZYseHTkKj6qwJ6auL0Uyz0axVqqpWVwg4LZGNWkhVT/n52E2ux8PBgLlqYpmyBA05
         Cg8Q6IFDt3xW1hkUDarpp6xystB9/4W9A2OB4sj+mDckPcIX8BqfuEQ2lJ0YODLSrKL0
         9M+iEvn1TqSD75CgrQC2bHwnQWBI2aB2e5qfgd5Kg/2WErQJfqiWnXUaATIoh6a62P2/
         q5vWLTHxrrLlhMt/RDrWPjSSk1LvjDCLLWD7my4IhCarwOXpOOvJMDRussGKYQENBm2c
         oqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713891836; x=1714496636;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BixicrujN2w/NN7W8Yk1bOtYDD16jf87ysiCrI+mjZw=;
        b=NFc48+q07nvxQI/nNZxeHmlp4TZUhaDhIyX2tMUDBoPpBoNPeULccPApPYdPPyx/XH
         DXxnj/+RszA0NjX/CpEhGKfWh0xERdlpt0mAuf4Lh24+GWcSdHTMfYq5Js1IxQTPlyc8
         3pJDBvwKk5FQ8ZHVAXFKHMHFfBNS3AJdeQpK8TDNfPaa72b6VyarwOq9bGyutlIVphXe
         Sn4Iw8J6LbFUAULUVCwocp1PX30+bNNKOtZiE21qJiJjhxVk85fa5yWiwBl0ZYYFAzJb
         EHZgDa1XoHFyKLsf+tiN+Sq4yfkloNvGp6XF0cQDwLgwsmw/Rjn5+3zMONNei7n2QqWx
         U/bA==
X-Forwarded-Encrypted: i=1; AJvYcCWWYXrGV6gqEvqvggbN0U+gYOyFCJaYcMf3rfSxjbJcNHF+9ozSYg5PPqtP49BZlB7AT6tgQzk1JpO9o5bMARckq7ZDKt7Cpq0JACD736u6+yHYZq6okokNdBHbWYZiXAQFHVWy7GKDdN2hgYgUBwdriJmy1+qQEmFTEecj6aCg+YhYqlHeHA==
X-Gm-Message-State: AOJu0YyJBSfaeO7F9e65v0ZNCCBv/vWdYjO9LE1AaiRcpnz+jyja3R/m
	/LMRvYHbV1+UgG1Wu0slK0EjJP0Er4mt+95061mUyNlmOHpfNEyP
X-Google-Smtp-Source: AGHT+IEZ4GKNo+ZGTgIioZ6E8Q2/FLCJDMv5q/lYaYPH5b0i9NhmaYmcUV6iKdtOBuu19Rf+VfV0Ww==
X-Received: by 2002:a17:90b:1205:b0:2ad:c098:ebca with SMTP id gl5-20020a17090b120500b002adc098ebcamr7093107pjb.20.1713891835397;
        Tue, 23 Apr 2024 10:03:55 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([1.203.116.31])
        by smtp.gmail.com with ESMTPSA id s19-20020a17090a881300b002a5d684a6a7sm9641148pjn.10.2024.04.23.10.03.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Apr 2024 10:03:54 -0700 (PDT)
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
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/8] NFS: remove nfs_page_lengthg and usage of page_index
Date: Wed, 24 Apr 2024 01:03:32 +0800
Message-ID: <20240423170339.54131-2-ryncsn@gmail.com>
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
2.44.0


