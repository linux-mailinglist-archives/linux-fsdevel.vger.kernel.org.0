Return-Path: <linux-fsdevel+bounces-48308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 473A0AAD1A4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 01:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 171271C00B81
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 23:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD21E21CC68;
	Tue,  6 May 2025 23:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OZDZjf47"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE05C2FA
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 May 2025 23:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746575123; cv=none; b=RlFiE/eaQqoCoVmR9MVHSCRmX2Wwtu5N3o6OfHpu4N4MaeRY1wIqPKfkPjvY+DCiKSM6maxQo9CCGz1q/jfee8LUInAKYHiiSd8KoO07l0SlQxuUt+fttu6hE1jSWsh2qggtDcABg0cn4j83KmtcaTpcNw03ZaErRL156XzLBpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746575123; c=relaxed/simple;
	bh=XS7JJ3Nvl0CmH2LCkgen7htJdtCoZtihW3XvOWVmfV8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OO/ZWQ7IEt3DlPpH9y5SdRFuKKRg+US9E9WjwekFPJL9UVj4neSrnXILgN5ADvHBay4PXDfkdU6mh5p6kH8DVOUIPAVL2tjeaEn8Xo0Rff5wCx71jT+MGPIwHlWorv5WcHoGF2Z7fmMHwDeldlTsAgiIzy6LkbnEWuVvP2HmY4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jbongio.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OZDZjf47; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jbongio.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b1fdf8f67e6so804237a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 May 2025 16:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746575121; x=1747179921; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OtsPDcfZJqIIpn5wMR7VBZW6rWeFTQMhjG+hUDcv2rM=;
        b=OZDZjf47gWGNzU/JMsZyHG/iWBdNCe7CX8VgSYddCyhNKDl+WpZ6s5yUHX4v51quwr
         ARV5TooqRjTqWn2t8u1ugO0WShYdkrAomy0qPkP+pjz1QoRgxU53bp4yRUS2u5RC+A6q
         2v4OTgzUzV9oqLtc0cd2kBx91jJCfhSPiHWhp/fkepzJILa2JvjPeHFMDusaH1CDq9H8
         z9YIm6oHm3NG3gvfRr1ZmdbFVne0W7fHgCE+396c48YGsOetWK8CubiGGorhtcjk6/Wd
         YaeaHiiMPVJtVi/6iAeE98yfD9/YgymaZE1NgSe6fi3DbgdCK2nVfkD4xs11T+Mc/m0P
         I4aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746575121; x=1747179921;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OtsPDcfZJqIIpn5wMR7VBZW6rWeFTQMhjG+hUDcv2rM=;
        b=UIDq3H2A//wF3kM51pwXrIG8+uJeqkd0BsFOJHKBFlF36eKergNxpLUV9wW1Fgf2Lh
         ws7PNOlWYOXeEEuV9q4ntqK6RHDMWWsB9PWvsDjm5lD0wZydoyqYXxpyZTK7wUALqHaL
         t+jEme0tE/4eY6rVfz93jhcqrJXOMYZWnW97j4AKQ85aFUKy0Y4RgOAXfQ/ocWbEcfWy
         Pndd4cziE72X3DYylT1lFn87diEiQekb6cX2Evjy6PP/8OoZt3AWW8UgTHeZcJ3x0KzQ
         PooMsofUgeIxKDdjWSLbBGFfcskWkzRPgOt7d+VE4W7jvDnk37Ksx/xa+T4/tbA1rfId
         bbMA==
X-Gm-Message-State: AOJu0YxCBLyiKnGaafR8DeMKuyX5b16+wix8OkSKXoLSRhnTvUHrj5d0
	sPhWPx8ccWUnh6Ef1WPuyN13RQUYtSWQl4JKbF0CRpHoVLM3MS9rgBiMHa9C/zz6WYqTTCWzaN4
	w9IWU6w==
