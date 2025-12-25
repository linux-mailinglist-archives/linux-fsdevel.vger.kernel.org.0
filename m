Return-Path: <linux-fsdevel+bounces-72086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C112ACDD614
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Dec 2025 07:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C8F230204A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Dec 2025 06:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E382DA758;
	Thu, 25 Dec 2025 06:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvMMpzu8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A612723F42D
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Dec 2025 06:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766644455; cv=none; b=rTPQgBGiyJV6n0CnxYg3fngywAYd4hytN06u3GyG+jeNvjxFCNK9FiSK7C+mKVCbRjXICTKpBsad0WjajTqfN0/SICw/UPn8sQ/0867AFVIG+NDa7xJ5pgJS2e+xh4GAM9M24tDemuRCDFjhA3rC+SJ4St1jKSy0IDeMer5GtlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766644455; c=relaxed/simple;
	bh=pTWub1wm6+YOwgTT62/BfAKG3yOfsN3gpjW71MdZj3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rG7d07GY54iv7W2fwvzeHlJWduvTEvvffwv7C0GDdpYruIiY/Hcd9yvZuIF2Yaa8VA0XucgjQdnED27CiKbicUNBxaA/91pjlleupBJo7VWaXL//Pi6/HlKYi/EnQsdEUFzw3hCrpiXLXHkOqXVLK9Zj0IN0b70w9cxZl1Csoyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvMMpzu8; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a09757004cso82337635ad.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 22:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766644453; x=1767249253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMv12N6Z7QdXIVFJNcbnUr2FQCD/anI5DuLaDa7CSFo=;
        b=HvMMpzu8Y2TMb0LTh2pjqh25x70RKEp3Mqfrkzlxo9HmoUgQyP2EPYj8iFOKN4wglE
         A5WdUN/BwO9ylSHfrsVzTLslU57fWdOzwt6QMvrnqavahFs14shVmk9YAkUzKwWrDddw
         97tg+Z7xN1QpL1kFXCamdAdfl3DlCtBNmtoyxStmX9oAoXcbJHu/cv3MSasg8BPueiDi
         zGhKUjrtaePmkUjsL+jp6Zt2AJMVdn1H4UAAEtYnhCYg4iJB4jjrKQP7U8fpg/hmZeXz
         s1AYQ6YbM1w1vx6jXm8evwrLHsXtAq/uoSSNHXdfkQVWWHcvS/GelO3u8ObLw90jC208
         NizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766644453; x=1767249253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OMv12N6Z7QdXIVFJNcbnUr2FQCD/anI5DuLaDa7CSFo=;
        b=fyvkLJicTP7BNzMtnpErhqTV/toS9tQMyX89rl4e5dNwYNIVCZIA6JzXlfDfc9fi/b
         jqtus8ZGXQtZdDWV7DbqVjDX1k2cFkxZtxzy7a/JTvPknKX7+uxMB59CWOMFtigpP2y9
         lCf4T+ApeMuKBKX+GvDulrfN7tet9xT6ypGucb4JwPyDxTHPAIsfAiKDDrqnoU+ftRGH
         Gv1wfdO89LehNmpDyGbShfL2z8ZPE0VV/8InLevNWPXBOhkRz3K5HCDmzw5IcBhA8ZOD
         xySPR9h261zli77REqrKOyWvJH6Z/NsChmFOEQ++sdd3VeCMrhhoXbXZVN7Ck1OJanGH
         zFUg==
X-Forwarded-Encrypted: i=1; AJvYcCXFb2xa8LQ2P79XjX1ocodsF8K91EPHz01VloVcjY1sI9E7VR7z4AWsfF9YM8ZClonukXCuOMskZEvFNk3C@vger.kernel.org
X-Gm-Message-State: AOJu0YwSCCL9RdkdivMuzuIBy5yk4KII8lWqg8PhsrZrklPkBgANQdGO
	V4LB22iA+FcXuGygp+IHoW4UcDZLmjqT1qB3fQv3b494CTxeozAA+6FOcrNgO/xV
X-Gm-Gg: AY/fxX5pbVyHWWH7bN1thL4XDUYVybh+/8WA37lZF3wf3NHigmR8EA8Eo9dct4r48id
	QznTTDiRBKE299ctR+G8E27dDjSI5AvOxclMYsBTFyYI2nCym7yzOHeAx0fpP4OaCkKyxaXu/tT
	yNq6a9B7KjhVPeK5mzcT496dCngOXNVRc2GhiNZDDcQcX8pWop4J9XkQV4tjHKdOvvwW01o1tyv
	u+d/hFGggjeo1t08kuQHV01Cq2MbhcrBmpPSbOo4vlyLWVgTZOgms/62xc5v/zJqgq+qhQX9ebL
	+wbgbutE0mHPudEiXc6uxmb2ocEuDtFdxrZdZKK//6rocM1CxVV2+RDI4+bM37es2pA/XIeqtz4
	5CYA4TktF5L5WZHGMV6fFEZACgBXjO83j/4kBdbalBYmaE19NoD+fUTEM8QzjMcmMlE4nAb6sHe
	8ThIjPZFmZV1glqKbjU6HJg5XLPxyJ
X-Google-Smtp-Source: AGHT+IFx0tk9ytMvmJKYaOSglMaTl8EMF2q6AFP1CjeCN6tQ8HgdzQxtnWndoHZS4n0yWdBkn8zNew==
X-Received: by 2002:a17:902:e74b:b0:299:e215:f61e with SMTP id d9443c01a7336-2a2f2a34fadmr199291485ad.36.1766644452765;
        Wed, 24 Dec 2025 22:34:12 -0800 (PST)
Received: from localhost.localdomain ([111.125.235.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4cb48sm174073575ad.64.2025.12.24.22.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 22:34:12 -0800 (PST)
From: Prithvi Tambewagh <activprithvi@gmail.com>
To: syzbot+00e61c43eb5e4740438f@syzkaller.appspotmail.com,
	axboe@kernel.dk,
	brauner@kernel.org,
	jack@suse.cz,
	viro@zeniv.linux.org.uk
Cc: io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Prithvi Tambewagh <activprithvi@gmail.com>
Subject: Syzbot test for v2: io_uring: fix filename leak in __io_openat_prep()
Date: Thu, 25 Dec 2025 12:04:02 +0530
Message-Id: <20251225063402.19684-1-activprithvi@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <694bcb49.050a0220.35954c.001a.GAE@google.com>
References: <694bcb49.050a0220.35954c.001a.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git b927546677c876e26eba308550207c2ddf812a43

Signed-off-by: Prithvi Tambewagh <activprithvi@gmail.com>
---
 io_uring/openclose.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/openclose.c b/io_uring/openclose.c
index bfeb91b31bba..15dde9bd6ff6 100644
--- a/io_uring/openclose.c
+++ b/io_uring/openclose.c
@@ -73,13 +73,13 @@ static int __io_openat_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe
 		open->filename = NULL;
 		return ret;
 	}
+	req->flags |= REQ_F_NEED_CLEANUP;
 
 	open->file_slot = READ_ONCE(sqe->file_index);
 	if (open->file_slot && (open->how.flags & O_CLOEXEC))
 		return -EINVAL;
 
 	open->nofile = rlimit(RLIMIT_NOFILE);
-	req->flags |= REQ_F_NEED_CLEANUP;
 	if (io_openat_force_async(open))
 		req->flags |= REQ_F_FORCE_ASYNC;
 	return 0;

base-commit: b927546677c876e26eba308550207c2ddf812a43
-- 
2.34.1


