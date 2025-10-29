Return-Path: <linux-fsdevel+bounces-66080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 266C5C17BF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BBD393566BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E012DAFBE;
	Wed, 29 Oct 2025 01:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xk/N85KX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FF42D8776;
	Wed, 29 Oct 2025 01:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699918; cv=none; b=VS2X9ESV8Z9lC5HbWzUtq+wRgvBO9bcLihO/Kyipf0EjAKqdtK0sLAk+/TICEaJ6L5FgeUtSip2bGhLRP7quEz2SBmZgp+GUq1ldMxkYlbSBcf7DhztzFkZD3Gtydh946eQt74/TLXOZL2UUge42n4x1qGYukxSVxAndaBnFUjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699918; c=relaxed/simple;
	bh=c9Y4NQbeJAGNlZ1TUgRQpy+3epgjsb72D3vk+v4IgWs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D8RxzkKaIhqow0fc/GOUlsZMoIUNO+T18k1oez6qeUQ4n8s+Id0XHHbj4VMwGM2iwrY+iBAizBbXtni88r8Uac9IvPYcLa/fAKh1izSgGrcro6FXHKSkbyIahZjCPgYSLzaKMZcYgSpsmd2dcBF1ysPeKHN+JJQI2bXNpepvrb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xk/N85KX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6706C4CEE7;
	Wed, 29 Oct 2025 01:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699918;
	bh=c9Y4NQbeJAGNlZ1TUgRQpy+3epgjsb72D3vk+v4IgWs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Xk/N85KXox4XMQ+jIgk1E/HDumNRMKpg3l9D6sg16ocu/h1xd8WY89udGJOctTR7N
	 teDWz9KCIrChZzsJ57Uvk2oKo9WVBe4RmpA5wCZrAv6G5GYjlkFErkc8eTFSoOIyBJ
	 DPMwpP+ZoGS2653rllJ0Ob4VVTSivGV5AbC34cqSmIl0tTHvLVBWdei0hRlqMiWacM
	 jqwtqrJEY0Jphf9gzFljqsno0o8dyTbFTFy7xGaMAnsD8aoBfp+mLtvjTLp3k+BXlW
	 ZK68n0PAP3IaZwBqK9h8PV87LVJXxHI9Bd6Z3N1UgZ32Le99KPXaZeEbs7c7Rsg1au
	 JmNme7aC5DtcQ==
Date: Tue, 28 Oct 2025 18:05:18 -0700
Subject: [PATCH 1/1] libfuse: allow root_nodeid mount option
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <176169814129.1428289.8442781355094968099.stgit@frogsfrogsfrogs>
In-Reply-To: <176169814111.1428289.10086098597397617301.stgit@frogsfrogsfrogs>
References: <176169814111.1428289.10086098597397617301.stgit@frogsfrogsfrogs>
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
index 7a856c101a7fc4..c82fd4c293ce66 100644
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


