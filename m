Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8A96958B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 06:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjBNFve (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 00:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjBNFvX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 00:51:23 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B5C1C7EF
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Feb 2023 21:51:21 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so19250434pjq.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Feb 2023 21:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZLwifksZSXnUDr5sO0tJjBAlgxcCepDWDdg2HoH0Tc=;
        b=eWD+x8mUOWS6qVzotZ3V+2qMmWYNRfLyD8v3WUNYQjnHcx5ichpbF5wX3qeDNGjYYr
         ZJdDhEQ4s1GLHpjQAYqwZ5K4DiZa0ZLm0o3PImpFKw4W6FAfAJle41EQ817TYEAqTz8/
         7kmQMMwYviCuiBce5aCS7gWbXtigR+MPDvG1DME+w+VxGxteI3WDp2MV5ZslDt2ajxue
         MXzGUZmJfJ0rs1smmJLqOgEP5vXfti2TmoPrM2fOYXNbBs+elbCBmAxn1USi3UJWTRaQ
         xCyhEjzALhiDjmeA4R4npp6Fe+uLrMX+951kZpNCttfHJQGFWi2RaZlmZR5DcQPapoA9
         2rtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZLwifksZSXnUDr5sO0tJjBAlgxcCepDWDdg2HoH0Tc=;
        b=yCWOCIRYXGtmo8g8FgS61bMn5nrLCL9G8S1ObbLeXsC5dXUhye84QLmmcmTMt7de9P
         8qULs8DWXz5noshySH/2/Cv9WZ9lSOatMB2zXIlpEVDJzxB/9olLa+OzyPRAgI6KJNLF
         REILZXKVn6T93PS1MsmCQOjrLtT9sZRfpcF5O9MZM738Yu7fL2ERVZE/J4499T7P1BID
         1J83j8BXRqVk83mktHqMiJpcpw8um//ROadPxpKJ+xBTCSb/O6tlYCNw6pfgVbLLlwaU
         xdw6GZJOyawxkVcPfDqAZ95LYUFpnsCDInP7Zk0ICCDq2Bnk6T2o8OXrANyusLwUHx1P
         qppA==
X-Gm-Message-State: AO0yUKX+8TGP6XIDzXHgjzSDtJyZ2XhabZQTpcqVb/1rac64F1Spr3+3
        UzSZR/TTD9f8x/2yznBK8AIglw==
X-Google-Smtp-Source: AK7set86mEk5hlWyjNXTo7wKqcQxv+VXxCD+25L7rSon37f+5Qr9gTHbXjaACmngsmqJVj70K7J7EQ==
X-Received: by 2002:a05:6a20:4421:b0:bc:74c3:9499 with SMTP id ce33-20020a056a20442100b000bc74c39499mr1503901pzb.24.1676353880892;
        Mon, 13 Feb 2023 21:51:20 -0800 (PST)
Received: from dread.disaster.area (pa49-181-4-128.pa.nsw.optusnet.com.au. [49.181.4.128])
        by smtp.gmail.com with ESMTPSA id s3-20020a637703000000b004e8f7f23c4bsm3407280pgc.76.2023.02.13.21.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 21:51:19 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <dave@fromorbit.com>)
        id 1pRoDk-00F5yL-JA; Tue, 14 Feb 2023 16:51:16 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.96)
        (envelope-from <dave@devoid.disaster.area>)
        id 1pRoDk-00HNdR-1q;
        Tue, 14 Feb 2023 16:51:16 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     linux-xfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/3] xfs, iomap: ->discard_folio() is broken so remove it