X-Google-Smtp-Source: AGHT+IFOaTs6P5tiVHNZk2Rtlo+DhEBVeGcUQKxC4Xo2GccgbstxSSMbBnoVUIgGOLU8TijamyIqip32VXfx
X-Received: from pfiu20.prod.google.com ([2002:a05:6a00:1254:b0:740:91e5:c308])
 (user=jbongio job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:438d:b0:1f5:8c05:e8f8
 with SMTP id adf61e73a8af0-2148c0f6678mr1495484637.25.1746575120863; Tue, 06
 May 2025 16:45:20 -0700 (PDT)
Date: Tue,  6 May 2025 23:45:07 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <20250506234507.1017554-1-jbongio@google.com>
Subject: [PATCH] fs: Remove redundant errseq_set call in mark_buffer_write_io_error.
From: Jeremy Bongio <jbongio@google.com>
To: Christoph Hellwig <hch@lst.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeremy Bongio <jbongio@google.com>
Content-Type: text/plain; charset="UTF-8"

mark_buffer_write_io_error sets sb->s_wb_err to -EIO twice.
Once in mapping_set_error and once in errseq_set.
Only mapping_set_error checks if bh->b_assoc_map->host is NULL.

Discovered during null pointer dereference while removing
a failing iblock device:

0xffffffff8be13778      mark_buffer_write_io_error + 0x98
0xffffffff8c755310      end_buffer_async_write + 0x90
0xffffffff8c75791b      end_bio_bh_io_sync + 0x2b
0xffffffff8c7c54d2      blk_update_request + 0x1b2
0xffffffff8c7c58c8      blk_mq_end_request + 0x18
0xffffffff8c7c6f96      blk_mq_dispatch_rq_list + 0x8d6
0xffffffff8c7caf98      __blk_mq_sched_dispatch_requests + 0x218
0xffffffff8c7cad2a      blk_mq_sched_dispatch_requests + 0x3a
0xffffffff8c7c6088      blk_mq_run_hw_queue + 0x108
0xffffffff8c7c74b8      blk_mq_flush_plug_list + 0x178
0xffffffff8c7c0c61      __blk_flush_plug + 0x41
0xffffffff8c7c0d72      blk_finish_plug + 0x22
0xffffffff8c6d8a98      do_writepages + 0x98
0xffffffff8c6d16f0      filemap_fdatawrite_wbc + 0x70
0xffffffff8c6d195c      filemap_flush + 0x9c
0xffffffff8be0d730      sync_filesystem + 0x40
0xffffffff8bdecfd7      fs_bdev_mark_dead + 0x27
0xffffffff8bf35fdb      bdev_mark_dead + 0x6b
0xffffffff8bf4a993      blk_report_disk_dead + 0x73
0xffffffff8c7cc2ce      del_gendisk + 0xde
0xffffffff8c153f14      iblock_destroy_blkdev + 0x24
0xffffffff8c1523ce      iblock_destroy_work_fn + 0x1e
0xffffffff8c658b75      process_scheduled_works + 0x1d5
0xffffffff8c6590ca      worker_thread + 0x1da

Fixes: 4b2201dad2674 ("fs: stop using bdev->bd_super in mark_buffer_write_io_error")
Signed-off-by: Jeremy Bongio <jbongio@google.com>
---
 fs/buffer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 7be23ff20b27..d7456e4643f6 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1222,7 +1222,6 @@ void mark_buffer_write_io_error(struct buffer_head *bh)
 		mapping_set_error(bh->b_folio->mapping, -EIO);
 	if (bh->b_assoc_map) {
 		mapping_set_error(bh->b_assoc_map, -EIO);
-		errseq_set(&bh->b_assoc_map->host->i_sb->s_wb_err, -EIO);
 	}
 }
 EXPORT_SYMBOL(mark_buffer_write_io_error);
-- 
2.49.0.967.g6a0df3ecc3-goog


