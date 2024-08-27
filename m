Return-Path: <linux-fsdevel+bounces-27441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 781F69618B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 22:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34B77284CAB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 20:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88022E62B;
	Tue, 27 Aug 2024 20:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="2Y42LbmC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87F01D31A6
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 20:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724791581; cv=none; b=bKqTepCB19b1eCmNnxJzf2o9f8mWuaVBbAG2Dm9LvvoarxV/S6oYkcNiYhr9AKqRSNzx4IxBFmVd529uAKlqWp6ddqlaKgOSVkphcyBv8dfrG97u/2KMk2xAMddEMRkPzYsJvj5tINi0dKSN57g2UO4VE2OdAQkGZA9/7m5ukkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724791581; c=relaxed/simple;
	bh=zf7CAYwSiTrsY7gSvm0A7Rd13FskrooCxwz2ZkyvQpw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tAQ6bbMcGB02RQWAQXhwaDECAzvU6I+bvzqMjaWI9zT+87AsxLDEGvEX4ithVQJ8Xw7VDgsLUT0WHsUwB+M/7n4qSNtPRmwgMbaLouuiQ4SPs+QQAcKB5d2qSP+1ZMmEJIHgAI+1csksFgqdnlF45kkxVRMLN2G3421JeHJooSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=2Y42LbmC; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5d5d0535396so3553002eaf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 13:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724791578; x=1725396378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UwkWnqVqcG8mlXDcVaMcok7qIAsDjfcCpuOxNl0BDGc=;
        b=2Y42LbmCDFInkLtRYrGqZNXTAqNgaoiLRxvuQd0vV0HzeMfv7N5DY041VdV7uVm+Lj
         VwWQNk9SrAFG2EPgyCxM4DYm96KAaCu0KBinhachc3D8h8ZHbH0U+PcKa2EHQYJRiPfv
         GkB9/pzXFx9QDkdUla7tGtALDjJCfT9AViFn7yNBdkZkBobtfmAbFsDlVZSGVtUAk8BZ
         +qX/RdbmcHZWwmFg3yNiTTyxb+MKpZ3wMBu9YXYLCTFra7NQD9x6G3BxU6eXeZ80278m
         9OGWAPyxunmDSzaTRx8X8SLFZ0GzzlDVQKBY6xmZ25gy10cczlV4Gv1k2i6a/oTmOnIj
         6slw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724791578; x=1725396378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UwkWnqVqcG8mlXDcVaMcok7qIAsDjfcCpuOxNl0BDGc=;
        b=k/dJ98DwFvauR1tG9YRno4BiA3mTIxKKHOLAt579Haam36eh32Sz/um8pM7FTn7Rxe
         +Wj/JyBeJ8Fc6+2Wh45BPgihZyoNvwD4UtTb20NPtyl4OSdRhcgsW0iNyY38SRUMyLkE
         0LAxOJEZRL/++CW8krop8NxrBWRRFgvgRLeUA5rDrxr0mZzkewcF8DipC1q29en1Lqt7
         ++ia40WC0G+y/vQR9nLgm+25JjSf9WD8S2R09zBhYP7WPKWOzUGq2Rh7OX1Ehgir+7ZJ
         hbv4tZ7Vgiqwu5knGBRWV2+UZ7DGeYP/H4OpQ1bBL01oAuqQR0Vd720jIjnQggzTmcll
         9Vgg==
X-Gm-Message-State: AOJu0YwAEv3FsH8Bj9ThYGV/myA+n9shsG5vI0R/lf/qIhIERJW2O5Jg
	YwI8FkS5C0zL9eJKQAmAOpYslKavK5HZoUH435SRCkdjMXqfGV+A9VSaOi/meVcZFWC6k2IfAy3
	X
X-Google-Smtp-Source: AGHT+IH98Xws88C3qE082Nb7OYcxsPcp8sZbHOnj6upWEXPKnZngH0vETetCj3XcESCmI0Pdhn+lEw==
X-Received: by 2002:a05:6358:2824:b0:1aa:d3b7:765c with SMTP id e5c5f4694b2df-1b5c215b266mr1617292755d.14.1724791578357;
        Tue, 27 Aug 2024 13:46:18 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f31b2e0sm584949785a.16.2024.08.27.13.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 13:46:17 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	amir73il@gmail.com,
	miklos@szeredi.hu,
	joannelkoong@gmail.com,
	bschubert@ddn.com
Subject: [PATCH 02/11] fuse: convert fuse_send_write_pages to use folios
Date: Tue, 27 Aug 2024 16:45:15 -0400
Message-ID: <ce4dd66436ee3a19cbe4fba10daa47c1f2a0421c.1724791233.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1724791233.git.josef@toxicpanda.com>
References: <cover.1724791233.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert this to grab the folio from the fuse_args_pages and use the
appropriate folio related functions.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fuse/file.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 5024bc5a1da2..3621dbc17167 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1177,23 +1177,23 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
 	offset = ap->descs[0].offset;
 	count = ia->write.out.size;
 	for (i = 0; i < ap->num_pages; i++) {
-		struct page *page = ap->pages[i];
+		struct folio *folio = page_folio(ap->pages[i]);
 
 		if (err) {
-			ClearPageUptodate(page);
+			folio_clear_uptodate(folio);
 		} else {
 			if (count >= PAGE_SIZE - offset)
 				count -= PAGE_SIZE - offset;
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


