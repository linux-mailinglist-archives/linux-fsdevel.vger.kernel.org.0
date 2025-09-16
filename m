Return-Path: <linux-fsdevel+bounces-61546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 396A6B589C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9186B3B4920
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6191C861E;
	Tue, 16 Sep 2025 00:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRcBewge"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAC62032D;
	Tue, 16 Sep 2025 00:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983088; cv=none; b=FigpIZa9otkPzRoxDZbDziui9pfNSLLsRHeRA5dc3s1qtw3D7zyyrc6Q2kfjJmd78CJX2BMphBammOvk04Cn+f79LC9/zEDw7i71o1cTnaJOO1ISI9L4zZKapSzhGBhCU3cDnyvUSBGy5pMZheEHUFP4iRTZ2vzBKz3X0hd9SQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983088; c=relaxed/simple;
	bh=6nvUs/PcbteWmV+7XW7d8DSA4HuEOspQD9OwoDwvsIQ=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RKr5e0SGcvEmvO6skaDbpdf94E+92PqkLG9Pzyd1BXmnmXf03ZVauJhTVWKSfb47u5BQsV0PC69Y0KxSsp8a5eEXP02RHCoKnQ98HsywJVeCJjwcxFDDBY1CrzHg46UUHLk3fepfsWVv7rda1CIdTrNEmSgsfcm4NX9Bv1H8fHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRcBewge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F54C4CEF1;
	Tue, 16 Sep 2025 00:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983088;
	bh=6nvUs/PcbteWmV+7XW7d8DSA4HuEOspQD9OwoDwvsIQ=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=CRcBewge2OCx/1JQqnIM0ShSxbUNG67FL7YNw+4fgwSoSu2kdJ4PBL55BZ3iMxcUv
	 d+zMMaHzLxAun8PLtHmQTqsp6LXBR+Bw/26onluvyvOlbef59eqtugrhClA7kiZLDr
	 iO6dJZZ5cTww7eijgQ+ki37Tlshq8XoSo2ko8oi2yQfC8uAiQo462wPC10Rp51ep7v
	 CLGN68b8K4wzhRTuS6KN1IkkkhYZSrNA/TShrvqMwe+dygxbAM5hbvxAZoWa3oEpCF
	 qY8gM7ypIHr+SKKl5jjSbKuGNOj5ne7/YyZzEQZ3yKUK6/LNO76/9ZQnkcuX5g50g9
	 gcQdXcuJDMUAw==
Date: Mon, 15 Sep 2025 17:38:08 -0700
Subject: [PATCH 8/9] fuse: update ctime when updating acls on an iomap inode
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798152609.383971.17217827222846117057.stgit@frogsfrogsfrogs>
In-Reply-To: <175798152384.383971.2031565738833129575.stgit@frogsfrogsfrogs>
References: <175798152384.383971.2031565738833129575.stgit@frogsfrogsfrogs>
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
 fs/fuse/acl.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)


diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index 4faee72f1365a5..9b24c53b510405 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -109,6 +109,7 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	const char *name;
 	umode_t mode = inode->i_mode;
+	const bool is_iomap = fuse_inode_has_iomap(inode);
 	int ret;
 
 	if (fuse_is_bad(inode))
@@ -179,10 +180,24 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
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
+		if (is_iomap) {
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


