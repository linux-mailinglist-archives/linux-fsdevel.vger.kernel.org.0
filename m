Return-Path: <linux-fsdevel+bounces-35809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A58209D8783
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 15:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B8302884E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 14:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61921BBBF7;
	Mon, 25 Nov 2024 14:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJQiMV5J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FE21BB6BA;
	Mon, 25 Nov 2024 14:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543849; cv=none; b=YjMn5qFgdk+yopGaah+voJMIW+yauLMyANKJ2Z8vUUpO3eewZrKH9to/zcyLBslG1Jk/UPAPyW244F4Y3q6qzjNRBOc6srTlz/b16zYIXIqU9ECfoA83FcV9RGEucvYbKXPnRRah15iSI3ytUwNnWdgjriRvjYyXuXS7NhNokEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543849; c=relaxed/simple;
	bh=IFLM84NiqCXkwMMafq8E9pIDiDKUxCWKPeY0cpJ2rUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iZEa/GxNtkItM2qRyu+Epa/M3ZU29xzThmfPtO94aT27Pn9ZJGwJrZcQjigz+ePYsdryu9crU/0+bawjgtYft08KZQn0N2DrMLQiRZfxEotsTavMfw5b4clFchQsonMNWfudBDSvq99OWmHUlQWBgzVU8T1JtMeEqwNzZij20Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJQiMV5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4EE0C4CED3;
	Mon, 25 Nov 2024 14:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732543848;
	bh=IFLM84NiqCXkwMMafq8E9pIDiDKUxCWKPeY0cpJ2rUw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UJQiMV5JAOp/zBa2ro19c5jVETBKlkxuYKGDtBvNaK7H9IlEGoz1oKWQmUY8AiAma
	 kh4aLXP5iCnsHEPtmh9tYVQpX/+AdLyrolYOZtlhp0BMsAmmPwS6diOILPAHBo8xCa
	 E0HVWVMWvYfoFrtFlQPJdo2RhtmykHtEJVuxi7/x7wYgVAeGGUGl8jIYquxCCRR/U2
	 Sx7mnI9v0HP7aG3H74gQEnK1NEVSm8Msn5bsDPm8e39OlIt23UFiaq8VkXZJbmqFVH
	 mcIEiCv1JEZOwlUUv67GMnplTXEclCovXk5tTeZpHmdZTZ1RUKbxCO1ZwWlf27pdA4
	 1kHDXMQqXB6RA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 25 Nov 2024 15:10:08 +0100
Subject: [PATCH v2 12/29] coredump: avoid pointless cred reference count
 bump
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-work-cred-v2-12-68b9d38bb5b2@kernel.org>
References: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
In-Reply-To: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=929; i=brauner@kernel.org;
 h=from:subject:message-id; bh=IFLM84NiqCXkwMMafq8E9pIDiDKUxCWKPeY0cpJ2rUw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS7tHr6qhRmdDsHZjjbfeU+sPD0rSxeHumzSkeL207Y+
 Tn5bHvUUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMBHb6YwMp+/UygqFvV0n8848
 t0Y0S4lz9c2avqY55/98dP4XtMXgIsNv9uaZUiJ1zbUZXbq3xDLFb2iGddwqZSl8rSF9QU3qszs
 PAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The creds are allocated via prepare_creds() which has already taken a
reference.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 0d3a65cac546db6710eb1337b0a9c4ec0ffff679..d48edb37bc35c0896d97a2f6a6cc259d8812f936 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -576,7 +576,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 	if (retval < 0)
 		goto fail_creds;
 
-	old_cred = override_creds(get_new_cred(cred));
+	old_cred = override_creds(cred);
 
 	ispipe = format_corename(&cn, &cprm, &argv, &argc);
 
@@ -781,7 +781,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 	kfree(argv);
 	kfree(cn.corename);
 	coredump_finish(core_dumped);
-	put_cred(revert_creds(old_cred));
+	revert_creds(old_cred);
 fail_creds:
 	put_cred(cred);
 fail:

-- 
2.45.2


