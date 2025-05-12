Return-Path: <linux-fsdevel+bounces-48771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 376D2AB44C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 21:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D86119E7A3E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 19:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405FE298C15;
	Mon, 12 May 2025 19:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRH1VbgJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B616D23C4E5
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 19:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747077456; cv=none; b=WA9L6A11/Ar92t2FUjswaRafmS34v5S7tXJmXp8/3KQkTpG8qkaKKASkbRvFe7puwR+p9dW1azbWYTjVQUp73UCwvdR4+SQHebmPCW5L3ODpi0uN372he+ZlLT8a7XABAL04YOhIxbwAodBdaDVZQtkQ7vduZe2QhpxDNMKG9qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747077456; c=relaxed/simple;
	bh=DM8G30RWCxGUTepNTSwS9MbBEItCS1h/UpYrlE8rj2c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PhENWJjxASKnhSWzoq8lYM4e6vfrGckNF+PfaiYTTAD3wLpK4PPXmlkl944bOXClDyQsyMvWQI+SiokTmUG7f+MYRf6RPjsF7xQEtdkWSBWiI93GZSsGAiSIkdD1VjYgqPPxu4YTMQE4nvqFahf3boT62ag2YYR3pI9i/w2RcoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eRH1VbgJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747077453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s/18zIVU9SJCaF8Ai1CFMU44OTCynZeUoKhqvxkl5xg=;
	b=eRH1VbgJmPvACaCKBCdZ8udqxQSkMUcmUFIscXOIipSnH/W63S38OycGGbQA3s4UxXM156
	G6+kTjhLYIUSM6X+o9NU8VSWiaT2aAciSnyxp4HPhvfcaKkEjkC6FozxRGuvGTr4dXY1mg
	beQ60vXzavwFiss2/H/vgE6HJPfgfD0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-LtR5QBaKNji3I9dodfhxJQ-1; Mon, 12 May 2025 15:17:32 -0400
X-MC-Unique: LtR5QBaKNji3I9dodfhxJQ-1
X-Mimecast-MFC-AGG-ID: LtR5QBaKNji3I9dodfhxJQ_1747077452
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4766e03b92bso82597051cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 12:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747077452; x=1747682252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/18zIVU9SJCaF8Ai1CFMU44OTCynZeUoKhqvxkl5xg=;
        b=HGidvOMxY/rmX1r1jZqwEhOxSm6HoqyWFCDbe27K9z4c2oOJBdYyc3bMP/OZiv2OdK
         TVsSR0q59t9dfsDMNOa9ibKfpNL1SrakAvS5OHYKAFlKFoelw9G5mWwyWORopaZ0TNj2
         hy9MsIV9MN76cH6LbBdUaMCM7V2KxhZeul1GcXgHVHucSK4p5d4zAGCgG0mga9A0+AHP
         HR1Cem9K45sGz4Tsb+9/dozPnfDRL5nVLf9k89t8JEHSLtUx5AZQfxPKUFIbh7pjRw0q
         D4B3n51WAKofcN1xmOxeJ/qNqRLhYS+oDX2dQO7dssULNZZQKEdoV4TBM+hf4cimTl/f
         urzg==
X-Gm-Message-State: AOJu0Yy583xTc7hV0QaKXxZIvKP9Z/V7AhYcL94hcQqKFDaqirFBs8uN
	F3bb+ENtO72bEb/lskE2AEp5ukrP/U5i649PIoxmWR3d9xc1Ix746SGv9lZqgMlTOnFG+qNRRv+
	vy/ZWBEj07c/6vbNNEJYm6mpGjt5015OX10J/zmyj+IyAKNEAiFrz3n92V5rY5P0=
X-Gm-Gg: ASbGncvAQ9iosOf2/boa+70MD1Tw0piAkkt7KaL4ldnFmcBhtqKNNbtvwniXA72BjQx
	lYLhnx6J0mogR+ysWX5h9g83Sk+1ntwjZfKzXWp0jj0jCGW6agnfBYF50VSzis94LJOFQX/9lEv
	u7j3211McfUrUvtL2M9gQ2ng3kCwVObDnGKBxLd+g6aacxU28qv/Or+DJmh2zYtrJxSfhF2Siqn
	/5TStQ0N4Q5+ZB0Mjqf8P8OfEK7lF1n9WnkLPc+S+7N5haNym2gTuc7rZqRmKqobEX/23J3NBRm
	pVy14U3z5snOFjaHIJBnkAm9z6PdZHt2ho8nz/tyFHc=
