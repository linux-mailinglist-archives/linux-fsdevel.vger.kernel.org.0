Return-Path: <linux-fsdevel+bounces-79686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEG5GIXpq2m7hwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 10:01:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F0B22AC93
	for <lists+linux-fsdevel@lfdr.de>; Sat, 07 Mar 2026 10:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82EC8303A867
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2026 09:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09BE387590;
	Sat,  7 Mar 2026 09:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYsFKhpY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F155B2D7DDB
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Mar 2026 09:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772874052; cv=none; b=YhVJ0m57kkLFW9t2wlX/fTg/qdz4APMAbRNHrrTdhOPcdJmKa449ae7P+UjKny94xwa9DPqDNBwSZPWtWnmMbElIawbbf+Bg36qoS5wJSd6FFxhmU4jB6kaQisp66lUgPPh/vdtBbqLsO5Gtlmz8k9CvtWs41sdR0o58anTTxY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772874052; c=relaxed/simple;
	bh=DpJ0U0ChB40a5/VIDnN1Pt8w6d+RWSvZEqctD6dXl5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kFMmYX72s+8LEEhEP/j7wtPA1gXZAaLP/esFPcjaO6FNK/a2TY7uORt6EDXfduaIkMcS90RitxCZq3oXI/qzygutqEB8laqFEQKHj8xHITXfrzq/v2iX/HDMjEq4FOxPyP6+Vx53js6WwD1lncvOMIwSSKktmtmGlOJ9MnQLX3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYsFKhpY; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-359866a1d02so5804753a91.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Mar 2026 01:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772874050; x=1773478850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n1qIWIJPlYMXQTKQnekP1rjhdJ7z4pMn0jMtkRlfuMk=;
        b=ZYsFKhpY9n+w9hAHDxGJPCNpN5+ZrUrD28Ad/tNMmxTdAlW0cgMdfyqKiG51zZMVNL
         9njdlkpleRMuItYoHePtJKVkZCnDIjADmJWrWfwmCPLzZOG3rZB3rWUCQGDuVHAxtwfE
         Vuex+CiRv/2yGByo3WNVQxe+Wah4aJsXJUbF0BrupTq1d51sK1MvgCKBrsul29oU0OPo
         if6TH56ToBFxwYgpbFDKAwQ4ChGGW39Jndnso/TPfEFaSj+z41qDdrjVJbQKGvYBIUT+
         pKXpVHmAznYh17B3ED7wbW9eRnKBnACCfKsOk3KCGsFUMSIgMbIW8Bb4WPEZtDiOVMBN
         pKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772874050; x=1773478850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1qIWIJPlYMXQTKQnekP1rjhdJ7z4pMn0jMtkRlfuMk=;
        b=laW/YVZJVJVrKYMhWOksCU+8RhuU1uhLpIz/EMcss56AfU8UhpZVlCvvrTLDOs4CVy
         HGPzsxvpPK0gyrVp8movFpYMidd9Tyl5cvZmcTdvjpSabNERST3Aruun5QteW+f8vD0E
         jL9UN/yMgzFvZpmQa46+frnKoIjc7Ez51e/TZET9x3TcTIrPGApNTJgk46DB6/wXVDpn
         TJI/qCjOkNyBfb+Zsq5QKD9r5Bwbw8s8EteCcNF+Lrgm5BGERflXQpSUoqZaKmGz3+25
         vtfKo5a1JyJa1HnMlRCrOeedcboOGwU4wt3dUzEpAkw/gOgwQFRBdA/InoWSY0TY5T+1
         UPzA==
X-Forwarded-Encrypted: i=1; AJvYcCWjWXv8Jk+Z0QL/dM6vCfX61zQ4zDdnIW7fAWYgo5sS0kJALEKeOkeNJedPrQ9aULoJydUUdRrmiZQSXH0E@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd1YvWTtBK6/yqfVedMYvbB5kXO3BdXF6iPePKQADEePUKwEzF
	sftHxmE0GEvszVMc5GNybHTnoMDVaOPXIZYV/pfZMeTva0dEvPu9m6R2
X-Gm-Gg: ATEYQzzl0099iFKPflnqCLwIuXlhnYJOtGNgt4DaZ+Rx9V9YVcFJce9DRRWOMIcecRO
	JtYq+cc9cGti/+5/on1FD4vzwTpxfV+LV0yue/cMravHaQLCBP1f8HPSr8n0TOv5QnhM7VHYbRw
	U4fgdS86KoWfdcn26KUyAKak5sSAe2pJFc+AQzsG5/qBfaU9GNEgOilJqeYyS5qlMBFM922cWdD
	ckr3zoq/cbNkyHFdOmCjgJ/jRllFjo/kBdygYk1dDW8B+GYniS6LD508yg2/U0r8c17AQepnbQQ
	+JGbTajJFg4debg5ncqLpzw8qJoGR+s9TlkotpuVngSZRiGYbXn6GtUtMZ/imHmZExNGeGhrPnv
	hMunPqA6qRbaYqont3WthtV0+lbcb/eWvlvQPGXcx90xBEUVMA+pTSG3AbDPoIq9/3FZUXbcVBW
	vBVEEWpR23NMBvNQWPO9lS4aZaBPRETUzdsLqcHE/H0WaZhMzcmROOYItzsYcGzfbuyX57lHfh/
	E1ZbHvvRScHj6JQ6w==
