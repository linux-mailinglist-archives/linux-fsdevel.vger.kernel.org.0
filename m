Return-Path: <linux-fsdevel+bounces-30275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF96988B69
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 22:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49DC9B21F1F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2024 20:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0311C2DD2;
	Fri, 27 Sep 2024 20:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="wxzftcrc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80361C2DCB
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 20:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727469946; cv=none; b=ST5+7z7UJ256zPi+kaP6ecMQZltVLeyLKRgYv69OnOGcAJkvGcmpvjnPbzrxgboaAG3OO0A43No/8lmfi6z6KB2GyJAcA0jMaWUUq2/sj0S4SOxEJtk8HeFpEvnOeuPhhDJWrhmAkpZQa3kUEfcZUDa0yS8EWLKbsG0CNpFS2uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727469946; c=relaxed/simple;
	bh=RweBD+yjU5RwYLC7s7RlewvuN1G9c+cqDexD026qbbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mphqwTcKRHck5dNy+2Yj8B1dFoWaL4aJ6q04DZcy+emvVcSYs9kPVUJ9kP128+lyy9yg4QKmeJGGWDVW7XTr4F2NRfqxfMCEmOeVnRG8tsS7hRmBB+3zsTFULxW/VaUqXzq0AdCbNdm4IytAyLWIQqdVQR/9JRJzYSJZy4P6ESw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=wxzftcrc; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6e232e260c2so20722457b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Sep 2024 13:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1727469943; x=1728074743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=md2Dl5H5eCKwtjG8j4VlEsjGa9FrCXxESC22tm3GiVY=;
        b=wxzftcrcg0cERJ0ljAj+00TL2iwzGzS9vZItekrvmwTBv6uQaLwPJnfzjEWYCoEFVe
         nod7kzfDd02k7+/Fs5XBBY10Nah3EjwxFrhiusJzMuYk+5pV70v6iP7NTtWH0XPRWnQG
         vAsJpqzqmagE7bWO4sNCI6wN0E3yy2AchLxbadBsYyaui62ddLU7S97Py1o6OBtIS4xk
         vQ/e0trGPufpUg/HyvxgiUmhAEuvY9DkF6NyLbCWz5fLJp+EZUnuuo/BLmcCJvy7ip5A
         U8cwBDMHWNS8TXYkGezeQMdaJ3btRxQgNIHTbm/Adm+PiVlQvhosObkh/C2gf8CZAuZM
         KVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727469943; x=1728074743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=md2Dl5H5eCKwtjG8j4VlEsjGa9FrCXxESC22tm3GiVY=;
        b=eYPrHaImPb52gI/3Es1MIJEz/0GBMRGYK+dTMR61M/IE25immDq/Y8HDgIP+fMs+Dj
         /bfjx+X2Z1uJAFiK2seUGGKa6XkbNyz1Jid3oaC2xZCUVUa2xUWPh8ArdBNYxYhU1u+V
         K6uU0eDjc8eSnsuVwLWSwH+yvxkO8csOoobkxPdC1WbXSWf1+9lSgfcUVkoczIRlPU5p
         jKI0RLoWeM5Mk0k+LD5L37RqMP5dW3r9JmhxWowMvFOFPO/nMEgckzqkrK1LvXSviqUA
         ZAKdWvEJ1rcgh3Rn0WOjhER575C9HpLgxBjPIKfEhHkApmWYsxtsFwXYGhz0hl+jLaYJ
         jMlA==
X-Gm-Message-State: AOJu0Yz01qEoecHIppoSn/cfilpIxJNi/YoZuHmhUgLDrfzsFUPSE9T6
	z0WR2fsLB3KNq2U3UgJ3aDShn6iR4EvcRoDybhEwIgdCPV6ID33wmO7JV3Mp3WFZRCjGqYh9EZh
	8
X-Google-Smtp-Source: AGHT+IEGyFHWflUQUYpISusKngKGFd8ih/tb96ZxKH7s+tnAZVFHpNP429MVSXL8aIUUiOkVUQvR2g==
X-Received: by 2002:a05:690c:39a:b0:6be:92c7:a27e with SMTP id 00721157ae682-6e2475e2d1emr38856207b3.28.1727469943123;
        Fri, 27 Sep 2024 13:45:43 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e245369a20sm4135517b3.85.2024.09.27.13.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 13:45:42 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	kernel-team@fb.com
Cc: Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 02/10] fuse: convert fuse_send_write_pages to use folios
Date: Fri, 27 Sep 2024 16:44:53 -0400
Message-ID: <f0e70cb0b99f46d05385705095fb9413a6c9ef0e.1727469663.git.josef@toxicpanda.com>
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

Convert this to grab the folio from the fuse_args_pages and use the
appropriate folio related functions.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/file.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 132528cde745..17ac2de61cdb 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1168,23 +1168,23 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
 	offset = ap->descs[0].offset;
 	count = ia->write.out.size;
 	for (i = 0; i < ap->num_pages; i++) {
-		struct page *page = ap->pages[i];
+		struct folio *folio = page_folio(ap->pages[i]);
 
 		if (err) {
-			ClearPageUptodate(page);
+			folio_clear_uptodate(folio);
 		} else {
-			if (count >= PAGE_SIZE - offset)
-				count -= PAGE_SIZE - offset;
+			if (count >= folio_size(folio) - offset)
+				count -= folio_size(folio) - offset;
 			else {
 				if (short_write)
-					ClearPageUptodate(page);
+					folio_clear_uptodate(folio);
 				count = 0;
 			}
 			offset = 0;
 		}
 		if (ia->write.page_locked && (i == ap->num_pages - 1))
-			unlock_page(page);
-		put_page(page);
+			folio_unlock(folio);
+		folio_put(folio);
 	}
 
 	return err;
-- 
2.43.0


