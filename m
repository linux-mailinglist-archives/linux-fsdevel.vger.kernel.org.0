Return-Path: <linux-fsdevel+bounces-9664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2318442F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 16:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42751B328FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 15:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94CB12FF75;
	Wed, 31 Jan 2024 14:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuceGC/4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DFD5A7A1;
	Wed, 31 Jan 2024 14:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706713014; cv=none; b=gS8o9/0rEqTwN18EqgRPXsU0WTHAUlRl7b34OqI4hEHNR8JkaEDlwfUGy4gRgwHUbuyKGTulxHGuarPBsdeYI/YCRSf2LerqLerBeFhr88C5NCeFfRv0CJ3eU6tM/gQpRguhOM2T8zYF8tJSZSsABpPCXvsD6ZlgODFvI5Uvj5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706713014; c=relaxed/simple;
	bh=udDX7mi5zTuN4PeqBdH8shqiz4Wq0FyCqAQLYTgJPOo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fen7RNSSAmAveK3MqvPefG17lpI+jgvVELapVY4KvYMwGISXrDZ4EzOoTlVC1oEAUbcdB6Yr9Y1q9AXCBqTRF8Fvpji6uVHO89b6bSuBoa30r9SyI6GnJ7TpWSaLQfql/TSS6VoOOXVsA1iRbRDW0XnXOu2uaYw62VGLn0T6yDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MuceGC/4; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d93b525959so2639805ad.0;
        Wed, 31 Jan 2024 06:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706713012; x=1707317812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YaQh+r2Zu4+oI4esO7EBFsRE6WihrlEdHsqMVhO6RU0=;
        b=MuceGC/4GGmR6+Z64HgOciVUzksltOuAHEdqvEOMWhKqI9zVEFhYMNnVooR58CkeR8
         /33O2AUI4/DZE9W8/Uf8vkIOmYID88h7a/XHYiWrI8T+v03x5XJwh85OYW7Z7tplpxBO
         cUadMDmKW9Maet/E9UyUnNuLqbAQEcY+K9KcneEsHDLFeCO1dySHNMmIx5464zuXkD+1
         Ys4ZCTSQ1T7UZaf9vT41tCgdj1xzs4z1MsaBgDMutepstvApp6vNAy8fJ8rc90+ncjAO
         Y5+I0Cgl6DJqiMY4oBspktUcapunBWQwIbcQGQAf0ZRY2t1F6wsvrQ8Fyu0T8wHQL1ho
         1bfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706713012; x=1707317812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YaQh+r2Zu4+oI4esO7EBFsRE6WihrlEdHsqMVhO6RU0=;
        b=Pv0wT36bynp9CQ6bVqRNV+R3slStbXB8+vVnHdccVk3Q16hX2glh9YZZFDKj2JXydF
         hP0j1sk+K7y+X1nexK7IfRucsnLWChPcwHakoS0Zml1csSk/n2q+Ya6DOJNcFaIxXrLl
         5Bj6svIEeLNl5HsoCFBpNtwoSuBYTVz/aOba15WwUepBPJXo7WwGsPfvpaReVdk5Zyei
         wLqdshvdUUINCCyrAiHkdgvvWjJaWUFR5bdyn6Men79bfDED8zxYG+qAglK3v1ij6QHw
         XPVoFlC+Mk/Js66gu4ddbghLflNcNNHLVWrqzgeBKV+zHZ/+LyEG+adCdE3U6sxwIWtH
         JUmg==
X-Gm-Message-State: AOJu0YwiXHilBClyRgVkHGYjP3XV/v9K3D67lOmHDFlLDFyI0HdcDlWU
	Dksibnqq/MxpOJkBZt5x1tyz3xCtRDVuZtJit8S4T1uv/7PPLodh
