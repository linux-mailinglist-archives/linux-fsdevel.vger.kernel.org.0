Return-Path: <linux-fsdevel+bounces-18172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 428AD8B61A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 21:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6CE21F22145
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4879713CF9E;
	Mon, 29 Apr 2024 19:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQ2LSAo4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675C813C91B;
	Mon, 29 Apr 2024 19:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714417640; cv=none; b=N73jDGZcHb7SiIA5R4GQ0F6AGq9Aaok9vatQZgfgpnWUzHMItKwjUDaqUw1keRS9SmadbFJuHsTK3yzT7FcfsNRpREkwqfAi6Itay79BdDxdLtrULdQTtvRG4x4ROGtZw5EqRKtj8AUnORReEgjDRzX8Cxi4DVs6eVtAk33cHVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714417640; c=relaxed/simple;
	bh=qqZmyySN3ttr0mL8w3csYiQ6Lq6o3ZnWQDeTR//44Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XSUJ/zmmU5X/p513KREaCDh8OOGVfjxnJIyPYq3RYLCQEQS6SRHBJYVUwoT6eiUGdHwlb+ce+aHcspFrdp+ewekBZlJysoMSO7dM+BpkrZBDY5WJyMMfFsunqSm2dyb/Gc755OIWPGbHAs/FOsCQLEoEbpm0R2qoQWoinfoYzog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQ2LSAo4; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e4c4fb6af3so33046505ad.0;
        Mon, 29 Apr 2024 12:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714417639; x=1715022439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/ZAdz4nacsjUfg+kmWc7WaK5L40TR/d1vDMSfySNIi0=;
        b=JQ2LSAo4R+obODDRpfUZSKAVEQHQ8bsTRNn1aIm/NI7EA5xPbtu7QSu7PCS12bAyRo
         N3hxJ6oN+UayuKohyBE/sGgkVZoAlZlX+1E+UJrG5RO9V2XQnsKF46AQ/lqygBcFDfbo
         g/d5nuGeXBHNieJ5ePQZCrdj4guDSxoIxXTanDJx77Mn7nGOFjECPB3WdvuP8gnOxNfe
         0olxPxKBKWXt9ZzPZzQyxm2ANpuHMNJHBvXvze6O3iEvwI5VrVoWgEvWgX2fxsBWJEVU
         n1txSUp1kJJTUjy7QelwiKdlzw6Pw6cH+sEj6uYlXCuzZ4PMk505Cwm2VfirVEDTYShl
         6aWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714417639; x=1715022439;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ZAdz4nacsjUfg+kmWc7WaK5L40TR/d1vDMSfySNIi0=;
        b=angW+WLC+N+Rm0mUItkNbxZBppy9bFHu1vZhjlgmn28nbBkchbeSL/TKo5FgeTYlLo
         0kSVh8cdVvzpNcasi1jCmT3z4xoTmsqTflmjHRc87FyFy+lTi0CCursNRZRT0CIF9Hiz
         KS9ykZId1oFiPu8sVzOusMuG0C3o+VAj3iPinyHuyjZfCjec3w7ZhT3mhf3G42oYoS+v
         aVZJPZbiGG5EZBkZO4fAxsJ++MS4Hs4NxWXhCINTxppmN9i0oNo0G3CXbYfYPbc4HNFA
         8o8lD7XaE/f+QVmD8ZLs6uy8usgYO8V01EMvBVXUZWjmnvhuepNBq6CgLZxbnetk4HsX
         Z7CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx0z1V/goda4/GBsEIHjVfuoXt10YCs6OmcsPlgo+BW5WCxA52tBmw2GFIPwmRFfxZYdswxYquRKiXuosnoJwZ7k6ZhLq/QR31t2fmCXgFUSztuU+DWJg0TW4x3ChwLD1FC4qRRiJZNCZ9FQ==
X-Gm-Message-State: AOJu0Yw1/mVV8tQAI5CRB08GPG1eSUTWbzYYWvJCHDa1jM/ajis4IB8r
	vm8Y8yHfIpJ3rs23d2hqW7p7T+OoupN8oE7TphfR+CyeLC70V4T6
X-Google-Smtp-Source: AGHT+IEmVRDgcLWQ+6tPsCb7ZBjy6NSNZhmYZz0nvDiJO9htXZ6R1aiOcZHSzS635P8dLMc8xNX3jg==
X-Received: by 2002:a17:902:d489:b0:1ea:964f:9b0b with SMTP id c9-20020a170902d48900b001ea964f9b0bmr870204plg.5.1714417638707;
        Mon, 29 Apr 2024 12:07:18 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([1.203.116.31])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902864400b001e49428f313sm20619356plt.261.2024.04.29.12.07.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Apr 2024 12:07:17 -0700 (PDT)
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
Subject: [PATCH v3 07/12] netfs: drop usage of folio_file_pos
Date: Tue, 30 Apr 2024 03:04:55 +0800
Message-ID: <20240429190500.30979-8-ryncsn@gmail.com>
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

folio_file_pos is only needed for mixed usage of page cache and
swap cache, for pure page cache usage, the caller can just use
folio_pos instead.

It can't be a swap cache page here, swap cache is never exposed
to netfs, so just drop it and use folio_pos instead.

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


