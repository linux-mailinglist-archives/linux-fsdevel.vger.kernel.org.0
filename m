Return-Path: <linux-fsdevel+bounces-27247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 292D095FB90
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 23:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C28A1C21BBF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 21:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C36199259;
	Mon, 26 Aug 2024 21:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbC7o0Vv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FF519ADA6
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 21:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724707211; cv=none; b=M4bwag7ObNyzuJSGI5IMvjNrjDySx02DVm5kbfW4M6ETI5PLErtZNB0qZbu0zihEsjj7y2qbksHLjVsX63xwPJ6MrEQPKYkSLLI+LsKfs7QkJrA5rw78ShdphPB7+5FlS/sxCuQn+pqS9VIfX4aXlN11BPZLK2/XqWoQ8LShTCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724707211; c=relaxed/simple;
	bh=ssIjC0FzFiR5e6vInB5Mt1IP0g4DdbYHZGPZNOSMczk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXmPFM14snd0QyRPRZl9++FxQJDTpGK7kJ/uhFifq7gCHUaTdHlkx0yrmqA522waHOeP/kMR1I/etVoOUi6XA0iHl61RDnkuRO4ZBf3hCJiKX+C7JwzSrImdlxd23UvAiKBooakJIffHeryx4bb9iQZekm34xkmfs3MVChl0j+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbC7o0Vv; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e13cda45037so5151232276.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 14:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724707209; x=1725312009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/w6y+HE3p0vEoIb0akm4SHp9YAeENOx9SQfUh1DXgc=;
        b=SbC7o0VvQGPVqgXs2VhMadbTD+AOPIF06YBT8ZmdyvopEq4a29Tdl6UzYK65XFSu7m
         h+Ag7BYOcFZIRmwEkgD87qSJDL8sp0tJ1q7/bY7nHzTi/GUDvJ/Aocr1VcdgsnhPDM2k
         9Ls3REBleXN42Qrrqcy8PcT4RbWsuJG2lbK5arWUVwkLSZmUxELbCCuUYr1N+P+e475+
         65/qmHY1HxPM+3/Z2I3U+3hOZ47OWzo/PgQ4cKg/sb9okyXx3arXfQnUWJs/5sI1VksS
         2pT3dkDQOWmcGrsWJIEE+xA31ltRwo4i+vC8MMpeg8BiEQdUCZXz7vsim6D1jyHU0LKG
         y26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724707209; x=1725312009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/w6y+HE3p0vEoIb0akm4SHp9YAeENOx9SQfUh1DXgc=;
        b=KhI5boVHqppHbiHd3B60LVbaW5WeGCay27P85F6gSPexg/4qcWrWml9W9+Ni7lue6e
         3sMnye02m2dQozInZJJsERBgGf7CqDXocNahJZbccFPiWTccPBY8Tij0AP8nKrZOYqlj
         i3hkIMvwkFVJU2oA0Z4z6ueAUHhjiuQFzHlDQNrQr+V9g1DmH8xWwGrqm8bvgVDeTSD1
         jdtLNDIHtG0+SGBXht/S4KYkpVym82vBKbf9YqC3TS5xeqMcYhH4PO71l8plI86QzvFP
         8/Pj2tk+1YEvl5nPlqZo3cv5kiwtaNdTeW9Lsf7CzI8R+SatIx5M9QokDICwR7jqSvsT
         /I5g==
X-Forwarded-Encrypted: i=1; AJvYcCUoEyZBV1Pk7hEWloNSzqTPo7I5TAE+n1JITAp7OjABABU6S2pfNmYvFC8pywfgquZJqIXZN2KQuyP1CtZM@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9eCHUGx67SpQueNpIpC7OZ0kWSWYIpEtdC2aAi4UebAJDtBpP
	HNzteZkkDUHQsO9L7q2tvJmsD4Tx6DPBjsQq+H3mf1+K3EXqPrAiKJ+GOQ==
X-Google-Smtp-Source: AGHT+IGbvx3/+YL7vtsIUdHUM08iF0ROzFMACSF/vl8D2OPiAi8bJ9nc7D1hrSFngYy6iU1VxyVZQw==
X-Received: by 2002:a05:6902:238a:b0:e13:d23b:f21b with SMTP id 3f1490d57ef6-e1a2a9789e1mr741613276.37.1724707208863;
        Mon, 26 Aug 2024 14:20:08 -0700 (PDT)
Received: from localhost (fwdproxy-nha-008.fbsv.net. [2a03:2880:25ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e178e4b3cafsm2153287276.28.2024.08.26.14.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 14:20:08 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v4 6/7] fuse: move fuse file initialization to wpa allocation time
Date: Mon, 26 Aug 2024 14:19:07 -0700
Message-ID: <20240826211908.75190-7-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240826211908.75190-1-joannelkoong@gmail.com>
References: <20240826211908.75190-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before this change, wpa->ia.ff is initialized with an acquired reference
on the fuse file right before it submits the writeback request. If there
are auxiliary writebacks, then the initialization and reference
acquisition needs to also be set before we submit the auxiliary writeback
request.

To make the logic simpler and to pave the way for a subsequent
refactoring of fuse_writepages_fill() and fuse_writepage_locked(), this
change initializes and acquires wpa->ia.ff when the wpa is allocated.

No functional changes added.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index b879cd8711c0..ef25dcfcac18 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1762,8 +1762,7 @@ static void fuse_writepage_free(struct fuse_writepage_args *wpa)
 	for (i = 0; i < ap->num_pages; i++)
 		__free_page(ap->pages[i]);
 
-	if (wpa->ia.ff)
-		fuse_file_put(wpa->ia.ff, false);
+	fuse_file_put(wpa->ia.ff, false);
 
 	kfree(ap->pages);
 	kfree(wpa);
@@ -1936,7 +1935,6 @@ static void fuse_writepage_end(struct fuse_mount *fm, struct fuse_args *args,
 
 		wpa->next = next->next;
 		next->next = NULL;
-		next->ia.ff = fuse_file_get(wpa->ia.ff);
 		tree_insert(&fi->writepages, next);
 
 		/*
@@ -2155,7 +2153,6 @@ static void fuse_writepages_send(struct fuse_fill_wb_data *data)
 	int num_pages = wpa->ia.ap.num_pages;
 	int i;
 
-	wpa->ia.ff = fuse_file_get(data->ff);
 	spin_lock(&fi->lock);
 	list_add_tail(&wpa->queue_entry, &fi->queued_writes);
 	fuse_flush_writepages(inode);
@@ -2300,6 +2297,7 @@ static int fuse_writepages_fill(struct folio *folio,
 		ap = &wpa->ia.ap;
 		fuse_write_args_fill(&wpa->ia, data->ff, folio_pos(folio), 0);
 		wpa->ia.write.in.write_flags |= FUSE_WRITE_CACHE;
+		wpa->ia.ff = fuse_file_get(data->ff);
 		wpa->next = NULL;
 		ap->args.in_pages = true;
 		ap->args.end = fuse_writepage_end;
-- 
2.43.5


