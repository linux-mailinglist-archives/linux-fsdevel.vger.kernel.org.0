Return-Path: <linux-fsdevel+bounces-34246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C8E9C4194
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 16:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4EFF1F2226B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 15:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD961A2541;
	Mon, 11 Nov 2024 15:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="St0tImYN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5086E1A0AF1;
	Mon, 11 Nov 2024 15:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731337822; cv=none; b=IpiQBWp05nfSU9lquqPyS391uiHWnhW1RuMFVGxDmfgF406gervzn4tDwR5/fB7SM6pl5n7rlOFl3+7Dma+SdlQXNL5eicKAwQ5By87RBhYz5RWlnGXpcQMWbrK5Bs0UYISDGioXf1zTqt4N1NbManc9iW0qX+eh1YeXoAiM2vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731337822; c=relaxed/simple;
	bh=X9Af+k53SC3pvggsk6PSnlpJHVzsDieYt3NpVr0tWwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L/YS3WZSb5CBL44A37RJkJg1BNiC9YDbYdY6NZ7laaubs1ng6xgm8/sl8PqIqApGRTGbCis1v9sHsZC6YyWv+sksel4dCDoZStMUPbXOiSZpnZlqA74Acn4GZKXDeJrRsRKfmdfwQMEksEU520wUpS8STBhJwOzQK4Dxt+gbVbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=St0tImYN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34AD2C4CED5;
	Mon, 11 Nov 2024 15:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731337821;
	bh=X9Af+k53SC3pvggsk6PSnlpJHVzsDieYt3NpVr0tWwA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=St0tImYNtLAGmFvdFBA5ALrWoHLKF9hTyIplyzGB3tR7/PjUcP1GZQs9IMIwTAInA
	 rYq/jrsp3Hm1bLREVBBzHdtDL3nA7DrAa39r2Sy75GbEVJAL8cFEZVxeO/5KY1RFrk
	 fvVp1trh4NXhwlM61npJrepJW/+sKVVxLA0EeAlwUYdLIIWmSz3sDHTc+BTIs1+1JU
	 qOE6mm2+kN4KoUxipZF7QJXaotjJQok9W5/Fm+PpsNIBp4V6pKdZY2Ax72TgbXPvdv
	 vYIIJsQBbWyCdprfj54hppPVXark7OKIF17hejnlK9VRUtk+xIYcfgv1khvJJPPc53
	 u1rFPZ+ibo/+g==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 11 Nov 2024 10:09:55 -0500
Subject: [PATCH v4 1/3] fs: don't let statmount return empty strings
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-statmount-v4-1-2eaf35d07a80@kernel.org>
References: <20241111-statmount-v4-0-2eaf35d07a80@kernel.org>
In-Reply-To: <20241111-statmount-v4-0-2eaf35d07a80@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Ian Kent <raven@themaw.net>, 
 Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1937; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=X9Af+k53SC3pvggsk6PSnlpJHVzsDieYt3NpVr0tWwA=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnMh5bgI0HS4izak8RGZ4OBcDOOn9z7xZmmT8Hs
 Gn1JqWyH5WJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZzIeWwAKCRAADmhBGVaC
 FUw2D/9Z3AuWcVoFp3Y03tOJUH7+0Ozn6zpDoO/+HnaiqzcRKLxszJHhbcwzSYUGObVthrNykXd
 sREgrNmdOfnOZaC27VAmTjQSuHyCnxNOHM0unqcDnjquyMemWyoqkgbYY0tRYj9extHQLnoMlAn
 QeDl318Rx8wrQG185gHM2uM2K+7C0Q5im+KgE8MvHKYHTXQTzlfy/9QEhwxpBW6SaJfvKQ5vPJD
 wvEFIQiJG6xGlBIcxfA/VCSfvKof61wA1S/A3ZC/n4RA6P3Q77x01VgUZGo6T08FyloTYF1XIgJ
 yAiXY1ixIoDOyOoDbUCK/PFOc02QgRI3XucG4xBhM+5/qk3oFM27r0q59mubfDswY9jO3zLYhnb
 XLGwet2zbNvLiIbpgUNCVq/lIuXVPlgPGjgOqwkp0REfzgnPvxYDZggVjFMbe9P4178JW3M3bFD
 rBzZr3uZzBLFTVObC+jPTof+Ai8I2oUZXr8RBCw6sUgG39GKJ4kmB4ZNFurEd563ON2Nk2RZGyL
 8wfP3lCwZandhSo74DmhvbJEtYns1URUIQhddNXvm4KzmhX8/X2wADLmd4ycvZ/RgWyuemPL152
 PErtA9/EP/cNBUdTuA6MqDMoIeRuIuligjRn2V1zZeYtb70f4AtWo+qzXPpQe+pzCYArXwdAMmW
 X9/dHGiE27RR7uA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

When one of the statmount_string() handlers doesn't emit anything to
seq, the kernel currently sets the corresponding flag and emits an empty
string.

Given that statmount() returns a mask of accessible fields, just leave
the bit unset in this case, and skip any NULL termination. If nothing
was emitted to the seq, then the EOVERFLOW and EAGAIN cases aren't
applicable and the function can just return immediately.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/namespace.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ba77ce1c6788dfe461814b5826fcbb3aab68fad4..28ad153b1fb6f49653c0a85d12da457c4650a87e 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5046,22 +5046,23 @@ static int statmount_string(struct kstatmount *s, u64 flag)
 	size_t kbufsize;
 	struct seq_file *seq = &s->seq;
 	struct statmount *sm = &s->sm;
+	u32 start = seq->count;
 
 	switch (flag) {
 	case STATMOUNT_FS_TYPE:
-		sm->fs_type = seq->count;
+		sm->fs_type = start;
 		ret = statmount_fs_type(s, seq);
 		break;
 	case STATMOUNT_MNT_ROOT:
-		sm->mnt_root = seq->count;
+		sm->mnt_root = start;
 		ret = statmount_mnt_root(s, seq);
 		break;
 	case STATMOUNT_MNT_POINT:
-		sm->mnt_point = seq->count;
+		sm->mnt_point = start;
 		ret = statmount_mnt_point(s, seq);
 		break;
 	case STATMOUNT_MNT_OPTS:
-		sm->mnt_opts = seq->count;
+		sm->mnt_opts = start;
 		ret = statmount_mnt_opts(s, seq);
 		break;
 	default:
@@ -5069,6 +5070,12 @@ static int statmount_string(struct kstatmount *s, u64 flag)
 		return -EINVAL;
 	}
 
+	/*
+	 * If nothing was emitted, return to avoid setting the flag
+	 * and terminating the buffer.
+	 */
+	if (seq->count == start)
+		return ret;
 	if (unlikely(check_add_overflow(sizeof(*sm), seq->count, &kbufsize)))
 		return -EOVERFLOW;
 	if (kbufsize >= s->bufsize)

-- 
2.47.0


