Return-Path: <linux-fsdevel+bounces-63485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2605EBBDE8B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 13:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D51594E9FB4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 11:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF542270EAB;
	Mon,  6 Oct 2025 11:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRADCv4A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE7E21CC5B
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Oct 2025 11:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759751138; cv=none; b=rFYfWIygCnCuP9vjymi/psznroN8GElnm8JEiwVQ9ZIbrmZnbcgLRr1H9ykyFcy+F9yl2xmU3s9JpZESAS3LMPIn7uPgkZL6+LFti0At5AKaSODQ8D6UOTjfCEufod+vjWqp2aCYkVfZ8ULCI7MeH2wJ6cS2Oek/UW5MetWUEik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759751138; c=relaxed/simple;
	bh=BNMTecTK7ht2nSD6ZXYzFBe3xWgFyVgzfWdD51vF2ns=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QiJzK7kVfyaA5+uELf1+0Fb0sWpkDjrskU5x4j1sd3+TU5gHUH9sTGNWSqymP5jJMcfdE7Rafzz6Ybyhj/rqCK4Q3VrSptNGcyK3iwINC9hG3WZvjujiL31XgiIOKFUbok49Dwq3s3QrczOe5mL7zVGouhfVg+4aUEn15gEHHHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRADCv4A; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b62e7221351so1971722a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Oct 2025 04:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759751136; x=1760355936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N6fpNIGval6qAKSpqRMG3diXPAJYgi/qIqxbDjCK0H4=;
        b=BRADCv4AmoGrSNykcmZfCU/NW5/7yNOzfyyXh+TlUefpAiPXbXvjsvL6+Mkywkeaux
         d7RkUdN4FTXhku8uwu8Ynn3ZtHiv6N1kgGjwsZ+etbRxQcY0kvKsZQr0VDnKy0AwVrIS
         B3ei/oTRLl5WFIXu/soM4vbP+Yuie2aQ60yUFwnBCJVbdKQ9iEQkZrSJjaKx9D1sFIS9
         U45p5CwcA1iCaoLLBd3lMQKQMC0WomvwA2PpWgYcCD8QZv+oQEn6pdqBTe6nj8HBV7dK
         Bl+Ap2jftmSXuvc9TvE58gljXCXfJx5jMWUKp1EnAzIPw//8FzM2Zf2OkkJkkUQEHKgV
         gdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759751136; x=1760355936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N6fpNIGval6qAKSpqRMG3diXPAJYgi/qIqxbDjCK0H4=;
        b=GHPJsfAgeMfXbRm8PtuXja+H50/uibVLIEYcz9PbRkrBcRzCjeISK5Agya//0KcCHV
         bvntftnHluqK1XKQ0mTRfCTH7ndZkLWGb6i5CVbFrrv/+4iDqU/1UWjMrxUXEBxeLaMg
         MjDdQC8bLQ+NK7nC6huPN+LBEHBhI9Pl+20WPzEqDsCqS0EvNWaNZK8HadQIysz3Htbz
         jfw0hSEgb56NfgK8HhH+F3IzIzKxo9/Q2Rypb1I4qfib7il1zKiDAW1iKwlyvnGXjZCE
         qmLKEjVNd/fKnms8KtnY99fDnyo+WO746Dy7ZTXXjcMEd6cIA2loOO40eZpntMS4g3P4
         HmVA==
X-Forwarded-Encrypted: i=1; AJvYcCXwyHQZqpBE6N//JC8Akfd9JdgRww8S+KaL1SYLcdtbariz5wO1MrXEdx2KCLl6XnadlcKyngK33YEBLsLi@vger.kernel.org
X-Gm-Message-State: AOJu0YzfB4zXw1fwxHwIRTuZcYhXcsp9Qg9nNux4tKgUVzKgywMWXARl
	a773kxDurwYUQHSXr0wCkPymMfM5f4bN5ZfYY7TH/qhj0GxV4rkkMAT4/7ia4KF7
X-Gm-Gg: ASbGncsnQQ12o8VXWTj04cUxbPw6H6B2fkDOfAkXb0iocy3s1s6KsMWnYo5OCez61ia
	5CW7WspGW4Y3Pphs8H1PeS4BmX3o5Krg0ulsfi3fUOrpPBEIgup9OxcFHgP/Eit6wxup918Ghrz
	aeAHp314uBqFJluOtwXuiqCW9tCyid/2WkPb9XLqPEdZQtEZx4rq/MgybbVGhI9k7TqHOjK08uy
	Ht15WefnaBIrU9j+es/9IY3CEVxTR0mBia4XvznhaWritzBD3+odCzlJ5FwPNsqUenbnxA4AYaE
	VJYMb2TyEE3RnDCI78tx76pt4dfrR+IqENTgYQzwKfGP8dcY1+ahWqHgmfQHYjviFM5ZTSYN4D2
	PmzM8z9GzfmBDbiwRey1B3TXTp2o6ljCmc+Zad6lnx0eHABZUt5EoX2qlzGM4q6d0ORSlfLTdzk
	OCsbxcm2SI
X-Google-Smtp-Source: AGHT+IFxvKU50K5L0Q+Tb+yTYS0SE7q47+l6oijumnjKnEw2OY+E5WVkaAED+m1lCr0N1DGoF+vVUQ==
X-Received: by 2002:a17:902:db10:b0:264:8a8d:92dd with SMTP id d9443c01a7336-28e9a58b55emr157083105ad.20.1759751136030;
        Mon, 06 Oct 2025 04:45:36 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1b845bsm130568745ad.79.2025.10.06.04.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 04:45:35 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com
Cc: viro@zeniv.linux.org.uk,
	pali@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] exfat: fix out-of-bounds in exfat_nls_to_ucs2()
Date: Mon,  6 Oct 2025 20:45:07 +0900
Message-Id: <20251006114507.371788-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the loop that converts characters to ucs2 ends, the variable i 
may be greater than or equal to len. However, when checking whether the
last byte of p_cstring is NULL, the variable i is used as is, resulting
in an out-of-bounds read if i >= len.

Therefore, to prevent this, we need to modify the function to check
whether i is less than len, and if i is greater than or equal to len,
to check p_cstring[len - 1] byte.

Cc: <stable@vger.kernel.org>
Reported-by: syzbot+98cc76a76de46b3714d4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=98cc76a76de46b3714d4
Fixes: 370e812b3ec1 ("exfat: add nls operations")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 fs/exfat/nls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
index 8243d94ceaf4..a52f3494eb20 100644
--- a/fs/exfat/nls.c
+++ b/fs/exfat/nls.c
@@ -616,7 +616,7 @@ static int exfat_nls_to_ucs2(struct super_block *sb,
 		unilen++;
 	}
 
-	if (p_cstring[i] != '\0')
+	if (p_cstring[min(i, len - 1)] != '\0')
 		lossy |= NLS_NAME_OVERLEN;
 
 	*uniname = '\0';
--

