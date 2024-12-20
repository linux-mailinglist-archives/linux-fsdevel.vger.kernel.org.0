Return-Path: <linux-fsdevel+bounces-37957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 439A89F95CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 16:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B881516FF41
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 15:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1412121C178;
	Fri, 20 Dec 2024 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nqqzrpEc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15D321A45C
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 15:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709724; cv=none; b=FKObvWwDGzga+bMF36Ui1OM0W/rHOaXOkcSKxCI3wRjqJX5TW+OO6d8CeOwPAYd70AtOUcQ4uSSsYv8FVlAvB7EK5VUg1jpezY8/11827UKOKdd/RPYyzd1IZU1v0mdwW8/uDdwENqX8vMvX0y6nKLEY2GwMYOp7gv7OxApTUAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709724; c=relaxed/simple;
	bh=cl+oP5X8N7YKHDElO28Q8MeUv/ZKeS8cyPvyEaOZdN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U7Kj4/nxP/YmV+tFEOpRO3SXOzKB0oa4kJCNqMcpTYSuFuR8amrSs+mWnTUs8m+dXGxdECFzupdxCkVDpLKLWFT22XBBh5rNG5AApBvDN5Ixg9zbNQQa+9+6jUH893Yee4wzEHu8NX1FbkFVgUkrjejrxxGWESep/AO+gTEItxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nqqzrpEc; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-844c9993c56so168921539f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 07:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734709722; x=1735314522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qy66q6foyU2ZBCe4X6zLGxi2eTMkd0mxpiy36jLMGYw=;
        b=nqqzrpEccq1eo7LKwO1s4rU8vfiuRVkl3K3iumPJlThFajAbySOyap4/hIP9+X2wjV
         Bf8qUD3GSHB6JuvtBTOGC/sDN6Co3SXndULxWUdDGKZfa0STbdMXIe/5G4auM4+yGkbx
         5In5SD7acOXTeVOTrWdkv/v450oWVB4lkWlyCqfcGwC3KZmTU7dQTu8PmsEK7YIPtxi6
         nL0JVMzTa6kaaZ2g60OYPPlRSb3TAsOyzqd2e3MKHHDMoAj1La3uzdf+o1KA9CIdP0HV
         fHozHWEe5rNw+z5oTAnZaE42w6tnXZUbUK3ST6YX51RUT9/2gMMD2to0DdBgNZSe2me+
         xHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734709722; x=1735314522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qy66q6foyU2ZBCe4X6zLGxi2eTMkd0mxpiy36jLMGYw=;
        b=MiJ57SlwP0gn5URGa4rxQwNT4R08NkxxYG5MWfBpke9eZ60KiJmVjt9CH0eWrvLvV2
         rH1vsfNnOC54I6F23EchMjrI7VysgryIGLN3UnPvmskMI+5x6oX5eohqOJwy3xjBiOwZ
         1znjFkmS18qOECQkQzGpAoropcjsrcNhOHFfcmRlJ1e4tsexMTfX96nBILdQHtjLgBo1
         d3MzhDqKM9JyFanu+TJ0jvs6ZbcqmdbnfmmJgUmp+622GSvLeNrXpgl2Vh1l4bO0/0gV
         FjPi0TxNBHfqy9/JTxKRbRIE7XBRfxncs2SLUrDcqHaqu5vlfVVXaqurdNBCrDtYzxmJ
         Wzbw==
X-Forwarded-Encrypted: i=1; AJvYcCV+SYpo1Y0j6wPvPrCk+yGh5f5hvGXo9fJ5bEkDLMYcpDxoQlsK9dNWtm80Dtfg5TdCJ/GDO8VhY5CTsP4q@vger.kernel.org
X-Gm-Message-State: AOJu0YxpWd7RBWcq6D3i9ZvlsZwwgsm7TsW/Qtwd0IGLOG/GD/aNFevQ
	RfajCJIat/F/0dMb2uCViiyzainzHL7LSMU87mSobGKNr7f/rsnLXWSJPioAL6E=
X-Gm-Gg: ASbGncvUagzHp56/hzFLeCtMytO7xBO144TbFw4wvkBX3DKIWTgu5TqU5HoaGxlAdEN
	iLIPf5GMuszUvpZUj7TOOAkAwa1dcHz3C0reW6lvV3mKlhCW6y9Fa2YjtrZtIaIgJyILNV0DFvH
	ycN73aXMhFo6fjiG9vrqdziFC/Yf0+ZUG3k947SyYThByVFNZ99UNxabjb1jrUdMN+L86GiOJO9
	FlT7FbawveFCAeHv6PLbg2lG/hY9NEuivpYNmRMO9dBysmXh6usmikHkdh/
X-Google-Smtp-Source: AGHT+IF2sIPl1WVDVbn7fgvbpII69l3j4cwL7QghFjhSCJ3SFTcAXuckA2Q7OzRuPKU0QQKKTwe1pQ==
X-Received: by 2002:a05:6602:26c6:b0:841:81ef:70b9 with SMTP id ca18e2360f4ac-8499e605a2bmr323110339f.9.1734709721832;
        Fri, 20 Dec 2024 07:48:41 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68bf66ed9sm837821173.45.2024.12.20.07.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 07:48:41 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	bfoster@redhat.com,
	Jens Axboe <axboe@kernel.dk>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 05/12] mm/readahead: add readahead_control->dropbehind member
Date: Fri, 20 Dec 2024 08:47:43 -0700
Message-ID: <20241220154831.1086649-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220154831.1086649-1-axboe@kernel.dk>
References: <20241220154831.1086649-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If ractl->dropbehind is set to true, then folios created are marked as
dropbehind as well.

Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/pagemap.h | 1 +
 mm/readahead.c          | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index bcf0865a38ae..5da4b6d42fae 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1353,6 +1353,7 @@ struct readahead_control {
 	pgoff_t _index;
 	unsigned int _nr_pages;
 	unsigned int _batch_count;
+	bool dropbehind;
 	bool _workingset;
 	unsigned long _pflags;
 };
diff --git a/mm/readahead.c b/mm/readahead.c
index 8a62ad4106ff..c0a6dc5d5686 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -191,7 +191,13 @@ static void read_pages(struct readahead_control *rac)
 static struct folio *ractl_alloc_folio(struct readahead_control *ractl,
 				       gfp_t gfp_mask, unsigned int order)
 {
-	return filemap_alloc_folio(gfp_mask, order);
+	struct folio *folio;
+
+	folio = filemap_alloc_folio(gfp_mask, order);
+	if (folio && ractl->dropbehind)
+		__folio_set_dropbehind(folio);
+
+	return folio;
 }
 
 /**
-- 
2.45.2


