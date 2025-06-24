Return-Path: <linux-fsdevel+bounces-52696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F1DAE5F49
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 10:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94A614C14D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 08:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A08C25A2C4;
	Tue, 24 Jun 2025 08:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/eZ1pIZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9647257AC6;
	Tue, 24 Jun 2025 08:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753773; cv=none; b=J0F4zhTC+PxgYdMEtNXd5bAuzDINDE0V0PvLDDAmFI/K6exs6ARnrB76YXm23ZXOP08gEWefQlDCOOD8t2NkY+O6Pc69xpg0FKplr3kuKlYC+gTRiKcv1DzmCG3yZ/FQC6bzZrMTXE91YhmNYtQYqfZsb8SRm6p9B01K5ShwE60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753773; c=relaxed/simple;
	bh=x0hJaWV+M6v/bmrgFW41mF0ngSOkgOMOw2KzsQtObgA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KuFmrdTDyN9zpo7/p3kDNWmNB/DLbcHSgyoJZkrt927d6rsau/hSSn/EBnpcmcNDWzcWNNTqXLiokBr85094fcajhZ491jqjo/4po8Jl9DHWPFIqHPA5P3WiHt6BAADSF9dDOgX09/rJeh9qUUqN6y3YiqB7rYKZj0El8EmrmhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/eZ1pIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63EB0C4CEF2;
	Tue, 24 Jun 2025 08:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750753773;
	bh=x0hJaWV+M6v/bmrgFW41mF0ngSOkgOMOw2KzsQtObgA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y/eZ1pIZSxuIK+elmApGMDjkjjzHMWtWsAn5+6HqjXPLG+fnDl2jJNL8tFSRDifR7
	 OVypZaZAGHw1fvn5e3bFUixouffFaF6KYb0x8gieXfs1SmVaRxYDnp2sPYSd+FHs/x
	 xvFXuYvYFobzQ8DfDCMWjMv8PMsH/NcE7L05JZftkSywhmu9/WLLrCEYjcAwchH3Un
	 gUfqiqKmydiqBkTNCHDZCVsEeqYBJJh/SrxqPb0BAxqeemgWErE/J3ZVie02f/zwZy
	 qIXxCih5GkCKoKrlyJ/J+Oj7Oz9oJDmSdfidqy61mCgmDccoXBotZGYpDYGlKXd7Ty
	 Ay+Si/AznhtgA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Jun 2025 10:29:04 +0200
Subject: [PATCH v2 01/11] fhandle: raise FILEID_IS_DIR in handle_type
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-work-pidfs-fhandle-v2-1-d02a04858fe3@kernel.org>
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
In-Reply-To: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>, stable@kernel.org
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=826; i=brauner@kernel.org;
 h=from:subject:message-id; bh=x0hJaWV+M6v/bmrgFW41mF0ngSOkgOMOw2KzsQtObgA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWREJT6v2fP6oODHtbF6m3oSAteVzexePLNR226H7dd6q
 eZH52uDOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACaikcjIcElCumG36rs5PWuf
 WPbMPbdmZqPkmdStOZ8OL06dKZmUl8PIsFv8n7xTs7AgS3bJBp7K1M09biq98gEZrSVvHFykKjr
 5AQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Currently FILEID_IS_DIR is raised in fh_flags which is wrong.
Raise it in handle->handle_type were it's supposed to be.

Fixes: c374196b2b9f ("fs: name_to_handle_at() support for "explicit connectable" file handles")
Cc: <stable@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fhandle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 3e092ae6d142..66ff60591d17 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -88,7 +88,7 @@ static long do_sys_name_to_handle(const struct path *path,
 		if (fh_flags & EXPORT_FH_CONNECTABLE) {
 			handle->handle_type |= FILEID_IS_CONNECTABLE;
 			if (d_is_dir(path->dentry))
-				fh_flags |= FILEID_IS_DIR;
+				handle->handle_type |= FILEID_IS_DIR;
 		}
 		retval = 0;
 	}

-- 
2.47.2


