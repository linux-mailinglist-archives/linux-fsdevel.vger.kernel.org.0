Return-Path: <linux-fsdevel+bounces-63722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA49BCBB04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 07:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4B4D94EAC13
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 05:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E2F26A1CF;
	Fri, 10 Oct 2025 05:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZlWfOJ4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2042E4207A
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 05:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760072641; cv=none; b=X2RovDgBpbrnekDq9I5aSGP4BMXgx7zcvGCED4XN93khXPe9y2esuAnKNNiLTgKQ1CTk/vydg/Ul4nG+FX45orJtmFdSIN1MnJuGRSEsPhl/CAgJ+roUQi0N8x1qvNdcS1M7UrWDMtYtviPSZILQ8cgUNFfH0SEqITSeacZTjMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760072641; c=relaxed/simple;
	bh=1Dc701lWNd96LkNgZ9yo8fbcDa5EjS3FNySFxixaJsw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Taab0v2XIcF2RBq+RYSdkxrjdE0pumzova3rextJWDlAVQNrFQxpxZIUTT0fTuAYe7x3i1NkoTbqeijBglEYVu09NSUqEepKZbo6K2MYoFkxfIqE+RtBZ+6UYv/5LWWzkEiHmOE6C6Ib5Su9wn73yiHLi7iwQnzUTcpGltiU80Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZlWfOJ4; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7835321bc98so1688044b3a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 22:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760072639; x=1760677439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QOIbcB6sHuY59NsTH9o+B3XGfKC27cxgCVvQpYalfzk=;
        b=UZlWfOJ47gLWD4xqhE67hUNZf+pbRQc1Z/rO+wjLVNcIRBc/FvKIMrudizMLhtKCsg
         dkmRDnzZB/lEjFhPtAMBVXbBaCy9dZeeEtE3tTPyWlKj6QBLZz6qkFHC78P2rts6GjFt
         ASCQqXDpJfJ9j+WgJ12xcdjQJpTlsucxWbtHj9vTxFMpLHyR71ibPLEK9huS9D7Vdxx5
         9tFvxDfIrQd2z/hj7DZTbHzVoh6EUCBfGVFgoX2G8D70x9cXr9OqMTxu5tduIf66F1pE
         /GSb/bfS9xhVXdb3akbDWBxhdES8iY+oiJmO/RGdsgME6i+z4PyR9fTWKXTFEibI1Vke
         Xq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760072639; x=1760677439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QOIbcB6sHuY59NsTH9o+B3XGfKC27cxgCVvQpYalfzk=;
        b=oBRSMbnH7J9jidb8KM1mzlugEmUSB0SJ7ban7dWxwujKiYwgZtspO8TykOOsdj9uGJ
         jt5W9dpJFcJ40LIwgGfXeKhD8iN2REyyJwnwWcBnOweTGPCA3ho4npQUgE9dCAbYL/kR
         r9JDpm5K11pFWb01hxg9MffRjwpoxoOn7VGtR3thsW2ITnIW/ooXAeQUAuoOCWLDSSUe
         i4jYSGg+TxT6WsEM2yOxx9mk8g6EFQWVaOSctsQEGnJXwl2DHNAsbGvux+XgE4X8p6VM
         JodARy7d9j1Lk2lFL1y3veIkSZFJB3yFkirL3NqsdH2I5rpq8XKNoooboZu0uA4ugFIX
         Fd9w==
X-Forwarded-Encrypted: i=1; AJvYcCW5Q9mv3D4fooV86cvJGvJcdoDJwRpZKVFP3S3sJG4WjMiz521bUjJEVpgWWD9JNR09hwEdRr6/TQB3PC0H@vger.kernel.org
X-Gm-Message-State: AOJu0YwytleNy2G6e5MBzt5PGSOQ6efwHAUaz2eJqSFptdydAMzguyAM
	P475QVb+VaKb6P0QXrQQi8xdQQjoeXf5oohSh2BvhvHxFRPcL0GJmCwa
X-Gm-Gg: ASbGncvmH/rQgVhgjI50Fpw8QXNqSZ+ou1OGFXvvAq35Pl1ZcrPRI5rK+d7mCMVAiK8
	1VyilTvrdkPWrrr8xCNWgm2u+MEubQsctD2f510Gws/Fr1GPdj0wmMHSEKb8rFNwZye03BKushV
	J3ueMBM8PCvF4fTmpbkM3N4fRVvDJXiNV7x7ZYxbGkje8G7XjQZsPosnOy9eklBWOhp4tUwc7/V
	ALoV2AETWVlgB9S5u/EGapkGiA/uSpGkSOhHK7/Bz+LKqyddzH/heuUHYBKy95MYR58F0e9QH0h
	TDe4LtimbXqvHhceo1X4j1l8S1uZCjOi59MbSmLS438WSV43ctTLxNOTrkHrXNWDRFcPuy31p7X
	jmMwQUAa6+zkkflFQk8n+aZJAcyxmGs+0gQ4TR7C33sIhdcQpZ7JQhVPHExI/+mSc9zJ7
X-Google-Smtp-Source: AGHT+IGuDVmXLZYX/y/OUM5zsyxoqV8HwvNsVgBWqVPj9W6hKvMwFMtAmda8Lcymjv6YGDInXNZEmA==
X-Received: by 2002:aa7:88c8:0:b0:77f:143d:eff2 with SMTP id d2e1a72fcca58-79387c191fcmr12173718b3a.28.1760072639240;
        Thu, 09 Oct 2025 22:03:59 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b733355sm1505098b3a.26.2025.10.09.22.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 22:03:58 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>
Cc: Yuezhang Mo <yuezhang.mo@sony.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	pali@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH v2] exfat: fix out-of-bounds in exfat_nls_to_ucs2()
Date: Fri, 10 Oct 2025 14:03:29 +0900
Message-Id: <20251010050329.796971-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In exfat_nls_to_ucs2(), if there is no NLS loss and the char-to-ucs2
conversion is successfully completed, the variable "i" will have the same
value as len. 

However, exfat_nls_to_ucs2() checks p_cstring[i] to determine whether nls
is lost immediately after the while loop ends, so if len is FSLABEL_MAX,
"i" will also be FSLABEL_MAX immediately after the while loop ends,
resulting in an out-of-bounds read of 1 byte from the p_cstring stack
memory.

Therefore, to prevent this and properly determine whether nls has been
lost, it should be modified to check if "i" and len are equal, rather than
dereferencing p_cstring.

Cc: <stable@vger.kernel.org>
Reported-by: syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=98cc76a76de46b3714d4
Fixes: 370e812b3ec1 ("exfat: add nls operations")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 fs/exfat/nls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
index 8243d94ceaf4..de06abe426d7 100644
--- a/fs/exfat/nls.c
+++ b/fs/exfat/nls.c
@@ -616,7 +616,7 @@ static int exfat_nls_to_ucs2(struct super_block *sb,
 		unilen++;
 	}
 
-	if (p_cstring[i] != '\0')
+	if (i != len)
 		lossy |= NLS_NAME_OVERLEN;
 
 	*uniname = '\0';
--

