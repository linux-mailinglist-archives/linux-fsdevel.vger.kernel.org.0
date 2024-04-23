Return-Path: <linux-fsdevel+bounces-17531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA73C8AF4EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 19:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC771F2389C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 17:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96B113FD61;
	Tue, 23 Apr 2024 17:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hssLaR8M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD1013DBBD;
	Tue, 23 Apr 2024 17:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713891852; cv=none; b=ee2TKrxYujMYhuYqVs6ccpbYvzispaz8hLmQ48ev/O3jMSBmoCO1Z81IiJ8aNk5B8St3cvIV27S7FuCzeg+eTyc1FCf5vO8jqQXAXQaGkvyEsWAP5pn48IQaTn2octElxjIoHsfiXu46tm78rNUirvnrmMR9X8C4yjTC81gn/Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713891852; c=relaxed/simple;
	bh=gNeowpHLn3XanGMjOPlcSsZZHe5AP0lM6lADWQVCs4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUJbxRKusAwoHyeNKNoTj9zr4z5MO6LLOW5dXZ1HQ04nnvv3F9JtxrPtrSWb9K3w3Q+o8lpPj5BSE1MDmg48Yjdw4BotGlJkYTfOIRtcNHcf8AhQ7mE7SGtR3Ot30NykAZzSQu3bvzN4c/8NCuWfYX5ji+2HVyuhDctK+RjI1XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hssLaR8M; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2a528e7f2b6so4175372a91.0;
        Tue, 23 Apr 2024 10:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713891849; x=1714496649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5+IkB3+J9K42d+V5Wi+AdhWpwnXMtEpYhZXm/5fw+dM=;
        b=hssLaR8M2lcyrOpNUFlmgrj2Y1T5SXrRUj1lifpeOb+bkPn5xghGzVuGTD0fcwFw/C
         unEJ27qIxjTra/3Yq4pIlQq0KOj7GOdTeQTHlfzoLmaw0cq1RfaENtJuMSa8Ylxeib3m
         N/651MyY4GhWYmnbq/KzY5S9EUeiIpNQ0S+Z917obAvPFZ+zzczLtH8fA7Oyw5q636UB
         fzVk997y+XC14gNlnQDn0O8AEksrF0Twtd5h7JVclZWQZky7KR39XWMyjLYZlT5hYCB0
         ANm5XYqs336VFDPVV6n/bdiNVZt8os+DjX2m5xLurp5VERemGO4BXKii4NkIFZsrSRcq
         LjFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713891849; x=1714496649;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5+IkB3+J9K42d+V5Wi+AdhWpwnXMtEpYhZXm/5fw+dM=;
        b=n3Xz/dpmak/UPdzX3OBml2IqWyoXZVOnhnLNv/yOJE9RJouqJXnVtc3yxCBS0Rrjah
         mZU1V0uNDdbREPmjgpf9HPvivsYpXxZZhIYruh+/ZLDPtljWVpsQkJEhz/CZRUcUtQ9D
         WnFxaMYGS49PNlvhfkq1kzFVBfVhT24jJJ9hmeUYTJL1vA4PIAHnJQKBepnDPrdlKGRI
         DR2UGhl4FD56oauDfFCHvR0V5YFDW8V3aaJL8vGVbGHPxF6PfjBLfyDNqVRZdcgh58ED
         8hEir4weJ7IqakGwR85vD073QK0ovDC4+lid4amx9/ffb32KTQ7mmJDEfU9G4u89UCP5
         N4kw==
X-Forwarded-Encrypted: i=1; AJvYcCXZMGJVDmXK6Kbcs7ht7RgFAcux9fBEfZRkC6PT4KwxvzzeGR/2fTNKoTMgO+xW0wFBt5ATrkp/Rzl6OAWV9k2BqCJfKz5DJpica/yRqSxOmc4WF4+ZwKoqzMTGaYq2TyreGPFhrODa1aKyDm7+Ylrosz+heG9a9BOlJJ0r8AQyUsISEuP8NvM=
X-Gm-Message-State: AOJu0YyZtYEy1AAdgeB5uPALHWiptbSB4lsVLLwDLt3YBf9WwJzFgi6D
	pkl0Dk/+TCGRSfby7SJ2juQue2TrLHW2XG8agkUjp6XFEbJBUGsV
X-Google-Smtp-Source: AGHT+IGWT+ho4KjjKYkt4pXE9QMNwfjSrpJN8MJZvcmr2D9GT4W4gI0wGDBUlpVmvv4mlpFse7FLPw==
X-Received: by 2002:a17:90a:cc0c:b0:2a5:d979:8eb2 with SMTP id b12-20020a17090acc0c00b002a5d9798eb2mr10816827pju.19.1713891849092;
        Tue, 23 Apr 2024 10:04:09 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([1.203.116.31])
        by smtp.gmail.com with ESMTPSA id s19-20020a17090a881300b002a5d684a6a7sm9641148pjn.10.2024.04.23.10.04.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Apr 2024 10:04:08 -0700 (PDT)
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
	Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	ceph-devel@vger.kernel.org
Subject: [PATCH v2 4/8] ceph: drop usage of page_index
Date: Wed, 24 Apr 2024 01:03:35 +0800
Message-ID: <20240423170339.54131-5-ryncsn@gmail.com>
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

page_index is needed for mixed usage of page cache and swap cache,
for pure page cache usage, the caller can just use page->index instead.

It can't be a swap cache page here, so just drop it.

Signed-off-by: Kairui Song <kasong@tencent.com>
Cc: Xiubo Li <xiubli@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: ceph-devel@vger.kernel.org
---
 fs/ceph/dir.c   | 2 +-
 fs/ceph/inode.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 0e9f56eaba1e..570a9d634cc5 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -141,7 +141,7 @@ __dcache_find_get_entry(struct dentry *parent, u64 idx,
 	if (ptr_pos >= i_size_read(dir))
 		return NULL;
 
-	if (!cache_ctl->page || ptr_pgoff != page_index(cache_ctl->page)) {
+	if (!cache_ctl->page || ptr_pgoff != cache_ctl->page->index) {
 		ceph_readdir_cache_release(cache_ctl);
 		cache_ctl->page = find_lock_page(&dir->i_data, ptr_pgoff);
 		if (!cache_ctl->page) {
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 7b2e77517f23..1f92d3faaa6b 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1861,7 +1861,7 @@ static int fill_readdir_cache(struct inode *dir, struct dentry *dn,
 	unsigned idx = ctl->index % nsize;
 	pgoff_t pgoff = ctl->index / nsize;
 
-	if (!ctl->page || pgoff != page_index(ctl->page)) {
+	if (!ctl->page || pgoff != ctl->page->index) {
 		ceph_readdir_cache_release(ctl);
 		if (idx == 0)
 			ctl->page = grab_cache_page(&dir->i_data, pgoff);
-- 
2.44.0


