Return-Path: <linux-fsdevel+bounces-58473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A5EB2E9E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28E2A18871AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5AA1991DD;
	Thu, 21 Aug 2025 01:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQ+0V2FI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADDB3B29E
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 01:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738051; cv=none; b=EHFGzWaXUGcVO620ATK64HjXq1USlsstrYyLIpdphJ4A/sa6WylkcXjLmGc2byJxs71bANS9gsQnpm9Mc+PXbzsFcpMDYAZ036jWdN7K1sUFfGv6SmXd/4OcbCrG/ewIa0vtG9Y1zSWroxAVNeqOsTI+U3PS+ytMUjpjNgh796I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738051; c=relaxed/simple;
	bh=yjQ1k31c4CuGNKDPUClRquF7Yrilu45QAluFIFV1Fzs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qkBVDbN1ApIHprRFHEBiYBA+1thp5RMxslw8hewu/k94Ie9MD7/iPVbwIvamEo+CMlUKehDS3nC8oeiSSq9810azVQ7+R72Bsc+Uj0YbDvnUq2RFFn1LOMDJ75vZ++7mPvDX6zJRBYzK6s/HkestvFqv4iWeOnqrU7fktpcJFc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQ+0V2FI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22EB9C4CEE7;
	Thu, 21 Aug 2025 01:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738051;
	bh=yjQ1k31c4CuGNKDPUClRquF7Yrilu45QAluFIFV1Fzs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=GQ+0V2FIx3cFVJUHrcRwWVsd1LwklLqLxF51Wvt7iwgRDHvVN/b4IVdUjAyPZfp5h
	 mfC1QMIZjfWfrXrEp2H7Jg0Ya8gTBUXeReTw4y4SZ1gzLRaOPvEJlP0/j/aPClL49E
	 wRV2ROX2NfNtN3xAgdYyAcZzCEOyRDgn5slXj4rQU8mmstUJLrqSC5LOD+GDs2ElnV
	 XshO/+3CRgNKP6VMLiO51nBRafhUXxFKMCtH2+Q152O0lIZbzEACUASJKDyZYxx3B/
	 ld43TyX1Zh82Qs/aH9agO1eDkwePAqWrPj3obRZYwEa+j+IQXRm/oaphUjogFQ4D1a
	 nApGOWk3HuWSA==
Date: Wed, 20 Aug 2025 18:00:50 -0700
Subject: [PATCH 5/6] fuse: update ctime when updating acls on an iomap inode
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net,
 linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <175573710289.18622.15987761983808620236.stgit@frogsfrogsfrogs>
In-Reply-To: <175573710148.18622.12330106999267016022.stgit@frogsfrogsfrogs>
References: <175573710148.18622.12330106999267016022.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

In iomap mode, the fuse kernel driver is in charge of updating file
attributes, so we need to update ctime after an ACL change.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/acl.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index 4f37390e3f3ce7..efab333415131c 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -169,10 +169,24 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 			ret = 0;
 	}
 
-	/* If we scheduled a mode update above, push that to userspace now. */
 	if (!ret) {
 		struct iattr attr = { };
 
+		/*
+		 * When we're running in iomap mode, we need to update mode and
+		 * ctime ourselves instead of letting the fuse server figure
+		 * that out.
+		 */
+		if (fuse_has_iomap(inode)) {
+			attr.ia_valid |= ATTR_CTIME;
+			inode_set_ctime_current(inode);
+			attr.ia_ctime = inode_get_ctime(inode);
+		}
+
+		/*
+		 * If we scheduled a mode update above, push that to userspace
+		 * now.
+		 */
 		if (mode != inode->i_mode) {
 			attr.ia_valid |= ATTR_MODE;
 			attr.ia_mode = mode;


