Return-Path: <linux-fsdevel+bounces-57074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AADB1E8A9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 14:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22CECA0231E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 12:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D1127AC48;
	Fri,  8 Aug 2025 12:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRoVAXxo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CD027A935;
	Fri,  8 Aug 2025 12:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754657637; cv=none; b=dhCM0jeBSXJlP5B22rg/Kjr0arcxQDaCO/aULlSQ5X9q+1BrSkNCrF03WqrZ3TkvxG9qD0w0TNIMHAtJ90PqEUpTliZeGydfL1jjDS3yQgVmpRQ21MoWfgYdGMaercmG/Plct9Yi3/nexFY6h12inHfjki78ttOnJzYF++887hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754657637; c=relaxed/simple;
	bh=KkGDKiJOUwD7zLKcC5btX1IuhHoswB0EXW0yNh3HBaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jIjoOsYElRyNc2POeKcvFA3PX+eGU3pn63INdb5F9Ksn2tszPYq73NeyRqpaGoSraU2QnZBHotbZJqoi8fFVfnkz05n2lYe16REoiCHxU7BYBHTF5S9hJK+8EIyrMO25+xXc5szyn1BPQSoU+Iz0o/saJft6HdXE7wYh7r7uC5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRoVAXxo; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-7682560a2f2so2273847b3a.1;
        Fri, 08 Aug 2025 05:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754657635; x=1755262435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTWOqUkzFG3Jw/HnlOM4lgmjg34Hd8Pocw1TILgDbGg=;
        b=mRoVAXxohScSq6BPh3Hre0kxwANrIu0/j6rRovKsVqm3Ua7nek1a3sKMUyU7Ry1RpO
         Kn8wIN5CotY7DgMRvJWR9HL5GY0jabEIQDkyFc/g0m7hK3w0EcG+41KV7WRd/mkq5KBU
         dlB6XXqqZX3t2wjmFTYWL3TE+eUoPL3vO3anrZCNNhRrI9ybsbBXKW8oD8PoHzGXnRpW
         qi+XnXYsxlwUIj69IYhgKvXhUhPjEMzVURr1RdU0kbkgFfcIwIBJdRfFrBQJerP3aPTJ
         iXWpxR9JZVZ1URCvqLsBhrsXq7tWYn0HErvytLdZxVyW0wOWclL08rbLE+WnBAAcwz4w
         aKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754657635; x=1755262435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mTWOqUkzFG3Jw/HnlOM4lgmjg34Hd8Pocw1TILgDbGg=;
        b=q5LpEZmXhfT8ftc0pPKt+LPccNOlDp3E54gpSVz3jwl8EEhajj9sks9X6Byi1l06P8
         0zYKdpbGANXopsnx3KqUyZ6BMyjwWe+tEp+/5rnD+TNxzWAfqT5WgD6sM1PsYG8fxBC3
         EL4OuIAOKLTWZWD3ML6M5/D9jK2geteoqik1F4QGvHqQY4K/GZ8KVHZhHp9pIGQm4XnY
         fBYAvmVn0ToAaSIx7tO6Tijulzmq88fjow+01w+7M1LqAcdwbPjVUH318e1F/9XHhs+Z
         WLkWSJz3lk0l5IMwUWWgjXnvZ+4xs+pMW78+wpyYmRVXSAJuffqH1bKZp3jS7P3XJJg6
         xb0w==
X-Forwarded-Encrypted: i=1; AJvYcCUDytnmwjzIxd8v2ettruQyjLCq6fl5w+IsNN6RNaOWBbuv2ehsWvDp0MLIE9sRdvvCZkdsV4dNqHaE2L0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX2P6UShnmg7p+JZ49+AsjBVQeVK2vWa0x/NAoomgHCCtCUayL
	3dYEsOkF3+Ztfk6PXMme6vyz3EVzevHa/OF48knjwm8aaQRkiQOYLrX3
X-Gm-Gg: ASbGncuGegI7aFKhVEMMxYtiLSOit8nzxRYubueNZtP4k54EayVt9uveCi26FEuQibj
	WZ7W+GPmLaR6v+9WLWCqMiFp9EK3m7QIJPqcIfsd+ysYjbfxg2xyw7GLkM15UkgM9qgWqUWFwJc
	UmA8liv8ZAKxkJTcKGquwzQhvYvrR7RaA+a3icJp6IP9LeUeXM2bEA8HYoGG5+yUlrXbl9A2A/n
	JkL/Ze/46zGOI5LHmmtN2NyW1kboF3TnebE+X8tr4Z+xcqP4nF8PlHLxozTVyj0eWe4cRHEdOop
	XxKfAn33gSFjzUSr87JTAKNy2IlBHxuFGaO0bI096svKRJ6kB3Y62ee9ytflHHscAuX63n57IhH
	GDbOsPIFyPWYwog==
X-Google-Smtp-Source: AGHT+IHEu3YnEzqJY/WXYBAGLf2iW78rGpx5r015+HxZuncS7sPK8bFfmj7sVtI8d8rVxFCGTdqmdQ==
X-Received: by 2002:a05:6a21:6d88:b0:240:177:e820 with SMTP id adf61e73a8af0-24055662d71mr4928154637.13.1754657634893;
        Fri, 08 Aug 2025 05:53:54 -0700 (PDT)
Received: from archlinux.lan ([117.185.160.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbd174sm20419107b3a.63.2025.08.08.05.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 05:53:54 -0700 (PDT)
From: Jialin Wang <wjl.linux@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	superman.xpt@gmail.com,
	wjl.linux@gmail.com
Subject: [PATCH v2] proc: proc_maps_open allow proc_mem_open to return NULL
Date: Fri,  8 Aug 2025 20:53:47 +0800
Message-ID: <20250808125347.14775-1-wjl.linux@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250807154606.131d96b133c19baca0c5f2e6@linux-foundation.org>
References: <20250807154606.131d96b133c19baca0c5f2e6@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 65c66047259f ("proc: fix the issue of proc_mem_open returning
NULL") caused proc_maps_open() to return -ESRCH when proc_mem_open()
returns NULL. This breaks legitimate /proc/<pid>/maps access for kernel
threads since kernel threads have NULL mm_struct.

The regression causes perf to fail and exit when profiling a kernel thread:

  # perf record -v -g -p $(pgrep kswapd0)
  ...
  couldn't open /proc/65/task/65/maps

This patch partially reverts the commit to fix it.

Fixes: 65c66047259f ("proc: fix the issue of proc_mem_open returning NULL")
Signed-off-by: Jialin Wang <wjl.linux@gmail.com>
---
Changes in v2 (Thanks to Andrew):
- Add more detailed misbehavior description in commit message

 fs/proc/task_mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 3d6d8a9f13fc..7a7ce26106ac 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -340,8 +340,8 @@ static int proc_maps_open(struct inode *inode, struct file *file,
 
 	priv->inode = inode;
 	priv->mm = proc_mem_open(inode, PTRACE_MODE_READ);
-	if (IS_ERR_OR_NULL(priv->mm)) {
-		int err = priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
+	if (IS_ERR(priv->mm)) {
+		int err = PTR_ERR(priv->mm);
 
 		seq_release_private(inode, file);
 		return err;
-- 
2.50.0


