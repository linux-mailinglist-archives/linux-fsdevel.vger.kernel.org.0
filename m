Return-Path: <linux-fsdevel+bounces-15124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DABF7887457
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 22:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF2362830FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 21:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774637FBBD;
	Fri, 22 Mar 2024 21:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhwK4mVd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F8D43AB5;
	Fri, 22 Mar 2024 21:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711141631; cv=none; b=Qz4MzYesAf1hhmNTW30vaG7UmDqTXqrgjmvTBV8ejbCpAdJXiRYDGE4RnYEo9XbKkWA0D8gkOmikwohECR4R4OYeyOFSPjDg71F0kxhQiTmIt5ph2JAWuidz/cfd3wVe0vEOjSfn6mkCv4AS8ehHtt8kmrb5pgG2k69BBDaUNlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711141631; c=relaxed/simple;
	bh=YkgedNbnPlvyhg23jakh3mh9WdU2gO/2Oo9+tx8JwdY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kpKvGe0QKPoaxvBtUujRNgm3G3S1zU1u4TuWN0KOJdSJ3M0YbT31JbqFAqJkQnC59aakdKlrYTRdvWJbaeZ5r5JvUxJZDqK+VP58RmgpUpTDy5tVu1L/X/3RvQqmC34kGe/1xtfSFdr2qLbMKacKLo9WmppejO6NTe3aVfauUHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhwK4mVd; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e6f4ad4c57so1844078b3a.2;
        Fri, 22 Mar 2024 14:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711141629; x=1711746429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1XeA+1BAAqVXX6Ddia15d3yogqfe8/erMo6VyCuZWoM=;
        b=DhwK4mVdi6MNR8YHapVB4NE2gu8ez61GzcSIpmXpYuXkTtG7xwMxOlEfF79VFOXroM
         I2cWnizLWMB7qyiKtiEu+h9GgJ4Ktz/Zt8JCESril0YpL8vOm+wlU+7/afEfNE46cL3m
         yRyvhlPOUI/BpdicAZoZ0QLrDO+QDqA0MeRSm/nwpokVvYTwvVSw+FlUaYBeSqhnPR98
         OE8znGWobBGa2qTvGNlYw+14PhfS4TwVkD1Ep/OSwTNc59Nkqp+nmkcNOyNMIMbYhrum
         xxvwyh7iCnTe/dgSE3hoDi0rbPGF/65RW1s2bshLp2bGdq+sdITZ0t40Lm4V4SwZade1
         MCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711141629; x=1711746429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1XeA+1BAAqVXX6Ddia15d3yogqfe8/erMo6VyCuZWoM=;
        b=Pvowz8m5fO2JoRtVDbIGbyPCss00frTcabJbXr+AHlHrAhRND/QQ/rYgyjAK67jKZe
         FClZ83Dd20JhGaJ7/1rlJ3eJ+u7xyQt3tbRyq6mphEB0b3i+We7i0chG9zwRb73Dq1uL
         RnVKn9N4oW9s7RaNAbLcic8b+w/fk9mABa63Hi9l92VlxffPSQHP8TRsCqqCOPfGkzWV
         2qItQMK0XwnqHInMvbPV35c7RMDJ7zMPfoLbZ0tr/eYDGqnKmDhP4b4BQPrD0h9ZL9/Y
         RSpD4Pryjach/bm4KHb49ixmCZZyEjRPQbabDbGRhlrsYcsfCcFryYkvxqMJ+/v+UGid
         iLeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjkPRUDDfKEja7Tjo46vS16zSkgcCHA/xTuFg1dfsLnV9zw3z+P51JvCGdjejlHIfhLgno0r9C9Pdvfdl/RynOKz8Pr3ozg0ngUOv0OU3dEa7Dt715eB496eMb3Q92Yo9Qm48uMNM5XGy7QA==
X-Gm-Message-State: AOJu0YwSvcSVPZSfFakcVxYJtUljod6c/X2C2AeP7se4P6Jq59iW/HaV
	O2TZxpE4S+Jv0L4nQ5N3QvNO2HSqItJ2KoTtywa68G8+YpLmst6C
X-Google-Smtp-Source: AGHT+IFgMy1CSPUjv+TNn7WAnGnMfNGDWz+egwFlwmPjHLf9tI2fPtnVT3pxannuIeETTJXF3HkIog==
X-Received: by 2002:a17:902:eb92:b0:1dc:4bf6:7eb4 with SMTP id q18-20020a170902eb9200b001dc4bf67eb4mr1047502plg.31.1711141628851;
        Fri, 22 Mar 2024 14:07:08 -0700 (PDT)
Received: from localhost.localdomain (58-190-164-40f1.hyg1.eonet.ne.jp. [58.190.164.40])
        by smtp.gmail.com with ESMTPSA id a4-20020a170902ecc400b001dddce2291esm187307plh.31.2024.03.22.14.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 14:07:08 -0700 (PDT)
From: Soma Nakata <soma.nakata01@gmail.com>
To: linux-mm@kvack.org
Cc: soma.nakata01@gmail.com,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/filemap: set folio->mapping to NULL before xas_store()
Date: Sat, 23 Mar 2024 06:04:54 +0900
Message-Id: <20240322210455.3738-1-soma.nakata01@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Functions such as __filemap_get_folio() check the truncation of
folios based on the mapping field. Therefore setting this field to NULL
earlier prevents unnecessary operations on already removed folios.

Signed-off-by: Soma Nakata <soma.nakata01@gmail.com>
---
 mm/filemap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 2723104cc06a..79bac7c00084 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -139,11 +139,12 @@ static void page_cache_delete(struct address_space *mapping,
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 
+	folio->mapping = NULL;
+	/* Leave page->index set: truncation lookup relies upon it */
+
 	xas_store(&xas, shadow);
 	xas_init_marks(&xas);
 
-	folio->mapping = NULL;
-	/* Leave page->index set: truncation lookup relies upon it */
 	mapping->nrpages -= nr;
 }
 
-- 
2.25.1


