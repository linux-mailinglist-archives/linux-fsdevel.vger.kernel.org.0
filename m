Return-Path: <linux-fsdevel+bounces-71582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 64841CC98FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 22:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D2A4E30398D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 21:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5615830F7FA;
	Wed, 17 Dec 2025 21:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjUsuM3B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0731030C600
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Dec 2025 21:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766006030; cv=none; b=trJ4fzZbpK37n0sW88A42duYOHWZSuRcZPhdiLq2ryR4eaPKuGlj19Hp0qkFF/u46+r+15XeQg6UZi8+Fn3M3y67K8dmtDFoCzBzzTrwsrx1T0czP8JnTMVgZgbLYQSCPfOJqVt03R4I5RumHxSp7fCEuN2dpfM9QxVTH0OGXnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766006030; c=relaxed/simple;
	bh=H6Dnvdf9bmtdIjrm3kzMHDEtw/qB7Ge+CUXBEkKfJQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eatJZNrBTVZACYTnGcOIhY+vVll0isCY4VGKZHOtYqxRbfuFC+WVb+VB/YYrvUj4b1NNqKU/xzNxIg1/KTPFLB14kTR9pPO0mnbVu6ycikbeW/n4Fr8DRm6rNqUQsZ2FWKN4KX6RKkvWOXd+EZKSyfAmxo6poxsarOl7yycBX6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjUsuM3B; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7cac8243bcdso4305088a34.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Dec 2025 13:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766006028; x=1766610828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=WykdBCYT8yJh4sQTY3N188JsaYBSsyfv2BDjqpmbRM8=;
        b=ZjUsuM3BbnWCEV1r0mJOiH8IiuyV8itGy80DbJ2DvaVz9XpYqHnyM1Os5jhx7SQPT+
         74uV/PE0mILYb2H+7izwWvGAgpqHhF9HSmwtjpICIKA0FxlJs1GOzSxTCMw4q6hVbKnu
         0h1gz5kc+Tx+PsFmhISimdbhRddvPupnkfzdRIqHxbK65nPPIFzg5ZjzpgpxaZn7Zi1+
         Ddrx1iWrBRJIzTbi158EGCv335o8UjbbwAY3Jk0ffx4IS3nxXvYLxRsOQ01LPOJNOm9u
         5nTxpcR4SdXc1LsIk822yGZBlMn8wt2UVvNRhOUGd63S/3f2jAmvQbzdIUHVsZLVGimp
         iexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766006028; x=1766610828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WykdBCYT8yJh4sQTY3N188JsaYBSsyfv2BDjqpmbRM8=;
        b=QgG8Aw0Wo5hxpEjpsPrOIw9H4sGAnrwglTtQmhbLbhc075kdCQ3nsPT5vRnfZdmBWA
         34BIwOJZSPVmjsmjGeqV5dDMiaGqmvjzk8xGBABZ4NP9qYDn4wAzyvfze0Xobvpj0vPH
         QAF4TfTUQA2opJBFNmOcqy6gXlwYW9LgGWVJpMdfbZpOeSKb20ZWlgVWDju7cAHpMUDm
         VlHCxOGQ2EYXZlY9W5XUjvco4A/bNmfFT/Pq6BfLN8my7F565m4tDehaEqw9t6catYP4
         WW2N8fKK9xhgPVHaRwf3Ihuv8SXBN1g2NPvuN3tjeBpnrkWKf7YLmGsW9d2tH1E0XQik
         VChQ==
X-Forwarded-Encrypted: i=1; AJvYcCV95m4WbiKu1NY/3OhDnyO5cTBaZLJ8aYjPDXa/IK5dgYFw46VGsWbN+luE7GJK4sCoSrVVD9ri22gP4CDF@vger.kernel.org
X-Gm-Message-State: AOJu0YyagHsRAfvV3i1CEDkNXcJLBMhk0Jrrfhyv2ItMS4DZHcgogNyE
	U7W8WQJXDLBO6F4uWvMHu19yECzBoES8tpxO2tAv38X1Pss0XWDfTOBa
X-Gm-Gg: AY/fxX6MLocOebzeJSIAk+a3sDr+FgB9Aqs1uRRIxDLie18syUZj1TsjSBjpmAprdw8
	ZwKI5bmI+dw8KqjC6At4rF6G70J5ZlqxQOmUhhh2ETwKG09wbyz3znR5NrxaeWHepP1mXzO3tMK
	rtI6L+wHSZJ9jbVgMNtizes61AJUa0AKVzdusF+3QlzOvAdAJg/B7qS4BjgEbckdZaTL4YUGVT0
	Jn+P1KVeOuk2jVy0ipvPLGCcG7GQpieXKTHQtcdWuP+NZDYW4oGlJWqrnYWCitv75h5bknQAlxD
	KciP9hy3WmwAYhHY5Qda+PU4zZOpBqbjNBcLQcN8/m8NMNx4D0VpvkcDxh16nvJUOemN9OJB3oJ
	JncICkIMbrd8xvcAjlGvfwM+ecJOzYA1Tlg88We0f5PmADcYqHkTVQGL69FY9Rc4rbxwEzcOZR8
	7kvWfu4GMdDO46o8iHRl9MpJaDXnmCshpDV60zaOs8nOA=
X-Google-Smtp-Source: AGHT+IEJ79LfZmTkRRoNE6whe1Hjdhe/lgdvw3Z/AFdcRJKL1VDs0J2lLY280PufpqnuhZpriR704A==
X-Received: by 2002:a05:6830:254a:b0:7c6:9d7b:b033 with SMTP id 46e09a7af769-7cae8355339mr10935440a34.22.1766006027800;
        Wed, 17 Dec 2025 13:13:47 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a468:73ca:1f36:d52])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3fa179f3a71sm354640fac.0.2025.12.17.13.13.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 17 Dec 2025 13:13:47 -0800 (PST)
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
Subject: [PATCH] mm/memremap: fix spurious large folio warning for FS-DAX
Date: Wed, 17 Dec 2025 15:13:10 -0600
Message-ID: <20251217211310.98772-1-john@groves.net>
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

Signed-off-by: John Groves <john@groves.net>
---
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

=== Proposed fix ===

mm/memremap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/memremap.c b/mm/memremap.c
index 4c2e0d68eb27..af37c3b4e39b 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -428,7 +428,12 @@ void free_zone_device_folio(struct folio *folio)
 		for (i = 0; i < nr; i++)
 			__ClearPageAnonExclusive(folio_page(folio, i));
 	} else {
-		VM_WARN_ON_ONCE(folio_test_large(folio));
+		/*
+		 * FS_DAX legitimately uses large file-mapped folios for
+		 * PMD mappings, so only warn for other device types.
+		 */
+		VM_WARN_ON_ONCE(pgmap->type != MEMORY_DEVICE_FS_DAX &&
+				folio_test_large(folio));
 	}
 
 	/*

base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
-- 
2.49.0


