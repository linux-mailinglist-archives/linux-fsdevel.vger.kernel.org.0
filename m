Return-Path: <linux-fsdevel+bounces-58640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3934B30625
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 22:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69B81621C60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 20:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8229F350D57;
	Thu, 21 Aug 2025 20:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ifMkrRm7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141E1350D59
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 20:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807623; cv=none; b=RpIF1rxgzoGSHhBTm9EG3y2T1kGO3MRRBk7LL/PblhM2UUlKfC4DWkQEn1YxqGSDg0BhIDrMBe8ivkptnzkpo04qj3yEz4t5K6efUr7m4d/+O+/Sjpfph4Fo4ow00raXAyg5Q7wHPdaY3eXiHaccrKyoYulhUMbh9nh4uOo3Al8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807623; c=relaxed/simple;
	bh=aMn/6ao90XzzaC4s0c7CDFRUmP2ZTM6xnRau/8BGgmM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IVvuR5OiqUPzKINnEAkj40651c4mA9e0MbMpLVS2fSi/TgRyr39Xyc/QxGbI3DVE5dBCFz9Blz+arSyjHORj69q5sNUDQlsgI2uc/vnGJOXjhQtj88edzAGkmxQVZ14ZqGx5MXr/bq8qXxuc1FCeUleculYG//xOoN/Q1khIg4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ifMkrRm7; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d60501806so12163477b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 13:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807620; x=1756412420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XLN4UbEHNtGwPYNoqmeGrAHZvRznKShz2RgBNkDqb/A=;
        b=ifMkrRm7ay32qJZgOfIEyjhwpWOScgUbN9sWTuHTBsvcij8ymIcrx+ONEZeZ0IBn22
         TIG4gT552lSvTEOfdc+23VuK1CnpMb7w24kAPoRJAAlzCPO2fvkkTG0gp3xPyRWx4dAc
         re/lAV9JBg2TrweT+tevjQRsJizGAS6anJxRQ1QN4Kl6Jfqr3quDpGPo3r5hodCNZRLR
         plhTPrivgk70/GRWVmX6c8V0Sz5dioG9oGQs29DVt+vVs09UXpovNCxZb3b0juF0iYLG
         BMuJPKxZqi3a77vvxecvjU2YKKzRElCisRqMuoVmvwOMVoTtZDfq6x5ivJwWaiFuQ+yW
         nrxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807620; x=1756412420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XLN4UbEHNtGwPYNoqmeGrAHZvRznKShz2RgBNkDqb/A=;
        b=NHMlpmvGzS/TbxCRC0pV4HRQjjZsSxnXJq2UwIRkaN36qsCUrszq8n1Gu7O6IxSV7K
         EU8vtyEgr+b/cgWzouHhj+Rt6//B4fPsgECFzLWcdgekcOuazWw/aeGAJUGlKLGcbIJA
         lR7Xtkdi+bDhDP/cOSlivx5LeRAryvm3ePxIgxIEt+CP3a2gHYjZTk+Q/AwAQXkNnwPF
         r1aiiwZbuXLV48rt70sM6r9+NX/2Y8x6GpEQ9psAYrnYsw43ADOxRPT2b49DZ/DD9yBt
         oAQBdns7GwoM1xX2ar3W3J0P3zcbKAiMoZoQ96wyYgVNXsn+y6ByxGJukW9m/8v0g12S
         YO6w==
X-Gm-Message-State: AOJu0YypU8kxtYx8cEo+llgIE1bd1UZPadYQxZKRC4AXnNOKofGRmNFI
	x3yMktmY2ni/2VzFwogD5G4maxL3u5eg+TGFAzq4NwJ8iSbEt5cmiZQkyI9XGzo/pYK9KQKFQDP
	Dz0rKR7LCFg==
X-Gm-Gg: ASbGnctoPvXskgGHT+F+84XLzYqSMAz5KrZORZHdXWJSfOCqgtQOr5zOd8s8rhA26my
	GJQ6cqEgakfS53Bqv8k37sJI1Qhlo9523loO+PnqC41un5F78QgrLdYb3VQ/VHETVShs3CoYbgO
	E2y/9GEsFxrEqTOSsKR8UpVYAGK0+V0C0KT/GuQQs7awrgHERopyjVwGCtFHiFo7vyIL8uW31P5
	EnNuhZrdF7cxYAz5v2BxT8zN2kYUIgb5nbQkwAIIeWTyEWEdJqNV+jsi8IAZJWRUupMKlXKxeqU
	C/3MwZMeFiXdKkKxVu0At+k7VO6OR0UNuYBMQDxYhGSop9fODz/PHh/6M2F955t17zP/UyJLDHz
	ZhfD5cQGZDuTs4oZ/7iBsCwTYspBNaYmd53C4LbmEUB/sHQh+GKBsAVv3zfDiM+ydLEW3VQ==
X-Google-Smtp-Source: AGHT+IGb0qgYBLWVZIch3EbtVHWOhrkqQCA2jAcmKvem4xmtzmk5uwLi8F7ETWvIrlxUB1p8XxL6IA==
X-Received: by 2002:a05:690c:6711:b0:71c:1673:7bb6 with SMTP id 00721157ae682-71fdc326e68mr7121847b3.23.1755807620154;
        Thu, 21 Aug 2025 13:20:20 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6e0be8b0sm45782287b3.66.2025.08.21.13.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:19 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 03/50] fs: hold an i_obj_count reference in wait_sb_inodes
Date: Thu, 21 Aug 2025 16:18:14 -0400
Message-ID: <e8edf6189d036e2222ed2094cf625d3cf06e0111.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In wait_sb_inodes we need to hold a reference for the inode while we're
waiting on writeback to complete, hold a reference on the inode object
during this operation.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fs-writeback.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index a6cc3d305b84..001773e6e95c 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2704,6 +2704,7 @@ static void wait_sb_inodes(struct super_block *sb)
 			continue;
 		}
 		__iget(inode);
+		iobj_get(inode);
 		spin_unlock(&inode->i_lock);
 		rcu_read_unlock();
 
@@ -2717,6 +2718,7 @@ static void wait_sb_inodes(struct super_block *sb)
 		cond_resched();
 
 		iput(inode);
+		iobj_put(inode);
 
 		rcu_read_lock();
 		spin_lock_irq(&sb->s_inode_wblist_lock);
-- 
2.49.0


