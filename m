Return-Path: <linux-fsdevel+bounces-48380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6090AAADF2B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 14:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7792E188EAC2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 12:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8216526E17A;
	Wed,  7 May 2025 12:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fDoB4BVB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A52126FA40
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 May 2025 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746621019; cv=none; b=HCykAiCjzTtNNNyL+FmHXJMvXKMtlw9SP0pQEXu2MZYlcXPhrxiddgm5/W7rVZPaGPiDsNyfZHs+O1GtwsssYrP//cphqv2+9oCtMcY2e/btiqb0l6wUTirPQtIsjqcZAX47cpX8ZRzTDM/MnIW4Q9EKHm8+LcQNqXLemntoX0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746621019; c=relaxed/simple;
	bh=jVTLpnH1ToFiMhLryE6e/RlERX0ngJ62bz7zsEwdBpw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IQxL6h1AMgQHwWyKn5kNPwww203nh7KUwbieTRyz8GGb/pISwxEYrL5+rX8x9DV5g2rT33JNiq4QvXHcI/8LL3VWRL5DQgfx3YtV6Qo67wNo8WDJ+uqiGLqnGZG7ejlNYDcziIwhNynwm0rqlurXuT3eOwviRphkSywdGNnDnqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jbongio.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fDoB4BVB; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jbongio.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b115383fcecso3987225a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 May 2025 05:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746621015; x=1747225815; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fZm5iwwK8C7Xild1vEzRzbpfCJNu9cpHt0iq+yqi0mA=;
        b=fDoB4BVBXjPeulwM6g0iM7rz092fitolh5xh8oiwoZXpEKejAT74zzxwaG1HEinug3
         TXcl2sTmu8qa/qKzYMSOZsWO8TZJyGKfWkr0N1Do0MsIGrNGo77MJzpgBZ9FBtwn6PJd
         bx2xX4YbHD6dZnYSNNu/hj5XYRqzmC8Des/PBTQSBRXCme9ESNsRYvjc7Fn20aAtVrLL
         w+Fh6l1gY9UFM3Yy+gUZ55YozX9J4NXunJww/PaePHJwMTj/zB23J6Rsx1QcM44FHv6u
         E868lCrkfzH6jNkqvDpNDtwHOAz9YlEmwaP3HUDYj7dBkGiOGq2HtAuMm83Gnrw6M2h0
         ew0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746621015; x=1747225815;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fZm5iwwK8C7Xild1vEzRzbpfCJNu9cpHt0iq+yqi0mA=;
        b=eN/cUAz1K3OBKNpcAmQSvauiNZqsUPeeIScRTmsuobJvzh7xOenR89XQP/23h0fqRH
         8RQyapbeUqrv2zmchYjxKC2EphHHfmzcv2bSPDTJFBTNRlyBD1cDn+9kLCs1OEEEdvXN
         5vaucGyueGuW+6tipvo1BNoWyw5BPv4CeKjjhoAg/oBJ1LZ0RajpEo/hE2tLTggHXXe2
         0bPg/mZ/b8/TL7U5w2pNidTvvKIvTZx5UXEo1Ub/BFtA55W5/9T8tRIt0m4Ul8kfeun/
         cP7S3CUpguqGVLbTPu+MANhJ2N7Zag0INMekxIYK4rSAzh9v38ehCuFR80pMJuRvCDfF
         OGfg==
X-Gm-Message-State: AOJu0YxT8scFCvyd7+pcacXh/ek6jjiyGAvBvfga3Ifou1vAhZYAodqt
	5Hie+IvFvI8JINB1AqBf26BBl1YYVEsv8Ujorx75yCoF5q0iDV9FX4WIlm/+7UAOieCmv8Cc/X6
	HrDKDIA==
X-Google-Smtp-Source: AGHT+IG0s9mmAwtjcErZA6XvgyOx4XtPiFlVQqITZqYsgnCfrkIE/m+c2QJq6mlfQu5CCY9xqh9GeMoKJ/6T
X-Received: from pfhx20.prod.google.com ([2002:a05:6a00:1894:b0:73e:780:270e])
 (user=jbongio job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2d07:b0:1f5:8a1d:38fd
 with SMTP id adf61e73a8af0-2148b113301mr4916207637.2.1746621015415; Wed, 07
 May 2025 05:30:15 -0700 (PDT)
Date: Wed,  7 May 2025 12:30:10 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <20250507123010.1228243-1-jbongio@google.com>
Subject: [PATCH v2] fs: Remove redundant errseq_set call in mark_buffer_write_io_error.
From: Jeremy Bongio <jbongio@google.com>
To: Christoph Hellwig <hch@lst.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeremy Bongio <jbongio@google.com>
Content-Type: text/plain; charset="UTF-8"

mark_buffer_write_io_error sets sb->s_wb_err to -EIO twice.
Once in mapping_set_error and once in errseq_set.
Only mapping_set_error checks if bh->b_assoc_map->host is NULL.

Discovered during null pointer dereference during writeback
to a failing device:

[<ffffffff9a416dc8>] ? mark_buffer_write_io_error+0x98/0xc0
[<ffffffff9a416dbe>] ? mark_buffer_write_io_error+0x8e/0xc0
[<ffffffff9ad4bda0>] end_buffer_async_write+0x90/0xd0
[<ffffffff9ad4e3eb>] end_bio_bh_io_sync+0x2b/0x40
[<ffffffff9adbafe6>] blk_update_request+0x1b6/0x480
[<ffffffff9adbb3d8>] blk_mq_end_request+0x18/0x30
[<ffffffff9adbc6aa>] blk_mq_dispatch_rq_list+0x4da/0x8e0
[<ffffffff9adc0a68>] __blk_mq_sched_dispatch_requests+0x218/0x6a0
[<ffffffff9adc07fa>] blk_mq_sched_dispatch_requests+0x3a/0x80
[<ffffffff9adbbb98>] blk_mq_run_hw_queue+0x108/0x330
[<ffffffff9adbcf58>] blk_mq_flush_plug_list+0x178/0x5f0
[<ffffffff9adb6741>] __blk_flush_plug+0x41/0x120
[<ffffffff9adb6852>] blk_finish_plug+0x22/0x40
[<ffffffff9ad47cb0>] wb_writeback+0x150/0x280
[<ffffffff9ac5343f>] ? set_worker_desc+0x9f/0xc0
[<ffffffff9ad4676e>] wb_workfn+0x24e/0x4a0

Fixes: 485e9605c0573 ("fs/buffer.c: record blockdev write errors in super_block that it backs")
Signed-off-by: Jeremy Bongio <jbongio@google.com>
---
Changes in v2:
- Removed brackets
- Corrected Fixed SHA
- Changed backtrace to a more relevant failure path.

---
 fs/buffer.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 7be23ff20b27..7ba1807145aa 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1220,10 +1220,8 @@ void mark_buffer_write_io_error(struct buffer_head *bh)
 	/* FIXME: do we need to set this in both places? */
 	if (bh->b_folio && bh->b_folio->mapping)
 		mapping_set_error(bh->b_folio->mapping, -EIO);
-	if (bh->b_assoc_map) {
+	if (bh->b_assoc_map)
 		mapping_set_error(bh->b_assoc_map, -EIO);
-		errseq_set(&bh->b_assoc_map->host->i_sb->s_wb_err, -EIO);
-	}
 }
 EXPORT_SYMBOL(mark_buffer_write_io_error);
 
-- 
2.49.0.967.g6a0df3ecc3-goog


