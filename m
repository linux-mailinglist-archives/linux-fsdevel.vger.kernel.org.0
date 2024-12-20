Return-Path: <linux-fsdevel+bounces-37962-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 165899F95D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 16:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA63B1890BB5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 15:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6564121D5AB;
	Fri, 20 Dec 2024 15:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ncr/MD9e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C31D21CA1C
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709730; cv=none; b=WoAY0E6TAOmA7ADe/IlceJnvOoCrDsF6Qg6iK+H34lPZ+wwLyq2aZsTFodK1litODuYmiccCzvekEGXpYV54MugX8EgeDwb9W58nsVWVYkkFTYGtKEjeSPdcisOSKiCwPTvlnAyQ/+c+4qYE6NxwzrsLArr19JRm1R6DymK08fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709730; c=relaxed/simple;
	bh=GaN0/oBzXsAiWqwBFn1n2Fc++lywThntHtcNeWBfcz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EzuSwI0UoeS5resPVOC6S71/q6kCcLvI0UGHIjc0AcI+w9WKjnlKH8/peg8Z9f5equ9NS5/Y8IReFFAtJ6PGM4nkhGTl6ZQrvAMsbKqPlmZ+4dYxXV9/bJhh9AnqvfmGLktP3yoVRdXyyon/1BGEHWNejfqqQsUZ18GtzID1s8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ncr/MD9e; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-844ee15d6f4so158518739f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 07:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734709728; x=1735314528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4qQwDJE6vdlPLyJQIpmMrltr90cAGUkJZOMxstE6os=;
        b=ncr/MD9eAO4S+4YZqT2PvSRUEUfRH0XRRnl8I516z8jRSkZ31sND98yfS6V+rRRspf
         5Kf/Ih7ECLvuydILFZhyqjSWG5a0bFHOQuclk7Aa5IkNAXA9StMT23TpMMzuiaE8Reop
         s+/SZtvp/g63rRqlCEC4yu/eGk5P5iygxFE7q1pQGkGw2K1J91g8DrjgTMMq4WDIRrSD
         D0Fv68GrKAqWRL0VI0jnvmWPRajAKViBpycTXrWNDBoIKkqs0jJq5fWbWXhb1zrIdMDv
         OaUM3NEj+wa0kS9lobiBPDHTorWqD9w2cbpGIhaDA4lYoZVx4sZFwChBBXDGWiJfmQyw
         Z1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734709728; x=1735314528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4qQwDJE6vdlPLyJQIpmMrltr90cAGUkJZOMxstE6os=;
        b=tvYNE71TwtBsdxzILtbDbizj/otezOWyGjWr53Wut92Dw/1IU3oNfHmk/jw0c3E2F+
         0A2/4Lh0HyzjrPXd6GQYVSr8FfQ4yiLMtUZcNgeaVPcV9aevIo+dnAUxu771nhlVfS2+
         YxdSITp/xeTuj/W2RlfaIuRl12NpajZcRJ2hHA3ZsBYIBssp3dSTeB8rXVbVBFZcqJri
         myxlWmYjDHnfaqW9aET8wPE/qtK9qk/lBm+3/UkWYgFp6dutcUJALBjc+J4wudmip3Nl
         R8G6SOXMLMtKs5GFk4yRfV7YQ4zQ5H3V63rexTDXvaBEBsKI/fV9L6v6npbKWeIlI8XI
         s5GA==
X-Forwarded-Encrypted: i=1; AJvYcCWow4vuk0umC0OnAfkTIiNkpe0o2us+J9XHf0rpS4SlSG3ZSxi8OufbYk5phSHJPdhghEtMIOGLJF6S9GbS@vger.kernel.org
X-Gm-Message-State: AOJu0YxT3oCPmXbySibIMTq3MXOJ1AiS3X/Uk50BmIqDdCEDTVjj++va
	zBYfQKKnZnYf7HjsHErX80CE3RgwFXM/dR2cbVnCYq3l7LoN26ArpWpVQyXrmcPqdDYirAqGqYv
	9
X-Gm-Gg: ASbGncudR2PW7cLoKuDHUfSIjP89JAk3rQZFtjhDrslQqBh7ZunboLDmV2s4+Aclm7v
	waOWVCGPgzn4IRUFweTCwuL9n3+7aPtt48UxnfMnHPgiN6nAoTPtTiU/t6NU6kN0iZnWCjWast/
	MOWe5/nRVXDUzfRq/H1dmTL0gDDWLX3suNM86hJU7u8qlM3H+6KDFuUvEI7fERA8LNihMoV8Om1
	l45K46gqCbm1oXbqKD8TaLg1YwtBb/QFOahBdNzkOBbR8v81LR3SNocAY2f
X-Google-Smtp-Source: AGHT+IFGv05g9yMPyknBeMlKwprAW5pwl3vrHXnYcOynrc2BQ0O5hQEIENaNx6lgdvRHQ9LzhuK/ng==
X-Received: by 2002:a05:6602:158e:b0:844:e06e:53c5 with SMTP id ca18e2360f4ac-8499e4fafe3mr298729939f.8.1734709728444;
        Fri, 20 Dec 2024 07:48:48 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68bf66ed9sm837821173.45.2024.12.20.07.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 07:48:47 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org,
	clm@meta.com,
	linux-kernel@vger.kernel.org,
	willy@infradead.org,
	kirill@shutemov.name,
	bfoster@redhat.com,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/12] mm/filemap: add filemap_fdatawrite_range_kick() helper
Date: Fri, 20 Dec 2024 08:47:48 -0700
Message-ID: <20241220154831.1086649-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220154831.1086649-1-axboe@kernel.dk>
References: <20241220154831.1086649-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Works like filemap_fdatawrite_range(), except it's a non-integrity data
writeback and hence only starts writeback on the specified range. Will
help facilitate generically starting uncached writeback from
generic_write_sync(), as header dependencies preclude doing this inline
from fs.h.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/fs.h |  2 ++
 mm/filemap.c       | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6a838b5479a6..653b5efa3d3f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2878,6 +2878,8 @@ extern int __must_check file_fdatawait_range(struct file *file, loff_t lstart,
 extern int __must_check file_check_and_advance_wb_err(struct file *file);
 extern int __must_check file_write_and_wait_range(struct file *file,
 						loff_t start, loff_t end);
+int filemap_fdatawrite_range_kick(struct address_space *mapping, loff_t start,
+		loff_t end);
 
 static inline int file_write_and_wait(struct file *file)
 {
diff --git a/mm/filemap.c b/mm/filemap.c
index aa0b3af6533d..9842258ba343 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -449,6 +449,24 @@ int filemap_fdatawrite_range(struct address_space *mapping, loff_t start,
 }
 EXPORT_SYMBOL(filemap_fdatawrite_range);
 
+/**
+ * filemap_fdatawrite_range_kick - start writeback on a range
+ * @mapping:	target address_space
+ * @start:	index to start writeback on
+ * @end:	last (non-inclusive) index for writeback
+ *
+ * This is a non-integrity writeback helper, to start writing back folios
+ * for the indicated range.
+ *
+ * Return: %0 on success, negative error code otherwise.
+ */
+int filemap_fdatawrite_range_kick(struct address_space *mapping, loff_t start,
+				  loff_t end)
+{
+	return __filemap_fdatawrite_range(mapping, start, end, WB_SYNC_NONE);
+}
+EXPORT_SYMBOL_GPL(filemap_fdatawrite_range_kick);
+
 /**
  * filemap_flush - mostly a non-blocking flush
  * @mapping:	target address_space
-- 
2.45.2


