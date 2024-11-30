Return-Path: <linux-fsdevel+bounces-36178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C64A49DEF32
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2024 08:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E4E3B216C2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2024 07:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1949D1474D3;
	Sat, 30 Nov 2024 07:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeknYd83"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B9943179;
	Sat, 30 Nov 2024 07:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732950136; cv=none; b=ZNkTrEuu55E+JDR9MuhrgRaa1IZVfa2uVvWDUK3U4dvSIWB8oa/pRDkU2qOEn2WIvQb2JN1HNTm8P6nDRUXDiv7SGjgqsGQFM2AlBUgCrasFyXOKhzPLyYTGlV8HKwnK9gjMxykjRh6LAhv3WhZhzZjnUulrR9bd/dSFNBFCWgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732950136; c=relaxed/simple;
	bh=s6I9pZtLYg0a8BYNA80JWka6T3igQ0OocnU70AC+NzM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SlU0G0mK+aaxzuQniT4q53YUzitlcpXVzyVMGT/YgJi41SU6ebhTsem6dt+PRJPIbaA/qWdt3NXkOJtn6O9afQrBK7Ubuyve7zczpMzRhxmzhbEcwRRKmLUSBawVJr155LVO3vq2p6x7JAhxawr1bBPS6BFovV1NAoYd05eElZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeknYd83; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-214d5f7b1b8so1671365ad.2;
        Fri, 29 Nov 2024 23:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732950134; x=1733554934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RReSnjb52ei54+X/8PT9gkRCEQgRrEutq4HeExShp1w=;
        b=TeknYd83iA1Ajl+YFaTNrDtUjtwLye5MX5J1Q7lfg13o72jSDUDNEBjNQUNTacCj0d
         GdPNncMsALgWNPRcBy0f4gZOIrGmcFymRjUP4xHJAdbUSi5qStwJY7HRv2shk5v4FMWU
         +Wj11/kPWOtgLM7Pv+eyJxpwsAwmWRPcbSknPAcgQwxrANRLUv2ve3dz+7/AxFy5rd7k
         pbHBRZ3vD36volV1QP3EIr0mQUjjFXCl5lfuEYK6etgYfe2x0pLFQmDl1bgSZHDmbMDH
         GVNck7GdGp9f3vXjbgpcZ1qmLRSxBhZeUXo1VYv+0cTzOqYioxVblgSxpKhIO1lPcFn6
         FXbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732950134; x=1733554934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RReSnjb52ei54+X/8PT9gkRCEQgRrEutq4HeExShp1w=;
        b=dTvZn0XzS8UZaWy1LcnTpQiLDtpPIXrqsEuH5xCYQtfSG0S6YoH7V3EIrmeQRevLmO
         DIGiegAWJ+5f0fiNU3X2/rqeoDK69AC7WU1g2aig6hMUWz7dXoD3j1xvO72iQkGRfAJd
         PvnPbC8t6WPf0fwNyJaMt4iVVkISpvUs3m8tlIC9xsPH+pith+DeW+l7jjgeHwtUMibL
         gL3wqOHzHOmcEIGDHTrxU/R/ExWTH1s0J0LKaB1sOtcmtmRQ8hpLQUEOFlzY+ghJ26WO
         Ap5XjEdeMN+43X96vRbda/bya3HhSBRmPjZgyTXZ8I/r4Bs/wGnEYT4y7qy/pTw5CUsJ
         zHNg==
X-Forwarded-Encrypted: i=1; AJvYcCUBI88p3CCzzC8S8cBNue5Yw7vE81QmN0VtsZX2DLZdQFx7EJ84099FMT5q8f/rVrLSALU219084XGCyTjz@vger.kernel.org, AJvYcCWCtdr24Nh5SrQeD0/usgvH5ybhUygbkHuPbWTvHtRPkPKcM9CHZKdjdV7tqIDoGNUdIo0F12bwKtVZZPVf@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2dzh/v102tLDoSd6z6jcr+NVY80NrtsiJrSRH8+fqHq9qWalZ
	wZCSqRmvfy0sjWXebTUXEYrdks8ZFLfHyEqT7/E6p9jg47bfZaI6
X-Gm-Gg: ASbGncuDdG1t/xxdvaUvHtZ01IiVm+Q4c4PQP7zqQy2QBMY0GvD0DfrdeNhSNy1uMjL
	fBwwjTs3xhZLXvUHA0eyqPk72hazAisKtMnB/PYihqwg5vmzJshI+wnvsYcu9T0a1uW7efM8RZG
	OEog0JNsEdN257UbfUXwQkngJkF+e2B08kSINo7tPeZnGrcu08uuwHbGASLAk041sBvIkF+2PMk
	77ws3Sn33Bhy4zWxCVq+a8vmMWfluQueUB2lqA8WjcxC4k6
X-Google-Smtp-Source: AGHT+IE+rk+0oE1+HoPqqDCHwez7ZXRIUpYDajQIhyaPV716hdvJj9I4kdcwZ8DyI65UWS0m/REF/w==
X-Received: by 2002:a17:903:191:b0:20c:a63e:b678 with SMTP id d9443c01a7336-21501e655b0mr78985985ad.14.1732950134310;
        Fri, 29 Nov 2024 23:02:14 -0800 (PST)
Received: from ice.. ([171.76.83.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2152d2cf14esm34830485ad.207.2024.11.29.23.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 23:02:13 -0800 (PST)
From: Nihar Chaithanya <niharchaithanya@gmail.com>
To: miklos@szeredi.hu
Cc: joannelkoong@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Nihar Chaithanya <niharchaithanya@gmail.com>,
	syzbot+87b8e6ed25dbc41759f7@syzkaller.appspotmail.com
Subject: [PATCH] fuse: add a null-ptr check
Date: Sat, 30 Nov 2024 12:21:22 +0530
Message-Id: <20241130065118.539620-1-niharchaithanya@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bug KASAN: null-ptr-deref is triggered due to *val being
dereferenced when it is null in fuse_copy_do() when performing
memcpy().
Add a check in fuse_copy_one() to prevent this.

Reported-by: syzbot+87b8e6ed25dbc41759f7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=87b8e6ed25dbc41759f7
Fixes: 3b97c3652d91 ("fuse: convert direct io to use folios")
Tested-by: syzbot+87b8e6ed25dbc41759f7@syzkaller.appspotmail.com
Signed-off-by: Nihar Chaithanya <niharchaithanya@gmail.com>
---
 fs/fuse/dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 563a0bfa0e95..9c93759ac14b 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1070,6 +1070,9 @@ static int fuse_copy_pages(struct fuse_copy_state *cs, unsigned nbytes,
 /* Copy a single argument in the request to/from userspace buffer */
 static int fuse_copy_one(struct fuse_copy_state *cs, void *val, unsigned size)
 {
+	if (!val)
+		return -EINVAL;
+
 	while (size) {
 		if (!cs->len) {
 			int err = fuse_copy_fill(cs);
-- 
2.34.1


