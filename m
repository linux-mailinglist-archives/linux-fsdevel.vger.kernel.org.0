Return-Path: <linux-fsdevel+bounces-19926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CB78CB335
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 20:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB9FF1C21B94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 18:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B090149DE3;
	Tue, 21 May 2024 17:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsjB+EgM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7A9149C7B;
	Tue, 21 May 2024 17:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716314371; cv=none; b=OLjyXzo3dLZ3o4ft71jnh1NyP3sbhcBx1WHPQeGTkTS21VkfOFsqatLl2gTDXa2OjuYvyqtIFlcmBLVub7eDSpO+k/ebD5QdiIAWNf+kxZFUwgh3kM98247X2Eu+XRzbvOkMy59OvopA6YflWPcm0F4nL9ZXSpbwz3RuMZxG3kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716314371; c=relaxed/simple;
	bh=8KtNWQs4oLqQnrcIx6ZN5romD3/jWxvpvKP8KnV42Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qeW8hKsYvlYwbF/AeCiMgZV99W59IYpt9dv8Z1zaNe/zYBzBBH9Eef0qodkEazvEsxuvrY095Aqb1KVl4vv0mI8gEgxFrX9TfXeMGECkwO4J7/SPjIoHHUOGt5t9mkEAgG+QzBQVdZOiOcXjcSW9vZcixwrH6JC6084Z2BKXX6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsjB+EgM; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f4d6b7168eso1236505b3a.2;
        Tue, 21 May 2024 10:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716314370; x=1716919170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xg2lyZdavS/xqDWMBFosXrNzMBl51D2SBqOTVmsbmqo=;
        b=SsjB+EgM6JpeXYoi2RagpAzFrqDKZzoEdhEMIuZhRuyIBKaPTzx6r4ldGnaPyUVmqC
         AfGVrk+64xThVHddEooYZq0tkBDLrKZneNenleWuKRdv9563oa/gpKrLzMVGNxtEryvb
         XAgf547/0bLTFDaHfqkNoKhu5XhkjjGz+wCPClSCxBJEkLMFMKxkTX177bRqtLFuJPrO
         QUGOCqOYoSB4rygmS8dpzIPlJ8c1VeDLZY+jxgEXy6y/sN4UUQ5AzMu1nlyi8XrXFfGQ
         xIURi91VO9LojZUeU5U0iDsw9hTABU4uiljwdxk4Pi/Ci1EVbBX6T1we1qJzF4dyMUdi
         LXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716314370; x=1716919170;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xg2lyZdavS/xqDWMBFosXrNzMBl51D2SBqOTVmsbmqo=;
        b=GMiKRoL9mDk9zKBM3mBpjdj2uQ8FllVEMqwl4y52veRNOhBt6vVSQyUyNIg7dKIEqf
         jZMjWg1CR0WxkyKIhN8uFdyF7a3W1AB6KtzAWHhzCttf+HFARebrFnVpng8Rd+Sl+dJH
         p7Pos9JRat0bhPYZ9hHdMTOjh2s3lNTTwSDC7Wss+NFW/Xb4PHDieB1SykfKgcIog7uv
         v6urvA8BVLha9rz8js/Vu41zKYCSEiT8hjR39U2+c2dtTbhh9EQlCae92ZX+B7uL+ctU
         UqwDGaY6oYtKAzC7FiabMWpThk/FE/LauWbn5bjaKVowze+zeFaf3MZjU+1jXo/11AlW
         IShg==
X-Forwarded-Encrypted: i=1; AJvYcCU1GTfnl0C4A/BXr0qhdnIAgRiMsLNtgdD/ZXLxAqSGE0yXelF7yfz8yKrY58AagI+SQUgksLzwYR/Hse7+O0P5Q18gH4q3o7Xrj/0GM9srkriWr/6zUgOKGyI5Sk2T7aXKfGkjMkMhTYbcpg==
X-Gm-Message-State: AOJu0Yxh0MZHNv8ODBh31yuymGW0BX48uCzHduYqfe+SM8xqguYY6xHa
	1d3U79U1ejqtDD2N6B7kIuMQ6mWvsmbCH0TehnmCD8DQKoeTf+9e
X-Google-Smtp-Source: AGHT+IFJcbaL2RYoor2pNfsZrFdmKgf74KAMgNVGow1v7hTBzhmhyuQsxHRR2tBe0moomC0BGjEz7g==
X-Received: by 2002:a17:902:d4c4:b0:1f2:eff9:cd4 with SMTP id d9443c01a7336-1f2eff910a4mr117995375ad.0.1716314369672;
        Tue, 21 May 2024 10:59:29 -0700 (PDT)
Received: from localhost.localdomain ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f2fcdf87besm44646935ad.105.2024.05.21.10.59.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 May 2024 10:59:29 -0700 (PDT)
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
	David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	netfs@lists.linux.dev
Subject: [PATCH v6 06/11] netfs: drop usage of folio_file_pos
Date: Wed, 22 May 2024 01:58:48 +0800
Message-ID: <20240521175854.96038-7-ryncsn@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240521175854.96038-1-ryncsn@gmail.com>
References: <20240521175854.96038-1-ryncsn@gmail.com>
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
index a6bb03bea920..a688d4c75d99 100644
--- a/fs/netfs/buffered_read.c
+++ b/fs/netfs/buffered_read.c
@@ -271,7 +271,7 @@ int netfs_read_folio(struct file *file, struct folio *folio)
 	_enter("%lx", folio->index);
 
 	rreq = netfs_alloc_request(mapping, file,
-				   folio_file_pos(folio), folio_size(folio),
+				   folio_pos(folio), folio_size(folio),
 				   NETFS_READPAGE);
 	if (IS_ERR(rreq)) {
 		ret = PTR_ERR(rreq);
@@ -470,7 +470,7 @@ int netfs_write_begin(struct netfs_inode *ctx,
 	}
 
 	rreq = netfs_alloc_request(mapping, file,
-				   folio_file_pos(folio), folio_size(folio),
+				   folio_pos(folio), folio_size(folio),
 				   NETFS_READ_FOR_WRITE);
 	if (IS_ERR(rreq)) {
 		ret = PTR_ERR(rreq);
diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 1121601536d1..b3a6b7b41192 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -54,7 +54,7 @@ static enum netfs_how_to_modify netfs_how_to_modify(struct netfs_inode *ctx,
 {
 	struct netfs_folio *finfo = netfs_folio_info(folio);
 	struct netfs_group *group = netfs_folio_group(folio);
-	loff_t pos = folio_file_pos(folio);
+	loff_t pos = folio_pos(folio);
 
 	_enter("");
 
-- 
2.45.0


