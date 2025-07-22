Return-Path: <linux-fsdevel+bounces-55709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D567B0E2B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 19:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B229560EA4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 17:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4630027E1AC;
	Tue, 22 Jul 2025 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAZ06pGS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9465185E4A;
	Tue, 22 Jul 2025 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753206048; cv=none; b=fnhHBRoKANJMxT97V4rB5OrwdX9glDLirwL6bTRCnzJ5YWmb3rnBcRoMGdvOevtfBMM1f1X7gZClpjs0QxrPEsEgZF5tzQsFDMwjGfYYn25YOnRkv1kE//twvw+ig5fKztwCfbEtru+qvS6myc19P6qSFz5X6sl1vYJxfhDGqzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753206048; c=relaxed/simple;
	bh=WovQaQ9PikrY5uLmVbsHl3tpSSKbTT19zMVimO8nhF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aA9kRmlGQdv+MaLA1wXoTy+mFtQA1zDzpx6/cAfYZ3phQoz4NW1XD05pMBDtAvG8MHhs9jRYGYDzob5N6AdJPnf69MlRENW44i42ChloFURyQ/R5xoEV/deJZ2iQdguksY6O86rjrsoX6CrQPWep+OfFnwj6wEC8VzltES875DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DAZ06pGS; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso5044098b3a.0;
        Tue, 22 Jul 2025 10:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753206046; x=1753810846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3nTeLrKufhqWMbv8ZxgNZNY3CTIL94aICMXLX0urdhU=;
        b=DAZ06pGS1+hnIOMhS7LKLaMqit2ydrH9+4prM+cUXQ7aNOKdQbneAMY0SZOib6+EaL
         ewPyvnng5ss7o1YYrc6N7t7NK/bhpvsxU/LSupiJQrFZjf74//UJEBPMUVVWqHfmrofh
         F+cOPhbDw/nGDwPLh6DGSIMLdw60gvzHl4lH0Riz34lht+pRkcpXpNVuRYg4XtAGthug
         E6rAq/KJVNAvTgITmQ9cNpoAuB+p5OxcRDHKz49iI08DPJy0nM75iLj23b+R3bimo2MF
         VWKSQvPPxOZSESSuTxhAOC8uNB0yMOO4eSTufwIaj6ovTbmXdgTwFEdhgiIXLkRPn2DH
         4JSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753206046; x=1753810846;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3nTeLrKufhqWMbv8ZxgNZNY3CTIL94aICMXLX0urdhU=;
        b=YBoh+guxcufg+VLXtzsTL6HEy77i43XeXfVge+19H+/HnVgcWLqq2Ljbkirrs5Eo+u
         7IM25d71XNvIbpRtN69zXQFzh3vLvaGEuiSCvUOr1Qx7yRYb6fnZgnqbvGKUkoE202z1
         aS8jNh1LtfdLcGXv7T7IaSqPCvBpdUaR02OPUDCuhGVsQpaCHNv/s8aKxL7crIpyQdZ5
         ezMtdtFbpbct4CbZZ7W/gIAwKaMmiqxIWGmdScUQBtabAqeSjQWX5vrayUXxQLkCY7B2
         re4H+pRrjmZer0LqlTY+gzl7mt2blWjSrOLadMrAn03UcYubmpq5IdbEXM2hoMKFST5h
         AiZg==
X-Forwarded-Encrypted: i=1; AJvYcCULZorRcRDgfQRIugGocgE5AJaYw1hEJA+eKvF+WaM+J7sxF2VNKixIYC7aUZylKlfmwmyjqQakDtz6/VAv@vger.kernel.org, AJvYcCVrt2OFdo9zfuZzTcs2c++RzfTYi4AP6o6A1xgxzI67V7hrvhjtL4Pi0aQqdIfYg0CkQu9IJ6m/rR4soC00@vger.kernel.org
X-Gm-Message-State: AOJu0Yym1BTQJ8tuHZbQwHP35GzNIOIGylmxConJpSyaVitHKY410hM3
	35hDiFM1oRHZ4a+TQCOQL5JPy1K29sjzA7xSJlo01/Um3ajjUUqvAw26