Date:   Tue, 14 Feb 2023 16:51:14 +1100
Message-Id: <20230214055114.4141947-4-david@fromorbit.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230214055114.4141947-1-david@fromorbit.com>
References: <20230214055114.4141947-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Ever since commit e9c3a8e820ed ("iomap: don't invalidate folios
after writeback errors") XFS and iomap have been retaining dirty
folios in memory after a writeback error. XFS no longer invalidates
the folio, and iomap no longer clears the folio uptodate state.

However, iomap is still been calling ->discard_folio on error, and
XFS is still punching the delayed allocation range backing the dirty
folio.

This is incorrect behaviour. The folio remains dirty and up to date,
meaning that another writeback will be attempted in the near future.
THis means that XFS is still going to have to allocate space for it
during writeback, and that means it still needs to have a delayed
allocation reservation and extent backing the dirty folio.

Failure to retain the delalloc extent (because xfs_discard_folio()
punched it out) means that the next writeback attempt does not find
an extent over the range of the write in ->map_blocks(), and
xfs_map_blocks() triggers a WARN_ON() because it should never land
in a hole for a data fork writeback request. This looks like:

[  647.356969] ------------[ cut here ]------------
[  647.359277] WARNING: CPU: 14 PID: 21913 at fs/xfs/libxfs/xfs_bmap.c:4510 xfs_bmapi_convert_delalloc+0x221/0x4e0
[  647.364551] Modules linked in:
[  647.366294] CPU: 14 PID: 21913 Comm: test_delalloc_c Not tainted 6.2.0-rc7-dgc+ #1754
[  647.370356] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
[  647.374781] RIP: 0010:xfs_bmapi_convert_delalloc+0x221/0x4e0
[  647.377807] Code: e9 7d fe ff ff 80 bf 54 01 00 00 00 0f 84 68 fe ff ff 48 8d 47 70 48 89 04 24 e9 63 fe ff ff 83 fd 02 41 be f5 ff ff ff 74 a5 <0f> 0b eb a0
[  647.387242] RSP: 0018:ffffc9000aa677a8 EFLAGS: 00010293
[  647.389837] RAX: 0000000000000000 RBX: ffff88825bc4da00 RCX: 0000000000000000
[  647.393371] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88825bc4da40
[  647.396546] RBP: 0000000000000000 R08: ffffc9000aa67810 R09: ffffc9000aa67850
[  647.400186] R10: ffff88825bc4da00 R11: ffff888800a9aaac R12: ffff888101707000
[  647.403484] R13: ffffc9000aa677e0 R14: 00000000fffffff5 R15: 0000000000000004
[  647.406251] FS:  00007ff35ec24640(0000) GS:ffff88883ed00000(0000) knlGS:0000000000000000
[  647.410089] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  647.413225] CR2: 00007f7292cbc5d0 CR3: 0000000807d0e004 CR4: 0000000000060ee0
[  647.416917] Call Trace:
[  647.418080]  <TASK>
[  647.419291]  ? _raw_spin_unlock_irqrestore+0xe/0x30
[  647.421400]  xfs_map_blocks+0x1b7/0x590
[  647.422951]  iomap_do_writepage+0x1f1/0x7d0
[  647.424607]  ? __mod_lruvec_page_state+0x93/0x140
[  647.426419]  write_cache_pages+0x17b/0x4f0
[  647.428079]  ? iomap_read_end_io+0x2c0/0x2c0
[  647.429839]  iomap_writepages+0x1c/0x40
[  647.431377]  xfs_vm_writepages+0x79/0xb0
[  647.432826]  do_writepages+0xbd/0x1a0
[  647.434207]  ? obj_cgroup_release+0x73/0xb0
[  647.435769]  ? drain_obj_stock+0x130/0x290
[  647.437273]  ? avc_has_perm+0x8a/0x1a0
[  647.438746]  ? avc_has_perm_noaudit+0x8c/0x100
[  647.440223]  __filemap_fdatawrite_range+0x8e/0xa0
[  647.441960]  filemap_write_and_wait_range+0x3d/0xa0
[  647.444258]  __iomap_dio_rw+0x181/0x790
[  647.445960]  ? __schedule+0x385/0xa20
[  647.447829]  iomap_dio_rw+0xe/0x30
[  647.449284]  xfs_file_dio_write_aligned+0x97/0x150
[  647.451332]  ? selinux_file_permission+0x107/0x150
[  647.453299]  xfs_file_write_iter+0xd2/0x120
[  647.455238]  vfs_write+0x20d/0x3d0
[  647.456768]  ksys_write+0x69/0xf0
[  647.458067]  do_syscall_64+0x34/0x80
[  647.459488]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  647.461529] RIP: 0033:0x7ff3651406e9
[  647.463119] Code: 48 8d 3d 2a a1 0c 00 0f 05 eb a5 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f8
[  647.470563] RSP: 002b:00007ff35ec23df8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  647.473465] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff3651406e9
[  647.476278] RDX: 0000000000001400 RSI: 0000000020000000 RDI: 0000000000000005
[  647.478895] RBP: 00007ff35ec23e20 R08: 0000000000000005 R09: 0000000000000000
[  647.481568] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe533d8d4e
[  647.483751] R13: 00007ffe533d8d4f R14: 0000000000000000 R15: 00007ff35ec24640
[  647.486168]  </TASK>
[  647.487142] ---[ end trace 0000000000000000 ]---

