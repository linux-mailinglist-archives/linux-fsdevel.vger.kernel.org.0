Return-Path: <linux-fsdevel+bounces-22725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8647A91B6F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 08:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44F9C1F23578
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 06:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5929D61FED;
	Fri, 28 Jun 2024 06:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="TZmxOzuP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6A83398B
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Jun 2024 06:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719555855; cv=none; b=i7zb6KIujbZbnG1VYwHc/SBS5eL+uhonEYvsuN6+3JA7QtXEDH/TAI8E+5ISc89UfLnJGgQ0wVxHZeH/8Bzm4QmC0FAsGVChY/zYSa4Fdm899uvwuFM9hnw5lMC7CoYtAbpb58lUv5NpURPZhiJ3kEezKAfnQ720MhWP25oGXpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719555855; c=relaxed/simple;
	bh=2OhVz+CWLAqwx1TZwOjll/zRHYZJKy6m4OT1DSiFqzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hWKR0JWuGEUNpmHuAcSZegp9xXIE/dvn74g4utD47fe+qBQx7Xenuy809BOCxoRhzPWkTJgsZ3JdbdQFU8uWLrHt+DjhyUki+Nfx7r/g0Asm5h9OlcmPdsgiJ7xPmRggBWbVpCZqvyqOzv4+lNMfVNtfnY0E0SUs/uDv5kry+kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=TZmxOzuP; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7eb01106015so9982839f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 23:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1719555853; x=1720160653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HzLoPiZE4JE6+DixEf0MtA8WCsiSCC+1JUW9jnXAdIU=;
        b=TZmxOzuPQQQBHI35Gj/lGElIJtwzr0/aWCV7HwluPPi6Dyha+xq7r77TgraTqnTIxb
         S3+YYKuIM5giFHpuMbFgC0X2GrsxMvXWSWhaYphzjt+wP2aI7MMMCM3y79yWe7HKAGYQ
         fYrTCydC6iTTCn00V54NHFOrzlweBEX6oyBBSMX1dpUsxVoITXGK47PSKP+SSQO2NPne
         VwTW9+S6prqUkv2epwKINqKbdd+eRqP7Oadbs18pkm/K1nCetKjU0aG1N8dJHagDiwcn
         vGY5z6YMH0bFV2CzHVKYs32LrHe6eBVjECUqiUq8RXnxXEHTosiHdcsRD/lIsuZHEQD/
         Hfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719555853; x=1720160653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HzLoPiZE4JE6+DixEf0MtA8WCsiSCC+1JUW9jnXAdIU=;
        b=lm6XXpIcJJgJNJr5U1DB0kRI4i+WMFR+aQHlyGbd0Xzr/x50waxgDuL/pL1TlmrWHU
         kAaqEut8e2fteDOifzpZJWysr81u9j6fkzdjfZfsa7Kg01zMeWupj3WY4fZbD7LhxVxV
         BMPeEm9uHClWAcL8weJLQcD277SDehsCaSp/ZTcAMvEq9s93HO7+ccddUANTp7Wi+Jqc
         NAIsD4ABBxBn4qauWWRnhg5/WUAXxlZ2hSx4EWUaeqM7MDYXZjximBIpB9ZkUzPvXsjV
         aQgCKviYaS9rDSCgzCr7YbB+MMLHFmVPCmSTwdpjOKde6Q44jJ0Z/BwTyWe7m922cuFG
         8MbA==
X-Forwarded-Encrypted: i=1; AJvYcCVNymhEqRdi3bDjvY5RhoqINP9W+/SEAc2ht8WCMZrdT4QfWSl2iTxNipRuyC1Vy09RDv5w1btbd7yiYgSyoep7okCiXOUAy7ye52wBug==
X-Gm-Message-State: AOJu0YwzaDyEufbDd9UKHOxvnQVw9B676bdEeTURl3KR3Uc0djjHKckG
	CrN2A6g0gzZIRrjgP7mIK3JF8UBRteCPS9x4MBq7i59tPXoXat3OpNI2jZBNl0Q=
X-Google-Smtp-Source: AGHT+IFsWTRPrleNV9WCHgmOyv7LoUsWG9TeEWqDKOF3BkaC6BtC1QHIn26XExOxqaLkUv77OaSsOQ==
X-Received: by 2002:a05:6e02:1c0c:b0:375:c443:9883 with SMTP id e9e14a558f8ab-3763f6ce08dmr180676155ab.21.1719555853457;
        Thu, 27 Jun 2024 23:24:13 -0700 (PDT)
Received: from fedora.vc.shawcable.net (S0106c09435b54ab9.vc.shawcable.net. [24.85.107.15])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c69b53ba0sm671358a12.7.2024.06.27.23.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 23:24:12 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: dhowells@redhat.com,
	jlayton@kernel.org
Cc: netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>,
	Simon Horman <horms@kernel.org>
Subject: [RESEND PATCH] fscache: Remove duplicate included header
Date: Fri, 28 Jun 2024 08:23:30 +0200
Message-ID: <20240628062329.321162-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove duplicate included header file linux/uio.h

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/netfs/fscache_io.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/netfs/fscache_io.c b/fs/netfs/fscache_io.c
index 38637e5c9b57..b1722a82c03d 100644
--- a/fs/netfs/fscache_io.c
+++ b/fs/netfs/fscache_io.c
@@ -9,7 +9,6 @@
 #include <linux/uio.h>
 #include <linux/bvec.h>
 #include <linux/slab.h>
-#include <linux/uio.h>
 #include "internal.h"
 
 /**
-- 
2.45.2


