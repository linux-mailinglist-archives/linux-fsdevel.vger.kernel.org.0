Return-Path: <linux-fsdevel+bounces-61579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91015B589FB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D2B3A84F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD074207F;
	Tue, 16 Sep 2025 00:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4bIkqR+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0DD5C96
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 00:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983604; cv=none; b=JakUd2UMolnPwvL2mfh+mGddS64Yw6DK45oR/I9jrYlbQaOHKfPHclkYJWIHCtiGGJ7ZhqGb7NLwrzIjS9V9ZrP83ZFOoWpyDUVLcB68tyKVxEmxI+2aXc+zdoNQnckcWKBus1rxmqynVQo19Jwao9jf+LQZfgz5PY5ZcwTKhWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983604; c=relaxed/simple;
	bh=Pd4fRhFlYU7lnzqmwX2KhC2HVd3ecLhT8XeXjR2XtUU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iples+DEADyDRVFdXI+c5gHlDy4xBfnUG7N4DWM8RwMtuSe+nEpFG3e5iWSvUMGLOgDJIqT/Mg0ceIyIB6l/OxGQfQkg+0ddlTjJCavhEJE7CTyItsxHaO75N6EBnlbQs8+ES8HcFd+8lUStFmVgVczNvFHz/4Pb/TK58JHwFcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4bIkqR+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DC2C4CEF1;
	Tue, 16 Sep 2025 00:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983604;
	bh=Pd4fRhFlYU7lnzqmwX2KhC2HVd3ecLhT8XeXjR2XtUU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=I4bIkqR+s8PXgQTc3z45xElwDBYRyd6G/HAdNa7RvXuEwyJ+5nrzmA6wWIsDJhTCk
	 P2FGCedqTdyOJCGlQrKPg8FtoGcYSpx46PcQRzKjam0S/laApx6ziSp+ihtll8Jv96
	 f0CWjv1FHzHyokUdTDg10rpd5S7HrcLbAZyAa/WIwV5rLVYXnJZAZr+oIwBpaTyPgg
	 kYjUFa8hIg+ZzoAsVtHurCldm/aZkt4f4lAs582GRMxEbZG0k91ykeB6IGVyhxA+ja
	 SERToX3d9oZMAAAdxCthmsg+uKw1BPU+pjMrbkE318IWYH2S+9BN3WzWwCqRQV2ldZ
	 jxXjf0qKZ5X1w==
Date: Mon, 15 Sep 2025 17:46:44 -0700
Subject: [PATCH 1/1] libfuse: allow root_nodeid mount option
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: John@groves.net, neal@gompa.dev, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com
Message-ID: <175798155039.387637.5133423111118185974.stgit@frogsfrogsfrogs>
In-Reply-To: <175798155022.387637.12203325269097480388.stgit@frogsfrogsfrogs>
References: <175798155022.387637.12203325269097480388.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Allow this mount option so that fuse servers can configure the root
nodeid if they want to.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/mount.c |    1 +
 1 file changed, 1 insertion(+)


diff --git a/lib/mount.c b/lib/mount.c
index 2eb967399c9606..140489fa74bb55 100644
--- a/lib/mount.c
+++ b/lib/mount.c
@@ -100,6 +100,7 @@ static const struct fuse_opt fuse_mount_opts[] = {
 	FUSE_OPT_KEY("defcontext=",		KEY_KERN_OPT),
 	FUSE_OPT_KEY("rootcontext=",		KEY_KERN_OPT),
 	FUSE_OPT_KEY("max_read=",		KEY_KERN_OPT),
+	FUSE_OPT_KEY("root_nodeid=",		KEY_KERN_OPT),
 	FUSE_OPT_KEY("user=",			KEY_MTAB_OPT),
 	FUSE_OPT_KEY("-n",			KEY_MTAB_OPT),
 	FUSE_OPT_KEY("-r",			KEY_RO),


