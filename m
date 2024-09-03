Return-Path: <linux-fsdevel+bounces-28320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F13969352
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 07:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B550B23174
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 05:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFFA1CEABC;
	Tue,  3 Sep 2024 05:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsLnkosh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62E91C36;
	Tue,  3 Sep 2024 05:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725342496; cv=none; b=SvXGuN3OV/aFqoF67qQXzNb/QJg4aqtLt2m99QQdE4QApSPCUhebuioZEgMCCq5iGj/vkgnicjf8xdc0hPDmwMJ49a/8Y2N60oebyKH+EJP4c2qQ60kS53IcJPbfwEVvlwBSVM+Ia/DULLaB7ngYNHJ3HlTs17cvGla3rfL4n5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725342496; c=relaxed/simple;
	bh=thvWb6/FcNkw42kpdYrjOO/9GBTLKOCi2h+FLP38Z9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q2pKKG0Uw7UQp4RbvXM7/NfUmZ60tW8+YGDQiRMOMY2kuzfJ/524DK0mjk2b26KZkLF8Jj0plJrbbuM/KN2y45z56+bIPds9AFfMrADcW58vkR0jHvBzOILC9RWbYKC4oSQyxtRn9oK/KmUE9bjNwLuRrMfgF1+N2rsrr7SibQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsLnkosh; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71433096e89so3788348b3a.3;
        Mon, 02 Sep 2024 22:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725342493; x=1725947293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2wddDtgNRo6H+L5O7VjLJSxivaqF2zLC8e/VyYLHeRM=;
        b=CsLnkoshFdxKKuT9ksAlDyrsVwa5l0yxFmbw6y+uVqEuPnNehB3XcquhxXs3xiEVwR
         IxOCO9epmCj2rWR2OLZdfLE1Ueom3/eXBjNVdKsU1aYVpu6qRDeZRWFnEgp9Wpf2xbNV
         RTs7HdGp24dIRNKqZB2hZ4UVpsZUlGB+aL47ola5m29yWQaAUocBZ9L6GUv9cHEafy3p
         FJouLDwLPLe58AEFr4+8FT4NmqBP+apI8YW4H2dwmGP/fBxb2lVH1oUwmhRm7TePQdbH
         k19hfahdH4lW+pWIj5SD031bSFGeIS/E2oL0kKXX5OBkbUKN5qPYBDsnkSVJnkfbicKL
         wmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725342493; x=1725947293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2wddDtgNRo6H+L5O7VjLJSxivaqF2zLC8e/VyYLHeRM=;
        b=hO5p54k0T+VWPLVXZWdzM3wHpw+nKwcdvPx3nJhJuqDDtD7Kj+kJLII1oYLgt94cIt
         gW5H438u5NncqjPccCVrzjOlO7ItO6KDuxaAGEYM1ZDvGIEsHxRoe55o4hlNN6ouocIT
         gj4wEu5A8diHt4mGSQvMTuLjBnJ65hYEKVxecN3MuaKDMm5TFxmfxGEoKqPEuVhwqRGk
         URNxUai9jy4emarmMA3JyzjqT7TxEYSVHYwl8HCM1W6c5DNHviyNnu1CyMuPLGp6SJ35
         IbQqWSol5M0/DnaH8kHdGvB57DbaNxBXZsUrl4zuKem5MJqumI4czrFJTy4/m5N7cYjo
         S0Og==
X-Forwarded-Encrypted: i=1; AJvYcCUNK6Qqp0bB0YjrMr6rDQ1zdxkqVcscKyDrQW7THOeVYZqsJg2fJYIiNEyUNFys5HY8tVu/rUgIQYvZ@vger.kernel.org, AJvYcCUwHwbueaxuVRPErVNX++tkgqprZ+0/8l+e9KLB6IzhS77U4nZbPVqW8wh1+uofqOVwtneew55xicG4+EFLOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcmOWQc+UNax6ra6XHqL+H/PNIBikQwMyjh+rDG+LnlQt/7bt6
	vxcLA2V6Ud7sMZIN8LFpsaqs4G6J19aPpyFl+sk6F/7Dhl7oDGBWPJmrvg==
X-Google-Smtp-Source: AGHT+IHNIiVRhe866pxn7l8CEtRiXBoW/hHx+m6dOWzSojMn41HgSvRb1iDivSrUDTA4IcDjCmqJhw==
X-Received: by 2002:a05:6a21:670b:b0:1c0:f648:8574 with SMTP id adf61e73a8af0-1cece520865mr9338847637.29.1725342492990;
        Mon, 02 Sep 2024 22:48:12 -0700 (PDT)
