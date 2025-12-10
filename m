Return-Path: <linux-fsdevel+bounces-71074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFF9CB3E86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 21:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6554A3050CD0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 20:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FA327380A;
	Wed, 10 Dec 2025 20:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BDr4Aqdx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ethEPv/L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E5F1E7C2E
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 20:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765396882; cv=none; b=GkkcxNZ7x6vCM+sxiIiCRhAby1eQY20Gt2NcD3OkY1IkQvOs5708TtMZxbTaOm/rfsNQg6qvIr9hO/TJDLjFU/NXKF2/vhzXUVP1nVEzelbeviEwPGoa0JoYIDy+On+O3ZIfBLhzS/WuEjSqGeamVLBSXUHtOg7NPCHfunGRfI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765396882; c=relaxed/simple;
	bh=9lNlm3j+fSy9wQz6ZuaQWjtCR0vh1DpvT71w12klh7s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cIwuN5MT7PmuIsLB1ATvWOPF4hMzGRMB6+Q8I6KHZnJoPxcraGldthOASFZzjySEAeD85ZRXq95bbtwhHu/MMf32SYLA0Lnc5LrGCqR5O261GTo6RcJkgU/AViUTL68P8EhjiBB7LnBDSL7X4IO5n2K3dv13P14LouE7DGKiIHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BDr4Aqdx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ethEPv/L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765396879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=V9RbkySjzGfl0K9jXSqidi1BNCt8AnLcDnqFvp2ykS8=;
	b=BDr4AqdxyV1Zvja3bfIifY4+y5eAptDmuJlwNsiZGbEnkPpoDXr/ifDSLSofIxK/ih+51F
	nuWTugOlYI/0bKxqHDUgBZ7yjEd5EU4xFdpo9kPJsmfKkfKH/pxjImvCVc4lMH5BWOutxg
	QbX16KLbMieVAUhy3IufEIZb8Fg8RqA=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-qp5sX4Z9Nc6Gydn0ol6BZg-1; Wed, 10 Dec 2025 15:01:18 -0500
X-MC-Unique: qp5sX4Z9Nc6Gydn0ol6BZg-1
X-Mimecast-MFC-AGG-ID: qp5sX4Z9Nc6Gydn0ol6BZg_1765396876
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-297f587dc2eso4627425ad.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 12:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765396876; x=1766001676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V9RbkySjzGfl0K9jXSqidi1BNCt8AnLcDnqFvp2ykS8=;
        b=ethEPv/Ll62CCWSh0hfGQe1I+IuohT3MzAbW87vE82Evu8gZypHJtTUzZtEv963J4F
         XGRgXBUVEK35RkVd2KPdogHxaXpo0dAqikw8Bz81+Rh5VcGRPJW+zDldBjZZNVJ9vrWD
         ZdcDLanIPwI958TH12th8ja2dBb8IkTLsv/NtwvmEO8eZidEM5Kr53BYZyL/WArOIPGR
         7hJakNsEaJO68txSS0H1aPUSGZiwqUibmw/aZqh0sBXZ9TIsKxjmzBR7QBPruCPzoidO
         Yfx5k2HcsfmZveuJfagbPyiLKLrOCfyE/wBh8/FzhyAZEo/In8GpmGV0r/LOYD2zm8P0
         k8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765396876; x=1766001676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9RbkySjzGfl0K9jXSqidi1BNCt8AnLcDnqFvp2ykS8=;
        b=DsweHzT0b3wJQRsg3VUEeBIVW6OXVQCGCCwENPdX2femwlgjd8rmkBGRKwviLsakU2
         dcnChTV0DRx/XeNMvFlOBHkUBxxyvsroUjac5vbrqNDp+RWP47gRFDqckLJCEYnH1vAQ
         vq1H27gNU4c9m+unoq9Nw5mrAWfACVjGGkEiHhVmLaOAXZNYXhdmRBcWVTiItGxdjXvZ
         wXL70CfPhFnsEBBbNVSiJBjcEmHrXEzyNKRAwu0QhcFc0OfO5QwFIK+g5mnR+/+mWWCQ
         yoowSopzzeyOZoUvPyM9FDT84EEK7ar30kEdbTG6haXZMv2K+1e5ssJRSQymF2mbvrcb
         5S1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1lbH/em3HRQEjOmaGXkzXXRJnnKBZVne48ZZlv/DB8OP7gQDeIPAD3tYkDs4HCqFQZX5bAFc8Nac/NT+7@vger.kernel.org
