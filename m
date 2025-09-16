Return-Path: <linux-fsdevel+bounces-61844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 876C6B7E970
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAE47583364
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 23:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5AD2EDD69;
	Tue, 16 Sep 2025 23:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GlnT5olf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB0C2C21D5
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 23:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758066636; cv=none; b=h4G0kn326X+Ma1PTEx5F5DEsjjzjG9GLOcSvJjMXhaaWNBJehU9zhJz2zxiRma1nIwNNAy/HoA4OjobLU9gNtFKk224izf0FReA+dwUwKqYlv5j9jwgmulVdRquI8QwTatKJkSACksaobFOWrP1sQetdBzoXwfcrTaLmoHU1DSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758066636; c=relaxed/simple;
	bh=98GkOjzNEJqwvQK/4lUwfHNtYdVVuLzxJ15LQCdn1IY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8r2AsmWKU5ymnoQAjyIg8N0/6waKjzsW/s4riBgp/bg+BY+WCz5L5YE0HTPpd3uED3CI3IdsbKhf4YuEQx8F0PDtrpO1H33FYObp1W18HKQ997KFm9JTpWuLjHTyWFO4sAXorKzoYnvFkResvG9bVkvn+E0uXtoHkIB4JHgbnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GlnT5olf; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b4c29d2ea05so301735a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 16:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758066634; x=1758671434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rG6E+B3mjTcSPZ6yVzAJALw0H8+ndYKaxBlvC8laKf4=;
        b=GlnT5olf53BRTZ4BIemxBvWFHgfqTpKqU2Ab80yQNnCiC/EMGB/Wh/PzU8z6kaeVF3
         /OHnctV0IfoXhqtMlsZ64wWjta7KwKZ7hBJGozMkecIPlQS+w6helKXdADof79BweY0o
         KDl814ionrLz9rVLGCqdJoverD1rjGGnFFxg3OoubtXTqk/7AIQ3thkChnPOnftXnA0g
         HFqq7Fgztoq0KHeflo/CB7eGuy2MYOPK402zl9pEpZ2daSCz7BRALlWZsAPLdbD2z8dU
         yUhrYHzH88wB1Pn0T2J6HWfey4oSNLj5uxI7pRrn6MUJx9TEUV4zTYMG7pwruxsKpD8E
         58dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758066634; x=1758671434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rG6E+B3mjTcSPZ6yVzAJALw0H8+ndYKaxBlvC8laKf4=;
        b=KNpkj6CLJ3c0gr8cyQCgLlff9KUOf1YN0AgpyWn/6ZRsDgKO649oGUq3tkiAtJ2Sqm
         P6U9N33e85DjyK4Wu1wEYwXX0Oy1AcVJ0YRtntasYdjZhoSMOb75TBTAnikIlUec4PLn
         9jsOl1I1TRsks1BqcWrLVO9ti+XKevZDbuE7d6xNBP/9rfpTjoKRlBW+0ZRPRbARaK8s
         uLSCFL5ooFkX4Totrxk41gL+nCtv2A/4WOrT9HxOtwohf1e5+q6KcnBq8YyGLFevgASK
         4hi5E6VXnfoX/OYLHgYPV/VqmFMWFuFuVjUIpQn2nNwfo0D4/il1nhjjdAPTccryQVnn
         TECw==
X-Forwarded-Encrypted: i=1; AJvYcCV1Yb3N8ANuQyuYhLo4CtjWNsAx4h+ncOJca3QGADc28VInU295HSeNcW06V11AOvK3fkWjARVuLbgyRtW5@vger.kernel.org
X-Gm-Message-State: AOJu0YzugpA3iwT3hoN1iq6Fro2+qnTe7+5OpcTazaXHcHx8vmsUW6Fl
	qQkqV8frpGYkyFxHdIM735FFANJGtdNUYOoWDHumJPzSBUBmPw5WrRPD
X-Gm-Gg: ASbGnctHOqIvXPzHclQk6bXoTtsK1sf4vqyB17p1BxyWnMIqo8MZfke4Gv9nU1k1F6u
	YieG85zShVw9VfAfzbaD0/yn107oSHwtYwxV5jLpgZkKu4V12viwC0xg7hM14JbMgcmNEcLMK72
	OeIF5bd3+2Wk6LQfotkDdfzGZvOnQiSD9ZcPdioe3W6llMi0tyoKQH/3gXwFbuSjib6FHlxjdBJ
	26hHzGrzShzO0w2mWyjLthD/27wDP9nw0vmEP0kAspT56msZ3idvFx88zdf08r2QGb/DkM6rIsJ
	l3yXpMXP3TRbwEyTolMYSV+vpoWaXdhA21JhzYR/OC9lNxNcwS8iw8s2FDg0E/vby5jaQQoemmS
	Sj0qzf8i4xyYB0wHHGgHdPq8lrWbktANzUc9NHvmkBOKsToFcPiswHpCz/D+T1DUtPA3X2yJppM
	dNA9xNKhhvbmbaDyvnHF+Qzlbx
X-Google-Smtp-Source: AGHT+IGDxK1TSJHJMfjQoDefaoarnOiH5p2F5ClNqiomMKUWzK7J0G8impfhFApU6S2QB8fO6tB6Vw==
X-Received: by 2002:a17:90b:33cd:b0:32b:d8a9:8725 with SMTP id 98e67ed59e1d1-32ea631cd58mr4496407a91.18.1758066634546;
        Tue, 16 Sep 2025 16:50:34 -0700 (PDT)
Received: from localhost (fwdproxy-prn-054.fbsv.net. [66.220.149.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ea101ef2fsm1520309a91.5.2025.09.16.16.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 16:50:34 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: hch@infradead.org,
	djwong@kernel.org,
	hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 05/15] iomap: rename iomap_readpage_iter() to iomap_read_folio_iter()
Date: Tue, 16 Sep 2025 16:44:15 -0700
Message-ID: <20250916234425.1274735-6-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250916234425.1274735-1-joannelkoong@gmail.com>
References: <20250916234425.1274735-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

->readpage was deprecated and reads are now on folios.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 0c4ba2a63490..d6266cb702e3 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -412,7 +412,7 @@ static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
 	}
 }
 
-static int iomap_readpage_iter(struct iomap_iter *iter,
+static int iomap_read_folio_iter(struct iomap_iter *iter,
 		struct iomap_readpage_ctx *ctx)
 {
 	const struct iomap *iomap = &iter->iomap;
@@ -477,7 +477,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 	trace_iomap_readpage(iter.inode, 1);
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.status = iomap_readpage_iter(&iter, &ctx);
+		iter.status = iomap_read_folio_iter(&iter, &ctx);
 
 	iomap_bio_submit_read(&ctx);
 
@@ -509,7 +509,7 @@ static int iomap_readahead_iter(struct iomap_iter *iter,
 		if (WARN_ON_ONCE(!ctx->cur_folio))
 			return -EINVAL;
 		ctx->cur_folio_in_bio = false;
-		ret = iomap_readpage_iter(iter, ctx);
+		ret = iomap_read_folio_iter(iter, ctx);
 		if (ret)
 			return ret;
 	}
-- 
2.47.3


