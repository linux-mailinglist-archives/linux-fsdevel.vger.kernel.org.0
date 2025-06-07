Return-Path: <linux-fsdevel+bounces-50905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D07E1AD0D39
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 13:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F503B3079
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 11:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D009221DAD;
	Sat,  7 Jun 2025 11:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RU8YvU4L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FD41FDA97
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Jun 2025 11:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749297193; cv=none; b=dTI/AbdjbzZsP3QVOQudRYzLKRLcikIsdASmmW6HBidi7WhXfPoJKKUiFLWdF3jr+GbQU5QfD57v8rYkOic5rrMtl3TTBr2F3BW1fmmvsTmkhe43vMI+BzrFlF2I3DZOpsnCYyEzmw9hKNLxHxJ5OnNGZHgNTo9yJ5qatSkoZao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749297193; c=relaxed/simple;
	bh=k79nhHCR5QitpPzZHBnUkbzQJE5oeDsJxxVtLmNSAFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cC5oADsSOyTtysyPdkI1Rl8YqkjiyCYfZ+Y6qk4fR+alqQYQrDAA3AxLGBVxZOo9usymzVSaFmX8o8YQ+rlFaisNc1vgfUgbD7IaXY7AFqzVS+c9X+MdzDwSV6JmRs6lgb5QJJ2PqGReWxkKWKNalLQ1vFFb92xiw9rMTX/Ruh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RU8YvU4L; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60779962c00so1936948a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Jun 2025 04:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749297190; x=1749901990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPwqoJIEukf9Xeid6Z/wUxU+emhYk0B+36uVqwkPMlE=;
        b=RU8YvU4LhPdmkOnX8lsSF4RjZzmbPjR7e2qaB77mzvbkk3N0WwyQhVvzlKahEhlfXS
         6tkrQJZD6B5xlW/8uiYsCMjkUkEks+GAgNbRqo907Uafy2hK8a8sxTXnz0N5KmAIpOFH
         G5Etj2sw+VLbPlpIWbEz8nY1mSC2JZZ/Mkhyn3ZGP8opD+YuYsIXJx0K7qA3sMCE88Pe
         KI2osOHjn9anclkecTMGY2w+WbyTwQpA5kmMvDR2jjOhieLboUYfjlWvWP7MBEYnG63d
         qYwumKR7+ny4GeOVAvOYs8jbQMgUNJkkCC7aHuxt+/K4BlumsReNrOhqIsVj/1qFn+gc
         Cbhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749297190; x=1749901990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPwqoJIEukf9Xeid6Z/wUxU+emhYk0B+36uVqwkPMlE=;
        b=PmfWVhoe6MJHYjq9PnplvfkaBTV5MByuZkc4jL1PoTFRasyQvR2BFBn4858jBzposs
         VBtsTtUiZA9eVNkDhPNgKY8dWDogfTsDwh5s/ioJYYgnN6v6dfhFqN0YjJ5dH6df1kRD
         O33a26/30uEfeAxfjNmHMiLihT4Lmoei53w944HPgLU6rpcCQze/2pcMFuKBuQyaug9v
         GpY+yXaOg1vaHgS9/29YpaXBaa7KWE7yO1ej6WYySCQFWqbrptgs+IOdP515MDhw4vrb
         WbW/PVwrMb4E7x6Tmjg2ujOKu2BxbafBlD5JOkApeTIEGAXGrOa+VvBiC4aEiG5AAjGv
         ortA==
X-Forwarded-Encrypted: i=1; AJvYcCWWkrF+BDXzW53h+kiGJoRClPLQolWRrejb3GmNczVzzoGu7VkaNkpKa3+U76ZJqqCykljpPVyeJDWwsTS7@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/uvE8Wdz31rFVp+dz4ixZhxWUcUwYQIV4WWdxzomsW2v6mkIC
	n5RZLawOLocBJFFwV8+TaEFBzG8PmnkD0rCLOvJ0aQb1jG+16H2K8jBP
X-Gm-Gg: ASbGncvDptnwcGoVxgCXfVwEw8FG2jwbwKUIxwEJkDVK3CdNOqfRCQyDIy5CGgJIjxJ
	3yMi1IaBk6SKl/BRKdMR/NepTm5wjBtRyAb/4pJkuy/tfBb5zC/o0YFHwWyNGH/SXmPWU68gkwh
	IlAwixN+3d9AR1aHwRQaRr7ToqwctjR0NRPD3i3tp7G4310Z0mu277z2YkKVpVyqyvrk5Am1tHp
	BtEwinyTRdTBbtNlxo7rgHmsybFbboYZGgWLuzGt/Do1MLexdy9vGM/81l3kJqvFxwEGyQWWnNk
	0KL5PknN3BDn13LgXLMjkhh6AVS0R0bC8V3RXDs8E3cWk2zYDqU1kyqx7GvMMnP1sPO0TKHOkHU
	uMqIGUZBriAcZD37nYlnYy1fH1XtFoPr/7K5MufBksSnOpbSZ
X-Google-Smtp-Source: AGHT+IH+/TgLLr0RABTr5ibsFGW6uIIb4OFqQk1him7CqmnAqHp7hbO5MWLYuRcyRo4AqeDDYE6JKQ==
X-Received: by 2002:a17:906:ef0e:b0:ad8:96d2:f3e with SMTP id a640c23a62f3a-ade1a93bc65mr578218366b.22.1749297190079;
        Sat, 07 Jun 2025 04:53:10 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1d7542b1sm264876766b.35.2025.06.07.04.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jun 2025 04:53:09 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] ovl: remove unneeded non-const conversion
Date: Sat,  7 Jun 2025 13:53:04 +0200
Message-Id: <20250607115304.2521155-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250607115304.2521155-1-amir73il@gmail.com>
References: <20250607115304.2521155-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

file_user_path() now takes a const file ptr.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index dfea7bd800cb..f5b8877d5fe2 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -48,7 +48,7 @@ static struct file *ovl_open_realfile(const struct file *file,
 		if (!inode_owner_or_capable(real_idmap, realinode))
 			flags &= ~O_NOATIME;
 
-		realfile = backing_file_open(file_user_path((struct file *) file),
+		realfile = backing_file_open(file_user_path(file),
 					     flags, realpath, current_cred());
 	}
 	ovl_revert_creds(old_cred);
-- 
2.34.1