X-Received: by 2002:a17:90b:5587:b0:354:a546:5edd with SMTP id 98e67ed59e1d1-359be24b125mr4977305a91.11.1772874050220;
        Sat, 07 Mar 2026 01:00:50 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:899a:49a8:c3d1:e400])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359c0179a67sm4263149a91.13.2026.03.07.01.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 01:00:49 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: dhowells@redhat.com,
	pc@manguebit.org
Cc: jlayton@kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+9c058f0d63475adc97fd@syzkaller.appspotmail.com,
	Deepanshu Kartikey <Kartikey406@gmail.com>
Subject: [PATCH] netfs: Fix kernel BUG in netfs_limit_iter() for ITER_KVEC iterators
Date: Sat,  7 Mar 2026 14:30:41 +0530
Message-ID: <20260307090041.359870-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B8F0B22AC93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux.dev,vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79686-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,9c058f0d63475adc97fd];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,syzkaller.appspot.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

When a process crashes and the kernel writes a core dump to a 9P
filesystem, __kernel_write() creates an ITER_KVEC iterator. This
iterator reaches netfs_limit_iter() via netfs_unbuffered_write(), which
only handles ITER_FOLIOQ, ITER_BVEC and ITER_XARRAY iterator types,
hitting the BUG() for any other type.

Fix this by adding netfs_limit_kvec() following the same pattern as
netfs_limit_bvec(), since both kvec and bvec are simple segment arrays
with pointer and length fields. Dispatch it from netfs_limit_iter() when
the iterator type is ITER_KVEC.

Fixes: cae932d3aee5 ("netfs: Add func to calculate pagecount/size-limited span of an iterator")
Reported-by: syzbot+9c058f0d63475adc97fd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9c058f0d63475adc97fd
Tested-by: syzbot+9c058f0d63475adc97fd@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
---
 fs/netfs/iterator.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/fs/netfs/iterator.c b/fs/netfs/iterator.c
index 72a435e5fc6d..154a14bb2d7f 100644
--- a/fs/netfs/iterator.c
+++ b/fs/netfs/iterator.c
@@ -142,6 +142,47 @@ static size_t netfs_limit_bvec(const struct iov_iter *iter, size_t start_offset,
 	return min(span, max_size);
 }
 
+/*
+ * Select the span of a kvec iterator we're going to use.  Limit it by both
+ * maximum size and maximum number of segments.  Returns the size of the span
+ * in bytes.
+ */
+static size_t netfs_limit_kvec(const struct iov_iter *iter, size_t start_offset,
+			       size_t max_size, size_t max_segs)
+{
+	const struct kvec *kvecs = iter->kvec;
+	unsigned int nkv = iter->nr_segs, ix = 0, nsegs = 0;
+	size_t len, span = 0, n = iter->count;
+	size_t skip = iter->iov_offset + start_offset;
+
+	if (WARN_ON(!iov_iter_is_kvec(iter)) ||
+	    WARN_ON(start_offset > n) ||
+	    n == 0)
+		return 0;
+
+	while (n && ix < nkv && skip) {
+		len = kvecs[ix].iov_len;
+		if (skip < len)
+			break;
+		skip -= len;
+		n -= len;
+		ix++;
+	}
+
+	while (n && ix < nkv) {
+		len = min3(n, kvecs[ix].iov_len - skip, max_size);
+		span += len;
+		nsegs++;
+		ix++;
+		if (span >= max_size || nsegs >= max_segs)
+			break;
+		skip = 0;
+		n -= len;
+	}
+
+	return min(span, max_size);
+}
+
 /*
  * Select the span of an xarray iterator we're going to use.  Limit it by both
  * maximum size and maximum number of segments.  It is assumed that segments
@@ -245,6 +286,8 @@ size_t netfs_limit_iter(const struct iov_iter *iter, size_t start_offset,
 		return netfs_limit_bvec(iter, start_offset, max_size, max_segs);
 	if (iov_iter_is_xarray(iter))
 		return netfs_limit_xarray(iter, start_offset, max_size, max_segs);
+	if (iov_iter_is_kvec(iter))
+		return netfs_limit_kvec(iter, start_offset, max_size, max_segs);
 	BUG();
 }
 EXPORT_SYMBOL(netfs_limit_iter);
-- 
2.43.0


