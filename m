Return-Path: <linux-fsdevel+bounces-50683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4DF4ACE6C4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 00:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BBF116B5D5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 22:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB64A22FE11;
	Wed,  4 Jun 2025 22:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="P3CfjMUn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FEB22D9EB
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Jun 2025 22:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749076885; cv=none; b=uT9sygi5quDDOYLfLzgpQ6SZois1M5di/qnLC/Q5CLlPpO7UQQgJLkKu4+cI6ixm82HXBdKAgxL/CaSIKA8vpXtlHPxA86kNSw4BHCviNaIJetcrXc0l2UyseyA+asrpmIRAFwoKK/HiCDZ9Rw4ScGgXKeVM5VmxWxXDCWkbDsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749076885; c=relaxed/simple;
	bh=CyCqgcP/8wYlhvYpUL+wYju404rWIxZOeVIW+huRTKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RmhVDmXdmFbPOPWGq2MoYj+Sh+zVNUmPQGFMk5ndCrV2IFY676qFCCGdIM4gztC0U9RBQmO6Q6WiB1HgOMOmOgBFO0sMQb7KHHWurliFGF7pDwyKBfDWIGcnljCAkGCyPV99KhaG9JgVHuliSxTQhla3eyky45qmzSAoG+e+tWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=P3CfjMUn; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6021e3daeabso168956eaf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Jun 2025 15:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1749076882; x=1749681682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yvufXqjnJ3qTN2sBGZHkQ2E9AKqOmVfPt2rFXs4VRnE=;
        b=P3CfjMUn6+gpZPlnqSXgprksJ/VImUK12QdJ/PuW9qU40HcZkR3ODjKn38NaXEV03f
         kBRS7FDIes2pqZnCrxZkJVfxvNRMumNqRJ2kjE0UNrScb4Hzy60Hvm59WF5KYcutbMr/
         92CPPV1x0yJ+GbxDjnFzLuL3EHEYNUHiOY8xU7GgRszYZhmYuZ7Cf8qDo4IMxlO401iX
         Xmup917SPLQ+eFbPioPpIzr5SXkA+VdiPvz9kjydRcbZF006ybpSl88KZgK3IKv1Br02
         3qMGKDg490Qq6HN1ab28D6tRIUCUANpFQAS351uGBqFjpIy9nIEOg9WVm8/pMLZYmF3c
         D03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749076882; x=1749681682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yvufXqjnJ3qTN2sBGZHkQ2E9AKqOmVfPt2rFXs4VRnE=;
        b=eUc7SVvx3XVvgOBaIakGJq0owu6O7HXOuHs2gRL2qI/6UhdZBHnwbqtZV1fLKvNfhI
         9Rvt9q6ZgwDOyljdxz4NJZZTI0AN1iqJwlWqIfp2SC6JZ2AQ5eUAeF3g765Yqgrk/w+S
         cCWOb6IYdtAGUtpz+EHNMOivtKCs0SacwUMvfXxt4NlUIvfattpACc8V1HEcEqFkTo7i
         HCZOh/xY+OpU1CSgQ+HHeD/tVeF+3zmRvKEXde3xgg2j4z+Okz/ewHERswJSHoizAdpE
         x6/FVo+VTsM+lDidPRR6Asj1jlM4qfLRZGgLRQ+a2+A6AV3ae2dOpqCNyAMq9QmUMgA2
         iaQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUptGSMWF1YDdHtX6SESyTWCLkLIzx8qGaYc+DhFHxRliTH4ocJGCmbAA0SHF1NWCvrouJFEmhPRj4akHbE@vger.kernel.org
X-Gm-Message-State: AOJu0YwT9n9e7ATt2qmsDv7AL3MX3zMiwS2vwE6yY53PP2qCaZOAegMM
	ut7AqahGv3+x/siTbPlcL0Qf+I3eppyN6mT/12hQFVfivy0Z+FFCuS/UK24kT4zudyI=
X-Gm-Gg: ASbGncuobxJGKYtH+Bv+fFap3+19wnT9TMY/W0A/0rXMO/iYvED5ZXEe6IhgGQUdFI6
	Gk2NehvIaomVmyQSeKLU4S45/xKhGBjh/hM6gZWSleXuNpxI4N6bvQ4EaEgHwSUdo1TfC513lB5
	lxiLBVGqZJFIllfk4PRayFRgEC3T0G3zt5PTTGWqPUMWnU0MxVj8mnhOF6MWK5at8cYV9uc8EPW
	P51Wbu56RT9KEbRJIKIedmMcivFRJbB0yKpwg1ZkuM6sJesXQwun0L+5HyhCHoIL8GPUfuT/hPV
	cxPFqqPI58k7AnZElQH4V3Ocm9cfzki0yjAn8kYjxK51k/KLs5zwdfR2MrNB/Ef53KFjTg==
X-Google-Smtp-Source: AGHT+IEgL3SSoqVtCvX5ax2jQoI4T2U4ltupU8SlVFrpe9DhuXyhI/70nvWEs2LXx4OCIXNohaVIWg==
X-Received: by 2002:a05:6870:2b17:b0:2c1:5674:940e with SMTP id 586e51a60fabf-2e9bf4d1887mr3150201fac.21.1749076881888;
        Wed, 04 Jun 2025 15:41:21 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:feaf:df32:3afb:acbb])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2e9067afeecsm2811751fac.13.2025.06.04.15.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 15:41:20 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	pdonnell@redhat.com,
	amarkuze@redhat.com,
	Slava.Dubeyko@ibm.com,
	slava@dubeyko.com
