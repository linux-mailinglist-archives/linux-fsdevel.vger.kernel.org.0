Return-Path: <linux-fsdevel+bounces-33985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E3D9C12CD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 00:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69DCF1F22D6B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 23:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69591F666A;
	Thu,  7 Nov 2024 23:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYJb8mu8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F5A1F4264
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Nov 2024 23:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731023796; cv=none; b=EblvVnDAVtatApvUiVx0kPgF8P0jSE9m+oh7oDMc+CpIOY7nT11pW9z02rlkWoBNBGUSA8YFNy0A1Uu/h970fF+MAOl6iB4n0VEh1gq9XfpV3tQON+soz69dX26eejsjCz9XGcuWwteqDXXJhxwJvHASOHD8+EH+7E8VNlKIv7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731023796; c=relaxed/simple;
	bh=3cbO7y0pACrtoUjmXCfJYrCv/UHydIb1Y40En1V5hgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mcXtxwtEjzPeypuds4REeJ1VoDc5z/6Sj9mb5L6G9QQKyOOt2sJtSKzS6J9S11H9Y2GKb9acu3QoaUm7rK5TeiQCOZ0emmXKC63RaaJfW8paTfApJlpGBOKdw2THoPQBpr+9Z46rHEYPWI93E02ju883UlvSOf+T3RQNbuVjgoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYJb8mu8; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e3314fc5aacso1510418276.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Nov 2024 15:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731023794; x=1731628594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2CBAn6giMXXiKhPOgLeKDCo9Vrjd3aYf+IrGQBfRgc=;
        b=cYJb8mu8Sh1CMdJcoeekOG5NTrNPs1htqOVIkbX4gRcPBCwBnauO/GM5neJYb37Rdv
         6bS5OB+OX/8Oz5MC2IVx45zcjX5amu4uyxcn4rOqinPIJSNn4JvQ/TIDeQsiTkFXePtI
         9RPY+QomUArnGFRUSbUwRaGcZgeV1e1Rspvv36nqOq+3Wpq6D+w/94tDCZ+TYmEWctQg
         1+EayFuvlIhB2tgvPAO4yLF4C3Ow9UC59dP/L7CMM99kXndn/50wMN9frNmjhuC9ZYn9
         5VJgvpWp7WDUQy5MXswfHujwBb9O4CjytwcAKp3wnYfnvItl7KG8tn9GHe9cZDaJ6APE
         A7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731023794; x=1731628594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u2CBAn6giMXXiKhPOgLeKDCo9Vrjd3aYf+IrGQBfRgc=;
        b=Pi/phNti9aEtJBWZjf+wbsm/zaFmAofk9h/8dynVF+ljgXE/bv2zEvGOwW+3HWxcZk
         /7fztUqXuxMeYt0irLZdd6sVfQxWcPopYZrT5zMa8vx1srpp4/oQQEA7NoXu1APKe0W7
         Hj8NsKvnX0qnaXvMhU16i4TROJ5rjWTSbqfhvuh8dYV6/bIX+KkrXm1TznU716ndo5+X
         uPYbOrPKKzL4l1JljAwGuDC9BSUe5pCby/RJh0oa1lwtNZa3um95NaPnrq2OpJE91dwd
         3PoU6u3ejVareyke2e/EnrjSws2DZ7FO2GbZPJ8mhszTow5r2QV+PIutZW3M9mTuaIti
         PeZA==
X-Forwarded-Encrypted: i=1; AJvYcCU6yvgi6z5So5gfF5ydFtZAhWpUk0h7ArFIPFRt5tBn8BRWOP5inkdZUh7I7MCsHpcQMR3VmBU3h2tFRpEC@vger.kernel.org
X-Gm-Message-State: AOJu0YxZIYl3SQAda66mnfa5pFbxJyR/w/rzV4YdEQzCwqWui3zrJVUo
	Jg02NkXcUEctkmHZw2+FWoIdzNxG0Bcdj/4kbrP5kB6K1Mp48EyM
X-Google-Smtp-Source: AGHT+IEFzO2Zgam/gnWf8Abfux5tkvxODQuWALP1dfzNCjLg2EJGoSDqARXu4PrQApxNEjREq7Rfug==
X-Received: by 2002:a05:690c:46c6:b0:6ea:95f5:25fb with SMTP id 00721157ae682-6eaddd704c0mr12260067b3.3.1731023793872;
        Thu, 07 Nov 2024 15:56:33 -0800 (PST)
Received: from localhost (fwdproxy-nha-014.fbsv.net. [2a03:2880:25ff:e::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eaceb09a6fsm5009617b3.68.2024.11.07.15.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 15:56:33 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: shakeel.butt@linux.dev,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	linux-mm@kvack.org,
	bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH v4 4/6] mm/memory-hotplug: add finite retries in offline_pages() if migration fails
Date: Thu,  7 Nov 2024 15:56:12 -0800
Message-ID: <20241107235614.3637221-5-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241107235614.3637221-1-joannelkoong@gmail.com>
References: <20241107235614.3637221-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In offline_pages(), do_migrate_range() may potentially retry forever if
the migration fails. Add a return value for do_migrate_range(), and
allow offline_page() to try migrating pages 5 times before erroring
out, similar to how migration failures in __alloc_contig_migrate_range()
is handled.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 mm/memory_hotplug.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 621ae1015106..49402442ea3b 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1770,13 +1770,14 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
 	return 0;
 }
 
-static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
+static int do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 {
 	struct folio *folio;
 	unsigned long pfn;
 	LIST_HEAD(source);
 	static DEFINE_RATELIMIT_STATE(migrate_rs, DEFAULT_RATELIMIT_INTERVAL,
 				      DEFAULT_RATELIMIT_BURST);
+	int ret = 0;
 
 	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
 		struct page *page;
@@ -1833,7 +1834,6 @@ static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 			.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
 			.reason = MR_MEMORY_HOTPLUG,
 		};
-		int ret;
 
 		/*
 		 * We have checked that migration range is on a single zone so
@@ -1863,6 +1863,7 @@ static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
 			putback_movable_pages(&source);
 		}
 	}
+	return ret;
 }
 
 static int __init cmdline_parse_movable_node(char *p)
@@ -1940,6 +1941,7 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 	const int node = zone_to_nid(zone);
 	unsigned long flags;
 	struct memory_notify arg;
+	unsigned int tries = 0;
 	char *reason;
 	int ret;
 
@@ -2028,11 +2030,8 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
 
 			ret = scan_movable_pages(pfn, end_pfn, &pfn);
 			if (!ret) {
-				/*
-				 * TODO: fatal migration failures should bail
-				 * out
-				 */
-				do_migrate_range(pfn, end_pfn);
+				if (do_migrate_range(pfn, end_pfn) && ++tries == 5)
+					ret = -EBUSY;
 			}
 		} while (!ret);
 
-- 
2.43.5


