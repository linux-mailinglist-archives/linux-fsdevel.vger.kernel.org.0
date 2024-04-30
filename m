Return-Path: <linux-fsdevel+bounces-18225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2078B686B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BDF31C20B48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2573210A1E;
	Tue, 30 Apr 2024 03:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMR63tNo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837421094E;
	Tue, 30 Apr 2024 03:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447384; cv=none; b=r6AGMENmXM43hNRcjSjOXvDXPAUqdyMugVoQctrtmlm6OtXLeqW44ETuWgGiPkWQtCoKISk3W227DbrGbMAFOz/4bBeOgkw2dID3sGYIFADzfEz+tiwb01Z94FfpnRrpswS+ElyN/GLSUC2Ea86cqAwI/0m3jIHhSuK82nSeA4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447384; c=relaxed/simple;
	bh=K8sHhpDUwKmrUEmhT9e1eV+3etNK0FZ/8ZhhOojr7hY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cIv7h105KXCJQh+07PSM9NUDH8yyCTaHGGPSGuuJ4UmuvyjDg1J/zyZKg8akuGiAnxVFC2RbKPPPybWVFf9VCkaDZVIRHM5l6AZbK+dVt8My3wCdT/w/uG26KQ7p3EzXpULECJMTLmWlFpv5tWuVxE58YfPHJq+pJOulbQr/14U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMR63tNo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5984EC116B1;
	Tue, 30 Apr 2024 03:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447384;
	bh=K8sHhpDUwKmrUEmhT9e1eV+3etNK0FZ/8ZhhOojr7hY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=mMR63tNoees33mtE95JmwZxDwUVmsodHn+Ca03exQuOEP26T2Ly9mxamy+pPzefhl
	 ugodiSi6BiOgnHYtTf/M0C7Nogzi1atRcQpq+z6wvETRQZip0EpOFX+VVxkgLHj5Ed
	 qI29nqx66+SRfQOY6JGKI4xg/camzjdiRBcf0kc+0CEAzjrPPD0pIL8nKNQ9haNyRu
	 cEC9k2w86/kKPAMO2zkdPRtRZfWNRAkn2+aBFJjFsU/PUXa8oqQROazKkBPmsZW8oj
	 D3GtE9ePWAY4vDcEFOgr0NU8bQiSY9nqOcwCkM2NangMAIXtY6o6F5i7yz63CW4F3h
	 6CdlIX8gSVNbg==
Date: Mon, 29 Apr 2024 20:23:03 -0700
Subject: [PATCH 14/18] ext4: use a per-superblock fsverity workqueue
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
 fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <171444679826.955480.9268289580826919477.stgit@frogsfrogsfrogs>
In-Reply-To: <171444679542.955480.18087310571597618350.stgit@frogsfrogsfrogs>
References: <171444679542.955480.18087310571597618350.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Switch ext4 to use a per-sb fsverity workqueue instead of a systemwide
workqueue.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/ext4/super.c |   11 +++++++++++
 1 file changed, 11 insertions(+)


diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 044135796f2b6..d54c74c222999 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5332,6 +5332,17 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 #endif
 #ifdef CONFIG_FS_VERITY
 	sb->s_vop = &ext4_verityops;
+	/*
+	 * Use a high-priority workqueue to prioritize verification work, which
+	 * blocks reads from completing, over regular application tasks.
+	 *
+	 * For performance reasons, don't use an unbound workqueue.  Using an
+	 * unbound workqueue for crypto operations causes excessive scheduler
+	 * latency on ARM64.
+	 */
+	err = fsverity_init_wq(sb, WQ_HIGHPRI, num_online_cpus());
+	if (err)
+		goto failed_mount3a;
 #endif
 #ifdef CONFIG_QUOTA
 	sb->dq_op = &ext4_quota_operations;


