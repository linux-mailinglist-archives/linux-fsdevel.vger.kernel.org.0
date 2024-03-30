Return-Path: <linux-fsdevel+bounces-15733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFEF89285F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 01:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A51F1282A9A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 00:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6571860;
	Sat, 30 Mar 2024 00:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNmQlW1H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CA715A5;
	Sat, 30 Mar 2024 00:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711759246; cv=none; b=K7IuxXKcGYT18YoPHemYyXyAIxOImymJNZwzHHdKjwrRga5nAjBShVrPGWL9JF0hJ+LLpZ78me+ZJMBIA94CFUoKTY9jHXUFwWHPzYPoA3OfG1w0je2Uqg5a+PcnzNDYberLdrAOgvYOQeSbwMzoxvfQqKpAvClt1CXM6zmLD2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711759246; c=relaxed/simple;
	bh=UWh2uI1BZRIP+I8yjMlT4bxcWpCxMGxtnm2AAkkDuqM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bO0v6vNB5RuazT7RbsFhj2x4vIBePrsQ2RXZ/uZivY805VwpXDov3H1hbK/tZcUQ+tely2WrBjOsCkbc5g6M4zFAtsKlThxMp4RMicwppTEaqb5sLJZPyGZPtTi80w+0ZtlB3sFFuKF/As46dnXIWcYaVwCFRA2T5YaWUISvMVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNmQlW1H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B5DC433C7;
	Sat, 30 Mar 2024 00:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711759246;
	bh=UWh2uI1BZRIP+I8yjMlT4bxcWpCxMGxtnm2AAkkDuqM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=FNmQlW1HAuIdA8iTscM3LI3fvo5EJaZya0eGm3qKTmvYXef9FGLjmdwDkWfMLc6de
	 r6tcA91lO5p2SQdH31uM58xh3x6Z9fJ/uqgIXw52m63FnIITtV+/2Sux6RlI6jauQT
	 N+Mwze12to613FTMGPB1PePGl6W+c//Yi6VTx/CZDaUg2LeKikAWKknRNiOkosBiMM
	 97EUEcIbRSzQuh7J89ayC3zmhBVBGkmoW7Ayu5sFVaWJmSNsEbLnrbMs/3rts17Wen
	 2LiKIFPEGSIkE1yomXRr76TytIX5URBsuAeGIOHj8RO19TuLo6X+2BZoAMr7hnuuum
	 peDXm+1FwQwhw==
Date: Fri, 29 Mar 2024 17:40:45 -0700
Subject: [PATCH 18/29] xfs: don't store trailing zeroes of merkle tree blocks
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, ebiggers@kernel.org, aalbersh@redhat.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171175868859.1988170.3655437906964376707.stgit@frogsfrogsfrogs>
In-Reply-To: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
References: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
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

As a minor space optimization, don't store trailing zeroes of merkle
tree blocks to reduce space consumption and copying overhead.  This
really only affects the rightmost blocks at each level of the tree.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/xfs_fsverity.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)


diff --git a/fs/xfs/xfs_fsverity.c b/fs/xfs/xfs_fsverity.c
index d675b0f71bde5..8d87d411a9ccb 100644
--- a/fs/xfs/xfs_fsverity.c
+++ b/fs/xfs/xfs_fsverity.c
@@ -667,11 +667,6 @@ xfs_fsverity_read_merkle(
 	if (error)
 		goto out_new_mk;
 
-	if (!args.valuelen) {
-		error = -ENODATA;
-		goto out_new_mk;
-	}
-
 	mk = xfs_fsverity_cache_store(ip, key, new_mk);
 	if (mk != new_mk) {
 		/*
@@ -722,6 +717,12 @@ xfs_fsverity_write_merkle(
 		.value			= (void *)buf,
 		.valuelen		= size,
 	};
+	const char			*p = buf + size - 1;
+
+	/* Don't store trailing zeroes. */
+	while (p >= (const char *)buf && *p == 0)
+		p--;
+	args.valuelen = p - (const char *)buf + 1;
 
 	xfs_fsverity_init_merkle_args(ip, &name, pos, &args);
 	return xfs_attr_setname(&args, false);


