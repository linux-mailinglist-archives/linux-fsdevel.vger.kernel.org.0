Return-Path: <linux-fsdevel+bounces-51481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E580AD71EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 15:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72BD517611B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 13:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218E8246774;
	Thu, 12 Jun 2025 13:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHrJX7mu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A3E2459CD
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 13:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734772; cv=none; b=EmEHxNIm6DqAdQw786P9Vvj8sh5Gbt5D+J0co5PvNoL+gAIkQp699qTyJXZKJ/OD+gG52YKx3qkjOXxkrIFtS7xpYt13Bkh16wBvdluYXfhMK3yLxsbZbqViXh3v+X/U95UAF+nZnSdXVBlnnsW0jcMWEldrJvhDNMlqRPelui4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734772; c=relaxed/simple;
	bh=uojrRS3ErQUZ3il9+C3X1w58pwOV5G2r0qb4DAuOnCw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HBaFWyOjF3MMt2Dyjo4XmTPdNSENnj76lSe6tYMF/VKdxZI2aXvJBfKeq6zgNYgIXYSrU6Qk0RaNjmbttbXki2WPJir6KsstCyPuz0OtTbRcw++XfNAlXsspHwuV2vsbd14v9ch8z4oWP6UDr6vdyWWciNYp7WnPqFTgIP+4xmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHrJX7mu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6069FC4CEEA;
	Thu, 12 Jun 2025 13:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749734772;
	bh=uojrRS3ErQUZ3il9+C3X1w58pwOV5G2r0qb4DAuOnCw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vHrJX7muTCxWGREkw5YgmsMgiJr0VGEhCDU6NlS729w1KN8LobEZGTEvmQcgOS7UQ
	 VkG6bt8mO0hunR/KJBMADkTqDLRsD+WCAlyogtv/waixU0rY7WvbwUNLdMi/vba04c
	 21oORyDtc1h/gNhnn9g1jHcm1a53ADG3Fc95Jun5GfnG14Y9ZQFrAAPki+z4nh/wHu
	 fQqHxSo5HU95Jey8cgC3SEqeOO7GEQ39C+EG7QIRWhv0iZ3oKtycTfQe+gqPt1lCg8
	 1blrQkBfDRN6Aw5YilpOpdgiSXxMFGytax0P6PXFYLHaA4f8M6+iJsM039yZZtBur6
	 ryQyEkcW19DDw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 12 Jun 2025 15:25:34 +0200
Subject: [PATCH 20/24] coredump: auto cleanup prepare_creds()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-work-coredump-massage-v1-20-315c0c34ba94@kernel.org>
References: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
In-Reply-To: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=1111; i=brauner@kernel.org;
 h=from:subject:message-id; bh=uojrRS3ErQUZ3il9+C3X1w58pwOV5G2r0qb4DAuOnCw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR4XXVfFTEj9XT/5yKOqH5nJo8DJxMV2h8L7PiT9MTB7
 r1Ciu/1jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImUn2H4zbbuWJjO1zWbQ6QP
 rnUT6d53onhj3fzTnUe6OD/YzTAoZWRkuGocqRZx3nCRNNtijueC7Ztm8PTz2il8C+OtY7q9c9E
 6bgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

which will allow us to simplify the exit path in further patches.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index ba771729f878..0ad0f29a350d 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1074,7 +1074,7 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 	struct mm_struct *mm = current->mm;
 	struct linux_binfmt * binfmt;
 	const struct cred *old_cred;
-	struct cred *cred;
+	struct cred *cred __free(put_cred) = NULL;
 	int retval = 0;
 	size_t *argv __free(kfree) = NULL;
 	int argc = 0;
@@ -1113,7 +1113,7 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 
 	retval = coredump_wait(siginfo->si_signo, &core_state);
 	if (retval < 0)
-		goto fail_creds;
+		return;
 
 	old_cred = override_creds(cred);
 
@@ -1192,8 +1192,6 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 	kfree(cn.corename);
 	coredump_finish(cn.core_dumped);
 	revert_creds(old_cred);
-fail_creds:
-	put_cred(cred);
 	return;
 }
 

-- 
2.47.2


