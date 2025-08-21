Return-Path: <linux-fsdevel+bounces-58619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 232B8B2FDF9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 17:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7616E1BC6267
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 15:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492AE2EDD51;
	Thu, 21 Aug 2025 15:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="BVN9FsGs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BA3283FF0
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 15:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755788988; cv=none; b=WhEjvxkqC+VLLcTIY7a5c07+KOnWYVlekF3yNMzDSgpadr7dfMyHYKScxNueL9WwJbb/SjdEmhr0usUQvndDR/LwUIp6XIKCOtO6aKbKBwpHOZ+mlAS4e/r4ErEvPa1QlUzhKZbvniwCF5ygi/TAS25KNXHlv/FHxFNATIYRdOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755788988; c=relaxed/simple;
	bh=OKjnd4X98tRpk9XuHhJizhKjstGINl6E+zDsKsA4jdo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W2m5RbiRqtpGIgiOjdNI/PAJAH+VmaHnlpurqE1F5oZESTsTBbDAAC+IZwFWbxlcZAopIgxAx8bkHH35JiOBtioACn6Uoc//mi6R5Cvb4GTd+5Z+kCHocRlo63pPK5IrIMNns+aK0kOQyTDbVHksNKSIkzhA2+jbUWBhmiomLvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=BVN9FsGs; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7e8704c7a46so127303685a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 08:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1755788986; x=1756393786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nvYZ3xwBzsmY6VteFa6Rk8Li/fQk5rtNPNaSWCyz9bY=;
        b=BVN9FsGsJ2ensFXqmpE2fgCjPvGGAjD6lQO4Bg2w8YU+y00WQ/KtFG9kcUXCXQSi21
         ajddKI77yoKkTI3Ugte62rmYi48Xf8w+6KgbgNtwpOphSmLVYBYz2UDTABIQU58Kz0tf
         dfZ5nf9dzCyzLq7W0pHcIbzjgSePFS4P1iI6WNjgY4A9WfWL7B3y2CRefz7N45rDDEIb
         mSCl8kiGTYbtRaitpdi61xnVD2kpBhUWdMyONV6LgeQScYwdFVzThhkeC4iWKOllLRtm
         +nZAzv65ICdMA6urIRGlPWl9yZtDqfLqDZ6DLMVVM5YrtaUOUjaZGNNctRdaP3T8T/8J
         1XJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755788986; x=1756393786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nvYZ3xwBzsmY6VteFa6Rk8Li/fQk5rtNPNaSWCyz9bY=;
        b=qc5QNptThAAL2HuTVwBCmJksZSlxLgI55rLu1Y522G1cw+jG0p8mKEt/xA6DwhgwNW
         UE9mc1Sjij1nfv/3unrRq/H46DCsZWLZa4+5L+licCOA2+BsbUf2en00kUg2zGZ4qiHX
         4CkrW4m+KOUSx9fctn18cQLjshfPkh0lF8oCJ4DLk5ezBu8Bax894QWfiRP51AKszwh5
         BrTFE9/TpPqED1/qC9rfLutXLZzAo+yFDPrAYoje8ybQ5qjeFvIQFsMp1LuSGWEFIgzr
         AhNAPlElZCkKDu162jn9aXCZt9mgVtVTnr076s0nHCBfoxopmND4zuU+VC2nlpJP3bei
         LseQ==
X-Gm-Message-State: AOJu0YyRiVWdTjkymJKr5CxS05fYxxkCwm/bCatoeHMu0DcJKNQMi0lg
	HLFiS3OS0a1aXYjm1n3LqOqqV6doim32k6UEjBl+T96H3cWdIZEoECUjLK4GHn43WBZK/dSCDE3
	VcYWg
X-Gm-Gg: ASbGncs72BZb7g79oD52lDeo3JA3t1zk3NrpTepEtmTR+V0oaniDavaKU/498XW/Fyd
	4CKNTuKVfsuL8JsaYH+rKL7+ZtQ0r+aSWbr5WpJExenFn5N8aVOvkBWSm0K9/kzP8rius2JtOek
	LpTq4Hzzq9e18YwpD3Xe6SGcqDYsM9nGpAcIxBDO5xg36i9iEBHekd+siwppOmePoLS3T5Tx2Hu
	Ns+DTwE+JbxtCqp5VoutVvZffwf9TgqSHd8asnNMOjqAerHPJi8cCgRA7mifw9kgp4nB2X9of8P
	NUDjwVTX/5GcNTxFr4SS6TB792MzUEUbXTMgMVn+PAkqeTn9xh5MTkqpD5icRU8rUhRep1+Wqvs
	Ousmk1hV/TeX3rMWLgsjXscQUP7AXzqWWj2e8Sg==
X-Google-Smtp-Source: AGHT+IGVtZqbXTtQtenHmUQZI/jmmKnotmOHRL/ZFHYy98fCdCtX+MWXTkJBHoo1hchd5d2SGjt08A==
X-Received: by 2002:a05:6214:509e:b0:709:de23:aacf with SMTP id 6a1803df08f44-70d88e8f53bmr32501656d6.23.1755788975417;
        Thu, 21 Aug 2025 08:09:35 -0700 (PDT)
Received: from ethanf.zetier.com ([65.222.209.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70d8b0e3e6dsm10845676d6.73.2025.08.21.08.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:09:34 -0700 (PDT)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH v3 0/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
Date: Thu, 21 Aug 2025 11:09:25 -0400
Message-Id: <20250821150926.1025302-1-ethan.ferguson@zetier.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for reading / writing to the exfat volume label from the
FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL ioctls.

Implemented in similar ways to other fs drivers, namely btrfs and ext4,
where the ioctls are performed on file inodes.

NOTE: I have not implemented allocating a new cluster in this patch.
This is because I am having trouble with using exfat_alloc_cluster.
I have submitted this patch so that while I debug this error, I can
receive comments on the rest of my changes. Any pointers in the right
direction would be appreciated!

v3:
Add lazy-loading of volume label into superblock.
Use better UTF-16 conversions to detect invalid characters.
If no volume label entry exists, overwrite a deleted dentry,
or create a new dentry if the cluster has space.
v2:
Fix endianness conversion as reported by kernel test robot
Link: https://lore.kernel.org/all/20250817003046.313497-1-ethan.ferguson@zetier.com/
v1:
Link: https://lore.kernel.org/all/20250815171056.103751-1-ethan.ferguson@zetier.com/

Ethan Ferguson (1):
  exfat: Add support for FS_IOC_{GET,SET}FSLABEL

 fs/exfat/exfat_fs.h  |   3 +
 fs/exfat/exfat_raw.h |   6 ++
 fs/exfat/file.c      |  78 ++++++++++++++++++
 fs/exfat/super.c     | 190 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 277 insertions(+)

-- 
2.34.1


