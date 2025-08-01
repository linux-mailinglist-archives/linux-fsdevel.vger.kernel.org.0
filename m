Return-Path: <linux-fsdevel+bounces-56494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CACCFB17A9D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 02:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41BA83BD4A1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 00:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DDB8836;
	Fri,  1 Aug 2025 00:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHanOh9n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D868E134CB
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Aug 2025 00:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754008076; cv=none; b=J3Ba36hjIvBb0Jn6+8sg9gGXJDCia2bEKaxG7qkxIxaKYMEIDBGaT3Px2aRYWsAV13IWmA9QUDVgMEiLDQL7folzpKcHl4spA9on36Uv7VZSUwRQUeud2Mmkcc9ZVk6sj6XV4baUkKoZOZz/lzZQz8lvMrB8iMREn7Z2lKb4bDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754008076; c=relaxed/simple;
	bh=xdDa5cPqlYA8hU6hWe3h3Iv8yi3FYmFf4fthmsVSLgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHLE+WI536Xaxj0xDidsIP5xmhNR0V0H5qWgnbL0YjMwOh9nLRYTkj8XfyRiKjDVbXWoQKMVDJ9wX/z/N9tybKnL0+b0Ocq6IxsNqkuqt4oFEhRSCbNdr1tbodoG/sBFUok/0P0JXdgLLC5bRt0cHiriUTlAVus/jfLrEzPjm/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHanOh9n; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-769a21bd4d5so1028850b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 17:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754008074; x=1754612874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdRz9q7dLOqqdNdkm8h8OqDbX3LI7OI2JzdfLntQtvE=;
        b=FHanOh9n31DyW9fqwuOwEV5L1HUsHjAOo1lXqJm0NmfjqJCYfYO0S5UQ1l5y/TBb0A
         DQslIyGXq9MWsaMK2BSdTZ6yti8V4vQ5BtP/Dzfh65B5OJl9TPOqt0FRbzA7OVbIKNur
         u5RUGRw+5DiwlZIeCxlySUlaGQVWpvVmpc3P/eBWjQMOB5yKx5Q0owUA81Y6qhCZnAJR
         hagZtnCv3IWYXw1pgD2iMprLidv/ocpVem2/V3d6RUwdNc/VYW+dc591n2HVzbIi+yqR
         VLl21jksERoxl9RCjB8bu4h+rbUpSxKwX8y4xm3UUgDqd6nJk2IzX5LjEstRc0058VoV
         agwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754008074; x=1754612874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdRz9q7dLOqqdNdkm8h8OqDbX3LI7OI2JzdfLntQtvE=;
        b=xJZUu9M8LNreOk/mrCEouZTGMZF+vfsk7SftCjZ9aBOUcmCBSGqzvJ1JRquxcKtpfw
         DyPJIkpXYR7tgGM2imL8FqjQJR85zz7bR3h878Txs1SG8N0PFJcYdW6lFQANLbxVRJGT
         HOjzViaE34p+sSKAu/CxpDs+oVFbGrJJaVC0bvD62Ios5oC0W5ihUyf3Z8upVq+ZpOo9
         KoqA/WPTKh3zTLKWsU3QbRxVZZ/9ngHYoSIju0YrwXl+hyxcbPcS5uXNRyzFcDAM+ouN
         1miZSFAmuvm5/6cIocGcWUYMfWLNd9wA0vulDlSWoWZcbROL+sjmmtcfTCaw8hxqK4Zn
         Ipaw==
X-Forwarded-Encrypted: i=1; AJvYcCXTpUClnzV97KmpzAyK91LFT9SjVBo8rdDTdZMjbGkMOqV64+y38zfR71gS8QaNK/ycfkYEEKas8GKE63/f@vger.kernel.org
X-Gm-Message-State: AOJu0YwNaQ77VAcaQKd1IqT8J9i16ULVsmXRtf3ypGxyv89Ang4IExzV
	WkxBhBeK0HM3Shzpb4QeJVH7VRNeLNPN/KHy+y8YmzeSzFVr4G4VIM1P
X-Gm-Gg: ASbGncve/z1gUGqURm+yiLoNsRVxFZ5ZVa/5si+96Lv5aqnbjxCjVnt/5Vv8n6x6O+w
	VsmPBO/WLjZ3Ar4CNvIdSz8bj/m6Ups3tFpZHHk1jdBW2SRa8hF8dSHnPYfyabO3zfGr0XvhfST
	0TYNILmbeejFtG0MF2+uD/ObBeX4fWf1SNswCSfvtFXhsxghnJ0uCviV/fqjUaO/59sQUi+rx3q
	FX1Qmw/HIVB7S6KJWzD9ze3e4B0QwpNc9Hc8KLQ7UOVKCifYRgViDtNp9D8mOxvh5KJ8XTAUQQ/
	GfO7idwOgwqLRTdYX3fl1uZ0/Vm+IyxyYABQ/UvaSWUXZBYtLkYzFToHif1IIpjzQ02+HC8RME9
	wEsL7kcfBd8/Tw/Qelg==
X-Google-Smtp-Source: AGHT+IE2eTaDl+wmfJliugEXOoJY7F7v3oLACX+cFUkV/3LGNbDY5rsM5LpXKvBPnATgOkUarm0T/g==
X-Received: by 2002:a05:6a00:7083:b0:749:bc7:1577 with SMTP id d2e1a72fcca58-76ab1614e85mr10747796b3a.9.1754008074092;
        Thu, 31 Jul 2025 17:27:54 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfcf5f7sm2660467b3a.88.2025.07.31.17.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 17:27:53 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-mm@kvack.org,
	brauner@kernel.org
Cc: willy@infradead.org,
	jack@suse.cz,
	hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [RFC PATCH v1 09/10] mm: add clear_dirty_for_io_stats() helper
Date: Thu, 31 Jul 2025 17:21:30 -0700
Message-ID: <20250801002131.255068-10-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250801002131.255068-1-joannelkoong@gmail.com>
References: <20250801002131.255068-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add clear_dirty_for_io_stats() which clears dirty stats corresponding to
a folio.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/writeback.h |  1 +
 mm/page-writeback.c       | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 000795a47cb3..8ca0e106cef7 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -382,6 +382,7 @@ int write_cache_pages(struct address_space *mapping,
 		      void *data);
 int do_writepages(struct address_space *mapping, struct writeback_control *wbc);
 void writeback_set_ratelimit(void);
+void clear_dirty_for_io_stats(struct folio *folio, long nr_pages);
 void tag_pages_for_writeback(struct address_space *mapping,
 			     pgoff_t start, pgoff_t end);
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index f5916711db2d..d49cea4854c1 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2711,6 +2711,22 @@ static void __clear_dirty_for_io_stats(struct folio *folio,
 	wb_stat_mod(wb, WB_RECLAIMABLE, -nr_pages);
 }
 
+void clear_dirty_for_io_stats(struct folio *folio, long nr_pages)
+{
+	struct address_space *mapping = folio_mapping(folio);
+	struct bdi_writeback *wb;
+	struct wb_lock_cookie cookie = {};
+	struct inode *inode;
+
+	if (!mapping || !mapping_can_writeback(mapping))
+		return;
+
+	inode = mapping->host;
+	wb = unlocked_inode_to_wb_begin(inode, &cookie);
+	__clear_dirty_for_io_stats(folio, wb, nr_pages);
+	unlocked_inode_to_wb_end(inode, &cookie);
+}
+
 /*
  * Helper function for deaccounting dirty page without writeback.
  *
-- 
2.47.3


