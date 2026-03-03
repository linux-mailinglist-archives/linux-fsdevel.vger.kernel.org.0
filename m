Return-Path: <linux-fsdevel+bounces-79229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIPBCTnopmlWZgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 14:55:05 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B2D1F0D0B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 14:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 95C3A306F1D4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 13:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9CE36309A;
	Tue,  3 Mar 2026 13:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8aY9l3/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D44635F195;
	Tue,  3 Mar 2026 13:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772545783; cv=none; b=XBalG5WJNCnI2mBYfwvd+md0WRVtY8HgZEr2l3ZdjuzJLhzfhM0D5xewarkD/Kc4sTwb7LE0s+5ob49a9cT+sYkz2WvdcWtcomsnXjkVAfnP3bilt6iy2xfsMqZEuCM4WP8lSHmh0MPcLIYhRBIYMvyb5/LsnInp28lvFp7bJJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772545783; c=relaxed/simple;
	bh=aEnsbJuZOrSqcCTr8229rBmTXM8YIUu3ak8cRkJ0pSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jZTqyDQRgRT6CvdKtxerYno5Zhjl5dByuHa07SvuBXxkHwfBmFZwUgl4Xk1V2nADP4t5xYGzAJOSiZv41RpzeVJ1GZI4rAO+Sf0G4A8vVgvVpzUSy58mj7h/oATMOHo9XNZrtmTWjPgQSYDUeobZY1GUKYg3pU2m5IRuE4CzKM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8aY9l3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D995C2BC9E;
	Tue,  3 Mar 2026 13:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772545782;
	bh=aEnsbJuZOrSqcCTr8229rBmTXM8YIUu3ak8cRkJ0pSc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=I8aY9l3/gA3hzodBHVs87JDsbQrbtwLWlTvyBut6R7Myzgi1dlQJvrnXCqT/6Rf+9
	 yygr8CLRQCzjlMwBgBHIIzDtlg2n2FAQyhmh11xhekYAntgY/X4bVzN/8o0+iOYuvb
	 GUWsyOB3V5hWJG3Rg65q0kPCPAVv6jmee4lqtmwAuWAmGDyAPmsXGkxzN3u412T2U/
	 S54c2h34nYuJCfAvMVfZPyr4F/WslC4y1ZgjtNncEyT814VhLmv3insDjTuvn0+yZq
	 nkdiqRIwug5dwS1vjkgUN771TI7zWtFfto1GTI4OwHruxQkb4u3LrUD37HVeY+Hqon
	 /jFW/a+LaTVWA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 03 Mar 2026 14:49:20 +0100
Subject: [PATCH RFC DRAFT POC 09/11] fs: add init_root()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-work-kthread-nullfs-v1-9-87e559b94375@kernel.org>
References: <20260303-work-kthread-nullfs-v1-0-87e559b94375@kernel.org>
In-Reply-To: <20260303-work-kthread-nullfs-v1-0-87e559b94375@kernel.org>
To: linux-fsdevel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1060; i=brauner@kernel.org;
 h=from:subject:message-id; bh=aEnsbJuZOrSqcCTr8229rBmTXM8YIUu3ak8cRkJ0pSc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQue3ZvS8EGAbtlT620lkzMNGne6Bc9S2ah3YGGyrc/D
 XYV7Pct6ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIsWhGhl7T7LSURj2XGm91
 7vM3DDisTy1v5upf3Syzxytzb0C9CcP/6o9/ZSRe/40828y1xGXO7JdvOoxfr+iP1fG5lbSd/ft
 jNgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Queue-Id: 07B2D1F0D0B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79229-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add a init_root() helper that allows to grab init's current filesystem
root. This can be used by callers to perform tasks relative to init's
current filesystem root.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fs_struct.c            | 6 ++++++
 include/linux/fs_struct.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/fs/fs_struct.c b/fs/fs_struct.c
index ab6826d7a6a9..64b5840131cb 100644
--- a/fs/fs_struct.c
+++ b/fs/fs_struct.c
@@ -196,3 +196,9 @@ struct fs_struct init_fs = {
 	.seq		= __SEQLOCK_UNLOCKED(init_fs.seq),
 	.umask		= 0022,
 };
+
+void init_root(struct path *root)
+{
+	get_fs_root(&init_fs, root);
+}
+EXPORT_SYMBOL_GPL(init_root);
diff --git a/include/linux/fs_struct.h b/include/linux/fs_struct.h
index ade459383f92..8ff1acd8389d 100644
--- a/include/linux/fs_struct.h
+++ b/include/linux/fs_struct.h
@@ -49,4 +49,6 @@ static inline int current_umask(void)
 	return current->fs->umask;
 }
 
+void init_root(struct path *root);
+
 #endif /* _LINUX_FS_STRUCT_H */

-- 
2.47.3


