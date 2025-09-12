Return-Path: <linux-fsdevel+bounces-61090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEE1B5519C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 16:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A65F5C104A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 14:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C1631353E;
	Fri, 12 Sep 2025 14:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b="msHjmnNN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365EB31353D
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757687214; cv=none; b=VPoOMqMJ5Pn0klpLtpkJrm7XJMOrn5RFmbUUVQwrAYJh08PN4naDHcXY6af3qT+HYmWSXOapIRyxPfvy5x4kCvE5b7+qprBeVza0a/AG7omL6zjEOKvEeniKC1NGSjGryUMXEv/DtJKuldxODC9gFMSxzKBc0kvNOh+Nc2hGSTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757687214; c=relaxed/simple;
	bh=PF3+mX1UCF5J8ZLqHvBeFtapRgcvk8VI2dOGOMMDzv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pNXfW5ooOSu+sBurOslIMxl8hxktUKfxIDUDo6QwJq75156HtT8DhenWTQWATPhLxWHWpUQTR0YodrYngFxe1eC9qbOP3+6OB67YmNZ5XxxSnfkB5pVS9dqGW6gzRk12ATQj+zZnuKBiUjLSBaZjs/9NrXgYy+shHTgzh1TQiyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com; spf=pass smtp.mailfrom=scylladb.com; dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b=msHjmnNN; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scylladb.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-56088927dcbso2448871e87.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 07:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb.com; s=google; t=1757687210; x=1758292010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sRjRC1966lBzfsIjnJOjnoq3yYiS+mepNFXbE3jMfno=;
        b=msHjmnNNvC9rpaic4gKVNoZFj8qSlSSTbyXM+fyQfmtXH3QRnwbZqzqq2M5nMDDjwI
         UocncGTmcwyFirGMHMIOF49Q7ZmsNxTdVuMtn4h5aTc9pEYwLM4HkzfaR82TCipNRLP7
         X2YqBG6QalGSuh8bK8keNZ+vbSHi/eiLDRlErvyZnWOuvajzI3TCMWtiekabvQP/DQCc
         Hd/iRAl+p+QnpizGZdH79M3GU5FJss66HnQKB8w39k1eMFL9EvfZEH5QoIp9AzUlhQQC
         iRo3CbBTgreUn5lnFIPaxXqcvoPgSplJvGD+KMHFyMz4n+oMNvA/yThposPzqWqL4wtm
         2Dsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757687210; x=1758292010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sRjRC1966lBzfsIjnJOjnoq3yYiS+mepNFXbE3jMfno=;
        b=dphAgM1QwfvKyU/cvy41jhaLTXDs/aIaqrbBBGgAkCUq+xHwKPCOeO8IUn5jsT2A+X
         BPgnIXiM0wrWGKhVI8HIfWpsUzxnMb9yrVq7TMZZyqi9VF1EvR16Xwbw0NRj1ZcvcjHr
         Ujd83Ur/X6m3QX8LIWZ5vWMYGoN2yXEpYBjV6JgpuxYcUMDXSI3vlyxxa2Q2hb1u2FIS
         2wjH1GbwJuBJLhlOdrgytlIc5R4WSeSRmeJRArz1fuVJ44VPDMeXHAmeKMjH0mmeVadq
         0TDCR95JPonGWz1HUHIgGZJnsx1zaCY/Ek2JzucGqO8RLbhkxljDCqyU6cjW8FKXjuVN
         KCvw==
