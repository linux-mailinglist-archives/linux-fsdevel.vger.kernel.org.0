Return-Path: <linux-fsdevel+bounces-58220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E860EB2B43D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 00:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D8011BA0725
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 22:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D307125E814;
	Mon, 18 Aug 2025 22:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="em/KbKsI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E231ADC83
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 22:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755557585; cv=none; b=ArB2vZfjKQbM7E+yzFSpj0m4cQnZcwOp/kHem/TO0cru3pRtg9ZFZuyKchVJRJ8tbzHjSmhXmcTpZX/a+WzEPaFjCL72rz3uEKx22Th6O3nrGspoPmLF028Lhrbqv6m6A6E63h7+2CngnMPK6yMkL46wdiJnMM6h77LzfGWKdF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755557585; c=relaxed/simple;
	bh=X9AiOBxrDWUBxcvGr4SHrHEf/UX6SU6UARTZ0UhyGNs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jdaOWCPdbu1+9RZKUM3Dq4gCVkAuh7r5KCMRf3EYxpEF0KXDWzEWgiwgiYFQqgG1t1wNrUErTiIx4Op00mHrty1yD8NizsDrAG2I+RsrFFKRMMwQTVBRjZGeP6albYREqIGBSKq9Ix7e49wFyn6pHQcQpewR/x6FhVORb91aogU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=em/KbKsI; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d6014810fso42172607b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Aug 2025 15:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1755557582; x=1756162382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zQW+7fBIPiveRS1MmyDS8JqPH/TmomZsQcYpmk1tatM=;
        b=em/KbKsI8pAmfXj7ug3yRRy5/twSE9ui03EQUDTUPAaZ+jwPw+yDX7BVG7PBTWNhy5
         G5dIohiBlRCz7olZcVCB9FdiiIkOvvIpubDUlYO8lLj5boR3w+HWwEyPxyt+wB7aQT4l
         VaIbJsgecYT2qMuM5wDWGWaqSjhV2wgylVaUyiPwn6X8LYL1IQeV+u8WIaPnVeQslkzz
         jf1bsNtebOFbBrv/8Pv+NTbL0d7NrdYrNwiuYdrjBxnro0KAWAvgWKs1AvsHawuft1L9
         0/4UD2JeikOIYQb8zDvmiFi/PJXvP0VaNMU64T3n7mzIWWORGNSjPNkIugmZc4971Qoi
         IwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755557582; x=1756162382;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zQW+7fBIPiveRS1MmyDS8JqPH/TmomZsQcYpmk1tatM=;
        b=RlyuplUBuvI+em1JlXk/UlMWmGBLIdLKY4Z2T9sLS4l41zbLrK+/LgnArelisBR0lN
         hGR16Q74EcHMvEucEfvqd7tuZlK9wbq4vM1mtQ8/zZzTMVEcmyXkTRdUrXlYQDaUs7qn
         eiiXvIHNnsWbTEH1zwehdH8BHFSulUzFCAJKENvfrOqsizLDDZz+rVeeUCChQLtjtmx+
         v2xlZlnpJETA4xwmrRasYpNPq6Ne/DBMJXgnJuLqjadssEw6CNMKh2y5nn3jvd2w2swN
         OHJ45ov4Z23LdpiiJZTtEcabUfroXevcnTbpaE0wEFiq8bw3qmkTllLkXRWBu2ty/Pda
         sXVg==
X-Forwarded-Encrypted: i=1; AJvYcCXM9xb1jz4GPitD1DIqWlegTTdDrils095b8BW2t3Yv+MbrDTxNyF3pSk5/uWSusidbxzoS1c4I3sFBIbBD@vger.kernel.org
X-Gm-Message-State: AOJu0YyTIR9LMqWedayuPlA+SUpddCK2zlDR2IG04S2c/kIU8uCOSaZ3
	AGOC/KSjFokpQzeKcGcpRN/O47iaI5XHhZyx4tSeSs855n2brkUx5KMUp4H70ETkRr6KGUwAdz7
	vwxjxbw8=
