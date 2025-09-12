Return-Path: <linux-fsdevel+bounces-61093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C18B5528C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 16:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2F45AA81EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 14:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610503115B8;
	Fri, 12 Sep 2025 14:59:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F81256C9B;
	Fri, 12 Sep 2025 14:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757689186; cv=none; b=g9SUpQji7bTdhL/amCClkxVl7tuBX6ZgXkUx+wCZzILvfUvs01fuLwDsOMk3qZNcEAHo2pGm4Btee3YROUCzx6/8XYaSyA6CVhFk5oeSa/C/qcDWdreOQPPI9tPyRgAVlS7VygDY/2JaD4mN1JHgOFbNRkVxDfmjn1JSaFtipMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757689186; c=relaxed/simple;
	bh=Bpn7eRgulG1Q6k/P9UITv3kB0rJqxawUPo3DndL4fio=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=NuWKm3VnOMjwOgWfuP3GdpdrtkmKK9XahlkM1jqOf8hj8AXYkskvxYUhxr+IlSjRr+aLy0JJ7UQ1U/Z13S1XleDrKFu1RW7qK4fBQ4UVslmLp1BR/R0xPNTUJtVlkzGVoSvelk4QxhFBEOrET5xADAcD/S2DRmS0zoarWQeTSos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 58CExRZV057679;
	Fri, 12 Sep 2025 23:59:27 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 58CExRc6057676
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 12 Sep 2025 23:59:27 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <56dd2ace-7e72-424d-a51a-67c48ae58686@I-love.SAKURA.ne.jp>
Date: Fri, 12 Sep 2025 23:59:27 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yangtao Li <frank.li@vivo.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH v5] hfs: update sanity check of the root record
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav305.rs.sakura.ne.jp
X-Virus-Status: clean

syzbot is reporting that BUG() in hfs_write_inode() fires upon unmount
operation when the inode number of the record retrieved as a result of
hfs_cat_find_brec(HFS_ROOT_CNID) is not HFS_ROOT_CNID, for
commit b905bafdea21 ("hfs: Sanity check the root record") checked
the record size and the record type but did not check the inode number.

Viacheslav Dubeyko considers that the fix should be in hfs_read_inode()
but Viacheslav has no time for proposing the fix [1]. Also, we can't
guarantee that the inode number of the record retrieved as a result of
hfs_cat_find_brec(HFS_ROOT_CNID) is HFS_ROOT_CNID if we validate only in
hfs_read_inode(). Therefore, while what Viacheslav would propose might
partially overwrap with my proposal, let's fix an 1000+ days old bug by
adding a sanity check in hfs_fill_super().

Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
Link: https://lkml.kernel.org/r/a3d1464ee40df7f072ea1c19e1ccf533e34554ca.camel@ibm.com [1]
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 fs/hfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 388a318297ec..ae6dbc4bb813 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -354,7 +354,7 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
 			goto bail_hfs_find;
 		}
 		hfs_bnode_read(fd.bnode, &rec, fd.entryoffset, fd.entrylength);
-		if (rec.type != HFS_CDR_DIR)
+		if (rec.type != HFS_CDR_DIR || rec.dir.DirID != cpu_to_be32(HFS_ROOT_CNID))
 			res = -EIO;
 	}
 	if (res)
-- 
2.51.0


