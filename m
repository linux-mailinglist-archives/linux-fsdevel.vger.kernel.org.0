Return-Path: <linux-fsdevel+bounces-69165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E57C718FD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 01:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 361DA4E2E6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 00:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067E71DE3B7;
	Thu, 20 Nov 2025 00:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RO3UVNiz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B96322A
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 00:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763599103; cv=none; b=t6LnnfqvZfs6BvbTNCELpu5iAAPPYLNDmCzPyPySAtofE5enVn3d6ekomQ7y13VK9Kx24GlySxxjjgWhE+gDgEgeKxUhq+XZ1VN5gpG1EiQOX30kJL3TJl50qcpE7cXWvIBkONeJdEnjZ9tlphNf2iy5BXpQwEpB6G5DkqmiB+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763599103; c=relaxed/simple;
	bh=kUWAYx6zSILh8SSAIikd4TkrHPiAO/7RGiLykZsVOWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sOYgrxAzVvwidoMmGi4DSmOv/aUUygU57I7IldK52WMcoxzWKNFnjw1MsDD+KdGUAqCg5OlKHz57yIeyh/gjGXeXN9hbAJvcL/I72NYozHjWa80yWu5zSrFUJE+gpvijVZMUzkg/DW4+riI8A50LRMJ2nbO/6/xLyN8UP6o3IeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RO3UVNiz; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42b38de7940so136658f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 16:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763599100; x=1764203900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KdAuQPMlMqnLA814W2ruOeTYaPbQYBkcVQoSYWqQY/8=;
        b=RO3UVNizZ0MfaMlC7TbZ+m3+XGPqJX28D7Hq4SOos7vuTQ+Adi7oxRGjf11QDKsFVd
         nyg3sptQ/xB85VlC1cioKk8lcbUsAG42ddOZ52vIgGiZgq84qh2uXVAMNaOZn3bt7MKi
         MnDsgIY+kE/bediXvs35xB9ApIq1OaF1DhA1rGWuWMV1vByrM10njZ1G12Wl+oMrSFxu
         7FDIMNGk7SijhfShVbHklET9976OcJxgjlekoemLI+ch5rR/Gzta96Bui6S1R5Wpomai
         9oH5r99gMABrZOBl41L/AVb12MTtKhj1sj6apB+WaJC3kUyMRXiIkYMscNTkXSesvErh
         FahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763599100; x=1764203900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KdAuQPMlMqnLA814W2ruOeTYaPbQYBkcVQoSYWqQY/8=;
        b=cCaP+Ho3kH9cXiXtj2bJQyKC/WOgqc+v4yWNlvxCEpL3PL0keD0jM3kSwJX38tTB5v
         hCVKOTbItkx9B+Xn8YIyRCJp4SZF0YQ6aP6HwKNlT/Jla4ugS1HaMIY7GFrfUJma7I1s
         wb4Oo8N/k73rkhljwUIZvobyasphshRspvLEJJChlORjaIv8hH8j/nf/oFQab/D57Vkv
         3B5egRbGPhT4rieNm8uABrPBuWHBGx4UUESmvcT0ajX8LT9pxlC1lrBW91iefpg4/aOe
         8Epkbwj6PntKQXZxhTj6VWAKkabrZ1G5vH+gapk8t1ffUWnQyorsoXeI2y2QgyLPSdLC
         hVWw==
X-Forwarded-Encrypted: i=1; AJvYcCUzopD645P+HKcU7zpMF5+h7TZYf94OvUu3zP9UDW3mySdy8GA8XxFdqbReTsdW5UDsIJYeGCz/hWMbqNOp@vger.kernel.org
X-Gm-Message-State: AOJu0YxBDfJFtBcDB/kIMwn3sq7Znr4Dznt7P3GfePRc+esiG2h/WC5Y
	Nke7CW5cxrm4S/HGuiZAj2Y0q+X/hLnsKA0Hz82wxi94quB9RXIqqxpL
X-Gm-Gg: ASbGncueQ1hwK8v7ttkTfF061F6I26Nxo2Lkz7OMID1gKTOe3CBYAC7fRcg6cw6hvKw
	fAFdpecyAs1oRY5N2sim6f+JZ4bjW42HJfj/hqRXtoTkCH6p9vV7cjX/MaaQCTMoh7i+LSwTnVP
	uC0xXwTA8/JPk/60M+gkcvJ6gpD00GEWuQwERKBMzfb57ttnrunRnIIdGLqzPUplwGn1BSMzz3i
	HNUkxoGtgxzxmMniEFCNuXOuDx8iobDRnt3xGqDTZTQaxTH4mey7Ll9z8MaJNgFGktviLvmfrtW
	1i5LuShYr3Fzf2UiEDNzU0FG1Rik61l5KWutwhtEQAUStlDnV8WXV/UvaN/PSRSiMVlB6arCDrr
	IE/L354Alb8Cisi6uN3ZZwRP5yUHSy7YMTzhykVTKGPDcriZNPK9mfKEd5sRMUCQt1qjjA4vKqe
	5DrFn07nNkpWfGE1arR7ZwhfFbibPJ2kUftkwm56DOVlYQU+NZkftn949O55imGdELaFIPhw==
