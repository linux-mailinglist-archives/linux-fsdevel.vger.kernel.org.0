Return-Path: <linux-fsdevel+bounces-19274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B8C8C23EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 13:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFA4C1F21C0A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 11:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7E717085C;
	Fri, 10 May 2024 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaGM2Fto"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA9A170849;
	Fri, 10 May 2024 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715341805; cv=none; b=A9eU0YossiSObRR+r2q4lThDkZd0hEvQd86szCKhTCz55o5n2f64ymiIf2cTSpD0FIQiTVqAHpTf3JN91yF2VNJKpvCmw6+J7H9dQdJhr+QALyLubKIut3at3FV9I8k2YZD/bikR5p9qzY1kgCPM4EQIIVu7+FV8m0gEYYqqmnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715341805; c=relaxed/simple;
	bh=4l5Ap/GQGcYF0sHhsyCYu2fRIWgnQn2r2DT/zqLBNUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBJR51I7sGtU5HaxxpbCh64fWcodZ3yW3tY0xuwFsKudebHkwlwQIco+xmud8cvVsMq0+F7mxKnLSEfqYMSMRemK68fcpjnfMh6ooptmk6/TH6a8np9yXfSQcIoYba14HLN7hSqAVxPc3+fndaa9cujYdx6iM5bcbSVtuicIfyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FaGM2Fto; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6edc61d0ff6so1692283b3a.2;
        Fri, 10 May 2024 04:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715341803; x=1715946603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7WZK1EC9ikQfyuHFTfKb94AiIKSPD5K2lma7no+Kt3Y=;
        b=FaGM2FtoNu1aXaqPgls9vgfcmriY7CifDQP5C/9J9eI2Oup2Am4RnXz3AxoFsleeIO
         bA49p1B1lczIJuVn2a/rwHkO5rA+qSzmTlYzx43CC9SHo5YNQVqm1Np8MOMetbw+Y9BI
         /8av+/8JVsmGlqoDFeYTTUPnBzHlnbvG1BsXySqUkrpRUCHJcUaADjfJsBiR8+MVLddL
         d3AxRdFEbC76JtuSxJ4T0LxFCeZR0z/ISVYKikxq5p1UG30Po3RV9zLe9c/8suWoNohd
         F7qkHOWJkXadnfr6Yn2F+1EJMBWWfho4bhvvto4qtaCNCSwOq5L68ng0A+yrSfIrOU2s
         uvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715341803; x=1715946603;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7WZK1EC9ikQfyuHFTfKb94AiIKSPD5K2lma7no+Kt3Y=;
        b=WYRN7XDt4rRkZyLoAdZMjA4u9uACCQU52s9MT36B2vaaVZiWW22ng1N6mBmXy09Lbu
         lkzNTZHm7VOaFGC6PzyHBZFbDKjr5EgWWu2qAlxJdXFPhLqBSUR0UWd68KN6nVThshEg
         GzW/8V/lYHA+8jGjtTYeHkPSbt786I+QzKGQzmqDzvrqVaAvrxm1ySFVnnsBKdYeos36
         PYRJUq7vJ2KDHWqfRDUHKN6su3dlD6BY1mLPFV+/9fzFwke6/0T17oI/Py7Zj1jJsStH
         JNkdvtOaDrV6iqdtyDaaXagvwrtwMvTPi+bme3VUFBW4tFD0ngy51UVVoW46dzcH4zwf
         isrA==
X-Forwarded-Encrypted: i=1; AJvYcCWfyZAr41Ye8HoAwFPik1qEllQht963t6R2w7QRNXnZofz8jv4AiYYVsG731hq2GZkX2d6ulmVBkRMXtKXHT579LdsdWwyr1N86kWlnNte8EM9+gUYBu7OkXRH+1P4Q/Sw2oI0wJFqPMv3itSqy+AEyRCI7/3dPAULJGqrWEFBRWuq8MWMAs4I=
X-Gm-Message-State: AOJu0YwgUEurn5hwnaEuk2sNQGIQDUGOn+lxd2GSg6UILIMi1QGhrQtL
	yxXl8BgdVpLBhNZE4YgXRvanWfxWOmhfs0vhJXIzCbUIdA5dKi5H
X-Google-Smtp-Source: AGHT+IGzJePUE/u2//e0nGqK25e74fSzzO7KZJDptjk5/1bik27/+5woaxZ+Rq3FhnwvPq89SZQajQ==
X-Received: by 2002:a05:6a21:339f:b0:1af:dbe7:ccbe with SMTP id adf61e73a8af0-1afde103d87mr3133457637.28.1715341803002;
        Fri, 10 May 2024 04:50:03 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c134155sm30183825ad.231.2024.05.10.04.49.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 May 2024 04:50:02 -0700 (PDT)
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
	Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	ceph-devel@vger.kernel.org
Subject: [PATCH v5 03/12] ceph: drop usage of page_index
Date: Fri, 10 May 2024 19:47:38 +0800
Message-ID: <20240510114747.21548-4-ryncsn@gmail.com>
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
2.45.0