X-Gm-Message-State: AOJu0YxM/+y4cLKKi/nB3+wDjV9xLK7yfOyURT/oezQ+pFuRNQ2FjMIl
	RniQwe538mlyPX5GxcBbDLV49Z84VqSUpSLJii+cvRe4llaKuMU4dvDoxX8/8FBMTe45fgI5WQ9
	cvJO6S7uZEGy3Yy2mOwjYj4lkMUFy+NrmQiCUARljB47hywx2WZKTvMEmHxT6P5kkUg==
X-Gm-Gg: AY/fxX7Ga4joiNVa7oqcdT2MhOzu71QDpdxOj5K1wb+zFHjQgArwIgVPWRFNpDwmC4E
	vFgfhoMn90FEW87HVaqV7qacEdk50//13k4ZRmewTXoHHok3bai7T9LCjJvVqGrzBaFpM1Jw9ZO
	JGCO8tEaMfhZ8MUkF+1UP4reZkql3knyWHA2MN5HEbCQ0pDz4ONqP3xzsPHJddMj/TZ3RXmZOdj
	TtRlVIJJRyvi3f/4f5EVRLbYeFNZzmcWo0BxO0CrLAXtqNYNLQ7aZiALgZ8W/F5XNf6GAt5y+s6
	kqVIsY0vAXKsMoU26gEmGu+iyf7l8LIfQ+BRCM5Zf7ueyhtAB+K8c3SN2BdulRdV7OEC5n0gh/O
	bmQOY8Y4SNB1G/GKqQggIt95eJZ5IqMfttcrNBg==
X-Received: by 2002:a17:903:3b8f:b0:295:8a09:bcf2 with SMTP id d9443c01a7336-29ec229b8bamr31841465ad.8.1765396876009;
        Wed, 10 Dec 2025 12:01:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrGjll388q8qWAtNsls6L1JpU1c2oP7akLc7evYgTdRMpha5cZhDbVRpAeZMgzYqyVmAu9gA==
X-Received: by 2002:a17:903:3b8f:b0:295:8a09:bcf2 with SMTP id d9443c01a7336-29ec229b8bamr31841005ad.8.1765396875476;
        Wed, 10 Dec 2025 12:01:15 -0800 (PST)
Received: from dkarn-thinkpadp16vgen1.punetw6.csb ([2402:e280:3e0d:a45:3861:8b7f:6ae1:6229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29ee9b373d6sm1819395ad.13.2025.12.10.12.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 12:01:14 -0800 (PST)
From: Deepakkumar Karn <dkarn@redhat.com>
To: willy@infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Liam.Howlett@oracle.com,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Deepakkumar Karn <dkarn@redhat.com>
Subject: [PATCH] pagemap: Add alert to mapping_set_release_always() for mapping with no release_folio
Date: Thu, 11 Dec 2025 01:31:04 +0530
Message-ID: <20251210200104.262523-1-dkarn@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AS_RELEASE_ALWAYS tells the memory management code to always call
->release_folio() when releasing a folio, even if it has no private
data. Setting this flag without providing release_folio callback
leads to try_to_free_buffers() being called on folios without
buffer_heads, causing a NULL pointer dereference.

Add a VM_WARN_ONCE() alert to mapping_set_release_always() to catch
this programming error early and help prevent similar bugs in other
filesystems.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Deepakkumar Karn <dkarn@redhat.com>
---
 include/linux/pagemap.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 31a848485ad9..cc352e87ac2d 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -296,6 +296,9 @@ static inline bool mapping_release_always(const struct address_space *mapping)
 
 static inline void mapping_set_release_always(struct address_space *mapping)
 {
+	/* Alert while setting the flag with no release_folio callback */
+	VM_WARN_ONCE(!mapping->a_ops->release_folio,
+		     "Setting AS_RELEASE_ALWAYS with no release_folio");
 	set_bit(AS_RELEASE_ALWAYS, &mapping->flags);
 }
 
-- 
2.52.0


