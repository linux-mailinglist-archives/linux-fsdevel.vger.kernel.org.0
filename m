Return-Path: <linux-fsdevel+bounces-18483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0627E8B96C3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 10:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386EE1C20E42
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 08:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDDE5647F;
	Thu,  2 May 2024 08:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/yVBxpZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0C856473;
	Thu,  2 May 2024 08:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714639657; cv=none; b=EartS9+vOfa0SRT0Lv812r1W88WsBc+L3GnuQ55lGrRvA7GU5pA65d+m8j1FxdwJe4FGGNeZw8HY/9dRNSo9n72bHP8udma4NDF31Zzdsh95pI64lXbbU5mCAmAUB6dfaZl/4dLxiKeppTwGbS0dMGaxA88ATnRTrbQGS4Qaq+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714639657; c=relaxed/simple;
	bh=bkTdiJFGGBlH6tCXYVyOUBzvEQj2B5ZrCO6Nvtf8Xr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=De8TYzw0VW4mi8nQdSP6bsh74RlHEL7UfXBD5MfR6SPnDZFxMY4lujscmHuPxmzPZQrr2xMOyJ2RHQM8w47JgG65rBKvzgeoE8B/C0C6DPAT+D+EMnB7Q59H01HzcVp0h3+2OLGPuIMkUCkMElcR5qRjCs3HiaSF3/OvQNZn2b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/yVBxpZ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f043f9e6d7so7708938b3a.3;
        Thu, 02 May 2024 01:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714639655; x=1715244455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7PiwJE9uQmN0uws0CC+HD/WsVJUPjjolITxGR0eGWdQ=;
        b=F/yVBxpZ4T1Q4ixwkoam34Gu8hCs1p0qhakVU/6VYvrTN7Zv/QGHwTUKOmhqOMn+tN
         XlE16OXT9GNOyWrokzC87sql6BwdedyRa4odWdZ4tQAND+NdvbTu5k2uKsXgOuhu9fUe
         HE29h/+DNGjuaGTCnhC9Iq4eD8dM9gzPYZRZTQs7ybPTyZ4Ghnqzr+tl1eZI+q5d3JYc
         M5YOY2q1tthWFG8yhWXSRafGlDCeZln7c7U9eOR+3h602owO+3sXNXmw8pJndxaO/NDg
         yX9rJ0jfeD0anboCyEiGlAqMTuVffgcWDtXq43vMIMIjFPZFeGJL41r+qygFPtcZCGy8
         kdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714639655; x=1715244455;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7PiwJE9uQmN0uws0CC+HD/WsVJUPjjolITxGR0eGWdQ=;
        b=aAwMfiy8piUokLj8s7mC5Q3bjbK+WXj8O7QQbsd0wVs5fh9ByyhuNGg39oXpkot03X
         CXNIdVtG17SRhwnvyHC8hOcrc2WGEwK/BDu9ogDFCyZ0+cs3cGWwbfoVDqTAewT2SFxo
         cPJ7wLVsSxdf/+d83/JIa6jVM/87fvlIKGjc+TIdbuUkYxwrYpRZ9T7ULChPz2WRmNqW
         PpnymdfrGjc5GpJ8BY4VUkF8Jl5Dp7mG6fVOJEtr8v7kiKAbpBSg0iutrYYuAd/SoMo+
         FRO07LoZPQll2AXiuVgNBo0m5Kia21FGS1f5R8bjFpW2ajqDLYTxB6p0d+f1qbCeRQig
         LukA==
X-Forwarded-Encrypted: i=1; AJvYcCWlIhJ4NcWF3m9I9G56Z2EaBnod1Dr2bd96GCp27Aq5Ipn/1rnWj8+eDA+MtmjUkDtswtasd/1gdGm104OWD7YjHugNRRCwozdM4utwDyDTGDrop2ZBLso9cHcWvaeOr8wlSeTT+A6Ci+1h7g==
X-Gm-Message-State: AOJu0Yx1UiNEQkA8C/Ko7ka+RioA3ayjgXcIP6u4w7BzVvcH1O8CaZiZ
	ZfdD7G9Bf8I92m5WVvfImZar6AnFpIPTogopnVECt0G/nTXMAM9D
X-Google-Smtp-Source: AGHT+IH8n+nmsJYFVIZGJmzndILHRpj0aN5unHTTwojRKIiOB2rktCNSIBo9mSCnI2OwpCiqNtBByg==
X-Received: by 2002:a05:6a21:7883:b0:1a9:d9bb:acdc with SMTP id bf3-20020a056a21788300b001a9d9bbacdcmr5924624pzc.28.1714639655088;
        Thu, 02 May 2024 01:47:35 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([1.203.116.31])
        by smtp.gmail.com with ESMTPSA id q6-20020a17090a938600b002b273cbbdf1sm686805pjo.49.2024.05.02.01.47.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 May 2024 01:47:34 -0700 (PDT)
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
	Steve French <stfrench@microsoft.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Bharath SM <bharathsm@microsoft.com>
Subject: [PATCH v4 05/12] cifs: drop usage of page_file_offset
Date: Thu,  2 May 2024 16:46:02 +0800
Message-ID: <20240502084609.28376-6-ryncsn@gmail.com>
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

page_file_offset is only needed for mixed usage of page cache and
swap cache, for pure page cache usage, the caller can just use
page_offset instead.

It can't be a swap cache page here, so just drop it and convert it to
use folio.

Signed-off-by: Kairui Song <kasong@tencent.com>
Cc: Steve French <stfrench@microsoft.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: Paulo Alcantara <pc@manguebit.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Bharath SM <bharathsm@microsoft.com>
---
 fs/smb/client/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 9be37d0fe724..388343b0fceb 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -4828,7 +4828,7 @@ static int cifs_readpage_worker(struct file *file, struct page *page,
 static int cifs_read_folio(struct file *file, struct folio *folio)
 {
 	struct page *page = &folio->page;
-	loff_t offset = page_file_offset(page);
+	loff_t offset = folio_pos(folio);
 	int rc = -EACCES;
 	unsigned int xid;
 
-- 
2.44.0