X-Google-Smtp-Source: AGHT+IGaY4LQD053zcJHFyDpcQtFMlF4Cb6fvrnEBtIVGlU6SAwI8QpE8efHRGsxSnjAYD3KQ/r48g==
X-Received: by 2002:a17:902:6b0c:b0:1d8:b486:8501 with SMTP id o12-20020a1709026b0c00b001d8b4868501mr4333041plk.1.1706713011943;
        Wed, 31 Jan 2024 06:56:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXFcJ2PAYflWm06l6Xef2gNPwF/JPDKADf3NnZTd2Hf+SsEATcwY4dJX6teV16K3sDFMA71rgH54tlUh83l2eIPgBbBYGfYcjvwN1WuB9kFsiacD0RA/I/g85+SaoxR0w4STzfYfWCgoGndQfFAfDCnM0vh+KAF9nAWzJXuC9O9Vhz9tMYPKm2nhYALvZKkAGlBdLm3e3j9gyQ9ZijJb3HL4KabC0cP+rghaf95/NHkHliTOKJkKJUzphXWXR+v0ni0J1Y=
Received: from carrot.. (i223-218-113-167.s42.a014.ap.plala.or.jp. [223.218.113.167])
        by smtp.gmail.com with ESMTPSA id x5-20020a1709029a4500b001d5d736d1b2sm9180005plv.261.2024.01.31.06.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 06:56:50 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org,
	syzbot <syzbot+ee2ae68da3b22d04cd8d@syzkaller.appspotmail.com>,
	syzkaller-bugs@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] nilfs2: fix hang in nilfs_lookup_dirty_data_buffers()
Date: Wed, 31 Jan 2024 23:56:57 +0900
Message-Id: <20240131145657.4209-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <00000000000047d819061004ad6c@google.com>
References: <00000000000047d819061004ad6c@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported a hang issue in migrate_pages_batch() called by mbind()
and nilfs_lookup_dirty_data_buffers() called in the log writer of nilfs2.

While migrate_pages_batch() locks a folio and waits for the writeback to
complete, the log writer thread that should bring the writeback to
completion picks up the folio being written back in
nilfs_lookup_dirty_data_buffers() that it calls for subsequent log
creation and was trying to lock the folio.  Thus causing a deadlock.

In the first place, it is unexpected that folios/pages in the middle of
writeback will be updated and become dirty.  Nilfs2 adds a checksum to
verify the validity of the log being written and uses it for recovery at
mount, so data changes during writeback are suppressed.  Since this is
broken, an unclean shutdown could potentially cause recovery to fail.

Investigation revealed that the root cause is that the wait for writeback
completion in nilfs_page_mkwrite() is conditional, and if the backing
device does not require stable writes, data may be modified without
waiting.

Fix these issues by making nilfs_page_mkwrite() wait for writeback to
finish regardless of the stable write requirement of the backing device.

Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+ee2ae68da3b22d04cd8d@syzkaller.appspotmail.com
Closes: https://lkml.kernel.org/r/00000000000047d819061004ad6c@google.com
Fixes: 1d1d1a767206 ("mm: only enforce stable page writes if the backing device requires it")
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
Andrew, please apply this as a bugfix.

This fixes a hang issue reported by syzbot and potential mount-time
recovery failure.

This patch is affected by the merged folio conversion series and cannot
be backported as is, so I don't add the Cc: stable tag.  Once merged,
I would like to send a separate request to the stable team.

Thanks,
Ryusuke Konishi

 fs/nilfs2/file.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/nilfs2/file.c b/fs/nilfs2/file.c
index bec33b89a075..0e3fc5ba33c7 100644
--- a/fs/nilfs2/file.c
+++ b/fs/nilfs2/file.c
@@ -107,7 +107,13 @@ static vm_fault_t nilfs_page_mkwrite(struct vm_fault *vmf)
 	nilfs_transaction_commit(inode->i_sb);
 
  mapped:
-	folio_wait_stable(folio);
+	/*
+	 * Since checksumming including data blocks is performed to determine
+	 * the validity of the log to be written and used for recovery, it is
+	 * necessary to wait for writeback to finish here, regardless of the
+	 * stable write requirement of the backing device.
+	 */
+	folio_wait_writeback(folio);
  out:
 	sb_end_pagefault(inode->i_sb);
 	return vmf_fs_error(ret);
-- 
2.34.1


