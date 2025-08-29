Return-Path: <linux-fsdevel+bounces-59689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B18B3C5E0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 01:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 230F9178B7B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 23:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF83D35CED2;
	Fri, 29 Aug 2025 23:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Npl6RgPz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE23B2D877C;
	Fri, 29 Aug 2025 23:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756511910; cv=none; b=IOlh4spSQmr3FZ2z1hBUx79q7YDIN82MAhhXW1ZLJoW7iB2IRFC/AP9G4rjynLp2QUEo2xTqtUh7BP16aNO9J7dHkbIxrfCRtd2qtEqpzCiHtT91e2Zn7cllEKeWo1QlQEBkFVtj4K28QiDZNJhCSoJrMcpmuJBB/K7eM8GQf2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756511910; c=relaxed/simple;
	bh=zH/do5XxBs1HkUtFDJZI51iQ96L5yoQuW7kMOSzvXWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mJq3IXvFNHyE+vJ90p3N1u1k+CWaoITRFY0pHEAUYjbtGnEP2k/XOHtjAYGRmUwGNx2BHD5oFZ9ZwcFq7FvUF1Dvy7oNDJnBS4qM45ONDhTNuCuVXCp+o7Fjs8qh4fx564x8CkttpN4YFLcN+LUNfft4IJQ5r5nSdUWgYTq1L4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Npl6RgPz; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24a1274cfb1so156625ad.2;
        Fri, 29 Aug 2025 16:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756511908; x=1757116708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2u6sJG+KLbQqKao4V3rG14IuH9iR5eKYi/O/inLxJk=;
        b=Npl6RgPzx4O9mdUtxKFJ6Kg1tdRsplLre1n0HaWvaj7LzSLzcWjVdDawG7gisyOea2
         KGdnUh1+amq1HnB67SBuUm66gTkTDbVwROKZoyaEOQmaNlHIJgIsO1VDJtXH8b3q8FDK
         v1VumiukKX9kjMhvnKF2jkWxp/uh0tfoOCqQn+uxrzOUnpNqJTruahhFVlQatgHvCHuV
         z6Vcaph+cr8WDQOETHHJfbbXy5iv956JW+14mnMWzHXZPQFVWKZF6hZLPRWyMvu1uyrj
         mxP0kkzjEMM7au9hoqgTeeAVIQZurEKnF3RV+BsZ0Bh0myXoCXxxP6q++ANprpLViOtm
         vK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756511908; x=1757116708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2u6sJG+KLbQqKao4V3rG14IuH9iR5eKYi/O/inLxJk=;
        b=Q2EGvsghmk9M7row3quI2QWK3MG7s3DLn4cwFasv8NoBVulMHMsETJSm+YjJUIrE8m
         eviYQj9CIOxhrQZ7LFnGnYKS5kHIO7U+aJSx0k/9xVA8sKygyEJQoRf8iPDwV4yuXF46
         LPHWVttQqK5D+RobEV4PUJ6bvb15w0aYGX3s3NA/W2YYTCUs2a1C523A+1Y6TeujBybr
         hAUsHtp6SJwG58gijwNAqrWjowlPQ8Y5LNQh10AkDgofsRThw6IZCu5+ghnFe3nKfIqV
         hYEp/IK81ss6c1qmHcemI2f2dVGdwQwiHoHCDX0UmcSVg18U/hVu2nsfeJyus33ScZVi
         W5Xg==
X-Forwarded-Encrypted: i=1; AJvYcCU0vpWul3mTENSc4P76YJbgTjRiQMzyWdquRzUnjIefNqBgCfpy145iDB2ppBUAO7bC8vMhG9M8HyYu@vger.kernel.org, AJvYcCUZu9a5YTQFYGH5a3iYGCmTjABmaHIdhfybIFTfONsDTx3JXnqSXGCS/zk1MScMHboo30eKXt9hAzQ=@vger.kernel.org, AJvYcCVdx/bnlx94BKLVgalTrqzdCWOYWqd2cOv4nFGTPt7Z2C/+oLYRgCQP6GviJbCybeGcw6vUj6O8xc28viKJqA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLZ0xHCnvvwLIwaE6RgO2IGT9iLLfu4seQlR4ASR/7CPNw9Ga/
	ve76xaw1tF1VAihJnrwAj6+1yAL7Gpqxuq8hQ3wtu3fGcNXjHUN0l56W
X-Gm-Gg: ASbGnctB3gUshKsbMrbrUcXeQCA3/CZvBFHKHJ3YEqTndVwwYoFhUFqWropuPIkU0mb
	Ws3E47CF0RGUUjE5cL9pWXnhDobxk2u+x6XH0WbswFYuWiGwiiMq5ltsgxZ1MG/2KYtwO3wYOir
	t2xTherkERvQxmx/nPsHGk+o/DPXEBifJ3Kv0KJnsJSqz9d6ngIaeci8MpCY80aVULgl5f0S/BA
	Wvrgc1o30FuoeOgUQUfa1o4SnMFunuKJcOMBE2T9k0msjRVMG3bDvR2QrV3SopwsE6ELay1Bzix
	HBn3GbzfHRi5fcmESQ/zRTSl5Zu/yTke+MSQk45Lgx5oAnq3D+mPqd7F8Pdtnxi+vf0yjTQNfWo
	jvskqeAvgpKaeV3HcuF38eBMFbpsK8R8d+3tFgw==
X-Google-Smtp-Source: AGHT+IE45QruX+kdX6mWvqKOD7zyLIz3isQ0tr95vKTtf7O3MY4elF+lUNMiyuspigxZVw+IOwQ6wA==
X-Received: by 2002:a17:902:d54f:b0:249:3027:bdbb with SMTP id d9443c01a7336-249446d2688mr6755865ad.0.1756511907977;
        Fri, 29 Aug 2025 16:58:27 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903705be3sm36617025ad.18.2025.08.29.16.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 16:58:27 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v1 08/16] iomap: rename iomap_readpage_iter() to iomap_readfolio_iter()
Date: Fri, 29 Aug 2025 16:56:19 -0700
Message-ID: <20250829235627.4053234-9-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250829235627.4053234-1-joannelkoong@gmail.com>
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

->readpage was deprecated and reads are now on folios.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 75bbef386b62..743112c7f8e6 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -444,7 +444,7 @@ static void iomap_readfolio_submit(const struct iomap_iter *iter)
 }
 #endif /* CONFIG_BLOCK */
 
-static int iomap_readpage_iter(struct iomap_iter *iter,
+static int iomap_readfolio_iter(struct iomap_iter *iter,
 		struct iomap_readpage_ctx *ctx)
 {
 	const struct iomap *iomap = &iter->iomap;
@@ -514,7 +514,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	trace_iomap_readpage(iter.inode, 1);
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.status = iomap_readpage_iter(&iter, &ctx);
+		iter.status = iomap_readfolio_iter(&iter, &ctx);
 
 	iomap_readfolio_complete(&iter, &ctx);
 
@@ -537,7 +537,7 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
 		 */
 		WARN_ON(!ctx->cur_folio);
 		ctx->folio_unlocked = false;
-		ret = iomap_readpage_iter(iter, ctx);
+		ret = iomap_readfolio_iter(iter, ctx);
 		if (ret)
 			return ret;
 	}
-- 
2.47.3


