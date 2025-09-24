Return-Path: <linux-fsdevel+bounces-62539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9AAB98012
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 03:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 526482E725A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 01:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C651F4CB3;
	Wed, 24 Sep 2025 01:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJxNz7Cq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D971F3B85
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 01:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758677304; cv=none; b=J4f7jEkXdjBlFAmHauDHeZmZWRxbz2BTWbBeiqkEa4YWQHRMpL+bDAChdLZ1ox1FQLmNV4AaHb6fqfyQAC57/fCc1vxuDRqlXGbnlri0rJ0nCabgI+Z4OeGrU7WGxJ3IqzoHTLdSbr0wcKGGXbaUxICovOPIewmT+R+fgeOOh8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758677304; c=relaxed/simple;
	bh=19hk+LqNI5XDabxjhXafIBVwjhECKzWuy7AL6boNFpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iuQgezAkkjPmeRqp7ZcgLte1+YTy0hnnUzOsxFjwYxaZ4DYyQq5+zuwhv/O/39Pscv4mDJWd3zTbAecAV2tlPVrLpVV/76VqhyfCn1pZUkHcucjIcaOe4u+p+IBVE4bO6C/57STaEi/POm6KHSTric5u3e8t8oFmFV/9tIeZyVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJxNz7Cq; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77f2e960728so3665552b3a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 18:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758677302; x=1759282102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xNaBmcK1g7tsyculUAXfjKLZdvr7GDVhE7z0HdXPkB8=;
        b=VJxNz7Cq0Igsm8KBow0N0DGGGhREY9CbrtRb4DthEhSov5A70HWlk7hquA9naJ6Q0o
         HoAyAUBgLQ4aLMgckm1nOhWJhyAPwZ+rg3F8KBEJznQ7RFyx4ogc7EvjSVkP9gU6lHoZ
         cZJeyoGYkR1kTVzNMgypelzF24B+fx+CwwfDS1RucauqYKNk1dHhxkhoDTSgba9sxLDE
         bPuJw7UeOhzobJN/9bZsGWKxcy5zVQt0b+SAIFpZUgg6+EFqgiojfTnuRfIJiJZEDacK
         iMdlwaotu1tHTCbGogyD+CnOFWvPAc+1bi6iym44iK7qtvN16gG2ns5PRuIS0yDY85I4
         G5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758677302; x=1759282102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xNaBmcK1g7tsyculUAXfjKLZdvr7GDVhE7z0HdXPkB8=;
        b=HTbWP2qsibGdVuFz79z93QOjJm1oyRtDEunGMhFaxDK/IOF8o4nHp78Z6+Fvn3yzpA
         rE5FBHUKAhqG/Y/5K+dyCZWGlG1FQDd/2QaJQpVfy2cAf14e8LH6X2dqcolPbDKwN+kH
         j1jSVS4gVlXAsBkBkTtJss7oqb1u2ck11xX2twUuOnqMiHE7h7DJN+/XDfFzJlL8u5xF
         Ib3AHNGa9pmX/scGPO7kYzlrO8k2cQDpMq50r+mBfFJLG9lbFCREoez2JnIMUeQ+tIDp
         Rq2CUnyYHJhH7btVKigPfDFhBQLcd7oNocD1FVlbg+XgJWN76/oTUGSydH5o5Wr6EosQ
         zgnA==
X-Forwarded-Encrypted: i=1; AJvYcCWJOeN/vITGOqpjv8Exoyd5WWcxIRt40Tsm+TqqsuPWXpzUv093gRoHqkAv8g5UG5FVTGxoR5K5DOwJko8C@vger.kernel.org
X-Gm-Message-State: AOJu0YxL0sb65OnfESQiIntE1z+UuGgTNu+FeZha/5G1ZQfyBrNKzEB5
	CluxMJ2wQ/wkR5+S+ZQ2owm0rlJ9zQiw7FCICPxXGx8kz9E0El56WIcl
X-Gm-Gg: ASbGncvE/nImQD4qPmt94y61zSe9bWXlrNl1qFKW6L1lHknG+imNYVCQ4LoWXRLtLYN
	Se48Tf4nu+AyIKrEVvJqLt4KYYBdcb65ZewFe0hUrkX70fnXUGoW/qpT74mQ05YHCsVSH8Jmwpd
	O9+MedM0LJuuWyDGL9bpXtt/APHBtOl+EuHwWDRlNlnSabzzfOD5ahdztDnKOq8ePYYYxy3+DKX
	t2fEWxQH5/9bjnxyH4mCeUT7JXZJmnZwE6DCba2WEpw+/KYiQvr4UyBFbyt8wNH+I9yTR3HA8S+
	6XKBjtU4NoHSh2h+1omfwBiMlnWYoYIE81y/Tqe239XNABB987q9GRSx2RLYpzJlWqfR4RNJcYn
	ezu3+DaYM5sLYwJYqX10pDTelPN/9Q16eYII3DixEk7NsL3z3ZV21Bv9gfIUXVzZ4eCBbq7ShHk
	3kUg==
X-Google-Smtp-Source: AGHT+IEtAt1brf7bOZfywQUNzTcIp9ZaeKJDD5QwEYNs2WxUGFQmKQ2sv8z9OUBVuDDhakBgEvfhEQ==
X-Received: by 2002:a05:6a20:b298:b0:2df:8271:f079 with SMTP id adf61e73a8af0-2df8271fb80mr400111637.10.1758677302521;
        Tue, 23 Sep 2025 18:28:22 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:a860:817b:dcc:3e4a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b55199e08f1sm12644501a12.24.2025.09.23.18.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 18:28:22 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com
Subject: [PATCH] nsfs: reject file handles with invalid inode number
Date: Wed, 24 Sep 2025 06:58:15 +0530
Message-ID: <20250924012815.1096559-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reject nsfs file handles that claim to have inode number 0, as no
legitimate namespace can have inode 0. This prevents a warning in
nsfs_fh_to_dentry() when open_by_handle_at() is called with malformed
file handles.

The issue occurs when userspace provides a file handle with valid
namespace type and ID but claims the namespace has inode number 0.
The namespace lookup succeeds but triggers VFS_WARN_ON_ONCE() when
comparing the real inode number against the impossible claim of 0.

Since inode 0 is reserved in all filesystems and no namespace can
legitimately have inode 0, we can safely reject such handles early
to prevent reaching the consistency check that triggers the warning.

Testing confirmed that other invalid inode numbers (1, 255) do not
trigger the same issue, indicating this is specific to inode 0 rather
than a general problem with incorrect inode numbers.


Reported-by: syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com
Tested-by: syzbot+9eefe09bedd093f156c2@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

---
 fs/nsfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 32cb8c835a2b..42672cec293c 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -469,7 +469,8 @@ static struct dentry *nsfs_fh_to_dentry(struct super_block *sb, struct fid *fh,
 
 	if (fh_len < NSFS_FID_SIZE_U32_VER0)
 		return NULL;
-
+	if (fid->ns_inum == 0)
+		return NULL;
 	/* Check that any trailing bytes are zero. */
 	if ((fh_len > NSFS_FID_SIZE_U32_LATEST) &&
 	    memchr_inv((void *)fid + NSFS_FID_SIZE_U32_LATEST, 0,
-- 
2.43.0


