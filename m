Return-Path: <linux-fsdevel+bounces-61654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A54B58AC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 03:06:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA01C3B866C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 01:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FEF91CEAD6;
	Tue, 16 Sep 2025 01:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTvOOMR3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD2720322;
	Tue, 16 Sep 2025 01:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984810; cv=none; b=N0BpmoG29t3/o5BkgBRg5cdPOXDofkxLC632kNbgl6FpqRQCg/5dwocw6lPIBcwnPW7IfUPTq3UCs9cohA6HbfffzuwKJi238pA3HBkRkXPk310feHPf0hOxAtE7o23dvCUbZ1skrEGEgQhx4HlhBr2aIASTw9eiLNA6dxc2OKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984810; c=relaxed/simple;
	bh=UdBR8N7ku78pa3m37QsEztLJvbWxSyCB7R4mSqX6IuE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G46ysBTbMNImk83Wm9QjOo94/G7RQkMIZtf3FHVt/KrGNY4UMLIIQuj7f3lXQvu1aQ4VNmhs3qxbf6t6awo6JBfEzVCgJyZWsPuRKQLpX1S+Z8EhLwBdZnnKUomKmTah6peCFsCdo8s48yg/ySEcatNbasSyLsTCZnXqIZSUWMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTvOOMR3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344F9C4CEF1;
	Tue, 16 Sep 2025 01:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757984810;
	bh=UdBR8N7ku78pa3m37QsEztLJvbWxSyCB7R4mSqX6IuE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=bTvOOMR3QK5RN+iQDrz7cN+s6z6pCw21tFYvpR8twzlMj7PA+5AmViok0OVYwV3sJ
	 dfyBqhtDgnQo8szjayGEc75v865MfQE2TPWp2XIbtLUFOMwucQNNNOzhuRb8K4L/L7
	 FzOQFdVV8+3PYE7e1kKyx0Ck21AhoMK+Gri16Epu9lbEl/4yK40Dx9fV5mhxYWY9v2
	 ci7G7vue+vtjLH0OaBJSXqtvGyzH77deSRNr7RBYMZQ2cZOfyEAoukEd8Z/KAvuGaE
	 fFOwbAa5PJi2hUG5eHc85b6x/t5r9Te75qSqxaKG021NHVsPq9GEfhSB1Ho226CTYT
	 /K+kj4inrOkgg==
Date: Mon, 15 Sep 2025 18:06:49 -0700
Subject: [PATCH 3/3] fuse2fs: enable iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, John@groves.net, bernd@bsbernd.com,
 joannelkoong@gmail.com
Message-ID: <175798162705.391696.10423276147840972958.stgit@frogsfrogsfrogs>
In-Reply-To: <175798162643.391696.6878173028466397793.stgit@frogsfrogsfrogs>
References: <175798162643.391696.6878173028466397793.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Now that iomap functionality is complete, enable this for users.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |    4 ----
 misc/fuse2fs.c    |    4 ----
 2 files changed, 8 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 5c563eff1c38c1..c4397fc365ced7 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -1652,10 +1652,6 @@ static inline int fuse_set_feature_flag(struct fuse_conn_info *conn,
 static void fuse4fs_iomap_enable(struct fuse_conn_info *conn,
 				 struct fuse4fs *ff)
 {
-	/* Don't let anyone touch iomap until the end of the patchset. */
-	ff->iomap_state = IOMAP_DISABLED;
-	return;
-
 	/* iomap only works with block devices */
 	if (ff->iomap_state != IOMAP_DISABLED && fuse4fs_on_bdev(ff) &&
 	    fuse_set_feature_flag(conn, FUSE_CAP_IOMAP)) {
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 7a10b6cab87f7c..5e4680ca023282 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1478,10 +1478,6 @@ static inline int fuse_set_feature_flag(struct fuse_conn_info *conn,
 static void fuse2fs_iomap_enable(struct fuse_conn_info *conn,
 				 struct fuse2fs *ff)
 {
-	/* Don't let anyone touch iomap until the end of the patchset. */
-	ff->iomap_state = IOMAP_DISABLED;
-	return;
-
 	/* iomap only works with block devices */
 	if (ff->iomap_state != IOMAP_DISABLED && fuse2fs_on_bdev(ff) &&
 	    fuse_set_feature_flag(conn, FUSE_CAP_IOMAP)) {


