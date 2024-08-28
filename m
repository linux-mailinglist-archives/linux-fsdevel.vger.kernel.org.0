Return-Path: <linux-fsdevel+bounces-27656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 416C29633B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 23:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEDEC282DB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 21:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003391AD3FF;
	Wed, 28 Aug 2024 21:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="PIvXS66T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201251AD419
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 21:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724879696; cv=none; b=r9awNp2hA8ULWXcphGDQNsLd/AlNQ/xdK3iVXcs31k4QdqGvKPL4JAkgCXotQweD8aLqhckCBXD5TN9Z2DAUXG+dwnCLSGlm2QYZRtO+2JD3xFo2epC3N85kwDqpHQSPKm9k+IHAQ7CPAXOUp1oqQThjw9qwoB4NPrODO5dGv9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724879696; c=relaxed/simple;
	bh=CcHyS6Bom3SQZBn4LjTJ0CfHs6M34Rvnq7tBZEB3EPg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IvrYHVVuUljBzolNN0IgcdUnEwIRqGrBydJTbcnnxd+iVNMQ6zeCLJif99feq9jjLDvPHzaLHo+Wj0b7IGwU5Xq+ntajI1mckzFDSZcST8+IqXUdcaYr3T/KhmMy3tF3+6izrZA3cjcKDEkEQk5vtPpC8ECvG+Qgr6ci5K+bW80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=PIvXS66T; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3df06040fa6so160896b6e.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 14:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724879694; x=1725484494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UYShWyaopsca1NyTpUxwtu+pR/ZJZzNE3uDTpWEJNBM=;
        b=PIvXS66TPDECWoHGsq5uqUx9w3mvqesh5x4yx9O+msM7pYoYc0/DHyIzoYkuc2OV5/
         nLsVu8w2qGBIXiJSlJD2uTcbrK5rzzl3pEOnEl2TK7lx5vr8eoeHDuDdYDD6yPjKkTW4
         Jk/wlyJi589JDGKRKnIzTbqy+Rcp85jI1XMwQoVpBXhloBtvoEhhvvYX8kR/JsEButdA
         e2knaub5godJ/OIc8TD/1/rDbd4DTP90Q1ytVIWmQuwE0YB9EFHiWGZdg86lPxdlEVED
         X10fYMIkw8Bz5foHKm2U3Esgl1s3tuxn5ubwDf9tT0XAreTFhTpJa4FVbx566UsaHdvE
         u4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724879694; x=1725484494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UYShWyaopsca1NyTpUxwtu+pR/ZJZzNE3uDTpWEJNBM=;
        b=C3DvGhmlT/XSahROgAxINTTlKlDo5vZ18U8i8gZwSgk1DZBIFOwZJVTbFI7Odj1Ebg
         dCUyyJYqdrJcM2L5wBmQYjYZZwQiT2WXTI065xdfrREri6vFaGQcGRNncYVN8j31VM/3
         LpAtG+cl1yyix7j0UQrTx901Pt2k3V6qzX0+UQzslH+1gM1nsdW/NYKSiqCXPW9FaGYg
         gtr0JR+YNoEhKA8eHf0XGgCE1l688lP4QSylGpiszgXI6TAD3IMNEB6G332ruOcD/m/D
         mZIBriGrjl9ZumlrbQxLcferWqSZyW4pZhbkoPzdhrVhl91VmxGuYcT40pR45qtcojvH
         AC5Q==
X-Gm-Message-State: AOJu0YyBQb3dOfMedEyktKZGR+r295doCYdDzlRo5pT7Vl+vnoMMjRH3
	/TeYYCLPi2swSBt+iNpi3fq14sBuAGcGJSuMqBTV0mGWz4SHUK+Poy7Gn6bVBd18f0y74ZlW/P9
	0
X-Google-Smtp-Source: AGHT+IGjtvhd2eR+I4/nw0bUxctwKBMWlFHJc7HHnEtcoaZAeyrZbCVspG/32FoJ9h5Ia1MqFWNHfg==
X-Received: by 2002:a05:6808:124a:b0:3d5:628a:a41e with SMTP id 5614622812f47-3df05f05ec2mr692532b6e.51.1724879693991;
        Wed, 28 Aug 2024 14:14:53 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fe1c58e6sm63969921cf.96.2024.08.28.14.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 14:14:53 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	joannelkoong@gmail.com,
	bschubert@ddn.com,
	willy@infradead.org
Subject: [PATCH v2 10/11] fuse: convert fuse_retrieve to use folios
Date: Wed, 28 Aug 2024 17:14:00 -0400
Message-ID: <91692a20e0f3282a819905d75bfe0d19bb5c8d5d.1724879414.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724879414.git.josef@toxicpanda.com>
References: <cover.1724879414.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're just looking for pages in a mapping, use a folio and the folio
lookup function directly instead of using the page helper.

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/dev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 7146038b2fe7..bcce75e07678 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1709,15 +1709,15 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
 	index = outarg->offset >> PAGE_SHIFT;
 
 	while (num && ap->num_pages < num_pages) {
-		struct page *page;
+		struct folio *folio;
 		unsigned int this_num;
 
-		page = find_get_page(mapping, index);
-		if (!page)
+		folio = __filemap_get_folio(mapping, index, 0, 0);
+		if (IS_ERR(folio))
 			break;
 
 		this_num = min_t(unsigned, num, PAGE_SIZE - offset);
-		ap->pages[ap->num_pages] = page;
+		ap->pages[ap->num_pages] = &folio->page;
 		ap->descs[ap->num_pages].offset = offset;
 		ap->descs[ap->num_pages].length = this_num;
 		ap->num_pages++;
-- 
2.43.0


