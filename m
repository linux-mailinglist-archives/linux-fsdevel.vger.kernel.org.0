Return-Path: <linux-fsdevel+bounces-57730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8657FB24D31
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 17:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D3D87BB099
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 15:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34B520B22;
	Wed, 13 Aug 2025 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hrgvEIFj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FCA1BCA0E
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 15:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098422; cv=none; b=sKQsgMzatvVMhAxweUWPIGdVp1XJfNV7w3Rj+g9CmupN1b7kfFjlGQ1KKpLY4OZ55/DI/EtDEYenhqM/nQ5eOJzuHBmBWD/kpuRP7H55QHxYoNaq/IYbph65OLZd+HPeQx8UGniNMLuxUbd1yFQQWct9ftcS7bEd1YZK2wp+HkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098422; c=relaxed/simple;
	bh=r0Q3/TPCWCj5je+U2rG7EyAr8ROhxwks9lmR/+AGuGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dyDZ3MyUobM5oObN5HSMCDbOhuhtBDjQ77h4XPDS3jUVxa+H2xSU3QKMzTh4WkeSxQ3OflQTNzTVQsGjI1YQ4SIxDEU28V63Eyo6ZKN9H5DYLyTiK4ctkxT6DhPd44UiUB/02IWd2DbM/FOv+4Rn+WaE7UbSzav0agddF8h1BzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hrgvEIFj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755098419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vBBwUljDcx/zXCckv1PYYIXd77ivcdUmswrYLYVNyEs=;
	b=hrgvEIFjt/C9LGKvwDWhm3bwouVdvzeJpEkz0eJWHFfI6HjagPXeHrcfjT6IiPpGc70zEt
	e4tTH3grkA/Zy0buH+54AAFBIUAOpMZr78YkCU0wyqTl3CCeZ/K/KDcoIckin4tSbuw/WD
	uBDoeEEyYFQlFaElUpXAZIixQqafixQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-9f6cAgVjOM2cvqvKUqR2FA-1; Wed, 13 Aug 2025 11:20:18 -0400
X-MC-Unique: 9f6cAgVjOM2cvqvKUqR2FA-1
X-Mimecast-MFC-AGG-ID: 9f6cAgVjOM2cvqvKUqR2FA_1755098417
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a15fd6b45so4121905e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Aug 2025 08:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755098417; x=1755703217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vBBwUljDcx/zXCckv1PYYIXd77ivcdUmswrYLYVNyEs=;
        b=FDnxNWwqd78QArU3twXEpXcejSVTQJReU14VPTJtFq9lEAPLJY8D8jCO0laoEFRUjk
         sR5QVb8iHri5AEjRCfAekCgJ/V3VMaefbLsVAV/AWp7SK4Wc+hMfqmae3oEgLROmghwr
         /KmnnhFH2F6pqCwXBOwvvrHGMpcWtV//nuQECOHY/cA0U5HmVf6FDnmCTy5sRZgjoyNc
         FTRUi0waZNttIvkvtWIuKBjVcTZC3sLk/jBYVPW8tMm0ZaTK/neTxdmxowSMVJanTgCq
         hCenwzDbwSquO8WnT9XUMFTuw7lEdQT9TZmut2I5D7osSEyQhcEX/yOcNVPoySx0RpLq
         C3AQ==
X-Gm-Message-State: AOJu0YxmnyyeRl9l6eqZFnvHIlE4936x5HMOr0QjwrXDc0we3/HRF4s7
	r2A3bveIv0uTo/Lizw1izjZpjRkKu1yQEZue/oHq9VWXX0d2VggX9+lQQWF6bseAxPc0Z0p00rj
	L3gK0dAOgTFQ/aAExr6kLcvsO2rG2B0a1R8MZGjScnFjgaWE3oLrwYOSbtOyuOMGmcd4IthiLxg
	S4aUKyzSLUfir+h+icXgSPASM69ovzTA/sgfaFcvdCiMsqmX2St0jMAA==
X-Gm-Gg: ASbGncuqZGGyiK/AK8vDjl7TzMBbScgF1za6litYduu70dP1bNvQN+rSExdhjuyqJIb
	L2d28/NRh9rQdqw/cb1W+57QOiivUc40RDm8o/DRUQWBRo9yDDnIqfa8eO7Nxz0HIb8t9j09MBU
	uaNGs1OcgH8QxCWbHASlacHHDhiaG1lMrymTgHfcURuRi6y1tBssaoXjQoEfMSgcCCsklxb8xYR
	BVoSK1jGEwngfol0Ojn07XzJM1BQSkkXKEN/kTRNHm7FG1KSD+Xe++VmmHDWLZ3sXtEVHIymooC
	X+jF+2Ym+Z9P03yNqaC3YTUAOenJ7QL8Q59PG5q0mqH9B63C7nkBdhqE7sJOTNP2LBOgHhGlgNF
	0jc/1zT/INFSB
X-Received: by 2002:a5d:5d12:0:b0:3b8:d25e:f480 with SMTP id ffacd0b85a97d-3b918cfb0acmr2903928f8f.29.1755098416754;
        Wed, 13 Aug 2025 08:20:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3/zULV6kQbuZMuhssdO5+fvj9bGtqdyLJITmdRCAQRtbG4jld96gvqoe4Gt3nJ+yVo+D1wg==
X-Received: by 2002:a5d:5d12:0:b0:3b8:d25e:f480 with SMTP id ffacd0b85a97d-3b918cfb0acmr2903897f8f.29.1755098416259;
        Wed, 13 Aug 2025 08:20:16 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (94-21-53-46.pool.digikabel.hu. [94.21.53.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c489e81sm48584381f8f.68.2025.08.13.08.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:20:15 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Bernd Schubert <bschubert@ddn.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Chunsheng Luo <luochunsheng@ustc.edu>,
	Florian Weimer <fweimer@redhat.com>
Subject: [PATCH v2 0/3] fuse copy_file_range() fixes
Date: Wed, 13 Aug 2025 17:20:10 +0200
Message-ID: <20250813152014.100048-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix 32 bit overflow issues.

v2:
  - check for return value not exceeding requested size [1/3]
  - split patch: limit copy size for old API [2/3], add new API [3/3]

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
Miklos Szeredi (3):
  fuse: check if copy_file_range() returns larger than requested size
  fuse: prevent overflow in copy_file_range return value
  fuse: add COPY_FILE_RANGE_64 that allows large copies

 fs/fuse/file.c            | 39 +++++++++++++++++++++++++++++++--------
 fs/fuse/fuse_i.h          |  3 +++
 include/uapi/linux/fuse.h | 12 +++++++++++-
 3 files changed, 45 insertions(+), 9 deletions(-)

-- 
2.49.0