Received: from localhost ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152cd57dsm74140175ad.93.2024.09.02.22.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 22:48:12 -0700 (PDT)
From: Julian Sun <sunjunchao2870@gmail.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	brauner@kernel.org,
	djwong@kernel.org,
	hch@lst.de,
	Julian Sun <sunjunchao2870@gmail.com>,
	syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com
Subject: [PATCH] iomap: clean preallocated blocks in iomap_end() when 0 bytes was written.
Date: Tue,  3 Sep 2024 13:48:08 +0800
Message-Id: <20240903054808.126799-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, all.

Recently, syzbot reported a issue as following:

WARNING: CPU: 1 PID: 5222 at fs/iomap/buffered-io.c:727 __iomap_write_begin fs/iomap/buffered-io.c:727 [inline]
WARNING: CPU: 1 PID: 5222 at fs/iomap/buffered-io.c:727 iomap_write_begin+0x13f0/0x16f0 fs/iomap/buffered-io.c:830
CPU: 1 UID: 0 PID: 5222 Comm: syz-executor247 Not tainted 6.11.0-rc2-syzkaller-00111-gee9a43b7cfe2 #0
RIP: 0010:__iomap_write_begin fs/iomap/buffered-io.c:727 [inline]
RIP: 0010:iomap_write_begin+0x13f0/0x16f0 fs/iomap/buffered-io.c:830
Call Trace:
 <TASK>
 iomap_unshare_iter fs/iomap/buffered-io.c:1351 [inline]
 iomap_file_unshare+0x460/0x780 fs/iomap/buffered-io.c:1391
 xfs_reflink_unshare+0x173/0x5f0 fs/xfs/xfs_reflink.c:1681
 xfs_file_fallocate+0x6be/0xa50 fs/xfs/xfs_file.c:997
 vfs_fallocate+0x553/0x6c0 fs/open.c:334
 ksys_fallocate fs/open.c:357 [inline]
 __do_sys_fallocate fs/open.c:365 [inline]
 __se_sys_fallocate fs/open.c:363 [inline]
 __x64_sys_fallocate+0xbd/0x110 fs/open.c:363
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2d716a6899

syzbot constructed the following scenario: syzbot called the write()
system call, passed an illegal pointer, and attempted to write 0x1017
bytes, resulting in 0 bytes written and returning EFAULT to user
space. Then, it called the write() system call again, passed another
illegal pointer, and attempted to write 0xfea7 bytes, resulting in
0xe00 bytes written. Finally called copy_file_range() sys call and
fallocate() sys call with FALLOC_FL_UNSHARE_RANGE flag.

What happened here is: during the first write, xfs_buffered_write_iomap_begin()
used preallocated 512 blocks, inserted an extent with a length of 512 and
reserved 512 blocks in the quota, with the iomap length being 1M.
However, when the write failed(0 byte was written), only 0x1017 bytes were
passed to iomap_end() instead of the preallocated 1M bytes/512 blocks.
This caused only 3 blocks to be unreserved for the quota in iomap_end(),
instead of 512, and the corresponding extent information also only removed
3 blocks instead of 512.

As a result, during the second write, the iomap length was 3 blocks
instead of the expected 512 blocks, which ultimately triggered the
issue reported by syzbot in the fallocate() system call.

To resolve this issue, when a write fails, we should pass
iomap.length to iomap_end() to indicate it to clean up all
the resources, rather than just the length requested by the user.

This patch has already passed xfstests -g quick test on both xfs
and ext4 without causing additional failures.

Reported-and-tested-by: syzbot+296b1c84b9cbf306e5a0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=296b1c84b9cbf306e5a0
Fixes: f4b896c213f0 ("iomap: add the new iomap_iter model")
Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
---
 fs/iomap/iter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
index 79a0614eaab7..6e3f6109cac5 100644
--- a/fs/iomap/iter.c
+++ b/fs/iomap/iter.c
@@ -76,7 +76,8 @@ int iomap_iter(struct iomap_iter *iter, const struct iomap_ops *ops)
 	int ret;
 
 	if (iter->iomap.length && ops->iomap_end) {
-		ret = ops->iomap_end(iter->inode, iter->pos, iomap_length(iter),
+		ret = ops->iomap_end(iter->inode, iter->pos,
+				iter->processed > 0 ? iomap_length(iter) : iter->iomap.length,
 				iter->processed > 0 ? iter->processed : 0,
 				iter->flags, &iter->iomap);
 		if (ret < 0 && !iter->processed)
-- 
2.39.2


