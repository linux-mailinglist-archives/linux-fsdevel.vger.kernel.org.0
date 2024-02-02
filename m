Return-Path: <linux-fsdevel+bounces-9996-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1B7846E89
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 12:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2698228BE7B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 11:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33467FBBA;
	Fri,  2 Feb 2024 11:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffGXxH3I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EB4199C7;
	Fri,  2 Feb 2024 11:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706871702; cv=none; b=eDobIu5SA33FRKM6DsBKVQwI1FIVqIu8RD+ggcO2uyDjDPF8ZLLsci9tqBQ9sPP49tb3misl5WbhyiuSD3baz3CmDjNUEheE0uZXlpcoQbRJE0oSSJeNVDRR/r0rpNRVY3697rpnomD8cKhpKbi2doR2oT76u2ba/MWTeFsoFOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706871702; c=relaxed/simple;
	bh=9aR+eQcT3uksXoS6Dpy5brM1qyLhEMyYI3uvHkTP0qU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QdjY7ZIlr4potvqOL8QcIznuyGUzrM8xMazmAUsXSXwHyaBQIrXYjxb0ZAPYK2JcCE8wDUL/I6Zao45KcOyoHWNazkS0TdEz1hOvterJfmxK/CisIGMOnCcfwyqJpXGyc24VyhGHEZreQJ32Au16qu4AuQIiKZor5dmvX0wfudI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffGXxH3I; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40fc654a718so4211325e9.2;
        Fri, 02 Feb 2024 03:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706871699; x=1707476499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tcRoP6jqkxxvkdaIc+oDE/GcNDBDjhW3zJ8nFO+SqcA=;
        b=ffGXxH3IdJek6Z7UTSotqPeP9nGGyQmsCJ51Dr/Q4iBRcKB7ZROpKjJr9ppJjVm/Q2
         hJYWo7o/2zWdBxtU3ytVajGbiu5ExXngyvwjnN4Ul2bLTV71BoFcYBqmGz5DvzfN7oU+
         TK4V+8Ie4SNxoqQlcpTVq/aA/3lv7JRfSkaKOmv4eHZQkzFCCjjfHy704cg0DH8T4O6r
         behvzEhkQH/9gsiJBVGOoOXiH9fft4S0eXqLEBHBVIY5UNv4kydHfnQodWdS1gOknIRQ
         RdEeMlRiai33oXSoeZtvmn6PT0Kp5a4xr0AC9BbdsUa2fG3xLN40O1yTUCb5R2WXkl12
         UP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706871699; x=1707476499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tcRoP6jqkxxvkdaIc+oDE/GcNDBDjhW3zJ8nFO+SqcA=;
        b=mTigUSKco/FUhBynhPMflAZ4s26bHM3+WebAEnqpDY3kfAY0mS1XmlrKBKR3Ins6+d
         prW/LwkMLGMHw1QlJ11nkTURioWSlZ1pZRLXeEMVMvvSQm11oFG03qQnPdqRzhqOqOt2
         ITy8l/i6DAFQjxyYSGql/iEj6ROTLHq9ZYWmJHPJ6lWx1MMO37/igQVJq3k7lfNCsc9+
         1orUqPEq5vLLHPYHnZF+Li/h7RoDxMh6IANH6//ZM/JA2ifMJuUfs2YXo94vbbtAG9IS
         Hl3e+7bACqCBiphF6RrWWSO5W/ulWv3sbC7XmrYMFtatPVJgb+VWYy0WxGZcisiYAgpA
         1vMw==
X-Gm-Message-State: AOJu0YzzzzWBvJ9JTEZxCdndT01MLj2RGxc4L9dMuCmxaJ1Wz8ZZzaOa
	zJ9hNHN6yP3sXU9oMNzAClKox8TGPXdiN7EQG5cOR4V9gWr29qsH
X-Google-Smtp-Source: AGHT+IFWJuZHv6nPCONRfPkrpizu+TeSvd+crSLNqJe4AT2YjgZqnVepyg89IqMP8PWciUeyAYlk9w==
X-Received: by 2002:a05:600c:3586:b0:40f:b022:cea with SMTP id p6-20020a05600c358600b0040fb0220ceamr1217675wmq.28.1706871697723;
        Fri, 02 Feb 2024 03:01:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWXO1Ur+WWKPpAh5QJ6vGv9SZ/7mx4kBf8CShmV5B34ckymTI/YCLJnQeBTPqnffIIxE4S3g55/t3j/dIgBGRnyWWUrGQ3N8az58b3ugfa3QcKEUZ9cNYIl+SMmTzZ8ovKw62PsbOIgWDVqNZObD30jlu59jXl9ROF0y8ybog37xqzo8ksIjtfoJLodCZtBeXyGVbJr8jYWRQGD1BvPjWJ3p5C9axDjGInqj393ZKqiu/B62afE8clVYLBJjEIA6jEDKa9GJXSuiWecj/WA
Received: from amir-ThinkPad-T480.lan (46-117-242-41.bb.netvision.net.il. [46.117.242.41])
        by smtp.gmail.com with ESMTPSA id a13-20020a5d4d4d000000b0033b0924543asm1654180wru.108.2024.02.02.03.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 03:01:37 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-unionfs@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] Decomplicate file_dentry()
Date: Fri,  2 Feb 2024 13:01:30 +0200
Message-Id: <20240202110132.1584111-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Miklos,

When posting the patches for file_user_path(), I wrote [1]:

"This change already makes file_dentry() moot, but for now we did not
 change this helper just added a WARN_ON() in ovl_d_real() to catch if we
 have made any wrong assumptions.

 After the dust settles on this change, we can make file_dentry() a plain
 accessor and we can drop the inode argument to ->d_real()."

I was going to follow your suggestion and make this change to ->d_real(),
but a recent discussion on EVM signature verification on overlay files [2]
raised the need to get the real metacopy inode instead of the real data
inode.

So instead of removing the inode argument, I replaced it with a type.
Currently, type can take D_REAL_{DATA,METADATA}, but in the future,
if the need arises, it could grow other types like D_REAL_{UPPER,LOWER}.

Please let me know what you think of the proposed API.

This work is destined to be a pull request to Christian's vfs tree,
unless someone has any objections to this route.

Thanks,
Amir.

[1] https://lore.kernel.org/r/20231009153712.1566422-1-amir73il@gmail.com/
[2] https://lore.kernel.org/r/20240130214620.3155380-5-stefanb@linux.ibm.com/

Amir Goldstein (2):
  fs: make file_dentry() a simple accessor
  fs: remove the inode argument to ->d_real() method

 Documentation/filesystems/locking.rst |  2 +-
 Documentation/filesystems/vfs.rst     | 16 ++++-----
 fs/overlayfs/super.c                  | 52 ++++++++++++---------------
 include/linux/dcache.h                | 18 ++++++----
 include/linux/fs.h                    | 13 ++++++-
 5 files changed, 53 insertions(+), 48 deletions(-)

-- 
2.34.1


