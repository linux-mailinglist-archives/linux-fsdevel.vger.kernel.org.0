Return-Path: <linux-fsdevel+bounces-18168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF288B619E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 21:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9734128215B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A4213C3FF;
	Mon, 29 Apr 2024 19:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfRkM0Bl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C7C13AA51;
	Mon, 29 Apr 2024 19:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714417622; cv=none; b=RpYYLpzwEbUa5xGktjWUSJ+iDBVp0ObYKdXTxysK4J8DD5oHYT7FMxraeH4wpMdGplvbZpF0FfTbEmvGuwdmosQwzweNZeih1B5HDCHdNExzlmgzZt2Aqz5fSVOWooKYPN+LEEgYpZ44WBr4arzFgIMmgB8WuU3P2wkU+ooiKNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714417622; c=relaxed/simple;
	bh=gNeowpHLn3XanGMjOPlcSsZZHe5AP0lM6lADWQVCs4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RNarrLQgut4/wEU8dV9SM/mkeKmmJaZnJrn4NKUMakU7uxYHf0u2uQqkq7XoGyxO62BLEF4K6zIgcQmTc95oySo8fj8d7goOd419krxJDcGz/s9x6oUjvv0jkQkbXPbJ+tJ1K+fpaEoVv6UzZHfQ8ZfxeGHV/JUTqsAlIhTLqvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfRkM0Bl; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ecff9df447so4772508b3a.1;
        Mon, 29 Apr 2024 12:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714417620; x=1715022420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5+IkB3+J9K42d+V5Wi+AdhWpwnXMtEpYhZXm/5fw+dM=;
        b=gfRkM0Bl2uYNacwxZWM/fH9gLepnhxSm3kE1PA30ZP7GsJBty2/mLX3R9fMk8zXcle
         lI9xvHoBCoeTmfOiXFyzkTmzkbCGzxK9dRGr3SFQwT2/V2JfcMchWxSRWD+pTIOl3ntB
         R3pwHZpQDRUx8QLtfQTffQMld4OQ01k8ijOyqutQKpuVeGwy9BS5xqW+0HQ5/isaSWS0
         0R90XWv1jakRvT6CIcVwVGvukOYOWvaBOEz0EcnV8PSq5ZiaA7zXFx4LC+utYa9SxuNn
         f8KZAtUSA/tdCUeywIif63DGVhfesg4wdN8qGs/JOosC2VQDsCXSzXz8jHoJkPrFoqFN
         FyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714417620; x=1715022420;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5+IkB3+J9K42d+V5Wi+AdhWpwnXMtEpYhZXm/5fw+dM=;
        b=Z8fUTN0YvUIO4ULIoZ2ba9hnmsStz+FXbimENhLFAHXOoBRqXZ3yrw9je+EZ/317pk
         BkKHR+6K0oEjuh3JRLXKEWBgfLaA5a2xF1ndE0JpEgSOTwzMP1HxYroXjc7TkIMYWnGy
         FnxPIU0Db2/y1HaWhn3kjD669QTEeVVlME4f27Xpyj2xAPa7TNMmQHgbp2fKiD9Xxo31
         2hrOnCBeKEVuOC4Hn7lwi5WQCln0EHtJ2VMtrM6uhPGzfIy2dr68HsbWATibxBtuboeq
         PUsfTwtjlhreGKOaXMVZAN3kPU+6Hzu3pHPZELBobNbF+N2bh18yXHoxaQhpbb2FbLcQ
         bYBA==
X-Forwarded-Encrypted: i=1; AJvYcCWjNaWfHl8858u4Bs/GPy8pcBEwmg4LJrRdrmsmjgmB/HKJk71kEmydoIUX5WnUcGVqDZTCTZBisO0n1yEn3bbNB/gw8O0pDmtxl8vd39VT4u/i4//YZGBn4xzWKlZAHiHvoOlPHAq0G828uUiwfXhLtJ9Dv1Ge60rWlxLGUUbOiTgfavf0Pwg=
X-Gm-Message-State: AOJu0YyV7DNvYYIZfaL20W9LJx4qZ8czh6V41qfZIKQ/sKXPd3t4t++a
	oFWLecRCrSHBDs2d6RB6z/p3mDGaDQW1AvD5hPCcSJjOGl6eNgZV
X-Google-Smtp-Source: AGHT+IGvkma+YPu9xzUecSUUsFD1l+4n7xw1LuJ9VLq1yA2mCnKc5mpq0XVMSd8n6uL8gi84MJzVXg==
X-Received: by 2002:a05:6a20:f393:b0:1ad:682d:55b3 with SMTP id qr19-20020a056a20f39300b001ad682d55b3mr555060pzb.3.1714417620501;
        Mon, 29 Apr 2024 12:07:00 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([1.203.116.31])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902864400b001e49428f313sm20619356plt.261.2024.04.29.12.06.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Apr 2024 12:07:00 -0700 (PDT)
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
Subject: [PATCH v3 03/12] ceph: drop usage of page_index
Date: Tue, 30 Apr 2024 03:04:51 +0800
Message-ID: <20240429190500.30979-4-ryncsn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429190500.30979-1-ryncsn@gmail.com>
References: <20240429190500.30979-1-ryncsn@gmail.com>
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


