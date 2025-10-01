Return-Path: <linux-fsdevel+bounces-63158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9160EBAFF54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 12:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 394C22A2036
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 10:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D1D2BDC2C;
	Wed,  1 Oct 2025 10:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="XZfMFc6A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FB21BF58;
	Wed,  1 Oct 2025 10:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759313414; cv=none; b=pPypk9g79/OGY4qwWhbg46OswvOT3bcL/i1NzR/hs0GdRi28b8DzixDATRzoVTaku/5HDiRhKc36Rq27NwXdUt0WXTFFrS/cCMblnNS/BOzt3A46xhTPtVZFoeKuHtuy7+0srQRHM6QPL88ntUxWuD7KUJCjK7u0LRG+MO2YWXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759313414; c=relaxed/simple;
	bh=9Kdcxe0YU1RDTvXq8oIZkEx4aSa2Moo0guzu6R+eV7I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GGywWPbsZPuk/azPytH6sTXvigqNgSIbDRSgEgm8eW29K2jZ4D4BBw8/2rcwf/pY1LjxuI/S5dpiVDdhTfvLrCNOaQeXZ8xr9IoFLeH0ae0PuKTcbQawHL5bq8yLDZFIuE9xlkdTMfSVn51ev6OGt4yWOZY/4favjJMhIORtmnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=XZfMFc6A; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1759313412; x=1790849412;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FpE6TyTqiWm2/3R74zOPPEXG4XAaowdakO3HuHcNBGU=;
  b=XZfMFc6Axk9oLd1mKBsSNKPN7QshEeGFSA4lAEqkJ17TaYdKetzAIRUj
   P7ZevGCIKLthCvCYRopfgmVwLzJmUZZk1ccQuv72aPB8Me0QMXAsIMBZY
   kUE/FbsSYFKOJ33UWvJ7tnDwMha7reCfgczk9HcHcjWS2rdDkU+uFWf/9
   9js4CNTdrl1uhlqUXvSelePayWjewEcR0stHuK48QsZiiAMKk0baYVv5m
   Ob7psy2cOpmbX2U/NJTjwtckSmcpwx5JZD45Na++5X/B4/0PhBM6K/8AO
   koD/ggIdm0VrKdam17hccct+LSvcE5RJgebvS/4egbrK+p9VbOStJqX/f
   A==;
X-CSE-ConnectionGUID: qpOiKXzMTDGK1E2aKN0MIg==
X-CSE-MsgGUID: YLfa/iWkQ5C5l6XDURW5UA==
X-IronPort-AV: E=Sophos;i="6.18,306,1751241600"; 
   d="scan'208";a="3862601"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2025 10:10:10 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:30544]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.10:2525] with esmtp (Farcaster)
 id 58df080d-a7e3-408e-bec0-aaf43a4bcc6e; Wed, 1 Oct 2025 10:10:10 +0000 (UTC)
X-Farcaster-Flow-ID: 58df080d-a7e3-408e-bec0-aaf43a4bcc6e
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 1 Oct 2025 10:10:10 +0000
Received: from dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com
 (172.19.75.107) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20; Wed, 1 Oct 2025
 10:10:08 +0000
From: Jakub Acs <acsjakub@amazon.de>
To: <linux-fsdevel@vger.kernel.org>
CC: <acsjakub@amazon.de>, Jan Kara <jack@suse.cz>, Amir Goldstein
	<amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner
	<brauner@kernel.org>, <linux-unionfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH] fs/notify: call exportfs_encode_fid with s_umount
Date: Wed, 1 Oct 2025 10:09:55 +0000
Message-ID: <20251001100955.59634-1-acsjakub@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D033UWC002.ant.amazon.com (10.13.139.196) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Calling intotify_show_fdinfo() on fd watching an overlayfs inode, while
the overlayfs is being unmounted, can lead to dereferencing NULL ptr.

This issue was found by syzkaller.

Race Condition Diagram:

Thread 1                           Thread 2
--------                           --------

generic_shutdown_super()
 shrink_dcache_for_umount
  sb->s_root = NULL

                    |
                    |             vfs_read()
                    |              inotify_fdinfo()
                    |               * inode get from mark *
                    |               show_mark_fhandle(m, inode)
                    |                exportfs_encode_fid(inode, ..)
                    |                 ovl_encode_fh(inode, ..)
                    |                  ovl_check_encode_origin(inode)
                    |                   * deref i_sb->s_root *
                    |
                    |
                    v
 fsnotify_sb_delete(sb)

Which then leads to:

[   32.133461] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
[   32.134438] KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
[   32.135032] CPU: 1 UID: 0 PID: 4468 Comm: systemd-coredum Not tainted 6.17.0-rc6 #22 PREEMPT(none)

<snip registers, unreliable trace>

[   32.143353] Call Trace:
[   32.143732]  ovl_encode_fh+0xd5/0x170
[   32.144031]  exportfs_encode_inode_fh+0x12f/0x300
[   32.144425]  show_mark_fhandle+0xbe/0x1f0
[   32.145805]  inotify_fdinfo+0x226/0x2d0
[   32.146442]  inotify_show_fdinfo+0x1c5/0x350
[   32.147168]  seq_show+0x530/0x6f0
[   32.147449]  seq_read_iter+0x503/0x12a0
[   32.148419]  seq_read+0x31f/0x410
[   32.150714]  vfs_read+0x1f0/0x9e0
[   32.152297]  ksys_read+0x125/0x240

IOW ovl_check_encode_origin derefs inode->i_sb->s_root, after it was set
to NULL in the unmount path.

Fix it by protecting calling exportfs_encode_fid() from
show_mark_fhandle() with s_umount lock.

This form of fix was suggested by Amir in [1].

[1]: https://lore.kernel.org/all/CAOQ4uxhbDwhb+2Brs1UdkoF0a3NSdBAOQPNfEHjahrgoKJpLEw@mail.gmail.com/

Fixes: c45beebfde34 ("ovl: support encoding fid from inode with no alias")
Signed-off-by: Jakub Acs <acsjakub@amazon.de>
Cc: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
---

This issue was already discussed in [1] with no consensus reached on the
fix.

This form was suggested as a band-aid fix, without explicity yes/no
reaction. Hence reviving the discussion around the band-aid.

 fs/notify/fdinfo.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
index 1161eabf11ee..9cc7eb863643 100644
--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -17,6 +17,7 @@
 #include "fanotify/fanotify.h"
 #include "fdinfo.h"
 #include "fsnotify.h"
+#include "../internal.h"
 
 #if defined(CONFIG_PROC_FS)
 
@@ -46,7 +47,12 @@ static void show_mark_fhandle(struct seq_file *m, struct inode *inode)
 
 	size = f->handle_bytes >> 2;
 
+	if (!super_trylock_shared(inode->i_sb))
+		return;
+
 	ret = exportfs_encode_fid(inode, (struct fid *)f->f_handle, &size);
+	up_read(&inode->i_sb->s_umount);
+
 	if ((ret == FILEID_INVALID) || (ret < 0))
 		return;
 
-- 
2.47.3




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


