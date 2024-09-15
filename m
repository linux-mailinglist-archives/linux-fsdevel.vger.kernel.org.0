Return-Path: <linux-fsdevel+bounces-29395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 232C09794D4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2024 08:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9454283D28
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2024 06:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F4B1B969;
	Sun, 15 Sep 2024 06:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLDEqOAN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3C125570;
	Sun, 15 Sep 2024 06:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726382679; cv=none; b=qqrHwgoWQ1yWO/BksRrqB8BGaUCExQ8XM3Hi6XQN3kI7Y/sLopdEmW1EzkGFUzFd1FxGQ4uOyt4ltJNugtR/EBc7LKl+3wfsWlsCOY8OWM/1jvQVwOwYMu4aYQiaVWgZ6s9p9VYYcoGe34if3ErUxZTpD0MmlFs1y99NFNia8EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726382679; c=relaxed/simple;
	bh=q03nswiAshUbon3Pfv4QqueXclwfdc55jIPLX1ziK74=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P9Ym5khBuRtaBWZK5d3R3OWu43lmTluLs9gYEwxbfE7kdhrZrrtmANhBCTN+w+H8uEwdyjTjBpUW1k6VipUp/Jrm87KPeyY49PLY3Xa3TufD1SOerNrhnSPQmVpwnSGm3B3/wrbwzkGmFFQ9Nd87FRhaECUI6JwLt6Y+NL6zLcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLDEqOAN; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fee6435a34so30152665ad.0;
        Sat, 14 Sep 2024 23:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726382677; x=1726987477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fB1iJHerb9EwcLKBKYuEUZxaTVOQFRr0n1KVkpDHAjQ=;
        b=kLDEqOANMkbBXc2KBoEytf2i4ue7ruZASduv+YLQl0K2t2jljv/KyRKHSbaNN2Hjrn
         FUNe0zb9+56N6kwB1USVtf1LKBLmIiurE8YcBMm+7PuUVFaxTu6OWCQzLVzqmDoiOOMR
         XHsVhzyXQJXdV2XpU/Ts6AiZB5P67ZNYSG5hQ6rytRQxXdssQsaB6omgTatX73Srn8F/
         rxFosSw7UExbxNDOq4DUsEBfbsklswV8fsi4nJTTXyi/DsnG+NsAsRxfcHLeKDS7jAWi
         0m9QksgwuqwSWEz+E5ODt/EOL+0RfbRBHEk6RJMHUnYWN3zwa0VhnzlOwI4K4mTvxOMe
         olKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726382677; x=1726987477;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fB1iJHerb9EwcLKBKYuEUZxaTVOQFRr0n1KVkpDHAjQ=;
        b=pOhdCqRw9NzhwGA2eXMJDmbTG0B1cx0CRb6r5C+mhCrEeGOP99PigW+o6ng1zo8K0C
         5U3pMy4RF/aixB0Yz/26dhvb2eeG1q31Fi5s6xyGVgfedqamXQ5F5ZaBAjo5P34XIl45
         5D2/s7XebA+Doc7M1NkxzhMKl9Sw/BpVcSEfMDzGD5s39x4xZE9r+kr8EeojJ46EjS6H
         ZnenV9ezl/AcDZJQw+N1oBKLt3/fCgpOuwloQuLpm2VMn2tghE2R0GoxG+AFzT+GB8Vt
         CBE/QmpiWAwe7sogrW3wjmIqUxAuPjlm82r3MUuTlfWM4cElpe9Yyav2aBihA1THFyTI
         uV0w==
X-Forwarded-Encrypted: i=1; AJvYcCXea+6sR4pwh7KmSXcwCQMEWbW/WmZjVBkZXAOHOeZuj80Imr0jwhp8UVgtQ8E5l5skmUgBXTcslEBI7FQi@vger.kernel.org, AJvYcCXvsc8GcwjMpW64i2EBOvdaKZrcW+UDPFmmiEB0BotBYo8vOpMY15x0fojMutlhS8FReQ/Ch54WlLDZcW/p@vger.kernel.org
X-Gm-Message-State: AOJu0YwGX7oqymJ1SKJhQ086x7CY/3Dz+owc0iBRehMAMit0fOupslmS
	7SV6xR6Ilw6mAq/tIGInyd8a5rPBtDc/LTAyWidOcdVvFjD0MmTQ
X-Google-Smtp-Source: AGHT+IHLObd+CA2v8GkjKFBnbdXn2oCZmNRDPGD9K3fblyb5n2EV7BmyDAfUBew20DD1PSotmtBmfg==
X-Received: by 2002:a17:902:e5c8:b0:1fc:2e38:d3de with SMTP id d9443c01a7336-2076e315577mr186275495ad.7.1726382676843;
        Sat, 14 Sep 2024 23:44:36 -0700 (PDT)
Received: from localhost.localdomain (syn-076-088-006-086.res.spectrum.com. [76.88.6.86])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-207946d2a79sm17335895ad.159.2024.09.14.23.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2024 23:44:36 -0700 (PDT)
From: Daniel Yang <danielyangkang@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Yang <danielyangkang@gmail.com>,
	syzbot+e1c69cadec0f1a078e3d@syzkaller.appspotmail.com
Subject: [PATCH] fs/exfat: resolve memory leak from exfat_create_upcase_table()
Date: Sat, 14 Sep 2024 23:44:03 -0700
Message-Id: <20240915064404.221474-1-danielyangkang@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

    If exfat_load_upcase_table reaches end and returns -EINVAL,
    allocated memory doesn't get freed and while
    exfat_load_default_upcase_table allocates more memory, leading to a    
    memory leak.
    
    Here's link to syzkaller crash report illustrating this issue:
    https://syzkaller.appspot.com/text?tag=CrashReport&x=1406c201980000

Signed-off-by: Daniel Yang <danielyangkang@gmail.com>
Reported-by: syzbot+e1c69cadec0f1a078e3d@syzkaller.appspotmail.com
---
 fs/exfat/nls.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c
index afdf13c34..ec69477d0 100644
--- a/fs/exfat/nls.c
+++ b/fs/exfat/nls.c
@@ -699,6 +699,7 @@ static int exfat_load_upcase_table(struct super_block *sb,
 
 	exfat_err(sb, "failed to load upcase table (idx : 0x%08x, chksum : 0x%08x, utbl_chksum : 0x%08x)",
 		  index, chksum, utbl_checksum);
+	exfat_free_upcase_table(sbi);
 	return -EINVAL;
 }
 
-- 
2.39.2


