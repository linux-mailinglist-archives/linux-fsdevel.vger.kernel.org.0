Return-Path: <linux-fsdevel+bounces-68320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB3BC58E48
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 17:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B68C5639D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B247135A93C;
	Thu, 13 Nov 2025 16:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+Y2ucnx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06545351FBA;
	Thu, 13 Nov 2025 16:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051900; cv=none; b=IqeIn1MxSva7IICSNxhlgYH5EFFjjhfijXlFZtd36w42gFtIsUCHNmhml5KyA2jgNcCgrtlpj4vJNFeeL8jnyR9fHGzIOGGoCyeVaXeAodkmvSObZ54ga4L4No5gI6zX3POacBCgK20VoEGiaG7yvVy6IDn2ITeSFj1SR2AUWBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051900; c=relaxed/simple;
	bh=xJFIdbOnLw3BnG2oDf6mB2DYhMbtQyAgs8MS7kqQ8c0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BM4Tm71cQjSYTwZduDHlHxHuR6gbN8lCmjWvrYXQjATthuko4ZAW3uk2rXrk98I5D1qotY8Osj9t9y8Z42uT8JjAHTQ8maEBpYubf7/G67B+q0DDR/xVNsjOXNX0f6aEHLMfDU5LOa30JCL9u+fCE7BXih9r2UNuJ6dTWvqBCGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+Y2ucnx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CCA7C4CEF5;
	Thu, 13 Nov 2025 16:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051899;
	bh=xJFIdbOnLw3BnG2oDf6mB2DYhMbtQyAgs8MS7kqQ8c0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L+Y2ucnx97m8pGmQ6sAmNsbd8cZko+Yc5Yd/fwNw7+b466DcKfbJnQ2BIzRQ7Vz1P
	 9+NrQoEd1APpXvDFj2kAtrHT75ULrwNZO/Iyjh+d6KgdPRjANzqUyewWFlLIxqvE0u
	 +7pUoNoR5t0Zmtv9tpg86cwlphhD7psrNd/pBLGtgJdqZ6JKqZsYSSN5v8ZdzEVhHD
	 jY2Ob4nWCrmgrIZMdBquRj4NyGwSYwJ3WRbvSXon3fza1CCgJEBhYRi/t7ZvFj9Z1N
	 zIfELiumo+vIGhaH6rCaClNTr35gy5vcgVGhB8xKuh/TYKTB+jVJuPw3GoAs3j4btw
	 k/yw+l0xjzuiA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 17:37:32 +0100
Subject: [PATCH v2 27/42] ovl: port ovl_check_empty_dir() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v2-27-c08940095e90@kernel.org>
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=761; i=brauner@kernel.org;
 h=from:subject:message-id; bh=xJFIdbOnLw3BnG2oDf6mB2DYhMbtQyAgs8MS7kqQ8c0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKcbprJCRct+EsMbFe+NT6axCXdgBH2EymRk6rjeYmZ
 /xr3r/sKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmMjsXEaGaYmVHBfbOPjPF6wI
 SDThnPqo4/frskzBomUX8uUW112+xvA/xS3/3Cz1uSxdJ664S/LoMIi21KSzH8r1fXHop9D1S8Z
 cAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/readdir.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index f3bdc080ca85..01d4a70eb395 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -1063,11 +1063,9 @@ int ovl_check_empty_dir(struct dentry *dentry, struct list_head *list)
 	int err;
 	struct ovl_cache_entry *p, *n;
 	struct rb_root root = RB_ROOT;
-	const struct cred *old_cred;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	with_ovl_creds(dentry->d_sb)
 		err = ovl_dir_read_merged(dentry, list, &root);
-	ovl_revert_creds(old_cred);
 	if (err)
 		return err;
 

-- 
2.47.3


