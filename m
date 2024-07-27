Return-Path: <linux-fsdevel+bounces-24357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F4593DD6A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2024 07:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97C311C230EE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2024 05:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD961946F;
	Sat, 27 Jul 2024 05:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YA7zkatT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159FF18643
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jul 2024 05:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722057917; cv=none; b=GkGZopv86SagDQVD0ohcx5XtLqAVtt4vSQRxuFaBY1E3a/NaGl9gYrRm4rvePPn0rACO3J/YCPqoaihsTQjnyjYoC5ka7czwKDOs2MXfnjheICMOR+aPEL1Y0BIUcYiFHTc2XtdsMbgbUoFnxpFyzDNSI58MrWRh4hmXa1glf0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722057917; c=relaxed/simple;
	bh=5ofRoWDFlDBxbXA/pSw5dPo+BMYbpKLy7/eH3DEdg1I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GziEmXwaDudpTNO1Z+CFLX3+KVJxaWURKYjdBGcX+5HFkIq84ftkNUcbsC0EBSASalRnyw3TSJ1680LmPozE0i2j4Se5kQs4oJdR8bHC+kxGWCGQ/YJqwAFEzs6WxeJ8qtgp+63gHfS1Ns/0OtZPU2o1l1qKdif7KMd+xvD0Nkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YA7zkatT; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fc658b6b2eso10522155ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2024 22:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722057915; x=1722662715; darn=vger.kernel.org;
        h=content-transfer-encoding:commitdate:commit:authordate:author
         :mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uraz/Rjf7B10uQwtKk5Km/juVMq3uk/FF6/Ih+sO3gk=;
        b=YA7zkatT/UZQ/la8owgsC8aMvHtIfkOk1AbQLovIlE9LDSowQuPzCycbxKYOVboE6E
         rBBlGFM1tQfEBrmg2/Fr8WZbToM03Yyo/T38JSHyNRgDfWgRobteytFvwgYqJUO7T3Y2
         fcz8iiI1eraPweZwjfpENqo4iW3XE+cKebBkHGBY7lkGMNjaGi7adOo/WNWV9REXSA6C
         EBcvtDoS/bSlamX63iuX0pSJB9VohsDLwyqJfRUxm+Yq1+eYmGF/JzAvCpklfNI4Gs6D
         LQV6iKLF4tGRRAkmGbFM7cATGjNA9bghYPfnLgFeI2XZOw8okTM0fM5+AGki3n5Dn+lj
         Y2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722057915; x=1722662715;
        h=content-transfer-encoding:commitdate:commit:authordate:author
         :mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uraz/Rjf7B10uQwtKk5Km/juVMq3uk/FF6/Ih+sO3gk=;
        b=t+ZTbRWGbUx8k20NFp+bUyJ5HvZbtm+G9wbU8LkPHrUrZnZup6azAwjWe44cEj7ofB
         H9fPtd5V3+goJr+BK9dvFgKsdm81F6sr1vHnyGgn3sdHHzS++G1HflbJX35gFbDcgKOO
         hvFazFRRvmUKPJ4BQSn2I5FvvZmML/yiBfOX+4qgFzEKr+0FgyOWFz+ofiao+e0uFV7A
         MZUtyarXLGhNyUXd2+gsHyOw7J1GQDZUgMfSg2c7tUIYqCR0aB+FsjPlDvrrG0W0AcwN
         gG2bQpMElZm9ZX71HQiazlsJNdGK8OX191dVIJNdhNE15p+9gF9qCiKiLJsqzqfkaTEm
         Vl4Q==
X-Gm-Message-State: AOJu0Yy3wFXfRZiifpqY1JSCI7VB3Zvg3Xy2+oLSL8RNMMFgecB5VNsi
	zoH80hkdgLmE08+OgRCnaRtP2wSQmgrZSH5R1F+3AiHuoxxE7Yg0ld1zHGtpC9w=
X-Google-Smtp-Source: AGHT+IEMsMNXkWqi2O0PPz5uUuY0duZcf2oHVzL7FWhymEgdsnJDL9i1C5eQSF3lmeLE97a7tsk13A==
X-Received: by 2002:a17:902:f811:b0:1fd:9b96:32f5 with SMTP id d9443c01a7336-1ff0483e1f2mr17428485ad.31.1722057915021;
        Fri, 26 Jul 2024 22:25:15 -0700 (PDT)
Received: from BiscuitBobby.am.students.amrita.edu ([175.184.253.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c8dc78sm43246965ad.4.2024.07.26.22.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 22:25:14 -0700 (PDT)
From: Siddharth Menon <simeddon@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	syzbot+fdedff847a0e5e84c39f@syzkaller.appspotmail.com,
	Siddharth Menon <simeddon@gmail.com>
Subject: hfsplus: Initialize directory subfolders in hfsplus_mknod
Date: Sat, 27 Jul 2024 10:53:50 +0530
Message-Id: <20240727052349.74139-1-simeddon@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Author:     Siddharth Menon <simeddon@gmail.com>
AuthorDate: Sat Jul 27 10:31:53 2024 +0530
Commit:     3f02808f3a98598adf145b3347b50926fd7d5c74
CommitDate: Sat Jul 27 10:31:53 2024 +0530
Content-Transfer-Encoding: 8bit

hfsplus: Initialize directory subfolders in hfsplus_mknod

Addresses uninitialized subfolders attribute being used in `hfsplus_subfolders_inc` and `hfsplus_subfolders_dec`.

Fixes: https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
Reported-by: syzbot+fdedff847a0e5e84c39f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/x/report.txt?x=16efda06680000
Signed-off-by: Siddharth Menon <simeddon@gmail.com>
---
 fs/hfsplus/dir.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index f5c4b3e31a1c..331c4118bc8e 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -485,6 +485,9 @@ static int hfsplus_mknod(struct mnt_idmap *idmap, struct inode *dir,
 
 	mutex_lock(&sbi->vh_mutex);
 	inode = hfsplus_new_inode(dir->i_sb, dir, mode);
+	if (test_bit(HFSPLUS_SB_HFSX, &sbi->flags))
+		HFSPLUS_I(dir)->subfolders = 0;
+
 	if (!inode)
 		goto out;
 
-- 
2.39.2