X-Gm-Gg: ASbGnctSBCRQG4PIoOU5j5O1QFyxB0eUpxdV8nTht3jgbxglxyeTrM3E2439eDtQdCx
	gJuky2Cm4+tcETRtvrbn1Y79CTJnCE4bvlX2PqO0mB6962cG8c2SL3x5c9XncTsk0hrajC5RQ9F
	BiGljfssKpw/h5I2xfx6GXSWbuIcP8cO0/+Tju9qQUYb1FLz5ftnPeHLQmKEwjK2ccWaWTYdiDi
	OCNTYchbUV6zu63jvyswTKBtoGBhNXn84vSM9tMRjpqFVMDI4GtnHeKEf4RZ1/13ZLPI5vF6vGJ
	T/DrKwY6GMANn0331I7XpfxnIm9BwGmrmJWm3v55G84o2f+WIK5lGNSRFl7OMXXqFI9OKbyfukZ
	LmGVVnFAVsLYzNYZLoDRe1PVML7fFNNDH1A==
X-Google-Smtp-Source: AGHT+IEekkfee5KQgWDSilmCZjuDBlF810Go2byNIz/lyq8/TG/rOo1hYqfL9xYzFu9dtTgmtqtRqw==
X-Received: by 2002:a05:690c:708f:b0:71a:2961:e2c8 with SMTP id 00721157ae682-71f9d55730dmr6947737b3.10.1755557581830;
        Mon, 18 Aug 2025 15:53:01 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:a996:9117:6d16:a41d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71f4e9dd746sm6869907b3.38.2025.08.18.15.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 15:53:01 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] hfs: make proper initalization of struct hfs_find_data
Date: Mon, 18 Aug 2025 15:52:52 -0700
Message-Id: <20250818225252.126427-1-slava@dubeyko.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Potenatially, __hfs_ext_read_extent() could operate by
not initialized values of fd->key after hfs_brec_find() call:

static inline int __hfs_ext_read_extent(struct hfs_find_data *fd, struct hfs_extent *extent,
                                        u32 cnid, u32 block, u8 type)
{
        int res;

        hfs_ext_build_key(fd->search_key, cnid, block, type);
        fd->key->ext.FNum = 0;
        res = hfs_brec_find(fd);
        if (res && res != -ENOENT)
                return res;
        if (fd->key->ext.FNum != fd->search_key->ext.FNum ||
            fd->key->ext.FkType != fd->search_key->ext.FkType)
                return -ENOENT;
        if (fd->entrylength != sizeof(hfs_extent_rec))
                return -EIO;
        hfs_bnode_read(fd->bnode, extent, fd->entryoffset, sizeof(hfs_extent_rec));
        return 0;
}

This patch changes kmalloc() on kzalloc() in hfs_find_init()
and intializes fd->record, fd->keyoffset, fd->keylength,
fd->entryoffset, fd->entrylength for the case if hfs_brec_find()
has been found nothing in the b-tree node.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfs/bfind.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
index 34e9804e0f36..e46f650b5e9c 100644
--- a/fs/hfs/bfind.c
+++ b/fs/hfs/bfind.c
@@ -21,7 +21,7 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 
 	fd->tree = tree;
 	fd->bnode = NULL;
-	ptr = kmalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
+	ptr = kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
 	fd->search_key = ptr;
@@ -115,6 +115,12 @@ int hfs_brec_find(struct hfs_find_data *fd)
 	__be32 data;
 	int height, res;
 
+	fd->record = -1;
+	fd->keyoffset = -1;
+	fd->keylength = -1;
+	fd->entryoffset = -1;
+	fd->entrylength = -1;
+
 	tree = fd->tree;
 	if (fd->bnode)
 		hfs_bnode_put(fd->bnode);
-- 
2.43.0