X-Gm-Message-State: AOJu0YyTYrV1ERmMsZJMvuyJJYgXzd0YDgPlcE2HxOVVbmLrelHYevlu
	35R7hlzedzQnAXgSP+MQyviz5kfoobQ91wQKyUKveJjp2wB4zCFpRIDG3agFc0uBeSEu7A4S2XY
	iEdClC9X5TM9DctDwnT+LlVzG8a8MS4EcNayGoCniUGCa5Zwgi62eXqxUmWyo+4eoXS8WrDyk/9
	1TCJHFN3RwdAFwMcDTYxMR/nDh2lUR7TGahhhF0IihBwnX40HUcXPNgfX3+sXeJPGaKGNN1M8vX
	Z+J3cbqLA77cIryvpsZim9Gft+BFdGrADtwg4uiAo3Bcj8iDOWeqGWogP0dj6S5EgS/e+/ks9eZ
	G0ifyaJ35vQNuw0feqrlHibssRSW9kLWUKRNXtqAv8qItgr1Jb8dSSklQMJyfT8Ke97lMg==
X-Gm-Gg: ASbGncuFZO65v64+/a3YmunMfljGpLUIgFlvkw0Aq2Tl7h/2prehO3OtHf68T33hpBs
	ZLJ+GDF8ecWm1FkvVfoHUb1Vb0lMO/zwGdDpr5Gq3tOzyy+6XqtzDyRvNeINgg3SKd9rsLrpcHM
	93YeajxdPQFAqZVgVu87Mz3vKpgvLqK1HJL3KrmujgvwNSPUenP6n5eTDiIRUgkfHCMxv4cuenS
	qk7xbfxU9mqFZpoOx9w9cqDGwb7XaOmTVqO+Shldjfyd3ubKOXwZ526RQ1vZqFcPygZ668vKJs6
	ADXIhKVfZOIWdXrT5+jp2hk/odBwqg7Af1ns+Lr3ekAbeBPuPilzCDaliK5HqbRdExcrt8LuXk3
	OG/VXSMBhuLePyrVmH4vFKPEF
X-Google-Smtp-Source: AGHT+IEy+fslMohQ/o8bmo2lPeVV1KOipNxHMsd/6juIdxHFmkMsP5LnlX28JLdn/Yu4Xw5s5EruKA==
X-Received: by 2002:a05:6512:79a:b0:55c:e6ac:bdde with SMTP id 2adb3069b0e04-5704f1cf4b7mr850933e87.26.1757687209780;
        Fri, 12 Sep 2025 07:26:49 -0700 (PDT)
Received: from localhost-live ([104.28.198.247])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-571a0fd0825sm247439e87.125.2025.09.12.07.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 07:26:49 -0700 (PDT)
From: Pavel Emelyanov <xemul@scylladb.com>
To: linux-fsdevel@vger.kernel.org
Cc: "Raphael S . Carvalho" <raphaelsc@scylladb.com>,
	Pavel Emelyanov <xemul@scylladb.com>
Subject: [PATCH] inode: Relax RWF_NOWAIT restriction for EINTR in file_modified_flags()
Date: Fri, 12 Sep 2025 17:26:26 +0300
Message-ID: <20250912142626.4018-1-xemul@scylladb.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylladb,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylla,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0

When performing AIO write, the file_modified_flags() function checks
whether or not to update inode times. In case update is needed and iocb
carries the RWF_NOWAIT flag, the check return EINTR error that quickly
propagates into iocb completion without doing any IO.

This restriction effectively prevents doing AIO writes with nowait flag,
as file modifications really imply time update.

However, in the filesystem is mounted with SB_LAZYTIME flag, this
restriction can be raised, as updating inode times should happen in a
lazy manner, by marking the inode dirty and postponing on-disk updates
that may require locking.

Signed-off-by: Pavel Emelyanov <xemul@scylladb.com>
---
 fs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 01ebdc40021e..d65584d25a00 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2369,7 +2369,7 @@ static int file_modified_flags(struct file *file, int flags)
 	ret = inode_needs_update_time(inode);
 	if (ret <= 0)
 		return ret;
-	if (flags & IOCB_NOWAIT)
+	if ((flags & IOCB_NOWAIT) && !(inode->i_sb->s_flags & SB_LAZYTIME))
 		return -EAGAIN;
 
 	return __file_update_time(file, ret);
-- 
2.51.0