Subject: [PATCH] ceph: fix overflowed value issue in ceph_submit_write()
Date: Wed,  4 Jun 2025 15:41:06 -0700
Message-ID: <20250604224106.396310-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

The Coverity Scan service has detected overflowed value
issue in ceph_submit_write() [1]. The CID 1646339 defect
contains explanation: "The overflowed value due to
arithmetic on constants is too small or unexpectedly
negative, causing incorrect computations.
In ceph_submit_write: Integer overflow occurs in
arithmetic on constant operands (CWE-190)".

This patch adds a check ceph_wbc->locked_pages on
equality to zero and it exits function if it has
zero value. Also, it introduces a processed_pages
variable with the goal of assigning the number of
processed pages and checking this number on
equality to zero. The check of processed_pages
variable on equality to zero should protect from
overflowed value of index that selects page in
ceph_wbc->pages[index] array.

[1] https://scan5.scan.coverity.com/#/project-view/64304/10063?selectedIssue=1646339

Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
---
 fs/ceph/addr.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index b95c4cb21c13..afbb7aba283e 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1411,6 +1411,7 @@ int ceph_submit_write(struct address_space *mapping,
 	bool caching = ceph_is_cache_enabled(inode);
 	u64 offset;
 	u64 len;
+	unsigned processed_pages;
 	unsigned i;
 
 new_request:
@@ -1438,6 +1439,9 @@ int ceph_submit_write(struct address_space *mapping,
 		BUG_ON(IS_ERR(req));
 	}
 
+	if (ceph_wbc->locked_pages == 0)
+		return -EINVAL;
+
 	page = ceph_wbc->pages[ceph_wbc->locked_pages - 1];
 	BUG_ON(len < ceph_fscrypt_page_offset(page) + thp_size(page) - offset);
 
@@ -1474,6 +1478,7 @@ int ceph_submit_write(struct address_space *mapping,
 	len = 0;
 	ceph_wbc->data_pages = ceph_wbc->pages;
 	ceph_wbc->op_idx = 0;
+	processed_pages = 0;
 	for (i = 0; i < ceph_wbc->locked_pages; i++) {
 		u64 cur_offset;
 
@@ -1517,19 +1522,22 @@ int ceph_submit_write(struct address_space *mapping,
 			ceph_set_page_fscache(page);
 
 		len += thp_size(page);
+		processed_pages++;
 	}
 
 	ceph_fscache_write_to_cache(inode, offset, len, caching);
 
 	if (ceph_wbc->size_stable) {
 		len = min(len, ceph_wbc->i_size - offset);
-	} else if (i == ceph_wbc->locked_pages) {
+	} else if (processed_pages > 0 &&
+		   processed_pages == ceph_wbc->locked_pages) {
 		/* writepages_finish() clears writeback pages
 		 * according to the data length, so make sure
 		 * data length covers all locked pages */
 		u64 min_len = len + 1 - thp_size(page);
+		unsigned index = processed_pages - 1;
 		len = get_writepages_data_length(inode,
-						 ceph_wbc->pages[i - 1],
+						 ceph_wbc->pages[index],
 						 offset);
 		len = max(len, min_len);
 	}
@@ -1554,17 +1562,17 @@ int ceph_submit_write(struct address_space *mapping,
 	BUG_ON(ceph_wbc->op_idx + 1 != req->r_num_ops);
 
 	ceph_wbc->from_pool = false;
-	if (i < ceph_wbc->locked_pages) {
+	if (processed_pages < ceph_wbc->locked_pages) {
 		BUG_ON(ceph_wbc->num_ops <= req->r_num_ops);
 		ceph_wbc->num_ops -= req->r_num_ops;
-		ceph_wbc->locked_pages -= i;
+		ceph_wbc->locked_pages -= processed_pages;
 
 		/* allocate new pages array for next request */
 		ceph_wbc->data_pages = ceph_wbc->pages;
 		__ceph_allocate_page_array(ceph_wbc, ceph_wbc->locked_pages);
-		memcpy(ceph_wbc->pages, ceph_wbc->data_pages + i,
+		memcpy(ceph_wbc->pages, ceph_wbc->data_pages + processed_pages,
 			ceph_wbc->locked_pages * sizeof(*ceph_wbc->pages));
-		memset(ceph_wbc->data_pages + i, 0,
+		memset(ceph_wbc->data_pages + processed_pages, 0,
 			ceph_wbc->locked_pages * sizeof(*ceph_wbc->pages));
 	} else {
 		BUG_ON(ceph_wbc->num_ops != req->r_num_ops);
@@ -1576,7 +1584,7 @@ int ceph_submit_write(struct address_space *mapping,
 	ceph_osdc_start_request(&fsc->client->osdc, req);
 	req = NULL;
 
-	wbc->nr_to_write -= i;
+	wbc->nr_to_write -= processed_pages;
 	if (ceph_wbc->pages)
 		goto new_request;
 
-- 
2.49.0


