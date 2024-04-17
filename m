Return-Path: <linux-fsdevel+bounces-17163-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E55678A8882
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 18:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843C61F23E0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 16:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB22115D5CC;
	Wed, 17 Apr 2024 16:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CW65eJsw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CC7148821;
	Wed, 17 Apr 2024 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713370199; cv=none; b=p84QLicbpNi11nFo+15NPn06Ze+xf+yv7jSMfgExFqQsb2limxQNT77ZEkjwGLEAFsDboCC8HTXBlxNA4b9PZozvpiZPvFnGs1D0sx+8vDt/2vNMLBhJs9bj5kemSMn+sNESMJDGA0AupVw5K7p7CAL9PeL9gmEtRocfxCcymdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713370199; c=relaxed/simple;
	bh=gNeowpHLn3XanGMjOPlcSsZZHe5AP0lM6lADWQVCs4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JHqkusRoblLdQ4xi6f6MX9Rj5ugVY+5rJnzYUCC96sMvIuT6OGZEt0/zPrMyqQuvHVaiJQZtT0odYboUZ3PgoanBRlSnFhD/UwWJAeXs4cH4ctFPywItmZj0Kb4eIgAp5A02Nrv40env9J81UzqJsqd5OZykXk4RQZPco9SlUcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CW65eJsw; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ecf406551aso4776595b3a.2;
        Wed, 17 Apr 2024 09:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713370197; x=1713974997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5+IkB3+J9K42d+V5Wi+AdhWpwnXMtEpYhZXm/5fw+dM=;
        b=CW65eJswhXnaDYbGXb9KQc7uhrTdxxq81xyfc3OYHNAHG8RoikTuX/UPK9TAN7BlaR
         54spxgVRE0IuFkurhOuVKyy0dZ3LOnIBw4hhq88pRHGAjLCf2l9IBXjjvDq+HFpB8+Hr
         0sgJS2JLmBXzJzRr+qCgu7inn5mCCKjdwl6FdeRBS4vW5ZlgReliy8c+NkhbqTFqxgjv
         Zgl5nPJe4Q4qJXuldEMPxt1xeLNVLcZWfaoLGmrk5Mh34kd0cy6azaOTW64IU4VKVY5k
         pG2JcalVbJgT0te5ZCkjICjscFN0+G/a64CSMFPCksZNJajY8k+jicMy/L11f+Gh56ME
         8gaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713370197; x=1713974997;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5+IkB3+J9K42d+V5Wi+AdhWpwnXMtEpYhZXm/5fw+dM=;
        b=lEDo3+Je8eINE2SgUJAINFTsh7jeD03wbKupOIt4OEHfC/opjwBaEH+vesUzZVUd3M
         Ev5VXhw5IwRWCUaFm/T2mDgGjaFFfkPDKMizsNZKqTbSGMCrfY+SLpt2XKe/HDMKO0jn
         m091aEp+JXewElOrjWaSx8XkjjK/8W1meHDpF2RgMr/OzHEdvfMRiIuvz7yzNiCja4kC
         2oLzDu2la6OVmfs0oECDFOnouXZT3euvaZe5kKiZHrGp6V4CKAvsCNW8NQGceaOXyXfW
         +wN42Kf99FEXI397fqtRFdLTelLfrQs3UdvpM7yp/rBi2jY+poVzLmRPII/s/FwwYrW5
         lUBw==
X-Forwarded-Encrypted: i=1; AJvYcCXV96KOSvSNkBFfxAGDD4f8GIjl6lVivoZj2z+PEdHCEymNg7TwslJMZ2T/BPI+GBGiSjxDwLIwZ7Oo88zCUimQ378ppNcC2ijAgKzhv9LN2VvEBx4GXbVHlGqmgFokvd8/UwVJQ9xZF/dJgtChQ8Shik69zxfS/eb7sSaH8VLkeMDynGH0uWM=
X-Gm-Message-State: AOJu0YwVmTIOi0tc/0MpQcxghLb6Vr0YMKqSA0uQZqhq8mdkUyFu857i
	Y2y7VXWbHzNgCgDuvEd3nEQ9W8ImzsDEB4uaR8EFU/5GXEcAcuAa
X-Google-Smtp-Source: AGHT+IF89lpxIREGckNZOeGWJiBxfqA/7WGCBHYUpnctYHo1cbqQfhXPRXtCnH1w7NEcZKTHHIsNPw==
X-Received: by 2002:a05:6a21:2709:b0:1a9:eeef:f6b3 with SMTP id rm9-20020a056a21270900b001a9eeeff6b3mr63326pzb.53.1713370197257;
        Wed, 17 Apr 2024 09:09:57 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([115.171.40.106])
        by smtp.gmail.com with ESMTPSA id h189-20020a6383c6000000b005f75cf4db92sm5708366pge.82.2024.04.17.09.09.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Apr 2024 09:09:56 -0700 (PDT)
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
Subject: [PATCH 4/8] ceph: drop usage of page_index
Date: Thu, 18 Apr 2024 00:08:38 +0800
Message-ID: <20240417160842.76665-5-ryncsn@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417160842.76665-1-ryncsn@gmail.com>
References: <20240417160842.76665-1-ryncsn@gmail.com>
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


