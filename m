Return-Path: <linux-fsdevel+bounces-47430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6382AA9D694
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 02:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A6ED92511C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 00:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A060C188587;
	Sat, 26 Apr 2025 00:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1k4gmZT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16C713B284
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Apr 2025 00:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745626220; cv=none; b=laCowSdMx5jgmEuNOqtPeWRy3cnm4J3HjedIxSShpl+ZKxOFPwp6u5HdGudUVY9wdF7O4zWgwOTDzdumuagITnXKx5iQ14VpT8y2bM5Jnc3PaJ5L67jc+W5COzuVApLteVuKaHPcBkwm+02wto462Re+9ngaZw6x8k3lME3dEYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745626220; c=relaxed/simple;
	bh=QeH64RdViViugDAU0Kn+rUhWjTD05LYUWSl906uwQf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qv51H+WnSR9vZpZbGXCOLF2EIK6CH2dekqVsZhmUhFeky7K3aIOjrmr27tOzIOP4HkjJX2sXBPoKM5E7VDsa1Bow1Fg6nXoOYs48AZi/EhFXQtlG1dA90utCMlHI/fZ3cG7am+9A/xJgcuCU3PH/bHhotisV0Y6wInqw4oP57jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1k4gmZT; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-af59c920d32so1882713a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 17:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745626218; x=1746231018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGzft7eQgDC1xVmXzqLbagCzkSYMK56vovoBoAqfRCQ=;
        b=Z1k4gmZTCrHegTekZ1k95GmFef22Cnwp0jko341KUTez7E0eg8UtVXIeJ4DJmaeARI
         gec3voyIkl44AQ4LhYbd9v03BsIQBunFTavo9C1kQAQpd9S91zHqAGWCxsnC4A5rp2Uh
         Qi1wnZyO8yGgke4W9nrpj5rpyqvGXYSiwRgtR8N+vh9GRCmeKc9MIETI6Tn+BY6mXlEQ
         6GaELPJU56HFHAd+nSfVnp4idGwMwo1LWB18zF/dkB5wRWpo2DYwWDsy+3OFWLBYuL7H
         1+Wuh2x4FDWHPxDz59HJR9ApWjY4lMyJ9ZG4O0y3U6geThwFqIh2s4ch1EWJ15wenhkD
         Z5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745626218; x=1746231018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGzft7eQgDC1xVmXzqLbagCzkSYMK56vovoBoAqfRCQ=;
        b=N/a0OxNsSPfXXai6efy+IkCFtS8S2iMdNQmu5LJM3j/VZ9nzN3UplXPhAB4jhDCa0I
         SiwRSyoYzV1wcQ6g4uhDTPCEjeHuXmcovYcP2wVRXkoEAInGwee2ExG33cBJzMxaVZTH
         JNcbimZZutJIoFhVYKCwOxNIYhE78imd3vLHx/vYGF7oFSRYFp9PgTo7mTDRG+iyk9RZ
         BzY792mCa7PMCecyuCuk98TSU5w98Dht/eomtbUcno4Wmf7twtsvOS4mtk/CFoWAGFyX
         pxCY3kSzn3Ox2OmK4GDnB/zYtcMMfcXGpCbq5I83nRbknwyMbnnxofP6OJNyqiIZ6vUl
         RZNg==
X-Gm-Message-State: AOJu0YxHbUFMcflupWf4H+YEm0qKKOBgXvBot5pQ6vl/eE/TuvpXdiji
	UkDmO95Di3FqIb1uQjIKBAxoTLQZ5mEi/XNjuv5GzxjmXUAj/I69
X-Gm-Gg: ASbGncs9MhHQo4go9MQTlWkBsxpw28IAVBys+Ey2BdXk5o5UcE41aiGJOPr9od6iqqO
	CB4GxUubhiOpmQeF/AYRnONXryufYk0trQSwFFS7/a9eC4H2hWoOk0FaKzY+851NdOw7CZomq86
	fRsmP1xT75XTyqyoI6lzK2jIG4aXHguBKG4nrmnJDDDTKCqC3+Y76aPNLXHMfm4+G+ryw0PFUrl
	8Ri7y+/J2jAZrHqcqsB1TwYqDS172zVxnAMI7V0ejRyTs6r3VNg6ivMT2kgWaoQK1fuXF2hWGfz
	ZKbcx6qNBRe/t/qyaEQLqq356FFLbz5bP6Pg
X-Google-Smtp-Source: AGHT+IFx/0siRxOU/edg7PdKAnN+Rvb480thGEE4tCnH2co+nDTjQYxA4mFuJhimuG/8H1dNFW0p3w==
X-Received: by 2002:a17:90b:58e6:b0:2ee:db8a:2a01 with SMTP id 98e67ed59e1d1-309f7ea6787mr6327588a91.30.1745626217835;
        Fri, 25 Apr 2025 17:10:17 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:10::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef09985asm4582873a91.28.2025.04.25.17.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 17:10:17 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	jlayton@kernel.org,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v5 07/11] fuse: support large folios for stores
Date: Fri, 25 Apr 2025 17:08:24 -0700
Message-ID: <20250426000828.3216220-8-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250426000828.3216220-1-joannelkoong@gmail.com>
References: <20250426000828.3216220-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for folios larger than one page size for stores.
Also change variable naming from "this_num" to "nr_bytes".

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/fuse/dev.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index fb81c0a1c6cd..a6ee8cd0f5cb 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1776,18 +1776,23 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 	num = outarg.size;
 	while (num) {
 		struct folio *folio;
-		unsigned int this_num;
+		unsigned int folio_offset;
+		unsigned int nr_bytes;
+		unsigned int nr_pages;
 
 		folio = filemap_grab_folio(mapping, index);
 		err = PTR_ERR(folio);
 		if (IS_ERR(folio))
 			goto out_iput;
 
-		this_num = min_t(unsigned, num, folio_size(folio) - offset);
-		err = fuse_copy_folio(cs, &folio, offset, this_num, 0);
+		folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
+		nr_bytes = min_t(unsigned, num, folio_size(folio) - folio_offset);
+		nr_pages = (offset + nr_bytes + PAGE_SIZE - 1) >> PAGE_SHIFT;
+
+		err = fuse_copy_folio(cs, &folio, folio_offset, nr_bytes, 0);
 		if (!folio_test_uptodate(folio) && !err && offset == 0 &&
-		    (this_num == folio_size(folio) || file_size == end)) {
-			folio_zero_segment(folio, this_num, folio_size(folio));
+		    (nr_bytes == folio_size(folio) || file_size == end)) {
+			folio_zero_segment(folio, nr_bytes, folio_size(folio));
 			folio_mark_uptodate(folio);
 		}
 		folio_unlock(folio);
@@ -1796,9 +1801,9 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
 		if (err)
 			goto out_iput;
 
-		num -= this_num;
+		num -= nr_bytes;
 		offset = 0;
-		index++;
+		index += nr_pages;
 	}
 
 	err = 0;
-- 
2.47.1


