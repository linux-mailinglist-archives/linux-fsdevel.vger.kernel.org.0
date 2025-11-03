Return-Path: <linux-fsdevel+bounces-66747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC9EC2B69E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 12:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C58B31895DE7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 11:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B3D30CD9E;
	Mon,  3 Nov 2025 11:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDRfwTg0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A85E30C61D;
	Mon,  3 Nov 2025 11:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169269; cv=none; b=FPJQvYOzr11IrePCDJVXRMRS8wVO+eA8vR62ZcEb00zpJiUZtACrsv1yPt6e/tiQfo+/CEqOsyTM7nJSvHFeImBZ4xA3PIVTtL2WsmY/4CqBU+DJ6UtOfBmjA3KTlNneQrtCsciXYLz7Lz9I/8QloTHSzJKEE4+a7dB6JlYvi50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169269; c=relaxed/simple;
	bh=levEAcCe3qHl8KZRvufqmIV0fvjVebO71tbqxGWp4c8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mqonWyxkRRqYQ+hKhGMuRdqIGTagfgQ6+V/QrHsUUE9akNMD3UIg0fCxaxEo5phFXCjZ/lLVUqylgLSlDhENjOaR9u49/fYI4p/mBrGYQESMoYMJ4gFzjzfcEOPrd9HevmZAUqLThMc/OK4UeTS+jp4r6RX+sCcgxBnJGnnMdW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDRfwTg0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E30CC116B1;
	Mon,  3 Nov 2025 11:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762169269;
	bh=levEAcCe3qHl8KZRvufqmIV0fvjVebO71tbqxGWp4c8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LDRfwTg0QjpeDhA96LiFXb2SmOmHJAJ6a9dSzCXfvQqX9nLZUjs+D0oIZPvsD13Cc
	 DC6K459GxA2yHnye+Axchx4DJiiXPzjjzX0+hfnaBz9If5gYv7tBIXbx7+ChxrTMoL
	 eS+yXl4PmkrV50ukt73jIWiKBHPVuVdCOOufeSS+jY7GWhmcnPx/+pqpJT+RU1h/Xl
	 bbMQWziX/brtBe2/isOU1UN5rPdGXSRPfAU+36rZSsnXEhX3gdnqj2NlA9FcZqZEZa
	 GbyQk5XcmL7JqQ2K0EJtLBN04m+wUYPmKmFMRgaRw8gBIKYkRSI3FjwzjbLJpOx2BP
	 UJmL0TJCELZEg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 12:27:02 +0100
Subject: [PATCH 14/16] act: use credential guards in acct_write_process()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-work-creds-guards-simple-v1-14-a3e156839e7f@kernel.org>
References: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
In-Reply-To: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 cgroups@vger.kernel.org, netdev@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=1156; i=brauner@kernel.org;
 h=from:subject:message-id; bh=levEAcCe3qHl8KZRvufqmIV0fvjVebO71tbqxGWp4c8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyTOy4whNlJb48P2yuqN7RhJvSEzzP//y2iuGPXsCzX
 Y79DkUqHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOZeJ/hf8Fepp9pKmwlwSsn
 TzMRt3+Rap1ikW1ZHB53xcU9JfJCJ8Mf7tQYZ9mT/wXrbzy9nL06/M9HjkUTSsPLr+ZxdvjP2jy
 ZEwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use credential guards for scoped credential override with automatic
restoration on scope exit.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/acct.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/acct.c b/kernel/acct.c
index 61630110e29d..c1028f992529 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -520,12 +520,10 @@ static void fill_ac(struct bsd_acct_struct *acct)
 static void acct_write_process(struct bsd_acct_struct *acct)
 {
 	struct file *file = acct->file;
-	const struct cred *cred;
 	acct_t *ac = &acct->ac;
 
 	/* Perform file operations on behalf of whoever enabled accounting */
-	cred = override_creds(file->f_cred);
-
+	with_creds(file->f_cred);
 	/*
 	 * First check to see if there is enough free_space to continue
 	 * the process accounting system. Then get freeze protection. If
@@ -538,8 +536,6 @@ static void acct_write_process(struct bsd_acct_struct *acct)
 		__kernel_write(file, ac, sizeof(acct_t), &pos);
 		file_end_write(file);
 	}
-
-	revert_creds(cred);
 }
 
 static void do_acct_process(struct bsd_acct_struct *acct)

-- 
2.47.3


