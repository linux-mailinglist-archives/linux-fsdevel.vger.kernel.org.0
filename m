Return-Path: <linux-fsdevel+bounces-74941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFM7KsVpcWmaGgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 01:05:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 524185FCAC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 01:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A0FA736409A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 00:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC06117A31E;
	Thu, 22 Jan 2026 00:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFv6mwxg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA5542AB7
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 00:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769040313; cv=none; b=HTh/GhxR9KrIwMCzQVh5pjnw+2M0moeqkA6dri8cSK+IMkMRwOk9E5VPUlNCCUXeJL4IhomnPaL+kUw3jCMJA60TSMgmOwr3vGFHBlrB3dTI2RzaQsXNZTTtYDyDy6+4HKLCUrow2UQPYDUy+2H2blKrSDQcKt5CMa0xXW9HLh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769040313; c=relaxed/simple;
	bh=q+AUUOOeMhKH4rbq5XzBfwcYUGNSAKYTTd5X5bgXNQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LEolEmmf+6SOLxyVw66/Zxn2WkbCcqzWusltDHJ2nHy+9WWjM1L8v7nfzEecDF4WwQymVmgaQyCVCm46YZiK4TEdvffM19Ype0L3KJNwg+626TSaGqaFP4TJRCd7k4WUzDj5lHtn3NbhCZ8k3nSEcyxNOMKzj3FdvHizyOJ27sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFv6mwxg; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8c531473fdcso47523585a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 16:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769040305; x=1769645105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PO1Jt5uhqRvDjhw/8xWJ8hHcQeGO0dm7l6ynZgVgbzM=;
        b=CFv6mwxgE+DU48BCauiF33LjMTbc3Vv05tXOOSvcKDqTqZs0BAIOjJleMo3WS6g67Y
         jT9aIzmRiuD6lgeDFW7untTRehJNhuXYQu2P53qyZJw56lgnY5HkApw+MQefzTIDBw0R
         mRmY3NQacbauWurnC7lPptSNBk0MCYt0XD2T3s/VUWHCFXuPUSRJgfGL5/Jr1ARHnQSu
         C2pqAlmb0obHoH+JpRl6eIz/ogjIkoXVuZq+APnqJXCjrUjLjSPmgL815b7JHiJcOUv8
         p1iCCz9zUjO+uYE3pvhEv8vT5aEgdxEc8+q97bOLLRWpKnVAAYQ+Sp6eltEF+G4aieS1
         T7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769040305; x=1769645105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PO1Jt5uhqRvDjhw/8xWJ8hHcQeGO0dm7l6ynZgVgbzM=;
        b=Mz+CFtkfP4XIpiiR1/lGWztNG3/lizD6DFcTB+pkV2GYC5l6q7iS5gbmv3mbFqkVL8
         b9w1iGvnIoW6noXeMPHiQn6LS8jSeZPp/LIGkn2BtPaFp1PQ2l6NnDxbcT65vjHhilsw
         ORftGl1W8o/xosPj2BAHWmAFoAYLSpyF2w6ktDJFB9uJ7A2tAvZ9YYl6ZkXpWd9krSur
         yeDaYUInbwBCCfuhZd2DhjNt2oMu6SR3GHBSPcfQFHh/aDBM/wi2ruboVR4tLZIOOgEz
         DBCRhSTs47TDqckzw4+Cct5YzFt/faiD2Yu53srWJTBMA11CLnmX9bjpZhi/GF+WgL/h
         cK8A==
X-Forwarded-Encrypted: i=1; AJvYcCUJu6rcV9U4ZiCUB18U63kGXPmrLvZAWZgYVdTyZsi+G1QMG15WVUtkpqtRNiZyl8ZTixfKyTsw5n6uISo5@vger.kernel.org
X-Gm-Message-State: AOJu0YwSRrsAowFOl87FVyjLglu5udhEE2i9FiKnYT9L/bBRsZrh8zYn
	2cEd9xq9hqa6jqzL0GJp/q10Lw57kX5i0VWnx+dxoIcWTTNBMkoY670F
X-Gm-Gg: AZuq6aKVoK33aiSfHIUdEBSKL8kkLVblJ6tZOHSN3CU55DtSr62IAbZvanpo8dHr/RA
	HZ+je7bikTacs7ocpyK62EDqJxjeL+PrsByUxN7M9rkbaGTbNN6zqWwbRRGXxfkLFLaKsFeZK/T
	9srfZEH/0+QsuUSAE2ohXV/uqDUZXsoO6qXNK31O4Oy7wn9MFC8WiGSZ+/s2A0bykxD6pQNgZ1p
	JnFvLuNrFjlCqRkCQ3MCRcsZwP7zXVKbWrA48AtCio8OnqhshQHUj2hHNniXLYMfek9sVcSpJVN
	CaclMl3V6prNhBcl0alMWxWi4jksTlnmqepAqQwFNitUVf7fXZYwr50u/zl/iCwLu5+OaEvEANL
	T7jj1gZK2QLTrzFbVAEYlNb5r1E1QRHj+Iu6W+e+FV7ULTtCgpIaPseJQPNk5hNH7NxVrif+Ict
	chabMlRgME31EfqrhJNLjKOA==
X-Received: by 2002:a05:620a:4586:b0:8a3:87ef:9245 with SMTP id af79cd13be357-8c6a6979ebbmr2872525685a.85.1769040305419;
        Wed, 21 Jan 2026 16:05:05 -0800 (PST)
Received: from localhost ([198.1.209.214])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71ad7a2sm1419883385a.3.2026.01.21.16.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 16:05:03 -0800 (PST)
From: William Hansen-Baird <william.hansen.baird@gmail.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com
Cc: yuezhang.mo@sony.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	William Hansen-Baird <william.hansen.baird@gmail.com>
Subject: [PATCH 1/2] exfat: remove unnecessary else after return statement
Date: Wed, 21 Jan 2026 19:04:33 -0500
Message-ID: <20260122000451.160907-1-william.hansen.baird@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74941-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[sony.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[williamhansenbaird@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 524185FCAC
X-Rspamd-Action: no action

Else-branch is unnecessary after return statement in if-branch.
Remove to enhance readability and reduce indentation.

Signed-off-by: William Hansen-Baird <william.hansen.baird@gmail.com>
---
 fs/exfat/inode.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index f9501c3a3666..234a9f41e083 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -511,8 +511,9 @@ static ssize_t exfat_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 			exfat_write_failed(mapping, size);
 
 		return ret;
-	} else
-		size = pos + ret;
+	}
+
+	size = pos + ret;
 
 	if (rw == WRITE) {
 		/*
-- 
2.52.0


