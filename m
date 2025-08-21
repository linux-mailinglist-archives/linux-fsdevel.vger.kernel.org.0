Return-Path: <linux-fsdevel+bounces-58669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2EFB306CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21A1B626740
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 20:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2332A390944;
	Thu, 21 Aug 2025 20:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="T4u0tbi4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D76438FDEF
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 20:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807667; cv=none; b=Krb5KmqUfZfRkkPK748xxzTwhcpUUC/LJ+tBPa75ZX/32dJtD3Fu5paOKmwD7C1kaX9lg5Wvnl9dpGygSGEXl91R4G5nO19BoTjUgxrZoQV6sHl2U2X95X8pL4LF3Aaz7QcrJQUsqRUr31ZPqCvz1odLxl/CeisQGsnnn0xRDOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807667; c=relaxed/simple;
	bh=sLtWG4tBwYzFayC8el4qA8KAx3MpBYf6WBWbOygRAvQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TaaDD6AMvc8BHXE3V7EXL/srjOMTY80Zw1CUdpbfVMA6roXxHHVrscDJDvhLjPpGzpm7BbHIe9RXhlResRHJZonRVQb8BR9llalmEPuHDz8mRYqEWxotxJ70nLP4akVI8vz7kSv+XLuS8LbEHTEYcO4OIAjqXK9PlkUaZ5rc/fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=T4u0tbi4; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-71d60110772so13045227b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 13:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807664; x=1756412464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1kMEWwVY5zqmZ8rO1Ng8kME7oWtjO/CBjlFvprNCTeU=;
        b=T4u0tbi4Zb4tBUiLbA2xTner5l3xFJnADxs1QlZj+pO0Lvg+mgQ+z/ZqDKph84MOI2
         FgdvHdgatMts8XVlYQDeiGGmenaP35LFrf4LwnDO+bGSaebO/S+00/yLx2m26ml7RKJy
         zezEaoYtNkL+cCUmjfR84Yvh/o6p0vjPX1jCaakHZAPkRECg0Ytp+QWSu5pxTCsqGT/b
         9PIlNbd+K4oVbClwZAbLvsu791PeNO+JZRxSYdYfma5KtS0WuSAvQBsH+tGRgcwG5dj0
         woTsS5O8F6/ANmDqqQIpwNKolzADTvJMzuwPT4ngqPxUa+zpeD9qHRE7FrigtyiPGys7
         fCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807664; x=1756412464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kMEWwVY5zqmZ8rO1Ng8kME7oWtjO/CBjlFvprNCTeU=;
        b=fcBqlj49lgz5NxHpE1FtHsCdWHPasXgnoJIMr7MVeQjihi/Gy2gEd8apHQFOZgE4FS
         jXpeQf/83ZQR+1rMA13cFCSZdeCDssItQBKsJ2KDKHj0M9ZuNyf2+4FVB3TYozkr2FEZ
         VhsSY75+JmaN9IE/4N8AmiffQwzvZmE8GH3dv082jwNDGb4kWDuKH6oFkJR7gbHF0hhg
         nsVvI7j7E1E6x/x0Lf3VT9aooPFanjgC8Fp/WWPbIZVR39qGzmhNvjRht6Tz/QuCQfI/
         NBQ9DJlgcYchQkTZJZHMZekpE+8QrjONhhEE9FVfOLBcawzUr5IuC+aPwvSvdTjiIid6
         CGlg==
X-Gm-Message-State: AOJu0Yyv4iq2w7seUM8vmAtpj1jdOKQW/Vl5UWIe340KWSz/9BZpUT57
	2JfHsW2w+L5TpLxqT3bmWyPcdpXyOc0/WODOzzKpqlJNI7m+aWTmEQhWBY8XUluYEGQ5RPiR2gJ
	sX9au9KLo7w==
X-Gm-Gg: ASbGncuPkBas+IqgLct5sVlMChitPpfxICak0xBNveFi1Gk+HmzxORPFIOfKjYB/TYn
	H23w640maAFni4GYEJlAiICuYPhgABw9nZ3KOLcrwUVXZQfHBgE/NVuYBlmelu8cItXv3EIM4dX
	9aY0pPjjkLhTqyM9Peu1tkNjQox0Z2UfX2xwvtTBQNht9IhLzMHo4XzNS6VI9SuYJuvqxvOh+c4
	BqkyLIca29nb4xdcxTVKHXfxOHDfHz1Ea9SYa6ivdFqo00aG720lGyc39GnPc7MC5g59hB1zy3y
	zArKLIXqC3qthmdhF+lcPCqdbtzWYNhZM/bjL7sVHzFvhlzrmjXXJF+/owsihN6x5ZHTfWMQbKs
	tHb0hZF2nX1I8Mnwg/Ecrg2y8vNPgDYefUZxAoY9hOLop1iFEJxqGs1Vin38=
X-Google-Smtp-Source: AGHT+IFwsNnYsC18/NFJN5WgIoo/uwdywJ99qClr9yakhuxBJ4gcZI1q3LLBJjoDD8XpK/y4+KE4Iw==
X-Received: by 2002:a05:690c:6c0d:b0:71f:a20b:6d34 with SMTP id 00721157ae682-71fdc30ab77mr7353677b3.22.1755807664570;
        Thu, 21 Aug 2025 13:21:04 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6e0b039dsm46054927b3.59.2025.08.21.13.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:03 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 32/50] fs: use igrab in drop_pagecache_sb
Date: Thu, 21 Aug 2025 16:18:43 -0400
Message-ID: <4259ca48aec7355b3d3ab26d5d779973e5f2f721.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just use igrab to see if the inode is valid instead of checking
I_FREEING|I_WILL_FREE.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/drop_caches.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index 019a8b4eaaf9..852ccf8e84cb 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -23,18 +23,15 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		spin_lock(&inode->i_lock);
-		/*
-		 * We must skip inodes in unusual state. We may also skip
-		 * inodes without pages but we deliberately won't in case
-		 * we need to reschedule to avoid softlockups.
-		 */
-		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
+		if ((inode->i_state & I_NEW) ||
 		    (mapping_empty(inode->i_mapping) && !need_resched())) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		__iget(inode);
 		spin_unlock(&inode->i_lock);
+
+		if (!igrab(inode))
+			continue;
 		spin_unlock(&sb->s_inode_list_lock);
 
 		invalidate_mapping_pages(inode->i_mapping, 0, -1);
-- 
2.49.0


