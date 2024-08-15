Return-Path: <linux-fsdevel+bounces-26087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B42953CC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 23:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E01F284042
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Aug 2024 21:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD10714BF9B;
	Thu, 15 Aug 2024 21:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="iBbntoeo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41AD1448EB
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 21:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723757773; cv=none; b=AqB1tVArc/ExyVMyjNtxbA2JOs+InrhS+vPf9dPEyaEM2dXCTCOTTHhaOLbRoXpEP4+hA9jBkLB/INTiF+SikNNIAoHg5GpfvZERK+LfX+sxeg6qM72lx7FRCiWIESBUmfKT4cFts2xNk87eMqmkau12g3BGmnmbPBeqEEZDIuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723757773; c=relaxed/simple;
	bh=mOac5qzzGyyVEGSWRz2iL+Q6O9hEJNRQVbnxA854O/A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jTB5uZLf1ogoQ9ig41uOtXIPaQRabPZKxvHmiKD1f6n77lSrOV6T/XsDGNpNEzxsMq7s98MoSEfsMXrSLHXheD7bYnaAlcHO6hUl44ME+oYltcrcSqCvVczQLd8vfABAGN4VQcr5Zl4JNLga70XiaPcD1in4UQVbB1d74VrmjQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=iBbntoeo; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42803bbf842so13210555e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Aug 2024 14:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723757770; x=1724362570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g68gIqBQ2QfEwT+TpHj5FQDPpGo/AVym/P/p31T0VSM=;
        b=iBbntoeoUyb0GXWa2nn5BdyFbR7W2kLVXukyD8WlDRxDL7E94AAIEYLrHapUAPjggg
         az5h9x4ptNL1dd2L2lDdFysUnUQwA7STs1evKcUfwIvHSVld1akiJDt+AqrYw10TUUn0
         IlBOv9Pd5P95PfDwiEhS66zKBg5HDNbnx0uk9wnbCb+a7lyZKwczQjl5X6wvWxGnbm4z
         NWPrxtUVxyroNG3RQ+LRwIVQ65OcIc8ZQj9cAubd5pJSOFoZ/ww/iOnCeWqiE5az3MKG
         Ql3SdClq/8Ky7XSFklKCnWQDhAihyDsxu4xlmL1I/5lopWzYAPEy1DLfevpStOY2RhyC
         R1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723757770; x=1724362570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g68gIqBQ2QfEwT+TpHj5FQDPpGo/AVym/P/p31T0VSM=;
        b=I2v7Frhsad9ooaYtlf374HOspjk8YRInHwL05zFy5hr0q6aNvuMPVN5icrvX0Uc4gu
         vdcdUyV2gDZdiXjcsehlR6ZG9ipDzqTOWC0XFDa+geu6zC4xfGHmiFFb4gjeYeeiGL1d
         C8mc8Pubv3W0SGfXBGpMZ+rTkPgs6XaQVzfjoZjAvPMWMBYvZL0LHv/wzmQo7pgxG+ph
         7aIyTDegST0jr9mfLKEbeygZX+eHLgVYdTxOhq5TSOQisuiUqxM6qthJ7wgSsywQBH52
         VrrZzfdFEyQC7AW+HEgp3ZislEMQwEQj7uSuXvNMDb4X6oV6i31GmBdXt64jlntXhrr4
         Bgeg==
X-Gm-Message-State: AOJu0YwrW+nCD95AqdWudP05ZyhNCydMcaG044g/M+GSeZMp6dJeqyqi
	YKy3P1GyS6DXwbcI6Lva8Fv0GRT03cibGZZnf4CU34Z/l8VG6EJ+WQ0yVAjEFpI=
X-Google-Smtp-Source: AGHT+IF4S9c0XMAnCX/TBjYmE2/4J+KGavrLYPeyZOETX2g5JKQV4Q7kt8/04Jd2nKjcOMSf5I5Ifw==
X-Received: by 2002:a05:600c:45cd:b0:426:6e9a:7a1e with SMTP id 5b1f17b1804b1-429ed7ed5c0mr4930285e9.35.1723757769481;
        Thu, 15 Aug 2024 14:36:09 -0700 (PDT)
Received: from debian.fritz.box. (aftr-62-216-208-163.dynamic.mnet-online.de. [62.216.208.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed6585d1sm4783225e9.22.2024.08.15.14.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:36:09 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: dsterba@suse.com,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] affs: Remove unused macros GET_END_PTR, AFFS_GET_HASHENTRY
Date: Thu, 15 Aug 2024 23:35:01 +0200
Message-Id: <20240815213500.37282-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The macros GET_END_PTR() and AFFS_GET_HASHENTRY() are not used anymore
and can be removed. Remove them.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/affs/affs.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/affs/affs.h b/fs/affs/affs.h
index 2e612834329a..e8c2c4535cb3 100644
--- a/fs/affs/affs.h
+++ b/fs/affs/affs.h
@@ -14,8 +14,6 @@
 
 /* Ugly macros make the code more pretty. */
 
-#define GET_END_PTR(st,p,sz)		 ((st *)((char *)(p)+((sz)-sizeof(st))))
-#define AFFS_GET_HASHENTRY(data,hashkey) be32_to_cpu(((struct dir_front *)data)->hashtable[hashkey])
 #define AFFS_BLOCK(sb, bh, blk)		(AFFS_HEAD(bh)->table[AFFS_SB(sb)->s_hashsize-1-(blk)])
 
 #define AFFS_HEAD(bh)		((struct affs_head *)(bh)->b_data)
-- 
2.39.2


