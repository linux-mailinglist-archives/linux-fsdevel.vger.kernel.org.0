Return-Path: <linux-fsdevel+bounces-72467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9E8CF7908
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 10:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 167CE303D934
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 09:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DE6320A06;
	Tue,  6 Jan 2026 09:39:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66B131DDBF
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 09:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767692397; cv=none; b=bJf21bWSBdUHQz4D2ljs24bL3LAIQp1IHLJk8AhGlKI+5Y6LQ+xAla9C7R0v5I7He4qh56GyVqTkC7fmRQ03EwjhlK55xb3uQBaa8UdOfQ6Xl/p8ui/kNHrei9m0AdEWEWsN/cxPFwdYuvztNnwDJT4xT0BAf3SNpDYyjwwTC/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767692397; c=relaxed/simple;
	bh=T+InTxJI9aYV1U0u5GaIf8qPMBQvNq0oo4qLHSrXh4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J9IygEgHkfJlqMHWCh1yqtUks6X9JFAroZ/Ee0jKS7P4pmaiqLz0FDysxCMqUzjMfu6xY3mEeTqywHima+2aREMPawarB1GVsG+W44GpCvuTHZq1t1mLXU1rDsbLkgW4O0ncF5pBmEmMTVTsmUzDN+vYDI6Ee7TPZgElZbXeP1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 6069dWJC043555;
	Tue, 6 Jan 2026 18:39:32 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 6069dWYK043551
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 6 Jan 2026 18:39:32 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <d0a07b1b-8b73-4002-8e29-e2bd56871262@I-love.SAKURA.ne.jp>
Date: Tue, 6 Jan 2026 18:39:33 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3] hfsplus: pretend special inodes as regular files
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
        "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <8ce587c5-bc3e-4fc9-b00d-0af3589e2b5a@I-love.SAKURA.ne.jp>
 <86ac2d5c35aa2dc44e16d8d41cf09cebbcae250a.camel@ibm.com>
 <bfa47de0-e55e-419c-9572-2d8a7b3b99f8@I-love.SAKURA.ne.jp>
 <5369106f-97ab-49e6-bc99-517d642b02b8@I-love.SAKURA.ne.jp>
 <443c081b0d0d116827adfc3eed5bc5cba4cf7f30.camel@ibm.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <443c081b0d0d116827adfc3eed5bc5cba4cf7f30.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav204.rs.sakura.ne.jp

Since commit af153bb63a33 ("vfs: catch invalid modes in may_open()")
requires any inode be one of S_IFDIR/S_IFLNK/S_IFREG/S_IFCHR/S_IFBLK/
S_IFIFO/S_IFSOCK type, use S_IFREG for special inodes.

Reported-by: syzbot <syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=895c23f6917da440ed0d
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
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



