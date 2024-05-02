Return-Path: <linux-fsdevel+bounces-18481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFD78B96BE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 10:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46741B21A50
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 08:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F71548E7;
	Thu,  2 May 2024 08:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5PHE+4t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576F554BCF;
	Thu,  2 May 2024 08:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714639647; cv=none; b=sSV1QfA9ZSl0v3mAQycwvfr2ywC+1GlOwZKnLlO1Gu1ehRNmUT7qUQ3Z9XJcLLMm4KBxz+q1jMW0otYnlHwEXZqm5bugl0hX4jly9xHSp3v4NX8M6kKkojUxDZkOFhDKnMX0IU9uP/SagIEoBCklO0/YZ3OOu1hE5ju6lg9MRho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714639647; c=relaxed/simple;
	bh=gNeowpHLn3XanGMjOPlcSsZZHe5AP0lM6lADWQVCs4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ud6Sj7E2tBp/NwLnq+ZdRgw36KdW1L2+72ObfGqFnEx08ZI4pY9h88zySSUl9yDaiC46oXjncDDVH0FWHrjvi502ug58oiiZ4Dr+9Jev7gt58HgKHsgKl0RQuliXzVqijvCd+ki2gNeCFL1VGN094+IlX/RGAEDCiHvbIgT3LjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5PHE+4t; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2b27c532e50so1828766a91.2;
        Thu, 02 May 2024 01:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714639645; x=1715244445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5+IkB3+J9K42d+V5Wi+AdhWpwnXMtEpYhZXm/5fw+dM=;
        b=I5PHE+4twrtf5dhvKYH5hN/V49DsPYFYXHrVXJz4Uudg8ZC0JnomULnFERh+pUDA4L
         +jIe+95GH3pWuJRibjH19ZGQ8nPfRzvMy/asEY5jej+YiRGkV0rTqOZliapyETGSyFtC
         EvRCb6QFDUH5wDsHsYkjxMeTdxqbSiKA16p11OXacJ8wpX6G8s8MiMDHkKVpaPy6HnXh
         GXS6VRQ3NM3B/w3ZNoDyXBNuJF/dOFc03q/4Qw7OHBtcsMJTWLnlRpNpnzAbu7zojZOJ
         OmRDi7NmNjJLlecu862rZ8DG7Dilbu42zeRfXjqoSYekmaVyK+qt+i4r/8wo6RyQnYFi
         EdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714639645; x=1715244445;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5+IkB3+J9K42d+V5Wi+AdhWpwnXMtEpYhZXm/5fw+dM=;
        b=KeRVtBQrx/y2kb4ZFpkAdm3JWtuC7+anNISsYwz47BE5ZsTPwVesQ3xlSYQRSKFuNS
         mN5ql31LQjBDK1FEZHl5Qn+8H0IznG2eTSE5OXY7uF6pJdbm68m5SRv6Y1QdPLhtYbAx
         leLbb982onOMorYC7N/G9SlQSyyNlCquTRm+UF1H6OwJ4/p9HYb59hERzpyB0QvaSwZR
         VxPpfdtVJuRioOYqT2JAYVl3b1pl5WICMo/BnKAURzeEw5dYSNdpkvBuRN7xbEvdT25Q
         JC9KC53fKJ/BDNTeLH7uahrzALqnals293kdBv7uT52K5QHTMUHPBcv4kOUEkq8vuDJD
         f2Zg==
X-Forwarded-Encrypted: i=1; AJvYcCXpGo9kKkAPlPut5Z2elNXqcAgM9FtaL8Ii9uoRV1iM+0kokB7d4IFM5d2GzKTBqqzmBwEC74suKXo2H08QbkG8jssui+lutK1QluD6M6ACoTS1qagVj8ItRJX1PNWQhkHaPa05sjrdmvbZEXrTREcsBk7zthk+1vqEgbv83nNTP3QiWSfXQXM=
X-Gm-Message-State: AOJu0YwJTkqL1zF8S1jhuNj5cmTa7Hdoy79SAQTxdWQb5KhJCKRXTKFu
	7AULcxZdG5/3um6nkoRuVOL1Wf3hIPk79pu3+ZnRheFaGJnWaISR
X-Google-Smtp-Source: AGHT+IFyJzDWLYcpgS33rbs90FlHpYKxLcb6n/RLJGWRhgWQpaZsVJE2vmaB1MgKiD0eY8T7Jpul2g==
X-Received: by 2002:a17:90a:986:b0:2b3:be55:bf6f with SMTP id 6-20020a17090a098600b002b3be55bf6fmr981227pjo.22.1714639645519;
        Thu, 02 May 2024 01:47:25 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([1.203.116.31])
        by smtp.gmail.com with ESMTPSA id q6-20020a17090a938600b002b273cbbdf1sm686805pjo.49.2024.05.02.01.47.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 02 May 2024 01:47:24 -0700 (PDT)
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
Subject: [PATCH v4 03/12] ceph: drop usage of page_index
Date: Thu,  2 May 2024 16:46:00 +0800
Message-ID: <20240502084609.28376-4-ryncsn@gmail.com>
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