Punching delalloc extents out from under dirty cached pages is wrong
and broken. We can't remove the delalloc extent until the page is
either removed from memory (i.e. invaliated) or writeback succeeds
in converting the delalloc extent to a real extent and writeback can
clean the page.

Hence we remove xfs_discard_folio() because it is only punching
delalloc blocks from under dirty pages now. With that removal,
nothing else uses ->discard_folio(), so we remove that from the
iomap infrastructure as well.

Reported-by: pengfei.xu@intel.com
Fixes: e9c3a8e820ed ("iomap: don't invalidate folios after writeback errors")
Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/iomap/buffered-io.c | 16 +++-------------
 fs/xfs/xfs_aops.c      | 35 -----------------------------------
 include/linux/iomap.h  |  6 ------
 3 files changed, 3 insertions(+), 54 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 356193e44cf0..502fa2d41097 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1635,19 +1635,9 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	 * completion to mark the error state of the pages under writeback
 	 * appropriately.
 	 */
-	if (unlikely(error)) {
-		/*
-		 * Let the filesystem know what portion of the current page
-		 * failed to map. If the page hasn't been added to ioend, it
-		 * won't be affected by I/O completion and we must unlock it
-		 * now.
-		 */
-		if (wpc->ops->discard_folio)
-			wpc->ops->discard_folio(folio, pos);
-		if (!count) {
-			folio_unlock(folio);
-			goto done;
-		}
+	if (unlikely(error && !count)) {
+		folio_unlock(folio);
+		goto done;
 	}
 
 	folio_start_writeback(folio);
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 41734202796f..3f0dae5ca9c2 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -448,44 +448,9 @@ xfs_prepare_ioend(
 	return status;
 }
 
-/*
- * If the page has delalloc blocks on it, we need to punch them out before we
- * invalidate the page.  If we don't, we leave a stale delalloc mapping on the
- * inode that can trip up a later direct I/O read operation on the same region.
- *
- * We prevent this by truncating away the delalloc regions on the page.  Because
- * they are delalloc, we can do this without needing a transaction. Indeed - if
- * we get ENOSPC errors, we have to be able to do this truncation without a
- * transaction as there is no space left for block reservation (typically why we
- * see a ENOSPC in writeback).
- */
-static void
-xfs_discard_folio(
-	struct folio		*folio,
-	loff_t			pos)
-{
-	struct xfs_inode	*ip = XFS_I(folio->mapping->host);
-	struct xfs_mount	*mp = ip->i_mount;
-	int			error;
-
-	if (xfs_is_shutdown(mp))
-		return;
-
-	xfs_alert_ratelimited(mp,
-		"page discard on page "PTR_FMT", inode 0x%llx, pos %llu.",
-			folio, ip->i_ino, pos);
-
-	error = xfs_bmap_punch_delalloc_range(ip, pos,
-			round_up(pos, folio_size(folio)));
-
-	if (error && !xfs_is_shutdown(mp))
-		xfs_alert(mp, "page discard unable to remove delalloc mapping.");
-}
-
 static const struct iomap_writeback_ops xfs_writeback_ops = {
 	.map_blocks		= xfs_map_blocks,
 	.prepare_ioend		= xfs_prepare_ioend,
-	.discard_folio		= xfs_discard_folio,
 };
 
 STATIC int
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 0983dfc9a203..681e26a86791 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -310,12 +310,6 @@ struct iomap_writeback_ops {
 	 * conversions.
 	 */
 	int (*prepare_ioend)(struct iomap_ioend *ioend, int status);
-
-	/*
-	 * Optional, allows the file system to discard state on a page where
-	 * we failed to submit any I/O.
-	 */
-	void (*discard_folio)(struct folio *folio, loff_t pos);
 };
 
 struct iomap_writepage_ctx {
-- 
2.39.0

