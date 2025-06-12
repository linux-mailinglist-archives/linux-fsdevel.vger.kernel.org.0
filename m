Return-Path: <linux-fsdevel+bounces-51479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7625AD71E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 15:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E065165DA2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 13:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A906225B30A;
	Thu, 12 Jun 2025 13:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4OaHoAX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B32123E353
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 13:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734768; cv=none; b=qz45EAhdhsa7pZfwjVIN44Htm9EmP+NjpgzDpDiHNggzh18nIW5AD5QMKSkq79Lg0GSMnLO8CSNOil06ZkP7oZpKsCPKhfm0L6HeRjlZwQedfgnzhuYjFDej6eTkhe+DVkOeR5fL7ZUSgBgEedJGRV+wQfW44oHIZoV9QclbDKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734768; c=relaxed/simple;
	bh=omTE8wnVFmGckS7IdJfWl5N4Qi8kLSwJBxEYJOHe0rY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ulmrP/9rjKSOdAYX1UqLWD81Likm4v7jpfNp1xQnb9YXiYiJaed9z2z180FUh9uAFYNDlRDcIiSxTUBc+ou3frPwowz5nkw4Y4rzTfCdnB9lTnQpzHA/pN1ob3Y/UGSrtFx/7T56gP7YOHjHTNGpVEfgYF4aGPajDmMdMbKNQDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4OaHoAX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6D5C4CEEA;
	Thu, 12 Jun 2025 13:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749734767;
	bh=omTE8wnVFmGckS7IdJfWl5N4Qi8kLSwJBxEYJOHe0rY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L4OaHoAX1HqDJ7jqo9aBbKB8Pvr5R8serE+Q94XkdPUcuUzI/8BfPzBN3vLm4Sx6b
	 v3xszySEQMKtS2GK0WE4ZioVXK19o1fv25hcZVDI0D/k1lqgaR0hMTm9/0OgxD22fa
	 umZRJIDBqAp6d2Gm9RMvn0+frj37zsiUDRijwm0935ZD7atVynehe2jsKgi0TU3w03
	 tznWiIDaeh39BOC1dPhWl5sV03rasah6ooWt6DbzR/MU/sXFpOCcXdxEvgc8wl39W+
	 A7ikI1OeNH9g8/3ekgWaQ8C+0gt31OjBO6RzZXVURCljWn15co0AmRgtr1l9Y4BtWa
	 etr6ZzDQbldjw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 12 Jun 2025 15:25:32 +0200
Subject: [PATCH 18/24] coredump: directly return
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-work-coredump-massage-v1-18-315c0c34ba94@kernel.org>
References: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
In-Reply-To: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=941; i=brauner@kernel.org;
 h=from:subject:message-id; bh=omTE8wnVFmGckS7IdJfWl5N4Qi8kLSwJBxEYJOHe0rY=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGhK1Ueh4NzhTLkjO34jPjjL1ZTle/1GhiPU9d9XveIlAsGMU
 Yh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmhK1UcACgkQkcYbwGV43KKylgEAjGPP
 5YD1fNYkDo93gChuSWKSsN8WfvUqNHrYVHggkjIA/0N3zI7Tpf72P29fz9Ol9qy1r39N4DprgrA
 DdfC0tuUB
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

instead of jumping to a pointless cleanup label.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index f8d5add84677..ba771729f878 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1095,13 +1095,13 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 
 	binfmt = mm->binfmt;
 	if (!binfmt || !binfmt->core_dump)
-		goto fail;
+		return;
 	if (!__get_dumpable(cprm.mm_flags))
-		goto fail;
+		return;
 
 	cred = prepare_creds();
 	if (!cred)
-		goto fail;
+		return;
 	/*
 	 * We cannot trust fsuid as being the "true" uid of the process
 	 * nor do we know its entire history. We only know it was tainted
@@ -1194,7 +1194,6 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 	revert_creds(old_cred);
 fail_creds:
 	put_cred(cred);
-fail:
 	return;
 }
 

-- 
2.47.2


