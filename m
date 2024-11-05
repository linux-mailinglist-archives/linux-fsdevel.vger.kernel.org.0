Return-Path: <linux-fsdevel+bounces-33690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 855849BD46B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 19:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B73A71C21A4A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2024 18:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657741E7C16;
	Tue,  5 Nov 2024 18:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wzta4frQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90541E7647;
	Tue,  5 Nov 2024 18:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730830761; cv=none; b=Ic6v86FIpCO2lWdt9bcComtSn6tVZivIq79dxDF+7MWegTAc7lEcarZg29jAjNlpyYxBSm8iR8q5kRC/8pOaz9NXqMZqli+EY+WOFE2j6T2M8EpZbFlPKxWsommyMXJI2wbyCcpEw+VvLR3F4Qo6rvhgVXPLCmGHMKiV6j8fg/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730830761; c=relaxed/simple;
	bh=KLo/rEHIE6am70Vo9zl892I6Woc0BURA4LAhcckibeU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=utdY3NG2K9a0yJtXEFf90u/Yji33LZg9ZcNG9N1C7cu+hz4m2ZnHlQzXCK3LoSdPmCVLaiOYgRwJxcZAqpeDmjDSuljUUW93Z9U57+m5LFXZATymw7okkSSWhwnnvKfhclHjj7vvujimw+oCIxDqBr7GEzwiwC8f9YrM/n/D3BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wzta4frQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F80C4CECF;
	Tue,  5 Nov 2024 18:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730830760;
	bh=KLo/rEHIE6am70Vo9zl892I6Woc0BURA4LAhcckibeU=;
	h=From:To:Cc:Subject:Date:From;
	b=Wzta4frQAfI+4x29xiW8d95oYiYMxDwzeUtVWVyxDS1oUTnFvakcknjMNjmV59u8x
	 s6w5C7WqSSq5pm152rGl/d+Ns/2NXaRTkrTeFe4kMlW3/ugHTz/Iw9//DMH0TL043G
	 WGWXmMW6T/oRX9lkWkk5VWWNEpssvtmrDa18Re9xeN/uOFm4VPEnrgIhkW2NCuSSTY
	 sWg1NgdhxcjETb4r1O47SzSPTEFSihoziq/5Y5RVOuIjXFN5mHxzZ2Ik/lpoNU3T16
	 ThWrqxS5f8u/XdkUPaRQZHRJsv/njGi9uL6/eE8elHb4k0J3eIRjmO22YfB29R3Qco
	 tf6VjvAeNvy5g==
From: Kees Cook <kees@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Kees Cook <kees@kernel.org>,
	syzbot+03e1af5c332f7e0eb84b@syzkaller.appspotmail.com,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Eric Biederman <ebiederm@xmission.com>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Tycho Andersen <tandersen@netflix.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] exec: NULL out bprm->argv0 when it is an ERR_PTR
Date: Tue,  5 Nov 2024 10:19:11 -0800
Message-Id: <20241105181905.work.462-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1391; i=kees@kernel.org; h=from:subject:message-id; bh=KLo/rEHIE6am70Vo9zl892I6Woc0BURA4LAhcckibeU=; b=owGbwMvMwCVmps19z/KJym7G02pJDOlaifPnGyS82b/muRhXf1nrDL+nbivKFV8oKxtG8T/fs vIHt6hCRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwES4rjL8lV0nvoYlzPJdBW/x 9vUhHHsKS4qPP2dLPv+y+69b4t/7mYwML71dr6nqdhzI+PWgVKKNuSjg68a+13YiemdmpygVVd7 mBAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Attempting to free an ERR_PTR will not work. ;)

    process 'syz-executor210' launched '/dev/fd/3' with NULL argv: empty string added
    kernel BUG at arch/x86/mm/physaddr.c:23!

Set bprm->argv0 to NULL if it fails to get a string from userspace so
that bprm_free() will not try to free an invalid pointer when cleaning up.

Reported-by: syzbot+03e1af5c332f7e0eb84b@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6729d8d1.050a0220.701a.0017.GAE@google.com
Fixes: 7bdc6fc85c9a ("exec: fix up /proc/pid/comm in the execveat(AT_EMPTY_PATH) case")
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 fs/exec.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 79045c1d1608..65448ea609a2 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1522,8 +1522,12 @@ static int bprm_add_fixup_comm(struct linux_binprm *bprm,
 		return 0;
 
 	bprm->argv0 = strndup_user(p, MAX_ARG_STRLEN);
-	if (IS_ERR(bprm->argv0))
-		return PTR_ERR(bprm->argv0);
+	if (IS_ERR(bprm->argv0)) {
+		int rc = PTR_ERR(bprm->argv0);
+
+		bprm->argv0 = NULL;
+		return rc;
+	}
 
 	return 0;
 }
-- 
2.34.1