X-Google-Smtp-Source: AGHT+IFAwRjVawIG5s2kzHv/D7vBSiH4VLWTHAmEMoNYwk1EFfoGrLoJLaH9uGe7hX8U9UOUL/mVWg==
X-Received: by 2002:a05:6000:18a6:b0:427:8c85:a4ac with SMTP id ffacd0b85a97d-42cb9a647dfmr547948f8f.47.1763599099823;
        Wed, 19 Nov 2025 16:38:19 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e581sm1902407f8f.8.2025.11.19.16.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 16:38:18 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org,
	viro@zeniv.linux.org.uk
Cc: jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 1/2] fs: tidy up step_into() & friends before inlining
Date: Thu, 20 Nov 2025 01:38:02 +0100
Message-ID: <20251120003803.2979978-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Symlink handling is already marked as unlikely and pushing out some of
it into pick_link() reduces register spillage on entry to step_into()
with gcc 14.2.

The compiler needed additional convincing that handle_mounts() is
unlikely to fail.

At the same time neither clang nor gcc could be convinced to tail-call
into pick_link().

While pick_link() takes an address of stack-based object as an argument
(which definitely prevents the optimization), splitting it into separate
<dentry, mount> tuple did not help. The issue persists even when
compiled without stack protector. As such nothing was done about this
for the time being to not grow the diff.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

v2:
- split out from the original diff
- fixup copy-pasted commentary to tell where the inode in pick_link came
  from

 fs/namei.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 1d1f864ad6ad..8777637ef939 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1672,13 +1672,15 @@ static inline int handle_mounts(struct nameidata *nd, struct dentry *dentry,
 	path->dentry = dentry;
 	if (nd->flags & LOOKUP_RCU) {
 		unsigned int seq = nd->next_seq;
+		if (likely(!d_managed(dentry)))
+			return 0;
 		if (likely(__follow_mount_rcu(nd, path)))
 			return 0;
 		// *path and nd->next_seq might've been clobbered
 		path->mnt = nd->path.mnt;
 		path->dentry = dentry;
 		nd->next_seq = seq;
-		if (!try_to_unlazy_next(nd, dentry))
+		if (unlikely(!try_to_unlazy_next(nd, dentry)))
 			return -ECHILD;
 	}
 	ret = traverse_mounts(path, &jumped, &nd->total_link_count, nd->flags);
@@ -1941,13 +1943,23 @@ static int reserve_stack(struct nameidata *nd, struct path *link)
 
 enum {WALK_TRAILING = 1, WALK_MORE = 2, WALK_NOFOLLOW = 4};
 
-static const char *pick_link(struct nameidata *nd, struct path *link,
+static noinline const char *pick_link(struct nameidata *nd, struct path *link,
 		     struct inode *inode, int flags)
 {
 	struct saved *last;
 	const char *res;
-	int error = reserve_stack(nd, link);
+	int error;
+
+	if (nd->flags & LOOKUP_RCU) {
+		/* make sure that d_is_symlink from step_into() matches the inode */
+		if (read_seqcount_retry(&link->dentry->d_seq, nd->next_seq))
+			return ERR_PTR(-ECHILD);
+	} else {
+		if (link->mnt == nd->path.mnt)
+			mntget(link->mnt);
+	}
 
+	error = reserve_stack(nd, link);
 	if (unlikely(error)) {
 		if (!(nd->flags & LOOKUP_RCU))
 			path_put(link);
@@ -2026,9 +2038,10 @@ static const char *step_into(struct nameidata *nd, int flags,
 {
 	struct path path;
 	struct inode *inode;
-	int err = handle_mounts(nd, dentry, &path);
+	int err;
 
-	if (err < 0)
+	err = handle_mounts(nd, dentry, &path);
+	if (unlikely(err < 0))
 		return ERR_PTR(err);
 	inode = path.dentry->d_inode;
 	if (likely(!d_is_symlink(path.dentry)) ||
@@ -2050,14 +2063,6 @@ static const char *step_into(struct nameidata *nd, int flags,
 		nd->seq = nd->next_seq;
 		return NULL;
 	}
-	if (nd->flags & LOOKUP_RCU) {
-		/* make sure that d_is_symlink above matches inode */
-		if (read_seqcount_retry(&path.dentry->d_seq, nd->next_seq))
-			return ERR_PTR(-ECHILD);
-	} else {
-		if (path.mnt == nd->path.mnt)
-			mntget(path.mnt);
-	}
 	return pick_link(nd, &path, inode, flags);
 }
 
-- 
2.48.1


