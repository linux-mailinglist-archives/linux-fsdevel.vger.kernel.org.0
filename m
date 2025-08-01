Return-Path: <linux-fsdevel+bounces-56492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64781B17A9B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 02:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7733C62189D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 00:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04D028DB3;
	Fri,  1 Aug 2025 00:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U76eMobF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F38134CB
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Aug 2025 00:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754008073; cv=none; b=cKgqq/jWAqf+1FAneDa/0wdpKH6BHV+PkCkLGL/z600rse26qpZLxDOuJ4jYeF/wlu9CTWoK9HS/NfTUVfv94PQ59a+IeUZcNArmlnqTkFkw/Vy6PsK+PLdEoyUynbC+pykKGSMUi6/iOa6XnUEqiP6GEOzj2/qvIMR4pXgzYQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754008073; c=relaxed/simple;
	bh=f2e5w/gfDD3Ki3E9C2VlDZLf0Y0O2hMiomNaJeuHY3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fV8AieR9Bo5I2Al+uU9RqsUaQtrq1ye0U6yduF7hsek8YcozFcKEo6O/cqxV8m+kAo6QaJ8hvstlgDdnqEq6mgW92MbR7KInal91swHbnhXZYg1BpU6sc444NGnD04dIVQiqsrTefbx7V/kmkOuIyN4+4eGWboV3vTD34p9X4GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U76eMobF; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b3aa2a0022cso1139304a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 17:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754008071; x=1754612871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7z5+HbZuc9YunuPIlspdA93dn5EvXoJwr6yRZmAwcU=;
        b=U76eMobFCW7aG5sP1pha2+Aoz7JAvg5dozNEPax9lut68mMkj6SiV+k8YIyVVFDoHz
         n9haMy5d8FkpqUf62leFO6UfTz3sqm4/4LgiM5IxNp8cxiijqOeILxbLwPYzFy2dtyi5
         3YEgc/vKZBDY8WFuWDKe96eI30w26l5MC+MYdhAi4x2tA/EL69JuAc4TK8ZgSYCtheW0
         u9wXgsXU6ryhnmaiWdjvnj8SvQ6PBfxTw2Ju65twfMwIeqtPqMV9b/4PfVrUTUOpCIbH
         SlqK/R26GIxRjNyq8N+YQux9dbk/d0gOAjE/TKOhRWpDG9WvMXViZPuW8faaKdvawhrY
         bhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754008071; x=1754612871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z7z5+HbZuc9YunuPIlspdA93dn5EvXoJwr6yRZmAwcU=;
        b=piA88xp6ZT/wpe/rM+9DuXGuK+yqP2WGzwLOaSonLnn67tkWLPNOXnW1R8FkSpP97H
         0beQVpD29xEXTZBO/WRtWWFXBkLN3PVA7Fe7V8dU0vdsEk9wTuRQJ+xMqIQcL/44UbOB
         fz9yax8V+NtB6YLRQPIq3+kLlpd2wLrtk4fRLE+/O10hXK72+lbgasY3vMuM9o/7wC5u
         yqwZwrxyGEoMxqUYjzpSii4bTufAy9UDLWBptIXsAEGgQOOWPu0h9+YasoqWA/7uhf2L
         8qQpsDXoRMV8nLmcXEhkY9l+rG6ly+fZcvm38EQfuTOWTt0rhMBR2yKcEEoltBuiY3SR
         CA0w==
X-Forwarded-Encrypted: i=1; AJvYcCVwxiMjEMec0zSZ/jbGZqE2ZAR+tv0N8sNZvFXvDVA7GWcSchNPGwNkdJANwDnNJLoZ/1dAvw6xeinOprfD@vger.kernel.org
X-Gm-Message-State: AOJu0YydqBWYZxyACSyPkP8EAbaUltxA+CUdcXYeBOH83K942jNqDmmb
	xB+Wj11JlECDRd/GtUr1MtptDMLanoX2fpbz/RZt7Bvg4BQ25NyMMD/e
X-Gm-Gg: ASbGncsDMtw6L4fyDHxXwuX0Ay1wlSexfeUkjVcyt/7T7re21/vOD0j4yu58rbRQ/nv
	vzt2srr8rHocnosrtCA/okuk5RU0lhaqh4wpQKtdXcpuk4FXXEN5ScsgF89cFh/tFJ1TPfuOihO
	tE5Lj+NJ/kjUxJ7Rk3/cY3sP+Ef1Bci6cpDo6jU4MXvTuvFLC0k/TESmidUQMKsg/jx4hMUBXEW
	anAlo9xOXPSFKPEn4X72axqQ424ijM+hAOsUxVS7pw67TwnU/lxpHeZGDd6ZvPByk0I5bojr7uo
	s/AfMm6kPHmv2G4pe1K1BN9hT3sMZXg5UkseA8QdANJudjTbx3c5s2V2J+EmbjkVPw/A+PkWJiA
	JGNpqbUmmBFLGhOZ/cA==
X-Google-Smtp-Source: AGHT+IFYmTAjVpt+7oBGfT3RIHk8CfJXE6Zr0DBlD9CkoTtvscoJm5dVQ4NSb12WkhTU0A/RSTNmRw==
X-Received: by 2002:a17:902:ce92:b0:234:df51:d16c with SMTP id d9443c01a7336-2422a6bc4f8mr9251225ad.45.1754008071081;
        Thu, 31 Jul 2025 17:27:51 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef6bcfsm28587855ad.5.2025.07.31.17.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 17:27:50 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: linux-mm@kvack.org,
	brauner@kernel.org
Cc: willy@infradead.org,
	jack@suse.cz,
	hch@infradead.org,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: [RFC PATCH v1 07/10] mm: add no_stats_accounting bitfield to wbc
Date: Thu, 31 Jul 2025 17:21:28 -0700
Message-ID: <20250801002131.255068-8-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250801002131.255068-1-joannelkoong@gmail.com>
References: <20250801002131.255068-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a no_stats_accounting bitfield to wbc that callers can set. Hook
this up to __folio_clear_dirty_for_io() when preparing writeback.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 include/linux/writeback.h | 3 +++
 mm/page-writeback.c       | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 34afa6912a1c..000795a47cb3 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -72,6 +72,9 @@ struct writeback_control {
 	 */
 	unsigned no_cgroup_owner:1;
 
+	/* Do not do any stats accounting. The caller will do this themselves */
+	unsigned no_stats_accounting:1;
+
 	/* To enable batching of swap writes to non-block-device backends,
 	 * "plug" can be set point to a 'struct swap_iocb *'.  When all swap
 	 * writes have been submitted, if with swap_iocb is not NULL,
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 77a46bf8052f..c1fec76ee869 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2404,6 +2404,7 @@ void tag_pages_for_writeback(struct address_space *mapping,
 }
 EXPORT_SYMBOL(tag_pages_for_writeback);
 
+static bool __folio_clear_dirty_for_io(struct folio *folio, bool update_stats);
 static bool folio_prepare_writeback(struct address_space *mapping,
 		struct writeback_control *wbc, struct folio *folio)
 {
@@ -2430,7 +2431,7 @@ static bool folio_prepare_writeback(struct address_space *mapping,
 	}
 	BUG_ON(folio_test_writeback(folio));
 
-	if (!folio_clear_dirty_for_io(folio))
+	if (!__folio_clear_dirty_for_io(folio, !wbc->no_stats_accounting))
 		return false;
 
 	return true;
-- 
2.47.3


