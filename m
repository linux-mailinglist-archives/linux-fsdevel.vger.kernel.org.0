Return-Path: <linux-fsdevel+bounces-12086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C6885B249
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 06:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44AF1F2509A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 05:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9CA58207;
	Tue, 20 Feb 2024 05:32:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id AC3D357890;
	Tue, 20 Feb 2024 05:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708407160; cv=none; b=eA4sEIMw0I7H9atcux5RFLtULhxhwi6ybgvvtAPLhW2EGpjPZJE1gIWO69Ghs+v+q53l817rcSA2kDMRJ1dk7hXgs3MboDUlendEOEgJ0WkAy/PE5lyLEPWgGL2prChWglT7CD7subwKXBI4Jni4hcK+mozrrcrnp6VmYLoXaT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708407160; c=relaxed/simple;
	bh=/iE2ApkkDcWpaSrqEgjPddcYxT+ULvvlHs/xktTZh0I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=BFHSfeWyP78mEF3UzARhGrHfXWqHwdIi9bzYAiyHRmRGZHp/tlI8WGbepAgvStrW276UOLzcjUoAbPJ9BRbBw4mcEgy/1e7G5HpVjrw402gczNmd6OaMgBafEUAQvsZQJX55VisI/jujSB2aGwaCIhUOz2oE/u61pC9JU4z4jGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id EF737602610ED;
	Tue, 20 Feb 2024 13:32:32 +0800 (CST)
X-MD-Sfrom: kunyu@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: Li kunyu <kunyu@nfschina.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	ebiederm@xmission.com,
	keescook@chromium.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] =?UTF-8?q?exec:=20Remove=20unnecessary=20=E2=80=98NULL?= =?UTF-8?q?=E2=80=99=20values=20from=20mm?=
Date: Tue, 20 Feb 2024 13:32:25 +0800
Message-Id: <20240220053225.63316-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

mm is assigned first, so it does not need to initialize the assignment.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 fs/exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index 10309a93d9c52..64046203bd5ea 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -369,7 +369,7 @@ static bool valid_arg_len(struct linux_binprm *bprm, long len)
 static int bprm_mm_init(struct linux_binprm *bprm)
 {
 	int err;
-	struct mm_struct *mm = NULL;
+	struct mm_struct *mm;
 
 	bprm->mm = mm = mm_alloc();
 	err = -ENOMEM;
-- 
2.18.2


