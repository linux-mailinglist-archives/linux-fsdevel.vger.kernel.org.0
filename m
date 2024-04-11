Return-Path: <linux-fsdevel+bounces-16672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE968A1447
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 14:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34A58B21861
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 12:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7861514BFA5;
	Thu, 11 Apr 2024 12:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="l40O6oGQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349991E895;
	Thu, 11 Apr 2024 12:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712837958; cv=none; b=rDaRcTYZTNv3Rbqy5AR13/LtsYXcJSTbRDqPWYNQrkVTenWjwDj+lxChenP4PM1WwcRfOe520Jodsrwfy1gQkTNdyoPgnzYBAO2DQNlTM4B2NGnIZP2D2KP68aiB3joIfH+GfzIMixZ3ef+g5L+JfjHCfEALkILbyAPCi7K/xxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712837958; c=relaxed/simple;
	bh=RT+xIqfnDDbgIj8uJAxoJ4nw3qi4SV6fgAP1DKs9/dc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=elVNCaa4+e62Tog+x85mVWadFHuZyXA34qP/iDX379wA3Aw3zu8UGop/ZwLXmkruN2YT+QJGrDdBmHKVlGKNAukIqBLrgfsCIstNUdgOxZo80JNUPqsN7DQauLhOqFC2Xav1kL2ZJadYV8E9hdLeTYyr0V+pl21Q0Qm/C9FLOYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=l40O6oGQ; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712837945; bh=tuHA1e8X3klZLTfe7IoJd81w8+BJeqW9FDqVUSy7N5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l40O6oGQj8+qU/cY/eOfzWo0valnvf/ojuIbetfL5r0nJUc3sCxtFdesVRo4I1tM3
	 UIZxGhXGVqHcb7rMUdCilTrvR8nrS6ENJZfEyxqUa1r4ohOX79dhuAEkMJ/2bYiu3G
	 PiYaWOOl31v/cgUZLW8s5P3fE/yzhU6fdsluZS+w=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszc19-0.qq.com (NewEsmtp) with SMTP
	id 15BBE4D3; Thu, 11 Apr 2024 20:05:27 +0800
X-QQ-mid: xmsmtpt1712837127th3fua2c4
Message-ID: <tencent_4AA6ED5ECD6879FE6FD02EFD6D109638E80A@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjI4P3w0jk/ucTXkXPH6oE2Y8+QRawsqZtKzMg9Settplp+91tJC
	 mwwQUC7HFmA5AvdnpBfoJf/mGj0IxYphBZbw0J1rfhCBY4tJ+RZcwUb1i6uUkR0LFaIwUxZgls9G
	 KLUHY7YEDSoxIlzQpUv1lp9TIYKevlcYwfv3/uglMg3PZn22pYD26YDc0fgllE3Y3/0GS4EQabWg
	 LURnCE3str0hVFa6boFUZDltVIAqHGZrkjl3xVF9Eonx1EnmlXuyYkFERvAxzJMimKe+ZIsihKWa
	 ZW8CSON7pUP2yQStVrqE3cWwj0YIQ4DhbYcQXPCPsCblwILMFe/SWhExLL9M3ul4SdzBH69gLVWh
	 1xr61RsRMWnOZfjfuND64kYirZaD5g99pTJinO8Tonk2+rwDvP7BdQ3Kq18osiju+M3QGFuIBseP
	 KEg3xygKnWgG2DQjEwVjVmz73KVcymsyWQmcv7BHeMmKK2kkfODLQIQjpFviA0trxt9GsqjyB6tG
	 kx0De1kGb141dPZ7Ns8dTxU/e6otA2FacCi2QIR+zcWsqOFPj39LvuUZlKZnEZcCDBMWXrKa359p
	 9vIm/WFae9t5uXL9iGVJFH3G5Cgh3E1YZyUHs7xHcS+6D+47rMEwkMOzCQ0FMguwpK6LWzTOu4so
	 BnB3/RpIIQjPinIGER7tOuolzN8m01TZ9zizWTVGKdJYdcEvmRNjSVttV9zC99ceqXNeboitrwcU
	 SwCtMus1xJW4SeRgN4Fr8Q37ig3S5UeFn4TjI8YsUnVrhu+R4uy8W2H9RSakzPBWtFG8oA8Le/zL
	 Dw3PlkKxPK9eMvNScBuSHSAPo+cmLkxe85ZI55jxqLQDAKiXrjYHhwxhQKQYckU6wugLwwdKXpUN
	 r6jsFuSpp6Vl2QDJXf6RYff+OsJFjAqdlj++eGFHTRM9O05iN97jqUqCq8ErjoESKouUVd7e8sVo
	 8xmAsQjhcgr5B5sFIoelvQjwIPgpnv
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: dave.kleikamp@oracle.com
Cc: eadavis@qq.com,
	jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+bba84aef3a26fb93deb9@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH V2] jfs: fix null ptr deref in dtInsertEntry
Date: Thu, 11 Apr 2024 20:05:28 +0800
X-OQ-MSGID: <20240411120527.1315528-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f4f7c644-b229-486b-973b-97c55dac334f@oracle.com>
References: <f4f7c644-b229-486b-973b-97c55dac334f@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[syzbot reported]
general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 PID: 5061 Comm: syz-executor404 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
RIP: 0010:dtInsertEntry+0xd0c/0x1780 fs/jfs/jfs_dtree.c:3713
...
[Analyze]
In dtInsertEntry(), when the pointer h has the same value as p, after writing
name in UniStrncpy_to_le(), p->header.flag will be cleared. This will cause the
previously true judgment "p->header.flag & BT-LEAF" to change to no after writing
the name operation, this leads to entering an incorrect branch and accessing the
uninitialized object ih when judging this condition for the second time.

[Fix]
After got the page, check freelist first, if freelist == 0 then exit dtInsert()
and return -EINVAL.

Reported-by: syzbot+bba84aef3a26fb93deb9@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/jfs/jfs_dtree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/jfs/jfs_dtree.c b/fs/jfs/jfs_dtree.c
index 031d8f570f58..5d3127ca68a4 100644
--- a/fs/jfs/jfs_dtree.c
+++ b/fs/jfs/jfs_dtree.c
@@ -834,6 +834,8 @@ int dtInsert(tid_t tid, struct inode *ip,
 	 * the full page.
 	 */
 	DT_GETSEARCH(ip, btstack->top, bn, mp, p, index);
+	if (p->header.freelist == 0)
+		return -EINVAL;
 
 	/*
 	 *	insert entry for new key
-- 
2.43.0


