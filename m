Return-Path: <linux-fsdevel+bounces-55612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E220B0C93B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 19:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29E7B1AA7DF6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 17:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8180B2E092A;
	Mon, 21 Jul 2025 17:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xf8j1ikU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4173D28469C
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jul 2025 17:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753117838; cv=none; b=WhVq6HWJrgpmi4t7TWQMgtxFbpu/MKHM9T213D3b66SEVsmtdRnrmGvRBeL1fYLDQ90caIVook/LJC7JPd3wjfUpDTlB6HYFoLrIdR00gexgF35sQMuc8k8wPCW+0htGjAKjrv0JSKchf5u2SVcMe4TbWiar5Qtr4wJh0LAXCKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753117838; c=relaxed/simple;
	bh=Xh4LDDhwpUBvyMN0r5+ZGiNOpB9NnQTQv7jcxfOB6vE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dLtx3JappcyqfZ7SUDyhncsWDZwanxeAsj3bVTz2VYyBZrjTa/14qkGvNWUYSaet4qXrUS3q1XH5Nz6+c/i7AvABHtJneTfNhLU3IxOuszpFN9eiP3RBkwePjSGb42Z445oh/nCaThrf6QS+qIFmIB6gD1s6LfTQXZc3JbDFU+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xf8j1ikU; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4561b43de62so4815e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jul 2025 10:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753117835; x=1753722635; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4un8nSFBWo7E3EBvAMYaGlfkVjBQ69T4Q1lbOQwgI8A=;
        b=xf8j1ikU0spxG9p3TK7elw5oCpnxQhAe5ALlOF6/mulkH+K7zy404gqH/fd+lMKS+E
         enEZIL+RMOAW1OFoSS4t2XsJqZ5uYsXss/1JE5s9/CEwycoTtcxaJ1xKxx1INbcD1ok9
         BOru1Ena/TBVkQcug8cbHDnaZ7aX8tgTFHhdGkhXB41AnQ6fkx1qqMWk0qfZmBbFnp3V
         o9EfYRXTPFMCa1nbQ1AIPcQ499WzlH5c7wEtk5x9VjdH+Gr2TFZxRdnTJsKuDXCQWo8z
         wavyKnlOIQuT6FDL5KQR3xPAeJG7mgDNY9J5pt8ZsgJlNvVmTtMBddhO94jcJA+GMYzx
         tNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753117835; x=1753722635;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4un8nSFBWo7E3EBvAMYaGlfkVjBQ69T4Q1lbOQwgI8A=;
        b=dLs7TEzrGgRvIM9hfk0qE0U/7ENZ3DBSJ2JUQ9Tr+ZS7IZtzYC4rKdjjXh6XTf32ju
         onksjdZkoP7Zl4nVOJuz8zrgYRRjMD8G7IW1OPgv3oLjGJHdyTgfBpu6dmvQutD3Smsq
         oSOo5cBwghBsmFcIAN1mtlzlL+u3z8ojoFAmi2i5SdUeyceLD26786cxokjrk0jwh+pW
         sG+9xVQiXRIUoyDCfFN+IU1ljyr5zO+NDR/uiurSDUZtzi+O31m2y5ZKvitxiX2j21DJ
         NDB+WzbHyCSd6gbFClRAxpw145uOr3LwzfUdE/frDUay55tfvjX+N/NfHEfxMtm6QDBH
         0iSA==
X-Forwarded-Encrypted: i=1; AJvYcCXQLxdsGE8JWq0plLAgTQaL6t4Y2JvsghkLT+pjF5F4mhQSqeI4NDF+OuxlMHICVBJ8EabSzcTcbkRo3os3@vger.kernel.org
X-Gm-Message-State: AOJu0YxJZo6SOO7FGzBBhOmu+umBsBW6Aeve/9hCl52Sisel8BlTAz9J
	1VlDyHUe3oQUUIG0RcYrFFDg45qLmBJwnixS0MOx2eG12/xB9x3Lnq93vgxCF2wYTA==
