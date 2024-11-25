Return-Path: <linux-fsdevel+bounces-35808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DBA9D882B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 15:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BFAAB32023
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 14:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903A41B6D06;
	Mon, 25 Nov 2024 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZwaE8c5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8191B4F1A;
	Mon, 25 Nov 2024 14:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543847; cv=none; b=lMY8cDPJfqDC1csPUUzAaI+ygA5TAJyoVwrYG3Lnp6pEgHK8APGxjFZvCnIEguPk9phIxi9huh74wQ7cr7JDpJjXpRSXiZZ5SjSqDn3/LiCvUiW3p0toRFe5DHssDaGV5rs/oozppgNmVUam1FZiC8dJuQ2omBhKixLkawri0lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543847; c=relaxed/simple;
	bh=SOhlGmJ+FST7cLV7knRpvEsHg1d/XybMiJ0MpBSZ/Js=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bcxH5vMG4tTlq5Z7ZUl3pdKn5DO6BcLP/Rqy3NI7rthq/NUHRji6y1jujTe57waEJ4V7ZXxqBVWFaBI3zjArWR8vaM0KJlw9V+AoHf5tozsOMQF4UKUV5VaDI2P5K3pLZbh+KVy+9XWX3HXwtJvIpHNxRiE26hF9lw8sYcSZa/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZwaE8c5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E52C4CED2;
	Mon, 25 Nov 2024 14:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732543846;
	bh=SOhlGmJ+FST7cLV7knRpvEsHg1d/XybMiJ0MpBSZ/Js=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PZwaE8c52fA6NmHPVkrRztNJR13dvGbpfLoi66rIbdqlTUqoXi0McF/3o9P6GhlQM
	 8o1iANloU59H3HYBIWSsKA2C6Z0iZN6BNNTxdarYGNkdBR4bt3dfvvgG7Vi2gOz0kh
	 cmwE48UqDj4N8yeU8Aw6gQOfXZLr1Fr4iFjjnMvqb82V1/VqwohYvCVGThdXn1Nc5h
	 F6kJrlVmZ4H7b9Q7Ppl4Ut54P+P0TQshJYLoAFogoIjJ+2NnCUrzkpd2TUQztoMvk1
	 TvDhNtdZVR7uX7DuM6YI267L2hZjTk2fa6BOJpducGMqnL31ctWwVfyjfUFilkB2D5
	 Os+pIf/QjdqUQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 25 Nov 2024 15:10:07 +0100
Subject: [PATCH v2 11/29] binfmt_misc: avoid pointless cred reference count
 bump
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-work-cred-v2-11-68b9d38bb5b2@kernel.org>
References: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
In-Reply-To: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=954; i=brauner@kernel.org;
 h=from:subject:message-id; bh=SOhlGmJ+FST7cLV7knRpvEsHg1d/XybMiJ0MpBSZ/Js=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS7tHruF00+wNhbpLNK2VFHp8L026PoL4+zE8znv5+RH
 3Os+KVrRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERurmRkeHDiDv9zyZ86TSeO
 hsdYLS8QCs77919v0+o7flEC0n/Wz2H4zdaT0dPHsovneOjUPVN6TOfbuDhJKW18EjWN+9E9v+r
 djAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

file->f_cred already holds a reference count that is stable during the
operation.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/binfmt_misc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index 5692c512b740bb8f11d5da89a2e5f388aafebc13..31660d8cc2c610bd42f00f1de7ed6c39618cc5db 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -826,9 +826,9 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 		 * didn't matter much as only a privileged process could open
 		 * the register file.
 		 */
-		old_cred = override_creds(get_new_cred(file->f_cred));
+		old_cred = override_creds(file->f_cred);
 		f = open_exec(e->interpreter);
-		put_cred(revert_creds(old_cred));
+		revert_creds(old_cred);
 		if (IS_ERR(f)) {
 			pr_notice("register: failed to install interpreter file %s\n",
 				 e->interpreter);

-- 
2.45.2