X-Received: by 2002:ac8:5a4b:0:b0:48e:1c13:ecaf with SMTP id d75a77b69052e-4945273c570mr229772421cf.16.1747077451381;
        Mon, 12 May 2025 12:17:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+7q4UW257no1ZfUNsmnYKJakieEg/UoQSyIMxIM5MObxjq90atPrhvRnYakQEeO5zdg2D9g==
X-Received: by 2002:ac8:5a4b:0:b0:48e:1c13:ecaf with SMTP id d75a77b69052e-4945273c570mr229770951cf.16.1747077449828;
        Mon, 12 May 2025 12:17:29 -0700 (PDT)
Received: from jkangas-thinkpadp1gen3.rmtuswa.csb ([2601:1c2:4301:5e20:98fe:4ecb:4f14:576b])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-494524bbc53sm55635321cf.47.2025.05.12.12.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 12:17:29 -0700 (PDT)
From: Jared Kangas <jkangas@redhat.com>
To: willy@infradead.org,
	akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Jared Kangas <jkangas@redhat.com>
Subject: [PATCH] XArray: fix kmemleak false positive in xas_shrink()
Date: Mon, 12 May 2025 12:17:07 -0700
Message-ID: <20250512191707.245153-1-jkangas@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kmemleak periodically produces a false positive report that resembles
the following:

unreferenced object 0xffff0000c105ed08 (size 576):
  comm "swapper/0", pid 1, jiffies 4294937478
  hex dump (first 32 bytes):
    00 00 03 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    d8 e7 0a 8b 00 80 ff ff 20 ed 05 c1 00 00 ff ff  ........ .......
  backtrace (crc 69e99671):
    kmemleak_alloc+0xb4/0xc4
    kmem_cache_alloc_lru+0x1f0/0x244
    xas_alloc+0x2a0/0x3a0
    xas_expand.constprop.0+0x144/0x4dc
    xas_create+0x2b0/0x484
    xas_store+0x60/0xa00
    __xa_alloc+0x194/0x280
    __xa_alloc_cyclic+0x104/0x2e0
    dev_index_reserve+0xd8/0x18c
    register_netdevice+0x5e8/0xf90
    register_netdev+0x28/0x50
    loopback_net_init+0x68/0x114
    ops_init+0x90/0x2c0
    register_pernet_operations+0x20c/0x554
    register_pernet_device+0x3c/0x8c
    net_dev_init+0x5cc/0x7d8

This transient leak can be traced to xas_shrink(): when the xarray's
head is reassigned, kmemleak may have already started scanning the
xarray. When this happens, if kmemleak fails to scan the new xa_head
before it moves, kmemleak will see it as a leak until the xarray is
scanned again.

The report can be reproduced by running the xdp_bonding BPF selftest,
although it doesn't appear consistently due to the bug's transience.
In my testing, the following script has reliably triggered the report in
under an hour on a debug kernel with kmemleak enabled, where KSELFTESTS
is set to the install path for the kernel selftests:

        #!/bin/sh
        set -eu

        echo 1 >/sys/module/kmemleak/parameters/verbose
        echo scan=1 >/sys/kernel/debug/kmemleak

        while :; do
                $KSELFTESTS/bpf/test_progs -t xdp_bonding
        done

To prevent this false positive report, mark the new xa_head in
xas_shrink() as a transient leak.

Signed-off-by: Jared Kangas <jkangas@redhat.com>
---
 lib/xarray.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/xarray.c b/lib/xarray.c
index 9644b18af18d1..51314fa157b31 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -8,6 +8,7 @@
 
 #include <linux/bitmap.h>
 #include <linux/export.h>
+#include <linux/kmemleak.h>
 #include <linux/list.h>
 #include <linux/slab.h>
 #include <linux/xarray.h>
@@ -476,6 +477,7 @@ static void xas_shrink(struct xa_state *xas)
 			break;
 		node = xa_to_node(entry);
 		node->parent = NULL;
+		kmemleak_transient_leak(node);
 	}
 }
 
-- 
2.49.0


