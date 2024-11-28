Return-Path: <linux-fsdevel+bounces-36085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD709DB7B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 13:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1928BB22568
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 12:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EFB19DF5F;
	Thu, 28 Nov 2024 12:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="WFgc/Y2l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA1A19C54C;
	Thu, 28 Nov 2024 12:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732797154; cv=none; b=pJkjgqjtgx2jaA86y4dc+T5LGPAvu3as2dXLvDxzUa6j/vC3kVp847vOexGCs/NqNzv6UWTrC3/IWgdCgXt3A90A0DDm1/KR4QIIjQSIe06lVS7tDZkfuHG9IUsmsJyAG1ik33vLgO3EJFSlB7JOECUKpc0taYlxJD85OGUwDqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732797154; c=relaxed/simple;
	bh=AxALqGtWLut1/ZUqWtQavC+9LrGZSfY2sMtxcXzsONA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=nCVkK4z2cemmaJjTz6J3DNCZGx8DylteGOE6Ou7u/BjPEp8uk1iz+i4c+MrDgpAErJNRYcLFEhWSGJsllbeL9PF2v7hAzE2WNpgj8PHxRPG0EgAVLqD4BNi1hHE9gZ/r0fE92LDDgsytLY9BZjJ73qzZMFNZ54Kw+GkFBvG2qfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=WFgc/Y2l; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1732797144; bh=SAfbWZBE+VYIVKerAsNYSDaPnXIeLQyt5hb1HSzhrgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WFgc/Y2ln1P5nx/s2Gw4rY8DLNZkhssrCnubzvhRi69y/qp5t4YZF5llTUi5q2Oqf
	 SxtNKQsOjZxRlTb6WreCePs0mlKqC+YZB08QwzE5R7Uq1HRbzGLzlRt7bOF7oCziqb
	 6w+vZT9IQJv4sExLVVn529EV8nd5ASwTwklUcsGA=
Received: from pek-lxu-l1.wrs.com ([114.244.57.34])
	by newxmesmtplogicsvrszc25-0.qq.com (NewEsmtp) with SMTP
	id 7C9826BD; Thu, 28 Nov 2024 20:31:09 +0800
X-QQ-mid: xmsmtpt1732797069tyyxpnakb
Message-ID: <tencent_398177A566523D6B372E972A36064B5C7409@qq.com>
X-QQ-XMAILINFO: NlxVGCthfHmZO4HE3bMhIlVW1xA1nxkRDJI6yS9oorMRK4o67ZPkr+IEVLqpMW
	 g1mPmJOheSOtHIoyLyHvSWhxXnb6Zojv6GUQJHk2aoMc3R0Gn7NCGbG8zV1D7IG9K+BRfXzTjATA
	 LO1oDDuLBTgdHbRLUIQaX9zlUnhH1QCZoaBSBxqlTD93vFMd6op0WcJk/dQIuZM56HY3alnfq4vt
	 kkEY/GBkPgT+Lrq8eW/5Zt+VG4NRVOwF1N12ZBfIKvtbgwRHWPim7p4q6IkgmJpZtlLGgQc01mQB
	 NP/7cdKnuQ4Ujgbf60iOg94AdamYNv+t884/enewM49RKaHkfpT1f3Xdgpsw7z+1xQJqTAHzpZje
	 gHVbCjhLYBLGIsP78sEsEY11Vx2oloNrKOirmAPeLvf//Y/OgEbnmWOg8kIp0xerkMF/KRw9BDoA
	 KPTNpwt/m26A4MuqNtPwTrp+HN0xwf2bRBeaCI6nLQWEbsB/5zw5r6eZSqrJ/S88Te5sN/rWlxKI
	 Bwu1dEQDCx991K6sptbjM08AGJ/g+3881VV4AUM1mDWSY+5FDeJ03cNcmfXsoQzjS/L4Q0Hexuvv
	 abrco2CimKMeF1HfKKRkdO0MOIwZ3VZRXR0fNKg7Nq0CyYYsZNn050FwydqHdipuKF1eiWWCMvKA
	 94Rn8jp7yMfflY7aZyZCMDCZatuAftZlT27gUO0EazT1a1T6KhTHH32fPqR3qD5pKeYEn0pNmBG1
	 dq59zUhbPCVY+wAxiy3wh4+zSS7WvexgEu+lyo2aTdqQDcY4FM8oV71FvL3nAwul9VboNxNq9doH
	 3CKC9HlNSrrgTEzYU9JtDYfWzKYTszeCvnmSMcMVyYSrJj3tfbN+6XJF3k5ALf71Ldrqj0al5l9F
	 0895WjgVkNb2NB5vdG3UlxGesKV+5UbA==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+c6811fc2262cec1e6266@syzkaller.appspotmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] hfs: check key length before reading
Date: Thu, 28 Nov 2024 20:31:10 +0800
X-OQ-MSGID: <20241128123109.1421815-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <6746eaef.050a0220.21d33d.0020.GAE@google.com>
References: <6746eaef.050a0220.21d33d.0020.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The length of the key maybe too large. Add a key length check before reading
the key.

Reported-and-tested-by: syzbot+c6811fc2262cec1e6266@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c6811fc2262cec1e6266
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/hfs/bnode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index 6add6ebfef89..6e38d61da36f 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -67,6 +67,9 @@ void hfs_bnode_read_key(struct hfs_bnode *node, void *key, int off)
 	else
 		key_len = tree->max_key_len + 1;
 
+	if (key_len > tree->max_key_len + 1)
+		return;
+
 	hfs_bnode_read(node, key, off, key_len);
 }
 
-- 
2.47.0


