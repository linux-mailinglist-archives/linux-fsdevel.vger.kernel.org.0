Return-Path: <linux-fsdevel+bounces-68601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0146CC61081
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 06:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id B53A9242B5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Nov 2025 05:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E9B23717F;
	Sun, 16 Nov 2025 05:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="YtcZj491"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F512264DB
	for <linux-fsdevel@vger.kernel.org>; Sun, 16 Nov 2025 05:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763271741; cv=none; b=l8yX8fDBisGRkVFn6S6VbTdQPcKUW94f7rs/tBb9y9VtnbEslq5h2kmwFRtpNAOEdYvuX5febM0xCkdoQNneraE1YkcakNjbt8tV5v0urgLg+6wr9EodHqUzdUXqr2lgKAgocOv3vzYwYEb8CyRgAnuw4RQhi3E9eMEB24mHusg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763271741; c=relaxed/simple;
	bh=AkswSf8Pj6kLPywAFc/4sCinbDAhglnWFAuDkhBcqCM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=putUsyboWrXZsms2SbXur3b2r4M1bbjUHwaH3Vcsau80hKeWm5hNMnHTUQv9MBCcC+Fk0ecX38dGHzK+ZBKTdYxF+sn+KQK3sQj70fclBDO5YCvQq/qI03kW7M05h+/7nW/LCg9gcq823QiJPswTEqRizdvmt99bzmQQRdp+q6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=YtcZj491; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-343f35d0f99so2516575a91.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Nov 2025 21:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1763271739; x=1763876539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTWCYfcDkOpbvWX4/d8dth0aaIAROH9noLyncWa3asY=;
        b=YtcZj491XiR71IBZfPFAuiD+vNsHGsSTXGqvc+N+Bl/+p1ckvbASso2rmOlWcvaOqw
         4fY8Et9Yonqny1RC5zUUiZMl1HpkE4p8qz0Pav0NQi5YlOaT6YMlvMkmywIYJbwTokPc
         zgUzivtoO2zkyh8X6q8JEzfHZ2mnIeO5Npok8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763271739; x=1763876539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FTWCYfcDkOpbvWX4/d8dth0aaIAROH9noLyncWa3asY=;
        b=qdLyEXMnghdR7cLz9hdG6UDUqNfAMNQfS3HSA+JLjRfygu+hDrRWCoq8b2gojjIlA6
         qu3Tb9h3cCuZxMqjmYfx0a1nZ6W9FfNFzKPU4wC73e55JEOMBMEppZXGZkKr66LDSwqh
         8czPXZZIpUi0qdNQ8XE8ZxXrmx6Ok9ZWF7PnKgbbxlMFcAsAVruJo866CMPAHHNAAaE8
         D1/qaF32wklYZONrmT5h4Y8bSsDMBcxnhMD+KqhnkbQUeF0goZx56zozkRSHnL4SnZTF
         R6yiVIynuhAJ8mJiCwaDiaKaDNnO7MIkeVosHlK/aucx//gFwGT1p4QZykhTI1Kf31Um
         tBvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEzB8BB7ke+POku3cyr9VaxGxXaEbka9Vs1Q0ieENEc0jfH8BhbDmXHmF4ZuwMokpF8e1oHlSwlRFuYtZb@vger.kernel.org
X-Gm-Message-State: AOJu0YyhXc+HiZnqzcWqsuy2PvktYLCMrxSApmu5KZyxPChvZLpGlYr0
	+UGeKRyDD1yExuXdM1DBdzMsGL5wyyRYZi2e+PRbj435TBajWrKxjgezUYJPX510S4U=
