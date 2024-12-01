Return-Path: <linux-fsdevel+bounces-36201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F98B9DF5B7
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 14:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A059B216E8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Dec 2024 13:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6987B1CB9F0;
	Sun,  1 Dec 2024 13:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/J/IQ2a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E671CB536;
	Sun,  1 Dec 2024 13:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733058784; cv=none; b=I7TnCJk9aaszGj5Pt8vBOtcXvuGNGdLtS2ObymYIarYvyVTX5CAasMP03nDlvssIgNajGZfqBghF3ni5BAO/ge1j0fo0HAfWo/l/cSBi8/ZOF4Sq4jx7w5yasfAmUGH+DDRSeOjoW7oJvX9Kehy0YDJwNCs+hdsR3RO6rhU3mHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733058784; c=relaxed/simple;
	bh=TJBi4pm189sh4ufpQJIXs7nXM7IBeLfA/J2zP6inFng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H1zz/YQHu/4iYY7F1MOmDuFZ3vEaTYtNFuKBJm/sJPVdiVrfRcVmIhqq/DBP75DwDHPeStCUeUfJFT7hCDRjwegKM1skelgGJhj6RhBEas1wikl/i/P4I266uKtEMQ6+jIi7F9vh2fITH+3eVWARB2Q7ov7TI20MSpognOZKcCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/J/IQ2a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970B1C4CECF;
	Sun,  1 Dec 2024 13:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733058784;
	bh=TJBi4pm189sh4ufpQJIXs7nXM7IBeLfA/J2zP6inFng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q/J/IQ2aZ09LqY4wvm6kblmxEPW7UC830L4v7N/IEFJEPkE/wDdEd/34MOZw0Ytlo
	 1AkgKVPYnnTJeO7aDJ6LAzC/9SHbokYXoq1B4zUd/cvi561i8lST/E1hr3TI29NLa1
	 S/X4lKmTVubfGGWmeMxVrhPbIFowetyZH3Vodew2C1PV+0L6m/AqJSUGmk/TzoV+AH
	 x9/lYLlEf3cswJSxeAQlAGAPFk9DJbB+pUimAgPUyCx2wqSjNy4WusLckkiJz0BiAf
	 thpVPiyLlPBcQ+YQfy6RkTwRL8OK33R7cTvtFyh4hUxSig5JTGvYNGTENlYNen/xU+
	 Z1ecPmgdzZmaw==
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Erin Shepherd <erin.shepherd@e43.eu>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	stable <stable@kernel.org>
Subject: [PATCH 2/4] kernfs: restrict to local file handles
Date: Sun,  1 Dec 2024 14:12:26 +0100
Message-ID: <20241201-work-exportfs-v1-2-b850dda4502a@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241201-work-exportfs-v1-0-b850dda4502a@kernel.org>
References: <20241201-work-exportfs-v1-0-b850dda4502a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=809; i=brauner@kernel.org; h=from:subject:message-id; bh=TJBi4pm189sh4ufpQJIXs7nXM7IBeLfA/J2zP6inFng=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT7JOz7XRBnuOPYe9vOovSCjI1nS/y2T3zsOTtdx7GJ+ WNFZJ1HRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQibzAyHIiMPjx3wewlTqkm s591dutGv2SvO9f96IbVe+40rurNTxkZtpvnv10+jWfeN83f51eEpnmw8XE12M7jzxH7/F5x0iZ RVgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

The kernfs filesystem uses local file handles that cannot be
exported. Mark its export operations accordingly.

Fixes: aa8188253474 ("kernfs: add exportfs operations")
Cc: stable <stable@kernel.org> # >= 4.14
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/kernfs/mount.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 1358c21837f1a0fe1b109e39134e993d0ef83879..c6266ecc78a3ca767e3dcab24fde7c2b79f5370d 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -154,6 +154,7 @@ static const struct export_operations kernfs_export_ops = {
 	.fh_to_dentry	= kernfs_fh_to_dentry,
 	.fh_to_parent	= kernfs_fh_to_parent,
 	.get_parent	= kernfs_get_parent_dentry,
+	.flags		= EXPORT_OP_LOCAL_FILE_HANDLE,
 };
 
 /**

-- 
2.45.2


