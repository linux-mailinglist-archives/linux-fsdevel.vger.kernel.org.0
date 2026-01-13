Return-Path: <linux-fsdevel+bounces-73380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B83FD1740A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 09:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B46E43046385
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 08:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F50637FF56;
	Tue, 13 Jan 2026 08:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdyZl+C4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4674F3161B7
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 08:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768292412; cv=none; b=XvcBLQyImPi5eiRVOShY4KW/VOSVJheoW0RJrczeXF2juw4bcwZrLg+W2BT2zPikSmVgHS0qT2yxQ1yRekqsYfdWBQiZ0kDAN8lJLumeUprtAjhnUdN/93ZKTnpuQ1qBuWhWZ/RPPJVjQqbZY3XmPupYfwGq2q4JKIdvy/zqvVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768292412; c=relaxed/simple;
	bh=0jw4cquGwYB/z9UG9OvV2yjttj2hcaywvOyHf+rt51U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETHjR3KIdDqgSTMkTgLN+nR8OB+3j1rSw/oVtYoezBfIEjWcnEdJvwsk/zzRLZGiRb+8e7doawAyfXco/N0wOfP8y1T4IgDNsZXvTz/CxVugmtACns2VuerPEHpQZ4Gy3R6Qfu6FBF6f9GCXAdANJU4QyTK30DkGBtVUJSFJTew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdyZl+C4; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-81f223c70d8so2359838b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Jan 2026 00:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768292410; x=1768897210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/87bRPMbHbR/p4x6KC1TwxlWsiz9Mk6aUZxvYG30piw=;
        b=PdyZl+C4CREJu2o9l8VnREMRw/3/4jdk8QzoTkaXU/h9X7MZhmWPjsbGBR1HSrBT1r
         ysWrGqRjJDQ+t2soNbRcM3zG7wehIwlXIkgySZ8figJbO1TFw/jT0WtPcT07wOSDJi5/
         PPH/kAAgVIsn59uLhA0U6GAfQuhJ7srg1wvGQtq+E9oCkGca/MKg/EbGMRIXWQed4lvR
         5MxlXWyf95lQWt27QudgN9oxEqkBS4Ac7bWSe86UfEzGA7Rbx0xcipPU8wuu31hkmIDV
         5h9IwaRKm6g9woRJ1bm9AUCXIoVDmKKg/9Qiym43CprjlhQZXSLXDIC7h3SPEtIR0S+2
         sivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768292410; x=1768897210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/87bRPMbHbR/p4x6KC1TwxlWsiz9Mk6aUZxvYG30piw=;
        b=xMhf9dJCyPH0U9PegnJwoxiIenOp1gyOWUszNT2T2LinKI95V6v7H27AaPGmLfJmHs
         nPI9boZ+/NxrlBKG8EewhRJIyeMTdQVtBFjam09X5nBaCyehKLJRDtPrd57V9SxdfTHI
         EGzR0AX1K23yk8fswYDfMrIK2jSmQmAlGpCIhNSmFPAh58UMAaNVCxAnt02CZjy4mVfy
         NJXhJGpRAiqV16osoAcRNQF9BnhAUFRxpowOC63KPuwB+osk8GGrDeV5qrtqRBm2skpC
         i48Yr7NXdm5tKcpAmpTRcqzE5Xd80TG5KNHbUH/bM3WIWp95RdOBXWDkpQipNBv3jxdD
         aVlA==
X-Forwarded-Encrypted: i=1; AJvYcCXoPGNbWEOO22zXu0PawpJ7qpU9uJQEZvRGbSilpYINktzeSXNT0pShVyDl/5IAjvXUzBSrLvSHCeVWiaIQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzD3YAuNPWBPvsjpetRtPti2KF96ntN2wghLnm2OpzNqdCeWxC6
	LSBZWprbKUJ/QdG6wfBTtzxoWcxq4tRL5GA9noCMermoMokIVjYh47IH