X-Gm-Gg: ASbGncu0IItC9GDi0jPf8YKo1DZ6QEUBPJUl4Z2+b6bpceXdi01YWuOO6xtViDa8W72
	rTAJ/bpq/FJ+aJJq0mdWuRmYqrB+B3sH5IZtv4SvvZ+8Ci6Vs9NH7EgbEgJPg4D/W/pj+ZQjtY2
	ts1kw9q2eVZ4/UiRYzq5YgLrzPGkDk+lWXcvXquqEjLhaL3COCnq9qYsq7EtVn27r+efxRy0Wzk
	btSecLPHQvr4SOQ4gQmyFtZeSQ7S03+XwCuPH5E8Sm9DZv3yEfhPbUSCn6cBxoWpB/yy3Mu1D6s
	GmMtoKt12C4DbX3cQBaZVKMWRadfeql+Hv8xoHQE40MNxUC7O9aTWe0KZ5cVSAWN6gB4WaqbfdI
	DS9uPkopFaParap3Mf3Qr
X-Google-Smtp-Source: AGHT+IEs/FWzsXvd6aAGOTf3DNnp3qevJR4IZXlTTOL1qa+g+sj5fIyKNezQOM6bGxhgPzhVTWJfaA==
X-Received: by 2002:a05:600c:6307:b0:453:672b:5b64 with SMTP id 5b1f17b1804b1-458626f3f63mr184565e9.2.1753117835315;
        Mon, 21 Jul 2025 10:10:35 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:2f39:c3cf:d3aa:5466])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4563b74f78bsm105016005e9.27.2025.07.21.10.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 10:10:34 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Mon, 21 Jul 2025 19:09:55 +0200
Subject: [PATCH] eventpoll: fix sphinx documentation build warning
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-epoll-sphinx-fix-v1-1-b695c92bf009@google.com>
X-B4-Tracking: v=1; b=H4sIAGJ0fmgC/x2MQQqAIBAAvxJ7bkEllfpKdJDackFMFCIQ/550n
 IGZCoUyU4FlqJDp4cJ37CDHAXbv4kXIR2dQQmlhlURKdwhYkuf44skvzlYamozTigz0LGXq+l+
 uW2sfwGKW5WIAAAA=
X-Change-ID: 20250721-epoll-sphinx-fix-9716e46a52e6
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, 
 kernel test robot <lkp@intel.com>, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753117803; l=1514;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=Xh4LDDhwpUBvyMN0r5+ZGiNOpB9NnQTQv7jcxfOB6vE=;
 b=1S8UD7vqp5U9+jw6Djr1PnJec8iMHJ0yaV+ATeTx2X7uvP3B3Pf1P5GEQPqcpqcIchBxI8pop
 NHiY3TZBJvvBlmKJ2gm+9ZM81oACuOwHJr5PVus0a8b5tFbf0h/x1BB
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

Sphinx complains that ep_get_upwards_depth_proc() has a kerneldoc-style
comment without documenting its parameters.
This is an internal function that was not meant to show up in kernel
documentation, so fix the warning by changing the comment to a
non-kerneldoc one.

Fixes: 22bacca48a17 ("epoll: prevent creating circular epoll structures")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/r/20250717173655.10ecdce6@canb.auug.org.au
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507171958.aMcW08Cn-lkp@intel.com/
Signed-off-by: Jann Horn <jannh@google.com>
---
This should go on the vfs misc branch. (Feel free to squash it or not,
idk how you do that in the VFS tree.)
---
 fs/eventpoll.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 44648cc09250..02ac05322b1b 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2192,9 +2192,7 @@ static int ep_loop_check_proc(struct eventpoll *ep, int depth)
 	return result;
 }
 
-/**
- * ep_get_upwards_depth_proc - determine depth of @ep when traversed upwards
- */
+/* ep_get_upwards_depth_proc - determine depth of @ep when traversed upwards */
 static int ep_get_upwards_depth_proc(struct eventpoll *ep, int depth)
 {
 	int result = 0;

---
base-commit: 981569a06f704ac9c4eed249f47426e1be1a5636
change-id: 20250721-epoll-sphinx-fix-9716e46a52e6

-- 
Jann Horn <jannh@google.com>


