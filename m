Return-Path: <linux-fsdevel+bounces-33952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C5F9C0EBD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 20:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B39F1F28069
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 19:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D387217677;
	Thu,  7 Nov 2024 19:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIS1xVLe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E21A21733F
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Nov 2024 19:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731007050; cv=none; b=YJXfsbGiN+tZgvzSXT8k/P4NlOWFa2KbNJftUiG1zAuUo16O79Iq9DPRudVZfn49CyFr3DKsIrRe2Y64+ZOmorGgJ5gQtuFQWoivcFyk8LA15ftrjHG59gZ0siCH9SKtJ6cQE1g3xJXtsDhiP8Owoy9Qb4I295gOjINXVyqZ7R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731007050; c=relaxed/simple;
	bh=3cbO7y0pACrtoUjmXCfJYrCv/UHydIb1Y40En1V5hgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kfd3BExdE7MrqSWx2R29jke92EFduEpad1vevYS7WhGk8v66ZUI25dB8FJBaz/LcZ3Zea3xC51qRDgi0FfRYUn7ubyQWG8PRhfaG8tyiA5gt4MaCzKKz2KECwK3P5Sj9HwBdgnJ0T7YtsKw1OAYUTNQK61W/ye7hDHUM1avxPnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIS1xVLe; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e29047bec8fso2003004276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Nov 2024 11:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731007047; x=1731611847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u2CBAn6giMXXiKhPOgLeKDCo9Vrjd3aYf+IrGQBfRgc=;
        b=GIS1xVLeyBiwtx6UAZivgi7qFs4hnTsrPdcRV3pyk3ouKum+7goLQXd6jhOraxnxCN
         u0l06dUnbQVYoHW3ZSBzvvqSI0Veo1FL5PjBbLP9awn93cNUuONSvVBJQd/txtDiltmz
         hASsU8Kmmf8wT/BiDHurSvcgxBMb5hFXp2OpsoOVfXT++Qpcp+QggK/A0Av5gEq3TpR6
         H+PwIW54E+rZUxLbwwSObDxEDIXHMReIJSsksr21MB6iWWLzWCbrHJwIvxtNP/df3m71
         peS+SUE27cdYLMjAEPRK24FTZVKPKUkMH1SdU1jILpWSFGzcDVoKJdiCA0JIJV14lXHL
         cqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731007047; x=1731611847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u2CBAn6giMXXiKhPOgLeKDCo9Vrjd3aYf+IrGQBfRgc=;
        b=R/yysLbzh7pc2vi3qnH8a+tu/KAxzcvbMJwxD+/+mvDTLLvguiTH6Nny6ilejTf2cT
         m/f+KqTIpSekLOWa+EZLUflX6A0d1CgtMMv8yQyiU3GVwRhqfNEQp4G6IdnolW4eQJad
         QKK7C6dKXpPYBZYizC6VASljK7dVkZi7S4YxKp3YNyUPhUDwBLFV+vFfjk+J5Y/km1QH
         TGjcf9ikPC3A7UhsvmDF2Tilg46p0lp4t3IqK8/Bt6pTcLEEi+jfeuVPZ6bMLQVkLi1B
         lPGTuSULx4XUYrgfajDLcpkf3U/2BWiYNZC+JE5UHZAOUCBmVnxPKygCnrJN3QWbsz0f
         lkdA==
X-Forwarded-Encrypted: i=1; AJvYcCWTIsbkDTF9VhAKc25tjlyYwsOWFsM+61b9fVtV1hH9NyzgJDTCKlNXCq3VGRnkXQNoYcxdPoDrOVfkC84D@vger.kernel.org
X-Gm-Message-State: AOJu0YxPPP8Z28lHRaeIlsFFefpo212/VbxPSdNMmKOQj87Ga5ZNSUrC
	IfWDAsOtlWzyVdQYUGDBeYT+ssu8T74h4da8zvTDeGgtLeUSCisg
X-Google-Smtp-Source: AGHT+IEkpWzZirMthRa1KIppd+IoM2B6ZQrYg1W/sBImn83Wn53xX/nxsQKorMCpOKraG2RVdoxyYg==
X-Received: by 2002:a05:690c:fd2:b0:6db:e1e0:bf6a with SMTP id 00721157ae682-6eadc0a0bbemr9007977b3.7.1731007047220;
        Thu, 07 Nov 2024 11:17:27 -0800 (PST)
Received: from localhost (fwdproxy-nha-008.fbsv.net. [2a03:2880:25ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eace8f1c74sm4067837b3.31.2024.11.07.11.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 11:17:27 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: shakeel.butt@linux.dev,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	linux-mm@kvack.org,
	bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: [PATCH v3 4/6] mm/memory-hotplug: add finite retries in offline_pages() if migration fails
Date: Thu,  7 Nov 2024 11:16:15 -0800
Message-ID: <20241107191618.2011146-5-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241107191618.2011146-1-joannelkoong@gmail.com>
References: <20241107191618.2011146-1-joannelkoong@gmail.com>
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


