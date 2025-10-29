Return-Path: <linux-fsdevel+bounces-66125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 563A4C17D41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D6AD3BD15E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E90427E1D5;
	Wed, 29 Oct 2025 01:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0470d6F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B2EEEBB;
	Wed, 29 Oct 2025 01:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700623; cv=none; b=Aove5MesU2GSQNgUKBtlgI5Jgd571T48GndgfYLfup7nacUgKXJAo8Lx/lw383R/cWsGn7WkHiswk18TuJbkNBtQhT51btoQaW1SGvxTEWi8dV/WOB+D0JwIJVuEnRk6vOrpja33jfNx/HH0jX+0mL/+ZRJMkeBI8L0TvXknU5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700623; c=relaxed/simple;
	bh=d6lKMLjHACbWoBsG6DuZ6lADKbgOo62MILssdLZVixw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q4uBOa02arXYX6Rnez0Iyez3ThRtEEQtmLoEunEPvadu82vjJs7HzOnBFwjYZS9OUQ0i8Cjczf8CXyUt3sUvWc1KzagzkHBr+0VzBSOqSTD88U5jD7h79GU+mO+elxwlOLsGQI/HIzPUPqeKRSP4b0n21ISuWlttAIAQhZqwsF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0470d6F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D66C4CEE7;
	Wed, 29 Oct 2025 01:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700622;
	bh=d6lKMLjHACbWoBsG6DuZ6lADKbgOo62MILssdLZVixw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=l0470d6FMI5wZlonghn6DETRZ9OrhGao57DiNwYPDhA525BbEr81MSOhR1xg1hu97
	 IxDTSVywxiPkNo2mCJrgcFqhz04W8i/ynmFYUJ/7e/ZgGzy83JSzTG45IeCod+S1qO
	 MQo0bJBR0IRF89MJj0LvwWAaZ8IgcFN6L1Ko1xSn88YxPadApYLeLuexNF+eav4BB/
	 /hW1ln05++WSJhbgHJ6be5iwR8oE/fPLG9zq2KydcGmrmiSHrfK1XNoObN4hFt88i5
	 orMyrGeNHDCsZzAmxwaNxTjufWuyI805EKt8fF3rj6FOLbGJjqI1Ce6DqXlyCLnA0Y
	 yM1X50WD8sCig==
Date: Tue, 28 Oct 2025 18:17:02 -0700
Subject: [PATCH 3/3] fuse2fs: enable iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169818612.1430840.5945327018338457674.stgit@frogsfrogsfrogs>
In-Reply-To: <176169818545.1430840.7420840378591574460.stgit@frogsfrogsfrogs>
References: <176169818545.1430840.7420840378591574460.stgit@frogsfrogsfrogs>
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
index 5e2ced05dc5071..ef73013aa8fcb1 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -2017,10 +2017,6 @@ static inline int fuse_set_feature_flag(struct fuse_conn_info *conn,
 static void fuse4fs_iomap_enable(struct fuse_conn_info *conn,
 				 struct fuse4fs *ff)
 {
-	/* Don't let anyone touch iomap until the end of the patchset. */
-	ff->iomap_state = IOMAP_DISABLED;
-	return;
-
 	/* iomap only works with block devices */
 	if (ff->iomap_state != IOMAP_DISABLED && fuse4fs_on_bdev(ff) &&
 	    fuse_set_feature_flag(conn, FUSE_CAP_IOMAP))
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 7410059305fe24..b359e91f7b9e9b 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1843,10 +1843,6 @@ static inline int fuse_set_feature_flag(struct fuse_conn_info *conn,
 static void fuse2fs_iomap_enable(struct fuse_conn_info *conn,
 				 struct fuse2fs *ff)
 {
-	/* Don't let anyone touch iomap until the end of the patchset. */
-	ff->iomap_state = IOMAP_DISABLED;
-	return;
-
 	/* iomap only works with block devices */
 	if (ff->iomap_state != IOMAP_DISABLED && fuse2fs_on_bdev(ff) &&
 	    fuse_set_feature_flag(conn, FUSE_CAP_IOMAP))


