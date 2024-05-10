Return-Path: <linux-fsdevel+bounces-19278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB3B8C23F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 13:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABDCE1C2363D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 11:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9D4171677;
	Fri, 10 May 2024 11:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kl41EsBd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8312171670;
	Fri, 10 May 2024 11:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715341824; cv=none; b=HWjhkf1hT42TwqqzLDYat5frjXK0Iyi6cbRFFmdD90peO94wy8MvYyNKPYWLld9dmnYX2OB9hEQggVor71qDfcwTHlDUieyADzU12ikwcSx6C/ZAzjaY5Ux0KMUN90iAxnxaOExXzmMVSwGiYSJoLWpGvj0Op6CYheXho42ZJSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715341824; c=relaxed/simple;
	bh=F3EKclujHSSuxRJLJjZWka9tbvl2y2InP9dBBoHDt2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mGCxyAYNd7Ls66sYvHVQFyVSfXP/OwM42pBkhF/u84b0iTbLUda0rt2LePT2jJ2tMe3wIjfkd4UjSoduBWNWtkiCe37X6BsiEfACVQuaG68yyi3It5mqwb334ql9CBZk+TTG6IgbQgAJ+NyceT2KpQPeCJthV1kYJ6rT2hBMYaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kl41EsBd; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1edfc57ac0cso15524115ad.3;
        Fri, 10 May 2024 04:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715341822; x=1715946622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r4pI/dLra8+Fx5rO5TUtIiOfN5ranfVQtnPo5N4NowI=;
        b=kl41EsBdLi4RH2Jm9RI14Xqksuhmb2bqaXkewMKijqQn/Zu3fd8VBNJZZihWTpcWcO
         CzaI1R0/tBug2AjkX5vqSVNoqHTmIKp4XYqEvfkym5S8RMG+8c4zMH6JHhPdFpk5Sbdz
         +uVjDPfnm+43yccPl/Mj+/PkJWEC8xSZEbNAMmlmmrB6gcxNl7uErj7UMF+s7XuXzkil
         arzGZi9FA1AY5TWaYQbvrC4QHcFUHKfyZbOYQ0FXhwgsFYCOWMc6LeaGDtiihecb9+Bq
         AnhAJwjOm4y9oeUKVKRIYDNGVBvA1/mOLyXk3zqCf7Ztu3as9x88vIuqwl7jcNWVqhpt
         LTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715341822; x=1715946622;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r4pI/dLra8+Fx5rO5TUtIiOfN5ranfVQtnPo5N4NowI=;
        b=ZqySyk590pZn8rVaTqLAERMvjuLjm8J8y0BIVQd18HbMMa6p/nSjDCBgNylrOwikon
         YllcEEIvHJdirlkJBkVdu7CzZRxk4PbHqALhS38iKXLbG2yNScE1b7zoe2f7Ro79iejd
         u63NNhPE6dEXVB830eeLPpK1uHdOREfz2Af9BaMC3MMSUhYhRxLpTHcTu2oQ1vg8KxL0
         2W5bRH4faLzwKG83POu2p6lKfJl/G8j+YfIwkfX60AKQGPqwoIprwYB7CTp2/YE231dX
         qYkZskZT9WE0z/kmxLQ3vdfdslbBhK6CyhGXOVjv1K7o8EJ+CdzXCtcBzH/zrtBMSkYd
         +Spw==
X-Forwarded-Encrypted: i=1; AJvYcCXpED7B+8+xhxEU+7sfoE68FT45rQ/4z0wM2mdw1D3IwMQ0FNToHZh5VNNhfrCsw5M56L8FYVrENpWCUjliV5EIuAGtbYguyHFbA8/UCc3YbR1YX0zvkVFfFzkt618PuNbslD9xgUlJOHz3VA==
X-Gm-Message-State: AOJu0YyPw+dMFpgVxTu6B6cbLvm+AT+XQlu52ppkRxWmWQGol+cEoK9C
	w7YB0PY6I9RgUlWUH99ZSL2HTJeYQyRJRnngzSvTM+2clw9zZ2V+
X-Google-Smtp-Source: AGHT+IHSu4vf1uCLF5qFTJHXuHSvWwDd6wRy4AQCNalBLaHz4N+8wZRkLwQ24nQsMv4SDXunk7nJRA==
X-Received: by 2002:a17:902:dacd:b0:1e5:62:7aaa with SMTP id d9443c01a7336-1ef43d185e9mr29151095ad.20.1715341821906;
        Fri, 10 May 2024 04:50:21 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c134155sm30183825ad.231.2024.05.10.04.50.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 May 2024 04:50:21 -0700 (PDT)
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
Subject: [PATCH v5 07/12] netfs: drop usage of folio_file_pos
Date: Fri, 10 May 2024 19:47:42 +0800
Message-ID: <20240510114747.21548-8-ryncsn@gmail.com>
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
2.45.0