X-Gm-Gg: ASbGncsFOC4CxA5vMV/KQAs7VYfCoPUPsVczAxQAHrG42aHpnraSG5LDVsf/zUu7+k3
	j23TX/sqOPKE3F1wloy5su2BRnyyWgwbWklp1fXHnk69oENptQe7aIu7KXdhKtAqx/811JP7VAf
	JhiFBvzkhC0wUs7EiQE3ZbTiix66mmUHOqg7eg0RRD/A9vicSX/2IgRhZW0QbYuDVxKrNWDMW4I
	uNfA3Xgz45ZrDRKO8dcgkyHVMZ7oXI7wNPGGK3uLEJ9srZ2b/ElZKa/Oy1qODV/d5y/PLIIY6Kb
	N5ikTbqaxLWNPWC3/Vih24jrl3e4+aBIJeix0fcgfm/9+Xki71D1jkD5e1m4rm6XivxUi7SW3Pg
	PCDZKTOAOApYYD6+H4xUSTEHNBBpO6luOFOIGhZkqneUh+264gchu6ICcCXnHz0xYNTvfdNunBI
	Jldy5UXPhYh4VLS78EdRfYj+8T651lQuiVLcU/Y8/JL2dgBUKf65/pRfVKXz9xNo8wns76TA==
X-Google-Smtp-Source: AGHT+IG2K2QlmLfFxQbOUyvFX7GI+ZJKFUXmOL4E+Oy9wQTzgT+ZrGoudEvwXm4hz5A9Qo5blHBWsg==
X-Received: by 2002:a17:90b:180e:b0:340:bc27:97bd with SMTP id 98e67ed59e1d1-343f9e9f385mr8126097a91.9.1763271738957;
        Sat, 15 Nov 2025 21:42:18 -0800 (PST)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.. ([2409:40c0:1035:4e2d:eebe:9df9:70d0:b210])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc36ed72cd1sm8509995a12.11.2025.11.15.21.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 21:42:18 -0800 (PST)
From: ssrane_b23@ee.vjti.ac.in
X-Google-Original-From: ssranevjti@gmail.com
To: willy@infradead.org
Cc: akpm@linux-foundation.org,
	shakeel.butt@linux.dev,
	eddyz87@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com,
	ssrane_b23@ee.vjti.ac.in
Subject: [PATCH v2] mm/filemap: fix NULL pointer dereference in do_read_cache_folio()
Date: Sun, 16 Nov 2025 11:12:05 +0530
Message-Id: <20251116054205.114412-1-ssranevjti@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <aReUv1kVACh3UKv-@casper.infradead.org>
References: <aReUv1kVACh3UKv-@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>

When read_cache_folio() is called with a NULL filler function on a mapping
that doesn't implement read_folio, a NULL pointer dereference occurs in
filemap_read_folio().

The crash occurs when:
1. build_id_parse() is called on a VMA backed by a file from a filesystem
   that doesn't implement address_space_operations.read_folio (e.g., procfs,
   sysfs, or other virtual filesystems)
2. read_cache_folio() is called with filler=NULL
3. do_read_cache_folio() sets filler = mapping->a_ops->read_folio (still NULL)
4. filemap_read_folio() calls filler() causing a NULL pointer dereference

The fix is to add a NULL check after the fallback assignment and return
-EIO, which is handled gracefully by the callers.

Reported-by: syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=09b7d050e4806540153d
Fixes: ad41251c290d ("lib/buildid: implement sleepable build_id_parse() API")
Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
---
Changes in v2:
- Add early read_folio check in __build_id_parse() for unsupported filesystems.
-Add defensive !filler check in do_read_cache_folio() to prevent NULL dereference.
---
 lib/buildid.c | 3 +++
 mm/filemap.c  | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/lib/buildid.c b/lib/buildid.c
index c4b0f376fb34..3136cc92010f 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -298,6 +298,9 @@ static int __build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 	/* only works for page backed storage  */
 	if (!vma->vm_file)
 		return -EINVAL;
+	/* check if filesystem supports page cache operations */
+	if (!vma->vm_file->f_mapping->a_ops->read_folio)
+		return -EINVAL;
 
 	freader_init_from_file(&r, buf, sizeof(buf), vma->vm_file, may_fault);
 
diff --git a/mm/filemap.c b/mm/filemap.c
index 13f0259d993c..f700fe931d61 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3980,6 +3980,8 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
 
 	if (!filler)
 		filler = mapping->a_ops->read_folio;
+	if (!filler)
+		return ERR_PTR(-EIO);
 repeat:
 	folio = filemap_get_folio(mapping, index);
 	if (IS_ERR(folio)) {
-- 
2.34.1


