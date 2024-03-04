Return-Path: <linux-fsdevel+bounces-13421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1BB86F91B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 04:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 377002815ED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 03:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639F453A6;
	Mon,  4 Mar 2024 03:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="inTuET2+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BF779C5;
	Mon,  4 Mar 2024 03:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709524433; cv=none; b=a8pfdDHNONRj4Dx47OEiFabhBbdTJ075V4rMZgST9NMnWRjlgrDAHVYi8WTNsL+zoaEEo+TmZYBvllBlBDzCZgCggeK6SRebe1echkyor6Cuuh3tv/ll3rZpMrqZWM4vZ8/aW83NTg6LmxaQDlBkDvEBHIv7uhiApo0srxFjHqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709524433; c=relaxed/simple;
	bh=QKe2AxQ/+t/EQnE1vD/TQouAhYU7yxxiqzEWgcoRQiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ALNOWgFrZqKzmUAz2P/FRi+Ver8/coU5St2w1HBbmX948G650Nl3aE/6UZd5C6sjQZf3onZmYltK4+AqIVk5Ajfnmcl9cnoq8GgyC0CSB1750AdknOGfS30q0nmM3SfjrZYMKIH45n3tT9SSqweGRzhK8K7a1KCegPR7ERg5XBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=inTuET2+; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709524427; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=tWOaTiza0KnzciAsTzWfF+Y4WXogwxZOxLtOTQabvJ4=;
	b=inTuET2+qMGADqrwQuYcNSAZJj382UhLKjb2IzT1WXiUZJlVKsUGSRKhLHsAud+5HnBO6UgXLn6sCXY85suDOMpfJ1id1EfvyMFFNrvNxTj1jRsv6+9IW13TFqLHf+guPWK3YKch/E6rsP8qDk8c7oTafzSv8FVUmfTOKqPFJ00=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W1iD3p9_1709524421;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W1iD3p9_1709524421)
          by smtp.aliyun-inc.com;
          Mon, 04 Mar 2024 11:53:47 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	syzkaller-bugs@googlegroups.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	syzbot+7bc44a489f0ef0670bd5@syzkaller.appspotmail.com
Subject: [PATCH] erofs: fix uninitialized page cache reported by KMSAN
Date: Mon,  4 Mar 2024 11:53:39 +0800
Message-Id: <20240304035339.425857-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <ab2a337d-c2dd-437d-9ab8-e3b837f1ff1a@I-love.SAKURA.ne.jp>
References: <ab2a337d-c2dd-437d-9ab8-e3b837f1ff1a@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reports a KMSAN reproducer [1] which generates a crafted
filesystem image and causes IMA to read uninitialized page cache.

Later, (rq->outputsize > rq->inputsize) will be formally supported
after either large uncompressed pclusters (> block size) or big
lclusters are landed.  However, currently there is no way to generate
such filesystems by using mkfs.erofs.

Thus, let's mark this condition as unsupported for now.

[1] https://lore.kernel.org/r/0000000000002be12a0611ca7ff8@google.com

Reported-by: syzbot+7bc44a489f0ef0670bd5@syzkaller.appspotmail.com
Fixes: 1ca01520148a ("erofs: refine z_erofs_transform_plain() for sub-page block support")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/decompressor.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index d4cee95af14c..2ec9b2bb628d 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -323,7 +323,8 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
 	unsigned int cur = 0, ni = 0, no, pi, po, insz, cnt;
 	u8 *kin;
 
-	DBG_BUGON(rq->outputsize > rq->inputsize);
+	if (rq->outputsize > rq->inputsize)
+		return -EOPNOTSUPP;
 	if (rq->alg == Z_EROFS_COMPRESSION_INTERLACED) {
 		cur = bs - (rq->pageofs_out & (bs - 1));
 		pi = (rq->pageofs_in + rq->inputsize - cur) & ~PAGE_MASK;
-- 
2.39.3


