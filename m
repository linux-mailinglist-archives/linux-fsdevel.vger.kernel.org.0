Return-Path: <linux-fsdevel+bounces-71742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9352DCCFD23
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 13:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4586430101FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 12:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E89E2D6608;
	Fri, 19 Dec 2025 12:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4+ytKGK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54F521773D
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 12:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766147845; cv=none; b=lsuJfYCctSvUruD7dePp3W+uiSc7cw57cVOd2r5ay7MtbPa0f0TTh5RDPLRs9R1OUyek+C9mxQCbDWKqfrdzbzr6AbKot22cyA3E5rr213gJ9HKqNd5K+n1spCXoW4uuoWUkk/JVq+mMm6d7pwvGP/NUkGwziE77TPt/Sq9hUQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766147845; c=relaxed/simple;
	bh=/KO9zUvcW4Dg8BOmM2ZDfaFSNvhLzW8vK8xe00YlUgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HCusKADMqL4Q8yx9b/crSxXqOb649EPNWFafkfzafd35Cuuga6nQNGrRivsqR1t3UWqIxU5drG0pJF5M9CgPetG6uQAq+H50NHnZLAkJptZC/PA9IF/1UojkjTmhMG0Ca1cgZpDR71CSH127sI7pE/P0PUl1ed730sOczVGDVQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4+ytKGK; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7c7660192b0so1121785a34.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 04:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766147842; x=1766752642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=IcHUaTFrmXuihljZ9NPOpOfzWyP2bzk3HiTs5aJT8Q8=;
        b=H4+ytKGKrZl5ieedBgH3OEWHdiLUDJTBLJ6up2s0wvV+akqhLMWA7t+St6X19O3PiF
         7AkxXkvq8OaptIQS2hh5L4CzyXLBurbiqXCTYtsyUSJoukrfX6/ujtHxwLpUhi3F7SAB
         rxsZl/lPoizwrOWV+fsTp0jt2cD2F/tFyUaB3TesssVG206e06qoIQdHtsU5SUYQZ1nV
         JB+JOOp0NwOBtHM4K/Rkw/KIJFb0H4gphB9TPUAfPsUHDEWI7FsWpXefFRp+dxbb51EO
         rRQEXrD24Xe0BNT2JMNv93nyaWesBykjEIdwstnpFdAMghWYMW4fDQTDN+K1CCTDhJBR
         +6Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766147842; x=1766752642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcHUaTFrmXuihljZ9NPOpOfzWyP2bzk3HiTs5aJT8Q8=;
        b=HqBUBOYmFAYlhDo5G8BeL5q1iGQFU8WqmZMYz/qOD0PoBz7Nk2BIWXYmI3l2KTTsjx
         tLeBos6URLob0LQ5To6KpaYTW2ah7W+wtwuTid4dgy5fVbMPTMdZrbr0S4CfBEDxc8M2
         GFYFjkKHsXRZzpMSimWL9vZkQ1P1UIRQWGkwkwV7N2YllSwl+8GVwyQkB3eGpZbt3Mt9
         pCD0+KbjgmYVwo3QReWFjx/TdstsKwo4DZpZKxK0J3zd7qnngAiO2odQTJVsoNOD5DH8
         gIEEaxRcZwqEG37qm89RU83VZY3CH/7vDWd56FPH9bRGtYkr/smR1Dm/aBd+HQrWEGuT
         sUEw==
X-Forwarded-Encrypted: i=1; AJvYcCVOCh1c1AAe2apiOWCti9OQSShMZMsnEHn6t7x132NwqTU1zbuQuGwxjFbVCKGB4TBa/hDxTN6/MwJfMd4f@vger.kernel.org
X-Gm-Message-State: AOJu0YxIAJQJGvt8+TmD9U72ck+HFoqz6gnXYn9JiBE9MqFAuNTMQg0I
	fSSBg5m2o8ubuJB9it2YW/gJIZ3poFo376mA16Olv3oLUEC1JsXZ3n43
X-Gm-Gg: AY/fxX4PZRDWwJsVPtyV8+SzcRvLt05QvJ0gNJorlpzpk3E6QH98xkN99v/uChrMvUP
	8OpSVbHA+E1CA0eWQy3yytLBrbx9C1PEreOxtr57TY8IH0dxNeBl2VW1e84AyzaH7gzqVtYNPSf
	sjqKX1mbfEDQJQUFWneHxogwE9R1ZYXZuXDLHIlRsGniZckmCu3GeDHL55HFH05VNY6ucydkIPz
	kzffWestNtxqogYltkSM23W/Ywn48xK/gIhxlVs+20Gp8aEsFyUuauhvSY8eKeFGdR0gWEn931h
	hFpcwiZVu9lM8/3yFQHBJcoo/ZzOkSlD0A/cLCDXOWJcBPbS7SEblUVfRevg6z5KHm+CrAdsdRn
	PkELSqR4yD6ipyuUZF8OmrFDSZ5EEHOnwAE+BmWimQZbui4JVvTVrYFuffg4o1g7W2uYIDbL7lE
	9i+pzUUwz0j/C9rmCiibYEaKXrr2o0ypFYFoc8Xn8ZLntz
