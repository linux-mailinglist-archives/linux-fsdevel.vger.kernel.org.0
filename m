Return-Path: <linux-fsdevel+bounces-46137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD5EA833E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 00:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65CB619E88BD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 22:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FD5216396;
	Wed,  9 Apr 2025 22:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cgs6yTLv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3B3211474;
	Wed,  9 Apr 2025 22:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744236338; cv=none; b=FD4wBuolOzl5vLJThoaLi+Ti4Czx8cFAcSJM7EOqGeVV8x6UAacd8SICftTejgotL5I+NwfwxyYkgw5gUQOpFqaNaHtjhha4RD43hgdHkGLkDqj+P6VbEFZKgNE5sPsJ4dMXtec3KzZH+rGfUkZ4QkiNdtTD484oFyZnac+EyJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744236338; c=relaxed/simple;
	bh=c3nJ5PqIIqVpEzkrmJTyMYW/nGRLsvXS9KvH8WeGjQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d27FCWpmcp2/Fd+93MRAjDP5ry6UVaNJUV0FZ3IxzJE8Z5ekf0Dk3cBVW+ZJ/ldHJ+MyJYOL31WIG/hOaFjyginwy2rUz6lycxE4daADFmh6aSQrB7UqC5fKeihB6usqzslsmD2HmQV6Xuw9Ukn/v2KhQiBgNmQved5KdgrspI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cgs6yTLv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF6CC4CEE2;
	Wed,  9 Apr 2025 22:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744236337;
	bh=c3nJ5PqIIqVpEzkrmJTyMYW/nGRLsvXS9KvH8WeGjQM=;
	h=From:To:Cc:Subject:Date:From;
	b=Cgs6yTLvlHkBWy3C6oj2TgL/rvNBIW+rPT5dT5ONnjHtPRP9CPj/RZywCbS8On7Fe
	 xLHKXuBVeaaxVjW9gS4BA9y4uO9q2Gnk/a87GphnVLRa5UNihmjBaIdkeioeDCkpaW
	 w02ZxYunvLNE/5WOufXG6KZtizxS2Smb0K8y/BRAAC4KNNdGeJX0havkcqtpIHDh92
	 glltl5hKYYw7uyqm+2axbi0ENp7DEr0CzRmkjwd4hU4cNqarW0kiYWBJ3YZWJMB6ou
	 ZmG1t2fzCu7Dhhi55YrQDrlIUqDoBF2hBhbHKyK5fId0Q2Mp4npayXc3BulncxJ4iE
	 yN6JVoBdJhsMQ==
From: Song Liu <song@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	kernel-team@meta.com,
	Song Liu <song@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH] fs: Fix filename init after recent refactoring
Date: Wed,  9 Apr 2025 15:05:34 -0700
Message-ID: <20250409220534.3635801-1-song@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

getname_flags() should save __user pointer "filename" in filename->uptr.
However, this logic is broken by a recent refactoring. Fix it by passing
__user pointer filename to helper initname().

Fixes: 611851010c74 ("fs: dedup handling of struct filename init and refcounts bumps")
Cc: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: Song Liu <song@kernel.org>
---
 fs/namei.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 360a86ca1f02..8510ff53f12e 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -125,9 +125,9 @@
 
 #define EMBEDDED_NAME_MAX	(PATH_MAX - offsetof(struct filename, iname))
 
-static inline void initname(struct filename *name)
+static inline void initname(struct filename *name, const char __user *uptr)
 {
-	name->uptr = NULL;
+	name->uptr = uptr;
 	name->aname = NULL;
 	atomic_set(&name->refcnt, 1);
 }
@@ -210,7 +210,7 @@ getname_flags(const char __user *filename, int flags)
 			return ERR_PTR(-ENAMETOOLONG);
 		}
 	}
-	initname(result);
+	initname(result, filename);
 	audit_getname(result);
 	return result;
 }
@@ -268,7 +268,7 @@ struct filename *getname_kernel(const char * filename)
 		return ERR_PTR(-ENAMETOOLONG);
 	}
 	memcpy((char *)result->name, filename, len);
-	initname(result);
+	initname(result, NULL);
 	audit_getname(result);
 	return result;
 }
-- 
2.47.1