X-Gm-Gg: ASbGncuryiq5huPZY8aKA5k4BVAO3xOaq3uOC/ctyVjNOmVv5PZJc1B6+Xo30CZJRV3
	fmmXNRm3Ts9Jc78eo/yTOB19wyoDA88S9yrNH/dTwqzK0MCexc9rYr3q8JLGk6GMtlT62Lkz0ba
	psfQ3tOxCevdOrPPfjWzc/1Ta+oJ+Zmnk5Pg8GKBweDw/ed/uxiy6NAfoJzsrMCDpL6MqpEPIKn
	SOVu+au+N5ebRXTA24UyF1L205JbyzvYE4+ggqz5/so++ZYU6Ru0GZyoDmWlvckVktHQ6Wf5BD1
	DEAUUsf4LvVRLty40fMKivX5ZJ4gdnvygrGaxPXQ/sgjxA180RqqNLhBMb1VsoGl0+shU1bDhia
	LmlJ4PW7ezr1ajIBhKD42ok1DP/p98pEL1H8A1OC5BEuOIcgQXRDDnR4gC6snny3oLw5UFzrsq6
	k05Dpe
X-Google-Smtp-Source: AGHT+IHXofxaXAuzCTLZ52xYH7I3ZxslIzIjmJnqbJ8FLMUIdSLObu7TSKc0W/EqY0JYX1uN7V/HHg==
X-Received: by 2002:a05:6a21:6da3:b0:232:5977:bbfc with SMTP id adf61e73a8af0-2381225eb60mr44715347637.10.1753206046007;
        Tue, 22 Jul 2025 10:40:46 -0700 (PDT)
Received: from p920.moonheelee.internal (d173-180-147-14.bchsia.telus.net. [173.180.147.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c84e2706sm7936159b3a.31.2025.07.22.10.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 10:40:45 -0700 (PDT)
From: Moon Hee Lee <moonhee.lee.ca@gmail.com>
To: almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	syzbot+b0373017f711c06ada64@syzkaller.appspotmail.com,
	Moon Hee Lee <moonhee.lee.ca@gmail.com>
Subject: [PATCH RESEND] fs/ntfs3: reject index allocation if $BITMAP is empty but blocks exist
Date: Tue, 22 Jul 2025 10:40:16 -0700
Message-ID: <20250722174015.274146-2-moonhee.lee.ca@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Index allocation requires at least one bit in the $BITMAP attribute to
track usage of index entries. If the bitmap is empty while index blocks
are already present, this reflects on-disk corruption.

syzbot triggered this condition using a malformed NTFS image. During a
rename() operation involving a long filename (which spans multiple
index entries), the empty bitmap allowed the name to be added without
valid tracking. Subsequent deletion of the original entry failed with
-ENOENT, due to unexpected index state.

Reject such cases by verifying that the bitmap is not empty when index
blocks exist.

Reported-by: syzbot+b0373017f711c06ada64@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b0373017f711c06ada64
Fixes: d99208b91933 ("fs/ntfs3: cancle set bad inode after removing name fails")
Tested-by: syzbot+b0373017f711c06ada64@syzkaller.appspotmail.com
Signed-off-by: Moon Hee Lee <moonhee.lee.ca@gmail.com>
---
 fs/ntfs3/index.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 1bf2a6593dec..6d1bf890929d 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1508,6 +1508,16 @@ static int indx_add_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
 			bmp_size = bmp_size_v = le32_to_cpu(bmp->res.data_size);
 		}
 
+		/*
+		 * Index blocks exist, but $BITMAP has zero valid bits.
+		 * This implies an on-disk corruption and must be rejected.
+		 */
+		if (in->name == I30_NAME &&
+		    unlikely(bmp_size_v == 0 && indx->alloc_run.count)) {
+			err = -EINVAL;
+			goto out1;
+		}
+
 		bit = bmp_size << 3;
 	}
 
-- 
2.43.0


