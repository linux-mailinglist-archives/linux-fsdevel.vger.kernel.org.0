Return-Path: <linux-fsdevel+bounces-60088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37632B413F0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D545A1BA148B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EE22D9EE1;
	Wed,  3 Sep 2025 04:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="lyuUcIf/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F662D876F
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875349; cv=none; b=bNCCFJQ8vVuio0bTZz/c24CliDhv82fGAFKzMkUVdjM1buwQKDQV+gAznJj1+2uczjki6OJ3fZgJA6ThtdYdWfRcaLLRPlr6gNaq75hIvCS3TZo1xVtaJUJQqDEyVRpHDn6fL+Riyw+sHgXV+O1o0kCxQE/rEGumK78PeibqiR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875349; c=relaxed/simple;
	bh=kxCVQn6mTB0kRnGPlvZT4TOOG3gCcgLMewhJ8XkRJyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3SMqiFKSfkOKM15nKZrVx9s+T0kGGOZTgaTqES+2TII96BQdRcXiiSDBXaSn7zIcTOwZkJa9FelXDM8bJwbHa1BPRQUUsB06B8Nlw6jSfZTva12JtX2W3uAvd3sdq4wvOyoyRGO37Em6XspifZV2zbNa2gfgckK71prZkPeExA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=lyuUcIf/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=N2nzFgpyxkcPrEM5Ouc448XkMF9E5Pw89qAeq0TKdss=; b=lyuUcIf/SlKBxLWqxHLkg+Iwsq
	UUS4rvw4OFLaYWLYe7v++gGsR5z0j/vCPGPMCyBzLtP+ieueToXJt+72j3pfFTiqA9v1xEf/ePm9D
	fu9S8TW/yhoTa1FW9bpYEhNGsWHeJjHnPGk8sGxmxumJYPFS17uHboH/mLgtAaSm+0jOX0QTKUAAg
	nVCp55TFcIxT4CazADsh8gPWU31apt0FHTm/PjPI0WidwTMbzDQ1+pQBxxBfTrSyAQnTSKFCM+KEX
	xF65teyH8dZD33s7UroX7BgMsra0jHm2n5GwPJ8aGS4O56W7BGEB5k75+E1/c4/mHjyN4vM6+T+5l
	XlMh4VQQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX8-0000000ApDn-0oGV;
	Wed, 03 Sep 2025 04:55:46 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 46/65] may_copy_tree(), __do_loopback(): constify struct path argument
Date: Wed,  3 Sep 2025 05:55:08 +0100
Message-ID: <20250903045537.2579614-47-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
References: <20250903045432.GH39973@ZenIV>
 <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 3a9db3e84a92..4ed3d16534bb 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2990,7 +2990,7 @@ static int do_change_type(const struct path *path, int ms_flags)
  *
  * Returns true if the mount tree can be copied, false otherwise.
  */
-static inline bool may_copy_tree(struct path *path)
+static inline bool may_copy_tree(const struct path *path)
 {
 	struct mount *mnt = real_mount(path->mnt);
 	const struct dentry_operations *d_op;
@@ -3012,7 +3012,7 @@ static inline bool may_copy_tree(struct path *path)
 }
 
 
-static struct mount *__do_loopback(struct path *old_path, int recurse)
+static struct mount *__do_loopback(const struct path *old_path, int recurse)
 {
 	struct mount *old = real_mount(old_path->mnt);
 
-- 
2.47.2