X-Google-Smtp-Source: AGHT+IEgOA0/a6B77dCuTQnCdZXbZikCeOm1NYByQGossxUkCBmPTXJQBtJah4Ps9oYiD64ephxmcQ==
X-Received: by 2002:a05:6830:25d4:b0:7c7:591a:7e91 with SMTP id 46e09a7af769-7cc668a4bd5mr1727231a34.7.1766147842443;
        Fri, 19 Dec 2025 04:37:22 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:7cbc:db2c:ec63:19af])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667ebe98sm1571289a34.21.2025.12.19.04.37.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Dec 2025 04:37:21 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: John Groves <John@Groves.net>,
	John Groves <jgroves@micron.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Gregory Price <gourry@gourry.net>,
	Balbir Singh <bsingharora@gmail.com>,
	Alistair Popple <apopple@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	John Groves <john@groves.net>
Subject: [PATCH V2] mm/memremap: fix spurious large folio warning for FS-DAX
Date: Fri, 19 Dec 2025 06:37:17 -0600
Message-ID: <20251219123717.39330-1-john@groves.net>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: John Groves <John@Groves.net>

This patch addresses a warning that I discovered while working on famfs,
which is an fs-dax file system that virtually always does PMD faults
(next famfs patch series coming after the holidays).

However, XFS also does PMD faults in fs-dax mode, and it also triggers
the warning. It takes some effort to get XFS to do a PMD fault, but
instructions to reproduce it are below.

The VM_WARN_ON_ONCE(folio_test_large(folio)) check in
free_zone_device_folio() incorrectly triggers for MEMORY_DEVICE_FS_DAX
when PMD (2MB) mappings are used.

FS-DAX legitimately creates large file-backed folios when handling PMD
faults. This is a core feature of FS-DAX that provides significant
performance benefits by mapping 2MB regions directly to persistent
memory. When these mappings are unmapped, the large folios are freed
through free_zone_device_folio(), which triggers the spurious warning.

The warning was introduced by commit that added support for large zone
device private folios. However, that commit did not account for FS-DAX
file-backed folios, which have always supported large (PMD-sized)
mappings.

The check distinguishes between anonymous folios (which clear
AnonExclusive flags for each sub-page) and file-backed folios. For
file-backed folios, it assumes large folios are unexpected - but this
assumption is incorrect for FS-DAX.

The fix is to exempt MEMORY_DEVICE_FS_DAX from the large folio warning,
allowing FS-DAX to continue using PMD mappings without triggering false
warnings.

Fixes: d245f9b4ab80 ("mm/zone_device: support large zone device private folios")
Signed-off-by: John Groves <john@groves.net>
---

Change since V1: Deleted the warning altogether, rather than exempting
fs-dax.

=== How to reproduce ===

A reproducer is available at:

    git clone https://github.com/jagalactic/dax-pmd-test.git
    cd xfs-dax-test
    make
    sudo make test

This will set up XFS on pmem with 2MB stripe alignment and run a test
that triggers the warning.

Alternatively, follow the manual steps below.

Prerequisites:
  - Linux kernel with FS-DAX support and CONFIG_DEBUG_VM=y
  - A pmem device (real or emulated)
  - An fsdax namespace configured via ndctl as /dev/pmem0

Manual steps:

1. Create an fsdax namespace (if not already present):
   # ndctl create-namespace -m fsdax -e namespace0.0

2. Create XFS with 2MB stripe alignment:
   # mkfs.xfs -f -d su=2m,sw=1 /dev/pmem0
   # mount -o dax /dev/pmem0 /mnt/pmem

3. Compile and run the reproducer:
   # gcc -Wall -O2 -o dax_pmd_test dax_pmd_test.c
   # ./dax_pmd_test /mnt/pmem/testfile

4. Check dmesg for the warning:
   WARNING: mm/memremap.c:431 at free_zone_device_folio+0x.../0x...

Note: The 2MB stripe alignment (-d su=2m,sw=1) is critical. XFS normally
allocates blocks at arbitrary offsets, causing PMD faults to fall back
to PTE faults. The stripe alignment forces 2MB-aligned allocations,
allowing PMD faults to succeed and exposing this bug.


 mm/memremap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/memremap.c b/mm/memremap.c
index 4c2e0d68eb27..63c6ab4fdf08 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -427,8 +427,6 @@ void free_zone_device_folio(struct folio *folio)
 	if (folio_test_anon(folio)) {
 		for (i = 0; i < nr; i++)
 			__ClearPageAnonExclusive(folio_page(folio, i));
-	} else {
-		VM_WARN_ON_ONCE(folio_test_large(folio));
 	}
 
 	/*

base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
-- 
2.49.0