X-Gm-Gg: AY/fxX41Bn7/EcG1NUV5XWcPlLF2/YZyBedIvD0eiNZ6XK+DiqbWb1p1Mxg+lu9ibtS
	nMrKmUjCt2z0lZuLchJUAlViyCrqoxkELB4Deu08iBwVqtCppsqIehhfq3QA7TwRTDg9oZdJtQr
	gHQJF3+StR6c5WQuemVFJXQcu1cQDKJhMU4a390ShiFRW/V540vY3/w3ZmbQK5rgeKJDY1V6HW4
	3KlFc6sz0k7NNBbctsWjzjvAxYDxDOZ7A5l7xyj56+UHxpv4sW6JB+Q/V+SPrqXginXCdrebdaP
	WnNaUGtK+JYX9tsBUdjhu7RgTr0tkZbQvLU8qFX430Yx+iA9yJhN4Sk4mM2M52YL69wU9mVAFLV
	zASm4oWLHknuNlsBrtvq/N622q5jtaInIMJoatgs1HORrozJwpV4ajRMAVa0Nm0Cmz9bVfrDezq
	m08Jk5dzn+6EK7tzPRxrLOfQVkgw==
X-Google-Smtp-Source: AGHT+IE/3FdJ2WGt2j8Id3o2941yJOPJ+Gd97MnlhdgU5K/PMOcm5NNzFrwTozoT+AFownwN36YEJw==
X-Received: by 2002:a05:6a00:302a:b0:81a:7e99:d573 with SMTP id d2e1a72fcca58-81b7d260788mr19367242b3a.12.1768292410494;
        Tue, 13 Jan 2026 00:20:10 -0800 (PST)
Received: from localhost ([45.142.165.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f3fc40c1csm8249626b3a.55.2026.01.13.00.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 00:20:10 -0800 (PST)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jinchao Wang <wangjinchao600@gmail.com>,
	syzbot <syzbot+1e3ff4b07c16ca0f6fe2@syzkaller.appspotmail.com>
Subject: [RFC PATCH] fs/hfs: fix ABBA deadlock in hfs_mdb_commit
Date: Tue, 13 Jan 2026 16:19:39 +0800
Message-ID: <20260113081952.2431735-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <68b0240f.a00a0220.1337b0.0006.GAE@google.com>
References: <68b0240f.a00a0220.1337b0.0006.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a hung task in hfs_mdb_commit where a deadlock occurs
between the MDB buffer lock and the folio lock.

The deadlock happens because hfs_mdb_commit() holds the mdb_bh
lock while calling sb_bread(), which attempts to acquire the lock
on the same folio.

thread1:
hfs_mdb_commit
	->lock_buffer(HFS_SB(sb)->mdb_bh);
	->bh = sb_bread(sb, block);
		...->folio_lock(folio)

thread2:
->blkdev_writepages()
	->writeback_iter()
		->writeback_get_folio()
			->folio_lock(folio)
	->block_write_full_folio()
		__block_write_full_folio()
			->lock_buffer(bh)

This patch removes the lock_buffer(mdb_bh) call. Since hfs_mdb_commit()
is typically called via VFS paths where the superblock is already
appropriately protected (e.g., during sync or unmount), the additional
low-level buffer lock may be redundant and is the direct cause of the
lock inversion.

I am seeking comments on whether this VFS-level protection is sufficient
for HFS metadata consistency or if a more granular locking approach is
preferred.

Link: https://syzkaller.appspot.com/bug?extid=1e3ff4b07c16ca0f6fe2
Reported-by: syzbot <syzbot+1e3ff4b07c16ca0f6fe2@syzkaller.appspotmail.com>

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 fs/hfs/mdb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
index 53f3fae60217..c641adb94e6f 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -268,7 +268,6 @@ void hfs_mdb_commit(struct super_block *sb)
 	if (sb_rdonly(sb))
 		return;
 
-	lock_buffer(HFS_SB(sb)->mdb_bh);
 	if (test_and_clear_bit(HFS_FLG_MDB_DIRTY, &HFS_SB(sb)->flags)) {
 		/* These parameters may have been modified, so write them back */
 		mdb->drLsMod = hfs_mtime();
@@ -340,7 +339,6 @@ void hfs_mdb_commit(struct super_block *sb)
 			size -= len;
 		}
 	}
-	unlock_buffer(HFS_SB(sb)->mdb_bh);
 }
 
 void hfs_mdb_close(struct super_block *sb)
-- 
2.43.0


