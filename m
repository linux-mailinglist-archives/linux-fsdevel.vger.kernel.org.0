Return-Path: <linux-fsdevel+bounces-24377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB5D93E8C9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jul 2024 19:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C74D81C20E66
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jul 2024 17:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F7D54765;
	Sun, 28 Jul 2024 17:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbWzgcFX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24501DA2F
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jul 2024 17:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722187823; cv=none; b=Bn3roZ4qD9fylBpMghKbkvW1e8rnoPIC2yJZiVZmQB1YwXeYl6Oj0tgkH0fHJflWWbGwT0wwUGOwq63Ruof+dkMMGR40H2XoCgr3ON35XsDDjwJJZalSzuL6WvDpIR3Q5cJVEWjm87D9aZQbYWjc9ENN01EWTJ+ecVDbWYlQR5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722187823; c=relaxed/simple;
	bh=2AD3MMNZqnt70MEWY//mRnCq/uSFCw9XkUjYoZqo9bk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V+trQNCLKr2J78l+EbNan6MZKnczi9WieOiyzxN0SoNXBxBDX9D6fKRr4NIcvvClEbI8MlxF5QR0Vc8fD8VDluDV782HaovOXyFtkDgvTHNS64MUVd8pBNIGnuvDcok4RfCkc1NBhoiunMIzMI0fuP0np+vmiFZvwAg0MH3Z3wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbWzgcFX; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7a2123e9ad5so1470537a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jul 2024 10:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722187821; x=1722792621; darn=vger.kernel.org;
        h=content-transfer-encoding:commitdate:commit:authordate:author
         :mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6wiv0nloWjoHcpjHzBuCqTkOOAP2x8qTq7AZF6uuHjQ=;
        b=gbWzgcFXUfaEckuED5h9CFpNEifgsVdUaR6FgqQbjPj5yYNwVjHH3BLutcHg0gXPA5
         P1AH1Bmb3/rm22i62ajceV5p9wk4i5LvZlv9hsLWuDdCNafQfRvo/dFiBNnNelCMI6vY
         0Qj/cOBbtyRs+UCCtx+rLSWYMlGM3GXp8QYo8hr+/FdX7abc9eCsOb42fEEtLlpWuE8W
         XdHMkVQvgYvyp9Je1MonGwh1aa3X/mBPntdNOzKAk+1dIsrD/dn7xSjeODPo4YuDafR7
         XkJ7T+MzzMGdAbLYQZS75ZNcweZuLy9f69Hzza40I+wTCTkT0f3jHqNltg5hJkdZgJbX
         YVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722187821; x=1722792621;
        h=content-transfer-encoding:commitdate:commit:authordate:author
         :mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6wiv0nloWjoHcpjHzBuCqTkOOAP2x8qTq7AZF6uuHjQ=;
        b=Q1EzVyoVAjIw3LBgEkO6LiXUAp6aMwXaiUZ2D1qTdVoFCt26QUtTFcj8V2VVmRDAWW
         enELhX+hKf8NXg0B86etmtixYbBMCtpYgawfdzooo/8O73uJWFnStSkdKOJ3j07pc7Ma
         ckZY4gT+Dzgr7RbFhneSXPunZIuRl94EqTi7bNNeY2Y1D+9z7MXW5/tFXh8//YhEmE0z
         UQVHz2KLWtIXVltzuOpFpyNMzoIgdPQeFzpzJ0/ACDGm9h0kamoyP7h8j6MOt9m+1Ws2
         0aOCsti+lyhZa64ZW+snq8xpCUY75AQBNLoP59rfP6pcCG4l1G11E7eizXIPulWM9o4A
         zvCg==
X-Gm-Message-State: AOJu0YxUOftZ0KGaRwtvCUSKQEJy4ketlUvI0Uf4zHWnM0q42uxpvKAB
	ersBicxYVVV5FnNOdfZvH5pUsJnSESicjdR5jKhkJvSrTFMrCt77Kiz9qVVZHz4=
X-Google-Smtp-Source: AGHT+IEfMq8QoH5lOT2NRgNitnLWzz70aYsDLkP3r7fNq48j/yoIHV/k94tN1APtPUzLmahR4gqBRw==
X-Received: by 2002:a05:6a20:918e:b0:1be:c41d:b6b7 with SMTP id adf61e73a8af0-1c4a0f4b3aamr8625612637.19.1722187820740;
        Sun, 28 Jul 2024 10:30:20 -0700 (PDT)
Received: from BiscuitBobby.am.students.amrita.edu ([175.184.253.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70eca8af213sm3169860b3a.180.2024.07.28.10.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 10:30:20 -0700 (PDT)
From: Siddharth Menon <simeddon@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	syzbot+fdedff847a0e5e84c39f@syzkaller.appspotmail.com,
	Siddharth Menon <simeddon@gmail.com>
Subject: [PATCH v3] hfsplus: Initialize subfolders value in hfsplus_init_once
Date: Sun, 28 Jul 2024 22:59:13 +0530
Message-Id: <20240728172910.483823-1-simeddon@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Author:     Siddharth Menon <simeddon@gmail.com>
AuthorDate: Sun Jul 28 17:05:40 2024 +0530
Commit:     41b1c7e0a2b4907dd7f1af4bb319fe9d33dd76cf
CommitDate: Sun Jul 28 17:05:40 2024 +0530
Content-Transfer-Encoding: 8bit

Addresses KMSAN uninit-value error in hfsplus_delete_cat
discovered by syzbot while fuzzing. It is triggered by 
`hfsplus_subfolders_dec` due to uninitialized value of the subfolders 
attribute of the hfsplus_inode_info struct created by 
`hfsplus_init_once`.

Fixes: https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
Reported-by: syzbot+fdedff847a0e5e84c39f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/x/report.txt?x=16efda06680000
Signed-off-by: Siddharth Menon <simeddon@gmail.com>
---
Updated commit to be more descriptive of the issue being fixed and 
initialize subfolders value at a hfsplus_init_once
 fs/hfsplus/super.c | 1 +
 1 file changed, 1 insertion(+)

diffhfsplus_init_onceus/super.c b/fs/hfsplus/super c
index 97920202790f..24e58de21 a hfsplus_init_oncehfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -661,6 +661,7 @@ static void hfsplus_init_once(void *p)
 	struct hfsplus_inode_info *i = p;
 
 	inode_init_once(&i->vfs_inode);
+	i->subfolders = 0;
 }
 
 static int __init init_hfsplus_fs(void)
-- 
2.39.2


