Return-Path: <linux-fsdevel+bounces-37912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F23789F8B11
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 05:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2617C164A5F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 04:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8DA78F4B;
	Fri, 20 Dec 2024 04:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bHJ6uu/Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EBB23741;
	Fri, 20 Dec 2024 04:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734668200; cv=none; b=N3xNHwMXL5t/01h1j7CZRNglnw8dBhoQAKDvD5B/9ue607C1mCyWF8/gR7bvUvu7BN4Nmq7y63Jc4bwiqal37MX6oBh07juuX3gd6USaET/mO9wmO9J0yBhIw9yYfUqgSnxAOZTxHP1hIrRAopoYExgSvr/+60q7o0faAyW7MP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734668200; c=relaxed/simple;
	bh=BXZgD/OmaNvl8quB+anTeQboS2cGwq+CPw+Cpci/LtI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d64Cd0jQkvrYfyjv05DiCbjYym28rwGnIxrXvf7b1gK6IPx3ClNYBZ3eO8YzwoRggBENQBEKulJwmXkuay0YSC2qBJu+fAhf8V1AzSzajeutX8A0a0e/LVqUSA4iqJ7L+qD259vqPx4kCagvGnhKX0nU7WDqKdwsNo3B0C/fK3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bHJ6uu/Z; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=LbSfG
	6Ybj+QumLD/3JUMP2n9jXx3OEd/cTnbZimSajQ=; b=bHJ6uu/ZxEqbrM8mZh4e2
	i59niZ56Uex3p6MxyTenzgAcDuI8Q3QU49s3Lnl+C5cLpAxBDv/HUAv2XpO9dn1v
	B7mr+9ieTSZSfrXSsutCjAM0rSTa2r6edgeqf70u/3KBVVqTVD+MfwkSu+LAXfnK
	UbVfS6Ws9KhWJYYgmtm7YU=
Received: from localhost.localdomain (unknown [111.35.188.140])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgBHJmWH72RnHqbbDA--.20966S4;
	Fri, 20 Dec 2024 12:16:23 +0800 (CST)
From: David Wang <00107082@163.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	surenb@google.com,
	David Wang <00107082@163.com>
Subject: [PATCH] seq_file: copy as much as possible to user buffer in seq_read()
Date: Fri, 20 Dec 2024 12:16:05 +0800
Message-Id: <20241220041605.6050-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgBHJmWH72RnHqbbDA--.20966S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww47Kw18tr1rAFyDJw4Utwb_yoW8Aw4fpF
	1aga9a9F4kXrZ8Zrn3ZFn8Was5X3W8JayYqay5Xayftw18twn8ZF1xKFy0qw4Ygr1Fk3yj
	vr1F9340y3s8J3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pE1vVZUUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbB0gO7qmdk55XYAAAAsp

seq_read() yields only seq_file->size bytes to userspace, even when user
buffer is prepare to hold more data. This causes lots of extra *read*
syscalls to fetch data from /proc/*.
For example, on an 8-core system, cat /proc/interrupts needs three
*read*:
	$ strace -T -e read cat /proc/interrupts  > /dev/null
	...
	 43 read(3, "            CPU0       CPU1     "..., 131072) = 4082 <0.000068>
	 44 read(3, "  75:   13490876          0     "..., 131072) = 2936 <0.000148>
	 45 read(3, "", 131072)                     = 0 <0.000010>
On a system with hundreds of cpus, it would need tens of more read call.
A more convincing example is /proc/allocinfo, which is available when
CONFIG_MEM_ALLOC_PROFILING=y. When cat /proc/allocinfo, 4k+ lines need ~100
read calls.

This patch try to fill up user buffer as much as possible, extra read
calls can be avoided, and 2%~10% performance improvement would be
observed:
	$ strace -T -e read cat /proc/interrupts  > /dev/null
	...
	 56 read(3, "            CPU0       CPU1     "..., 131072) = 7018 <0.000208>
	 57 read(3, "", 131072)                     = 0 <0.000010>

Signed-off-by: David Wang <00107082@163.com>
---
 fs/seq_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 8bbb1ad46335..2cda43aec4a2 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -220,6 +220,7 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 		if (m->count)	// hadn't managed to copy everything
 			goto Done;
 	}
+Restart:
 	// get a non-empty record in the buffer
 	m->from = 0;
 	p = m->op->start(m, &m->index);
@@ -282,6 +283,11 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	copied += n;
 	m->count -= n;
 	m->from = n;
+	/*
+	 * Keep reading in case more data could be copied into user buffer.
+	 */
+	if (m->count == 0)
+		goto Restart;
 Done:
 	if (unlikely(!copied)) {
 		copied = m->count ? -EFAULT : err;
-- 
2.39.2


