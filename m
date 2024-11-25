Return-Path: <linux-fsdevel+bounces-35820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD7F9D8797
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 15:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B111E28A50E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 14:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6824E1D1F57;
	Mon, 25 Nov 2024 14:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FA6xDo7y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00921D049D;
	Mon, 25 Nov 2024 14:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543873; cv=none; b=epcgPI1vJimhSmQeXFdx/90Zb/F/yWQdrgx0qYevyYs2awlSv3pfRKvb0qwYpAEQvmOEjx5qvnGXKauFus3kfj2G34dUIK2To7a4emKbbh/+H5twWz8ki34IETW+7cF0XcB2MZ6qfX8eyf+k6Hc63bTOF5SDDp3J4/bjUGE4KbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543873; c=relaxed/simple;
	bh=8xl/acLUl4L0b9zFmJu3StuC3yEGAh718uvyVtl7LjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nPzXCJlythVAXFmwwHUk5tNdPoyCXoLSqIXyP1A8z+3NHmKiKwZ3LKKEWi+TmjieYYPbNg+ec1Ws7wF7uwO+waVfdQo5IdJZWAJrIuZblKEGAW59pT/+X8ni+09B/ZxHBzXnlNX9y4gSd6z8KGSbYqKVYUiBZi4RI0cAAADCu8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FA6xDo7y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35DAC4CED2;
	Mon, 25 Nov 2024 14:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732543873;
	bh=8xl/acLUl4L0b9zFmJu3StuC3yEGAh718uvyVtl7LjQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FA6xDo7ypzfiHi/idoPlzpjcUS2dGA+VjEf34Mh5/2Rmksa2YeUZb0H/SkCiQ5MoM
	 0pIk5lBzfGQ9BTKIqN9bsWhmNKI6AIzSCGiYZI2k6Xlt6N8+2xbf2kD9ikgmqCWpsy
	 IqRjSDIFFdRXe0bj6Jm4YuVfQuqFcfOE1dMfJTwrGOYf2eKkvjuLG9rcXCerjqnbFm
	 YIRTCfe+hw89HPiMhgwYszrn4+mKOURcatcx2d6zz3jTQYMtxKAURxhii3pej8HhHS
	 ceS846ltvISWwhxbnpnW/vidZABwyqJuqRQEXypO74wq0pzZfxSbT9TYZt6eA0Jm7M
	 aOwF4LAEyBDvw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 25 Nov 2024 15:10:19 +0100
Subject: [PATCH v2 23/29] acct: avoid pointless reference count bump
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-work-cred-v2-23-68b9d38bb5b2@kernel.org>
References: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
In-Reply-To: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1076; i=brauner@kernel.org;
 h=from:subject:message-id; bh=8xl/acLUl4L0b9zFmJu3StuC3yEGAh718uvyVtl7LjQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS7tHqdunRRYcvltWufVD1d1hV3VbX96wtL4bfWuRuLI
 9d6WUyO7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjI20RGhjs7f6ReXaV/9sJL
 k9m3U2xfPuK1zH/ecuPUZMZXQnOkRPgZ/umvKLrB8Pll7cHPbfOW86dzbzvHdmfb7GmNPe+emF7
 0z+YDAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

file->f_cred already holds a reference count that is stable during the
operation.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/acct.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/acct.c b/kernel/acct.c
index ea8c94887b5853b10e7a7e632f7b0bc4d52ab10b..179848ad33e978a557ce695a0d6020aa169177c6 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -501,7 +501,7 @@ static void do_acct_process(struct bsd_acct_struct *acct)
 	flim = rlimit(RLIMIT_FSIZE);
 	current->signal->rlim[RLIMIT_FSIZE].rlim_cur = RLIM_INFINITY;
 	/* Perform file operations on behalf of whoever enabled accounting */
-	orig_cred = override_creds(get_new_cred(file->f_cred));
+	orig_cred = override_creds(file->f_cred);
 
 	/*
 	 * First check to see if there is enough free_space to continue
@@ -541,7 +541,7 @@ static void do_acct_process(struct bsd_acct_struct *acct)
 	}
 out:
 	current->signal->rlim[RLIMIT_FSIZE].rlim_cur = flim;
-	put_cred(revert_creds(orig_cred));
+	revert_creds(orig_cred);
 }
 
 /**

-- 
2.45.2


