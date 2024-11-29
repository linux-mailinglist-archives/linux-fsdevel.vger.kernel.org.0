Return-Path: <linux-fsdevel+bounces-36129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B549DC154
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 10:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D7E9162E0E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 09:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABE2175D34;
	Fri, 29 Nov 2024 09:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="lYx6s+0F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6CF16A92E
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Nov 2024 09:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732871922; cv=none; b=Y+FeRNRe3dfiF/J/UAqelPl7P655jpvposf5L7ab71/k4xS8VWHAwRfUFropPwXzkM+lKZq6j75mgbs9Tl1Jucs+dL8mQ3OJxtQRo7MJadW5TZzlUl/JUZWR3NRxsMvLnYg2Yt4H/JBByY3nX/lDMV8m45nJbYiJwkYySaQzUj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732871922; c=relaxed/simple;
	bh=Y8aEBPbd5DgLbGNrhcKnY3kzlL+4aXBL2AZzYx1CWfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YW7q6tWsdxc8wHk8NuwITM08l4d7LcZ6Ub+XlfDhR3CJlna7Ta0d79occCdgzSIcfnENflVzDHE0nyYKq2AQjNaE7Uux+okb0cfnipvsdEbF3zGeGiVM0k9YzF7Sh05caYBdWvlF2qdsLIC4PMpC1waNzypAdBgZRCkW6/ViO1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=lYx6s+0F; arc=none smtp.client-ip=178.154.239.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net [IPv6:2a02:6b8:c07:109:0:640:efe1:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id 3E88A608F1;
	Fri, 29 Nov 2024 12:18:31 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id SIX747HOl0U0-5hvnaODk;
	Fri, 29 Nov 2024 12:18:30 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1732871910; bh=kdFdHuC1AqlBdX5CGc+aFd6jDW3DJKCLcSvuBGlpCH0=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=lYx6s+0FBs+4JqO2TXjZfMfZ2FjGa4UgrZgCxoM/bgci7oCDLrwoeFktlbmGmzyQ1
	 RQpb4sir7GvTSZc3WhkgljErIoOtOPyr0Wkjii1M+EVX7z41moEWQznV2EmOndfWPf
	 y7CU0XFBHtThi3IbsXYzxBc2/yLAoF+m+GsEJvyI=
Authentication-Results: mail-nwsmtp-smtp-production-main-46.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Steven Whitehouse <swhiteho@redhat.com>,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+9fb37b567267511a9e11@syzkaller.appspotmail.com
Subject: [PATCH 1/2] gfs2: throw -EIO when attempting to access beyond end of device
Date: Fri, 29 Nov 2024 12:03:54 +0300
Message-ID: <20241129090355.365972-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot has reported the following KMSAN splat:

BUG: KMSAN: uninit-value in gfs2_quota_init+0x22c4/0x2950
 gfs2_quota_init+0x22c4/0x2950
 gfs2_make_fs_rw+0x4cf/0x6a0
 gfs2_fill_super+0x43f5/0x45a0
 get_tree_bdev_flags+0x6ee/0x910
 get_tree_bdev+0x37/0x50
 gfs2_get_tree+0x5c/0x340
 vfs_get_tree+0xb3/0x5a0
 do_new_mount+0x71f/0x15e0
 path_mount+0x742/0x1f10
 __se_sys_mount+0x722/0x810
 __x64_sys_mount+0xe4/0x150
 x64_sys_call+0x39bf/0x3c30
 do_syscall_64+0xcd/0x1e0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __alloc_pages_noprof+0x9a7/0xe00
 alloc_pages_mpol_noprof+0x299/0x990
 folio_alloc_noprof+0x1db/0x310
 filemap_alloc_folio_noprof+0xa6/0x440
 __filemap_get_folio+0xac4/0x1550
 gfs2_getbuf+0x23f/0xcd0
 gfs2_meta_ra+0x17f/0x7b0
 gfs2_quota_init+0x78d/0x2950
 gfs2_make_fs_rw+0x4cf/0x6a0
 gfs2_fill_super+0x43f5/0x45a0
 get_tree_bdev_flags+0x6ee/0x910
 get_tree_bdev+0x37/0x50
 gfs2_get_tree+0x5c/0x340
 vfs_get_tree+0xb3/0x5a0
 do_new_mount+0x71f/0x15e0
 path_mount+0x742/0x1f10
 __se_sys_mount+0x722/0x810
 __x64_sys_mount+0xe4/0x150
 x64_sys_call+0x39bf/0x3c30
 do_syscall_64+0xcd/0x1e0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

On a specially crafted filesystem image with invalid on-disk inode data,
'gfs2_meta_ra()' may trigger an attempt to access beyond end of device,
and such an attempt is not detected after 'wait_on_buffer()'. Fix this
by adding an extra 'buffer_uptodate()' check, throwing -EIO in case of
error and adjusting all of the related users.

Reported-by: syzbot+9fb37b567267511a9e11@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9fb37b567267511a9e11
Fixes: 7276b3b0c771 ("[GFS2] Tidy up meta_io code")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 fs/gfs2/dir.c      | 4 ++++
 fs/gfs2/meta_io.c  | 7 +++----
 fs/gfs2/quota.c    | 4 +++-
 fs/gfs2/recovery.c | 2 +-
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index dbf1aede744c..85736135bcf5 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -299,6 +299,10 @@ static int gfs2_dir_read_data(struct gfs2_inode *ip, __be64 *buf,
 				goto fail;
 			BUG_ON(extlen < 1);
 			bh = gfs2_meta_ra(ip->i_gl, dblock, extlen);
+			if (IS_ERR(bh)) {
+				error = PTR_ERR(bh);
+				goto fail;
+			}
 		} else {
 			error = gfs2_meta_read(ip->i_gl, dblock, DIO_WAIT, 0, &bh);
 			if (error)
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index fea3efcc2f93..18957afed91a 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -532,7 +532,7 @@ struct buffer_head *gfs2_meta_ra(struct gfs2_glock *gl, u64 dblock, u32 extlen)
 	first_bh = gfs2_getbuf(gl, dblock, CREATE);
 
 	if (buffer_uptodate(first_bh))
-		goto out;
+		return first_bh;
 	bh_read_nowait(first_bh, REQ_META | REQ_PRIO);
 
 	dblock++;
@@ -546,11 +546,10 @@ struct buffer_head *gfs2_meta_ra(struct gfs2_glock *gl, u64 dblock, u32 extlen)
 		dblock++;
 		extlen--;
 		if (!buffer_locked(first_bh) && buffer_uptodate(first_bh))
-			goto out;
+			return first_bh;
 	}
 
 	wait_on_buffer(first_bh);
-out:
-	return first_bh;
+	return buffer_uptodate(first_bh) ? first_bh : ERR_PTR(-EIO);
 }
 
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 72b48f6f5561..d919edfb8dda 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -1427,8 +1427,10 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
 		}
 		error = -EIO;
 		bh = gfs2_meta_ra(ip->i_gl, dblock, extlen);
-		if (!bh)
+		if (IS_ERR(bh)) {
+			error = PTR_ERR(bh);
 			goto fail;
+		}
 		if (gfs2_metatype_check(sdp, bh, GFS2_METATYPE_QC))
 			goto fail_brelse;
 
diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
index f4fe7039f725..527353c36aa5 100644
--- a/fs/gfs2/recovery.c
+++ b/fs/gfs2/recovery.c
@@ -49,7 +49,7 @@ int gfs2_replay_read_block(struct gfs2_jdesc *jd, unsigned int blk,
 
 	*bh = gfs2_meta_ra(gl, dblock, extlen);
 
-	return error;
+	return IS_ERR(*bh) ? PTR_ERR(*bh) : 0;
 }
 
 int gfs2_revoke_add(struct gfs2_jdesc *jd, u64 blkno, unsigned int where)
-- 
2.47.1


