Return-Path: <linux-fsdevel+bounces-30935-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 334B398FD53
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 08:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAFE41F2185F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 06:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF33F12B176;
	Fri,  4 Oct 2024 06:28:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB19A6F305;
	Fri,  4 Oct 2024 06:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728023325; cv=none; b=ce/ix3OxStDkGLjvIv+ODtsfCblfgzlKLbTG95EjEa0LTi3Si1bEAz/i1HGto6BJLY/YWf8l4JCJPU+C1On459XYAchkJLikPmdTlHTOPUGr/wvygBHfAJmg/tUM8gQOnQoO26zfagQjZoUninK0WlGqLeOBK7m6y7c9EJYu8Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728023325; c=relaxed/simple;
	bh=jkkJMMrSbK6C7UmCv6f9H/qFBHejsFq/miM9SZS//V0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u0BSyLrkwfyiBFWo7mj8nBdby8Qhvx8CBor8pDijJYAuv3xtB24TDdFntd+FOvqYcQ++HRoimDt1vm6s5tL4oFXneYTspyOGCj6yRLIxZ3fUrGlU3HdYvsUBP1MNZRvcgsBMbwLH0IyeD4mATzvzATAuQjUuSthKJu2814bGkcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 916082055FA3;
	Fri,  4 Oct 2024 15:20:36 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-6) with ESMTPS id 4946KZSC103714
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 4 Oct 2024 15:20:36 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-6) with ESMTPS id 4946KZVf731528
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 4 Oct 2024 15:20:35 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 4946KZ5c731527;
	Fri, 4 Oct 2024 15:20:35 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: syzbot <syzbot+ef0d7bc412553291aa86@syzkaller.appspotmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linkinjeon@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [exfat?] KMSAN: uninit-value in vfat_rename2
In-Reply-To: <66ff2c95.050a0220.49194.03e9.GAE@google.com> (syzbot's message
	of "Thu, 03 Oct 2024 16:45:25 -0700")
References: <66ff2c95.050a0220.49194.03e9.GAE@google.com>
Date: Fri, 04 Oct 2024 15:20:34 +0900
Message-ID: <87r08wjsnh.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

syzbot <syzbot+ef0d7bc412553291aa86@syzkaller.appspotmail.com> writes:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    e7ed34365879 Merge tag 'mailbox-v6.12' of git://git.kernel..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=11b54ea9980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=92da5062b0d65389
> dashboard link: https://syzkaller.appspot.com/bug?extid=ef0d7bc412553291aa86
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b7ed07980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=101dfd9f980000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/66cc3d8c5c10/disk-e7ed3436.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c7769a88b445/vmlinux-e7ed3436.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/c1fe4c6ee436/bzImage-e7ed3436.xz
> mounted in repro #1: https://storage.googleapis.com/syzbot-assets/2ab98c65fd49/mount_0.gz
> mounted in repro #2: https://storage.googleapis.com/syzbot-assets/7ffc0eb73060/mount_5.gz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ef0d7bc412553291aa86@syzkaller.appspotmail.com

The patch fixes this bug. Please apply.
Thanks.


From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: [PATCH] fat: Fix uninitialized variable
Date: Fri, 04 Oct 2024 15:03:49 +0900

Reported-by: syzbot+ef0d7bc412553291aa86@syzkaller.appspotmail.com
Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---
 fs/fat/namei_vfat.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index 6423e1d..15bf32c 100644
--- a/fs/fat/namei_vfat.c	2024-10-04 14:51:50.473038530 +0900
+++ b/fs/fat/namei_vfat.c	2024-10-04 14:56:53.108618655 +0900
@@ -1037,7 +1037,7 @@ error_inode:
 	if (corrupt < 0) {
 		fat_fs_error(new_dir->i_sb,
 			     "%s: Filesystem corrupted (i_pos %lld)",
-			     __func__, sinfo.i_pos);
+			     __func__, new_i_pos);
 	}
 	goto out;
 }
_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

