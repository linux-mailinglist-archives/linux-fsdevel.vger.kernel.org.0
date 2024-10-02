Return-Path: <linux-fsdevel+bounces-30749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC73E98E141
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 18:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FFB9B248E2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 16:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1594A1D1516;
	Wed,  2 Oct 2024 16:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhS833p/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDDB1D1728
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Oct 2024 16:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727888129; cv=none; b=mpMdTD/RQGT6T7phK8Jci9EBp112AG3N6byF2kaHQmT4ls9xKPcB6KXHhBjOZrFGt82pSiyqmF3NF+UdmOcmll0SfiD687Oow00B2g90rdyUNRDx3pSEB7dxHD/Qs8YUBN5Va+EoavtbIelPBzdeKPvog5IFMAqEZSCage6diQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727888129; c=relaxed/simple;
	bh=z0jzrAVwUj+wlUqi10T4RxWMvzfAFR82rl0RHi13/3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gXfe/pT/MUJ1EmOVfdpcISyLnVxGwIjxERSjaTch0IysU9mIKrMmbjWs3xrHg+L76jCbr/aWiWtL7Gqt10FwbHlFRl76GPyzUIZnImqrHzdRCjcz+Xhx/um+sT0+WoEGePRi8rS4MyIg0SbPad+Uo6Xvz9sY+KTKIFgTfHBldVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhS833p/; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e25d57072dcso29025276.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Oct 2024 09:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727888127; x=1728492927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNsfIkoLfAyupuPYO+kOiKo/vH/CGwDLTjW09giv0OA=;
        b=jhS833p/9xtLXe+wuew3TOWm46r4ixXec4PzWFmXOpzMBlwkr5fiKE0T6gf+wKkoza
         3gVQN/vBqoAJfTcqVCu2VjUkNAdkBmnYg/a839qMbWGTmzuGtC6XIPWGeL+UFFaOq5VB
         iuBxXdLK9wiHt5IqoY8ISqKphTtrOBW07aX/+yr1G0sP8su3s4do6m8hoe47A6AhvTPr
         9FYVLoNhiXScdiijyMCZaN8qTeIVMf/zT98NEvZ8NylCvO8bviH4FyDP4HI5BTXtU0kE
         MGilE0Fvaf7FcBnPJpH1dzGwlwlOxv5l/KzUM41TntCSsI84hGwkiz5KhndfC831lDPn
         Dbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727888127; x=1728492927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNsfIkoLfAyupuPYO+kOiKo/vH/CGwDLTjW09giv0OA=;
        b=NUaEoW02YpTyRbUjhW7UkVzTLIl99cuqyI7BqOBuq5H6dbUdgizU0QtcFevgQzrvz9
         CCgg9OOxBOrJM7SO9NORynCaV2Rj/caS8AYshOwehC4a6msq8kz1RqoawvzqmaGWM5aV
         VC0CxvyQb+qn/Qkbfq67AapZaV7BbFl2nqa3BjxAz4/x482NcR99NX8jv47qG0yh56nt
         YuRFqJnpXpV7LVZlPIq+T5aDWjAYDiYJjQV1EvFjoka6AE9yqvhXJLLCYTSTgmmL1lOP
         b1pqeEepzeO8jDRqEpVdsG3Y6g5Zs26+8JkfC6vQ8N/iXrKotD1x/VTCnOr5PwrOMZVO
         o6kw==
X-Forwarded-Encrypted: i=1; AJvYcCWBuSC83nktDLN+A6882DBbYNFCh/G3vwhV23WQKB74cRMiyO1DcrsDrvVxizUODS86O7ah+X5ihneqeJUW@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmz/iUzEGYpCAECwIff5SaNqdx5dbY0Isvl+w9O5Bl/4cTl6dp
	Jgy/Dk4ho1YpRp4pFCdlVaRR81N+gDKe+r7z+avOtX66hDjR34P2
X-Google-Smtp-Source: AGHT+IE0nQq+u2gpgqB+qOoyMqjAoFCBEmdL3ctRS173F4/W5nal4mvzgPEwhYAR/pq14lvVCxAmLg==
X-Received: by 2002:a05:6902:2291:b0:e20:296e:48bd with SMTP id 3f1490d57ef6-e2638382edfmr3579349276.2.1727888126952;
        Wed, 02 Oct 2024 09:55:26 -0700 (PDT)
Received: from localhost (fwdproxy-nha-002.fbsv.net. [2a03:2880:25ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e286d233373sm204436276.36.2024.10.02.09.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 09:55:26 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH 11/13] mm/writeback: add folio_mark_dirty_lock()
Date: Wed,  2 Oct 2024 09:52:51 -0700
Message-ID: <20241002165253.3872513-12-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241002165253.3872513-1-joannelkoong@gmail.com>
References: <20241002165253.3872513-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new convenience helper folio_mark_dirty_lock() that grabs the
folio lock before calling folio_mark_dirty().

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/mm.h  |  1 +
 mm/page-writeback.c | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ecf63d2b0582..446d7096c48f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2539,6 +2539,7 @@ struct kvec;
 struct page *get_dump_page(unsigned long addr);
 
 bool folio_mark_dirty(struct folio *folio);
+bool folio_mark_dirty_lock(struct folio *folio);
 bool set_page_dirty(struct page *page);
 int set_page_dirty_lock(struct page *page);
 
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index fcd4c1439cb9..9b1c95dd219c 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2913,6 +2913,18 @@ bool folio_mark_dirty(struct folio *folio)
 }
 EXPORT_SYMBOL(folio_mark_dirty);
 
+bool folio_mark_dirty_lock(struct folio *folio)
+{
+	bool ret;
+
+	folio_lock(folio);
+	ret = folio_mark_dirty(folio);
+	folio_unlock(folio);
+
+	return ret;
+}
+EXPORT_SYMBOL(folio_mark_dirty_lock);
+
 /*
  * set_page_dirty() is racy if the caller has no reference against
  * page->mapping->host, and if the page is unlocked.  This is because another
-- 
2.43.5


