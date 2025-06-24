Return-Path: <linux-fsdevel+bounces-52669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2103DAE59FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 04:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A58F1BC1925
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 02:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714D723ABAD;
	Tue, 24 Jun 2025 02:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuygD1wt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC5223BCF5;
	Tue, 24 Jun 2025 02:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731792; cv=none; b=Pv00wV8WG4l5Hp8FodAdXBEn1L61zvqZgBCVMSy9IH33hVhwBVRg+j9hjMjq5eQtQ/lV+cSNmcdJRIjrKpEW1svnK9ImvJhV97j5EkCaRdWSE6OwgD+wDB6MHKC7zqQUayOYVc1FDR8UWWDN187IE8wfxxna2r5tPEFxgdfW2CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731792; c=relaxed/simple;
	bh=1omTk1Ch+v0J61SN5PsUTdcgoiWHtCmb4QEydnVokh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4HFwFl0EJHU6z3Pk8wo+1TVn3Lpm1TQx64sY4t2xwDFhZ738ixco6EPxfJWnEO0tFJRMDntVg6wh5CKo3qtgC8jGpBPTjnYTowrcxRUyEE1WN0TlDwZ4zL+8LevJNvE7RRsH2kazNDa3QPh1r8KWogdrPRTKQ9V9QCEl2t9aMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuygD1wt; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-235f9e87f78so51442955ad.2;
        Mon, 23 Jun 2025 19:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750731790; x=1751336590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tox0Qswx9v0l5ZOogOjVwIDqVz0HHeeI62d4g2LDVOc=;
        b=XuygD1wtfEn5OHmrc4evdP1f5LmhVx5TIE7zAuWUsfl1lmJs0wanAGUKRwFwDnyzGd
         GPc/yL2a0E33fqCmFVWA3Bz02cLWElW/fkglNmcb+8GOQKCx1Gd0BNopq9/8+guXm4MG
         9WPH39nL35ag9/SXvmHHozNELPJc05NRsNz70hnGkuZ2rnwNJaN5n5MFsa6UnTH4QhRR
         SvG22+yMMyUVAK2IUOHDImfmFOVNOa24d4UVsmVcXShUyR1LTwCqLey3qxg29SK6TSMa
         MIt4ZMnsoJ/1IGpXcgfMVx816ZpsP1yMF6q46hpj/YZgRydmjsX5gJStWvvjkCp78IjK
         jzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750731790; x=1751336590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tox0Qswx9v0l5ZOogOjVwIDqVz0HHeeI62d4g2LDVOc=;
        b=mmLRC97Zh2b6RzK2AaAv8a1SLTnSfujAC4i+X6InKpVKo1tTULe3p57pGSG5+Q81rj
         LBSGRcactJ4yQ0UPNRUs9wpr88ZRmx5q9GYXeJ8vyQ09i1Bazw7SLkMGETI92EEEok5a
         RYUslhSO116+NsjSJcSEQhA2aRbonX6a+X9nAaIvC2YjCB+p2TFlpAaz/e/43qNelGmR
         4QweMGAlOm8aM6STZGAN8m7YQUMdBJ5f3lVmaK+9l3FHmFjyHQO3TQr2AT0w+6y0TYRd
         31rpTVHQ9J3ubARyOD5gZFt9b5MjDsOdMl565cr64Yw2wxlzwtlqtR96wsBYIQRSXimn
         9GTg==
X-Forwarded-Encrypted: i=1; AJvYcCVMIey6tVRT8OO4L7HOjGfX8a1Zm6MjVoNQ5nVspiIMR/bgAGg2aeZRv+ngNraO6KaA/WpSxVJvARbU@vger.kernel.org, AJvYcCVVu2g41NWhUNT6CC+3VQ3cTqPTXA83vhxf8Daf9Gi001ma9oYsrUIkt8xuyCh9GuffkY2Kq85sUL+v@vger.kernel.org, AJvYcCXZ2Mb3DWo473jW0T8PT/36fnRwKrVVicc/wrs2Ep/bhhi8VQz5bbQWmLTuGQH1aIumwhVvMeUGIcyD7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1aNNByuQRw3Js8jzZnCdG51GB7G80VXX6IFUOgtEGcAWITYYF
	BkRLA16oOwFqbsKoVH2WY9rPgZvilNZWw/Rg0OXgHbZTYIY+gGhp33rwseRZHw==
X-Gm-Gg: ASbGnctRIYZubJO0lMd/MSbYwvOsAG+Df/0DkUOEYjClbEfmePKj6B9TeECtrwyxSEc
	F1bMtuQRqfj7eQyxaLTR/M3ABjDfIneribvYPKBy8/0n5k9WvUTjwqQonVQC28uDgyZPqrKgAJz
	HkEVgmjfQBrvZqMB3yC19c0g0UmLkBCapoLs3vgwlqyp1MPAxWY1PthnUFpLommPXXY1Di/I/BJ
	osK43uLzdW1MCI3tLXYieYbuOSyE9u8HPrydiaYmAJ/IuAvkZc7gIPSELkm59hH4jJy5/jXgSW3
	82jGF5F+xsaZ9yeF/VoSChCneq1wdf67oMjit9WC1F7akwigDOvEWZx1
X-Google-Smtp-Source: AGHT+IH5CRqWFclGp4+pjO3Krc9w8Dlmdz6YsBo5B17VXk21dqxgX65WgOovZM324PVjmcp/pfeQBw==
X-Received: by 2002:a17:902:d543:b0:234:a139:120b with SMTP id d9443c01a7336-237d980d666mr220447735ad.11.1750731790587;
        Mon, 23 Jun 2025 19:23:10 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:a::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31f11a20c8sm9120603a12.27.2025.06.23.19.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 19:23:10 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: hch@lst.de,
	miklos@szeredi.hu,
	brauner@kernel.org,
	djwong@kernel.org,
	anuj20.g@samsung.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	kernel-team@meta.com
Subject: [PATCH v3 09/16] iomap: export iomap_writeback_folio
Date: Mon, 23 Jun 2025 19:21:28 -0700
Message-ID: <20250624022135.832899-10-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250624022135.832899-1-joannelkoong@gmail.com>
References: <20250624022135.832899-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

Allow fuse to use iomap_writeback_folio for folio laundering.  Note
that the caller needs to manually submit the pending writeback context.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 4 ++--
 include/linux/iomap.h  | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 2973fced2a52..d7fa885b1a0c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1638,8 +1638,7 @@ static bool iomap_writeback_handle_eof(struct folio *folio, struct inode *inode,
 	return true;
 }
 
-static int iomap_writeback_folio(struct iomap_writepage_ctx *wpc,
-		struct folio *folio)
+int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio)
 {
 	struct iomap_folio_state *ifs = folio->private;
 	struct inode *inode = wpc->inode;
@@ -1721,6 +1720,7 @@ static int iomap_writeback_folio(struct iomap_writepage_ctx *wpc,
 	mapping_set_error(inode->i_mapping, error);
 	return error;
 }
+EXPORT_SYMBOL_GPL(iomap_writeback_folio);
 
 int
 iomap_writepages(struct iomap_writepage_ctx *wpc)
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index bfd178fb7cfc..7e06b3a392f8 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -465,6 +465,7 @@ void iomap_start_folio_write(struct inode *inode, struct folio *folio,
 		size_t len);
 void iomap_finish_folio_write(struct inode *inode, struct folio *folio,
 		size_t len);
+int iomap_writeback_folio(struct iomap_writepage_ctx *wpc, struct folio *folio);
 int iomap_writepages(struct iomap_writepage_ctx *wpc);
 
 /*
-- 
2.47.1


