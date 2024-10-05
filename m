Return-Path: <linux-fsdevel+bounces-31050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A359914B1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 07:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78B401F23356
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 05:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC02481D1;
	Sat,  5 Oct 2024 05:50:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75826380;
	Sat,  5 Oct 2024 05:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728107445; cv=none; b=bAKTNkreNZc25dhy9jNHzY6N0s7yYc4pz73Q+LoEPmkC+qLCRpDOjx/FpF+Z2666Wdw4YslicIGwBGd+w299WTJQd406xi2jxpZzORFfG2qJHIFZM2S2iRHtTkrmcfEyuL/HxDh5mkSSbNoH6kKiz5pFkGwAbOw2d5aNKQS2tNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728107445; c=relaxed/simple;
	bh=R7cxEsN+UnbUmIliTAH/0H4gE9lFR/4ihLfCPer5wII=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K+FSN4EQPqx+t5Wbt24Qsr+PGciqzoneFlVRCnzFDOoG4adsoj+v8M3u67nVJgyMOK3iDn3QSqhNBh2p7vLHh+yhWbkki8AhLan98G1QX6N2qQUkDG8MDM9DfTRx7k3FEAGw9Iq5SRSOhuSISsi5jrdSKZELbpwIJGddfDgPOGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 232AD2055FA2;
	Sat,  5 Oct 2024 14:50:41 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-6) with ESMTPS id 4955odwl012195
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 5 Oct 2024 14:50:40 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-6) with ESMTPS id 4955odmH101869
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 5 Oct 2024 14:50:39 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 4955odGi101868;
	Sat, 5 Oct 2024 14:50:39 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: syzbot <syzbot+ef0d7bc412553291aa86@syzkaller.appspotmail.com>,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [exfat?] KMSAN: uninit-value in vfat_rename2
In-Reply-To: <20241004155332.b2a7603be540c692e56dc71c@linux-foundation.org>
	(Andrew Morton's message of "Fri, 4 Oct 2024 15:53:32 -0700")
References: <66ff2c95.050a0220.49194.03e9.GAE@google.com>
	<87r08wjsnh.fsf@mail.parknet.co.jp>
	<20241004155332.b2a7603be540c692e56dc71c@linux-foundation.org>
Date: Sat, 05 Oct 2024 14:50:39 +0900
Message-ID: <874j5rgksw.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrew Morton <akpm@linux-foundation.org> writes:

> On Fri, 04 Oct 2024 15:20:34 +0900 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>
>> syzbot <syzbot+ef0d7bc412553291aa86@syzkaller.appspotmail.com> writes:
>> 
>> > git tree:       upstream
>> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=11b54ea9980000
>> > kernel config:  https://syzkaller.appspot.com/x/.config?x=92da5062b0d65389
>> > dashboard link: https://syzkaller.appspot.com/bug?extid=ef0d7bc412553291aa86
>> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b7ed07980000
>> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=101dfd9f980000

[...]

>> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> > Reported-by: syzbot+ef0d7bc412553291aa86@syzkaller.appspotmail.com
>> 
>> The patch fixes this bug. Please apply.
>> Thanks.
>> 
>> 
>> From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>> Subject: [PATCH] fat: Fix uninitialized variable
>> Date: Fri, 04 Oct 2024 15:03:49 +0900
>> 
>> Reported-by: syzbot+ef0d7bc412553291aa86@syzkaller.appspotmail.com
>> Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>
> Could we please have some description?  Seems that an IO error triggers this?

OK, I added the description guessed from syzbot log.

Thanks.


From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: [PATCH v2] fat: Fix uninitialized variable
Date: Fri, 04 Oct 2024 15:03:49 +0900

This produced by corrupted fs image of syzbot, in theory, however IO
error would trigger this too.

This affects just a error report, so should not be serious error.

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

