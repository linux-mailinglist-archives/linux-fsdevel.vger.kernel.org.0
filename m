Return-Path: <linux-fsdevel+bounces-31463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36551997196
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 18:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6B5528450E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 16:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B321E4123;
	Wed,  9 Oct 2024 16:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSMJf5Yv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2E51E285C;
	Wed,  9 Oct 2024 16:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728491200; cv=none; b=BPqUZXvqnGbIxRw4PS0NDECK+8fYdKObCk6IrN/b6RyZzPok0fvdKKtrw2ifoZMEExw9r9XdVCNQhSw0DUWtvcLcuPXQZTgQMylGOfCgNQml0ZDNVaRl9FsW3S/NUe33qfahLv3qJljXAvRWIIdcokb6DB1UH3+NA7QbpXrZdJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728491200; c=relaxed/simple;
	bh=UYuDl25axeC8L+3RX7L0LERIgnmmg03ITxZL5PJpNdI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NPakbFPTmB7TjCdwotUgF/Z8dwHAKwZInj/QjBwXygBRSQ11Qe/2iZepuhrjjSrGEvqMgyG6+s05GuZ8XV4UwJ2pfW/N0frtYWlk+pPnvQfvAfi0h8VSaSa02bU7gRqh4Upgtz/7Um31vl6c+8EuRfpi1L6XRwH3QP1i6VIU9BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSMJf5Yv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5440EC4CEC3;
	Wed,  9 Oct 2024 16:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728491199;
	bh=UYuDl25axeC8L+3RX7L0LERIgnmmg03ITxZL5PJpNdI=;
	h=From:Date:Subject:To:Cc:From;
	b=nSMJf5YvzT+QslzGw0M0kAAyMWl/wZbwnY5A3F6w5VGm7+wEL/bojhf/xbzh3yVFT
	 JUgYXQ7il8/yAdrYv3hdvhEcYQxl3WSJ8UZOUOGvziadon0ygS3cvNXBNa3Wruckr6
	 rJJaaAWEBSOygP+C/ZiueeKEWbKQ3ZkLIKVW2ExMlS8agZnDgEpynkLQg8D0V01PGh
	 IDACbTDQ+lsxwbps3nvuDdt11BYrEsl8Tp4VLyzhYIxUts9+K6oW6PoPQbWwZ9XxeL
	 4JD4E/PaqO1qeSSJpA1gfothg0+8aB3TF/1MHEQSOvhED8e3TOQkOGvnTtQP/XHr1z
	 /5R5Mr7Z7+P7w==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 09 Oct 2024 12:26:32 -0400
Subject: [PATCH] fs: grab current_time() in setattr_copy_mgtime() when
 ATTR_CTIME is unset
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-mgtime-v1-1-383b9e0481b5@kernel.org>
X-B4-Tracking: v=1; b=H4sIALeuBmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDAwNL3dz0kszcVN00M3MjC1OjFDPz5GQloOKCotS0zAqwQdGxtbUAZRh
 fJ1gAAAA=
X-Change-ID: 20241009-mgtime-f672852d67cc
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1233; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=UYuDl25axeC8L+3RX7L0LERIgnmmg03ITxZL5PJpNdI=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnBq674ZX0VDNVAHHinEwqEy+bXkux6MUEqvVc8
 qiUOc/Y1mCJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZwauuwAKCRAADmhBGVaC
 FZ5ID/48wlcjnfOuNSI/y3uSIxj1XoYmkGFYi43I+XRSK1Su0az1/RVXZP1vrEqJxZpgx4xtn/0
 4nCKW9puENWee3+6pa+RYt9hQCHx+eFPE0I/Y2RwoEWABLiZfM+EpJxR9oOE/4zsOiH9bcXnkrZ
 y2LC2txksmU5/emKm0Gj4WYFVe5Ba8n2x3KIdFWRI7CVlluoWgPrbfDU8Ll8Gnau75n9rlEpQsM
 hR6Z9lpvr7/hG0GGwcE6gVYjR6m2IBwPRMY3o0PIhP/njzwyCVvOwp4JGVKSiJfTB19Nrgu/1RA
 mffej752kxEzgYXLqZgWGxOVyJVU4yc4P8jEs6I6EgISNte19yLme9w+Q0ffpKLeBrDmICv2BHY
 KLajW9J9Rc1nzAEkzM5MayffuW0+6eCnI2szYi/L4wCQy0yL3DgMughuojNp+k6V0bgbYQq0CkF
 zg5tA1RHfzsqPSgZJDYccgBNXTxQE7lHVLIcU5WFwpy0e5d4D9IqHxcYpsKseDcncBopS6rl4Eu
 XJPmlhTqu8f0jvCoQ2vRXUHpvMKBCqq9VVg2cFN4XJ2yXB8zFaD0lt/KmmCWDvNtScn5PWBWfON
 xKj4vfO0xpgbBdA06uS1WcZAe6KQK++Cg/q4Yp1SBFcKGRdHaaf32xjPnAN0QjUh3RD4g1n9a4A
 S+jzvPiMnyBglCA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

With support of delegated timestamps, nfsd can issue a setattr that sets
the atime, but not the ctime. Ensure that when the ctime isn't set that
"now" is set to the current coarse-grained time.

Reported-by: Jan Kara <jack@suse.cz>
Closes: https://lore.kernel.org/linux-fsdevel/20241009153022.5uyp6aku2kcfeexp@quack3/
Fixes: d8d11298e8a1 ("fs: handle delegated timestamps in setattr_copy_mgtime")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
A fix for bug that Jan reported. Christian, it may be best to fold this
into d8d11298e8a1.
---
 fs/attr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/attr.c b/fs/attr.c
index c614b954bda5244cc20ee82a98a8e68845f23bd7..9caf63d20d03e86c535e9c8c91d49c2a34d34b7a 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -298,6 +298,7 @@ static void setattr_copy_mgtime(struct inode *inode, const struct iattr *attr)
 	} else {
 		/* If ATTR_CTIME isn't set, then ATTR_MTIME shouldn't be either. */
 		WARN_ON_ONCE(ia_valid & ATTR_MTIME);
+		now = current_time(inode);
 	}
 
 	if (ia_valid & ATTR_ATIME_SET)

---
base-commit: 109aff7a3b294d9dc0f49d33fc6746e8d27e46f6
change-id: 20241009-mgtime-f672852d67cc

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


