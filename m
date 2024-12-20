Return-Path: <linux-fsdevel+bounces-37932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 584BA9F9401
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 15:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08C41887849
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 14:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E619215F61;
	Fri, 20 Dec 2024 14:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TXo35mCp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F291A83FD;
	Fri, 20 Dec 2024 14:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734703848; cv=none; b=Jf6ws5zgm7BBpAvm+mKq8ns25fkZenGm/Ufvd1LxS8XJn/PsEeBEuS0NNFtiXX9AbbUQaEbJkbNr8Bk/lzYA2Q0FSaDa/cPs3LQ6oOGAT+PrzM0i5gUz/crylNaYze639f1h+IsYjtB50kK8GHDdM4egBTN5wdZtqM7mupMhklo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734703848; c=relaxed/simple;
	bh=GPfnfTn1KX5prNTjXajuoOVanwHklmw90l5iVHHXn7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dJepIsw6/zpP/BFWKnY6vo1UdnfUYu7DfG8NNIoR4TMvB+cpXPzy5KqYDDoJmUg1THcIx3x5ILJS7QsqaCLKzRSzj9wk/caMtKy0k9pnIn5OntoAR88qj8CxvfY2GZa4HL22WZAZhCRIcZyvxdFeKBBkLJagljNOKHeOQ4H6RKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TXo35mCp; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=zgO81
	Y7kgOfMSKitLumdQG8YoricRky6BUgrR7UwCag=; b=TXo35mCp3bpX/kC0nnJZ1
	pXVY8XAC9MkpUUirUmcqFbMDAhwELG4m8hVtulczzjbJJvxmTrw0DUjHq7xrXcp2
	CyVaPn9qv5FkLz6Mrz0q+7HoJhO8VNM3Fsaqh/XzdE+3GkAaA9S7K3VYEWdS8S53
	9FrF/m+hc2XMJXN2bsnaMY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDnN1tVemVnRQn7AQ--.56170S4;
	Fri, 20 Dec 2024 22:08:34 +0800 (CST)
From: David Wang <00107082@163.com>
To: brauner@kernel.org,
	viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	surenb@google.com,
	Markus.Elfring@web.de,
	David Wang <00107082@163.com>
Subject: [PATCH v2] seq_file: copy as much as possible to user buffer in seq_read()
Date: Fri, 20 Dec 2024 22:08:19 +0800
Message-Id: <20241220140819.9887-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241220041605.6050-1-00107082@163.com>
References: <20241220041605.6050-1-00107082@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnN1tVemVnRQn7AQ--.56170S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF1UXr4rXw4Utw1xCw1DAwb_yoW8CryUpF
	1aga9I9F4kJrs8Zrn3AFn8Was5X3W8JayYgayrX3yftw18twn8ZF1xtFy0qw4jqr1rC3yj
	vr1F9340y3s8J3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p__-BDUUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiMwq7qmdleYceRwAAsN

seq_read() yields at most seq_file->size bytes to userspace, even when
user buffer is prepared to hold more data. This causes lots of extra
*read* syscalls to fetch data from /proc/*.
For example, on an 8-core system, cat /proc/interrupts needs three
*read*:
	$ strace -T -e read cat /proc/interrupts  > /dev/null
	...
	 43 read(3, "            CPU0       CPU1     "..., 131072) = 4082 <0.000068>
	 44 read(3, "  75:   13490876          0     "..., 131072) = 2936 <0.000148>
	 45 read(3, "", 131072)                     = 0 <0.000010>
On a system with hundreds of cpus, it would need tens of more read calls.
A more convincing example is /proc/allocinfo, which is available when
CONFIG_MEM_ALLOC_PROFILING=y. When cat /proc/allocinfo, 4k+ lines need ~100
read calls.

Fill up user buffer as much as possible in seq_read(), extra read
calls can be avoided with a larger user buffer, and 2%~10% performance
improvement would be observed:
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


