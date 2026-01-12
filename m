Return-Path: <linux-fsdevel+bounces-73200-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E173ED1189E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 10:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17025303ADFB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 09:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FC9348477;
	Mon, 12 Jan 2026 09:40:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CCE33987E;
	Mon, 12 Jan 2026 09:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768210820; cv=none; b=CyHBSW/ii+/yo2b9jOZTbnT2TGfhblpuL5Ngla+8vJ06p71TqaZuU/r6NS4eQIXR5n7R179hv4nSMGw4u2Zn+toeLGEMrw0grBavhX18EwC1MVsC87fzYMwz2UfMrGwHPOYdqq26OfF5y2hc+9VLNkQOAuboa0gUFSu790Ywads=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768210820; c=relaxed/simple;
	bh=11M4KxP/TYyUAeLBTvFNK5Mx0+y6Yf/MyOxeIchSz+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I1J/aqaTQWVlLsqryLNE24H2iKOeo+JunEuiVy3xxqKSB8tqN+e6T51eak8AIEHDDIZ+PqmZ+bFSyZb2bYX63kt8DeyhoDt7DbYJ0JfXeLrAOX+Dxet8/OHuclV5lLoXGBP1AyjrTB2FrbwHsxvV/obf1pi7EhYcEo3lsqK1Cm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 60C9dMoq007287;
	Mon, 12 Jan 2026 18:39:22 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 60C9dMAx007284
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 12 Jan 2026 18:39:22 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <da5dde25-e54e-42a4-8ce6-fa74973895c5@I-love.SAKURA.ne.jp>
Date: Mon, 12 Jan 2026 18:39:23 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3] hfsplus: pretend special inodes as regular files
To: Christian Brauner <brauner@kernel.org>,
        syzbot <syzbot+f98189ed18c1f5f32e00@syzkaller.appspotmail.com>,
        Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>
References: <6964b615.050a0220.eaf7.0093.GAE@google.com>
 <20260112-apokalypse-sachte-846a6175c176@brauner>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260112-apokalypse-sachte-846a6175c176@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav203.rs.sakura.ne.jp
X-Virus-Status: clean

Since commit af153bb63a33 ("vfs: catch invalid modes in may_open()")
requires any inode be one of S_IFDIR/S_IFLNK/S_IFREG/S_IFCHR/S_IFBLK/
S_IFIFO/S_IFSOCK type, use S_IFREG for special inodes.

Reported-by: syzbot <syzbot+f98189ed18c1f5f32e00@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=f98189ed18c1f5f32e00
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
https://lkml.kernel.org/r/d0a07b1b-8b73-4002-8e29-e2bd56871262@I-love.SAKURA.ne.jp was
a bit too late to append to previous bug report. ;-)

 fs/hfsplus/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index aaffa9e060a0..7f327b777ece 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -53,6 +53,12 @@ static int hfsplus_system_read_inode(struct inode *inode)
 		return -EIO;
 	}
 
+	/*
+	 * Assign a dummy file type, for may_open() requires that
+	 * an inode has a valid file type.
+	 */
+	inode->i_mode = S_IFREG;
+
 	return 0;
 }
 
-- 
2.47.3


