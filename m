Return-Path: <linux-fsdevel+bounces-72318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9121FCEE260
	for <lists+linux-fsdevel@lfdr.de>; Fri, 02 Jan 2026 11:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3111A300795E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jan 2026 10:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF39A2D94AC;
	Fri,  2 Jan 2026 10:17:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC9D2C21D0
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jan 2026 10:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767349041; cv=none; b=AajF5U4UrR1g7IR/LTO8wH9QBass221s2ZvUqngxYqOxFTkpjiKpDNGVjujef4lh3ke+BobTZJTDrabY/kAp0AIWdNMcYXvsZJST5YuE4faQYJHeFGvrS2NS5QfUFAqBhUO9bXkfYopHWzSY+LoidYeYd6JyWoySJpUd7ZrzCB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767349041; c=relaxed/simple;
	bh=5UdPDSs0mu0oHeCUtuV1uV7OYyJuse6iTFIwhYvjubY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=t91yGCIs16tvKpQnHGA8Gyo58fI3WbN4E4iRbzrRzrUdjXwwPQg1wXchOeK059JT0f/5Gz5FlWTXxU5EQSQSZxW4pr9yI8v5snfA8qSBjIAf98FyjL7xoHcYotNghxnEvunu7m6ZYdXYMRLMBAAPHVKQU8/EPEHXfx7JKiXgFew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 602AH5nX047668;
	Fri, 2 Jan 2026 19:17:05 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 602AH5HB047664
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 2 Jan 2026 19:17:05 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <5369106f-97ab-49e6-bc99-517d642b02b8@I-love.SAKURA.ne.jp>
Date: Fri, 2 Jan 2026 19:17:05 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] hfsplus: pretend special inodes as regular files
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <8ce587c5-bc3e-4fc9-b00d-0af3589e2b5a@I-love.SAKURA.ne.jp>
 <86ac2d5c35aa2dc44e16d8d41cf09cebbcae250a.camel@ibm.com>
 <bfa47de0-e55e-419c-9572-2d8a7b3b99f8@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <bfa47de0-e55e-419c-9572-2d8a7b3b99f8@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav105.rs.sakura.ne.jp

Since commit af153bb63a33 ("vfs: catch invalid modes in may_open()")
requires any inode be one of S_IFDIR/S_IFLNK/S_IFREG/S_IFCHR/S_IFBLK/
S_IFIFO/S_IFSOCK type, use S_IFREG for special inodes.

Reported-by: syzbot <syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=895c23f6917da440ed0d
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 fs/hfsplus/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index aaffa9e060a0..82e0bf066e3b 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -52,6 +52,7 @@ static int hfsplus_system_read_inode(struct inode *inode)
 	default:
 		return -EIO;
 	}
+	inode->i_mode = S_IFREG;
 
 	return 0;
 }
-- 
2.47.3


