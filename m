Return-Path: <linux-fsdevel+bounces-66810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 857ECC2CA53
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 16:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D40E4F8798
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 15:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70E132E75F;
	Mon,  3 Nov 2025 14:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3jenSgj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333BA32D0EA;
	Mon,  3 Nov 2025 14:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181886; cv=none; b=JUDvznTeuuB+urJtMv6Ewnf494/JvAwx6DsQ1fMY+UWUMycpgjpWbjLNScTcjDxLQhJ6e+0JzCg5mQscZStEXflCXzvQ5gf9c/yb310+pcFiL8wfb9Px+CfzZ+7qaPxOwcNL8LgJkFqGWY5eg56c3jt1bh0KYjb1tgfQcNrWVos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181886; c=relaxed/simple;
	bh=pg2v4Qq4p691A716jLKgU9cR9rJWdfU2QnrT9iAtdLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aKL7VmjfqrYnITsbsaysrEcQIG3Z9Lp1JR0scetRMHuXMnwu2AtaVOzxCaJNwZe/ua7LRH+KugevcbnLbM1UHNNizx7nDiutL2ngw/ZKLAQTkcOKd4erOpZVcG6IUpAxD4qHP952sto56kOVYqAx/+NudHd2Yv0fxSdQl83Ks+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3jenSgj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2085C19421;
	Mon,  3 Nov 2025 14:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762181885;
	bh=pg2v4Qq4p691A716jLKgU9cR9rJWdfU2QnrT9iAtdLo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=k3jenSgjz87qIYdLxKG5JJW4vxX0/TPxC6CFwTvlx7Tl7n9xE4mlIADEP/AxPoF0k
	 3tHWsJQRfZReyP4rQ+YQZMb3IGYp9s5/GvKHpgXYopc4D7vWRzqJErSHWqp0ROj2Xq
	 ++uF8hSneX2nYhaqRzlD1Ez+xBkz53yTGWIFTOdebt+I7k7+6dn5upLZYqDAldx3pP
	 42Rcni/Xnt5jNXU6QaOy43bHgEsAZAKt2MVBNKePKZi45IFqA9Dwd+KyCcYbW3uXw1
	 hcERYhyvMRY4w7zbRD1Mtuv+R1mzlr01Py/eUnVUwoTd2mK6Pwh9MKVd1ATi12wQyZ
	 VgLHGxzPN5PMw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 15:57:31 +0100
Subject: [PATCH 05/12] coredump: move revert_cred() before
 coredump_cleanup()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-work-creds-guards-prepare_creds-v1-5-b447b82f2c9b@kernel.org>
References: <20251103-work-creds-guards-prepare_creds-v1-0-b447b82f2c9b@kernel.org>
In-Reply-To: <20251103-work-creds-guards-prepare_creds-v1-0-b447b82f2c9b@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 cgroups@vger.kernel.org, netdev@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=611; i=brauner@kernel.org;
 h=from:subject:message-id; bh=pg2v4Qq4p691A716jLKgU9cR9rJWdfU2QnrT9iAtdLo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyHHqZ6D57643ky/+/Hb66KPGd3u+ty2sqxY7dP8x1W
 VGzSaXyeUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE3AIZGd7od/1OWLjnxvcJ
 QtuE5zwRbfra+q7KjcFz9rPzNt/mP8xm+O+68mRGc8RuhsSMUs9/pps+397laOW5KMdl6vUvk+b
 9SGYEAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

There's no need to pin the credentials across the coredump_cleanup()
call. Nothing in there depends on elevated credentials.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 5c1c381ee380..4fce2a2f279c 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1197,8 +1197,8 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 	}
 
 close_fail:
-	coredump_cleanup(&cn, &cprm);
 	revert_creds(old_cred);
+	coredump_cleanup(&cn, &cprm);
 	return;
 }
 

-- 
2.47.3


