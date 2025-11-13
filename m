Return-Path: <linux-fsdevel+bounces-68383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F33C5A314
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93C564F3C6C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFD8328600;
	Thu, 13 Nov 2025 21:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qeZ5EOSX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D8D328241;
	Thu, 13 Nov 2025 21:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069579; cv=none; b=hmSmjv6+4Rxtk9HYvGPIyOCJx4n7lpKB85PhhG52sbdSY2fKoAm849Q3Su+QyhchDftj2iTdDWHGO9vedFqN4XSS1uy0NfzwrJAxdfrNAEti2CU8RUrvDDeEKZKMAfYIeF2qyYG9PleKm6tWkEvnJzf6yGzqTElt8lW4xUMZ12I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069579; c=relaxed/simple;
	bh=PAHkLqVM+99Pf8HmCRxGZ0wSmCLXrInLV2f528A/yOI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ouFwGsJSkKnji/RCAtvKPMlA6Cw6mD4lLMR0m3S7e07dsLRii+it6CCLTDwnVoshrCTtgPXdl0Q+0wtacR9SafmrfNaPqmoCXPaBqJM7TEG0/To9Que5pGKZjodPy8J353NWLpLLlwZ2RKPIgRXAs+N3U8sBx+tyLhi21Mk759U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qeZ5EOSX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090DEC4CEF5;
	Thu, 13 Nov 2025 21:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763069579;
	bh=PAHkLqVM+99Pf8HmCRxGZ0wSmCLXrInLV2f528A/yOI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qeZ5EOSX723tvCDFboS+/tES5ycV3wv8HJfl2TS6EyLYuqOP7NG1JBl08NvWl6heT
	 IblSP1B5uQ4t9FwdXa2Ln6G1f43ML2Qb8LL+DO3htrXblttS4sl3/DsQ4anmkN1xj5
	 KPXA+GqvRrczea/Mpc6PKZbLL34UiAD6PPWBS60/8hjcG3rEDl5HT1rRqquAfchzmC
	 ybOjSgIAN+GI5rT9rwtdGATXG5RjncdISBQkkq8C8tCnk+oSG1T8gJKXquiFlYRx4b
	 rvtBXEXmuJy6psTQ4xw+omqOQS0g42N/1lv8aK6qQDy+85ZCdE+lBOaBSib7vGIoOn
	 i9WaH495/VSiw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 22:32:10 +0100
Subject: [PATCH v3 27/42] ovl: port ovl_check_empty_dir() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v3-27-b35ec983efc1@kernel.org>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=811; i=brauner@kernel.org;
 h=from:subject:message-id; bh=PAHkLqVM+99Pf8HmCRxGZ0wSmCLXrInLV2f528A/yOI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSK+YVnC3zpKrHnCGpSKe7aL3qHS0j1isqMoGOhHyea5
 3Lt6i/vKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmAjfSob//vNe8bqaCe1pnPoy
 7F7wi6q7m4pbXySfl1dafUhpUdukEkaGSesKHmzyXeKzze82+9KOm39vm9j9STp9esfOmOk8PzZ
 H8QMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/readdir.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index f3bdc080ca85..01d4a70eb395 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -1063,11 +1063,9 @@ int ovl_check_empty_dir(struct dentry *dentry, struct list_head *list)
 	int err;
 	struct ovl_cache_entry *p, *n;
 	struct rb_root root = RB_ROOT;
-	const struct cred *old_cred;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	with_ovl_creds(dentry->d_sb)
 		err = ovl_dir_read_merged(dentry, list, &root);
-	ovl_revert_creds(old_cred);
 	if (err)
 		return err;
 

-- 
2.47.3


