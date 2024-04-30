Return-Path: <linux-fsdevel+bounces-18226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7AC8B686D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2ED41F21F01
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AFB10A1D;
	Tue, 30 Apr 2024 03:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yk/spXkM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769E66FB1;
	Tue, 30 Apr 2024 03:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447400; cv=none; b=a/KgBz++atvXSxpy/j9be9QuJ01UOk+OLEqT7OVcg4gRP1sA7ZhmMbdp+ExD9yxiP3y1NALFP5tzE65eVu/yK1L5Y/rIR4mVPtCixlsA3FidkRXLyT0CJNGd7Kl7NL6m/5Q1KwCBv1BS2stOVN3Fvq0iPHmMs5RGPiLmklh5azY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447400; c=relaxed/simple;
	bh=gB0lB1As9r668EW/1cWU3h8zKHM+upDI+fj8Xu0cnus=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kW/yUIy/c/uV/iIqlfvVmQJVKzHBeGc67CKZrdqqlEru7CF+0BjA0v5EckoBrGljmuT6DfjqnkDMxRW4ZGe0yWHySGkS3N/ZxD7MG5g4pHwPAa3KgIq76jaj+hpM4fUOUaXE3IeKPLAwuOeVBA9wfJ5rK5dRayavfLkKmEAkSwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yk/spXkM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08F6C116B1;
	Tue, 30 Apr 2024 03:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447400;
	bh=gB0lB1As9r668EW/1cWU3h8zKHM+upDI+fj8Xu0cnus=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Yk/spXkM8GjDfMrwZfF+fA5pyETmn4uxd0xt65lUvCaj0p+NGV/9vYdFTMPscLScJ
	 3YmTwLOP4ixhYHqgMCQmVkaz+Q1yB9041a8byi28xKEPMOeIvjnOIixstEZE9prqdn
	 JK/Ec0GGTQY5HTJpfejlcWD09jvereeJVhDqqoyyeAnOHALRQAUHtJ1ZUXhT7kyH7U
	 phJKJLCD4/I3Fk7KfrN5aGgSezLTUhF3MvvMclvmI7XEYEd0kBK4V9Vs0AxvYE9JRz
	 dyaOLukvdY5Vl8In+KC9bRnR0DDxa+B9HhB2bbbmA0FA42a+IjszS3iTbsd9EANLfk
	 9pM5nQQNsUQPQ==
Date: Mon, 29 Apr 2024 20:23:19 -0700
Subject: [PATCH 15/18] f2fs: use a per-superblock fsverity workqueue
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, alexl@redhat.com, walters@verbum.org,
 fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org
Message-ID: <171444679842.955480.5756334661180465966.stgit@frogsfrogsfrogs>
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

Switch f2fs to use a per-sb fsverity workqueue instead of a systemwide
workqueue.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/f2fs/super.c |   11 +++++++++++
 1 file changed, 11 insertions(+)


diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a4bc26dfdb1af..06ac11bb2d214 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4423,6 +4423,17 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 #endif
 #ifdef CONFIG_FS_VERITY
 	sb->s_vop = &f2fs_verityops;
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
+		goto free_bio_info;
 #endif
 	sb->s_xattr = f2fs_xattr_handlers;
 	sb->s_export_op = &f2fs_export_ops;


