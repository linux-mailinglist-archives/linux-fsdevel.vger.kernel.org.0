Return-Path: <linux-fsdevel+bounces-59686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 389C9B3C5D4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 01:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89D1D1C87875
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 23:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576E72C08A8;
	Fri, 29 Aug 2025 23:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hE+t8Bd/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EAC273D92;
	Fri, 29 Aug 2025 23:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756511905; cv=none; b=CAWcMNJTbLPWHWgpAvVgV2+W/4El1AngPSRjnC66oBuF27lf4KicSpKs3b3ophQCRPiGFQ5I5K2CPW5aLCftqdHfLlmJkThlE0/I3mP3L5FVw+BYbyXZcd9tEHB6fThLGzmgsyHcBxozprDAjxP2mIngYyFZlb1vJCN3WAh/kl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756511905; c=relaxed/simple;
	bh=409beLvv/0SSmhpbBTM7jbdp8Sk9NE69GuHmQAH0nqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s3oL3HHg1V35yfQKroemyd9CDwWG16ejYZU8en4nyJqFBlHLMjmD7iZyOKMAQiKfkfjwmRPqdF+d/37vHHKH5MfO+R/VwfskgShNJaNcdsrAFfuFBha0ukWIiXwv/9oC87AabcsaaZTykG7eBOeXB8k95+IjujoHtF0SdkvKlQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hE+t8Bd/; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-771eecebb09so3533013b3a.3;
        Fri, 29 Aug 2025 16:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756511904; x=1757116704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFyYgR1MiP06F5QZ7U7b6ysCvDKlbl1l0kLxV7mwhz0=;
        b=hE+t8Bd/bRnSyr1jhury6YIa7i1ZUUpGb2uGDRRRsg73nP0uQUCjj95xZCzk1x5vSm
         JougFvIJn0vbTE2kDbu1ixOQbk1WgCCBBi6JNnR+CuADZAv1akneCcr5PoLUym5dF5j8
         lXd5eoetPwjrEWrcpZzc/Wm4GcrMfyQTS6qxHBE2QV6AaJUPlwFIdG5CD4eftepWjnsz
         9JmtYSpsdA9LnYsXKElqSYjgdcs4mnFtTQskwUQux8v48lH7W9CSlPt1dDS7wIhDRMYB
         i4gkXX7EMZ5NCCqxQex3b+RIq0v8JAcjgQg1oQiqULWlBZkhNvSYesgpu++dJC0WI9zj
         zfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756511904; x=1757116704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFyYgR1MiP06F5QZ7U7b6ysCvDKlbl1l0kLxV7mwhz0=;
        b=DGGWSdCaz7NZLKUIbDzfod7MjO5Pv0M++OMpzdipJq9WhEF96KQnw3aPJagE7xp0Dk
         TY9gLiQKP4ZvU32NN6FdYRT0H3mV2wKcg4gPuhbPYSjihUlfGD+B1+Q2FzNE+kPXWUQ0
         6f6OQQWatevHUexFpeE0Wq7kaB/q79n992o2MYgiKMRNOElqrjFTxQtFoTsEYtd0XIE0
         m7wF28lqqGx6rDSoxfV9/iR4WlxTpPN2lKbTtttSdS42ob9q4iqrBJA2Ad0DUa0vUFFj
         1PF4DDDyPsPAizHWUTK9zTAkDzJu7oe6t5NDB7+25WdJt3yfvpnWUEucSf9ThnD1RS9L
         cBdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtxxLMwFgIa7UODONul/l13t3nJwpc33wj36FZzuNLTGBw3g9dbKpcwxm97ua/jnAx1xaeMYF9866E@vger.kernel.org, AJvYcCWm7RFy2aIJAZiKl6u1U5R0TFwfw5oTesvhOKDugY3F3Q3xl5II+ZJ2lwCoexASEVE8OU+6Yd82ZQM=@vger.kernel.org, AJvYcCWrnPYGBU2WmcaVicG+86C1nEwhEHUsoh8DBR0BTnZ57xfJLFq9yFRAZoeFAMlpA0P+j2cDCEjtM0MMkt03Pg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsNRyB24CQ5MQHvDWQ3dONZmWJoQSFGQeSAW6Y9niysOfVHAwX
	qLncyDJSYg/Z5/7B6LeDXN+waYeZ6KpaE76MWT4MMHt4RhgZNyb56ZI/
X-Gm-Gg: ASbGnctbNnPGhMCaFNRBX4tnWnYAc1Ekwxmnn1oQgiXCwvoCvfWk8n3fldIDVwLYIGx
	ZX2ZJJH6+tDR6yi8jvgz7ne72a1UWqJ9PxrrEQoS0nIMhIjvxtXUm0aydWAYOjcVWCJqGEz6Xp2
	OZDKzVjUg14e5NWMR2YHPU7T/VrG7Vr/wtDOVVMslg8jBVquqNAygZAQjCV340/pLNjchyaD7oD
	GbhLQ5j8EYglviek+Jj7ow5opcdOJ0ad8QV4k+6YISioi9i1mHZAZwtOrNR4fL3rUaY831XN2ct
	8rJYQuhE2hOv+5VISkv6RBBqDP9BZx4tSOh3tvwONsQnaCgbMLletQLPumXaPZe/jt/ErZK0SiB
	1X97PVm32nPerQm0MXl0KYICLId4=
X-Google-Smtp-Source: AGHT+IHu0tOUQy+eSMbAm3k3SfdNgVh3ysa5ICqGCPnLs7GrIXxtUxXTB+yI8LAhOGvZoXme/SOUbA==
X-Received: by 2002:a05:6a00:39a0:b0:757:ca2b:48a3 with SMTP id d2e1a72fcca58-7723e259561mr478531b3a.9.1756511903766;
        Fri, 29 Aug 2025 16:58:23 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e2f99sm3420738b3a.84.2025.08.29.16.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 16:58:23 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v1 05/16] iomap: propagate iomap_read_folio() error to caller
Date: Fri, 29 Aug 2025 16:56:16 -0700
Message-ID: <20250829235627.4053234-6-joannelkoong@gmail.com>
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

Propagate any error encountered in iomap_read_folio() back up to its
caller (otherwise a default -EIO will be passed up by
filemap_read_folio() to callers). This is standard behavior for how
other filesystems handle their ->read_folio() errors as well.

Remove the out of date comment about setting the folio error flag.
Folio error flags were removed in commit 1f56eedf7ff7 ("iomap:
Remove calls to set and clear folio error flag").

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/iomap/buffered-io.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 9db233a4a82c..8dd26c50e5ea 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -495,12 +495,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
 
 	iomap_readfolio_complete(&iter, &ctx);
 
-	/*
-	 * Just like mpage_readahead and block_read_full_folio, we always
-	 * return 0 and just set the folio error flag on errors.  This
-	 * should be cleaned up throughout the stack eventually.
-	 */
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(iomap_read_folio);
 
-- 
2.47.3


