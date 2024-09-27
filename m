Return-Path: <linux-fsdevel+bounces-30282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE98988B75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 22:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66A1CB24B7C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 20:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8EA1C331B;
	Fri, 27 Sep 2024 20:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="uTW+Gx+Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EF81C1AB9
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 20:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727469957; cv=none; b=Roo6Oh15sS3MPzt27nGA/+oKpZ1eIlZk6yO4W38s77eZFogonN04GawyG47q2qM+nzYLImmn4c9Q48z1qNHStKZTKSIxYwDo8Rt3uGCI02k3vwR9I+iZiHj/AZMLCDB8MICCb8r5mF8ipHkxWGr4Cuk/wcmN2s8HcCD5yIuBr1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727469957; c=relaxed/simple;
	bh=wVISCudRt38hav0ZgW6Oe4SSnOs/IfFY15A7fvAwhTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZgMIrKlo93nx+F0DL5wWx6xZOBixs9AeM9MZ8jc4N+uvJvzgUAMU3Epc5joYaJrqEf+oKhQt71r6/3lg9DjVOqkvdSEiqzbVZhJEHpdg+dMcpHVKvvA9pJDx99ldVdDqz0p4nG2ncc0GM79N4lO5J3YOYGtfgT4x5QeVnc5b2h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=uTW+Gx+Q; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e23aa29408so19598667b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 13:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727469955; x=1728074755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j74oib4cu11+e7bTznb2eAYbEwPMzV5mPl9l6fM+GTg=;
        b=uTW+Gx+QrQFymaNx67AGmy+nYnmtx5l8JpFL66+o+IHpv6QFUnTciqi9+8Jaymcev5
         oBiJgS+9wiqVNLgLG6A6unK7KLu+uUd352ExFbX+k99PzKOaC6z5VqN+IO16RRGAuGmj
         dUgJ+iZ+hcccx60Mq6eyujzFaEdOTXkHNlrpdXNCvm15cyrt4x73HfoWXaY7KdK308xc
         U1nAZ7Uztd4p6X9Aci4HtfpOTKikRQ0hadOEpq6s7vs8Hq5R0on6orhVz0S1bqir92e2
         s9gi92ScsrL4XqpXe4L0RTgPyWN0AKR5UstdQTUuvpE+ax51rRQZlMHM4vDP/4Wvp84D
         eiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727469955; x=1728074755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j74oib4cu11+e7bTznb2eAYbEwPMzV5mPl9l6fM+GTg=;
        b=GL/8kfBiV/XWiayvVFe1zO79k0gsmn/vvSYhutkVs8wDsFLYL8elC/A8mhH6r9I2tu
         subzRd8ngYInGRl9WUMtbSAlpSezixRH/xciPlzyikjVjbP2xXOtqXymBV8hKld71rZa
         gNYe9nTKEZymee5tgFfm0/4eXp0bk1GeW8AIi6p+ZEb+WCCrEE6Hj559007Y+u3R2N20
         Gg9myVnj1GoZXD8YVXLsqeBkVNTP2Ogqr9Wzdcyv0XjAa7AvNEokB97YeXPm/c6mzhbm
         67ulgtL1Bb35DMqR1F2MrxpTV8fJAXmi1gMOuxEJJ9cuzxUdYcoym7aAB6AeQuwOtRn+
         nKZg==
X-Gm-Message-State: AOJu0YywiqxQkKJWAgHPTVqL/hqrVGNQhhU+Avksk/rWTbYppIgAcj4C
	j5+9RVRowPvpgnFIYnLH0jn0DL+3K9Et8mM9nxREjG2Krl7XwSvBSuHHa1rT0+0d5dpP1l090F8
	M
X-Google-Smtp-Source: AGHT+IHZyGxm7wwuRxV6fZ9ZYijhkkFE1PYR/OlTL3n5e3gRe1Py0XHlvrgo2WfVYbrXgbhK5OjyMQ==
X-Received: by 2002:a05:690c:55c6:b0:6dd:c6a8:5778 with SMTP id 00721157ae682-6e245386765mr36266807b3.14.1727469955157;
        Fri, 27 Sep 2024 13:45:55 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e24530a961sm4207717b3.36.2024.09.27.13.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 13:45:54 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	kernel-team@fb.com
Cc: Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH v3 09/10] fuse: convert fuse_retrieve to use folios
Date: Fri, 27 Sep 2024 16:45:00 -0400
Message-ID: <5b0e4f2c48a04d66dfe70f8228b05ebc53be6a00.1727469663.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727469663.git.josef@toxicpanda.com>
References: <cover.1727469663.git.josef@toxicpanda.com>
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
index 1f64ae6d7a69..4c58113eb6a1 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1756,15 +1756,15 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
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


