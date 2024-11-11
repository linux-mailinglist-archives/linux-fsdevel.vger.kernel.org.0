Return-Path: <linux-fsdevel+bounces-34347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B79849C4A5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 01:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C2BDB2C0CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 23:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC4A1C9EDD;
	Mon, 11 Nov 2024 23:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2qS/cp5W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5B31C7B64
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 23:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731368936; cv=none; b=dlmhy1/+hRCmV4y2LXcJwMIVcOYhfN+sEC25EFiVw8zpL3JGCAvR8EkiVnExDUMp4E8umQlszbBnNdh1q9x/voQg7ntKzTHv/W9Qf/Y9zF1HtHX43+QElWDF0RcrZNtiRaIuwhljzJ7qAW+9bIdWbTWo5V7WWfi+e7V5dEfCHD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731368936; c=relaxed/simple;
	bh=AFLrZl3fH+/hMhwZTjgZ0OWM0ndgzDi220n1zUDQffQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGg8CZ6+m9xdKUZfHLqg2XHMsLLX3dcbVno10jbR8b/GdwpGG57AUcow4JRxPyvYsxwuM7AiLdG6p2j79gfnm5g3tPaxqjIWAdlLBzJjG/VS+4ZjskwBDLdJqe0/QlOPcPwnYs0NqMwMN9IzwTgbKtI4Mzjbv3n9uvjvdy1ukkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2qS/cp5W; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-72097a5ca74so4256690b3a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Nov 2024 15:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731368933; x=1731973733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvfAlDie45/dO/q2Oa4nMUlSYRbUQddnQckYeJvFoiA=;
        b=2qS/cp5W20QeHg9RA27riSWL5AkZbAWM/PwKqjqs6Ii8ffsglV/wEcmEWXLLzcHOAd
         eei6lcVWFwRlLkhM5BqTWB61Gr5sv3uGcIc64ZVwA3+7viLF4AdIO14jOZCTrteKdQwb
         z3rJva6VXJrUi/QfIe9X1l2ErVYL1uiLOvwgPl4wVObJ56fEM1xUFksJ/uwOprAssIGE
         hb7Dnro93lgaccCPQLBvZxUlORIUQoJgjI8dRui/XGDro8XEPlpToO13zK3J1vMuwvJJ
         Gnr1/CPO2Ijp6uWNISxE3CO6UYUFij3OmQAGEunVZ4lPIij1q/ZCUfdzUjipCqbPD141
         1aHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731368933; x=1731973733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvfAlDie45/dO/q2Oa4nMUlSYRbUQddnQckYeJvFoiA=;
        b=UtxX+uke5VMs6/oM6/fRQoUzM38bWeFKK2lNk8DlT8ZETKFAoVeWZYuYNvkiHhdARm
         WnifkN0uK6vMIg6YVPOgplVpmDeleGrcbK/E0wJWDM2ju1n4jogarZpqN8V0ZYxamG5v
         NnbA2v164jKyZ0U1AzPGSSvD0fHwmGH+jiuWpzsmrayQ3OtZyNZW6wcmyP4iiyB5RXhq
         67gfMycpY6Fz0I5BgPrXo1aUSVlL8XE3rosdB6fZOoGmdTDh5tQ38jOQdfvMCjcR93zj
         EPz8gDCH5rAGTkDl0rMgf0ZrjlcqeoPPdLyig/fYkMzTIVIBR6+FgAPG/Cjo2S9rFg6/
         Jljg==
X-Forwarded-Encrypted: i=1; AJvYcCXYyUfUQDb00W5ADNsbNuRdrUYlThBMynbhL1j7u3Z/KV6oLKMJ5dQq3yz9OAVqrjAlLP/85WerRebQOlkF@vger.kernel.org
X-Gm-Message-State: AOJu0YzKBLEytkduM9VesSjosvYOdaXG395UqSkGmrc/6VkH3rKf1qNU
	YPTAggC6t+Htw/v6pgtqxWlxX4s4QbrskRexjpoXm/APQmiBIannbLYGtV29CYs=
X-Google-Smtp-Source: AGHT+IHeHxas0hJ7ji/qpv6NspxjwSxpVOtrX7CmDHrNgbtKnM+jsbZo98ZnZg8WufLJazefZ+DkyQ==
X-Received: by 2002:a05:6a00:138b:b0:710:9d5d:f532 with SMTP id d2e1a72fcca58-72413380f6cmr21319143b3a.19.1731368933147;
        Mon, 11 Nov 2024 15:48:53 -0800 (PST)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a7ee9sm10046057b3a.64.2024.11.11.15.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 15:48:52 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 04/16] mm/readahead: add readahead_control->uncached member
Date: Mon, 11 Nov 2024 16:37:31 -0700
Message-ID: <20241111234842.2024180-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241111234842.2024180-1-axboe@kernel.dk>
References: <20241111234842.2024180-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If ractl->uncached is set to true, then folios created are marked as
uncached as well.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/pagemap.h | 1 +
 mm/readahead.c          | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 68a5f1ff3301..8afacb7520d4 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1350,6 +1350,7 @@ struct readahead_control {
 	pgoff_t _index;
 	unsigned int _nr_pages;
 	unsigned int _batch_count;
+	bool uncached;
 	bool _workingset;
 	unsigned long _pflags;
 };
diff --git a/mm/readahead.c b/mm/readahead.c
index 003cfe79880d..8dbeab9bc1f0 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -191,7 +191,13 @@ static void read_pages(struct readahead_control *rac)
 static struct folio *ractl_alloc_folio(struct readahead_control *ractl,
 				       gfp_t gfp_mask, unsigned int order)
 {
-	return filemap_alloc_folio(gfp_mask, order);
+	struct folio *folio;
+
+	folio = filemap_alloc_folio(gfp_mask, order);
+	if (folio && ractl->uncached)
+		__folio_set_uncached(folio);
+
+	return folio;
 }
 
 /**
-- 
2.45.2


