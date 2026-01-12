Return-Path: <linux-fsdevel+bounces-73227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73496D12A92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 14:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7EE33301A1E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 13:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C072357732;
	Mon, 12 Jan 2026 13:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/TCaB7V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53D850097B;
	Mon, 12 Jan 2026 13:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768222883; cv=none; b=ocy0PDL9JUlpyjvjHGAJjhLsOA/mD81+FEM1zB97fkRmXzxG/2+8ypjjioYOo+3ACFktNuago2BUN+i9bshwIohgOAi4am1CRlQldSjomD+TrtY7022qE6QRDLL4hv5BjJjd2T2EwhwR246LbCxdC16R1boQGLW9cfDCHUhjggw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768222883; c=relaxed/simple;
	bh=uiNYMtqcb9O1ip5TEu3Ffn4D37AEp4q0qw0mwhG2I1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W7DPkFpZ40474rvLyzIFWOjznBic4xjscM+3VZavikXQD1LUlUyZE4/0FNqN124IlkTafZ1TnwZkXcjPivylq0fuR5WOuCBdLQz5/jeVJmzk21nqwRQbiey0QA1Xrl/FItwVUp6l1e7xWOm2qWOPbBCTUYDDnDZdiN9Asn3PFFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/TCaB7V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC67C16AAE;
	Mon, 12 Jan 2026 13:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768222883;
	bh=uiNYMtqcb9O1ip5TEu3Ffn4D37AEp4q0qw0mwhG2I1w=;
	h=From:To:Cc:Subject:Date:From;
	b=c/TCaB7VNXvJyWjYR4ANrjnAKbWEe2wxeKBEcQNqgH/qN7Gkjbmm3XcuiB78SqVlm
	 JP/cVTiKBTyMD4eSydJP8vhXhZFLf5uZRJBneIWYpMHMP1mkDmunjj6UbcAeVR/+VJ
	 uCqtu/8yeJPkIsnP6lOxdQOrQriD0REVa1gsAUZH1m2FMWKLm0HFK/v+BuBsATJNPa
	 49XrSC0phYK441lYhaJmMcY24tujl2mbKQqxv8NdXyzKB3iFh4qXTzt9nagdkr41/q
	 NiGqrSaoh5sKysQtjLI6P8WgwUL8Gj5bRFEh4rTRgNxKjb8lhdKzlFjagKCb1KcRQr
	 F3aNBIRmQvArQ==
From: Jeff Layton <jlayton@kernel.org>
To: brauner@kernel.org
Cc: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org,
	jack@suse.com,
	viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fuse: add setlease file operation
Date: Mon, 12 Jan 2026 08:01:21 -0500
Message-ID: <20260112130121.25965-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the setlease file_operation to fuse_file_operations, pointing to
generic_setlease.  A future patch will change the default behavior to
reject lease attempts with -EINVAL when there is no setlease file
operation defined. Add generic_setlease to retain the ability to set
leases on this filesystem.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
As Jan pointed out in review, this patch is also needed in the
vfs-7.0.leases branch, as I missed FUSE. Can you drop this patch on top
of that branch, preferably ahead of the patch that changes
kernel_setlease()? Let me know if you'd rather I resend the whole pile.

 fs/fuse/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 01bc894e9c2b..2956f6cb598d 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3177,6 +3177,7 @@ static const struct file_operations fuse_file_operations = {
 	.poll		= fuse_file_poll,
 	.fallocate	= fuse_file_fallocate,
 	.copy_file_range = fuse_copy_file_range,
+	.setlease	= generic_setlease,
 };
 
 static const struct address_space_operations fuse_file_aops  = {
-- 
2.52.0


