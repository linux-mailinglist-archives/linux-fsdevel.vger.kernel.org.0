Return-Path: <linux-fsdevel+bounces-22895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EB891E6DB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 19:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA1DC1F2543A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2024 17:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2354B16EC14;
	Mon,  1 Jul 2024 17:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRBHaRTd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8054316EBF7;
	Mon,  1 Jul 2024 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719856093; cv=none; b=F6VdVlBzrYD6R2XqZ8mhFnhda8WJG8PLTEi6tKmkoWQI5P7IknZt7pRo34spfz7xW0WIEMkRkzgnHnukeyRUgOdMbRjQC9uMi4fgM+OV5sfOTFGfLg50Xf5E3h4BIynScQZbXjSUDjcLdW8QkyBGIOxWxG1iGYXvYwmkBIooTXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719856093; c=relaxed/simple;
	bh=vClrN8Cgz91Pyp8b4riGZaG1H0hvRxtBooe+ewQkcqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+cgbsFc6tNr0mLB0JPXj+q0vj7EkkLi4IJE7RGo4rcRZBKcZUOQkU6z7+4r2OIV9bPubrpyeLgQ6Q7BLXwf8copWZZWqItPZ5+4i0MBjIkFLdbEfx0VtkSBQpS05p09aDJSiGlWhWv87CVVtNBe4z552PnAA54Ao15UYazSGtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRBHaRTd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E24C4AF0A;
	Mon,  1 Jul 2024 17:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719856093;
	bh=vClrN8Cgz91Pyp8b4riGZaG1H0hvRxtBooe+ewQkcqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pRBHaRTdyqI4Pp5Y/yc6w73ARTYOtRfRkHODvDLacSQU8DXg5IqqKNeCjQ7n3Xa90
	 DjItfOERvdhm8d/MkL4MSeAMMQcDdOQxm7hm/WOXwcVfHgtqOTPyQBoI6i67kDcfcU
	 J66uRbX6RQkj/pBFD6TczR+Wrq1n7UctUssaf4OkwPZTCkQlYw5zoELi5QhR/UV9DN
	 cSLvU5VKtPLiY9k2sCIOpUS8SgQEujAZK5tNUPNR8+5ArPiTnggUIQK840hF9eiLdP
	 5lZRbPWN2Xya4e8wyFHc9vKc8P/6iB4bMQMonqZ+wLAvsvG6ZbB7ExvCwgWwPEKbIs
	 S7qt8NJMlML9A==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-mm@kvack.org,
	akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	adobriyan@gmail.com,
	Andrii Nakryiko <andrii@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v2 2/2] fs/procfs: improve PROCMAP_QUERY's compat mode handling
Date: Mon,  1 Jul 2024 10:48:05 -0700
Message-ID: <20240701174805.1897344-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701174805.1897344-1-andrii@kernel.org>
References: <20240701174805.1897344-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kernel provides compat_ptr_ioctl() wrapper to sanitize pointers for
32-bit processes on 64-bit host architectures. Given procfs_procmap_ioctl()
always expects pointer argument, this is exactly what we need.

This has any effect only on 32-bit processes on s390 architecture.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 3757be498749 ("fs/procfs: implement efficient VMA querying API for /proc/<pid>/maps")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 fs/proc/task_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 3f1d0d2f78fe..b7bb4d04e962 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -637,7 +637,7 @@ const struct file_operations proc_pid_maps_operations = {
 	.llseek		= seq_lseek,
 	.release	= proc_map_release,
 	.unlocked_ioctl = procfs_procmap_ioctl,
-	.compat_ioctl	= procfs_procmap_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 };
 
 /*
-- 
2.43.0


