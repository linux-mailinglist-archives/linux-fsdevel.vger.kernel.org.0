Return-Path: <linux-fsdevel+bounces-69442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCF4C7B361
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C3B54EBFD8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F273546EB;
	Fri, 21 Nov 2025 18:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnHoQtWp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65E93546FC
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748145; cv=none; b=ZJocOWZE/iDosjz65RJ17gm0f5BYBnIKQ+fsfgcFv4rACIpZIJ4+c9AoK9/9LMnPKxAD5vcJkQP3cxsQefPhznvvi5iz96g3g34ezW5JGnAwcjuualvRmZFB0Mbg7SH7I1fW1xorJGUBGprFxLy2/7wSKh0OPoxf43ZQdZvvZrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748145; c=relaxed/simple;
	bh=ycVYOtw1iBOK4SQPS4QmQKwDwtfDHi89xEqXRsoz+Ys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IoslcVLMje03X6uSzCikcA7LfcRF11zX7NFAQd4oMBXjCAfIj1QDHpEbNBw4uQvFUAm1uNN9M15D2l6GmJDBJifadKVBfYjXNtqYHTpOVZ5t2BvvZE+2ejvLoEPDF61vSCkAcx27GAgYUU+Acme29SNgXzcz6GYyfNo7Y7qtV4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnHoQtWp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB10EC16AAE;
	Fri, 21 Nov 2025 18:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748144;
	bh=ycVYOtw1iBOK4SQPS4QmQKwDwtfDHi89xEqXRsoz+Ys=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WnHoQtWpZ4jBGburliVTtsC3mUhd+O0trAHyL4yA+XUIpyQSIRmAyEqyLP2/eY2oO
	 bAJiXsUHPTkGKk5nR1rU2sdZIsEg2lgyoWGJpgmmqacMVfNG9LLD/IDlkhCDbr01VZ
	 0jA1t7l2HKHR3VXhYmC3hLJ7W7Rr/pGPRIrBVcVhYKdIP9vmNdtTRIulhLajUAGGjJ
	 c0gQbFDExR4Eaa7ks7CfbjltycmRmYONX0VLc+KbaQiHqNemlQyJ9vIFXLW9gmLaM5
	 oDLDo0WoUvh/A6eLgMo56AItCbN4xALFs08bEmQNvW9LuWgNfB1rsyCBU0XhBiUm8q
	 rdKc3bOyvqYPw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:01:23 +0100
Subject: [PATCH RFC v3 44/47] file: convert replace_fd() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-44-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1147; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ycVYOtw1iBOK4SQPS4QmQKwDwtfDHi89xEqXRsoz+Ys=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrLh4932L0eKa8zv+neF3Dy08Pm/rY6MXb0M7dOK3L
 e5ac8bjY0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEps1j+Gdi/c3qKl9sUPqF
 A7VTGpXWagVfTz7rY/pF3yZ28j2rB88Z/kfsdrR5ltT21vLI7TexFf/8Dm7dUTHr/rviO7Ou/1+
 ZW8YIAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/file.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 28743b742e3c..0613ca112baf 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1357,28 +1357,26 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
  */
 int receive_fd(struct file *file, int __user *ufd, unsigned int o_flags)
 {
-	int new_fd;
 	int error;
 
 	error = security_file_receive(file);
 	if (error)
 		return error;
 
-	new_fd = get_unused_fd_flags(o_flags);
-	if (new_fd < 0)
-		return new_fd;
+	FD_PREPARE(fdf, o_flags, file);
+	error = ACQUIRE_ERR(fd_prepare, &fdf);
+	if (error)
+		return error;
+	get_file(file);
 
 	if (ufd) {
-		error = put_user(new_fd, ufd);
-		if (error) {
-			put_unused_fd(new_fd);
+		error = put_user(fd_prepare_fd(fdf), ufd);
+		if (error)
 			return error;
-		}
 	}
 
-	fd_install(new_fd, get_file(file));
-	__receive_sock(file);
-	return new_fd;
+	__receive_sock(fd_prepare_file(fdf));
+	return fd_publish(fdf);
 }
 EXPORT_SYMBOL_GPL(receive_fd);
 

-- 
2.47.3


